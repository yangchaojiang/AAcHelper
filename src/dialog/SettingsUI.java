package dialog;

import com.intellij.ide.util.PropertiesComponent;
import com.intellij.openapi.options.Configurable;
import com.intellij.openapi.options.ConfigurationException;
import com.intellij.openapi.ui.Messages;
import org.jetbrains.annotations.Nls;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;


public class SettingsUI implements Configurable {
    private JTextField textField1;
    private JTextField textField2;
    private JPanel jPanel;
    private JCheckBox checkBox1;
    private JTextField emailHint;
    private JTextField textField3;
    private JTextField textField4;

    @Nls
    @Override
    public String getDisplayName() {
        return "AAcSetting";
    }

    @Nullable
    @Override
    public String getHelpTopic() {
        return null;
    }

    @Nullable
    @Override
    public JComponent createComponent() {
        checkBox1.setSelected(PropertiesComponent.getInstance().getBoolean("isHttp",false));
        textField1.setText(PropertiesComponent.getInstance().getValue("importPath",""));
        textField2.setText(PropertiesComponent.getInstance().getValue("shili",""));
        emailHint.setText(PropertiesComponent.getInstance().getValue("emailName",""));
        return jPanel;
    }

    @Override
    public boolean isModified() {
        return true;
    }

    @Override
    public void apply() throws ConfigurationException {
         boolean isHttp=  checkBox1.isSelected();
         if (isHttp) {
             if (textField1.getText().isEmpty()) {
                 Messages.showInfoMessage("您路径为空", "提示");
                 return;
             }
             if (textField2.getText().isEmpty()) {
                 Messages.showInfoMessage("构成函数没有填写", "提示");
                 return;
             }
             PropertiesComponent.getInstance().setValue("importPath",textField1.getText());
             PropertiesComponent.getInstance().setValue("shili",textField2.getText());
         }
        PropertiesComponent.getInstance().setValue("emailName",emailHint.getText());
        PropertiesComponent.getInstance().setValue("isHttp",isHttp);
        Messages.showInfoMessage("OK" +
                "", "提示");
    }

    @Override
    public void reset() {

    }
}
