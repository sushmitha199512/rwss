
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%

	//System.out.println("*****REPORT BEGINING*****");
	String distcode=null,distname=null,divcode=null,divname=null;
	String date=null,date1=null,type=null;
	
	distcode=request.getParameter("dcode");
    distname=request.getParameter("dname");
    divcode=request.getParameter("divcode");
	divname=request.getParameter("divname");
	date = request.getParameter("date");
	date1 = request.getParameter("date1");
	type = request.getParameter("type");
	
	
	
	//String districtName = String.valueOf(session.getAttribute("districtName"));
	//int pass = Integer.parseInt(request.getParameter("pass"));
	String query=null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null, query9 = null, query10 = null, query11 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null ;
	int slno = 0,NOP=0;
	int Count = 0, i = 0,Count1=0;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0,nodatatotal=0,subfctotal=0,subpc1total=0,subpc2total=0,subpc3total=0,subpc4total=0,subnctotal=0,subnsstotal=0,subuitotal=0,subnodatatotal=0,NOP1=0;
	int noofassets=0,noofhabs=0, noofhabs1=0,noofworks=0;
try
{ %>
<html>
<head>

</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_udate_count_frm.jsp">Back|</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>SubdivisionWise-ModuleWise-Report</td>	
	</tr>

	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5><b><font color=blue>District: <%=distname%>&nbsp;&nbsp;FROM:<%=date%>&nbsp;To:<%=date1%></font></b></td>	
	</tr>	


<%
if(type.equals("w"))
	{
 	
	%>
	  
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Water Quality</td>
	</tr>
	   <tr align=center bgcolor="#ffffff" align=center>
	      <td class=btext>Slno</td>
		  <td class=btext>SubDivision </td>	
		  <td class=btext>Ftk Samples </td>
		  <td class=btext>Lab Samples</td>
	   </tr>
	     
	
<%	
	}
	//System.out.println("distcode"+distcode);
	query2="SELECT distinct subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where circle_office_code='"+distcode.trim()+"' and division_office_code='"+divcode+"' order by  subdivision_office_code,subdivision_office_name";
	 stmt1=conn.createStatement();
	 rs=stmt1.executeQuery(query2);
	// System.out.println("query2:"+query2);
	 
	  while(rs.next())
	   {
	    %>
	    <tr bgcolor="#ffffff"> 
		   <td class=rptValue><%=++slno%></td>
		 
		<td class=rptValue>
		<%=rs.getString(2)%>
		</td>
		
	     <%
	       if(type.equals("w"))
	       {
	       		    
		   query="select (select nvl(count(f.source_code),0) from rws_ftk_testing_tbl f ,rws_mandal_subdivision_tbl sd where f.test_date is not null and substr (f.source_code,1,2)=sd.dcode and substr (f.source_code,6,2)=sd.mcode and to_date (f.test_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date (f.test_date,'dd/mm/yy') <=to_Date ('"+date1+"','dd/mm/yy')and sd.dcode='"+distcode.trim()+"' and sd.division_office_code='"+divcode+"' and sd.subdivision_office_code='"+rs.getString(1)+"')a,(select distinct nvl(count(w.source_code),0) from rws_water_sample_collect_tbl w ,rws_mandal_subdivision_tbl sd where w.samp_collect_date is not null and substr (w.source_code,1,2)=sd.dcode and substr(w.source_code,6,2)=sd.mcode and to_date (w.samp_collect_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date (w.samp_collect_date,'dd/mm/yy') <=to_Date ('"+date1+"','dd/mm/yy') and sd.dcode='"+distcode.trim()+"' and sd.division_office_code='"+divcode+"' and sd.subdivision_office_code='"+rs.getString(1)+"')b  from dual";
		    
		   }
		  stmt=conn.createStatement(); 
		   rs1=stmt.executeQuery(query);
		  // System.out.println("query:"+query);
		   //rs1.beforeFirst();
		   if(rs1.next())
		   {
		            noofhabs+=rs1.getInt(1);
                    noofhabs1+=rs1.getInt(2);
		   %>
		     <td class=rptValue><%=rs1.getString(1)%></td>
		     <td class=rptValue><%=rs1.getString(2)%></td>
		   <%} 
	  
	     }
	  
	  %>
	   <tr>
		<td class="btext" colspan=2>GRANDTOTAL</td>
		<td class="btext"><%=noofhabs%></td>
				<td class="btext"><%=noofhabs1%></td>
		</tr>
		
	<% }catch(Exception e)	{
	 e.printStackTrace();
	
	 }%>