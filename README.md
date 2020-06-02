# vanet-vehicles

This is the setup for the vehicles that will connect to the RSU brokers and publish messages to the topic "vanet/messages".

Input the IP address of the machine to the **VEHICLEIP** fields within the following files: **vehicle_csr_key_gen.sh** and **mqttvehicleca.sh**.

In the **vehicle_csr_key_gen.sh** file, the password as well as subjectinfo details should be changed accordingly. The Common Name field in subjectinfo (CN) must match the name of client that would be connected to. In testing, this can be the IP address of the vehicle.

In the **mqttvehicleca.sh** file, the CASERVERIP field will need the IP address of the machine hosting CA Server. Before connecting to the CA server, it is necessary to do a manual ssh connection to verify the ssh host using the ECDSA key fingerprint and add to the CA server to known-hosts

In the **mqtt_publisher.py** file, the vehicle_ip field will need the IP address of host machine, the broker field will need the Common Name for the broker (IP address of the broker machine) and the **sub_script.exp** file should also have the password changed.

It should be noted that the SSL connection required by MQTT is only supported by Python 3.6.x and lower.

On downloading, the vehicle_setup.sh file should be run as root using command:

    sudo bash ./vehicle_setup.sh