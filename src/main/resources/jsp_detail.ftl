<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <#assign classNameLower=classNameLower(className)>
</head>
<body>
    <div class="name">详情</div>
    <div class="mrl20 ">
        <div class="chaxun3 mrt30">
            <#list columns as column>
                <div class="jias clearfix" style="margin-top: 15px;">
                    <div class="namee">${column.remarks}</div>
                    <input type="text" class="add_jsp_input" readonly="readonly" value="${usd}{${classNameLower}.${column.columnNameLower}}" />
                </div>
            </#list>
            <div style="width: 300px; margin: 25px auto 50px 20px; padding-bottom: 100px;">
                <input class="but_blue" style="padding: 8px 25px;" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/index?useLastFilter=true')" type="button" value="返回" />
            </div>
        </div>
    </div>
</body>

</html>
