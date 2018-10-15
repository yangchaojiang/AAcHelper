<#include "../commnt/file_package_improt.ftl">;

import com.aac.module.model.AacViewModel;
<#if isHttp>
<#if dataType gt 0 >
import com.aac.data.http.converter.BeanConverter;
import ${importPtah}.bean.${beanBean};
import com.aac.data.http.utils.AacUtils;
import com.lzy.okgo.model.HttpParams;
<#if rxType==0>
import android.arch.lifecycle.LiveData;
<#elseif rxType==1>
import io.reactivex.Flowable;
 <#else >

 </#if>
import android.content.Context;
<#if dataType == 2 >
import com.alibaba.fastjson.TypeReference;
import java.util.List;
</#if>
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

public class ${name}ViewModel extends AacViewModel {
<#if isHttp>
   <#if dataType=1>
        <#if rxType==0>
  public LiveData<${beanBean}> getData(Context context,String param) {
     HttpParams params = new HttpParams();
     params.put("param",param);
    return AacUtils.httpLiveGet("url"
           ,params
           ,new BeanConverter<>("${beanKey}",${beanBean}.class));

     }

    <#elseif rxType==1>

    public Flowable<${beanBean}> getData(Context context, String param) {
           HttpParams params = new HttpParams();
           params.put("param",param);
           return AacUtils.httpRxGet("url"
                  ,params
                  ,new BeanConverter<>("${beanKey}",${beanBean}.class));
    }
       <#else >
      </#if>
   <#elseif dataType>=2>
       <#if rxType==0>
     public LiveData<List<${beanBean}>> getListData(Context context, String param) {
             HttpParams params = new HttpParams();
             params.put("param",param);
             TypeReference typeReference = new TypeReference<List<${beanBean}>>(){};
             return  AacUtils.httpLiveGet("url"
                     ,params
                     ,new BeanConverter<>("${beanKey}", typeReference.getType()));
       }
      <#elseif rxType==1>

       public Flowable<List<${beanBean}>> getListData(Context context, String param) {
              HttpParams params = new HttpParams();
              params.put("param",param);
              TypeReference typeReference = new TypeReference<List<${beanBean}>>(){};
              return  AacUtils.httpRxGet("url"
                      ,params
                      ,new BeanConverter<>("${beanKey}", typeReference.getType()));
    }

      <#else >

      </#if>
<#else >
</#if>
</#if>
    @Override
     protected void onCleared() {
     super.onCleared();
     }
}