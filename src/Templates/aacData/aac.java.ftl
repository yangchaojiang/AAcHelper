<#include "../commnt/file_package_improt.ftl">;


import android.support.annotation.NonNull;
<#if viewIndex==0>
import android.app.Activity;
import android.content.Intent;
import com.aac.expansion.data.AacDataActivity;

<#elseif viewIndex==1>

import com.aac.expansion.data.AacDataFragment;
import android.support.annotation.NonNull;
import android.os.Bundle
<#else>
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;
import android.support.annotation.Nullable;
import com.aac.module.ui.AacService;
</#if>
import com.aac.module.pres.RequiresPresenter;
import ${packageName}.R;
import ${importPtah}.presenter.${name}Presenter;
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">

@RequiresPresenter(${name}Presenter.class)
public class ${name}${viewName} extends AacData${viewName}<${name}Presenter, ${beanBean}> {

<#if viewIndex==0>
    public static void startActivity(Activity activity) {
        Intent intent = new Intent(activity,${name}Activity.class);
        activity.startActivity(intent);
    }
<#elseif viewIndex==1>

    public ${name}${viewName}  getInstance(@NonNull String param){
         ${name}${viewName}  fragment=new ${name}${viewName}();
         Bundle  mBundle=new Bundle();
         mBundle.putString("param",param);
         fragment.setArguments(mBundle);
         return mBundle;
}
</#if>
   @Override
   public int getContentLayoutId() { return R.layout.${smallViewName}_${smallName};  }

    @Override
    public void setData(@NonNull ${beanBean} data) {

    }
    @Override
    public void setError(Throwable e) {

    }
}
