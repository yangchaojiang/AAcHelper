<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
import com.aac.expansion.list.AacListPresenter
<#elseif viewIndex==1>
import com.aac.expansion.list.AacListFragmentPresenter
</#if>
import ${importPtah}.model.${name}ViewModel
import ${importPtah}.ui.${name}${viewName}
import ${importPtah}.bean.${beanBean};


<#include "../commnt/file_header_info.ftl">

class ${name}Presenter : <#if viewIndex==0>AacListPresenter<#elseif viewIndex==1>AacListFragmentPresenter</#if><${name}${viewName}, ${beanBean}> (){
    private lateinit var m${name}: ${name}ViewModel
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }
<#if viewIndex==0>
    override fun setLoadData(pager: Int) {
             m${name}.getListData(view,"param",pager)?.observe(view,dataSubscriber);
    }
<#elseif  viewIndex==1>


      override fun lazyLoad() {

      }
     override fun setLoadData(pager: Int) {
           m${name}.getListData(view.context,"param",pager).observe(view,dataSubscriber);
      }
</#if>
    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}
