 <%@ include file="/commons/rws_header1.jsp" %> 
<html>
<head>
<script>
function circleClicked(ndx)
{
var circle=document.getElementById("FORWARDTO_LIST["+ndx+"].value").value;
var officeType='<%= request.getAttribute("officeType")%>';
document.forms[0].action="/pred/proposals/ShowForwardToOffices.do?mode=divisions&circle="+circle+"&officeType="+officeType;
document.forms[0].submit();
}

function divisionClicked(ndx)
{
var officeType='<%= request.getAttribute("officeType")%>';
var circle='<%= request.getAttribute("circle")%>';

var division=document.getElementById("FORWARDTO_LIST["+ndx+"].value").value;
if(officeType!='division')
{


document.forms[0].action="/pred/proposals/ShowForwardToOffices.do?mode=subdivisions&circle="+ circle + "&division="+division;
document.forms[0].submit();
}else{
var divisionName=document.getElementById("FORWARDTO_LIST["+ndx+"].label").value;
if(opener.document.forms[0].forwardDivisionOffice.value!="")
opener.document.forms[0].forwardDivisionOffice.value=opener.document.forms[0].forwardDivisionOffice.value+" , ";
opener.document.forms[0].forwardDivisionOffice.value=opener.document.forms[0].forwardDivisionOffice.value+divisionName;

if(opener.document.forms[0].forwardToDivision.value!="")
opener.document.forms[0].forwardToDivision.value=opener.document.forms[0].forwardToDivision.value+",";
opener.document.forms[0].forwardToDivision.value=opener.document.forms[0].forwardToDivision.value+"1"+circle+division+"00";
self.close();

}

}
function subDivisionClicked(ndx)
{
var circle='<%= request.getAttribute("circle")%>';

var division='<%= request.getAttribute("division")%>';
var officeType='<%= request.getAttribute("officeType")%>';

var subDivision=document.getElementById("FORWARDTO_LIST["+ndx+"].value").value;
var subDivisionName=document.getElementById("FORWARDTO_LIST["+ndx+"].label").value;

if(opener.document.forms[0].forwardSubDivisionOffice.value!="")
opener.document.forms[0].forwardSubDivisionOffice.value=opener.document.forms[0].forwardSubDivisionOffice.value+" , ";
opener.document.forms[0].forwardSubDivisionOffice.value=opener.document.forms[0].forwardSubDivisionOffice.value+subDivisionName;

if(opener.document.forms[0].forwardToSubDivision.value!="")
opener.document.forms[0].forwardToSubDivision.value=opener.document.forms[0].forwardToSubDivision.value+",";
opener.document.forms[0].forwardToSubDivision.value=opener.document.forms[0].forwardToSubDivision.value+"1"+circle+division+subDivision;

self.close();

document.forms[0].action="/pred/proposals/ShowForwardToOffices.do?mode=subdivisions&circle="+ circle + "&division="+division+"&subDivision="+subDivision+"&subDivisionName="+subDivisionName;
document.forms[0].submit();
}
</script>
</head>
<BODY>
<html:form action="ShowForwardToOffices">
<%int count=0; %>
<html:hidden property="circle"/>
<html:hidden property="division"/>
<html:hidden property="subDivision"/>
<c:if test="${requestScope.display=='circles'}">
<table bgcolor="#FFFFFF"  bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	    <thead class="gridHeader">
	    <tr>
	    <th width="50" align="center"> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Select</b></font>
		</th> 
	    <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Circle</b></font>
		</th> 
		
	    </tr>
	
    <nested:iterate id="FORWARDTO_LIST" property="paramList" indexId="ndx">
	  
		 <tr class='<c:out value="row${ndx%2}"/>'>
		
		 <td  width="50" align="center">
		  <input type="radio" name="remove" value="<%= ndx%>"  onclick="circleClicked('<%= ndx%>')">
		  </td>
		  <td width="250">
		  <bean:write name="FORWARDTO_LIST"  property="label"   />
		  <html:hidden name="FORWARDTO_LIST" property="value" indexed="true"/>
		   
		</td>
		
		
		
	</tr> 
        </nested:iterate>
    
        <%request.setAttribute("count",count+""); %>
        
		 </thead> 
         </table>
   </c:if>
   
   <c:if test="${requestScope.display=='divisions'}">
<table bgcolor="#FFFFFF"  bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	    <thead class="gridHeader">
	    <tr>
	    <th width="50" align="center"> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Select</b></font>
		</th> 
	    <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Division</b></font>
		</th> 
		
		
	    </tr>
	
    <nested:iterate id="FORWARDTO_LIST" property="divisionList" indexId="ndx">
	  
		 <tr class='<c:out value="row${ndx%2}"/>'>
		
		 <td  width="50" align="center">
		  <input type="radio" name="remove" value="<%= ndx%>" onclick="divisionClicked('<%= ndx%>')">
		  </td>
		  <td width="250">
		  <html:hidden name="FORWARDTO_LIST"  property="label"  indexed="true"/> 
		  <bean:write name="FORWARDTO_LIST"  property="label"   />
		  <html:hidden name="FORWARDTO_LIST" property="value" indexed="true"/> 
		</td>
		
		
		
	</tr> 
        </nested:iterate>
    
        <%request.setAttribute("count",count+""); %>
        
		 </thead> 
         </table>
   </c:if>
   
   <c:if test="${requestScope.display=='subdivisions'}">
<table bgcolor="#FFFFFF"  bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	    <thead class="gridHeader">
	    <tr>
	    <th width="50" align="center"> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Select</b></font>
		</th> 
	    <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;SubDivision</b></font>
		</th> 
		
		
	    </tr>
	
    <nested:iterate id="FORWARDTO_LIST" property="subDivisionList" indexId="ndx">
	  
		 <tr class='<c:out value="row${ndx%2}"/>'>
		
		 <td  width="50" align="center">
		  <input type="radio" name="remove" value="<%= ndx%>" onclick="subDivisionClicked('<%= ndx%>')">
		  </td>
		  <td width="250">
		  <html:hidden name="FORWARDTO_LIST"  property="label"  indexed="true"/> 
		  <bean:write name="FORWARDTO_LIST"  property="label"  />
		  <html:hidden name="FORWARDTO_LIST" property="value" indexed="true"/>
		</td>
		
		
		
	</tr> 
        </nested:iterate>
    
        <%request.setAttribute("count",count+""); %>
        
		 </thead> 
         </table>
   </c:if>
</html:form>	   
</BODY>
</html>
