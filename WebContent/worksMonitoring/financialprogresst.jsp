<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>
<%@ include file="header_rpt.jsp" %>


<html>	
<head>
 <%@ page import="java.util.Date" %>
<%! Date date= new Date(); %>
   <%! int day=date.getDate(); %>  	
   <%! long month=date.getMonth(); %>  
   <%! long year = date.getYear(); %> 
   <script language="JavaScript" src="./resources/calendar.js"></script>

   <!-- <SCRIPT LANGUAGE="JavaScript">
	var cal = new calendar();
	</SCRIPT> -->
	
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
</script>





	<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		

	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
		<body>
		
<html:form action="InsertFinancialProgresst"  >

<center>
<!-- <span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span> -->


</center>
	
<center>

	<table cellpadding="0" cellspacing="0" align="center">
		<tr height="95%">
			<td>
	<table cellpadding="0" cellspacing="0" width="750" align="center">
		<tr>
			<td>
	
	<!-- <table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="resources/images/top_left_b.gif"></td>
			<td background="resources/images/top_center_b.gif" width="100%" class="heading" valign="middle" align="center" class id ="mainheading">Physical Progress Entry Form</td>
			<td><img src="resources/images/top_right_b.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_t_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><center>EOAT Entry Form</center></B><font></td>
	    <td align=right><IMG SRC="resources/images/icon_help.gif" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="resources/images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_t_right1.gif" ALT=""></TD>
</TABLE>

	<table width="100%" bgcolor=#edf2f8 cellpadding="2" cellspacing="2" border="1" bordercolor="#364d67" rules="none" style="border-collapse:collapse">
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><b><bean:message key="app.common.circle" /></b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><b><%=(String)session.getAttribute("circleName")%></b></td>
		
		<td class=label><font color="#000000" face=verdana size=2><b><bean:message key="app.common.division" /><b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><b><%=(String)session.getAttribute("divisionName")%></b></td>
		
		<td></td>
	
	</tr>
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><b><bean:message key="app.common.subdivision" /></b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><b><%=(String)session.getAttribute("subdivisionName")%></b></td>
		
		<td class=label><font color="#000000" face=verdana size=2><b><bean:message key="app.common.programme" /></b>
		<td class=label>:</td>
		<td class=label><font color="#000000" face=verdana size=2><b><%=session.getAttribute("programmeName")%></b></td>
	</tr>
		<!-- <td class=label><bean:message key="app.common.assettype" />
		<td class=label>:</td>
		<td class=label><%=(String)request.getAttribute("assetName")%></td> -->
		
		<!-- <td class=label><bean:message key="app.common.month"/>
		<td class=label>:</td>
		<td class=label><%=(String)request.getAttribute("monthName")%></td>
		
	</tr>
	<tr>
		
		<td class=label><bean:message key="app.common.year" />
		<td class=label>:</td>
		<td class=label><%=request.getParameter("cmbYear")%></td>
		
		
	</tr>

	<tr>
		<td class=label><bean:message key="app.common.subprogramme" />
		<td class=label>:</td>
		<td class=label><%=session.getAttribute("subprogrammeName")%></td>

		<td class=label><bean:message key="app.progress.entereddate" />
		<td class=label>:</td>
		<!-- <td><html:text property="enteredDate" styleClass="btext" /></td> -->
		<!-- <td class=label><%=(String)session.getAttribute("date")%></td>

	</tr> -->
	
	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
	<td class=label ><font color=#871D0E face=verdana size=2>WORK DETAILS</td></font>
	<tr>
		 <td class=label align=left><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.valueofworkdone" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="valWorkDone" styleClass="btext" /></td> 
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.costofwork" /></b>
		<td class=label>:</td>
		<td ><html:text property="costOfWork" styleClass="btext" /></td>

	</tr>

	

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.valueofworkbeyondagree" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="valWrkBAgr" styleClass="btext" /></td>

		 <td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.valueofworktobedone" /></b>
		<td class=label>:</td> 
		<td><html:text property="valWrkToDone" styleClass="btext" /></td>

	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.dateofcompletion" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="dateComp" styleClass="btext" /></td> 
		
		<!-- "javascript: showCalendar(document.RepresentativeProposalForm.endorsementDate);" -->
	 <!-- <td><A HREF="#"
   onClick="cal.select(document.financialFormt.dateComp,'anchor1','MM/dd/yyyy'); return false;"
   NAME="anchor1" ID="anchor1"><img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle"></A></td>  -->
							 <td><a href="javascript: showCalendar(document.financialFormt.dateComp);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td> 
   
		
	</tr>
	<td class=label ><font color=#871D0E face=verdana size=2>EOAT DETAILS</td><td colspan="5"><hr size="1" color="#525e6e"></td>  
	<tr>	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatorderno" /></b>
		<td class=label>:</td> 
		<td ><html:text property="eoatOrderNo" styleClass="btext" /></td>

	


		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatdate" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="eoatDate" styleClass="btext" /></td>
		<td><a href="javascript: showCalendar(document.financialFormt.eoatDate);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td> 
		</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.costescalationsought" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="cstEscSought" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatperiod" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="eoatPeriod" styleClass="btext" /></td>
	</tr>

	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatoldrefno1" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="eoatORNo1" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatoldrefdt1" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="eoatORDt1" styleClass="btext" /></td>
		<td><a href="javascript: showCalendar(document.financialFormt.eoatORDt1);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr>
	
	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatoldrefno2" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="eoatORNo2" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatoldrefdt2" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="eoatORDt2" styleClass="btext" /></td>
		<td><a href="javascript: showCalendar(document.financialFormt.eoatORDt2);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
	</tr>
	
	<tr>
	
	<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eoatgrantauthority" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="eoatGrantAuth" styleClass="btext" /></td>

	</tr>

	<td class=label ><font color=#871D0E face=verdana size=2>FINE DETAILS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.fineimposed" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="fineImposed" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.finerecovered" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="fineRecovered" styleClass="btext" /></td>

		</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.reasonsfornotrecovfine" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="rsnsForNotRecFine" styleClass="btext" /></td>
	</tr>
	<td class=label ><font color=#871D0E face=verdana size=2>OFFICERS RESPONSIBLE</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	<tr>
	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.officerresp1" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="officerResp1" styleClass="btext" /></td>

		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.officerresp2" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="officerResp2" styleClass="btext" /></td>

	</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.officerresp3" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="officerResp3" styleClass="btext" /></td>
</tr>
	<td class=label ><font color=#871D0E face=verdana size=2>EXEMPTIONS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.exemptrecommbySE" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="exemptRecSE" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.totaldaysexemptbySE" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="totDaysExemptSE" styleClass="btext" /></td>
	</tr>
	
	<tr>
	
	<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.suppdocumentforexempupd" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="suppDocExmpUpd" styleClass="btext" maxlength="1"/></td>
	
	</tr>
	<td class=label ><font color=#871D0E face=verdana size=2>PENALTY</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.rateofpenalty" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="ratePenalty" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.totalpenalty" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="totalPenalty" styleClass="btext" /></td>
</tr>


	<tr>
	
	<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.agreementcopypenaltyupd" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="agreeCopyPenalUpd" styleClass="btext" maxlength="1"/></td>
	
	</tr>
	
	<td class=label ><font color=#871D0E face=verdana size=2>CONTRACTOR DETAILS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	
	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.reasonsbycontractor" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="reasonsContractor" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.contractorrepmadeupd" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="contRepUpd" styleClass="btext" maxlength="1"/></td>
</tr>
	
	<td class=label ><font color=#871D0E face=verdana size=2>RECOMMENDATIONS</td><td colspan="5"><hr size="1" color="#525e6e"></td> 

	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.aeerecommend" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="aeeRecommend" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.deerecommend" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="deeRecommend" styleClass="btext" /></td>

		</tr>

	<tr>
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.eerecommend" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="eeRecommend" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.serecommend" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="seRecommend" styleClass="btext" /></td>
	</tr>

	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.cerecommend" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="ceRecommend" styleClass="btext" /></td>

	</tr>
	
	<td class=label ><font color=#871D0E face=verdana size=2>SUPPLIMENT AGREEMENT</td><td colspan="5"><hr size="1" color="#525e6e"></td> 
	<tr>
		

		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.suppagreeno" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="suppAgreeNo" styleClass="btext" /></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.suppagreedt" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="suppAgreeDt" styleClass="btext" /></td>
		<td><a href="javascript: showCalendar(document.financialFormt.suppAgreeDt);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
</tr>

	<tr>
		
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.preparedby" /></b>
		
		<td class=label>:</td> 
		<td ><html:text property="preparedBy" styleClass="btext" maxlength="5"/></td>

	
		<td class=label><font color="#000000" face=verdana size=2><B><bean:message key="app.eoat.prepareddate" /></b>
		
		<td class=label>:</td>
		<td class=label><html:text property="preparedDt" styleClass="btext" /></td>
		<td><a href="javascript: showCalendar(document.financialFormt.preparedDt);">
						<img src="/Pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		
	</tr>

	<tr>
		  <td colspan="6"><hr size="1" color="#525e6e"></td>
		</tr> 
	
		<TR>
		<!-- <TD align=center  colspan=6><html:submit /> -->
		<%
		String disIns=(String)request.getAttribute("name");
		if (disIns==null)
		{
			disIns="";
			
		}
		System.out.println("disins"+disIns);
		if (session.getAttribute("flag").equals("0") && !disIns.equals("forward"))
		{
			
			%>
			<html:hidden property="cmdinssub" />
		<td align=center  colspan=6><INPUT class id ="buttonfont" id=button4 type=button value=Submit name=button4 onClick="fsubmit()">
		<%
		}
			if (session.getAttribute("flag").equals("1") && !disIns.equals("forward"))
			{
			%>
				<td align=center  colspan=6><INPUT class id ="buttonfont" id=button4 type=button value=Submit name=button4 onClick="usubmit()">
				<%
			}
			if (disIns.equals("forward") && session.getAttribute("flag").equals("0"))
			{
			%>
			<td align=center  colspan=6><INPUT class id ="buttonfont" id=button4 type=button value=Submit name=button4 disabled>
			<%
			}
			%>
			<html:hidden property="cmdNext" />
		<!--  <INPUT class id ="buttonfont" id=button3 type=button value=Next name=button3 onClick="movenext()">  -->
		
		<INPUT class id ="buttonfont" id=button1 type=button value=Exit name=button1 onClick="main()">
		<%
		
		int mno=Integer.parseInt((String)session.getAttribute("ppNumber"));
		
		System.out.println("number"+mno);
		if (mno>0)
		{
			
		%>
			<html:hidden property="cmdDel" />
		 <INPUT class id ="buttonfont" id=button2 type=button value=Delete name=button2 onClick="ppdelete()"> 
		<%}%>
		</TD>

		</TR>
		</table>
		<tr><td>  
		<!-- <table cellpadding="0" cellspacing="0" width="100%">
		<tr>	

			<td><img src="resources/images/bottom_left.gif"></td>
			<td background="resources/images/bottom_center.gif" width="100%" class="heading" valign="middle"	align="center"></td>
			<td><img src="resources/images/bottom_right.gif"></td>
		</tr>
	</table> -->
	<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse" >
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_b_left1.gif" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=723>
	 <!--  <FONT  style="font-size:9pt" color="#000000"><font color="#FF6666" >*</font>&nbsp;Data mandatory</FONT></td> -->
	  <TD WIDTH="20" bordercolor=white><IMG SRC="resources/images/r_b_right1.gif" ALT=""></TD>
</TABLE>
	</td>
	</tr>
	</table>
	</td></tr></table>

	</html:form>
	<p align="center">

<%@ include file="footer.jsp" %>


              </p>

