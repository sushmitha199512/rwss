
<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>
 
<%String pcode = request.getParameter("pcode");

String bankorPao=request.getParameter("bankOrPAO");

String tableName=null;
if(bankorPao!=null && bankorPao.equals("1")){
session.setAttribute("bankOrPAO",bankorPao);
tableName="rws_div_work_bank_refund_tbl";
//System.out.println("Tale name:"+bankorPao);
}else if(bankorPao!=null && bankorPao.equals("2")){
session.setAttribute("bankOrPAO",bankorPao);
tableName="rws_div_work_pao_refund_tbl";
}else{
session.setAttribute("bankOrPAO",bankorPao);
  tableName="rws_div_work_bank_refund_tbl";
}
		  int count = 1,sno=0;%>
<html>
<style>
#input_box {
	background-color:#C9DFF4;
	font-weight:bold;
}
</style>
<script language="javascript">

function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
function fnClose()
{
	document.forms[0].action="/pred/home.do";
	document.forms[0].submit();	
}
function fnReject(){
  alert("Reason");
}
function fnAccept(count){

   	  var flag=false;var i=0;
 for(i=1;i<=count;i++){
//alert(document.getElementById("refundForm[0].chequeNo").value);
//alert(document.getElementById('refundForm['+(i-1)+'].chequeNo').value );
if(document.getElementById('check'+i).checked){
flag=true;
break;
}
}

if(!flag){
	alert("Please Select Work");
return;
}
document.forms[0].action="rws_div_works_refunds_process.jsp?mode=accept";
	document.forms[0].submit();	
}
function fnReject(count){

 	  var flag=false;var i=0;
for(i=1;i<=count;i++){
//alert(document.getElementById("refundForm[0].chequeNo").value);
//alert(document.getElementById('refundForm['+(i-1)+'].chequeNo').value );
if(document.getElementById('check'+i).checked){
flag=true;
break;
}
}

if(!flag){
	alert("Please Select Work");
return;
}
document.forms[0].action="rws_div_works_refunds_process.jsp?mode=reject";
	document.forms[0].submit();	
}
</script>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table.css'/>">
<body  bgcolor="#edf2f8">
<form method="post">
<table border = 0>	
		<caption>
			<table  border=0 width="960px" rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
						<a href="<rws:context page='/home.jsp'/>">My Home</a>
					</td>
				</tr>
			</table>
		</caption>
</table>
		<table>
		<tr  align="center">
			<td align="center" class="rptHeading" style="width:350">Refunds</td>
			<td class="rptHeading" style="width:300" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
<tr><td colspan="3"></td>
<% if(bankorPao!=null && bankorPao.equals("1")){ %>
<td >Bank:<input type="radio" name="bankOrPAO" value="1" checked="checked" onclick="submit();">
PAO:<input type="radio" name="bankOrPAO" value="2" onclick="submit();"></td>
<% } else if(bankorPao!=null && bankorPao.equals("2")){ %>
<td >Bank:<input type="radio" name="bankOrPAO" value="1"  onclick="submit();">
PAO:<input type="radio" name="bankOrPAO" value="2" checked="checked" onclick="submit();"></td>
<% } else { %>
<td >Bank:<input type="radio" name="bankOrPAO" value="1" checked="checked" onclick="submit();">
PAO:<input type="radio" name="bankOrPAO" value="2" onclick="submit();"></td>
<% } %>
</tr>
		</table>
		<%
	try
	{
		String qry = "select b.dname,c.division_office_name,a.work_id,d.work_name,a.refund_bill_amount,nvl(a.remarks,'-'),to_char(update_date,'dd/mm/yyyy') from "+tableName+" a,rws_district_tbl b,rws_division_office_tbl c,rws_work_admn_tbl d where a.work_id=d.work_id and substr(d.office_code,2,2)=b.dcode and  substr(d.office_code,4,1)=c.division_office_code and  b.dcode=c.circle_office_code and a.refund_flag='I' and a.ee_forward_date is not null ";
		  stmt = conn.createStatement();
		  rs = stmt.executeQuery(qry);

		  %>
		<table border = 1 width="80%" align=center bordercolor=black style="border-collapse:collapse">
			 <tr align="center">
				<td class=btext>Sl. No.</td>
				<td class=btext>Circle</td>
				<td class=btext>Division</td>
				<td class=btext>Work_id</td>
				<td class=btext>Work Name</td>
				<td class=btext>Refund Amount</td>
			<td class=btext>Date</td>
			<td class=btext>Remarks</td>
	<td class=btext>Select</td>

			</tr>
		<%
			String val = "";
						while(rs.next())
				{
					
					%>
					<tr onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
						<td class="rptValue" nowrap><%=count++%></td>
						<td class="rptValue" nowrap><%=rs.getString(1)%></td>
						<td class="rptValue" nowrap><%=rs.getString(2)%></td>
						<td class="rptValue" nowrap><%=rs.getString(3)%></td>
						<td class="rptValue" nowrap><%=rs.getString(4)%></td>
						<td class="rptValue" nowrap><%=rs.getString(5)%></td>
						<td class="rptValue" nowrap><%=rs.getString(7)%></td>
						<td class="rptValue" nowrap><%=rs.getString(6)%></td>
						<td><input type=checkbox name=check<%=count-1%> value='<%=rs.getString(3) %>@#<%=rs.getString(7) %>' ></td>
					</tr>
				<%
								}
if(count==1){
%>

<tr>
						<td colspan="4"></td><td  class=btext >No Records</td>
</tr>
<% }
		

		%>
		<input type="hidden" name="resultCount" value="<%=count%>">
		</table><BR>
		<table align="center">
		<%if(count>=1){%>
		<tr>
			<td align="center">
				<input type=button name=getValues1 value="Close" onclick="fnClose()" class="btext">&nbsp;&nbsp;
				<input type=button name=getValues2 value="Accepted" onclick="fnAccept(<%=count %>)"  id=fnSavve class="btext">
				<input type=button name=getValues3 value="Rejected" onclick="fnReject(<%=count %>)"  id=fnSavve1 class="btext">

			</td>
		</tr>
		<%}%>
		</table>
	<%}
		catch(Exception e){
		System.out.println("Exception at rws_div_works_refunds : "+e);//e.printStackTrace();
		}
		finally{
		try{
			if(rs!=null)rs.close();if(stmt!=null)stmt.close();
			if(conn!=null)conn.close();
		}catch(Exception eee){
			System.out.println("Exception at finally block rws_div_works_refunds : "+eee);
			}
		}
	
	%>

	
</form>

</body>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>