Abstract
--------

ACME Corporate Network (ACN) helps you setup a, VirtualBox based, internal network for experimental purposes where you can mix Linux, Windows and other operating systems supported by VirtualBox. A virtual machine acts as a NAT-firewall between the lab network and your host.

Users
-----

Note that users are disabled after issuing commands with adcli. Account needs to be "enabled" in AD Users & Computers, a password needs to be set (could perhaps be issued by doing "echo Alpha01234! | adcli ...")

.. code:: bash

  $ apt-get install krb5-user adcli
  $ echo Secret007! | kinit Administrator
  $ adcli create-user alice --domain=acme.com.local --display-name="Alice Alison" --mail=alice@acme.com.local --login-ccache=/tmp/krb5cc_0
  $ adcli create-user bob --domain=acme.com.local --display-name="Bob Bobson" --mail=bob@acme.com.local --login-ccache=/tmp/krb5cc_0
  # alice/Alpha123
  # bob/Bravo123
  
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
  # Create the keys and add the Router Private Key to your keys
  $ src/mk_keys.sh
  $ cp ansible/roles/ssh/files/deploy_rsa ~/.ssh
  # Do the install with user/pass: deploy/Secret007!
  # Install the python-package and retrive
  # the ipaddress for facing the hypervisor
  $ echo 192.168.1.169 acme_router >> /etc/hosts
  $ ansible-playbook playbooks/router.yaml

~/.ssh/config
-------------

.. code:: bash

  Host acme_router
    HostName acme_router
    user deploy
    IdentityFile ~/.ssh/deploy_rsa

Links
-----
- https://www.youtube.com/watch?v=EgqQMDw4T4Q How to do this with Vagrant Packer instead.
