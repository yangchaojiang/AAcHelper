<#include "../commnt/file_package_improt.ftl">;


import com.chad.library.adapter.base.BaseMultiItemQuickAdapter;
import com.chad.library.adapter.base.BaseViewHolder;
import ${importPtah}.bean.${beanBean};

import java.util.ArrayList;

public class ${name}Adapter extends BaseMultiItemQuickAdapter<${beanBean},BaseViewHolder> {
    /**
     * Same as QuickAdapter#QuickAdapter(Context,int) but with
     * some initialization data.
     *
     */
    public ${name}Adapter() {
       super(new ArrayList<>());
       // addItemType(JokeBean.TYPE_TEXT, R.layout.item_text_joke)
       // addItemType(JokeBean.TYPE_PIC, R.layout.item_center_pic_joke)
    }

    @Override
    protected void convert(BaseViewHolder helper, ${beanBean} item) {

    }
}
