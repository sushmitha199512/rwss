<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<style>
tr.even {
  background-color: #ddd;
  width:20px;
  height:15px;
}
tr.odd {
  background-color: #eee;
  width:20px;
  height:15px;
  }
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
<%
String catCode=request.getParameter("catCode");
String catName="";
if(catCode.equals("1")) catName="PROJECT";
if(catCode.equals("2")) catName="NORMAL";
if(catCode.equals("3")) catName="DISTRICT LEVEL";
String dname=request.getParameter("dname");
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
String dist=request.getParameter("district");
////System.out.println("dist:"+dist);
%>
<table border = 0 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" >
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a> |<a href="./rws_Aap_xls.jsp?catCode=<%=catCode%>&district=<%=dist%>&dname=<%=dname%>" target=_new>Excel</a></td>
				</tr>
			</table>
			</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" class="striped">
<tr bgcolor="#8A9FCD" align="center">
<td colspan=13>

<B><font color="#660099"><font color="blue"><%=dname%></font>&nbsp;&nbsp; AAP-2011&nbsp;<font color="blue"><%=catName%></font> &nbsp; Works</font></B></td></tr>
<tr >
  <td class=btext rowspan=2 align="center"> Sl.No</td>
  <td class=btext rowspan=2 align="center">District/<br>Division</td>
  <td class=btext rowspan=2 align="center">Spill/New</td>
  <td class=btext rowspan=2 align="center">Work Id/<br>Work Name</td>
  <td class=btext rowspan=2 align="center">Program/<br>Sub Program</td>
  <td class=btext rowspan=2 align="center">Sanctin No/<br>Sanction Date</td>
  <td class=btext rowspan=2 align="center">Estimate Cost(in Lakhs)</td>
  <td class=btext rowspan=2 align="center">Plan-NonPlan/<br>Work Type</td>
  <td class=btext colspan=1  align="center">Source Details</td>
  <td class=btext rowspan=2 align="center">Grounding Date/</br>Probable Date Of Completion</td>
  <td class=btext rowspan=2  align="center">No.of Habs</td>
 <td class=btext colspan=2  align="center">Habitation  Sanctioned Details</td>
</tr>
<tr>
        <td class=btext align="center"> Source Code/Source Name/<br>Source Type/<br>Location</td>
		<td class=btext align="center">Mandal<br>Panchyat <br>HabCode/<br>Habitation  </td>
		<td class=btext align="center">Status As on 01.04.2011</td>
</tr>
<%
 try{

  int cnt=0,count=1;
 String prvWrkid="";
 String wrkId="";
String qry="select distinct a.work_id,circle_office_name,division_office_name,b.work_name,programme_name,subprogramme_name,to_char (admin_date,'dd/MM/yyyy'),admin_no,sanction_amount,decode(plan_code,'1','PLAN','2','NON PLAN'),decode(aug_new_code,'1','MAIN SCHEME','2','AUGMENTATION','3','MAINTENANCE'),(case when admin_date < '01/APR/2011' then  'SPILL' else 'NEW' end)a,no_of_habs from rws_AAP_selected_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl s,rws_circle_office_tbl c,rws_division_office_tbl d,rws_admn_hab_lnk_tbl l,rws_complete_hab_view v where a.work_id=b.work_id and a.work_id=l.work_id and b.work_id=l.work_id and  b.programme_code=p.programme_code and p.programme_code=s.programme_code and s.subprogramme_code=b.subprogramme_code and substr(office_code,2,2)=c.circle_office_code and substr(office_code,4,1)=d.division_office_code and c.circle_office_code=d.circle_office_code and v.panch_code=l.hab_code and substr(a.work_id,5,2)=substr(panch_code,1,2) and  category_code='"+catCode+"'   ";
if(dist!=null && !dist.equals("") && !dist.equals("all"))
 { qry+= " and substr(a.work_id,5,2) ='"+dist+"' ";}
 qry+= " order by circle_office_name";
//System.out.println("qry:"+qry);
stmt=conn.createStatement();
stmt1=conn.createStatement();
stmt2=conn.createStatement();
stmt3=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
	int countt=1;
	wrkId=rs.getString(1);
	
	%>
			<tr>
				<td class=rptvalue align="center"><%=++cnt%></td>
				<td class=rptvalue ><%=rs.getString(2)%>/<br><%=rs.getString(3)%></td>
				<td class=rptvalue ><%=rs.getString(12)%></td>
				<td class=rptvalue ><%=wrkId%>-<br><%=rs.getString(4)%></td>
				<td class=rptvalue ><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>
				<td class=rptvalue ><%=rs.getString(8)%>/<br><%=rs.getString(7)%></td>
				<td class=rptvalue ><%=rs.getDouble(9)%></td>
				<td class=rptvalue ><%=rs.getString(10)%>/<br><%=rs.getString(11)%></td>
			<%
			 String qry2="select a.source_code,nvl(a.source_name,'-'),nvl(location,'-'),decode(a.source_type_code,'1','SUBSURFACE SOURCE','2','SURFACE SOURCE','3','RAIN WATER','4' ,'TRADITIONAL','5', 'OTHERS','6','SUSTAINABILITY') from RWS_SOURCE_IDEN_FIN_TBL a,rws_source_tbl b where a.source_code=b.source_code and work_id='"+wrkId+"' ";
			rs2=stmt2.executeQuery(qry2);
			if(rs2.next())
			{%>
			<td class=rptvalue align="center"><%=rs2.getString(1)%>/<br><%=rs2.getString(2)%>/<br><%=rs2.getString(4)%>/<br><%=rs2.getString(3)%></td>
			<%}else{%>
			<td class=rptvalue align="center">-</td>
			<%}String qry3="select (select nvl(to_char(grounding_date,'dd/MM/yyyy'),'-') from rws_work_commencement_tbl where work_id='"+wrkId+"')a, (select nvl(to_char (probable_date,'dd/MM/yyyy'),'-') from rws_contractor_selection_tbl where work_id='"+wrkId+"')b from dual";
			rs3=stmt3.executeQuery(qry3);
			  if(rs3.next()){
				  
				  if(rs3.getString(1)!=null && !rs3.getString(1).equals("")){%>
				<td class=rptvalue><%=rs3.getString(1)%>/<br>
				<%}else{%><td class=rptvalue>-/<br><%}
				  if(rs3.getString(2)!=null && !rs3.getString(2).equals("")){%>
				<%=rs3.getString(2)%></td><%}else{%>-</td><%}
				
			}else{%>
			<td class=rptvalue >-</td>
			 <%}%>
			<td class=rptvalue ><%=countt++%></td>
		  <%String qry1="select mname,pname,panch_code,panch_name,coverage_status from rws_admn_hab_lnk_tbl   a,rws_complete_hab_view b where a.hab_code=b.panch_code and  work_id='"+wrkId+"' ";
		   rs1=stmt1.executeQuery(qry1);
		   while(rs1.next())
			{

			  if(count==1){
				
				  %>
			<td class=rptvalue ><%=rs1.getString(1)%>/<br> <%=rs1.getString(2)%>/<br><%=rs1.getString(3)%>/<br><%=rs1.getString(4)%></td>
			<td class=rptvalue ><%=rs1.getString(5)%></td>
			<%}else{
					
			  if(!prvWrkid.equals("")){
				  	if(!prvWrkid.equals(rs.getString(1))){%>
					<td class=rptvalue ><%=rs1.getString(1)%>/<br> <%=rs1.getString(2)%>/<br><%=rs1.getString(3)%>/<br><%=rs1.getString(4)%></td>
					<td class=rptvalue ><%=rs1.getString(5)%></td>
					<%}else{%>
					<td class=rptvalue colspan=10></td>
					<td class=rptvalue ><%=countt++%></td>
					<td class=rptvalue>
					<%=rs1.getString(1)%>/<br><%=rs1.getString(2)%>/<br><%=rs1.getString(3)%>/<br>
					<%=rs1.getString(4)%> </td>
					<td class=rptvalue ><%=rs1.getString(5)%></td>
					
					<%}
				}
			  
			  }%>
			</tr>
			<%
			 prvWrkid=rs.getString(1);
			  count++;
	  }
	  %>
	  </tr>
		<%
}
%>
</table>
<%
if(rs4!=null)rs4.close();
if(rs3!=null)rs3.close();
if(rs2!=null)rs2.close();
if(rs1!=null)rs1.close();	
if(stmt4!=null)stmt4.close();
if(stmt3!=null)stmt3.close();
if(stmt2!=null)stmt2.close();
if(stmt1!=null)stmt1.close();
if(rs!=null)rs.close();
if(stmt!=null)stmt.close();

}catch(Exception e)
{
  //System.out.println("Exception in Aap Report:"+e);
}
%>

