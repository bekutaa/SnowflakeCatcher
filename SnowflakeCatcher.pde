SnowFlake [] storm;
boolean drawCatcher = true;

int eraserSize = 15;
int timeCounter = 0;

void setup()
{
  size(400,400);
  background(0);

  storm = new SnowFlake[600];
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
//    if(i < 20 && timeCounter%10 == 0)
//    {
//      System.out.print(storm[i].myY + " ");
//    }
  }
//  if(timeCounter%10 == 0)
//  {
//    System.out.println();
//  }
  
 // timeCounter++;
}

void mouseDragged()
{
  noStroke();
  if(drawCatcher)
  {
    fill(255,0,0);
  }
  else
  {
    fill(0,0,0);
  }
  ellipse(mouseX,mouseY,eraserSize,eraserSize);
}

void keyPressed()
{
  if(key == 'z')
  {
    drawCatcher = !drawCatcher;
  }
  if(key == 'x')
  {
    background(0);
  }

  if(key == 'a')
  {
    if(eraserSize < 1000)
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
    mySize = 5;

    myTimer = (int)(Math.random()*480);
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
    // if below is not black, and is onscreen, then don't move
    if(get(myX,myY+mySize) != color(0) && myY >= 5 && myY < 395)
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
    fill(0);
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
    if(myY > 410)
    {
      myX = (int)(Math.random()*width);
      myY = (int)(Math.random()*80)-75;
    }
  }
}

