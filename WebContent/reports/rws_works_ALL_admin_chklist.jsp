<%	int pre=0;
    int aval=0;
    
    try
    {
      query ="select distinct nvl(w.WORK_NAME,'-'), nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id=prg.work_id(+) and w.work_id='"+wCode+"' ";

	  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  st3 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  
	  s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  ss1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  st22 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	  rs = stmt.executeQuery(query);
	 // System.out.println("stmt in admin ");
	  rs.setFetchSize(500);
	  rs.last();
	  Count = rs.getRow();
	  rs.beforeFirst();
%>
	<br><br>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<tr>
		<td align="left" class="rptHeading" colspan=8>&nbsp;I.&nbsp;Administrative Sanction Details </td>	
	</tr>
<%	
	if(Count!=0)
	{
	try
	{
	while(rs.next())
	{
		int asno=0,ahabs=1,ahabs1=0,aserial=0,aha=1;
     	
		String aq="select distinct w.programme_code,p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0'),count(ln.hab_code) from RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_work_admn_tbl w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+wCode+"' group by w.programme_code, p.programme_name,nvl(w.SANCTION_AMOUNT,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.ADMIN_NO,'0') order by nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-') asc";

        rr = ss.executeQuery(aq);
	    rr.setFetchSize(500);
		rr.last();
		ahabs1=rr.getRow();
	
		if(ahabs1!=0)
		{
		rr.beforeFirst();
		try
		{
		while(rr.next())
		{
	    session.setAttribute("ProgName",rr.getString(2));
		asno++;
%>	
		<tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>	
			<td class="rptValue"><%=rr.getFloat(3)%></td>	
		</tr>
		
		<tr bgcolor="#ffffff">
			<td class="btext">2. SanctionNo/SanctionDate</td>
			<td class="rptValue" ><%=rr.getString(5)%>&nbsp;/<br>&nbsp;<%=rr.getString(4)%></td>
		</tr>
		
<%		if(aha==ahabs1)
		{
		pre=rr.getInt(6);
		
%>
		<tr bgcolor="#ffffff">
			<td class="btext">3. No Of Habs</td>
			<td class=rptValue align="right"><b><%=rr.getInt(6)%></b></td>
		</tr>
<%
		String qury2="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,rws_work_admn_tbl w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr.getString(1)+"'  order by pr.panch_code";
        rss = st3.executeQuery(qury2);
        rss.setFetchSize(500);
        rss.beforeFirst();
%>

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	 
	
       	<tr bgcolor="#ffffff">
			<td class="btext">4. Habitations</td>
			<td class="btext">Plain<br>Pop</td>
			<td class="btext">SC<br>Pop</td>
			<td class="btext">ST<br>Pop</td>
			<td class="btext">Total</td>
			<td class="btext">Coverage Status</td>
		</tr>
<%
try
{
	while(rss.next())
	{
		aserial++;
		if(aserial==1)
		{
%>
		<tr bgcolor="#ffffff"> 	
			<td class="rptValue"><%=aserial%>.&nbsp;<%=rss.getString(2)%></td>
			<td class="rptValue" align="right" ><%=rss.getInt(3)%></td>
			<td class="rptValue" align="right" ><%=rss.getInt(4)%></td>
			<td class="rptValue"  align="right"><%=rss.getInt(5)%></td>
			<td class="rptValue"  align="right"><%=rss.getInt(6)%></td>
			<td class="rptValue"  align="center"><%=rss.getString(7)%></td>
		</tr>
		  
<%		}
	   	else
		{
%>		
	<tr bgcolor="#ffffff">
		<td class="rptValue" ><%=aserial%>.&nbsp;<%=rss.getString(2)%></td>
		<td class="rptValue" align="right" ><%=rss.getInt(3)%></td>
		<td class="rptValue" align="right"><%=rss.getInt(4)%></td>
		<td class="rptValue" align="right"><%=rss.getInt(5)%></td>
		<td class="rptValue" align="right" ><%=rss.getInt(6)%></td>
		<td class="rptValue"  align="center"><%=rss.getString(7)%></td>
	</tr>
       
   <%
    }
    }
    }catch(Exception e)
	{
	}
	finally
	{
		if(rss!=null)rss.close();
		if(st3!=null)st3.close();
	}
    
   %>
   </table>
   <% } 
	%>
		
<% aha++; 
    }
	}catch(Exception e)
	{
	}
	finally
	{
		if(rr!=null)rr.close();
		if(ss!=null)ss.close();
	}
}
	
//********************************************************************************************

	String q1="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_REVISED_ADM_SANC_TBL w,rws_revised_adm_prog_lnk_tbl prg where w.work_id=prg.work_id(+) and w.work_id='"+wCode+"'";
	try
	{
		r= s.executeQuery(q1);
		r.setFetchSize(500);
		r.last();
		Counts = r.getRow();
		r.beforeFirst();
		if(Counts!=0)
		{
		try
		{
		 while(r.next())
		 {
%>	
		<tr bgcolor="#ffffff">
			<td class="rptValue"><b>(Revised To)</b></td>
		</tr>
<%
        int asn=0,ahabss=1,ahabss1=0,aserials=0,ano1=0,ahaa=1;
		
		String aq4="select distinct w.programme_code,p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE ,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0'),count(ln.hab_code) from RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_programme_tbl p,RWS_REVISED_ADM_SANC_TBL  w where w.work_id=ln.work_id and  w.programme_code=p.programme_code and w.work_id='"+wCode+"' group by w.programme_code, p.programme_name,nvl(w.Rev_SANCTION_AMOUNT,'0'),nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(w.REV_ADMIN_NO,'0') order by nvl(to_char(w.REV_ADMIN_DATE,'dd-mm-yyyy'),'-') asc";

        rr1 = ss1.executeQuery(aq4);
        session.setAttribute("ProgName",rr1.getString(2));
	    rr1.setFetchSize(500);
		rr1.last();
		ahabss1=rr1.getRow();
		//out.println("habs1");
		if(ahabss1!=0)
		{
		rr1.beforeFirst();
		try
		{
		while(rr1.next())
		{
			asn++;
			if(ahaa==ahabss1)
			{
				String aqury3="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_REV_ADM_SANC_HAB_LNK_TBL ln,rws_habitation_directory_tbl h,RWS_REVISED_ADM_SANC_TBL w  where  w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+wCode+"' and w.programme_code='"+rr1.getString(1)+"'  order by pr.panch_code";
		        rss1 = st22.executeQuery(aqury3);
		        rss1.setFetchSize(500);
		        rss1.beforeFirst();
			}
%>
		<tr bgcolor="#ffffff">
			<td class="btext">1. Sanction<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>	
			<td class="rptValue" ><%=rr1.getFloat(3)%></td>	
		</tr>
		
		<tr bgcolor="#ffffff">
			<td class="btext">2. SanctionNo/SanctionDate</td>
			<td class="rptValue"><%=rr1.getString(5)%>&nbsp;/ &nbsp;<%=rr1.getString(4)%></td>
		</tr>
		
<%		 if(ahaa==ahabss1)
		 {
%>
		<tr bgcolor="#ffffff">
			<td class="btext">3. No Of Habs</td>
			<td class="rptValue"><b><%=rr1.getInt(6)%></b></td>
		</tr>
<% try
{
		while(rss1.next())
		{
			ano1++;
			if(ano1==1)
			{
%>
		<tr bgcolor="#ffffff">
			<td class="rptValue" ><%=ano1%>.&nbsp;<%=rss1.getString(2)%></td>
			<td class="rptValue" align="right"><%=rss1.getInt(3)%></td>
			<td class="rptValue" align="right" ><%=rss1.getInt(4)%></td>
			<td class="rptValue" align="right" ><%=rss1.getInt(5)%></td>
			<td class="rptValue"  align="right"><%=rss1.getInt(6)%></td>
			<td class="rptValue" align="center" ><%=rss1.getString(7)%></td>
		</tr>
		
<% 	}else{
%>
	<tr bgcolor="#ffffff">
			<td class="rptValue" ><%=ano1%>.&nbsp;<%=rss1.getString(2)%></td>
			<td class="rptValue" align="right" ><%=rss1.getInt(3)%></td>
			<td class="rptValue" align="right" ><%=rss1.getInt(4)%></td>
			<td class="rptValue" align="right" ><%=rss1.getInt(5)%></td>
			<td class="rptValue"  align="right"><%=rss1.getInt(6)%></td>
			<td class="rptValue" align="center" ><%=rss1.getString(7)%></td>
		</tr>
<% 		} }
		}catch(Exception e)
		 {}
		 finally
		 {
			try
			{
				if(rss1!=null)rss1.close();
				//if(st22!=null)st22.close();
			}catch(Exception e)
			{}		
			}
		 } 
		else
		{			 
%>
			<td colspan=6></td>
<%		 }
		ahaa++; 
			}
			}catch(Exception e)
			{}
			finally
			{
			try
			{
				if(rr1!=null)rr1.close();
				//if(ss1!=null)ss1.close();
				
			}catch(Exception e)
			{}		
			}
		 }
 	}
 	}catch(Exception e)
	{
	}
	finally
	{
		if(r!=null)r.close();
		if(s!=null)s.close();	
	}
}
}catch(Exception e)
{}
finally
{
	 if(s!=null)s.close();
	 if(s1!=null)s1.close();
	 if(ss1!=null)ss1.close();
	 if(st22!=null)st22.close();
}

//********************************************************************************
}//end of main while
}catch(Exception e)
{
	System.out.println("Exception in admin"+e.getMessage());
}
finally
{
		if(rs!=null)rs.close();
    //	System.out.println("stmt.close in admin ");
		if(stmt!=null)stmt.close();
}
}
else
{
%>
	 <tr  bgcolor="#ffffff">
		<td class="btext">1.Sanction<br>Amt(Rs In Lakhs)</td>
		<td class="rptValue">-</td>	
	</tr>
	<tr  bgcolor="#ffffff">
		<td class="btext">2.SanctionNo/SanctionDate</td>
		<td class="rptValue" >-</td>
	</tr> 
	<tr bgcolor="#ffffff">
		<td class="btext">3.No Of Habs</td>
		<td class="rptValue" >-</td>
	<tr>
	<tr  bgcolor="#ffffff">
		<td class="btext">4.Habitations</td>
		<td class="btext">Plain<br>Pop</td>
		<td class="btext">SC<br>Pop</td>
		<td class="btext">ST<br>Pop</td>
		<td class="btext">Total</td>
		<td class="btext">Coverage Status</td>
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
		finally
		{
		 if(stmt!=null)stmt.close();
		 if(st1!=null)st1.close();
		 if(st2!=null)st2.close();
		 if(ss!=null)ss.close();
		 
		 if(s!=null)s.close();
		 if(s1!=null)s1.close();
		 if(ss1!=null)ss1.close();
		 if(st22!=null)st22.close();
		  
		}
		
		%>


</table>
<br>
<%--<%if(pre>10){%><br><br><%}%>--%>