#include "BLEDevice.h"
#include "BLEServer.h"
#include "BLEUtils.h"
#include "BLE2902.h"
#include "String.h"
 
BLECharacteristic *pCharacteristic;
bool deviceReady = true;
bool deviceConnected = false;
uint8_t txValue = 0;
long lastMsg = 0;
String rxload="";
bool ledstatus = false;

#define SERVICE_UUID           "6e400001-b5a3-f393-e0a9-e50e24dcca9e" 
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
 
class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
      Serial.println("Connected");
    };
    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
      Serial.println("Disconnected");
      pServer->getAdvertising()->start();
      

    }
};
 
class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
      if (rxValue.length() > 0) {
        rxload="";
        for (int i = 0; i < rxValue.length(); i++){
          rxload +=(char)rxValue[i];
        }
      }
    }
};
 
void setupBLE(String BLEName){
  const char *ble_name=BLEName.c_str();
  BLEDevice::init(ble_name);
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
  BLEService *pService = pServer->createService(SERVICE_UUID); 
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID_RX,BLECharacteristic::PROPERTY_WRITE);
  pCharacteristic->setCallbacks(new MyCallbacks()); 
  pService->start();
  pServer->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify...");
}

void setup() {
  Serial.begin(9600);
  setupBLE("ESP32_Bluetooth");
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(14, OUTPUT);
  pinMode(25, OUTPUT);
  pinMode(26, OUTPUT);
  pinMode(27, OUTPUT);
  pinMode(32, OUTPUT);
}
 
void loop() {
  long now = millis();
  if (now - lastMsg > 100) {
    if (deviceConnected&&rxload.length()>0) {
        unsigned rxloadvalue = (unsigned)rxload[0];
        Serial.println("Received value: " + String(rxloadvalue));
        if(rxloadvalue == 25 && ledstatus){
           ledstatus = false;
           digitalWrite(25, LOW);
        }else if(rxloadvalue == 25 && !ledstatus){
           ledstatus = true;
           digitalWrite(25, HIGH);
        }else if(rxloadvalue == 12 || rxloadvalue == 13 || rxloadvalue == 14 || rxloadvalue == 26 || rxloadvalue == 27 || rxloadvalue == 32){
           digitalWrite((int) rxloadvalue, HIGH);
           delay(500);
           digitalWrite((int) rxloadvalue, LOW);
        }


        rxload="";
    }
    lastMsg = now;
  }

}
