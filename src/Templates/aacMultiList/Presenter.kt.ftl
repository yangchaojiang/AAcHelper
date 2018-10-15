<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
    <#if rxType==0>
import com.aac.expansion.list.AacMultiListAPresenter
    <#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxMultiListAPresenter
    <#else>

    </#if>

<#elseif viewIndex==1>
    <#if rxType==0>
import com.aac.expansion.list.AacMultiListFPresenter
    <#elseif rxType==1>
import com.aac.module.rx2.presenter.list.AacRxMultiListFPresenter
    <#else>

    </#if>
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}
import ${importPtah}.bean.${beanBean};


<#include "../commnt/file_header_info.ftl">

class ${name}Presenter : <#if viewIndex==0>Aac<#if rxType==1>Rx</#if>MultiListAPresenter<#elseif viewIndex==1>Aac<#if rxType==1>Rx</#if>MultiListFPresenter</#if><${name}${viewName}, ${beanBean}> (){
    private lateinit var m${name}: ${name}ViewModel
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
     }

<#if  viewIndex==1>  override </#if> fun lazyLoad() {
       <#if  isHttp>
        <#if rxType==0>
              m${name}.getListData(view.context,"param").observe(view,dataSubscriber);
        <#elseif rxType==1>
            m${name}.getListData(view.context,"param").subscribe(dataRxSubscriber);
        </#if>
       </#if>
      }
    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}
