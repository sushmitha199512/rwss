<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<script>
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
 function fnview()
 {
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
	
	 if(fDate<=tDate)
	 {
		 document.forms[0].action="./rws_Releases_bdates_rpt.jsp?drill="+drill;
		 document.forms[0].submit();
	 }else{
			alert("ToDate is  always greater than From Date");   
		   }
	 }
 }
</script>

<form>
<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value="Releases Between Dates" />
<jsp:param name="TWidth" value="300" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="340" border=1 style="border-collapse:collapse;" >
<tr >
<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendar(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<td  align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendar(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
</tr>
<tr><td align="center"><input type="button" name="view" value="View Report" onclick="fnview()"></td></tr></td>
</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>
<input type="hidden" name="drill" value="1"/>
</form>