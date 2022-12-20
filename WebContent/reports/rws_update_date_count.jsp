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
     //out.println("rTYPE = " +type);
	String districtName = String.valueOf(session.getAttribute("districtName"));
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
				<td class="bwborder"><a href="./rws_udate_count_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!--<td class="bwborder"><a href="./rws_excel1_prnt.jsp?rDistrict=<%=rDistrict%>" target="_new">Print |</a></td>
			    <td class="bwborder"><a href="./rws_excel1.jsp?rDistrict=<%=rDistrict
	            %>" target="_new">Excel</a></td>-->
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>DistrictWise-ModuleWise-EntryDetails-Report</font></td>	
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
	if(type.equals("b"))
	{
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Habitations</td>
		
	</tr>
<%	
	}
else if(type.equals("l"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Assets</td>
		
	</tr>
<%	
	}
else if(type.equals("d"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Works</td>
		
	</tr>
<%	
	}


	//coded add by srinivas
else if(type.equals("t"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Drought</td>
		
	</tr>


<%	
	}


	//coded add by srinivas
else if(type.equals("k"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Bills</td>
	</tr>


<%	
	}


	//coded add by srinivas
else if(type.equals("v"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Vouchers</td>
	</tr>
<%	
	}
	//end srinivas

	else if(type.equals("s"))
	{
	%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Slno</td>
		<td class=btext>Circle</td>	
		<td class=btext>Schools</td>
			</tr>
<%	
	}
	//if(rDistrict != null && rDistrict.equals("00"))
	//{
		//query2="SELECT distinct dcode,DNAME from rws_district_tbl order by dcode,dname";
    // }
	//if(!rDistrict.equals("00"))
	//{
		//System.out.println("IN DISTRICT SELECTION...");
		//stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       // query2="SELECT distinct dcode,DNAME from rws_district_tbl where dcode='"+rDistrict+"' order by //dcode,dname";
   // }
		//stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//stmt2= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//stmt3= conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	//rs=stmt1.executeQuery(query2);
	//System.out.println("query2 first"+query2);
	
	//rs.beforeFirst();
	int noofassets=0,noofhabs=0,noofworks=0;
	
		if(type.equals("b"))
		   {
		if(rDistrict != null && !rDistrict.equals("00"))
		{
		/*query ="SELECT distinct d.dcode,d.dname,count(hd.hab_code) from RWS_HABITATION_DIRECTORY_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and hd.update_date between '"+date+"' and '"+date1+"' and substr(hd.hab_code,1,2)='"+rDistrict+"' group by d.dcode,d.dname";*/
		
//		query ="select distinct d.dcode,d.dname,count(hd.hab_code) from RWS_HABITATION_DIRECTORY_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.hab_code,1,2)='"+rDistrict+"' group by d.dcode,d.dname";
		query = "select distinct d.dcode,d.dname,count(h.panch_code) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,RWS_HABITATION_DIR_DYNA_TBL hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.hab_code,1,2)='"+rDistrict+"'group by d.dcode,d.dname order by d.dcode";
		   }
		   else if(rDistrict != null && rDistrict.equals("00"))
			   {
			   /*query = "SELECT distinct d.dcode,d.dname,count(hd.hab_code) from RWS_HABITATION_DIRECTORY_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and hd.update_date between '"+date+"' and '"+date1+"'  group by d.dcode,d.dname";*/
        //         query ="select distinct d.dcode,d.dname,count(hd.hab_code) from RWS_HABITATION_DIRECTORY_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname";
				query = "select distinct d.dcode,d.dname,count(h.panch_code) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,RWS_HABITATION_DIR_DYNA_TBL hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') group by d.dcode,d.dname order by d.dname";
			   }
		   }
        else if(type.equals("l"))
		   {
		if(rDistrict != null && !rDistrict.equals("00"))
		{
		/* query = "SELECT distinct d.dcode,d.dname,count(ASSET_CODE) from RWS_ASSET_MAST_TBL hd,rws_district_tbl d  where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null AND hd.update_date between '"+date+"' and '"+date1+"' and  substr(hd.hab_code,1,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/
		query ="select distinct d.dcode,d.dname,count(hd.hab_code) from RWS_asset_mast_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.hab_code,1,2)='"+rDistrict+"' group by d.dcode,d.dname";

		// out.println("query"+query);
		}
		   else if(rDistrict != null && rDistrict.equals("00"))
			   {
			   /*query = "SELECT distinct d.dcode,d.dname,count(ASSET_CODE)from RWS_ASSET_MAST_TBL hd,rws_district_tbl d  where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null AND hd.update_date between '"+date+"' and '"+date1+"' GROUP by d.dcode,d.dname";*/
			   query ="select distinct d.dcode,d.dname,count(hd.hab_code) from RWS_asset_mast_TBL hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
			   }
		   }
		 else if(type.equals("d"))
		   {
			 if(rDistrict != null && !rDistrict.equals("00"))
			   {
         /* query= "SELECT distinct d.dcode,d.dname,count(Work_id)from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode and substr(hd.office_code,2,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/

		  query ="select distinct d.dcode,d.dname,count(hd.Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where substr(hd.office_code,2,2)=d.dcode and hd.prepared_on is not null and to_date(hd.prepared_on,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.prepared_on,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.office_code,2,2)='"+rDistrict+"' group by d.dcode,d.dname order by d.dcode";
			   }
                 else if(rDistrict != null && rDistrict.equals("00"))
			   {
					// out.println("in last");
					// out.println(rDistrict);
		/*query= "SELECT distinct d.dcode,d.dname,count(Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode GROUP by d.dcode,d.dname";*/
             query ="select distinct d.dcode,d.dname,count(hd.Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where substr(hd.office_code,2,2)=d.dcode and hd.prepared_on is not null and to_date(hd.prepared_on,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.prepared_on,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
		
			   }

		   }




//code is add by srinivas 

else if(type.equals("t"))
		   {
			 if(rDistrict != null && !rDistrict.equals("00"))
			   {
         /* query= "SELECT distinct d.dcode,d.dname,count(Work_id)from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode and substr(hd.office_code,2,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/

		    query ="select distinct d.dcode,d.dname,count(hd.habcode) from RWS_DROUGHT_HABITATION_TBL  hd,rws_district_tbl d where substr(hd.habcode,1,2)=d.dcode and hd.frm_date is not null and to_date(hd.frm_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.frm_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')and substr(hd.habcode,1,2)='"+rDistrict+"' group by d.dcode,d.dname";
			   }
                 else if(rDistrict != null && rDistrict.equals("00"))
			   {
					// out.println("in last");
					// out.println(rDistrict);
		/*query= "SELECT distinct d.dcode,d.dname,count(Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode GROUP by d.dcode,d.dname";*/
             query ="select distinct d.dcode,d.dname,count(hd.habcode) from RWS_DROUGHT_HABITATION_TBL  hd,rws_district_tbl d where substr(hd.habcode,1,2)=d.dcode and hd.to_date is not null and to_date(hd.to_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.to_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
		
			   }

		   }
		 

//end srinivas





		    else if(type.equals("s"))
		   {
			 if(rDistrict != null && !rDistrict.equals("00"))
			   {
         /* query= "SELECT distinct d.dcode,d.dname,count(Work_id)from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode and substr(hd.office_code,2,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/

		  query ="select distinct d.dcode,d.dname,count(hd.hab_code) from rws_school_master_tbl hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')and substr(hd.hab_code,1,2)='"+rDistrict+"' group by d.dcode,d.dname ";
			   }
                 else if(rDistrict != null && rDistrict.equals("00"))
			   {
					// out.println("in last");
					// out.println(rDistrict);
		/*query= "SELECT distinct d.dcode,d.dname,count(Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode GROUP by d.dcode,d.dname";*/
             query ="select distinct d.dcode,d.dname,count(hd.hab_code) from rws_school_master_tbl hd,rws_district_tbl d where substr(hd.hab_code,1,2)=d.dcode and hd.update_date is not null and to_date(hd.update_date,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.update_date,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
		
			   }

		   }




//Srinivas add code bills



 else if(type.equals("k"))
		   {
			 if(rDistrict != null && !rDistrict.equals("00"))
			   {
         /* query= "SELECT distinct d.dcode,d.dname,count(Work_id)from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode and substr(hd.office_code,2,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/

		  query ="select distinct d.dcode,d.dname,count(hd.Work_id) from  RWS_WORK_BILL_TBL hd,rws_district_tbl d where substr(hd.Work_id,5,2)=d.dcode and hd.UPDATE_DATE  is not null and to_date(hd.UPDATE_DATE ,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE ,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.Work_id,5,2)='"+rDistrict+"' group by d.dcode,d.dname";
			   }
                 else if(rDistrict != null && rDistrict.equals("00"))
			   {
					// out.println("in last");
					// out.println(rDistrict);
		/*query= "SELECT distinct d.dcode,d.dname,count(Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode GROUP by d.dcode,d.dname";*/
             query ="select distinct d.dcode,d.dname,count(hd.Work_id) from RWS_WORK_BILL_TBL hd,rws_district_tbl d where substr(hd.Work_id,5,2)=d.dcode and hd.UPDATE_DATE is not null and to_date(hd.UPDATE_DATE,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
		
			   }

		   }


//code is add by srinivas Vouchers



else if(type.equals("v"))
		   {
			 if(rDistrict != null && !rDistrict.equals("00"))
			   {
         /* query= "SELECT distinct d.dcode,d.dname,count(Work_id)from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode and substr(hd.office_code,2,2)='"+rDistrict+"' GROUP by d.dcode,d.dname";*/

		  query ="select distinct d.dcode,d.dname,count(hd.Work_id) from  RWS_WORK_exp_voucher_TBL hd,rws_district_tbl d where substr(hd.Work_id,5,2)=d.dcode and hd.UPDATE_DATE  is not null and to_date(hd.UPDATE_DATE ,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE ,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy') and substr(hd.Work_id,5,2)='"+rDistrict+"' group by d.dcode,d.dname";
			   }
                 else if(rDistrict != null && rDistrict.equals("00"))
			   {
					// out.println("in last");
					// out.println(rDistrict);
		/*query= "SELECT distinct d.dcode,d.dname,count(Work_id) from RWS_Work_Admn_TBL hd,rws_district_tbl d where hd.Prepared_on is not null AND hd.prepared_on between '"+date+"' and '"+date1+"' and substr(hd.office_code,2,2)=d.dcode GROUP by d.dcode,d.dname";*/
             query ="select distinct d.dcode,d.dname,count(hd.Work_id) from RWS_WORK_exp_voucher_TBL hd,rws_district_tbl d where substr(hd.Work_id,5,2)=d.dcode and hd.UPDATE_DATE is not null and to_date(hd.UPDATE_DATE,'dd/mm/yy') >= to_Date('"+ date+ "','dd/mm/yy') and to_date(hd.UPDATE_DATE,'dd/mm/yy') <=to_Date('"+ date1 + "','dd/mm/yy')  group by d.dcode,d.dname order by d.dname";
		
			   }

		   }












		   //System.out.println("query"+query);
         
		  rs1=stmt.executeQuery(query);
		  rs1.setFetchSize(500);
          rs1.last();
          Count = rs1.getRow();

		 // rs2=stmt2.executeQuery(query1);
		  //rs3=stmt3.executeQuery(query3);
		//System.out.println("query sec"+query);
          rs1.beforeFirst();
		   if(Count!=0)
		   {
		while(rs1.next())
       { %>
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><a href="./rws_mandal_udate_count.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>
		&date=<%=date%>&date1=<%=date1%>&type=<%=type%>"><%=rs1.getString(2)%></a></td>
	     <%
		 // rs2.beforeFirst();
		   // rs3.beforeFirst();
		  
		  if(!rs1.getString(3).equals("") || rs1.getString(3)!=null)
		   {%>
            <td class=rptValue><%=rs1.getInt(3)%></td>
			<%
			 noofhabs=noofhabs+rs1.getInt(3); 
		  }
		  else
			{ %>
             <td class=rptValue><%="-"%></td>
			<% } 
			
			}
			
		}
		else
		   { %>
                 <td class=rptValue colspan=3 align=center><a href="./rws_udate_count_frm.jsp"><b>No Records</b></a></td>
	     <%
		   }
	   %>
		 <tr>
		<td class="btext" colspan=2>GRANDTOTAL</td>
		<td class="btext"><%=noofhabs%></td>
		</tr>
		<!--<td class="btext"><%=noofassets%></td>
		<td class="btext"><%=noofworks%></td>-->
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
<input type="hidden" name="pass"> 

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
