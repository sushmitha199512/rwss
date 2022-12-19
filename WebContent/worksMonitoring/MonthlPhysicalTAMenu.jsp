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
	document.f1.action="/pred/worksMonitoring/MonthlyPhysicalTAReport.jsp";
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
<table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="/pred/resources/images/top_left_b.gif"></td>
			<td background="/pred/resources/images/top_center_b.gif" width="280" class="heading" valign="middle" align="center" class id ="mainheading">Physical Targets&Achievements Report</td>
			<td><img src="/pred/resources/images/top_right_b.gif"></td>
		</tr>
	</table>
<table border=1 cellspacing=1 cellpadding=1 width="380" style="border-collapse:collapse" rules="none" bordercolor=navy >


<form name=f1 method="post" action="/pred/worksMonitoring/MonthlPhysicalTAMenu.jsp">
         
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
	 try
	 {   
		 %>
		
		<%	
			if(request.getParameter("circle") == null || request.getParameter("circle").equals("-1"))
		 {

			 %>
			 <tr>
		<td class=label>Circle *</td>
		<td class=label>:</td>
		 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:127px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" >ALL</option>

		 <%
		 }
		 else
		 
			 if(request.getParameter("circle") != null || request.getParameter("circle").equals("00"))
			 {
				 %>
				 
		<td class=label>Circle *</td>
		<td class=label>:</td>
				 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:127px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" selected>ALL</option>
		 <%
			 }
		 else 
			if(!request.getParameter("circle").equals("-1"))  
			{
			 %>
			 <td class=label>Circle *</td>
		<td class=label>:</td>
				 <td><select name=circle onChange="getDivisions()" class="comboFont" style="width:127px"> 
		<!-- <td><select name=circle onChange="this.form.submit()" class="comboFont"> -->
         <option value="-1" >Please Select...</option>
		
         <option value="00" >ALL</option>
		 <%
			}
		 String str="";
		// str="select head_office_code,circle_office_code,circle_office_name from rws_circle_office_tbl";
		str="select distinct substr(office_code,2,2) as circleoffcode,circle_office_name  from rws_physical_progress_tbl pp,rws_circle_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code";
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
		  dtr="select distinct substr(office_code,4,1) as divisionoffcode,division_office_name  from rws_physical_progress_tbl pp,rws_division_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,2,2) = ?";
		  pstmt=conn.prepareStatement(dtr); 	
		  pstmt.setString(1,circlecode);
	  	  rs=pstmt.executeQuery();	      
%>
	<tr>
	<td class=label>Division</td>
	<td class=label>:</td>
	<td><select name=division onChange="getSubDivisions()" class="comboFont" style="width:127px">
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
			
%>
	
	<td class=label>SubDivision</td>
	<td class=label>:</td>
	<td><select name=subdivision onChange="subdivsubmit()" class="comboFont" style="width:127px">
	 <option value=0></option>
<%
	if (request.getParameter("circle") != null && request.getParameter("division") != null)
	{   
	   // dtr1="select head_office_code,circle_office_code,division_office_code,subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where circle_office_code= '" + circlecode + "' and division_office_code=" + divcode + " ";
		dtr1="select distinct substr(office_code,5,2) as subdivisionoffcode,subdivision_office_name  from rws_physical_progress_tbl pp,rws_subdivision_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code AND substr(office_code,5,2)=co.subdivision_office_code and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1)='"+divcode+"'";
		pstmt=conn.prepareStatement(dtr1);
		rs=pstmt.executeQuery();
	    while (rs.next())
		{
			
	      subdivcode=rs.getString(1);
		 if(request.getParameter("subdivision") != null && request.getParameter("subdivision").equals(rs.getString(1)))
		  {
        %>
			<option value=<%=rs.getString(1)%> selected><%=rs.getString(2)%></option>
		<%
		  }
		else
		  {
         %>
          <option value=<%=rs.getString(1)%>> <%=rs.getString(2)%></option>
		  <%
		  }
  
		  }
	rs.close();
	
	%>
	</select></td>
<%
	}
	subdivcode=request.getParameter("subdivision");
if(subdivcode==null)
subdivcode="";
	System.out.println("circlecode"+request.getParameter("circle"));
	System.out.println("divisioncode"+request.getParameter("division"));
	System.out.println("subdivisioncode"+request.getParameter("subdivision"));
	System.out.println("assettype"+request.getParameter("AssetType"));
	System.out.println("year"+request.getParameter("cmbYear"));
	System.out.println("month"+request.getParameter("cmbMonth"));
//	if(request.getParameter("circle").equals("00") && AssetType.equals(""))
//		 {
//		dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE";
//		 }
%>
	</tr>
	
		<tr>
		<td class=label>AssetType *</td>
	<td class=label>:</td>
	<td><select name=AssetType  onChange="assettypesubmit()" class="comboFont" style="width:127px">
	 <!-- <option value=0>Please Select...</option> --> 
<%
	if(request.getParameter("subdivision")!=null)
		 {
	if(circlecode.equals("00"))
		 {
	        //dtr2="select type_of_asset_code,type_of_asset_name from rws_asset_type_tbl";
//dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "'";
dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE order by pp.asset_type";
}
else
	if(!circlecode.equals("00") && divcode==0 && subdivcode.equals("0"))
		 {
	dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "' order by pp.asset_type";
		 }
else
	if(!circlecode.equals("00") && divcode!=0 && subdivcode.equals("0"))
	 {
	dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1) = '" + divcode + "' order by pp.asset_type";
	 }
else
	if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
	 {
	dtr2="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1) = '" + divcode + "' and substr(pp.office_code,5,2) = '" + subdivcode + "' order by pp.asset_type";
	 }
		
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
	%>
	</select></td>
	</tr>

	<tr>
	<td class=label>Year *</td>
	<td class=label>:</td>
	<td><select name=cmbYear  onChange="yearsubmit()" class="comboFont" style="width:127px">
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
	dtr3="select distinct year from rws_physical_progress_tbl pp where pp.asset_type='"+typeofassetcode[0]+"'";
	
		 }
 else
		 if(!circlecode.equals("00") && divcode==0 && subdivcode.equals("0"))
		 {
	 dtr3="select distinct year from rws_physical_progress_tbl where substr(office_code,2,2)='"+circlecode+"' and asset_type='"+typeofassetcode[0]+"'";
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 && subdivcode.equals("0"))
		 {
			 dtr3="select distinct year from rws_physical_progress_tbl where substr(office_code,2,2) = '" + circlecode + "' and substr(office_code,4,1) = '" + divcode + "' and asset_type='"+typeofassetcode[0]+"'";
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
		 {
	 System.out.println("typeofassetcode"+typeofassetcode[0]);
			 dtr3="select distinct year from rws_physical_progress_tbl where substr(office_code,2,2) = '" + circlecode + "' and substr(office_code,4,1) = '" + divcode + "' and substr(office_code,5,2) = '" + subdivcode + "' and asset_type='"+typeofassetcode[0]+"'";
			 System.out.println(dtr3);
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
			 dtr3="select distinct year from rws_physical_progress_tbl pp where pp.asset_type='"+typeofassetcode[0]+"'";
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
			 dtr3="select distinct year from rws_physical_progress_tbl pp where pp.asset_type='"+typeofassetcode[0]+"' and substr(pp.office_code,2,2)='"+circlecode+"'";
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
	%>


	</td>
	</tr>

	<tr>
	<td class=label>Month *</td>
	<td class=label>:</td>
	<td><select name=cmbMonth class="comboFont" style="width:127px">
	<!-- <option value=0></option> -->
<%
	//if(request.getParameter("cmbYear")!=null)
		 //{
if(circlecode.equals("00"))
		 {
	//dtr3="select distinct year from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type='"+AssetType+"'";
	System.out.println("typeofassetcode"+typeofassetcode[0]);
	dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	
		 }
 else
		 if(!circlecode.equals("00") && divcode==0 && subdivcode.equals("0"))
		 {
	 dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
	 
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 && subdivcode.equals("0"))
		 {
			 dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
			 
		 }
 else
		if(!circlecode.equals("00") && divcode!=0 && !subdivcode.equals("0"))
		 {
			 dtr3="select distinct month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where substr(pp.office_code,2,2)='"+circlecode+"' and substr(pp.office_code,4,1) = '" + divcode + "' and substr(pp.office_code,5,2) = '" + subdivcode + "' and pp.month=mm.month_code and pp.asset_type='"+typeofassetcode[0]+"' and pp.year = '" + year[0] + "'";
			 
		 }
		 
//nyear=request.getParameter("cmbYear");
pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	      
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
			  <table cellpadding="0" cellspacing="0" >
		<tr>	

			<td><img src="/pred/resources/images/bottom_left.gif"></td>
			<td background="/pred/resources/images/bottom_center.gif" width="300" class="heading" valign="middle"	align="center"></td>
			<td><img src="/pred/resources/images/bottom_right.gif" ></td>
		</tr>
		</table>
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
<tr><td align=center class=label>Fields Marked * are Mandatory</td></tr>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>
			   </form>
               </center>


			   </body>
			   </html>

			   