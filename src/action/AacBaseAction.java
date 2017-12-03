package action;

import com.intellij.icons.AllIcons;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.DataKeys;
import com.intellij.openapi.actionSystem.PlatformDataKeys;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class AacBaseAction extends AnAction {
    Project project;
    String packageName;
    String smallName;
    String bigname;
    String userName;
    String basePath;

    @Override
    public void actionPerformed(AnActionEvent e) {
        e.getPresentation().setIcon(AllIcons.General.Add);
        VirtualFile file = DataKeys.VIRTUAL_FILE.getData(e.getDataContext());
        assert file != null;
        basePath = file.getPath();
        // TODO: insert action logic here
        Map<String, String> map = System.getenv();
        userName = map.get("USERNAME");// 获取用户名
        project = e.getData(PlatformDataKeys.PROJECT);
        try {
            packageName = readPackageName();
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }

    /**
     * 刷新项目
     *
     * @param e 类
     */
    public void refreshProject(AnActionEvent e) {
        e.getProject().getBaseDir().refresh(false, true);
    }

    /**
     * 检测大写
     *
     * @param param param
     ***/
    public static String upperCharToUnderLine(String param) {
        Pattern p = Pattern.compile("[A-Z]");
        if (param == null || param.equals("")) {
            return "";
        }
        StringBuilder builder = new StringBuilder(param);
        Matcher mc = p.matcher(param);
        int i = 0;
        while (mc.find()) {
            builder.replace(mc.start() + i, mc.end() + i, "_" + mc.group().toLowerCase());
            i++;
        }

        if ('_' == builder.charAt(0)) {
            builder.deleteCharAt(0);
        }
        return builder.toString();
    }

    /**
     * 创建文件
     *
     * @param activity 活动
     * @param s        文件名称
     * @param toPath   路径
     * @param firstName 选中
     */
    public void createFile(String activity, String s, String toPath, String firstName,boolean fileType) {
        String ss = toPath.replace("/", ".");
        int start = ss.indexOf(packageName);
        String extendName = toPath.substring(start + packageName.length()).replace("/", ".");
        String extendName2=extendName.substring(0,extendName.lastIndexOf(".")).toLowerCase();
        String content;
        content = readFile("/" + activity + "/" + s);
        content = content.replace("$packageName", packageName);
        content = content.replace("$date", getNowDateShort());
        content = content.replace("$smallName", smallName);
        content = content.replace("$name", bigname);
        content = content.replace("$author", userName);
        content = content.replace("$extendName", extendName);
        content = content.replace("$importPtah", packageName + extendName2);
        writetoFile(content, toPath, firstName + s.replace("txt", fileType?"java":"kt").replace("Kt",""));
    }


    /**
     * 转换成大写还是小写
     *
     * @param s 字符串
     * @param b true 大写 false 小写
     * @return String
     */
    public String toUpperOrNot(String s, boolean b) {
        char[] cs = s.toCharArray();
        char c = cs[0];
        boolean isSmall = false;
        if (c >= 'a' && c <= 'z') {
            isSmall = true;
        }
        if (b) {
            //转换为大写
            if (isSmall) {
                cs[0] -= 32;
            }
        } else {
            if (!isSmall) {
                cs[0] += 32;
            }
        }
        return String.valueOf(cs);
    }

    public void writetoFile(String content, String filepath, String filename) {
        try {
            File floder = new File(filepath);
            // if file doesnt exists, then create it
            if (!floder.exists()) {
                boolean b = floder.mkdirs();
            }
            File file = new File(filepath + "/" + filename);
            if (!file.exists()) {
                boolean newFile = file.createNewFile();
            }

            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 获取时间
     *
     * @return String
     */
    public String getNowDateShort() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        return formatter.format(currentTime);
    }

    /**
     * 读取流
     *
     * @param filename /Activity/Fragment.txt
     * @return String
     */
    public String readFile(String filename) {
        InputStream in;
        in = this.getClass().getResourceAsStream(filename);
        String content = "";
        try {
            content = new String(readStream(in));
        } catch (Exception e) {
        }
        return content;
    }

    /**
     * 读出字节数组
     *
     * @param inStream 输入流
     * @return byte[]
     * @throws Exception
     */
    public byte[] readStream(InputStream inStream) throws Exception {
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        try {
            byte[] buffer = new byte[1024];
            int len = -1;
            while ((len = inStream.read(buffer)) != -1) {
                outSteam.write(buffer, 0, len);
            }

        } catch (IOException e) {
        } finally {
            outSteam.close();
            inStream.close();
        }
        return outSteam.toByteArray();
    }

    /**
     * 读取package
     *
     * @return String
     */
    public String readPackageName() throws ParserConfigurationException, IOException, SAXException {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(project.getBasePath() + "/app/src/main/AndroidManifest.xml");
        NodeList dogList = doc.getElementsByTagName("manifest");
        for (int i = 0; i < dogList.getLength(); i++) {
            Node dog = dogList.item(i);
            Element elem = (Element) dog;
            return elem.getAttribute("package");
        }

        return "";
    }

    public void manifast(String name, String activity) {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        try {
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(project.getBasePath() + "/app/src/main/AndroidManifest.xml");
            NodeList list = doc.getElementsByTagName("application");
            for (int i = 0; i < list.getLength(); i++) {
                Node dog = list.item(i);
                Element elem = (Element) dog;
                if (activity == null) {
                    if (elem.getAttribute("android:name") != null) {
                        elem.removeAttribute("android:name");
                    }
                    elem.setAttribute("android:name", name);
                } else {
                    Element methodElement = doc.createElement("activity");
                    methodElement.setAttribute("android:name", activity);
                    methodElement.setAttribute("android:configChanges", "orientation|keyboardHidden");
                    methodElement.setAttribute("android:windowSoftInputMode", "adjustPan|stateHidden");
                    elem.appendChild(methodElement);
                }
                break;
            }
            new File(project.getBasePath() + "/app/src/main/AndroidManifest.xml").delete();
            //开始把Document映射到文件
            TransformerFactory transFactory = TransformerFactory.newInstance();
            Transformer transFormer = transFactory.newTransformer();

            //设置输出结果
            DOMSource domSource = new DOMSource(doc);
            //生成xml文件
            File file = new File(project.getBasePath() + "/app/src/main/AndroidManifest.xml");
            //判断是否存在,如果不存在,则创建
            if (!file.exists()) {
                file.createNewFile();
            }
            //文件输出流
            FileOutputStream out = new FileOutputStream(file);
            //设置输入源
            StreamResult xmlResult = new StreamResult(out);
            //输出xml文件
            transFormer.transform(domSource, xmlResult);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
