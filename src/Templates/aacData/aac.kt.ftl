<#include "../commnt/file_package_improt.ftl">


<#if viewIndex==0>
import android.app.Activity
import android.content.Intent
import com.aac.expansion.data.AacDataActivity;
import  kotlinx.android.synthetic.main.activity_${smallName}.*
<#elseif viewIndex==1>
import android.os.Bundle
import com.aac.expansion.data.AacDataFragment;
import  kotlinx.android.synthetic.main.fragment_${smallName}.*
<#else>
import android.content.Context
import android.content.Intent
import android.os.IBinder
import android.support.annotation.Nullable
import com.aac.module.ui.AacService
</#if>
import com.aac.module.pres.RequiresPresenter
import ${packageName}.R
import ${importPtah}.presenter.${name}Presenter
import ${importPtah}.bean.${beanBean};


<#include "../commnt/file_header_info.ftl">

 @RequiresPresenter(${name}Presenter::class)
 class ${name}${viewName} : AacData${viewName}<${name}Presenter, ${beanBean}>() {

     override fun getContentLayoutId():Int=  R.layout.${smallViewName}_${smallName}


     override fun setData(data: ${beanBean}) {

     }
     override fun setError(e: Throwable) {

     }
<#if viewIndex==0>
     companion object {
         fun startActivity(activity: Activity) {
             val intent = Intent(activity, ${name}Activity::class.java)
             activity.startActivity(intent)
         }
     }
<#elseif viewIndex==1>
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

 }

