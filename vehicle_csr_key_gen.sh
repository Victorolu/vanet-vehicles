SUBINFO=/etc/certs/subjectinfo
PASSFILE=/etc/certs/passwordfile
CERTDIR=/etc/certs
FILE=/etc/certs/vehicle.key
FILE2=/etc/certs/vehicle.csr

if ! test -e "$CERTDIR"; then
    mkdir "$CERTDIR"
fi

#Creates the file containing the password for generating key and certificate
if ! test -e "$PASSFILE"; then
    echo "password" | sudo tee -a $PASSFILE > /dev/null
fi

#Creates the file containing the vehicle info for generating key and certificate
if ! test -e "$SUBINFO"; then
    echo "UK,Manchester,Manchester,vanet,vanet-vehicle,vehicleID" | sudo tee -a $SUBINFO > /dev/null
fi

while IFS="," read -r f1 f2 f3 f4 f5 f6
do
    CO="$f1"
    ST="$f2"
    LO="$f3"
    OR="$f4"
    OU="$f5"
    CN="$f6"

    echo "$CO $ST $LO $OR $OU $CN"
done < "$SUBINFO"

if test -e "$FILE"; then
    echo "Private key file exists"
    echo "**********Replacing file**********"
    sudo rm "$FILE"
    sudo rm "$FILE2"
    sudo openssl genrsa -des3 -out "$FILE" -passout file:$PASSFILE 2048
    sudo openssl req -out "$FILE2" -key "$FILE" -passin file:$PASSFILE -subj "/C=$CO/ST=$ST/L=$LO/O=$OR/OU=$OU/CN=$CN" -new
    echo "Files have been replaced"
else
    echo "Private key file does not exist"
    sudo openssl genrsa -des3 -out "$FILE" -passout file:$PASSFILE 2048
    sudo openssl req -out "$FILE2" -key "$FILE" -passin file:$PASSFILE -subj "/C=$CO/ST=$ST/L=$LO/O=$OR/OU=$OU/CN=$CN" -new
    echo "Files has been created"
fi
