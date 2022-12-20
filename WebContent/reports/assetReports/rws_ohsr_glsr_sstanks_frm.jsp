
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@page import="nic.watersoft.commons.*" %>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
        String loggedUser = user.getUserId();

          java.util.Date date =new  java.util.Date();
			  int year=date.getYear()+1900;
              String currentYear= String.valueOf(year); 
             int finYear_Start=2010;
                   
             String dcode="";
         	if(loggedUser.substring(0,3).equals("col")){
         		dcode=(String)session.getAttribute("district");    
         	   }       
		
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
       if(document.f1.rDistrict.value==""){
           alert("Please Select District");
           return false;
       }
       if(document.f1.sourceType.value==""){
           alert("Please Select Type of Source");
           return false;
       }
		
			document.f1.action="./rws_ohsr_glsr_sstanks_report.jsp";
			document.getElementById('vbutton').disabled=true;
			document.f1.submit();
		
		
	}
	

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">	

	
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td> </tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

				
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>OHSR, GLSR AND SS Tanks Sources Details</td>	
	</tr>
	
<%

		String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("rDistrict");
		rConstituency = request.getParameter("constituency");

try
{
%>
<tr>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER)||loggedUser.equals(Constants.GUEST)||loggedUser.equals(Constants.SEC_USER) ||loggedUser.substring(0,3).equals("col")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="">--Select--</option>  
			<option value="00">ALL</option>
			
<%
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d  where d.dcode <> '16' ";
			if(dcode!=null && !dcode.equals("")){
				query+=" and d.dcode='"+dcode+"'";
			}
			query+=" order by d.dname";
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
				<input type="text" name="rDistricts" value="<%=rs.getString(2)%>">
				<input type="hidden" name="rDistrict" value="<%=rs.getString(1)%>">
				<input type="hidden" name="rDistrictName" value="<%=rs.getString(2)%>">
	<%
			}
		}

%>

</td>
	</tr>
	<tr>
	<td class=rptLabel>Component Type&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
	<SELECT name="sourceType" id="combo" class="mycombo" style="width:150px">
			<option value="">--Select--</option>  
			<option value="OHSR">OHSR</option>
			<option value="GLSR">GLSR</option>
			<option value="OHBR">OHBR</option>
			<option value="GLBR">GLBR</option>
			<option value="SSTanks">SS Tanks</option>
			<option value="Cistern">Cisterns</option>
	</SELECT>
	</td>
	</tr>


<%

%>
		
	<%


		
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
			
		




<!-- end of habitations -->


<%	
	//if(rDistrict != null ){	////System.out.println("View Report Enabled...");
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
<br><br><br><br>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="rDistrictName">
</form>
</body>
</html>
