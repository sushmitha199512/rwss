<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<% try {
	ResultSet r1=null;	
	Statement stmt1 = null,s1=null,s2=null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement st3 = null;
	ResultSet rs3 = null,r2=null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
	 Statement st6=null;
	 ResultSet rs6=null;%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">

	function fnSubmit()
	{
		if(document.f1.district.selectedIndex=="")
		{
		alert("SELECT CIRCLE...");		
		return false;
		}
		 if(document.f1.acomp.selectedIndex=="")
		{
		alert("SELECT ASSET COMPONENT...");		
		return false;
		}
		 if(document.f1.assetType.selectedIndex=="")
		{
		alert("SELECT ASSET TYPE...");		
		return false;
		}
		
		 if(document.f1.sccomp.selectedIndex=="")
		{
		alert("SELECT ASSET SUB COMPONENT...");		
		return false;
		}
		else
		{
			document.f1.action="./arws_new_asset_subcomp_rpt.jsp";
			document.f1.submit();
		}


	document.f1.action="./arws_new_asset_subcomp_rpt.jsp";
	document.f1.submit();
	}
	function valSubmit()
	{ 
		alert(" Please SELECT Circle \n Please SELECT Asset Type \n Please SELECT Asset Component \n Please SELECT Asset Sub Component");
				
	}
//-->
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Asset Sub Component Details</font>
			</td>	
		</tr>
<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null,RepName=null,Const=null;
	String panchName=null;
	String repName=null;
	String aType=null;
	String aComp=null,scComp=null, compName=null, scName=null;
	
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>
			<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
					rDist = request.getParameter("district");
					// //System.out.println("Rdist   "   +rDist);	
					stmt = conn.createStatement();
					//rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.asset_code=ac.asset_code order by c.circle_office_name");
	
		rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,  RWS_ASSET_MAST_TBL  am  where c.CIRCLE_OFFICE_CODE = am.CIRCLE_office_code order by circle_OFFICE_NAME");
					while(rs.next())
					{
						if(rDist != null && rDist.equals(rs.getString(1)) )
						{
				%>
							<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
							<% 			
							 distName=rs.getString(2);
							//session.setAttribute("dName",distName);		
						}// END OF IF
						else 
						{%>	
							<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
						<%		//session.setAttribute("dName",null);		
						} 
					}// END OF While

						%>
			</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
			</td>
			<td class = btext>
				  <SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<%
					rMand = request.getParameter("mandal");
					// //System.out.println("mandal name   "   +rMand);
					if(rDist != null && !rDist.equals("0"))
					{
						stmt1 = conn.createStatement();
						//String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_ASSET_SUBCOMP_PARAM_TBL ac, RWS_ASSET_MAST_TBL  a,  RWS_division_OFFICE_TBL d where a.asset_code= ac.asset_code and d.circle_office_code=a.circle_office_code and d.division_office_code= a.division_office_code and a.circle_office_code="+rDist+" order by d.division_OFFICE_NAME";
						String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d,  RWS_ASSET_MAST_TBL  am  where d.CIRCLE_OFFICE_CODE=am.CIRCLE_office_code and am.division_office_code=d.division_office_code and d.CIRCLE_OFFICE_CODE="+rDist+" order by division_OFFICE_NAME";

						rs1 =stmt1.executeQuery(st);
						while(rs1.next())
						{
							if(rMand != null && rMand.equals(rs1.getString(1)))
							{
					%>
								<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
								<%
									mandalName=rs1.getString(2);
									//out.println("DDDDDDDDDDDDDDDDDDDD"+mandalName);
									session.setAttribute("mName",mandalName);
							}// END OF IF
							else
							{
								%>
									<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
								<%	
							}
						}// END OF while 
					}// END OF 1 if
								%>
			</td>
		</tr>
		<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font>
			</td>
			<td class = btext>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
					rPanch = request.getParameter("panchayat");
					if(rMand != null && !rMand.equals("0"))
					{
						stmt2 = conn.createStatement();
					String St2="SELECT distinct  d.subdivision_office_code,d.subdivision_OFFICE_NAME FROM  RWS_ASSET_MAST_TBL  a,  RWS_subdivision_OFFICE_TBL d where d.circle_office_code=a.circle_office_code and d.division_office_code= a.division_office_code and d.subdivision_office_code=a.subdivision_office_code and a.circle_office_code='"+rDist+"' and a.division_office_code='"+rMand+"' order by d.subdivision_OFFICE_NAME";
						rs2 =stmt2.executeQuery(St2);
						while(rs2.next())
						{
							if(rPanch != null && rPanch.equals(rs2.getString(1))) 
							{

					%>
						<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>
					<%
						panchName=rs2.getString(2);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
					<%	
							}
					}// END OF WHILE
				}// END OF IF
					%>
			</td>
			</tr>
			<tr>
			<td class = btext> 
				<font color=navy nowrap><b>Asset Type</b> </font>
				<font color="red"><b>*</b></font>
			</td>
			<td  class = btext nowrap >
				<SELECT name="assetType" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
				<%
					aType = request.getParameter("assetType");
					stmt2 = conn.createStatement();
					String St2="select TYPE_OF_ASSET_CODE ,TYPE_OF_ASSET_name from RWS_ASSET_TYPE_TBL order by TYPE_OF_ASSET_CODE ";
						rs2 =stmt2.executeQuery(St2);
						
						while(rs2.next())
						{
							if(aType != null && !aType.equals("0") && aType.equals(rs2.getString(1))) 
							{

					%>
						<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>
					<%
						//aType=rs2.getString(2);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
					<%	
							}
					}// END OF WHILE
				
					%>
		
	
</SELECT></td>

</tr>
<% if(aType != null && !aType.equals("0"))
		{
	%>
<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Asset Component</b></font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext>
				<SELECT name="acomp" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
					st3 = conn.createStatement();
					String Stt2="select ASSET_COMPONENT_CODE,ASSET_COMPONENT_NAME  from RWS_ASSET_COMPONENT_TYPE_TBL WHERE TYPE_OF_ASSET_CODE='"+ aType +"' order by  ASSET_COMPONENT_CODE";
					rs3 =st3.executeQuery(Stt2);
					
					aComp = request.getParameter("acomp");
									
						while(rs3.next())
						{
							if(aComp != null && aComp.equals(rs3.getString(1))) 
							{

					%>
						<option value="<%= rs3.getString(1)%>" SELECTed><%= rs3.getString(2) %>
					<%
						compName=rs3.getString(2);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs3.getString(1)%>"><%= rs3.getString(2) %>
					<%	
							}
					}// END OF WHILE
				
					%>
			</SELECT></td>
			</td>
			</tr>
		<%}%>
		
	<%	if(aComp != null && !aComp.equals("0"))
		{
		try {
	%>
<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Asset Sub Component</b></font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext>
				<SELECT name="sccomp" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
					st4 = conn.createStatement();
					String Stt3="select ASSET_subCOMPONENT_CODE, ASSET_subCOMPONENT_NAME from RWS_ASSET_SUBCOMPONENT_TBL WHERE TYPE_OF_ASSET_CODE='"+ aType +"' and ASSET_COMPONENT_CODE='"+ aComp +"' order by ASSET_subCOMPONENT_CODE";
					//System.out.println(" query is  "+Stt3);
					rs4 =st4.executeQuery(Stt3);
					
					scComp = request.getParameter("sccomp");
					//System.out.println("hjee;;");
									
						while(rs4.next())
						{
							if(scComp != null && scComp.equals(rs4.getString(1))) 
							{

					%>
						<option value="<%= rs4.getString(1)%>" SELECTed><%= rs4.getString(2) %>
					<%
						scName=rs4.getString(2);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs4.getString(1)%>"><%= rs4.getString(2) %>
					<%	
							}
					}// END OF WHILE
		}catch(Exception e)
			{
			//System.out.println("error is  "+e);
			}
					%>
			</SELECT>
			</td>
			</tr>
		<%}%>
	</table>
</TD>
<%  // START HP  ----  SOURCE ------- BORE WELL -------
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("04")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") )
	{				%>

		<%@ include file = "rws_asset_subcomp_hp_sour_bw_frm.jsp" %>
<%} 
		// END HP  ----  SOURCE ------- BORE WELL -------
		// START PWS --- SOURCE --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<%@ include file = "rws_asset_subcomp_pws_sour_bw_frm.jsp" %>
<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %>

<%}
//END  PWS --- SOURCE --- COMPONENTS 
// START PWS --- HEAD WORKS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("004") )
	{
	%>
 <%@ include file = "rws_asset_subcomp_pws_headwork_standpost_frm.jsp" %>

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("005") )
	{
	%>
 <%@ include file = "rws_asset_subcomp_pws_headwork_capacitor_frm.jsp" %> 

<%}
// END PWS --- HEAD WORKS --- COMPONENTS 

// START PWS --- PIPE LINE --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
	 <%@ include file = "rws_asset_subcomp_pws_pipeline_distribution_frm.jsp" %> 

<%}
// END PWS --- PIPE LINE --- COMPONENTS 
// START PWS --- RESERVIORS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
	 <%@ include file = "rws_asset_subcomp_ pws_reservoirs_ohsr _frm.jsp" %> 

<%}

else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
	<%@ include file = "rws_asset_subcomp_pws_reservoirs_cisterns_frm.jsp" %> 

<%}

// END PWS --- RESERVIORS --- COMPONENTS 
// START PWS --- PUMP SETS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("01")  && aComp!=null && aComp.equals("05") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
// END  PWS --- PUMP SETS --- COMPONENTS 
// start  MPWS --- souce --- COMPONENTS 
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
//END MPWS --- SOURCE --- SUBCOMPORNETS

//START  MPWS --- PIPE LINE --- SUBCOMPORNETS

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
//END MPWS --- PIPELINE --- SUBCOMPORNETS

//START MPWS --- RESERVIORS --- SUBCOMPORNETS
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("02")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
//END MPWS --- RESERVIORS --- SUBCOMPORNETS


// START CPWS ---SOURCE--- COMPONENTS 
else
if(rDist!=null && aType!=null && !aType.equals("00") &&  aType.equals("03") && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("001") )
	{
	%>
	<!-- <%@ include file = "rws_asset_subcomp_cpws_sour_bw_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("00") &&  aType.equals("03") && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("002") )
	{
	%>
	<!-- <%@ include file = "rws_asset_subcomp_cpws_sour_bw_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("00") &&  aType.equals("03") && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("003") )
	{
	%>
	<!-- <%@ include file = "rws_asset_subcomp_cpws_sour_bw_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("00") &&  aType.equals("03") && aComp!=null && aComp.equals("01") && scComp!=null && !scComp.equals("004") )
	{
	%>
	<!-- <%@ include file = "rws_asset_subcomp_pws_sour_bw_frm.jsp" %> -->

<%}
	// END pws ---SOURCE--- COMPONENTS 

	// START pws --- HEAD WORKS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("004") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("005") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("006") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("007") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("008") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("02") && scComp!=null && !scComp.equals("0") && scComp.equals("009") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
// END pws --- HEAD WORKS --- COMPONENTS 

//START  pws --- PIPE LINE --- SUBCOMPORNETS

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("03") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
//END pws --- PIPELINE --- SUBCOMPORNETS

// START pws --- RESERVIORS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("002") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("003") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}

else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("004") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("04") && scComp!=null && !scComp.equals("0") && scComp.equals("005") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
// END PWS --- RESERVIORS --- COMPONENTS 

// START pws --- PUMP SETS --- COMPONENTS 
else  
if(rDist!=null && aType!=null && !aType.equals("0") &&  aType.equals("03")  && aComp!=null && aComp.equals("05") && scComp!=null && !scComp.equals("0") && scComp.equals("001") )
	{
	%>
<!-- <%@ include file = "rws_asset_subcomp_pws_sour_glsr_frm.jsp" %> -->

<%}
// END  pws --- PUMP SETS --- COMPONENTS 

%>
</TD>
<%
	String fYear = request.getParameter("finyear");
	// //System.out.println("Finantial year   "   +fYear);
	// //System.out.println(distName);
	 //System.out.println(compName);
	 //System.out.println(scName);
session.setAttribute("dName",distName);
session.setAttribute("mName",mandalName);
session.setAttribute("pName",panchName);
session.setAttribute("compName", compName);
session.setAttribute("scName", scName);
%>		
	<INPUT TYPE="hidden" name="dName" value="<%=distName%>">
	<INPUT TYPE="hidden" name="mName" value="<%=mandalName%>">
	<INPUT TYPE="hidden" name="pName" value="<%=panchName%>">
	<INPUT TYPE="hidden" name="rptName" value="<%=RepName%>">
	<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">


<TR>
<TD colspan=2 align=center valign=top>
	<%  if(rDist!=null){%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
 <%} 
	else{ %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button onclick="valSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
<% } %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ 
		//e.printStackTrace();
		}
	finally
	{
		conn.close();
	}%>