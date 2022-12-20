<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;
String attend="";
String a="";


String dcode=request.getParameter("district");

int sno=1;
int complaintcount=0;
int gcomplaintcount=0;
int ncomplaintcount=0;
int gncomplaintcount=0;
String cDate=null;
cDate=request.getParameter("fromdate");



String aDate=request.getParameter("adate");


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
				<td class="bwborder"><a href="/pred/rws_login_frm1.html">Home</a></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Complaints  Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
               <td class=btext>Total No. Of Attended  Complaints</td> 
			   <td class=btext>Total No. Of Non Attended  Complaints</td> 
		   
			   </tr>
<%
try
{
    String query = "";
	 if(dcode!=null && !dcode.equals("") && dcode.equals("51"))
		{
	  query="select  dcode,dname from rws_district_tbl order by dname";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	{
	  query="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	  }
attend="attend";
a="notattended";
  
  stmt1=conn.createStatement();
   stmt2=conn.createStatement();
  rs1=stmt1.executeQuery(query);
  while (rs1.next())
	{
		String qry="select (select count(*) from rws_complaints_register_tbl a,rws_asset_mast_tbl b where b.asset_code=a.asset_code and attended_date is  null and  substr(source_code,1,2)='"+rs1.getString(1)+"')a1,(select count(*) from rws_complaints_register_tbl a,rws_asset_mast_tbl b where b.asset_code=a.asset_code and attended_date is not  null and  substr(source_code,1,2)='"+rs1.getString(1)+"')a2 from dual       ";
		 
		  
		 
		 
		  rs2=stmt2.executeQuery(qry);
          complaintcount=0; 
          ncomplaintcount=0;
          
		 while(rs2.next())
		{
			complaintcount=rs2.getInt(1);
            ncomplaintcount=rs2.getInt(2);
             
			 
		}
		gcomplaintcount=complaintcount+gcomplaintcount;
        gncomplaintcount=gncomplaintcount+ncomplaintcount;
		
			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
<%if(complaintcount > 0)
{ %>
                
				<td class=rptValue><a href="rws_complaints_detail_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=1%>&dName=<%=rs1.getString(2)%>"><%=complaintcount%></a></td>

<%}else{  %>
                		<td class=rptValue NOWRAP><%=complaintcount%></td>
<%} %>
<%if(ncomplaintcount > 0)
{ %>
<td class=rptValue><a href="rws_complaints_detail_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=2%>&dName=<%=rs1.getString(2)%>"><%=ncomplaintcount%></a></td>
<%}else{ %>
                        <td class=rptValue NOWRAP><%=ncomplaintcount%></td>
<%} %>

				
				
				</tr>
<%			
}
	%>
	<tr>
	<td class="btext" colspan="2">Total:</td>
    
    <td class="btext"><%=gcomplaintcount%></td>
     <td class="btext"><%=gncomplaintcount%></td>
	 
	</tr>
	<%
}
catch(Exception e)
{
	
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
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
