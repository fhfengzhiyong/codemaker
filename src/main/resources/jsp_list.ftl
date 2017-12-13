<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<#assign classNameLower=classNameLower(className)>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
    <div class="name">列表</div>
    <!--内容区域-->
    <div class="mrl20 ">
    	<!--搜索框-->
        <div class="chaxun mrt30">
            <div class="jias">
                <form action="" id="query-form">
                    <input type="hidden" name="pageNum" value="${usd}{pageBean.pageNum}" />
                    <#list columns as column>
                        <span>${column.remarks}：
                     <input class="search_input" type="text"name="${column.columnNameLower}"  id="${column.columnNameLower}" value="${usd}{${classNameLower}.${column.columnNameLower}}" placeholder="${column.remarks}"/></span>
                    </#list>
                    <button type="button" class="but_blue" onclick="queryBut('${usd}{remoteURL}/${classNameLower}Manage/index')">查询</button>
                </form>
            </div>
        </div>
        <!--数据区域-->
        <div class="table_con ">
           <!--表格按钮-->
            <div class="content_table_action_title">
                <button class="but_blue" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/toAdd')">增加</button>
                <button class="but_red" onclick="batchDelete()">批量删除</button>
            </div>
            <!--数据表格-->
            <table class="table-striped table-hover table-condensed">
                <tr class="tb_title">
                    <td width="3%">
                        <input type="checkbox" style="width: 15px;" class="content_table_checkbox" name="checkall" id="checkall" />
                    </td>
                    <#list columns as column>
                        <td width="10%">${usd}{fn:substring("${column.remarks}",0,6)}</td>
                    </#list>
                    <td width="10%">操作</td>
                </tr>
                <c:forEach var="item" items="${usd}{pageBean.recordList}" varStatus="status">
                    <tr class="tr_body">
                        <td width="3%">
                            <input type="checkbox" style="width: 15px;" class="content_table_checkbox" name="communistCheckBox" id="pk_${usd}{item.${pk}}" value="${usd}{item.${pk}}" />
                        </td>
                        <#list columns as column>
                            <td width="10%" >
                            		  ${usd}{item.${column.columnNameLower}}
                            </td>
                        </#list>
                        <td width="10%">
                            <div class="content_table_action_group">
                                <input class="sj_btn" type="button" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/detail?${pk}=${usd}{item.${pk}}')" value="详情" />
                                <input class="sj_btn" type="button" value="修改" onclick="menuUrl('${usd}{remoteURL}/${classNameLower}Manage/toUpdate?${pk}=${usd}{item.${pk}}')" />
                                <input class="del_btn" type="button" value="删除" onclick="delete${className}(this,'${usd}{item.${pk}}')" />
                            </div>
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
                    <jsp:param name="pageNum" value="${usd}{pageBean.pageNum}" />
                    <jsp:param name="pageCount" value="${usd}{pageBean.pageCount}" />
                    <jsp:param name="showCount" value="4" />
                </jsp:include>
            </c:if>
                <script type="text/javascript" src="${usd}{remoteURL}/static/customjs/${classNameLower}/${classNameLower}.js"></script>
        </div>
    </div>
</body>

</html>