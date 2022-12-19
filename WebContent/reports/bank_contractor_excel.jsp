<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "bank_contractor_excel.xls");
String sdate1="";
sdate1=(String)session.getAttribute("sdate");
String stype1="";
stype1=(String)session.getAttribute("stype");
String snum1="";
snum1=(String)session.getAttribute("snum");
Statement stmt1=conn.createStatement();
ResultSet rs1=null;
String qry=null;
%>
<table>
<tr><td class=btext align="center">Contractor Details</td></tr></table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr >
   <td bgcolor="green" colspan=13 align="center"><font face="verdana" size=2 color="white" ><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date :<%=sdate1%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type :<%=stype1%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;File Number :<%=snum1%></b></font></td>
</tr>
<tr align=center>
<td class=btext ><b>Sl.No</b></td>
<td class=btext ><b>TXID_Contractor</b></td>
<td class=btext ><b>Contractor_Code</b></td>
<td class=btext ><b>Contractor_Name </b></td>
<td class=btext ><b>Contractor_Acc_No </b></td>
<td class=btext ><b>Contractor_IFSC_Code</b></td>
<td class=btext ><b>Debit_Acc_No</b></td>
<td class=btext ><b>Debit_IFSC_Code </b></td>   
<td class=btext ><b>TX_Status</font> </b></td>
<td class=btext ><b>Bank_TX_Date  </b></td>
<td class=btext ><b>Bank_Ref_No</b></td> 
<td class=btext ><b>Remarks</b></td> 
<td class=btext ><b>Transaction_Amount </b></td> 
  </tr>
  <tr>
  <%
  try{
	  int count=0;
	  long gtot=0;
	  long amt=0;
	  String q1="";
	  qry="select distinct TXID_CONTRACTOR,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY,CONTRACTOR_ACCOUNT_NO,CONTRACTOR_IFSC_CODE,DEBIT_ACC_NO,DEBIT_IFSC_CODE,decode(TX_STATUS,'A','ACKNOWLEDGED','P','PAID','R','REJECTED','O','OPENED'),to_char(BANK_TX_DATE,'dd/mm/yyyy'),BANK_REF_NO,nvl(a.REMARKS,'-'),TRANSACTION_AMOUNT from  rws_contractor_settlement_tbl a,rws_contractor_tbl b where a.CONTRACTOR_CODE=b.CONTRACTOR_CODE ";
	  if(sdate1 !=null && !sdate1.equals(""))
	  {
		  qry+="and to_char(FTX_DATE,'dd/mm/yyyy')='"+sdate1+"'";
	  }

	  if(stype1!=null && !stype1.equals(""))
	  {
		  qry+="and NEFT_RTGS_INTR='"+stype1+"'";
		  
	  }
	  if(snum1!=null && !snum1.equals(""))
	  {
		  qry+="and FILE_NUMBER='"+snum1+"'";
		  
	  }
	  System.out.println("queryyyy"+qry);
	  stmt1=conn.createStatement();

	  rs1=stmt1.executeQuery(qry);
	  System.out.println("queryyy1"+qry);

	  while(rs1.next())
	  {
	  count++;
	  String s1=rs1.getString(1);
	  System.out.println("query2"+s1);
	  

%>

<td class=rptvalue align="center"><%=count%></td>
<td  class=rptvalue align="center"><%=rs1.getString(1)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(2)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(3)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(4)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(5)%> </td>
<td  class=rptvalue align="right"><%=rs1.getString(6)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(7)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(8)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(9)%> </td>
<td  class=rptvalue align="center"><%=rs1.getString(10)%></td>
<td  class=rptvalue align="center"><%=rs1.getString(11)%></td>
<td  class=rptvalue align="right"><%=rs1.getString(12)%></td>


</tr>

<%   amt+=rs1.getInt(12);
	  }%>
<tr>
<td class=btext colspan=12 align="right">Total:</td><td align="right" class=btext><%=amt%></td>
</tr>
<%
	  if(count==0)
	  {%>
	  <tr align=center>
	  <td colspan='13'>No Records</td>
	  </tr>
	  <%}

  }
catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
  





</table>
</body>
</html>