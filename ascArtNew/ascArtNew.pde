import g4p_controls.*;
import java.awt.*;
import javax.swing.*;
int limitSize = 50;
PImage img;
//PImage t;
PImage conv;
PImage icon = createImage(5, 5, RGB);
char[] lum = {' ', '.', ',', '-', '~', ':', ';', '=', '!', '*', '#', '$', '@'};
String result = "";
String selPath = "";
int charLim = Integer.MAX_VALUE;
GWindow window; 
void setup() {
  size(670, 820);
  icon.loadPixels();
  icon.pixels = new color[] {
    -1, -16777216, -1, -16777216, -1, 
    -16777216, -16777216, -16777216, -16777216, -16777216, 
    -1, -16777216, -1, -16777216, -1, 
    -16777216, -16777216, -16777216, -16777216, -16777216, 
    -1, -16777216, -1, -16777216, -1};
  icon.updatePixels();
  surface.setIcon(icon);
  createGUI();
  //noSmooth();
  textarea1.setFont(new Font("Monospaced", Font.PLAIN, 25));
  textarea1.setText(
    "      @@@@@@@@@@@@            \n" + 
    "  @@@@      @@@@  @@@@        \n" + 
    "  @@          @@      @@@@    \n" + 
    "@@              @@      @@    \n" + 
    "@@              @@        @@  \n" + 
    "@@                        @@  \n" + 
    "  @@                        @@\n" + 
    "  @@@@                      @@\n" + 
    "      @@@@                  @@\n" + 
    "        @@@@                @@\n" + 
    "            @@@@            @@\n" + 
    "              @@            @@\n" + 
    "                @@        @@  \n" + 
    "@@              @@        @@  \n" + 
    "@@              @@      @@    \n" + 
    "  @@          @@      @@@@    \n" + 
    "  @@@@      @@@@  @@@@        \n" + 
    "      @@@@@@@@@@@@            \n" + 
    "Dmitrisoft"
    );
  dropList1.setItems(new String[] {
    "floor, floor", 
    "floor, round", 
    "floor, ceil", 
    "round, floor", 
    "round, round", 
    "round, ceil", 
    "ceil, floor", 
    "ceil, round",    
    "ceil, ceil"
    }, 7);
  for(int _ = 0; _ < 50; _++) print("\n");
}
void draw() {
  background(200);
}

void fileSelected(File selection) {
  if (selection != null) {
    button1.setText("Current Image: " + selection.getName());
    selPath = selection.getAbsolutePath();
    refresh();
  }
}

/*public boolean allType() {
  for (String s : new String[]{"png", "bmp", "jpg", "jpeg"}) if (s == split(selPath, ".")[split(selPath, ".").length - 1]) return true;
  return false;
}*/

void refresh() {
  result = "";
  if (selPath != null && selPath != "") {  
    img = loadImage(selPath);
    if (max(img.width, img.height) > limitSize) {
      if (img.width > img.height) img.resize(limitSize, 0);
      else img.resize(0, limitSize);
    }
    if (checkbox2.isSelected()) {
      for (int i = 0; i < img.pixels.length; i++) {
        img.pixels[i] = color(255 - red(img.pixels[i]), 255 - green(img.pixels[i]), 255 - blue(img.pixels[i]));
      }
    }
    int i = 0;
    for (color c : img.pixels) {
      if (i % img.width == 0 && i != 0) {
        result += "\n";
        //if(i + img.width >= charLim) break;
      }
      if (alpha(c) > 250)  result += str(lum[rndFnc(map((red(c) + green(c) + blue(c)) / 3, 0, 255, lum.length - 1, 0), floor(dropList1.getSelectedIndex() / 3))]) + str(lum[rndFnc(map((red(c) + green(c) + blue(c)) / 3, 0, 255, lum.length - 1, 0), dropList1.getSelectedIndex() % 3)]);
      else result += "  ";
      i++;
      if (i >= charLim) break;
    }
    if (checkbox3.isSelected()) result += "\nhttps://t.me/thetextstickers";
    textarea1.setText(result);
  }
}

int rndFnc(float r, int c) {//round, floor, ceil
  //int c = dropList1.getSelectedIndex();
  switch(c) {
  case 0:
    return round(r);
  case 1:
    return floor(r);
  case 2:
    return ceil(r);
  }
  return 0;
}

synchronized public void windraw1(PApplet appc, GWinData data) {
  window.image(conv, 0, 0);
  //conv.resize(width, height);
}
