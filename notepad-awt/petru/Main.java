package petru;
import java.awt.FileDialog;
import java.awt.Frame;
import java.awt.Menu;
import java.awt.MenuBar;
import java.awt.MenuItem;
import java.awt.TextArea;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.BoxLayout;

class Notepad extends Frame implements ActionListener
{
	private TextArea textArea;
	private MenuBar menuBar;
	private Menu fileMenu;
	private MenuItem fileNew;
	private MenuItem fileOpen;
	private MenuItem fileSave;
	
	private boolean dirty;
	private String currentFileName;
	
	
	public Notepad()
	{
		super("Notepad");
		dirty = true;
		currentFileName = "";
		
		textArea = new TextArea("",0,0,TextArea.SCROLLBARS_VERTICAL_ONLY);
		menuBar = new MenuBar();
		fileMenu = new Menu("File");
		fileNew = new MenuItem("New");
		fileNew.addActionListener(this);
		fileOpen = new MenuItem("Open");
		fileOpen.addActionListener(this);
		fileSave = new MenuItem("Save");
		fileSave.addActionListener(this);
		fileMenu.add(fileNew);
		fileMenu.add(fileOpen);
		fileMenu.add(fileSave);
		
		menuBar.add(fileMenu);
		
		setLayout(new BoxLayout(this,BoxLayout.PAGE_AXIS));
		setMenuBar(menuBar);
		add(textArea);
		
		setSize(400,400);
		setVisible(true);
		
		addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent e)
			{
				System.exit(0);
			}
		});
	}
	
	private void save()
	{
		try{ 
			if (currentFileName.equals(""))
			{
				FileDialog fd = new FileDialog(this,"Save file",FileDialog.SAVE);
				fd.setVisible(true);
				if (fd.getFile() == null)
					return;
				currentFileName = fd.getFile();
				BufferedWriter out = new BufferedWriter(new FileWriter(fd.getFile()));
				out.write(textArea.getText());
				out.close();
				setTitle("Editing " + currentFileName);
			}
		}
		catch (IOException e)
		{
			System.out.println("IO Exception!");
		}
	}
	
	private void open()
	{
		try{
			FileDialog fd = new FileDialog(this,"Open file",FileDialog.LOAD);
			fd.setDirectory(System.getProperty("user.dir"));
			fd.setVisible(true);
			if (fd.getFile() == null)
				return;
			currentFileName = System.getProperty("user.dir")
                    .toString() + "/" + fd.getFile();
			BufferedReader in = new BufferedReader(new FileReader(currentFileName));
			char[] cbuff = new char[100];
			in.read(cbuff);
			textArea.setText(new String(cbuff));
			in.close();
			setTitle("Editing " + currentFileName);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	
	private void checkIfDirty()
	{
		if (dirty)
			save();
	}
	
	public void actionPerformed(ActionEvent e)
	{
		if (e.getSource() == fileNew)
		{
			checkIfDirty();
		}
		else if (e.getSource() == fileSave)
		{
			save();
		}
		else if (e.getSource() == fileOpen)
		{
			if (!(textArea.getText().equals("")))
				checkIfDirty();
			open();
		}
	}
}

public class Main {
	
	public static void main(String[] args) {
		new Notepad();
	}
	
}
