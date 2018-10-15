<#include "../commnt/file_package_improt.ftl">

import java.io.Serializable
<#if dataType==3>
import com.chad.library.adapter.base.entity.MultiItemEntity;
</#if>
<#include "../commnt/file_header_info.ftl">

class ${beanBean} :Serializable<#if dataType==3>,MultiItemEntity</#if> {
var test:String?=null


<#if dataType==3>
     override fun getItemType(): Int = 0
</#if>
}