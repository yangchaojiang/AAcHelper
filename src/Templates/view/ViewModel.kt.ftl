<#include "../commnt/file_package_improt.ftl">

import com.aac.module.model.AacViewModel

<#if  isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean}
<#if rxType==1>
import android.arch.lifecycle.LiveData
<#elseif rxType==2>
import io.reactivex.Flowable
 <#else >

 </#if>

import android.content.Context
import com.lzy.okgo.OkGo
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

class ${name}ViewModel : AacViewModel() {
<#if isHttp>
<#if dataType==1>
<#if rxType==0>
    fun getData(context: Context, param: String): LiveData<${beanBean}> {
           return OkGo.get<${beanBean}>>(url)
           .tag(context)
           .params("param",param)
           .converter(BeanConverter("${beanKey}", ${beanBean}::class.java))
           .adapt(LiveDataAdapter())
    }
  <#elseif rxType==1>
       fun getData(context: Context, bbsId: String): Flowable<${beanBean}> {
           return OkGo.get<${beanBean}>(HttpNames.bbsInfo)
                   .tag(context)
                   .params("bbsId", bbsId)
                   .converter(BeanConverter("${beanKey}", ${beanBean}::class.java))
                   .adapt(RxDataAdapter<${beanBean}>())
                   .compose(defaultSchedulers())
  <#else >

 </#if>
<#elseif dataType==2>
<#if rxType==0>
      fun getListData(context: Context, param: String): LiveData<List<${beanBean}>> {
           return OkGo.get<List<${beanBean}>>(url)
            .tag(context)
            .params("param",param)
            .converter(BeanListConverters("${beanKey}", ${beanBean}::class.java))
            .adapt(LiveDataAdapter())
      }
       <#elseif rxType==1>
           fun getListData(context: Context, param: String): Flowable<List<${beanBean}>> {
                  return OkGo.get<List<${beanBean}>>(url)
                   .tag(context)
                   .params("param",param)
                   .converter(BeanListConverters("${beanKey}", ${beanBean}::class.java))
                   .adapt(RxDataAdapter())
                   .compose(defaultSchedulers())
            }
        <#else >

        </#if>
<#else >

</#if>
</#if>
    override fun onCleared() {
        super.onCleared()
    }

}