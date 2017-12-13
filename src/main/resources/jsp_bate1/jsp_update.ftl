<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<#assign classNameLower=classNameLower(className)>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(function(){
	 $(".fancybox").click(function(){
		 //top.showWindow($(this).attr("href"));
		// top.$.fancybox('<img src="http://farm5.static.flickr.com/4058/4252054277_f0fa91e026.jpg" height="333" width="500">');
	 })
})
</script>

<!--表单验证开始 -->
<script>
function showResponse(data,statusText) {
	if(data.result){
		alert(data.message);
			menuUrl(ctxPath+'/${classNameLower}ModelManage/index?useLastFilter=true');
	}else{
		alert("操作失败:"+data.message);
	}
	return true;
}

function showRequest(formData,jqForm,options){
	  return $("#form1").valid();
}

$().ready(function(){
	var validate=$("#form1").validate({
		rules:{
		    <#list columns as column>
			${column.columnNameLower}:{required:true},
			</#list>
		},
		messages:{
		   <#list columns as column>
			${column.columnNameLower}:{required:jQuery.format("${column.remarks}")},
		   </#list>
		},
		success: function(label) {
		    label.text("");			 
		}
	});
    
    $('#form1').submit(function(){
		    $(this).ajaxSubmit({
		      type:"POST",
		      url: ctxPath+"/${classNameLower}Manage/update",
		      beforeSubmit:showRequest, 
		      success:showResponse
		    });
		    return false;
    });
    
});
</script>

</head>
<body>
<h2>修改</h2>
    <div style="margin:10px;0;0;10px;">
        <form action="/${classNameLower}Manage/update" id="form1" method="post">
            <table id="mytable" cellspacing="0">
                <#list columns as column>
                    <#if column_index==0>
                        <tr>
                            <td width="200px" class="spec td1_top" align="right">${column.remarks}</td>
                            <td class="td1_top">
                                <input name="${column.columnNameLower}" value="${usd}{${classNameLower}.${column.columnNameLower}}" />
                            </td>
                        </tr>
                      <#else>
                            <tr>
                                <td width="200px" class="spec" align="right">${column.remarks}</td>
                                <td>
                                    <#if column.simpleJavaType=='Date'>
                                        <input name="${column.columnNameLower}" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" value='<fmt:formatDate value="${usd}{deviceModel.createDate}" pattern="yyyy-MM-dd HH:mm:ss "/>'/>
                                    <#else>
                                            <#if column.simpleJavaType=='int'>
                                            <input name="${column.columnNameLower}" value="${usd}{item.${column.columnNameLower}}" />
                                                <select name="${column.columnNameLower}">
                                                    <option value="-1">选择</option>
                                                </select>
                                            <#else>
                                                    <input name="${column.columnNameLower}" value="${usd}{${classNameLower}.${column.columnNameLower}}" />
                                            </#if>
                                    </#if>
                                </td>
                            </tr>
                    </#if>
                </#list>
            </table>
            <input style="margin-left:200px" type="submit" value="保存"class="btn_submit btn_blue"  />
            <input style="margin-left:30px" type="button" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/index?useLastFilter=true')" value="取消" class="btn_return btn_gray"/>
        </form>
    </div>
</body>
</html>