<#include "../commnt/file_package_improt.ftl">

import com.chad.library.adapter.base.BaseMultiItemQuickAdapter
import com.chad.library.adapter.base.BaseViewHolder
import ${importPtah}.bean.${beanBean}

import java.util.ArrayList

/**
 * Same as QuickAdapter#QuickAdapter(Context,int) but with
 * some initialization data.
 *
 */
class  ${name}Adapter : BaseMultiItemQuickAdapter<${beanBean}, BaseViewHolder>(ArrayList()) {

    init {
        //addItemType();
    }

    override fun convert(helper: BaseViewHolder, item: ${beanBean}) {

    }
}
