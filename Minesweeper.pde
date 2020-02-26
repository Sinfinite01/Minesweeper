import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
public final static int NUM_ROWS = 16;
public final static int NUM_COLS = 16;
private ArrayList <MSButton> mines = new ArrayList(); //ArrayList of just the minesweeper buttons that are mined
private boolean gameState=true;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }
    
    
    for(int numMines=0; numMines<(NUM_ROWS*NUM_COLS)/10; numMines++)
    {
        setMines();
    }
}
public void setMines()
{
    //your code
    int rowMine;
    int colMine;
    rowMine = (int)(Math.random()*NUM_ROWS);
    colMine = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[rowMine][colMine]))
    {
        mines.add(buttons[rowMine][colMine]);
    }
    else
    {
        setMines();
    }
    //System.out.println((rowMine+1) + ", " + (colMine+1));
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            if(!mines.contains(buttons[row][col]) && buttons[row][col].clicked==false)
            {
                return false;
            }
            if(mines.contains(buttons[row][col]) && buttons[row][col].flagged==false)
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            buttons[row][col].setLabel("OOF");
            if(mines.contains(buttons[row][col]))
            {
                buttons[row][col].clicked=true;
            }
        }
    }
    gameState=false;
}
public void displayWinningMessage()
{
    //your code here
    for(int row=0; row<NUM_ROWS; row++)
    {
        for(int col=0; col<NUM_COLS; col++)
        {
            buttons[row][col].setLabel("WIN");
        }
    }
}
public boolean isValid(int r, int c)
{
    //your code here
    if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
    {
        return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
    numMines++;
    if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
    if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
    if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
    if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
    if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
    numMines++;
    if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        //your code here
        if(clicked==false&&mouseButton==RIGHT && gameState)
        {
            flagged=!flagged;
            clicked=false;
        }
        else if(mines.contains(this) && gameState)
        {
            clicked = true;
            displayLosingMessage();
        }
        else if(countMines(myRow,myCol)>0 && gameState)
        {
            clicked = true;
            setLabel(countMines(myRow,myCol));
        }
        else
        {
            if(gameState)
            {
                clicked = true;
            }
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked==false && !mines.contains(buttons[myRow-1][myCol-1]) && gameState)
            {
                buttons[myRow-1][myCol-1].mousePressed();
            }
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked==false && !mines.contains(buttons[myRow][myCol-1]) && gameState)
            {
                buttons[myRow][myCol-1].mousePressed();
            }
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked==false && !mines.contains(buttons[myRow+1][myCol-1]) && gameState)
            {
                buttons[myRow+1][myCol-1].mousePressed();
            }
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked==false && !mines.contains(buttons[myRow-1][myCol]) && gameState)
            {
                buttons[myRow-1][myCol].mousePressed();
            }
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked==false && !mines.contains(buttons[myRow+1][myCol]) && gameState)
            {
                buttons[myRow+1][myCol].mousePressed();
            }
            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked==false && !mines.contains(buttons[myRow-1][myCol+1]) && gameState)
            {
                buttons[myRow-1][myCol+1].mousePressed();
            }
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked==false && !mines.contains(buttons[myRow][myCol+1]) && gameState)
            {
                buttons[myRow][myCol+1].mousePressed();
            }
            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked==false && !mines.contains(buttons[myRow+1][myCol+1]) && gameState)
            {
                buttons[myRow+1][myCol+1].mousePressed();
            }

        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0,255,0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
