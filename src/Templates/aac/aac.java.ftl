<#include "../commnt/file_package_improt.ftl">;


<#if viewIndex==0>
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.aac.module.ui.AacActivity;
<#elseif viewIndex==1>
import com.aac.module.ui.AacFragment;
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



<#include "../commnt/file_header_info.ftl">

@RequiresPresenter(${name}Presenter.class)
public class ${name}${viewName} extends Aac${viewName}<${name}Presenter> {

<#if viewIndex==0>
    public static void startActivity(Activity activity) {
        Intent intent = new Intent(activity,${name}Activity.class);
        activity.startActivity(intent);
    }
    @Override
    public int getContentLayoutId() { return R.layout.activity_${smallName};  }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    }
<#elseif viewIndex==1>
    @Override
    public int getContentLayoutId() { return R.layout.fragment_${smallName};  }

<#else>
    public static void startService(Context context) {
    Intent intent = new Intent(context,${name}Service.class);
    context.startService(intent);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
    return super.onBind(intent);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
    return super.onStartCommand(intent, flags, startId);
    }

</#if>

}
