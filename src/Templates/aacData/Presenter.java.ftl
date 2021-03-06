<#include "../commnt/file_package_improt.ftl">;



<#if viewIndex==0>
import com.aac.expansion.data.AacDataAPresenter;

<#if rxType==0>
import com.aac.expansion.data.AacDataAPresenter;
<#elseif rxType==1>
import com.aac.module.rx2.presenter.data.AacRxDataAPresenter;
 <#else>

 </#if>
<#elseif viewIndex==1>
<#if rxType==0>
import com.aac.expansion.data.AacDataFPresenter;
<#elseif rxType==1>
import com.aac.module.rx2.presenter.data.AacRxDataFPresenter;
 <#else>

 </#if>
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">


public class ${name}Presenter extends <#if viewIndex==0> Aac<#if rxType==1>Rx</#if>DataAPresenter <#else >Aac<#if rxType==1>Rx</#if>DataFPresenter</#if><${name}${viewName},${beanBean}> {

  public static final String TAG = ${name}Presenter.class.getName();
  private ${name}ViewModel m${name};
  @Override
  public void onCreate() {
   super.onCreate();
    m${name} = getViewModel(${name}ViewModel.class);
  }
     @Override
    public void retryData() {
         getData();
    }

    public void getData() {
<#if  isHttp>
    <#if rxType==0>
      m${name}.getData(getView(),"id").observe(getView(), getDataSubscriber());
    <#elseif rxType==1>
      m${name}.getData(getView(),"id").subscribe(getDataRxSubscriber());
    </#if>
</#if>
    }
<#if viewIndex==1>
    @Override
    protected void lazyLoad() {
        getData();
    }
</#if>
}
