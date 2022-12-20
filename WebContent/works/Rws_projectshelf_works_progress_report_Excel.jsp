<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "ProgressReport.xls");

%>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@page import="nic.watersoft.works.rws_projectshelf_works_probabledt_frm"%>
<%

 System.out.println("RWSSDEPT");
int count = 1;

	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String rwsuserid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>





	<form action="aap1.do">

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="20"><B><font color="#FFFFFF">Ongoing Works </B></td>
<td align="center">
</td>
</tr>
<tr >
	<td class="clrborder" align="center" rowspan="2">S.No.</td>
	<td class="clrborder" align="center" rowspan="2">District</td>
	<td class="clrborder" align="center" rowspan="2">Division</td>
	<td class="clrborder" align="center" rowspan="2">Work ID</td>
	<td class="clrborder" align="center" rowspan="2">Work Name</td>
	<td class="clrborder" align="center" rowspan="2">Program Name/<br>SubProgram Name</td>
	<!-- <td class="clrborder" align="center">Sanction No</td> -->
	<td class="clrborder" align="center" rowspan="2">Sanction date</td>
	<td class="clrborder" align="center" rowspan="2">Est. Cost<br>(in lakhs)</td>
	<!-- <td class="clrborder" align="center">Category</td>
	<td class="clrborder" align="center">Work Type</td> -->
	<td class="clrborder" align="center" rowspan="2">Habs</td>
	<!-- <td class="clrborder" align="center">Source Code</td> -->
	<td class="clrborder" align="center" rowspan="2">Stipulated Date</td>
	<td class="clrborder" align="center" rowspan="2">Probable Date<font color="red"><b>*</b></font></td>
	
	<td class="clrborder" align="center" rowspan="2">Exp Upto Last Financial Year</td>
	<td class="clrborder" align="center" colspan="3">Exp During the Financial Year</td>
	<td class="clrborder" align="center" rowspan="2">Description</td>
	
	</tr>
	<tr>
	<td class="clrborder" align="center">Exp Upto Last Month</td>
	<td class="clrborder" align="center">Exp During the Month</td>
	<td class="clrborder" align="center">Total</td>
	</tr>
	
	<%
	/*String s=session.getAttribute("psWorks").toString();
	  if((java.util.ArrayList)session.getAttribute("viewworks")!=null){ */
	%>
	<logic:notEmpty name="PSWorkProbabledtForm" property="psWorks">
	<logic:iterate  id="psWorks" name="PSWorkProbabledtForm" property="psWorks" indexId="ndx">
	
	<tr align="left"  >
		<td class="bwborder"><%=count++%></td>
		<td  class="bwborder" ><bean:write name="psWorks" property="dname"/></td>
		<td  class="bwborder" ><bean:write name="psWorks" property="divname"/></td>
		<td  class="bwborder" ><bean:write name="psWorks" property="workId"/></td>
		<td  class="bwborder" ><bean:write name="psWorks" property="workName"/></td>
		
		<td class="bwborder"><bean:write name="psWorks" property="progName"/>/<br><bean:write name="psWorks" property="subprogName"/></td>
	
		<td  class="bwborder" ><bean:write name="psWorks" property="admnDate"/></td>
		<td  class="bwborder" align="right"><bean:write name="psWorks" property="admnAmnt"/></td>
		
		<td  class="bwborder" align="right" nowrap><bean:write name="psWorks" property="noofhabs"/>
			
			</td>
		
		
		
		<td nowrap><bean:write name="psWorks" property="stipulatedDate"/>
		
		<td nowrap><bean:write name="psWorks" property="probableDate"/>
		</td>
		
	
		<td  class="bwborder" align="right"><bean:write name="psWorks" property="expLastFinancialYear"/></td>
	<td  class="bwborder" align="right"><bean:write name="psWorks" property="expUptoLastMonth"/></td>
	<td  class="bwborder" align="right"><bean:write name="psWorks" property="expCurrentMonth"/></td>
	<td  class="bwborder" align="right"><bean:write name="psWorks" property="expTotal"/></td>
		
		
		<td  class="bwborder" align="right"><bean:write name="psWorks" property="description"/>
		<td class="bwborder" align=center>
	

	
				
				
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>


</table>
</form>