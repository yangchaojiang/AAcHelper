<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
<#if rxType==0>
import com.aac.module.ui.AacPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.AacRxPresenter
 <#else>

 </#if>
<#elseif viewIndex==1>
<#if rxType==0>
import com.aac.module.ui.AacFragmentPresenter
<#elseif rxType==1>
import com.aac.module.rx2.presenter.AacRxFragmentPresenter
 <#else>

 </#if>

<#else >
import com.aac.module.ui.AacPresenter;
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}

<#include "../commnt/file_header_info.ftl">

<#if viewIndex==0>
   class ${name}Presenter : Aac<#if rxType==1>Rx</#if>Presenter<${name}${viewName}>() {
<#elseif viewIndex==1>
    class ${name}Presenter : AacFragmentPresenter<${name}${viewName}>() {
<#else >
    class ${name}Presenter : Aac<#if rxType==1>Rx</#if>Presenter<${name}Service>() {
</#if>

    private lateinit var m${name}: ${name}ViewModel
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }


    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}