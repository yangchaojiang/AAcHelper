<#include "../commnt/file_package_improt.ftl">;


<#if viewIndex==0>
import com.aac.module.ui.AacPresenter;
<#elseif viewIndex==1>
import com.aac.module.ui.AacFragmentPresenter;
<#else >
import com.aac.module.ui.AacPresenter;
</#if>
import ${importPtah}.model.${name}ViewModel;
import ${importPtah}.ui.${name}${viewName};

<#include "../commnt/file_header_info.ftl">
<#if viewIndex==1>
public class ${name}Presenter extends AacFragmentPresenter<${name}Fragment> {
<#else >
public class ${name}Presenter extends AacPresenter<${name}${viewName}> {
</#if>

    public static final String TAG = ${name}Presenter.class.getName();
    private ${name}ViewModel m${name};
    @Override
    public void onCreate() {
        super.onCreate();
        m${name} = getViewModel(${name}ViewModel.class);
    }


}
