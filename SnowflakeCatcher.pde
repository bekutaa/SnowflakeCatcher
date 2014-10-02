SnowFlake [] storm;
int backColor = color(30,30,90);

int eraserSize = 15;

void setup()
{
  size(800,600);
  background(backColor);

  storm = new SnowFlake[2000];
  for (int i = 0; i < storm.length; i++)
  {
    storm[i] = new SnowFlake();
  }
}
void draw()
{
  
  for (int i = 0; i < storm.length; i++)
  {
    storm[i].erase();
    storm[i].lookDown();
    storm[i].move();
    storm[i].wrap();
    storm[i].show();
  }
}

void mouseDragged()
{
  noStroke();
  if(mouseButton == LEFT)
  {
    fill(255,0,0);
  }
  if(mouseButton == RIGHT)
  {
    fill(backColor);
  }
  ellipse(mouseX,mouseY,eraserSize,eraserSize);
}

void keyPressed()
{
  if(key == 'x')
  {
    background(backColor);
  }

  if(key == 'a')
  {
    if(eraserSize < 125)
    {
      eraserSize = eraserSize + 5;
    }
  }
  if(key == 's')
  {
    if(eraserSize > 10)
    {
      eraserSize = eraserSize - 5;
    }
  }
}

class SnowFlake
{
  int myX, myY, mySize;
  int myColor;
  int myTimer, myCount;
  boolean moveFlag;

  SnowFlake()
  {
    myX = (int)(Math.random()*width);
    myY = -10;
    myColor = color(255,255,255);
    moveFlag = false;
    mySize = 4;

    myTimer = (int)(Math.random()*900);
    myCount = 0;
  }

  void show()
  {
    if(!moveFlag)
    {
      if(!(myCount > myTimer))
      {
        myCount++;
      }
    }

    noStroke();
    fill(myColor);
    ellipse(myX,myY,mySize,mySize);
  }

  void lookDown()
  {
    // if below is not the background color, and is onscreen, then don't move
    if(get(myX,myY+mySize) != color(backColor) && myY > 0 && myY < 600)
    {
      moveFlag = false;
    }
    else
    {
    // move if timer has been reached, otherwise stay in place
      if(myCount > myTimer)
      {
        moveFlag = true;
      }
      else
      {
        moveFlag = false;
      }
    }
  }

  void erase()
  {
    fill(backColor);
    ellipse(myX,myY,mySize+3,mySize+3);
  }

  void move()
  {
    if(moveFlag)
    {
      myY++;
    }
  }

  void wrap()
  {
    if(myY > height + 10)
    {
      myX = (int)(Math.random()*width);
      myY = (int)(Math.random()*300)-300;
    }
  }
}

