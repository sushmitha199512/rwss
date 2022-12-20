<%@ page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<style type="text/css">
body, body a {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 13px !important;	
}
.btext {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 12px !important;
	border: 1px solid #777777;
}
.rightPad td {
	padding-right: 3px !important;
}
</style>

<script>
function deleteFn(work_id)
{
	var workid=work_id;
	//var v="./rws_works_grounded_delete.jsp?workId="+work_id"";
	alert("hi--"+work_id);
	document.forms[0].action="./rws_works_grounded_delete.jsp&workId="+workid;
	document.forms[0].submit();
}



</script>
<%
String district="";
if (request.getParameter("district") != null){
	district = request.getParameter("district");
}
else{
	district = session.getAttribute("district").toString();
}
session.setAttribute("district", district);


//HashMap programmeList = new HashMap();

String progCode = "";
String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
Statement statement = conn.createStatement();
ResultSet resultSet = statement.executeQuery(nrdwpQuery);
while (resultSet.next()) {
	if (!progCode.equals("")) {
		progCode = progCode + "," + resultSet.getString(1);
	} else {
		progCode = resultSet.getString(1);
	}
}
resultSet.close();
statement.close();

String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' order by 1";
Statement stmtCmDB = conn.createStatement();
ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
while (rsCmDB.next()) {
	progCode = progCode + "," + rsCmDB.getString(1);
}   

%>
<body>
<form method="post">
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
			<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp;</a><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </a></td>
	</tr>  
	</table>
	</caption>
	<tr>
		<td class=rptLabel align="center" colspan=5>Grounding Date Remove form</td>	
	</tr>
			<tr align=center align=center>
				<td class=btext style="width: 30px !important;">SNO</td>
				<td class=btext > Work Id </td>         
                <td class=btext >Work Name</td>
                <td class=btext >Grounding date</td>
                <td class=btext >Delete</td>
		  	</tr>
		  	<%try{
		  	 stmt=conn.createStatement();
		  	 String qry="select a.work_id,a.WORK_NAME,to_char(b.GROUNDING_DATE,'DD-MM-YYYY') as GROUNDING_DATE from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b where substr(a.work_id,7,2) in ('01','02','03','10') and a.PROGRAMME_CODE in ("+progCode+") and ADMIN_DATE>=to_date('01-01-2013','dd/mm/yyyy') and a.WORK_CANCEL_DT is null and a.WORK_ID=b.WORK_ID and (a.work_id not in (select t.work_id from RWS_NEW_EST_TBL t) or a.work_id not in (select c.work_id from RWS_CONTRACTOR_SELECTION_TBL c) or a.work_id not in (select s.work_id from RWS_SOURCE_IDEN_FIN_TBL s)) and substr(a.work_id,5,2)='"+district+"' order by EXTRACT(YEAR FROM(b.GROUNDING_DATE)) desc";
		  	 rs=stmt.executeQuery(qry);
		  	// System.out.println(qry);
		  	 int sno=1;
		  	 while(rs.next()){
		  		 String workId=rs.getString("work_id");
		  		 %>
		  		 <tr>
		  		<%--  <input type="hidden" name="work_id" value=<%=rs.getString("work_id")%>/> --%>
			  		<td class="rptValue" style="width: 30px !important;"><%=sno++ %></td>
					<td class="rptValue" ><%=rs.getString("work_id") %> </td>         
	                <td class="rptValue" ><%=rs.getString("WORK_NAME") %></td>
	                <td class="rptValue" ><%=rs.getString("GROUNDING_DATE") %></td>
	                <!-- <td class="rptValue" ><input type="button" value="Delete" name="Delete" onclick="return deleteFn(document.forms[0].work_id.value)"></td> -->
	               <td class="rptValue" > <a href="./rws_works_grounded_delete.jsp?workId=<%=workId%>">Delete</a></td>
                </tr>
		  		<% 
		  	 }
		  	 rs.close();
		  	}catch(Exception e){
		  		e.printStackTrace();
		  	}finally{
		  		if(conn!=null)
		  			conn.close();
		  	}		  	
		  	%>		  	
		  	<tr>
		  	</tr>
		</table>
		</form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>

		
		