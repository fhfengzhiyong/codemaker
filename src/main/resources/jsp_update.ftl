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
    <div class="name">修改</div>
    <div class="mrl20 ">
        <div class="chaxun3 mrt30">
            <form action="/${classNameLower}Manage/update" id="form1" method="post">
                <#list columns as column>
                    <div class="jias clearfix" style="margin-top: 15px;">
                        <div class="namee">*${column.remarks}</div>
                        <#if column.simpleJavaType=='Date'>
                            <input name="${column.columnNameLower}" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" value='<fmt:formatDate value="${usd}{deviceModel.createDate}"  pattern="yyyy-MM-dd HH:mm:ss "/>' />
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
                    </div>
                </#list>
                <div style="width: 300px; margin: 25px auto 50px 20px; padding-bottom: 100px;">
                    <input class="but_blue" style="padding: 8px 25px;"  type="submit"  value="提交" />
                    <input class="but_red" style="padding: 8px 25px;" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/index?useLastFilter=true')" type="button" value="取消" />
                </div>
            </form>
        </div>
    </div>
</body>

</html>