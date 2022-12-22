<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>
<%try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String d=loggedUser.substring(1,3);
	String dcode= request.getParameter("district");
	String ass= request.getParameter("asset");
	//System.out.println("user:::"+d);
	//System.out.println("asset:::"+ass);
	 %>
<html>
<head>
<title>WaterSoft</title>
<script language="JavaScript">
	function fnSubmit()
	{
		 var logValue = '<%=loggedUser%>';
		var a=0;
		 if(logValue=="admin" || logValue=="100000")
			{
		if(document.f1.district.value== "" || document.f1.district.value == null)
		{
		alert("Please select District");
		}
			}
						
		if(document.f1.mandal.value == '' || document.f1.mandal.value == null)
		{
         alert("Please select Mandal");
		}
				
		else
		{
				if(logValue=="admin" || logValue=="100000")
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				//document.f1.aname.value = document.f1.asset.options[document.f1.asset.selectedIndex].text;
				//alert("1:"+document.f1.asset[0].checked);
				if(document.f1.asset[0].checked)
				document.f1.action="./rws_habgis_rpt.jsp"
				else if(document.f1.asset[1].checked)
		        document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[2].checked)
				document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[3].checked)
				document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[4].checked)
				document.f1.action="./rws_hpgis_rpt.jsp"
				else if(document.f1.asset[5].checked)
				document.f1.action="./rws_hpopsh_rpt.jsp"
				else if(document.f1.asset[6].checked)
				document.f1.action="./rws_hpopsh_rpt.jsp"
				else if(document.f1.asset[7].checked)
				document.f1.action="./rws_schoolgis_rpt.jsp"
			document.f1.submit();
			}

				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				//document.f1.aname.value = document.f1.asset.options[document.f1.asset.selectedIndex].text;
		if(document.f1.asset[0].checked)
				document.f1.action="./rws_habgis_rpt.jsp"
				else if(document.f1.asset[1].checked)
		        document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[2].checked)
				document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[3].checked)
				document.f1.action="./rws_asurfaceohsr_rpt.jsp"
				else if(document.f1.asset[4].checked)
				document.f1.action="./rws_hpgis_rpt.jsp"
				else if(document.f1.asset[5].checked)
				document.f1.action="./rws_hpopsh_rpt.jsp"
				else if(document.f1.asset[6].checked)
				document.f1.action="./rws_hpopsh_rpt.jsp"
				else if(document.f1.asset[7].checked)
				document.f1.action="./rws_schoolgis_rpt.jsp"
			document.f1.submit();
		}
		
	}


	function fnSubmit1()
	{
		//alert(document.f1.district1.value);
		 var logValue = '<%=loggedUser%>';
		 if(logValue=="admin" || logValue=="100000")
			{
		if(document.f1.district1.value== "" || document.f1.district1.value == null)
		{
		alert("Please select District");
		}
			}
				

	
		if(logValue=="admin" || logValue=="100000")
			{
			document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
			//	if(document.f1.asset1[0].checked)
				//document.f1.action="./rws_mandalGis_rpt.jsp"
				if(document.f1.asset1.checked)
				document.f1.action="./rws_cpwsGis_rpt.jsp"
				document.f1.submit();
			}
			else{
		//if(document.f1.asset1[0].checked)
				//document.f1.action="./rws_mandalGis_rpt.jsp"
				if(document.f1.asset1.checked)
				document.f1.action="./rws_cpwsGis_rpt.jsp"
				document.f1.submit();
			}
			
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
<form name=f1 >
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
				<font color="#FFFFFF">GIS- Information Reports</font>
			</td>	
		</tr>
				
	<% String rMandal="";
	String assetcode = null;
	String query="";
//	rDist = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	String rAsset = request.getParameter("assetName");
	 %> 
	  
<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()" >
             <option value="">-Select-</option> 
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				   if(rs.getString(1).equals(dcode))
				{
				%>
				   <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
			  <%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

	
			<tr>
			<td class = btext> 
			<font color=navy><b>Mandal</b> </font><font color=red><b>*</b> </font></td>
			<td class=btext>
			<SELECT name="mandal" id="mand1" class="mycombo" style="width:150px" >
			<option value="">SELECT...</option>
<%	
				stmt1 = conn.createStatement();
				//System.out.println("value:::"+request.getParameter("district"));
				//System.out.println("loggedUser:::"+loggedUser);
				String query1="";
				if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")) )
	{
					query1 = "SELECT distinct m.mcode, m.mname from rws_mandal_tbl m  where m.dcode='"+request.getParameter("district")+"' order by m.mname";
               
	}else
	{  query1 = "SELECT distinct m.mcode, m.mname from rws_mandal_tbl m  where m.dcode='"+d+"' order by m.mname";
		
	}
	//System.out.println("qqqqqqqqqqq::"+query1);
				rs1 = stmt1.executeQuery(query1);
				while(rs1.next())
				{%>
				<option value=<%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>

				<%}	%>
</SELECT></td></tr>

<tr><td  colspan="2">
<input type="radio" value="0" name="asset"  onclick="fnSubmit()"  >Basic Information <br>
<!-- <input type="radio" value="0" name="asset"  onclick="fnSubmit()"  >Panchayat Information<br> -->
<input type="radio" value="01" name="asset"  onclick="fnSubmit()" >PWS <br>
<input type="radio" value="02" name="asset"  onclick="fnSubmit()" >MPWS <br>
<input type="radio" value="09" name="asset"  onclick="fnSubmit()"  >Direct Pumping <br>
<input type="radio" value="04" name="asset"  onclick="fnSubmit()"  >HandPumps<br>
<input type="radio" value="05" name="asset"  onclick="fnSubmit()"  >Shallow HandPumps<br>
<input type="radio" value="06" name="asset"  onclick="fnSubmit()"  >OpenWells <br>
<input type="radio" value="11" name="asset"  onclick="fnSubmit()"  >Schools<br>

</td></tr>
<%String dcode1=request.getParameter("district1");
//System.out.println("dcodeddddddddddddd"+dcode1);
%>
<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()" >
             <option value="">-Select-</option> 
		<%
			stmt2 = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs2 = stmt2.executeQuery(query);
				while(rs2.next())
				{
				   if(rs2.getString(1).equals(dcode1))
				{
				%>
				   <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				    <option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option> 
			  <%
				}
				}
				rs2.close();			
				stmt2.close();
				}
		else
		{
			 //System.out.println("in selected dist:");
			stmt2 = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			// System.out.println("in selected dist:"+query);
			rs2 = stmt2.executeQuery(query);
			if(rs2.next())
			{
				dcode1=rs2.getString(1);
				// System.out.println("in selected dist:"+dcode1);
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs2.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs2.getString(1)%>">
	<%
			}
		}
	%></tr>
<tr><td colspan="2"> <!-- <input type="radio" value="0" name="asset1"  onclick="fnSubmit1()"  >Mandal Information<br> -->
<input type="radio" value="03" name="asset1"  onclick="fnSubmit1()" >CPWS<br></td></tr>
	</table>

<%}catch(Exception e)
{
 e.printStackTrace();
 }
  finally{
  //conn.close();
  } 
  %>	  
	</TD></TR></table>
	</TD></TR></table>
	<input type="hidden" name="dname">
	<input type="hidden" name="mname">
	<input type="hidden" name="dname1">


	</form>
	</body>
	</html>
	  
	