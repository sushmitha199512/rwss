<%@page import="java.sql.*, javax.sql.*, javax.naming.*,java.io.*,java.io.File,java.text.SimpleDateFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>
<%
try
{
Statement stmt1 = conn.createStatement();
Statement stmt2 = conn.createStatement();
ResultSet rs1=null;
String samount="";
stmt = conn.createStatement();
String qry="",q1="";
int totValues = Integer.parseInt(request.getParameter("sendBank"));
double totAmt = 0.0;
for(int i=1;i<=totValues;i++)
{
samount=request.getParameter("amtState"+i);
//System.out.println("stateamount"+samount);
	qry = "insert into rws_bill_pao_settlement_tbl(txid,txid_div,OFFICE_CODE,BILL_AMOUNT_STATE,GRANT_NAME,REMARKS,SEND_DATE,payment_mode,AMOUNT_RELEASED,BALANCE,programme_code) values ('"+request.getParameter("txId")+"','"+request.getParameter("txIdDiv"+i)+"','"+request.getParameter("officeCode"+i)+"',"+request.getParameter("amtt"+i)+",'"+request.getParameter("grant"+i)+"','"+request.getParameter("remarks"+i)+"',sysdate,'"+request.getParameter("pmode"+i)+"','"+request.getParameter("amountR"+i)+"','"+request.getParameter("bal"+i)+"','"+request.getParameter("grantcode"+i)+"')";
	
	 stmt.addBatch(qry);
}

qry = "insert into rws_bill_pao_bridge_det_tbl SELECT WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUT_state,SYSDATE,'Y','"+request.getParameter("txId")+"','P' from rws_bill_pao_bridge_temp_tbl";

	stmt.addBatch(qry);


String q="select distinct work_id,bill_sl_no,BILL_AMOUT_STATE from rws_bill_bank_bridge_tbl";
//System.out.println("q1:"+q);
Hashtable ht1 = new Hashtable();
stmt2 = conn.createStatement();
ResultSet rs2=stmt2.executeQuery(q);
while(rs2.next())
{
	ht1.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)); 
}
 //System.out.println("Q:"+q);
 q = "select * from rws_bill_pao_bridge_temp_tbl";

rs=stmt1.executeQuery(q);
while(rs.next())
{
	String val = ""+ht1.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
	//System.out.println("val:"+val);
	if(val!=null && !val.equals("null")){
		qry = "update rws_bill_bank_bridge_tbl set BILL_AMOUT_STATE=BILL_AMOUT_STATE+"+rs.getString(4)+",STATE_SEND_DATE=sysdate,STATE_TXID='"+request.getParameter("txId")+"',STATE_FLAG='Y',office_code='"+rs.getString(2)+"' where work_id='"+rs.getString(1)+"' and bill_sl_no = '"+rs.getString(3)+"'";
	//update logic
	}else{
		//insert logic
		qry = "insert into rws_bill_bank_bridge_tbl values('"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"','0','','Y','N','','P','"+request.getParameter("txId")+"',sysdate)";
	}
	//System.out.println("Qry4:"+qry);
		stmt.addBatch(qry);
}
	
		

	qry = "delete from rws_bill_pao_bridge_temp_tbl";
		//System.out.println("Qry5:"+qry);
		stmt.addBatch(qry);
		int[] size = stmt.executeBatch();
		conn.setAutoCommit(true);
		conn.commit();
		if(size.length>0)
	    {
		%>
		<script>
			alert("PAO Details are Send Successfully");
			document.location.href="rws_bill_release_to_pao_division.jsp";
		</script>
	    <%
	    }
	else
	{
		conn.rollback();
	%>
		<script>
			alert("Failed to Forward - Try Again");
			document.location.href="rws_bill_release_to_pao_division.jsp";
		</script>
	<%
	}
 }
catch(Exception e)
{
	System.out.println("Exception at rws_bill_release_to_pao_div_save : "+e);
	%>
	<script>
			alert("Failed to Save - Try Again");
			document.location.href="rws_bill_release_to_pao_division.jsp";
		</script>
		<%
}
%>