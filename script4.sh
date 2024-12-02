#!/bin/bash

USER="msalomon" # Nom de l'utilisateur cible
GROUP="and"     # Groupe associé à l'utilisateur

echo "Installation des outils de développement web"

# Sublime Text
echo "Installation de Sublime Text..."
sudo wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update && sudo apt install -y sublime-text

# Visual Studio Code
echo "Installation de Visual Studio Code..."
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O vscode.deb
sudo apt install -y ./vscode.deb

# Git
echo "Installation de Git..."
sudo apt install -y git

# PhpStorm
echo "Installation de PhpStorm..."
wget https://download.jetbrains.com/webide/PhpStorm-2023.2.tar.gz
tar -xzf PhpStorm-2023.2.tar.gz
sudo mv PhpStorm-2023.2 /opt/
sudo ln -s /opt/PhpStorm-2023.2/bin/phpstorm.sh /usr/local/bin/phpstorm

# Serveur AMP (Apache, MariaDB, PHP, phpMyAdmin)
echo "Installation du serveur AMP..."
sudo apt install -y phpmyadmin ufw mariadb-server php apache2
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Configuration de MariaDB
echo "Configuration de MariaDB..."
sudo mysql -u root -p <<EOF
CREATE DATABASE msalomon_db;
CREATE USER 'msalomon'@'localhost' IDENTIFIED BY 'CqriT';
GRANT ALL PRIVILEGES ON msalomon_db.* TO 'msalomon'@'localhost';
EXIT;
EOF

# Vérification de l'installation AMP
echo "Vérification du serveur AMP..."
echo "Accédez à http://localhost et à http://localhost/phpmyadmin/ pour vérifier l'installation."

# Looping (Wine et Looping)
echo "Installation de Looping..."
sudo apt install -y wine
cd /opt/ && wget https://www.looping-mcd.fr/Looping.zip
sudo unzip Looping.zip
echo 'alias looping="wine /opt/looping.exe"' >> ~/.bashrc
source ~/.bashrc
# Ajouter Looping au menu Cinnamon
echo "Ajout de Looping au menu Cinnamon..."
cinnamon-menu-editor --add --name "Looping MCD" --cmd "wine /opt/looping.exe" --category "Graphisme"

# Python et Flask
echo "Installation de Python et Flask..."
python3 --version
sudo apt install -y python3-pip python3-venv
python3 -m venv ~/env1
source ~/env1/bin/activate
pip install flask

# Création du dossier public_web et du fichier hello.py
echo "Création du projet Flask..."
mkdir ~msalomon/public_web
cat > ~msalomon/public_web/hello.py <<EOL
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return 'Hello world!'
EOL

# Démarrer le serveur Flask
echo "Démarrage du serveur Flask..."
cd ~msalomon/public_web
FLASK_APP=hello.py flask run --port=8080 >/dev/null 2>&1 &

echo "Installation terminée. Vous pouvez maintenant tester le projet Flask à http://localhost:8080"
