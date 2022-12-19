<%
String count1 = request.getParameter("count");
String get = request.getParameter("get");
String distName = (String)request.getAttribute("distName");
String year = (String)request.getAttribute("year");

String dist=request.getParameter("dname");
		
//System.out.println("dist:"+dist);

int length = 0;
//System.out.println("work_id::"+request.getParameter("work_id"));
if(request.getParameter("work_id") != null)
{
	String wid = request.getParameter("work_id");
	length = wid.length();
}
//System.out.println("workId length:"+length);
%>
<%@ include file="/commons/rws_header1.jsp" %>
<html>

<script language="javascript">
function init()
{
var get = <%=get%>;
var wId = <%=length%>;

if(get == "0" && wId == 0)
{
//document.forms[0].district.value="";
//document.forms[0].year.value="";
}
}

function getSubmit()
{
	var myCounts = <%=count1%>;
	//alert("counts:"+myCounts);
	var district = '<%=request.getAttribute("district")%>';
	var dname = '<%=dist%>';
	var div=document.forms[0].division.value;
	var division=div;
	var wrkcat=document.forms[0].workCategory.value;
	var program=document.forms[0].program.value;

	if(div=="" )
	{
		alert("Please Select Division ");
	}
	else
	{
	 document.forms[0].action="switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=workId&district="+district+"&get=1&count="+myCounts+"&special=1&program1="+program+"&wrkcat1="+wrkcat+"&division="+division+"&dname="+dname;
		document.forms[0].submit();
	}
}

function getParameters(that)
{
	var index=that.value;
	//alert(index);
	var myCount = <%=count1%>;
	var openerDoc = opener.document;
	var work_id = document.getElementById("TESTPARAM_LIST["+index+"].work_id").value;
	
	if(that.checked)
	{
		//alert(index);
		var  url="switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=getDivisions&workId="+work_id+"&count="+myCount+"&special=1";
		openerDoc.forms[0].action = url;
		openerDoc.forms[0].submit();
		window.close();
	}
}
</script>

<body topmargin="0" leftmargin="0" bgcolor="#edf2f8">
<html:form action="locDetails.do">

<table align=center width="100%">
	<tr>
			<td align=right>
			<a href="javascript:window.close()">Close</a>
		</td>
	</tr>
	<!-- source details -->
	<tr>
		<td>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td  class="textborder" nowrap>
						Choose Your Work
					</td>
				</tr>
			</table>
		</td>
	</tr>
		
	
	<tr>
		<td>
			<table border=1 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">

				<tr><td align=center class="clrborder">Please Select the Division   in the District: <%=dist%></td>
				</tr>
				<%String div="",cat="",prog="";
				//System.out.println("eee:"+request.getParameter("division"));
				if(request.getParameter("division")!=null )
				{
				 div=request.getParameter("division");
				}
				if(request.getParameter("workCategory")!=null)
				{
                    cat=request.getParameter("workCategory");
				}
				if(request.getParameter("program")!=null)
				{
                    prog=request.getParameter("program");
				}
				//System.out.println("div="+div);
				%>
				<tr><td align=center class="clrborder">&nbsp;Division:
				<font color="red" face="verdana">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<html:select property="division" styleClass="combo" value="<%=div%>">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="divisions">
					<html:options collection="divisions" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
					</td>
				</tr>
				<tr><td align=center class="clrborder">Work Category:&nbsp;&nbsp;&nbsp;
					<html:select property="workCategory" styleClass="combo" value="<%=cat%>">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="wrkcat">
					<html:options collection="wrkcat" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
					</td>
				</tr>
				<tr><td align=center class="clrborder">Program:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;
					<html:select property="program" styleClass="combo" value="<%=prog%>">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="programs">
					<html:options collection="programs" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">
						<html:button property="mode" value="Get Works" styleClass="btext" onclick="getSubmit()"/>
					</td>	
				</tr>
	</table>
<p>&nbsp;</p>
<%if(request.getAttribute("workslist")!=null){ %>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td colspan=7 class="textborder">
						<font color="#ffffff">Works List</font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">Select</td>
					<td align=center class="clrborder">Work Name</td>
					<td align=center class="clrborder">Admin Date</td>
					<td align=center class="clrborder">Sanc. Amount</td>
				</tr>
				
				<nested:iterate id="TESTPARAM_LIST" property="works" indexId="ndx">
				<tr align="left" bgcolor="#ffffff">
					<td  class=bwborder align=center>
						<nested:hidden name="TESTPARAM_LIST" property="work_id" indexed="true"/>
						<nested:radio name="TESTPARAM_LIST" property="work_id" value="<%= String.valueOf(ndx)%>" indexed="false" onclick="getParameters(this)"/>
					</td>
					<td  class="bwborder" >
						<bean:write name="TESTPARAM_LIST" property="work_name"  />
					</td>
					<td  class="bwborder" >
						<bean:write name="TESTPARAM_LIST" property="admin_date"  />
					</td>
					<td  class="bwborder" align=center>
						<bean:write name="TESTPARAM_LIST" property="sanction_amount"/>
					</td>
				</tr>
				</nested:iterate>
				
				
			</table>
			<%} %>
</html:form>
</body>
</html> 