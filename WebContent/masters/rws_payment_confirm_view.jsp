
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_ee_header1.jsp"%>
<%@page import="java.io.File"%>
<%
String realpath=request.getRealPath("");
 %>
 <html:form action="/bankConfirm.do">
<body >
<center>
<br></br><br></br><br></br><br></br>
<table width="100%">
<tr><td align=right></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="rws_ee_homepage_frm.jsp">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="File Download " />
	<jsp:param name="TWidth" value="560" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
<tr><td>SlNo.</td><td>File Name</td><td>File Size</td></tr>
    <%
        String sourceDirectory = request.getRealPath("");
          sourceDirectory+="//downloads//ANDB//";
try{
File dirName = new File(sourceDirectory);
int count=1;
if (dirName.exists()&& dirName.isDirectory())
{
//out.print("path: " + dirName.getAbsolutePath() + "<br>");
File[] allFiles = dirName.listFiles();
for (int i=0; i < allFiles.length; i++)
{
%><tr ><td class="btext" width="100" align=left><%=count++ %></td><td width="300" class="btext">
<a href="rws_contractor_payment_files_list.jsp?path=<%=allFiles[i].getAbsolutePath()%>"><%=allFiles[i].getName()%></a>
</td><td class="btext"  width="195">-</td></tr>
<%
}
}
}
catch (Exception  ex){
ex.printStackTrace();
}
%>

</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="560"/>
</jsp:include>
</center>
</body>
</html:form>