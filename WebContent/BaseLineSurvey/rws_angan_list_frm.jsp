<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>





<script language="JavaScript" type="text/javascript">
function funcDelete(habcode,angancode)
{	//alert("1");
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/Angan.do&mode=delete&habCode="+habcode+"&angNum="+angancode;
	    document.forms[0].submit();
	}
}

function openEditWindow(url)
{
	
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}

</script>
<body>

<html:form action="/School.do" >
<table width=100%>
<tr><td align=right><html:link page="/School.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="home.jsp">Home</a></td>
</tr>
</table>


<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="12">BaseLine Survey Anganwadi List  </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					
				
                    <td class=clrborder align=center nowrap>Habitation</td>
                    <td class=clrborder align=center nowrap>Anganwadi Name</td>
                     <td class=clrborder align=center nowrap>Anganwadi Code</td>
                    <td class=clrborder align=center nowrap>Building Type Name</td>
                    <td class=clrborder align=center nowrap>Total Enrollment</td>
                    <td class=clrborder align=center nowrap>Availability Of Toilet Facility</td>
<td class=clrborder align=center nowrap>Building Department</td>
<td class=clrborder align=center nowrap>Year Of Built</td>
<td class=clrborder align=center nowrap>Sanitary Use</td>
<td class=clrborder align=center nowrap>Functional Reason</td>
<td class=clrborder align=center nowrap>Reason For Defunct</td>
<td class=clrborder align=center nowrap>Toilet Water Facility Available</td>
<td class=clrborder align=center nowrap>Drinking Water Exist</td>
<td class=clrborder align=center nowrap>Bin Available</td>
<td class=clrborder align=center nowrap>Pit Available</td>
<td class=clrborder align=center nowrap>Survey Date</td>
<td class=clrborder align=center nowrap>Action</td>

                    
				
				</tr>
				<%
try{
	int count=0;
	
java.util.Collection a = (java.util.Collection)session.getAttribute("angans"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<logic:iterate id="COMPLIST" name="angans">
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		
		<td class=bwborder align=left nowrap><%=count++%></td>
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="habCode" />/<bean:write
		name="COMPLIST" property="panchName" /><Br><html:hidden
		name="COMPLIST" property="anganNum" /></td>
		
		 <html:hidden
		name="COMPLIST" property="dName"  /><html:hidden
		name="COMPLIST" property="mName"  /><html:hidden
		name="COMPLIST" property="pName"  /><html:hidden
		name="COMPLIST" property="vName"  />
		
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="anganwadiName"  /></td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="anganCode"  /></td>
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="buildingTypename"  /></td>
		
		
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="totalEnrolment"  /></td>
		
		</td>
		
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="availabilityofToiletfacility"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="buildingDept"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="yearofBuilt"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="sanitaryUse"  /></td>
		
		</td>


		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="functionalReason"  /></td>
		
		</td>

<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="reasonforDefunct"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="toiletwaterFacilityavailable"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="drinkingWaterexist"  /></td>
		
		</td>
		
		

<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="binExist"  /></td>
		
		</td>

<td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="pitExist"  /></td>
		
		</td>
		
		
		
		
				
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="surveyDate"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<a href="#1" onclick="openEditWindow('switch.do?prefix=/BaseLineSurvey&page=/Angan.do?mode=get&habCode=<bean:write name='COMPLIST' property='habCode'/>&anganNum=<bean:write name='COMPLIST' property='anganNum'/> ')">Edit&nbsp;|</a>&nbsp;
		<a href="#" onclick="funcDelete('<bean:write name='COMPLIST' property='habCode'/>','<bean:write name='COMPLIST' property='anganNum'/>')">Delete</a>

 


</td> 
		
				
		</tr>
			</logic:iterate>
				
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=22 align=center>No Records</td>
	</tr>
	<%
	}
}catch(Exception p)
{
System.out.println("Exception in baseline status jsp:"+p);
}
%>
	</table>
	</td>
	</tr>
</html:form>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>




