<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
%>
<html>
<head>

<script language="JavaScript">
<% 
String sessionToken = (String)session.getAttribute("csrfToken");
String fieldtoken = request.getParameter("token");
System.out.println("storedToken>>>> "+sessionToken+"token>>>>"+fieldtoken);
if (sessionToken == null || fieldtoken == null || !sessionToken.equals(fieldtoken)) {
System.out.println("ivalid user");
//return mapping.findForward("InvalidUser");
}else {System.out.println("valid user");}

String csrfToken="";
nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
csrfToken = valUtil.getCSRFCode();
String token =(String)session.getAttribute("csrfToken");
System.out.println("session tokenJsp=== "+token);
String token1 =request.getParameter("token");
System.out.println("parameter token=== "+token);
session.setAttribute("csrfToken",csrfToken);

%>
function show()
	{
	document.getElementById('search').style.display='none';
	document.getElementById('selecthab').style.display='block';
    }
	function show1()
	{
		document.getElementById('search').style.display='block';
		document.getElementById('selecthab').style.display='none';
	}
	function check()
	{
	 
	 if(document.forms[0].hab[0].checked)
	 {
	   document.getElementById('search').style.display='none';
	 }
	 if(document.forms[0].hab[1].checked)
	 {
	  document.getElementById('selecthab').style.display='none';
	 }
	
	}
	
	function fnSubmit()
	{
		
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000" || user=="guest")
		{
			if (document.forms[0].hab[0].checked)
			{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			if(document.f1.work.value=='')
			{
				alert("Please Select Work");
				return false;
			}
			else
			{

				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;	
				document.f1.wname.value = document.f1.work.options[document.f1.work.selectedIndex].text;	
				document.f1.mode.value = '1';
				document.f1.action="./rws_bill_history_rpt.jsp";
				document.f1.submit();
			}
		}else if(document.forms[0].hab[1].checked) 
		  {
            var work=document.f1.workid.value;
			
			 if(work.length == 0)
			{ 
				 alert("Please Enter 14 Digit Work ID");
			}
			else if(work.length != 14)
			{    
				alert("Work Id must be 14 digits");
				return false;
  			}
			 else{

				 document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				 document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				 document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				 document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;	
				 document.f1.wname.value = document.f1.work.options[document.f1.work.selectedIndex].text;	
				 document.f1.mode.value = '2';
			     document.f1.action="./rws_bill_history_rpt.jsp";
			     document.f1.submit();
			 }
		 }
			
		}
		else
		{
			if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			if(document.f1.program.value=='')
			{
				alert("Please Select Work Category");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			if(document.f1.work.value=='')
			{
				alert("Please Select Work");
				return false;
			}else{
				//alert("sssssssss");
			//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
			document.f1.yname.value = document.f1.year.options[document.f1.year.selectedIndex].text;
			document.f1.wname.value = document.f1.work.options[document.f1.work.selectedIndex].text;	
			//alert(document.f1.wname.value);
			document.f1.mode.value = '1';
			document.f1.action="./rws_bill_history_rpt.jsp";
			document.f1.submit();
			}
		}
	}
	

</script>

</head>
<body bgcolor="#edf2f8" onload="check()">
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=650>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Bill's History Report</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	String wrkcat = request.getParameter("program");
	String fyear = request.getParameter("year");
%>
<tr><td class=rptLabel colspan="2" align="center">
<input type="radio" value="1" name="hab" checked onclick="show()">Detailed Report&nbsp;&nbsp;
<input type="radio" value="2" name="hab" onclick="show1()">Work Id Based Report&nbsp;&nbsp;
<div id="selecthab" style="display:block">
<table border=1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("EE-Budget")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		
		<%

		  stmt = conn.createStatement();
		
			//query="SELECT distinct d.dcode,d.dname from rws_district_tbl d ,rws_work_bill_tbl w where d.dcode<>16  and substr(work_id,5,2)=d.dcode order by d.dname";
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_bill_tbl b,rws_work_admn_tbl w  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode and b.work_id=w.work_id   and substr(w.office_code,2,2)=d.dcode order by d.dname";
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

	<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				<option value="">-Select-</option>
<%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			//query="select  division_office_code,division_office_name from rws_division_office_tbl where circle_office_code='"+dcode+"'";
			query="select  distinct division_office_code,division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w,rws_work_bill_tbl b  where  w.work_id=b.work_id and a.circle_office_code=substr(office_code,2,2) and a.division_office_code =substr(office_code,4,1)    and circle_office_code='"+dcode+"'";
			// System.out.println("qqq:"+query);

			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(divcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
</td></tr>
		

		<tr><td class=rptLabel nowrap>Work Category&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
		<option value="">-Select-</option>
<% if(divcode!=null && !divcode.equals("")){
			Statement stmt1 = conn.createStatement();
			query="select distinct a.category_code,a.category_name from rws_work_category_tbl a,rws_work_admn_tbl b,rws_work_bill_tbl c where c.work_id=b.work_id and  a.category_code =b.category_code and substr(office_code,2,2)='"+dcode+"'   and substr(office_code,4,1)='"+divcode+"'  order by category_code";
			// System.out.println("qqq cat:"+query);
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				if(wrkcat.equals(rs1.getString(1))){
	%>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%}else{%>
				<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		}%>
</td></tr>
<tr><td class=rptLabel nowrap>Admin Sanction Year&nbsp;&nbsp;<font color="red">*</font></td>&nbsp;&nbsp;&nbsp;&nbsp;
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
				<option value="">-Select-</option>
<%if(wrkcat!=null && !wrkcat.equals("")){
	Statement	 stmt1 = conn.createStatement();
	
	query="select distinct to_char(admin_date,'dd/mm/yyyy')  from rws_work_admn_tbl a,rws_work_bill_tbl b  where a.work_id=b.work_id and  admin_date is not null  and substr(office_code,2,2)='"+dcode+"'  and substr(office_code,4,1)='"+divcode+"'  and  category_code='"+wrkcat+"' order by 1 desc";
	// System.out.println("qqq date:"+query);
	ResultSet rs1 = stmt1.executeQuery(query);
		ArrayList aa = new ArrayList();	
		String finalSancYear="";
	while(rs1.next())
		{
			//// System.out.println("rs1:"+rs1.getString(1));
			//// System.out.println("before :"+rs1.getString(1));
			String dates = rs1.getString(1);
			
			int da = Integer.parseInt(dates.substring(3,5));
			int ye = Integer.parseInt(dates.substring(6,10));
			if(da<=03)finalSancYear = ye-1+"-"+ye;
			else finalSancYear = ye+"-"+(ye+1);
			//System.out.println("final year:"+finalSancYear);
			//HashSet h = new HashSet();
			aa.add(finalSancYear);
		}
			HashSet h = new HashSet(aa);
        	ArrayList bb =new ArrayList(h);
			Collections.sort(bb,Collections.reverseOrder()); 
            for(int i = 0;i<bb.size();i++)
			{
		finalSancYear = (String)bb.get(i);
	  if(fyear!=null &&  !fyear.equals("") && finalSancYear.equals(fyear))
		{
	 %>
		 <option value="<%=finalSancYear%>" selected><%=finalSancYear%></option> 
	 <%}else {%>
	  <option value="<%=finalSancYear%>" ><%=finalSancYear%></option> 
	 
	 <%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
		}%>
</td></tr>
<tr><td class=rptLabel>Work &nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="work" id="combo" class="mycombo" style="width:450px">
				<option value="">-Select-</option>
<%
		if(fyear!=null && !fyear.equals("")){
		Statement	 stmt4 = conn.createStatement();
			query="select distinct a.work_id,a.work_name from rws_work_admn_tbl a ,rws_work_bill_tbl b where  a.work_id=b.work_id and substr(office_code,2,2)='"+dcode+"'  and substr(office_code,4,1)='"+divcode+"'  and  category_code='"+wrkcat+"'  and admin_date <='31/MAR/"+fyear.substring(5)+"' and  admin_date >='01/APR/"+fyear.substring(0,4)+"'";
			
			// System.out.println("qqq4:"+query);
			ResultSet  rs4 = stmt4.executeQuery(query);
			while(rs4.next())
			{
				
	%>
		 <option value="<%=rs4.getString(1)%>-<%=rs4.getString(2)%>"><%=rs4.getString(1)%>-<%=rs4.getString(2)%>
		 </option> 
	<%
			}
						if(rs4!=null)rs4.close();
						if(stmt4!=null)stmt4.close();
		}%>
</td></tr>
</table>
</div>
<div id="search" style="display:block">
<table >
<tr>
 <td class="rptLabel" colspan=2 align="left">Enter&nbsp;Your&nbsp;Work Id:&nbsp;<font color="red">*</font><input type="text" name="workid" maxlength="14" onkeypress="return numeralsOnly(event)" /><br></td>
 </tr>
</table>
</div>
</td>
</tr>

<%	
}catch(Exception e){
// System.out.println("Exception in bill Report frm jsp:"+e);

}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
<INPUT type="hidden" name="yname">
<INPUT type="hidden" name="wname">
<INPUT type="hidden" name="mode">
</form>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>