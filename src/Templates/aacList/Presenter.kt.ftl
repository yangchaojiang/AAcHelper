<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
<#if rxType==0>
import com.aac.expansion.list.AacListPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxListAPresenter
 <#else>

 </#if>

<#elseif viewIndex==1>
<#if rxType==0>
import com.aac.expansion.list.AacListFragmentPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxListFPresenter
 <#else>

 </#if>
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}
import ${importPtah}.bean.${beanBean};


<#include "../commnt/file_header_info.ftl">

class ${name}Presenter : <#if viewIndex==0>Aac<#if rxType==1>Rx</#if>ListAPresenter<#elseif viewIndex==1>Aac<#if rxType==1>Rx</#if>ListFragmentPresenter</#if><${name}${viewName}, ${beanBean}> (){
    private lateinit var m${name}: ${name}ViewModel
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
        m${name}.getListData(view,"param")?.observe(view,dataSubscriber);
    }
<#if viewIndex==0>

<#elseif  viewIndex==1>
      override fun lazyLoad() {
         <#if rxType==0>
              m${name}.getListData(view.context,"param").observe(view,dataSubscriber);
          <#elseif rxType==1>
            m${name}.getListData(view.context,"param").subscribe(dataRxSubscriber);
          </#if>

      }

</#if>
    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}
