# vanet-vehicles

This is the setup for the vehicles that will connect to the RSU brokers and publish messages to the topic "vanet/messages".

In the **client_csr_key_gen.sh"" file, the password as well as subjectinfo details should be changed accordingly. The Common Name field in subjectinfo (CN) must match the name of client that would be connected to. In testing, this can be the IP address of the client.

The pub_script.exp file should also have the password changed.

It should be noted that the SSL connection required by MQTT is only supported by Python 3.6.x and lower.

On downloading, the client_setup.sh file should be run as root using command:

    sudo ./client_setup.sh