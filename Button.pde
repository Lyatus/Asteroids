class Button {
  int x, y, width, height;
  String title;
  color normalColor = color(128), hoverColor = color(64);

  Button(int x, int y, int width, int height, String title) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.title = title;
  }
  void draw() {
    pushStyle();
    fill((hover())?hoverColor:normalColor);
    rect(x, y, width, height);
    fill(255);
    text(title,x+width/2,y);
    popStyle();
  }
  boolean pressed() {
    return mousePressed && hover();
  }
  boolean hover(){
    return mouseX>=x && mouseX<=x+width && mouseY>=y && mouseY<=y+height;
  }
}

