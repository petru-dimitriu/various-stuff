package petru;

import java.awt.*;
import java.awt.event.*;
import java.util.Random;

import javax.swing.BoxLayout;


class WordProvider{
	static String words[] = {"GOODNESS","GOODWILL","FRIENDLINESS", "SELFLESSNESS", "BLISS","JOYFULNESS","TREASURE","LIBERTY","FORGIVE"};
	static String getWord()
	{
		Random r = new Random();
		return words[r.nextInt(words.length)];
	}
}

enum State {NEW, PLAYING, WON, LOST};

class MyFrame extends Canvas
{
	private String completeWord, partialWord;
	private Integer lives;
	private Font plainFont; 
	private State state; 
	
	public MyFrame()
	{
		setSize(200,100);
		this.state = State.NEW;
		plainFont = new Font("Serif", Font.PLAIN, 30);
	}
	
	public MyFrame(String completeWord, String partialWord, Integer lives)
	{
		setSize(200,100);
		this.completeWord = completeWord;
		this.partialWord = partialWord;
		this.lives = lives;
		this.state = State.NEW;
		plainFont = new Font("Serif", Font.PLAIN, 30);
	}
	
	public void paint (Graphics g)
	{
		setFont(plainFont);
		String message;
		switch(state)
		{
		case WON:
			message = "BRAVO!";
			break;
		case LOST:
			message = "YOU LOST!";
			break;
		case PLAYING:
			message = "Press keys";
			break;
		default:
			message = "Waiting";
		};
		g.drawChars(message.toCharArray(), 0, message.length(), 20, 20);
		
		if (completeWord != null && partialWord != null)
		{
			String ll = "Lives left: " + lives;
			g.drawChars(ll.toCharArray(),0,ll.length(),20,50);
			g.drawChars(partialWord.toCharArray(),0,partialWord.length(),20,80);
		}
	}
	
	void setWordsLives(String completeWord, String partialWord, Integer lives)
	{
		this.completeWord = completeWord;
		this.partialWord = partialWord;
		this.lives = lives;
	}
	
	void setState(State s)
	{
		state = s;
	}
	
	public State getState()
	{
		return state;
	}
}

class Window extends Frame implements ActionListener
{
	MyFrame mf;
	Button bNewWord;
	Integer lives;
	
	String completeWord,partialWord;
	
	public Window()
	{
		super("Hangman");
		setLayout(new BoxLayout(this,BoxLayout.PAGE_AXIS));
		setSize(300,200);
		mf = new MyFrame(completeWord, partialWord, lives);
		bNewWord = new Button("New word");
		add (mf);
		add (bNewWord);
		
		addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent e)
			{
				System.exit(0);
			}
		});
		
		KeyAdapter ka = new KeyAdapter(){
			public void keyPressed(KeyEvent e)
			{
				if (mf.getState() == State.NEW)
					return;
				
				char[] partial = partialWord.toCharArray();
				
				boolean ok = false;
				for (int i=0;i<completeWord.length();i++)
				{
					if (completeWord.charAt(i) == (char)(e.getKeyChar()-'a'+'A'))
					{
						partial[i] = (char)(e.getKeyChar()-'a'+'A');
						ok = true;
					}
				}
				
				if (!ok)
					lives--;
				
				if (lives == 0)
					mf.setState(State.LOST);
				partialWord = String.copyValueOf(partial);
				if (partialWord.indexOf('_')<0)
					mf.setState(State.WON);
				mf.setWordsLives(completeWord, partialWord, lives);
				mf.repaint();
			}
		};
		
		mf.addKeyListener(ka);
		
		bNewWord.addKeyListener(ka);
		bNewWord.addActionListener(this);
		
	}
	
	public void actionPerformed(ActionEvent e)
	{
		// new word
		completeWord = WordProvider.getWord();
		lives = 7;
		StringBuilder sb = new StringBuilder();
		for (int i=0;i<completeWord.length();i++)
			sb.append('_');
		partialWord = sb.toString();
		
		mf.setWordsLives(completeWord,partialWord,lives);
		mf.setState(State.PLAYING);
		mf.repaint();
		
	}
}

public class Hangman {

	
	public static void main(String[] args) {
		(new Window()).setVisible(true);

	}

}
