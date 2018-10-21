# diskimage-builder


## Getting Started


How to set-up the diskimage-builder and change to default disk layout to LVM.
Tested with CentOS7.


### Prerequisites

```
yum install epel-release 
yum install parted qemu-img kpartx git python python-pip wget policycoreutils-python libguestfs-tools 
git clone https://github.com/openstack/diskimage-builder.git
cd diskimage-builder
pip install --user -r requirements.txt && python setup.py install --user
```

### Installing

Download image:

```
wget https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
```

Add to .bash_profile

```
PATH=$PATH:$HOME/bin:~/.local/bin
source /root/.bash_profile
```


## Usage

Build the image
```
source setenv.sh
disk-image-create -o centos7 --no-tmpfs --image-size 5 vm centos7 centos7-custom dracut-regenerate
```

Change the qcow2 to VMDK
```
qemu-img convert -f qcow2 -O vmdk -o adapter_type=lsilogic,subformat=streamOptimized,compat6 centos7.qcow2 /tmp/centos7.vmdk
```

Import to OpenStack and launch

If you need to review, then you can mount it:
```
guestmount -a /tmp/centos7.vmdk -i --ro /mnt
```

## Built With


## Contributing



## Authors


## License


## Acknowledgments


