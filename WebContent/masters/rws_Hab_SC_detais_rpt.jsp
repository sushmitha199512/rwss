<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<%
	int sno = 1;
	String mode = "lcSave";
	String type = request.getParameter("type").toUpperCase();
	//// System.out.println("type:"+type);
%>

<script>
function init(){

}
function fnSave(index)
{
  var habcode='<%=request.getParameter("habcode")%>';
// alert(habcode);
  var url="switch.do?prefix=/masters&page=/HabSCST.do?mode=lcSave";
 //alert(url);
 document.forms[0].action=url;
//alert("wssssssss");
  document.forms[0].submit();  
  //alert("fghfdghfd");
}
function addrow()
{
 var type='<%=request.getParameter("type")%>';
 //alert(type);
var sno=document.forms[0].sno.value;
sno++;
document.forms[0].sno.value = sno;
var tbody = document.getElementById('t1').getElementsByTagName('tbody')[0];

row = document.createElement('TR');
cell0 = document.createElement('TD');
cell1 = document.createElement('TD');
cell2 = document.createElement('TD');
cell0.innerHTML=sno;
if(sno<=9)
	var sno1="0"+sno;
else
   sno1=sno;
if(type=='sc'){
cell1.innerHTML ="SC"+	sno1;
}else if(type=='st'){
	cell1.innerHTML ="ST"+	sno1;
}else if(type='mt'){
	cell1.innerHTML ="MT"+sno1;
}
cell2.innerHTML ="<input type=text  name=locname"+sno+">";
i=i+1;
row.appendChild(cell0);
row.appendChild(cell1);
row.appendChild(cell2);
tbody.appendChild(row);
}

</script>
<body onload="init()">
	<form action="HabSCST.do" method="post">

		<table align="center">
			<tr>
				<td align="right"><a href="#" onclick="window.close()" />Close</td>
			</tr>
			<tr>
				<td class=btext>Habitation:<%=request.getParameter("habcode")%>-<%=request.getParameter("habname")%></td>
			</tr>
		</table>
		<table border=0 cellspacing=0 cellpadding=0 width=45%
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
			<tr>
				<td bgcolor="#8A9FCD"><font face=verdana color="#000000"
					size="2"><B>Habs-Localties Details List</B></font></td>
			</tr>
			<table id="t1" border=1 cellspacing=0 cellpadding=0 width=45%
				bordercolor=#000000 style="border-collapse: collapse"
				bgcolor="#ffffff" align="center">
				<thead>
					<tr>
						<td class=btext>Sl.No</td>
						<td class=btext>Locality Code</td>
						<td class=btext>Locality Name</td>
					</tr>
				</thead>
				<tbody>
					<%
						String qry = "select * from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=? and substr(locality_code,1,2)=? order by locality_code ";
						ps = conn.prepareStatement(qry);
						ps.setString(1, request.getParameter("habcode"));
						ps.setString(2, type);
						rs = ps.executeQuery();
						while (rs.next()) {
					%>
					<tr>
						<td class=rptvalue><%=sno%></td>
						<td class=rptvalue><%=rs.getString(2)%></td>
						<td class=rptvalue><input type="text"
							name="locname<%=sno++%>" value="<%=rs.getString(3)%>"></td>
					</tr>

					<%
						}
					%>
				</tbody>
				<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
				<tr>
					<td colspan=3 align="center"><input type="button" name="Add"
						value="Add" onclick="addrow(<%=sno%>)"><input
						type="button" name="save" value="save" onclick="fnSave(<%=sno%>)"></td>
				</tr>
			</table>

			<input type="hidden" name="sno" value="<%=sno - 1%>" />
			<input type="hidden" name="mode" value="lcSave" />
			<input type="hidden" name="habcode"
				value="<%=request.getParameter("habcode")%>" />
			<input type="hidden" name="type" value="<%=type%>" />


			</form>
			<%@ include file="/commons/rws_alert.jsp"%>
			</html>