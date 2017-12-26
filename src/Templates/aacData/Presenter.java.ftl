<#include "../commnt/file_package_improt.ftl">;



<#if viewIndex==0>
import com.aac.expansion.data.AacDataAPresenter;
<#elseif viewIndex==1>
import com.aac.expansion.data.AacDataFPresenter;
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">


public class ${name}Presenter extends <#if viewIndex==0> AacDataAPresenter <#else >AacDataFPresenter</#if><${name}${viewName},${beanBean}> {

  public static final String TAG = ${name}Presenter.class.getName();
  private ${name}ViewModel m${name};
  @Override
  public void onCreate() {
   super.onCreate();
    m${name} = getViewModel(${name}ViewModel.class);
  }
   @Override

     @Override
    public void retryData() {
         getData();
    }

    public void getData() {
     m${name}.getData(getView(),"id").observe(getView(), getDataSubscriber());
    }
<#if viewIndex==1>
    @Override
    protected void lazyLoad() {
        getData();
    }
</#if>
}
