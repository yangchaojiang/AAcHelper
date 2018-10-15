<#include "../commnt/file_package_improt.ftl">;

<#if viewIndex==0>
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.aac.expansion.list.AacMultiListActivity;
<#elseif viewIndex==1>
import android.view.View;
import android.support.annotation.NonNull;
import com.aac.expansion.list.AacMultiListFragment;
<#else >

</#if>
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.NonNull;
import com.aac.module.pres.RequiresPresenter;
import ${packageName}.R;
import ${importPtah}.presenter.${name}Presenter;
import ${importPtah}.bean.${beanBean};
import ${importPtah}.adapter.${name}Adapter;
<#include "../commnt/file_header_info.ftl">

@RequiresPresenter(${name}Presenter.class)
public class ${name}${viewName} extends AacMultiList${viewName}<${name}Presenter, ${beanBean}> {

    private ${name}Adapter m${name}Adapter=new ${name}Adapter();

<#if viewIndex==0>
    public static void startActivity(Activity activity) {
        Intent intent = new Intent(activity,${name}Activity.class);
        activity.startActivity(intent);
    }
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    setLoadMore(true);
    }

<#elseif viewIndex==1>
    public ${name}${viewName}  getInstance(@NonNull String param){
          ${name}${viewName}  fragment=new ${name}${viewName}();
          Bundle  mBundle=new Bundle();
          mBundle.putString("param",param);
          fragment.setArguments(mBundle);
          return fragment;
     }
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
    super.onViewCreated(view, savedInstanceState);
    //setStartLoadMore(true);
    }
</#if>
     @Override
     public int setGridSpanCount() {
     return 1;
     }

    @NonNull
    @Override
    public ${name}Adapter getMultiAdapter() {
        return   m${name}Adapter;
    }
}
