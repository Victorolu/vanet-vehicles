import time
import paho.mqtt.client as paho
import hashlib, argparse, ssl, pickle
import pandas as pd


broker = "192.168.0.112"
port = 8883
root_ca = "/etc/certs/ca.crt"
client_crt = "/etc/certs/broker.crt"
private_key = "/etc/certs/broker.key"

topic="vanet/messages"

# This allows for messages to parsed to the mqtt publisher client as that is what would be expected
# parser = argparse.ArgumentParser()
# parser.add_argument('-m', '--message', required=True, default=None)
# df = parser.parse_args().message

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

df = pd.DataFrame(carMessage.items(), columns=["Element", "Value"])

def on_publish(client, userdata, mid):
    print("sent") 

client= paho.Client()

client.on_publish=on_publish
client.tls_set(ca_certs=root_ca,
            certfile=client_crt,
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


