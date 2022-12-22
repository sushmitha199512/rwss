<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_work_ongoing_xls.xls");

String dcode=(String)session.getAttribute("dcode");
String category=(String)session.getAttribute("category");
String year=(String)session.getAttribute("year");
String dname=(String)session.getAttribute("dname");
String yr="";
String cname="";
if(category.equals("1"))
{
	cname="Projects";
}
else if(category.equals("2"))
{
	cname="Normal";
}
else if(category.equals("3"))
{
	cname="District level";
}
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null;
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null;
if(year.equals("2010-2011"))
{
yr="01-Apr-2010";
}
else
{
yr="01-Apr-2009";
}
%>
<html>
<body>
<form>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr class=btext align="center">
		<font color="navy">District: &nbsp;<%=dname%></font>&nbsp;&nbsp;<font color="navy">Year: &nbsp;<%=year%></font>&nbsp;&nbsp;<font color="navy">Category: &nbsp;<%=cname%></font>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Ongoing Works-Habitations Benefitted Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
                <tr align=center>
               <td class=btext >Sl.No</td>
               <td class=btext >Work Id</td>
               <td class=btext >Work Name</td>
               <td class=btext >District</td>
               <td class=btext  >Mandal</td>
               <td class=btext  >Panchayat</td>
			   <td class=btext  >Village</td>
			   <td class=btext  >Habitation</td>
			    <td class=btext  >Habitation Type</td>
			   <td class=btext  >Habitation Sub Type</td>
			   <td class=btext  >Coverage Status</td>
			   <td class=btext  >Population Benefitted</td>
               </tr>
<%int sno=1,sn=0;
String workido = "",workidn="";
try
{
	String qry="SELECT w.work_id,no_of_habs,work_name,c.dname,c.mname,c.pname,c.vname,c.panch_name ,c.coverage_status,d.habitation_type,d.habitation_sub_type,(d.census_sc_popu+d.census_st_popu+d.census_plain_popu) as popu FROM RWS_WORK_ADMN_TBL W,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_habitation_directory_tbl d where d.hab_code=c.panch_code and d.hab_code=b.hab_code and  w.work_id=b.work_id and b.hab_code=c.panch_code and w.ADMIN_DATE <'"+yr+"'and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION <'"+yr+"') and substr(work_id,5,2)='"+dcode+"') and substr(w.work_id,5,2)='"+dcode+"' and category_code='"+category+"' order by w.work_id";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	//System.out.println("Qry*******"+qry);
	
	while(rs.next())
	{
		sn++;
 workidn = ""+rs.getString(1);
    		%>
			<tr>
			<td class="rptvalue"><%=sno++%></td>
			<%if(!workidn.equals(workido)){%>
			<td class="rptvalue"><%=rs.getString(1)%></td>
			<td class="rptvalue"><%=rs.getString(3)%></td>
			<td class="rptvalue"><%=rs.getString(4)%></td>
			<%}else{%>
			<td  class=rptValue >&nbsp;</td>
			<td  class=rptValue >&nbsp;</td>
			<td  class=rptValue >&nbsp;</td>
			<%}%>
			<td class="rptvalue"><%=rs.getString(5)%></td>
			<td class="rptvalue"><%=rs.getString(6)%></td>
			<td class="rptvalue"><%=rs.getString(7)%></td>
			<td class="rptvalue"><%=rs.getString(8)%></td>
			<td class="rptvalue"><%=rs.getString(10)%></td>
			<td class="rptvalue"><%=rs.getString(11)%></td>
			<td class="rptvalue"><%=rs.getString(9)%></td>
			<td class="rptvalue"><%=rs.getString(12)%></td>
			</tr>
			<%
				workido = workidn;
		}
    if(sn==0)
	{
	%>
	<tr align="center">
	<td class="rptvalue" colspan="14" ><b>No Records</b></td>
	</tr>
	<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</html>


