<#include "../commnt/file_package_improt.ftl">;

import com.aac.module.model.AacViewModel;
<#if isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean};
<#if rxType==0>
import android.arch.lifecycle.LiveData;
<#elseif rxType==1>
import io.reactivex.Flowable;
 <#else >

 </#if>
import android.content.Context;
import com.alibaba.fastjson.TypeReference;
import com.lzy.okgo.OkGo;
<#if dataType == 2 >
import java.util.List;
</#if>
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

public class ${name}ViewModel extends AacViewModel {
<#if isHttp>
<#if dataType==1>
<#if rxType==0>
  public LiveData<${beanBean}> getData(Context context,String param) {
    return  OkGo.<${beanBean}>get("url")
             .tag(context)
             .params("param",param)
             .converter(new BeanConverter<>("${beanKey}",${beanBean}.class))
             .adapt(new LiveDataAdapter<>());
  }
  </#if>
<#elseif rxType==1>

    public LiveData<List<${beanBean}>> getListData(Context context, String param) {
             TypeReference typeReference = new TypeReference<List<${beanBean}>>(){};
             return OkGo.<List<${beanBean}>>
              get("url")
             .params("param",param)
             .tag(context)
             .converter(new BeanConverter<>("${beanKey}", typeReference.getType()))
             .adapt(new LiveDataAdapter<>());
    }
<#else >
</#if>
</#if>

    @Override
     protected void onCleared() {
     super.onCleared();
     }
}