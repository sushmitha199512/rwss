<%@page import="nic.watersoft.admin.Rws_Hab_Freeze_Unfreeze_DAO"%>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.util.*"%>

<script type="text/javascript">
function getData()
{
  if(document.forms[0].fyear.value=="")
	{
		alert("Please Select fin year");
		return;
	}
else {
	 	var finyear=document.forms[0].fyear.value;
    	document.forms[0].action="./HabFreezUnfreez_act.jsp?finyear="+finyear;
     	document.forms[0].submit();
	 }
}
</script>

<%
//Calendar cal=Calendar.getInstance();
//int year=cal.get(Calendar.YEAR);
//System.out.println("Current Year: "+year );
Rws_Hab_Freeze_Unfreeze_DAO dao=new Rws_Hab_Freeze_Unfreeze_DAO();
String cyear=dao.getHYear();
String year=cyear.substring(6,10);
//System.out.println("Current Year: "+year );
%>


<form action="HabFreezUnfreez_act.jsp">

	<% 

		/* String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken); */
	%>
	<%-- <html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" /> --%>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
           <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		   </table>	

		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
			
                <font color="#FFFFFF">Select Financial Year</font>
			</td>	
		</tr>

		<tr>
		<td>
		<table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
		<!-- <table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center> -->
		<tr align="center">
		<td class="textborder" width="200">Select Year <font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<select name="fyear" styleClass="mycombo" style="width:100px">
		<option value=" "><font class="myfontclr1">Select</option>
       	<option value='<%=year%>'><font class="myfontclr1"><%=year%></script></option>
		
		</select>
		</td>
	</tr>
		
		
		</table>
		</td>
			 		 
			 	
		
		</tr>
		
	<tr>
		<td class="textborder" align=center>
        <input type=button value=Submit onclick="getData()"></td>
	</tr>
	

</table>
</form>

<%@ include file="/commons/rws_footer.jsp"%>
<%
if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>


	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	</script>
<%
 }
 
				
%>



