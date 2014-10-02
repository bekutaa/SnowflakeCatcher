import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SnowflakeCatcher extends PApplet {

SnowFlake [] storm;
int backColor = color(30,30,90);

int eraserSize = 20;

public void setup()
{
  size(800,600);
  background(backColor);

  storm = new SnowFlake[height*2];
  for (int i = 0; i < storm.length; i++)
  {
    storm[i] = new SnowFlake();
  }
}
public void draw()
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

public void mouseDragged()
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

public void keyPressed()
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

    myTimer = (int)(Math.random()*(height*1.5f));
    myCount = 0;
  }

  public void show()
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

  public void lookDown()
  {
    // if below is not black, and is onscreen, then don't move
    if(get(myX,myY+mySize) != color(backColor) && myY > -1 && myY < height-5)
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

  public void erase()
  {
    fill(backColor);
    ellipse(myX,myY,mySize+3,mySize+3);
  }

  public void move()
  {
    if(moveFlag)
    {
      myY++;
    }
  }

  public void wrap()
  {
    if(myY > height + 10)
    {
      myX = (int)(Math.random()*width);
      myY = (int)(Math.random()*(height/2))-(height/2);
    }
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SnowflakeCatcher" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
