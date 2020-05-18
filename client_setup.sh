
BLOCKCHAINDIR=/etc/blockchain

if test -f "$BLOCKCHAINDIR"; then
    sudo mkdir "$BLOCKCHAINDIR"   
fi

# Creates the cleint's key and csr for mqtt connection
./client_csr_key_gen.sh

# Sends the created crs to the CA for certification
./mqttclientca.sh

# Creates copies of mqtt subscriber and blockchain executable files
cp pub_script.exp /etc/blockchain/pub_script.exp
cp mqtt_publisher.py /etc/blockchain/mqtt_publisher.py