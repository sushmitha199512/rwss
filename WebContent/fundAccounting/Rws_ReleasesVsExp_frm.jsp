<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function funcInit()
{
	if(document.forms[0].fromYear.value=="")
	{
		document.getElementById("fromMonthLabel").style.display="none";
		document.getElementById("fromMonthComb").style.display="none";
		document.forms[0].fromYear.style.width="180px";
	}
	if(document.forms[0].fromMonth.value=="")
	{
		document.getElementById("toYearLabel").style.display="none";
		document.getElementById("toYearComb").style.display="none";
	}
	if(document.forms[0].toYear.value=="")
	{
		document.getElementById("toMonthLabel").style.display="none";
		document.getElementById("toMonthComb").style.display="none";
	}
 
}

function submitForm()
{
document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureSchemeWiseBetweenDates.do&mode=betweenDates";
document.forms[0].submit();

}

function getViewRpt()
{

if(document.forms[0].fromYear.value!=""&& document.forms[0].toYear.value!="")
{

	if(parseInt(document.forms[0].fromYear.value.substring(0,4),10)>parseInt(document.forms[0].toYear.value.substring(0,4),10))
	{
		alert("From Year should not be greater than To Year");
		return false;
	}
	if(document.forms[0].fromYear.value==document.forms[0].toYear.value)
	{
		var arr=new Array(0,10,11,12,1,2,3,4,5,6,7,8,9);
		var intFromMonth=arr[parseInt(document.forms[0].fromMonth.value,10)];
		var intToMonth=arr[parseInt(document.forms[0].toMonth.value,10)];
		if(intFromMonth>intToMonth)
		{
			alert("From Month should not be greater than To Month");
			return false;	
		}
	}
	
}

document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureSchemeWiseBetweenDates.do&mode=betweenDatesView";
document.forms[0].submit();
}
</script>
<body onload="funcInit()">
<html:form action="releasesVsExpenditureSchemeWiseBetweenDates.do&mode=betweenDates">
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Releases Vs Expenditure" />
		<jsp:param name="TWidth" value="100%"/>
		
	</jsp:include>
</td></tr></thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>
<tbody>
<tr>
<td>


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
<tr>
	<td class="mycborder">
		
	<fieldset>
			<legend></legend>
			<label>
				<table  border="0"  width="100%">
				<tr>
					<TD class="textborder">
				     	Select Circle<font color="#FF6666"></font>
					</TD>
					<td colspan="2">
						<html:select property="circle" style="width:180px"  styleClass="mycombo">
							<html:option value="">All........</html:option>
							<html:options collection="circlesList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
					</tr>
				<tr>
					<TD class="textborder">
				     	Select Scheme<font color="#FF6666"></font>
					</TD>
					<td colspan="2">
						<html:select property="scheme" style="width:180px"  styleClass="mycombo">
							<html:option value="">All........</html:option>
							<html:options collection="schemesList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
					</tr>
					<tr>
					<TD class="textborder">
				     	From Year<font color="#FF6666"></font>
					</TD>
					
					<td>
						<html:select property="fromYear" style="width:100px"  styleClass="mycombo" onchange="javascript:submitForm()">
							<html:option value="">All........</html:option>
							<html:options collection="fromYearsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
					
					<TD class="textborder" id="fromMonthLabel">
				     	Month<font color="#FF6666"></font>
					</TD>
					<td id="fromMonthComb">
						<html:select property="fromMonth" style="width:80px"  styleClass="mycombo" onchange="javascript:submitForm()">
							<html:option value="">All.......</html:option>
							<html:options collection="fromMonthsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
					</tr>
					<tr>
					<TD class="textborder" id="toYearLabel">
				     	To Year<font color="#FF6666"></font>
					</TD>
					
					<td id="toYearComb">
						<html:select property="toYear" style="width:100px"  styleClass="mycombo" onchange="javascript:submitForm()">
							<html:option value="">All........</html:option>
							<html:options collection="toYearsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
					
					<TD class="textborder" id="toMonthLabel">
				     	Month<font color="#FF6666"></font>
					</TD>
					<td id="toMonthComb">
						<html:select property="toMonth" style="width:80px"  styleClass="mycombo" onchange="javascript:submitForm()">
							<html:option value="">All.......</html:option>
							<html:options collection="toMonthsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
						</html:select>
					</td>
				  </tr>
				  <tr>
				  <td colspan="4"  align="center"><input type="button" value="View" class="btext" style="width:80px" onclick="getViewRpt()"/>
				  </tr>
				  </table>
			 </label>
	 </fieldset>
	 </td>
	 </tr>
	 </table>
	 
	 
	 </td>
	 </tr>
	 </tbody>
	 </table>
	 </html:form>
	 </body>
	 
				    

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
