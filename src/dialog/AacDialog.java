package dialog;


import bean.DialogValueBean;
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
    private JComboBox lanType;
    private JTextField beanName;
    private JCheckBox checkBoxType;
    private JTextField textFieldKey;
    private JComboBox comboBoxRxType;
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
        setTitle("输入您的模块名称");
        setSize(600, 300);
        buttonOK.addActionListener(e -> onOK());
       // comboBoxRxType.setEnabled(false);
        textFieldKey.setEnabled(false);
        buttonCancel.addActionListener(e -> onCancel());
        checkBoxType.addChangeListener(e -> {
            if (checkBoxType.isSelected()){
               // comboBoxRxType.setEnabled(true);
                textFieldKey.setEnabled(true);
            }else {
               // comboBoxRxType.setEnabled(false);
               textFieldKey.setEnabled(false);
            }
        });
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        contentPane.registerKeyboardAction(e -> onCancel(), KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
    }

    private void onOK() {
        // add your code here
        if (aacName.getText().trim().isEmpty()) {
            Messages.showInfoMessage("名称好像啥也没填！", "提示");
            return;
        }
        if (aaViewType.getSelectedIndex() > 1 && aacTpye.getSelectedIndex() > 0) {
            Messages.showInfoMessage("Service只支持aac类型", "提示");
            return;
        }
        if (aacTpye.getSelectedIndex() > 0 && beanName.getText().trim().isEmpty()) {
            Messages.showInfoMessage("Bean,好像啥也没填！", "提示");
            return;
        }
        DialogValueBean bean = new DialogValueBean();
        if (checkBoxType.isSelected()) {
            bean.setRxIndex(comboBoxRxType.getSelectedIndex());
            bean.setKeyName(textFieldKey.getText().trim());
        }else {
            bean.setRxIndex(0);
        }
        bean.setHttp(checkBoxType.isSelected());
        bean.setName(aacName.getText().trim());
        bean.setBeanName(beanName.getText().trim());
        bean.setLanType(lanType.getSelectedIndex());
        bean.setIndexDataType(aacTpye.getSelectedIndex());
        bean.setIndexViewType(aaViewType.getSelectedIndex());
        bean.setIndexViewName(aaViewType.getSelectedItem().toString());
        listener.selectValue(bean);
        dispose();
    }

    private void onCancel() {
        // add your code here if necessary
        dispose();
    }

    public static void main(String[] args) {
        AacDialog dialog = new AacDialog();

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
        void selectValue(DialogValueBean bean);

    }
}
