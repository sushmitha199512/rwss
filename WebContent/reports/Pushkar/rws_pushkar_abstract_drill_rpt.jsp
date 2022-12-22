<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html:html>

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
String division=request.getParameter("division");
String ghatType=request.getParameter("ghatType");
String mode=request.getParameter("mode");
String workType=request.getParameter("worktype");
int styleCount=0;
String style="";
 %>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Pushkar Work Wise Abstract Report For Circle:<%=session.getAttribute("circleName").toString() %> and Division:<%=session.getAttribute("divisionName").toString() %></td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>Ghat&nbsp;Type</b></td>
<td class=gridhdbg ><b>Work&nbsp;Type </b></td>
<td class=gridhdbg ><b>Work&nbsp;Id </b></td>
<td class=gridhdbg><b>Est.&nbsp;Cost(Rs. in Lakhs) </b></td>
<td class=gridhdbg><b>Value&nbsp;Of&nbsp;Work&nbsp;Done(Rs. in Lakhs)</b></td>
<td class=gridhdbg><b>Work&nbsp;Completed </b></td>
<td class=gridhdbg><b>Exp.(Rs. in Lakhs) </b></td>

  </tr>


	<%
	Statement statement=null;
	ResultSet resultSet=null;
	
	try{
		String query="";
		if(mode.equals("Number")){
		 query="select nvl(WORK_TYPE,'-'),nvl(work_id,'-'),nvl(ADMIN_AMOUNT,'0'),nvl(VALUE_OF_WORK_DONE,'0'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0')  from RWS_PUSHKAR_WORK_TBL where GHAT_TYPE='"+ghatType+"' and substr(OFFICE_CODE,2,2)='"+circle+"' and substr(OFFICE_CODE,4,1)='"+division+"' and WORK_TYPE='"+workType+"' order by WORK_TYPE";
		}
		else{
			query="select nvl(WORK_TYPE,'-'),nvl(work_id,'-'),nvl(ADMIN_AMOUNT,'0'),nvl(VALUE_OF_WORK_DONE,'0'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0')  from RWS_PUSHKAR_WORK_TBL where GHAT_TYPE='"+ghatType+"' and substr(OFFICE_CODE,2,2)='"+circle+"' and substr(OFFICE_CODE,4,1)='"+division+"' and WORK_TYPE='"+workType+"' and WORK_COMPL_DATE is not null order by WORK_TYPE";
		}
	
		//System.out.println("query---"+query);
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			
		
	
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	

		
		
		
		%>
<tr>

<td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=ghatType %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(resultSet.getDouble(3)/100000) %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(resultSet.getDouble(4)/100000) %></td>
<% if(!resultSet.getString(5).equals("-")){%>
<td class="<%=style %>" style="text-align: left;" align="right">Yes</td>
<%} else{%>
<td class="<%=style %>" style="text-align: left;" align="right">No</td>
<%} %>
<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(resultSet.getDouble(6)/100000) %></td>

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

</html:html>
