<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
Statement st2 = null,st22=null,ss1=null;
ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null;
	//String[] record = null;
		int Count=0,Cnt=0,slno=0,sl=0,Counts=0,no=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
	
	
	

try
{
	
	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),count(ln.hab_code),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name from RWS_WORK_ADMN_TBL w,RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_circle_office_tbl c where substr(w.office_code,2,2)=c.circle_office_code and w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and w.programme_code=p.programme_code  and  substr(w.office_code,2,2)='"+dCode+"' group by nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name";*/

	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id(+)=prg.work_id and w.programme_code=prg.programme_code and substr(w.office_code,2,2)='"+dCode+"'" ;*/

     query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+)  and substr(w.office_code,2,2)='"+dCode+"'";


 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);


 rs = stmt.executeQuery(query);
rs.setFetchSize(500);
 rs.last();
Count = rs.getRow();
rs.beforeFirst();%>

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_admn_status_form.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Administrative Sanction Report</font></td>	
	</tr>
<% 
	
		
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=12>District: <%=dName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" align=center>
		<td  class= "btext">S.NO</td>
		<td class="btext">WorkId/WorkName</td>
		<td class="btext" >ProgrammeName</td>
		<td class="btext" >Sanction<br>Amt(Rs In Lakhs)</td>
		<td class="btext"  >SanctionNo/SanctionDate</td>
	    <td class="btext"  >No Of Habs</td>
		<td class="btext"  >Habitations</td>
		<td class="btext" >Plain<br>Pop</td>
		<td class="btext" >SC<br>Pop</td>
		<td class="btext" >ST<br>Pop</td>
		<td class="btext" >Total</td>
		<td class="btext" >CoverageStatus</td>
		</tr>
		
		
	
<%	
	if(Count!=0)
	{
	while(rs.next())
	{
	%>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue  ><%=++slno%></td>			
		<td class=rptValue  ><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>
	   
		
		<%
         int sno=0,habs=1,habs1=0,serial=0,ha=1;
		String qury1="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+rs.getString(2)+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";

        rs1 = st1.executeQuery(qury1);
        //rs1.setFetchSize(500);
		rs1.last();
		habs1=rs1.getRow();
		
		if(habs1!=0)
		{
		//out.println("habs"+habs1);
	    rs1.beforeFirst();
		while(rs1.next())
		{
			sno++;
			if(habs==habs1)
			{
			
			String qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_prog_lnk_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' and prg.programme_code='"+rs1.getString(1)+"'  order by pr.panch_code";
        rs2 = st2.executeQuery(qury2);
        rs2.setFetchSize(500);
        rs2.beforeFirst();
			}
		%>
		
		<td class="rptValue" ><%=sno%>.&nbsp;<%=rs1.getString(2)%></td>
		<td class="rptValue" ><%=rs1.getFloat(3)%></td>	
		<td class="rptValue" ><%=rs1.getString(5)%>&nbsp;/ &nbsp;<%=rs1.getString(4)%></td>
		<% if(habs==habs1)
			{ %>
		<!--<td class=rptValue align="center"><b><%=rs1.getInt(6)%></b></td>-->
		
         <% 
			while(rs2.next())
		{
			no++;
			if(no==1)
			{
			%>
			
		<!--<td class=rptValue ><%=no%>.&nbsp;<%=rs2.getString(2)%></td>
		
		<td class=rptValue align="center"><%=rs2.getInt(3)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(4)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(5)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(6)%></td>-->
		
		</tr>
		
	  <% 
			}
	   else
			{%>
			<!--<tr><td colspan=6></td>
			<td class=rptValue ><%=no%>.&nbsp;<%=rs2.getString(2)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(3)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(4)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(5)%></td>
		<td class=rptValue align="center"><%=rs2.getInt(6)%></td>
		<!--<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>-->
			</tr>
              <% } } } 
		 else
			{%>
			<td colspan=6></td>
			
		<% }	%>
		</tr>
		<tr>
		<td colspan=2>
		</tr>
<% habs++; 
}
		}
		
		
           //out.println("in else");
			String q="select distinct w.programme_code,p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+rs.getString(2)+"' group by w.programme_code, p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0') order by nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";

        rr = ss.executeQuery(q);
	
        rr.setFetchSize(500);
		rr.last();
		habs1=rr.getRow();
		//out.println("habs1");
		if(habs1!=0)
		{
		rr.beforeFirst();
		while(rr.next())
		{
			//out.println("in while");
            //out.println("habs1");
			sno++;
			if(ha==habs1)
			{
			
			String qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' and w.programme_code='"+rr.getString(1)+"'  order by pr.panch_code";
        rss = st2.executeQuery(qury2);
        rss.setFetchSize(500);
        rss.beforeFirst();
			}
		%>
		
		<td class="rptValue" ><%=sno%>.&nbsp;<%=rr.getString(2)%></td>
		<td class="rptValue" ><%=rr.getFloat(3)%></td>	
		<td class="rptValue" ><%=rr.getString(5)%>&nbsp;/ &nbsp;<%=rr.getString(4)%></td>
		<% if(ha==habs1)
			{ %>
		<td class=rptValue  align="center"><b><%=rr.getInt(6)%></b></td>
         <% 
			while(rss.next())
		{
			serial++;
		
			if(serial==1)
			{
				//out.println("in if");
			%>
		<td class=rptValue><%=serial%>.&nbsp;<%=rss.getString(2)%></td>
		<td class=rptValue   align="center"><%=rss.getInt(3)%></td>
		<td class=rptValue  align="center"><%=rss.getInt(4)%></td>
		<td class=rptValue  align="center"><%=rss.getInt(5)%></td>
		<td class=rptValue align="center"><%=rss.getInt(6)%></td>
		<td class=rptValue align="center"><%=rss.getString(7)%></td>
		</tr>
		
	  <% 
			}
	   else
			{
		   //out.println("in if else");
		   %>
			<tr><td colspan=6></td>
			<td class=rptValue ><%=serial%>.&nbsp;<%=rss.getString(2)%></td>
		<td class=rptValue align="center"><%=rss.getInt(3)%></td>
		<td class=rptValue align="center"><%=rss.getInt(4)%></td>
		<td class=rptValue align="center"><%=rss.getInt(5)%></td>
		<td class=rptValue align="center"><%=rss.getInt(6)%></td>
		<td class=rptValue align="center"><%=rss.getString(7)%></td>
			</tr>
              <% } } } 
		 else
			{
			 
			 %>
			<td colspan=6></td>
			
		<% }	%>
		</tr>
		<tr>
		<td colspan=2>
		</tr>
<% ha++; 
}
		}
	
//********************************************************************************************

String q1="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_REVISED_ADM_SANC_TBL w,rws_revised_adm_prog_lnk_tbl prg where w.work_id=prg.work_id(+) and w.work_id='"+rs.getString(2)+"'";

 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 s2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 ss1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st22 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

r= s.executeQuery(q1);
r.setFetchSize(500);
 r.last();
Counts = r.getRow();
// System.out.println("Total Records = "+Count);
r.beforeFirst();
if(Counts!=0)
		{
	while(r.next())
			{
%>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue  ></td>			
		<td class=rptValue  ><b><%=r.getString(2)%><br>(Revised To)</br></b></td>
	
		
		<%
          int sn=0,habss=1,habss1=0,serials=0,no1=0,haa=1;
		String q2="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"' group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
        r1 = s1.executeQuery(q2);
        r1.setFetchSize(500);
		r1.last();
		habss1=r1.getRow();
		//out.println("habs"+habs1);
		if(habss1!=0)
				{
        r1.beforeFirst();
		
		while(r1.next())
		{
			sn++;
			if(habss==habss1)
			{
			
			String q3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_revised_adm_prog_lnk_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+r.getString(1)+"' and prg.programme_code='"+r1.getString(1)+"'  order by pr.panch_code";
        r2 = s2.executeQuery(q3);
        r2.setFetchSize(500);
        r2.beforeFirst();
			}
		%>
		
		<td class="rptValue" ><%=sn%>.&nbsp;<%=r1.getString(2)%></td>
		<td class="rptValue" ><%=r1.getFloat(3)%></td>	
		<td class="rptValue"><%=r1.getString(5)%>&nbsp;/ &nbsp;<%=r1.getString(4)%></td>
		<% if(habss==habss1)
			{ %>
		<!--<td class=rptValue align="center"><b><%=r1.getInt(6)%></b></td>-->
         <% 
			while(r2.next())
		{
			serials++;
			if(serials==1)
			{
			%>
		<!--<td class=rptValue ><%=serials%>.&nbsp;<%=r2.getString(2)%></td>
		<td class=rptValue align="center"><%=r2.getInt(3)%></td>
		<td class=rptValue align="center"><%=r2.getInt(4)%></td>
		<td class=rptValue align="center"><%=r2.getInt(5)%></td>
		<td class=rptValue align="center"><%=r2.getInt(6)%></td>-->
		</tr>
		
	  <% 
			}
	   else
			{%>
			<!--<tr><td colspan=6></td>
			<td class=rptValue ><%=serials%>.&nbsp;<%=r2.getString(2)%></td>
		<td class=rptValue align="center"><%=r2.getInt(3)%></td>
		<td class=rptValue align="center"><%=r2.getInt(4)%></td>
		<td class=rptValue align="center"><%=r2.getInt(5)%></td>
		<td class=rptValue align="center"><%=r2.getInt(6)%></td>-->
			</tr>
              <% } } } 
		 else
			{%>
			<td colspan=6></td>
			
		<% }	%>
		</tr>
		<tr>
		<td colspan=2>
		</tr>
<% habss++; 
}
			}

			           //out.println("in else");
			String q4="select distinct w.programme_code,p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE ,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,RWS_REVISED_ADM_SANC_TBL  w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+rs.getString(2)+"' group by w.programme_code, p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0') order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";

        rr1 = ss1.executeQuery(q4);
	
        rr1.setFetchSize(500);
		rr1.last();
		habss1=rr1.getRow();
		//out.println("habs1");
		if(habss1!=0)
		{
		rr1.beforeFirst();
		while(rr1.next())
		{
			//out.println("in while");
            //out.println("habs1");
			sn++;
			if(haa==habss1)
			{
			
			String qury3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' and w.programme_code='"+rr1.getString(1)+"'  order by pr.panch_code";
        rss1 = st22.executeQuery(qury3);
        rss1.setFetchSize(500);
        rss1.beforeFirst();
			}
		%>
		
		<td class="rptValue" ><%=sn%>.&nbsp;<%=rr1.getString(2)%></td>
		<td class="rptValue" ><%=rr1.getFloat(3)%></td>	
		<td class="rptValue"><%=rr1.getString(5)%>&nbsp;/ &nbsp;<%=rr1.getString(4)%></td>
		<% if(haa==habss1)
			{ %>
		<td class=rptValue align="center"><b><%=rr1.getInt(6)%></b></td>
         <% 
			while(rss1.next())
		{
			no1++;
		
			if(no1==1)
			{
				//out.println("in if");
			%>
		<td class=rptValue ><%=no1%>.&nbsp;<%=rss1.getString(2)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(3)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(4)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(5)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(6)%></td>
		<td class=rptValue align="center"><%=rss1.getString(7)%></td>
		</tr>
		
	  <% 
			}
	   else
			{
		   //out.println("in if else");
		   %>
			<tr><td colspan=6></td>
			<td class=rptValue ><%=no1%>.&nbsp;<%=rss1.getString(2)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(3)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(4)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(5)%></td>
		<td class=rptValue align="center"><%=rss1.getInt(6)%></td>
		<td class=rptValue align="center"><%=rss1.getString(7)%></td>
			</tr>
              <% } } } 
		 else
			{
			 
			 %>
			<td colspan=6></td>
			
		<% }	%>
		</tr>
		<tr>
		<td colspan=2>
		</tr>
<% haa++; 
}
		}

		}
		}
//********************************************************************************
}//end of main while

	}
else
	{%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=7 align=center><a href="./rws_admn_status_form.jsp"><b>No Records</b></a></td>
		</tr>
		<% }
}
catch(Exception e)
{
	e.printStackTrace();
}
	finally
	{
	conn.close();
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> 
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
