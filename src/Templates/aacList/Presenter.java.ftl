<#include "../commnt/file_package_improt.ftl">;

<#if viewIndex==0>
import com.aac.expansion.list.AacListPresenter;
<#elseif viewIndex==1>
import com.aac.expansion.list.AacListFragmentPresenter;
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};
import ${importPtah}.bean.${beanBean};

<#include "../commnt/file_header_info.ftl">

public class ${name}Presenter extends <#if viewIndex==0>AacListPresenter<#elseif viewIndex==1>AacListFragmentPresenter</#if><${name}${viewName}, ${beanBean}> {
    public static final String TAG = ${name}Presenter.class.getName();
    private ${name}ViewModel m${name};
    @Override
    public void onCreate() {
        super.onCreate();
        m${name} = getViewModel(${name}ViewModel.class);
    }

     @Override
      public void setLoadData(int pager) {
              m${name}.getListData(getView(),"id",pager).observe(getView(),getDataSubscriber());
     }
<#if viewIndex==1>

      @Override
      protected void onCreateView() {
      super.onCreateView();
      }
     @Override
     protected void lazyLoad() {
     //m$name.getData().observe(getView(),getDataSubscriber());
     }

}
</#if>
}
