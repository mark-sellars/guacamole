#Install Docker Compose
yum -y install python-pip
pip install docker-compose

#Remove all old docker components

yum -y remove docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-selinux \
	docker-engine-selinux \
	docker-engine

#Install supporting packages

yum -y install -y yum-utils \
	device-mapper-persistent-data \
	lvm2

yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo

#Install docker community edition

yum -y install docker-ce

#Start docker
systemctl start docker

systemctl enable docker

#Docker group

groupadd docker
usermod -aG docker $USER

echo Finished!

