<%@ include file="/commons/rws_header1.jsp"%>
<html:javascript formName="assetForm" />
<jsp:include page="rws_AssetSubCompParamList_frm2.jsp"/>
</head>
	<%
		String assetCode = request.getParameter("assetTypeCode");
		String assetCodee = request.getParameter("assetCode");
		String assetName = "";
		if (assetCode != null) {
			if (assetCode.equals("01"))
				assetName = "PWS";
			else if (assetCode.equals("02"))
				assetName = "MPWS";
			else if (assetCode.equals("03"))
				assetName = "CPWS";
		}
	%>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">

	<table bordercolor="#8A9FCD" border="0" rules="none"
		style="border-collapse: collapse;" width="100%">
		<thead class="gridLabel">
			<tr bgcolor="#8A9FCD">
				<td colspan=2 align=left><b>Asset SubComponent Parameter
						Details </b></td>
			</tr>
		</thead>
		<tr>
			<td colspan="3">
				<table class="row" bordercolor="#8A9FCD" border="1" rules="none"
					style="border-collapse: collapse;" width="100%">
					<%
						if (((String) session.getAttribute("assetsubCompParams")).equalsIgnoreCase("pickpipemat")) {
					%>
					<html:form action="Asset.do?mode=Submit">
						<%
							int count = 0;
						%>
						<tr>
							<td>
								<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
									border="1" style="border-collapse: collapse; margin-top: 0">
									<thead class="gridHeader">
										<tr>
											<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
															key="app.select" /></b></font></th>
											<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
															key="app.pipeMaterial" /></b></font></th>
											<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
															key="app.pipeDiameter" /></b></font></th>
											<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
															key="app.pipeClass" /></b></font></th>
											<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
															key="app.pipeLength" /></b></font></th>

										</tr>
									</thead>
									<nested:iterate id="ASSETPIPELINE_LIST"
										property="assetPipeLine" indexId="ndx">
										<%
											count = count + 1;
										%>
										<tr>
											<td width="40px" align="center"><input type="checkbox"
												name="remove" value="<%=ndx%>"> <nested:text
													name="ASSETPIPELINE_LIST" indexed="true"
													property="assetCode" styleClass="gridText" maxlength="0"
													style="width:0px" onkeypress="return textOnly()" /> <nested:hidden
													name="ASSETPIPELINE_LIST" indexed="true" property="rowId" />

												<html:hidden name="ASSETPIPELINE_LIST" indexed="true"
													property="habCode" /></td>

											<td align=center><html:select name="ASSETPIPELINE_LIST"
													indexed="true" property="material" styleClass="mycombo"
													style="width:100px"
													onchange='<%="javascript: materialChanged(\" + ndx +\")"%>'>
													<html:option value="">SELECT...</html:option>
													<html:optionsCollection name="ASSETPIPELINE_LIST"
														property="pipeMaterialList" />
												</html:select></td>
											<td align=center><html:select name="ASSETPIPELINE_LIST"
													indexed="true" property="diameter" styleClass="mycombo"
													style="width:100px"
													onchange='<%="javascript: validate(\" + ndx +\")"%>'>
													<html:option value="">SELECT...</html:option>
													<html:optionsCollection name="ASSETPIPELINE_LIST"
														property="pipeDiameterList" />
												</html:select></td>
											<td align=center><html:select name="ASSETPIPELINE_LIST"
													indexed="true" property="pclass" styleClass="mycombo"
													style="width:100px"
													onchange='<%="javascript: validate(\" + ndx +\")"%>'>
													<html:option value="">SELECT...</html:option>
													<html:optionsCollection name="ASSETPIPELINE_LIST"
														property="pipeClassList" />
												</html:select></td>
											<td align=center><nested:text name="ASSETPIPELINE_LIST"
													indexed="true" property="length" styleClass="gridText"
													style="width:160px" readonly="false"
													onkeyup="extractNumber2(this,7,2,false)"
													onkeypress="return blockNonNumbers(this, event, true, false)" />
											</td>
											</td>
										</tr>
									</nested:iterate>
									<%
										request.setAttribute("count", count + "");
									%>
								</table>
							</td>
						</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="3"><html:button property="mode"
					title="Add New Pipe Type" styleClass="btext"
					value="Add New Pipe Type" onclick="save()" /> <html:button
					property="mode" title="Remove Pipe Type" styleClass="btext"
					value="Remove Pipe Type" onclick="removePipeType(this)" /> <html:button
					property="mode" title="Save the Fields" styleClass="btext"
					value="Save" onclick="savePipeType(this)" /> <html:reset
					title="Close the Window" styleClass="btext" value="Close"
					onclick="pickpipematCloseFunc()" /></td>
		</tr>
	</table>
	<input type="hidden" name="count" value="<%=count%>">

	</html:form>

	<%
		}
	%>
	<c:if test="${sessionScope.assetsubCompParams=='Cisterns'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-CISTERNS
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.cisCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation
											Linkage</b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.cisLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Capacity
											in Lts.</b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;No
											Of Fillings/Day</b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.cisPlatformExisting" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.cisPfCond" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.cisDrain" />
									</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Water
											Quality</b></font><font color="red"></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>
								<td align="center">
									<table>
										<tr>
											<td><nested:text name="ASSETRESERVIOR_LIST"
													indexed="true" property="habCode" styleClass="gridText"
													style="width:100px" readonly="true" /></td>
											<td><html:button property="addHab" value="..."
													styleClass="btext"
													onclick='<%="javascript: fnPickHabitations(\" + ndx +\")"%>' />
											</td>
										</tr>
									</table>
								</td>
								<td align="center"><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="noOfHab" readonly="true"
										styleClass="noborder-text-box" style="width:35px" /> <html:button
										property="addHab" value="..." styleClass="btext"
										title="Click Here"
										onclick='<%="javascript: fnHabitationLinkage(\" + ndx +\")"%>' />

								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisLocation" styleClass="gridText"
										maxlength="50" style="width:100px" onkeypress="upperOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisCapLts" maxlength="10"
										styleClass="gridText" style="width:100px"
										onkeyup="extractNumber2(this,10,2,false)"
										onkeypress="return blockNonNumbers(this, event, true, false)" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisHr" styleClass="gridText"
										maxlength="2" style="width:100px"
										onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<html:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="cisCond" />
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisPf" styleClass="mycombo"
										style="width:100px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisPfCond" styleClass="mycombo"
										style="width:100px">
										<html:option value="">SELECT...</html:option>
										<html:option value="G">GOOD</html:option>
										<html:option value="B">BAD</html:option>
									</html:select></td>
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisDrain" styleClass="mycombo"
										style="width:100px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="cisNoOfTaps" styleClass="mycombo"
										style="width:100px">
										<html:option value="">
											<bean:message key="app.pleaseSelect" />
										</html:option>
										<html:option value="N">Safe Source</html:option>
										<html:option value="Y">NSS</html:option>
									</html:select></td>
								<html:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="cisTapCond" />
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="cisCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New Cistern" styleClass="btext" value="Add New Cistern"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Cistern" styleClass="btext"
						value="Remove Cistern" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="cisCode">
		</html:form>
	</c:if>

	<c:if test="${sessionScope.assetsubCompParams=='Ohsr'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-OHSR
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohsrCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation
											Linkage</b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohsrLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohsrCapacityLts" /></b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.NoOfFillings" /></b></font><font color="red">*</font></th>

								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohsrStaqing" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Water
											Quality</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohsrCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>

								<td align="center">
									<table>
										<tr>
											<td><nested:text name="ASSETRESERVIOR_LIST"
													indexed="true" property="habCode" styleClass="gridText"
													style="width:100px" readonly="true" /></td>
										</tr>
									</table>
								</td>
								<td align="center"><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="noOfHab" readonly="true"
										styleClass="noborder-text-box" style="width:35px" /> <html:button
										property="addHab" value="..." styleClass="btext"
										title="Click Here"
										onclick='<%="javascript: fnHabitationLinkage(\" + ndx +\")"%>' />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohsrLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohsrCapacityLts"
										styleClass="gridText" style="width:100px"
										onkeyup="extractNumber2(this,10,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="noOfFillings" maxlength="5"
										styleClass="gridText" style="width:100px" /></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohsrStages" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />

								</td>
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohsrLwl" styleClass="mycombo"
										style="width:100px">
										<html:option value="">
											<bean:message key="app.pleaseSelect" />
										</html:option>
										<html:option value="N">Safe Source</html:option>
										<html:option value="Y">NSS</html:option>
									</html:select></td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohsrMwl" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohsrFillHrs" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohsrEmptyHrs" />
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="ohsrCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New OHSR" styleClass="btext" value="Add New OHSR"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove OHSR" styleClass="btext"
						value="Remove OHSR" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this);" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			</table>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="ohsrCode">
		</html:form>
	</c:if>


	<c:if test="${sessionScope.assetsubCompParams=='Ohbr'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-OHBR
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohbrCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohbrLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ohbrCapacityLts" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;OHBR
											Staging</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /> <html:hidden
										name="ASSETRESERVIOR_LIST" indexed="true" property="habCode" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohbrCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohbrLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<td class="textborder" align=center><nested:text
										name="ASSETRESERVIOR_LIST" indexed="true"
										property="ohbrCapacityLts" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,10,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="ohbrStages" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohbrLwl" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohbrMwl" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohbrFillHrs" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="ohbrEmptyHrs" />
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="ohbrCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New OHBR" styleClass="btext" value="Add New OHBR"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove OHBR" styleClass="btext"
						value="Remove OHBR" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="ohbrCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='Glsr'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-GLSR
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glsrCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation
											Linkage</b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glsrLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glsrCapacityInLts" /></b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.NoOfFillings" /></b></font><font color="red">*</font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Water
											Quality</b></font><font color="red"></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /> <html:hidden
										name="ASSETRESERVIOR_LIST" indexed="true" property="habCode" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glsrCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>
								<td align="center">
									<table>
										<tr>
											<td><nested:text name="ASSETRESERVIOR_LIST"
													indexed="true" property="habCode" styleClass="gridText"
													style="width:100px" readonly="true" /></td>
											<td><html:button property="addHab" value="..."
													styleClass="btext"
													onclick='<%="javascript: fnPickHabitations(\" + ndx +\")"%>' />
											</td>
										</tr>
									</table>
								</td>
								<td align="center"><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="noOfHab" readonly="true"
										styleClass="noborder-text-box" style="width:35px" /> <html:button
										property="addHab" value="..." styleClass="btext"
										title="Click Here"
										onclick='<%="javascript: fnHabitationLinkage(\" + ndx +\")"%>' />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glsrLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glsrCapacityInLts"
										styleClass="gridText" style="width:100px"
										onkeyup="extractNumber2(this,8,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glsrNoOfFillings" maxlength="5"
										styleClass="gridText" style="width:100px" /></td>
								<!-- <nested:hidden name="ASSETRESERVIOR_LIST" indexed="true" property="glsrLwl"/> -->
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="glsrMwl" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="glsrFillHrs" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="glsrEmptyHrs" />
								<td align=center><html:select name="ASSETRESERVIOR_LIST"
										indexed="true" property="glsrLwl" styleClass="mycombo"
										style="width:100px">
										<html:option value="">
											<bean:message key="app.pleaseSelect" />
										</html:option>
										<html:option value="N">Safe Source</html:option>
										<html:option value="Y">NSS</html:option>
									</html:select></td>
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="glsrCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New GLSR" styleClass="btext" value="Add New GLSR"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove GLSR" styleClass="btext"
						value="Remove GLSR" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="glsrCode">
		</html:form>
	</c:if>

	<c:if test="${sessionScope.assetsubCompParams=='Glbr'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-GLBR
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrCapacityInLts" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrLwl" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrMwl" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrFillHrs" />
									</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.glbrEmptyHrs" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>


								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrCapacityInLts"
										styleClass="gridText" style="width:100px"
										onkeyup="extractNumber2(this,10,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrLwl" maxlength="50"
										styleClass="gridText" style="width:100px"
										onkeyup="extractNumber2(this,10,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrMwl" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,8,3,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrFillHrs" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,8,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="glbrEmptyHrs" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="glbrCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>
								<!-- added by swapna on 18-01-2012 -->
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New GLBR" styleClass="btext" value="Add New GLBR"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove GLBR" styleClass="btext"
						value="Remove GLBR" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			</table>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="glbrCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='BPT'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-BPT
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.bptCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.bptLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.bptCapacity" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.bptStaging" /></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>


								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="bptCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="bptLocation" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="false" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="bptCapacity" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="bptStaging" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="bptMaxwl" />
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="bptMinwl" />
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New BPT" styleClass="btext" value="Add New BPT"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove BPT" styleClass="btext"
						value="Remove BPT" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="bptCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='SPosts'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-RESERVOIRS-STAND
						POSTS
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Stand
											Post Code</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Stand
											Post Name</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Location</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Image</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Remarks</b></font>
								</th>
						</thead>
						<nested:iterate id="ASSETRESERVIOR_LIST" property="assetReservior"
							indexId="ndx">
							<%
								count++;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETRESERVIOR_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /> <html:hidden
										name="ASSETRESERVIOR_LIST" indexed="true" property="habCode" />
								</td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="standPostCode" maxlength="8"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" readonly="true" /></td>
								<nested:hidden name="ASSETRESERVIOR_LIST" indexed="true"
									property="habCode" />

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="standPostName" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="spLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<!-- bhagya -->
								<td align=center><nested:equal name="ASSETRESERVIOR_LIST"
										property="imageStatus" value="Yes">
										<a href="#"
											onclick="openFile('<bean:write name="ASSETRESERVIOR_LIST" property="standPostCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETRESERVIOR_LIST" property="imageStatus"
										value="Yes">
										<p styleClass="gridText" style="width: 100px">Image not
											Exist</p>
									</nested:notEqual></td>
								<!-- added by swapna on 18-01-2012 -->
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()"
										readonly="true" /></td>
								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()"
										readonly="true" /></td>

								<td align=center><nested:text name="ASSETRESERVIOR_LIST"
										indexed="true" property="spRemarks" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
			<tr>
				<td align="center"><html:button property="mode"
						title="Add New Stand Post" styleClass="btext"
						value="Add New Stand Post"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Stand Post" styleClass="btext"
						value="Remove Stand Post" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			</table>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="standPostCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='SSTank'}">
		<html:form action="Asset.do?mode=Submit">

			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-SS
						Tank
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssTankCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssArea" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssDepth" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssCapacityDays" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssCapacityMcum" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssTankAdeq" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;If
											Others, Please Specify</b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.ssTankLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>

								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssTankCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /> <html:hidden
										name="ASSETHEADWORK_LIST" indexed="true" property="habCode" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssSize" maxlength="10"
										styleClass="gridText" style="width:100px"
										onkeypress="return decimalsOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssDepth" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,7,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>

								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssCapacityDays" maxlength="10"
										styleClass="gridText" style="width:100px"
										onkeypress="return decimalsOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssCapacityMcum" styleClass="gridText"
										style="width:100px"
										onkeyup="extractNumber2(this,20,10,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><html:select name="ASSETHEADWORK_LIST"
										indexed="true" property="ssTankAdeq" styleClass="mycombo"
										style="width:100px"
										onchange='<%="javascript: powerConsumptionChanged(\" + ndx +\")"%>'>
										<html:option value="">SELECT...</html:option>
										<html:option value="Urban">Canal</html:option>
										<html:option value="Rural">River</html:option>
										<html:option value="Dedicated">Reserviors</html:option>
										<html:option value="Others">Others</html:option>
									</html:select></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="powerConnOthers" maxlength="10"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<script language="javascript">
				var index=<%=ndx%>;
				if( document.getElementById("ASSETHEADWORK_LIST["+index+"].ssTankAdeq").value=="Others")
				{
				document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").disabled=false;
				}
				else
				{
				document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").value="";
				document.getElementById("ASSETHEADWORK_LIST["+index+"].powerConnOthers").disabled=true;

				}
			</script>

								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="ssTankLocation" maxlength="40"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="powerConn" />
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="powerHours" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New SS Tank" styleClass="btext" value="Add New SS Tank"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove SS Tank" styleClass="btext"
						value="Remove SS Tank" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="ssTankCode">
		</html:form>
	</c:if>


	<c:if test="${sessionScope.assetsubCompParams=='Sump'}">
		<html:form action="Asset.do?mode=Submit">

			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-Sump
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpDiameter" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpDepth" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpCapacity" /></font><font color="#FF6666">*</font></b></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.sumpCondition" /></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<td align="center"><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpLocation" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="sumpType" />
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="sumpMadeOf" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpDiameter" styleClass="gridText"
										style="width:160px" onkeyup="extractNumber2(this,7,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpDepth" styleClass="gridText"
										style="width:160px" onkeyup="extractNumber2(this,7,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpCapacity" maxlength="10"
										styleClass="gridText" style="width:100px"
										onkeypress="return decimalsOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="sumpFillHr" />
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="sumpEmptyHr" />
								<td align=center><html:select name="ASSETHEADWORK_LIST"
										indexed="true" property="sumpCondition" styleClass="mycombo"
										style="width:100px">
										<html:option value="">SELECT...</html:option>
										<html:option value="G">Good</html:option>
										<html:option value="B">Bad</html:option>
									</html:select></td>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New Sump" styleClass="btext" value="Add New Sump"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Sump" styleClass="btext"
						value="Remove Sump" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="sumpCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='FootpathBridge'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-FOOT
						PATH BRIDGE
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.bridgeCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Location</b></font>
								</th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="bridgeCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /> <nested:hidden
										name="ASSETHEADWORK_LIST" indexed="true" property="habCode" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" maxlength="50" property="bridgeLocation"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="bridgeLength" />
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="bridgeWidth" />
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New Foot Path Bridge" styleClass="btext"
						value="Add New Foot Path Bridge"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Foot Path Bridge" styleClass="btext"
						value="Remove Foot Path Bridge" onclick="removeSubComps(this)" />
					<html:button property="mode" title="Save the Fields"
						styleClass="btext" value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="bridgeCode">
		</html:form>
	</c:if>


	<c:if test="${sessionScope.assetsubCompParams=='PumpHouse'}">
		<html:form action="Asset.do?mode=Submit">

			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-PUMP
						HOUSE
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.pumpHouseCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.pumpCond" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.pumpHouseArea" /></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="pumpHouseCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>

								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="pumpHouseLocation"
										styleClass="gridText" style="width:100px" maxlength="25"
										onkeypress="upperOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="pumpHouseArea" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<!--  <td   align=center >
			<nested:text name="ASSETHEADWORK_LIST" indexed="true" property="pumpHouseHeight" maxlength="30"  styleClass="gridText" style="width:100px" onkeyup="extractNumber2(this,5,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"/>
		 </td> -->

							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New Pump House" styleClass="btext"
						value="Add New Pump House"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Pump House" styleClass="btext"
						value="Remove Pump House" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="pumpHouseCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='WatchManQuarter'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-WATCHMAN
						QUARTER
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.watchManCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.location" /></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /> <html:hidden
										name="ASSETHEADWORK_LIST" indexed="true" property="habCode" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="watchManCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="watchManLocation" maxlength="30"
										onkeypress="upperOnly()" styleClass="gridText"
										style="width:160px" readonly="false" /></td>
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="watchManType" />
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="watchManArea" />
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="watchManNoOfQuarters" />
							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New WatchMan Quarter" styleClass="btext"
						value="Add New WatchMan Quarter"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove WatchMan Quarter" styleClass="btext"
						value="Remove WatchMan Quarter" onclick="removeSubComps(this)" />
					<html:button property="mode" title="Save the Fields"
						styleClass="btext" value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="watchManCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='Distribution'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-PIPELINE-DISTRIBUTffffION
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.disCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.nopipe" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.pipeMat" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.disLength" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.disNoOfStandPosts" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.disNoOfHouseConnections" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.disNoOfPipeLines" /></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETPIPELINE_LIST" property="assetPipeLine"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETPIPELINE_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>
								<nested:hidden name="ASSETPIPELINE_LIST" indexed="true"
									property="habCode" />
								<td align="center"><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="habCode" styleClass="gridText"
										style="width:160px" readonly="true" /> <html:button
										property="addHab" value="..." styleClass="btext"
										onclick='<%="javascript: fnPickHabitations(\" + ndx +\")"%>' />
								</td>
								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disNoOfPipes" maxlength="30"
										styleClass="gridText" style="width:100px" readonly="true" /></td>
								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="habCode" styleClass="gridText"
										style="width:160px" readonly="true" /> <html:button
										property="addMat" value="..." styleClass="btext"
										onclick='<%="javascript: fnPickPipeMat(\" + ndx +\")"%>' /> 
								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disLengths" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,5,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disNoOfStandPosts" maxlength="3"
										styleClass="gridText" style="width:100px"
										onkeypress="return numeralsOnly()" /></td>

								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disNoOfHouseConnections"
										maxlength="4" styleClass="gridText" style="width:100px"
										onkeypress="return numeralsOnly()" /></td>

								<td align=center><nested:text name="ASSETPIPELINE_LIST"
										indexed="true" property="disNoOfPipeLines" maxlength="3"
										styleClass="gridText" style="width:100px"
										onkeypress="return numeralsOnly()" /></td>

							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><html:button property="mode"
						title="Add New Distribution" styleClass="btext"
						value="Add New Distribution"
						onclick="javascript: fnPickNewHabitations()" /> <html:button
						property="mode" title="Remove Distribution" styleClass="btext"
						value="Remove Distribution" onclick="removeSubComps(this)" /> <html:button
						property="mode" title="Save the Fields" styleClass="btext"
						value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="disCode">
		</html:form>
	</c:if>
	<c:if
		test="${sessionScope.assetsubCompParams=='RawWaterCollectionWell' || sessionScope.assetsubCompParams=='ClearWaterCollectionWell'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<c:if
					test="${sessionScope.assetsubCompParams=='RawWaterCollectionWell'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-RAW
							WATER COLLECTION WELL
					</b></td>
				</c:if>
				<c:if
					test="${sessionScope.assetsubCompParams=='ClearWaterCollectionWell'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-CLEAR
							WATER COLLECTION WELL
					</b></td>
				</c:if>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;
											<c:if
												test="${sessionScope.assetsubCompParams=='RawWaterCollectionWell'}">
												<bean:message key="app.rwCollectionWellCode" />
											</c:if> <c:if
												test="${sessionScope.assetsubCompParams=='ClearWaterCollectionWell'}">
												<bean:message key="app.cwCollectionWellCode" />
											</c:if></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.rwLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.rwCapacity" /><span class="mandatory">*</span></b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>

							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="collectionWellCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>

								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<html:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="rwTypeOfFlooring" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="rwLocation" maxlength="30"
										styleClass="gridText" style="width:100px"
										onkeypress="upperOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="rwCapacity" styleClass="gridText"
										style="width:100px" onkeyup="extractNumber2(this,9,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<c:if
									test="${sessionScope.assetsubCompParams=='RawWaterCollectionWell'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="rwDiameter" />
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="rwDepth" />
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='ClearWaterCollectionWell'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="rwDiameter" />
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="rwDepth" />

								</c:if>
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><c:if
						test="${sessionScope.assetsubCompParams=='RawWaterCollectionWell'}">
						<html:button property="mode"
							title="Add New Raw Water Collection Well" styleClass="btext"
							value="Add New RWC Well"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode"
							title="Remove Raw Water Collection Well" styleClass="btext"
							value="Remove RWC Well" onclick="removeSubComps(this)" />
					</c:if> <c:if
						test="${sessionScope.assetsubCompParams=='ClearWaterCollectionWell'}">
						<html:button property="mode"
							title="Add New Clear Water Collection Well" styleClass="btext"
							value="Add New Clear Water Collection Well"
							onclick="fnPickNewHabitations()" />

						<html:button property="mode"
							title="Remove Clear Water Collection Well" styleClass="btext"
							value="Remove Clear Water Collection Well"
							onclick="removeSubComps(this)" />
					</c:if> <html:button property="mode" title="Save the Fields"
						styleClass="btext" value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="collectionWellCode">
		</html:form>
	</c:if>
	<c:if
		test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='RSFilters' || sessionScope.assetsubCompParams=='MicroFilters' || sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<c:if test="${sessionScope.assetsubCompParams=='SSFilters'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-SS
							FILTERS
					</b></td>
				</c:if>
				<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-RS
							FILTERS
					</b></td>
				</c:if>
				<c:if test="${sessionScope.assetsubCompParams=='MicroFilters'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-MICRO
							FILTERS
					</b></td>
				</c:if>
				<c:if test="${sessionScope.assetsubCompParams=='RoPlants'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-HEADWORKS-RO
							PLANTS
					</b></td>
				</c:if>
				<c:if test="${sessionScope.assetsubCompParams=='DONOR-TP'}">
					<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-DONOR
							- RO PLANTS
					</b></td>
				</c:if>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.wtpCode" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.wtpLocation" /></b></font></th>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='RSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpMld" /></b></font></th>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;Capacity(LPH)</b></font>
									</th>
								</c:if>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.wtpUnits" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.wtpNoOfHoursOfUsage" /></b></font></th>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='RSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpSize" /></b></font></th>
								</c:if>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.wtpUnitsStandby" /></b></font></th>
								<c:if test="${sessionScope.assetsubCompParams=='DONOR-TP'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;Average
												Cans Supplied Per Day</b></font></th>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='SSFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpFreqSandScrap" />(in Months)
										</b></font></th>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;Raw
												Water Storage Tank Existing</b></font></th>
									<th><font size="1" face="verdana" color="black"><b>&nbsp;Product
												Water Storage Tank Existing</b></font></th>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='MicroFilters' || sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;Shelter
												Existing</b></font></th>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpBackwashFreq" /></b></font></th>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpPerformance" /></b></font></th>
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpExtentionScope" /></b></font></th>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpSedimentationTank" /></b></font></th>
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpHorizontalRoughingFilter" /></b></font></th>
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpVerticalRoughingFilter" /></b></font></th>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
									<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
													key="app.wtpClarifloculator" /></b></font></th>
								</c:if>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Latitude-N</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Longitude-E</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Elevation</b></font>
								</th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;Way
											Point</b></font></th>
							</tr>
						</thead>
						<nested:iterate id="ASSETHEADWORK_LIST" property="assetHeadWorks"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETHEADWORK_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpCode" maxlength="30"
										styleClass="gridText" style="width:145px"
										onkeypress="return upperOnly()" readonly="true" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpLocation" maxlength="50"
										styleClass="gridText" style="width:130px"
										onkeypress="return upperOnly()" /></td>
								<c:if test="${sessionScope.assetsubCompParams=='SSFilters'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="wtpType" value="SSF" />
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="wtpType" value="RSF" />
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='MicroFilters'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="wtpType" value="MSF" />
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
									<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
										property="wtpType" value="ROP" />
								</c:if>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpMld" styleClass="gridText"
										style="width:50px" onkeyup="extractNumber2(this,6,2,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpUnits" maxlength="3"
										styleClass="gridText" style="width:50px"
										onkeypress="return numeralsOnly()" /></td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpNoOfHoursOfUsage"
										styleClass="gridText" style="width:70px"
										onkeyup="extractNumber2(this,9,4,false);"
										onkeypress="return blockNonNumbers(this, event, true, false);" />
								</td>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='RSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<td align=center><nested:text name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpSize" maxlength="20"
											styleClass="gridText" style="width:60px"
											onkeypress="return upperOnly()" /></td>
								</c:if>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="wtpUnitsStandby" maxlength="1"
										styleClass="gridText" style="width:70px"
										onkeypress="return numeralsOnly()" /></td>
								<c:if test="${sessionScope.assetsubCompParams=='DONOR-TP'}">
									<td align=center><nested:text name="ASSETHEADWORK_LIST"
											indexed="true" property="aveCansSupplied" maxlength="5"
											styleClass="gridText" style="width:70px"
											onkeypress="return numeralsOnly()" /></td>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='RoPlants' || sessionScope.assetsubCompParams=='DONOR-TP'}">
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpRawWater" styleClass="mycombo"
											style="width:60px">
											<html:option value="">SELECT...</html:option>
											<html:option value="1">Yes</html:option>
											<html:option value="0">No</html:option>
										</html:select></td>
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpProductWater"
											styleClass="mycombo" style="width:60px">
											<html:option value="">SELECT...</html:option>
											<html:option value="1">Yes</html:option>
											<html:option value="0">No</html:option>
										</html:select></td>
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpShelter" styleClass="mycombo"
											style="width:60px">
											<html:option value="">SELECT...</html:option>
											<html:option value="1">Yes</html:option>
											<html:option value="0">No</html:option>
										</html:select></td>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='SSFilters'}">
									<td align=center><nested:text name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpFreqSandScrap" maxlength="3"
											styleClass="gridText" style="width:70px"
											onkeypress="return numeralsOnly()" /></td>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='MicroFilters'}">
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpShelter" styleClass="mycombo"
											style="width:60px">
											<html:option value="">SELECT...</html:option>
											<html:option value="1">Yes</html:option>
											<html:option value="0">No</html:option>
										</html:select></td>
								</c:if>

								<nested:hidden name="ASSETHEADWORK_LIST" indexed="true"
									property="wtpRateOfFiltration" />
								<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
									<td align=center><nested:text name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpBackwashFreq"
											styleClass="gridText" style="width:100px"
											onkeyup="extractNumber2(this,5,2,false);"
											onkeypress="return blockNonNumbers(this, event, true, false);" />
									</td>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpPerformance" styleClass="mycombo"
											style="width:60px">
											<html:option value="">SELECT...</html:option>
											<html:option value="G">Good</html:option>
											<html:option value="B">Bad</html:option>
										</html:select></td>
									<td align=center><html:select name="ASSETHEADWORK_LIST"
											indexed="true" property="wtpExtentionScope"
											styleClass="mycombo" style="width:50px">
											<html:option value="">SELECT...</html:option>
											<html:option value="Y">YES</html:option>
											<html:option value="N">NO</html:option>
										</html:select></td>
								</c:if>
								<c:if
									test="${sessionScope.assetsubCompParams=='SSFilters' || sessionScope.assetsubCompParams=='MicroFilters'}">
									<td align=center><nested:checkbox
											name="ASSETHEADWORK_LIST" indexed="true"
											property="wtpSedimentationTank" styleClass="gridText"
											style="width:50px" /></td>
									<td align=center><nested:checkbox
											name="ASSETHEADWORK_LIST" indexed="true"
											property="wtpHorizontalRoughingFilter" styleClass="gridText"
											style="width:50px" /></td>
									<td align=center><nested:checkbox
											name="ASSETHEADWORK_LIST" indexed="true"
											property="wtpVerticalRoughingFilter" styleClass="gridText"
											style="width:50px" /></td>
								</c:if>
								<c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
									<td align=center><nested:checkbox
											name="ASSETHEADWORK_LIST" indexed="true"
											property="wtpClarifloculator" styleClass="gridText"
											style="width:50px" /></td>
								</c:if>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="latitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="longitude" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="elevation" styleClass="gridText"
										style="width:100px" maxlength="10" onkeypress="decimalsOnly()" />
								</td>
								<td align=center><nested:text name="ASSETHEADWORK_LIST"
										indexed="true" property="waypoint" styleClass="gridText"
										style="width:100px" maxlength="4" onkeypress="decimalsOnly()" />
								</td>
							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3"><c:if
						test="${sessionScope.assetsubCompParams=='SSFilters'}">
						<html:button property="mode" title="Add New SS Filter"
							styleClass="btext" value="Add New SS Filter"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove SS Filter"
							styleClass="btext" value="Remove SS Filter"
							onclick="removeSubComps(this)" />
					</c:if> <c:if test="${sessionScope.assetsubCompParams=='RSFilters'}">
						<html:button property="mode" title="Add New RS Filter"
							styleClass="btext" value="Add New RS Filter"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove RS Filter"
							styleClass="btext" value="Remove RS Filter"
							onclick="removeSubComps(this)" />
					</c:if> <c:if test="${sessionScope.assetsubCompParams=='MicroFilters'}">
						<html:button property="mode" title="Add New MICRO Filter"
							styleClass="btext" value="Add New MICRO Filter"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove MICRO Filter"
							styleClass="btext" value="Remove MICRO Filter"
							onclick="removeSubComps(this)" />
					</c:if> <c:if test="${sessionScope.assetsubCompParams=='RoPlants'}">
						<html:button property="mode" title="Add New RO Plant"
							styleClass="btext" value="Add New RO Plant"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove RO Plant"
							styleClass="btext" value="Remove RO Plant"
							onclick="removeSubComps(this)" />
					</c:if> <html:button property="mode" title="Save the Fields"
						styleClass="btext" value="Save" onclick="savefunc(this)" /> <html:reset
						title="Close the Window" styleClass="btext" value="Close"
						onclick="closeFunc()" /></td>
			</tr>
			<input type="hidden" name="count" value="<%=count%>">
		</html:form>
		<input type="hidden" name="subCompCode" value="wtpCode">

	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='Miscellaneous'}">
		<html:form action="Asset.do?mode=Submit">

			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-MISCELLANEOUS
				</b></td>
			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">
						<thead class="gridHeader">
							<tr>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.select" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.otherCompCode" /></b></font></th>
								<!-- <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
		 </th> -->
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.otherCompLocation" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.otherCompName" /></b></font></th>
								<th><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
												key="app.otherCompRemarks" /></b></font></th>
						</thead>

						<nested:iterate id="ASSETPUMPSET_LIST" property="assetPumpSets"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>"> <nested:text
										name="ASSETPUMPSET_LIST" indexed="true" property="assetCode"
										styleClass="gridText" maxlength="0" style="width:0px"
										onkeypress="return textOnly()" /></td>
								<nested:hidden name="ASSETPUMPSET_LIST" indexed="true"
									property="habCode" />
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="otherCompCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>

								<!-- <td align="center">
		 			<nested:text name="ASSETPUMPSET_LIST" indexed="true" property="habCode"  styleClass="gridText" style="width:160px" readonly="true"/>
					<html:button property="addHab" value="..." styleClass="btext"
							 onclick='<%="javascript: fnPickHabitations(\"+ ndx +\")"%>' />
		</td>	 -->
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="compLocation" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>



								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="compName" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="remarks" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>

							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>

			</table>
			</td>
			</tr>
			<tr>
				<td align="center" colspan="3">
					<center>
						<html:button property="mode" title="Add New" styleClass="btext"
							value="Add New" onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove" styleClass="btext"
							value="Remove" onclick="removeSubComps(this)" />
						<html:button property="mode" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc(this)" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</center>
				</td>
			</tr>
			</table>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="otherCompCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='Chlorination'}">
		<html:form action="Asset.do?mode=Submit">

			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>-CHLORINATION
				</b></td>

			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">

						<tr class="gridHeader">
							<td rowspan="2"><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
											key="app.select" /></b></font></td>
							<td rowspan="2"><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
											key="app.otherCompCode" /></b></font></td>
							<!-- <td rowspan="2"> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Habitation</b></font>
		 </td> -->
							<td rowspan="2"><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
											key="app.otherCompLocation" /></b></font></td>
							<td rowspan="2"><font size="1" face="verdana" color="black"><b>&nbsp;Working
										or Not</b></font></td>
							<td colspan="4"><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
											key="app.otherCompName" /></b></font></td>
							<td rowspan="2"><font size="1" face="verdana" color="black"><b>&nbsp;<bean:message
											key="app.otherCompRemarks" /></b></font></td>
						</tr>
						<tr class="gridHeader">
							<td><font size="1" face="verdana" color="black"><b>Bleaching
										Powder</b></font></td>
							<td><font size="1" face="verdana" color="black"><b>Liquid
										Chlorine</b></font></td>
							<td><font size="1" face="verdana" color="black"><b>Gas
										Chlorine</b></font></td>
							<td><font size="1" face="verdana" color="black"><b>Online
										Dose</b></font></td>
						</tr>
						<nested:iterate id="ASSETPUMPSET_LIST" property="assetPumpSets"
							indexId="ndx">
							<%
								count = count + 1;
							%>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%=ndx%>">
								<nested:text name="ASSETPUMPSET_LIST" indexed="true"
										property="assetCode" styleClass="gridText" maxlength="0"
										style="width:0px" onkeypress="return textOnly()" /></td>

								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="otherCompCode" maxlength="3"
										styleClass="gridText" style="width:160px" readonly="true" /></td>
								<nested:hidden name="ASSETPUMPSET_LIST" indexed="true"
									property="habCode" />
								<!-- <td align="center">
		 			<nested:text name="ASSETPUMPSET_LIST" indexed="true" property="habCode" maxlength="4" styleClass="gridText" style="width:160px" readonly="true"/>
					<html:button property="addHab" value="..." styleClass="btext"
							 onclick='<%="javascript: fnPickHabitations(\"+ ndx +\")"%>' />
		</td> -->
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="compLocation" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="workingOrNot" styleClass="mycombo"
										style="width:50px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								</td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="bp" styleClass="mycombo"
										style="width:50px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								</td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="lc" styleClass="mycombo"
										style="width:50px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								</td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="gc" styleClass="mycombo"
										style="width:50px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								</td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="od" styleClass="mycombo"
										style="width:50px">
										<html:option value="">SELECT...</html:option>
										<html:option value="Y">YES</html:option>
										<html:option value="N">NO</html:option>
									</html:select></td>
								</td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="remarks" maxlength="50"
										styleClass="gridText" style="width:160px"
										onkeypress="upperOnly()" /></td>

							</tr>
						</nested:iterate>

					</table>
				</td>
			</tr>

			</table>
			</td>
			</tr>
			<tr>
				<td align="center" colspan="3">
					<center>
						<html:button property="mode" title="Add New" styleClass="btext"
							value="Add New" onclick="javascript: fnPickNewHabitations()" />
						<html:button property="mode" title="Remove" styleClass="btext"
							value="Remove" onclick="removeSubComps(this)" />
						<html:button property="mode" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc(this)" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</center>
				</td>
			</tr>
			</table>
			<input type="hidden" name="count" value="<%=count%>">
			<input type="hidden" name="subCompCode" value="otherCompCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='OandM'}">
		<html:form action="Asset.do?mode=Submit">
			<%
				int count = 0;
			%>
			<tr bgcolor="#8A9FCD" class="gridLabel">
				<td colspan=4 align=left><b>Component Name:&nbsp;<%=assetName%>
						- O AND M to <font color="white"><b><%=request.getParameter("assetName")%></b></font>
						- (<%=request.getParameter("habCode")%><%=request.getParameter("pumpCode")%>)
				</b></td>

			</tr>
			<tr>
				<td>
					<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000"
						border="1" style="border-collapse: collapse; margin-top: 0">

						<tr class="gridHeader">
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;select</b></font>
							</td>
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;Cost
										of Asset</b></font></td>
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;Agency</b></font><span
								class="mandatory">*</span></td>
							<td colspan=4 align="center"><font size="1" face="verdana"
								color="white"><b>&nbsp;Annual Cost (Rs. In Lakhs)</b></font></td>
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;Source
										Of <br>Funding
								</b></font><span class="mandatory">*</span></td>
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;No.
										Of Public <br>Stand Posts
								</b></font><span class="mandatory"></span></td>
							<td rowspan=2><font size="1" face="verdana" color="black"><b>&nbsp;No.
										Of House <br>Connections
								</b></font></td>
							<td colspan=2 align="center"><font size="1" face="verdana"
								color="white"><b>&nbsp;Amount (In Rupees)</b></font></td>
						</tr>
						<tr class="gridHeader">
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Power
										Cost</b></font></td>
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Consumables</b></font>
							</td>
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Wages&Others</b></font>
							</td>
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Total
										Cost of MTC</b></font><span class="mandatory">*</span></td>
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Tariff/<br>Month
								</b></font></td>
							<td><font size="1" face="verdana" color="black"><b>&nbsp;Total
										<br>Collection/Annum
								</b></font></td>
						</tr>
						<nested:iterate id="ASSETPUMPSET_LIST" property="assetPumpSets"
							indexId="ndx">
							<% count=count+1; %>
							<tr>
								<td width="40px" align="center"><input type="checkbox"
									name="remove" value="<%= ndx%>">
								<nested:text name="ASSETPUMPSET_LIST" indexed="true"
										property="oandmCode" styleClass="gridText" maxlength="0"
										style="width:0px" onkeypress="return textOnly()" /></td>
								<nested:hidden name="ASSETPUMPSET_LIST" indexed="true"
									property="habCode" />
								<nested:hidden name="ASSETPUMPSET_LIST" indexed="true"
									property="oandmCode" />
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="assetCost"
										value="<%=request.getParameter(\"costOfAsset\")%>"
										readonly="true" styleClass="gridText" /></td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="agencyCode" styleClass="mycombo"
										style="width:80px">
										<html:option value="">SELECT...</html:option>
										<html:option value="1">ZP</html:option>
										<html:option value="2">MANDAL</html:option>
										<html:option value="3">GP</html:option>
									</html:select></td>
								<td align=center>
									<%//System.out.println("4"); %> <nested:text
										name="ASSETPUMPSET_LIST" indexed="true" property="powerCost"
										maxlength="50" styleClass="gridText" style="width:50px"
										onkeypress="extractNumber2(this,7,1,false)"
										onkeyup='<%= "javascript: fnCalTotal1(\"+ ndx +\")"%>' />
								</td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="consumAnnum" maxlength="50"
										styleClass="gridText" style="width:50px"
										onkeypress="extractNumber2(this,7,1,false)"
										onkeyup='<%= "javascript: fnCalTotal1(\"+ ndx +\")"%>' /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="wagesAnnum" maxlength="50"
										styleClass="gridText" style="width:50px"
										onkeypress="extractNumber2(this,7,1,false)"
										onkeyup='<%= "javascript: fnCalTotal1(\"+ ndx +\")"%>' /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="total3" maxlength="50"
										styleClass="gridText" style="width:50px" readonly="true" /></td>
								<td align=center><html:select name="ASSETPUMPSET_LIST"
										indexed="true" property="sourceFund" styleClass="mycombo"
										style="width:80px">
										<html:option value="1">RWS</html:option>
										<html:option value="2">GP</html:option>
										<html:option value="3">MANDAL</html:option>
										<html:option value="4">ZP</html:option>
									</html:select></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="standPosts" maxlength="50"
										styleClass="gridText" style="width:50px"
										onkeypress="return numeralsOnly()" /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="houseConn" maxlength="50"
										styleClass="gridText" style="width:50px"
										onkeypress="extractNumber2(this,7,1,false)"
										onkeyup='<%= "javascript: fnCalTotal2(\"+ ndx +\")"%>' /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="tariffMonth" maxlength="50"
										styleClass="gridText" style="width:50px"
										onkeypress="extractNumber2(this,7,1,false)"
										onkeyup='<%= "javascript: fnCalTotal2(\"+ ndx +\")"%>' /></td>
								<td align=center><nested:text name="ASSETPUMPSET_LIST"
										indexed="true" property="total2" maxlength="50"
										styleClass="gridText" style="width:50px" readonly="true" /></td>
								<nested:hidden name="ASSETPIPELINE_LIST" indexed="true"
									property="assetCode" value="<%=assetCodee%>" />
							</tr>
						</nested:iterate>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="3">
				
					<center>
					<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
						<%if(count==1){ %>
						<html:button property="mode" title="Add New" styleClass="btext"
							value="Add New" disabled="true" />
						<%}
       	else
       	{
       	%>
						<html:button property="mode" title="Add New" styleClass="btext"
							value="Add New" onclick="javascript: fnPickNewHabitations1()" />
						<%} %>

						<html:button property="mode" title="Remove" styleClass="btext"
							value="Remove" onclick="removeSubComps(this)" />
						<html:button property="mode" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc(this)" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</center>
				</td>
			</tr>
			<input type="hidden" name="count" value="<%= count %>">
			<input type="hidden" name="subCompCode" value="oandmCode">
		</html:form>
	</c:if>
	<%@ include file="/commons/rws_alert.jsp"%>