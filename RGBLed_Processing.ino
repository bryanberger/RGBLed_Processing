int REDPin = 3;    // RED pin of the LED to PWM pin 4
int GREENPin = 5;  // GREEN pin of the LED to PWM pin 5
int BLUEPin = 6;   // BLUE pin of the LED to PWM pin 6

long int incomingByte = 0;   // for incoming serial data
int wait = 10; //20ms

void setup()
{
  pinMode(REDPin, OUTPUT);
  pinMode(GREENPin, OUTPUT);
  pinMode(BLUEPin, OUTPUT);
  
  Serial.begin(9600);
}

int* getColour() {
  int* colour;
  int i;
  i = 0;
  while (i < 4)
  {
    if (Serial.available() > 0) {
        colour[i] = Serial.read();
        i++;
    }
  }
  
  return colour;
}

void loop()
{
 
   if (Serial.available() > 0) {
    // get incoming byte:
    incomingByte = Serial.read();
    
     if (incomingByte == 'C') {
        int* one;
      one =  getColour();
      
      //1 2 3 not 0 1 2 due to the dud value
     analogWrite(REDPin, one[1]);
     analogWrite(GREENPin, one[2]);
     analogWrite(BLUEPin, one[3]);
    } 
  }
  
 delay(wait);
}
