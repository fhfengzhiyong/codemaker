<#assign classNameLower=classNameLower(className)>
function delete${className}(obj,id) {
	if(id==""){
		layer.msg("请选择一条数据");
		return false;
	}
	if (confirm("您确定删除吗？")) {
		var url = ctxPath+"/${classNameLower}Manage/delete";
		$.ajax({
			url : url,
			type : "POST",
			data : {	
				"${pk}" : id
			},
			success : function(data) {
				if (data.result) {
					alert(data.message);
					menuUrl(ctxPath+'/${classNameLower}Manage/index?useLastFilter=true');
				}
			},
			error : function(data) {
				alert("访问数据失败！请重新操作！");
			}
		});
	}
}
$(function () {
	checkbox();
});


function batchDelete() {
	var ids = findCheckIds();
	if(ids.length<1){
		layer.msg("请选择一条数据");
		return;
	}
	if (confirm("您确定删除吗？")) {
		var url = ctxPath+"/${classNameLower}Manage/batchDelete";
		$.ajax({
			url : url,
			type : "POST",
			data : {
				"ids" : ids
			},
			success : function(data) {
				if (data.result) {
					alert(data.message);
					menuUrl(ctxPath+'/${classNameLower}Manage/index?useLastFilter=true');
				}
			},
			error : function(data) {
				alert("访问数据失败！请重新操作！");
			}
		});
	}
}