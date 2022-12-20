
<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<% 		
DecimalFormat ndf = new DecimalFormat("####.00");
String workId = request.getParameter("workId");
String bill = request.getParameter("bill");
System.out.println("Bill:"+bill);
ResultSet rs123 = null;
String returnValue = "";
try{
   Statement stqq =null; 
   ResultSet rsqq = null;
	String getAmount = "";
	Statement gmst1 = conn.createStatement();
		 	   if(bill.equals("0"))
		 	   {
		 	   		getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
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
		 	  		//getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
					
					getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
					System.out.println("WQyr--------->:"+getAmount);
		 	  		ResultSet gmrs2 = gmst1.executeQuery(getAmount);
		 	   		long val1=0,val2=0;
			 	   if(gmrs2.next())
			 		{
			 	   		if(gmrs2.getString(1)!=null && !gmrs2.getString(1).equals(""))
			 	   			val1 = gmrs2.getLong(1);
			 	   		//if(gmrs2.getString(2)!=null && !gmrs2.getString(2).equals(""))
			 	   			//val2 = gmrs2.getLong(2);
			 		}
		 	   		returnValue = ""+(val1+val2);
		 	  }
				 		returnValue += "/";
String stat123="select nvl(sum(voucher_amt),0) from rws_work_direct_voucher_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
System.out.println("stat123---------->:"+stat123);
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

