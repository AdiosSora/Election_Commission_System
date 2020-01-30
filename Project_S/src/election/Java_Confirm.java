package election;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

public class Java_Confirm extends JFrame implements ActionListener{

  JLabel ansLabel;

  public  void Confirmmethod(){
	  Java_Confirm frame = new Java_Confirm();

    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setBounds(10, 10, 300, 200);
    frame.setTitle("タイトル");
    frame.setVisible(true);
  }

 public Java_Confirm (){
    JButton infoButton = new JButton("Question");
    infoButton.addActionListener(this);

    JPanel p = new JPanel();
    p.add(infoButton);

    ansLabel = new JLabel("未選択です");
    JPanel ansPanel = new JPanel();
    ansPanel.add(ansLabel);

    getContentPane().add(p, BorderLayout.CENTER);
    getContentPane().add(ansPanel, BorderLayout.PAGE_END);
  }

  public void actionPerformed(ActionEvent e){
    int option = JOptionPane.showConfirmDialog(this, "投票しますか？",
      "最終確認", JOptionPane.YES_NO_OPTION,
      JOptionPane.WARNING_MESSAGE);

    if (option == JOptionPane.YES_OPTION){
      ansLabel.setText("実行しました");
    }else if (option == JOptionPane.NO_OPTION){
      ansLabel.setText("実行は中止しました");
    }
  }
}
