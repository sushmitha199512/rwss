<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String dname=(String)session.getAttribute("dname");
String mname=(String)session.getAttribute("mname");
String habcode=request.getParameter("habcode");
String scheme=(String)session.getAttribute("scheme");
String scheme1=(String)session.getAttribute("scheme1");
String toa=request.getParameter("toa");
//System.out.println("scheme (not)"+scheme);
//System.out.println("habcode"+habcode);
%>
<form>
<table><tr><td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
</tr></table>
<table width="80%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Habitations </font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr >
<td class=btext ><b>S.No</b></font></td>
 	<td class=btext><b>Asset Code</b></font></td>
	<td class=btext><b>Asset Name</b></font></td>
	<td class=btext><b>Location</b></font></td>
		<td class=btext><b>Date.Of Creation</b></font></td>
			<td class=btext><b>Asset Cost(Lakhs)</b></font></td>
	<td class=btext><b>Population Benifited</b></font></td>
	<td class=btext><b>Status</b></font></td>
   </tr>
<%
String qry="";
stmt=conn.createStatement();
try
{
	if(!toa.equals("04"))
	{
		 qry="select a.asset_code,a.asset_name,a.location,to_char(date_creation,'dd/mm/yyyy'),asset_cost,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)pop,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status from rws_asset_mast_tbl a, rws_asset_hab_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and  b.hab_code=c.panch_code and  B.hab_code='"+habcode+"' and type_of_asset_code='"+toa+"' group by a.asset_code,a.asset_name,a.location,asset_status,asset_cost,to_char(date_creation,'dd/mm/yyyy')";
	}
	else
	{
		qry="Select a.asset_code,a.asset_name,a.location,to_char(date_creation,'dd/mm/yyyy'),asset_cost,POPU_BENEFITED,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED')  from rws_asset_mast_tbl a where  a.hab_code='"+habcode+"' and type_of_asset_code='"+toa+"'";
	}
	rs=stmt.executeQuery(qry);
	int count=1;
	while(rs.next())
	{%>
	<tr>
		<td class=rptvalue ><%=count++%></td>
		<td class=rptvalue  nowrap><%=rs.getString(1)%></td>
		<td class=rptvalue ><%=rs.getString(2)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(3)%></td>
		<td class=rptvalue   nowrap><%=rs.getString(4)%></td>
		<td class=rptvalue   nowrap><%=rs.getString(5)%></td>
		<td class=rptvalue   nowrap><%=rs.getString(6)%></td>
		<td class=rptvalue   nowrap><%=rs.getString(7)%></td>
	</tr>
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
<%@ include file="/commons/rws_footer.jsp"%>

