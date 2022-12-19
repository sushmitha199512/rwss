<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	


StringBuffer query = new StringBuffer();

StringBuffer query2 = new StringBuffer();


StringBuffer query3 = new StringBuffer();


	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());

   StringBuffer ccode=new StringBuffer();
   StringBuffer divcode=new StringBuffer(); 
   if(!loggedUser.toString().equals(Constants.ADMIN) && !loggedUser.toString().equals(Constants.LAKH_USER)){
   ccode.append(loggedUser.substring(1,3));
    divcode.append(loggedUser.substring(3,4));
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
		var logValue = '<%=loggedUser.toString()%>';
   var finyear=document.forms[0].elements["finyear"].value;
  var year1=finyear.substring(0,4);
  var year2=finyear.substring(5,9);
     var cyear=new Date().getFullYear() ;

		if(logValue=="admin" || logValue=="100000")
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
			         
			document.f1.action="./rws_rwss_action_plan_rfd_rpt.jsp";
          
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
				

			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Rwss Action Plan</td>
	</tr>

<%

StringBuffer District=new StringBuffer();


StringBuffer rConstituency=new StringBuffer();
rConstituency.append(request.getParameter("constituency"));

StringBuffer rMandal=new StringBuffer();



StringBuffer rPanchayat=new StringBuffer();


StringBuffer rVillage=new StringBuffer();


StringBuffer rHabitation=new StringBuffer();


StringBuffer dcode=new StringBuffer();
dcode.append(request.getParameter("district"));
session.setAttribute("dcode",dcode);
		//String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
//String dcode=request.getParameter("district");
//session.setAttribute("dcode",dcode);
		//rConstituency = request.getParameter("constituency");
		Statement stmt2=null,stmt3=null;

try
{

if(ccode!=null && !ccode.toString().equals("")&& !loggedUser.toString().equals("guest") && !loggedUser.toString().equals("secrwss")){


%>


	<%
			stmt = conn.createStatement();
            if(divcode.toString()==null || divcode.toString().equals("0") && !loggedUser.toString().equals("guest")){

            	query.delete(0,query.length());	
query.append("SELECT  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+ccode+"'");

    //System.out.println("Data:"+query);
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{%>
			
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext><input type="text" name=dcode12 value='<%=rs.getString(2) %>'></td>
<input type="hidden" name="district" value='<%=rs.getString(1) %>'  />
			<%}
}else{
	
	query.delete(0,query.length());
			query.append("SELECT  d.dcode,d.dname,a.division_office_name,a.division_office_code from rws_district_tbl d ,rws_division_office_tbl a where a.circle_office_code=d.dcode and a.circle_office_code='"+ccode+"' and a.division_office_code='"+divcode+"'");
			rs = stmt.executeQuery(query.toString());
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
			<option value="51">ALL</option>	


<%

stmt = conn.createStatement();
query.delete(0,query.length());
query.append("SELECT  dcode,dname from rws_district_tbl ");

//System.out.println("Data:"+query);
rs = stmt.executeQuery(query.toString());
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
		String 	query5="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
		ResultSet rs2 = stmt2.executeQuery(query5);
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
query3.delete(0,query3.length());
		query3.append("select * from  rws_asset_type_tbl  order by 1");
		ResultSet rs3 = stmt3.executeQuery(query3.toString());
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
	//System.out.println("THE ERROR IN DISTRICT... " +e);
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

