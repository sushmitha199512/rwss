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
   if(!loggedUser.equals(nic.watersoft.commons.Constants.ADMIN) && !loggedUser.equals(nic.watersoft.commons.Constants.LAKH_USER)){
 //110102
   ccode=loggedUser.substring(1,3);
    divcode=loggedUser.substring(3,4);
} 
System.out.println("loggedUser"+loggedUser);
System.out.println("CCode"+ccode);
System.out.println("divCode"+divcode);
 
%>
<html>
<head>  

<script language="JavaScript">

function getSubPrograms(){

alert("HI");
}
function unview()
{
    var a=document.getElementById('combo').value;

	if(a=="-1")
	{
       document.getElementById('vbutton').disabled=true;
	}

}
	function fnSubmit()
	{
 var finyear=document.getElementById('combo1').value;
  var year1=finyear.substring(0,4);
  var year2=finyear.substring(5,9);
     var cyear=new Date().getFullYear() ;

		var logValue = '<%=loggedUser%>';
		if(logValue=="admin" || logValue=="100000")
		{
			if(document.f1.district.value=='00')
			{
			    document.f1.drill.value='null';
			}
document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
		}


			 if(document.f1.combo1.value=='0')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else if(document.f1.program.value=='')
			{
				alert("Please Select Programmes");
				return false;
			}else if(document.f1.subProg.value==''){
			alert("Please Select Sub Programme");
				return false;
  				}
			
		
			else
		{
				document.f1.drill.value='null';
			


			document.f1.pname.value = document.f1.combo2.options[document.f1.combo2.options.selectedIndex].text;
if(cyear!=year1){
     
			document.f1.action="./rws_performance_sc_st_rpt1.jsp";
                 document.f1.submit();
            }else {
            document.f1.action="./rws_performance_sc_st_rpt.jsp";
document.f1.submit();
			}
		}
	}


 function addrow()
    {

  var table = document.getElementById("a"); 
var rowCount = table.rows.length;
 
var row = table.insertRow(rowCount); 
var cell1 = row.insertCell(0); 
var element1 = document.createElement("input"); 
element1.type = "text"; 
cell1.appendChild(element1); 

var cell2 = row.insertCell(1); 
var element2 = document.createElement("input"); 
element2.type = "text"; 
cell2.appendChild(element2); 

var cell3 = row.insertCell(2); 
var element3 = document.createElement("input"); 
element3.type = "text"; 
cell3.appendChild(element3); 

var cell4 = row.insertCell(3); 
var selector = document.createElement('select');
selector.id = 'CTYPE';
selector.name = 'DTYPE';
cell4.appendChild(selector);

var option = document.createElement('option');
option.value = 'C';
option.appendChild(document.createTextNode('CREDIT'));
selector.appendChild(option);

option = document.createElement('option');
option.value = 'D';
option.appendChild(document.createTextNode('DEBIT'));
selector.appendChild(option);



	  
	  
    }

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table id="a" >

</table>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width="20%">
		<caption>
              
			<table  border=0 rules=none style="border-collapse:collapse" width="200" align="right" bgcolor="#edf2f8">
				

			<% 
if(loggedUser!=null && !loggedUser.equals(nic.watersoft.commons.Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>PLAIN,SC,ST Works Abstract Report</td>
	</tr>

<%

		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");
		Statement stmt2=null,stmt3=null;

try
{

if(ccode!=null && !ccode.equals("")&& !loggedUser.equals("guest") && !loggedUser.equals("secrwss")){


%>


	<%
			stmt = conn.createStatement();
            if(divcode==null || divcode.equals("0") && !loggedUser.equals("guest")){

query="SELECT  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+ccode+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{%>
			
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=dcode12 value='<%=rs.getString(2) %>'></td>

			<%}
}else{
			query="SELECT  d.dcode,d.dname,a.division_office_name,a.division_office_code from rws_district_tbl d ,rws_division_office_tbl a where a.circle_office_code=d.dcode and a.circle_office_code='"+ccode+"' and a.division_office_code='"+divcode+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{%>
			
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=dcode12 value='<%=rs.getString(2) %>'></td>

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

<td class=rptLabel>
		<SELECT name="district" id="combo" class="mycombo" style="width:120px">
				<option value="00"> ALL District</option>

<% 

}
%>

<%@ include file="/reports/financialYear.jsp" %>
	<!-- 	<tr><td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" class="mycombo" style="width:150px">
				<option value="">-select-</option>
				<option value="03">CPWS</option>
				<option value="01">PWS</option>dfs
				<option value="02">MPWS</option>

		</SELECT>
		</td></tr> -->
		<tr><td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Programme<font color="red">*</font><br>
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

		</SELECT>
		<%-- <SELECT name="program" id="combo2" style="width:140px" multiple  size="10" class="hightlongcombo">
				<option value="">-select-</option>
<%
String[] programes=request.getParameterValues("program");
	
    String programe="";
if(programes!=null){
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
}
   if(programe!=null && programe.contains("01,02,18,23,32,48,49,51,58,72")){
 %>


				<option value="01,02,18,23,32,48,49,51,58,72" selected >NRDWP Related</option>
<%
}else {

%>
				<option value="01,02,18,23,32,48,49,51,58,72"  >NRDWP Related</option>
<% 

}

		
		
%>
		</SELECT> --%>
		</td>

<td class=rptLabel>&nbsp;&nbsp;&nbsp;Sub Program&nbsp;&nbsp;<br>
		&nbsp;&nbsp;&nbsp;<SELECT name="subProg" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

				<option value="0">-select-</option>
			<option value="PLAIN">PLAIN</option>
			<option value="SC">SC</option>
			<option value="ST">ST</option>
				
<%
	
%>
		</SELECT>
		</td>

<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Scheme<font color="red">*</font><br>
		&nbsp;&nbsp;&nbsp;<SELECT name="scheme" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

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

