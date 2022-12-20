<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<body>
<%
int count=0;
String acode=request.getParameter("acode");
String dcode=request.getParameter("dcode");
String div=request.getParameter("div");
String subdiv=request.getParameter("subdiv");
String ast=request.getParameter("ast");
//String divname=request.getParameter("divname");
String qry="";

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=75% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.back(-1)">Back|</a> 
					<a href="../home.jsp">Home</a>
                </tr>
			</table>
		</caption>
		
		<%if(ast.equals("1")) {%>
		<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11">
		<font color="ffffff">Asset Details</font></td>
		</tr>
		<%} else if(ast.equals("2")) {%>
		<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11">
		<font color="ffffff">Work Details</font></td>
		</tr>
		<%}%>

<tr>
<td class=btext>Sl.No</td>
<%if(ast.equals("1")) {
 if(div==null || div.equals("-1")){%>
<td class=btext>Division Name</td>
<%}
 if(subdiv==null || subdiv.equals("-1")){%>
<td class=btext>Subdivision Name</td>
<%}%>

<td class=btext>Asset Code</td>
<td class=btext>Asset Name</td>
<td class=btext>Asset Cost</td>

<%}else if(ast.equals("2")){
if(div==null  || div.equals("-1")){%>
<td class=btext>Division Name</td>
<%}%>
<td class=btext>Work Id</td>
<td class=btext>WorkName</td>
<td class=btext>Sanction Amount</td>
<%}%>
</tr>
<%
if(ast.equals("1"))
{
  
 //qry="select  asset_code,asset_name,asset_cost from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b  where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)='"+dcode+"' and  type_of_asset_code='"+acode+"'";
 qry="select asset_code,asset_name,asset_cost,d.division_office_name,s.subdivision_office_name from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_division_office_tbl d,rws_subdivision_office_tbl s where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)='"+dcode+"'and type_of_asset_code='"+acode+"' and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and substr(a.work_id,5,2)=d.circle_office_code and substr (a.work_id,5,2)=s.circle_office_code and b.division_office_code=d.division_office_code and b.subdivision_office_code=s.subdivision_office_code "; 
 if(div!=null && !div.equals("-1"))
	{
  qry+=" and b.division_office_code='"+div+"' ";
	}
	if(subdiv!=null && !subdiv.equals("-1"))
	{
  qry+=" and b.subdivision_office_code='"+subdiv+"' ";
	}
} else if (ast.equals("2")) {
//qry="select  a.work_id,b.work_name,sanction_amount from rws_ddws_scheme_data_port a,rws_work_admn_tbl b where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)= '"+dcode+"'and type_of_asset='"+acode+"' ";
qry="select a.work_id,b.work_name,sanction_amount,d.division_office_name from rws_ddws_scheme_data_port a,rws_work_admn_tbl b, rws_division_office_tbl d  where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)= '"+dcode+"'  and type_of_asset='"+acode+"' and  substr(a.work_id,5,2) =d.circle_office_code and substr(b.office_code,4,1) =d.division_office_code ";
if(div!=null && !div.equals("-1"))
	{
  qry+=" and substr(office_code,4,1)='"+div+"' ";
	}
}
// System.out.println("sdgsfg:"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{%>
<tr>
<td class="rptValue"><%=++count%></td>

<% 
if(ast.equals("1")) {	
if(div==null || div.equals("-1")){%>
<td  class="rptValue"><%=rs.getString(4)%></td>
<%} 
if(subdiv==null || subdiv.equals("-1")){%>
<td  class="rptValue"><%=rs.getString(5)%></td>
<%}
}else if(ast.equals("2")) {	
if(div==null || div.equals("-1")){%>
<td  class="rptValue"><%=rs.getString(4)%></td>
<%} 
}%>
<td  class="rptValue"><%=rs.getString(1)%></td>
<td  class="rptValue" nowrap><%=rs.getString(2)%></td>
<td  class="rptValue" align="right"><%=rs.getString(3)%></td>
</tr>
<%}

%>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>