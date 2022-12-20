<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
        String loggedUser = user.getUserId();
		
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
		document.f1.rDistrictName.value = document.f1.rDistrict.options[document.f1.rDistrict.selectedIndex].text;
	   if(document.f1.normal[0].checked)
	    {
		 document.f1.action="./rws_works_sc_ongoing_rpt.jsp?&habType"
		document.f1.submit();
		}
		else  if(document.f1.normal[1].checked)
		{
		  document.f1.action="./rws_works_sc_ongoing_xls.jsp?&habType"
		  document.f1.submit();
		}
		else
		{
		 alert("Please Select Report Type");
		}
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Ongoing Habtype works Details</td>	
	</tr>
	
<%

		String rDistrict, habType= null;
		rDistrict = request.getParameter("rDistrict");
		//habType = request.getParameter("habType");
		

try
{
%>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
								
	%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
	<%
			}
						rs.close();			
						stmt.close();
		}
		else
		{
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
	%>
				
	<%
			}
		}
		%>
		<tr><td class=rptLabel>habtype&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="habType" id="combo" class="mycombo" style="width:150px">
		  <option value="SC">SC</option>
		  <option value="ST">ST</option>
		  <option value="PLAIN">PLAIN</option>
		</SELECT>
		</td>
		<tr>
		<td class=rptLabel colspan=2 align ="center"><input type="radio" value="normal"  name="normal" checked/>Normal
		<input type="radio" value="excel"  name="normal" />Excel</td>
		
<%}
catch(Exception e)
{
	//////System.out.println("THE ERROR IN DISTRICT... " +e);
	e.printStackTrace();
}
%>
			
		</td>
	</tr>




<!-- end of habitations -->


<%	
	//if(rDistrict != null ){	//////System.out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="rDistrictName">
</form>
</body>
</html>
<%@ include file="footer.jsp" %>

