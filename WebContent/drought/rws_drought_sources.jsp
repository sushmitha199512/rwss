<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="AdminstrativeSanctionForm" />
<%

String proposalId=(String)session.getAttribute("sourceproposalId");
String index=(String)session.getAttribute("index");
String sourceedit=(String)session.getAttribute("sourcetype");
System.out.println("index............."+index);
System.out.println("source type value............."+sourceedit);
%>




<script language="JavaScript">
var sourcetype='<%=sourceedit%>';
// alert("sourcetype....."+sourcetype);
function getFormmandal()
{  //  alert("in sub page...............");
    var sourcetype='<%=sourceedit%>';
	var mcode = document.getElementById("mandalCode").value;
   //  alert(mcode);
	if(mcode=="")
	{
		alert("Select Mandal");
	}
	else
	{
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=sourceHabs&mcode="+mcode+"&type="+sourcetype;
       //   alert("in sub page..............."+url);
		document.forms[0].action=url;
		document.forms[0].submit();
	}
}

function getFormSource()
{   var sourcetype='<%=sourceedit%>';
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=sourceTypes&type="+sourcetype;
      //   alert("in sub page..............."+url);
		document.forms[0].action=url;
		document.forms[0].submit();
	
}

function getFormSrctype()
{       var sourcetype='<%=sourceedit%>';
        var subsourceType = document.getElementById("subcompType").value;
        /// alert("subsourceType..............."+subsourceType);
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=subSourceTypes&subcompType="+subsourceType+"&type="+sourcetype;
       //  alert("in sub page..............."+url);
		document.forms[0].action=url;
		document.forms[0].submit();
	
}


function getForm()
	{   var sourcetype='<%=sourceedit%>';
		document.getElementById('spradgroup').value='existNew';
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=newSource&type="+sourcetype;
		document.forms[0].action=url;
		document.forms[0].submit();
	}


function getSources()
{    // alert("i am in getting sources");
     var sourcetype='<%=sourceedit%>';
     var sourceHabCode = document.getElementById("sitehab").value;
     var sourceType = document.getElementById("subcompType").value;
     var subsourceType = document.getElementById("subSourceType").value;
      //  alert("values"+sourceHabCode+sourceType+subsourceType);
    
     var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=getSourceDetails&sourceHabCode="+sourceHabCode+"&sourceType="+sourceType+"&subsourceType="+subsourceType+"&type="+sourcetype;
    //  alert("in sub page..............."+url);
     document.forms[0].action=url;
	 document.forms[0].submit();
}


function sinsertForSourceIdentification()
{   var spid='<%=proposalId%>';
    var id='<%=index%>';
    var sourcetype='<%=sourceedit%>';
    // alert("sourceproposalId"+spid);
    var len=document.getElementById("resultCount").value;
	// alert(len);
	len = len-1;
	for( var j=0;j<len;j++)
	{ 
	  if(document.getElementById("SOURCE["+j+"].sourceSelected").checked==true)
		{
				
		     var sourceid=document.getElementById("SOURCE["+j+"].souCode").value;
		     var sourcename=document.getElementById("SOURCE["+j+"].souName").value;
		     var sourceloc=document.getElementById("SOURCE["+j+"].souLocation").value;
            //  alert("sourceid"+sourceid+sourcename+sourceloc);   
		}
       
    }
  		
     var sourceHabCode = document.getElementById("sitehab").value;
     var sourceType = document.getElementById("subcompType").value;
     var subsourceType = document.getElementById("subSourceType").value;
    //  var subsourceType = document.getElementById("subSourceType").value;
     // alert("sourceid"+sourceid+sourcename+sourceloc); 
     // alert("values"+sourceHabCode+sourceType+subsourceType);   
     if(sourceid == null )
{
     alert(" Make Sure you select atleast one of the Source Item ");
     return false;
}
            var openerDoc = opener.document;
			var frm = openerDoc.forms[0];
			frm.action = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=addSource&sourceHabCode="+sourceHabCode+"&sourceType="+sourceType+"&subsourceType="+subsourceType+"&sourceId="+sourceid+"&sourceName=" +sourcename+"&sourceLocation=" +sourceloc+"&spid=" +spid+"&index=" +id+"&type="+sourcetype;
			frm.submit();
			window.close();


}


function getSourceNot(that)
	{   var sourcetype='<%=sourceedit%>';
		var index=that.value;
		var sourceid=document.getElementById("SOURCE["+index+"].souCode").value;
        var sourcename=document.getElementById("SOURCE["+index+"].souName").value;
        var sourceloc=document.getElementById("SOURCE["+index+"].souLocation").value;
       //  alert("sourceid"+sourceid+sourcename+sourceloc);
		var url = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do?mode=addSourceDetails&sourceId="+sourceid+"&sourceName=" +sourcename+"&sourceLocation=" +sourceloc+"&type="+sourcetype;
		document.forms[0].action=url;
	    document.forms[0].submit();
       
	}

</script>

<% int resultCount = 1;%>
<html:form action="AdminstrativeSanction.do">
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none"   style="border-collapse:collapse">
<tr class="textborder">
		<td>
		<fieldset>
        <legend><font color=#871D0E face=verdana size=2><b>Source Identification</b></font></legend>
        <label>
		<table>
         <tr class="textborder">
 	     <td><font face=verdana size=2><b>Mandal</b></td>
 	     <td><html:select property="mandalCode" style="width:183px" styleClass="mycombo"  onchange="getFormmandal()">
	          <html:option value="">Please Select...</html:option>
              <logic:present name="mandals">
			 <html:options collection="mandals"   name="LabelValueBean" property="value" labelProperty="label"  />
             </logic:present>
			</html:select>
		</td>
		</tr> 

        <tr class="textborder">
		<td><font face=verdana size=2><b>Source Habitation</b><font color="#FF6666">*</font></td>
		<td><html:select property="sitehab" style="width:503px" styleClass="mycombo"  onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
            <logic:present name="sourceHabs">
			<html:options collection="sourceHabs" name="LabelValueBean" property="value" labelProperty="label" /> 
            </logic:present> 
			</html:select>
        </td>
        </tr>

        <tr class="textborder">
		<td><font face=verdana size=2><b>Source Type</b><font color="#FF6666">*</font></td>
			<td width="150">
			<html:select property="subcompType" style="width:183px"  styleClass="mycombo"  onchange="getFormSrctype()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="scTypes">
			 <html:options collection="scTypes"  name="LabelValueBean" property="value" labelProperty="label"  /> 
			 </logic:present>
			</html:select>
			</td>
            <td><font face=verdana size=2><b>Sub Source Type</b><font color="#FF6666">*</font></td>
			<td width="150">
			<html:select property="subSourceType" style="width:183px"  styleClass="mycombo" onchange="getSources()" >
			  <html:option value="">Please Select...</html:option>
		      <logic:present name="subSources">
			  <html:options collection="subSources" name="LabelValueBean" property="value" labelProperty="label" /> 
			 </logic:present>
		    </html:select>
			</td>
        </tr>
   <tr align="center">
   <td  bgcolor="#8A9FCD" align="center" colspan="3">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Source Details</font>	
	</td>
	</tr>
<tr align="center">
<td align="center" colspan="3">
  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="100%" align=center >
			 	
			<tr>
			    <td class=clrborder align=center >Select</td>			    			    
                <td class=clrborder align=center>Source Code</td>		
                <td class=clrborder align=center>Source Name</td>
                <td class=clrborder align=center>Source Location</td>
               
                				</tr>
      
    <%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("sourceDetails"); 
//System.out.println("A Size::"+a.size());

if(a != null && a.size() > 0)
{
%>

<nested:iterate id="SOURCE" property="sourceDetails" indexId="ndx" >
<% resultCount++; %>
	
	<tr><td  class=bwborder align=center>
	    <nested:radio name="SOURCE" property="sourceSelected" indexed="true" value="<%=String.valueOf(ndx)%>" />
	</td>
     <td  class=bwborder align=left><nested:write  name="SOURCE" property="souCode" /> 
      <nested:hidden name="SOURCE" property="souCode" indexed="true"/>
     </td>
      <td><nested:write name="SOURCE" property="souName"  />
         <nested:hidden name="SOURCE" property="souName" indexed="true"/>
	  </td>
	  <td><font style="font-family:verdana; font-size:8pt; color:#000000"><nested:write name="SOURCE" property="souLocation"  /></font>
         <nested:hidden name="SOURCE" property="souLocation" indexed="true"/>
	  </td>	
	</tr>
</nested:iterate>
<%
}
else 
{
%>
<tr>
<td colspan=4 align=center>No Records</td>
</tr>
<%
}
}catch(Exception e)
{
System.out.println("Exception"+e);
}
%>
</td>
</tr>
<tr align=center>
	<td align="center" >
		<input type="hidden" name="resultCount" value="<%=resultCount%>">
</td>
</table>
</tr>
      <tr>
			<td align=center colspan=4>
			<input type=button value=ADD onclick="sinsertForSourceIdentification()" class="bText"/>
			<!-- <input type=button value=Delete onclick="sfndelete()" class="bText"/>  -->
			</td>
	   </tr>
		
      
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		</table>
</html:form>

		