Abstract
--------

ACME Corporate Network (ACN) helps you setup a, VirtualBox based, internal network for experimental purposes where you can mix Linux, Windows and other operating systems supported by VirtualBox. A virtual machine acts as a NAT-firewall between the lab network and your host.

The Virtual Firewall is preloaded with:

- bind9
- udhcpd
- iptables
- ansible

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
