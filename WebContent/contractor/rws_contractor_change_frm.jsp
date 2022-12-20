<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function fnSea()
{
	      
       if(document.forms[0].workId.value=="" || document.forms[0].workId.value==null)
      { 
      alert("Enter WorkId");
      return false;
      }
      else
      {
      //return true;
        document.forms[0].action="switch.do?prefix=/contractor&page=/ContractorChange.do?mode=data"
		document.forms[0].submit;
      }
  }

function fnSea1()
{
	    if(document.forms[0].workId.value=="" || document.forms[0].workId.value==null)   
       {
       alert("Enter WorkId ");
       return false;
       }
       else if(document.forms[0].contractorCode.value=="" || document.forms[0].contractorCode.value==null)
       {
       alert("Select Contractor ");
       return false;
       }
       else
       {
        var value=confirm("Are you sure want to update Contractor  both in Selection and  Vouchers    ");
      // alert(value);
       if(value==false)
       {
        return false;
        }
else if(value==true)
{
      document.forms[0].action="switch.do?prefix=/contractor&page=/ContractorChange.do?mode=update";
	  document.forms[0].submit;

}
       
       }
       
       
        
}
function getData(variable)
{
var a=variable;
//alert(a);
 var url="switch.do?prefix=/contractor&page=/ContractorChange.do?contractorName="+variable+"&mode=display";
//alert(url);
document.forms[0].action=url;
document.forms[0].submit();

}


</script>
<body>

   <html:form action="ContractorChange.do">
   
   
   
<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
   

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" align="center">
<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Contractor Change Form 
	 </td>
	</tr>
<tr>
<%String numb=(String)request.getAttribute("workid"); %>
<td align=center>Work Id:<font color="#FF6666">*</font>:<html:text property="workId" 
 styleClass="mytext" style="width:95px"  value="<%=numb%>"  maxlength="14" size="14"  readonly="true"  />
 <!--<html:submit property="mode" title="Submit"  styleClass="btext"  onclick="return fnSea();"/>-->
 
</td>
</tr>

 <tr><td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="50%" align=center>
<tr  align=center>
<td class=clrborder colspan=9 >Works details</td>
</tr>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					<td class=clrborder align=center nowrap >Office</td>
				    <td class=clrborder align=center nowrap>Work Id</td>
                    <td class=clrborder align=center>Work Name</td>
                    <td class=clrborder align=center >Admin No</td>
                     <td class=clrborder align=center nowrap >Admin Date</td>
                    <td class=clrborder align=center nowrap>Sanction Amount( In Rs. Lakhs )</td>
                    <td class=clrborder align=center nowrap>Contractor Code</td>
                     <td class=clrborder align=center nowrap>Contractor Name</td>

                    
                    
				
				</tr>
				<%
try{
	int count=0;
java.util.Collection a = (java.util.Collection)session.getAttribute("works"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<nested:iterate id="COMPLIST" name="works" indexId="ndx">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
        <td class=bwborder align=left nowrap><%=count%></td>
		
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="officeEntered" indexed="true" /> <nested:write
		name="COMPLIST" property="officeEntered" /></td>
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="workId" indexed="true" /> <nested:write
		name="COMPLIST" property="workId" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="workName" indexed="true" /> <nested:write
		name="COMPLIST" property="workName" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="adminNo" indexed="true" /> <nested:write
		name="COMPLIST" property="adminNo" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="adminDate" indexed="true" /> <nested:write
		name="COMPLIST" property="adminDate" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="sanctionAmount" indexed="true" /> <nested:write
		name="COMPLIST" property="sanctionAmount" /></td>

		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="contractorCode" indexed="true" /> <nested:write
		name="COMPLIST" property="contractorCode" /></td>
        <td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="contractorName" indexed="true" /> <nested:write
		name="COMPLIST" property="contractorName" /></td>
		
				
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
p.printStackTrace();
}
%>
	</table>
	</td>
	</tr>

<tr>
<td>
<table align=center>	  	 	

<tr><td colspan="4" align="center">
				<font face="verdana" size="1" color=red>Select Contractor Alphabet Wise --></font>
				<font face="verdana" size="1">				
					
					
			<a href="#" class="blue" onclick="javascript:getData('a','conName');toggleRowColor(this);">A</a>
					<a href="#" class="blue" onclick="javascript:getData('b','conName');toggleRowColor(this);">B</a>
					<a href="#" class="blue" onclick="javascript:getData('c','conName');toggleRowColor(this);">C</a>
					<a href="#" class="blue" onclick="javascript:getData('d','conName');toggleRowColor(this);">D</a>
					<a href="#" class="blue" onclick="javascript:getData('e','conName');toggleRowColor(this);">E</a>
					<a href="#" class="blue" onclick="javascript:getData('f','conName');toggleRowColor(this);">F</a>
					<a href="#" class="blue" onclick="javascript:getData('g','conName');toggleRowColor(this);">G</a>
					<a href="#" class="blue" onclick="javascript:getData('h','conName');toggleRowColor(this);">H</a>
					<a href="#" class="blue" onclick="javascript:getData('i','conName');toggleRowColor(this);">I</a>
					<a href="#" class="blue" onclick="javascript:getData('j','conName');toggleRowColor(this);">J</a>
					<a href="#" class="blue" onclick="javascript:getData('k','conName');toggleRowColor(this);">K</a>
					<a href="#" class="blue" onclick="javascript:getData('l','conName');toggleRowColor(this);">L</a>
					<a href="#" class="blue" onclick="javascript:getData('m','conName');toggleRowColor(this);">M</a>
					<a href="#" class="blue" onclick="javascript:getData('n','conName');toggleRowColor(this);">N</a>
					<a href="#" class="blue" onclick="javascript:getData('o','conName');toggleRowColor(this);">O</a>
					<a href="#" class="blue" onclick="javascript:getData('p','conName');toggleRowColor(this);">P</a>
					<a href="#" class="blue" onclick="javascript:getData('q','conName');toggleRowColor(this);">Q</a>
					<a href="#" class="blue" onclick="javascript:getData('r','conName');toggleRowColor(this);">R</a>
					<a href="#" class="blue" onclick="javascript:getData('s','conName');toggleRowColor(this);">S</a>
					<a href="#" class="blue" onclick="javascript:getData('t','conName');toggleRowColor(this);">T</a>
					<a href="#" class="blue" onclick="javascript:getData('u','conName');toggleRowColor(this);">U</a>
					<a href="#" class="blue" onclick="javascript:getData('v','conName');toggleRowColor(this);">V</a>
					<a href="#" class="blue" onclick="javascript:getData('w','conName');toggleRowColor(this);">W</a>
					<a href="#" class="blue" onclick="javascript:getData('x','conName');toggleRowColor(this);">X</a>
					<a href="#" class="blue" onclick="javascript:getData('y','conName');toggleRowColor(this);">Y</a>
					<a href="#" class="blue" onclick="javascript:getData('z','conName');toggleRowColor(this);">Z</a>
			</td></tr>



</table>
</td>
</tr>
<tr>
<td>
<table align=center>
<tr>
	<td class="textborder" >
	Contractors<font color="#FF6666">*</font></td>
	<td class="textborder" >
		<html:select property="contractorCode" styleClass="mycombo" style="width:350px"  >
		<html:option value="">SELECT...</html:option>
        <logic:present name="contractors">
  	<html:options collection="contractors" name="rwsLocationBean" property="value" labelProperty="labelValue" />
    </logic:present >
		</html:select>
	
</td>
</tr>
</table>
</td>
</tr>
	
<tr align=center>
<td>
<html:submit property="mode" title="UpDate" value="Update" styleClass="btext"  onclick=" return fnSea1();"/>
</td>
</tr>
	

	
	
</table>

</html:form>
</html:html>

<p align="center">

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





