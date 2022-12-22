<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
</body>
<%
String dist=request.getParameter("district1");
String mandal=request.getParameter("mandal");
String ast=request.getParameter("astwrk");
String mname=request.getParameter("mname");
int count=0;
Statement stmt1=null;
ResultSet rs1=null;
stmt1=conn.createStatement();
//System.out.println("dist"+dist);
//System.out.println("ast"+ast);%>
<table border = 0 width=20% align=center>
<%if(request.getParameter("dName")!=null && !request.getParameter("dName").equals("")){ %>
<tr><td class=btext>District:</td><td><font face=verdana size=2><%=request.getParameter("dName")%></td></tr>
<%}%>
<%if(request.getParameter("mandal")!=null && !request.getParameter("mandal").equals("")){ %>
<tr><td class=btext>Mandal:</td><td><font face=verdana size=2><%=request.getParameter("mname")%></td></tr>
<%}%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="javascript:window.print()">print</a>|
					<a href="/pred/home.jsp?loginMode=watersoft">Home
					</td>
				</tr>
			</table>
		</caption>
<%
if(ast!=null && !ast.equals("") &&  ast.equals("1") ) 
{
%>
<tr>
<td class=btext>Sl.No</td>
<td class=btext>Mandal</td>
<td class=btext>Panchyat</td>
<td class=btext>Village</td>
<td class=btext>Habitation</td>
<td class=btext>School Name </td>
<td class=btext>School Clasification</td>
<td class=btext>Asset Name</td>
<td class=btext>Asset Status</td>
<td class=btext>Asset Cost</td>
<td class=btext>Date Of Creation</td>
<%
String qry="";
qry="select  v.mname,v.pname,v.vname,v.panch_name,school_name,SCHOOL_CLASSIFICATION ,asset_name,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'), asset_cost, to_char(date_creation,'dd/mm/yyy') from rws_complete_hab_view v,rws_school_master_tbl s,rws_asset_mast_tbl a,rws_school_asset_lnk_tbl l where v.panch_code=s.hab_code and v.panch_code=a.hab_code and s.hab_code=a.hab_code and v.panch_code=l.hab_code and s.hab_code=l.hab_code and a.hab_code=l.hab_code and a.asset_code=l.asset_code and s.school_code=l.school_code and  substr(l.asset_code,1,4) = '0000'  and substr(l.hab_code,1,2)='"+dist+"' ";
if(mandal!=null && !mandal.equals(""))
	{
	qry+=" and substr(l.hab_code,6,2)='"+mandal+"' ";
	}
 System.out.println("qry:"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
	%><tr>
	<td class=rptValue><%=++count%></td>
<% 
		 /*String qry1="select  v.mname,v.pname,v.vname,v.panch_name,school_name,SCHOOL_CLASSIFICATION ,asset_name,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'), asset_cost, to_char(date_creation,'dd/mm/yyy') from rws_complete_hab_view v,rws_school_master_tbl s,rws_asset_mast_tbl a,rws_school_asset_lnk_tbl l where v.panch_code=s.hab_code and v.panch_code=a.hab_code and s.hab_code=a.hab_code and v.panch_code=l.hab_code and s.hab_code=l.hab_code and a.hab_code=l.hab_code and a.asset_code=l.asset_code and s.school_code=l.school_code and  l.asset_code='"+rs.getString(3)+"' and l.hab_code='"+rs.getString(1)+"' and l.school_code='"+rs.getString(2)+"'  ";
		//  System.out.println("qry1:"+qry1);
		 rs1=stmt1.executeQuery(qry1);
	  if(rs1.next())
	  {*/ 
	  %>
	    <td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue nowrap><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=rptValue><%=rs.getString(8)%></td>
		<td class=rptValue align="right"><%=rs.getString(9)%></td>
		<td class=rptValue><%=rs.getString(10)%></td>
	  	  <% /*}  
	  if(rs1!=null) rs1.close();*/
%>
	</tr>
<%}
if(rs!=null) rs.close();
}else if(ast!=null && !ast.equals("") &&  ast.equals("2") ) 
{%>
<tr>
<td class=btext>Sl.No</td>
<td class=btext>Mandal</td>
<td class=btext>Panchyat</td>
<td class=btext>Village</td>
<td class=btext>Habitation</td>
<td class=btext>School Name </td>
<td class=btext>School Clasification</td>
<td class=btext>Work Name</td>
<td class=btext>Admin No</td>
<td class=btext>Admin Date</td>
<td class=btext>Sancation Amount</td>
 <%
	 String qry="select v.mname,v.pname,v.vname,v.panch_name,school_name,SCHOOL_CLASSIFICATION,work_name,admin_no,to_char(ADMIN_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT from rws_complete_hab_view v,rws_school_master_tbl s,rws_work_admn_tbl a,rws_school_asset_lnk_tbl l where v.panch_code=s.hab_code and v.panch_code=l.hab_code and s.hab_code=l.hab_code and a.work_id=l.asset_code and s.school_code=l.school_code and v.dcode=substr(office_code,2,2) and  substr(l.asset_code,1,4) <> '0000'  and substr(l.hab_code,1,2)='"+dist+"' ";
	 if(mandal!=null && !mandal.equals(""))
	{
	qry+=" and substr(l.hab_code,6,2)='"+mandal+"' ";
	}
	//System.out.println("kkkggggggggggk"+qry);
    stmt=conn.createStatement();
    rs=stmt.executeQuery(qry);
    while(rs.next())
	{%>
	<tr>
	<td class=rptValue><%=++count%></td>
   <%/* String qry1="select v.mname,v.pname,v.vname,v.panch_name,school_name,SCHOOL_CLASSIFICATION,work_name,admin_no,to_char(ADMIN_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT from rws_complete_hab_view v,rws_school_master_tbl s,rws_work_admn_tbl a,rws_school_asset_lnk_tbl l where v.panch_code=s.hab_code and v.panch_code=l.hab_code and s.hab_code=l.hab_code and a.work_id=l.asset_code and s.school_code=l.school_code and v.dcode=substr(office_code,2,2) and l.asset_code='"+rs.getString(3)+"' and l.hab_code='"+rs.getString(1)+"' and l.school_code='"+rs.getString(2)+"' ";
   rs1=stmt1.executeQuery(qry1);
    if(rs1.next())
	{ */%>
	<td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue nowrap><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue nowrap><%=rs.getString(7)%></td>
		<td class=rptValue nowrap><%=rs.getString(8)%></td>
		<td class=rptValue align="right"><%=rs.getString(9)%></td>
		<td class=rptValue><%=rs.getString(10)%></td>
	  
	<%/*}
if(rs1!=null) rs1.close(); */
%>
</tr>
<%}
if(rs!=null) rs.close();

}
if(count==0)
{%>
	<tr>
	<td class=rptValue align=center  colspan=11>No Records</td>
<%}
%>

</body>
</html>