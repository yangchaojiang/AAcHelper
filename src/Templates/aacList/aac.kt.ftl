<#include "../commnt/file_package_improt.ftl">

<#if viewIndex==0>
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import com.aac.expansion.list.AacListActivity
<#elseif viewIndex==1>
import android.os.Bundle
import android.view.View
import android.support.annotation.NonNull
import com.aac.expansion.list.AacListFragment
</#if>
import com.chad.library.adapter.base.BaseViewHolder
import com.aac.module.pres.RequiresPresenter
import ${packageName}.R
import ${importPtah}.presenter.${name}Presenter
import ${importPtah}.bean.${beanBean}
import  kotlinx.android.synthetic.main.${smallViewName}_${smallName}.*

<#include "../commnt/file_header_info.ftl">

 @RequiresPresenter(${name}Presenter::class)
 class ${name}${viewName} : AacList${viewName}<${name}Presenter, ${beanBean}>() {

    override fun getItemLayout(): Int=android.R.layout.simple_list_item_2
<#if viewIndex==0>
     override fun onCreate(savedInstanceState: Bundle?) {
         super.onCreate(savedInstanceState)
        // setLoadMore(true)
     }
<#elseif viewIndex==1>
     override fun setOpenLazyLoad(): Boolean = true

     override fun setGridSpanCount(): Int = 3

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
     override fun convertViewHolder(helper: BaseViewHolder, item: ${beanBean}) {
         // helper.setText(android.R.id.text1, item)
         //helper.setText(android.R.id.text2, item)
     }

<#if viewIndex==0>
     companion object {
         fun startActivity(activity: Activity) {
             val intent = Intent(activity, ${name}Activity::class.java)
             activity.startActivity(intent)
         }
     }
</#if>
 }

