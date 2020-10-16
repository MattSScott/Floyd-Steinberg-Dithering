PImage smoke;

void setup(){
  smoke = loadImage("smoke.jpg");
  smoke.filter(GRAY);
  size(1500,500);
  image(smoke, 0, 0);
}

void draw(){
 smoke.loadPixels();
 for(int y = 0; y<smoke.height-1; y++){
   for(int x=1; x<smoke.width-1; x++){
     color col = smoke.pixels[index(x,y)];
     
     float redO = red(col);
     float greenO = green(col);
     float blueO = blue(col);
     
     int redN = round(redO/255) * 255;
     int greenN = round(greenO/255) * 255;
     int blueN = round(blueO/255) * 255;
     
     smoke.pixels[index(x,y)] = color(redN, greenN, blueN);
     
     float ErrR = redO - redN;
     float ErrG = greenO - greenN;
     float ErrB = blueO - blueN;
     
     pixelUpdate(index(x+1, y  ), ErrR, ErrG, ErrB, 7.0/16.0);
     pixelUpdate(index(x-1, y+1), ErrR, ErrG, ErrB, 3.0/16.0);
     pixelUpdate(index(x  , y+1), ErrR, ErrG, ErrB, 5.0/16.0);
     pixelUpdate(index(x+1, y+1), ErrR, ErrG, ErrB, 1.0/16.0);
   }
 }
 smoke.updatePixels();
 image(smoke, 750, 0);
}

int index(int x, int y){
  return x + y * smoke.width;
}

void pixelUpdate(int index, float ErrR, float ErrG, float ErrB, float weight){
     color c = smoke.pixels[index];
     
     float red = red(c);
     float green = green(c);
     float blue = blue(c);
     
     red+=ErrR*weight;
     green+=ErrG*weight;
     blue+=ErrB*weight;

  smoke.pixels[index] = color(red, green, blue);
}
