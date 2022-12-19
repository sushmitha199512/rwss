<%@ include file="header_rpt.jsp" %> 
<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>



<html>	
<head>
 <%@ page import="java.util.Date" %>
<%! Date date= new Date(); %>
   <%! int day=date.getDate(); %>  	
   <%! long month=date.getMonth(); %>  
   <%! long year = date.getYear(); %> 
   <script language="JavaScript" src="./resources/calendar.js"></script>

  
	
<script>
	
function ppdelete()
{
	//alert("PPPPPPPP");
	alert("Record Successfully Deleted");

	document.financialFormt.cmdDel.value="2";
	document.financialFormt.action="InsertFinancialProgresst.do";
	document.financialFormt.submit();
}
function winClose()
{
	location.href="/Pred/Menu.jsp";
}
function main()
{
	window.location="Menu.jsp";
}
function movenext()
{
	document.financialFormt.cmdNext.value="Next";
	document.financialFormt.action="FinancialProgresst.do";
	document.financialFormt.submit();
}
function fsubmit()
{
	if (document.financialFormt.preparedBy.value=="")
	{
		alert("Prepared By should not be Blank");
	}
	else
		if (document.financialFormt.preparedDt.value=="")
		{
		alert("Prepared Date should not be Blank");
		}
		else
	{
	alert("Record Successfully Inserted");
	
	document.financialFormt.cmdinssub.value="disIns";
	document.financialFormt.action="InsertFinancialProgresst.do";
	document.financialFormt.submit();
	}
}
function usubmit()
{
	alert("Record Successfully Updated");
	document.financialFormt.action="InsertFinancialProgresst.do";
	document.financialFormt.submit();
}
function moveprevious()
{
	document.financialFormt.cmdPrevious.value="Previous";
	document.financialFormt.action="FinancialProgresst.do";
	document.financialFormt.submit();
}
function disable()
{
	document.financialFormt.button4.disabled = true;
}
function chkAll(n,prop)
{  
 
 for(var i=0;i<n;i++)
 {
 document.getElementById('appListt['+i+'].'+prop).checked=1;
 }
}
function clrAll(n,prop)
{
 
for(var i=0;i<n;i++)
 {
  document.getElementById('appListt['+i+'].'+prop).checked=0;
 }
}
</script>





	<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		

	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
		<body>
		


<%
int count=0;
%>
	
<!--  <center>  -->

	<table cellpadding="0" cellspacing="0" align="center">
		<tr height="95%">
			<td>
	<table cellpadding="0" cellspacing="0" width="750" align="center">
		<tr>
			<td>
	
	
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>Works Monitoring Form</center></B><font></td>
	    <td align=right><IMG SRC="resources/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="resources/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20"  bordercolor=white><IMG SRC="resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>
 <logic:present name="memo">
		<fieldset>
		  <!-- <legend >
					<B>Applications</B>
		</legend>  --> 
	<table width="100%" height="200" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
	
					 <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>S.NO</td>
				     <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>Office Issued From</td>
				     <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>Office Issued To</td>
				     <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>Work ID</td>
				     <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>Date of Completion</td>
				     <td class="clrborder" align="center"><font color="#000000" face=verdana size=2><b>Date of Grounding</td>
				     
  				
	</tr>
	<logic:iterate id="appListt" name="memo" scope="session">
				
				  <% count++; %>
				  <tr>	
					<td class="bwborder" align="center"> <%=count%>.<html:checkbox name="appListt"  property="sno" indexed="true"/> </td>
					<td class="bwborder" align="center">
				 	
					<html:text name="appListt" 
									 property="offissuedfrom" 
									 styleClass="mytbltext" 
									  readonly="true" indexed="true"/></td>
									 
					<td align="right" class="bwborder">
						<html:text title="unit"
						             name="appListt" 
									 property="offissuedto" 
									 style="width:90px" 
									 
									 styleClass="mytbltext"  indexed="true" />
				   </td>
					<td align="right" class="bwborder">
								 <html:text name="appListt" 
					               property="workid" indexed="true"/>
					</td>
					<td align="right" class="bwborder">
						<html:text title="unit"
						             name="appListt" 
									 property="dateofcomp" 
									 style="width:90px" 
									
									 styleClass="mytbltext"  indexed="true"/>
					</td>
					
					<td align="right" class="bwborder">
								 <html:text name="appListt" 
					               property="groundDate" indexed="true"/>
					</td>
					</tr>
			  </logic:iterate>
				<input type="hidden" name="index" value="<%= count %>">	
				<tr>
	        <td width="60"><a href="javascript:chkAll('<%=count%>','sno');">Check All</a>&nbsp;</td>
	        <td align="left" width="60"><a href="javascript:clrAll('<%=count%>','sno');">Clear All</a> </td>
	       <!--  <td align="right" width="660"><a href="javascript:chkAll('<%=count%>','appCorrect');">Check All</a>&nbsp;</td>
	        <td align="right"><a href="javascript:clrAll('<%=count%>','appCorrect');">Clear All</a> </td> -->
	        </tr>
	</table>
	</fieldset>
	
	</logic:present>
	
<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	 
	  <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
<br>
<center>
<html:submit property="save"   
						 styleClass="btext" value="Save" onclick="save()" />
</center>
<!-- </center> -->
</html:form>
	<p align="center">

<%@ include file="footer.jsp" %>


              </p>