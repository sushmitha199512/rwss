<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%

	//System.out.println("*****REPORT BEGINING*****");
	String distcode=null,distname=null;
	String date=null,date1=null,type=null;
	distcode=request.getParameter("dcode");
    distname=request.getParameter("dname");
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
try
{%>
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
		<td align="center" class="rptHeading" colspan=5>DivisionWise-ModuleWise-Report</font></td>	
	</tr>

	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=5><b><font color=blue>District: <%=distname%>&nbsp;&nbsp;FROM:<%=date%>&nbsp;To:<%=date1%></font></b></td>	
	</tr>	

	
<%	if(type.equals("b"))
	{
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Habitations</td>
		
	</tr>
<%	
	}
else if(type.equals("l"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Assets</td>
			</tr>
<%	
	}
else if(type.equals("d"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Works</td>
		
	</tr>
<%	
	}
//add code srinivas

else if(type.equals("t"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Drought</td>
		
	</tr>


<%
	}

	else if(type.equals("s"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Schools</td>
		
	</tr>




	
<%
	}

	else if(type.equals("k"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Bills</td>
		
	</tr>
<%
	}
	else if(type.equals("v"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Division</td>	
		<td class=btext>Voucher</td>
		
	</tr>




<%	
	}
		query2="SELECT distinct division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+distcode+"' order by  division_office_code,division_office_name";
     
	
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//stmt2= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//stmt3= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	    rs=stmt1.executeQuery(query2);
	//System.out.println("query2 first"+query2);
	
	rs.beforeFirst();
	int noofassets=0,noofhabs=0,noofworks=0;
	while(rs.next())
       { %>
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>	
		<% if(type.equals("b") || type.equals("l") || type.equals("s") || type.equals("t"))
		   { %>
		<td class=rptValue><a href="./rws_subdiv_udate_count.jsp?dcode=<%=distcode%>&dname=<%=distname%>&divcode=<%=rs.getString(1)%>&divname=<%=rs.getString(2)%>&date=<%=date%>&date1=<%=date1%>&type=<%=type%>">
		<%=rs.getString(2)%></a>
		</td>
	     <%
		   }
	      else
		   {%>
          <td class=rptValue><%=rs.getString(2)%></a></td>
		<%
		   }
         if(type.equals("b"))
		   {
		/*query = "SELECT distinct sd.division_office_code,count(hd.hab_code) from RWS_HABITATION_DIRECTORY_TBL hd,rws_mandal_subdivision_tbl sd where hd.update_date is not null and hd.update_date between '"+date+"' and '"+date1+"' and substr(hd.hab_code,1,2)=sd.dcode and substr(hd.hab_code,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";*/

		query ="select distinct sd.division_office_code,count(hd.hab_code) from RWS_HABITATION_DIR_DYNA_TBL hd,rws_mandal_subdivision_tbl sd where hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.hab_code,1,2)=sd.dcode and substr(hd.hab_code,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";
		   }
		   else if(type.equals("l"))
		   {
		/* query = "SELECT distinct sd.division_office_code,count(ASSET_CODE)from RWS_ASSET_MAST_TBL hd,rws_mandal_subdivision_tbl sd  where hd.update_date is not null AND hd.update_date between '"+date+"' and '"+date1+"'  and substr(hab_code,1,2)=sd.dcode and substr(hab_code,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";*/
           
		   query ="SELECT distinct sd.division_office_code,count(ASSET_CODE) from RWS_ASSET_MAST_TBL hd,rws_mandal_subdivision_tbl sd  where hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hab_code,1,2)=sd.dcode and substr(hab_code,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";
		
		   }
          else if(type.equals("d"))
		   {
		  /*query = "SELECT distinct substr(office_code,4,1),count(Work_id)from RWS_Work_Admn_TBL hd where Prepared_on is not null AND hd.PREPARED_ON between '"+date+"' and '"+date1+"' and substr(office_code,2,2)='"+distcode+"' and substr(office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(office_code,4,1)";*/
		  query ="select distinct substr(office_code,4,1),count(Work_id)from RWS_Work_Admn_TBL hd where Prepared_on is not null AND to_date(hd.prepared_on,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.prepared_on,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  and substr(office_code,2,2)='"+distcode+"' and substr(office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(office_code,4,1)";
		   }

//code is added by srinivas


  else if(type.equals("t"))
		   {
		  /*query = "SELECT distinct substr(office_code,4,1),count(Work_id)from RWS_Work_Admn_TBL hd where Prepared_on is not null AND hd.PREPARED_ON between '"+date+"' and '"+date1+"' and substr(office_code,2,2)='"+distcode+"' and substr(office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(office_code,4,1)";*/
		  query ="select distinct sd.division_office_code,count(hd.habcode) from RWS_DROUGHT_HABITATION_TBL  hd,rws_mandal_subdivision_tbl sd where hd.frm_date is not null and to_date(hd.frm_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.frm_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.habcode,1,2)=sd.dcode and substr(hd.habcode,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";
		   }


//end srinivas

     else if(type.equals("k"))
		   {
		 		  query ="select distinct substr(hb.office_code,4,1),count(hd.Work_id)from RWS_WORK_BILL_TBL hd, RWS_Work_Admn_TBL hb where hd.UPDATE_DATE is not null and hd.work_id=hb.work_id AND to_date(hd.UPDATE_DATE,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  and substr(hb.office_code,2,2)='"+distcode+"' and substr(hb.office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(hb.office_code,4,1)";				 
		   }


//end Srinivas 


//end srinivas

     else if(type.equals("v"))
		   {
		 		  query ="select distinct substr(hb.office_code,4,1),count(hd.Work_id)from RWS_WORK_EXP_VOUCHER_TBL hd, RWS_Work_Admn_TBL hb where hd.UPDATE_DATE is not null and hd.work_id=hb.work_id AND to_date(hd.UPDATE_DATE,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  and substr(hb.office_code,2,2)='"+distcode+"' and substr(hb.office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(hb.office_code,4,1)";				 
		   }


//end Srinivas 

            else if(type.equals("s"))
		   {
		  /*query = "SELECT distinct substr(office_code,4,1),count(Work_id)from RWS_Work_Admn_TBL hd where Prepared_on is not null AND hd.PREPARED_ON between '"+date+"' and '"+date1+"' and substr(office_code,2,2)='"+distcode+"' and substr(office_code,4,1)='"+rs.getString(1)+"' GROUP by substr(office_code,4,1)";*/
		  query ="select distinct sd.division_office_code,count(hd.hab_code) from rws_school_master_tbl hd,rws_mandal_subdivision_tbl sd where hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.hab_code,1,2)=sd.dcode and substr(hd.hab_code,6,2)=sd.mcode and sd.dcode='"+distcode+"' and sd.division_office_code='"+rs.getString(1)+"' group by sd.division_office_code";
		   }
		  rs1=stmt.executeQuery(query);
		  //rs2=stmt2.executeQuery(query1);
		   //rs3=stmt3.executeQuery(query3);
		//System.out.println("query sec"+query);
		//System.out.println("query third"+query1);
		//System.out.println("query four"+query3);
          rs1.beforeFirst();
		  //rs2.beforeFirst();
		  //rs3.beforeFirst();
		  if(rs1.next())
		   {%>
            <td class=rptValue><%=rs1.getInt(2)%></td>
			<%
			 noofhabs=noofhabs+rs1.getInt(2); 
		  }
		  else
			{ %>
             <td class=rptValue><%="-"%></td>
			<% } }%>
		 <tr>
		<td class="btext" colspan=2>GRANDTOTAL</td>
		<td class="btext"><%=noofhabs%></td>
		</tr>
	   
		
	<%

	rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();
	}
catch(Exception e)
{
	//e.printStackTrace();
}
	finally
	{
	conn.close();
	}
%>
</table>
<!--<input type="hidden" name="pass">-->

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
