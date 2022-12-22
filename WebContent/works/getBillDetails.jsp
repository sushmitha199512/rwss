
<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<% 		
DecimalFormat ndf = new DecimalFormat("####.00");
String workId = request.getParameter("workId");
String bill = request.getParameter("bill");
System.out.println("Bill:"+bill);
ResultSet rs123 = null,rsBill=null;
String returnValue = "";
try{
   Statement stqq =null; 
   ResultSet rsqq = null;
	String getAmount = "";
	Statement gmst1 = conn.createStatement();
	Statement stmtBill = conn.createStatement();
		 	   if(bill.equals("0"))
		 	   {
		 	   		getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
		 	   		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
			 	   if(gmrs1.next())
			 		{
			 			returnValue = gmrs1.getString(1);
			 		}
			 		else
			 		{
			 			returnValue = "0";
			 		}
		 	   }
		 	  else
		 	  {
		 	  		getAmount = "select (select nvl(BILL_AMOUNT_CENTRAL,0)  from rws_bill_bank_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' and BILL_ACTIVATION_FLAG='P')a,(select nvl(BILL_AMOUT_state,0)  from rws_bill_pao_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' and BILL_ACTIVATION_FLAG='P')b from dual";
					
					getAmount = "select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' and BILL_ACTIVATION_FLAG='P')a,(select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' and BILL_ACTIVATION_FLAG='P')b from dual";
					System.out.println("WQyr:"+getAmount);
		 	  		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
		 	   		long val1=0,val2=0;
			 	   if(gmrs1.next())
			 		{
			 	   		if(gmrs1.getString(1)!=null && !gmrs1.getString(1).equals(""))
			 	   			val1 = gmrs1.getLong(1);
			 	   		if(gmrs1.getString(2)!=null && !gmrs1.getString(2).equals(""))
			 	   			val2 = gmrs1.getLong(2);
			 		}
		 	   		returnValue = ""+(val1+val2);
		 	  }
				 		returnValue += "^";
String stat123="select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
//System.out.println("stat123:"+stat123);
stqq = conn.createStatement();
rsqq=stqq.executeQuery(stat123);
 if(rsqq.next())
{
	//returnValue += ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2)
	returnValue += rsqq.getString(1);//""+ndf.format(Math.round(Float.parseFloat(rsqq.getString(1))*100000*100)/100f);
}
else
{
	returnValue += "0";
}
 
 
 
  ///Bill Details Fetching  
  
  returnValue += "^";
 String billDetQuery="select CM_BY_DEE,CM_MBOOK_PG_NO,to_char(CM_DT,'dd/mm/yyyy'),SCM_BY_SE,SCM_SE_MBOOK_PG_NO,to_char(SCM_SE_DT,'dd/mm/yyyy')  from rws_work_bill_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
 
 //System.out.println("billDetQuery"+billDetQuery);

rsBill=stmtBill.executeQuery(billDetQuery);
if(rsBill.next())
{
	//returnValue += ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2)
	returnValue += rsBill.getString(1);
	returnValue += "^";
	returnValue += rsBill.getString(2);
	returnValue += "^";
	
	returnValue += rsBill.getString(3);
	returnValue += "^";
	returnValue += rsBill.getString(4);
	returnValue += "^";
	returnValue += rsBill.getString(5);
	returnValue += "^";
	returnValue += rsBill.getString(6);
	returnValue += "^";
	
	
	
}
else
{
	returnValue += "0";
}

  
  
}
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
   } 
   finally
   {
		try
		{
		}
		catch(Exception d)
		{

		}
}
   %>
<%=returnValue%>

