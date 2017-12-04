package action;

import com.intellij.icons.AllIcons;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.ui.Messages;
import dialog.AacDialog;
import utils.FreeMarkerUtil;

import java.io.IOException;


public class AacAction extends AnAction {

    private FreeMarkerUtil freeMarkerUtil;
    private AnActionEvent event;

    /**
     * 刷新项目
     */
    private void refreshProject() {
        event.getProject().getBaseDir().refresh(false, true);
    }

    @Override
    public void update(AnActionEvent e) {
        super.update(e);
    }

    @Override
    public void actionPerformed(AnActionEvent e) {
        e.getPresentation().setIcon(AllIcons.General.Add);
        freeMarkerUtil = new FreeMarkerUtil(e);
        AacDialog dialog = new AacDialog();
        dialog.setListener((name, beanName, lanType, indexType, indexViewType, indexViewName) -> {
                    try {
                        event = e;
                        freeMarkerUtil.setTypeViewIndex(indexViewType);
                        freeMarkerUtil.setIndexViewName(indexViewName);
                        freeMarkerUtil.setIndexDataTye(indexType);
                        selectIndex(name, beanName, lanType, indexType);
                    } catch (IOException e1) {
                        e1.printStackTrace();
                        System.err.print(":" + e1.getMessage());
                        Messages.showInfoMessage(e1.getMessage(), "提示");
                    }
                }
        );
        dialog.pack();
        dialog.setVisible(true);
    }

    private void selectIndex(String msg, String beanName, int lanType, int indexDataType) throws IOException {
        String type;
        if (indexDataType == 0) {
            type = "aac";
        } else if (indexDataType == 1) {
            type = "aacData";
        } else {
            type = "aacList";
        }
        init(msg, type, beanName, lanType,indexDataType);
    }

    private void init(String name, String typeName, String beanName, int lanType, int indexType) throws IOException {
        freeMarkerUtil.setSmallName(freeMarkerUtil.toUpperOrNot(name, false));
        freeMarkerUtil.setBigname(freeMarkerUtil.toUpperOrNot(name, true));
        if (beanName != null && !beanName.isEmpty()) {
            freeMarkerUtil.setBeanBean(freeMarkerUtil.toUpperOrNot(beanName, true));
        }
        String s;
        String fileName;
        String presenterType;
        String viewModelType;
        String beanNames;
        if (lanType == 1) {
            s = "aac.kt.ftl";
            presenterType = "Presenter.kt.ftl";
            viewModelType = "ViewModel.kt.ftl";
            beanNames = "TestBean.kt.ftl";
        } else {
            s = "aac.java.ftl";
            presenterType = "Presenter.java.ftl";
            viewModelType = "ViewModel.java.ftl";
            beanNames = "TestBean.java.ftl";
        }
        // 创建四个MVP
        String basePath = freeMarkerUtil.getBasePath();
        String smallName = freeMarkerUtil.getSmallName();
        String bigname = freeMarkerUtil.getBigname();
        freeMarkerUtil.createFiles(typeName, s, basePath + "/" + smallName + "/ui");
        freeMarkerUtil.createFiles(typeName, presenterType, basePath + "/" + smallName + "/presenter");
        freeMarkerUtil.createFiles("view", viewModelType, basePath + "/" + smallName + "/model");
        if (indexType > 0) {
            freeMarkerUtil.createFiles("bean", beanNames, basePath + "/" + smallName + "/bean");
        }
        if (freeMarkerUtil.getTypeViewIndex()  != 2) {
            //写入layout 资源文件
            if (freeMarkerUtil.getTypeViewIndex() == 0) {
                fileName = "activity_.xml.ftl";
            } else {
                fileName = "fragment_.xml.ftl";
            }
            freeMarkerUtil.createFiles("Layout", fileName, freeMarkerUtil.getProject().getBasePath() + "/app/src/main/res/layout");
        }
        if (freeMarkerUtil.getTypeViewIndex()  == 0) {
            //写入Manfast
            String ss = basePath.replace("/", ".");
            int i = ss.indexOf(freeMarkerUtil.getPackageName());
            String extendName = basePath.substring(i + freeMarkerUtil.getPackageName().length()).replace("/", ".");
            freeMarkerUtil.manifast(null, extendName + "." + smallName + ".ui." + bigname + "Activity");
        }
        refreshProject();
    }


}
