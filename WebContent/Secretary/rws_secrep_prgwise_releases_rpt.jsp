<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<script type="text/javascript">
function fun1()
{
 var repsel='<%=request.getParameter("rv")%>';
     // alert("repsel"+repsel);
 	 if(repsel=="bank")
	 {
      document.f1.reptype[0].checked=true;
	 }
	 else if(repsel=="pao")
	 {
	   document.f1.reptype[1].checked=true;
	 }
     else
	 {
      document.f1.reptype[0].checked=true;
	 }

}

function fnSubmit()
{
        if(document.f1.reptype[0].checked)
          {
            var repvalue='bank';
			// alert("repvalue"+repvalue);	
            document.f1.rv.value = repvalue;
			document.f1.action="./rws_secrep_prgwise_releases_rpt.jsp";
	        document.f1.submit();
		   }
           
          if(document.f1.reptype[1].checked)
          {
            var repvalue='pao';
			document.f1.rv.value = repvalue;
			document.f1.action="./rws_secrep_prgwise_releases_rpt.jsp";
	        document.f1.submit();
	      }

}



</script>

<%
     WorksData1 wd = new WorksData1();
     String mydate="29/08/2012";//wd.getServerDate();
     //System.out.println("..........."+mydate);
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");   
     SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
     try{
       //parse the string into Date object
       java.util.Date date = sdfSource.parse(mydate);
       //System.out.println("date : " + date);
       //parse the date into another format
       mydate = sdfDestination.format(date);    
      // System.out.println("Converted date is : " + mydate);
	   } 
       catch(ParseException pe)
	   { 
	     System.out.println("Parse Exception : " + pe);
	   }
    
	String  rYear=mydate.substring(9,11);
	String  rMonth=mydate.substring(3,6).toUpperCase();
    //System.out.println("..........."+rYear+rMonth);
	
%>
<body onload="fun1();">
<form  name=f1 action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=70% align = "right" bgcolor="#edf2f8">
		   <tr>
				<td align="right" class="bwborder"><a href="#" onclick="window.close();">Close&nbsp;<a href="javascript:onclick=history.go(-1)">Back</td>  
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="3">
				<!--<font color="#FFFFFF">Borewell Status Graph</font>-->
                <font color="#FFFFFF">Programme Wise Releases As on Date</font>
			</td>	
		</tr>


<tr bgcolor="#8A9FCD" align="center"><td align="center" colspan=2 class=btext><input type="radio" name="reptype" id="bank" value="bank" onclick="fnSubmit();"/>Bank &nbsp;&nbsp;&nbsp;<input type="radio" name="reptype" id="pao" value="pao" onclick="fnSubmit();"/>PAO</td></tr>

</table>

<br><br>
<%
String repvalue="";

if(request.getParameter("rv")!=null)
{
repvalue=request.getParameter("rv");
//System.out.println("repvalue"+repvalue);
}
else
repvalue="bank";
if(repvalue.equals("bank"))
{
    try
     { 
      %>
<table align=center>
<tr align=center><td width="5%"  bordercolor="black">NOTE&nbsp;-&nbsp;Programmes are arranged from Maximum Releases to Minimum Releases Amount</td></tr>
</table>
<br><br>
<table width="70%">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="3">Programme Wise Bank Releases Details for Month:<%=rMonth%> and  Year:20<%=rYear%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;***Amount in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>Programme Name </b></td>  
<td class=btext ><b>Total Released Amount </b></td> 
</tr>
       <%int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="";
       stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
       stmt2=conn.createStatement();
       String distname1="",distname2="";
       double min_amt=0;
        long tot_amt=0; int rcount=0;
       qry="SELECT substr(work_id,1,2),b.programme_name,sum(BILL_AMOUNT_CENTRAL) AS total_amt  FROM rws_bill_bank_bridge_det_tbl a,rws_programme_tbl b where substr(work_id,1,2)=b.programme_code and SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"' and TXID is not null and BILL_ACTIVATION_FLAG='P' GROUP BY substr(work_id,1,2),b.programme_name order by 3 desc";
       System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
            while(rs1.next())
             {      %>   
		        <tr>  
                <td class=rptValue>&nbsp; <%=count++%> </td>
                <td class=rptValue ><%=rs1.getString(2)%>   </td>  
				<td class=rptValue><%=rs1.getString(3)%>   </td>  
				</tr>
		   <%
              
             
             tot_amt+=Double.parseDouble(rs1.getString(3));
            }
      
%>
<tr><td class=btext colspan=2 align=right>Total</td><td class=btext align=right><%=tot_amt %></td></tr>
</table>
<%
   }
   catch(Exception e)
     {
     e.printStackTrace();
     } 

%>
<%}
else if(repvalue.equals("pao"))
{
    try
     { 
      %>
<table align=center>
<tr align=center><td width="5%"  bordercolor="black">NOTE&nbsp;-&nbsp;Programmes are arranged from Maximum Releases to Minimum Releases Amount</td></tr>
</table>
<br><br>
<table width="70%">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="3">Programme Wise PAO Releases Details for Month:<%=rMonth%> and  Year:20<%=rYear%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;***Amount in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>Programme Name </b></td>  
<td class=btext ><b>Total Released Amount </b></td> 
</tr>
       <%int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="";
       stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
       stmt2=conn.createStatement();
       String distname1="",distname2="";
       double min_amt=0;
        long tot_amt=0; int rcount=0;
       //qry="Select a.WORK_ID ,b.work_name,substr(a.OFFICE_CODE,2,2),substr(a.OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL ,to_char(BANK_SEND_DATE,'dd/mm/yyyy')  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b  where  a.work_id=b.work_id and SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"' AND bill_amount_central= (Select min(bill_amount_central) from rws_bill_bank_bridge_det_tbl a ,rws_work_admn_tbl b  where  a.work_id=b.work_id and  SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"')";
       //qry="Select substr(OFFICE_CODE,2,2),substr(OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL  from rws_bill_bank_bridge_det_tbl   where   BILL_AMOUNT_CENTRAL="+min_amt+" ";
       qry="SELECT substr(work_id,1,2),b.programme_name,sum(BILL_AMOUT_state) AS total_amt  FROM rws_bill_pao_bridge_det_tbl a,rws_programme_tbl b where substr(work_id,1,2)=b.programme_code and SUBSTR(state_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(state_SEND_DATE ,8,2) ='"+rYear+"' and state_txID is not null and BILL_ACTIVATION_FLAG='P' GROUP BY substr(work_id,1,2),b.programme_name order by 3 desc";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
          
     	  while(rs1.next())
          {
         %>   
		        <tr>  
                <td class=rptValue>&nbsp; <%=count++%> </td>
                <td class=rptValue ><%=rs1.getString(2)%>   </td>  
				<td class=rptValue><%=rs1.getString(3)%>   </td>  
				</tr>
		<% 
              
             
                   tot_amt+=Double.parseDouble(rs1.getString(3));
           
      }
%>
<tr><td class=btext colspan=2 align=right>Total</td><td class=btext align=right><%=tot_amt %></td></tr>
</table>
<%
   }
   catch(Exception e)
     {
     e.printStackTrace();
     } 

%>
<%}
else
{
}
%>
<INPUT type="hidden" name="yr">
<INPUT type="hidden" name="mn">
<INPUT type="hidden" name="rv">
</form>
</body>


