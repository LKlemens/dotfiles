#!/usr/bin/python3
"""
This scripts creates an isolated network environment,
and adds necessary configuration to the given QEMU command line to run
in this network.

WARNING: for development purposes only, allows PE for every user on the host.

Typical Usage

$ qemu-with-bridge.py -n 192.168.1.0 -- kvm -drive file=hd.qcow,if=virtio

This would:

    1. Create a new bridge
    2. Set it up, and give its BR0 address of 192.168.1.199
    3. run dnsmasq on 192.168.1.199, set it to give addresses from
       192.168.1.10 to DHCP requests
    4. run sshd on 192.168.1.199:2222, set it up to accept vagrant
       insecure SSH key for root. Useful for sshfs from guest.
    5. adds itself, and hence all children to a cgroup whose name
       is derived from 192.168.1.0/24 subnet.
    6. runs a thread that sets NAT to the default gateway every 5
       seconds. This is done so that internet would still work even
       if laptop default gateway changes, e.g., wifi, or VPN.
       This is a hack, which will be fixed in future.
    7. Takes the given command line, adds command line to set a new
       tap device on bridge for qemu, and run the resulting command line.

This gives an easy way to run many identical VMs in isolated network.

"""
import argparse
import fcntl
import ipaddress
import os
import signal
import subprocess
import sys
import tempfile
import time
import threading

from collections import namedtuple
from distutils import spawn


def ip_set_last(ip, last):
    "sets the last quadret of the IP"
    return (ip - ip.packed[-1] + last).exploded


def default_gateway_iface():
    "returns the name of the default gateway interface, crashes if none"
    return subprocess.check_output(['awk', '$2 == 00000000 { print $1 }',
                                    '/proc/net/route']).split(b'\n')[0]


def main():
    parser = argparse.ArgumentParser(
        description='Run qemu, automatically run DHCP server, ' +
        'automatically create bridge and add a binded interface')
    parser.add_argument('cmd', nargs='*')
    parser.add_argument(
        '--net',
        '-n',
        help='network address of the interface, default mask /24')
    defaultmac = 'DE:AD:BE:EF:43:1F'
    parser.add_argument('--tap-from-cmd',
                        '-T',
                        dest='cmd_tap',
                        action='store_true',
                        help='Create tap devices for each -netev tap,ifname= commandline')
    parser.add_argument('--virtio',
                        '-V',
                        dest='virtio',
                        action='store_true',
                        help='use a virtio driver, useful if you have Linux')
    parser.add_argument('--nspawn',
                        '-N',
                        dest='nspawn',
                        action='store_true',
                        help='use systemd-nspawn')
    parser.add_argument('--add',
                        '-a',
                        dest='add',
                        nargs='?',
                        const=True,
                        help='Do not create a new bridge, add guest to existing bridge')
    parser.add_argument('--mac',
                        '-m',
                        dest='mac',
                        default='default',
                        help='use a custom MAC on network device')
    parser.add_argument('-device',
                        '-d',
                        dest='device',
                        help='pass a custom -device to QEMU for network device')
    parser.add_argument('--kill-cgroup',
                        '-k',
                        dest='kill_cgroup',
                        action='store_true',
                        help='kills all process in cgroup from previous run')
    parser.add_argument('--no-cgroup',
                        '-C',
                        dest='cgroup',
                        action='store_false',
                        help='store all processes in cgroup, ' +
                        'refuse to run if cgroup processes already exist')
    parser.set_defaults(cgroup=True)
    parser.set_defaults(virtio=False)
    parser.add_argument(
        '--no-kill-children-at-exit',
        dest='kill_children',
        action='store_false',
        help='By default will spawn a process to kill all cgroup' +
        'children when the main Qemu process exited')
    parser.set_defaults(kill_children=True)
    parser.add_argument('--ssh-key',
                        '-S',
                        dest='ssh_key',
                        action='store_true',
                        help='just print SSH key')
    args = parser.parse_args()
    custom_br = args.add and not args.add is True
    if custom_br:
        args.cgroup = False
    if args.ssh_key:
        sys.stdout.buffer.write(VAGRANT_PRIV)
        return
    if not custom_br:
        ip = ipaddress.ip_address(args.net)
        gateway = ip_set_last(ip, 199)
        cgroup_name = 'qemu_' + ip_set_last(ip, 0)
    else:
        ip = ipaddress.ip_address('10.19.17.1')
        gateway = ip_set_last(ip, 199)
        cgroup_name = 'qemu_custom_br_' + ip_set_last(ip, 0)
    cgroups = Cgroup()

    mac_counter_name = '/var/run/qemu_with_bridge_'+ip_set_last(ip, 0)

    def kill_all():
        "kill all cgroup processes"
        if not args.cgroup:
            return
        time.sleep(0.3)  # give child time to print output
        for pid in (p for p in cgroups.cgroup_procs(cgroup_name)
                    if p != os.getpid()):
            os.kill(pid, signal.SIGINT)
        time.sleep(1)
        for pid in (p for p in cgroups.cgroup_procs(cgroup_name)
                    if p != os.getpid()):
            os.kill(pid, signal.SIGKILL)

    if args.kill_cgroup:
        kill_all()
        sys.exit(0)
    if args.cgroup:
        if cgroups.is_cgroup_empty(cgroup_name) and args.add:
            sys.stderr.write('Trying to add a VM to a nonexisting bridge (cgroup %s)\n'%cgroup_name +
                    'please run ./qemu-with-bridge -n %s -- kvm ... without --add once\n'%ip_set_last(ip, 0))
            sys.exit(3)
        if not cgroups.is_cgroup_empty(cgroup_name) and not args.add:
            sys.stderr.write('Processes for net %s are running:\n' %
                             cgroup_name)
            for pid in cgroups.cgroup_procs(cgroup_name):
                commandline = 'cannot find pid %d' % pid
                try:
                    with open('/proc/%d/cmdline' % pid, 'r') as fileobj:
                        commandline = fileobj.read().replace('\0', ' ')
                except Exception as e:
                    pass  #whatever happens - nevermind, just debug info
                sys.stderr.write('%d: %s\n' % (pid, commandline))
            sys.exit(2)
        # make sure we get the first MAC
        if not args.add and os.path.exists(mac_counter_name):
            os.remove(mac_counter_name)
        cgroups.join_cgroup(cgroup_name)
    else:
        if not args.add and os.path.exists(mac_counter_name):
            os.remove(mac_counter_name)
    if args.mac == 'default':
        args.mac = defaultmac[:-2] + '%02X'%(0x1f+flock_counter_inc(mac_counter_name))
    devname = 'b' + ip_set_last(ip, 0)
    if custom_br:
        devname = args.add
    # can fail, since it might not exist
    if not args.add:
        subprocess.call(['ip', 'link', 'del', 'dev', devname])
        subprocess.check_call(
            ['ip', 'link', 'add', 'dev', devname, 'type', 'bridge'])
        subprocess.check_call(['sudo', 'ip', 'link', 'set', 'dev', devname, 'up'])
        subprocess.check_call(
            ['ip', 'addr', 'add', gateway + '/24', 'dev', devname])

    def masquerade():
        # if the laptop is disconnected from the internet, and no
        # default gateway exist, no masquerade is needed
        if default_gateway_iface():
            Iptables.masquarade_all_to(default_gateway_iface(),
                    bytes(devname, 'ascii'))

    tapdevs_to_del = []
    try:
        if not args.add:
            tapdevs_to_del.append(devname)
            masquerade()
            repeat_every(5, masquerade)
            first_guest = ip_set_last(ip, 10)
            last_guest = ip_set_last(ip, 198)
            run_dnsmasq(devname, gateway, first_guest, last_guest)
            run_sshd(gateway)
        if not args.cmd_tap and not args.nspawn:
            macaddr = 'mac='+args.mac
            netdevname = 'QWBnetdev'
            netdevid = 'netdev='+netdevname
            if args.device:
                if 'mac=' not in args.device:
                    device = [args.device, netdevid, macaddr]
                args.cmd.extend(['-device', ','.join(args.device)])
            else:
                devtype = 'e1000'
                if args.virtio:
                    devtype = 'virtio-net-pci'
                device = [devtype, netdevid, macaddr]
            args.cmd.extend(['-netdev', 'type=tap,script=no,ifname=QWBtap,id='+netdevname])
            if not args.device:
                args.cmd.extend(['-device', devtype+',netdev='+netdevname+','+macaddr])
        current_tap = []
        for line in subprocess.check_output(['ip', 'tuntap', 'show']).split(b'\n'):
            line = line.decode('utf-8')
            if ': tap' not in line:
                continue
            current_tap.append(line[:line.index(': tap')])
        if args.nspawn:
            ifname = 've_%d'%os.getpid()
            peer = 'host0' # problem with concurrent executions
            subprocess.check_call(['ip', 'link', 'add', ifname, 'type', 'veth',
                                   'peer', 'name', peer])
            subprocess.check_call(['ip', 'link', 'set', 'dev',
                                   ifname, 'master', devname])
            subprocess.check_call(['ip', 'link', 'set', 'dev',
                                   ifname, 'up'])
            args.cmd.extend(['--network-interface='+peer])
        else:
            cmdline = args.cmd[:]
            while cmdline and '-netdev' in cmdline[:-1]:
                cmdline = cmdline[cmdline.index('-netdev')+1:]
                parts = cmdline[0].split(',')
                if parts[0] != 'tap' and 'type=tap' not in parts:
                    continue
                for part in parts:
                    if not part.startswith('ifname='):
                        continue
                    ifname = part[len('ifname='):]
                    # remove tap device, only if it is currently a tap device
                    # so that tap device named eth0 wouldn't kill the system...
                    if ifname in current_tap:
                        subprocess.check_call(['ip', 'link', 'del', 'dev', ifname])
                    subprocess.check_call(['ip', 'tuntap', 'add', 'dev',
                        ifname, 'mode', 'tap'])
                    subprocess.check_call(['ip', 'link', 'set', 'dev',
                        ifname, 'up'])
                    subprocess.check_call(['ip', 'link', 'set', 'dev',
                        ifname, 'master', devname])
                    tapdevs_to_del.append(ifname)
        subprocess.call(args.cmd)
    finally:
        if not args.add:
            s = signal.signal(signal.SIGINT, signal.SIG_IGN)
            kill_all()
            # remove tap devices when done
            for devname in tapdevs_to_del:
                subprocess.call(['ip', 'link', 'del', 'dev', devname])
            signal.signal(signal.SIGINT, s)


class Iptables(object):
    "access to iptables information via iptables command"
    entry = namedtuple(
        'iptable_entry',
        ['pkts', 'bytes', 'target', 'prot', 'opt', 'in_', 'out', 'src', 'dst'])

    @classmethod
    def _get_chain(cls, chain, table='filter'):
        "returns the POSTROUTING table lines"
        txt = subprocess.check_output(
            ['iptables', '-v', '-t', table, '-L', chain])
        return [cls.entry(*x.split()[:9])
                for x in txt.strip().split(b'\n')[2:]]

    @classmethod
    def get_postrouting(cls):
        return cls._get_chain('POSTROUTING', 'nat')

    @classmethod
    def get_forward(cls):
        return cls._get_chain('FORWARD')

    @classmethod
    def is_entry_forward_from_bridge(cls, ent, bridge):
        return all([ent.prot == b'all', ent.target == b'ACCEPT',
                    ent.in_ == bytes(bridge), ent.src == b'anywhere',
                    ent.dst == b'anywhere', ent.out == b'any'])

    @classmethod
    def has_forward_from_bridge(cls, bridge):
        for ent in cls.get_forward():
            if cls.is_entry_forward_from_bridge(ent, bridge):
                return True
        return False

    @classmethod
    def is_entry_forward_to_bridge(cls, ent, bridge):
        return all([ent.prot == b'all', ent.target == b'ACCEPT',
                    ent.in_ == b'any', ent.src == b'anywhere',
                    ent.dst == b'anywhere', ent.out == bridge])

    @classmethod
    def has_forward_to_bridge(cls, bridge):
        for ent in cls.get_forward():
            if cls.is_entry_forward_to_bridge(ent, bridge):
                return True
        return False

    @classmethod
    def is_entry_masquerade_to(cls, ent, iface):
        "returns true if iptables' entry masquarade all traffic to given iface"
        return all([ent.prot == b'all', ent.target == b'MASQUERADE',
                    ent.in_ == b'any', ent.src == b'anywhere',
                    ent.dst == b'anywhere', ent.out == iface])

    @classmethod
    def has_masquerade_to(cls, iface):
        "do we have masquerade rule for interface iface?"
        for ent in cls.get_postrouting():
            if cls.is_entry_masquerade_to(ent, iface):
                return True
        return False

    @classmethod
    def masquarade_all_to(cls, iface, bridge):
        "add masquerade rule to interface iface if needed"
        if not cls.has_forward_from_bridge(bridge):
            print('adding accept forward rule from bridge', bridge)
            subprocess.check_call(['iptables', '-I', 'FORWARD', '1',
                                   '-i', bridge, '-j', 'ACCEPT'])
        if not cls.has_forward_to_bridge(bridge):
            print('adding accept forward rule from bridge', bridge)
            subprocess.check_call(['iptables', '-I', 'FORWARD', '1',
                                   '-o', bridge, '-j', 'ACCEPT'])
        if not cls.has_masquerade_to(iface):
            print('adding masquarade rule for interface', iface)
            subprocess.check_call(['iptables', '-t', 'nat', '-A',
                                   'POSTROUTING', '-o', iface, '-j',
                                   'MASQUERADE'])


def repeat_every(seconds, func, *args, **kwargs):
    "call func every seconds seconds"

    def and_again():
        func(*args, **kwargs)
        t = threading.Timer(seconds, and_again)
        t.daemon = True
        t.start()

    t = threading.Timer(seconds, and_again)
    t.daemon = True
    t.start()


def run_dnsmasq(devname, gateway, first_guest, last_guest):
    "runs dnsmasq"
    if os.fork() != 0:
        return
    leasefile = tempfile.NamedTemporaryFile()
    os.execlp('dnsmasq', 'dnsmasq', '-d', '-z', '-I', 'lo', '-i', devname,
              '-a', gateway, '-A', '/gateway/' + gateway,
              '--dhcp-sequential-ip', '-l', leasefile.name, '-F',
              first_guest + ',' + last_guest)
    sys.stderr.write('ERROR RUNNING dnsmasq\n')


def run_sshd(gateway):
    "runs sshd on interface"
    if os.fork() != 0:
        return
    vagrant_priv = tempfile.NamedTemporaryFile()
    vagrant_priv.write(VAGRANT_PRIV)
    vagrant_priv.flush()
    vagrant_pub = tempfile.NamedTemporaryFile(dir='/var/run')
    os.chmod(vagrant_pub.name, 0o644)
    vagrant_pub.write(VAGRANT_PUB)
    vagrant_pub.flush()
    os.chmod(vagrant_pub.name, 0o644)
    sshd_path = spawn.find_executable('sshd')
    os.execlp(sshd_path, sshd_path, '-D', '-h', vagrant_priv.name, '-f',
              '/dev/null', '-o', 'Port=2222', '-o', 'ListenAddress=' + gateway,
              '-e', '-o', 'AuthorizedKeysFile=' + vagrant_pub.name, '-o',
              'Subsystem=sftp internal-sftp', '-o', 'PermitEmptyPasswords=yes',
              '-o', 'UsePAM=yes')
    sys.stderr.write('ERROR RUNNING sshd\n')
    sys.exit(1)


class Cgroup(object):
    """Cgroup allows creation and manipulation
    of cgroup v1 through filesystem"""

    def mk_cgroup(self, name):
        "create a new cgroup"
        new_cgroup = os.path.join(self.cgrouproot, name)
        if not os.path.exists(new_cgroup):
            os.mkdir(new_cgroup)
        return new_cgroup

    def cgroup_procs(self, name):
        'list of pids in cgroup'
        cgroup_procs = os.path.join(self.mk_cgroup(name), 'cgroup.procs')
        with open(cgroup_procs, 'r') as fileobj:
            return [int(x) for x in fileobj.readlines()]

    def is_cgroup_empty(self, name):
        "is_cgroup_empty returns true if no processes belong there"
        cgroup_procs = os.path.join(self.mk_cgroup(name), 'cgroup.procs')
        with open(cgroup_procs, 'r') as fileobj:
            return fileobj.read().strip() == ''

    def join_cgroup(self, name):
        "create and join a cgroup"
        cgroup_procs = os.path.join(self.mk_cgroup(name), 'cgroup.procs')
        with open(cgroup_procs, 'w') as fileobj:
            fileobj.write('%s\n' % os.getpid())

    def __init__(self):
        self.cgrouproot = self.find_create_cgroup()

    @classmethod
    def find_create_cgroup(cls):
        "tries to fetch systemd cgroup, creates new dir if can't find"
        cgroup_dir = '/sys/fs/cgroup/systemd'
        if not cls.is_cgroup_mount_entry(cgroup_dir):
            cgroup_dir = tempfile.NamedTemporaryFile(dir='/var/run').name
            subprocess.check_call(['mount', '-t', 'cgroup', '-o',
                                   'none,name=systemd,xattr', 'systemd',
                                   cgroup_dir])
        return cgroup_dir

    @classmethod
    def is_cgroup_mount_entry(cls, path):
        "returns true if path is mounted as cgroup"
        if not os.path.exists(path):
            return False
        path = os.path.realpath(path)
        mount_entries = cls.mount_entries()
        return mount_entries[path].type_ == 'cgroup'

    @classmethod
    def mount_entries(cls):
        "return list of mount entries"
        with open('/proc/mounts') as fileobj:
            return {cls.mount_entry(line).dir_: cls.mount_entry(line)
                    for line in fileobj.readlines()}

    @classmethod
    def mount_entry(cls, line):
        "parse /proc/mounts entry to MountEntry object"
        fsname, dir_, type_, opts, freq, passno = line.split()
        return cls.MountEntry(fsname=fsname,
                              dir_=dir_,
                              type_=type_,
                              opts=opts,
                              freq=freq,
                              passno=passno)

    MountEntry = namedtuple(
        'MountEntry', ['fsname', 'dir_', 'type_', 'opts', 'freq', 'passno'])


VAGRANT_PRIV = b'''
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
w+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoP
kcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2
hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NO
Td0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW
yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd
ELs4jJsdyky+ewdZeNds5tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1
Bw7XpgUwFgeUJwUlzQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf
TK2Lg6EdbUE9TarUlBf/xPfuEhMSlIE5keb/Zz3/LUlRg8yDqz5w+QWVJ4utnKnK
iqwZN0mwpwU7YSyJhlT4YV1F3n4YjLswM5wJs2oqm0jssQu/BT0tyEXNDYBLEF4A
sClaWuSJ2kjq7KhrrYXzagqhnSei9ODYFShJu8UWVec3Ihb5ZXlzO6vdNQ1J9Xsf
4m+2ywKBgQD6qFxx/Rv9CNN96l/4rb14HKirC2o/orApiHmHDsURs5rUKDx0f9iP
cXN7S1uePXuJRK/5hsubaOCx3Owd2u9gD6Oq0CsMkE4CUSiJcYrMANtx54cGH7Rk
EjFZxK8xAv1ldELEyxrFqkbE4BKd8QOt414qjvTGyAK+OLD3M2QdCQKBgQDtx8pN
CAxR7yhHbIWT1AH66+XWN8bXq7l3RO/ukeaci98JfkbkxURZhtxV/HHuvUhnPLdX
3TwygPBYZFNo4pzVEhzWoTtnEtrFueKxyc3+LjZpuo+mBlQ6ORtfgkr9gBVphXZG
YEzkCD3lVdl8L4cw9BVpKrJCs1c5taGjDgdInQKBgHm/fVvv96bJxc9x1tffXAcj
3OVdUN0UgXNCSaf/3A/phbeBQe9xS+3mpc4r6qvx+iy69mNBeNZ0xOitIjpjBo2+
dBEjSBwLk5q5tJqHmy/jKMJL4n9ROlx93XS+njxgibTvU6Fp9w+NOFD/HvxB3Tcz
6+jJF85D5BNAG3DBMKBjAoGBAOAxZvgsKN+JuENXsST7F89Tck2iTcQIT8g5rwWC
P9Vt74yboe2kDT531w8+egz7nAmRBKNM751U/95P9t88EDacDI/Z2OwnuFQHCPDF
llYOUI+SpLJ6/vURRbHSnnn8a/XG+nzedGH5JGqEJNQsz+xT2axM0/W/CRknmGaJ
kda/AoGANWrLCz708y7VYgAtW2Uf1DPOIYMdvo6fxIB5i9ZfISgcJ/bbCUkFrhoH
+vq/5CIWxCPp0f85R4qxxQ5ihxJ0YDQT9Jpx4TMss4PSavPaBH3RXow5Ohe+bYoQ
NE5OgEXk2wVfZczCZpigBKbKZHNYcelXtTt/nP3rsCuGcM4h53s=
-----END RSA PRIVATE KEY-----
'''
VAGRANT_PUB = b'''
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
'''

def flock_counter_inc(path):
    with FlockCounter(path) as counter:
        return counter.counter()

class FlockCounter(object):
    "open and exclusively flock a file"
    def __init__(self, path):
        self.fd = open(path, 'a+')

    def __enter__(self):
        fcntl.flock(self.fd, fcntl.LOCK_EX)
        self._inc()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        fcntl.flock(self.fd, fcntl.LOCK_UN)
        self.fd.close()

    def _inc(self):
        self.fd.seek(0, 0)
        n = self.fd.read()
        if not n:
            n = 0
        else:
            n = int(n)
        self.n = n+1
        self.fd.seek(0, 0)
        self.fd.truncate(0)
        self.fd.write(str(self.n))
        self.fd.flush()

    def counter(self):
        return self.n


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Exit Due to keyboard interrupt')
        sys.exit(1)
