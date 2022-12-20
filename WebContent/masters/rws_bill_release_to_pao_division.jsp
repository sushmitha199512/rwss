<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />     
<%String pcode = request.getParameter("pcode");
NumberFormat formatter = new DecimalFormat("#0.00");
		  int count = 1,sno=0;	%>
<html>
<style>
#input_box {
	background-color:#C9DFF4;
	font-weight:bold;
}
</style>
<script language="javascript">

function fnPrint()

{
	var width = 900;
	var height = 600;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_bill_tobe_release_rpt_secy_prt.jsp";
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow1 = window.open(url, "_New", properties);
	newWindow1.focus();
}
function wopen(url, name, w, h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function fnClose()
{
	document.location.href="../home.jsp";
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
						<a href="<rws:context page='/home.jsp'/>">Home</a><!-- Print --></a>
					</td>
					
				</tr>
			</table>
		</caption>
</table>
		<table>
		<tr  align="center">
			<td align="center" class="rptHeading" style="width:350">State Payment Dues-Forwarding Form</td>
			<td class="rptHeading" style="width:300" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		</table>
		<%
	//	System.out.println("1");
		DecimalFormat ndf = new DecimalFormat("####.00");
		double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0;
		PreparedStatement st1 = null;
		ResultSet rs1=null;
	try
	{
		String serverDate = (String)session.getAttribute("serversysdate");
		//System.out.println("Server Date:"+serverDate);
		String q1 = "select max(substr(txid,5,6)) from rws_bill_pao_settlement_tbl where substr(txid,1,4)=?";
		st1 = conn.prepareStatement(q1);
		st1.setString(1, serverDate.substring(6,10));
		//System.out.println("Qry:"+q1);
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
		//System.out.println("Tx Id:1:"+txId);
		if(txId.length()==1)txId="00000"+txId;
		else if(txId.length()==2)txId="0000"+txId;
		else if(txId.length()==3)txId="000"+txId;
		else if(txId.length()==4)txId="00"+txId;
		else if(txId.length()==5)txId="0"+txId;
		txId = serverDate.substring(6,10)+txId;
		//System.out.println("Tx Id:2:"+txId);
		String qry = "select dname,division_office_name,SUM(BILL_AMOUT_STATE),to_char(sysdate,'dd/mm/yyyy'),OFFICE_CODE,programme_name,programme_code,dcode,division_office_code from rws_district_tbl a,rws_division_office_tbl b ,rws_bill_pao_bridge_temp_tbl c,rws_programme_tbl d  where a.dcode=b.CIRCLE_OFFICE_CODE and b.DIVISION_OFFICE_CODE =substr(c.office_code,4,1)  and a.dcode=substr(c.office_code,2,2) and d.programme_code=substr(work_id,1,2) group by  dname,division_office_name ,office_code,programme_name,programme_code,dcode,division_office_code order by dcode,division_office_code";
		//System.out.println("qry:"+qry);
		  stmt = conn.createStatement();
		  rs = stmt.executeQuery(qry);
		  %>
		<table border = 1 align=center bordercolor=black style="border-collapse:collapse">
		<tr><td colspan="11" class="btext" align="center">Group Transaction ID: <%=txId%>
			<input type="hidden" name="txId" value="<%=txId%>"></td></tr>
			 <tr align="center">
				<td class=btext>Sl. No.</td>
				<td class=btext>Transaction ID</td>
				<td class=btext>Circle</td>
				<td class=btext>Division</td>
				<td class=btext>State Share Due</td>
				<td class=btext>Grant</td>
				<td class=btext>Amount Released</td>
				<td class=btext>Balance Due</td>
				<td class=btext>Payment <br>Mode</td>
				<td class=btext>Date</td>
				<td class=btext>Remarks</td>
			</tr>
		<%
			String val = "";
		  double tstate=0.0,state=0.0,bal=0.0;
		
			if(rs.isBeforeFirst())
			{
				while(rs.next())
				{
					String qq = "select sum(bill_amout_state) from rws_bill_pao_bridge_temp_tbl where substr(work_id,1,2)=? and substr(work_id,5,2)=? and substr(office_code,4,1)=?";
					PreparedStatement ssss = conn.prepareStatement(qq);
					ssss.setString(1, rs.getString(7));
					ssss.setString(2, rs.getString(8));
					ssss.setString(3, rs.getString(9));
					ResultSet rrr = ssss.executeQuery();
					double amtt = 0.0;
					if(rrr.next())amtt=rrr.getDouble(1);
					String txIdDiv = "";
					String count1 = ""+count;
					if(count1.length()==1)txIdDiv = "0"+count1;
					else txIdDiv = count1;
					txIdDiv = txId + txIdDiv;
					//System.out.println("in txIdDiv:"+txIdDiv);
					//System.out.println("in txId:"+txId);
					//System.out.println("in loop1:"+count);
		%>
		<tr>
		<td class="rptValue" nowrap align="center"><%=count%></td>
		<td class="rptValue" nowrap><%=txIdDiv%></td>
		<td class="rptValue" nowrap><%=rs.getString(1)%></td>
		<td class="rptValue" nowrap><%=rs.getString(2)%></td>
		<td class="rptValue" nowrap align="right"><%=formatter.format(amtt)%></td>
		<td class="rptValue" nowrap><%=rs.getString(6)%></td>
		<td class="rptValue" nowrap align="right"><%=formatter.format(rs.getDouble(3))%></td>
		<td class="rptValue" nowrap><%=formatter.format(amtt-rs.getDouble(3))%></td>
        <td class="rptValue" nowrap><select name="pmode<%=count%>" style="width:62px" class="myCombo"><option value="1">PAO</option><option value="2">Saving Bank A/C</option><option value="3">PD A/C</option></select></td>
		<td class="rptValue" nowrap><%=rs.getString(4)%></td>
		<td><textarea name="remarks<%=count%>" cols="15" rows="2"></textarea></td>
		<input type="hidden" name="officeCode<%=count%>" value="<%=rs.getString(5)%>">
		<input type="hidden" name="grant<%=count%>" value="<%=rs.getString(6)%>">
		<input type="hidden" name="grantcode<%=count%>" value="<%=rs.getString(7)%>">
		<input type="hidden" name="amountR<%=count%>" value="<%=rs.getString(3)%>">
		<input type="hidden" name="txIdDiv<%=count%>" value="<%=txIdDiv%>">
		<input type="hidden" name="amtt<%=count%>" value="<%=amtt%>">
		<input type="hidden" name="bal<%=count%>" value="<%=amtt-rs.getDouble(3)%>">
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
		</table><br>
		<%if(count>=1){%>
		<table>
		<tr>
			<td align="center" colspan"9">
				<input type=button name=getValues value="Close" onclick="fnClose()" class="btext">&nbsp;&nbsp;
				<input type=button name=getValues value="Save" onclick="fnSave()" id=fnSavve class="btext">
			</td>
		</tr>
		</table>
		<%}%>
	<%}
		catch(Exception e){
		System.out.println("Exception in rws_bill_release_to_pao_division : "+e.getMessage());
		}
		finally{
		try{
			if(rs!=null)rs.close();if(stmt!=null)stmt.close();
			if(rs1!=null)rs1.close();if(st1!=null)st1.close();
			
			if(conn!=null)conn.close();
		}catch(Exception eee){eee.getMessage();}
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
		var totcount='<%=count%>';
		for(var i=1;i<=totcount;i++)
		{
			if(parseFloat(document.getElementById('amountR'+i).value)<=0)
			{
				alert("Invalid Amount("+document.getElementById('amountR'+i).value+") provided for the Sl. No:"+i+"\nPlease ensure the Correctness of Amount with EE-Budget ");
				document.getElementById('fnSavve').disabled=true;
				document.getElementById('fnSavve').value="Cannot Forward";
				return false;
			}
		}
		if(confirm("Are You Sure"))
		{
			document.getElementById('fnSavve').disabled=true;
			document.getElementById('fnSavve').value="Forwarding Wait...";
			document.forms[0].action="rws_bill_release_to_pao_div_save.jsp";
			document.forms[0].submit();
		}
	}
	</script>
		
</form>

</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>