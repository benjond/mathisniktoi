#!/bin/bash

# Variables
MOUNT_POINT="/media/cdrom" # Point de montage du CD-ROM
USER="msalomon"            # Utilisateur à ajouter au groupe vboxsf

echo "Création du point de montage pour le CD-ROM..."
sudo mkdir -p $MOUNT_POINT

echo "Montage du CD-ROM..."
sudo mount -t iso9660 /dev/cdrom $MOUNT_POINT

echo "Mise à jour des paquets et installation des dépendances nécessaires..."
sudo apt update
sudo apt install -y build-essential linux-headers-$(uname -r)

echo "Installation des additions invité VirtualBox..."
cd $MOUNT_POINT
sudo ./VBoxLinuxAdditions.run

echo "Ajout de l'utilisateur $USER au groupe vboxsf..."
sudo gpasswd -a $USER vboxsf

echo "Redémarrage de la machine virtuelle requis pour finaliser l'installation."
echo "Reboot automatique dans 5 secondes..."
sleep 5
sudo reboot

# Instructions supplémentaires après redémarrage
echo "Après redémarrage, vérifiez l'accès au répertoire partagé en testant les permissions."
