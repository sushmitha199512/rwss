<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html:html>

<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>

<html:form action="/contaminatedHabs.do">

<%


nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
	StringBuffer divCode=new StringBuffer();

	if(request.getParameter("divCode")!=null){
	divCode.append(request.getParameter("divCode"));
	}
	  session.setAttribute("divCode",divCode);


StringBuffer style=new StringBuffer();

int styleCount=0;

		%>


<table border = 0 cellspacing = 0 cellpadding = 0 width=70%   style="border-collapse:collapse"">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=70% align="right" >		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back|</a> 
                  <!--   <a href="rws_WQ_RFD_excel.jsp" target="_new">Excel</a>-->
                 
                 <a href="/pred/home.jsp?loginMode=watersoft">Home
                 </a>
                 
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class="gridhdbg" colspan="9"><b>Contaminated Habitations/Sources As Per Lab Testing(<%=session.getAttribute("financialYear") %>)</b></td>
		
		</tr>
      	<tr align=center>
		<td class="gridhdbg" align=center >Sl.No</td>
		<td class="gridhdbg" align=center >District</td>
		
	
  

<td class="gridhdbg" align=center >Contaminated Habs</td>
<td class="gridhdbg" align=center >Contaminated Sources<br> </td>
<td class="gridhdbg" align=center >TDS<br></td>
<td class="gridhdbg" align=center >Fluoride<br></td>
<td class="gridhdbg" align=center >Iron<br></td>
<td class="gridhdbg" align=center >Salinity<br></td>
<td class="gridhdbg" align=center >Nitrate<br></td>
</tr>


       <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		<td class="gridhdbg">4</td>
		<td class="gridhdbg">5</td>
		<td class="gridhdbg">6</td>
		<td class="gridhdbg">7</td>
		<td class="gridhdbg">8</td>
		<td class="gridhdbg">9</td>
			</tr>


		<%
		int slno=1;
		style.delete(0,style.length());
		if(styleCount%2==0){
				 style.append("gridbg1");
		}else{
			
			 style.append("gridbg2");
		}
		styleCount++;
		%>
		<logic:iterate id="ContaminatedDetails" name="ContaminatedDetails">
<tr>
<td class="<%=style.toString() %>" style="text-align: center;"><%=slno++%></td>
<td class="<%=style.toString() %>" style="text-align: center;"><bean:write name="ContaminatedDetails" property="district" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedHabsView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="contaminatedHabs" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedSourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="contaminatedSources" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedTdsSourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="tds" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedFlourideSourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="floride" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedIronSourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="iron" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedSelinitySourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="selinity" /></td>
<td class="<%=style.toString() %>" style="text-align: right;"><a href="#" onclick="viewWorks('/pred/wquality/contaminatedHabs.do?mode=contaminatedNitrateSourcesView&dcode=<bean:write name="ContaminatedDetails" property="dcode" />&dname=<bean:write name="ContaminatedDetails" property="district" />&financialYear=<bean:write name="ContaminatedDetails" property="financialYear" />')"><bean:write name="ContaminatedDetails" property="nitrate" /></td>
</tr>

<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="contaminatedHabs" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="contaminatedSources" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="tds" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="floride" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="iron" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="selinity" /></td>
<td class="gridhdbg" style="text-align: right;"><bean:write name="ContaminatedDetails" property="nitrate" /></td>
</tr>
</logic:iterate>
</table>

</html:form>

</html:html>

	  