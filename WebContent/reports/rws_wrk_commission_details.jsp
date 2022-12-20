<%@	page import="java.math.BigDecimal" %>
<%
	 query="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl e where w.work_id=e.work_id and w.work_id='"+wCode+"' ";
	//distinct is removed from the query
	Statement stmt3 = null;
	//int sno=0;
	int sn=0;
	%>
  <table >

 	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Work Converted into Asset</font></td>	
	</tr>

  <table >	  	
		
		<tr  bgcolor="#ffffff">
			<td class="btext">S.No</td>
		    <td class="btext">Asset Code</td>
			<td class="btext">AssetName</td>
			<td class="btext">Location</td>
			<td class="btext">Habitation</td>
			<td class="btext">Date Of Creation</td>
			<td class="btext">Asset Cost(Rs In Lakhs)</td>
			<td class="btext">Asset Status</td>
			<td class="btext">Date of Commissioning</td>
			<td class="btext">Programme Name</td>
		</tr>
<%
 try
{
 qry1="select c.*,a.date_of_comm,p.programme_name from rws_work_completion_tbl a,rws_work_admn_tbl b,rws_asset_mast_tbl c,rws_programme_tbl p where p.programme_code=b.programme_code and  a.date_of_comm is not null and a.work_id=c.asset_code and b.work_id=a.work_id and a.work_id='"+wCode+"'";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry1);
	System.out.println("Qry*******"+qry1);
			while(rs.next())
	{
		
      sn++;
  		%>
		<tr>
		<td class="rptvalue"><%=sno++%></td>
		
		<td class="rptvalue"><%=rs.getString(1)%></td>
		<td class="rptvalue"><%=rs.getString(2)%></td>
		<td class="rptvalue"><%=rs.getString(3)%></td>
		<td class="rptvalue"><%=rs.getString(4)%></td>
		<td class="rptvalue"><%=rs.getString(5)%></td>
		<td class="rptvalue"><%=rs.getString(6)%></td>
		<td class="rptvalue"><%=rs.getString(7)%></td>
		<td class="rptvalue"><%=rs.getString(8)%></td>
		<td class="rptvalue"><%=rs.getString(9)%></td>
		<td class="rptvalue"><%=rs.getString(10)%></td>

		
		</tr>
		<%
	
	
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

</table>




 
 

     

   
