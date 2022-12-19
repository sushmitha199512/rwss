
<%@ include file="/reports/conn.jsp" %>
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
			document.f1.action="./rws_secrep_releases_monthwise_rpt.jsp";
	        document.f1.submit();
		   }
           
          if(document.f1.reptype[1].checked)
          {
            var repvalue='pao';
			document.f1.rv.value = repvalue;
			document.f1.action="./rws_secrep_releases_monthwise_rpt.jsp";
	        document.f1.submit();
	      }

}



</script>

<%
System.out.println("Dat:"+nic.watersoft.commons.RwsUtils.getCurrentDate("dd/MMM/yyyy"));
    String mydate="29/AUG/2012";//wd.getServerDate();
	String  rYear=mydate.substring(9,11);
	String  rMonth=mydate.substring(3,6).toUpperCase();
	
%>
<body onload="fun1();">
<form  name="f1" action="<%= request.getRequestURI()%>" >
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
                <font color="#FFFFFF">Releases As on Date</font>
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
else{
repvalue="bank";
}
if(repvalue.equals("bank"))
{
    try
     { 
      %>
<table align=center>
<tr align=center><td width="5%"  bordercolor="black">NOTE&nbsp;-&nbsp;Divisions are arranged from Maximum Releases to Minimum Releases Amount</td></tr>
</table>
<br><br>
<table width="90%">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="5">Bank Releases Details for Month:<%=rMonth%> and  Year:20<%=rYear%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;***Amount in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>District </b></td>  
<td class=btext ><b>Division </b></td> 
<td class=btext ><b>Total Released Amount </b></td> 
</tr>
       <%int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="";
       stmt1=conn.createStatement();
       stmt2=conn.createStatement();
       String distname1="",distname2="";
       double min_amt=0;
        long tot_amt=0; int rcount=0;
       //qry="Select a.WORK_ID ,b.work_name,substr(a.OFFICE_CODE,2,2),substr(a.OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL ,to_char(BANK_SEND_DATE,'dd/mm/yyyy')  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b  where  a.work_id=b.work_id and SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"' AND bill_amount_central= (Select min(bill_amount_central) from rws_bill_bank_bridge_det_tbl a ,rws_work_admn_tbl b  where  a.work_id=b.work_id and  SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"')";
       //qry="Select substr(OFFICE_CODE,2,2),substr(OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL  from rws_bill_bank_bridge_det_tbl   where   BILL_AMOUNT_CENTRAL="+min_amt+" ";
       qry="SELECT substr(OFFICE_CODE,2,2),substr(OFFICE_CODE,4,1),sum(BILL_AMOUNT_CENTRAL)  FROM rws_bill_bank_bridge_det_tbl where SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"' and txid is not null and bill_activation_flag='P' GROUP BY office_code order by 3 desc";
      // System.out.println("qry***********"+qry);
      // rs1=stmt1.executeQuery(qry);
         
     	//  while(rs1.next())
      // {
		    
            //qry1="select distinct a.dcode,a.dname,b.division_office_code,b.division_office_name from rws_district_tbl a ,rws_division_office_tbl b ,rws_bill_bank_bridge_det_tbl c where a.dcode=substr(c.office_code,2,2) and a.dcode=b.circle_office_code  and b.division_office_code=substr(c.office_code,4,1) and a.dcode='"+rs1.getString(1)+"' and b.division_office_code='"+rs1.getString(2)+"'";
            
             qry1="SELECT sum(nvl(c.BILL_AMOUNT_CENTRAL,'0')) ,a.dname,b.division_office_code,b.division_office_name FROM rws_bill_bank_bridge_det_tbl c,rws_district_tbl a ,rws_division_office_tbl b where SUBSTR(c.bank_SEND_DATE ,4,3) ='"+rMonth+"' AND substr(c.bank_SEND_DATE ,8,2) ='"+rYear+"' and txid is not null and bill_activation_flag='P'  and a.dcode=substr(c.office_code,2,2) and a.dcode=b.circle_office_code  and b.division_office_code=substr(c.office_code,4,1) GROUP BY substr(OFFICE_CODE,2,2),a.dname,b.division_office_code,b.division_office_name order by sum(nvl(c.BILL_AMOUNT_CENTRAL,'0')) desc";
      System.out.println("qry1***********"+qry1);
		       rs2=stmt2.executeQuery(qry1);
               while(rs2.next())
             {
 System.out.println("Running:");
               %>   
		        <tr>  
                <td class=rptValue>&nbsp; <%=count++%> </td>
                <td class=rptValue ><%=rs2.getString(3)%>   </td>  
				<td class=rptValue><%=rs2.getString(5)%>   </td>  
				<td class=rptValue align=right><%=rs2.getString(2)%> </td>    
				</tr>
		<%
 tot_amt+=Double.parseDouble(rs2.getString(2));
              }
             
            
          // }
             
      
%>
<tr><td class=btext colspan=3 align=right>Total</td><td class=btext align=right><%=tot_amt %></td></tr>
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
<tr align=center><td width="5%"  bordercolor="black">NOTE&nbsp;-&nbsp;Divisions are arranged from Maximum Releases to Minimum Releases Amount</td></tr>
</table>
<br><br>
<table width="90%">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="5">PAO Releases Details for Month:<%=rMonth%> and  Year:20<%=rYear%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;***Amount in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>District </b></td>  
<td class=btext ><b>Division </b></td> 
<td class=btext ><b>Total Released Amount </b></td> 
</tr>
       <%int count=1;
       Statement stmt4=null,stmt5=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="";
       stmt4=conn.createStatement();
       stmt5=conn.createStatement();
       String distname1="",distname2="";
       double min_amt=0;
        long tot_amt=0; int rcount=0;
       //qry="Select a.WORK_ID ,b.work_name,substr(a.OFFICE_CODE,2,2),substr(a.OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL ,to_char(BANK_SEND_DATE,'dd/mm/yyyy')  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b  where  a.work_id=b.work_id and SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"' AND bill_amount_central= (Select min(bill_amount_central) from rws_bill_bank_bridge_det_tbl a ,rws_work_admn_tbl b  where  a.work_id=b.work_id and  SUBSTR(bank_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(bank_SEND_DATE ,8,2) ='"+rYear+"')";
       //qry="Select substr(OFFICE_CODE,2,2),substr(OFFICE_CODE,4,1), BILL_AMOUNT_CENTRAL  from rws_bill_bank_bridge_det_tbl   where   BILL_AMOUNT_CENTRAL="+min_amt+" ";
       qry="SELECT substr(OFFICE_CODE,2,2),substr(OFFICE_CODE,4,1),sum(BILL_AMOUT_state) AS total_amt  FROM rws_bill_pao_bridge_det_tbl where SUBSTR(state_SEND_DATE ,4,3) IN ('"+rMonth+"') AND substr(state_SEND_DATE ,8,2) ='"+rYear+"' and STATE_TXID is not null and BILL_ACTIVATION_FLAG='P'  GROUP BY office_code order by 3 desc";
       //System.out.println("qry***********"+qry);
       rs1=stmt4.executeQuery(qry);
          
     	  while(rs1.next())
       {
		    
            qry1="select distinct a.dcode,a.dname,b.division_office_code,b.division_office_name from rws_district_tbl a ,rws_division_office_tbl b ,rws_bill_pao_bridge_det_tbl c where a.dcode=substr(c.office_code,2,2) and a.dcode=b.circle_office_code  and b.division_office_code=substr(c.office_code,4,1) and a.dcode='"+rs1.getString(1)+"' and b.division_office_code='"+rs1.getString(2)+"'";
            //System.out.println("qry1***********"+qry1);
		       rs2=stmt5.executeQuery(qry1);
               while(rs2.next())
             {
               %>   
		        <tr>  
                <td class=rptValue>&nbsp; <%=count++%> </td>
                <td class=rptValue ><%=rs2.getString(2)%>   </td>  
				<td class=rptValue><%=rs2.getString(4)%>   </td>  
				<td class=rptValue align=right><%=rs1.getString(3)%> </td>    
				</tr>
		<% 
              
              }
                   tot_amt+=Double.parseDouble(rs1.getString(3));
           }
             
      
%>
<tr><td class=btext colspan=3 align=right>Total</td><td class=btext align=right><%=tot_amt %></td></tr>
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
        System.out.println("Else Block:");
}
%>
<INPUT type="hidden" name="rv">
</form>
</body>


