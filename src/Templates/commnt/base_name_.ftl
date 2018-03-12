<#if viewIndex==0><#if rxType==1>AacPresenter<#elseif rxType==2>AacRxPresenter<#else></#if>
<#elseif viewIndex==1><#if rxType==1>AacFragmentPresenter<#elseif rxType==2>AacFragmentPresenter <#else>
</#if>
</#if>