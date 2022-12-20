
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
						property="circleCode"   styleClass="mycombo" style="width:130px"
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
					<td class="bwborder"><html:select   property="mandalCode"
						 multiple="true" styleClass="mycombo" style="width:160px;height:160px;"
						>
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="mandals">
							<html:options collection="mandals" name="labelValueBean"
								property="value" labelProperty="label" />
						</logic:notEmpty>
					</html:select></td>
					</tr>
			</table>