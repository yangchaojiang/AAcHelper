package action;

import bean.DialogValueBean;
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
        dialog.setListener(bean -> {
                    try {
                        event = e;
                        freeMarkerUtil.setValueBean(bean);
                        freeMarkerUtil.setSmallName(freeMarkerUtil.toUpperOrNot(bean.getName(), false));
                        freeMarkerUtil.setBigname(freeMarkerUtil.toUpperOrNot(bean.getName(), true));
                        selectIndex(bean);
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

    private void selectIndex(DialogValueBean bean) throws IOException {
        String type;
        if (bean.getIndexDataType() == 0) {
            type = "aac";
        } else if (bean.getIndexDataType() == 1) {
            type = "aacData";
        } else if (bean.getIndexDataType() == 2) {
            type = "aacList";
        } else {
            type = "aacMultiList";
        }
        init(bean, type);
    }

    private void init(DialogValueBean bean, String typeName) throws IOException {
        String s;
        String fileName;
        String presenterType;
        String viewModelType;
        String beanNames;
        String adapterName;
        if (bean.getLanType() == 1) {
            s = "aac.kt.ftl";
            presenterType = "Presenter.kt.ftl";
            viewModelType = "ViewModel.kt.ftl";
            beanNames = "TestBean.kt.ftl";
            adapterName="Adapter.kt.ftl";
        } else {
            s = "aac.java.ftl";
            presenterType = "Presenter.java.ftl";
            viewModelType = "ViewModel.java.ftl";
            beanNames = "TestBean.java.ftl";
            adapterName="Adapter.java.ftl";
        }
        // 创建四个MVP
        String basePath = freeMarkerUtil.getBasePath();
        String smallName = freeMarkerUtil.getSmallName();
        String bigname = freeMarkerUtil.getBigname();
        freeMarkerUtil.createFiles(typeName, s, basePath + "/" + smallName + "/ui");
        freeMarkerUtil.createFiles(typeName, presenterType, basePath + "/" + smallName + "/presenter");
        freeMarkerUtil.createFiles("view", viewModelType, basePath + "/" + smallName + "/model");
        if (bean.getIndexDataType() > 0) {
            freeMarkerUtil.createFiles("bean", beanNames, basePath + "/" + smallName + "/bean");
        }
        if (bean.getIndexDataType() == 3) {
            if (bean.getLanType() == 1) {
                freeMarkerUtil.createFiles("Adapter", adapterName, basePath + "/" + smallName + "/adapter");
            } else {
                freeMarkerUtil.createFiles("Adapter", adapterName, basePath + "/" + smallName + "/adapter");
            }
        }
        if (bean.getIndexViewType() != 2) {
            //写入layout 资源文件
            if (bean.getIndexViewType() == 0) {
                fileName = "activity_.xml.ftl";
            } else {
                fileName = "fragment_.xml.ftl";
            }
            freeMarkerUtil.createFiles("Layout", fileName, freeMarkerUtil.getProject().getBasePath() + "/app/src/main/res/layout");
        }
        if (bean.getIndexViewType() == 0) {
            //写入Manfast
            String ss = basePath.replace("/", ".");
            int i = ss.indexOf(freeMarkerUtil.getPackageName());
            String extendName = basePath.substring(i + freeMarkerUtil.getPackageName().length()).replace("/", ".");
            freeMarkerUtil.manifast(null, extendName + "." + smallName + ".ui." + bigname + "Activity");
        }
        refreshProject();
    }


}
