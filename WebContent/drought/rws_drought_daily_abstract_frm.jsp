<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<%	 
	 	int count = 1;
 %>
<%
 	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	
%>

<%
     Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">

function autocompletion() {
	for (i = 0; i < document.forms.length; i++) {
		document.forms[i].setAttribute("AutoComplete", "off");
	}
}


function init()
{
toggleItem('collapse_myTbody1');
}

function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

function toggleItem(id)
{   
	itm = getItem(id);
	if(id=="collapse_myTbody2")
	var im = "onea";
	else if(id=="collapse_myTbody3")
	var im = "onec";
	else
	var im = "oneb";
	if(!itm)
	return false;
	if(itm.style.display == 'none'){
	itm.style.display = '';
	if (document.images[im]) {
	document.images[im].src = "/tgrwss/images/collapse.gif";
	}
	}    
	else{
	itm.style.display = 'none';
	if (document.images[im]) {
	document.images[im].src = "/tgrwss/images/expand.gif";
	}
	}	      
	return false;
	}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/drought&page=/dailyReprot.do?mode=data";
	document.forms[0].submit();
    
     
}

function getData3()
{   
    // alert("in viewwwwwwwwwwwwwww");
    
	document.forms[0].action="switch.do?prefix=/drought&page=/dailyReprot.do?mode=view";
	document.forms[0].submit();
    
}




function fnSave()
{
	
    var habitations1="";
	var district='<%=request.getParameter("dist")%>';
	var finyear='<%=request.getParameter("absDate")%>';	 
    var len=document.forms[0].resultCount.value;
	//alert(district+finyear);
	len = len-1;
	for( var j=0;j<len;j++)
	{     

            
			if(document.getElementById("COMPLIST["+j+"].checks").checked==true)
			{
				
				
				habitations1=habitations1+document.getElementById("COMPLIST["+j+"].trhabs").value;
                habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].trpopserv").value;
            	habitations1=habitations1+","+document.getElementById("complist["+j+"].trnooftrips").value;
                habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].trqty").value;
                habitations1=habitations1+","+document.getElementById("complist["+j+"].cathabs").value;
				habitations1=habitations1+","+document.getElementById("complist["+j+"].catpopserv").value;
				habitations1=habitations1+","+document.getElementById("complist["+j+"].catnooftrips").value;
				habitations1=habitations1+","+document.getElementById("complist["+j+"].catqty").value;
                habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].hshabs").value;
                habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].hssour").value;
				habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].hspopserv").value;
				habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].powhabs").value;
				habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].tothabs").value;
			
				
				habitations1=habitations1+","
			    
           
             
             
		     }
			 
			 
	}
    
	habitations1=habitations1+"D,";
	
	  if(habitations1=="D,")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	   
	     if(confirm("Are You Sure To Save The Record")) {
			  document.forms[0].hab1.value = habitations1;
	          document.forms[0].action="switch.do?prefix=/drought&page=/dailyReprot.do&mode=save&dist="+district;
              document.forms[0].submit();
			}
	  }
}


function addHabs()
{
 // alert(" i am adding");
 	var hab1;
	var hab2;
	var hab3;
	var tothabs;

 var len=document.forms[0].resultCount.value;
 len = len-1;
 tothabs=0;
	 for( var j=0;j<len;j++)
	 {     
	  hab1=document.getElementById("COMPLIST["+j+"].trhabs").value;
      hab2=document.getElementById("COMPLIST["+j+"].hshabs").value;
      hab3=document.getElementById("COMPLIST["+j+"].powhabs").value;
      tothabs=parseInt(hab1)+parseInt(hab2)+parseInt(hab3);
	  document.getElementById("COMPLIST["+j+"].tothabs").value=tothabs; 
	
	 }
}





</script>

<body onload="autocompletion()">
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="dailyReprot.do">


		<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />


<table cellpadding="0" cellspacing="0"  border="0" >
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Drought Daily Abstract Entry Form" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
   <tr>
   <td>

	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none"    style="border-collapse:collapse">

	    <tr>
	       <td class="textborder">		
		  	Date<html:text property="absDate" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
		    <a href="javascript:showCalendar(document.getElementById('absDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
            Districts<span class="mandatory">*</span><html:select property="dist" styleClass="mycombo" style="width:150px"  >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
	         <logic:present name="districts">
			<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
	        </logic:present >
			</html:select>
 			
<input type="button"  name="Save"   value="Submit" onclick="getData3();"></td>
      </tr>
      <tr>
		<td>
        <fieldset>
		<legend><bean:message key="legend.workDetails" /></legend>
		<label>
        </label>
       </fieldset>
	 	<table width="100%" cellpadding="0" cellspacing="0" border="1" bgcolor="#DEE3E0" >
		<thead class="gridHeader">
		<tr align="center">
		<th align="center" rowspan=3>Select</th>
		<th align=center rowspan=3>Sl.No</th>
		
		<th align=center colspan=8>Transportation</th>
		<th align=center colspan=3>Hiring of Private Sources</th>
		<th align=center>Power Problem(Low Voltage)</th>
		<th align=center >Total</th>
		</tr>
		<tr>
		
		<th align="center" colspan=4>Human Population</th>
		<th align="center" colspan=4>Live Stock (Cattle)</th>
		<th align="center" rowspan=2>NO.of.Habs</th>
		<th align="center" rowspan=2>No.of.Sources</th>
		<th align="center" rowspan=2>Population Served</th>
		
		<th align="center" rowspan=2>No.of.Habs</th>
		<th align="center" rowspan=2>No.of.Habs.</th>
        </tr>
        <tr>
        <th align="center">No.of.Habs</th>
		<th align="center">Population Served</th>
		<th align="center">No.of Tanker Trips</th>
		<th align="center">Quantity(KL)</th>
		<th align="center">No.of.Habs</th>
		<th align="center">Population Served</th>
		<th align="center">No.of Tanker Trips</th>
		<th align="center">Quantity(KL)</th>
        </tr>
		</thead>
	
<%
try{ 
java.util.Collection a = (java.util.Collection)session.getAttribute("hps"); 
//System.out.println("a*********"+a);
String st1=(String)session.getAttribute("st1");
	if( a != null && a.size() > 0)
	{
	%>
		
	<nested:iterate id="COMPLIST" name="hps" indexId="ndx">
	<tr bgcolor="#ffffff" align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
		<td>
	      	<html:checkbox name="COMPLIST" property="checks"   indexed="true"  />
		</td>
	    <td><%=count++%></td>
		<td class=bwborder  align=center  nowrap>
	        <html:text name="COMPLIST" property="trhabs" indexed="true" style="width:80px" onkeypress="return decimalsOnly(event)"/>
	    </td>
	     <td class=bwborder  align=center nowrap>
	           <html:text  name="COMPLIST" property="trpopserv" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	     </td>
	     
	      <td class=bwborder align=center nowrap>
	           <html:text  name="COMPLIST" property="trnooftrips" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	     </td>
			
		<td class=bwborder  align=center nowrap>
			  <html:text name="COMPLIST" property="trqty" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)" />
	   </td>
	
	
	<td class=bwborder  align=center  nowrap>
	        <html:text name="COMPLIST" property="cathabs" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"/>
	    </td>
	     <td class=bwborder  align=center nowrap>
	           <html:text  name="COMPLIST" property="catpopserv" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	     </td>
	     
	      <td class=bwborder align=center nowrap>
	           <html:text  name="COMPLIST" property="catnooftrips" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	     </td>
			
		<td class=bwborder  align=center nowrap>
			  <html:text name="COMPLIST" property="catqty" indexed="true"  style="width: 80px" onkeypress="return decimalsOnly(event)" />
	   </td>
	
	
	
	
		<td class=bwborder align=center nowrap>
				<html:text  name="COMPLIST" property="hshabs" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	   </td>

		<td class=bwborder  align=center nowrap>
				<html:text  name="COMPLIST" property="hssour" indexed="true"  style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	   </td>

		<td class=bwborder  align=center nowrap>
				<html:text  name="COMPLIST" property="hspopserv" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	   </td>

      <td class=bwborder  align=center nowrap>
				<html:text name="COMPLIST" property="powhabs" indexed="true" style="width: 80px" onkeypress="return decimalsOnly(event)" onblur="javascript:addHabs()"/>
	   </td>

       <td class=bwborder align=center nowrap bgcolor="#FF0000">
			<html:text  name="COMPLIST" property="tothabs" indexed="true" readonly="true" style="width: 80px" onkeypress="return decimalsOnly(event)"  />
	   </td>

	 </tr> 
					
  </nested:iterate>


	<%
	}
	
	else 
	{
	%>
	<tr>
	<td colspan=11 align=center>No Records</td>
	</tr>
	<%
	}
	

}catch(Exception p)
{
System.out.println("Exception in Abstract List:"+p);
p.printStackTrace();
}
%>

<table align="center">
<tr>
<td>
<%if(loggedUser.equals("1000DR")){ %>
<input type="button"  name="Save"   value="Save / View / Update" onclick="fnSave();">
<%}
else
{
 %>
<input type="button"  name="Save"   value="Save / View" onclick="fnSave();">

<%}%>
</td>
</tr>
</table>
<tr align=center>
	<td align="center" >
		<input type="hidden" name="resultCount" value="<%=count%>">
	
</td>
</tr>
<input type=hidden name=hab1>
</table>
</td>
</tr>
</table>
</html:form>
</body>
</html:html>

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