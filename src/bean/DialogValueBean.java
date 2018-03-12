package bean;

public class DialogValueBean {
    private String name;
    private  String beanName;//实体类名称
    private  int lanType;//语言类型
    private  int indexDataType;//选择数据类型
    private   int indexViewType;//view 类型
    private  String indexViewName;//view 类型名称
    private   boolean  isHttp;
    private   int rxIndex;
    private   String keyName;
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBeanName() {
        return beanName;
    }

    public void setBeanName(String beanName) {
        this.beanName = beanName;
    }

    public int getLanType() {
        return lanType;
    }

    public void setLanType(int lanType) {
        this.lanType = lanType;
    }

    public int getIndexDataType() {
        return indexDataType;
    }

    public void setIndexDataType(int indexDataType) {
        this.indexDataType = indexDataType;
    }

    public int getIndexViewType() {
        return indexViewType;
    }

    public void setIndexViewType(int indexViewType) {
        this.indexViewType = indexViewType;
    }

    public String getIndexViewName() {
        return indexViewName;
    }

    public void setIndexViewName(String indexViewName) {
        this.indexViewName = indexViewName;
    }

    public int getRxIndex() {
        return rxIndex;
    }

    public void setRxIndex(int rxIndex) {
        this.rxIndex = rxIndex;
    }

    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    public boolean isHttp() {
        return isHttp;
    }

    public void setHttp(boolean http) {
        isHttp = http;
    }
}
