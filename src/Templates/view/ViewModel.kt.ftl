<#include "../commnt/file_package_improt.ftl">

import com.aac.module.model.AacViewModel

<#if  isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean}

<#if rxType==0>
import android.arch.lifecycle.LiveData
import com.aac.data.http.utils.httpLiveGet
<#elseif rxType==1>
import io.reactivex.Flowable
import com.aac.data.http.utils.httpRxGet
 <#else >

 </#if>
import com.aac.data.http.converter.BeanConverter
import com.lzy.okgo.model.HttpParams
import android.content.Context
    <#if dataType == 2 >
import com.alibaba.fastjson.TypeReference

    </#if>
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

class ${name}ViewModel : AacViewModel() {
<#if isHttp>
<#if dataType==1>
<#if rxType==0>
    fun  getData(context: Context, param: String): LiveData<${beanBean}> {
         val params = HttpParams()
         params.put("param", param)
         return httpLiveGet<${beanBean}>("url",
                params,
                BeanConverter("${beanKey}", ${beanBean}::class.java))

    }
  <#elseif rxType==1>
       fun getData(context: Context, param: String): Flowable<${beanBean}> {
           val params = HttpParams()
           params.put("param", param)
           return httpRxGet<${beanBean}>("url",
                  params,
                  BeanConverter("${beanKey}", ${beanBean}::class.java))
       }
  <#else >

 </#if>
<#elseif dataType==2>
      <#if rxType==0>
      fun getListData(context: Context, param: String): LiveData<List<${beanBean}>> {
          val params = HttpParams()
          params.put("param", param)
          val typeReference = object : TypeReference<List<${beanBean}>>() { }
          return  httpLiveGet<List<${beanBean}>>("url",
                  params,
                  BeanConverter("${beanKey}",typeReference.type))

      }
       <#elseif rxType==1>
           fun getListData(context: Context, param: String): Flowable<List<${beanBean}>> {
               val params = HttpParams()
               params.put("param", param)
               val typeReference = object : TypeReference<List<${beanBean}>>() { }
               return httpRxGet<List<${beanBean}>>("url",
                      params,
                      BeanConverter("${beanKey}",typeReference.type))

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