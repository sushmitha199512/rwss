<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


<script type="text/javascript" src="/pred12022015/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred12022015/resources/style/demos.css" type="text/css">
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}



function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
////for sources/////////


function opensourcewindow(assetcode)
{
	//alert(1);
	
	var zURL = "./switch.do?prefix=/masters&page=/HabiYield.do&mode=sources1&assetcode="+assetcode;
	var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}




///////////////
function openExpVoucher(assetcode)
{
	//alert(1);
	var zURL = "./switch.do?prefix=/masters&page=/HabiYield.do&mode=assethabs&assetcode="+assetcode;
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs1',popFeatures);
	myWin.focus();	
}

function openHabView(assetcode)
{
	//alert(1);
	
	var zURL = "./switch.do?prefix=/masters&page=/HabiYield.do&mode=habsinassets&assetcode="+assetcode;
	//alert("zURL"+zURL);
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs1',popFeatures);
	myWin.focus();	
}



</script>
<body>
<form  action="HabiYield.do"> 
<table width="100%" >
<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</a>
 <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>


</tr>
</table>

<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Entry Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Sl. No.</FONT></TD> 
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset Code</FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Scheme Code</FONT></TD>
    <td><FONT class=myfontclr><font color="#993366">Asset Name</font></FONT></td>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Panchayat</FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.village" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Lead Habitation</FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.location" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetStatus" /></FONT></TD>
	
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCost" /></FONT></TD>
   
	</tr>
	<% int count=0; %>
	

	<%if(((java.util.ArrayList)session.getAttribute("habs")).size()>0){
	
	System.out.println("anuuu"+((java.util.ArrayList)session.getAttribute("habs")).size());
	%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	<%=session.getAttribute("message")%>
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="habs">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
	        <td  class=mycborder1 align=center nowrap>
			<FONT class=myfontclr1 ><bean:write name="assetlist" property="assetcode" />
			<input type=button name="button1" title="sources"  Class="btext" value="&nbsp...&nbsp;" style="width: 50px" onmouseover="Tip(this.value,TITLE,'List Of Sources')"  onmouseout="UnTip()" onclick="opensourcewindow('<bean:write name="assetlist" property="assetcode"/>')"/></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemecode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName1"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location1" /></FONT>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			
		   <td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetcost" /></FONT>
			</td>
			
			<td class=rptValue><input type=button name="button1" title="Habs"  Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;" onmouseover="Tip(this.value,TITLE,'Asset Related Habitations')"  onmouseout="UnTip()" onclick="openHabView('<bean:write name="assetlist" property="assetcode"/>')"/></td> 
			
		
			
			</tr>
	</logic:iterate>
	

</table>
 
</td>
</tr>
</form>
</body>
 <%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>