<#include "../commnt/file_package_improt.ftl">

<#if viewIndex==0>
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import com.aac.expansion.list.AacMultiListActivity

<#elseif viewIndex==1>
import android.os.Bundle
import android.view.View
import com.aac.expansion.list.AacMultiListFragment
</#if>
import com.chad.library.adapter.base.BaseViewHolder
import com.aac.module.pres.RequiresPresenter
import com.chad.library.adapter.base.BaseMultiItemQuickAdapter
import ${packageName}.R
import ${importPtah}.presenter.${name}Presenter
import ${importPtah}.bean.${beanBean}
import ${importPtah}.adapter.${name}Adapter

<#include "../commnt/file_header_info.ftl">

 @RequiresPresenter(${name}Presenter::class)
 class ${name}${viewName} : AacMultiList${viewName}<${name}Presenter, ${beanBean}>() {

 private val m${name}Adapter : ${name}Adapter = ${name}Adapter()

   override fun getMultiAdapter(): BaseMultiItemQuickAdapter<${beanBean},BaseViewHolder> = m${name}Adapter

<#if viewIndex==0>
     override fun onCreate(savedInstanceState: Bundle?) {
         super.onCreate(savedInstanceState)
        // setLoadMore(true)
     }
<#elseif viewIndex==1>
     override fun setOpenLazyLoad(): Boolean = true

     override fun setGridSpanCount(): Int = 1

     override fun onViewCreated(view: View?, savedInstanceState: Bundle?) {
       super.onViewCreated(view, savedInstanceState)
       //setStartLoadMore(true);
      }

    companion object {
         fun getInstance(param: String): ${name}${viewName} {
             val fragment = ${name}${viewName}()
             val bundle = Bundle()
             bundle.putString("param", param)
             fragment.arguments = bundle
             return fragment
         }
    }
</#if>

<#if viewIndex==0>
     companion object {
         fun startActivity(activity: Activity) {
             val intent = Intent(activity, ${name}Activity::class.java)
             activity.startActivity(intent)
         }
     }
</#if>
 }

