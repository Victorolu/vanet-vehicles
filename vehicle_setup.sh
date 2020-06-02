BLOCKCHAINDIR=/etc/blockchain
VEHICLEIP=$1
CASERVERIP=$2

if test -e "$BLOCKCHAINDIR"; then
    echo "/etc/blockchain directory already exists"
else
    mkdir "$BLOCKCHAINDIR"
    echo "Created /etc/blockchain directory"
fi

# Adds CA Server to known hosts and makes sure there are no duplicates
ssh-keygen -R $CASERVERIP
ssh-keyscan -H $CASERVERIP >> ~/.ssh/known_hosts

# Installing dependencies
apt-get install -y python3-pandas python3-pip expect sshpass
sudo -H pip3 install paho-mqtt

# Adds executable attribute to scripts
chmod +x vehicle_csr_key_gen.sh
chmod +x mqttvehicleca.sh

# Creates the cleint's key and csr for mqtt connection
./vehicle_csr_key_gen.sh $VEHICLEIP

# Sends the created crs to the CA for certification
./mqttvehicleca.sh $VEHICLEIP $CASERVERIP

# Creates copies of mqtt subscriber and blockchain executable files
cp pub_script.exp /etc/blockchain/pub_script.exp
cp mqtt_publisher.py /etc/blockchain/mqtt_publisher.py