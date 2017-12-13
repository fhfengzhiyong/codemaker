<trim prefix="where" prefixOverrides="and |or "> 
<#list columns as column>
    <#if  column.operType = "in">
    <if test="@com.bluepoint.weiqi.common.ognl.Ognl@isNotEmpty(${column.javaName})"> 
      and  ${column.fieldName} in  
	  <foreach item="item"  index="index"  collection="${column.javaName}" open="("  separator=","  close=")">
	  ${jh}{item}
	  </foreach>  
    </if>
    <#elseif column.operType = "like">
    <if test="@com.bluepoint.weiqi.common.ognl.Ognl@isNotEmpty(${column.javaName})"><![CDATA[ and ${column.fieldName} ${column.operType}  ${column.aliasJavaName} ]]> </if>
    <#else>
    <if test="@com.bluepoint.weiqi.common.ognl.Ognl@isNotEmpty(${column.javaName})"><![CDATA[ and ${column.fieldName} ${column.operType}  ${jh}{${column.javaName}} ]]> </if>
    </#if>
</#list> 
</trim>