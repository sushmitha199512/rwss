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
	document.f1.action="/pred/worksMonitoring/FinancialProgressReport.jsp";
	document.f1.submit();
}
function getSubPrograms()
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
			<td background="/pred/resources/images/top_center_b.gif" width="280" class="heading" valign="middle" align="center" class id ="mainheading">Financial Progress Report</td>
			<td><img src="/pred/resources/images/top_right_b.gif"></td>
		</tr>
	</table>
<table border=1 cellspacing=1 cellpadding=1 width="380" style="border-collapse:collapse" rules="none" bordercolor=navy >


<form name=f1 method="post" action="/pred/worksMonitoring/FinancialProgressMenu.jsp">
         
<%
     String ccode="";
	 int divcode=0;
	 String circlecode="";
	 String subdivcode="";
	 String dtr="";
	 String dtr1="";
	 String dtr2="";
	 String dtr3="";
	 String dtr4="";
	 String pCode="";
	 String sCode="";
	 GregorianCalendar cal = new GregorianCalendar();
	 int year = 0;
	 int myear = cal.get(Calendar.YEAR);

	 int i = 0;	 
	 String typeofassetcode="";
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
		str="select distinct substr(pp.office_code,2,2) as circleoffcode,circle_office_name  from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp,rws_circle_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(fp.office_code,2,2)=co.circle_office_code and pp.office_code=fp.office_code";
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
			String prog=request.getParameter("program");
			if(prog==null)
				prog="";
			String subprog=request.getParameter("subprogram");
			if(subprog==null)
				subprog="";
	     // dtr="select head_office_code,circle_office_code,division_office_code,division_office_name from rws_division_office_tbl where circle_office_code= '" + circlecode + "' ";
		  dtr="select distinct substr(pp.office_code,4,1) as divisionoffcode,division_office_name  from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp,rws_division_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(fp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code and substr(fp.office_code,4,1)=co.division_office_code and pp.office_code=fp.office_code AND substr(pp.office_code,2,2) = ?";
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
	<td><select name=subdivision class="comboFont" style="width:127px">
	<option value=0></option>
<%
	if (request.getParameter("circle") != null && request.getParameter("division") != null)
	{   
	   // dtr1="select head_office_code,circle_office_code,division_office_code,subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where circle_office_code= '" + circlecode + "' and division_office_code=" + divcode + " ";
		dtr1="select distinct substr(pp.office_code,5,2) as subdivisionoffcode,subdivision_office_name  from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp,rws_subdivision_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code and substr(fp.office_code,2,2)=co.circle_office_code and substr(pp.office_code,4,1)=co.division_office_code and substr(fp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,5,2)=co.subdivision_office_code and substr(fp.office_code,5,2)=co.subdivision_office_code and pp.office_code=fp.office_code and substr(pp.office_code,2,2) = '" + circlecode + "' and substr(pp.office_code,4,1)='"+divcode+"'";
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
%>
	</tr>
		

	<tr>
	<td class=label >Year *</td>
	<td class=label>:</td>
	<td><select name=cmbYear class="comboFont" style="width:127px">
	<!-- <option value=0>Please Select...</option> -->
<%
	for (i=0; i < 5; i++)
	{
		year = myear+i-4;
%>
		<!-- <option value=<%=year%>><%=year%></option> -->
<%
	}
 if(circlecode=="" ||  circlecode.equals("00"))
		 {
	dtr3="select distinct pp.year from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp where pp.office_code=fp.office_code";

		 }
		 if(!circlecode.equals("00"))
		 {
			 dtr3="select distinct pp.year from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp where pp.office_code=fp.office_code and substr(fp.office_code,2,2) = '" + circlecode + "'";
		 }
pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       typeofassetcode=rs.getString(1);
		 
       if(request.getParameter("cmbYear") != null && (request.getParameter("cmbYear")).equals( rs.getString(1)))
		  {
        %>
			<option value=<%=rs.getString(1)%>  selected><%=rs.getString(1)%></option>
		<%
		  }
		else
		  {
         %>
          <option value=<%=rs.getString(1)%>> <%=rs.getString(1)%></option>
		  <%
		  }
		  
         
         
		  }
	rs.close();
	%>


	</td>
	</tr>



	<tr>
	<td class=label>Month </td>
	<td class=label>:</td>
	<td><select name=cmbMonth class="comboFont" style="width:127px">
	<option value=0></option>
    
<%
	 if(!circlecode.equals("00"))
		 {
	//str="select month_code,month_name from rws_month_mast_tbl order by month_code";
	//str="select distinct pp.month,month_name from rws_financial_progress_tbl pp,rws_physical_progress_tbl fp,rws_month_mast_tbl mm where pp.month=mm.month_code and fp.month=mm.month_code and pp.office_code=fp.office_code and substr(fp.office_code,2,2) = '" + circlecode + "'";
	str="select month,month_name from rws_financial_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and substr(office_code,2,2) = '" + circlecode + "'";
		 }
//     if(circlecode=="" ||  circlecode.equals("00"))
//		 {
//		 str="select distinct month,month_name from rws_financial_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code";
//		 }
    pstmt=conn.prepareStatement(str);
	rs=pstmt.executeQuery();

	while (rs.next())
	{

		if(request.getParameter("cmbMonth") != null && (request.getParameter("cmbMonth")).equals( rs.getString(1)))
		  {
        %>
			<option value=<%=rs.getString(1)%>  selected><%=rs.getString(2)%></option>
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
	</td>
	</tr>
	
<tr>
		<td class=label>Program *</td>
	<td class=label>:</td>
	<td><select name=program class="comboFont" onChange="getSubPrograms()" style="width:127px">
	<!-- <option value=0>Please Select...</option> -->
	
	<%
	    if(request.getParameter("circle").equals("00"))
		dtr4="select distinct ff.programme_code,pp.programme_name from rws_financial_progress_tbl ff,rws_programme_tbl pp where ff.programme_code=pp.programme_code";
		else
		 dtr4="select distinct ff.programme_code,pp.programme_name from rws_financial_progress_tbl ff,rws_programme_tbl pp where ff.programme_code=pp.programme_code and substr(ff.office_code,2,2)='" + circlecode + "'";
	        
            pstmt=conn.prepareStatement(dtr4);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       pCode=rs.getString(1);
		   if(request.getParameter("program") != null && (request.getParameter("program")).equals( rs.getString(1)))
		  {
        %>
			<option value=<%=rs.getString(1)%>  selected><%=rs.getString(2)%></option>
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
	</tr>

	<tr>
	<td class=label >SubProgram </td>
	<td class=label>:</td>
	<td><select name=subprogram class="comboFont" style="width:127px">
	<!-- <option value=0>Please Select...</option> -->
	<%
		if(!circlecode.equals("00"))
		 dtr3="select distinct sub_programmer_code,subprogramme_name from rws_financial_progress_tbl ff,rws_subprogramme_tbl ss where ff.PROGRAMME_CODE = ss.PROGRAMME_CODE and ff.sub_programmer_code=ss.subprogramme_code and substr(office_code,2,2)='" + circlecode + "' and ff.programme_code='"+request.getParameter("program")+"' ";
		 else
			 dtr3="select distinct sub_programmer_code,subprogramme_name from rws_financial_progress_tbl ff,rws_subprogramme_tbl ss where ff.PROGRAMME_CODE = ss.PROGRAMME_CODE and ff.sub_programmer_code=ss.subprogramme_code and ff.programme_code='"+request.getParameter("program")+"' ";


            pstmt=conn.prepareStatement(dtr3);
			rs=pstmt.executeQuery();
	    while (rs.next())
		{
	       sCode=rs.getString(1);
		 
        %>
			<option value=<%=rs.getString(1)%> >
			<%=rs.getString(2)%></option>
		<%
		  
         
         
		  }
	rs.close();
	%>



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
<td colspan=3 align=center><input type=button value=submit name=button1 onclick="fnsubmit()"></td>
</tr>
<br>
<tr><td align=center class=label>Fields Marked * are Mandatory</td></tr>
			   </form>
               </center>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>

			   </body>
			   </html>

	
