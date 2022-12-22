<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
	
	String rDistrict=null, rProgramme=null,rProg=null,dcode=null, panchcode=null, mancode=null,distcode=null,habcode=null;
	//rDistrict = request.getParameter("district");
	//out.println("district"+rDistrict);
	//dcode = request.getParameter("dcode1");
	//out.println("dcode"+dcode);
	//mancode = request.getParameter("mcode");
   // out.println("mannnn"+mancode);
	//distcode = request.getParameter("dcode");
	//out.println("disttttttt"+distcode);
	//panchcode=request.getParameter("pcode");
	
	//rProgramme = request.getParameter("program");
	//out.println("proggRA"+rProgramme);
	// rProg = request.getParameter("prog");
	 habcode=request.getParameter("habcode");
	
	String districtName = (String)session.getAttribute("circleName");
	String mandalName = (String)session.getAttribute("prName");
	
	
	
	String query=null, query1 = null,query2=null,query3=null;
	ResultSet rs3 = null;
	ResultSet rs2 = null;
	Statement stmt3 = null;
	Statement stmt1 = null;
	//PreparedStatement ps = null;
	int total=0;
	int i = 0;
	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<body bgcolor="white" class="mystyle">

<form method="post">
<table width="100%">
<tr><td>
<font size="1px"  color="blue">
<div align="left" >
<%if(districtName!=null && !districtName.equals("null")){ %>
District: &nbsp;&nbsp;<%= districtName %>&nbsp;&nbsp;&nbsp;
<%}%>
<%if(mandalName!=null && !mandalName.equals("null")) {%>
Program: &nbsp;&nbsp;<%= mandalName %>&nbsp;&nbsp;&nbsp;
<%}
%>

</div></font>
</td></tr>
<tr><td align="right" colspan="20"><a href="/pred/home.jsp?loginMode=prajapatham">Home &nbsp;|</a>&nbsp;<a href="rws_programmes_frm.jsp">Back</a></td></tr>
</table>
<%
    //if(rDistrict!=null && rDistrict.equals("0") && rProgramme!=null && rProgramme.equals("0"))
			//{ 
	//if(dcode==null && rProg==null)
				//{%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "left">
<tr><td colspan="50" align="center" class="rptLabel">Habitation Details</td></tr>
<tr>
<td class="rptLabel">HabitationCode</td>
<td class="rptLabel">CPWS</td>
<td class="rptLabel">PWS</td>
<td class="rptLabel" width="110">Direct Pumping</td>
<td class="rptLabel" width="90">Bore Wells</td>
<td class="rptLabel">Others</td>
<td class="rptLabel" width="100">Any Other Schemes</td>
<td class="rptLabel" width="100">Coverage Status</td>
</tr>
<% 
	 
	query2="SELECT distinct nvl(DECODE(PE.EXIST_CPWS,'Y','Yes','N',''),'--'),nvl(DECODE(PE.EXIST_PWS ,'Y','Yes','N',''),'--'),nvl(DECODE(PE.EXIST_DIRECT_PUMPING ,'Y','Yes','N',''),'--'),nvl(DECODE(PE.EXIST_BOREWELLS ,'Y','Yes','N',''),'--'),nvl(DECODE(PE.EXIST_OTHERS ,'Y','Yes','N',''),'--'),nvl(PE.OTHER_DETAILS,'--'),nvl(HD.COVERAGE_STATUS,'--'),P.HAB_CODE,pr.panch_name FROM rws_panchayat_raj_tbl pr,RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and pr.panch_code=P.hab_code and P.hab_code='"+habcode+"'";

	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2 = stmt1.executeQuery(query2);
	
	if(rs2.next())
	{%>
	<tr>
        <td class=rptValue><%=rs2.getString(8)+'-'%><%=rs2.getString(9)%></td>
		<td class=rptValue><%=rs2.getString(1)%></td>
		<td class=rptValue><%=rs2.getString(2)%></td>
		<td class=rptValue><%=rs2.getString(3)%></td>
		<td class=rptValue><%=rs2.getString(4)%></td>
		<td class=rptValue><%=rs2.getString(5)%></td>
		<td class=rptValue><%=rs2.getString(6)%></td>
		<td class=rptValue><%=rs2.getString(7)%></td>
		
		</tr>
		
<% 
		//habcode=rs2.getString(8);	
		
		} 
	//stmt1.close();
	//rs2.close();
	%>

<tr>
<td colspan="50">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center" >
<tr>
<td class=rptLabel colspan="15" align="center">Work Details-<%=rs2.getString(9)%></td>
</tr>
<tr>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel rowspan="1"  width="550" align="center">Name Of The Work</td>
<td class="rptLabel" width="80">Estimated Cost (Rs.In Lakhs)</td>
 <td class="rptLabel" width="120">Admin Sanction Ref.No</td>
 <td class="rptLabel">Admin Sanction Date</td>
 <td class="rptLabel">Sanctioned At</td>
 <td class="rptLabel">Date Of Grounding</td>
 <td class="rptLabel">Date Of Completion</td>
 <td class="rptLabel">Exp. Incurred Upto The Prev.Month(Rs.in Lakhs)</td>
 <td class="rptLabel">Exp. Incurred During The Month(Rs.in Lakhs)</td>
 <td class="rptLabel">Total Expenditure(Rs.in Lakhs)</td>
 <td class="rptLabel">Value Of Workdone by But Not Paid (Rs.in Lakhs)</td>
 <td class="rptLabel">Physical Stage Of Work</td>
 <td class="rptLabel">Remarks</td>
</tr>
<%

		 query2="SELECT DISTINCT P.WORK_ID,nvl(UPPER(P.WORK_NAME),'--')WORK_NAME ,P.DCODE,P.MCODE,P.HAB_CODE,nvl(P.WORK_NAME,'--'),P.ESTIMATE_COST,P.SANCTIONED_AT, P.PROGRAMME_CODE,P.SUBPROGRAMME_CODE,P.ADMN_SANC_NO, nvl(to_char(P.ADMN_SANC_DATE,'DD-MON-YY'),'--')ADMN_SANC_DATE ,P.ADMN_SANC_NO,nvl(to_char(P.GROUND_DATE,'DD-MON-YY'),'--')GROUND_DATE ,nvl(to_char(P.COMPLETION_DATE,'DD-MON-YY'),'--')COMPLETION_DATE,P.EXP_UPTO_THE_PRE_MONTH,EXP_DUR_THE_MONTH,EXP_TO_BE_INCURRED,nvl(UPPER(PHY_STAGE_OF_WORK),'--')PHY_STAGE_OF_WORK,nvl(UPPER(P.REMARKS),'--')REMARKS, DECODE(PE.EXIST_CPWS ,'Y','Yes','N',''),DECODE(PE.EXIST_PWS ,'Y','Yes','N',''),DECODE(PE.EXIST_DIRECT_PUMPING ,'Y','Yes','N',''),DECODE(PE.EXIST_BOREWELLS ,'Y','Yes','N',''),DECODE(PE.EXIST_OTHERS ,'Y','Yes','N',''),PE.OTHER_DETAILS,HD.COVERAGE_STATUS FROM RWS_HABITATION_DIRECTORY_TBL HD,RWS_PRAJAPADAM_TBL P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,rws_district_tbl d WHERE P.HAB_CODE=PE.HAB_CODE and substr(P.hab_code,1,2)=d.dcode AND HD.HAB_CODE=P.HAB_CODE and P.hab_code='"+habcode+"' order by P.WORK_ID";
		
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs2 = stmt1.executeQuery(query2);
		int slno = 0;
	while(rs2.next())
	{
		
		++ slno;
		
			
%>		<tr>
       
		<td class=rptValue><%=slno%></td>
		<td class=rptValue ><%=rs2.getString("WORK_NAME")%></td>
		<td class=rptValue><%=rs2.getFloat("ESTIMATE_COST")%></td>
		<td class=rptValue><%=rs2.getString("ADMN_SANC_NO")%></td>
		<td class=rptValue width="50"><%=rs2.getString("ADMN_SANC_DATE")%></td>
		<td class=rptValue width="50"><%=rs2.getString("SANCTIONED_AT")%></td>
		<td class=rptValue><%=rs2.getString("GROUND_DATE")%></td>
		<td class=rptValue><%=rs2.getString("COMPLETION_DATE")%></td>
		<td class=rptValue><%=rs2.getFloat("EXP_UPTO_THE_PRE_MONTH")%></td>
		<td class=rptValue><%=rs2.getFloat("EXP_DUR_THE_MONTH")%></td>
		<td class=rptValue><%=rs2.getFloat("EXP_DUR_THE_MONTH")+rs2.getFloat("EXP_UPTO_THE_PRE_MONTH")%>
		</td>
		<td class=rptValue><%=rs2.getFloat("EXP_TO_BE_INCURRED")%></td>
		<td class=rptValue><%=rs2.getString("PHY_STAGE_OF_WORK")%></td>
		<td class=rptValue><%=rs2.getString("REMARKS")%></td>
		</tr>
		<%
	}
}

//}
//}

catch(Exception e)
{
//System.out.println("Exception is "+e);
	//e.printStackTrace();
}
finally
{
	conn.close();
	
	
}
%>
</table>
</div>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>