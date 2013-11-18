class Note {
  boolean hit;
  boolean on;
  boolean drag;
  float x, y; 
  float d;  
  float lastX, lastY;
  int counter;
  String name;
  int t;
  String s ;

  Note(float _x, float _y, String _name) {
    hit=false;
    on=false;
    x=_x;
    y=_y;
    d=20;
    lastX=_x-d;
    lastY=_y;
    counter=0;
    name=_name;
  }

  void onOff() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<=d/2) {
      on = !on;
    }
  }

  void turn() {
    if (on) {
      float dis = dist(mouseX, mouseY, x, y);
      if (dis<d*2) {
        lastX=x+d*(mouseX-x)/dis;
        lastY=y+d*(mouseY-y)/dis;
      }
    }
  }

  boolean trigger(Train t) {
    float check = dist(x, y, t.pos.x, t.pos.y);
    if (check<1) {
      hit = true;
      //out.playNote(t);
      return true;
    }
    else {
      hit = false;
      return false;
    }
  }

  void blink() {      
    if (hit) {
      counter++;
    }
    if (counter>10) {
      hit=false;
      counter=0;
    }
  }

  void display() {
    stroke(0);
    strokeWeight(3);
    textSize(10);
    text(name, x, y+24);
    float dis=dist(mouseX, mouseY, x, y);
    if (on && hit) {
      fill(color(255, 0, 100));
    }
    else if (on) {
      fill(color(255, 255, 0));
    }
    else {
      fill(255);
    }

    ellipse(x, y, d, d);
    strokeWeight(1);
    line(x, y, lastX, lastY);  

    if (on) {
      float gapX = lastX-x;
      float gapY = lastY-y;

      if (gapY<=0) {
        t = int(map(acos((lastX-x)/dist(lastX, lastY, x, y)), PI, 0, 0, 18));
      }
      else {
        t = int(map(PI+(acos((lastX-x)/dist(lastX, lastY, x, y))), PI, 2*PI, 18, 36));
      }
      //String s = Integer.toString(t);
      s = melody[t];
      if (gapY>=0) {
        textSize(20);
        text(s, lastX-10, lastY+30);
      }
      else {
        textSize(20);
        text(s, lastX-10, lastY-10);
      }
    }
    fill(0);
    noStroke();
    ellipse(lastX, lastY, d/3, d/3);
  }
}

