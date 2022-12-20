<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn3.jsp" %>
<%
String work_id = request.getParameter("work_id");

String circle = request.getParameter("circle");
String program = request.getParameter("program");
String workName = request.getParameter("workName");
System.out.println("work id:"+work_id);
System.out.println("circle:"+request.getParameter("circle"));
System.out.println("program:"+request.getParameter("program"));
String[] months={"","January","February","March","April","May","June","July","August","September","October","November","December"};
int month = 0,total = 0;
try
{
String dname = "",sdname = "",scheme="";
stmt = conn.createStatement();
stmt1 = conn.createStatement();
Statement stmt2 = conn.createStatement();
Statement stmt3 = conn.createStatement();
String q = "select w.office_code,a.type_of_asset_name from rws_work_admn_tbl w,RWS_ASSET_TYPE_TBL a where w.work_id='"+work_id+"' and a.type_of_asset_code='"+work_id.substring(6,8)+"'";
System.out.println("Q:"+q);
ResultSet rs2 = stmt1.executeQuery(q);
if(rs2.next())
{
	String officeCode = rs2.getString(1);
	scheme = rs2.getString(2);
	System.out.println("Office COde:"+officeCode+"subsedfsdf:"+officeCode.substring(4,6));
	ResultSet rs3 = stmt2.executeQuery("select division_office_name from rws_division_office_tbl where circle_office_code = '"+officeCode.substring(1,3)+"' and division_office_code='"+officeCode.substring(3,4)+"'");
	if(rs3.next())
		dname = rs3.getString(1);
	if(!officeCode.substring(4,6).equals("00"))	
	{
		ResultSet rs4 = stmt3.executeQuery("select subdivision_office_name from rws_subdivision_office_tbl where circle_office_code = '"+officeCode.substring(1,3)+"' and division_office_code='"+officeCode.substring(3,4)+"' and subdivision_office_code='"+officeCode.substring(4,6)+"'");
		if(rs4.next())
			sdname = rs4.getString(1);
	}
}
System.out.println("dname::"+dname);
System.out.println("sdname::"+sdname);
String qry = "select * from rws_work_expenditure_tbl where work_id='"+work_id+"'";
System.out.println(qry);
rs1 = stmt.executeQuery(qry);
int count = 0;
%>
<html>
<head>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8" >
<form>

<table align=center width="100%">
	<tr>
		<td align=right>
			<a href="#" onclick="window.print();return false;"><u>Print</u></a>&nbsp;&nbsp;&nbsp;<a href="javascript:window.close()"><U>Close</U></a>
		</td>
	</tr>
	<tr>
		<td align="center" colspan=3 class="textborder"><font color="#666699" size="2" face="verdana">WORK EXPENDITURE DETAILS</font></td>
	</tr>
	<tr>
		<td colspan=3 class="textborder">&nbsp;</td>
	</tr>
	<!-- source details -->
	<tr>
		<td>
<table border=0>
	<tr>
		<td colspan=3 class="textborder">Circle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=circle%></td>
	</tr>
	<tr>
		<td colspan=3 class="textborder">Division&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=dname%></td>
	</tr>
	<%if(!sdname.equals("")){ %>
	<tr>
		<td colspan=3 class="textborder">Sub Division&nbsp; : <%=sdname%></td>
	</tr>
	<%} %>
	<tr>
		<td colspan=3 class="textborder">Progaramme&nbsp;: <%=program%></td>
	</tr>
	<tr>
		<td colspan=3 class="textborder">Scheme&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=scheme%></td>
	</tr>
	<tr>
		<td colspan=3 class="textborder">&nbsp;</td>
	</tr>
	<tr>
		<td colspan=3 class="textborder">&nbsp;</td>
	</tr>
</table>

			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
								<tr bgcolor="#8A9FCD">
					<td colspan=3 class="textborder">
						<b>Work Name:</b><font color="#ffffff"><SMALL><%=workName%></SMALL></font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">Year</td>
					<td align=center class="clrborder">Month</td>
					<td align=center class="clrborder">Expenditure</td>
				</tr>
<%
while(rs1.next())
{
try{
            	if(rs1.getString(3)!=null)
            		month=Integer.parseInt(rs1.getString(3));
            	}catch(Exception e){
            		System.out.println("Exception is "+e);}
				if(rs1.getString(5)!=null)total +=rs1.getInt(5);
%>
<tr>
					<td align=left class="rptValue"><%=rs1.getString(2)%></td>
					<td align=left class="rptValue"><%=months[month]%></td>
					<%if(rs1.getString(5)!=null){ %><td align=left class="rptValue"><%=rs1.getString(5)%></td>
					<%}else{%><td align=left class="rptValue">0</td>
					<%}%>
				</tr>
<%
}
 %>
<tr>
<td colspan=2 class="clrborder" align="left">Total:</td>
<td align="left" class="clrborder"><%=total%>
			</table>
		</td>
	</tr>
				
</table>
</body>
</html> 
<%

}
catch(Exception e)
{
System.out.println("error in jsp:"+e.getMessage());
}
%>
