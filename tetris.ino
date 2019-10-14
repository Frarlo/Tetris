/**
*
*@author jedda_ibrahim
*/

const int X = A0;
const int Y = A1;
const int SV = 2;
int contatore = 0;
int tempo = 150;

/**
*metodo utilizzato per dichiarare l evariabili più importanti
*/
void setup()
{
  pinMode(SV, INPUT);
  digitalWrite(SV, HIGH);
  Serial.begin(9600);
}
/**
*metodo che svolge tutte le operazioni scritte al suo interno infinite volte 
*/
void loop()
{
  if (analogRead(X) > 900)
  {
    Serial.println("d");
  }
  if (analogRead(X) < 200)
  {
    Serial.println("s");
  }
  if (analogRead(Y) == 1023)
  {
    Serial.println("g");
  }
  if (digitalRead(SV) == 0)
  {
    Serial.println("1");
  }
  delay(tempo);

}
