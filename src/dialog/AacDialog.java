package dialog;


import com.intellij.openapi.ui.Messages;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class AacDialog extends JDialog {
    private JPanel contentPane;
    private JButton buttonOK;
    private JButton buttonCancel;
    private JComboBox aacTpye;
    private JComboBox aaViewType;
    private JTextField aacName;
    private DataListener listener;

    public AacDialog() {
        setContentPane(contentPane);
        setModal(true);
        int windowWidth = this.getWidth(); //获得窗口宽
        int windowHeight = this.getHeight(); //获得窗口高
        Toolkit kit = Toolkit.getDefaultToolkit(); //定义工具包
        int screenWidth = kit.getScreenSize().width; //获取屏幕的宽
        int screenHeight = kit.getScreenSize().height; //获取屏幕的高
        this.setLocation(screenWidth / 2 - windowWidth / 2 - 200, screenHeight / 4 - windowHeight / 4);//设置窗口居中显示
        getRootPane().setDefaultButton(buttonOK);
        setTitle("新建Aac，输入您的模块名称");
        setSize(500, 300);
        buttonOK.addActionListener(e -> onOK());

        buttonCancel.addActionListener(e -> onCancel());

        // call onCancel() when cross is clicked
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        // call onCancel() on ESCAPE
        contentPane.registerKeyboardAction(e -> onCancel(), KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
    }

    private void onOK() {
        // add your code here
        if (aacName.getText().trim().isEmpty()) {
            Messages.showInfoMessage("名称好像啥也没填！", "提示");
            return;
        }
        listener.selectValue(aacName.getText().trim(), aacTpye.getSelectedIndex(), aaViewType.getSelectedIndex());
         dispose();
    }

    private void onCancel() {
        // add your code here if necessary
        dispose();
    }

    public static void main(String[] args) {
        AacDialog dialog = new AacDialog();
        dialog.setListener((msg, indexType, indexViewType) -> {
            Messages.showInfoMessage(msg, "提示");
        });
        dialog.pack();
        dialog.setVisible(true);
        System.exit(0);
    }

    private void createUIComponents() {
        // TODO: place custom component creation code here
    }

    public void setListener(DataListener listener) {
        this.listener = listener;
    }

    public interface DataListener {
        void selectValue(String msg, int indexType, int indexViewType);

    }
}
