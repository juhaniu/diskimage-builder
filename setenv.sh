export ELEMENTS_PATH="./diskimage_builder/elements/:./custom_elements"
export DIB_CLOUD_INIT_DATASOURCES=OpenStack
export DIB_LOCAL_IMAGE=/root/diskimage-builder/CentOS-7-x86_64-GenericCloud.qcow2
export DIB_BLOCK_DEVICE_CONFIG='
  - local_loop:
      name: image0
      size: 5GB

  - partitioning:
      base: image0
      label: mbr
      partitions:
        - name: root
          flags: [ boot, primary ]
          size: 100%
  - lvm:
      name: lvm
      pvs:
        - name: pv
          options: ["--force"]
          base: root

      vgs:
        - name: vg
          base: ["pv"]
          options: ["--force"]

      lvs:
        - name: lv_root
          base: vg
          size: 1800M

        - name: lv_tmp
          base: vg
          size: 100M

        - name: lv_var
          base: vg
          size: 1500M

        - name: lv_log
          base: vg
          size: 100M

        - name: lv_audit
          base: vg
          size: 100M

        - name: lv_home
          base: vg
          size: 200M
  - mkfs:
      name: root_fs
      base: lv_root
      label: ci-root
      type: xfs
      mount:
        mount_point: /
        fstab:
          options: "defaults"
          fsck-passno: 1

  - mkfs:
      name: var_fs
      base: lv_var
      label: ci-var
      type: xfs
      mount:
        mount_point: /var
        fstab:
          options: "defaults"
          fsck-passno: 1

  - mkfs:
      name: tmp_fs
      base: lv_tmp
      label: ci-tmp
      type: xfs
      mount:
        mount_point: /tmp
        fstab:
          options: "defaults"
          fsck-passno: 1

  - mkfs:
      name: log_fs
      base: lv_log
      label: ci-log
      type: xfs
      mount:
        mount_point: /var/log
        fstab:
          options: "defaults"
          fsck-passno: 1

  - mkfs:
      name: audit_fs
      base: lv_audit
      label: ci-audit
      type: xfs
      mount:
        mount_point: /var/log/audit
        fstab:
          options: "defaults"
          fsck-passno: 1

  - mkfs:
      name: home_fs
      base: lv_home
      label: ci-home
      type: xfs
      mount:
        mount_point: /home
        fstab:
          options: "defaults"
          fsck-passno: 1

'



#not in use
#export DIB_BOOTLOADER_DEFAULT_CMDLINE="nofb nomodeset vga=normal net.ifnames=0 biosdevname=0"
#export BASE_ELEMENTS="bootloader cloud-init-datasources centos7 centos7-custom"

