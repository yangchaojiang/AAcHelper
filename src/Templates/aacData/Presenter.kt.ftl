<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
import com.aac.expansion.data.AacDataAPresenter
<#elseif viewIndex==1>
import com.aac.expansion.data.AacDataFPresenter
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}
import ${importPtah}.bean.${beanBean}

<#include "../commnt/file_header_info.ftl">


class ${name}Presenter : <#if viewIndex==0> AacDataAPresenter <#else>AacDataFPresenter</#if><${name}${viewName},${beanBean}> () {

    private var m${name}: ${name}ViewModel? = null

    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }

    override fun onCreateView() {
        super.onCreateView()
    }
    override fun retryData() {
         getData()
     }
     fun getData() {
       m${name}.getData(getView(),"id").observe(getView(), getDataSubscriber())

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
