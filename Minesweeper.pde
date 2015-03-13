import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs;

private int bombscount = 20;
 //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    bombs=new ArrayList <MSButton>();
 buttons = new MSButton [NUM_ROWS][NUM_COLS];   
for(int i=0;i<NUM_ROWS;i++)
{
    for(int j=0;j<NUM_COLS;j++)
    {
        buttons[i][j]=new MSButton(i,j);
    }
}
for(int i=0;i<bombscount;i++)
{
    setBombs();
}
    // //declare and initialize buttons
    // setBombs();
}
public void setBombs()
{
    int row1 = (int)(Math.random()*20);
    int col1=(int)(Math.random()*20);
    if(bombs.contains(buttons[row1][col1])==false)
    {
        bombs.add(buttons[row1][col1]);
    }
    else {
        bombscount++;
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
   int finalBombs=0;
    for(int i=0;i<bombscount;i++)
    {
        if(bombs.get(i).isMarked()==true)
        {
            finalBombs++;
        }
    }
    if(finalBombs==bombscount)
    {
        return true;
    }
return false;
}

public void displayLosingMessage()
{
    for(int i=0;i<bombs.size();i++)
    {
        (bombs.get(i)).setClicked(true);
        (bombs.get(i)).setMarked(false);
    }

    String loser = "You lose!";
    int row = (int)(NUM_ROWS/2)-1;
    int col = (int)((NUM_COLS/2)-(loser.length()/2));
    for(int i = 0; i < loser.length(); i++)
    { Stroke(Math.Random()*200, 0, 0);
        buttons[row][col+i].setLabel(loser.substring(i,i+1));
    }
}
public void displayWinningMessage()
{
  String winner = "You win!";
  int row = (int)(NUM_ROWS/2)-1;
  int col = (int)((NUM_COLS/2)-(winner.length()/2));
  for(int i = 0; i < winner.length(); i++)
  {
    if(col+i < NUM_COLS)
    {
        buttons[row][col+i].setLabel(winner.substring(i,i+1));
    }
}
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }

    public void setClicked(boolean n)
    {
        clicked = n;
    }
    public void setMarked(boolean n)
    {
        marked=n;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;

        if(keyPressed==true)
        {
            marked=true;
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0)
        {
            setLabel("" + countBombs(r,c));
        }
        else
         {
            if(isValid(r-1,c-1)==true && buttons[r-1][c-1].isClicked() == false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1,c)==true && buttons[r-1][c].isClicked() == false)
            {
                buttons[r-1][c].mousePressed();
            }
           if(isValid(r-1,c+1)==true && buttons[r-1][c+1].isClicked() == false)
            {
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r,c-1)==true && buttons[r][c-1].isClicked() == false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1)==true && buttons[r][c+1].isClicked() == false)
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r+1,c-1)==true && buttons[r+1][c-1].isClicked() == false)
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r+1,c)==true && buttons[r+1][c].isClicked() == false)
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c+1)==true && buttons[r+1][c+1].isClicked() == false)
            {
                buttons[r+1][c+1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
       if(isValid(row-1,col-1)==true && bombs.contains(buttons[row-1][col-1]))
       {
        numBombs++;
       }
       if(isValid(row-1,col)==true && bombs.contains(buttons[row-1][col]))
       {
        numBombs++;
       }
       if(isValid(row-1,col+1)==true && bombs.contains(buttons[row-1][col+1]))
       {
        numBombs++;
       }
       if(isValid(row,col-1)==true && bombs.contains(buttons[row][col-1]))
       {
        numBombs++;
       }
       if(isValid(row,col+1)==true && bombs.contains(buttons[row][col+1]))
       {
        numBombs++;
       }
       if(isValid(row+1,col-1)==true && bombs.contains(buttons[row+1][col-1]))
       {
        numBombs++;
       }
       if(isValid(row+1,col)==true && bombs.contains(buttons[row+1][col]))
       {
        numBombs++;
       }
       if(isValid(row+1,col+1)==true && bombs.contains(buttons[row+1][col+1]))
       {
        numBombs++;
       }
        return numBombs;
    }
}
