package action;

import com.intellij.icons.AllIcons;
import com.intellij.openapi.actionSystem.AnActionEvent;
import dialog.AacDialog;

import java.io.File;

/**
 * Created by FengTing on 2017/1/4.
 */
public class AacAction extends AacBaseAction {


    @Override
    public void update(AnActionEvent e) {
        super.update(e);
        e.getPresentation().setIcon(AllIcons.General.Add);
    }

    @Override
    public void actionPerformed(AnActionEvent e) {
        super.actionPerformed(e);
        AacDialog dialog = new AacDialog();
        dialog.setListener((msg, lanType,indexType, indexViewType) ->
                selectIndex(e, msg,lanType, indexType, indexViewType)
        );
        dialog.pack();
        dialog.setVisible(true);
    }



    private void selectIndex(AnActionEvent e, String msg, int lanType,int indexType, int indexViewType) {
        String type;
        switch (indexType) {
            case 0:
                if (indexViewType == 0) {
                    type = "Activity";
                } else if (indexViewType == 1) {
                    type = "Fragment";
                } else {
                    type = "Service";
                }
                break;
            case 1:
                if (indexViewType == 0) {
                    type = "DataActivity";
                } else if (indexViewType == 1) {
                    type = "DataFragment";
                } else {
                    type = "Service";
                }
                break;
            case 2:
                if (indexViewType == 0) {
                    type = "ListActivity";
                } else if (indexViewType == 1) {
                    type = "ListFragment";
                } else {
                    type = "Service";
                }
                break;
            default:
                if (indexViewType == 0) {
                    type = "Activity";
                } else if (indexViewType == 1) {
                    type = "Fragment";
                } else {
                    type = "Service";
                }
                break;
        }
        init(e, msg, type,lanType ,indexViewType);
    }

    private void init(AnActionEvent e, String name, String typeName,int lanType, int indexViewType) {
        smallName = toUpperOrNot(name, false);
        bigname = toUpperOrNot(name, true);
        String s;
        String fileName = null;
        String presenterType;
        String viewModelType;
        if (lanType==1){
            if (indexViewType == 0) {
                s = "ActivityKt.txt";
                fileName = "activity_.txt";
            } else if (indexViewType == 1) {
                s = "FragmentKt.txt";
                fileName = "fragment_.txt";
            } else {
                s = "ServiceKt.txt";
            }
            presenterType="PresenterKt.txt";
            viewModelType="ViewModelKt.txt";
        }else {
            if (indexViewType == 0) {
                s = "Activity.txt";
                fileName = "activity_.txt";
            } else if (indexViewType == 1) {
                s = "Fragment.txt";
                fileName = "fragment_.txt";
            } else {
                s = "Service.txt";
            }
            presenterType="Presenter.txt";
            viewModelType="ViewModel.txt";
        }
        // 创建四个MVP
        createFile(typeName, s, basePath + "/" + smallName + "/ui", bigname,lanType==0);
        createFile(typeName, presenterType, basePath + "/" + smallName + "/presenter", bigname,lanType==0);
        createFile("view", viewModelType, basePath + "/" + smallName + "/model", bigname,lanType==0);
        if (indexViewType != 2) {
            //写入layout 资源文件
            File layoutFile = new File(this.getClass().getResource("/Layout/" + fileName).getFile());
            String content = readFile("/Layout/" + fileName);
            content = content.replace("$name", bigname);
            //大写转小写加下划线
            String sss = upperCharToUnderLine(smallName);
            writetoFile(content, project.getBasePath() + "/app/src/main/res/layout",
                    layoutFile.getName().replace(".txt", sss + ".xml"));
        }
        if (indexViewType == 0) {
            //写入Manfast
            String ss = basePath.replace("/", ".");
            int i = ss.indexOf(packageName);
            String extendName = basePath.substring(i + packageName.length()).replace("/", ".");
            manifast(null, extendName + "." + smallName + ".ui." + bigname + "Activity");
        }
        refreshProject(e);
    }

    public static void main(String[] ags) {
        String extendName = "tex.text2.ui";
        String extendName2 = extendName.substring(0, extendName.lastIndexOf(".")).toLowerCase();
        System.out.println("text:" + extendName2);
    }

}
