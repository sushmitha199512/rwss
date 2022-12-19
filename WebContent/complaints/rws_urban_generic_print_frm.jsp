<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.util.*,java.text.*" %>
<%@page import="nic.watersoft.smsmobile.NicSmsGateway"%>  
<html xmlns="http://www.w3.org/1999/xhtml">
<script language="javascript">
function init()
{
  window.close();
}
function init1()
{
	
	var dist=document.forms[0].dcode.value;
	var man=document.forms[0].mcode.value;
	var pan=document.forms[0].pcode.value;
	var hab=document.forms[0].hcode.value;
//alert("D:"+dist+":M:"+man+":P:"+pan+":H:"+hab);
	/* window.opener.location.href="switch.do?prefix=/complaints&page=/Complaintsgeneric.do?mode=view&dcode="+dist+"&mcode="+man+"&pcode="+pan+"&hcode="+hab;
	window.close(); */
	 document.forms[0].action="switch.do?prefix=/complaints&page=/UrbanComplaintsgeneric.do?mode=view&dcode="+dist+"&mcode="+man+"&pcode="+pan+"&hcode="+hab;

     document.forms[0].submit(); 
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Grievance Acknowledgement </title>
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


<body>
<form method="post">
<%
java.util.Date date = new java.util.Date();
SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/mm/yyyy");
String currentYear = dateFormatter.format(date);
String complaintno=request.getParameter("complntno");
  %>
<BR><BR><BR><BR>
<table width="800" border = 1 align="center" cellpadding = 0 cellspacing = 0 bordercolor=#000000 bgcolor="#ffffff" style="border-collapse:collapse">
  <tr>
    <td colspan="5" align="center"><span class="style3">Generic Grievance Acknowledgement Slip </span></td>
  </tr>
   <%
  try
  {
  String query="select distinct dname,mname,vname,LOCALITY,complaint_no,to_char(complaint_date,'dd/mm/yyyy'),nvl(COMPLAINT_DESC,'-')as complaint_desc,rep_name,name,address,phone_no,DIST_NO,MAND_NO,VILL_NO,hab_code,ACTION_TAKEN  from rws_GENERIC_complaints_reg_tbl a,urban_locality b,rws_public_rep_tbl d,urban_district_tbl c,urban_mandal_tbl e,urban_village_tbl f where c.dcode=b.DIST_NO and e.mcode=b.MAND_NO and f.vcode=b.VILL_NO and e.mcode=f.mcode and substr(a.complaint_no,1,2)=b.DIST_NO and a.habitation_code=b.hab_code and d.rep_code=a.rep_code and complaint_no='"+complaintno+"'";
  stmt=conn.createStatement();
  System.out.println("query@@@@@@@@@@@:"+query);
  rs=stmt.executeQuery(query);
  if(rs.next())
  {
  %>
   <tr>
    <td colspan="5" align="right" ><span class="style3">Date:<%=rs.getString(6)%>  </span></td>
  </tr>
  
  <tr>
    <td colspan="5"><span class="style3" align=left>Your Complaint Registration No: <span class="style1"><%=rs.getString("complaint_no")%></span></span> </td>
  </tr>
  <tr>
    <td  align=left><span class="style3">Your Complaint Registration Details: </span></td>
  </tr>
  <tr>
    <td  align=right><span class="style3" align="right">Locality / Habitation Details: </span></td>
    <td  align=left><span class="style3">District:</span></td>
    <td align=left><span class="style2"><%=rs.getString("dname")%></span></td>
    <td  align=left><span class="style3">Municipality / Mandal:</span></td>
    <td align=left><span class="style2"><%=rs.getString("mname")%></span></td>
  </tr>
  <tr>
     <td ><span class="rptvalue"></span></td>
    <td  align=left><span class="style3">Ward / Village:</span></td>
    <td align=left><span class="style2" ><%=rs.getString("vname")%></span></td>
	 <td  align=left><span class="style3">Locality / Habitation:</span></td>
    <td align=left><span class="style2"><%=rs.getString("LOCALITY")%></span></td>
    
 </tr>
 
  
  
  <tr>
    <td align=right><span class="style3">Complaint Details: </span></td>
    <td align=left><span class="style3">Given By:</span></td>
    <td align=left><span class="style2"><%=rs.getString("rep_name")%></span></td>
    <td align=left><span class="style3">Problem Description:</span></td>
    <td align=left><span class="style2"><%=rs.getString("complaint_desc")%></span></td>
  </tr>
  <tr>
    <td><span class="style2"></span></td>
    
    <td align=left><span class="style3" >Name:</span></td>
    <td align=left><span class="style2"><%=rs.getString("name")%></span></td>
  </tr>
  <tr>
   <td rowspan="4"><span class="style2"></span></td>
    <td align=left><span class="style3">Address:</span></td>
    <td align=left colspan="3" ><span class="style2"><%=rs.getString("address")%></span></td>
  </tr>
  
	<tr>
	<td align=left><span class="style3" align="left">Complaint Status: </span></td>
	<%if(rs.getString("ACTION_TAKEN")!=null && rs.getString("ACTION_TAKEN")!="") {%>
	<td colspan="4" align=left><span class="style2"><%=rs.getString("ACTION_TAKEN")%></span></td>
	<%}else{ %>
<td colspan="4" align=left><span class="style2">Complaint Yet To Be Attended</span></td>
<%} %>
	

	<input type="hidden" name="dcode" value="<%=rs.getString("DIST_NO")%>">
	<input type="hidden" name="mcode" value="<%=rs.getString("MAND_NO")%>">
	<input type="hidden" name="pcode" value="<%=rs.getString("VILL_NO")%>">
	<input type="hidden" name="hcode" value="<%=rs.getString("hab_code")%>">

	</tr>
	
  <%
  String result = "Your complaint registered with id "+rs.getString("complaint_no")+" reference for tracking. ";
  NicSmsGateway sms = new NicSmsGateway();
  String message=sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", rs.getString("phone_no") , result);
  out.println("MESSAGE"+message);
  
  }
  }
  catch(Exception e)
  {
  e.printStackTrace();
  }
  %>
    

</table>
<p align="center">

<input type="button" name="Button" value="Print" onclick="javascript:window.print()"/> 
<input type="button" name="Button" value="Close" onclick="init1()"/> 
</p>


<%@ include file="/commons/rws_alert.jsp" %>
</form>
</body>

</html>
