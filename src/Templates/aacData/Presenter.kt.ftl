<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
import com.aac.expansion.data.AacDataAPresenter
<#if rxType==0>
import com.aac.expansion.data.AacDataAPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.data.AacRxDataAPresenter
 <#else>

 </#if>
<#elseif viewIndex==1>
<#if rxType==0>
import com.aac.expansion.data.AacDataFPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.data.AacRxDataFPresenter
 <#else>

 </#if>
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}
import ${importPtah}.bean.${beanBean}

<#include "../commnt/file_header_info.ftl">


class ${name}Presenter : <#if viewIndex==0> Aac<#if rxType==1>Rx</#if>DataAPresenter <#else>Aac<#if rxType==1>Rx</#if>DataFPresenter</#if><${name}${viewName},${beanBean}> () {

    private lateinit var m${name}: ${name}ViewModel

    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }

    override fun retryData() {
         getData()
     }
     fun getData() {
       <#if rxType==0>
          m${name}.getData(view.context,"id").observe(view, dataSubscriber)
         <#elseif rxType==1>
           m${name}.getData(getView(),"id").subscribe(dataRxSubscriber);
         </#if>
     }

<#if viewIndex==1>
    override  fun lazyLoad() {
             getData()
     }
</#if>
    companion object {
        val TAG = ${name}Presenter::class.java!!.name
    }
}
