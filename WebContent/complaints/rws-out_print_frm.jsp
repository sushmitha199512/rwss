<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.util.*,java.text.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script language="javascript">
function init()
{
  window.close();
}
function init1()
{
	var ast=document.forms[0].asset.value;
	var dist=document.forms[0].dcode.value;
	var man=document.forms[0].mcode.value;
	var pan=document.forms[0].pcode.value;
	var hab=document.forms[0].hcode.value;
//alert("D:"+dist+":M:"+man+":P:"+pan+":H:"+hab);
window.opener.location.href="switch.do?prefix=/complaints&page=/Complaints.do?mode=view&asset="+ast+"&dcode="+dist+"&mcode="+man+"&pcode="+pan+"&hcode="+hab;
	window.close();
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Complaints Acknowledgement </title>
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style24 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14; }
.style2 {font-family: Verdana; font-size: 12px; }
.style3 {font-family: Verdana; font-size: 12px; font-weight: bold; }
.style4 {font-family: Verdana; font-size: 12px; font-weight: bold; color:blue;}
.style25 {font-size: 14}
-->
</style>
</head>
<form>

<body onbeforeunload="init();">
<%
java.util.Date date = new java.util.Date();
SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/mm/yyyy");
String currentYear = dateFormatter.format(date);
String complaintno=request.getParameter("complntno");
  %>
<BR><BR><BR><BR>
<table width="800" border = 1 align="center" cellpadding = 0 cellspacing = 0 bordercolor=#000000 bgcolor="#ffffff" style="border-collapse:collapse">
  <tr>
    <td colspan="5" align="center"><span class="style3">Complaint Acknowledgement Slip </span></td>
  </tr>
   <%
  try
  {
  String query="select distinct  dname,mname,pname,panch_name,complaint_no,nvl(inward_no,'-')as inward_no,comp_cat_name,to_char(complaint_date,'dd/mm/yyyy'),rep_name,name,address,e.asset_name,location,comp_name,nvl(COMPLAINT_DESC,'-')as complaint_desc,type_of_asset_code,dcode,mcode,pcode,panch_code from rws_complaints_register_tbl a,rws_complete_hab_view b,rws_complaint_category_tbl c,rws_public_rep_tbl d,rws_asset_mast_tbl e where substr(a.component_code,1,16)=b.panch_code and substr(a.asset_code,7,2)=c.type_of_asset and a.comp_code=c.comp_code and a.category_code=c.com_category_code  and d.rep_code=a.rep_code and a.asset_code=e.asset_code and complaint_no='"+complaintno+"'";
  stmt=conn.createStatement();
  System.out.println("query@@@@@@@@@@@:"+query);
  rs=stmt.executeQuery(query);
  if(rs.next())
  {
  %>
   <tr>
    <td colspan="5" align="right" ><span class="style3">Date:<%=rs.getString(8)%>  </span></td>
  </tr>
  
  <tr>
    <td colspan="5"><span class="style3" align=left>Your Complaint Registration No: <span class="style1"><%=rs.getString("complaint_no")%></span></span> </td>
  </tr>
  <tr>
    <td  align=left><span class="style3">Your Complaint Registration Details: </span></td>
  </tr>
  <tr>
    <td  align=right><span class="style3" align="right">Habitation Details: </span></td>
    <td  align=left><span class="style3">District:</span></td>
    <td align=left><span class="style2"><%=rs.getString("dname")%></span></td>
    <td  align=left><span class="style3">Mandal:</span></td>
    <td align=left><span class="style2"><%=rs.getString("mname")%></span></td>
  </tr>
  <tr>
     <td ><span class="rptvalue"></span></td>
    <td  align=left><span class="style3">Panchayat:</span></td>
    <td align=left><span class="style2" ><%=rs.getString("pname")%></span></td>
	 <td  align=left><span class="style3">Habitation:</span></td>
    <td align=left><span class="style2"><%=rs.getString("panch_name")%></span></td>
    
 </tr>
 
  <tr>
 
    <td align=right><span class="style3">Asset Details: </span></td>
    <td align=left><span class="style3"> Asset Name: </span></td>
    <td align=left><span class="style2"><%=rs.getString("asset_name")%></span></td>
    <td align=left><span class="style3">Location:</span></td>
    <td align=left><span class="style2"><%=rs.getString("location")%></span></td>
  </tr>
   <tr>
     <td align=right><span class="style3">Component Details: </span></td>
    <td align=left><span class="style3"> Component Name: </span></td>
    <td align=left colspan="3"><span class="style2"><%=rs.getString("comp_name")%></span></td>
   </tr>
  <tr>
    <td align=right><span class="style3">Complaint Details: </span></td>
    <td align=left><span class="style3">Given By:</span></td>
    <td align=left><span class="style2"><%=rs.getString("rep_name")%></span></td>
    <td align=left><span class="style3">Nature of Problem:</span></td>
    <td align=left><span class="style2"><%=rs.getString("comp_cat_name")%></span></td>
  </tr>
  <tr>
    <td><span class="style2"></span></td>
    <td align=left><span class="style3">Inward No: </span></td>
    <td align=left><span  class="style2"><%=rs.getString(6)%></span></td>
    <td align=left><span class="style3" >Name:</span></td>
    <td align=left><span class="style2"><%=rs.getString("name")%></span></td>
  </tr>
  <tr>
   <td rowspan="4"><span class="style2"></span></td>
    <td align=left><span class="style3">Address:</span></td>
    <td align=left colspan="3" ><span class="style2"><%=rs.getString("address")%></span></td>
  </tr>
  <tr>
	<td align=left><span class="style3">Problem Description:</span></td>
	
	<td colspan="3" align=left ><span  class="style2"><%=rs.getString("COMPLAINT_DESC")%></span></td>
	</tr>
	<tr>
	<td align=left><span class="style3" align="left">Complaint Status: </span></td>
	<td colspan="4" align=left><span class="style2">Complaint yet to be Attended</span></td>

	<input type="hidden" name="asset" value="<%=rs.getString("type_of_asset_code")%>">

	<input type="hidden" name="dcode" value="<%=rs.getString("dcode")%>">
	<input type="hidden" name="mcode" value="<%=rs.getString("mcode")%>">
	<input type="hidden" name="pcode" value="<%=rs.getString("pcode")%>">
	<input type="hidden" name="hcode" value="<%=rs.getString("panch_code")%>">

	</tr>
	
  <%
  }
  }
  catch(Exception e)
  {
  e.printStackTrace();
  }
  %>
    
 </table>
<br>
<p align=center>
<input type="button" name="Button" value="Print" onclick="javascript:window.print()"/> 
<input type="button" name="Button" value="Close" onclick="init1()"/> 
</p>
<%@ include file="/commons/rws_alert.jsp" %>
</body>
</form>
</html>
