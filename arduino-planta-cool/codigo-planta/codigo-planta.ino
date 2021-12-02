#include <ESP8266WiFi.h>
#include "FirebaseESP8266.h"

// ID de la planta
String ID = "P001";

// Credenciales wifi
#define ssid "INFINITUM3198_2.4"
#define password "MGB7du6ZTu"

// Credenciales de Firebase
#define API_KEY "AIzaSyA3AX7f-vt0YXHrw-M9utADT8kYjqEFsdA"
const char *FIREBASE_HOST="https://planta-cool-default-rtdb.firebaseio.com/a"; 
const char *FIREBASE_AUTH="ZuM0pmh3aC5iS6a8oJLHdsWIkfgshUf4Z0vAmKFd";
FirebaseData firebaseData;

// Constantes de sensor de humedad
const int dry = 600;
const int wet = 336;

// Variables para la bomba de agua
bool regar = false;

void setup() {
  // Iniciar pin de bomba de agua
  pinMode(D0,OUTPUT);
  digitalWrite(D0, HIGH);

  // Monitor serial
  Serial.begin(19200);
  Serial.println();

  // Conectar a WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(250);
  }
  Serial.print("\nConectado al Wi-Fi");
  Serial.println();

  // Iniciar Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  
}


void loop() {

  // Leer sensor de humedad
  int sensorVal = analogRead(A0);
  Serial.print(sensorVal);
  Serial.println();

  int percentageMoisture = map(sensorVal, wet, dry, 100, 0);

  Serial.print(percentageMoisture);
  Serial.println("%");
  Serial.println();
  
  // Subir datos a Firebase
  Firebase.pushInt(firebaseData, ID + "/humedad-de-la-tierra-historia", percentageMoisture);
  Firebase.setInt(firebaseData, ID + "/humedad-de-la-tierra-actual", percentageMoisture);

  while(regar){
  // Loop de la bomba de agua
  digitalWrite(D0, LOW);
  delay(1000);
  digitalWrite(D0, HIGH);
  regar = false;
  
  }

  // Sensor de nivel del agua
  int hayAgua = digitalRead(D1);

  if(hayAgua){
    Serial.println("Sí hay agua");
    Serial.println();
    } else {
    Serial.println("No hay agua");
    Serial.println();
      }

  delay(3000);

}
