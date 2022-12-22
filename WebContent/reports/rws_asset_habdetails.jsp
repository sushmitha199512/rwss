<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<html>
<body>
<table border="1" cellspacing=0 cellpadding=0 width="50%"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
						<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="JavaScript:self.close()">Close</a>

			</tr>
			</table>
		</caption>
	<tr>
		<td align="center" class=btext colspan="3"><font size=2 face="verdana" >Asset-Habitation Details</font></td>	
	</tr>
	<tr>
	<td class=btext >SNO</td>
	<td class=btext >Habitation Code</td>
	<td class=btext >Habitation Name</td>
	</tr>
	
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String acode=request.getParameter("acode");
//System.out.println("asset code in hab:"+acode);
int sno=0;
String qry="select h.hab_code from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and h.asset_code= a.asset_code and a.asset_code='"+acode+"'";
stmt1=conn.createStatement();
//System.out.println("qry%%%:"+qry);
rs1=stmt1.executeQuery(qry);
// System.out.println("0:" +rs1);
 while(rs1.next())
{ //System.out.println("1");
%>
 <tr>
   <td class=rptValue> <%=++sno%></td>
   <%
   String qry1="select Panch_code,Panch_name from rws_complete_hab_view where panch_code='"+rs1.getString(1)+"' ";
   stmt2=conn.createStatement();
  // System.out.println("xds:"+qry1);
   rs2=stmt2.executeQuery(qry1);
   if(rs2.next())
   {%>
    <td class=rptValue> <%=rs2.getString(1)%></td>
    <td class=rptValue> <%=rs2.getString(2)%></td>
   
   <%}%>
   </tr>
   <%}

 %></table></body>


</html>
<%@ include file="/commons/rws_footer.jsp"%>