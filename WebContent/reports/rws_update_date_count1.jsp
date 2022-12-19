<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");

	String rDistrict=null;
	String date=null,date1=null,type=null;
	rDistrict = String.valueOf(session.getAttribute("districtCode"));
	date = String.valueOf(session.getAttribute("FDATE"));
	date1 = String.valueOf(session.getAttribute("TDATE"));
	type = String.valueOf(session.getAttribute("TYPE"));
	String type1 = "w1";
     //out.println("rTYPE = " +type);
	String districtName = String.valueOf(session.getAttribute("districtName"));
	//int pass = Integer.parseInt(request.getParameter("pass"));
	String query=null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null, query9 = null, query10 = null, query11 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null ;
	int slno = 0,NOP=0;
	int Count = 0, i = 0,Count1=0;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0,nodatatotal=0,subfctotal=0,subpc1total=0,subpc2total=0,subpc3total=0,subpc4total=0,subnctotal=0,subnsstotal=0,subuitotal=0,subnodatatotal=0,NOP1=0;
	int noofassets=0,noofhabs=0,noofhabs1=0,noofworks=0;
	
	String ftk="";
	String lab="";
	
try
{
	stmt1 = conn.createStatement();
	
	
	%>
<html>
<head>

</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_udate_count_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!--<td class="bwborder"><a href="./rws_excel1_prnt.jsp?rDistrict=<%=rDistrict%>" target="_new">Print |</a></td>
			    <td class="bwborder"><a href="./rws_excel1.jsp?rDistrict=<%=rDistrict
	            %>" target="_new">Excel</a></td>-->
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>DistrictWise-ModuleWise-EntryDetails-Report</td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5><font color=blue><b>District: All&nbsp;&nbsp;FROM:<%=date%>&nbsp;To:<%=date1%></b></font></td>
	
		</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5><b><font color=blue>District: <%=districtName%>&nbsp;&nbsp;FROM:<%=date%>&nbsp;To:<%=date1%></font></b></td>	
	</tr>	

	<%
		}
		
  if(type.equals("w"))
	{
 	
	%>
	  
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Water Quality</td>
	</tr>
	   <tr align=center bgcolor="#ffffff" align=center>
	      <td class=btext>Slno</td>
		  <td class=btext>Circle</td>	
		  <td class=btext>Ftk Samples </td>
		  <td class=btext>Lab Samples</td>
	   </tr>
	     <%	
	}
	
	   stmt = conn.createStatement();
	   
     	//System.out.println("rdist:"+rDistrict);
		  if(type.equals("w") )
		 {
		   
		    if(  rDistrict!=null && rDistrict.equals("00"))
		    { 
		     query1="select dcode,dname from rws_district_tbl where dcode<>'16' order by dname ";	
			
		    rs=stmt.executeQuery(query1);	
		    //System.out.println("dist query******:"+query1); 
			while(rs.next())
		      {          
			   // System.out.println("1111111111111"); 	 
			      query="select(select distinct nvl(count(f.source_code),0) from rws_ftk_testing_tbl f, rws_district_tbl d where substr (f.source_code,1,2)=d.dcode and f.test_date is not null and substr (f.source_code,1,2)='"+rs.getString(1)+"' and to_date(f.test_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date(f.test_date,'dd/mm/yy') <=to_Date('"+date1+"','dd/mm/yy') and f.test_date is not null)a,(select distinct nvl(count(w.source_code),0) from rws_water_sample_collect_tbl w, rws_district_tbl d where substr (w.hab_code,1,2)=d.dcode and w.samp_collect_date is not null and substr (w.source_code,1,2)='"+rs.getString(1)+"' and to_date (w.samp_collect_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date (w.samp_collect_date,'dd/mm/yy') <=to_Date('"+date1+"','dd/mm/yy'))b from dual";

	              //System.out.println("all query********************"+query); 	 
			       rs1=stmt1.executeQuery(query);
		         
				 
				  
				  
				  // rs1.setFetchSize(500);
          		/* rs1.last();
          			 Count = rs1.getRow();

		  			rs1.beforeFirst();
            System.out.println("Count: "+Count);*/
                     
	         	if(rs1.next())
                 {
                   // System.out.println("DDDDDDDD "+rs.getString(2)); 
                    noofhabs+=rs1.getInt(1);
                    noofhabs1+=rs1.getInt(2);%>
                  <tr bgcolor="#ffffff">
		          <td class=rptValue><%=++slno%></td>	
		          <td class=rptValue><a href="./rws_mandal_udate_count1.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>
					&date=<%=date%>&date1=<%=date1%>&type=<%=type%>"><%=rs.getString(2)%></td>
		          <td class=rptValue><%=rs1.getString(1)%></td>
		           <td class=rptValue><%=rs1.getString(2)%></td>
                  <%
          // System.out.println("srinivaskkkkskdalskdaksd");
			}
		
	}  %>
		 <tr>
		<td class="btext" colspan=2>GRANDTOTAL</td>
		<td class="btext"><%=noofhabs%></td>
		<td class="btext"><%=noofhabs1%></td>
		</tr>
		<!--<td class="btext"><%=noofassets%></td>
		<td class="btext"><%=noofworks%></td>-->
	<%
    		   
  } 
  //else if (rDistrict !=null && rDistrict .equals("-1"))
	//	 {
		//query1="select dcode,dname from rws_district_tbl where dcode<>'16'  and dcode='"+rDistrict+"' order by dname ";	
 //}
  else 
  {
  query="select(select distinct nvl(count(f.source_code),0) from rws_ftk_testing_tbl f, rws_district_tbl d where substr (f.source_code,1,2)=d.dcode and f.test_date is not null and substr (f.source_code,1,2)='"+rDistrict+"' and to_date(f.test_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date(f.test_date,'dd/mm/yy') <=to_Date('"+date1+"','dd/mm/yy') and f.test_date is not null)a, (select distinct nvl(count(w.source_code),0) from rws_water_sample_collect_tbl w, rws_district_tbl d where substr (w.hab_code,1,2)=d.dcode and w.samp_collect_date is not null and substr (w.source_code,1,2)='"+rDistrict+"' and to_date (w.samp_collect_date,'dd/mm/yy') >= to_Date ('"+date+"','dd/mm/yy') and to_date (w.samp_collect_date,'dd/mm/yy') <=to_Date('"+date1+"','dd/mm/yy'))b from dual";

			  // System.out.println("query****srinivas****"+query); 
			   
			     rs1=stmt1.executeQuery(query);
		        	          
	         	if(rs1.next())
                 {
                   // System.out.println("srinivaskkk"+rs1.getInt(2)); 
                    noofhabs+=rs1.getInt(1);
                    noofhabs1+=rs1.getInt(2);%>
                  <tr bgcolor="#ffffff">
		          <td class=rptValue><%=++slno%></td>	
		           <td class=rptValue><a href="./rws_mandal_udate_count1.jsp?dcode= <%= rDistrict%>&dname=<%=districtName %>
					&date=<%=date%>&date1=<%=date1%>&type=<%=type%>"><%=districtName%></td>
		           <td class=rptValue><%=rs1.getInt(1)%></td>
		            <td class=rptValue><%=rs1.getInt(2)%></td>
                  <%
                 			}
  }
 
   //	rs.close(); rs1.close();// rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	//stmt.close(); stmt1.close();// stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();

 }  

 }
 
catch(Exception e)
{
e.printStackTrace();
}
	finally
	{
	//conn.close();
	}
	%>
</table>

<input type="hidden" name="pass"> 

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
		   