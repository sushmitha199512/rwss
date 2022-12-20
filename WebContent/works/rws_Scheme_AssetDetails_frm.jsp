<tr>
	<td class="mycborder">
	<fieldset>
	<legend><bean:message key="legend.rwsOffices"/></legend>
	<label>
		
	<table border=0 width="830">
	<tr>
		<td class="textborder"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder" >
		<html:text property="headOfficeName" style="width:140px"  styleClass="mytext" readonly="true"/>
		<html:hidden property="headOfficeCode"/>
		</td>
		<td class="textborder">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<html:text property="circleOfficeName" style="width:140px"  styleClass="mytext" readonly="true"/>
			<html:hidden property="circleOfficeCode"/>
		</td>
	</tr>
	<tr>
		<td class="textborder"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
		<html:text property="divisionOfficeName" style="width:140px"  styleClass="mytext" readonly="true"/>
		<html:hidden property="divisionOfficeCode"/>
		</td>
		<td class="textborder">
		<bean:message key="app.subdivision" />
		<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<html:text property="subdivisionOfficeName" style="width:140px"  styleClass="mytext" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode"/>
		</td>
	</tr>
	</table>
	</label>
	</fieldset>
	<fieldset>
	<legend >Habitation Details</legend>
	<label>
	<table border=0 width="100%">
	<tr>
		<td><td>
	</tr>
		<tr>
			
		 	<td class="textborder"  >
		 	<bean:message key="app.district" /><font color="#FF6666">*</font></td>
	
             <td class="textborder" >
         	<html:text property="district" style="width:140px" styleClass="mytext"  readonly="true" />
		
           	<html:hidden property="circleOfficeCode"/>
           	</td>			
			<td class="textborder" >
				<bean:message key="app.mandal" /><font color="#FF6666">*</font>
			</td>
			<td class="bwborder" >
				<html:text property="mandalName" style="width:140px"  styleClass="mytext" readonly="true"/>
			<html:hidden property="mandal"/>
			</td>
					
			<TD class="textborder">
				<bean:message key="app.habCode" /><font color="#FF6666">*</font>
			</TD>
		    <TD colspan=3 class="bwborder">
		    	<html:text property="habName" style="width:140px"  styleClass="mytext" readonly="true" onmouseover="Tip('Lead Habitation for this Scheme',TITLE,'')" onmouseout="UnTip()"/>
				<html:hidden property="habCode"/>				
			</TD>			
		</tr>
		</table>
		

	</label>
			</fieldset>
			<fieldset>
			<legend  >Asset Details</legend>
			<label>
			<table  border=0  width="100%">
				<tr>
					<TD class="textborder"  nowrap>
					
						<bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
					    <html:text property="scheme" style="width:140px"  styleClass="mytext" readonly="true"/>
						<html:hidden property="schemeCode"/>		
						<html:hidden property="assetTypeCode"/>		
					</TD>
 					<TD colspan="2">
							&nbsp;
					</TD>
					<html:hidden property="assetCode"/>		
				    <TD class="textborder" nowrap >
					Asset Code<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
					 <html:text property="pumpCode"  styleClass="mytext" maxlength="3" style="width:80px" readonly="true"/>
					</TD>		    
				</tr>
				<tr>
				 
						
					<TD class="textborder" nowrap >
						<bean:message key="app.assetName" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				   
				    	<html:text property="assetName"  
				    			   styleClass="mytext" maxlength="150" style="width:210px" onkeypress="upperOnly()" onmouseover="Tip(this.value,TITLE,'')" onmouseout="UnTip()"  readonly="true"/>
				    </TD>
				     <TD class="textborder">				     
						<bean:message key="app.location" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="location"   
				    			   styleClass="mytext" maxlength="25" onkeypress="upperOnly()"/>
				    </TD>
					 <TD class="textborder">Asset Status<font color="#FF6666">*</font></TD>
				    <TD class="bwborder">
						 <html:hidden property="assetStatus"/>
					 	<input type="text" name="assetStatusName" style="width:80px" styleClass="mytext" value="Working" readonly="true">
					</td>	
					
				</tr>
				<tr>
					<TD class="textborder">
						<bean:message key="app.startYear" /><font color="#FF6666"></font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="startYear" styleClass="mytext"   maxlength="4" style="width:60px" readonly="true"/><!-- onkeypress="return decimalsOnly(event)" onblur="return checkStartYear()" -->
				    </TD>
					
					<TD class="textborder"   >
						<bean:message key="app.dateofCreation" /><font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="dateofCreation"   
				    			   styleClass="mytext" style="width:80px" readonly="true" onmouseover="Tip('Scheme Commissioned Date',TITLE,'')" onmouseout="UnTip()"/>
						</TD>
					<TD class="textborder"  >
						<bean:message key="app.assetCost" />(Rs. in Lakhs)<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				    	<html:text property="assetCost" styleClass="mytext"   maxlength="10" style="width:70px" readonly="true" onmouseover="Tip('See Note.5',TITLE,'')" onmouseout="UnTip()" />&nbsp;
				    </TD>
				</tr>
				<tr>
				<td class="textborder" colspan=2 nowrap>
				&nbsp;
					</td>
				 <TD class="textborder">
						<bean:message key="app.habbenfit" />
					</TD>
				    <TD class="bwborder">
						<html:text property="totHabs" styleClass="mytext"  style="width:40px" readonly="true"  onclick="abc()"/>
						<a style="cursor:hand" onclick="abc()"><font face=verdana color=blue size=2>View/Hide</font></a>
					</TD> 
					 <TD class="textborder">
						<bean:message key="app.popbenfit" />
					</TD>
				    <TD class="bwborder">
					<%if(schemeCode!=null && (schemeCode.equals("01") || schemeCode.equals("02") || schemeCode.equals("03") || schemeCode.equals("09"))) {%>
						<html:text property="totPopBenfit" styleClass="mytext"  maxlength="10" style="width:60px" readonly="true" onmouseover="Tip('Total Population for Benefitted Habs as on today',TITLE,'')" onmouseout="UnTip()"/>
						<%}else{%>
							<html:text property="totPopBenfit" styleClass="mytext"  maxlength="10" style="width:60px"  onmouseover="Tip('Population May Change for Non-Scheme type Assets',TITLE,'')" onmouseout="UnTip()" onkeypress="return numeralsOnly(event)" />
						<%}%>
					</TD> 
					</tr>
					<tr><td colspan=6 align=center>
					<div id="b" style="background-color:white;width:350px; height: 49px;filter: alpha(Opacity=125);opacity:0.15;border: solid 1px gray; background-image: url(./images/bg.jpg);;display=none">

					<table bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" align=center>
					<tr><td colspan=3 align="right" onclick="abc()" style="cursor:hand">
						<font face=verdana size=2 color="black"><b>&nbsp;&nbsp;&nbsp;Hide&nbsp;&nbsp;&nbsp;</b></font>
					</tr></td>
					<tr>
							<td class="textborder" colspan="3"><div align="center"><font color="black">Benefited Habs</font></div></td>
						  </tr>
						  <tr>
							<td class="textborder" align="center"><font color="black">S.No</font></td>
							<td class="textborder" align="center"><font color="black">Habitation Details</font></td>
						</tr>
						  <%
							int snos = 1;
							nic.watersoft.masters.PanchRaj panchRaj;
							ArrayList habs = (ArrayList)session.getAttribute("tempSelectedHabs");
							for(int i = 0;i<habs.size();i++)
							{
								panchRaj = (nic.watersoft.masters.PanchRaj)habs.get(i);
							%>
							<tr>
								<td style="width:40px"  align="center"><font size=2 color="black" face=verdana><%=snos++%></font></td>
								<td style="width:310px"><font size=2 color="black" face=verdana><%=panchRaj.getHabCode()%>-<%=panchRaj.getHabName()%></font></td>
							</tr>
							<%
							}
						  %>
						</table>
					</div>
					</td></tr>
					</table>
					</label>
					</fieldset>
	</td>
</tr>

