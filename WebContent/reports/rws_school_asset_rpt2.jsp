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

Statement stmt1=conn.createStatement();
ResultSet rs1=null;
//System.out.println("dist"+dist);
//System.out.println("ast"+ast);
%>
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
					<a href="/pred/home.jsp?loginMode=watersoft">Home</td>
					
				</tr>
			</table>
		</caption>
<tr>
<td class=btext>Sl.No</td>
<td class=btext>Mandal</td>
<td class=btext>Panchayat </td>
<td class=btext>Village </td>
<td class=btext>Habitation </td>
<td class=btext>School Name </td>
<td class=btext>School Category</td>

</tr>
<%
String qry="";
int count=0;
qry="select  hab_code,school_code,school_name,SCHOOL_CLASSIFICATION  from rws_school_master_tbl where hab_code||school_code in(select hab_code||school_code from rws_school_master_tbl where substr(hab_code,1,2)='"+dist+"' minus select a.hab_code||a.school_code from rws_school_master_tbl a,RWS_SCHOOL_ASSET_LNK_TBL b where a.hab_code=b.hab_code and a.school_code=b.school_code and substr(a.hab_code,1,2) ='"+dist+"'";
if(mandal!=null && !mandal.equals(""))
	{
		qry+=" and substr(a.hab_code,6,2)='"+mandal+"' ";
	}
	qry+=")";
//System.out.println("qry:"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);

while(rs.next())
{
	%><tr>
	<td class=rptValue><%=++count%></td>
<%
	String qry1="select  mname,pname,vname,panch_name from rws_complete_hab_view where panch_code='"+rs.getString(1)+"' ";
	rs1=stmt1.executeQuery(qry1);
	if(rs1.next())
	{%>
			<td class=rptValue><%=rs1.getString(1)%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(3)%></td>
			<td class=rptValue><%=rs1.getString(4)%></td>
	<%}
	if(rs1!=null) rs1.close();
	%>
	<td class=rptValue nowrap><%=rs.getString(3)%></td>
	<td class=rptValue><%=rs.getString(4)%></td>
	
</tr>
<%}
if(rs!=null) rs.close();

if(count==0)
{%>
	<tr>
	<td class=rptValue align=center  colspan=7>No Records</td>

<%}

%>

</body>
</html>