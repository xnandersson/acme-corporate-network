#!/bin/bash

source local.config

VBOX_NAME="Acme Router"
VBOX_NAME_ALPHANUMERIC="acmerouter"
VBOX_BRIDGEADAPTER="eno1"
VBOX_NIC_MACADDRESS=0800272389CB

VBoxManage createvm --name "${VBOX_NAME}" --ostype ${VBOX_OSTYPE} --register
VBoxManage createmedium --filename "${VBOX_DIR}/${VBOX_NAME}/${VBOX_NAME_ALPHANUMERIC}.vdi" --size 20240
VBoxManage storagectl "${VBOX_NAME}" --name SATA --add SATA --controller IntelAhci
VBoxManage storageattach "${VBOX_NAME}" --storagectl SATA --port 0 --device 0 --type hdd --medium "${VBOX_DIR}/${VBOX_NAME}/${VBOX_NAME_ALPHANUMERIC}.vdi"
VBoxManage storagectl "${VBOX_NAME}" --name IDE --add ide
VBoxManage storageattach "${VBOX_NAME}" --storagectl IDE --port 0 --device 0 --type dvddrive --medium "${VBOX_ISO}"
VBoxManage modifyvm "${VBOX_NAME}" --memory ${VBOX_MEMORY} --vram ${VBOX_VRAM}
VBoxManage modifyvm "${VBOX_NAME}" --ioapic on
VBoxManage modifyvm "${VBOX_NAME}" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "${VBOX_NAME}" --cpus 2
VBoxManage modifyvm "${VBOX_NAME}" --audio none
VBoxManage modifyvm "${VBOX_NAME}" --nic1 bridged --bridgeadapter1 ${VBOX_BRIDGEADAPTER}
VBoxManage modifyvm "${VBOX_NAME}" --nic2 intnet
VBoxManage modifyvm "${VBOX_NAME}" --macaddress1 ${VBOX_NIC_MACADDRESS}
