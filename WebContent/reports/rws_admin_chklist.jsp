

	<%
	 int pre=0;
     int aval=0;
    try
    {
      query ="select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-'),type_of_asset from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+)  and w.work_id='"+wCode+"'";
//System.out.println("in admin qqqqq:"+query);
	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	  rs = stmt.executeQuery(query);
	  rs.setFetchSize(500);
	  rs.last();
	  Count = rs.getRow();
	  rs.beforeFirst();
	  
	  %>
	  <br><br>
		
	<table >
		<tr>
			<td style="text-align: left;" class="rptHeading" colspan=8>&nbsp;I.&nbsp;Administrative Sanction Details </td>	
		</tr>
	
<%	
	if(Count!=0)
	{
	while(rs.next())
	{
			String aqury1="";
		//System.out.println("in admin qqqqq:"+rs.getString(3));
	    int asno=0,ahabs=1,ahabs1=0,aserial=0,aha=1;
		if(rs.getString(3).equals("11"))
		{
           aqury1="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_work_school_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
		else if(rs.getString(3).equals("12"))
		{
		   aqury1="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.lab_code) from RWS_work_lab_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
		else
		{
			aqury1="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
//System.out.println("in admin qqqqq:2222"+aqury1);
        rs1 = st1.executeQuery(aqury1);
        
        //rs1.setFetchSize(500);
		rs1.last();
		ahabs1=rs1.getRow();
	//	System.out.println("admin programe check in programe link display:"+ahabs1);
		if(ahabs1!=0)
		{
		   rs1.beforeFirst();	  
			while(rs1.next())
			{
			  session.setAttribute("ProgName ",rs1.getString(2));
			 // System.out.println("programme_name "+rs1.getString(1));
			  asno++;
			  String aqury2="";
			  if(ahabs==ahabs1)
			  {
				if(rs.getString(3).equals("11"))
		        {
				  aqury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-'),school_name from RWS_PANCHAYAT_RAJ_TBL PR,RWS_work_school_lnk_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl prg,  rws_school_master_tbl s where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and prg.programme_code='"+rs1.getString(1)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code  order by pr.panch_code";
		        }
		        else if(rs.getString(3).equals("12"))
			   {
			       aqury2="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+wCode+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		    	}
				  else
				  {
					  aqury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and prg.programme_code='"+rs1.getString(1)+"'  order by pr.panch_code";
				  }

             //   System.out.println("in admin qqqqq3333:"+aqury2);
		        rs2 = st2.executeQuery(aqury2);
		        rs2.setFetchSize(500);
		        rs2.beforeFirst();
			 }
	
	%>	
	 <tr  bgcolor="#ffffff">
	  	<td class="btext2">1.Sanction<br>&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
		<td class="rptValue" ><%=rs1.getFloat(3)%></td>	
	</tr>
	
	<tr bgcolor="#ffffff">
		<td class="btext2">2.SanctionNo/SanctionDate</td>
		<td class="rptValue" ><%=rs1.getString(5)%>&nbsp;/<br>&nbsp;<%=rs1.getString(4)%></td>
	</tr> 
	
	<% if(ahabs==ahabs1)
	   { 
		while(rs2.next())
		{
			ano++;
	 	}
	  } 
	  else
	  {
%>		<td colspan=6>colspan6..</td>
<%	  }
%>
	
<%  ahabs++; 
	}
   }
   String aq="";
	//String aq="select distinct w.programme_code,p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+wCode+"' group by w.programme_code, p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0') order by nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
	if(rs.getString(3).equals("11"))
		{
           aq="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_work_school_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
		else if(rs.getString(3).equals("12"))
		{
		   aq="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.lab_code) from RWS_work_lab_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
		else
		{
			aq="select distinct prg.programme_code,p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+wCode+"' group by prg.programme_code, p.programme_name,nvl(prg.SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
		}
//System.out.println("in admin qqqqq3334444444:"+aq);
        rr = ss.executeQuery(aq);
	    rr.setFetchSize(500);
		rr.last();
		ahabs1=rr.getRow();
	
		if(ahabs1!=0)
		{
		rr.beforeFirst();
		
		while(rr.next())
		{
	    session.setAttribute("ProgName",rr.getString(2));
		asno++;
%>	
		<tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>	
			<td class=btext ><font face="verdana" size="2" color="black"></b><%=rr.getFloat(3)%></b></font></td>	
		</tr>
		
		<tr bgcolor="#ffffff">
			<td class="btext">2. SanctionNo/SanctionDate</td>
			<td class=btext ><font face="verdana" size="2" color="black"><%=rr.getString(5)%>&nbsp;/&nbsp;&nbsp;&nbsp;</b><%=rr.getString(4)%></b></font></td>
		</tr>
		
<%		if(aha==ahabs1)
		{
		pre=rr.getInt(6);
		
%>
		<tr bgcolor="#ffffff">
		<%if(rs.getString(3).equals("11"))
	       {%>
			<td class="btext">3. No Of Schools</td>
<%}else if(rs.getString(3).equals("12"))
	       {%>
		   <td class="btext">3. No Of Labs</td>
		   <%}else {%>
		   <td class="btext">3. No Of Habs</td>
		   <%}%>
			<td class=btext><font face="verdana" size="2" color="black"><b><%=rr.getInt(6)%></b></font></td>
		</tr>
<%
String qury2="";
	//System.out.println("in admin qqqqq55");
		//String qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr.getString(1)+"'  order by pr.panch_code";
		//System.out.println("in admin qqqqq52");
		if(rs.getString(3).equals("11"))
				
		        {
				  qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0), nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+ nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(coverage_status,'-'),school_name from RWS_PANCHAYAT_RAJ_TBL PR,RWS_work_school_lnk_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl prg, rws_school_master_tbl s where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code  order by pr.panch_code";
		        }
		        else if(rs.getString(3).equals("12"))
			   {
			       qury2="select distinct division_office_code ,nvl(division_office_name,'-'),w.lab_code,lab_name  from rws_division_office_tbl d ,rws_work_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+wCode+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
		    	}
				  else
				  {
					//  System.out.println("in admin qqqqq53");
					  qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"'   order by pr.panch_code";
				  }
		//System.out.println("in admin qqqqq55555555:"+qury2);
        rss = st2.executeQuery(qury2);
        rss.setFetchSize(500);
        rss.beforeFirst();
%>
</table>
 <!--<h2 class="expand">Sanctioned Habitations(<%=rr.getInt(6)%>)</h2>
            <div class="collapse">
                <p>
              
--><table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  style="border-collapse:collapse" >
<tr></tr>
<tr></tr>	<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr> 	 
	<tr>
			<td style="text-align: left;" class="rptHeading" colspan=8>&nbsp;II&nbsp;Sanctioned Habitations(<%=rr.getInt(6)%>) </td>	
		</tr>
       	<tr bgcolor="#ffffff">
		<%if(rs.getString(3).equals("11"))
		        {%>
			<td class="btext2">4. School Name</td>
			<td class="btext2" align="right">Habitations</td>
			<td class="btext2">Plain<br>Pop</td>
			<td class="btext2">SC<br>Pop</td>
			<td class="btext2">ST<br>Pop</td>
			<td class="btext2">Total</td>
			<td class="btext2" align="center">Coverage Status</td>
			<%}else if(rs.getString(3).equals("12")){ %>
			<td class="btext2"colspan="3">4.Division</td>
			<td class="btext2" align="center" colspan="3">Lab Code</td>
			<td class="btext2" align="center" colspan="2">Lab Name</td>
			
			<%}else{%>
			<td class="btext"> Habitations</td>
			<td class="btext">Plain<br>Pop</td>
			<td class="btext">SC<br>Pop</td>
			<td class="btext">ST<br>Pop</td>
			<td class="btext">Total</td>
			<td class="btext" align="center">Coverage Status</td>
			<%}%>
		</tr>
<%
int styleCount=0;
String style="";
	while(rss.next())
	{
		aserial++;
		
		if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;					//System.out.println("name:"+rs.getString(3));
%>


		<%if(rs.getString(3).equals("11"))

		  {%>
		  <tr bgcolor="#ffffff"> 	
			<td class=<%=style %> style="text-align: left;" ><%=aserial%>.&nbsp;<%=rss.getString(8)%></td>
			<td class=<%=style %>  style="text-align: left;" ><%=rss.getString(2)%></td>
			<td class=<%=style %>  align="right" ><%=rss.getString(3)%></td>
			<td class=<%=style %>  align="right"><%=rss.getString(4)%></td>
			<td class=<%=style %>  align="right"><%=rss.getString(5)%></td>
			<td class=<%=style %>  align="right"><%=rss.getString(6)%></td>
			<td class=<%=style %>  align="center"><%=rss.getString(7)%></td>
			</tr>
		<%}else if(rs.getString(3).equals("12")) {%>
		<tr bgcolor="#ffffff"> 	
			<td class=<%=style %>  colspan="3"><%=aserial%>.&nbsp;<%=rss.getString(2)%></td>
			<td class=<%=style %>  align="center" colspan="3"><%=rss.getString(3)%></td>
			<td class=<%=style %>  align="center" colspan="2"><%=rss.getString(4)%></td>
			</tr>
			<%}else{%>
			<tr bgcolor="#ffffff"> 	
			<td class=<%=style %> style="text-align: left;" ><%=aserial%>.&nbsp;<%=rss.getString(2)%></td>
			<td class=<%=style %>  style="text-align: left;" ><%=rss.getInt(3)%></td>
			<td class=<%=style %>  align="right"><%=rss.getInt(4)%></td>
			<td class=<%=style %>  align="right"><%=rss.getInt(5)%></td>
			<td class=<%=style %>  align="right"><%=rss.getInt(6)%></td>
			<td class=<%=style %>  align="center" ><%=rss.getString(7)%></td>
			</tr>
			<%}%>
		
		  
  
   <%
//    }
    }
    
   %>
   
   <% } 
	%>
		
<% aha++; 
}
		}
	%>
	
	                 </table>
	                           
            </div>
            
            <table>
	<% 
	
//********************************************************************************************

		String q1="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_REVISED_ADM_SANC_TBL w,rws_revised_adm_prog_lnk_tbl prg where w.work_id=prg.work_id(+) and w.work_id='"+wCode+"'";
	//System.out.println("in revised admin");
	 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 ss1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st22 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

		r= s.executeQuery(q1);
		r.setFetchSize(500);
		r.last();
		Counts = r.getRow();
		r.beforeFirst();
		if(Counts!=0)
		{
		 while(r.next())
		 {
%>	
	   	
		<tr bgcolor="#ffffff">
			<td class="rptValue"  ><b><%=r.getString(2)%><br>(Revised To)</br></b></td>
		</tr>
<%String aq2="";String aq3="";String aq4="";

        int asn=0,ahabss=1,ahabss1=0,aserials=0,ano1=0,ahaa=1;
		if(rs.getString(3).equals("11"))
			 {
               aq2="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_schools from RWS_REV_school_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_sanc_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"' group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_schools order by nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			 }
			 else if(rs.getString(3).equals("12"))
			 {
               aq2="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_labs from RWS_REV_lab_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_sanc_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"'  group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_labs  order by nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			 }
			 else
			 {
			 aq2="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_prog_lnk_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"' group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.ADMIN_NO,'0') order by nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			 }
			 //System.out.println("in revised admin::::::"+aq2);
        r1 = s1.executeQuery(aq2);
        r1.setFetchSize(500);
		r1.last();
		ahabss1=r1.getRow();
		if(ahabss1!=0)
		{
			 //System.out.println("in revised admin:11:::"+ahabss1);
        r1.beforeFirst();

		 while(r1.next())
		 {
		    session.setAttribute("ProgName",r1.getString(2));		
			asn++;
			// System.out.println("in revised admin22::ahabss1:"+ahabss1);
			//  System.out.println("in revised admin:33:ahabss::"+ahabss);
			if(ahabss==ahabss1)
			{
			if(rs.getString(3).equals("11"))
			 {
			    aq3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_school_LNK_TBL ln,rws_habitation_directory_tbl h,rws_revised_adm_prog_lnk_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+r.getString(1)+"' and prg.programme_code='"+r1.getString(1)+"'  order by pr.panch_code";
			 }
			 else if(rs.getString(3).equals("12"))
			 {
			    aq3="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_rev_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+rs.getString(2)+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
			 }
			 else
			{
				 aq3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_revised_adm_prog_lnk_tbl prg  where  prg.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+r.getString(1)+"' and prg.programme_code='"+r1.getString(1)+"'  order by pr.panch_code";
			}
			//System.out.println("in admin revised2:"+aq3);
		        r2 = s2.executeQuery(aq3);
		        r2.setFetchSize(500);
		        r2.beforeFirst();
			}
%>	
	
	
	
<%	if(ahabss==ahabss1)
	{
		
 		while(r2.next())
		{
			
			aserials++;
			if(aserials==1)
			{%>
<% 			}
		 } 
	 	} 
		else
		{
%>		<td colspan=6></td>
<%		 }	%>
		
		
<% 		ahabss++; 
		//System.out.println("in revised ahabss444:"+ahabss);
		}
	}
	//String aq4="select distinct w.programme_code,p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE ,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,RWS_REVISED_ADM_SANC_TBL  w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+wCode+"' group by w.programme_code, p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0') order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
if(rs.getString(3).equals("11"))
			 {
               aq4="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_schools from RWS_REV_school_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_sanc_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"' group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_schools order by nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			 }
			 else if(rs.getString(3).equals("12"))
			 {
               aq4="select distinct prg.programme_code,p.programme_name,nvl(prg.rev_SANCTION_AMOUNT,'0'),nvl(to_char(REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_labs from RWS_REV_lab_LNK_TBL ln,rws_programme_tbl p,rws_revised_adm_sanc_tbl prg where prg.work_id=ln.work_id and  prg.programme_code=p.programme_code and prg.work_id='"+r.getString(1)+"'  group by prg.programme_code, p.programme_name,nvl(prg.REV_SANCTION_AMOUNT,'0'),nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(rev_ADMIN_NO,'0'),no_of_labs  order by nvl(to_char(rev_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			 }
			else
			{
			 aq4="select distinct w.programme_code,p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE ,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_school_LNK_TBL ln,rws_programme_tbl p,RWS_REVISED_ADM_SANC_TBL  w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+wCode+"' group by w.programme_code, p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0') order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";
			}
			//System.out.println("in admin revised:"+aq4);
        rr1 = ss1.executeQuery(aq4);
        //session.setAttribute("ProgName",rr1.getString(2));
//System.out.println("in admin revised666:"+ProgName);
	    rr1.setFetchSize(500);
		rr1.last();
		ahabss1=rr1.getRow();
		//out.println("habs1");
	//	System.out.println("in admin revised77776:"+ahabss1);
		if(ahabss1!=0)
		{
		rr1.beforeFirst();
		
		while(rr1.next())
		{
			asn++;
			if(ahaa==ahabss1)
	//System.out.println("in admin revised8888"+ahabss1);
			{String aqury3="";
			if(rs.getString(3).equals("11"))
			{
		        aqury3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-'),school_name from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_school_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w ,rws_school_master_tbl s where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr1.getString(1)+"' and s.school_code=ln.school_code and h.hab_code=s.hab_code  order by pr.panch_code";
			}
			else if(rs.getString(3).equals("12"))
			{
				//aqury3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_lab_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr1.getString(1)+"'  order by pr.panch_code";
				aqury3="select distinct division_office_code ,nvl(division_office_name,'-'),lab_name  from rws_division_office_tbl d ,rws_rev_lab_lnk_tbl ll,rws_water_quality_lab_tbl w  where ll.work_id='"+wCode+"' and d.circle_office_code=substr(ll.work_id,5,2) and ll.lab_code=w.lab_code and substr(w.office_code,4,1)=d.division_office_code";
			}
			else
			{
				aqury3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr1.getString(1)+"'  order by pr.panch_code";
			}
			//System.out.println("in admin revised44:"+aqury3);
		        rss1 = st22.executeQuery(aqury3);
		        rss1.setFetchSize(500);
		        rss1.beforeFirst();
			}
%>
             
		<tr bgcolor="#ffffff">		
		<td class="btext2" colspan="6">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue" ><%=rr1.getFloat(3)%></td>	
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext2" colspan="6">2.Rev.Admin.SancNo/Rev.Admin.SancDate</td>
			<td class="rptValue" ><%=rr1.getString(5)%>&nbsp;/ &nbsp;<%=rr1.getString(4)%></td>
		</tr>
<%		 if(ahaa==ahabss1)
		 {
%>
		
		<% 
		//System.out.println("asset::"+rs.getString(8));
		 if(rs.getString(3).equals("11"))
		{
		%>
		<td class="btext2" colspan="6">4. No Of Schools</td>
		<%}else  if(rs.getString(3).equals("12")){%>
		<td class="btext2" colspan="6">4. No Of Labs</td>
		<%}else{%>
		<td class="btext2" colspan="6">4. No Of Habs</td>
		<%}%>
		<td class=rptValue ><b><%=rr1.getInt(6)%></b></td>
		</tr>
		</table>
		<table >	  	
		<tr bgcolor="#ffffff">
		 <%if(rs.getString(3).equals("11")){//System.out.println("query in revised::5:"+rs.getString(8));%>
          <td class="btext2" >5. Habitation/School Name</td>
		  <td class="btext2">Plain Pop</td>
		<td class="btext2">SC Pop</td>
		<td class="btext2">ST Pop</td>
		<td class="btext2">Total</td>
		<td class="btext2" >Coverage Status</td>
		</tr>
		  <%}else if(rs.getString(3).equals("12")){%>
        <td class="btext2" colspan="4">5. Division</td>
<td class="btext2" colspan="3" align="center">Lab Name</td>
		
				</tr>
		<%}else{%>
			<td class="btext2" >5. Habitations</td>
		<td class="btext2">Plain Pop</td>
		<td class="btext2">SC Pop</td>
		<td class="btext2">ST Pop</td>
		<td class="btext2">Total</td>
		<td class="btext2" >Coverage Status</td>
		</tr>
		<%}%>
<% 
		while(rss1.next())
		{
			ano1++;
			//if(ano1==1)
			//{
            if(rs.getString(3).equals("11"))
			{%>
			<tr bgcolor="#ffffff">
			<td class=rptValue ><%=ano1%>.&nbsp;<%=rss1.getString(2)%>/<%=rss1.getString(8)%></td>
			<td class=rptValue align="right"><%=rss1.getString(3)%></td>
			<td class=rptValue align="right"><%=rss1.getString(4)%></td>
			<td class=rptValue align="right"><%=rss1.getString(5)%></td>
			<td class=rptValue align="right"><%=rss1.getString(6)%></td>
			<td class=rptValue align="center"><%=rss1.getString(7)%></td>
			</tr>
			<%}else if(rs.getString(3).equals("12")){%>
			<tr bgcolor="#ffffff">
				<td class=rptValue colspan="4"><%=ano1%>.&nbsp;<%=rss1.getString(2)%></td>
				<td class=rptValue  colspan="3" align="center"><%=rss1.getString(3)%></td>
						
				</tr>
			<%}else {%>
				<tr bgcolor="#ffffff">
				<td class=rptValue ><%=ano1%>.&nbsp;<%=rss1.getString(2)%></td>
				<td class=rptValue align="right"><%=rss1.getString(3)%></td>
				<td class=rptValue align="right"><%=rss1.getString(4)%></td>
				<td class=rptValue align="right"><%=rss1.getString(5)%></td>
				<td class=rptValue align="right"><%=rss1.getString(6)%></td>
				<td class=rptValue align="center"><%=rss1.getString(7)%></td>
				</tr>
		
			
		

	  
<% 	}	//} 
} } 
		else
		{			 
%>
			<td colspan=6></td>
<%		 }
%>
		<tr>
			<td colspan=2>
		</tr>
<% 			ahaa++; 
			}
		 }
 	}
 }
//********************************************************************************
}//end of main while

}
else
{
%>
	 <tr  bgcolor="#ffffff">
		<td class="btext2">1.Sanction<br>Amt(Rs In Lakhs)</td>
		<td class="rptValue">-</td>	
	</tr>
	<tr  bgcolor="#ffffff">
		<td class="btext2">2.SanctionNo/SanctionDate</td>
		<td class="rptValue" >-</td>
	</tr> 
	<tr bgcolor="#ffffff">
		<td class="btext2">3.No Of Habs</td>
		<td class="rptValue" >-</td>
	<tr>
	<tr  bgcolor="#ffffff">
		<td class="btext2">4.Habitations</td>
		<td class="btext2">Plain<br>Pop</td>
		<td class="btext2">SC<br>Pop</td>
		<td class="btext2">ST<br>Pop</td>
		<td class="btext2">Total</td>
		<td class="btext2">Coverage Status</td>
	</tr>
	<tr bgcolor="#ffffff"> 	
		<td class="rptValue">-</td>
		<td class="rptValue" >-</td>
		<td class="rptValue" >-</td>
		<td class="rptValue" >-</td>
		<td class="rptValue" >-</td>
		<td class="rptValue" >-</td>
	</tr>
<%	 }
		}catch(Exception e)
		{
		e.printStackTrace();
		}
		%>


</table>

<%if(pre>10){%><br><%}%>
<br>

