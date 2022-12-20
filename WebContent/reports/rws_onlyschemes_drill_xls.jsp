<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<body bgcolor="#edf2f8">
<%String dname=(String)session.getAttribute("dname"); %>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr>
  	       <td align="center" class="rptHeading" colspan=11>District : <%=dname%> Work Details</td>	
            <td align="right" class="rptHeading">***Amount in Lakhs</td>	
    </tr>
<%
try
{  String dcode=(String)session.getAttribute("dcode");
   	int sno=1;
	%><tr align="center" bgcolor="#ffffff">
			<td class=btext>Sno</td>
			<td class=btext>OFFICE_CODE</td>	
			<td class=btext>WORK_ID</td>	
			<td class=btext>WORK_NAME</td>
			<td class=btext>PROGRAMME_NAME </td>
			<td class=btext>SUBPROGRAMME_NAME </td>
			<td class=btext>ASSET_NAME </td>
		    <td class=btext>ADMIN_NO</td>
			<td class=btext>ADMIN_DATE</td> 
			<td class=btext>SANCTION_AMOUNT </td>
			<td class=btext>DATE_OF_COMPLETION </td>
            <td class=btext>DATE_OF_COMM </td>
 		</tr>
	<%

   
		String qry1= "select f.dname,a.office_code,a.WORK_ID ,a.WORK_NAME,c.PROGRAMME_name   ,d.SUBPROGRAMME_name  ,e.TYPE_OF_ASSET_NAME  ,a.ADMIN_NO   ,to_char(a.ADMIN_DATE,'dd/mm/yyyy') ,a.SANCTION_AMOUNT ,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') ,to_char(b.DATE_OF_COMM,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_completion_tbl b,rws_programme_tbl c ,rws_subprogramme_tbl d ,rws_asset_type_tbl e ,rws_district_tbl f where a.type_of_asset in ('01','02','03','09') and a. work_cancel_dt is null and a.work_id=b.work_id and b.date_of_completion is not null and b.date_of_comm is not null and substr(a.work_id,5,2)='"+dcode+"' and b.work_id not in(select asset_code from rws_asset_mast_tbl) and a.programme_code=c.programme_code and a.programme_code=d.programme_code and a.subprogramme_code=d.subprogramme_Code and a.type_of_asset=e.TYPE_OF_ASSET_CODE and substr(a.work_id,5,2)=f.dcode";
		//System.out.println("query:"+getDnameQuery);
		Statement stmt1=conn.createStatement();
		ResultSet rs1 = stmt1.executeQuery(qry1); 
		while(rs1.next())
		{
		  
                    %>
                <tr>
				<td class=rptValue align="center"><%=sno++%></td>
                <td class="rptValue" align="left"><%=rs1.getString(2)%></td>
				<td class="rptValue" align="left">&nbsp;<%=rs1.getString(3)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(4)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(5)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(6)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(7)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(8)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(9)%></td>
				<td class="rptValue" align="right"><%=rs1.getString(10)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(11)%></td>
				<td class="rptValue" align="left"><%=rs1.getString(12)%></td>
			   </tr>
<%
        
        }


}
	
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
 try{
      //rs1.close();
      //stmt1.close();
     // rs2.close();
     // ps1.close();
     

    }
catch(Exception w)
{
}
}


%>
</table>
</body>

<%@ include file = "footer.jsp" %>
