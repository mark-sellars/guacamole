=======================================
Recipe for Guacamole on centos with duo
=======================================

Add go daddy certs
==================

- Add certs before starting install
- Add certs to /etc/pki/tls/certs/nginx

Go daddy generates the .key file with UTF-8 instead of ansi, run the fallowing to fix:

- $ sudo iconv -c -f UTF8 -t ASCII  from-godady.key >> webserver.key

For the .crt combind the two crt files from go daddy:

- $ sudo cat random_name.crt gd_bundle-g2-g1.crt >> webserver.crt

- Cert names: guac.crt guac.key

- If the cert names are different update nginx config

Start install
=============
- I put my files in /etc/guacamole but put them where you like.

- If you would like some nice admin tools for you server run

.. code:: bash

   $ sudo sh cent_inst,sh

- This installs and sets up cockpit, webmin, htop, iftop, tmux, nnn, and epel.
  Modify to your likeing.

Getting Started
===============
- Simply copy this entire directory "gucamole" in to /etc and finish the setup
  there. You can keep a copy of "gucamole" in your home directory for referance.

- So the structure should look like this

etc
|-- guacamole
    |-- docker-compose.yml
    |-- guacamole_home
    |   |-- extensions
    |   |   `-- guacamole-auth-duo-1.0.0.jar
    |   `-- guacamole.properties
    |-- nginx
    |   |-- mysite.template
    |   `-- nginx.conf

How to make Guacamole
=====================
If you wish to automate the docker setup and install run "docker_inst.sh"
and skip all of the steps between the ======= signs

.. code:: bash

   $ sudo sh docker_inst.sh

===============================================================================
===============================================================================

Python requirements
===================
- At least python 2.7.5 is installed (python --version)
- pip is installed and upgraded (pip install --upgrade pip)
- Docker Compose is installed (pip install docker-compose)

Remove all old docker components
================================
.. code:: bash

   $ sudo yum remove docker \
		docker-client \
		docker-client-latest \
		docker-common \
		docker-latest \
		docker-latest-logrotate \
		docker-logrotate \
		docker-selinux \
		docker-engine-selinux \
		docker-engine

Install packages
================
.. code:: bash

   $ sudo yum install -y yum-utils \
		device-mapper-persistent-data \
		lvm2

   $ sudo yum-config-manager \
		--add-repo \
		https://download.docker.com/linux/centos/docker-ce.repo

Install docker community edition
================================
.. code:: bash

   $ sudo yum install docker-ce
   $ sudo systemctl start docker
   $ sudo systemctl enable docker

Create Docker Group and add your user to it
===========================================
.. code:: bash

   $ sudo groupadd docker
   $ sudo usermod -aG docker $USER

===============================================================================
===============================================================================

Restart Computer
================
.. code:: bash

   $ sudo reboot

Run the prepare script
======================
.. code:: bash

   $ sudo sh prepare.sh

- This will say "done" once it's done

DUO
===
If you are going to use DUO login to your DUO account and add a Web SDK in the
applications section. When you have that setup plug in the info to

/guacamole/guacamole_home/guacamole.properties

You will need to generate you own application key. It must be 40 char long and
unique. You can google instructions to use DD for this or use something like
onepassword,s password generator. I have not tested using anything other then
letters, capital letters, and numbers.

Prep the docker-compose file
============================

All that you need to edit is at the bottom. In the vary long line "command:"
you will want to change "some name" and "yourdomain.com" to the appropriate
information. If your are not in San Diego CA also change that as well. This is
for your SSL cert.

Run docker-compose up
=====================
.. code:: bash

   $ sudo docker-compose up

- This runs docker in verbose mode. Once you have it running go to

 <https://guac.domain.com> or <https://ipaddress>

Go back to the  terminal running docker and click ctrl + c
This shuts down the server.

Now launch the server again in detached mode so you can run it in the
background without needing to keep the terminal open.

.. code:: bash

   $ sudo docker-compose up -d

- If you want to launch it from any directory that you are in run

.. code:: bash

   $ sudo docker-compose -f /etc/guacamole/docker-compose.yml up -d

The server is good to go, the default login and password is
	- guacadmin/guacadmin

Remove junk
===========

Now that our setup is compleat and working, I would ensure these files are
removed from the working gucamole directory

- cent_isnt.sh
- docker_inst.sh
- pre_setup.sh
- readme.txt

The end
