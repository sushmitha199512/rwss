

<%@page import="java.io.File"%>
<%
String realpath=request.getRealPath("");
 %>
<style >
.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
</style>
<center>
<br></br>
<br></br>
<body >
<table width="60%">
<tr><td align=right></td><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a><a href="/pred/home.jsp?loginMode=watersoft">Home</a>                    
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="File Download " />
	<jsp:param name="TWidth" value="500" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" width="38%" border=1 style="border-collapse:collapse;" >
<tr><td>SlNo.</td><td>File Name</td><td>File Size</td></tr>
    <%




String sourceDirectory=request.getParameter("path");

System.out.println("source:"+sourceDirectory);
        File f = new File(sourceDirectory);     
        File[] fileObjects = f.listFiles();
    %>

        <%
int count=1;
            for (int i = 0; i < fileObjects.length; i++)
            {
                if (!fileObjects[i].isDirectory())
                {%>
                    <tr><td class="btext" align=left><%=count++ %> </td><td class="btext"><A HREF="download.jsp?filename=<%=fileObjects[i].getAbsolutePath()%>"><%=fileObjects[i].getName()%></A>  </td><td class="btext">(<%=Long.toString(fileObjects[i].length())%>    bytes long)</td></tr>
                                              
                <%} else{  %>

<tr><td class="btext" align=left><%=count++ %> </td><td class="btext"><a href="FilesList.jsp?path=<%=fileObjects[i].getAbsolutePath()%>"><%=fileObjects[i].getName() %></a></td><td class="btext">-</td></tr>
<% 
            }
            }%>
 <tr><td colspan=3><%=realpath  %></td></tr>
</table>
</body>
</html>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="500"/>
</jsp:include>
</center>