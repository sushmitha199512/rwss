<%@ include file="/commons/rws_header1.jsp" %>
<%
java.util.ArrayList carry = (java.util.ArrayList)session.getAttribute("carryResults");
if(carry!=null   && carry.size()>0)
{
for(int i = -1;i<carry.size()-1;)
{
i = i + 3;
}
}
String tcodes = request.getParameter("testCode");
String tcode = "0";
if(tcodes.equals("1"))tcode="35";else if(tcodes.equals("2"))tcode="2";
String testId = request.getParameter("testId");

String scode=request.getParameter("sourceCode");
%>

<script language="javascript">

function checkMandatory(names,displaymessage)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;
	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	
	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		
		if(parseFloat(values)<parseFloat(min))
		{
			alert(displaymessage+" Must be greater than or equal to "+min);
			flags = false;
		}
		else if(parseFloat(values)>parseFloat(max))
		{
			alert(displaymessage+" Must be less than or equal to "+max);
			flags = false;
		}
		else
		{
			flags = true;
		}
	}
	return flags;
}
function checkMandatoryAndRanges1(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	names = parseInt(names)-1;
	var values1 = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	if(values==null || values=="")
	{
		alert("Please Enter the value for "+displaymessage);
	}
	else
	{
		if(parseFloat(values1)<parseFloat(values))
		{
			alert("Total Hardness(Value:"+values+") must be less than Dissolved Solids(Value:"+values1+")");
		}
		else
		{
			flags = true;
		}
	}
	return flags;
}
function checkMandatoryAndRanges2(names,displaymessage,max)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	if(parseFloat(max)<parseFloat(values))
	{
		alert(displaymessage+"(Value:"+values+") must be less than Totalhardness(Value:"+max+")");
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges3(names,displaymessage,min,max)
{
	var flags = false;
	var values = document.getElementById("TESTPARAM_LIST["+ names +"].result").value;	
	if(parseFloat(values)<parseFloat(min))
	{
		alert(displaymessage+" Must be greater than or equal "+min);
		flags = false;
	}
	else if(parseFloat(values)>parseFloat(max))
	{
		alert(displaymessage+" Must be less than or equal "+max);
		flags = false;
	}
	else
	{
		flags = true;
	}
	return flags;
}
function checkMandatoryAndRanges4(names,displaymessage,min,max)
{
	var flags = false;
	if(parseFloat(min)<parseFloat(max))
	{
		alert("Dissolved Solids Value should be greater than the Sum of Total Hardness & Chloride");
		flags = false;
	}
	else
	{
		flags = true;
	}
	return flags;
}
function fnAdd1()
{
	var flag=false;
	var testCode = '<%=tcodes%>';
	if(testCode=="1")
	{
    	if(checkMandatoryAndRanges('3','pH Ranges',6,9)==true)
    	{
    		if(checkMandatory('4','Dissolved Solids')==true)
    		{
        		if(checkMandatoryAndRanges1('5','Total Hardness')==true)
        		{
	        		if(checkMandatory('6','Alkalinity')==true)
    				{
    					if(checkMandatoryAndRanges2('7','Calcium',document.getElementById("TESTPARAM_LIST[5].result").value)==true)
    					{
        					if(checkMandatoryAndRanges2('8','Magnesium',document.getElementById("TESTPARAM_LIST[5].result").value)==true)
        					{
	        					if(checkMandatory('9','Chloride')==true)
    							{
    								if(checkMandatoryAndRanges('10','Fluoride',0,20)==true)
    								{
										if(checkMandatoryAndRanges('11','Sulphate',0,400)==true)
	        								   {
        								if(checkMandatoryAndRanges('12','Nitrate',0,999)==true)
        								{
	        								if(checkMandatoryAndRanges('13','Iron',0,10)==true)
	        								{
                                              
		        								if(checkMandatoryAndRanges3('14','Manganese',0,99)==true)
		        								{
			        								if(checkMandatoryAndRanges3('15','Residual Chlorine',0,9)==true)
			        								{
				        								if(checkMandatoryAndRanges4('','',document.getElementById("TESTPARAM_LIST[4].result").value,parseFloat(document.getElementById("TESTPARAM_LIST[5].result").value)+parseFloat(document.getElementById("TESTPARAM_LIST[9].result").value))==true)
			        									{
			        										flag = true;
			        									}
				        							}
			        							}
		        							}
                                         }//ADDED
	        							}
        							}
    							}
	        				}
        				}
    				}
        		}
    		}
    	}
	 }
	 else if(testCode=="2")
	{
    	if(checkMandatoryAndRanges('0','MPN Coliform Bacteria',0,1609)==true)
    	{
    		if(checkMandatoryAndRanges3('1','E-Coli',0,24)==true)
    		{
    			flag = true;
    		}
    	}
    }
	if(flag==true)
	{
		var testIdd = '<%=testId%>';
		var url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=saveQT&testId="+testIdd;
		document.forms[0].action=url;
		document.forms[0].submit();
		//window.close();
	}




}


function ValidNumber(value) {

if(!isNaN(document.getElementById("TESTPARAM_LIST["+value+"].result").value)){
	return true;
}else{
document.getElementById("TESTPARAM_LIST["+value+"].result").value="";
//document.getElementById("TESTPARAM_LIST["+value-1+"].result").focus;
   alert("invalid number");
  return false;
}
   
}



      function ValidNumber1(value){  

  if(!isNaN(document.getElementById("TESTPARAM_LIST["+value+"].result").value))
	{
    	 alert("inivalid number");
		  return false;
	}else{
		return true;
}




         if(document.getElementById("TESTPARAM_LIST["+value+"].result").value==""){return true;}
       // var regEx = /^\d{1,2}\.\d{1,2}$/;  
        //var regEx = /^\d{3}\.\d{3}$/;  
         var regEx="/[0-9]{3}\.[0-9]{2}$/";
        bValid = document.getElementById("TESTPARAM_LIST["+value+"].result").value.match(regEx);  

        if(!bValid){  
alert('incorrect format');
document.getElementById("TESTPARAM_LIST["+value+"].result").value="";
document.getElementById("TESTPARAM_LIST["+value+"].result").focus;
          return false;           
        }  
        else return true;  
      }  




            function IsNumeric(input) {
		    return /^-?(0|[1-9]\d*|(?=\.))(\.\d+)?$/.test(input);
			}


     
</script>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8" >
<html:form action="WaterSampleRes.do?mode=Save">

<table align=center width="100%">
	<tr>
		<td align=right>
			<a href="javascript:window.close()">Close</a>
		</td>
	</tr>
	<tr>
		<td>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td  class="textborder" nowrap>
						District Name:&nbsp;<bean:write name="districtName" scope="request" />
					</td>
					<td  class="textborder" nowrap>
						&nbsp;Mandal Name:&nbsp;<bean:write name="mandalName" scope="request" />
					</td>
					<td  class="textborder" nowrap>
						&nbsp;Habitaiton Name:&nbsp;<bean:write name="habitationName" scope="request" />
					</td>
					<%if(scode!=null && !scode.equals(""))%>
					<td  class="textborder" nowrap>
						&nbsp;&nbsp;Source Location:&nbsp;<%=scode%>&nbsp;-&nbsp;<bean:write name="sourceLocation" scope="request" />
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td colspan=7 class="textborder">
						<font color="#ffffff">Water Quality Parameters List (As Per IS 10500:1991 Edition 2.2 (2003-09)</font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">SNo</td>
					<td align=center class="clrborder">Test Name</td>
					<td align=center class="clrborder">Parameter Name</td>
					<td align=center class="clrborder">Min Per Val</td>
					<td align=center class="clrborder">Max Per Val</td>
					<td align=center class="clrborder">Undesired Effect</td>
					<td align=center class="clrborder">Result</td>
				</tr>
				<%int count1=1; 
				  int val = -1;%>
				
				<nested:iterate id="TESTPARAM_LIST" property="wqtestParams">
				<tr align="left" bgcolor="#ffffff">
					<td  class="bwborder"><%=count1%></td>
					<td  class="rptValue">
						<nested:hidden name="TESTPARAM_LIST" property="testId" indexed="true"  />
						<bean:write name="TESTPARAM_LIST" property="testName"  />
					</td>
					<td  class="bwborder" >
						<nested:hidden name="TESTPARAM_LIST" property="testPCode" 
									   indexed="true"/> 
						<bean:write name="TESTPARAM_LIST" property="testPName"  />
					</td>
					<td  class="bwborder" align=center>
						<bean:write name="TESTPARAM_LIST" property="minPerVal" />
					</td>
					<td  class="bwborder" align=center>
					<bean:write name="TESTPARAM_LIST" property="maxPerVal" />
					</td>
					<td  class="bwborder" align=left width="200px">
						<bean:write name="TESTPARAM_LIST" property="undesirableEffect"/>
					</td>
					<%
					val = val + 3; %>
					<td class="bwborder" align=center>
					<nested:text name="TESTPARAM_LIST" property="result" styleClass="mytbltext" style="width:70px" indexed="true" maxlength="9" onblur='<%="return ValidNumber("+(count1-1)+")"%>' />
					</td>
				</tr>
				<%count1++; %>
				</nested:iterate>
				<tr>
					<td align=center colspan="7">
						<html:button property="save" title="Save Results"  styleClass="btext" value="Add" onclick="fnAdd1()"/>
				
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
	<tr bgcolor="#8A9FCD" >
		<td colspan=7 class="textborder">
			<font color="#ffffff">Water Quality Parameters Test(s) Last Updated</font>
		</td>
	</tr>
	<tr>
		<td align=center class="clrborder">SNo</td>
		<td align=center class="clrborder">Updated Date</td>
		<td align=center class="clrborder">Test Id</td>
		<td align=center class="clrborder">Test Name</td>
		<!-- <td align=center class="clrborder">Potable</td> -->
		<td align=center class="clrborder">Recommendations</td>
	</tr>
	<%int count=-1; 
	%>
	<logic:iterate id="waterPtestUpdateList" name="updateParameters">
    <%count++;
    int index = count+1;
    java.util.ArrayList testIds = new java.util.ArrayList();
    testIds = (java.util.ArrayList)session.getAttribute("testids");
     %>
    
    <tr align="left" bgcolor="#ffffff">
    <td  class="bwborder"><%=index%></td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="preparedOn" />
		</td>
		<td  class="bwborder" >
			<a href="switch.do?prefix=/wquality&page=/WaterSampleRes.do?mode=updateTests&testid=<%=testIds.get(count)%>" target="_blank" title="Click to get Water Quality Parameters List "><bean:write name="waterPtestUpdateList" property="testId"/></a>
		 </td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="testName" />
		</td>
		<td  class="bwborder" align="center" >
			<bean:write name="waterPtestUpdateList" property="condemnSource" />
		</td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="recommendations" />
		</td>
				
	</tr>
	</logic:iterate>
	<%if(count==-1){ %>
	<tr><td colspan="10" align="center">No Records</td></tr>
	<%} %>
</table>
<script>
var cc = '<%=count1-1%>';
for(var i=0; i<cc; i++)
{
	<c:forEach items="${parameters1}" var="item">
		var val = '<c:out value="${item.testPCode}" />';
		var res = '<c:out value="${item.result}" />';
		if(document.getElementById("TESTPARAM_LIST["+i+"].testPcode").value == val)
		{
			document.getElementById("TESTPARAM_LIST["+i+"].result").value = res;
		}
	</c:forEach>	
}
</script>

</html:form>
</body>
