
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp"%>

<%

 ResultSet rs1=null,rs2=null;
Statement stmt1=null,stmt2=null;
 
	String type=request.getParameter("type");
   String contractorCode=request.getParameter("contractorCode");
DecimalFormat ndf = new DecimalFormat("######.##");
 HashMap results=new HashMap();
  
		if(type.equals("1"))
		{
			results=(HashMap)session.getAttribute("completed");
		}else if(type.equals("2"))
		{
			results=(HashMap)session.getAttribute("ongoing");
		}else if(type.equals("3"))
			{
					results=(HashMap)session.getAttribute("allWorksList");
		
				}


 %>
<html>
<form>
<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	<caption>
	<table border=0 rules=none style="border-collapse:collapse"
		align="right">
		
	</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Contractor Status Report</td>
	</tr>


</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext >Sl.No</td>
		<td class=btext >District</td>
		<td class=btext >WorkID</td>
		<td class=btext >Work Name</td>
		<td class=btext >Admin Sanction Amount(In Lakhs)</td>
		<td class=btext >Date Of Completion</td>
			


	</tr>


<%
try{
int sno=1;String query="";
stmt1=conn.createStatement();
stmt2=conn.createStatement();
double sancAmount=0;
   String dateOFCompletion="-";
          
				String work_id=(String)results.get(contractorCode);
				String work_ids[]=work_id.split("@");
				for(int i=0;i<work_ids.length;i++)
				{		
				 query="select a.work_id,a.work_name,a.SANCTION_AMOUNT,b.dname from rws_work_admn_tbl a,rws_district_tbl b where substr(a.work_id,5,2)=b.dcode and a.work_id='"+work_ids[i]+"'";
			
                 rs1=stmt1.executeQuery(query);
				while(rs1.next()){
						sancAmount+=Double.parseDouble(rs1.getString(3));
           String query1="select to_char(c.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl c where c.work_id='"+rs1.getString(1)+"'";
					 rs2=stmt2.executeQuery(query1);
					if(rs2.next()){
						if(rs2.getString(1)!=null && !rs2.getString(1).equals("null")){
					dateOFCompletion=rs2.getString(1);

					}else{
dateOFCompletion="-";
}
				}
					
				%>
				<tr><td class=rptvalue><%=sno++ %></td><td class=rptvalue><%=rs1.getString(4) %></td><td class=rptvalue><%=rs1.getString(1) %></td><td class=rptvalue><%=rs1.getString(2) %></td><td class=rptvalue><%=rs1.getString(3) %></td><td class=rptvalue align=center><%=dateOFCompletion %></td></tr>
<% 
dateOFCompletion="-";
			}

				}

%>
<tr><td colspan=4 class=btext align=right>Totals:</td><td class=btext><%=ndf.format(sancAmount) %></td><td></td></tr>

<% 
			
}catch(Exception e){
		e.printStackTrace();
}
 %>



</table>
</form>
</html>