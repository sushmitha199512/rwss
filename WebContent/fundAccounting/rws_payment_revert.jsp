
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
<style>
.latest {
	border-width: 1;
	width:140;
	border-color: #000000;
	color: red;
	font-weight: bold;
	height: 20px;
	font-family: verdana;
	font-size: 10pt
}
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</style>
<style type="text/css">
/* --------
  The CSS rules offered here are just an example, you may use them as a base. 
  Shape your 'expand/collapse' content so that it meets the style of your site. 
 --------- */
* {margin:0; padding:0}
/* --- Page Structure  --- */

#wrapper{
  margin:0 auto;
  padding:15px 15%;
  text-align:left
}
#content {
  max-width:70em;
  width:100%;
  margin:0 auto;
  padding-bottom:10px;
  overflow:hidden
}
.demo {
  margin:0;
  padding:1.5em 1.5em 0.75em;
  border:1px solid #ccc;
  position:relative;
  overflow:hidden;
}
.collapse p {padding:0 10px 1em}
.top{font-size:.9em; text-align:right}
#switch, .switch {margin-bottom:5px; text-align:right}

/* --- Headings  --- */
h1 {
  margin-bottom:.75em; 
  font-family:georgia,'times new roman',times,serif; 
  font-size:2.5em; 
  font-weight:normal; 
  color:#c30
}
h2{font-size:1em;
 height:20;
}

.expand{padding-bottom:.75em}

/* --- Links  --- */
a:link, a:visited {
  border:1px dotted #ccc;
  border-width:0 0 1px;
  text-decoration:none;
  color:green
}
a:hover, a:active, a:focus {
  border-style:solid;
  background-color:#F5FFFA;
  outline:0 none
}
a:active, a:focus {
  color:red;
}
.expand a {
  display:block;
  padding:3px 10px
}
.expand a:link, .expand a:visited {
  border-width:1px;
  background-image:url(/pred/images/arrow-down.gif);
  background-repeat:no-repeat;
  background-position:98% 50%;
}
.expand a:hover, .expand a:active, .expand a:focus {
  text-decoration:underline
}
.expand a.open:link, .expand a.open:visited {
  border-style:solid;
  background:#4A708B url(/pred/images/arrow-up.gif) no-repeat 98% 50%;
  color:white;
}
</style>
<!--[if lte IE 7]>
<style type="text/css">
h2 a, .demo {position:relative; height:1%}
</style>
<![endif]-->

<!--[if lte IE 6]>
<script type="text/javascript">
   try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
</script>
<![endif]-->
<!--[if !lt IE 6]><!-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="/pred/resources/javascript/expand.js"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--
$(function() {
    // --- Using the default options:
   // $("h2.expand").toggler({initShow: "div.collapse:first"});
    
    
   // $("h2.expand").toggler();
    // --- Other options:
    //$("h2.expand").toggler({method: "toggle", speed: 0});
    //$("h2.expand").toggler({method: "toggle"});
    //$("h2.expand").toggler({speed: "fast"});
    $("h2.expand").toggler({method: "fadeToggle"});
    //$("h2.expand").toggler({method: "slideFadeToggle"});    
   // $("#content").expandAll({trigger: "h2.expand", ref: "div.demo",  speed: 300, oneSwitch: false});
});
//--><!]]>
</script>
<!--<![endif]-->
</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment Revert</title>


</head>
<script language="JavaScript">

function getTxIds()
{
    //alert("hai");
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/paymentRevertion.do?mode=txIds";
	document.forms[0].submit();  
     
	
} 
function getDetails()
{
    //alert("hai");
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/paymentRevertion.do?mode=txDetails";
	document.forms[0].submit();  
     
	
}
function getTxDates(){
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/paymentRevertion.do?mode=txDates";
	document.forms[0].submit();  
    
}
function revertPayment(){
	
	if(document.forms[0].elements["recordCount"].value=="1"){
		alert("No Transactions found to revert.");
		 return;
	}
	/* if(document.forms[0].elements["number"].value==""){
		alert("Enter Security Code");
		 return;
	} */
	if(confirm("Are you sure to confirm revert the transaction.\r\n Once done cannot back the transaction")){
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/paymentRevertion.do?mode=revert";
	document.forms[0].submit();  
	}
    
}

</script>

<body>
<html:form action="paymentRevertion.do">
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Bank & PAO Payment Revertion " />
		<jsp:param name="TWidth" value="780" />
	</jsp:include>


	<table bgcolor="white" style="border-collapse: collapse;">
		<tr >
			<td>
			<fieldset><legend>Criteria</legend> 
			<table  >
				<tr>
				<td class="btext2" width="100">Transaction&nbsp;Type<font color="#FF6666">*</font>
					<td class="textborder" width="150"><html:select
						property="txType" styleClass="mycombo" style="width:130px"
						onchange="javascript:getTxDates()">
						<html:option value="">
							<font class="myfontclr1">SELECT...</font>
						</html:option>
						<!-- temporary  comment for bank  and pao, to discourage the usage for the user   --> 
						<%-- <html:option value="1">
							<font class="myfontclr1">BANK</font>
						</html:option> --%>
						<%-- <html:option value="2">
							<font class="myfontclr1">PAO</font>
						</html:option> --%>
						<html:option value="3">
							<font class="myfontclr1">FORWARD PAO</font>
						</html:option>
						
						
						</html:select></td>
					<td class="btext2" width="100">Transaction&nbsp;Date<font color="#FF6666">*</font>
					<td class="textborder" width="150"><html:select
						property="txDate" styleClass="mycombo" style="width:130px"
						onchange="javascript:getTxIds()">
						<html:option value="">
							<font class="myfontclr1">SELECT...</font>
						</html:option>
						<logic:present name="txDates">
							<html:options collection="txDates" name="rwsLocationBean"
								property="value" labelProperty="label" />
						</logic:present>
					</html:select></td>
					<td class="btext2" width="100">Transaction&nbsp;Ids<font color="#FF6666">*</font>
					<td class="bwborder"><html:select property="txId"
						styleClass="mycombo" style="width:140px"
						onchange="javascript:getDetails()">
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="txIds">
							<html:options collection="txIds" name="labelValueBean"
								property="value" labelProperty="label" />
						</logic:notEmpty>
					</html:select></td>
									</tr>


			</table>
			</fieldset>
			</td>
		</tr>
		<tr>
			<td>
			<fieldset><legend>Transaction Details</legend> 

						
				<div id="wrapper"> 
      <div id="content">  
        <h1 class="heading"></h1>
          <div class="demo">
            <h2 class="expand">Total Bills:&nbsp;<bean:write name="RwsPaymentRevertActionForm" property="totalBills"   ></bean:write>
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Total Amount:&nbsp;<bean:write name="RwsPaymentRevertActionForm" property="totalProccessedAmount" ></bean:write>
            
            </h2>
            <div class="collapse">
                <p>
                <table width="60%" border="0" style="border-collapse:collapse"   >
                           <tr><td class="gridhdbg">SlNo </td><td class="gridhdbg">WorkId</td><td class="gridhdbg">OfficeCode</td>
                           <td class="gridhdbg">BillSlNO</td><td class="gridhdbg">Bill Amount</td>
                           </tr>
							<%
 	int count=1;
	int styleCount=0;
	String style="";


%>
                        <logic:notEmpty name="RwsPaymentRevertActionForm" property="txBillsList">
					<nested:iterate id="txBillsList" name="RwsPaymentRevertActionForm"
						property="txBillsList" indexId="ndx">
						<%
						if(styleCount%2==0){
							 style="gridbg1";
						 }else{
							 style="gridbg2";
						 }
						 styleCount++;
						%>
						<tr>
						<td class="<%=style%> "style="text-align: right;"><%=count++ %></td>
						<td class="<%=style%> "style="text-align: right;" ><bean:write name="txBillsList" property="workId" /></td>
						<td class="<%=style%> "style="text-align: right;"  ><bean:write name="txBillsList" property="officeCode" /></td>
						<td class="<%=style%> "style="text-align: right;" ><bean:write name="txBillsList" property="billSlNo" /></td>
						<td class="<%=style%> "style="text-align: right;"  ><bean:write name="txBillsList" property="billAmount" /></td>
						
						
						</tr>
						
                        </nested:iterate>
                        </logic:notEmpty>
                </table>
                </p>
                
            </div>
                   
           
            </div>
            </div>
            </div>
            
				
				
				</fieldset>
				
				<%-- <fieldset>
	<legend>Security Code</legend>
	<label>
	<center><div  id="captcha"><%@include file="/Captcha/form.jsp"%></div></center>
	</label>
	</fieldset> --%>
	
				</td>
				</tr>
				<tr><td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="latest" type="button" onclick="revertPayment();" value="Revert"></td></tr>
				
	
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="780" />
		</jsp:include>
	</table>
<input type="hidden" name="recordCount" value=<%=count %> >
</html:form>

	
</body>
<p align="center"><%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%></p>