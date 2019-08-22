Abstract
--------

ACME Corporate Network (ACN) helps you setup a, VirtualBox based, internal network for experimental purposes where you can mix Linux, Windows and other operating systems supported by VirtualBox. A virtual machine acts as a NAT-firewall between the lab network and your host.

Machines
--------

Acme Router
###########

The Acme Router is configured as multi-homed Firewall with one NIC facing the Hypervisor, and one NIC facing the ACME internal network.

Bind9 is configured as DNS in the COM.LOCAL domain. Udhcp is enabled on the ACME Internal Network.

A set of Ansible Playbooks are installed on the Acme Router together with ansible, and then used for provisioning of the rest of the network.

Acme Domain Controller
######################

The Acme Domain Controller is provisioned with Samba and configured as a Domain Controller in the ACME.COM.LOCAL domain.

Acme Workstation
################

The Acme Workstation is provisioned with SSSD and joined to Acme Domain Controller in the ACME.COM.LOCAL domain.

Pre-requisites
--------------

.. code:: bash

  $ sudo apt-get -y install ansible virtualbox
  $ wget http://cdimage.ubuntu.com/ubuntu-server/daily/current/eoan-server-amd64.iso --directory-prefix="${HOME}/Downloads"

Setup
-----

.. code:: bash

  $ src/mk_router.sh
  # Do the install with user/pass: deploy/Secret007!
  # Install the python-package and retrive
  # the ipaddress for facing the hypervisor
  $ echo 192.168.1.169 acme_router >> /etc/hosts
  $ ansible-playbook playbooks/router.yaml
