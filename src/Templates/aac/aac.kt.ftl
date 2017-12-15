<#include "../commnt/file_package_improt.ftl">

<#if viewIndex==0>
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.annotation.Nullable
import com.aac.module.ui.AacActivity
import  kotlinx.android.synthetic.main.activity_${smallName}.*
<#elseif viewIndex==1>
import android.os.Bundle
import android.view.View
import com.aac.module.ui.AacFragment
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


<#include "../commnt/file_header_info.ftl">

@RequiresPresenter(${name}Presenter::class)
class ${name}${viewName} : Aac${viewName}<${name}Presenter>() {



<#if viewIndex==0>
    override fun getContentLayoutId():Int=  R.layout.${smallViewName}_${smallName}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }
    companion object {
        fun startActivity(activity: Activity) {
            val intent = Intent(activity, ${name}Activity::class.java)
            activity.startActivity(intent)
        }
    }
<#elseif viewIndex==1>

    override fun getContentLayoutId():Int=  R.layout.${smallViewName}_${smallName}

    override fun onViewCreated(view: View?, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)

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
<#else >
    override fun onBind(intent: Intent?): IBinder? {
    return super.onBind(intent)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    return super.onStartCommand(intent, flags, startId)
    }

    companion object {
    fun startService(context: Context) {
    val intent = Intent(context, ${name}Service::class.java)
    context.startService(intent)
    }
    }
</#if>
}
