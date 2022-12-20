<%@ include file="/commons/rws_header1.jsp" %>
 
<script>
function fnPickHabitations()
{
    var	newWindow;
    var sourceCode='<%=request.getParameter("sourceCode")%>';
    var noOfHab='<%=request.getParameter("noOfHab")%>';
	 
	 
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

 	 var url = "switch.do?prefix=/masters&page=/Source.do&mode=disphab&noOfHab="+noOfHab
			   + "&sourceCode="+sourceCode;
	      var properties = "width=400,height=260,left=470,top=20,toolbar=no,"
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

</script>


<html:form action="Source.do?mode=edit" >


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  >
<tr class="gridHeader">
<td colspan=3 align="left"><font size="2">Source Details</font></td>
</tr>
<tr>
<td>
<table  border=0  align=center  >
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Source Type</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceTypeCode"  styleClass="mytext" style="width:125"   readonly="true"/>
		</td>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr>Sub Source Type</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="subSourceTypeCode"  styleClass="mytext" style="width:125"  readonly="true"/>
		</td>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr><bean:message key="app.sourceCode" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceCode" value="<%=(String)request.getAttribute(\"scode\")%>" styleClass="mytext" style="width:70px" maxlength="3" readonly="true" />
		</td>
				
		</tr>
		<tr>
		<td  class=mycborder nowrap >
		<FONT class=myfontclr>Source Name</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceName"  styleClass="mytext" style="width:135" maxlength="25" onkeypress="upperOnly()" readonly="true"/>
		</td>
		<td  class=mycborder  >
		<FONT class=myfontclr>Location</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="location"   
						styleClass="mytext" style="width:135" maxlength="25" onkeypress="upperOnly()" readonly="true"/>
		</td>
		<td  class=mycborder  >
		<FONT class=myfontclr><bean:message key="app.noOfHab" /></FONT>&nbsp;&nbsp;
		</td><td class=mycborder><html:text property="noOfHab"  style="width:70px" styleClass="mytext" maxlength="2" readonly="true" />&nbsp;&nbsp;
		<html:button property="addHab" value="..." styleClass="btext" title="Click Here"
								 onclick="javascript:fnPickHabitations()"/>
								 
		</td>
		</tr>
		<tr>
		<%//System.out.println("habCode="+request.getParameter("habCode")); %>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.popbenefited"  /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="popbenefited"  styleClass="mytext" style="width:50px" maxlength="5" readonly="true"/>
		</td>
		</tr>
		</table>
		<hr>
		<table  border=0    align=center  >
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.seasonal" /></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="seasonal" styleClass="mycombo"   >
		<html:option value="">SELECT...</html:option>
		<html:option value="Y">YES</html:option>
		<html:option value="N">NO</html:option>
		</html:select>
		</td>
		<td  class=mycborder  >
		<FONT class=myfontclr><bean:message key="app.presentCondition" /></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="presentCondition" styleClass="mycombo" style="width:123px"  >
		<html:option value="">SELECT...</html:option>
		<html:option value="W">WORKING</html:option>
		<html:option value="N">NOT WORKING</html:option>
		<html:option value="D">DRIED</html:option>
		</html:select>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Water Quality</FONT>
		</td>
		<td  class=mycborder >
		<html:select property="waterQuality" style="width:110px" styleClass="mycombo" onchange="EnableFields()"  >
		<html:option value="">SELECT...</html:option>
		<html:option value="SS">Safe Source</html:option>
		<html:option value="NSS">NSS</html:option>
		</html:select>
		</td>
		</tr>
		<tr>
		<td  ><FONT class=myfontclr nowrap>Static Water Level</FONT></td>
				<td class=mycborder>
					<html:text property="staticWaterLevel" style="width:60px" 
						 
						onkeypress="return decimalsOnly(event)" readonly="true"/>&nbsp;<FONT class=myfontclr>(lpcd)</FONT>
				</td>
			 
				<td ><FONT class=myfontclr nowrap>Summer Water Level</FONT></td>
				<td class=mycborder> 
					<html:text property="summerWaterLevel" style="width:60px" 
						 
						onkeypress="return decimalsOnly(event)" readonly="true"/>&nbsp;<FONT class=myfontclr>(lpcd)</FONT>
				</td>
				<td><FONT class=myfontclr>Yield</FONT></td>
				<td class=mycborder>
					<html:text property="yield" style="width:90px" 
						 
						onkeypress="return decimalsOnly(event)" readonly="true"/>&nbsp;<FONT class=myfontclr>(lpm)</FONT>
				</td>
			</tr>
			<tr>
			<td width="100" class=mycborder ><FONT class=myfontclr>Distance From Nearest<br>Water Source</FONT></td>
			<td width="150">
				<html:text property="distFromSource" style="width:60px" 
					onkeypress="return decimalsOnly(event)" readonly="true"/>&nbsp;<FONT class=myfontclr>(kms)</FONT>
				</td>
		   </tr>
		
		</table>
		 </tr>
		 <tr>
	<td  align="center">
	<html:button title="Close" styleClass="btext" property="Close" value="Close" onclick="window.close()" />
  	</td>
 </tr>
 <tr class="gridHeader" >
<td colspan=3>&nbsp;</td>
 </tr>
</table> 

</html:form>
<logic:notEmpty name="assetSrcs">
<table bgcolor="#DEE3E0" border="1" bordercolor="black"  align="center" width="400"  cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr  bgcolor="#8A9FCD">
<td  colspan="2" align="left"><B><font size="2">Assets in Source</font></B></td>
</tr>
<tr  bgcolor="#8A9FCD">
	<td   align=center>
	  <bean:message key="app.assetCode" /></td>
	 <td   align=center>
	   <bean:message key="app.assetName" /></td>
</tr>
</thead>
<tbody class="label">
<%int count=1;%>
<logic:iterate id="assetsrclist" name="assetSrcs">
<tr class="row<%=count%2%>">
<% count=count+1; %>
<td align=center>
 <bean:write name="assetsrclist" property="assetCode" /> 
</td>
<td  aign=left>
<bean:write name="assetsrclist" property="assetName" /> 
</td>
</tr>
</logic:iterate>
</tbody>
</table>
 </logic:notEmpty>
</td>
</tr>
 


