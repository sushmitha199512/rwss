<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	


String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
   String ccode="";
   String divcode=""; 
   if(!loggedUser.equals(Constants.ADMIN) && !loggedUser.equals(Constants.LAKH_USER)&& !loggedUser.equals("secrwss")&& !loggedUser.equals("minrwss")&& !loggedUser.equals("ENC")&& !loggedUser.equals("cerwss")&& !loggedUser.equals("pdswsm")&& !loggedUser.equals("pdccdu")&& !loggedUser.equals("ce_nab")&& !loggedUser.equals("ce_stp")&& !loggedUser.equals("ce_vqc")){
   ccode=loggedUser.substring(1,3);
    divcode=loggedUser.substring(3,4);
} 

 
%>
<html>
<head>  

<script language="JavaScript">
function unview()
{
    var a=document.forms[0].elements["combo"].value;

	if(a=="-1")
	{
       document.forms[0].elements["vbutton"].disabled=true;
	}

}
	function fnSubmit()
	{
	//alert("in fun");	
		var logValue = '<%=loggedUser%>';
   var finyear=document.forms[0].elements["finyear"].value;
  var year1=finyear.substring(0,4);
  var year2=finyear.substring(5,9);
     var cyear=new Date().getFullYear() ;

		if(logValue=="admin" || logValue=="100000"|| logValue=="ce_vqc"|| logValue=="ce_stp"|| logValue=="ce_nab"|| logValue=="pdccdu"|| logValue=="pdswsm"|| logValue=="cerwss"|| logValue=="ENC"|| logValue=="minrwss"|| logValue=="secrwss")
		{
			if(document.f1.district.value=='00')
			{
			    document.f1.drill.value='null';
			}
document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
		}


			 if(document.f1.finyear.value=='0')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else if(document.f1.program.value=='')
			{
				alert("Please Select Programmes");
				return false;
			}
			
		
			else
		{
				document.f1.drill.value='null';
			
			document.f1.pname.value = document.f1.combo2.options[document.f1.combo2.options.selectedIndex].text;
			         
			document.f1.action="./rws_ongoing_works_abs_rpt.jsp";
          
				document.f1.submit();
		}
		//}
		//else
		//{
		//	document.f1.drill.value='1';
			//document.f1.distname.value = document.f1.districts.value;
			//document.f1.action="./rws_work_gen.jsp";
//			document.f1.submit();
	//	}
	}


</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width="20%">
		<caption>
              
			<table  border=0 rules=none style="border-collapse:collapse" width="200" align="right" bgcolor="#edf2f8">
				

		<%--	<% 
 if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER)&& !loggedUser.equals("minrwss")&& !loggedUser.equals("ENC")&& !loggedUser.equals("cerwss")&& !loggedUser.equals("pdswsm")&& !loggedUser.equals("pdccdu")&& !loggedUser.equals("ce_nab")&& !loggedUser.equals("ce_stp")&& !loggedUser.equals("ce_vqc"))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%> --%>
	<!-- <tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr> -->
	<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%-- <%} %> --%>

			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Ongoing Works Details-Abstract</td>
	</tr>

<%

		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");
		Statement stmt2=null,stmt3=null;

try
{

if(ccode!=null && !ccode.equals("")&& !loggedUser.equals("guest") ){


			stmt = conn.createStatement();
            if(divcode==null || divcode.equals("0") && !loggedUser.equals("guest")){

query="SELECT  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+ccode+"'";

    System.out.println("Data:"+query);
			rs = stmt.executeQuery(query);
			if(rs.next())
			{%>
			
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=dcode12 value='<%=rs.getString(2) %>'></td>
<input type="hidden" name="district" value='<%=rs.getString(1) %>'  />
			<%}
}else{
			query="SELECT  d.dcode,d.dname,a.division_office_name,a.division_office_code from rws_district_tbl d ,rws_division_office_tbl a where a.circle_office_code=d.dcode and a.circle_office_code='"+ccode+"' and a.division_office_code='"+divcode+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{%>
			
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=dcode12 value='<%=rs.getString(2) %>'></td>

            <input type="hidden" name="district" value='<%=rs.getString(1) %>'  />
 
<td class=rptLabel>Diviion&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=divcode123 value='<%=rs.getString(3) %>'></td>



			<%}
}
			rs.close();
			stmt.close();
%>
		</SELECT>
		</td>

<% 

} else{

%>

<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:120px">
			<option value="00">ALL</option>	


<%

stmt = conn.createStatement();
query="SELECT  dcode,dname from rws_district_tbl ";

System.out.println("Data:"+query);
rs = stmt.executeQuery(query);
while(rs.next()){  %>

 <option value=<%=rs.getString(1) %>><%=rs.getString(2) %></option>
<%
	
	
	
}

}
%>

<%@ include file="/reports/AAP/financialYear.jsp" %>
	<!-- 	<tr><td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" class="mycombo" style="width:150px">
				<option value="">-select-</option>
				<option value="03">CPWS</option>
				<option value="01">PWS</option>
				<option value="02">MPWS</option>

		</SELECT>
		</td></tr> -->
		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo2" style="width:140px" multiple size="10" class="hightlongcombo">

				<option value="">-select-</option>
				<%
				String progCode="";
				String nrdwpQuery="select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
				Statement statement=conn.createStatement();
				ResultSet  resultSet=statement.executeQuery(nrdwpQuery);
				while(resultSet.next()){
					if(!progCode.equals("")){
						progCode=progCode+","+resultSet.getString(1);
					}
					else{
						progCode=resultSet.getString(1);
					}
				}
				resultSet.close();
				//System.out.println("progCode"+progCode);
				if(!progCode.equals("")){
				%>
				<option value=<%=progCode%>>NRDWP Related</option>	
					<%
					}
					%>
			
<%
		 stmt2 = conn.createStatement();
		String 	query2="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
		ResultSet rs2 = stmt2.executeQuery(query2);
		while(rs2.next())
		{%>
		<option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option> 
		<%}
		rs2.close();
		
%>
		</SELECT>
		</td>

<td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

				<option value="0">-select-</option>
				
<%
		stmt3 = conn.createStatement();
		String 	query3="select * from  rws_asset_type_tbl  order by 1";
		ResultSet rs3 = stmt3.executeQuery(query3);
		while(rs3.next())
		{%>
		<option value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option> 
		<%}
		rs3.close();
	
%>
		</SELECT>
		</td>
 
</tr>
		<%

}
catch(Exception e)
{
	System.out.println("THE ERROR IN DISTRICT... " +e);
	e.printStackTrace();
}
finally
{
try{
stmt2.close();
}catch(Exception e)
{
      e.printStackTrace();
}
      
}
%>




<!-- end of habitations -->


<%
	//if(district != null ){	////////System.out..println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "/reports/footer.jsp" %>
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="distname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="dcode" value='<%=ccode %>'>
<INPUT type="hidden" name="divCode" value='<%=divcode %>'>
</form>
</body>
</html>

