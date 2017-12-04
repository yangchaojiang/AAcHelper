package utils; /**
 * Created by yangc on 2017/12/3.
 */

import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.DataKeys;
import com.intellij.openapi.actionSystem.PlatformDataKeys;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FreeMarkerUtil {

    private Configuration cfg;
    private Project project;
    private String packageName;
    private String smallName;
    private String bigname;
    private String userName;
    private String basePath;
    private String beanBean;
    private int typeViewIndex;
    private String indexViewName;
    private int indexDataTye;
    public FreeMarkerUtil(AnActionEvent e) {
        VirtualFile file = DataKeys.VIRTUAL_FILE.getData(e.getDataContext());
        assert file != null;
        basePath = file.getPath();
        Map<String, String> map = System.getenv();
        userName = map.get("USERNAME");// 获取用户名
        project = e.getData(PlatformDataKeys.PROJECT);
        try {
            packageName = readPackageName();
            init("Templates");
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }


    public void init(String templateDir) {
        // 初始化FreeMarker配置
        cfg = new Configuration(Configuration.VERSION_2_3_22);
        cfg.setClassForTemplateLoading(this.getClass(), "/" + templateDir + "/");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }


    public static void main(String[] args) {

        try {
            Configuration cfg = new Configuration(Configuration.VERSION_2_3_22);
            cfg.setClassForTemplateLoading(cfg.getClass(), "/Templates/");
            cfg.setDefaultEncoding("UTF-8");
            cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            Template template = cfg.getTemplate("/Activity/aac.java.ftl");
            System.out.print("ok");
        } catch (IOException e) {
            e.printStackTrace();
            System.err.print(e.getMessage());
        }

    }


    /**
     * 创建文件
     *
     * @param activity 活动
     * @param name     文件名称
     * @param toPath   路径
     */
    public void createFiles(String activity, String name, String toPath) throws IOException {
        String ss = toPath.replace("/", ".");
        int start = ss.indexOf(packageName);
        String extendName = toPath.substring(start + packageName.length()).replace("/", ".");
        String extendName2 = extendName.substring(0, extendName.lastIndexOf(".")).toLowerCase();
        Map<String, Object> root = new HashMap<>();
        root.put("packageName", packageName);
        root.put("date", getNowDateShort());
        root.put("smallName", smallName);
        root.put("name", bigname);
        root.put("author", userName);
        root.put("extendName", extendName);
        root.put("beanBean", beanBean);
        root.put("importPtah", packageName + extendName2);
        root.put("viewIndex", typeViewIndex);
        root.put("viewName", indexViewName);
        root.put("dataType", indexDataTye);
        root.put("smallViewName", toUpperOrNot(indexViewName, false));
        Template template = cfg.getTemplate("/" + activity + "/" + name);
        if (name.contains("_.xml")) {
            buildTemplate(root, toPath, name.replace("ftl", "").replace("_", "_" + smallName), template);
        } else {
            if (activity.equals("bean")) {
                buildTemplate(root, toPath, beanBean + name.replace("TestBean", "").replace("ftl", ""), template);
            } else {
                buildTemplate(root, toPath, bigname + name.replace("ftl", "").replace("aac", indexViewName), template);
            }
        }
    }

    /****
     * 执行写文件操作
     * **/
    public void buildTemplate(Map root, String filepath,
                              String fileName, Template template) {
        File floder = new File(filepath);
        if (!floder.exists()) {
            boolean b = floder.mkdirs();
        } else {
            //存在该布局文件就不文件操作
            if (fileName.contains(".xml")) {
                return;
            }
        }
        File file = new File(filepath + "/" + fileName);
        try {
            Writer out = new OutputStreamWriter(new FileOutputStream(
                    file), "UTF-8");
            template.process(root, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

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

            // 3.设置输出格式和输出流
            // 5.创建一个TransformerFactory对象
            TransformerFactory tff = TransformerFactory.newInstance();
            // 6.通过TransformerFactory对象创建一个Transformer对象
            Transformer tf = tff.newTransformer();
            // 7.利用Transformer对象的transform方法指定输出流
            tf.setOutputProperty(OutputKeys.INDENT, "yes");// 设置缩进、换行
            tf.transform(new DOMSource(doc), new StreamResult(new File(
                    project.getBasePath() + "/app/src/main/AndroidManifest.xml")));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 读取流
     *
     * @param filename /templetes.Activity/templetes.Fragment.java.ftl
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


    public Project getProject() {
        return project;
    }


    public String getPackageName() {
        return packageName;
    }


    public String getSmallName() {
        return smallName;
    }

    public void setSmallName(String smallName) {
        this.smallName = smallName;
    }

    public String getBigname() {
        return bigname;
    }

    public void setBigname(String bigname) {
        this.bigname = bigname;
    }


    public String getBasePath() {
        return basePath;
    }


    public void setTypeViewIndex(int typeViewIndex) {
        this.typeViewIndex = typeViewIndex;
    }

    public String getBeanBean() {
        return beanBean;
    }

    public void setBeanBean(String beanBean) {
        this.beanBean = beanBean;
    }

    public void setIndexViewName(String indexViewName) {
        this.indexViewName = indexViewName;
    }

    public int getTypeViewIndex() {
        return typeViewIndex;
    }

    public String getIndexViewName() {
        return indexViewName;
    }

    public int getIndexDataTye() {
        return indexDataTye;
    }

    public void setIndexDataTye(int indexDataTye) {
        this.indexDataTye = indexDataTye;
    }
}
