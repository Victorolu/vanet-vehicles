# vanet-vehicles

This is the setup for the vehicles that will connect to the RSU brokers and publish messages to the topic "vanet/messages".

In the **vehicle_csr_key_gen.sh** file, the password as well as subjectinfo details should be changed accordingly. The **sub_script.exp** file should also have the password changed match.

Before connecting to the CA server, it is necessary to do a manual ssh connection **as root** to verify the ssh host using the ECDSA key fingerprint and add to the CA server to known-hosts using the command below:
    $ sudo sftp vanetclients@[IP address of CA Server]

In the **mqtt_publisher.py** file, the broker field will need to be inputted which is the Common Name for the broker (IP address of the broker machine).

It should be noted that the SSL connection required by MQTT is only supported by Python 3.6.x and lower.

On downloading, the vehicle_setup.sh file should be run as root using command:

    sudo bash ./vehicle_setup.sh <IP Address of host machine> <IP address of CA Server>