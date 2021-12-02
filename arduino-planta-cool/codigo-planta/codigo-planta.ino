#include <ESP8266WiFi.h>
#include "FirebaseESP8266.h"

// Credenciales wifi
#define ssid "INFINITUM3198_2.4"
#define password "MGB7du6ZTu"

// Credenciales de Firebase
#define API_KEY "AIzaSyA3AX7f-vt0YXHrw-M9utADT8kYjqEFsdA"
const char *FIREBASE_HOST="https://planta-cool-default-rtdb.firebaseio.com/a"; 
const char *FIREBASE_AUTH="ZuM0pmh3aC5iS6a8oJLHdsWIkfgshUf4Z0vAmKFd";
FirebaseData firebaseData;

void setup() {
  // Pines
  pinMode(D0,OUTPUT);

  // Monitor serial
  Serial.begin(9600);
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

  // Subir datos a Firebase
  Firebase.pushInt(firebaseData, "Planta1/humedad-de-la-tierra-historia", 88888);
  Firebase.setInt(firebaseData, "Planta1/humedad-de-la-tierra-actual", 99999);

  
  // Loop de la bomba de agua
  digitalWrite(D0, LOW);
  delay(1000);
  digitalWrite(D0, HIGH);
  delay(3000);

}
