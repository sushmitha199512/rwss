<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>





<script language="JavaScript" type="text/javascript">
function funcDelete(habcode,schoolcode)
{	//alert("1");
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/School.do&mode=delete&habCode="+habcode+"&schoolCode="+schoolcode;
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
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="12">BaseLine Survey Schools List  </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					
				
                    <td class=clrborder align=center nowrap>Habitation</td>
                    <td class=clrborder align=center nowrap>School Name</td>
                     <td class=clrborder align=center nowrap>Dise Code</td>
                    <td class=clrborder align=center nowrap>Locality</td>
                    <td class=clrborder align=center nowrap>School Type</td>
                    <td class=clrborder align=center nowrap>School Category</td>
<td class=clrborder align=center nowrap>School Established 2007</td>
<td class=clrborder align=center nowrap>Boys Count</td>
<td class=clrborder align=center nowrap>Girls Count</td>
<td class=clrborder align=center nowrap>Sanitation Exist</td>
<td class=clrborder align=center nowrap>Sanitation Building Department</td>
<td class=clrborder align=center nowrap>Year Of Built</td>
<td class=clrborder align=center nowrap>Boys Toilet Count</td>
<td class=clrborder align=center nowrap>Girls Toilet Count</td>
<td class=clrborder align=center nowrap>Is Water Exist</td>
<td class=clrborder align=center nowrap>Sanitary Use</td>
<td class=clrborder align=center nowrap>Drinking Water Facility Available</td>
<td class=clrborder align=center nowrap>Bin Exist</td>
<td class=clrborder align=center nowrap>Pit Exist</td>
<td class=clrborder align=center nowrap>Survey Date</td>
<td class=clrborder align=center nowrap>Action</td>

                    
				
				</tr>
				<%
try{
	int count=0;
	
java.util.Collection a = (java.util.Collection)session.getAttribute("schools"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<logic:iterate id="COMPLIST" name="schools">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		
		<td class=bwborder align=left nowrap><%=count++%></td>
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="habCode" />/<bean:write
		name="COMPLIST" property="panchName" /><Br><html:hidden
		name="COMPLIST" property="schoolCode" /></td>
		
		 <html:hidden
		name="COMPLIST" property="dName"  /><html:hidden
		name="COMPLIST" property="mName"  /><html:hidden
		name="COMPLIST" property="pName"  /><html:hidden
		name="COMPLIST" property="vName"  />
		
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="schoolName"  /></td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="diseCode"  /></td>
		
		</td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="locality"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="schoolType"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="schoolCategory"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="schoolEstablieshed2007"  /></td>
		
		</td>

<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="boysCount"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="girlsCount"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="sanitaryExist"  /></td>
		
		</td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST"  property="sanitaryBuildingdept"  /></td>
		
		</td>

<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="yearofBuilt"  /></td>
		
		</td>

		<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="boystoiletCount"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="girlstoiletCount"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="isWaterExist"  /></td>
		
		</td>

<td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="sanitaryUse"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="drinkingwaterFacilityAvailable"  /></td>
		
		</td>
		

<td class="rptValue" align=center>
		<bean:write	name="COMPLIST" property="binExist"  /></td>
		
		</td>

<td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="pitExist"  /></td>
		
		</td>
		
<!-- <td class="rptValue" align=center>
		
		<bean:write	name="COMPLIST" property="schoolCode"  /></td> -->
		
		
		
				
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="surveyDate"  /></td>
		
		</td>
		<td class="rptValue" align=center>
		<a href="#1" onclick="openEditWindow('switch.do?prefix=/BaseLineSurvey&page=/School.do?mode=get&habCode=<bean:write name='COMPLIST' property='habCode'/>&schoolCode=<bean:write name='COMPLIST' property='schoolCode'/> ')">Edit&nbsp;|</a>&nbsp;
		<a href="#" onclick="funcDelete('<bean:write name='COMPLIST' property='habCode'/>','<bean:write name='COMPLIST' property='schoolCode'/>')">Delete</a>

 


</td> 
		
				
		</tr>
			</logic:iterate>
				
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=26 align=center>No Records</td>
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




