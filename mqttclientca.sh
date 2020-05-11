export SSHPASS=vanetclients
cd /etc/certs
echo "Yup"
sshpass -e sftp -oBatchMode=no -b - vanetclients@192.168.0.98 << !
   cd incoming_requests
   put client.csr
   bye
!
echo "Done"
sleep 2
sshpass -e sftp -oBatchMode=no -b - vanetclients@192.168.0.98 << !
   cd outgoing_certificates
   get ca.crt
   get client.crt
   rm client.crt
   bye
!