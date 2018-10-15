<#include "../commnt/file_package_improt.ftl">;

<#if viewIndex==0>
    <#if rxType==0>
import com.aac.expansion.list.AacMultiListAPresenter;
    <#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxMultiListAPresenter;
    <#else>

    </#if>
<#elseif viewIndex==1>
    <#if rxType==0>
import com.aac.expansion.list.AacMultiListFPresenter;
    <#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxMultiListFPresenter;
    <#else>

    </#if>
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">

public class ${name}Presenter extends <#if viewIndex==0>Aac<#if rxType==1>Rx</#if>MultiListAPresenter<#elseif viewIndex==1>Aac<#if rxType==1>Rx</#if>MultiListFPresenter</#if><${name}${viewName}, ${beanBean}> {
    public static final String TAG = ${name}Presenter.class.getName();
    private ${name}ViewModel m${name};
    @Override
    public void onCreate() {
        super.onCreate();
        m${name} = getViewModel(${name}ViewModel.class);
    }

     @Override
      public void setLoadData(int pager) {
<#if  isHttp>
    <#if viewIndex==1>
        <#if rxType==0>
         m${name}.getListData(getView().getContext(),"id").observe(getView(),getDataSubscriber());
        <#elseif rxType==1>
        m${name}.getListData(getView().getContext(),"id").subscribe(getDataRxSubscriber());
        </#if>
    <#elseif viewIndex==0>

        <#if rxType==0>
         m${name}.getListData(getView(),"id").observe(getView(),getDataSubscriber());
        <#elseif rxType==1>
        m${name}.getListData(getView(),"id").subscribe(getDataRxSubscriber());
        </#if>
    </#if>
</#if>
     }
<#if viewIndex==1>
     @Override
     protected void lazyLoad() {
         setLoadData(1);
     }
</#if>
}
