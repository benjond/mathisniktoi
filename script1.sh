#!/bin/bash

# Ajout des dépôts
echo "Ajout des dépôts à /etc/apt/sources.list"
echo "deb http://ftp.lip6.fr/debian bookworm main contrib non-free non-free-firmware" >> /etc/apt/sources.list

# Installation de gpm pour gérer la souris
echo "Installation de gpm"
apt update && apt install -y gpm

# Configuration de l'utilisateur msalomon
echo "Configuration de l'utilisateur msalomon"
sudo chfn -f "Michel Salomon" -r "F153" -w "03.84.58.77.84" -h "" -o "" msalomon
sudo usermod -u 1103 msalomon
sudo groupadd -g 400 and
sudo usermod -g 400 msalomon
sudo usermod -aG adm msalomon

# Génération des clés SSH
echo "Génération des clés SSH pour l'utilisateur msalomon"
sudo -u msalomon ssh-keygen -t ed25519 -N "qwerty" -f /home/msalomon/.ssh/id_ed25519
sudo -u msalomon ssh-keygen -t rsa -b 3072 -N "qwerty" -f /home/msalomon/.ssh/id_rsa

# Suppression du groupe msalomon
echo "Suppression du groupe msalomon"
groupdel msalomon

# Création et configuration de l'utilisateur invite
echo "Création et configuration de l'utilisateur invite"
useradd -s /usr/sbin/nologin invite
echo "CqriT" | passwd --stdin invite
usermod -u 2020 invite
groupadd -g 200 external
usermod -g 200 invite

# Suppression du groupe invite
echo "Suppression du groupe invite"
groupdel invite

echo "Configuration terminée."
