<script>
function setSourceName()
{
var scode = document.forms[0].srcCode.value;
var sname = scode.substring(25,scode.length);
document.forms[0].srcName.value=sname;
}

</script>
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
		<td ><font face=verdana size=2><b>Source Habitation</b></td>
		<td ><html:select property="sitehab" style="width:183px" styleClass="mycombo"  onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="siteHab1" name="sitehabs" property="panchCode" labelProperty="panchName" /> 
			</html:select>
			
		</td>
		</logic:present>
		<logic:notPresent name="siteHab1">
		<td ><font face=verdana size=2><b>Source Habitation</b></td>
		<td ><html:select property="sitehab" style="width:183px" styleClass="mycombo" onchange="getForm()">
			<html:option value="">Please Select...</html:option>
			</html:select>
			
		</td>
		</logic:notPresent>

		<td><font face=verdana size=2><b>Source Type</b></td>
			<td width="150">
			<!-- <html:select property="subcompType" style="width:183px"  styleClass="mycombo" onchange = "getFormSprad()">
			</html:select>
			-->
			<html:select property="subcompType" style="width:183px"  styleClass="mycombo"  onchange="getFormSrctype()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="scTypes">
			<html:options collection="scTypes" name="scType" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
	  	 </tr>
	  	 		<tr class="textborder">
	  	 		<td><font face=verdana size=2><b>Sub Source Type</b></td>
			<td width="150">
			<!-- <html:select property="subcompType" style="width:183px"  styleClass="mycombo" onchange = "getFormSprad()">
			</html:select>
			-->
			<html:select property="subSourceType" style="width:183px"  styleClass="mycombo"  onchange="getForm()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="subSources">
			<html:options collection="subSources" name="subSource" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
		  <td><html:radio property="spradgroup"  value="existSrc" onclick="getForm()"/><font face=verdana size=2><b>Existing Source</b></td>
 			 <td ><html:radio property="spradgroup"  value="newSrc" onclick="getForm()" style="size:3px"/><font face=verdana size=2><b>New Source</td>
 	       </tr>
	  	 
			 <%
	    String codeExist=(String)session.getAttribute("codeExist");
	    String oldsrcExist="",oldsrccode="";
	    //oldsrcExist=request.getParameter("srcName");
        oldsrcExist=(String)session.getAttribute("oldsrcname");
	    String mod=request.getParameter("mode");
	    System.out.println("mode"+mod);
	   
	    %>
	    <input type=hidden name=mod value=<%=mod%>>	    
	    <input type=hidden name=codeExist value=<%=codeExist%>>
	    <input type=hidden name=oldsrcExist value="<%=oldsrcExist%>">
	    <input type=hidden name=oldsrcCode value="<%=oldsrccode%>">
	    <%
	     String r=request.getParameter("spradgroup");
	     if (r==null)
		 {r="";}
	     if (r=="" || r.equals("data"))
		{
		%>
	 	<tr class="textborder">
	 	<td ><font face=verdana size=2><b>Source</b></td>
			<td width="150"><html:select property="srcCode" style="width:300px" styleClass="mycombo" onchange="setSourceName()" >
		<html:option value="">Please Select...</html:option>
		<logic:present name="srcCodes">
			<html:options collection="srcCodes" name="sourceCode" property="sourceCode" labelProperty="sourceCode"/> 
			</logic:present>	</html:select>
		
			<td ><font face=verdana size=2><b>Source Name</b></td>
			<td width="160"><html:text property="srcName" readonly="true"/></td>
		</tr>
			<%
			}
			else if (r.equals("existSrc"))
			{
			
		%>
	 	<tr class="textborder">
	 	<td ><font face=verdana size=2><b>Source</b></td>
			<td width="150"><html:select property="srcCode" style="width:300px" styleClass="mycombo" onchange="setSourceName()" >
		<html:option value="">Please Select...</html:option>
		<logic:present name="srcCodes">
			<html:options collection="srcCodes" name="sourceCode" property="sourceCode" labelProperty="sourceCode" /> 
			</logic:present></html:select>
			<td ><font face=verdana size=2><b>Source Name</b></td>
			<td width="160"><html:text property="srcName" readonly="true"/></td>
		</tr>
		<%
		}
		else if (r.equals("newSrc"))
		{
		%>
		<tr class="textborder">
			<td width="180"><font face=verdana size=2><b>Source Code</b></td>
			<td width="160"><html:text property="newsrcCode" readonly="true"  style="width:300px"/></td>
			<%
			String acode = (String)request.getAttribute("assetCodee");
			
			if(!acode.equals("04")){ %>
			<td ><font face=verdana size=2><b>Source Name</b></td>
			<%}else if(acode.equals("04")){ %>
			<td ><font face=verdana size=2><b>Location Name</b></td>
			<%} %>
			<td width="160"><html:text property="newsrcName"   /></td>
	 	</tr>
			<%
			}
		%>
		<tr class="textborder">
		<td width="180"><font face=verdana size=2><b>Site/Source Identified By</b></td>
		<td width="160"><html:text property="srcIdby" /></td>
 		<td width="180" ><font face=verdana size=2><b>Source Site Handing Over Date</b></td>
		<td width="200"><html:text property="siteHODate"   readonly="true"/>
		<a href="javascript: showCalendar(document.monitoringForm.siteHODate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr>
		<tr class="textborder">
		<td ><b>Recommendations By<B> Geologist</b></td>
		<td colspan="2" ><html:text property="recommend"  style="width:400px" /></td>
		</tr>
			 <tr >
			 <td align=center colspan=4>
			<html:hidden property="revflag" />
			<%
		System.out.println("R value:"+r);
 		   %>
 		<input type=button value=Save onclick="sinsertForSourceIdentification()" class="bText"/>
		 <!-- <input type=button value="Update" onclick="supdateForSourceIdentification()" class="bText"/> -->
		<html:hidden property="revdel" />
		<input type=button value=Delete onclick="sfndelete()" class="bText"/>
		</td>
	 		</tr>
		</table>
		</label>
		</fieldset>
		 </td>
		</tr> 