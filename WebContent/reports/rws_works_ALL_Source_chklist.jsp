
<%
     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,rws_source_iden_fin_tbl fin where fin.work_id=w.work_id and w.work_id='"+wCode+"' ";
    // System.out.println("source query "+query);
	 try{
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 	 
	 rs = stmt.executeQuery(query);
	 rs.setFetchSize(500);
	 rs.last();
	 Count = rs.getRow();
	 rs.beforeFirst();
	 String a[]=new String[10];
%>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
	<tr align="center">
		<td align="left" class="rptHeading" colspan=10>III. Source Identification Details</font></td>	
	</tr>

<%	
	int csno=0,chabs=1,chabs1=0,cha=1;
	if(Count!=0)
	{
	try
	{
		while(rs.next())
		{
		String cqury1="select m.mname,raj.panch_name,nvl(st.SOURCE_TYPE_NAME,'-') as sourcetype,nvl (sst.SUBSOURCE_TYPE_NAME,'-') as subsource, nvl(fin.SOURCE_NAME,'-') as sourcename,nvl(fin.employee_code,'-') as emp,nvl (to_char (SITE_HAND_OVER_DATE,'dd/mm/yyyy'),'-') as handover,nvl(remarks,'-') as remarks from rws_source_iden_fin_tbl fin,rws_mandal_tbl m,rws_panchayat_raj_tbl raj,rws_source_type_tbl st,rws_subsource_type_tbl sst where raj.panch_code=fin.hab_code and substr (raj.panch_code,1,2)=m.dcode and substr (raj.panch_code,6,2)=m.mcode and st.SOURCE_TYPE_CODE=fin.SOURCE_TYPE_CODE and sst.SUBSOURCE_TYPE_CODE=fin.SUBSOURCE_TYPE_CODE and st.SOURCE_TYPE_CODE=sst.SOURCE_TYPE_CODE and fin.work_id='"+wCode+"' ";
 	  //  System.out.println("source data query "+cqury1);        
        rs1 = st1.executeQuery(cqury1);       
	    rs1.beforeFirst();
	    try
	    {
		 while(rs1.next())
		 {
		 csno++;
 %>
	  	<tr bgcolor="#ffffff">
		<td class="btext" nowrap>1. Mandal</td>
		<td class=rptValue nowrap><%=rs1.getString(1)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Habitation</td>
		<td class=rptValue ><%=rs1.getString(2)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >3. Source Type</td>
		<td class=rptValue ><%=rs1.getString(3)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext"  >4. SubSource Type</td>
		<td class=rptValue ><%=rs1.getString(4)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext">5. Source Name</td>
		<td class=rptValue ><%=rs1.getString(5)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >6. Site/Source Identified by</td>
		<td class=rptValue ><%=rs1.getString(6)%></td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" >7. Site/Source Hand Over Date</td>
		<td class=rptValue ><%=rs1.getString(7)%></td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" >8. Recommendations By Geologist</td>
		<td class=rptValue ><%=rs1.getString(8)%></td>
		</tr>
		<% }
		}
		catch(Exception e){}
		finally
		{
		try
		{
			if(rs1!=null)rs1.close();
			if(st1!=null)st1.close();
		}catch(Exception e){}
		}
		  
	} 
	}
	catch(Exception e){
	System.out.println("Exception in Contract"+e.getMessage());
	}
	finally
	{
	try
	{
		if(rs!=null)rs.close();
		if(stmt!=null)stmt.close();
	}catch(Exception e){}
	}
		
	}
	else
	{%>
		<tr bgcolor="#ffffff">
		<td class="btext" colspan=2>1. Mandal</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" colspan=2>2. Habitation</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" colspan=2>3. Source Type</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" colspan=2>4. SubSource Type</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		 <td class="btext" colspan=2>5. Source Name</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" colspan=2>6. Site/Source Identified by</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff">
		<td class="btext" colspan=2>7. Site/Source Hand Over Date</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
		<tr bgcolor="#ffffff" >
		<td class="btext" colspan=2>8. Recommendations By Geologist</td>
		<td class=rptValue colspan=2>-</td>
		</tr>
<% 		}
		}catch(Exception e)
		{}
		finally
		{
		  if(stmt!=null)stmt.close();
		  if(st1!=null)st1.close();
		}
%>
</table>
<br>
<br>
	
	
