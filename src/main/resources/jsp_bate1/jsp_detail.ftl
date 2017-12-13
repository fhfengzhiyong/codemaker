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
    <h2>详细</h2>
    <div style="margin:10px;0;0;10px;">
        <div class="content">
            <table id="mytable" cellspacing="0">
                <#list columns as column>
                    <tr>
                        <td width="100px" style="text-align:right;">${column.remarks}:</td>
                        <td>
                            <input type="text" readonly="readonly" value="${usd}{${classNameLower}.${column.columnNameLower}}" />
                        </td>
                    </tr>
                </#list>
            </table>
        </div>
        <div style="width:70%; ">
            <p style="margin-top:40px;">
             <a href="#" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/index?useLastFilter=true')" class="btn_return btn_gray">返回</a>
            </p>
        </div>
        </div>
</body>

</html>
