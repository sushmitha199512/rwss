<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String habcode=request.getParameter("habcode");
String mode=request.getParameter("mode");
String dist=request.getParameter("dist");
String qry1="";
%>
<form>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr align="center">
    <td class=btext ><b>S.No</b></font></td>
	<%if(mode!=null && mode.equals("1")){%>
 	<td class=btext><b>School Name</b></font></td>
	<td class=btext><b>Location </b></font></td>
	<td class=btext><b>School Classification</b></font></td>
	<td class=btext><b>No.of Students </b></font></td>
	<td class=btext><b>Facilities Avaliable</b></font></td>
	<td class=btext><b>No.of Boys</b></font></td>
	<td class=btext><b>No.of Girls </b></font></td>
	<%}%>
	<%if(mode!=null && mode.equals("2")){%>
	 <td class=btext><b>School Name</b></font></td>
	<td class=btext><b>Location </b></font></td>
	<td class=btext><b>School Classification</b></font></td>
	<td class=btext><b>No.of Students </b></font></td>
	<td class=btext><b>Facilities Avaliable</b></font></td>
	<td class=btext><b>No.of Boys</b></font></td>
	<td class=btext><b>No.of Girls </b></font></td>
	<td class=btext><b>Asset Name </b></font></td>
	<td class=btext><b>Asset Cost </b></font></td>
	<td class=btext><b>Asset Status </b></font></td>
	<td class=btext><b>Date of Creation</b></font></td>
    <%}%>
	<%if(mode!=null && mode.equals("3")){%>
	<td class=btext><b>School Name</b></font></td>
	<td class=btext><b>Location </b></font></td>
	<td class=btext><b>School Classification</b></font></td>
	<td class=btext><b>No.of Students </b></font></td>
	<td class=btext><b>Facilities Avaliable</b></font></td>
	<td class=btext><b>No.of Boys</b></font></td>
	<td class=btext><b>No.of Girls </b></font></td>
	<td class=btext><b>Work ID</b></font></td>
	<td class=btext><b>Work Name</b></font></td>
	<td class=btext><b>No.of Habs Covered</b></font></td>
	<td class=btext><b>Type of Asset</b></font></td>
	<%}%>
	<%if(mode!=null && mode.equals("4")){%>
 	<td class=btext><b>School Name</b></font></td>
	<td class=btext><b>Location </b></font></td>
	<td class=btext><b>School Classification</b></font></td>
	<td class=btext><b>No.of Students </b></font></td>
	<td class=btext><b>Facilities Avaliable</b></font></td>
	<td class=btext><b>No.of Boys</b></font></td>
	<td class=btext><b>No.of Girls </b></font></td>
	<%}%>
</tr>
<% 
Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
if (mode!=null && mode.equals("1"))
{
 qry1 = "select distinct SCHOOL_NAME ,nvl(SCHOOL_LOCATION,'-'),SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE ,NO_OF_BOYS ,NO_OF_GIRLS  from  rws_school_master_tbl where  hab_code='"+habcode+"'";
 }
else if(mode!=null && mode.equals("2"))
{
qry1 = "select distinct SCHOOL_NAME ,nvl(SCHOOL_LOCATION,'-'),SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE ,NO_OF_BOYS ,NO_OF_GIRLS,asset_name,asset_cost,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),  to_char(date_creation,'dd/mm/yyy') from rws_school_master_tbl a,rws_asset_mast_tbl b,rws_school_asset_lnk_tbl c where  a.hab_code=b.hab_code and b.asset_code=c.asset_code and b.hab_code='"+habcode+"' and a.school_code=c.school_code";
}
else if(mode!=null && mode.equals("3"))
{
qry1="select distinct SCHOOL_NAME ,nvl(SCHOOL_LOCATION,'-'),SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE ,NO_OF_BOYS ,NO_OF_GIRLS,WORK_ID ,WORK_NAME ,NO_OF_HABS,decode (TYPE_OF_ASSET ,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMP','09','DIRECTPUMPING' )   from rws_school_master_tbl a,rws_work_admn_tbl b,rws_school_asset_lnk_tbl c where  c.hab_code=a.hab_code and c.asset_code=b.work_id and a.hab_code='"+habcode+"' and a.school_code=c.school_code";
}
else if(mode!=null && mode.equals("4"))
{
qry1="select distinct SCHOOL_NAME ,nvl(SCHOOL_LOCATION,'- '),SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE ,NO_OF_BOYS ,NO_OF_GIRLS from rws_school_master_tbl a where a.hab_code='"+habcode+"' minus select distinct SCHOOL_NAME ,nvl(SCHOOL_LOCATION,'- '),SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE ,NO_OF_BOYS ,NO_OF_GIRLS from rws_school_master_tbl a,rws_school_asset_lnk_tbl b where a.hab_code=b.hab_code and a.hab_code='"+habcode+"' and a.school_code=b.school_code ";
}
//System.out.println("other"+qry1);
	int count=1;
	ResultSet rs1=stmt1.executeQuery(qry1);
	while(rs1.next())
	{
	%>
    <tr>
	<td class=rptvalue ><%=count++%></td>
<%if(mode!=null && mode.equals("1")){%>
	<td class=rptvalue  nowrap><%=rs1.getString(1)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  align="right"nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(6)%></td>
	<td class=rptvalue  align="right"nowrap><%=rs1.getString(7)%></td>
<%}%>

<%if(mode!=null && mode.equals("2")){%>
	<td class=rptvalue  nowrap><%=rs1.getString(1)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(6)%></td>
	<td class=rptvalue  nowrap align="right"><%=rs1.getString(7)%></td>
	<td class=rptvalue  nowrap align="right"><%=rs1.getString(8)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(9)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(10)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(11)%></td>
<%}%>
<%if(mode!=null && mode.equals("3")){%>
	<td class=rptvalue  nowrap><%=rs1.getString(1)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(6)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(7)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(8)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(9)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(10)%></td>
	<td class=rptvalue  align="right" nowrap><%=rs1.getString(11)%></td>
<%}%>
<%if(mode!=null && mode.equals("4")){%>
	<td class=rptvalue  nowrap><%=rs1.getString(1)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue align="right" nowrap><%=rs1.getString(6)%></td>
	<td class=rptvalue  nowrap align="right"><%=rs1.getString(7)%></td>
<%}}%>
 </tr>
</form>
</table>
