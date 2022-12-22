<%@ include file="conn3.jsp" %>
<%@ include file="header_rpt.jsp" %>
<html>
<head>
<title>Main Screen</title>

<script language="JavaScript">
function getDivisions()
{
	document.f1.submit();
}
function getSubDivisions()
{
	document.f1.submit();
}
function fnsubmit()
{
	document.f1.action="PhysicalProgressWorksSummaryReport.jsp";
	document.f1.submit();
}
function assettypenn()
{
	alert("Select AssetType");
}
function check_all()
{
	alert("Select CircleName,AssetType,Year");
}
function year_check()
{
	alert("Select Year");
}
function yearasset_check()
{
	alert("Select AssetType,Year");
}
function assettypesubmit()
{
	document.f1.submit();
}
function yearsubmit()
{
	document.f1.submit();
}
function subdivsubmit()
{
	document.f1.submit();
}
</script>
<link rel="stylesheet" type="text/css" href="style.css"> 
</head>
<center>
<body align=center bgcolor="#ffffff">

<!-- <span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span> -->

<br><br>
<!-- <table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="/pred/resources/images/top_left_b.gif"></td>
			<td background="/pred/resources/images/top_center_b.gif" width="210" class="heading" valign="middle" align="center" class id ="mainheading">Physical Progress Works Summary Report</td>
			<td><img src="/pred/resources/images/top_right_b.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=357>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>Physical Progress Works Summary Report</center></B><font></td>
	    <td align=right><IMG SRC="/pred/resources/images/icon_help.gif" WIDTH="13" HEIGHT="13" style="cursor:hand">&nbsp;
		<IMG SRC="/pred/resources/images/cloapp.gif" WIDTH="13" HEIGHT="13" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>
<table border=1 cellspacing=1 cellpadding=1 width="40%" style="border-collapse:collapse" rules="none" bordercolor=navy >


<form name=f1 method="post" action="/pred/worksMonitoring/physicalprogressreportquery.jsp">
         
<%
     String ccode="";
	 int divcode=0;
	 String circlecode="";
	 String subdivcode="";
	 String dtr="";
	 String dtr1="";
	 String dtr2="";
	 String dtr3="";
	 GregorianCalendar cal = new GregorianCalendar();
	 String year[] = new String[1000];
	 int myear = cal.get(Calendar.YEAR);

	 int i = 0;	 
	 String typeofassetcode[]=new String[1000];
	 String assettype="";
	 String nyear="";
	 String month="";
	 String mmonth[]=new String[1000];
	 try
	 {   
		 %>
		
		<%	
			if(request.getParameter("circle") == null || request.getParameter("circle").equals("-1"))
		 {

			 %>
			 <tr>
		<td class=label><font face=verdana size=2><b>Circle *</td>
		<td class=label>:</td>
		 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:155px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" >ALL</option>

		 <%
		 }
		 else
		 
			 if(request.getParameter("circle") != null || request.getParameter("circle").equals("00"))
			 {
				 %>
				 
		<td class=label><font face=verdana size=2><b>Circle *</td>
		<td class=label>:</td>
				 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:155px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" selected>ALL</option>
		 <%
			 }
		 else 
			if(!request.getParameter("circle").equals("-1"))  
			{
			 %>
			 <td class=label><b>Circle *</td>
		<td class=label>:</td>
				 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:155px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" >ALL</option>
		 <%
			}
		 String str="";
		// str="select head_office_code,circle_office_code,circle_office_name from rws_circle_office_tbl";
		//str="select distinct substr(office_code,2,2) as circleoffcode,circle_office_name  from rws_physical_progress_tbl pp,rws_circle_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code";
		str="select distinct substr(office_code,2,2) as circleoffcode,circle_office_name  from rws_work_admn_tbl pp,rws_circle_office_tbl co,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt where pp.work_id = ta.work_id and ta.work_id = we.work_id and we.work_id = mt.work_id and substr(pp.office_code,2,2)=co.circle_office_code";
		 pstmt=conn.prepareStatement(str);
		
		 rs=pstmt.executeQuery();
		 while(rs.next())
		 {
            ccode=rs.getString(1);
			
			if(request.getParameter("circle") != null &&
			request.getParameter("circle").equals(rs.getString(1))) 
		     {
             %>
			 <option value=<%=rs.getString(1)%> selected><%=rs.getString(2)%>
			 </option>
			 <%
			 }
			else
			{
	      %>
					<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
	<%
			}
	  }
	rs.close();
	%>
	</select></td></tr>
	
       <%  
			circlecode=request.getParameter("circle");
	   if(circlecode==null)
				circlecode="";
	   assettype=request.getParameter("AssetType");
if(assettype==null)
assettype="";
nyear=request.getParameter("cmbYear");
if(nyear==null)
nyear="";
//divcode=Integer.parseInt(request.getParameter("division"));
//if(request.getParameter("division").equals("null"))
//		 {
//	divcode=0;
//		 }
		 
System.out.println("divcode"+divcode);

String AssetType=request.getParameter("AssetType");
if(AssetType==null)
AssetType="";
//month=request.getParameter("cmbMonth");
//if(month==null)
//month="";
	     // dtr="select head_office_code,circle_office_code,division_office_code,division_office_name from rws_division_office_tbl where circle_office_code= '" + circlecode + "' ";
		 // dtr="select distinct substr(office_code,4,1) as divisionoffcode,division_office_name  from rws_physical_progress_tbl pp,rws_division_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,2,2) = ?";
		 dtr="select distinct substr(office_code,4,1) as divisionoffcode,division_office_name  from rws_work_admn_tbl pp,rws_division_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,2,2) = ?";
		  pstmt=conn.prepareStatement(dtr); 	
		  pstmt.setString(1,circlecode);
	  	  rs=pstmt.executeQuery();	      
%>
	<tr>
	<td class=label><font face=verdana size=2><b>Division</td>
	<td class=label>:</td>
	<td><select name=division onChange="getSubDivisions()" class="comboFont" style="width:155px">
	 <option value=0></option>
<%
	  while (rs.next())
	  {
	      if(request.getParameter("division") != null && Integer.parseInt(request.getParameter("division")) == rs.getInt(1))
		  {
        %>
			<option value=<%=rs.getInt(1)%>  selected><%=rs.getString("division_office_name")%></option>
		<%
		  }
		else
		  {
         %>
          <option value=<%=rs.getInt(1)%>> <%=rs.getString("division_office_name")%></option>
		  <%
		  }
  
		  }
	rs.close();
	%>
	</select></td></tr>
	<tr>
      <%  
			if (request.getParameter("circle") != null)
			{
				circlecode=request.getParameter("circle");
			}
			if (request.getParameter("division") != null)
			{
				divcode = Integer.parseInt(request.getParameter("division"));	   
			}
			System.out.println("circlecode"+request.getParameter("circle"));
	System.out.println("divisioncode"+request.getParameter("division"));
	
	System.out.println("assettype"+request.getParameter("AssetType"));
	System.out.println("year"+request.getParameter("cmbYear"));
	System.out.println("month"+request.getParameter("cmbMonth"));
			
%>
	
	
	</tr>
	
		<tr>
		<td class=label><font face=verdana size=2><b>AssetType *</td>
	<td class=label>:</td>
	<td><select name=AssetType  onChange="assettypesubmit()" class="comboFont" style="width:155px">
	 <!-- <option value=0>Please Select...</option> --> 
<%
	if(request.getParameter("division")!=null)
		 {
	if(circlecode.equals("00"))
		 {
	        //dtr2="select type_of_asset_code,type_of_asset_name from rws_asset_type_tbl";
//dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "'";
//dtr2="select distinct TYPE_OF_ASSET,type_of_asset_name from rws_work_admn_tbl pp,rws_asset_type_tbl at,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE order by pp.TYPE_OF_ASSET";
dtr2="select distinct TYPE_OF_ASSET,type_of_asset_name from rws_work_admn_tbl pp,rws_asset_type_tbl at,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and pp.work_id = ta.work_id and ta.work_id = we.work_id and we.work_id = mt.work_id order by pp.TYPE_OF_ASSET";
System.out.println("assettype"+dtr2);
}
else
	if(!circlecode.equals("00") && divcode==0 )
		 {
	dtr2="select distinct TYPE_OF_ASSET,type_of_asset_name from rws_work_admn_tbl pp,rws_asset_type_tbl at,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and pp.work_id = ta.work_id and ta.work_id = we.work_id and we.work_id = mt.work_id and substr(pp.office_code,2,2) = '" + circlecode + "' order by pp.TYPE_OF_ASSET";
		 }
else
	if(!circlecode.equals("00") && divcode!=0 )
	 {
	dtr2="select distinct TYPE_OF_ASSET,type_of_asset_name from rws_work_admn_tbl pp,rws_asset_type_tbl at,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and pp.work_id = ta.work_id and ta.work_id = we.work_id and we.work_id = mt.work_id and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1) = '" + divcode + "' order by pp.TYPE_OF_ASSET";
	 }
//else
//	if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
//	 {
//	dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1) = '" + divcode + "' and substr(pp.office_code,5,2) = '" + subdivcode + "' order by pp.asset_type";
//	 }
		
            pstmt=conn.prepareStatement(dtr2);
			rs=pstmt.executeQuery();
	     while (rs.next())
		{
	       typeofassetcode[i]=rs.getString(1);
		 if(request.getParameter("AssetType") != null && request.getParameter("AssetType").equals(rs.getString(1)))
		
			{
        %>
		<option value=<%=rs.getString(1)%> selected><%=rs.getString(2)%></option>
		
		<%
			}
		else
		  {
         %>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(2)%></option>
		<%
		  }
         i++;
         
		  }
		  rs.close();
		 }
	i=0;
	System.out.println("Before year");
	%>
	</select></td>
	</tr>

	<tr>
	<td class=label><font face=verdana size=2><b>Year *</td>
	<td class=label>:</td>
	<td><select name=cmbYear  onChange="yearsubmit()" class="comboFont" style="width:155px">
	<!-- <option value=0>Please Select...</option> -->
<%
//	for (i=0; i < 5; i++)
//	{
//		year = myear+i-4;
%>
		<!-- <option value=<%=year%>><%=year%></option> -->
<%
	//}

if(request.getParameter("AssetType")!=null)
		 {
if(circlecode.equals("00"))
		 {
	//dtr3="select distinct year from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type='"+AssetType+"'";
	System.out.println("typeofassetcode"+typeofassetcode[0]);
	//dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa where pp.work_id = wa.work_id and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
	dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
	System.out.println("dtr3"+dtr3);
		 }
 else
		 if(!circlecode.equals("00") && divcode==0 )
		 {
	 dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and substr(office_code,2,2)='"+circlecode+"' and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
	System.out.println("dtr32"+dtr3);
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 )
		 {
			dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and substr(office_code,2,2) = '" + circlecode + "' and substr(office_code,4,1) = '" + divcode + "' and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
		 }
 
		 
//nyear=request.getParameter("cmbYear");
pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       year[i]=rs.getString(1);
		   if(request.getParameter("cmbYear") != null && request.getParameter("cmbYear").equals(rs.getString(1)))
			{
			   %>
		 <option value=<%=rs.getString(1)%> selected><%=rs.getString(1)%></option>
		 <%
		 }
		 else
			{
		%>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(1)%></option>
		<%
			}
         
         i++;
		  }
	rs.close();
		 }
		i=0; 
	if(circlecode.equals("00") && nyear.equals(""))
		 {
			 dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
			 pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       year[i]=rs.getString(1);
		   
		%>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(1)%></option>
		<%
			}
         
         i++;
		  }
		 
		  if(!circlecode.equals("00") && nyear.equals(""))
		 {
			 dtr3="select distinct year from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and substr(office_code,2,2)='"+circlecode+"' and wa.TYPE_OF_ASSET='"+typeofassetcode[0]+"'";
			 pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       year[i]=rs.getString(1);
		   
		%>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(1)%></option>
		<%
			}
         i++;
         
		  }
		i=0;
		System.out.println("Before Month");
	%>


	</td>
	</tr>

	<tr>
	<td class=label><font face=verdana size=2><b>Month</td>
	<td class=label>:</td>
	<td><select name=cmbMonth class="comboFont" onChange="yearsubmit()" style="width:155px">
	<option value=0></option>
<%
	//if(request.getParameter("cmbYear")!=null)
		 //{
if(circlecode.equals("00"))
		 {
	//dtr3="select distinct year from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type='"+AssetType+"'";
	System.out.println("typeofassetcode"+typeofassetcode[0]);
	//dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	//dtr3="select distinct month,month_name from RWS_WORK_EXPENDITURE_TBL pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.year = '" + year[0] + "'";
	dtr3="select distinct month,month_name from RWS_WORK_EXPENDITURE_TBL pp,rws_month_mast_tbl mm,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.month=mm.month_code and pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and pp.year = '" + year[0] + "'";
		 }
 else
		 if(!circlecode.equals("00") && divcode==0 )
		 {
	 //dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	 dtr3="select distinct month,month_name from RWS_WORK_EXPENDITURE_TBL pp,rws_month_mast_tbl mm,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.month=mm.month_code and pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and substr(wa.office_code,2,2)='"+circlecode+"' and pp.year = '" + year[0] + "'";
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 )
		 {
			 //dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
			 dtr3="select distinct month,month_name from RWS_WORK_EXPENDITURE_TBL pp,rws_month_mast_tbl mm,rws_work_admn_tbl wa,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.month=mm.month_code and pp.work_id = wa.work_id and wa.work_id = ta.work_id and ta.work_id = mt.work_id and substr(office_code,2,2)='"+circlecode+"' and substr(office_code,4,1) = '" + divcode + "' and pp.year = '" + year[0] + "'";
		 }
// else
//		if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
//		 {
//			 dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and substr(pp.office_code,5,2) = '" + subdivcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
//			 
//		 }
		 
//nyear=request.getParameter("cmbYear");
pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	      mmonth[i]=rs.getString(1);
		   if(request.getParameter("cmbMonth") != null && request.getParameter("cmbMonth").equals(rs.getString(1)))
			{
			   %>
		 <option value=<%=rs.getString(1)%> selected><%=rs.getString(2)%></option>
		 <%
		 }
		 else
			{
		%>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(2)%></option>
		<%
			}
         
         
		  }
	rs.close();
	i=0;
		 //}
	System.out.println("Before work");
%>
	</td>
	</tr>
	

<tr>
	<td class=label><font face=verdana size=2><b>Work</td>
	<td class=label>:</td>
	<td><select name=cmbWork class="comboFont" style="width:155px">
	<option value=0></option>
<%
	//if(request.getParameter("cmbYear")!=null)
		 //{
if(circlecode.equals("00"))
		 {
	//dtr3="select distinct year from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type='"+AssetType+"'";
	System.out.println("yearrrrrr"+year[0]);
	//dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	//dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm where pp.work_id=mm.work_id and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
	dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id=mm.work_id and mm.work_id = ta.work_id and ta.work_id = mt.work_id and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
	System.out.println("dtr3"+dtr3);
		 }
 else
		 if(!circlecode.equals("00") && divcode==0 )
		 {
	 //dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	 //dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm where pp.work_id=mm.work_id and  substr(office_code,2,2)='"+circlecode+"' and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
	dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id=mm.work_id and mm.work_id = ta.work_id and ta.work_id = mt.work_id and  substr(office_code,2,2)='"+circlecode+"' and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 )
		 {
			 //dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
			 //dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm where pp.work_id=mm.work_id and substr(office_code,2,2)='"+circlecode+"' and substr(office_code,4,1) = '" + divcode + "' and pp.month=mm.month_code and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
		 dtr3="select distinct mm.work_id,work_name from RWS_WORK_EXPENDITURE_TBL pp,rws_work_admn_tbl mm,RWS_TENDER_APPL_TBL ta,rws_milestone_target_ach_tbl mt where pp.work_id=mm.work_id and mm.work_id = ta.work_id and ta.work_id = mt.work_id and substr(office_code,2,2)='"+circlecode+"' and substr(office_code,4,1) = '" + divcode + "' and pp.year = '" + year[0] + "' and pp.month = '" + mmonth[0] + "'";
		 }
// else
//		if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
//		 {
//			 dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and substr(pp.office_code,5,2) = '" + subdivcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
//			 
//		 }
		 
//nyear=request.getParameter("cmbYear");
pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	      
		   if(request.getParameter("cmbWork") != null && request.getParameter("cmbWork").equals(rs.getString(1)))
			{
			   %>
		 <option value=<%=rs.getString(1)%> selected><%=rs.getString(2)%></option>
		 <%
		 }
		 else
			{
		%>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(2)%></option>
		<%
			}
         
         
		  }
	rs.close();
	i=0;
		 //}
	
%>
	</td>
	</tr>


    <%
	 }


			 catch(Exception e)
			 {
			   System.out.println(e);
			   }
			   %>
         	   </td></tr>
			   </table>
			  <!-- <table cellpadding="0" cellspacing="0" >
		<tr>	

			<td><img src="/pred/resources/images/bottom_left.gif"></td>
			<td background="/pred/resources/images/bottom_center.gif" width="230" class="heading" valign="middle"	align="center"></td>
			<td><img src="/pred/resources/images/bottom_right.gif" ></td>
		</tr>
		</table> -->
		<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=358>
	  <!-- <FONT  style="font-size:9pt" color="#000000"><font color="#FF6666" >*</font>&nbsp;Data mandatory</FONT></td> -->
	  <TD WIDTH="20" bordercolor=white><IMG SRC="/pred/resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
		<tr>
<!-- </form> -->
<br>
<!-- <td colspan=3 align=center><input type=button value=submit name=button1 onclick="fnsubmit()"></td> -->
<%

//out.println("circlecode"+circlecode);
//out.println("nyear"+nyear);
//out.println("assettype"+assettype);
//out.println("divcode"+divcode);
if(circlecode.equals(""))
{
	%>
		<td colspan=3 align=center><input type=button value=submit name=button1 onclick="check_all()"></td>
		<%
}
if(!circlecode.equals("-1") && !assettype.equals("0") && !nyear.equals("0") && !circlecode.equals(""))
{
	%>
<td colspan=3 align=center><input type=button value=submit name=button1 onclick="fnsubmit()"></td>
<%
}

if(!circlecode.equals("-1") && nyear.equals("0") && assettype.equals("0"))
{
	%>
	<td colspan=3 align=center><input type=button value=submit name=button1 onclick="yearasset_check()"></td>
	<%
		
}
if(!circlecode.equals("-1") && nyear.equals("0") && !assettype.equals("0"))
{
	%>
	<td colspan=3 align=center><input type=button value=submit name=button1 onclick="year_check()"></td>
	<%
		
}

if(circlecode.equals("-1") && nyear.equals("0") && assettype.equals("0"))
{
	%>
	<td colspan=3 align=center><input type=button value=submit name=button1 onclick="check_all()"></td>
	<%
		
}
if(circlecode.equals("-1") && !nyear.equals("0") && !assettype.equals("0"))
{
	%>
	<td colspan=3 align=center><input type=button value=submit name=button1 onclick="check_all()"></td>
	<%
		
}
%>
</tr>
<br>
<tr><td align=center class=label><font face=verdana size=2><b>Fields Marked * are Mandatory</td></tr>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>
			   </form>
               </center>


			   </body>
			   </html>

			   