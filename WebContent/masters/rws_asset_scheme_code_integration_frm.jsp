<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	StringBuffer query=new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());	
%>
<html>
<head>
<script language="JavaScript">
	function fnSubmit(){
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value==''){
				alert("Please Select District");
				return false;
			}
			else if(document.f1.mandal.value==''){
				alert("Please Select Mandal");
				return false;
			}
			else if(document.f1.typeOfAsset.value==''){
				alert("Please Select Type Of Asset");
				return false;
			}			
			else{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" || loggedUser==("1000DR")){
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;			
				}
				else{
					document.f1.dname.value = document.f1.district.value;				
				}
				document.f1.action="./rws_asset_schemecode_generation.jsp";
				document.f1.submit();
			}	
		}
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a></td> 
					<td ><a href="javascript:onclick=history.go(-1)">Back </td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=3>Asset Scheme Code Integration</td>	
		</tr>
		<%
			try {
				StringBuffer dcode = new StringBuffer();
				dcode.append(request.getParameter("district"));				
		%>
		<tr>
			<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
				<%
					if(loggedUser.toString()!=null && (loggedUser.toString().equals("admin")||loggedUser.toString().equals("100000") ||loggedUser.toString().equals("guest") || loggedUser.toString().equals("1000DR"))) {
				%>
				<select name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
					<option value="">-Select-</option>
					<%
						query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
						ps = conn.prepareStatement(query.toString());
						rs = ps.executeQuery();
						while(rs.next()){
							if(rs.getString(1).equals(dcode.toString())) {
					%>
					<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
					<%	}	else { 	%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
					<% 		}
						  }
							rs.close();			
							ps.close();
						}else {
							query.append("SELECT dcode,dname from rws_district_tbl where dcode= ? ");
							ps = conn.prepareStatement(query.toString());
							ps.setString(1, loggedUser.substring(1,3));
							rs = ps.executeQuery();
							if(rs.next()){
								dcode.append(rs.getString(1));
					%>
				</select>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>" />
				<input type="hidden" name="district" value="<%=rs.getString(1)%>" />
				<%
						}
					}
				%>
			</td>
		</tr>
		<tr>
			<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
				<select name="mandal" id="combo" class="mycombo" style="width:150px"  >
					<option value="">-Select-</option>
					<%
						StringBuffer query1=new StringBuffer();
						query1.append("select  mcode,mname from rws_mandal_tbl where dcode= ? order by mname");		
		 				PreparedStatement stmt3 = conn.prepareStatement(query1.toString());
		 				stmt3.setString(1, dcode.toString());
						ResultSet rs3 = stmt3.executeQuery();
						while(rs3.next()) {
					%>
			 		<option value="<%=rs3.getString(1)%>" ><%=rs3.getString(2)%></option> 
					<% }	%>
				</select>
			</td>
     	</tr>
     	<tr>
     		<td class=rptLabel>Type Of Asset&nbsp;&nbsp;<font color="red">*</font></td>
     		<td class=btext>
				<select name="typeOfAsset" id="combo" class="mycombo" style="width:150px"  >
					<option value="">-Select-</option>
					<option value="01">PWS</option>
					<option value="02">MPWS</option>
					<option value="03">CPWS</option>
					<option value="09">DP</option>		
				</select>
			</td>		
   		</tr>	
		<%	} catch(Exception e){
				System.out.println("The Exception in rws_asset_scheme_code_integration_frm is  = "+e.getMessage());
        	}
		%>
		<tr bgcolor="#8A9FCD" align="center">
			<td colspan=3  align="center">
				<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Generate Scheme Codes" />
			</td>
		</tr>
	</table>
	<%@ include file = "/commons/rws_footer.jsp" %>
	<input type="hidden" name="dname">
</form>
</body>
</html>
<%
 if(request.getAttribute("message")!=null){	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
		var mess="<%=message%>";
		alert(mess)
	</script>
<%} %>
