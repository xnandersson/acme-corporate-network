#!/bin/bash

TEMP_DIR=/home/nandersson/tmp

SRC_ISO=/home/nandersson/Downloads/ubuntu-18.04.3-server-amd64.iso
DEST_ISO=/home/nandersson/Downloads/ubuntu-auto.iso

MOUNT_PATH=${TEMP_DIR}/ubuntu_iso

DEST_DIR=${TEMP_DIR}/acme_files

KICKSTART=ks.cfg
PRESEED=ubuntu-server.seed
POSTINSTALL=postinstall.sh

mkdir ${MOUNT_PATH}
mkdir ${DEST_DIR}

sudo mount -r -o loop ${SRC_ISO} ${MOUNT_PATH}

echo -n "Rsync..."
rsync -a ${MOUNT_PATH}/ ${DEST_DIR}/
sudo umount ${MOUNT_PATH}
sudo rm -rf ${MOUNT_PATH}
echo "DONE"

sudo chown -R nandersson:nandersson ${DEST_DIR}
chmod 755 ${DEST_DIR}

cp {${KICKSTART},${PRESEED},${POSTINSTALL}} ${DEST_DIR}/

chmod 644 ${DEST_DIR}/${KICKSTART}
chmod 644 ${DEST_DIR}/${PRESEED}
chmod 744 ${DEST_DIR}/${POSTINSTALL}

chown nandersson:nandersson ${DEST_DIR}/isolinux
chown nandersson:nandersson ${DEST_DIR}/isolinux/txt.cfg
chown nandersson:nandersson ${DEST_DIR}/isolinux/isolinux.cfg

chmod 755 ${DEST_DIR}/isolinux 
chmod 755 ${DEST_DIR}/isolinux/txt.cfg
chmod 755 ${DEST_DIR}/isolinux/isolinux.cfg

cat << EOF > ${DEST_DIR}/isolinux/txt.cfg
default install
label install
  menu label ^Install Ubuntu Server
  kernel /install/vmlinuz
  append  ks=cdrom:/${KICKSTART} file=/cdrom/preseed/ubuntu-server.seed vga=788 initrd=/install/initrd.gz quiet ---
EOF

chmod 555 ${DEST_DIR}/isolinux
chmod 444 ${DEST_DIR}/isolinux/txt.cfg ${DEST_DIR}/isolinux/isolinux.cfg

sudo mkisofs -D -r -V "ubuntu-auto" -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -input-charset utf-8 -cache-inodes -quiet -o ubuntu-auto.iso ${DEST_DIR}

sudo rm -rf ${DEST_DIR}

mv -f ubuntu-auto.iso ${DEST_ISO}
