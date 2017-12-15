<#include "../commnt/file_package_improt.ftl">;

<#if viewIndex==0>
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.aac.expansion.list.AacListActivity;
<#elseif viewIndex==1>
import android.view.View;
import com.aac.expansion.list.AacListFragment;
<#else >

</#if>
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.chad.library.adapter.base.BaseViewHolder;
import com.aac.module.pres.RequiresPresenter;
import ${packageName}.R;
import ${importPtah}.presenter.${name}Presenter;
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">

@RequiresPresenter(${name}Presenter.class)
public class ${name}${viewName} extends AacList${viewName}<${name}Presenter, ${beanBean}> {

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
    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
    super.onViewCreated(view, savedInstanceState);
    //setStartLoadMore(true);
    }

    public ${name}${viewName}  getInstance(@NonNUll String param){
          ${name}${viewName}  fragment=new ${name}${viewName}();
          Bundle  mBundle=new Bundle();
          mBundle.putString("param",param);
          fragment.setArguments(mBundle);
          return mBundle;
}
</#if>
     @Override
     public int setGridSpanCount() {
     return 3;
     }

    @Override
     public int getItemLayout() {
     return android.R.layout.simple_list_item_2;
    }
     @Override
    public void convertViewHolder(BaseViewHolder helper, ${beanBean} item) {
          //helper.setText(android.R.id.text1, item);
         // helper.setText(android.R.id.text2, item);
     }
}
