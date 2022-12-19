<%@page import="nic.watersoft.masters.RwsMaster"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html:javascript formName="sourceForm" />
<%System.out.println("inside source list"); %>
<script language="JavaScript">
function viewWorks(URL)
{
	alert(URL);
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function openEditWindow(url)
{

	 var width = 770;
	 var height = 400;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	// alert(url);
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function openDeleteWindow(url)
{
	//alert(url);
	 var width = 10;
	 var height = 10;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}

function fnPickHabitations(sourceCode,noOfHab)
{

	var	newWindow;
    
     var width = 600;
	 var height = 200;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

 	 var url = "switch.do?prefix=/masters&page=/Source.do&mode=disphab&noOfHab="+noOfHab
			   + "&sourceCode="+sourceCode;
	      var properties = "width=400,height=260,left=210,top=210,toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
   	 
}
//bhagya
function openFile(sourceno){
	 var assetcode = "<%=request.getParameter("assetCode")%>";
	   var habcode = "<%=request.getParameter("habCode")%>"
 	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	   var pumCode ="<%=request.getParameter("PumpCode")%>"; 
		var url="switch.do?prefix=/masters&page=/Asset.do?mode=showCompImage&sourceid="+sourceno+"&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&habCode="+habcode+"&assetCode="+assetcode+"&PumpCode="+pumCode;
		//alert(url);
		var width = 990;
		var height = 450;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=yes,status=yes,left=20,top=20";

		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
		
		
	}

</script>
 
<table width="100%">
<tr><td align=right><a href="#1" onclick="javascript:history.back()">Back&nbsp;|&nbsp;</a>
<!-- <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a> -->
<!-- <html:link page="/rws_Source_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link> -->

<html:link page="/rws_Source_xls.jsp" target="_blank">Excel</html:link>
</tr>
</table>
<table    bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse">
<tr bgcolor="#8A9FCD"><td class=myfontclr colspan=15><B><font color="#FFFFFF">Source Entry Form</font></B></td><td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
<tr >
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">S.No</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Source Code</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.source" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Habitation</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.location" /></FONT></td>
		
		<!-- <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.noOfHab" /></FONT>
		</td> 
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.popbenefited" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.seasonal" /></FONT></td>-->
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Depth</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Yield</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Source Codition</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Water Quality</FONT></td>
		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Image</FONT></td>
		
		<!-- added by swapna on 19-01-2012 for gis dat entry-->
		<td  class=mycborder align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Latitude-N</FONT></td>
<td  class=mycborder align=center nowrap >
		<FONT class=myfontclr><font color="#993366">Longitude-E</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Elevation</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">WayPoint</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Type of Treatment</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Plant Capacity (units MLD)</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>
		</tr>
<%if(session.getAttribute("sources")!=null && ((java.util.ArrayList)session.getAttribute("sources")).size()!=0)
{ 
	//System.out.println("after row data in source"+(java.util.ArrayList)session.getAttribute("sources").size());
int count=0;
%>
<logic:iterate id="sourcelist" name="sources">
<%count++; %>
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=count %></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceCode" /></FONT>
</td>
<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceTypeName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="sourcelist" property="subSourceTypeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="habName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="location" /></FONT>
</td>

<!-- <td  class=mycborder1 align=center>
 
<FONT class=myfontclr1><bean:write name="sourcelist" property="noOfHab" /></font>
<input type="button" value="..." style="width:20px;height:18px" class="btext"  onclick="fnPickHabitations('<bean:write name='sourcelist' property='sourceCode' />','<bean:write name="sourcelist" property="noOfHab" />')">
&nbsp;&nbsp;
</td>
<td  class=mycborder1 align=right>
<FONT class=myfontclr1><bean:write name="sourcelist" property="popbenefited" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="seasonal" /></FONT>
</td> -->
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceDepth" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="yield" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="presentCondition" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="waterQuality" /></FONT>
</td>
<!-- bhagya -->
<td  align=center >
			<logic:equal name="sourcelist"  property="imageStatus"  value="Yes" >
				<a href="#" onclick="openFile('<bean:write name="sourcelist" property="sourceCode"/>')">View</a>&nbsp;
			</logic:equal> 
			<logic:notEqual name="sourcelist"  property="imageStatus"  value="Yes" >
				<p styleClass="gridText" style="width:100px">Image not Exist</p>
			</logic:notEqual> 
		</td>

<!-- added by swapna on 19-01-2012 for gis data entry -->
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="latitude" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="longitude" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="elevation" /></FONT>
</td><td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="waypoint" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="typeofTreatment" /></FONT>
</td><td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="plantCapacity" /></FONT>
</td>
<logic:notEqual name="sourcelist"  property="sourceExist"  value="true">
<td class=mycborder1 align=center nowrap><a href="#1" onclick=openEditWindow('switch.do?prefix=/masters&page=/Source.do&sourceCode=<bean:write name='sourcelist' property='sourceCode' />&habCode=<bean:write name='sourcelist' property='habCode' />&noOfHab=<bean:write name='sourcelist' property='noOfHab' />&mode=get&sourceTypeCode=<bean:write name='sourcelist' property='sourceTypeCode' />&subSourceTypeCode=<bean:write name='sourcelist' property='subSourceTypeCode' />&wquality=<bean:write name="sourcelist" property="waterQuality" />')><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;<a href="#1" onclick=openDeleteWindow('switch.do?prefix=/masters&page=/Source.do&sourceCode=<bean:write name='sourcelist' property='sourceCode' />&mode=delete&assetTypeCode=<bean:write name='sourcelist' property='assetTypeCode' />&sourceTypeCode=<bean:write name='sourcelist' property='sourceTypeCode' />&wquality=<bean:write name="sourcelist" property="waterQuality" />')><font color="#990066">Delete</font></a>
</logic:notEqual>
<logic:equal name="sourcelist"  property="sourceExist"  value="true">
<td class=mycborder1 align=center><font class=myfontclr1 ><font color="#990066">   Note: This Source is Exist in another Asset </font></font>    </td>
</logic:equal>
<%-- <% String sourceCode = ((RwsMaster) pageContext.findAttribute("sourcelist")).getSourceCode();
System.out.println("sourceCode is@@@@@@@@@@@"+sourceCode);
Rws_Asset_Source_Image image=new Rws_Asset_Source_Image();
String imageStatus=image.getImageExist(sourceCode);
System.out.println("status"+imageStatus);
if(imageStatus.equals("Exist")){
%>
<a href="#1" onclick=openEditWindow('./masters/rws_show_source_Image.jsp?sourceCode=<%=sourceCode%>')><font color="#6600CC">&nbsp;|View Image</font></a>

<%} %> --%>
</td>

</tr>
</logic:iterate>
<%} 
else{%>
<tr><td colspan="15" align="center">No Records</td></tr>
<%} %>
</table>
<P align="left">
<font face=verdana size=2 color=red>Note:</font><font face=verdana size=2>You cannot change the Source Habitation through EDIT</font>
</p>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

