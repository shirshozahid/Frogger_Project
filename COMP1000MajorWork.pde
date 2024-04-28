//Shirsho Zahid Riddhy, 46727647 //<>//
//[x] I declare that I have not seen anyone else's code
//[x] I declare that I haven't shown my code to anyone else.

/*
The following statements have yellow lines
 because these constants have not yet been used.
 It's fine :)
 */

final int N_LANES = 2;
final int N_CARS_IN_LANE = 3;
final int MIN_GAP = 50;
final int MAX_LIVES = 1;
final int WIN_SCORE = 10;

float a;
float b;
float pedX;
float pedY;
boolean gameState = true;
int score;
float peaX;
float peaY;
int lives;
float[][] projLoc;
float[][] projMov;
float[][] projYLoc;
float[][] laneHeight;
float[][] vehY;

void setup () {
  size (1200, 400);
  background (255);
  a = width/50;
  b = width;
  pedX = width/2;
  pedY = height*0.9;
  peaX = width/50;
  peaY = height/6;
  lives = MAX_LIVES;
  projLoc = new float[N_CARS_IN_LANE][N_LANES];
  projMov = new float[N_CARS_IN_LANE][N_LANES];
  projYLoc = new float[N_CARS_IN_LANE][N_LANES];
  laneHeight = new float[N_CARS_IN_LANE][N_LANES];
  vehY = new float[N_CARS_IN_LANE][N_LANES];
  for (int i = 0; i < projLoc.length; i++) {
    for (int j = 0; j < projLoc[i].length; j++) {
      projLoc[i][j] = width/50;
      projMov[i][j] = random(1, 10);
    }
  }
  setHeight();
}

void resetCars() {
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      if (projLoc[i][j] > width) {
        projLoc[i][j]=0;
      }
    }
  }
}

void peaShooter(float m, float projYLoc[][]) {
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      for (int k = 1; k <= N_LANES; k++) {
        if (k == j + 1) {
          arc (m, projYLoc[i][j], ((height/8)/2)/N_LANES, (height*0.1), 5*PI/10, PI, OPEN);      //https://processing.org/reference/arc.html 
          fill (0, 255, 0);
          noStroke (); 
          circle(m, projYLoc[i][j], (height*0.1/N_LANES));
          circle (m - (((.012*height)*N_LANES)*.5)-4, projYLoc[i][j] - (height/N_LANES)/21, (height*0.1/2)/(N_LANES+1));
          circle (m - ((height*7)/(N_LANES*100)), projYLoc[i][j] - (height*0.05)/(N_LANES+1), (3*height/80)/N_LANES);
          circle (m, projYLoc[i][j] + ((17*height/80)/(N_LANES+1)), (height*0.05)/N_LANES);
          circle (m + ((height*3)/(N_LANES*(height/2*N_LANES))), projYLoc[i][j] + ((height*0.2)/(N_LANES+1)), (3*height/80)/N_LANES);
          circle (m - (0.02*(height/N_LANES)), projYLoc[i][j] + ((height*0.2)/(N_LANES+1)), (3*height/80)/N_LANES);
          stroke (#8E5A5A);
          ellipse (10*m/7, projYLoc[i][j], (height*0.05)/N_LANES, (height/8)/N_LANES);
        }
      }
    }
  }
}

void pedestrian(float pedX, float pedY) {
  fill(0, 255, 0);
  square(pedX, pedY-((((height/N_LANES)*0.3)/2)+((height/8)/N_LANES)/2), ((height/8)/N_LANES));
  fill(#0823A5);
  noStroke();
  rectMode(CENTER);
  rect(pedX, pedY, ((height/N_LANES)*0.15), ((height/N_LANES)*0.3));
  fill(0, 75, 0);
  triangle(pedX, pedY, pedX-10, pedY+30, pedX+10, pedY+30);
}

void setHeight() {
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      for (int k = 1; k <= N_LANES; k++) {
        if (k == j + 1) {
          laneHeight[i][j] = ((height/N_LANES)/2) * k;
          projYLoc[i][j] = (((height/N_LANES)/2) * k)-(.33*((height/N_LANES)/2));
          vehY[i][j] = (((height/N_LANES)/2) * k)-(.33*((height/N_LANES)/2));
        }
      }
    }
  }
}

void setupLanes() {
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      for (int k = 1; k <= N_LANES; k++) {
        if (k == j + 1) {
          laneHeight[i][j] = ((height/N_LANES)/2) * k;
          for (int l = 0; l < width; l+=30) {
            stroke(255);
            line(l, laneHeight[i][j], l+20, laneHeight[i][j]);
          }
        }
      }
    }
  }
}

void projectile(float projLoc[][]) {
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      projLoc[i][j] = projLoc[i][j] + projMov[i][j];
      if (projLoc[i][j] > width) {
        projLoc[i][j] = width/20;
      }
      if (dist(projLoc[i][j], projYLoc[i][j], pedX, pedY) < 2*(height*0.1/N_LANES)) {
        lives-=1;
        pedX = width/2;
        pedY = height*0.9;
        if (lives == 0) {
          gameState = false;
        }
      }
    }
  }  
  fill (0, 255, 0);
  for (int i = 0; i < N_CARS_IN_LANE; i++) {
    for (int j = 0; j < N_LANES; j++) {
      for (int k = 1; k <= N_LANES; k++) {
        if (k == j + 1) {
          circle(projLoc[i][j], projYLoc[i][j], (height*0.1/N_LANES));
        }
      }
    }
  }
}

void score() {
  if (pedY < 0) {
    score = score + 1;
    pedX = width/2;
    pedY = height*0.9;
  }
  textSize(20);
  text("score = " + score, width-300, height-50);  
  if (score == WIN_SCORE) {
    background(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    fill(0);
    text("You Win", width/2, height/2);
  }
}

void gameOver() {
  background(0);
  textAlign(CENTER);  
  textSize(50);
  fill(255, 0, 0);
  text("Game Over", width/2, height/2);
  text("Press SpaceBar to reset", width/2, height/2 + 100);
}

void keyPressed() {
  if (keyCode == UP) {
    pedY = pedY - (((height/N_LANES)/2)-(height-395));
  } else {
    if (keyCode == DOWN) {
      pedY = pedY + (((height/N_LANES)/2)-(height-395));
    }
  }
  if (keyCode == RIGHT) {
    pedX = pedX + (((height/N_LANES)/2)-(height-395));
  } else {
    if (keyCode == LEFT) {
      pedX = pedX - (((height/N_LANES)/2)-(height-395));
    }
  }
  if (gameState==false && keyCode == 32) {  //keyCode = 32; https://keycode.info/for/Space
    gameState = true;
    lives = 3;
    pedX = width/2;
    pedY = height*0.9;
    a = width/50;
  }
}

//Main design

void draw() {
  //Checking initial state of game
  if (gameState) {

    //gameState is true and the code below is run. 

    resetCars();
    background (0, 75, 0);
    fill (#8E5A5A);

    //Dashed line
    setupLanes();

    //Pea Shooter
    noStroke();
    peaShooter(peaX, projYLoc);

    //Pedestrian
    pedestrian (pedX, pedY);

    //Projectile
    projectile(projLoc);

    textSize(20);
    text("Lives = " + lives, width-300, height-25); 

    //Scoring
    score();
  }
  
  /*else statement runs here because the gameState
   becomes false when objects collide
  */
  
  else {
    gameOver();
  }
}
