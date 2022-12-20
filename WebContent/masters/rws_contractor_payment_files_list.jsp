
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

<script >
function sendSFTP(fileName){

	alert(fileName);
	document.forms[0].action="switch.do?prefix=/masters&page=/bankConfirm.do&mode=sftp&fileObj="+fileName;
	document.forms[0].submit();
	
}

</script>
<html:form action="/bankConfirm.do">
<body  >
<center>
<br></br><br></br><br></br><br></br><BR></BR>
<table width="80%">
<tr><td align=left></td><td align=right ><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="switch.do?prefix=/masters&page=/bankConfirm.do&mode=view">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="File Download " />
	<jsp:param name="TWidth" value="555" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" width="62%" border=1 style="border-collapse:collapse;" >
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
                    <tr><td class="btext" align=left><%=count++ %> </td><td class="btext"><A HREF="download.jsp?filename=<%=fileObjects[i].getName()%>"><%=fileObjects[i].getName()%></A>  </td><td class="btext">(<%=Long.toString(fileObjects[i].length())%>    bytes long)</td> <td class="btext">-</td><td class="btext"></td></tr>
                                              
                <%} else{  %>

<tr><td class="btext" align=left><%=count++ %> </td><td class="btext"><a href="rws_contractor_payment_files_list.jsp?path=<%=fileObjects[i].getAbsolutePath()%>"><%=fileObjects[i].getName() %></a></td><td class="btext"></td><td class="btext"></td></tr>
<% 
            }
            }%>
 
</table>


<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="555"/>
</jsp:include>
</center>
</body>
</html>
</html:form>