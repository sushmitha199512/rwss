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
				<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Pushkar Ghat Wise Report 2 For Circle:<%=session.getAttribute("circleName").toString() %></td>
		</tr>
		
		</table>
		<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
		
		
		<td class=gridhdbg  rowspan=2>SL&nbsp;NO</td>
		<td class=gridhdbg rowspan=2>Mandal</td>
		<td class=gridhdbg rowspan=2>Panchayat</td>
		
		<td class=gridhdbg rowspan=2>Name of the work</td>
		<td class=gridhdbg colspan=3>As per revised sanction by The CDM</td>
		<td class=gridhdbg rowspan=2>Tender Invited or not</td>
		<td class=gridhdbg rowspan=2>Tender approved or not</td>
		<td class=gridhdbg rowspan=2>Agreement concluded or not</td>
		<td class=gridhdbg rowspan=2>Work grounded or not</td>
		<td class=gridhdbg colspan=3>If grounded</td>
		<td class=gridhdbg rowspan=2>Remarks</td>
		</tr>
		<tr>
		<td class=gridhdbg >No. of Ghats</td>
		<td class=gridhdbg >Category</td>
		<td class=gridhdbg >Amount Sanctioned(Rs. in Lakhs)</td>
		<td class=gridhdbg >Value of work so far Completed(Rs. in Lakhs)</td>
		<td class=gridhdbg >Percent (%) of Completion</td>
		<td class=gridhdbg >Balance Value to be Executed(Rs. in Lakhs)</td>
		
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
<td class=gridhdbg >14</td>
<td class=gridhdbg >15</td>

</tr>
	<%
	Statement statement=null;
	ResultSet resultSet=null;
	String newvname="",newmname="",noofghats="";
	String mname="",vname="",workName="",ghatType="",pushkarCode="",tenderInvited="",tenderApproved="",agreementConcluded="",workGrounded="",remarks="";   
			int noOfGhats=0,nofghatstot=0;
	double cdmAmountSanctioned=0,valueofworksofarCompleted=0,percentofCompletion=0,balanceValue=0; 
	double cdmAmountSanctionedTot=0,valueofworksofarCompletedTot=0,balanceValueTot=0;
	try{
		String query="";
		
		 query="select DNAME,MNAME,VNAME,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,nvl(decode(TENDER_INVITED,'Y','Yes','N','No'),'-'),nvl(TENDER_AMOUNT,'0'),nvl(decode(TENDER_APPROVED,'Y','Yes','N','No'),'-'),nvl(TENDER_APPROVED_AMT,'0'),nvl(decode(AGREE_CONCLUDE,'Y','Yes','N','No'),'-'),nvl(AGREE_CONCLUDE_AMT,'0'),nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-'),nvl(PHYSICAL_STAGE,'-'),nvl(VALUE_OF_WORK_DONE,0),nvl(PERCENTAGE_WORK_DONE,'0'),nvl(to_char(PROBABLE_DATE_OF_COMP,'dd/mm/yyyy'),'-'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0'),nvl(REMARKS,'-'),count(GHAT_TYPE) from RWS_PUSHKAR_WORK_TBL a ,rws_complete_hab_view  b where substr(a.OFFICE_CODE,2,2)='"+circle+"' and substr(a.HABITATION_CODE,1,2)='"+circle+"' and substr(a.HABITATION_CODE,1,2)=b.dcode and a.HABITATION_CODE=b.panch_code group by DNAME,MNAME,VNAME,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,nvl(decode(TENDER_INVITED,'Y','Yes','N','No'),'-'),nvl(TENDER_AMOUNT,'0'),nvl(decode(TENDER_APPROVED,'Y','Yes','N','No'),'-'),nvl(TENDER_APPROVED_AMT,'0'),nvl(decode(AGREE_CONCLUDE,'Y','Yes','N','No'),'-'),nvl(AGREE_CONCLUDE_AMT,'0'),nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-'),nvl(PHYSICAL_STAGE,'-'),nvl(VALUE_OF_WORK_DONE,0),nvl(to_char(VALUE_OF_WORK_DONE_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(PROBABLE_DATE_OF_COMP,'dd/mm/yyyy'),'-'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0'),nvl(REMARKS,'-') order by mname,vname";
		
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			
			mname=resultSet.getString(2);
			vname=resultSet.getString(3);
			workName=resultSet.getString(7);
			ghatType=resultSet.getString(5);
			pushkarCode=resultSet.getString(6);
			tenderInvited=resultSet.getString(13);
			tenderApproved=resultSet.getString(15);
			agreementConcluded=resultSet.getString(17);
			noOfGhats=resultSet.getInt(27);
			if(!resultSet.getString(19).equals("") && resultSet.getString(19)!=null){
			workGrounded="Yes";
			}
			remarks=resultSet.getString(26);
			cdmAmountSanctioned=resultSet.getInt(12);
			valueofworksofarCompleted=resultSet.getInt(21);
			percentofCompletion=(valueofworksofarCompleted/cdmAmountSanctioned)*100;
			balanceValue=cdmAmountSanctioned-valueofworksofarCompleted;
			
			cdmAmountSanctionedTot=cdmAmountSanctionedTot+cdmAmountSanctioned;
			valueofworksofarCompletedTot=valueofworksofarCompletedTot+valueofworksofarCompleted;
			nofghatstot+=noOfGhats;
			
			balanceValueTot=balanceValueTot+balanceValue;
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	
%>

<tr>
<td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>

<td class="<%=style %>" style="text-align: left;" align="right"><%=mname%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=vname%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=workName%></td>

<td class="<%=style %>" style="text-align: right;" align="right"><%=noOfGhats%></td>



<td class="<%=style %>" style="text-align: left;" align="right"><%=ghatType%>-<%=pushkarCode%></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(cdmAmountSanctioned/100000) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=tenderInvited %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=tenderApproved %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=agreementConcluded %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=workGrounded %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(valueofworksofarCompleted/100000) %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(percentofCompletion) %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(balanceValue/100000) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks %></td>


<%
				
				
				%>



</tr>
<%
newvname=resultSet.getString(3);
newmname=resultSet.getString(2);
		}
		
		 
		statement.close();
		resultSet.close();
		%>
		<tr>
<td class="gridhdbg" style="text-align: right;" colspan=4 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=nofghatstot%></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(cdmAmountSanctionedTot/100000)  %></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(valueofworksofarCompletedTot/100000)  %></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(balanceValueTot/100000)  %></td>
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

