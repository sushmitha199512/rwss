
<%@ include file="/commons/rws_header1.jsp" %>

<%@page import="java.io.File"%>
<%
String realpath=request.getRealPath("");
 %>
 <center>
<body >
<table width="100%">
<tr><td align=right></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="File Download " />
	<jsp:param name="TWidth" value="500" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" width="38%" border=1 style="border-collapse:collapse;" >
<tr><td>SlNo.</td><td>File Name</td><td>File Size</td></tr>
    <%
        String sourceDirectory = request.getRealPath("");
          sourceDirectory+="//downloads//bank//";
try{
File dirName = new File(sourceDirectory);
int count=1;
if (dirName.exists()&& dirName.isDirectory())
{
//out.print("path: " + dirName.getAbsolutePath() + "<br>");
File[] allFiles = dirName.listFiles();
for (int i=0; i < allFiles.length; i++)
{
%><tr><td class="btext" align=left><%=count++ %></td><td class="btext">
<a href="FilesList.jsp?path=<%=allFiles[i].getAbsolutePath()%>"><%=allFiles[i].getName()%></a>
</td><td class="btext">-</td></tr>
<%
}
}
}
catch (Exception  ex){
ex.printStackTrace();
}
%>
<tr><td colspan=3><%=realpath  %></td></tr>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="500"/>
</jsp:include>
</center>