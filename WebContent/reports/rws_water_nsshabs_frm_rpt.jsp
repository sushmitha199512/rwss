<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();



 %>

<html>
<head>
<script language="JavaScript">
 function fnSubmit()
 {
  //alert(" in submit");
   var dcode=document.forms[0].district.value;
  
   
   if(document.forms[0].radio1.checked)
	   {
	  // alert("radio1"+document.forms[0].radio1.checked);
	 var check=document.forms[0].radio1.value; 
	// alert("radio1"+check);
	   
	   } 
   else if(document.forms[0].radio2.checked)
	   {
	   var check=document.forms[0].radio2.value; 
	//  alert("radio2"+check);
	   }
  
   else if(document.forms[0].radio3.checked)
   {
   var check=document.forms[0].radio3.value; 
  // alert("radio3"+check);
   }
   
   
  /*  else if(document.forms[0].radio4.checked)
   {
   var check=document.forms[0].radio4.value; 
   alert("radio4"+check);
   } */

   
   else if(document.forms[0].radio5.checked)
   {
   var check=document.forms[0].radio5.value; 
 //  alert("radio5"+check);
   }

   else if(document.forms[0].radio6.checked)
   {
   var check=document.forms[0].radio6.value; 
 //  alert("radio6"+check);
   }


  
	/* var check=""; */
	var cstatus="";
	//alert("normal:"+document.forms[0].normal[0].checked); 
	if(document.forms[0].normal[0].checked)		
	 {	
		//alert("111"+document.forms[0].cstatus.value);
		 if(document.forms[0].cstatus.value!=null  )
		 {
			 
			// alert("1"+document.forms[0].cstatus.value);
			if(dcode==0)
				{
				 // alert("Please Select District");
				}
			 else{
				// alert("anu");
					 cstatus=document.forms[0].cstatus.value
					 
					 
					document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
					// alert("document.forms[0].action"+document.forms[0].action);
					document.forms[0].submit();
					
					
					/* +"&check="+check */
				} 
		 }
		 /* 
		  else
	      {	 
			 alert("if nss0");
				 if(document.forms[0].nss[0].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
						alert("flouride");
						   check="flouride";
						     document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
							 document.forms[0].submit();
						  }
				 }
				 else if(document.forms[0].nss[1].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="tds";
						  document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
						document.forms[0].submit();
					}
				 }
                else if(document.forms[0].nss[2].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="salinity";
						  document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
						document.forms[0].submit();
					}
				 }
                else if(document.forms[0].nss[3].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="salinitytds";
						  document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
						document.forms[0].submit();
					}
				 }
                else if(document.forms[0].nss[4].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="iron";
						  document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
						document.forms[0].submit();
					}
				 }
                 else if(document.forms[0].nss[5].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="nitrate";
						  document.forms[0].action="./rws_water_nss_habs_rpt.jsp?dcode="+dcode+"&check="+check;
						  
						  System.out.ptintln("nitrate"+ document.forms[0].action);
						document.forms[0].submit();
					}
				 }
       	 }//else end  */
	 }//if normal end
	  else if (document.forms[0].normal[1].checked)
	  {
		  if(document.forms[0].cstatus.value!=null)
			 {
				if(dcode==0)
					{
					  alert("Please Select District");
					}
					else{
						 cstatus=document.forms[0].cstatus.value
						document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						document.forms[0].submit();
					}
			 } 
		 else
	      {	 
				 if(document.forms[0].nss[0].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
						   check="flouride";
						     document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
							 document.forms[0].submit();
						  }
				 }else if(document.forms[0].nss[1].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="tds";
						  document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						  document.forms[0].submit();
					}
				 }
else if(document.forms[0].nss[2].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="salinity";
						  document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						  document.forms[0].submit();
					}
				 }
else if(document.forms[0].nss[3].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="salinitytds";
						  document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						  document.forms[0].submit();
					}
				 }
else if(document.forms[0].nss[4].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="iron";
						  document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						  document.forms[0].submit();
					}
				 }
else if(document.forms[0].nss[5].checked)
				 {
					  if(dcode==0)
					 {
						  alert("Please Select District");
					 }
					else{
					     check="nitrate";
						  document.forms[0].action="./rws_water_nss_habs_xls.jsp?dcode="+dcode+"&cstatus="+cstatus +"&check="+check;
						  document.forms[0].submit();
					}
				 }
       	 }

	  }
			
 }


</script>
</head>
<%
 String rDistrict = null,query=null;
 rDistrict = request.getParameter("district");
%>
<body bgcolor="#edf2f8">
<form method=post >
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right">		
				
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="left">
		<td align="center" class=gridhdbg colspan=3><font face=verdana>Water Quality Habitation Status</font></td>	
	</tr>
	

<tr><td class=rptLabel align="left">
<!-- <input type="radio" value="1" name="nss" checked > --><font face=verdana>Coverage Status
<SELECT name="cstatus"  class="mycombo" style="width:150px" >
	   <option value="NSS">NSS</option>
	   <option value="FC">FC</option>
	   <option value="PC1">PC1</option>
	   <option value="PC2">PC2</option>
	   <option value="PC3">PC3</option>
	   <option value="PC4">PC4</option>
	   </SELECT>
 </font> </td></tr>
 
 <%
 String flouridePPM="",tdsPPM="",salinityPPM="",ironPPM="",nitratePPM="";
 try{
		
		Statement stmt1 = conn.createStatement();
		String query1 = "select TESTING_PARAMETER_CODE,TRIM(MAX_PERMISSIBLE_VALUE) from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE in ('13','05','12','16','15')";
		ResultSet rs1 = stmt1.executeQuery(query1);
		while(rs1.next())
		{
			if(rs1.getString("TESTING_PARAMETER_CODE").equals("13")){
				flouridePPM=rs1.getString(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("05")){
				tdsPPM=rs1.getString(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("12")){
				salinityPPM=rs1.getString(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("16")){
				ironPPM=rs1.getString(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("15")){
				nitratePPM=rs1.getString(2);
			}
		}			
		rs1.close();			
		stmt1.close();
}catch(Exception e){
e.printStackTrace();
}
 
 %>

<tr><td class=rptLabel align="left">
<input id="radio1" type="radio" value="flouride" name="nss"><font face=verdana>Flouride > <%=flouridePPM%>(Mg/Lit) Habitations</font></td></tr>

<tr><td class=rptLabel align="left">
<input id="radio2" type="radio" value="tds" name="nss"><font face=verdana>TDS > <%=tdsPPM%>(MG / LT MAX) Habitations</font></td></tr>

<tr><td class=rptLabel align="left">
<input  id="radio3" type="radio" value="salinity" name="nss"><font face=verdana>Salinity > <%=salinityPPM%>(PPT) Habitations</font></td></tr>

<!-- <tr><td class=rptLabel align="left">
<input id="radio4" type="radio" value="salinitytds" name="nss"><font face=verdana>Salinity-TDS Habitations</font></td></tr>
 -->
<tr><td class=rptLabel align="left">
<input id="radio5" type="radio" value="iron" name="nss"><font face=verdana>Iron Habitations</font></td></tr>

<tr><td class=rptLabel align="left">
<input id="radio6" type="radio" value="nitrate" name="nss"><font face=verdana>Nitrate Habitations</font></td></tr>


</table>


<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
<tr>
  <td class=gridhdbg>District<font color="red">*</font></td>
	  <td class=btext>
	  <SELECT name="district"  class="mycombo" style="width:150px" >
	   <option value="00">SELECT..</option>
	  <%
  try{
				stmt = conn.createStatement();
				query = "select dcode,dname from rws_district_tbl where dcode<>16  order by dname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDistrict != null && rDistrict.equals(rs.getString(1)))
					{					%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
						session.setAttribute("districtName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
						}
				}			
					rs.close();			
					stmt.close();

}catch(Exception e){
		e.printStackTrace();
}
%>
			</select>
		</td>
	</tr>
	<tr>
  <td class=gridhdbg>Financial Year<font color="red">*</font></td>
	  <td class=btext>
	  <SELECT name="financialYear"  class="mycombo" style="width:150px" >
	   		<option value="00" selected="selected">SELECT..</option>
			<!-- <option value="01-Apr-14/31-Mar-15/2014-2015">2014-2015</option>
			<option value="01-Apr-13/31-Mar-14/2013-2014">2013-2014</option>
			<option value="01-Apr-12/31-Mar-13/2012-2013">2012-2013</option>
			<option value="01-Apr-11/31-Mar-12/2011-2012">2011-2012</option>
			<option value="01-Apr-10/31-Mar-11/2010-2011" >2010-2011</option> -->
			<%			
			try{
				stmt = conn.createStatement();
				query = "select distinct to_char(PREPARED_ON,'yyyy') from rws_wq_test_results_tbl order by to_char(PREPARED_ON,'yyyy') desc";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					int year1=Integer.parseInt(rs.getString(1));					
					   int year2=year1+1;
					   int y1=Integer.parseInt(rs.getString(1).substring(2,4));
					   int y2=y1+1;
			%>
			<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>" ><%= year1 %>-<%= year2 %>
			<%
			
				}
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					if(conn!=null){
						conn.close();
						stmt.close();
						rs.close();
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
			%>
			</select>
		</td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td class=btext align="left">
<input type="radio" value="1" name="normal" checked ><font face=verdana>Normal</font> </td>

<td class=btext align="left">
<input type="radio" value="1" name="normal"><font face=verdana>Excel</font> </td>
</tr>

<tr class=gridhdbg bgcolor="#8A9FCD" align="center">
	<td colspan=3 align=center>
	<input type=button  onclick="fnSubmit()" class=btext value="View Report">
	</td>
</tr>

</table>
</body>
</html>