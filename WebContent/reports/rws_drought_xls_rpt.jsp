<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
    //String dname=(String)session.getAttribute("dname");
	StringBuffer dname = null;
	dname=new StringBuffer(String.valueOf(session.getAttribute("dname")));

	//String y1=(String)session.getAttribute("year1");
	StringBuffer y1 = null;
	y1=new StringBuffer(String.valueOf(session.getAttribute("year1")));

	
	//String dcode=(String)session.getAttribute("dcode");
	StringBuffer dcode = null;
	dcode=new StringBuffer(String.valueOf(session.getAttribute("dcode")));

	
	//String gtxidValueOld = "",gtxidValue="";
	StringBuffer gtxidValueOld=new StringBuffer();
	StringBuffer gtxidValue=new StringBuffer();
	
	int sno=1;
	int tot=0;
	int j=0;
	
	StringBuffer qry=new StringBuffer();
	StringBuffer gqry=new StringBuffer();
	
	
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>

	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading"  colspan=20> Contingency Plan-Drought Habitations Report - <%=y1%> </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	 <%if(dname.toString().equals("ALL")){%>
	<td class=btext colspan=26>District:<font color="red"><%=dname%></font> </td>
	<%}else{ %>
	<td class=btext colspan=25>District:<font color="red"><%=dname%></font> </td>
	<%} %>
	</tr>
	<tr align=center>
	
	<td class=btext rowspan = 3>Sl.No</td>
    <td class=btext  rowspan = 3 nowrap>Mandal</td>
     <td class=btext  rowspan = 3 nowrap>Panchayat</td>
	<td class=btext  rowspan = 3 nowrap>HabitationName</td>
	<td class=btext  rowspan = 3 nowrap>HabitationCode</td>
	<td class=btext  rowspan = 3 nowrap>Scarcity Name</td>
	<td class=btext  colspan=2 nowrap>Transportation</td>
 
	<td class=btext  colspan=2 nowrap>Hiring of Private Sources</td>
	
	<td class=btext  colspan = 2 nowrap>Flushing of BW</td>
	
	<td class=btext  colspan = 2 nowrap>Deepening of OW<br>(Includes Flushing)</td>
	
    <td class=btext  colspan = 2 nowrap>Deepening of OW</td>
	
     	<td class=btext  colspan = 2 nowrap>Anticipated max.period for <br>Trans/Hiring</td>
	<td class=btext  colspan =3 nowrap>Filling of SS Tanks</td>
<td class=btext  rowspan = 3 nowrap>Power Problem</td>
<td class=btext  rowspan = 3 nowrap>Power Estimate</td>
	
<td class=btext  colspan = 2 nowrap>Measures To Tackle Scarcity <br>permanently </td>

	
		<td class=btext  rowspan = 3 nowrap>Remarks</td>
	</tr>
	<tr>
	<td class=btext  rowspan = 2 nowrap align="center">Trans <br></br> Yes/No</td>
	<td class=btext  rowspan = 2 nowrap>Transport Estimate</td>
	<td class=btext  rowspan = 2 nowrap>Hiring of Sources</td>
	<td class=btext  rowspan = 2 nowrap>Hiring Estimate</td>
	<td class=btext  rowspan = 2 nowrap>Flushing</td>
	<td class=btext  rowspan = 2 nowrap>Flushing Estimate</td>
<td class=btext  rowspan = 2 nowrap>Deepening</td>
	<td class=btext  rowspan = 2 nowrap>Deepening Estimate</td>
	
	<td class=btext  rowspan = 2 nowrap>Deepening OW</td>
	<td class=btext  rowspan = 2 nowrap>Deepening OW Estimate</td>
	<td class=btext  rowspan = 2 nowrap>From Date</td>
	<td class=btext  rowspan = 2 nowrap>To Date</td>
	
	<td class=btext  rowspan = 2 nowrap>SST NUM</td>
	<td class=btext  rowspan = 2 nowrap>SST EST</td>
	<td class=btext  rowspan = 2 nowrap>SCHEME</td>
	<td class=btext  rowspan = 2 nowrap>Type Of Work</td>
	<td class=btext  rowspan = 2 nowrap>Work Estimate Cost</td>
	
	</tr>
	
	
	<tr>
<%

	
	try
	{
		String qry1="";
		PreparedStatement pstmt1=null;
		ResultSet rs3=null;
		//System.out.println("hello"+dis);
		
		if(dname.toString().equals("ALL")){
			//System.out.println("hellofdfffff"+dis+rs3);
			qry1="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
			pstmt1 = conn.prepareStatement(qry1);
			//System.out.println("helloaaaaaaaaaaaaaaaa"+dis+rs3);
			 rs3 = pstmt1.executeQuery();
			 
			//System.out.println("hellobbbbbbbbbbb"+dis+rs3);
					while(rs3.next())
					{
						//System.out.println("hellobbbbbbbbbbb"+rs3.getString("dname"));
						%>
						 <tr align=center>
		<td class=btext colspan=25>District:<font color="red"><%=rs3.getString("dname")%></font> </td>
		</tr>
						<%
						gqry.delete(0,gqry.length());
						gqry.append("select a.SCARCITY_CODE,decode(transportation,'Y','Yes','N','No'),nvl(transport_est,0),nvl(hiring_of_sources,'0'),nvl(hiring_est,0),nvl(flushing,'0'),nvl(flushing_est,0),nvl(deepening,'0'),nvl(deepening_est,0),nvl(to_char(frm_date,'dd/mm/yyyy'),'-'),nvl(to_char(to_date,'dd/mm/yyyy'),'-'),nvl(DEEP_OW_NUM,0),nvl(DEEP_OW_EST,0) ,nvl(SST_NUM,0),nvl(SST_EST,0) ,nvl(SST_SCHEME,'-'),decode(power_problem,'Y','Yes','N','No'),nvl(power_est,0),nvl(decode(type_of_work,'AUG','AUG','EXTN','EXTN','PWS','PWS','CPWS','CPWS','OTHERS','OTHERS'),'-'),nvl(work_est_cost,0),nvl(remarks,'-'),c.panch_name,a.habcode,c.mname,c.pname from rws_drought_habitation_tbl a,rws_complete_hab_view c where  c.panch_code=a.habcode  and substr(habcode,1,2)='"+rs3.getString("dcode")+"'  and year='"+y1+"'");
							
					    // ////System.out.println("query1111**********"+gqry);
						
						Statement	stmt8=conn.createStatement();
						Statement	stmt2=conn.createStatement();
					    
						ResultSet rs8=stmt8.executeQuery(gqry.toString());
						StringBuffer q2=new StringBuffer();
							while (rs8.next())
							{
								
								q2.delete(0,q2.length());
								q2.append("select SCARCITY_NAME  from RWS_DROUGHT_SCAR_REASONS_TBL where SCARCITY_CODE='"+rs8.getString(1)+"'");

						 
						   ResultSet rs2=stmt2.executeQuery(q2.toString());




							j++;
						%>
						<tr>
						
						
						
						
					  

						<td class="rptValue"><%=sno++%></td>
					    <td class="rptValue"><%=rs8.getString(24)%></td>
					    <td class="rptValue"><%=rs8.getString("pname")%></td>
						<td class="rptValue"><%=rs8.getString(22)%></td><!-- bhagya -->
					<td class="rptValue"><%=rs8.getString(23)%>&nbsp</td>
					<% if(rs2.next()){ %>
						<td class="rptValue"><%=rs2.getString(1)%></td>
					<%} else{ %>
					<td class="rptValue">-</td>
					<%} %>
						<td class="rptValue"><%=rs8.getString(2)%></td>
					    <td class="rptValue"><%=rs8.getString(3) %></td>
						<td class="rptValue"><%=rs8.getString(4)%></td>
						<td class="rptValue"><%=rs8.getString(5)%></td>
						<td class="rptValue"><%=rs8.getString(6)%></td>
						<td class="rptValue"><%=rs8.getString(7)%></td>
						<td class="rptValue"><%=rs8.getString(8)%></td>
						<td class="rptValue"><%=rs8.getString(9)%></td>
							<td class="rptValue"><%=rs8.getString(12)%></td>
						<td class="rptValue"><%=rs8.getString(13)%></td>
						<td class="rptValue"><%=rs8.getString(10)%></td>
						<td class="rptValue"><%=rs8.getString(11)%></td>
						
						<td class="rptValue"><%=rs8.getString(14)%></td>
						<td class="rptValue"><%=rs8.getString(15)%></td>
						<td class="rptValue"><%=rs8.getString(16)%></td>
					<td class="rptValue"><%=rs8.getString(17)%></td>
						<td class="rptValue"><%=rs8.getString(18)%></td>


						<td class="rptValue"><%=rs8.getString(19)%></td>
						<td class="rptValue"><%=rs8.getString(20)%></td>
						<td class="rptValue"><%=rs8.getString(21)%></td>
						
						
						</tr>
						
						
					<%
						
						
						if(j==0)
						{%>
						<tr>
						<td colspan=7 align="center">No Records</td>
						</tr>
						
						<%}
							rs2.close();
							
							}
							stmt2.close();
							rs8.close();
							stmt8.close();
							
					}	
					pstmt1.close();
					rs3.close();
		}else{
		gqry.append("select a.SCARCITY_CODE,decode(transportation,'Y','Yes','N','No'),nvl(transport_est,0),nvl(hiring_of_sources,'0'),nvl(hiring_est,0),nvl(flushing,'0'),nvl(flushing_est,0),nvl(deepening,'0'),nvl(deepening_est,0),nvl(to_char(frm_date,'dd/mm/yyyy'),'-'),nvl(to_char(to_date,'dd/mm/yyyy'),'-'),nvl(DEEP_OW_NUM,0),nvl(DEEP_OW_EST,0) ,nvl(SST_NUM,0),nvl(SST_EST,0) ,nvl(SST_SCHEME,'-'),decode(power_problem,'Y','Yes','N','No'),nvl(power_est,0),nvl(decode(type_of_work,'AUG','AUG','EXTN','EXTN','PWS','PWS','CPWS','CPWS','OTHERS','OTHERS'),'-'),nvl(work_est_cost,0),nvl(remarks,'-'),c.panch_name,a.habcode,c.mname,c.pname from rws_drought_habitation_tbl a,rws_complete_hab_view c where  c.panch_code=a.habcode  and substr(habcode,1,2)='"+dcode+"'  and year='"+y1+"'");
			
	    // ////System.out.println("query1111**********"+gqry);
		
		Statement	stmt8=conn.createStatement();
		Statement	stmt2=conn.createStatement();
	    
		ResultSet rs8=stmt8.executeQuery(gqry.toString());
		StringBuffer q2=new StringBuffer();
			while (rs8.next())
			{
				
				q2.delete(0,q2.length());
				q2.append("select SCARCITY_NAME  from RWS_DROUGHT_SCAR_REASONS_TBL where SCARCITY_CODE='"+rs8.getString(1)+"'");

		 
		   ResultSet rs2=stmt2.executeQuery(q2.toString());




			j++;
		%>
		<tr>
		
		
		
		
	  

		<td class="rptValue"><%=sno++%></td>
	    <td class="rptValue"><%=rs8.getString(24)%></td>
	    <td class="rptValue"><%=rs8.getString("pname")%></td>
		<td class="rptValue"><%=rs8.getString(22)%></td><!-- bhagya -->
					<td class="rptValue"><%=rs8.getString(23)%>&nbsp</td>
	<% if(rs2.next()){ %>
		<td class="rptValue"><%=rs2.getString(1)%></td>
	<%} else{ %>
	<td class="rptValue">-</td>
	<%} %>
		<td class="rptValue"><%=rs8.getString(2)%></td>
	    <td class="rptValue"><%=rs8.getString(3) %></td>
		<td class="rptValue"><%=rs8.getString(4)%></td>
		<td class="rptValue"><%=rs8.getString(5)%></td>
		<td class="rptValue"><%=rs8.getString(6)%></td>
		<td class="rptValue"><%=rs8.getString(7)%></td>
		<td class="rptValue"><%=rs8.getString(8)%></td>
		<td class="rptValue"><%=rs8.getString(9)%></td>
			<td class="rptValue"><%=rs8.getString(12)%></td>
		<td class="rptValue"><%=rs8.getString(13)%></td>
		<td class="rptValue"><%=rs8.getString(10)%></td>
		<td class="rptValue"><%=rs8.getString(11)%></td>
		
		<td class="rptValue"><%=rs8.getString(14)%></td>
		<td class="rptValue"><%=rs8.getString(15)%></td>
		<td class="rptValue"><%=rs8.getString(16)%></td>
	<td class="rptValue"><%=rs8.getString(17)%></td>
		<td class="rptValue"><%=rs8.getString(18)%></td>


		<td class="rptValue"><%=rs8.getString(19)%></td>
		<td class="rptValue"><%=rs8.getString(20)%></td>
		<td class="rptValue"><%=rs8.getString(21)%></td>
		
		
		</tr>
		
		
	<%
		}
		
		if(j==0)
		{%>
		<tr>
		<td colspan=7 align="center">No Records</td>
		</tr>
		
		<%}
		
		}
	}catch(Exception e)
			{
		e.printStackTrace();
			////System.out.println("error::"+e);
			}finally{
				  if(conn!=null){
					   conn.close();
						  }
					   }
			%>
	</table>
  
