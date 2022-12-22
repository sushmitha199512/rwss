<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@page import="nic.watersoft.commons.Debug"%>
<%@page import="nic.watersoft.works.rws_works_WorkStatus_form"%>
<script language="javaScript">
function office1()
{
	document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=data";
	document.forms[0].submit();
}
function fnview()
{
      var workStage;
	  for(var i=0;i<document.forms[0].workStage.length;i++)
	   {
	    if(document.forms[0].workStage[i].checked)
	    {
	     workStage=document.forms[0].workStage[i].value;
	     }
     }

 // alert("workStage:"+workStage);
  if(document.forms[0].circleCode.value=="")
{
	alert("Please Select Circle");
	return false;
}
  if(workStage==undefined)
	{
	   alert("Please Select  Any One Of The  Work Stages");
	   return false;
	}else
	{
		document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=view";
        document.forms[0].submit();
	}

}
function fnExview()
{

	var width = 850;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
    var val="yes";
	 var workStage;
	  for(var i=0;i<document.forms[0].workStage.length;i++)
	   {
	    if(document.forms[0].workStage[i].checked)
	    {
	     workStage=document.forms[0].workStage[i].value;
	     }
     }

  //alert("workStage:"+workStage);
  if(document.forms[0].circleCode.value=="")
{
	alert("Please Select Circle");
	return false;
}
  if(workStage==undefined)
	{
	   alert("Please Select  Any One Of The  Work Stages");
	   return false;
	}else{
		 var cir=document.forms[0].circleCode.value;
          var url = "switch.do?prefix=/works&page=/workgap.do?mode=excelview&workStage="+workStage+"&circle="+cir+"&returnVal="+val;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
		  
		  //document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=excelview";
         //document.forms[0].submit();         
 
	}
}
/*var chlist = document.forms[0].mode1.length;
var count="";
var choice=0;
for(i=0;i<chlist;i++)
{
	//alert("i:"+i);
	
	//alert(document.forms[0].checkfield[i].checked)
  if (document.forms[0].mode1[i].checked == true)
  {
    // alert('CheckBox ' + i + ' is checked ')
	
	choice++;
	//count+=i+'$';
  
  }
    
}
if(document.forms[0].circleCode.value=="")
{
	alert("Please Select Circle");
	return false;
}
if(choice==0)
{
	alert("Please Select any one of Check Box");
	return false;
}
else{
 //alert("count:"+count);
 document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=view";
 document.forms[0].submit();
} */


function fnworksave()
{
	var stage='<%=request.getParameter("workStage")%>';
	//alert(stage);
	if(stage==01){
		var len=document.forms[0].adminNo.length;
		//alert("len:"+len);
		var value="";
		  if(len==undefined)
		  {
			 // alert("length is null");
			  var admin=document.forms[0].adminNo.value;
			 if(admin!="") 
			{
			  var workid=document.forms[0].workId.value;
			  value+=admin+'$'+workid+'*';
			}
		  }
		  else{

			 for(var i=0;i<len;i++)
			   {

			  var admin=document.forms[0].adminNo[i].value;
			  //alert(document.forms[0].workId.length);
			  if(admin!="") 
			  {
			  var workid=document.forms[0].workId[i].value;
			  value+=admin+'$'+workid+'*';
			  }
		   }
		}
		//alert("value:"+value);
		if(value=="")
		{
			alert("Please Provide at least one Admin No");
			 return false;
		}
		else{
		document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
		document.forms[0].submit();
		}
	}
	else if(stage==02){

		alert("Please Go to WorksMonitering Form ");
	/* alert("in stage 2");
	 var value="";
	 var len=document.forms[0].tsNo.length;
	 for(var i=0;i<len;i++)
		{
		  var tsno=document.forms[0].tsNo[i].value;
		  alert("tsno:"+tsno);
		  var tsdate=document.forms[0].tsDate[i].value;
		    alert("tsdate:"+tsdate);
		  var tsamt=document.forms[0].tsAmnt[i].value;
		 alert("tsamt:"+tsamt);
		  if(tsno!="" || tsdate!="" || tsamt!="")
			{
		      var workid=document.forms[0].workId[i].value;
		      value+=tsno+'$'+tsdate+'$'+tsamt+'$'+workid+'*';
			}
		}
		alert(value);
     document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
      document.forms[0].submit();*/
	}
	else if (stage==03)
	{
				var len=document.forms[0].tenderId.length;
				var value="";
			  if(len==undefined)
			   {
				 // alert("length is null");
				  var tenderId=document.forms[0].tenderId.value;
				 if(tenderId!="") 
				{
				  var tenderId=document.forms[0].workId.value;
				  value+=tenderId+'$'+workid+'*';
				}
			  }else {
					for(var i=0;i<len;i++)
					{
					   var tenderId=document.forms[0].tenderId[i].value;
					   if(tenderId!="")
						{
							var workId=document.forms[0].workId[i].value;
							value+=tenderId+'$'+workId+'*';
						}
					}
				}
				 document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
				 document.forms[0].submit();

	}
	else if (stage==04)
	{
			var len=document.forms[0].groundingdate.length;
			//alert(len);
			var value="";
			if(len==undefined)
			 {
				 // alert("length is null");
				var gdate=document.forms[0].groundingdate.value;
				 if(gdate!="") 
				{
				  var gdate=document.forms[0].workId.value;
				  value+=gdate+'$'+workid+'*';
				}
			  }
			else {
				 for(var i=0;i<len;i++)
				{
				 var gdate=document.forms[0].groundingdate[i].value;
				 alert("gdate:"+gdate);
				 if(gdate!="")
				 {
					var workId=document.forms[0].workId[i].value;
					value+=gdate+'$'+workId+'*';
				 }
			  }
			}
			//alert(value);
		if(value=="")
		{
           alert(" Please Provide At least  one Grounding Date");
		   return false;
		}
		else{
		 document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
		 document.forms[0].submit();
		}

	}
	else if (stage==05)
	{
		var len=document.forms[0].year.length;
		//alert(len);
		var value="";
		if(len==undefined){
             var year=document.forms[0].year.value;
			 var month=document.forms[0].month.value;
		     var expup=document.forms[0].expUp.value;
		     var expdur=document.forms[0].expDur.value;
			if(year!="" || month!="" || expup!="" || expdur!="" )
			{
			    var workId=document.forms[0].workId.value;
				value+=year+'$'+month+'$'+expup+'$'+expdur+'$'+workId+'*';
			}
		  }else {
		  for(var i=0;i<len;i++)
		   {
           var year=document.forms[0].year[i].value;
		   var month=document.forms[0].month[i].value;
		   var expup=document.forms[0].expUp[i].value;
		   var expdur=document.forms[0].expDur[i].value;
		   
		   if(year!="" || month!="" || expup!="" || expdur!="" )
			{
			    var workId=document.forms[0].workId[i].value;
				value+=year+'$'+month+'$'+expup+'$'+expdur+'$'+workId+'*';
			}
		}
		 //alert(value);
		}
	 document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
     document.forms[0].submit();

	}else if (stage==06)
	{
		var len=document.forms[0].completiondate.length;
		//alert(len);
		var value="";
         if(len==undefined){
             var cdate=document.forms[0].completiondate.value;
		  	
		    if(cdate!="")
			 {
			    var workId=document.forms[0].workId.value;
				value+=cdate+'$'+workId+'*';
			 }
		 }else {
		 for(var i=0;i<len;i++)
	    	{
              var cdate=document.forms[0].completiondate[i].value;
		  	
		    if(cdate!="")
			 {
			    var workId=document.forms[0].workId[i].value;
				value+=cdate+'$'+workId+'*';
			 }
		   }
		//alert(value);
		}
		if(value=="")
		{
			alert("Please Provide At least one Work Completion Date");
			return false;
		}
		else{
	         document.forms[0].action="switch.do?prefix=/works&page=/workgap.do?mode=save&value="+value;
             document.forms[0].submit();
		}

	}


	
}

/*function fnseelect()
{
	var workStage;
			   for(var i=0;i<document.forms[0].workStage.length;i++)
			   {
			    if(document.forms[0].workStage[i].checked)
			    {
			     workStage=document.forms[0].workStage[i].value;
			    }
			   }
}*/

</script>
<html:html>
<html:form action="/workgap.do?" method="post">
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="700" ><tr>
		<tr><td class="mycborder">
		<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value=" WorksMonitring Gap Report"/>
<jsp:param name="TWidth" value="100%"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="100%"><tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Office Details</legend>
		 <table  border=0  width="100%">
		 <tr><td><font color="#000000" face=verdana size=2><B>Circle <font color="red">*</font></B></font></td>
		<td> <html:select property="circleCode" style="width:135px"   onchange="office1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:present name="circles">
		 <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<td><font color="#000000" face=verdana size=2><B>Program </B></font></td>
		<td> <html:select property="progCode" style="width:135px"   onchange="office1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:present name="programs">
		 <html:options collection="programs" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
</td>
</fieldset>
</table>
</td>
</tr>
<td>
<tr> <tr>
		<td class="bwborder" >
		<fieldset>
		<legend> 
				<B>Work Stages</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr class="textborder">	
			<td><html:radio property="workStage" value="01" title="Click to view the Admin & Revised Sanction Details" /></td>	
			<td>Admin Sanction </td>
			<td><html:radio property="workStage" value="02" title="Click to view Tecnical & Revised Technical Sanction Details"/></td>	
			<td>Technical Sanction</td>
			<td><html:radio property="workStage" value="03" title="Click to view Contractor Management Details" /></td>	 
			<td>Contractor Management </td>
		    </tr>
		    <tr class="textborder">
			 <td><html:radio property="workStage" value="04" title="Click to view Programme Schedule Details" /></td>	 
			<td>Programme Schedule </td>
		   <td><html:radio property="workStage" value="05" title="Click to view Work Expenditure Details" /></td>	 
			<td>Work Expenditure </td>
			<td><html:radio property="workStage" value="06" title="Click to view Work Completion Details" /></td>
			<td>Work Completion </td>	
			
		    </tr>	
		   </table>
		   </label>
		 </fieldset>
		 </td> 
	</tr>
<tr><td align="center"><input type="button" value="view" name="submit1" class="btext" onclick="fnview()">
&nbsp;&nbsp;<input type="button" value="Excel view" name="submit1" class="btext" onclick="fnExview()"></td>
</tr>
<fieldset>
<%
String stage1=request.getParameter("workStage");
//System.out.println("sssssstage:"+stage1);
 if(stage1!=null && stage1.equals("01"))
 {%>

<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Sanctioned Amount(Rs.in Lakhs)</th>
			  	 
			</tr>
			</thead>
 <%}else if(stage1!=null && stage1.equals("02")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
			 style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Technical Sanction No</th>
				 <th>Technical Sanction Date</th>
				 <th>Technical Sanction Amount(Rs.in Lakhs) </th>
			  	 </tr>
			</thead>
			
			
	<%}else if(stage1!=null && stage1.equals("03")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Tender Id</th>
				 <th>Contactor Name</th>
				 <th>Aggrement Date</th>
				 <th>Aggrement Value</th>
				
			  	 </tr>
			</thead>
			
			
	<%}
	else if(stage1!=null && stage1.equals("04")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Grounding Date</th>
				
			  	 </tr>
			</thead>
			
			
	<%}
	else if(stage1!=null && stage1.equals("05")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Year</th>
				 <th>Month</th>
				  </tr>
			</thead>
			
			
	<%}
	
	
	else  if(stage1!=null && stage1.equals("06")){%>

<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
                <th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Date Of Completion</th>
			  	 
			</tr>
			</thead>


			<%}else{%>

			 
			<%}

 if((java.util.ArrayList)session.getAttribute("viewworks")!=null){

	// System.out.println(" sdsadsad");
	 int sno=0;
	 if(stage1!=null && stage1.equals("01")){
		 int i=0;%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true" /></FONT>
		</td>
		
		</tr>

</logic:iterate>
<tr>
<td align="center" colspan=10>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()"/>
</td>
</tr>
	<%} else if(stage1!=null && stage1.equals("02")){
			int i=1;%>
		<tr><td colspan=15><font color="red" size=2>Note:*** Please Go to Works Monitoring -Works Progress Phase to Update These Records</font></td></tr>
<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="divName" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="plan" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workCat" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="augType" readonly="true" style="width:100px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap><input type="text" name="tsNo"  style="width:100px"  readonly="true"></td>
		<td  class=mycborder1 nowrap><input type="text" name="tsDate" style="width:70px"   readonly="true"></td>
		<td  class=mycborder1 nowrap><input type="text" name="tsAmnt" style="width:70px"  readonly="true"></td>
		
		</tr>
		<%++i;%>
		
</logic:iterate>
<tr>
<td align="center" colspan=15>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()" disabled="true"/>
</td>
</tr>
<%} else if(stage1!=null && stage1.equals("03")){%>
<tr><td colspan=15><font color="red" size=2>Note:*** Please Go to Works Monitoring -Works Progress Phase to Update These Records</font></td></tr>
<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="divName" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="plan" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workCat" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="augType" readonly="true" style="width:100px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true"  style="width:70px"/></FONT>
		</td>
		<td  class=mycborder1 nowrap><input type="text" name="tenderId" style="width:70px" readonly="true"></td>
		<td  class=mycborder1 nowrap><input type="text" name="conaname" style="width:70px" readonly="true"></td>
		<td  class=mycborder1 nowrap><input type="text" name="Agrdate" style="width:70px" readonly="true"> </td>
		<td  class=mycborder1 nowrap><input type="text" name="Agrvalue" style="width:70px" readonly="true"></td>
		
		</tr>
</logic:iterate>
<tr>
<td align="center" colspan=10>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()" disabled="true"/>
</td>
</tr>
<% }
		
		 else if(stage1!=null && stage1.equals("04")){
			 int i=0;%>
<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="divName" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="plan" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workCat" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="augType" readonly="true" style="width:100px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true"  style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap><input type="text" name="groundingdate" style="width:70px"><a href="javascript: showCalendar(document.forms[0].groundingdate[<%=i%>]);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a></FONT></td>
		
		</tr>
		<%++i; %>
</logic:iterate>
<tr>
<td align="center" colspan=10>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()"/>
</td>
</tr>
<%
	}
		 else if(stage1!=null && stage1.equals("05")){
			%>
			<tr><td colspan=15><font color="red" size=2>Note:*** Please Go to Works Monitoring -Works Progress Phase to Update These Records</font></td></tr>
<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="divName" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="plan" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workCat" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="augType" readonly="true" style="width:100px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true"  style="width:70px"/></FONT>
		</td>
		<td  class=mycborder1 nowrap><input type="text" name="year" style="width:70px"  readonly="true"></td>
		<td  class=mycborder1 nowrap><input type="text" name="month" style="width:40px"  readonly="true"></td>
		
		
		</tr>
		
</logic:iterate>
<tr>
<td align="center" colspan=10>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()" disabled="true"/>
</td>
</tr>
<%
	}
		 else if(stage1!=null && stage1.equals("06")){
			 int i=0;%>
<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=++sno%></FONT></td>
<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text  name="rep" property="workId"  readonly="true"   style="width:110px"/></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workName"  readonly="true" style="width:500px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="divName" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="plan" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="workCat" readonly="true" style="width:70px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="augType" readonly="true" style="width:100px" /></FONT>
		</td>
	<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminNo"  style="width:100px" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="adminDate"  style="width:70px"/>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><html:text name="rep" property="samount" readonly="true"  style="width:70px"/></FONT>
		</td>
		<td  class=mycborder1 nowrap><input type="text" name="completiondate" style="width:70px"><a href="javascript: showCalendar(document.forms[0].completiondate[<%=i%>]);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a></FONT></td>
		
		
		</tr>
		<%i++; %>
</logic:iterate>
<tr>
<td align="center" colspan=10>
<input type=button name="savework" title="Save the Fields"  Class="btext" value="Save" onclick="fnworksave()"/>
</td>
</tr>
<%
	}
		
		}
		else{%>
			<fieldset>
		    </fieldset>
		<%}%>


</fieldset>
</td>
</tr>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
	<jsp:param name="Tborder" value="0"/>
</jsp:include>
</tr>
</table>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/commons/rws_alert.jsp" %>
</html:form>

</html:html>

