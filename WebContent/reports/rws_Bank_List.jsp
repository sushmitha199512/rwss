<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%
String dcode=request.getParameter("district");
if(dcode!=null)
{
	session.setAttribute("dcode",dcode);
}
String divcode=request.getParameter("division");
if(divcode!=null)
{
	session.setAttribute("divcode",divcode);
}
Statement stmt1=null;
ResultSet rs1=null;
%>
<html>
<body>
<form>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home|</a></td>
			</tr>  
		</table>
	</caption>
		<font color="navy">District: &nbsp;<%=request.getParameter("dname")%></font>&nbsp;&nbsp;
		
		<%if(request.getParameter("divname")!=null && !request.getParameter("divname").equals("")){ %>
	 
		<font color="navy">Division: &nbsp;<%=request.getParameter("divname")%></font>
		<%}%>

<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Bank Account Details</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse" >
<tr align=center>
               <td class=btext >Sl.No</td>
			   <%
              if(divcode!=null && !divcode.equals("")){}else{%>
			    <td class=btext >Division</td>
				<%}%>
               <td class=btext >Bank Name</td>
               <td class=btext >Branch Name</td>
               <td class=btext >Account No</td>
               </tr>
<%int sno=1;
try
{
	String qry="select bank_name ,branch_name ,account_no,division_office_name from rws_office_bank_account_tbl a,rws_district_tbl b,rws_division_office_tbl c ,rws_bank_tbl d,rws_branch_tbl e  where substr(office_code,2,2)=b.dcode and substr(office_code,4,1)=c.division_office_code and  b.dcode=c.circle_office_code  and a.bank_code=d.bank_code and a.branch_code=e.branch_code";
	if(dcode!=null && !dcode.equals("all"))
	{
	qry+=" and dcode='"+dcode+"'";
	}
	if(divcode!=null && !divcode.equals(""))
	{
	qry+=" and division_office_code='"+divcode+"' ";
	}
	//System.out.println("Qry*******"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
    
	if(rs.isBeforeFirst())
	{
		while(rs.next())
		{
			%>
			<tr>
			<td class="rptvalue"><%=sno++%></td>
			 <%
              if(divcode!=null && !divcode.equals("")){}else{%>
			<td class="rptvalue"><%=rs.getString(4)%></td>
			<%}%>
			<td class="rptvalue"><%=rs.getString(1)%></td>
			<td class="rptvalue"><%=rs.getString(2)%></td>
			<td class="rptvalue"><%=rs.getString(3)%></td>
			</tr>
			<%
		}
	}
	else
	{
		%>
			<tr><td class="btext" colspan="4" align="center">No Records</td></tr>
			<%
	}
		
    
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
</form>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

</html>

