<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//String query = null;
StringBuffer query =new StringBuffer();

	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	/*String loggedUser = user.getUserId();
   String ccode="";
   String divcode=""; 
   
   
   if(!loggedUser.equals(Constants.ADMIN) && !loggedUser.equals(Constants.LAKH_USER)){
 
   ccode=loggedUser.substring(1,3);
    divcode=loggedUser.substring(3,4);
} */


StringBuffer loggedUser1=new StringBuffer();
loggedUser1.append(user.getUserId());
String loggedUser = loggedUser1.toString();
//StringBuffer ccode=new StringBuffer();
String ccode=loggedUser.substring(1,3);
   StringBuffer divcode=new StringBuffer(); 
if(!loggedUser.toString().equals(Constants.ADMIN) && !loggedUser.toString().equals(Constants.LAKH_USER)){
//110102
  // ccode.append(loggedUser.substring(1,3));
    divcode.append(loggedUser.substring(3,4));
} 
//System.out.println("loggedUser"+loggedUser);
//System.out.println("CCode"+ccode);
//System.out.println("divCode"+divcode);
 
%>
<html>
<head>  

<script language="JavaScript">
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
	//alert("in fun");	
		var logValue = '<%=loggedUser%>';
		if(logValue=="admin" || logValue=="100000")
		{
			if(document.f1.district.value=='00')
			{
			    document.f1.drill.value='null';
			}
			document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
		}


			 if(document.getElementById('combo1').value=='0')
			{
				alert("Please Select Financial Year");
				return false;
			}
						
		
			else
		{
			document.f1.action="./rws_WQ_nottestedsources_rpt.jsp";
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
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>WQ Source Not Tested </td>
	</tr>

<%

		StringBuffer district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		Statement stmt2=null,stmt3=null;

try
{

%>

<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		//System.out.println(loggedUser);
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("1000WQ")))
		{
			//System.out.println(loggedUser);
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px">
			<option value="">-Select-</option>
		
		<%
		
		  stmt = conn.createStatement();
		 String query1="select  distinct dcode,dname from  rws_district_tbl d,rws_wq_test_results_tbl a where substr(source_code,1,2)=d.dcode  and d.dcode<>'16' order by 2";
		 System.out.println("query1"+query1);
		  rs = stmt.executeQuery(query1);
		 while(rs.next())
		 {
			
				if(rs.getString(1).equals(ccode))
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
		 %>
		 </SELECT>
		 <%
						rs.close();			
						stmt.close();
						
						
		}
		else
		{
			stmt = conn.createStatement();
		String 	query1="SELECT dcode,dname from rws_district_tbl  where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query1);
			if(rs.next())
			{
				ccode=rs.getString(1).toString();
				
				%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">  
					<input type="hidden" name="dname1" value="<%=rs.getString(2)%>"> 
	        <%
			 }
		 }
	%>
</tr>
	
		<%@ include file="rws_wq_financial_years.jsp" %>
 
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
//stmt2.close();
}catch(Exception e)
{
      e.printStackTrace();
}
 
loggedUser=null;
ccode=null;



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
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="distname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="dcode" value='<%=ccode %>'>
<INPUT type="hidden" name="divCode" value='<%=divcode %>'>
</form>
</body>
</html>

