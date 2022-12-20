<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>

<html>

<body>


<form name="goform">
	<%
	//String fileLocation = "C:\\Tomcat 5.0\\webapps\\pred\\uploads\\proposals";
		
	//String fileLocation ="/pred/uploads/proposals";
	
	String fileLocation = "/apd8/pred/app/uploads/proposals";

		File f=new File(fileLocation);
		String[] fileNames=f.list();
		String[] goFileNames;
		int count=0,j=0;
		
			
		if(fileNames!=null && fileNames.length>0)
		{
			%>

			<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="List Of GO's" />
				<jsp:param name="TWidth" value="160" />
			</jsp:include>
			
			
			<table  bgcolor="b0e2f" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse" width="200" >
			
			
			<%

			
			//System.out.println("no of filenames"+fileNames.length);
			goFileNames=new String[fileNames.length];
			j=1;
			for(int i=0;i<fileNames.length;i++)
			{	
				if(fileNames[i].substring(0,3).equalsIgnoreCase("GO_"))
				{
					count++;
					goFileNames[j]=fileNames[i];
					
					
					%>
					<tr align=center><td><font size=2 color=4682b4><%=j%>.</font>
					<a href=/pred/uploads/proposals/<%=goFileNames[j]%> target="_new"><%=goFileNames[j] %></a>
					</td></tr>
					<%
					//System.out.println(goFileNames[j]);
					j++;
				}
			}
			%>

			</table>

			<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
			   <TR>
				  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_left1.gif'/>" ALT=""></TD>
				  <TD  bgcolor="#8A9FCD" width=160>
				  <FONT  style="font-size:8pt" color="#FFFFFF"><font color="#FF6666" >*</font>&nbsp;Click the file name to open</FONT></td>
				  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_b_right1.gif'/>" ALT=""></TD>
			</TABLE>

			<%			
		}
		else
		    out.println("<center><font color='#FF6666'>No GO's In This Directory</font></center>");
	%>

</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>