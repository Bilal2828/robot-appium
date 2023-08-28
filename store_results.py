import os
import xml.etree.ElementTree as ET
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS

# InfluxDB-Konfiguration
url = "https://us-east-1-1.aws.cloud2.influxdata.com"
token = "G_4ZvuD6iCdmSkieaw2lAfnl3Q8G1TD27saWrM_jS6ueKtXE4V_QZ3uzbr3tDQmkH0EWBmOYNFhw2HiZBWLoXg=="
org = "dev"
bucket = "test_results_gitlab"

# Verbindung zur InfluxDB herstellen
client = InfluxDBClient(url=url, token=token, org=org)

# XML-Datei öffnen und Testergebnisse extrahieren
current_dir = os.path.dirname(os.path.abspath(__file__))
xml_file_path = os.path.join(current_dir, "output.xml")
tree = ET.parse(xml_file_path)
root = tree.getroot()
test_results = []

for test in root.findall(".//test"):
    name = test.attrib["name"]
    starttime = test.find(".//status").attrib["starttime"]
    endtime = test.find(".//status").attrib["endtime"]
    msg = test.find(".//msg").text

    test_results.append({"name": name, "starttime": starttime, "endtime": endtime, "msg": msg})

# Testergebnisse in die InfluxDB-Datenbank einfügen
write_api = client.write_api(write_options=SYNCHRONOUS)

for result in test_results:
    point = Point("test_results_gitlab")\
        .field("msg", result["msg"])\
        .tag("name", result["name"])\
        .tag("starttime", result["starttime"])\
        .tag("endtime", result["endtime"])

    write_api.write(bucket=bucket, org=org, record=point)

# Verbindung zur InfluxDB schließen
client.close()

