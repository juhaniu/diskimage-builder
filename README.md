# diskimage-builder

Prep:
yum install epel-release
yum install parted qemu-img kpartx git python python-pip wget policycoreutils-python libguestfs-tools

git clone https://github.com/openstack/diskimage-builder.git
cd diskimage-builder
pip install --user -r requirements.txt && python setup.py install --user

wget https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2

Add to: /root/.bash_profile
PATH=$PATH:$HOME/bin:~/.local/bin
source /root/.bash_profile

Usage:

1.Source setenv.sh
2.disk-image-create -o centos7 --no-tmpfs --image-size 5 vm centos7 centos7-custom dracut-regenerate
3.qemu-img convert -f qcow2 -O vmdk -o adapter_type=lsilogic,subformat=streamOptimized,compat6 centos7.qcow2 /tmp/centos7.vmdk
4.Import to OpenStack and launch

