<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>


<table>
			<tr>
					<td  >District<font color="#FF6666">*</font>
					<td class="textborder" ><html:select
						property="circleCode"  styleClass="mycombo" style="width:140px"
						onchange="javascript:getMandals()">
						<html:option value="">
							<font class="myfontclr1">SELECT...</font>
						</html:option>
						<logic:present name="circles">
							<html:options collection="circles" name="rwsLocationBean"
								property="value" labelProperty="label" />
						</logic:present>
					</html:select></td>
					<td  width="100">Mandal<font color="#FF6666">*</font>
					<td class="bwborder"><html:select  property="mandalCode"
						styleClass="mycombo" style="width:140px"
						onchange="javascript:getPanchayats()">
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="mandals">
							<html:options collection="mandals" name="labelValueBean"
								property="value" labelProperty="label" />
						</logic:notEmpty>
					</html:select></td>
					<td  width="100">Panchayat<font color="#FF6666">*</font>
					<td class="textborder" width="150"><html:select
						property="panchayathCode"   styleClass="mycombo" style="width:130px"
						onchange="javascript:getVillages()">
						<html:option value="">
							<font class="myfontclr1">SELECT...</font>
						</html:option>
						<logic:present name="panchayats">
							<html:options collection="panchayats" name="rwsLocationBean"
								property="value" labelProperty="label" />
						</logic:present>
					</html:select></td>
				</tr>
				<tr>
					<td  width="100">Village<font color="#FF6666">*</font>
					<td class="bwborder"><html:select  property="villageCode"
						styleClass="mycombo" style="width:140px"
						onchange="javascript:getHabs()">
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="villages">
							<html:options collection="villages" name="rwsLocationBean"
								property="value" labelProperty="label" />
						</logic:notEmpty>
					</html:select></td>

					<TD ><bean:message key="app.habCode" /><font
						color="#FF6666">*</font></TD>
					<TD colspan=3 class="bwborder"><html:select  multiple="true" property="habCode"
						styleClass="mycombo" style="width:280px;height:200px;"
						onchange="javascript:getSourceDetails()">
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="habitations">
							<html:options collection="habitations" name="rwsLocationBean"
								property="value" labelProperty="label" />
						</logic:notEmpty>
					</html:select></TD>


				</tr>
			</table>