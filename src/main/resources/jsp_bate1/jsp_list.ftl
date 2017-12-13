<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
    <h2>管理</h2>
    <#assign classNameLower=classNameLower(className)>
        <form action="" id="query-form">
            <input type="hidden" name="pageNum" value="${usd}{pageBean.pageNum}" />
            <div class="search" style="padding: 10px 0 10px 0;">
                <#list columns as column>
                    <div style="width:18%; float:left;">
                        <span>${column.remarks}：
               			 <input style=" border-bottom: 2px solid #f3f3f3; height: 25px;" type="text" size="15" name="${column.columnNameLower}"  id="${column.columnNameLower}" value="${usd}{${classNameLower}.${column.columnNameLower}}" placeholder="${column.remarks}"/></span>
                    </div>
                </#list>
                <div style="width:5%; float:left; text-align:left; padding-right:40px; ">
                    <input id="query-select" onclick="queryBut('${usd}{remoteURL}/${classNameLower}Manage/index')" style="width:50px; height:30px;" type="button" value="查询" />
                </div>
                <div style="width:5%; float:left; text-align:left; padding-right:40px; ">
                    <input id="query-add" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/toAdd')" style="width:50px; height:30px;" type="button" value="增加" />
                </div>
            </div>
        </form>
        <table id="mytable" border="1" bordercolor="#d2d8db" width="95%" align="center" style="text-align:center; font-size:13px;">
            <tr>
                <#list columns as column>
                    <th width="10%" bgcolor="#e5e5e5">${column.remarks}</th>
                </#list>
                <th width="10%" bgcolor="#e5e5e5">操作</th>
            </tr>
            <c:forEach var="item" items="${usd}{pageBean.recordList}" varStatus="status">
                <tr>
                    <#list columns as column>
                        <td>${usd}{item.${column.columnNameLower}}</td>
                    </#list>
                    <td>
                        <input style="width:40px; height:28px; " type="button" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/detail?${pk}=${usd}{item.${pk}}')" value="查看" />
                        <input class="addimg" style="width:40px; height:28px; " type="button" value="修改" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/toUpdate?${pk}=${usd}{item.${pk}}')" />
                        <input class="addimg" style="width:40px; height:28px; " type="button" value="删除" onclick="delete${className}(this,'${usd}{item.${pk}}')" />
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${usd}{pageBean.pageCount==0}">
                <jsp:include page="/common/noDate.jsp">
                    <jsp:param name="columns" value="${size}" />
                </jsp:include>
            </c:if>
        </table>
        <c:if test="${usd}{pageBean.pageCount!=0}">
            <jsp:include page="/common/pager.jsp">
                <jsp:param name="actionUrl" value="${usd}{remoteURL}/${classNameLower}Manage/index" />
                <jsp:param name="totalCount" value="${usd}{pageBean.recordCount}" />
                <jsp:param name="pageSize" value="${usd}{pageBean.pageSize}" />
                <jsp:param name="pageNum" value="${usd}{pageNum}" />
                <jsp:param name="pageCount" value="${usd}{pageBean.pageCount}" />
                <jsp:param name="showCount" value="4" />
            </jsp:include>
        </c:if>
        <%@include file="../../common/foot.jsp" %>
        <script type="text/javascript" src="${usd}{remoteURL}/static/customjs/${classNameLower}/${classNameLower}.js"></script>
        <script src="${usd}{remoteURL}/static/js/table.js" type="text/javascript"></script>
</body>

</html>
