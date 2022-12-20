<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">

function fnSave(){
	//alert(1);

	var length= document.getElementById("resultCount").value;
	//alert("length"+length);
	document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	document.forms[0].elements['sBtn'].disabled=true;
	length=length-1;
	var flag=false;
	for(var k=0;k<length;k++)
	{		
	if(document.forms[0].elements["habs["+k+"].checks"].checked)
	 {
	
		flag=true;
		//alert(1);
		var  source=document.forms[0].elements["habs["+k+"].sourceCode"].value;
		var lat=document.forms[0].elements["habs["+k+"].latitude"].value;
        var safe = document.forms[0].elements["habs["+k+"].safelpcd"].value;	
        var unsafe = document.forms[0].elements["habs["+k+"].unsafelpcd"].value;
    var assetcode=document.forms[0].elements["habs["+k+"].assetcode"].value;
 
	}	//end if

	}//for loop
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
		 return;
	}
	else{
		//document.forms[0].action="/pred12022015/masters/rws_source_yield_cpws_update.jsp?prefix=/masters&page=/HabiYield.do&mode=savesources";	
	   
	   document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=savesources&source="+source+"&safe="+safe;	
		//alert("document.forms[0].action"+document.forms[0].action);
		document.forms[0].submit();

	}
	
}


function openExpVoucher(sourceCode)
{
	
		
		var zURL = "./switch.do?prefix=/masters&page=/HabiYield.do&mode=assethabs&sourcecode="+sourceCode;
		
		var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs1',popFeatures);
		myWin.focus();

	
	
	
	
		
}


</script>




<body>
<form  action="HabiYield.do" method="post"> 
<table width="100%" >
<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</a>
 <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>

</tr>
</table>

<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Sources</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >

	
<tr >
	
    <td class="btext" align="center">Sl. No.</TD> 
	<td class="btext" align="center">Source Code</TD>
<td class="btext" align="center">AssetCode</TD>
   <td class="btext" align="center">Habitation Linkage</TD>
    <td class="btext" align="center">Status</TD>
	<td class="btext" align="center">Safe Yield(LPD)</TD>
    <td class="btext" align="center">UnSafe Yield(LPD)</TD>
	
	 <td class="btext" align="center">Latitude</TD>
	
	 <td class="btext" align="center">Longitude</TD>
	<td class="btext" align="center">Elevation</TD>
	
	 <td class="btext" align="center">Flouride</TD>
	
	 <td class="btext" align="center">Brakish</TD>
	<td class="btext" align="center">Iron</TD>
	
	<td class="btext" align="center">Nitrate</TD>
	<td class="btext" align="center">Select</td>
	
	</tr>
	<% int count=1; %>
	

	<%if(((java.util.ArrayList)session.getAttribute("habs")).size()>0){
	
	System.out.println("anuuu"+((java.util.ArrayList)session.getAttribute("habs")).size());
	%>
	<tr>
	<td colspan="13"  class=myfontclr><B><font color="red">
	CPWS Sources
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="habs" name="habs"  indexId="index">
	
	
			<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		    <td class="rptValue"><%=count++%></td>
	        <td  class=mycborder1 align=center >
			<FONT class=myfontclr1 ><bean:write name="habs" property="sourceCode"/></FONT>
			
			<html:hidden name="habs" property="sourceCode"  indexed="true" />
			</td>
			
			<td  class=mycborder1 align=center >
			<FONT class=myfontclr1 ><bean:write name="habs" property="assetcode"/></FONT>
			
			<html:hidden name="habs" property="assetcode"  indexed="true" />
			</td>
			
			
		<!-- 	<td  class=mycborder1 align=center>
			<FONT class=myfontclr1 ><bean:write name="habs" property="habitation" /></FONT>
			</td>-->
			
			<td class=rptValue><input type=button name="button1" title="Habs"  Class="btext" value="&nbsp;...&nbsp;"  style="width: 50px" onmouseover="Tip(this.value,TITLE,'Add Habs')"  onmouseout="UnTip()" onclick="openExpVoucher('<bean:write name="habs" property="sourceCode"/>')"/></td>
			
			
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1 ><bean:write name="habs" property="coveragestatus" /></FONT>
			</td>
			
		<td><html:text name="habs" property="safelpcd"  indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>' maxlength="7" size="4" /></td>
		<td>
		<html:text name="habs" property="unsafelpcd" indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>'  maxlength="7" size="4"/> </td>
		
	
				
		<td>
				<html:text name="habs" property="latitude" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>	
		</td>
		
		<td>			
				<html:text name="habs" property="longitude" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>			
		</td>
				
		<td>			
				<html:text name="habs" property="elevation" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>			
		</td>
			
			
			<td class="rptValue">
			<html:text property="flouride" name="habs" indexed="true" onkeypress="return decimalsOnly(event)"  onblur='<%="return validateFl("+(count-2)+")"%>' maxlength="4" size="4"></html:text>
			
			
		</td>
		<td class="rptValue">
			<html:text property="brakish" name="habs" indexed="true" onkeypress="return numeralsOnly(event)" onblur='<%="return validateBr("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		
	
		
		</td>
		<td class="rptValue">
			<html:text property="iron" name="habs" indexed="true" onkeypress="return decimalsOnly(event)" onblur='<%="return validateIr("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		
	
		
		</td>
		<td class="rptValue">
			<html:text property="nitrate" name="habs" indexed="true" onkeypress="return numeralsOnly(event)" onblur='<%="return validateNit("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		
		
		</td>
		<td>			
			<html:checkbox name="habs" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' />
		</td>	
			</tr>
	</logic:iterate>
	
	<%if(count==1)
		{
		%><tr><td colspan="20" align="center" class="btext">No Records</td></tr><%}
		else{%>
		<!-- <tr><td colspan="20" align="center"><input type=submit value=Save id="sBtn" onClick="fnSave();" class="btext" disabled="disabled"></td></tr> -->
		<tr><td colspan="20" align="center"><input type=submit value=Save id="sBtn" onClick="fnSave();" class="btext" ></td></tr>
		<%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	
	

</table>
 
</td>
</tr>
</form>
</body>
 <%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>