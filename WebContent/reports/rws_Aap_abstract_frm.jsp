<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%String catCode="";
if(request.getParameter("catCode")!=null )
{
catCode = request.getParameter("catCode");
}
%>
<script>
function fnview()
{
	if(document.forms[0].catCode.value=="")
	{
		alert("Please Select Work Categoty");
	}else{
	document.forms[0].catName.value = document.forms[0].catCode.options[document.forms[0].catCode.selectedIndex].text;
	document.forms[0].action="./rws_Aap_abstract_rpt.jsp";
	document.forms[0].submit();
	}
}
</script>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="35%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
<tr bgcolor="#8D9EAF" align="center">
<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">AAP Abstract Works</font></td>	</tr>
	
	<tr colspan=2>
	<td align="center"><font color=navy face="verdana" size="2"><b>Work Category</b> </font>	
	<font color=red><b>*</b> </font></td>
	 <td class=btext>
	 <select name="catCode" style="width:150px" class="mycombo" >
	  <option value="">-Select-</option>
	  <option value="0">All</option>
<%
 try {
		Statement stmt1 = conn.createStatement();
		String	query1="select distinct category_code,category_name from rws_work_category_tbl order by category_code ";
    		ResultSet rs1 = stmt1.executeQuery(query1);
			while(rs1.next())
			{
				if(catCode!=null &&  catCode.equals(rs1.getString(1))){
	%>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%}else{%>
				<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		%>
</td>


</tr>



<tr colspan=2>
	<td align="center"><font color=navy face="verdana" size="2"><b>Financial Year</b> </font>	
	<font color=red><b>*</b> </font></td>
	

 <td class=btext>
	 <select name="finyear" style="width:150px" class="mycombo" >
	  <option value="">-Select-</option>
	  
<%
		 stmt1 = conn.createStatement();
			query1="select distinct FIN_YEAR  from rws_aap_selected_tbl";
    		 rs1 = stmt1.executeQuery(query1);
			while(rs1.next())
			{
%>
				<option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option> 
	<%}
			
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		%>
</td>


</tr>
		<tr align="center">
		<td colspan=2 align=center>
		<input type=button value="View Report" class = btext onclick="fnview()">
		</td>
		</tr>
		</table> 
		<INPUT type="hidden" name="catName">

</form>
<%  }catch(Exception e){e.printStackTrace();}  %>