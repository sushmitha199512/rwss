<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>

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
width: 1150px;
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
div#tbl-container22 table th {
height: 28px;

}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;

color: white;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 10;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
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
    margin:4px 0;
 }
.container img {
    width:16px;
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
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>

<%

WorksData1 wd = new WorksData1();
//System.out.println(wd.getServerDate());
//System.out.println(wd.getServerDate().substring(3,5));
int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	 	int count = 1;
	 	 if(Integer.parseInt(wd.getServerDate().substring(3,5))==11 || Integer.parseInt(wd.getServerDate().substring(3,5))==12){
	 		year1++;
	 	} 
 %>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
 <script language="JavaScript" src="<rws:context page='/resources/javascript/calendar.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/calendarfuture.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/rwsscript.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/menu.js' />"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/jquery-1.4.2.js' />"></script>




<script language="JavaScript">

function integersOnly(obj) {

    var value_entered = obj.value;
    
        if (value_entered.indexOf(".") > -1) {
            alert('Please enter an integer only. No decimal places.');
            integer_only_warned = true;
            obj.value = value_entered.replace(/[^0-9]/g,'');
        }
    
    obj.value = value_entered.replace(/[^0-9]/g,'');        
}

function fnDelete(value){
var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';
   var habCode=document.getElementById('TR_Details['+value+'].thabitationCode').value;
 var value=confirm("Are you sure want to delete this  "   +habCode+  "   Habitation");
 if(value==true){

document.forms[0].action="switch.do?prefix=/drought&page=/PowerTransport.do?mode=delete&habCode="+habCode+"&dist="+district+"&mand="+mandal;
	document.forms[0].submit();
}
}
function getYearData()
{
    	var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';

	document.forms[0].action="switch.do?prefix=/drought&page=/PowerTransport.do?mode=cview&dist="+district+"&mand="+mandal;
	document.forms[0].submit();
    
     
}

function validateDate(value)
{
	        
}
 function ValidateCategory(j,k)
 {
	 
	
	
    
 }
 function autocompletion()
 {
       // alert("auto comp");
 	 for (i=0; i<document.forms.length; i++) {
         document.forms[i].setAttribute("AutoComplete","off");
        }
 }
function fnSave(){
	
    var habitations1="";
	var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';
	var panchayat='<%=request.getParameter("panchayath")%>';
	//alert(district);
	//alert(mandal);
	
    var len=document.forms[0].resultCount.value;
	//alert(len);
	len = len-1;
	
	
	for( var j=0;j<len;j++)
	{     
		
			if(document.getElementById("TR_Details["+j+"].checks").checked==true)
			{
				 

				habitations1=habitations1+document.getElementById("TR_Details["+j+"].thabitationCode").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].causeOfScarcity").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].transportation").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].hiringOfSources").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].flushing").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].deepening").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].powerProblem").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].frmDate").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].toDate").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].transportationEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].hiringOfSourcesEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].flushingEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].deepeningEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].powerProblemEST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].typeOfWork").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].workESTCOST").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].remarks").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].deepenOwNum").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].deepenOwEst").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].sstNum").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].sstEst").value;
habitations1=habitations1+","+document.getElementById("TR_Details["+j+"].sstScheme").value;
habitations1=habitations1+","


if(document.getElementById("TR_Details["+j+"].transportation").value=='Y'){

if(document.getElementById("TR_Details["+j+"].frmDate").value==0)
				{
	           alert("Please Enter From Date");

			   				return;
				}
				if(document.getElementById("TR_Details["+j+"].toDate").value==0)
				{
	           alert("Please Enter To Date");
			 
			  return;
				}

}

		     }
			 
			 
	}
	habitations1=habitations1+"D,";
	//alert("habitations1"+habitations1);
	
	  if(habitations1=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	   
	     if(confirm("Are You Sure To Save The Checked Habitation(s)")) {
			  document.forms[0].hab1.value = habitations1;
	          document.forms[0].action="switch.do?prefix=/drought&page=/PowerTransport.do&mode=save&dist="+district+"&mand="+mandal+"&panchayath="+panchayat;
	          //alert(document.forms[0].action);
         document.forms[0].submit();
			}
	  }
}

</script>


<body  onload="autocompletion()">

<html:form action="/PowerTransport.do">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<!--<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>-->
	<td class="bwborder"><a href="switch.do?prefix=/drought&page=/PowerTransport.do&mode=get2">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
	</tr>  
	</table>
	</caption>
    <tr bgcolor="" align="center" >
	<td align="center" class="rptHeading" colspan=4><font color="red">(  Amount in Rs. Lakhs  ) 
	</font> </td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=4>Contingency Plan - Habitations for Drought 
	 </td>
	</tr>
	<%
	String dname=(String)session.getAttribute("dname");
			String mname=(String)session.getAttribute("mname");
			String pname=(String)session.getAttribute("pname");
	%>
	<tr  align="center">
	<td align="center" class="rptHeading"><font color="red">District:</font><%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">Mandal:</font><%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<% //System.out.println("panchayat name"+pname);
	if(!pname.equals(null) && !pname.equals("")){%>
	<font color="red">Panchayat:</font><%=pname%>&nbsp;
	<%} %></td>
	<td class="textborder" width="100">
	Drought Year<font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<SELECT name="droughtYear" id="combo" class="mycombo" style="width:150px"  >
		<option value="">-Select-</option>
		<%
		
		for(int i=year1;i>=2012;i--)
		{
			String ii =""+i;
			if(request.getParameter("year")!=null && request.getParameter("year").equals(ii)) {
			
				
			%>
		<option value='<%=i%>' selected><%=i%></option>
		<%
		}
		else
		{%>
		<option value='<%=i%>'><%=i%></option>
		<%
		
		}
		}
			
		%>



		</select>
		</td>
<!-- <td class="rptHeading">Drought Year:<html:select property="droughtYear" onchange="getYearData()"><html:option value="2015">2015</html:option><html:option value="2014">2014</html:option><html:option value="2013">2013</html:option><html:option value="2012">2012</html:option></html:select></td> --> 
<td class="rptHeading">Whether Drought Mandal Or Not:<html:select property="droughtMandal"><html:option value="">Select</html:option><html:option value="Y">Yes</html:option><html:option value="N">No</html:option></html:select></td>	
</tr>
	<tr bgcolor="#8A9FCD" align="center">
	</table>
	
	
	<div id="tbl-container22">

<table id="tbl" border = 1 width="100%" align=center bordercolor=black style="border-collapse:collapse">
	
		<thead class="fixedHeader">
        <tr align="center">
			<th class="locked" style="background:#4682b4" align="center" width="50"  rowspan=2 >Select</th>
<th class="locked" style="background:#4682b4" align="center" width="50"  rowspan=2 >Remove</th>
			<th class="locked" style="background:#4682b4" align="center" rowspan=2 width="30">S.No.</th>
			<%if(pname.equals(null) || pname.equals("")){%>
			<th class="locked" style="background:#4682b4" align="center" rowspan=2 width="150">Panchayath</th>
			<%} %>
			<th class="locked" style="background:#4682b4" align="center" rowspan=2 width=150>HabCode</th>
			<th class="locked" style="background:#4682b4" align="center" rowspan=2 width=150>Habitation Name</th>
			<th class="clrborder" style="background:#4682b4" align="center" rowspan=2 width=170>Scarcity Cause</th>
			<th class="clrborder" style="background:#4682b4" align="center" colspan=2 width=180 >Transportation</th>
			<th class="clrborder" style="background:#4682b4" align="center"  colspan=2 width=180>Hiring of private Source</th>
			<th class="clrborder" style="background:#4682b4" align="center"  colspan=2 width=180>Anticipated max. period for Trans/Hiring</th>
			<th class="clrborder" style="background:#4682b4" align="center"  colspan=2 width=180>Flushing of BW</th>
			<th class="clrborder" style="background:#4682b4" align="center" colspan=2 width=200>Deepening Of BW <br>(Includes Flushing)</th>
			<th class="clrborder" style="background:#4682b4" align="center"  colspan=2 width=180>Deepening of OW</th>

			<th class="clrborder" style="background:#4682b4" align="center"  colspan=3 width=300>Filling Of SS Tanks </th>

			<th class="clrborder"  style="background:#4682b4" align="center"  rowspan=2 width=200>REMARKS</th>
			<th class="clrborder" style="background:#4682b4" align="center" colspan=2 width=250>MEASURES TO TACKLE SCARCITY PERMANENTLY </th>

			<th class="clrborder" style="background:#4682b4" align="center" rowspan=2 width=80>Power Problem</th>
			<th class="clrborder" style="background:#4682b4" align="center" rowspan=2 width=100>POWER_EST </th>
				
			</tr>
			<tr align="center">
			<th class="clrborder" style="background:#4682b4" align="center" width=80 >Trans(Yes/No)</th>
		<th class="clrborder" style="background:#4682b4" align="center"  width=100 >TRANSPORT_EST</th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>HIRING_NUM </th>			
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>HIRING_EST </th>
<th class="clrborder" style="background:#4682b4" align="center"  width=120>From Date</th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=120>TO Date</th>
			
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>FLUSHING_NUM</th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>FLUSHING_EST</th>
			<th class="clrborder" style="background:#4682b4" align="center" width=100>DEEPENING_NUM </th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>DEEPENING_EST </th>
			<th class="clrborder" style="background:#4682b4" align="center" width=100>DEEP_OW_NUM </th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>DEEP_OW_EST </th>
			<th class="clrborder" style="background:#4682b4" align="center" width=100>SST_NUM </th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=100>SST_EST </th>
			<th class="clrborder" style="background:#4682b4" align="center"  width=180>SCHEME</th>
			<th class="clrborder" align="center" width="40" style="background:#4682b4">TYPE_OF_WORK </td>
			<th class="clrborder" align="center" width="50" style="background:#4682b4">WORK_EST_COST</td>
			</tr>
			
		

</thead>
			
			
   <%//System.out.println("nested near:"+request.getParameter("habCode"));%>
	<% if(request.getParameter("dist")!=null && request.getParameter("dist")!=null && request.getParameter("mand")!=null ){
	session.getAttribute("habs");
	
%>

	<nested:iterate id="TR_Details" name="habs" indexId="ndx" >
<tr  class="normalRow">
		
	<td class="locked" width="30">
	<html:checkbox name="TR_Details" property="checks"   indexed="true"  />
				</td>

	<td class="locked" align="center" nowrap><img src="/pred/resources/images/deleteButton2.png" onclick="javascript:fnDelete(<%=count-1 %>)" /></td>
	
	 	
	<td class="locked" align="center" width="30">
<%= count++ %>
	</td>
	<%if(pname.equals(null) || pname.equals("")){%>
	<td  align="left" class="locked">
	<bean:write name="TR_Details" property="panchayatName" />
	</td>
	<%} %>
	<td align="center" class="locked">
	<bean:write name="TR_Details" property="thabitationCode" />
	</td>
	<nested:hidden name="TR_Details" property="thabitationCode"  indexed="true"/>
    <nested:hidden name="TR_Details" property="dist"  indexed="true"/> 
	<nested:hidden name="TR_Details" property="mand"  indexed="true"/>
	<nested:hidden name="TR_Details" property="panchayatName"  indexed="true"/>
	<td  align="left" class="locked">
	<bean:write name="TR_Details" property="thabName" />
	</td>
<td class="textborder">
							<logic:present name="categories">
							<html:select  name="TR_Details" property="causeOfScarcity" styleClass="mycombo" style="width:150px" indexed="true" 	onchange='<%= "ValidateCategory("+(count-2)+","+1+")"%>'>
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="categories" name="labelValueBean"
										  property="value" labelProperty="label" />
							</html:select>
							
							</logic:present>
							</td>
											
						<td class="rptValue" width="80" align=center>
				<html:select name="TR_Details"  property="transportation" styleClass="mycombo" indexed="true"  style="width:80px">
				<html:option value="N"><font class="myfontclr1">NO</html:option>
		<html:option value="Y"><font class="myfontclr1">YES</html:option>
				</html:select>
						</td>
<td class="rptValue" width="100" align=center>  <html:text name="TR_Details" size="5"  property="transportationEST"  indexed="true" onkeypress="return decimalsOnly(event)" />	
	</td>
<td class="rptValue" align=center>
							<html:text name="TR_Details" size="5" property="hiringOfSources"  indexed="true"  onkeypress="return integersOnly(this)" /> 	
							
						</td>
	<td class="rptValue" width="100" align=center>  <html:text name="TR_Details" size="5" property="hiringOfSourcesEST"  indexed="true" onkeypress="return decimalsOnly(event)" /> 	
	</td>
			
<TD class="rptValue" nowrap align=center>
				    	<html:text name="TR_Details"  property="frmDate"   
				    			   styleClass="mytext" style="width:50"   indexed="true"  />
				    			   <a href="javascript: showCalendarFuture(document.getElementById('TR_Details[<%=count-2 %>].frmDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>

		<TD class="bwborder" nowrap>
				    	<html:text name="TR_Details"  property="toDate"   
				    			   styleClass="mytext" style="width:50"   indexed="true"  onchange="validateDate();" />
				    			   <a href="javascript: showCalendarFuture(document.getElementById('TR_Details[<%= count-2 %>].toDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
						
						<td align=center>
							<html:text name="TR_Details" size="5" property="flushing"  indexed="true"  onkeypress="return integersOnly(this)" /> 
							
						</td>
	<td class="rptValue" width="100" align=center>  <html:text name="TR_Details" size="5" property="flushingEST"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
				

						<td class="rptValue" align=center>
	<html:text name="TR_Details" size="5" property="deepening"  indexed="true"  onkeypress="return integersOnly(this)" /> 	
													
						</td>
	<td class="rptValue" width="100" align=center> <html:text name="TR_Details" size="5" property="deepeningEST"  indexed="true" onkeypress="return decimalsOnly(event)" /> 
	</td>
							
					
					<td class="rptValue" align=center><html:text name="TR_Details" size="5" property="deepenOwNum"  indexed="true"  onkeypress="return integersOnly(this)" /> </td>
					<td class="rptValue" align=center><html:text name="TR_Details" size="5" property="deepenOwEst"  indexed="true"  onkeypress="return decimalsOnly(event)" /></td>
				<td class="rptValue" align=center><html:text name="TR_Details" size="5" property="sstNum"  indexed="true"  onkeypress="return integersOnly(this)" /> </td>
					<td class="rptValue" align=center><html:text name="TR_Details" size="5" property="sstEst"  indexed="true"  onkeypress="return decimalsOnly(event)" /></td>

<td class="rptValue" align=center>



  
	<html:select name="TR_Details"  property="sstScheme" styleClass="mycombo" indexed="true"  style="width:90px">
						<html:option value="">Select</html:option>
							<html:option value="PWS">PWS</html:option>
							<html:option value="CPWS">CPWS</html:option>
							<html:option value="MPWS">MPWS</html:option>
							
							
				</html:select>
</td>


	<td class="rptValue" align=center >  <html:text name="TR_Details"  style="width:190px" property="remarks"  indexed="true" />	
	</td>	
					<td class="rptValue" >
							<html:select  name="TR_Details"  property="typeOfWork"  style="width:110px" indexed="true"  onchange='<%= "ValidateCategory("+(count-2)+","+2+")"%>'>
							<html:option value="">Select</html:option>
							<html:option value="AUG">AUG</html:option>
							<html:option value="EXTN">EXTN</html:option>
							<html:option value="PWS">PWS</html:option>
							<html:option value="CPWS">CPWS</html:option>
							<html:option value="OTHERS">OTHERS</html:option>
							
							</html:select>
							
							
						</td>
						
					<td class="rptValue" align=center width="70">  <html:text name="TR_Details" size="5" property="workESTCOST"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>

	<td class="rptValue" align=center>
				<html:select name="TR_Details"  property="powerProblem" styleClass="mycombo" indexed="true"  style="width:80px">
				<html:option value="N"><font class="myfontclr1">NO</html:option>
		<html:option value="Y"><font class="myfontclr1">YES</html:option>
				</html:select>
						</td>



					
				
					<td class="rptValue" width="100" align=center>  <html:text name="TR_Details" size="5" property="powerProblemEST"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
			

					
	</tr>
	</nested:iterate>
	
	<%}%>
   
 <tr align=center>
	<td align="center" >
		<input type="hidden" name="resultCount" value="<%=count%>">
	
	</td>
    </tr>
	


</table> 
</div>

<table align="center">
<tr  >
<td>
<input type="button"  name="Save"   value="Save" onclick="fnSave();">
</td>
</tr>
</table>


	   
	
<input type=hidden name=hab1>
</html:form>
</html:html>

<p align="center">

<%@ include file="/commons/rws_footer.jsp"%>
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
</script>