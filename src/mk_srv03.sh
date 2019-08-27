#!/bin/bash

source local.config 

VBOX_OSTYPE="Windows2012_64"
VBOX_NAME="$CORP srv-03"
VBOX_NAME_ALPHANUMERIC="acmewin2012"
UUID=$(echo ${VBOX_NAME} | md5sum | cut -d" " -f1)
VBOX_ISO="${HOME}/Downloads/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.iso"
VBOX_NIC_MACADDRESS=0800272389CD
VBOX_MEMORY=1024

VBoxManage createvm --name "${VBOX_NAME}" --ostype ${VBOX_OSTYPE} --register
VBoxManage createmedium --filename "${VBOX_DIR}/${VBOX_NAME}/${UUID}.vdi" --size 20240
VBoxManage storagectl "${VBOX_NAME}" --name SATA --add SATA --controller IntelAhci
VBoxManage storageattach "${VBOX_NAME}" --storagectl SATA --port 0 --device 0 --type hdd --medium "${VBOX_DIR}/${VBOX_NAME}/${UUID}.vdi"
VBoxManage storagectl "${VBOX_NAME}" --name IDE --add ide
VBoxManage storageattach "${VBOX_NAME}" --storagectl IDE --port 0 --device 0 --type dvddrive --medium "${VBOX_ISO}"
VBoxManage modifyvm "${VBOX_NAME}" --memory ${VBOX_MEMORY} --vram ${VBOX_VRAM}
VBoxManage modifyvm "${VBOX_NAME}" --ioapic on
VBoxManage modifyvm "${VBOX_NAME}" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "${VBOX_NAME}" --cpus 2
VBoxManage modifyvm "${VBOX_NAME}" --audio none
VBoxManage modifyvm "${VBOX_NAME}" --nic1 intnet
VBoxManage modifyvm "${VBOX_NAME}" --macaddress1 ${VBOX_NIC_MACADDRESS}
