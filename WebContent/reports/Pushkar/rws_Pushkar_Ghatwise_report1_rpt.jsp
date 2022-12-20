                              <%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}



</script>






<%

DecimalFormat ndf=new DecimalFormat("####.##");
int count=1;
String circle=request.getParameter("circle");

int styleCount=0;
String style="";

 %>

<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<tr align="right">
			<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; <a href="javascript:onclick=history.go(-1)">Back  </td>
			</tr>


  
		</table>
	</caption>
		<tr  align="center">
				<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Pushkar Abstract Report For Circle:<%=session.getAttribute("circleName").toString() %></td>
		</tr>
		
		</table>
		<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
		<tr align=center>
		
		
		<td class=gridhdbg  rowspan=2>SL&nbsp;NO</td>
		
		<td class=gridhdbg rowspan=2>Division</td>
		<td class=gridhdbg colspan=2>Works sanctioned</td>
		<td class=gridhdbg colspan=4>Works Under Progress</td>
		<td class=gridhdbg colspan=2>Works Completed</td>
		<td class=gridhdbg colspan=2>Works Not Started</td>
		<td class=gridhdbg rowspan=2>Remarks</td>
		</tr>
		<tr>
		<!-- <td class=gridhdbg >No</td>
		<td class=gridhdbg >Amount</td> -->
		<td class=gridhdbg >No</td>
		<td class=gridhdbg >Amount(Rs. in Lakhs)</td>
		
		<td class=gridhdbg >No</td>
		<td class=gridhdbg >Amount(Rs. in Lakhs)</td>
		<td class=gridhdbg >Value of Work Done(Rs. in Lakhs)</td>
		<td class=gridhdbg >Balance Value to be Executed(Rs. in Lakhs)</td>
		<td class=gridhdbg >No</td>
		<td class=gridhdbg >Amount(Rs. in Lakhs)</td>
		<td class=gridhdbg >No</td>
		<td class=gridhdbg >Amount(Rs. in Lakhs)</td>
	




  </tr>

<tr>
<td class=gridhdbg >1</td>
<td class=gridhdbg >2</td>
<td class=gridhdbg >3</td>
<td class=gridhdbg >4</td>
<td class=gridhdbg >5</td>
<td class=gridhdbg >6</td>
<td class=gridhdbg >7</td>
<td class=gridhdbg >8</td>
<td class=gridhdbg >9</td>
<td class=gridhdbg >10</td>
<td class=gridhdbg >11</td>
<td class=gridhdbg >12</td>
<td class=gridhdbg >13</td>

</tr>
	<%
	Statement statement=null,statement1=null;
	ResultSet resultSet=null,resultSet1=null;
	
	try{
		
		String query="",query1="";
		double worksSanctionedAmountTot=0,tendersInvitedAmountTot=0,tendersApprovedAmountTot=0,tendersToBeInvitedAmountTot=0,agreementConcludedAmountTot=0,wupEstimatedAmountTot=0,wupValueofworksofarCompletedTot=0,wupPercentofCompletionTot=0,wupBalanceValuetobeExecutedTot=0,WorksCompletedAmountTot=0,worksNotStartedAmountTot=0;
		int worksSanctionedNoTot=0,tendersInvitedNoTot=0,tendersApprovedNoTot=0,tendersToBeInvitedNOTot=0,agreementConcludedNoTot=0,wupNoTot=0,worksCompletedNoTot=0,worksNotStartedNoTot=0;
		
		query1="select DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE='"+circle+"'";
		statement1=conn.createStatement();
		resultSet1=statement1.executeQuery(query1);
		while(resultSet1.next()){
			String divisioncode="",divisionName="",remarks="";
			double worksSanctionedAmount=0,tendersInvitedAmount=0,tendersApprovedAmount=0,tendersToBeInvitedAmount=0,agreementConcludedAmount=0,wupEstimatedAmount=0,wupValueofworksofarCompleted=0,wupPercentofCompletion=0,wupBalanceValuetobeExecuted=0,WorksCompletedAmount=0,worksNotStartedAmount=0;
			int worksSanctionedNo=0,tendersInvitedNo=0,tendersApprovedNo=0,tendersToBeInvitedNO=0,agreementConcludedNo=0,wupNo=0,worksCompletedNo=0,worksNotStartedNo=0;
			divisionName=resultSet1.getString("DIVISION_OFFICE_NAME");
			divisioncode=resultSet1.getString("DIVISION_OFFICE_CODE");
		 query="select ADMIN_NO,ADMIN_AMOUNT,nvl(TENDER_INVITED,'-'),nvl(TENDER_AMOUNT,'0'),nvl(TENDER_APPROVED,'-'),nvl(TENDER_APPROVED_AMT,'0'),nvl(AGREE_CONCLUDE,'-'),nvl(AGREE_CONCLUDE_AMT,'0'),nvl(PHYSICAL_STAGE,'-'),nvl(VALUE_OF_WORK_DONE,'0'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0'),nvl(REMARKS,'-'),nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-') from RWS_PUSHKAR_WORK_TBL  where substr(OFFICE_CODE,2,2)='"+circle+"' and  substr(OFFICE_CODE,4,1)='"+divisioncode+"'";
		 System.out.println("query--"+query);
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			worksSanctionedNo=worksSanctionedNo+1; 
			worksSanctionedAmount=worksSanctionedAmount+resultSet.getInt(2);
			
			if(!resultSet.getString(14).equals("-") && resultSet.getString(11).equals("-")){
				wupNo=wupNo+1;
				wupEstimatedAmount=wupEstimatedAmount+resultSet.getInt(2);
			wupValueofworksofarCompleted=wupValueofworksofarCompleted+resultSet.getInt(10);
			
			}
			
			wupBalanceValuetobeExecuted=wupEstimatedAmount-wupValueofworksofarCompleted;
			
			
			if(!resultSet.getString(11).equals("-")){
			worksCompletedNo=worksCompletedNo+1;
			WorksCompletedAmount=WorksCompletedAmount+resultSet.getInt(12);
			
			}
			
			if(resultSet.getString(14).equals("-")){
			worksNotStartedNo=worksNotStartedNo+1;
			worksNotStartedAmount=worksNotStartedAmount+resultSet.getInt(2);
			}
			remarks=resultSet.getString(13);
			

			
		}
		statement.close();
		resultSet.close();
		
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			 if(worksSanctionedNo!=0){
%>

<tr><td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=divisionName %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=worksSanctionedNo %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(worksSanctionedAmount/100000) %></td>
 
 <td class="<%=style %>" style="text-align: right;" align="right"><%=wupNo %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(wupEstimatedAmount/100000) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(wupValueofworksofarCompleted/100000) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(wupBalanceValuetobeExecuted/100000) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=worksCompletedNo %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(WorksCompletedAmount/100000) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=worksNotStartedNo %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(worksNotStartedAmount/100000) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=remarks %></td>
 <%-- <td class="<%=style %>" style="text-align: left;" align="right"><%= %></td> --%>
 
 
<%
			 }
worksSanctionedNoTot+=worksSanctionedNo;
worksSanctionedAmountTot+=worksSanctionedAmount;

wupValueofworksofarCompletedTot+=wupValueofworksofarCompleted;

wupNoTot+=wupNo;
wupEstimatedAmountTot+=wupEstimatedAmount;


wupBalanceValuetobeExecutedTot+=wupBalanceValuetobeExecuted;

worksCompletedNoTot+=worksCompletedNo;
WorksCompletedAmountTot+=WorksCompletedAmount;

worksNotStartedNoTot+=worksNotStartedNo;
worksNotStartedAmountTot+=worksNotStartedAmount;
				
				%>



</tr>
<%
		
		}
		statement1.close();
		resultSet1.close();
		%>
				<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=worksSanctionedNoTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(worksSanctionedAmountTot/100000) %></td>
<td class="gridhdbg" style="text-align: right;"><%=wupNoTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(wupEstimatedAmountTot/100000) %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(wupValueofworksofarCompletedTot/100000) %></td>

<td class="gridhdbg" style="text-align: right;"><%=ndf.format(wupBalanceValuetobeExecutedTot/100000) %></td>
<td class="gridhdbg" style="text-align: right;"><%=worksCompletedNoTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(WorksCompletedAmountTot/100000) %></td>
<td class="gridhdbg" style="text-align: right;"><%=worksNotStartedNoTot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(worksNotStartedAmountTot/100000) %></td>
<td class="gridhdbg" style="text-align: right;"></td>
</tr>
		<%
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		try{
			if(conn!=null){
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
%>
	
</table>

