<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
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

	function fnSubmit()
	{
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000" || user=="guest")
		{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
           
			
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				
				document.f1.action="./rws_refunds_rpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			
			document.f1.action="./rws_refunds_rpt.jsp";
			document.f1.submit();
		}
	}
	function getDateObject(dateString,dateSeperator)
	{
		var curValue=dateString;
		var sepChar=dateSeperator;
		var curPos=0;
		var cDate,cMonth,cYear;  
		curPos=dateString.indexOf(sepChar);
		cDate=dateString.substring(0,curPos);
		endPos=dateString.indexOf(sepChar,curPos+1);
		cMonth=dateString.substring(curPos+1,endPos);
	  	curPos=endPos;
		endPos=curPos+5;			
		cYear=curValue.substring(curPos+1,endPos);
		dtObject=new Date(cYear,cMonth-1,cDate);	
		return dtObject;
	} 
	
		 var drill=1;
		 if(document.forms[0].fromDate.value=="")
		 {
			 alert("please select From Date");
		 }
		else  if(document.forms[0].toDate.value=="")
		 {
			 alert("please select To Date");
		 }
		 else{
		 var fDate=getDateObject(document.forms[0].fromDate.value,"/");
		 var tDate=getDateObject(document.forms[0].toDate.value,"/");
		
		 
		 }
	 

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Refunds Report</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divname = request.getParameter("division");
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("EE-Budget")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
			
<%  
			if(dcode!=null && dcode.equals("all")){%>
			<option value="all" selected>All</option> 
		<%}else{%>
				<option value="all" >All</option> 
			<%}stmt = conn.createStatement();
			
			//query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_work_admn_tbl w  where d.dcode<>16  and substr(w.work_id,5,2)=d.dcode and (w.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p') or  w.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p'))     order by d.dname";
			//System.out.println("1:"+query);
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
	

		<%//System.out.println("-Select-**********"+dcode);
			if(dcode!=null && !dcode.equals("all"))
	    {%>
		<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
		<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			//query="select category_code,category_name from rws_work_category_tbl order by category_code";
			query="select  distinct a.division_office_code,a.division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w where substr(w.office_code,2,2)=a.circle_office_code and substr(w.office_code,4,1)=a.division_office_code  and (w.work_id in(select work_id from rws_div_work_bank_refund_tbl where refund_flag='p') or  w.work_id in (select work_id from rws_div_work_pao_refund_tbl where refund_flag='p'))    ";
			if(dcode!=null && !dcode.equals("all"))
			{
			 query+=" and substr(w.office_code,2,2)='"+dcode+"'  ";
			}
			 query+=" order by a.division_office_name";
			//System.out.println("qqq:"+query);
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				if(divname!=null && divname.equals(rs1.getString(1)))
				{ %>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%}else{%>
						<option value="<%=rs1.getString(1)%>" ><%=rs1.getString(2)%></option> 
				<%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
%>
</td></tr>
<%}

else if(dcode != null && dcode.equals("all")  )
	
			
			{%>
			<tr>
			<td class = btext><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="division" id="combo" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="">-Select-</option>
	<INPUT TYPE="hidden" name="division" value="0"> 
	</td>
	</tr>
						
			<%	
				//session.setAttribute("division",null);
	
	}
%>
		<tr >
		<td align="center" class=btext><font color="navy">From Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
		<a href="javascript: showCalendar(document.forms[0].fromDate);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
		<tr>
		<td  align="center" class=btext><font color="navy">To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendar(document.forms[0].toDate);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
		</tr>
<%
}catch(Exception e){e.printStackTrace();}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="divpname">

</form>
</body>
</html>