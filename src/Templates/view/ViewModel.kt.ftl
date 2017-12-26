<#include "../commnt/file_package_improt.ftl">

import com.aac.module.model.AacViewModel

<#if  isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean}
import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.content.Context
import com.lzy.okgo.OkGo
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

class ${name}ViewModel : AacViewModel() {
<#if isHttp>
<#if dataType==1>
    private var liveData : LiveData<${beanBean}>?=null
    fun getData(context: Context, param: String): LiveData<${beanBean}> {
       if (listData == null) {
           listData = OkGo.get<${beanBean}>>(url)
           .tag(context)
           .params("param",param)
           .converter(BeanConverter("key", ${beanBean}::class.java))
           .adapt(LiveDataAdapter())
       }
      return listData
    }
<#elseif dataType==2>
     private var listData : LiveData<List<${beanBean}>>?=null
     fun getListData(context: Context, param: String, page: Int): LiveData<List<${beanBean}>>? {
        if (listData == null) {
            listData = OkGo.get<List<${beanBean}>>(url)
            .tag(context)
            .params("param",param)
            .converter(BeanListConverters("key", ${beanBean}::class.java))
            .adapt(LiveDataAdapter())
          }
      return listData
     }
<#else >

</#if>
</#if>
    override fun onCleared() {
        super.onCleared()
    }

}