<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		try{
	
	Statement stmt2 = null;
	
	ResultSet rs2 = null;

    Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">

function fnSubmit()
{       
	if(document.f1.district.selectedIndex=="")
	{
	     alert("please SELECT District");
		 return false;
	}
	if(document.f1.assettype.selectedIndex=="")
	{
	     alert("please SELECT Asset Type");
		 return false;
	}
	
	
		//document.f1.action="./rws_borewell_status_graph_rpt.jsp";
        document.f1.action="./arws_schemes_rpt.jsp?district="+document.f1.district.value;
		document.f1.submit();
}
	
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				
                <font color="#FFFFFF">Schemes - Without Sources,Reservoirs Report</font>
			</td>	
		</tr>


<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Typeofasset = null;
	String RANGE = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String dCode=null;
	String mCode=null;
	String pCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;	
	
%>
<TR> 
	<TD   valign=top  align="center" height="35%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>

<tr>
		<% 
	rDist = request.getParameter("district");
	////System.out.println("Rdist   "   +rDist);
	if(rDist==null || rDist.equals("0"))
	{
	%>
		<td class = btext ><font color=navy><b>District</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
	
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	 
	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dname");
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
	<% 			
			request.setAttribute("dName",rs.getString(2));
			session.setAttribute("dCode",rDist);


		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
		//session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	
	<tr>

	<td class = btext nowrap><font color="navy" ><b>Asset Type</b></font>
	<font color="red">*</font></td>
	<td class = btext colspan=3>
	<SELECT name="assettype" style="width:150px" class="mycombo">
		<option value="0">SELECT...</option>
		
<%
	Typeofasset = request.getParameter("assettype");
	
	
	if(Typeofasset!= null && !Typeofasset.equals("0"))
		{
		if(Typeofasset.equals("01"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Typeofasset %>" SELECTed>Pws</option>
					<option value="02">Mpws</option>		
					<option value="03">Cpws</option>
					<option value="09">Direct Pumping</option>
					
					

			<%} else if(Typeofasset.equals("02"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Typeofasset %>" SELECTed>Mpws </option>
					<option value="01">Pws </option>
					<option value="03">Cpws</option>
					<option value="09">Direct pumping</option>
					
					

			<%} else if(Typeofasset.equals("03"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Typeofasset %>" SELECTed>Cpws </option>
					<option value="01">Pws </option>
					<option value="02">Mpws</option>		
					
					<option value="09">Direct pumping</option>
					
					


			<%} else if(Typeofasset.equals("09"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Typeofasset %>" SELECTed>Direct pumping </option>
					<option value="01">Pws </option>
					<option value="02">Mpws</option>		
					<option value="03">Cpws</option>
					
					
					
		
			<%} 	
			
			
			
		}
		else
		{%>
			<option value="01">Pws </option>
			<option value="02">Mpws</option>		
			<option value="03">Cpws</option>
			<option value="09">Direct pumping</option>
			
			

		<%}%>
	
</SELECT></td>

</tr>
	

	
		
	
</table>

</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	//if(rDist!=null && !rDist.equals("0") && rDist.equals("51"))

	//	{
	//	
	%>

			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%
			//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	finally
	{
		conn.close();
	}

		%>
</TD></TR>
</TABLE>
</form>
</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

</html>
