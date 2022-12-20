<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%
String catCode = request.getParameter("catCode");
String dcode = request.getParameter("district");
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
String query="";
%>
<script>
function fnview()
{
	var user = '<%=loggedUser%>';
	if(user=="admin" || user=="100000"){
	if(document.forms[0].district.value=="")
	{
		 alert("Please Select District");
	}
	if(document.forms[0].catCode.value=="")
	{
		 alert("Please Select Work Category");
	}else{
			document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
	document.forms[0].action="./rws_Aap_rpt.jsp";
	document.forms[0].submit();
	}
	} else{
	    document.forms[0].action="./rws_Aap_rpt.jsp";
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
<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">AAP-2011 Works</font></td>	</tr>
	<tr colspan=2>
	<td align="center"><font color=navy face="verdana" size="2"><b>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="all">All</option>
		
		<%

		    stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_aap_selected_tbl b  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode  order by d.dname";
			rs = stmt.executeQuery(query);
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
			
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
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

	<tr colspan=2>
	<td align="center"><font color=navy face="verdana" size="2"><b>Work Category</b> </font>	
	<font color=red><b>*</b> </font></td>
	 <td class=btext>
	 <select name="catCode" style="width:150px" class="mycombo">
	  <option value="">-Select-</option>
<%
		Statement stmt1 = conn.createStatement();
		String	query1="select distinct a.category_code,a.category_name from rws_work_category_tbl a,rws_work_admn_tbl b,rws_aap_selected_tbl c where c.work_id=b.work_id and  a.category_code =b.category_code ";
		 if(dcode!=null && !dcode.equals("") && !dcode.equals("all"))
		 {
			 query1+=" and substr(office_code,2,2)='"+dcode+"'  ";
		 }
	      query1+=" order by category_code ";
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
</td></tr>
		<tr align="center">
		<td colspan=2 align=center>
		<input type=button value="View Report" class = btext onclick="fnview()">
		</td>
		</tr>
		</table>
		<INPUT type="hidden" name="dname">

</form>
