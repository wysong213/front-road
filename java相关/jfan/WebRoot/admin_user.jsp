<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@page import="com.bookstore.service.*"%>
<%@page import="com.bookstore.po.*"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat" %>

<%
String adminstatus = (String)session.getAttribute("adminstatus");
if(adminstatus == null||adminstatus.equals(""))
{
	response.sendRedirect("admin_login.jsp");
	return;
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String columnid = request.getParameter("columnid");
if(columnid==""||columnid==null){columnid="1";}
int pageNo= 1;
try{
pageNo=Integer.parseInt(request.getParameter("pageNo"));
}catch(Exception e){
}

int pageSize = 20;
UserService service = new UserService();
int totalCount = service.getUserList().size();
List results = service.getUserListByPage(pageSize,pageNo);
int totalPage = totalCount/pageSize+(totalCount%pageSize==0?0:1);
//OrderService orser = new OrderService();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>在线防伪认证系统后台管理系统</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="control.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	font-size: 10px;
	background:#DBDFE8 url(images/mainback.jpg) repeat-x fixed;
}
.STYLE1 {font-size: 12px}
-->
</style></head>



<body >
<table width="700" border="0" cellpadding="0" cellspacing="0" class="CContent"  >
	<tr>
		<td class="CTitle" >账户管理</td>
	</tr>
	<tr>
		<td class="SubMenu" ><a href="admin_user.jsp?columnid=1" >账户列表</a><span class="STYLE1">|</span></td>
	</tr>
	<tr >
		<td class="CPanel"  >

		
		<% if(columnid=="1"||columnid.equals("1"))
		{
		%>
		
		<table width="675" cellpadding="2" cellspacing="1" class="TablePanel" >
			<tr>
	          <td  class="TDHead" colspan="6"   >
			  账户列表			  </td>
			</tr>
			<tr>
	          <td   colspan="6" class="STYLE1"   >			  </td>
			</tr>
			<tr>
				<td width="100" align="center" class="TDHead">编号</td>
				<td width="130" align="center" class="TDHead">用户名</td>
				<td width="130" align="center" class="TDHead">密码</td>
				<td width="125" align="center" class="TDHead">最后登录时间</td>
			    <td width="90" align="center" class="TDHead">订单数</td>
			    <td width="100" align="center" class="TDHead">操作</td>
			</tr>
			<%for(int i=0;i<results.size();i++){
				User user  =(User)results.get(i);
			%>
			
			<tr>
			  <td align="center" class="STYLE1"><%=user.getId()%></td>
				<td class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;<%=user.getUsername()%></td>
				<td class="STYLE1">&nbsp;&nbsp;<%=user.getPassword()%></td>
				<td align="center" class="STYLE1"><%=user.getLastlogin() %></td>
			    <td align="center" class="STYLE1"></td>
			    <td align="center" class="STYLE1"><a href="#" onClick="confirmdelete(<%=user.getId() %>)">删除</a></td>
			</tr>
			<%}%>
		<tr>
	<td colspan="6" align="right">
	<%if(pageNo>1){%>
	<a href="admin_user.jsp?columnid=<%=columnid%>&pageNo=1">第一页</a>
	<a href="admin_user.jsp?columnid=<%=columnid%>&pageNo=<%=pageNo-1%>">上一页</a>
	<%}%>
	<%if(pageNo<totalPage){%>
	<a href="admin_user.jsp?columnid=<%=columnid%>&pageNo=<%=pageNo+1%>">下一页</a>
	<a href="admin_user.jsp?columnid=<%=columnid%>&pageNo=<%=pageNo+1%>">最后页</a>
	<%}%>	</td>
	</tr>
		</table>
		<%}
		if(columnid=="2"||columnid.equals("2"))
		{
		Admin admins=null;
     	admins=(Admin)session.getAttribute("admin");
		 %>
		 
		 <table width="500" cellpadding="2" cellspacing="1" class="TablePanel" >
			<tr>
	          <td class="TDHead" colspan="2" >修改密码</td>
			</tr>
			 <html:form action="adminAction.do" > <html:hidden property="method" value="modify" /> 
			<tr>
			  <td width="91" align="right"  class="STYLE1">用户名：</td>
			  <td width="396" class="STYLE1"><html:text property="name" size="25" readonly="true" value="<%=admins.getName() %>" /></td>
			</tr>
			<tr>
			  <td align="right"  class="STYLE1">旧密码：</td> 
			  <td>
			  <html:password property="oldpassword" size="27" />
			 </td>
			<tr>
			  <td align="right"  class="STYLE1">新密码：</td> 
			  <td>
			  <html:password property="password" size="27" />
			 </td>
			 <tr>
			  <td align="right"  class="STYLE1">确认新密码：</td> 
			  <td>
			  <html:password property="againpassword" size="27" />
			 </td>
			</tr>
			<tr>
			  <td></td>
			  <td><html:submit property="submit" value="提交" /></td>
			</tr>
			 </html:form>
		</table>
		
		<%} 
		if(columnid=="3"||columnid.equals("3"))
		{
		 %>
		 <table width="500" cellpadding="2" cellspacing="1" class="TablePanel" >
			<tr>
	          <td class="TDHead" colspan="2" >添加用户</td>
			</tr>
			 <html:form action="adminAction.do" > <html:hidden property="method" value="add" /> 
			<tr>
			  <td width="91" align="right"  class="STYLE1">用户名：</td>
			  <td width="396" class="STYLE1"><html:text property="name" size="25" /></td>
			</tr>
			<tr>
			  <td align="right"  class="STYLE1">密码：</td> 
			  <td>
			  <html:password property="password" size="27" />
			 </td>
			</tr>
			<tr>
			  <td></td>
			  <td><html:submit property="submit" value="提交" /></td>
			</tr>
			 </html:form>
		</table>
		
		<%} %>
		
		
		
		</td >
	</tr>
	
</table>
</body>
<script language="javascript">
function confirmdelete(id){
  if(confirm('确定要删除该用户吗？')){
  	location.replace('<%=request.getContextPath()%>/userAction.do?method=delete&amp;id='+id);
  }
}
</script>
</html>
