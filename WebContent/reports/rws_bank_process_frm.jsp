<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<html>
<script>
function fnSubmit()
{
	if(document.forms[0].datewise.value=="")
	{
		alert("Please Select Date");
	}else{
	document.forms[0].action="rws_bank_process_rpt.jsp";
	document.forms[0].submit();
	}
}

</script>
<%try{
 nic.watersoft.commons.RwsUser user1=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
 String loggedUser = user1.getUserId();
 String data=request.getParameter("datewise");
  String division=request.getParameter("division");
 String div="",cir="";
if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")||loggedUser.equals("EE-Budget"))){}else
 {
    cir=loggedUser.substring(1,3);
	div=loggedUser.substring(3,4);
 }
//System.out.println("cir-----"+cir);
 %>
<form method="post">
<table width="30%"><tr><td align="right"><a href="../home.jsp">Home</a></td></tr></table>
<table><tr><td class=btext>Bill Wise Releases - Central</td></tr></table>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=292>
 <tr><td class=rptLabel>Date of Payment:&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
	    <SELECT name="datewise" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()" >
		<option value="">-Select-</option>
		<%
		  stmt = conn.createStatement();
	     String  query="select  distinct to_char(PROCESSED_START_DATE,'dd/mm/yyyy'),to_char(PROCESSED_START_DATE,'dd/mm/yyyy') as p1  from rws_bill_bank_settlement_tbl   where PROCESSED_START_DATE is not null ";
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")||loggedUser.equals("EE-Budget"))){}else
		{
			query+=" and substr(office_code,2,2)='"+cir+"'";
			if(!div.equals("0")){
					query+=" and  substr(office_code,4,1)='"+div+"' ";
			}
		}
		 query += " order by substr(p1,9,10) desc,substr(p1,4,2) desc, substr(p1,1,2) desc ";
		// System.out.println(query);
		 rs = stmt.executeQuery(query);
		 while(rs.next())
		{
			
				if(rs.getString(1).equals(data))
				{
				%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%></option> 
			<%
				}
				else
				{
			%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
			<%
				}
			}
						rs.close();			
						stmt.close();
	 Statement  stmt1 = conn.createStatement();%>

	<tr><td class=rptLabel>Division:&nbsp;&nbsp;<font color="red"></font></td>
	<td class=btext>
	<%

	if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")||loggedUser.equals("EE-Budget")))
	 {
		%>
	  <SELECT name="division" id="combo" class="mycombo" style="width:150px" >
		<option value="">-Select-</option>
	 <%String da="",mn="",ya="";

	if(data!=null && !data.equals(""))
     {
	   da=data.substring(0,2);
	   mn=data.substring(3,5);
	    ya=data.substring(6,10);
	 }
	 String mn1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
	 
     String qry1="select  distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl  a,rws_bill_bank_settlement_tbl b where substr(office_code,2,2)=a.circle_office_code and substr(office_code,4,1)=a.division_office_code  and to_char(PROCESSED_START_DATE,'dd/MON/yyyy')= '"+da+"/"+mn1+"/"+ya+"' order by circle_office_code  "; 
	// System.out.println("qry1:"+qry1);
	 ResultSet rs1=stmt1.executeQuery(qry1);
	 while(rs1.next())
	   {
	    	if(rs1.getString(1).equals(division))
				{
				%>
					 <option value="<%=rs1.getString(3)+rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
					 	
			<%
				}
				else
				{
			%>
					 <option value="<%=rs1.getString(3)+rs1.getString(1)%>"><%=rs1.getString(2)%> </option>
				
			<%
				}%>
		
			<%}
			
	 }
	 else{%>
	  	
	  <SELECT name="division" id="combo" class="mycombo" style="width:150px" >
		<option value="">-Select-</option>
	 <%
		 
		 String qry1="select  distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl  where circle_office_code='"+loggedUser.substring(1,3)+"' "; 
		 if(!loggedUser.substring(3,4).equals("0")){
				query+=" and  division_office_code= '"+loggedUser.substring(3,4)+"'  ";
		}
		// System.out.println("qry12:"+qry1);
		 ResultSet rs1=stmt1.executeQuery(qry1);
		while(rs1.next())
		 {
		 
		 if(rs1.getString(1).equals(division))
				{
				%>
					 <option value="<%=rs1.getString(3)+rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
					 	
			<%
				}
				else
				{
			%>
					 <option value="<%=rs1.getString(3)+rs1.getString(1)%>"><%=rs1.getString(2)%> </option>
				
			<%
				}%>
				<%-- <input type="text" name="division1" readonly="true" class="mytext" style="width:150px" value="<%=rs1.getString(2)%>">
				<input type="hidden" name="division" value="<%=loggedUser.substring(1,3)+rs1.getString(1)%>"> --%>
	 <%}
	 
	 }
  }catch(Exception e)
   {
	System.out.println("Exception in Report:"+e);
   }
%>
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>
</form>
</html>