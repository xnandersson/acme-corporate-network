Abstract
--------

ACME Corporate Network (ACN) helps you setup a, VirtualBox based, internal network for experimental purposes. A dedicated virtual machine acts as a router or firewall between the lab network and your host.

In a purely Linux world, docker would be a much better fit, but in the cases where your experiments involves Windows I chose VirtualBox.

Aim is to automate as much as possible. Unattended installations, ansible provisioning and/or internal docker containers.

Pre-requisites
--------------

.. code:: bash

  $ sudo apt-get -y install ansible virtualbox

Setup
-----

.. code:: bash

  $ src/mk_router.sh
  # Do the install with user/pass: deploy/Secret007! and hostname: ubuntu

On Acme Router
-------------

.. code:: bash

  # Check ip on VBOX_BRIDGEADAPTER # 192.168.1.169
  $ sudo echo 192.168.1.169 acn_router >> /etc/hosts
  # Install python
  $ sudo apt-get install -y python

On Hypervisor
-------------

.. code:: bash

  # Verify Access
  $ ssh acn@acn_router -i ~/.ssh/id_rsa
  # Verify that Ansible works
  $ ansible -m ping acn_router
  $ ansible acn_router -a 'id'
  $ ansible-playbook playbooks/bind9.yaml

Setup ACN Router
----------------
- iptables
- dhcp
- named
  
Links
-----
- http://gyk.lt/ubuntu-16-04-desktop-unattended-installation/
