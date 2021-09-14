//Dice Game
//Nihal Sahu

int casinoRoll = (int)random(1, 7);
int playerRoll = (int)random(1, 7);

Boolean tie = false;
Boolean playerWin = false;
Boolean casinoWin = false;
Boolean insufficientFunds = false;
Boolean playerBetting = false;

int wallet = 500;
int bet = 0;

ArrayList<PImage> images = new ArrayList<PImage>();


void setup() {
  size(800, 800);

  images.add(loadImage("dice1.png"));
  images.add(loadImage("dice2.png"));
  images.add(loadImage("dice3.png"));
  images.add(loadImage("dice4.png"));
  images.add(loadImage("dice5.png"));
  images.add(loadImage("dice6.png"));
}

void draw() {
  background(0, 0, 128);
  textAlign(CENTER);
  textSize(70);
  text("Nihal's Casino", width / 2, 70);
  textSize(20);
  text("Press c to roll Casino's die.\nPress p to roll your die.\nPress w to see if you are a winner (can only do this if you place a bet).\nPress 1 to bet $100, 2 to bet $200, 3 to bet $300, etc. (1-9).", width / 2, 110);

 
  
  textSize(36);
  text("Your Roll: " + playerRoll, width / 4, height / 2 - 100);
  text("Casino Roll:" + casinoRoll, 3 * width / 4, height / 2 - 100); 
  text("Wallet: $" + wallet, width / 2, 700);
  if (playerBetting) {
    text("Your bet: $" + bet, width / 2, 740);
  }
  else {
    text("Your bet: $0", width / 2, 740);
  }
  

  //loads array image based on index number
  image(images.get(playerRoll-1), 115, 350);
  image(images.get(casinoRoll-1), width / 2 + 115, 350);
  
  //decides what output message to print based on bool variables
  if (insufficientFunds && wallet == 0) {
    text("Insufficient Funds! Game over!", width / 2, 600);
  }
  else if (insufficientFunds) {
    text("Insufficient Funds!", width / 2, 600);
  }

  if (tie) {
    text("You win $1000000!", width / 2, 600);
   
  } 
  else if (casinoWin) {
    text("You lose your $" + bet + ".", width / 2, 600);
   
  } 
  else if (playerWin) {
    text("You get $" + bet + "!", width / 2, 600);    
  }
}

void keyPressed() { 
  //casino roll
  if (key == 'c') {
    casinoRoll = (int)random(1, 7);
    tie = false;
    playerWin = false;
    casinoWin = false;
  }

  //player roll
  if (key == 'p' && bet != 0 && playerBetting == true) {
    playerRoll = (int)random(1, 7);
    tie = false;
    playerWin = false;
    casinoWin = false;
  }

  //checking for winning if all the conditions are met
  if (key == 'w' && bet != 0 && wallet > 0 && playerBetting == true) {
    if (casinoRoll == playerRoll) {
      insufficientFunds = false;
      tie = true;
      playerWin = false;
      casinoWin = false;
      wallet += 1000000;
      playerBetting = false;
    } 
    else if (casinoRoll > playerRoll) {
      insufficientFunds = false;
      tie = false;
      playerWin = false;
      casinoWin = true;
      wallet -= bet;
      playerBetting = false;
    } 
    else if (playerRoll > casinoRoll) {
      insufficientFunds = false;
      tie = false;
      playerWin = true;
      casinoWin = false;
      wallet += bet;
      playerBetting = false;
    }
  }  
  
  //if user makes a bet and presses the acceptable keys
  if ((key - 48) <= 9 && key - 48 > 0) {
    if (wallet - ((key - 48) * 100) >= 0) {
      bet = (key - 48) * 100;
      playerBetting = true;
      casinoRoll = (int)random(1, 7);
      playerRoll = (int)random(1, 7);
      tie = false;
      playerWin = false;
      casinoWin = false;
      insufficientFunds = false;
    }
    else {
      insufficientFunds = true;
      tie = false;
      playerWin = false;
      casinoWin = false;
    }
  }
  
  
}
