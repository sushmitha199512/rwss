<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@page import="nic.watersoft.commons.Debug"%>
<%@page import="nic.watersoft.works.rws_works_WorkStatus_form"%>
<%// System.out.println("sdhggfdsgkjdhg"); %>
<html:html>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/slidebox.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/Tooltip1.js'/>"></script>
<script language="javaScript">
function showHideDiv(id)
{
	if(document.getElementById(id).style.display=='block')
	{
		document.getElementById(id).style.display='none';
	}
	else if(document.getElementById(id).style.display=='none')
	{
		document.getElementById(id).style.display='block';
	} 	
}
function office1()
{ 
	// alert("1111");
	document.forms[0].action="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data";
	document.forms[0].submit();
}

function fnDivisionChanged()  
{
	document.forms[0].action="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data";
	document.forms[0].submit();
}
function fnSubdivisionChanged()
{
	document.forms[0].action="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data";
	document.forms[0].submit();
}
function fnSubmit()
{
 if(document.forms[0].circleCode.value=="")
 {
 alert("Please Select Circle");
 }
 else{
 // alert("sssss");

//var ast= document.getElementById("astwork"+index).value;
//var atype=document.getElementById("assettype"+index).value;
 //alert(ast);
 // alert(atype);
  document.forms[0].action="switch.do?prefix=/works&page=/Auglinkmain.do?mode=viewwork";
  document.forms[0].submit();
  }
}
<%// System.out.println("sdhggfdsgkjdhg 11111111111"); %>
function fnAssetwork(index)
{
// alert(index);
var selectbox = "assettype"+index;
 //alert("sssss:"+selectbox);
  //alert("astwork:"+document.getElementById("astwork"+index).value);
 document.getElementById("assettype"+index).options.length=0;
 if(document.getElementById("astwork"+index).value==1)
 {
   // alert("assetype:"+document.getElementById("assettype"+index).value)
   var optn = document.createElement("OPTION");
	optn.text = "SELECT";
	optn.value = "";
	document.getElementById("assettype"+index).options.add(optn);
    var optn = document.createElement("OPTION");
	optn.text = "PWS";
	optn.value = "01";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "MPWS";
	optn.value = "02";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "CPWS";
	optn.value = "03";
	document.getElementById("assettype"+index).options.add(optn);
    var optn = document.createElement("OPTION");
	optn.text = "HAND PUMPS";
	optn.value = "04";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "SHALLOW HANDPUMPS";
	optn.value = "05";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "OPEN WELLS";
	optn.value = "06";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "PONDS";
	optn.value = "07";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "OTHERS";
	optn.value = "08";
	document.getElementById("assettype"+index).options.add(optn);
	var optn = document.createElement("OPTION");
	optn.text = "DIRECT PUMPING";
	optn.value = "09";
	document.getElementById("assettype"+index).options.add(optn);
	
	
}
else if(document.getElementById("astwork"+index).value==2)
{
 var optn = document.createElement("OPTION");
	optn.text = "SELECT";
	optn.value = "";
	document.getElementById("assettype"+index).options.add(optn);
var optn = document.createElement("OPTION");
	optn.text = "PWS";
	optn.value = "01";
	document.getElementById("assettype"+index).options.add(optn);
var optn = document.createElement("OPTION");
	optn.text = "CPWS";
	optn.value = "03";
	document.getElementById("assettype"+index).options.add(optn);
var optn = document.createElement("OPTION");
	optn.text = "HAND PUMPS";
	optn.value = "04";
	document.getElementById("assettype"+index).options.add(optn);
var optn = document.createElement("OPTION");
	optn.text = "OTHERS";
	optn.value = "08";
	document.getElementById("assettype"+index).options.add(optn);

} 
 document.getElementById("assettype"+index).value="";

 
}
function fnbutton1(index)
{
    var width = 650;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
  var astwrk = document.getElementById("astwork"+index).value;
  var asttype = document.getElementById("assettype"+index).value;
  var asts=document.getElementById("assets"+index).value;
 if(astwrk!=null && asttype!=null && astwrk!="" && asttype!="")
 {
  var cir = document.getElementById("circleCode").value;
  var div = document.getElementById("divCode").value;
  var subdiv = document.getElementById("subdivCode").value;
  if(!document.getElementById('check['+index+']').checked)
   {
   alert("Before Click The Button You must select the Check Box with Sl. No:"+index);
   return false;
   }else{ 
 var url ="/pred/works/rws_Asset_Work_Details.jsp?astwrk="+astwrk+"&asttype="+asttype+"&circle="+cir+"&divcode="+div+"&subdiv="+subdiv+"&asts="+asts+"&index="+index; 
 
 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
 newWindow = window.open(url, "_New", properties);
 newWindow.focus();
}
}else 
{
 alert("Please Select Asset/Work and Type of Asset/Work  details");
}

 
}
function fnAssettype(index)
{
 var astwrk = document.getElementById("astwork"+index).value;
 var asttype = document.getElementById("assettype"+index).value;

  var cir = document.getElementById("circleCode").value;
  var div = document.getElementById("divCode").value;
  var subdiv = document.getElementById("subdivCode").value;

  var s="";
  var openRequest = getAjaxRequest();
		openRequest.open("POST","/pred/works/AssetGet.jsp?astwrk="+astwrk+"&asttype="+asttype+"	&circle="+cir+"&divcode="+div+"&subdiv="+subdiv+"&index="+index,false);
		postData=s;
		openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		openRequest.send(postData);
}
function generatePreviewData(form) 
	{
var postData ="mandals="+form.mands.value;
return(postData); 
} 

function getAjaxRequest()
	{
var openRequest;
try {
openRequest = new XMLHttpRequest();
return openRequest;
}
catch (error) {
try {
openRequest = new ActiveXObject("Microsoft.XMLHTTP");
return openRequest;
}
catch (error)
	{
if(isDebugOn)
displayDebugError("Error crea");
	}
	
}
	}
function fnAssets(index,that)
{
	if(!document.getElementById('check['+index+']').checked)
	{
	 alert("Before Select the Asset/Work Deatils You must select the Check Box with Sl. No:"+index);
	 document.getElementById("assets"+index).value="";
	}
	
}

function fnworksave(index)
{
 var checkchoice=0;
 for(var i=1;i<=index;i++)
 {
 if(document.getElementById('check['+i+']').checked)
  {
    checkchoice++;
  }
 }
 if(checkchoice==0)  
 {
 alert("Please Select At least One Checkbox");
 return false;
 }
 else
 {
 document.forms[0].action="switch.do?prefix=/works&page=/Auglinkmain.do?mode=save";
 document.forms[0].submit();  
  
 }
}
function fncheckbox(index)
{
// alert("in check box selection");
if(document.getElementById("astwork"+index).value=="")
{
 alert("Before Select checkbox Please select a asset/work ");
 document.getElementById('check['+index+']').checked=false;
}
else if(document.getElementById("assettype"+index).value=="")
{
 alert("Before Select checkbox Please select a  Asset Type details");
 document.getElementById('check['+index+']').checked=false; 
}
}
</script>
<style>
div.transbox
  {
  margin:30px 50px;
  background-color:#D6DCD9;
  border:1px solid black;
  /* for IE */
  filter:alpha(opacity=140);
  /* CSS3 standard */
  opacity:1.5;
  }
div.transbox p
  {
  margin:30px 40px;
  font-weight:bold;
  color:#000000;
  }
</style>
<body>
<center>

<html:form action="/Auglinkmain.do">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="965" ><tr>
		<tr><td class="mycborder">
		<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value=" Augmentation-MainScheme Linkage"/>
<jsp:param name="TWidth" value="100%"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>
<%// System.out.println("sdhggfdsgkjdhg 55555555555"); %>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="965" ><tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Office Details</legend>
		 <table  border=0  width="100%">
		 <tr><td><font color="#000000" face=verdana size=2><B>Circle <font color="red">*</font></B></font></td>
		<td> <html:select property="circleCode" style="width:135px"   onchange="office1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:present name="circles">
		 <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<%// System.out.println("sdhggfdsgkjdhg 6666666"); %>
<td><font color="#000000" face=verdana size=2><B>Division</B></font></td>
<td><html:select property="divCode" style="width:135px"    styleClass="mycombo" onchange="fnDivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="divisions">
	<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
<%// System.out.println("sdhggfdsgkjdhg 77777777777777"); %>
<td><font color="#000000" face=verdana size=2><B>Sub Division</B></font></td>
<td><html:select property="subDivCode" style="width:135px" styleClass="mycombo" onchange="fnSubdivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="subdivisions">
	<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
<%// System.out.println("sdhggfdsgkjdhg 88888888888888888"); %>
</tr>

</TABLE>
</fieldset> 
</td></tr>
<tr>
<td>
<center>
<%// System.out.println("sdhggfdsgkjdhg 999999999"); %>
<input type="button" value="View Works" name="submit1" class="btext"
		onclick="fnSubmit()">
		</center>
		</td>
		</tr>

<tr>
<td>
<fieldset>
<%// System.out.println("sdhggfdsgkjdhg 9.1"); %>
		<legend>Work Details</legend>
		<label>
			<table width="965" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   <tr>
						<td colspan=10><font face="verdana" size="2" color="red"><b>
							Note*******:Please Click on WORK ID, to View/Hide Lead Habitation Information('-' Represents Lead Habitation Not Selected)
						</b></font></td>
				   </tr>
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>select</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Admin Date</th>
				<!-- <th>Admin No</th> -->
			  	<th>Sanctioned Amount(Rs.in Lakhs)</th>
			  	<th>Asset/Work</th>
			  	<th>Type of Asset/work</th>
			  	<th>Linked to</th>
			  	<th>Linked to Asset/Work Details</th>			 
			</tr>
			</thead>
			<%// System.out.println("sdhggfdsgkjdhg 9.2"); %>
 			<%
 			int sno=0;
 			 %>
 			
 			<%
			String aTypes[] = {"PWS","CPWS","MPWS","HAND PUMPS","SHALLOW HANDPUMPS","OPEN WELLS","PONDS","OTHERS","DIRECT PUMPING"};
			String aTypesCodes[] = {"01","03","02","04","05","06","07","08","09"};
			String aTypes1[] = {"PWS","CPWS","MPWS","HAND PUMPS"};
			String aTypesCodes1[] = {"01","03","02","04"};
 			java.util.ArrayList rows=(java.util.ArrayList)request.getAttribute("rows");
 			
 			int iter = 1;
 			int k =0;
 			if(rows!=null){
 			 //System.out.println("**********************************************************************");
 			 %>
 			 <%// System.out.println("sdhggfdsgkjdhg 9.4"); %>
 			<nested:iterate id="list_d" property="rows" indexId="ndx">
 			<% // // System.out.println("ssssssssss");%>
			<tr bgcolor="#ffffff">
				<td class="rptValue"><font face="verdana" size="2"><%=++sno%></font>
				</td>
				<td class="rptValue"><font face="verdana" size="2">
				<input type=checkbox name="check[<%=sno%>]" onclick="fncheckbox(<%=sno%>)" value='<nested:write name="list_d" property="workId" />'  >
					
				</td>
				<td class="rptValue"  onclick="showHideDiv('details<%=iter%>');"><!--  onmouseout="document.getElementById('details<%=iter%>').style.display='none'"-->
				<font face="verdana" size="2" >
				<nested:write name="list_d" property="workId"/></font>
					<div id="details<%=iter++%>" class="transbox" style="left: 150;position: absolute;display:none;">
						<table>
							<tr>
								<td><font face="verdana" size="2"><b>Mandal:</b></td>
								<td><font face="verdana" size="2" color="blue"><b><nested:write name="list_d" property="mandalName"/></font></b></td>
							</tr>
							<tr>
								<td><font face="verdana" size="2"><b>Panchayat:</b></td>
								<td><font face="verdana" size="2" color="blue"><b><nested:write name="list_d" property="mandal"/></font></b></td>
							</tr>
							<tr>
								<td><font face="verdana" size="2"><b>Habitation:</b></td>
								<td><font face="verdana" size="2" color="blue"><b><nested:write name="list_d" property="habName"/></font></b></td>
							</tr>
						</table>
					</div>
				</td>
				<td class="rptValue" >
				<nested:write name="list_d" property="workName"/>
				</td>
				<td class="rptValue"><font face="verdana" size="2">
				<nested:write name="list_d" property="adminDate" />
				</td>

				<td class="rptValue"><font face="verdana" size="2">
				<nested:write name="list_d" property="samount" />
				</td>
				
				<td class="rptValue">
				<select name="astwork<%=sno%>" onchange="fnAssetwork(<%=sno %>)" style="width:75px"  styleClass="mycombo">
				<option value="">SELECT...</option>
		    	
			<%
			//// System.out.println("pwss:"+ast);
			//for(int i=0;i<rows.size();i++)
			//{
				rws_works_WorkStatus_form works1 = (rws_works_WorkStatus_form)rows.get(k++);
				//String val = works.getAstwork().toString();
				// System.out.println("HI:"+works1.getAstwork().size());
				//  System.out.println("HIIII:"+works1.getAssettype().size());
				if(works1.getAstwork().size() >0)
				{
					// System.out.println("1:"+works1.getAstwork().get(0));
					// // System.out.println("2:"+works1.getAssettype().get(0));
					}
				if(works1.getAstwork().size() >0 && works1.getAstwork().get(0).equals("ASSET")) {
				%>
				<option value="1" selected><%=works1.getAstwork().get(0)%></option>
				<option value="2">WORK</option>
				<%
				}
				else if(works1.getAstwork().size() >0  && works1.getAstwork().get(0).equals("WORK")) {
				%>
				<option value="1">ASSET</option>
				<option value="2" selected><%=works1.getAstwork().get(0)%></option>
				<%
				}
				else if(works1.getAstwork().size() == 0 ) {
				// System.out.println("11111111");%>
				<option value="1">ASSET</option>
				<option value="2">WORK</option>
				<%
				//System.out.println("22222222");
				}
			//}
			%>
				</select></td>
				
				<td class="rptValue">
				<select name="assettype<%=sno%>"  style="width:75px"  styleClass="mycombo">
				<option value="">SELECT...</option>
				<%
				if(works1.getAstwork().size() >0 && works1.getAstwork().get(0).equals("ASSET")) {
					for(int i=0;i<aTypes.length;i++)
					{
						
						if(works1.getAssettype().size() >0 && works1.getAssettype().get(0).equals(aTypes[i])) {
						%>
						<option value="<%=aTypesCodes[i]%>" selected><%=works1.getAssettype().get(0)%></option>
						<%
						}
						else if(works1.getAssettype().size() > 0 && !works1.getAssettype().get(0).equals(aTypes[i])) {
						%>
						<option value="<%=aTypesCodes[i]%>"><%=aTypes[i]%></option>
						<%
						}
					}
				}
				else if(works1.getAstwork().size() >0  && works1.getAstwork().get(0).equals("WORK"))
				{
					for(int i=0;i<aTypes1.length;i++)
					{
						
						if(works1.getAssettype().size() >0 && works1.getAssettype().get(0).equals(aTypes1[i])) {
						%>
						<option value="<%=aTypesCodes1[i]%>" selected><%=works1.getAssettype().get(0)%></option>
						<%
						}
						else if(works1.getAssettype().size() > 0 && !works1.getAssettype().get(0).equals(aTypes1[i])) {
						%>
						<option value="<%=aTypesCodes1[i]%>"><%=aTypes1[i]%></option>
						<%
						}
					}
				}
			%>
				</select>
				</td>
				<td class="rptValue"><input type=button name="button1" title="Save the Fields"  Class="btext" value="..." onclick="fnbutton1(<%=sno%>)"/>
				</td>
				
				<td class="rptValue"><input type="text" name="assets<%=sno%>" size="50" readonly=true
				<%//System.out.println("size:"+works1.getAssets().size());
				if(works1.getAssets().size() >0) {
				// System.out.println(" value:"+works1.getAssets().get(0));
				
					//if(works1.getAssets().get(0).substring(0,14)!=null && !works1.getAssets().get(0).substring(0,14).equals(""))
				%> value="<%=works1.getAssets().get(0)%>" /><% } %>
				</td>
				</tr>
			</nested:iterate>
			 </tbody>
			 </table>
			 	</label></fieldset>
			 <tr>
			<td align="center">
			<input type=button name="savework<%=sno%>" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave(<%=sno%>)"/>
		</td>
			<input type="hidden" name="resultCount" value="<%=sno%>"> 
		
			
			</tr>	
			
 			
 			 <%}else{%>
 			 <tr bgcolor="#ffffff">
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			  </tbody>
		  
			</table>
			
			</label></fieldset>
 			 <%} %>
		</td>
		</tr>
		
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
	<jsp:param name="Tborder" value="0"/>
</jsp:include>
</td>
</tr>
</table>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/commons/rws_alert.jsp" %>
</html:form>
</center></body>
</html:html>