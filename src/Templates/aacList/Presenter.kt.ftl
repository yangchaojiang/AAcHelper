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
    private var m${name}: ${name}ViewModel? = null
    public override fun onCreate() {
        super.onCreate()
        m${name} = getViewModel(${name}ViewModel::class.java)
    }

    override fun setLoadData(pager: Int) {
             m${name}?.getListData(view.context,"id",pager)?.observe(view,dataSubscriber);
    }
<#if viewIndex==1>
     override fun onCreateView() {
      super.onCreateView()
      }

      override fun lazyLoad() {
     //m$name.getData().observe(getView(),getDataSubscriber());
    }
</#if>
    companion object {
        val TAG = ${name}Presenter::class.java.name
    }
}
