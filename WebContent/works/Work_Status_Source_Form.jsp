		<tr class="textborder">
		<td>
		<fieldset>
        <legend><font color=#871D0E face=verdana size=2><b>Source Identification</b></font></legend>
        <label>
		<table>
 	    <tr class="textborder">
 	    <logic:present name="mandalCode">
 	    <td><font face=verdana size=2><b>Mandal</b></td>
 	    <td ><html:select property="mandalCode" style="width:183px" styleClass="mycombo"  onchange="getFormmandal()">
			<html:option value="">Please Select...</html:option>
			 <html:options collection="mandalCode" name="mandalCodes" property="mandalCode" labelProperty="mandalName" />
			</html:select>
		</td>
		</logic:present>
		<logic:notPresent name="mandalCode">
		<td ><font face=verdana size=2><b>Mandal</b></td>
		<td ><html:select property="mandalCode" style="width:183px" styleClass="mycombo" onchange="getFormmandal()">
			<html:option value="">Please Select...</html:option>
			</html:select>
			
		</td>
		</logic:notPresent>
 	    <tr class="textborder">
		<logic:present name="siteHab1">
		<td ><font face=verdana size=2><b>Source Habitation</b><font color="#FF6666">*</font></td>
		<td colspan="3"><html:select property="sitehab" style="width:503px" styleClass="mycombo"  onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="siteHab1" name="sitehabs" property="panchCode" labelProperty="habName" /> 
			</html:select>
		</td>
		</logic:present>
		<logic:notPresent name="siteHab1">
		<td ><font face=verdana size=2><b>Source Habitation</b><font color="#FF6666">*</font></td>
		<td colspan="3"><html:select property="sitehab" style="width:503px" styleClass="mycombo" onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
			</html:select>
		</td>
		</logic:notPresent>
	  	 </tr>
		<tr class="textborder">
		<td><font face=verdana size=2><b>Source Type</b><font color="#FF6666">*</font></td>
			<td width="150">
			<html:select property="subcompType" style="width:183px"  styleClass="mycombo"  onchange="getFormSrctype()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="scTypes">
			<html:options collection="scTypes" name="scType" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
		<td><font face=verdana size=2><b>Sub Source Type</b><font color="#FF6666">*</font></td>
			<td width="150">
			<html:select property="subSourceType" style="width:183px"  styleClass="mycombo"  onchange="getFormSubSource()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="subSources">
			<html:options collection="subSources" name="subSource" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
		</tr>
	  	 <tr class="textborder">
	  	 	<td>&nbsp;</td>
		  <td><html:radio property="spradgroup"  value="existSrc" onclick="getForm()"/><font face=verdana size=2><b>Existing Source</b></td>
 			 <td ><html:radio property="spradgroup"  value="newSrc" onclick="getForm()" style="size:3px"/><font face=verdana size=2><b>New Source</td>
	  	 	<td>&nbsp;</td>
 	       </tr>
    <%
	     String r=(String)request.getAttribute("spradgroup");
	     if (r==null){r="";}
	     if (r=="" || r.equals("data"))
		{
		%>
	 	<tr class="textborder">
	 	<td ><font face=verdana size=2><b>Source</b><font color="#FF6666">*</font></td>
			<td width="150"><html:select property="srcCode" style="width:270px" styleClass="mycombo" onchange="setSourceName()" >
		<html:option value="">Please Select...</html:option>
		<logic:present name="srcCodes">
			<html:options collection="srcCodes" name="sourceCode" property="sourceCode" labelProperty="sourceCode"/> 
			</logic:present>	</html:select>
		
			<td ><font face=verdana size=2><b>Source Name</b><font color="#FF6666">*</font></td>
			<td width="160"><html:text property="srcName" readonly="true"/></td>
		</tr>
			<%
			}
			else if (r.equals("existSrc"))
			{
		%>
	 	<tr class="textborder">
	 	<td ><font face=verdana size=2><b>Source</b><font color="#FF6666">*</font></td>
			<td width="150"><html:select property="srcCode" style="width:270px" styleClass="mycombo" onchange="setSourceName()" >
		<html:option value="">Please Select...</html:option>
		<logic:present name="srcCodes">
			<html:options collection="srcCodes" name="sourceCode" property="sourceCode" labelProperty="sourceCode" /> 
			</logic:present></html:select>
			<td ><font face=verdana size=2><b>Source Name</b><font color="#FF6666">*</font></td>
			<td width="160"><html:text property="srcName" readonly="true"/></td>
		</tr>
		<%
		}
		else if (r.equals("newSrc"))
		{
		%>
		<tr class="textborder">
			<td width="180"><font face=verdana size=2><b>Source Code</b><font color="#FF6666">*</font></td>
			<td width="160"><html:text property="newsrcCode" readonly="true"  style="width:270px"/></td>
			<%
			String acode = (String)request.getAttribute("assetCodee");
			if(!acode.equals("04")){ %>
			<td ><font face=verdana size=2><b>Source Name</b><font color="#FF6666">*</font></td>
			<%}else if(acode.equals("04")){ %>
			<td ><font face=verdana size=2><b>Location Name</b><font color="#FF6666">*</font></td>
			<%} %>
			<td width="160"><html:text property="newsrcName"   /></td>
	 	</tr>
			<%
			}
		%>
		<tr class="textborder">
			<td width="180"><font face=verdana size=2><b>Site/Source Identified By</b></td>
			<td width="160"><html:text property="srcIdby" maxlength="25"/></td>
	 		<td width="180" ><font face=verdana size=2><b>Source Site Handing Over Date</b></td>
			<td width="200"><html:text property="siteHODate"  readonly="true"/>
			<a href="javascript: showCalendar(document.forms[0].siteHODate);"><img src="/pred/resources/images/calendar.gif" border="0" align="absmiddle"></a></td>
		</tr>
		<tr class="textborder">
			<td ><b>Recommendations By<B><br> Geologist</b></td><td colspan="2" ><html:textarea property="recommend"  style="height:100px" /></td>
		</tr>
		<%
		System.out.println("session.getAttribute:"+session.getAttribute("tsStatus"));
		if(physicalStatuss.equals("Financially Completed") || physicalStatuss.equals("Commissioned") || physicalStatuss.equals("Completed") || !workCancelleddDate.equals(""))
        {
			if(userid.equals("admin") || userid.equals("100000"))
			{
				%>
					<tr>
						<td align=center colspan=4>
						<html:hidden property="revflag" />
						<html:hidden property="revdel"/>
						<input type=button value=Save onclick="sinsertForSourceIdentification()" class="bText"/>
						<input type=button value=Delete onclick="sfndelete()" class="bText"/>
						</td>
					</tr>
		<%
			}
			else
			{
				%>
				<tr>
					<td align=center colspan=4>
					<html:hidden property="revflag" />
					<html:hidden property="revdel"/>
					<input type=button value=Save onclick="sinsertForSourceIdentification()" class="bText"/><!-- Here unfreezed temporarily -->
					<input type=button value=Delete onclick="sfndelete()" class="bText"  disabled="true"/>
					</td>
				</tr>
		<%
			}
        }
        else{%>
				<tr>
					<td align=center colspan=4>
					<html:hidden property="revflag" />
					<html:hidden property="revdel"/>
					<input type=button value=Save onclick="sinsertForSourceIdentification()" class="bText"/>
					<input type=button value=Delete onclick="sfndelete()" class="bText"/>
					</td>
				</tr>  
		<%}%>

        
		</table>
		</label>
		</fieldset>
		 </td>
		</tr> 
		<%@ include file="/commons/rws_alert.jsp"%> 