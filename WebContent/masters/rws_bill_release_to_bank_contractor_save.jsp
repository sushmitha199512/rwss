<%@page import="java.sql.*, javax.sql.*, javax.naming.*,java.io.*,java.io.File,java.text.SimpleDateFormat"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<jsp:useBean id="lakh" class="nic.watersoft.commons.IndianLakhs" />
<%
NumberFormat formatter = new DecimalFormat("#0.00");
String newLine = "\r\n";
String data = "";
try
{
Statement stmt2=null,stmt1=null;
int totValues = Integer.parseInt(request.getParameter("sendBank"));
//System.out.println("bank tx id:"+request.getParameter("txId"));
//System.out.println("bank transaction");
//conn.setAutoCommit(false);
stmt = conn.createStatement();
String qq = "select nvl(sum(case when programme_code='60' or programme_code='02' or  programme_code='01' or programme_code='48' or programme_code='32' or programme_code='23' or programme_code='49' or programme_code='51' or programme_code='18' or  programme_code='59' or  programme_code='58' or  programme_code='50'  then bill_amount_central else 0 end),0) as a from rws_bill_bank_bridge_temp_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id";
Statement ss = conn.createStatement();
ResultSet rr = ss.executeQuery(qq);
rr.next();
String qq1 = "update RWS_BANK_GRANT_AMT_TBL set AMOUNT=AMOUNT-"+rr.getString(1)+" where code='1'";
//System.out.println("qq1:"+qq1);
stmt.addBatch(qq1);
String qry = "delete from rws_bill_bank_bridge_temp_tbl";
//stmt.addBatch(qry);
double totAmt = 0.0;
for(int i=1;i<=totValues;i++)
{
	System.out.println(i);
	System.out.println(request.getParameter("officeCode"+i));
	System.out.println(request.getParameter("officeCode"+i));
	System.out.println(request.getParameter("acNo"+i));
	System.out.println(request.getParameter("acNoMap"+i));
	System.out.println(request.getParameter("amtCentral"+i));
	System.out.println(request.getParameter("txIdDiv"+i));
	qry = "insert into rws_bill_bank_settlement_tbl values ('"+request.getParameter("txId")+"','"+request.getParameter("txIdDiv"+i)+"','"+request.getParameter("officeCode"+i)+"','"+request.getParameter("acNo"+i)+"','"+request.getParameter("amtCentral"+i)+"','I',sysdate,sysdate,'','"+request.getParameter("narration"+i)+"','"+request.getParameter("remarks"+i)+"','')";
	data += "T^"+request.getParameter("txIdDiv"+i)+"^"+request.getParameter("acNoMap"+i)+"^"+formatter.format(Double.parseDouble(request.getParameter("amtCentral"+i)))+"^C^O^"+request.getParameter("narration"+i)+"^"+request.getParameter("remarks"+i)+"^";
	data += newLine;
	totAmt += workData.round((Double.parseDouble(request.getParameter("amtCentral"+i))),2);
	System.out.println("Qry:"+qry);
	stmt.addBatch(qry);
}
String summary = "S^"+totValues+"^"+formatter.format(totAmt)+"^";
//System.out.println("Data:"+data);
//System.out.println("summary:"+summary);

	qry = "insert into rws_bill_bank_bridge_det_tbl SELECT WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUNT_CENTRAL,SYSDATE,'Y','"+request.getParameter("txId")+"',BILL_ACTIVATION_FLAG from rws_bill_bank_bridge_temp_tbl";
	System.out.println("Qry:"+qry);
	stmt.addBatch(qry);

	String q="select distinct work_id,bill_sl_no,BILL_AMOUT_STATE from rws_bill_bank_bridge_tbl";
System.out.println("q1:"+q);
	Hashtable ht1 = new Hashtable();
	stmt2 = conn.createStatement();
	ResultSet rs2=stmt2.executeQuery(q);
	while(rs2.next())
	{
       System.out.println("values"+rs2.getString(1)+"----"+rs2.getString(2)+"======"+rs2.getString(3));
		ht1.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)); 
	}
	stmt1 = conn.createStatement();
	q = "select * from rws_bill_bank_bridge_temp_tbl";
	System.out.println("q2:"+q);
	rs=stmt1.executeQuery(q);
	while(rs.next())
	{
		String val = ""+ht1.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
		System.out.println("val:"+val);
		if(val!=null && !val.equals("null"))
		{
			qry = "update rws_bill_bank_bridge_tbl set BILL_AMOUNT_central=BILL_AMOUNT_central+"+rs.getString(5)+",BANK_SEND_DATE=sysdate,TXID='"+request.getParameter("txId")+"',central_flag='Y',office_code='"+rs.getString(2)+"' where work_id='"+rs.getString(1)+"' and bill_sl_no = '"+rs.getString(3)+"'";
		//update logic
		}
		else
		{
			qry = "insert into rws_bill_bank_bridge_tbl values('"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','0','"+rs.getString(5)+"',sysdate,'N','Y','"+request.getParameter("txId")+"','I','','')";
		}
		System.out.println("Qry4:"+qry);
		stmt.addBatch(qry);
	}
	
	qry = "delete from rws_bill_bank_bridge_temp_tbl";
	//System.out.println("Qry:"+qry);
	stmt.addBatch(qry);

	int[] size = stmt.executeBatch();
	//System.out.println("1:"+totValues);
	System.out.println("bank size:"+size.length);

	if(size.length>0)
	{
		//File Logic Goes here
		String date1=(String)session.getAttribute("serversysdate");
		int da = Integer.parseInt(date1.substring(0,2));
		int mn = Integer.parseInt(date1.substring(3,5));
		int ye = Integer.parseInt(date1.substring(6,10));
		String mn1="",da1="";
		String month[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
		if(mn<=9)mn1="0"+mn;else mn1=""+mn;
		if(da<=9)da1="0"+da;else da1=""+da;
		//System.out.println("REAL PATH xxxxxxxxxxxxxxxxx "+request.getRealPath(""));
		File f2=new File(request.getRealPath("")+"/downloads/bank/"+ye+"/"+month[mn-1]+"-"+ye+"/"+da1+"-"+mn1+"-"+ye);
		if(f2.exists()==false){
		f2.mkdirs();  
		}


 //added by sai prasad
        String ffpath="/usr/local/apache-tomcat-6.0.18/webapps/pred/downloads/bank/"+ye+"/"+month[mn-1]+"-"+ye+"/"+da1+"-"+mn1+"-"+ye;
		File f3=new File(ffpath);
		System.out.println("File path is "+ffpath);
		if(f3.exists()==false){
			System.out.println("Creting directory");
		f3.mkdirs();  
		}
//done
		File[] contents = f2.listFiles();
		int count = contents.length;
		count++;
		String dcount="";
		if(count<=9)
		dcount="0"+count;
		else dcount=Integer.toString(count);
		String fname="RWANDB"+ye+mn1+da1+"."+dcount;
		String filePath = request.getRealPath("")+"/downloads/bank/"+ye+"/"+month[mn-1]+"-"+ye+"/"+da1+"-"+mn1+"-"+ye+"/"+fname;
		
		File sss=new File(request.getRealPath("")+"/downloads/bank/"+ye+"/"+month[mn-1]+"-"+ye+"/"+da1+"-"+mn1+"-"+ye,fname);
		sss.createNewFile();
		
		File testFile=new File("/usr/local/apache-tomcat-6.0.18/webapps/pred/downloads/bank/"+ye+"/"+month[mn-1]+"-"+ye+"/"+da1+"-"+mn1+"-"+ye,fname);
		testFile.createNewFile();
		

		try {
			Writer output = new BufferedWriter(new FileWriter(sss));
			//output.write(newLine);
			output.write(data);
			output.write(summary);
			output.close();
			//testFile
			Writer output1 = new BufferedWriter(new FileWriter(testFile));
			//output.write(newLine);
			output1.write(data);
			output1.write(summary);
			output1.close();
			 System.out.println("Writing file");
			//sss.setReadOnly();
		}
		catch (IOException ex){
			ex.printStackTrace();
			conn.rollback();
			%>
				<script>
					alert("Failed to Forward - Try Again");
					document.location.href="rws_bill_release_to_bank.jsp";
				</script>
			<%
		}
		conn.setAutoCommit(true);
		conn.commit();
		Statement sttt = conn.createStatement();
		String qryFileInsert = "insert into rws_bill_sett_send_file_tbl values ('"+request.getParameter("txId")+"','"+filePath+"',sysdate)";
		sttt.executeQuery(qryFileInsert);
	%>
		<script>
			alert("Forwarded to Bank Successfully");
			document.location.href="rws_bill_release_to_bank_division.jsp";
		</script>
	<%
	}
	else
	{
		conn.rollback();
	%>
		<script>
			alert("Failed to Forward - Try Again");
			document.location.href="rws_bill_release_to_bank_division.jsp";
		</script>
	<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
	%>
	<script>
			alert("Cannot Save - Duplicate bill details selected (work_id+ Bill No.)");
			document.location.href="rws_bill_release_to_bank_division.jsp";
		</script>
		<%
}
%>