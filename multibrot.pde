void setup() {
  //fullScreen();
  size(1000, 800);
  //noLoop();
  loadPixels();
  background(255);
}

float wid = 1000;
float hei = 800;

float w = 5;
float h = (w * hei) / wid;

int iterMax = 50;
int bound = 100;

float xmin = -w/2;
float ymin = -h/2;
float xmax = xmin + w;
float ymax = ymin + h;

float dx = (xmax - xmin)/ (wid);
float dy = (ymax - ymin)/ (hei);

float theta = 0;  

int d = 1;


void draw() {

  float y = ymin;
  for (int j=0; j<height; j++) {
    float x = xmin;
    for (int i=0; i<width; i++) {

      float a = x;
      float b = y;

      float ca = a;
      float cb = y;

      int n = 0;

      float oldMag = 0;
      float convergeNumb = iterMax;

      while (n < iterMax) {
        //z = z^d+c
        float aa = 0;
        float bb = 0;
        for (int o = 0; o<=d; o++) {
          if (o%2 == 0) {
            aa += sgnI(o)*choose(d,o)*pow(a,d-o)*pow(b,o);
          } else {
            bb += sgnI(o)*choose(d,o)*pow(a,d-o)*pow(b,o);
          }
        }

        a = aa + ca;
        b = bb + cb;
        float mag = abs(aa+bb);

        if (mag > bound) {
          float deltaMag = mag - oldMag;
          float deltaMax = bound - oldMag;
          convergeNumb = n + 10*deltaMax/(1*deltaMag);
          break;
        }
        n++;
        oldMag = mag;
      }      
      if (n == iterMax) {
        pixels[i+j*width] = color(0);
      } else {
        float norm = map(convergeNumb, 0, iterMax, 0, 1);
        pixels[i+j*width] = color(map(sqrt(norm), 0, 1, 0, 255), map(n, 0, iterMax, 0, 255), n);
      }
      x += dx;
    }
    y += dy;
  }

  updatePixels();
}

int fact(int k) {
  int result = 1; 
  for (int i=1; i<= k; i++) {
    result *= i;
  }
  return result;
}

int choose(int n, int k) {
  int result = fact(n)/(fact(k)*fact(n-k));
  return result;
}

int sgnI(int n) {
  if (n%4 < 2) {
    return 1;
  } else {
    return -1;
  }
}
