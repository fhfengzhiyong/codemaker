<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<#assign classNameLower=classNameLower(className)>
<html>
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
		      url: ctxPath+"/${classNameLower}Manage/add",
		      beforeSubmit:showRequest, 
		      success:showResponse
		    });
		    return false;
    });
    
});
</script>
</head>
<body>
    <h2>添加</h2>
    <div style="margin:10px;0;0;10px;">
        <form action="/${classNameLower}Manage/add" id="form1" method="post">
            <table id="mytable" cellspacing="0">
                <#list columns as column>
                    <tr>
                        <td width="100px" style="text-align:right;">*${column.remarks}:</td>
                        <td>
                            <input type="text" name="${column.columnNameLower}" />
                        </td>
                    </tr>
                </#list>
            </table>
            <input style="margin-left:200px" type="submit" value="保存" class="btn_submit btn_blue" />
            <input type="image"  class="btn_return btn_gray" value="返回" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/index?useLastFilter=true')" />
        </form>
    </div>
</body>

</html>