<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<!--<%@ page import="nic.watersoft.masters.RwsMasterData" %>-->
<%@ include file = "conn.jsp" %>
<%
	//Debug.println("***********************REPORT BEGINING***********************");
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	
	rDistrict = request.getParameter("district");
	////System.out.println("rdistrict "+request.getParameter("district"));
	//rMandal = request.getParameter("mandal");
	//rPanchayat = request.getParameter("panchayat");
	//rVillage = request.getParameter("village");
	//rHabitation=request.getParameter("habitation");

	rConstituency = request.getParameter("constituency");
	String query3="",query4="",query5="";
	//String districtName = (String)session.getAttribute("districtName");
	//String mandalName = (String)session.getAttribute("mandalName");
	//String panchayatName = (String)session.getAttribute("panchayatName");
	//String villageName = (String)session.getAttribute("villageName");
	//String constituencyName = (String)session.getAttribute("constituencyName");	
	//String habitationName = (String)session.getAttribute("habName");	
	
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="";
	
	if(request.getParameter("distname")!=null)
	{
	districtName = request.getParameter("distname");
	session.setAttribute("districtName",districtName);
	}
	if(request.getParameter("manname")!=null)
	{
	mandalName = request.getParameter("manname");
	session.setAttribute("mandalName",mandalName);
	}
	if(request.getParameter("panname")!=null)
	{
	panchayatName = request.getParameter("panname");
	session.setAttribute("panchayatName",panchayatName);
	}
	if(request.getParameter("vilname")!=null)
	{
	villageName = request.getParameter("vilname");
	session.setAttribute("villageName",villageName);
	}
	if(request.getParameter("conname")!=null)
	{
	constituencyName = request.getParameter("conname");	
	session.setAttribute("constituencyName",constituencyName);
	}
	if(request.getParameter("habName")!=null)
	{
	habitationName = request.getParameter("habName");
	session.setAttribute("habName",habitationName);
	}	
	
	districtName = (String)session.getAttribute("districtName");
	//mandalName = (String)session.getAttribute("mandalName");
	//panchayatName = (String)session.getAttribute("panchayatName");
	//villageName = (String)session.getAttribute("villageName");
	constituencyName = (String)session.getAttribute("constituencyName");	
	//habitationName = (String)session.getAttribute("habName");	
	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;

	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<head>
<!-- 
<script>
	window.history.forward(1);
</script>
 -->
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:history.go(-1)">Back|</a></td>
				<%--<td class="bwborder"><a href="./constituency_excelrpt.jsp?district=<%=rDistrict%>&constituency=<%=rConstituency%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>" target="_new">Excel|</a></td>--%>
			</tr>
		</table>
	</caption>
<% 
	//stmt = conn.createStatement();
    //for district
	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
	{		
	    query2="select distinct d.dcode,d.dname,count(w.work_id),sum(case when w.sanction_amount is not null then w.sanction_amount else 0 end),count (r.work_id),sum(case when r.rev_sanction_amount is not null then r.rev_sanction_amount else 0 end),count(e.work_id),sum(case when e.TS_AMOUNT is not null then e.TS_AMOUNT else 0 end),count (rev.work_id),sum(case when rev.rev_SANCTIONED_AMOUNT is not null then rev.rev_SANCTIONED_AMOUNT else 0 end)from RWS_work_admn_tbl w,RWS_REVISED_ADM_SANC_TBL r,RWS_NEW_EST_TBL e,rws_new_revised_est_tbl rev ,rws_district_tbl d where d.dcode=substr(w.office_code,2,2) and w.work_id=r.work_id(+) and w.work_id=e.work_id(+) and w.work_id=rev.work_id(+) group by d.dcode,d.dname order by d.dcode";
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
	}
	//for CONSTITUENCY
	if((rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1")) || (rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00")))
	{
		query2="select distinct div.division_office_code,div.division_office_name,count (w.work_id),sum(case when w.sanction_amount is not null then w.sanction_amount else 0 end),count(r.work_id),sum(case when r.rev_sanction_amount is not null then r.rev_sanction_amount else 0 end),count(e.work_id),sum(case when e.TS_AMOUNT is not null then e.TS_AMOUNT else 0 end),count (rev.work_id),sum(case when rev.rev_SANCTIONED_AMOUNT is not null then rev.rev_SANCTIONED_AMOUNT else 0 end) from RWS_work_admn_tbl w,RWS_REVISED_ADM_SANC_TBL r,rws_new_est_tbl e,rws_new_revised_est_tbl rev,rws_division_office_tbl div where w.work_id=r.work_id(+) and w.work_id=e.work_id(+) and w.work_id=rev.work_id(+) and div.circle_office_code=substr (w.office_code,2,2) and div.division_office_code=substr(w.office_code,4,1) and div.circle_office_code='"+rDistrict+"' group by div.division_office_code,div.division_office_name";
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
	}
	
//select distinct div.division_office_code,div.division_office_name,
//count(e.work_id),sum(case when e.SANCTIONED_AMOUNT is not null then e.SANCTIONED_AMOUNT else 0 end),
//count (w.work_id),sum(case when w.sanction_amount is not null then w.sanction_amount else 0 end),
//count(r.work_id),sum(case when r.rev_sanction_amount is not null then r.rev_sanction_amount else 0 end),
//count (rev.work_id),sum(case when rev.rev_SANCTIONED_AMOUNT is not null then rev.rev_SANCTIONED_AMOUNT else 0 end) 
//from RWS_work_admn_tbl w,RWS_REVISED_ADM_SANC_TBL r,rws_new_est_tbl e,rws_new_revised_est_tbl rev,rws_division_office_tbl div
//where w.work_id=r.work_id(+) and w.work_id=e.work_id(+) and w.work_id=rev.work_id(+) and div.circle_office_code=substr(w.office_code,2,2) 
//and div.division_office_code=substr(w.office_code,4,1) and div.circle_office_code='"+rDistrict+"' group by div.division_office_code,div.division_office_name
	
	
	rs2 = stmt1.executeQuery(query2);
%>
<%@ include file="./rws_prajapatham_workstatus_label.jsp"%>
<%	
	float totEstimateAmt=0,totEstimateSanctionAmt=0,totRevisedEstimateAmt=0,totRevisedSanctionAmt=0;
	float totAdmnSanEstimateAmt=0,totAdmnSanSanctionAmt=0,totRevAdmnSanEstimateAmt=0,totRevAdmnSanSanctionAmt=0;
	int totNoOfEstimates=0,totNoOfRevisedEstimates=0,totNoOfAdmnSanctions=0,totNoOfRevAdmnSanctions=0;
	String code="",name="";
	while(rs2.next())
	{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>

	<%	if(rDistrict != null && rDistrict.equals("00") && rConstituency.equals("-1"))
		{		
%>		
		<td class=rptValue><a href="./rws_prajapatham_workstatus_drill.jsp?distvalue=<%=rs2.getString(1)%>&distname=<%=rs2.getString(2)%>&district=<%=rs2.getString(1)%>&constituency=<%=rConstituency%>"><%=rs2.getString(2)%>
		</a></td>
<%
		}
		if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1")) 
		{			
%>		
		<td class=rptValue><a href="./rws_prajapatham_workstatus_rpt.jsp?district=<%=rDistrict%>&constituency=<%=rs2.getString(1)%>&convalue=<%=rs2.getString(1)%>&conname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a>
		</td>
<%
		}
		
		if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00")) 
		{	
			
%>		
		<td class=rptValue><a href="./rws_prajapatham_workstatus_rpt.jsp?district=<%=rDistrict%>&constituency=<%=rs2.getString(1)%>&convalue=<%=rs2.getString(1)%>&conname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a>
		</td>
<%
		}
%>
		 <td class=rptValue align="right"><%=rs2.getInt(3)%></td>
		 <% totNoOfAdmnSanctions+=rs2.getInt(3); %>
			
		<td class=rptValue align="right"><%=rs2.getFloat(4)%></td>
		<% totAdmnSanSanctionAmt+=rs2.getFloat(4); %>

			
		<td class=rptValue align="right"><%=rs2.getInt(5)%></td>
		<% totNoOfRevAdmnSanctions+=rs2.getInt(5); %>
			
		<% totRevAdmnSanEstimateAmt+=rs2.getFloat(6); %>
		<td class=rptValue align="right"><%=rs2.getFloat(6)%></td>
			
			
		 <td class=rptValue align="right"><%=rs2.getInt(7)%></td>
		 <% totNoOfEstimates+=rs2.getInt(7); %>
		  	
		 <% totEstimateAmt+=rs2.getFloat(8); %>
		 <td class=rptValue align="right"><%=rs2.getFloat(8)%></td>
			
			
		 <td class=rptValue align="right"><%=rs2.getInt(9)%></td>
		 <% totNoOfRevisedEstimates+=rs2.getInt(9); %>
			
			
		 <td class=rptValue align="right"><%=rs2.getFloat(10)%></td>
		 <% totRevisedSanctionAmt+=rs2.getFloat(10); %>
		 
		 </tr>
<%
	}
%>
			<tr class="btext">
			  <td class=btext colspan=2>GrandTotal</td>
			  <td class=btext align="right"><%=totNoOfAdmnSanctions%></td>
			  <td class=btext align="right"><%=Math.round(totAdmnSanSanctionAmt*100)/100f%></td>
              <td class=btext align="right"><%=totNoOfRevAdmnSanctions%></td>
			  <td class=btext align="right"><%=Math.round(totRevAdmnSanEstimateAmt*100)/100f%></td>
			  <td class=btext align="right"><%=totNoOfEstimates%></td>
			  <td class=btext align="right"><%=Math.round(totEstimateAmt*100)/100f%></td>
			  <td class=btext align="right"><%=totNoOfRevisedEstimates%></td>
			  <td class=btext align="right"><%=Math.round(totRevisedSanctionAmt*100)/100f%></td>
			</tr>
			<% if(slno==0){%><tr><td class="rptValue" colspan="18" align="center"><a href="./rws_prajapatham_workstatus_select.jsp"><b>No Records</b></a></td></tr><%}
			rs2.close();
%>
</tr>
</table>
<%
		
}
	
catch(Exception e)
{
	//Debug.println("Exception in drill is "+e);
	e.printStackTrace();
}
finally
{

	if(conn!=null)
	conn.close();
}
%>

</form>
</body>
</html>
