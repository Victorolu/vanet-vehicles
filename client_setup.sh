BLOCKCHAINDIR=/etc/blockchain

if test -e "$BLOCKCHAINDIR"; then
    echo "Directory already exists"
else
    mkdir "$BLOCKCHAINDIR"
    echo "Done"
fi

# Installing dependencies
apt-get install -y python3-pandas python3-pip expect sshpass
sudo -H pip3 install paho-mqtt

# Adds executable attribute to scripts
chmod +x client_csr_key_gen.sh
chmod +x mqttclientca.sh

# Creates the cleint's key and csr for mqtt connection
./client_csr_key_gen.sh

# Sends the created crs to the CA for certification
./mqttclientca.sh

# Creates copies of mqtt subscriber and blockchain executable files
cp pub_script.exp /etc/blockchain/pub_script.exp
cp mqtt_publisher.py /etc/blockchain/mqtt_publisher.py