export SSHPASS=vanetclients # Password to connect to sftp client profile of certification authority
CAserverIP=
cd /etc/certs
echo "Sending CSR to CA server"
# Connects to the sftp client for certification at username@ca_server_name to submit csr
sshpass -e sftp -oBatchMode=no -b - vanetclients@$CAserverIP << !
   cd incoming_requests
   put vehicle.csr
   bye
!
echo "Receiving CA and vehicle certificates"
sleep 1
# Connects to the sftp client for certification at username@ca_server_name to collect CA certificate and vehicle certificate
sshpass -e sftp -oBatchMode=no -b - vanetclients@$CAserverIP << !
   get ca.crt
   cd outgoing_certificates
   get vehicle.crt
   rm vehicle.crt
   bye
!