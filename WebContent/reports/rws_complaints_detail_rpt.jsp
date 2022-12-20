<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>


<form>
<%
Statement stmt2=null;
ResultSet rs2=null;
String s="";
String s1="";





String dcode=request.getParameter("district");
String dName=request.getParameter("dName");

int sno=1;
String attend=request.getParameter("attend");
String qry="";


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)"">Back&nbsp;|</a></td>
				<td class="bwborder"><a href="/pred/rws_login_frm1.html">Home</a></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
<%
if(request.getParameter("attend").equals("1"))
{%>
		<td align="center" class="rptHeading" colspan="14"> Complaints Not Attended Report</td>
<%} 
else if(request.getParameter("attend").equals("2"))
{%>
		<td align="center" class="rptHeading" colspan="14"> Complaints  Attended Report</td>
<%} %>

</tr>
<tr align="center">
<td class="rptHeading">District:<%=dName%></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" ><tr align=center>

               <td class=btext>Sl.No</td>
               
               <td class=btext>Complaint No.</td>
			   <td class=btext>Complaint Date</td>
			   <td class=btext>Complaint Description</td>
			   <td class=btext>Category</td>
			   <td class=btext>Complaint Attended Date</td>
			   <td class=btext>Complaint Attended By</td>
			   <td class=btext>Complaint Status</td>
			   <td class=btext>Remarks</td>
			   
		   
			   </tr>
<%
try
{

  
 
       
      if(attend.equals("1"))
{
 
		 qry="select   complaint_no,to_char(complaint_date,'dd/mm/yyyy'),complaint_desc,decode(category_code,'01','LEAKING','02','PUMP DAMAGED')result,nvl(to_char(attended_date,'dd/mm/yyyy'),'-'),nvl(attended_by,'-'),nvl(complaint_status,'-'),nvl(a.remarks,'-') from rws_complaints_register_tbl a,rws_asset_mast_tbl b where b.asset_code=a.asset_code and a.attended_date is null and   substr(source_code,1,2)='"+dcode+"'  order by complaint_no  ";
        }
else if(attend.equals("2"))
{
 qry="select   complaint_no,to_char(complaint_date,'dd/mm/yyyy'),complaint_desc,decode(category_code,'01','LEAKING','02','PUMP DAMAGED')result,nvl(to_char(attended_date,'dd/mm/yyyy'),'-'),nvl(attended_by,'-'),nvl(complaint_status,'-'),nvl(a.remarks,'-') from rws_complaints_register_tbl a,rws_asset_mast_tbl b where b.asset_code=a.asset_code and a.attended_date is not  null and   substr(source_code,1,2)='"+dcode+"'  order by complaint_no  ";
}
		
		
		   
		  System.out.println("query"+qry);
		 
		  stmt2=conn.createStatement(); 
		  rs2=stmt2.executeQuery(qry);
 
          
		while(rs2.next())
        {
        s=rs2.getString(5);
        
        if(s.equals("-"))
	     {
		  s1="Not Attended";
	      }
	else 
	{
	 s1=rs2.getString(7);
	}

       
		
             
			 
		
			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(1)%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(2)%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(3)%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(4)%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(5)%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(6)%></td>
				<td class=rptValue NOWRAP><%=s1%></td>
				<td class=rptValue NOWRAP><%=rs2.getString(8)%></td>
                
				</tr>
		<%}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
