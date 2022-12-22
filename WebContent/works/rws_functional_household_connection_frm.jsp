<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%
String scheme=request.getParameter("scheme");
//String hh="0";
String habCode=request.getParameter("habCode");
String mName=request.getParameter("mname");
String panchayat=request.getParameter("pname");
String village=request.getParameter("vname");
String habName=request.getParameter("hname");
String hh=request.getParameter("hh");

//System.out.println("Hab Code in function HouseHold :"+habCode);

//Statement stmt;


%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!-- <h1>hello jes</h1> -->
<table width="80%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<table width="70%"><tr style="width: 100%;">
<b>
<p align="left">
<font face=verdana size=2> Scheme:</font><font face=verdana size=2 color=blue> <%=scheme%></font></br>
<font face=verdana size=2> Mandal:</font><font face=verdana size=2 color=blue> <%=mName%></font>&nbsp;&nbsp;
<font face=verdana size=2> Panchayat:</font><font face=verdana size=2 color=blue> <%=panchayat%></font>&nbsp;&nbsp;
<font face=verdana size=2> Village:</font> <font face=verdana size=2 color=blue><%=village%></font>&nbsp;&nbsp;
<font face=verdana size=2> Habitation:</font> <font face=verdana size=2 color=blue><%=habName%>(<%=habCode%>)</font></p></b>
<b>
<p align=left>
<font face=verdana size=2> Household:</font><font face=verdana size=2 color=blue> <%=hh%></font>&nbsp;&nbsp;
<font face=verdana size=2> FHTC Provided till date:</font><font face=verdana size=2 color=blue> <%=hh%></font>&nbsp;&nbsp;
<font face=verdana size=2> FHTC Provided for selected month & Scheme:</font> <font face=verdana size=2 color=blue><%=hh%></font></p></b>

</tr></table>

<%-- <html:button property="mode" styleClass="btext"   value="Add New Beneficiary" onclick="" title="Click To Add New Beneficiary" /> --%>

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Functional Household Connection(FHTC)" />
	<jsp:param name="TWidth" value="96%" />
</jsp:include>

<!-- <tr align=center><td class=btext>aaaaaaaaaaaaa</td></tr>
 --><table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="74%" border=1 style="border-collapse:collapse" >

   
<tr align=center>
			<td class=btext rowspan="2">Sl No.</td>
			<td class=btext rowspan="2">Family Head</td>
			<td class=btext rowspan="2">Father/HusbandName</td>
			<!--  <td class=btext rowspan="2">Benificiary Id of state MIS if any</td>  -->
			<td class=btext rowspan="2">Gender</td>
			<td class=btext rowspan="2">Category</td>
			<td class=btext rowspan="2">Sub Category</td>
			   
			 <td class=btext colspan="3">No of Family members(incl family head)</td>
			<td class=btext rowspan="2">Is Aadhar Verified</td>
			<!-- <td class=btext>Action</td>  -->
</tr>
<tr>
<td class=btext rowspan="1"> Male</td>
    <td class=btext rowspan="1"> Female</td>
    <td class=btext rowspan="1"> Transgender</td>
       </tr>

<%
String mndDtlsQry="";
stmt = conn.createStatement();
mndDtlsQry="select FAMILY_HEAD,HUSBAND_NAME,GENDER,CATEGORY_NAME,SUBCATEGORY_DESC,IS_HAVING_TAP,IS_AADHAR_VALID,nvl(MALE_COUNT,0) as MALECOUNT,nvl(FEMALE_COUNT,0) as FEMALECOUNT,nvl(TRANSGENDER_COUNT,0) as TRANSCOUNT from rws_household_tapsurvey_tbl";
rs = stmt.executeQuery(mndDtlsQry);
int slno=1;

while(rs.next())
{%>
<tr>
	        <td class=rptValue><%=slno++%></td>
			<td class=rptValue><%=rs.getString("FAMILY_HEAD")%></td>
			<td class=rptValue><%=rs.getString("HUSBAND_NAME")%></td>
			
									<!-- <td class="textborder" > <input type="text" id="misIncharge"  style="width:250px"  maxlength="100"  value="" /></td> -->
			
			 <%-- <td>
			<nested:text name="familyHead" property="familyHead"  maxlength="10" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>	
			</td> --%>											</td>
			 <td class=rptValue><%=rs.getString("GENDER")%></td>
			<td class=rptValue><%=rs.getString("CATEGORY_NAME")%></td>
			<td class=rptValue><%=rs.getString("SUBCATEGORY_DESC")%></td>
			
												<td class="textborder" align="center"> <input type="text" readonly="true" style="width:40px; margin: 3px;"  maxlength="2"  value=<%=rs.getString("MALECOUNT") %> /></td>

												<td class="textborder" align="center"> <input type="text" readonly="true"  style="width:40px; margin: 3px;"  maxlength="2"  value=<%=rs.getString("FEMALECOUNT") %> /></td>

												<td class="textborder" align="center"> <input type="text" readonly="true"  style="width:40px; margin: 3px;"  maxlength="2"  value=<%=rs.getString("TRANSCOUNT") %> /></td>
			<% if(rs.getString("IS_AADHAR_VALID").equals("Yes")){ %>
			<td class=rptValue style="color: green;"><%=rs.getString("IS_AADHAR_VALID") %></td>
			<%}else{ %>
			<td class=rptValue style="color: red;"><%=rs.getString("IS_AADHAR_VALID") %></td>
			<%} %>
			<!-- <td width="40px" align="center"><input type="checkbox" name="remove" value=""></td> -->

<%  }


%>
</tr>

</table>
</body>
</html>
<p align="center">
	<%@ include file="/commons/rws_footer.jsp"%>
	<%@ include file="/commons/rws_alert.jsp"%>
</p>