#!/bin/bash

USER="msalomon" # Nom de l'utilisateur cible
GROUP="and"     # Groupe associé à l'utilisateur

echo "Installation des navigateurs et outils divers"

# Firefox
echo "Installation de Firefox..."
sudo wget https://packages.mozilla.org/apt/repo-signing-key.gpg -O /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list
sudo apt update && sudo apt install -y firefox

# Tor
echo "Installation de Tor..."
wget https://www.torproject.org/dist/torbrowser/14.0.3/tor-browser-linux-x86_64-14.0.3.tar.xz
tar -xf tor-browser-linux-x86_64-14.0.3.tar.xz
sudo mv tor-browser/ /opt/
sudo chown -R $USER:$GROUP /opt/tor-browser
sudo chmod +x /opt/tor-browser/start-tor-browser.desktop
sudo ln -sf /opt/tor-browser/start-tor-browser.desktop /usr/share/applications

# Vivaldi
echo "Installation de Vivaldi..."
wget https://downloads.vivaldi.com/stable/vivaldi-stable_7.0.3495.20-1_amd64.deb
sudo apt install -y ./vivaldi-stable_7.0.3495.20-1_amd64.deb

# LibreOffice
echo "Installation de LibreOffice..."
echo "deb http://ftp.fr.debian.org/debian/ bookworm-backports main non-free contrib" | sudo tee -a /etc/apt/sources.list
sudo apt update && sudo apt install -t bookworm-backports -y libreoffice

# WireShark
echo "Installation de Wireshark..."
sudo apt install -y wireshark
sudo gpasswd -a $USER wireshark

# FileZilla
echo "Installation de FileZilla..."
sudo apt install -y filezilla

# Ark
echo "Installation d'Ark..."
sudo apt install -y ark

# Microsoft Teams
echo "Installation de Microsoft Teams..."
wget https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v1.11.5/teams-for-linux_1.11.5_amd64.deb
sudo apt install -y ./teams-for-linux_1.11.5_amd64.deb

# Zoom
echo "Installation de Zoom..."
wget -O package-signing-key.pub https://zoom.us/linux/download/pubkey?version=5-12-6
gpg --show-keys package-signing-key.pub && gpg --import package-signing-key.pub
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb

# Thèmes et icônes
echo "Installation du thème Adapta-Nokto..."
wget -O Adapta-Nokto.zip "https://cinnamon-spices.linuxmint.com/files/themes/Adapta-Nokto.zip?time=1732804679"
mkdir -p /home/$USER/.themes
unzip Adapta-Nokto.zip -d /home/$USER/.themes
sudo chown -R $USER:$GROUP /home/$USER/.themes

echo "Installation des icônes Papirus..."
sudo apt install -y papirus-icon-theme

echo "Installation du thème New-Minty..."
wget -O New-Minty.zip "https://cinnamon-spices.linuxmint.com/files/themes/New-Minty.zip?time=1732805956"
unzip New-Minty.zip -d /home/$USER/.themes
sudo chown -R $USER:$GROUP /home/$USER/.themes

echo "Installation terminée."
