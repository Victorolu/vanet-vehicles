# vanet-vehicles

This is the setup for the vehicles that will connect to the RSU brokers and publish messages to the topic "vanet/messages".

In the **vehicle_csr_key_gen.sh** file, the password as well as subjectinfo details should be changed accordingly. The **sub_script.exp** file should also have the password changed to match.

In the **mqtt_publisher.py** file, the broker field needs to be inputted which is the Common Name for the broker (IP address of the broker host machine).

It should be noted that the SSL connection required by MQTT is only supported by Python 3.6.x and lower.

On downloading and after making the above changes, the vehicle_setup.sh file should be run as root using command:

    sudo bash ./vehicle_setup.sh <IP Address of host machine> <IP address of CA Server>