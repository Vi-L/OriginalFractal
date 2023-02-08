ArrayList<Square> sqs = new ArrayList<Square>();
int timer = 0;
boolean play = false;

public void setup() {
  size(500, 500);
  rectMode(CENTER);
  fractal(250, 250, 500, (float)Math.PI/4);
}

public void draw() {
  background(255);
  for (int i = 0; i < sqs.size(); i++) {
    Square thisS = sqs.get(i);
    
    pushMatrix();
    translate(250, 250);
    rotate(thisS.getRot());
    thisS.show();
    popMatrix();
    if (play) thisS.move();
  }
}

public void keyPressed() {
  if (key == ' ') {
    play = !play;
  }
}

public void fractal(float x, float y, float sz, float backRot) {
  if (sz > 1) {
    sqs.add(new TileSquare(0, 0, sz, color(100, 255, 50), 30, backRot));
    for (float i = 0; i < 2*Math.PI; i += Math.PI / 36) {
      Square s = new Square(x/3, x/3, sz/3, color(255, 0, 0), 10, i);
      sqs.add(s);
    }
    fractal(x, y, sz/2, backRot + (float)Math.PI / 4);
  }
}

public class Square {
  protected float myX, myY, mySz, myRot;
  protected int myColor, myTransp;
  private float mySpeed;
  Square() {
    myX = 0;
    myY = 0;
    mySz = 0;
    myRot = 0;
    myColor = color(0, 0, 0);
    myTransp = 0;
    mySpeed = 0;
  }
  
  Square(float x, float y, float sz, int c, int t, float rot) {
    myX = x;
    myY = y;
    mySz = sz;
    myColor = c;
    myTransp = t;
    myRot = rot;
    mySpeed = 1;
  }
  
  public void show() {
    fill(myColor, myTransp);
    rect(myX, myY, mySz, mySz);
  }
  
  public void move() {
    if (myX >= 260) mySpeed = -1;
    else if (myX <= -10) mySpeed = 1;
    myX+=mySpeed;
    myY+=mySpeed;
  }
  
  public float getX() {
    return myX;
  }
  public float getY() {
    return myY;
  }
  public float getRot() {
    return myRot;
  }
}

public class TileSquare extends Square{
  TileSquare(float x, float y, float sz, int c, int t, float rot) {
    myX = x;
    myY = y;
    mySz = sz;
    myColor = c;
    myTransp = t;
    myRot = rot;
  }
  public void move() {
    myRot += Math.PI/360;
  }
}
