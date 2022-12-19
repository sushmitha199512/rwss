<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>








<%


int count=1;
String dname=(String)session.getAttribute("dname");
String dcode=(String)session.getAttribute("dcode");
String fromDate=(String)session.getAttribute("fromDate");
String toDate=(String)session.getAttribute("toDate");
String natureOfProblem=(String)session.getAttribute("NatureOfProblem");
String yn="";

 %>

<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			

<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=dname %>(<%=natureOfProblem %>)<br>&nbsp;&nbsp;From Date:<%=fromDate %>&nbsp;&nbsp;To Date:<%=toDate %> </td>
</tr>

<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>

<td class=gridhdbg ><b>Complaint No </b></td>
<td class=gridhdbg ><b>Complaint Date </b></td>
<td class=gridhdbg><b>Complaint Discription </b></td>
<td class=gridhdbg >Grievance Related To</td>
   <td class=gridhdbg >Grievance Category</td>
   <td class=gridhdbg >Grievance Entry Category</td>
<td class=gridhdbg><b>Name/<br> Address/<br> PhoneNo /</b> Email</td>

<td class=gridhdbg><b>Attended By </b></td>
<td class=gridhdbg><b>Attended Date</b></td>
<td class=gridhdbg><b>Action Taken</b></td>
<td class=gridhdbg><b>Action&nbsp;Description </b></td>
<td class=gridhdbg><b>Message Sent</b></td>





  </tr>


	<%
	Statement statement=null;
	ResultSet resultSet=null;
	try{
		String query="";
		if(natureOfProblem.equals("ALL")){
			 query="select COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),COMPLAINT_DESC,NAME,ADDRESS,PHONE_NO,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),ACTION_TAKEN,ACTION_DESC,MESSAGE_SENT,nvl(GRIEVANCE_RELATED_TO,'-'),nvl(GRIEVANCE_CATEGORY,'-'),nvl(GRIEVANCE_ENTRY_CATEGORY,'-'),nvl(EMAILID,'-') from rws_generic_complaints_reg_tbl where NATURE_PROBLEM in('DWP[HPs/ BW SourcesDried/LowYield]','DWP[Transportation-Increase of Tankers]','DWP[CPWSS-Maintenance Problem]','DWP[SVS-Maintenance Problem-GP]','DWP[PIPELine damaged/Leakages]','DWP[Motor Repairs-GP]','DWP[Water Quality Problem]','DWP[Power problem]','New Praposal','HP Repairs','Illegal Connections','SS Tanks Filling','Others') and substr(HABITATION_CODE,1,2)='"+dcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy')  and  to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";	
		}
		else{
		 query="select COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),COMPLAINT_DESC,NAME,ADDRESS,PHONE_NO,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),ACTION_TAKEN,ACTION_DESC,MESSAGE_SENT,nvl(GRIEVANCE_RELATED_TO,'-'),nvl(GRIEVANCE_CATEGORY,'-'),nvl(GRIEVANCE_ENTRY_CATEGORY,'-'),nvl(EMAILID,'-') from rws_generic_complaints_reg_tbl where NATURE_PROBLEM='"+natureOfProblem+"' and substr(HABITATION_CODE,1,2)='"+dcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy')  and  to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE is NOT NULL";
		}
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			
		

	int styleCount=0;
	String style="";
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(12) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(13) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(14) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(4) %>/<br><%=resultSet.getString(5) %>/<br><%=resultSet.getString(6) %>/<br><%=resultSet.getString(15) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(7) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(10) %></td>
<%
				if(resultSet.getString(11)==null){
					yn="";
				}
				else if(resultSet.getString(11).equals("Y")){
					yn="Yes";
				}
				else if(resultSet.getString(11).equals("N")){
					yn="No";
				}
				
				%>
<td class="<%=style %>" style="text-align: left;" align="right"><%=yn%></td>




</tr>
<%
		}
		statement.close();
		resultSet.close();
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

