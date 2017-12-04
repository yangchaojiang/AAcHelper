<#include "../commnt/file_package_improt.ftl">;

import com.aac.module.model.AacViewModel;
<#if isHttp>
<#if dataType gt 0 >
import ${importPtah}.bean.${beanBean};
import android.arch.lifecycle.LiveData;
import android.arch.lifecycle.MutableLiveData;
import android.content.Context;
import com.alibaba.fastjson.TypeReference;
import com.lzy.okgo.OkGo;
import com.lzy.okgo.model.Response;
import ${importJsonPath}.JsonCallback;
<#if dataType == 2 >
import java.util.List;
</#if>
</#if>
</#if>
<#include "../commnt/file_header_info.ftl">

public class ${name}ViewModel extends AacViewModel {
<#if isHttp>
<#if dataType==1>
  private MutableLiveData<${beanBean}> liveData = new MutableLiveData<>();

  public LiveData<${beanBean}> getData(Context context,String param) {
    OkGo.<${beanBean}>get("url").tag(context).params("param",param).
            execute(new JsonCallback<${beanBean}>("key",${beanBean}.class) {
            @Override
               public void onSuccess(Response<${beanBean}> response) {
                   liveData.setValue(response.body());
              }

             @Override
               public void onError(Response<${beanBean}> response) {
                    super.onError(response);
                    liveData.setValue(null);
                }
           });
   return liveData;
  }
<#elseif dataType==2>
private MutableLiveData<List<${beanBean}>> listData = new MutableLiveData<>();
             TypeReference typeReference=new  TypeReference<${beanBean}>(){};
    public LiveData<List<${beanBean}>> getListData(Context context, String param,int page) {
      OkGo.<List<${beanBean}>>get("url")
         .tag(context)
         .params("param",param)
         .params("page",page)
         .execute(new JsonCallback<List<${beanBean}>>("key",typeReference.getType()) {
               @Override
              public void onSuccess(Response<List<${beanBean}>> response) {
                   listData.setValue(response.body());
               }

              @Override
               public void onError(Response<List<${beanBean}>> response) {
                     super.onError(response);
                     listData.setValue(null);
                }
             })
       return listData;
    }
<#else >
</#if>
</#if>

    @Override
     protected void onCleared() {
     super.onCleared();
     }
}