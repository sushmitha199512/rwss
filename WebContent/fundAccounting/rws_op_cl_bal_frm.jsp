<%@ page import="java.util.Date,java.text.DecimalFormat,java.math.BigDecimal,nic.watersoft.commons.CommonLists,nic.watersoft.commons.LabelValueBean" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	if(user!=null){
        if(loggedUser!=null && (!loggedUser.equals("admin") && !loggedUser.equals("100000") )){
     	   response.sendRedirect("../commons/UnAuthorize.jsp");
        }
	}
	String program = request.getParameter("program");
	String major = request.getParameter("major");
	String subprg = request.getParameter("subprg");
	String submajor = request.getParameter("submajor");
	String minor = request.getParameter("minor");
	String grpHead = request.getParameter("grpHead");
	String subHead = request.getParameter("subHead");	
	String detailHead = request.getParameter("detailHead");
	String subDetailHead = request.getParameter("subDetailHead");
	String HOACode = major+"-"+submajor+"-"+minor+"-"+grpHead+"-"+subHead+"-"+detailHead+"-"+subDetailHead;
	String modee = request.getParameter("modee");
	CommonLists commonLists = new CommonLists();
%>
<html>
<head>
<script language="JavaScript">
	function hideDefaultText(element, defaultVal)
	{
		if(element.value == defaultVal){
			element.value =	'';
		}
	}
	
	function showDefaultText(element, defaultVal)
	{
		if(element.value == ''){
			element.value =	defaultVal;
		}
	}
	
	function IsEmpty(aTextField) {
	
		var regexp = /^(\s)*$/
	
		if(regexp.test(aTextField.value)){
			return true;
	
		}else{
			return false;
		}
	
	}
	function fnSubmit()
	{
		if(document.f1.program.value=='')
		{
			alert("Please Select Program");
			return false;
		}
       else if(document.f1.subprg.value=='')
		{
			alert("Please Select SubProgram");
			return false;
		}
		else if(document.f1.major.value=='0000')
		{
			alert("Please Select Major Code");
			return false;
		}
		else
		{
			document.f1.action="./rws_op_cl_bal_frm.jsp";
			document.f1.modee.value = "1";
			document.f1.submit();
		}	
	}
	
function obSave()
{
	var val = "false";
	for(var ii = 0;ii<document.forms[0].ob.length;ii++)
	{
		if(document.forms[0].ob[ii].value!=0)
		{
			val = "true";
		}
	}
	if(val=="false")
	{
		alert("Please Enter OB for Atleast One Division to Save/Update");
	}
	else
	{
		document.f1.action="rws_op_cl_bal_insert.jsp";
		document.f1.submit();
	}
}
</script>
<% 
	Date dt=new Date();
%>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=435>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Division-wise Opening Balance</td>	
	</tr>
	
<%
try
{
	if(program==null)program="";
%>
		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
				<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			String query="select distinct programme_code,programme_name from rws_programme_tbl order by 2";
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				if(program!=null && program.equals(rs1.getString(1)))
				{
	%>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%		}
				else
				{
	%>
					 <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%
				}
			}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	%>
</td></tr>

<%
	ArrayList programmeList = commonLists.getSubprgList(program);
	LabelValueBean labelValueBean1 = null;
%>


<tr><td class=rptLabel>SubProgramme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="subprg" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="0000">-Select-</option>
			<%
				for(int i=0;i<programmeList.size();i++)
				{
					labelValueBean1 = (LabelValueBean)programmeList.get(i);
					if(major!=null && subprg.equals(labelValueBean1.getValue()))
					{
			%>
						<option value="<%=labelValueBean1.getValue()%>" selected><%=labelValueBean1.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean1.getValue()%>"><%=labelValueBean1.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<%
	ArrayList majorHeadList = commonLists.getMajorHeadList();
	LabelValueBean labelValueBean = null;
%>
<tr><td class=rptLabel>Major Head&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="major" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="0000">-Select-</option>
			<%
				for(int i=0;i<majorHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)majorHeadList.get(i);
					if(major!=null && major.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<%
	ArrayList submajorHeadList=null;
	if(major!=null && !major.equals("0000"))
		submajorHeadList = commonLists.getSubmajorHeadList(major);
	%>
<tr><td class=rptLabel>Sub Major Head&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="submajor" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="00">-Select-</option>
			<%
			if(submajorHeadList!=null && submajorHeadList.size()>0)
				for(int i=0;i<submajorHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)submajorHeadList.get(i);
					if(submajor!=null && submajor.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<%
	ArrayList minorHeadList = null;
	if(submajor!=null && !submajor.equals("00"))
		minorHeadList = commonLists.getMinorHeadList(major,submajor);
	%>
<tr><td class=rptLabel>Minor Head&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="minor" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="000">-Select-</option>
			<%
		if(minorHeadList!=null && minorHeadList.size()>0)
				for(int i=0;i<minorHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)minorHeadList.get(i);
					if(minor!=null && minor.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<%
	ArrayList groupHeadList = null;
	if(minor!=null && !minor.equals("00"))
		groupHeadList = commonLists.getGroupHeadList(major,submajor,minor);

%>
<tr><td class=rptLabel>Group Head &nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="grpHead" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="00">-Select-</option>
			<%
			if(groupHeadList!=null && groupHeadList.size()>0)
				for(int i=0;i<groupHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)groupHeadList.get(i);
					if(grpHead!=null && grpHead.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
		%>
	</select>
</td></tr>
<%
	ArrayList subHeadList=null;
	if(grpHead!=null && !grpHead.equals("00"))
		subHeadList = commonLists.getSubHeadList(major,submajor,minor,grpHead);
%>
<tr><td class=rptLabel>Sub Head&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="subHead" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="00">-Select-</option>
			<%
			if(subHeadList!=null && subHeadList.size()>0)
				for(int i=0;i<subHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)subHeadList.get(i);
					if(subHead!=null && subHead.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
		%>
	</select>
</td></tr>
<%
	ArrayList detailHeadList = null;
	if(subHead!=null && !subHead.equals("000"))
	detailHeadList = commonLists.getDetailHeadList(major,submajor,minor,grpHead,subHead);
%>
<tr><td class=rptLabel>Detail Head &nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="detailHead" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="000">-Select-</option>
			<%
		if(detailHeadList!=null && detailHeadList.size()>0)
				for(int i=0;i<detailHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)detailHeadList.get(i);
					if(detailHead!=null && detailHead.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<%
	ArrayList subDetailHeadList = null;
	if(detailHead!=null && !detailHead.equals("000"))
	subDetailHeadList = commonLists.getSubDetailHeadList(major,submajor,minor,grpHead,subHead,detailHead);
%>
<tr><td class=rptLabel>Sub Detail Head &nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="subDetailHead" id="combo" class="mycombo" style="width:250px" onchange="this.form.submit()">
			<option value="000">-Select-</option>
			<%
			if(subDetailHeadList!=null && subDetailHeadList.size()>0)
				for(int i=0;i<subDetailHeadList.size();i++)
				{
					labelValueBean = (LabelValueBean)subDetailHeadList.get(i);
					if(subDetailHead!=null && subDetailHead.equals(labelValueBean.getValue()))
					{
			%>
						<option value="<%=labelValueBean.getValue()%>" selected><%=labelValueBean.getLabelValue()%></option>
		<%		}
					else
					{
		%>
						<option value="<%=labelValueBean.getValue()%>"><%=labelValueBean.getLabelValue()%></option>
		<%
					}
				}
			%>
	</select>
</td></tr>
<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3 align=center>
		<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Divisions to Enter OB for 2011-2012">
	</td>
</tr>
</table>
<% int sno=1;
if(modee!=null && !modee.equals(""))
{
	if(program!=null && !program.equals("")) {%>
<font face="verdana" size="2" color="red"><b>Divisions</b></font>
<table border = 1 align = center bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=400>		
<tr>
	<td class=btext nowrap>Sl.No.</td>
	<td class=btext>District</td>
	<td class=btext>Division</td>
	<td class=btext align=center>Opening Balance(in Rs)&nbsp;<b style="font-family: Rupee Foradian; color=red">`</b></td>
</tr>
<%
	//String qq1 = "select sum(OP_CL_BAL),substr(office_code,2,3)||HEAD_OF_ACCOUNT||PROGRAMME_CODE from RWS_GRANT_OP_CL_BAL_TBL group by substr(office_code,2,3)||HEAD_OF_ACCOUNT||PROGRAMME_CODE";
	String qq1="select sum(OP_CL_BAL),substr(office_code,2,3)||HEAD_OF_ACCOUNT||PROGRAMME_CODE||SUBPROGRAMME_CODE from RWS_GRANT_OP_CL_BAL_TBL group by substr(office_code,2,3)||HEAD_OF_ACCOUNT||PROGRAMME_CODE||SUBPROGRAMME_CODE";
    Statement stt1 = conn.createStatement();
	ResultSet rsss1 = stt1.executeQuery(qq1);
	Hashtable ht1 = new Hashtable();
	while(rsss1.next())
	{
		ht1.put(rsss1.getString(2),rsss1.getString(1)); 
	}
	try
	{
		if(rsss1!=null)rsss1.close();
		if(stt1!=null)stt1.close();
	}
	catch(Exception e){}
		stmt1 = conn.createStatement();
		query="select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code order by 1,2";
		String divrelease = ""+ht1.get("000"+HOACode+program+subprg);
		if(divrelease!=null && !divrelease.equals("null")){}else{divrelease="0";}
		%>
			<tr>
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue>Hyderabad</td>
				<td class=rptValue>Head Office</td>
				<td class=rptValue><input type="text" name="ob" onfocus="return hideDefaultText(this, '0')" onblur="return showDefaultText(this, '0')" class="mytext" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="12" value="<%=divrelease%>"></td>
			</tr>
		<%
		rs1 = stmt1.executeQuery(query);
		while(rs1.next())
		{
			divrelease = ""+ht1.get(rs1.getString(1)+rs1.getString(2)+HOACode+program+subprg);
			if(divrelease!=null && !divrelease.equals("null")){}else{divrelease="0";}
			%>
				<tr>
					<td class=rptValue><%=sno++%></td>
					<td class=rptValue><%=rs1.getString(3)%></td>
					<td class=rptValue><%=rs1.getString(4)%></td>
					<td class=rptValue><input type="text" name="ob" onfocus="return hideDefaultText(this, '0')" onblur="return showDefaultText(this, '0')" class="mytext" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" maxlength="12" value="<%=divrelease%>"></td>
				</tr>
			<%
		}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
%>
<tr><td colspan="4" align="center"><input type="button" value="Save/Update OB" class=btext onclick="obSave()"></td></tr></table>
<%}}%>
<%	
}catch(Exception e){e.printStackTrace();}
%>
<%@ include file = "/commons/rws_footer.jsp" %>
<%@ include file = "/commons/rws_alert.jsp" %>
<input type="hidden" name="modee">
<input type="hidden" name="codee">
<input type="hidden" name="HOACode" value="<%=HOACode%>">
</form>
</body>
</html>