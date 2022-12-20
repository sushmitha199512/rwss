<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<form name="f1">
<%
java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;

String dcode=request.getParameter("dcode");



%>
<style type="text/css" media="print">
@page
{
	size: landscape;
	margin: 2cm;
}
</style>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
	
				 <td class="bwborder"><a href="#" onclick="window.close()">Close</a> &nbsp;<a href="#" onclick="window.print()"><img src="../images/print_icon.jpg"></a>
				</td>
			
			</tr>  
		</table>
	</caption>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="15">Pending Works</td>
</tr>
               <td class=btext >S.No</td>
               <td class=btext>District</td>
			
			   <td class=btext align=center>Work ID</td>
			   <td class=btext align=center>Work Name</td>
			   
               
			
			

</tr>
		   
		
			   <%


try
{
  

 
  String query1=" select a.work_id,w.work_name,w.ADMIN_DATE,b.dname,a.* from rws_notgroundworks_status_tbl a,rws_work_admn_tbl w,rws_district_tbl b where a.work_id=w.work_id and substr(a.work_id,5,2)=b.dcode and (a.LANDAQUISITION ='Y' and a.LANDAQUISITIONOBTAINDATE  is null) or(WATERDRAWLPERMISSION ='Y' and  WATERDRAWLPERMISSIONOBTAINDATE is null) or (RAILWAYCROSSINGPERMISSION ='Y' and RAILWAYCROSSINGPEROBTAIN is null) or (ROADCROSSINGPERMISSIONSTATE='Y' and ROADCROSSINGPEROBTAINDATE  is null) or (ROADCROSSINGPERMISSIONNHAI='Y' and ROADCROSSINGNHAIOBTAINDATE is null) or (FORESTCLEARANCE='Y' and FORESTCLEARANCEOBTAINDATE is null) or (OTHERS='Y' and OTHERSOBTAINDATE is null)";


  int count = 1,sno=0; 
  	stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(query1);

  while (rs1.next())
	{ 
 

  %>
  
  <tr><td class=rptLabel ><%=sno++ %></td>
  <td class=rptLabel  ><%=rs1.getString(1)%></td>
  
   <td class=rptValue  align=center><a href=""><%=rs1.getString(2) %></a></td>
   <td class=rptValue  align=center><a href=""><%=rs1.getString(3) %></a></td>
   <td class=rptValue  align=center><a href=""><%=rs1.getString(4) %></a></td>
  </tr>
  
  <%
			

}
%>


<%

}
catch(Exception e)
{
	e.printStackTrace();
	
}
%>
</table>
</form>
<center>
<%@ include file="/commons/rws_footer.jsp" %>
</center>



