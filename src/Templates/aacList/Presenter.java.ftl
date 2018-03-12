<#include "../commnt/file_package_improt.ftl">;

<#if viewIndex==0>
<#if rxType==0>
import com.aac.expansion.list.AacListPresenter;
<#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxListAPresenter
 <#else>

 </#if>
<#elseif viewIndex==1>
<#if rxType==0>
import com.aac.expansion.list.AacListFragmentPresenter;
<#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxListFPresenter
 <#else>

 </#if>
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">

public class ${name}Presenter extends <#if viewIndex==0>Aac<#if rxType==1>Rx</#if>ListAPresenter<#elseif viewIndex==1>Aac<#if rxType==1>Rx</#if>ListFragmentPresenter</#if><${name}${viewName}, ${beanBean}> {
    public static final String TAG = ${name}Presenter.class.getName();
    private ${name}ViewModel m${name};
    @Override
    public void onCreate() {
        super.onCreate();
        m${name} = getViewModel(${name}ViewModel.class);
    }

     @Override
      public void setLoadListData(int pager) {
              m${name}.getListData(getView(),"id",pager).observe(getView(),getDataSubscriber());
     }
<#if viewIndex==1>


     @Override
     protected void lazyLoad() {
     //m$name.getData().observe(getView(),getDataSubscriber());
      <#if rxType==0>
                 m${name}.getListData(getView().getContext(),"param").observe(getView(),getDataSubscriber());
                  <#elseif rxType==1>
                   m${name}.getListData(getView().getContext(),"param").subscribe(getDataRxSubscriber());
            </#if>
     }

}
</#if>
}
