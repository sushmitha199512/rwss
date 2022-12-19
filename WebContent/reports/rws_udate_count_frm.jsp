

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//.out.println("*****FROM BEGINING*****");
	String query, query1, query2, query3,FDATE=null, query4 = null;
	ResultSet rs1 = null;
	ResultSet rs5 = null;
	Statement stmt1 = null;	
	Statement stmt5 = null;	
%>
<html>
<head>

<script language="JavaScript">
       
function unview()
{ //alert("in function unview");
    var a=document.getElementById('date').value;
	
	if(a!="-1")
	{
       document.getElementById('dist').disabled=true;
	}
	 
}

	function fnSubmit()
	{
		
		if(document.f1.type.selectedIndex == "-1")
		{
			alert("SELECT Module...");
			return false;
		}
		
		// alert(document.f1.type.value);
		 if(document.f1.type.value == "w")
		{
	      // alert(" 111111111");
	        document.f1.action="./rws_update_date_count1.jsp";
		    document.f1.submit();		
		}
		else
		{
		   //  alert("2222222222");
	        document.f1.action="./rws_update_date_count.jsp";
			 document.f1.submit();		
		}
		
	}

	function userCheck()
	{
		 var response = '';
		 var path=  window.location.href;
		 var arr  = path.split("pred/");
		 $.ajax({ type: "POST",   
		          url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
		          async: false,
		          success : function(resp)
		          {
		        	  resp;
		              //window.location = '/../commons/UnAuthorize.jsp';

		          }
		 });  
	}
</script>

</head>
<body bgcolor="#edf2f8" onLoad="userCheck();">
<form name=f1 method="post">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=40%>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=40% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>DistrictWise-ModuleWise-EntryDetails-Report</td>	
	</tr>
<%
		String rDistrict= null;
		String fromDate=null;
		String toDate=null;
		String Year=null;
		String Type=null;%>
	<tr>
	<td class = btext nowrap><font color="navy" ><b>Module</b></font>
	<font color="red">*</font></td>
	<td class = btext colspan=3>
	<%if(Type == null || Type.equals("-1")){%>
	<SELECT name="type"   style="width:150px" class="mycombo" onChange="document.f1.submit()">
		<option value="-1">SELECT...</option>
				
<%}
try
{
	Type= request.getParameter("type");
	
	
	if(Type != null && !Type.equals("-1"))
		{
	
%>
					<%--<option value="<%=Type%>" SELECTed>ALL</option>
					<option value="b">HABITATIONS</option>		
					<option value="l">ASSETS</option>
					<option value="d">WORKS</option>--%>

<% 
	if(Type != null && Type.equals("b"))
	{
%>
			<option value="<%=Type%>" SELECTed>HABITATIONS</option>
			<!--<option value="p">ALL </option>-->
			<option value="l">ASSETS</option>
			<option value="d">WORKS</option>
			<option value="s">SCHOOLS</option>
			<option value="w">WATER QUALITY</option>
			<option value="t">DROUGHT</option>
           <option value="k">BILLS</option>
			<option value="v">VOUCHER</option>


<% } else if(Type != null && Type.equals("l"))
	 {
%>
			<option value="<%=Type%>" SELECTed>ASSETS</option>
			<!--<option value="p">ALL</option>-->
			<option value="b">HABITATIONS</option>		
			<option value="d">WORKS</option>
			<option value="s">SCHOOLS</option>
			<option value="w">WATER QUALITY</option>
			<option value="t">DROUGHT</option>
         <option value="k">BILLS</option>
			<option value="v">VOUCHER</option>

<% } else if(Type != null && Type.equals("d"))
	 {
%>
			<option value="<%=Type%>" SELECTed>WORKS</option>
			<!--<option value="p">ALL</option>-->
			<option value="b">HABITATIONS</option>		
			<option value="l">ASSETS</option>
		    <option value="s">SCHOOLS</option>
		    <option value="w">WATER QUALITY</option>
			<option value="t">DROUGHT</option>
		    <option value="k">BILLS</option>
			<option value="v">VOUCHER</option>

<% } else if(Type != null && Type.equals("s"))
{
	%>
				<option value="<%=Type%>" SELECTed>SCHOOLS</option>
				<!--<option value="p">ALL</option>-->
				<option value="b">HABITATIONS</option>
				<option value="l">ASSETS</option>
				<option value="d">WORKS</option>
				<option value="w">WATER QUALITY</option>
				<option value="t">DROUGHT</option>
			    <option value="k">BILLS</option>
		    	<option value="v">VOUCHER</option>

	<% }// code added by sridhar for water quality 
	else if(Type != null && Type.equals("w"))
	{
	 %>
	     <option value="<%=Type%>" SELECTed>WATER QUALITY</option>
				<!--<option value="p">ALL</option>-->
				<option value="b">HABITATIONS</option>
				<option value="l">ASSETS</option>
				<option value="d">WORKS</option>
				<option value="s">SCHOOLS</option>
				<option value="t">DROUGHT</option>
				<option value="k">BILLS</option>
			   <option value="v">VOUCHER</option>
  
	<%
	}
	

else if(Type != null && Type.equals("t"))
	{
	 %>
	     <option value="<%=Type%>" SELECTed>DROUGHT</option>
				<!--<option value="p">ALL</option>-->
				<option value="b">HABITATIONS</option>
				<option value="l">ASSETS</option>
				<option value="d">WORKS</option>
				<option value="s">SCHOOLS</option>
				<option value="k">BILLS</option>
			   <option value="v">VOUCHER</option>
  
	<%
	}
	else if(Type != null && Type.equals("k"))
	{
	 %>
	     <option value="<%=Type%>" SELECTed>BILLS</option>
				<!--<option value="p">ALL</option>-->
				<option value="b">HABITATIONS</option>
				<option value="l">ASSETS</option>
				<option value="d">WORKS</option>
				<option value="s">SCHOOLS</option>
                <option value="t">DROUGHT</option>     
			   <option value="v">VOUCHER</option>
  
				
	<%
	}
else if(Type != null && Type.equals("v"))
	{
	 %>
	     <option value="<%=Type%>" SELECTed>VOUCHER</option>
				<!--<option value="p">ALL</option>-->
				<option value="b">HABITATIONS</option>
				<option value="l">ASSETS</option>
				<option value="d">WORKS</option>
				<option value="s">SCHOOLS</option>
               <option value="t">DROUGHT</option>      
			   <option value="k">BILLS</option>
  
				
	<%
	}



	}
	else
	{
%>
			<!--<option value="p">ALL </option>-->
			<option value="b">HABITATIONS</option>		
			<option value="l">ASSETS</option>
			<option value="d">WORKS</option>
			<option value="s">SCHOOLS</option>
			<option value="w">WATER QUALITY</option>
			<option value="t">DROUGHT</option>
			<option value="k">BILLS</option>
			 <option value="v">VOUCHER</option>
  
<% }
	session.setAttribute("TYPE",Type);
%>
	
</SELECT></td>

</tr>
	
<% 
	rDistrict = request.getParameter("district");
      //System.out.println("rDistrict:=  " +rDistrict);	
      String usercode=RWS_USER.getCircleOfficeCode();
      String username=RWS_USER.getCircleOfficeName();
     //System.out.println("rdistname"+RWS_USER.getCircleOfficeName());
 if(!usercode.equals("00")){%>
 	<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
		<select name="district" style="width:150px" class="mycombo" id="date" onChange="this.form.submit()">
		<option value=<%=usercode%>><%=username%></option><%
		session.setAttribute("districtCode", usercode);
 	session.setAttribute("districtName", username);

 }
      
	else if((rDistrict == null || rDistrict.equals("-1")) && usercode.equals("00"))
	{
%>
<tr>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
		<select name="district" style="width:150px" class="mycombo" id="date" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		<option value="00">All</option>
<%
		session.setAttribute("districtCode", null);
		session.setAttribute("districtName", rDistrict);
	}
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
%>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
		<select name="district" style="width:150px" class="mycombo" id="date" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		<option value="00" SELECTED>All</option>
<% 
		session.setAttribute("districtCode",null);
		session.setAttribute("districtName",rDistrict);
		} 
		else 
			//code added by vikas 
			if(rDistrict != null && !rDistrict.equals("-1") && usercode.equals("00"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" id="date" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
			session.setAttribute("districtCode", rDistrict);
			}
			
		
			if(usercode.equals("00")){  
		stmt = conn.createStatement();
		query = "SELECT DISTINCT DCODE, DNAME FROM RWS_DISTRICT_TBL order by DCODE";
		
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rDistrict != null && rDistrict.equals(rs.getString(1)))
			{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
		session.setAttribute("districtCode", rDistrict);
		session.setAttribute("districtName", rs.getString(2));
			}
			else
			{					
%>
			<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%		session.setAttribute("districtCode", rDistrict);
			}
			}//end of IF			
		rs.close();			
		stmt.close();}
%>
	<tr>
		<td class=btext><font color=navy><b>Year</b></font>&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="year" style="width:150px" class="mycombo" onChange="this.form.submit()">
		    <option value="-1">SELECT...</option>
<%	
	String st4=null;
	String st5=null;
	Year = request.getParameter("year");
	//System.out.println("YEAR:= "+Year);
    stmt5 = conn.createStatement();
    //System.out.println("Type to compare "+Type);

	if(request.getParameter("type")!=null && request.getParameter("type").equals("b"))
	{  
		//System.out.println("Type b");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_HABITATION_DIR_DYNA_TBL where update_date is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_HABITATION_DIR_DYNA_TBL where substr(hab_code,1,2)='"+rDistrict+"' and update_date is not null order by 1 desc");
	}}
	else if(request.getParameter("type")!=null && request.getParameter("type").equals("l"))
	{
		//System.out.println("Type 1");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			 rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from rws_asset_mast_tbl where update_date is not null order by 1 desc");
			}else{
		 rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from rws_asset_mast_tbl where substr(hab_code,1,2)='"+rDistrict+"' and update_date is not null order by 1 desc");
	}}
	else if(request.getParameter("type")!=null && request.getParameter("type").equals("d"))
	{
		//System.out.println("Type d");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(prepared_on,'YYYY') from rws_work_admn_tbl where prepared_on is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(prepared_on,'YYYY') from rws_work_admn_tbl where substr(office_code,2,2)='"+rDistrict+"' and prepared_on is not null order by 1 desc");
	}}
	else if(request.getParameter("type")!=null && request.getParameter("type").equals("s"))
	{
		//System.out.println("Type s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from rws_school_master_tbl where update_date is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from rws_school_master_tbl where substr(hab_code,1,2)='"+rDistrict+"' and update_date is not null order by 1 desc");
	}}



//code add by Srinivas
else if(request.getParameter("type")!=null && request.getParameter("type").equals("t"))
	{
		//System.out.println("Type s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct YEAR from RWS_DROUGHT_HABITATION_TBL where YEAR is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct YEAR from RWS_DROUGHT_HABITATION_TBL  where substr(habcode,1,2)='"+rDistrict+"' and YEAR is not null order by 1 desc");
	}}
	
//coded end





//CODE IS ADD BY SRINIVAS BILLS



else if(request.getParameter("type")!=null && request.getParameter("type").equals("k"))
	{
		//System.out.println("Type s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_WORK_BILL_TBL where update_date is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_WORK_BILL_TBL hd where substr(hd.work_id,5,2)='"+rDistrict+"' and update_date is not null order by 1 desc");
	}}
//end





//code is add by srinivas vouchers
else if(request.getParameter("type")!=null && request.getParameter("type").equals("v"))
	{
		//System.out.println("Type s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_WORK_EXP_VOUCHER_TBL where update_date is not null order by 1 desc");
			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(update_date,'YYYY') from RWS_WORK_EXP_VOUCHER_TBL hd where substr(hd.work_id,5,2)='"+rDistrict+"' and update_date is not null order by 1 desc");
	}}

//end








	// code added by srinivas 
	else if(request.getParameter("type")!=null && request.getParameter("type").equals("w"))
	{
		//System.out.println("Type w");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs5 =stmt5.executeQuery("select distinct to_char(test_date,'YYYY') from rws_ftk_testing_tbl where test_date is not null union select to_char (SAMP_COLLECT_DATE,'YYYY') from rws_water_sample_collect_tbl where SAMP_COLLECT_DATE is not null order by 1 desc");

			}else{
		rs5 =stmt5.executeQuery("select distinct to_char(test_date,'YYYY') from rws_ftk_testing_tbl where substr(source_code,1,2)='"+rDistrict+"' and test_date is not null union select distinct to_char(samp_collect_date,'YYYY') from rws_water_sample_collect_tbl where substr (hab_code,1,2)='"+rDistrict+"' and samp_collect_date is not null order by 1 desc");
	}}
	//System.out.println("outside");		
	if(rs5!=null)
	{
		while(rs5.next())
		{			
	    	if(Year != null && Year.equals(rs5.getString(1)))
		    {
%>
		<option value="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(1)%></option>
<%
			}
			else
			{
%>
		<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%></option>
<%
			}
            session.setAttribute("YEAR",Year);
			
		}//End of while
		}//End of IF
%>
			</select>
		</td>
	</tr>
	
    <tr>
		<td class = btext nowrap>
			<font color=navy><b>From Date</b> </font>
			<font color="red">*</font></td>
			
		<td class = btext >
			<SELECT name="FDate" style="width:150px"  class="mycombo"  onChange="this.form.submit()">
			<option value="-1">SELECT...</option>
<%
	fromDate = request.getParameter("FDate");
    //System.out.println("fromDate:=   "+fromDate);
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		
	if(request.getParameter("type")!=null && !Type.equals("-1") && Type.equals("b"))
	{
		//System.out.println("Type f b");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_HABITATION_DIR_DYNA_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
			}else{
    	rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_HABITATION_DIR_DYNA_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	    }}
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("l"))
	{
		//System.out.println("Type f 1");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_asset_mast_tbl hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
			}else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_asset_mast_tbl hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	}}
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("d"))
	{
		//System.out.println("Type f d");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.prepared_on,'dd/mm/yy') as a1 from rws_work_admn_tbl hd where hd.prepared_on is not null and  to_CHAR(hd.prepared_on,'YYYY')='"+Year+"' order by 1 desc");
			}else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.prepared_on,'dd/mm/yy') as a1 from rws_work_admn_tbl hd where hd.prepared_on is not null and  to_CHAR(hd.prepared_on,'YYYY')='"+Year+"' and substr(hd.office_code,2,2)='"+rDistrict+"' order by 1 desc");
	}	}
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("s"))
	{
		//System.out.println("Type f s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_school_master_tbl hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"'order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");		   
			}
	 else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_school_master_tbl hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	}
	}

//CODE added by SRINIVAS FROM DATE 

else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("t"))
	{
		//System.out.println("Type f s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.FRM_DATE ,'dd/mm/yy') as a1 from RWS_DROUGHT_HABITATION_TBL  hd where hd.FRM_DATE is not null and  to_CHAR(hd.FRM_DATE,'YYYY')='"+Year+"'order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");		   
			}
	 else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.FRM_DATE,'dd/mm/yy') as a1 from RWS_DROUGHT_HABITATION_TBL hd where hd.FRM_DATE is not null and  to_CHAR(hd.FRM_DATE,'YYYY')='"+Year+"' and substr(hd.habcode,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	}
	}

//Code end


//code is add by Srinivas
else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("k"))
	{
		//System.out.println("Type f s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_BILL_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"'order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");		   
			}
	 else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_BILL_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' and substr(hd.work_id,5,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	}
	}
//end


//code is add by Srinivas
else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("v"))
	{
		//System.out.println("Type f s");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_EXP_VOUCHER_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"'order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");		   
			}
	 else{
   		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_EXP_VOUCHER_TBL hd where hd.update_date is not null and  to_CHAR(hd.update_date,'YYYY')='"+Year+"' and substr(hd.work_id,5,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
	}
	}
//end



	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("w"))
	{
		//System.out.println("Type f w");
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			///rs1=stmt1.executeQuery("select distinct to_char(f.test_date,'dd/mm/yy') from rws_ftk_testing_tbl f where f.test_date is not null and to_char (f.test_date,'YYYY')='"+Year+"'union select distinct to_char(w.samp_collect_date,'dd/mm/yy') from rws_water_sample_collect_tbl w where w.samp_collect_date is not null and to_char (w.samp_collect_date,'YYYY')='"+Year+"'");		   
			rs1=stmt1.executeQuery("select * from (select distinct to_char(f.test_date,'dd/mm/yy') as a1 from rws_ftk_testing_tbl f where f.test_date is not null and to_char (f.test_date,'YYYY')='"+Year+"' union select distinct to_char(w.samp_collect_date,'dd/mm/yy') as a1 from rws_water_sample_collect_tbl w where w.samp_collect_date is not null and to_char (w.samp_collect_date,'YYYY')='"+Year+"') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
			
			}
	 else{
   		 //rs1=stmt1.executeQuery("select distinct to_char(f.test_date,'dd/mm/yy') from rws_ftk_testing_tbl f where f.test_date is not null and to_char (f.test_date,'YYYY')='"+Year+"' and substr(f.source_code,1,2)='"+rDistrict+"' union select distinct to_char (w.samp_collect_date,'dd/mm/yy') from rws_water_sample_collect_tbl w where w.samp_collect_date is not null and to_char (w.samp_collect_date,'YYYY')='"+Year+"' and substr(w.hab_code,1,2)='"+rDistrict+"'");
   		  rs1=stmt1.executeQuery("select * from (select distinct to_char(f.test_date,'dd/mm/yy') as a1 from rws_ftk_testing_tbl f where f.test_date is not null and to_char (f.test_date,'YYYY')='"+Year+"' and substr(f.source_code,1,2)='"+rDistrict+"' union select distinct to_char(w.samp_collect_date,'dd/mm/yy') as a1 from rws_water_sample_collect_tbl w where w.samp_collect_date is not null and to_char (w.samp_collect_date,'YYYY')='"+Year+"' and substr(w.source_code,1,2)='"+rDistrict+"')order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
   		 
	   }
	}
	
	//System.out.println("before while"+rs1);
	if(rs1!=null)
	{
	while(rs1.next()) 
	{
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
	<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>

<% 
	//System.out.println("after while");		
    FDATE=rs1.getString(1);
	session.setAttribute("FDATE",FDATE);		
		}// END OF IF
		else 
		{
%>	
	<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%	
		} 
	}// END OF While
	  rs1.beforeFirst();
	}//end of IF 
%>
	</td>
 	<tr>
 		<td class = btext nowrap>
			<font color=navy><b>To Date:</b> </font>
			<font color="red">*</font></td>
		
		<td class = btext >
			<SELECT name="TDate" style="width:150px" class="mycombo"  onChange="this.form.submit()">
			<option value="-1">SELECT...</option>	
<%                    
	toDate = request.getParameter("TDate");
	//System.out.println("toDate:= "+toDate);
	
	if(request.getParameter("TDate")!=null)
	{
	//System.out.println("inside if");
	if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("b"))
	{
		//System.out.println("in type b");
		if(!request.getParameter("FDate").equals("-1"))
		{
       // System.out.println("fdate-1"+rDistrict);
		if(rDistrict != null && rDistrict.equals("00"))
		   {
            String qry="select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_HABITATION_DIR_DYNA_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			//System.out.println("Todate query"+qry);
			rs1=stmt1.executeQuery(qry);
			
           } else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_HABITATION_DIR_DYNA_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		   // System.out.println("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_habitation_directory_tbl hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
        }
		}
	}
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("l"))
	{
		//System.out.println("in type 1");
		if(!request.getParameter("FDate").equals("-1"))
		{
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_asset_mast_tbl hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
			} else{
		   rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_asset_mast_tbl hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		  }}
	}
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("d"))
	{					
		//System.out.println("in type d");
		if(!request.getParameter("FDate").equals("-1"))
		{
		if(rDistrict != null && rDistrict.equals("00"))
		   {
			rs1=stmt1.executeQuery("select distinct to_char(hd.prepared_on,'dd/mm/yy') as a1 from rws_work_admn_tbl hd where to_date(hd.prepared_on,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy')  order by 1 desc");
			} else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.prepared_on,'dd/mm/yy') as a1 from rws_work_admn_tbl hd where to_date(hd.prepared_on,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(hd.office_code,2,2)='"+rDistrict+"' order by 1 desc");
		}
		}
	}
	
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("s"))
	{					
		//System.out.println("in type s");
		if(!request.getParameter("FDate").equals("-1"))
		{
			if(rDistrict != null && rDistrict.equals("00"))
			   {
				rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_school_master_tbl hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
				} else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from rws_school_master_tbl hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(hd.hab_code,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		}
		}
	}

//code is add by Srinivas 

	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("t"))
	{					
		//System.out.println("in type s");
		if(!request.getParameter("FDate").equals("-1"))
		{
			if(rDistrict != null && rDistrict.equals("00"))
			   {
				rs1=stmt1.executeQuery("select distinct to_char(hd.TO_DATE,'dd/mm/yy') as a1 from RWS_DROUGHT_HABITATION_TBL  hd where to_date(hd.TO_DATE,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
				} else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.TO_DATE,'dd/mm/yy') as a1 from RWS_DROUGHT_HABITATION_TBL  hd where to_date(hd.TO_DATE,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(hd.habcode,1,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		}
		}
	}



else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("k"))
	{					
		//System.out.println("in type s");
		if(!request.getParameter("FDate").equals("-1"))
		{
			if(rDistrict != null && rDistrict.equals("00"))
			   {
				rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_BILL_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
				} else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_BILL_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(hd.work_id,5,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		}
		}
	}


else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("v"))
	{					
		//System.out.println("in type s");
		if(!request.getParameter("FDate").equals("-1"))
		{
			if(rDistrict != null && rDistrict.equals("00"))
			   {
				rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_EXP_VOUCHER_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
				} else{
		rs1=stmt1.executeQuery("select distinct to_char(hd.update_date,'dd/mm/yy') as a1 from RWS_WORK_EXP_VOUCHER_TBL hd where to_date(hd.update_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(hd.work_id,5,2)='"+rDistrict+"' order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		}
		}
	}




//end Srinivas
	else if(request.getParameter("type")!=null && !request.getParameter("type").equals("-1") && request.getParameter("type").equals("w"))
	{					
		 //System.out.println("in type w" +request.getParameter("type"));
		if(!request.getParameter("FDate").equals("-1"))
		{
		  // System.out.println(" after Fdate check");
			if(rDistrict != null && rDistrict.equals("00"))
			   {
			     //System.out.println(" in if ");
//srinivas


	rs1=stmt1.executeQuery("select * from (select distinct to_char(f.test_date,'dd/mm/yy') as a1 from rws_ftk_testing_tbl f where f.test_date is not null and to_char (f.test_date,'YYYY')>='"+Year+"' union select distinct to_char(w.samp_collect_date,'dd/mm/yy') as a1 from rws_water_sample_collect_tbl w where w.samp_collect_date is not null and to_char (w.samp_collect_date,'YYYY')>='"+Year+"') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
		

//srinivas end


			//	rs1=stmt1.executeQuery("select * from (select distinct to_char(f.test_date,'dd/mm/yy') as a1 from rws_ftk_testing_tbl f where to_date (f.test_date,'dd/mm/yy')>= to_date('"+fromDate+"','dd/mm/yy') and f.test_date is not null and to_char (f.test_date,'YYYY')='"+Year+"' union select distinct to_char(w.samp_collect_date,'dd/mm/yy') as a1 from rws_water_sample_collect_tbl w where to_date (w.samp_collect_date,'dd/mm/yy')>= to_date('"+fromDate+"','dd/mm/yy') and w.samp_collect_date is not null) and and to_char (w.samp_collect_date,'YYYY')='"+Year+"') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc");
				} else{
				   //System.out.println(" in else ");
		rs1=stmt1.executeQuery("select * from (select distinct to_char(f.test_date,'dd/mm/yy') as a1 from rws_ftk_testing_tbl f where to_date (f.test_date,'dd/mm/yy') >= to_date('"+fromDate+"','dd/mm/yy') and substr(f.source_code,1,2)='"+rDistrict+"' and f.test_date is not null union select distinct to_char (w.samp_collect_date,'dd/mm/yy') as a1 from rws_water_sample_collect_tbl w where to_date (w.samp_collect_date,'dd/mm/yy')>= to_date('"+fromDate+"','dd/mm/yy') and substr(w.source_code,1,2)='"+rDistrict+"' and w.samp_collect_date is not null) order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc ");
		}}
	}
	
	
   //System.out.println("Type selected ");
   if(rs1!=null)
   {
	while(rs1.next())
	{
		
	if(toDate != null && toDate.equals(rs1.getString(1)) )
	{
%>
	<option value="<%= rs1.getString(1) %>"SELECTed><%= rs1.getString(1) %>
<% 			
	 String TDATE=rs1.getString(1);
	 session.setAttribute("TDATE",TDATE);		
		}// END OF IF
		else 
		{
%>
		<option value="<%= rs1.getString(1) %>"><%= rs1.getString(1)%>
<%	
		} 
	}// END OF While
	}//End of IF
	
	}//End of IF of(type)
	//System.out.println("outside of if");
%>
			</option>
		</SELECT>
	</td>
</tr>

<% }
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
     try{
		conn.close();
    
     }
     catch(Exception e)
	{
		e.printStackTrace();
	}
	}
%>

<%	
  //System.out.println("end 1");
	if(rDistrict!= null && !rDistrict.equals("-1") && fromDate != null && !fromDate.equals("-1") && toDate != null && !toDate.equals("-1"))
	{
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=5 align=center>
			<input type=button onclick="fnSubmit()" id="dist" class=btext value="View Report">
		</td>
	</tr>
	
<%
//System.out.println("end2");
	}
%>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
						