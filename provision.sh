#!/bin/bash
NAME='mailgw'
PKGS="docker.io vim curl"
for PKG in $PKGS
do
	dpkg -V $PKG || { 
		apt-get -y update
		apt-get -y install $PKGS
	}
done
systemctl restart docker

for ZONE in $(firewall-cmd --get-active-zones | egrep -v '^\s') 
do
  firewall-cmd --add 25/tcp --zone=$ZONE --permanenet
done
firewall-cmd --reload

#-#IMGS=""
#-#for IMG in $IMGS
#-#do
#-#	IMG_FN=$(echo $IMG | sed -e 's/:/IMG_FN_SEMI_COLON/')
#-#	echo "Verifying / Loading / Pulling image $IMG, this might take a few minutes"
#-#	[[ -e /vagrant/docker-images/${IMG_FN}.tar ]] && { 
#-#		sudo docker images | sed -e 's/\s\s*/:/; s/\s.*//' | egrep -q "^$IMG" || sudo docker load -i /vagrant/docker-images/${IMG_FN}.tar || exit 1
#-#	} || { 
#-#		sudo docker images | sed -e 's/\s\s*/:/; s/\s.*//' | egrep -q "^$IMG" || sudo docker pull ${IMG}
#-#		echo "Archiving docker image $IMG, this might take a few minutes"
#-#		[[ -e /vagrant/docker-images/$(dirname $IMG_FN) ]] || mkdir -p /vagrant/docker-images/$(dirname $IMG_FN)
#-#		TMPF=$(mktemp)
#-#		docker save -o $TMPF $IMG
#-#		mv $TMPF "/vagrant/docker-images/${IMG_FN}.tar"
#-#	}
#-#done
#-#
#-#
#-#for CONTAINER in $NAME
#-#do
#-#	docker ps -a --format='{{.Names}}' | egrep "^$CONTAINER$" && { 
#-#		docker rm -f $CONTAINER
#-#		echo "removing container $CONTAINER"
#-#	}
#-#done


