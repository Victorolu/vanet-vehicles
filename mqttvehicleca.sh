export SSHPASS=vanetclients # Password to connect to sftp client profile of certification authority
VEHICLEIP=$1
CAserverIP=$2
cd /etc/mqtt
echo "Sending CSR to CA server"
# Connects to the sftp client for certification at username@ca_server_name to submit csr
sshpass -e sftp -oBatchMode=no -b - vanetclients@$CAserverIP << !
   cd incoming_requests
   put $VEHICLEIP.csr
   bye
!
echo "Receiving CA and vehicle certificates"
sleep 1
# Connects to the sftp client for certification at username@ca_server_name to collect CA certificate and vehicle certificate
sshpass -e sftp -oBatchMode=no -b - vanetclients@$CAserverIP << !
   get ca.crt
   cd outgoing_certificates
   get $VEHICLEIP.crt
   rm $VEHICLEIP.crt
   bye
!