<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%
   StringBuffer query =new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
	
	WorksData1 wd = new WorksData1();
	int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	//String a="";
	StringBuffer a =new StringBuffer();
	
%>
<html>
<head>

<script language="JavaScript">
function fnSubmit()
{
	var user = '<%=loggedUser.toString()%>';
	if(user=="admin" || user=="100000")
	  {
		if(document.f1.district.value=='')
		{
			alert("Please Select District");
			return false;
		}
			else
		{
			document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			document.f1.action="./Rws_Ntr_Sujala_Patakam_Rpt.jsp";
			document.f1.submit();
		}	
	  }else{
		  
		  document.f1.action="./Rws_Ntr_Sujala_Patakam_Rpt.jsp";
			document.f1.submit();
	  }
	
}
	function fnSubmit1()
	{
		var user = '<%=loggedUser.toString()%>';
		if(user=="admin" || user=="100000")
		  {
			if(document.f1.myphase.value=='')
			{
				alert("Please Select Phase");
				return false;
			}
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.action="./Rws_Ntr_Sujala_Patakam_Abs_Rpt.jsp";
				document.f1.submit();
			}	
		  }else{
			  document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.action="./Rws_Ntr_Sujala_Patakam_Abs_Rpt.jsp";
				document.f1.submit();
		  }
		
	}
	


</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				

			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Sujala Patakam</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
		%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER)||loggedUser.toString().equals(Constants.SEC_USER) ||loggedUser.toString().equals("EE-Budget")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		
			query.append("SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_bill_tbl b,rws_work_admn_tbl w  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode and b.work_id=w.work_id   and substr(w.office_code,2,2)=d.dcode order by d.dname");
			rs = stmt.executeQuery(query.toString());
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
			
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
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
	
	<tr><td class=rptLabel>Phase Implemented&nbsp;&nbsp;<font color="red">*</font></td><td class=btext>
	<select name="myphase" id="combo" class="mycombo" style="width:150px"  >
	   	    	    <option value="1">I</option>
	   	    	    <option value="2">II</option>
	   	    	    <option value="3">III</option>
	   	    	    <option value="4">IV</option>
	   	    	    </select>
	
	</td>
	
	
	</tr>
	
	
	
	
	<%	
}catch(Exception e)
{
e.printStackTrace();

}
%>
	<tr bgcolor="#8A9FCD" align="center" class=rptHeading>
		<td colspan=3  align="center">
			<input type="button"  name="a"  value="Get Report" onclick="fnSubmit()"  class=btext/>				
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">

</form>
</body>
</html>