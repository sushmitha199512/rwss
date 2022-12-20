<%@ page import="java.text.DecimalFormat,java.math.BigDecimal"%>
<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%String pcode = request.getParameter("pcode");
		  int count = 1,sno=0;
		int recCount=Integer.parseInt(request.getParameter("resultCount"));
		  %>
<html>
<style>
#input_box {
	background-color:#C9DFF4;
	font-weight:bold;
}
</style>
<script language="javascript">
function ismaxlength(obj){
var mlength=obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : ""
if (obj.getAttribute && obj.value.length>mlength)
obj.value=obj.value.substring(0,mlength)
}

function fnBack()
{
	history.go(-1);
	/* document.forms[0].action="rws_contractor_sel_payment.jsp";
	document.forms[0].submit();	 */
}

function fnClose()
{
	document.forms[0].action="/pred/home.do";
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
						<a href="/pred/home.do">My Home</a>
					</td>
				</tr>
			</table>
		</caption>
</table>
		<table>
		<tr  align="center">
			<td align="center" class="rptHeading" style="width:350">Payment Dues-Forward to Bank Form</td>
			<td class="rptHeading" style="width:300" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		</table>
		<%
		PreparedStatement st1 = null;
		Statement stT = null;
		PreparedStatement stmtTemp=null;
		ResultSet rs1 = null;
	try
	{
		stT=conn.createStatement();
		String updateQueryAll="update rws_bill_bank_bridge_temp_tbl set BILL_ACTIVATION_FLAG='I'";
		stT.executeUpdate(updateQueryAll);
		conn.commit();
		String updateQuery="update rws_bill_bank_bridge_temp_tbl set BILL_ACTIVATION_FLAG='S' where work_id=? and BILL_SL_NO=?";
		stmtTemp = conn.prepareStatement(updateQuery);
		for(int j=1;j<=recCount;j++){
			String val=request.getParameter("check"+j);
			if(val!=null && !val.equals("null")){
				String vals[]=val.split("@");
				stmtTemp.setString(1,vals[0]);
				stmtTemp.setString(2,vals[1]);
				stmtTemp.addBatch();
			}
		}
		int resCount[]=stmtTemp.executeBatch();
		conn.commit();
		if(stT!=null){
			stT.close();
		}
		if(stmtTemp!=null){
			stmtTemp.close();
		}
		String serverDate = (String)session.getAttribute("serversysdate");
		String q1 = "select max(substr(txid,5,6)) from rws_bill_bank_settlement_tbl where substr(txid,1,4)=?";
		st1=conn.prepareStatement(q1);
		st1.setString(1, serverDate.substring(6,10));
		rs1 = st1.executeQuery();
		String txId = "";
		int txIdd = 0;
		if(rs1.next())
		{
			if(rs1.getString(1)!=null && !rs1.getString(1).equals(""))
				txIdd = rs1.getInt(1);
		}
		txIdd++;
		txId = ""+txIdd;
		if(txId==null || (txId!=null && (txId.equals("") || txId.equals("0"))))
			txId = "000001";
		if(txId.length()==1)txId="00000"+txId;
		else if(txId.length()==2)txId="0000"+txId;
		else if(txId.length()==3)txId="000"+txId;
		else if(txId.length()==4)txId="00"+txId;
		else if(txId.length()==5)txId="0"+txId;
		txId = serverDate.substring(6,10)+txId;
		String qry = "select bank_name,branch_name,account_no,dname,division_office_name,micr_code,a.office_code,SUM(BILL_AMOUNT_CENTRAL),mapping_code  from rws_office_bank_account_tbl a,rws_district_tbl b,rws_division_office_tbl c ,rws_bank_tbl d,rws_branch_tbl e,rws_bill_bank_bridge_temp_tbl br  where BILL_ACTIVATION_FLAG ='S' and   br.office_code=a.office_code and substr(a.office_code,2,2)=b.dcode and substr(a.office_code,4,1)=c.division_office_code and  b.dcode=c.circle_office_code  and a.bank_code=d.bank_code and a.branch_code=e.branch_code group by bank_name,branch_name,account_no,dname,division_office_name,micr_code,a.office_code,mapping_code";
		  stmt = conn.createStatement();
		  rs = stmt.executeQuery(qry);
		  %>
		<table border = 1 align=center bordercolor=black style="border-collapse:collapse">
		<tr><td colspan="11" class="btext" align="center">Group Transaction ID: <%=txId%>
			<input type="hidden" name="txId" value="<%=txId%>"></td></tr>
			 <tr align="center">
				<td class=btext>Sl. No.</td>
				<td class=btext>Transaction Id</td>
				<td class=btext>Circle</td>
				<td class=btext>Division</td>
				<td class=btext>Bank</td>
				<td class=btext>Branch</td>
				<td class=btext>MICR Code</td>
				<td class=btext>A/C No.</td>
				<td class=btext>Central Share</td>
				<td class=btext>Narration</td>
				<td class=btext>Remarks</td>
			</tr>
		<%
			String val = "";
			if(rs.isBeforeFirst())
			{
				while(rs.next())
				{
					String txIdDiv = "";
					String count1 = ""+count;
					if(count1.length()==1)txIdDiv = "0"+count1;
					else txIdDiv = count1;
					txIdDiv = txId + txIdDiv;
					%>
					<tr>
						<td class="rptValue" nowrap><%=count%></td>
						<td class="rptValue" nowrap><%=txIdDiv%></td>
						<td class="rptValue" nowrap><%=rs.getString(4)%></td>
						<td class="rptValue" nowrap><%=rs.getString(5)%></td>
						<td class="rptValue" nowrap><%=rs.getString(1)%></td>
						<td class="rptValue" nowrap><%=rs.getString(2)%></td>
						<td class="rptValue" nowrap><%=rs.getString(6)%></td>
						<td class="rptValue" nowrap><%=rs.getString(3)%></td>
						<td class="rptValue" nowrap align="right"><%=rs.getString(8)%></td>
						<input type="hidden" name="officeCode<%=count%>" value="<%=rs.getString(7)%>">
						<input type="hidden" name="acNo<%=count%>" value="<%=rs.getString(3)%>">
						<input type="hidden" name="amtCentral<%=count%>" value="<%=rs.getString(8)%>">
						<input type="hidden" name="txIdDiv<%=count%>" value="<%=txIdDiv%>">
						<input type="hidden" name="acNoMap<%=count%>" value="<%=rs.getString("mapping_code")%>">					
						<td><textarea name="narration<%=count%>" cols="15" rows="2" onkeyup="return ismaxlength(this)" maxlength="30"></textarea></td>
						<td><textarea name="remarks<%=count%>" cols="15" rows="2" onkeyup="return ismaxlength(this)" maxlength="30"></textarea></td>
					</tr>
				<%
						count++;
				}
			}
			else
			{
				%>
				<tr>
					<td align="center" colspan="11" class="btext">There are No Bills to Forward</td>
				</tr>
		<%
			}
		%>
		<input type="hidden" name="sendBank" value="<%=--count%>">
		</table><BR>
		<table align="center">
		<%if(count>=1){%>
		<tr>
			<td align="center">
			<input type=button name=getValues value="Back" onclick="fnBack()" class="btext">&nbsp;&nbsp;
				<input type=button name=getValues value="Close" onclick="fnClose()" class="btext">&nbsp;&nbsp;
				<!-- to enable bank transaction also - modified on 23-1-2015---> 
				<input type=button name=getValues value="Forward to Bank" onclick="fnSaveBank()"  id=fnSavve class="btext">
				<!-- end of bank button -->
				
				<input type=button name=getValues value="Forward to PAO" onclick="fnSave()"  id=fnSavve class="btext">
			</td>
		</tr>
		<%}%>
		</table>
	<%}
		catch(Exception e){
		System.out.println("Exception in  rws_bill_release_to_bank_division:"+e.getMessage());
		}
		finally{
		try{
			if(rs!=null)rs.close();if(stmt!=null)stmt.close();
			if(rs1!=null)rs1.close();if(st1!=null)st1.close();
			if(stmtTemp!=null)stmtTemp.close();if(stT!=null)stT.close();
			if(conn!=null)conn.close();
		}catch(Exception eee){
			System.out.println("Exception at finally block of rws_bill_release_to_bank_division : "+eee.getMessage());
			}
		}
	
	%>
	<script>
	function fnCalState(val)
	{
		if(parseInt(document.getElementById('stateca'+val).value)>100)
		{
			document.getElementById('stateca'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			alert("State Percentage Should be in Between 1-100");
		}
		if((parseInt(document.getElementById('stateca'+val).value)+parseInt(document.getElementById('goica'+val).value))>100)
		{
			document.getElementById('stateca'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			alert("State+GOI Percentage Should be in Between 1-100");
		}
		else
		{
			var value = parseFloat(document.getElementById('totc'+val).value)*((parseFloat(document.getElementById('stateca'+val).value))/100);
			if(isNaN(value))
			{
				document.getElementById('statec'+val).value = '0';
			}
			else
			{
				document.getElementById('statec'+val).value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
	}	
	function fnCalCentral(val)
	{
		if(parseInt(document.getElementById('goica'+val).value)>100)
		{
			document.getElementById('goica'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("GOI Percentage Should be in Between 1-100");
		}
		if((parseInt(document.getElementById('stateca'+val).value)+parseInt(document.getElementById('goica'+val).value))>100)
		{
			document.getElementById('goica'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("State+GOI Percentage Should be in Between 1-100");
		}
		else
		{
			var value = parseFloat(document.getElementById('totc'+val).value)*((parseFloat(document.getElementById('goica'+val).value))/100);
			if(value=="" || value == null || isNaN(value))
			{
				document.getElementById('goic'+val).value = '0';
			}
			else
			{
				document.getElementById('goic'+val).value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
		var value = parseFloat(document.getElementById('totc'+val).value)*((parseFloat(document.getElementById('goica'+val).value))/100);
		if(value=="" || value == null || isNaN(value))
		{
			document.getElementById('goic'+val).value = '0';
		}
		else
		{
			document.getElementById('goic'+val).value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
		}
	}
	function fnCheckMax(val)
	{
		fnCalState(val);
		fnCalCentral(val);
		if((parseFloat(document.getElementById('totc'+val).value))>(parseFloat(document.getElementById('tota'+val).value)))
		{
			document.getElementById('totc'+val).value = '0';
			document.getElementById('statec'+val).value = '0';
			document.getElementById('goic'+val).value = '0';
			alert("Now Recommended Amount Should be Less than or Equal to Bill Amount Due");
		}
	}
	function fnCalCentralPer(val)
	{
		if(parseFloat(document.getElementById('goic'+val).value)>parseFloat(document.getElementById('totc'+val).value))
		{
			document.getElementById('goic'+val).value = '0';
			document.getElementById('goica'+val).value = '0';
			alert("GOI Amount of Now Recommended Should be in Less than or equal to Actual Amount of Now Recommended");
		}
		else
		{
			var value = ((parseFloat(document.getElementById('goic'+val).value))/(parseFloat(document.getElementById('tota'+val).value)))*100;
			if(value=="" || value == null || isNaN(value))
			{
				//document.getElementById('goic'+val).value = '0';
			}
			else
			{
				document.getElementById('goica'+val).value = value;//Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
	}
	function fnSave()
	{
		var flag = true;
		var totcount='<%=count%>';
		for(var i=1;i<=totcount;i++)
		{
			if(parseFloat(document.getElementById('amtCentral'+i).value)<=0)
			{
				alert("Invalid Amount("+document.getElementById('amtCentral'+i).value+") provided for the Sl. No:"+i+"\n Please ensure the Correctness of Amount with EE-Budget ");
				document.getElementById('fnSavve').disabled=true;
				document.getElementById('fnSavve').value="Cannot Forward";
				return false;
			}
		}
		for(var i=1;i<=document.forms[0].sendBank.value;i++)
		{
			if(document.getElementById('narration'+i).value!="")
			{
				if(document.getElementById('narration'+i).value.indexOf("iframe src")!=-1 || document.getElementById('narration'+i).value.indexOf("img src")!=-1)
				{
					alert("Invalid Narration - Please Enter Again");
					flag = false;
					document.getElementById('narration'+i).value='';
					document.getElementById('narration'+i).focus();
				}
			}
			if(flag)
			{
				if(document.getElementById('remarks'+i).value!="")
				{
					if(document.getElementById('remarks'+i).value.indexOf("iframe src")!=-1 || document.getElementById('remarks'+i).value.indexOf("img src")!=-1)
					{
						alert("Invalid Remarks - Please Enter Again");
						flag = false;
						document.getElementById('remarks'+i).value='';
						document.getElementById('remarks'+i).focus();
					}
				}
			}
		}
		if(flag)
		{
			if(confirm("Are You Sure"))
			{
				document.getElementById('fnSavve').value="Forwarding Wait...";
				//document.forms[0].action="rws_bill_release_to_bank_div_save.jsp";
				document.forms[0].action="rws_bill_release_to_bankpao_div_save.jsp";
				document.forms[0].submit();
			}
		}
	}
	
	function fnSaveBank()
	{
		var flag = true;
		var totcount='<%=count%>';
		for(var i=1;i<=totcount;i++)
		{
			if(parseFloat(document.getElementById('amtCentral'+i).value)<=0)
			{
				alert("Invalid Amount("+document.getElementById('amtCentral'+i).value+") provided for the Sl. No:"+i+"\n Please ensure the Correctness of Amount with EE-Budget ");
				document.getElementById('fnSavve').disabled=true;
				document.getElementById('fnSavve').value="Cannot Forward";
				return false;
			}
		}
		for(var i=1;i<=document.forms[0].sendBank.value;i++)
		{
			if(document.getElementById('narration'+i).value!="")
			{
				if(document.getElementById('narration'+i).value.indexOf("iframe src")!=-1 || document.getElementById('narration'+i).value.indexOf("img src")!=-1)
				{
					alert("Invalid Narration - Please Enter Again");
					flag = false;
					document.getElementById('narration'+i).value='';
					document.getElementById('narration'+i).focus();
				}
			}
			if(flag)
			{
				if(document.getElementById('remarks'+i).value!="")
				{
					if(document.getElementById('remarks'+i).value.indexOf("iframe src")!=-1 || document.getElementById('remarks'+i).value.indexOf("img src")!=-1)
					{
						alert("Invalid Remarks - Please Enter Again");
						flag = false;
						document.getElementById('remarks'+i).value='';
						document.getElementById('remarks'+i).focus();
					}
				}
			}
		}
		if(flag)
		{
			if(confirm("Are You Sure"))
			{
				document.getElementById('fnSavve').value="Forwarding Wait...";
				document.forms[0].action="rws_bill_release_to_bank_div_save.jsp";
				//document.forms[0].action="rws_bill_release_to_bankpao_div_save.jsp";
				document.forms[0].submit();
			}
		}
	}
	
	<!--bank function end-->
	</script>
</form>
<p align="left">
<font face="verdana" size="2" color="red">
Note********: Works Displayed above under the following programmes which are related to <b>NRDWP</b></font><BR>
<span class="style1"><bean:message key="app.nrdwprelatedfin"/></span></p>
</body>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>