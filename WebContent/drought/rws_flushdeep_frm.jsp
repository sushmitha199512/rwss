<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:4px 0;
 }
.container img {
    width:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}



.on {
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>
<%

	 
	 	int count = 1;
 %>


<%

WorksData1 wd = new WorksData1();
int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">
function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/drought&page=/FlushDeep.do?mode=data";
	document.forms[0].submit();
    
     
}
function getDatadist()
{
    
	document.forms[0].action="switch.do?prefix=/drought&page=/FlushDeep.do?mode=data1";
	document.forms[0].submit();
    
     
}

function getData3()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/FlushDeep.do?mode=view";
	document.forms[0].submit();
    

}

function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
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
	document.images[im].src = "/pred/images/collapse.gif";
	}
	}    
	else{
	itm.style.display = 'none';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/expand.gif";
	}
	}	      
	return false;
	}
function getData4()
{

document.getElementById('OptionsDiv111').style.display='block';
}
function fnSave()
{
	
    var habitations1="";
	var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';
	var habcode='<%=request.getParameter("habCode")%>';
	//alert(habcode);
    
	//alert(district);
	//alert(mandal);
	
    var len=document.forms[0].resultCount.value;
	
		//alert(len);
	len = len-1;
	
    
	
	for( var j=0;j<len;j++)
	{     
		
	if(document.getElementById("COMPLIST["+j+"].checks").checked==true)
		{
				 

				habitations1=habitations1+document.getElementById("COMPLIST["+j+"].thabitationCode").value;
habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].hpCode").value;
habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].flushDeepening").value;
habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].flushDate").value;
habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].flushRemarks").value;
habitations1=habitations1+","+document.getElementById("COMPLIST["+j+"].flushDepth").value;
habitations1=habitations1+","



var s=document.getElementById("COMPLIST["+j+"].hpCode").value;
//alert(s);


if(document.getElementById("COMPLIST["+j+"].flushDate").value==0)
				{
	           alert("Please Enter  Date of Completion");

			   				return;
				}
				
				else if(document.getElementById("COMPLIST["+j+"].flushDepth").value==0)
				{
	           alert("Please Enter  Depth");

			   				return;
				}




		     }
			 
			 
	}
	habitations1=habitations1+"D,";
	
	  if(habitations1=="D,")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	   
	     if(confirm("Are You Sure To Save The Checked Borewels(s)/ Openwell(s) / Source(s)")) {
			  document.forms[0].hab1.value = habitations1;
	          document.forms[0].action="switch.do?prefix=/drought&page=/FlushDeep.do&mode=save&dist="+district+"&mand="+mandal+"&habCode="+habcode+"&hpcode="+s;
         document.forms[0].submit();
			}
	  }
}




</script>

<body  onload="javascript:init();">
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/FlushDeep.do">



<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />




<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name = "TableName" value="Flushing Deepening of Borewells / Openwells / Sources " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   styl e= " border-collapse:collapse;" width="100%" >


<td class="textborder" width="100">
	Drought Year<font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px"  >
		<option value="">-Select-</option>
		<%
		/* for(int i=2012;i<=year1;i++) */
		for(int i=year1;i>=2012;i--)
		
		{
			
			 String k =""+i;
			if(request.getParameter("year")!=null && request.getParameter("year").equals(k)) {
				
				
			%>
		<option value='<%=i%>' selected><%=i%></option>
		<%
		}
		else
		{%>
		<option value='<%=i%>'><%=i%></option>
		<%
		
		}
		}
			
		%>



		</select>
		</td>
	

 <!--<td class="textborder" width="100">
	Drought Year<font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="year" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
<html:option value="">SELECT...</html:option>
		<%
		/* Date date=new Date();
		int s=date.getYear();
		System.out.println("date is ====="+s);
		 */
	//	 int year = Calendar.getInstance().get(Calendar.YEAR);
	//	 int preyear=year-1;
		// System.out.println("preyear"+preyear);
		%>
		
		<html:option value="2015">2015</html:option><html:option value="2014">2014</html:option>
		<%-- <option value=<%=year %> selected="selected"><%=year %></option>
		<option value=<%=preyear %> selected="selected"><%=preyear %></option> --%>
        <logic:present name="years">
  	<html:options collection="years" name="rwsLocationBean" property="value" labelProperty="labelValue" />
    </logic:present >
		</html:select>
	</td> 
	
	
--></table>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="100%" >
<tr>
<td>
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
		</td>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="value" labelProperty="label" />
            </logic:present >
			</html:select>
	</td>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
	<td class="textborder" width="100">
	<bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="villages">
		<html:options collection="villages" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
		</tr>
		<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData3()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="habitations">
  	<html:options collection="habitations" name="rwsLocationBean" property="value" labelProperty="labelValue" />
    </logic:present >
		</html:select>
	</td>
    
	</tr>
		</table>
		</label>
	</fieldset>
	</td>
</tr>

	
  <tr><td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					<td class=clrborder align=center nowrap>HabCode</td>
				
                    <td class=clrborder align=center nowrap>Habitation</td>
                    <td class=clrborder align=center nowrap>Borewells/<br>Openwells /<br>Sources</td>
                     <td class=clrborder align=center nowrap>Location</td>
                    <td class=clrborder align=center nowrap>Status</td>
                    <td class=clrborder align=center nowrap>Flushing/Deepening</td>
                    <td class=clrborder align=center nowrap>Date of Completion<br>( Flushing / Deepening )</td>
                    <td class=clrborder align=center nowrap>Depth<br>( In Metres )</td>
					<td class=clrborder align=center nowrap>Remarks</td>
                    
				
				</tr>
				<%
try{
	
java.util.Collection a = (java.util.Collection)session.getAttribute("hps"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<nested:iterate id="COMPLIST" name="hps" indexId="ndx">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		<td >
      	<html:checkbox name="COMPLIST" property="checks"   indexed="true"  />
	    </td>

		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="thabitationCode" indexed="true" /> <nested:write
		name="COMPLIST" property="thabitationCode" /></td>
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="thabName" indexed="true" /> <nested:write
		name="COMPLIST" property="thabName" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="hpCode" indexed="true" /> <nested:write
		name="COMPLIST" property="hpCode" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="location" indexed="true" /> <nested:write
		name="COMPLIST" property="location" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="status" indexed="true" /> <nested:write
		name="COMPLIST" property="status" /></td>
		<td class="rptValue" align=center>
		<html:select name="COMPLIST"  property="flushDeepening" styleClass="mycombo" indexed="true"  style="width:150px">
		<html:option value="F"><font class="myfontclr1">FLUSHING</html:option>
		<html:option value="D"><font class="myfontclr1">DEEPENING</html:option>
		</html:select>
		</td>
		

						<TD class="bwborder" nowrap>
				    	
				    	<html:text name="COMPLIST"  property="flushDate"   
				    			   styleClass="mytext" style="width:100"   indexed="true"   />
				    			   <a href="javascript: showCalendarFuture(document.getElementById('COMPLIST[<%= count-2%>].flushDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
						  </a>
				    </TD>
		
	<td class="rptValue" width="100" align=center>  <html:text name="COMPLIST" size="2"  property="flushDepth" maxlength="4"  indexed="true"  onkeypress="numeralsOnly(event)"  />	
	</td>
    <td class="rptValue" width="100" align=center>  <html:text name="COMPLIST" size="25" maxlength="50"  property="flushRemarks"  indexed="true"    />	
	</td>
		</tr>
				</nested:iterate>
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%
	}
}catch(Exception p)
{
System.out.println("Exception in compaints status jsp:"+p);
}
%>
	</table>
	</td>
	</tr>
	

			
  
		   
  
  
<tr  >
<td align="center">
<input type="button"  name="Save"   value="Save" onclick="fnSave();">

<input type="hidden" name="resultCount" value="<%=count%>">
	<input type=hidden name=hab1>
	
</td>
</tr>


   



			
		

			
			
   
 

</table>

	   
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
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