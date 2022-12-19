<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<style type="text/css">
<!--
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;


}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}
div#tbl-container22 {
widtd: 950px;
height: 430px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
font-size: 11px;
height: 28px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;

font-size: 8px;.
height: 21px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table td {
height: 28px;

}
div#tbl-container22 tdead td, div#tbl-container22 tdead td.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #2B3856;
color: white;
position:relative;
cursor: default; 
}
div#tbl-container22 tdead td {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 10;
}
div#tbl-container22 tdead td.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 td.locked{
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;

}
-->
</style>



<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:0 0;
 }
.container img {
    widtd:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}



.on {
    widtd:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>

<%

	 
	 	int count = 1;
 %>

 <script language="JavaScript" src="<rws:context page='/resources/javascript/calendar.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/calendarfuture.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/rwsscript.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/menu.js' />"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/jquery-1.4.2.js' />"></script>



<script type="text/javascript">
function getMandals(str)
{
var xmlhttp;    


if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
	xmlhttp.responseText

    }
  }

xmlhttp.open("POST","switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=get2",true);
xmlhttp.send(null);
}



</script>



<script language="JavaScript">

 function getData2()
{

 
	document.forms[0].action="switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=get2";
	document.forms[0].submit();
    
     
}

 function DateChanged()
 {
   alert("date changed");
   document.forms[0].action="switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=get2";
	document.forms[0].submit();

 }

function getHabs()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=view";
	document.forms[0].submit();

}
function fnSave(){
	
    var habitations1="";
	var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';
	//alert(district);
	//alert(mandal);
	
    var len=document.forms[0].resultCount.value;
	//alert(len);
	len = len-1;
	
	if(document.getElementById("toDate").value==0)
	{
	   alert("Please select Date");
	   return;
	}
	
    
	
	for( var j=0;j<len;j++)
	{     
		
			if(document.getElementById("TR_Details["+j+"].checks").checked==true)
			{
				 
				habitations1=habitations1+document.getElementById("TR_Details["+j+"].habCode").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].transportationEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].hiringOfSourcesEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].flushingEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].deepeningEST").value;

habitations1=habitations1+","

if(document.getElementById("toDate").value==0)
				{
	           alert("Please Enter From Date");

			   				return;
				}
				



		     }
			 
			 
	}
	habitations1=habitations1+"D,";
	
	  if(habitations1=="D,")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	   
	     if(confirm("Are You Sure To Save tde Checked Habitation(s)")) {
			  document.forms[0].hab1.value = habitations1;
			  document.forms[0].financialYear.value = document.getElementById("financialYear").value;
			  document.forms[0].toDate.value = document.getElementById("toDate").value;
			  
			  
	          document.forms[0].action="switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=save&dist="+district+"&mand="+mandal;
         document.forms[0].submit();
			}
	  }
}

</script>

<body >



<%
		
    String toDate=(String)session.getAttribute("toDate");

	 
%>

<html:form action="/DroughtCumulative.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Cumulative Expenditure for Drought Habitaions" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<div id="txtHint">
<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
<tr>
	<td class="mycborder">
		<fieldset>
			<legend></legend>
			<label>
<table  border=0  width="100%" >
<tr>

	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="dist" style="width:123px" styleClass="mycombo" onchange="javascript:getData2(
	)" >
	<html:option value=""><font class="myfontclr1">SELECT...</html:option>
	<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
	</html:select>
		
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mand" styleClass="mycombo" style="width:123px" onchange="javascript:getHabs()" >
	<html:option value="">SELECT...</html:option>
	<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
	</html:select>
	</td>
	<td class=mycborder>
		<td ><font face=verdana size=2><b>Date</b></td>
		<td width="200"><input type=text property="toDate" name="toDate" value=<%= toDate %> onchange="javascript:DateChanged()"></text>
		<a href="javascript: showCalendarFuture(document.getElementById('toDate'))" >
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
					
				<td class="textborder">Financial Year:
							<html:select property="financialYear" styleClass="mycombo" style="width:123px" >
							<html:option value="2011-2012"> 2011-2012</html:option>
							<html:option value="2013-2014"> 2013-2014</html:option>
							<html:option value="2014-2015"> 2014-2015</html:option>
							<html:option value="2014-2015">  2015-2016</html:option></html:select>
							
							</td>
	
	
	
</tr>


</label>
		</fieldset>
	</td>
</tr>

</table>



<table  border = 1 align=center bordercolor=black style="border-collapse:collapse;" width="100%">
	

        <tr align="center">
			<td class="clrborder" align="center" rowspan=2 width="20">Select</td>
			<td  class="clrborder" align="center" rowspan=2 width="30">S.No</td>
			<td  class="clrborder" align="center" rowspan=2 width=150>HabCode</td>
			<td  class="clrborder" align="center"  rowspan=2 width=150>Habitation Name</td>
			
			<td class="clrborder"  align="center"   colspan=5><b>Expenditure</b></td>
			</tr>
			<tr  align="center">
			<td class="clrborder"  align="center"   width=100 >TRANSPORT <br><font color="black">(Rs.In Lakhs)</font></td>
			<td class="clrborder"  align="center" width=100>HIRING OF PRIVATE SOURCES<br><font color="black">(Rs.In Lakhs)</font></td>
			<td class="clrborder"  align="center"   width=100>FLUSHING<br> <font color="black">(Rs.In Lakhs)</font>)</td>
			<td class="clrborder"  align="center"  width=100>DEEPENING <br> <font color="black">(Rs.In Lakhs)</font></td>
					
			</tr>
				
			
   <%System.out.println("nested near:"+request.getParameter("habCode"));%>
	<% if(request.getParameter("dist")!=null && request.getParameter("dist")!=null && request.getParameter("mand")!=null ){
	session.getAttribute("habs");
	
%>

	<nested:iterate id="TR_Details" name="habs" indexId="ndx" >
<tr  class="normalRow" onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
	
	<td class="locked" widtd="30">
	<html:checkbox name="TR_Details" property="checks"   indexed="true"  />
				</td>

	
	
	 	
	<td class="locked" align="center" widtd="30">
	<%= count++ %>
	</td>

	<td align="center" class="locked">
	<bean:write name="TR_Details" property="habCode" />
	</td>
	<nested:hidden name="TR_Details" property="habCode"  indexed="true"/>
    <nested:hidden name="TR_Details" property="dist"  indexed="true"/> 
	<nested:hidden name="TR_Details" property="mand"  indexed="true"/>
	<td  align="left" class="locked">
	<bean:write name="TR_Details" property="habName" />
	</td>
									
					
					<td class="rptValue" widtd="100" align=center>  <html:text name="TR_Details" size="15"  property="transportationEST"  maxlength="5" indexed="true" onkeypress="return decimalsOnly(event)" />	
	</td>
					<td class="rptValue" widtd="100" align=center>  <html:text name="TR_Details" size="15" property="hiringOfSourcesEST"  maxlength="5" indexed="true" onkeypress="return decimalsOnly(event)" /> 	
	</td>
					<td class="rptValue" widtd="100" align=center>  <html:text name="TR_Details" size="15" property="flushingEST"  maxlength="5" indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
					<td class="rptValue" widtd="100" align=center> <html:text name="TR_Details" size="15" property="deepeningEST"  maxlength="5" indexed="true" onkeypress="return decimalsOnly(event)" /> 
	</td>
				
					
			

					
	</tr>
	</nested:iterate>
	
	<%}%>
   
 <tr align=center>
	<td align="center" >
		<input type="hidden" name="resultCount" value="<%=count%>">
	
	</td>
    </tr>
	<% if(count==1){ %>
	
	<tr> <td colspan=8 align=center><b><font color=red>No Records</font> </b></td>
</tr>	
	<%  }%>
	


</table> 
</div>

<table align="center">
<tr  >
<td><br><br>
<input type="button"  name="Save"   value="Save" onclick="fnSave();">
</td>
</tr>
</table>
	   
		<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</table>	
<input type=hidden name=hab1>
<input type="hidden" name="financialYear">
<input type="hidden" name="toDate">

</html:form>
</html:html>

<p align="center">
</div>
</p>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>