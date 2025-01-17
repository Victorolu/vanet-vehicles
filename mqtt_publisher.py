import time
import paho.mqtt.client as paho
import hashlib, argparse, ssl, pickle
import pandas as pd

# Connection parameters
with open ("/etc/mqtt/ip_address", "r") as ip_address:
    vehicle_ip = ip_address.readline().rstrip('\n')
broker = "Broker IP"
port = 8883
root_ca = "/etc/mqtt/ca.crt"
vehicle_crt = "/etc/mqtt/"+ vehicle_ip + ".crt"
private_key = "/etc/mqtt/"+ vehicle_ip + ".key"

topic="vanet/messages"

# This is test data of messages that can be sent by vehicles in a VANET
carMessage = {
            "DSRCmsgID": "35",
            "MsgCount": "2",
            "TemporaryID": "12345",
            "Dsecond": "1589392304",
            "Latitude": "53.488826599999996",
            "Longitude": "-2.2722708393956568",
            "Elevation": "36m",
            "PositionAccuracy": "30cm",
            "TransmissionAndSpeed": "500ms",
            "Heading": "85",
            "SteeringWheelAngle": "160",
            "AccelerationSet4Way":"",
            "BrakeSystemStatus": "Good",
            "VehicleSize": "Medium"
        }

# This allows for messages to parsed to the mqtt publisher client as that is what would be expected
# parser = argparse.ArgumentParser()
# parser.add_argument('-m', '--message', required=True, default=None)
# df = parser.parse_args().message

df = pd.DataFrame(list(carMessage.items()), columns=["Element", "Value"])

def on_publish(client, userdata, mid):
    print("sent") 

client= paho.Client()

client.on_publish=on_publish
client.tls_set(ca_certs=root_ca,
            certfile=vehicle_crt,
            keyfile=private_key,
            cert_reqs=ssl.CERT_REQUIRED,
            tls_version=ssl.PROTOCOL_TLSv1_2,
            ciphers=None)

print("connecting to broker ",broker)
client.connect(broker, port)
client.loop_start()
print("connected")

client.publish(topic, pickle.dumps(df))

client.disconnect() #disconnect
client.loop_stop() #stop loop


