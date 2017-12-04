<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
import com.aac.module.ui.AacPresenter
<#elseif viewIndex==1>
import com.aac.module.ui.AacFragmentPresenter
<#else >
import com.aac.module.ui.AacPresenter
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}

<#include "../commnt/file_header_info.ftl">

<#if viewIndex==0>
   class ${name}Presenter : AacPresenter<${name}${viewName}>() {
<#elseif viewIndex==1>
    class ${name}Presenter : AacFragmentPresenter<${name}${viewName}>() {
<#else >
    class ${name}Presenter : AacPresenter<${name}Service>() {
</#if>

    private var m${name}: ${name}ViewModel? = null
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }

    override fun onCreateView() {
        super.onCreateView()
    }

    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}