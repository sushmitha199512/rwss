<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 


<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

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


</head>



<%

DecimalFormat ndf=new DecimalFormat("####.##");
int count=1;
String circle=request.getParameter("circle");
String division=request.getParameter("division");
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
				<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Pushkar Work Wise Abstract Report For Circle:<%=session.getAttribute("circleName").toString() %> and Division:<%=session.getAttribute("divisionName").toString() %> </td>
		</tr>
		
		</table>
		<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
		<tr align=center>
		
		
		<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
		
		<!-- <td class=gridhdbg ><b>District </b></td>
		<td class=gridhdbg ><b>Division</b></td> -->
		<td class=gridhdbg><b>Ghat Type</b></td>
		<td class=gridhdbg >Work Type</td>
		<td class=gridhdbg >No. of works</td>
		 <td class=gridhdbg >Est. Cost(Rs. in Lakhs)</td>
		<td class=gridhdbg>Value of work done(Rs. in Lakhs)</td>
		
		<td class=gridhdbg><b>Exp.(Rs. in Lakhs)</b></td>
		<td class=gridhdbg><b>Works Completed</b></td>





  </tr>

		<!-- <tr>
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


</tr> -->
	<%
	Statement statement=null;
	ResultSet resultSet=null;
	String ghatType="";
	int noOfWorksATot=0,noOfWorksAcompTot=0;
	double expATot=0,estmatedATot=0,valueOfworkATot=0;
	
	try{
		String query="";
		String[] arr = { "A", "B", "C" };
		String oldGhattype="";
		
		for(int i=0;i<arr.length;i++){
			String workType="";
			int noOfWorksA=0,noOfWorksAcomp=0;
			double expA=0,estmatedA=0,valueOfworkA=0;
			ghatType=arr[i];
			String[] arr1 = { "DW", "Sanitation", "Fountain Bath","Dress Change Room"};
			
			for(int j=0;j<arr1.length;j++){
				workType=arr1[j];
		 query="select nvl(EXP_ON_WORK,'0'),nvl(work_id,'0'),nvl(ADMIN_AMOUNT,'0'),nvl(VALUE_OF_WORK_DONE,'0'),WORK_TYPE,WORK_COMPL_DATE   from RWS_PUSHKAR_WORK_TBL where GHAT_TYPE='"+ghatType+"' and substr(OFFICE_CODE,2,2)='"+circle+"' and substr(OFFICE_CODE,4,1)='"+division+"' and WORK_TYPE='"+workType+"' order by WORK_TYPE";
		// System.out.println("query---"+query);
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			noOfWorksA++;
			expA+=resultSet.getInt(1);
			estmatedA+=resultSet.getInt(3);
			valueOfworkA+=resultSet.getInt(4);
			//workType=workType+resultSet.getString(5)+",";
			if(resultSet.getString(6)!=null && !resultSet.getString(6).equals("")){
				noOfWorksAcomp++;
			}
	
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	

		
		}
		statement.close();
		resultSet.close();
		
		if(noOfWorksA>0){
			noOfWorksATot=noOfWorksATot+noOfWorksA;
			expATot=expATot+expA;
			estmatedATot=estmatedATot+estmatedA;
			valueOfworkATot=valueOfworkATot+valueOfworkA;
			noOfWorksAcompTot=noOfWorksAcompTot+noOfWorksAcomp;
		%>

		<tr>

		 <%
		 System.out.println(oldGhattype+"@@@@"+ghatType);
		 if(!oldGhattype.equals(ghatType)){ %>
			 <td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>
			  <td class="<%=style %>" style="text-align: left;" align="right"><%=ghatType%></td>
			  <%} 
			  else{%>
			   <td class="<%=style %>" style="text-align: right;" align="right"></td>
			  <td class="<%=style %>" style="text-align: left;" align="right"></td>
			  <%} %>
			  <td class="<%=style %>" style="text-align: left;" align="right"><%=workType%></td>
		<td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_pushkar_abstract_drill_rpt.jsp?mode=Number&ghatType=<%=ghatType%>&circle=<%=circle%>&division=<%=division%>&worktype=<%=workType%>')"><%=noOfWorksA%></a></td>
		
		
		<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(estmatedA/100000)%></td>
		<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(valueOfworkA/100000)%></td>
		<td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(expA/100000) %></td>
		<td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_pushkar_abstract_drill_rpt.jsp?mode=Wcomp&ghatType=<%=ghatType%>&circle=<%=circle%>&division=<%=division%>&worktype=<%=workType%>')"><%=noOfWorksAcomp%></a></td>


		</tr>
		<%
		oldGhattype=ghatType;
		}
		noOfWorksA=0;
		expA=0;
		estmatedA=0;
		valueOfworkA=0;
		
			noOfWorksAcomp=0;
			
		}
			
	}
		%>
		 		<tr>
<td class="gridhdbg" style="text-align: right;" colspan=3 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=noOfWorksATot %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(expATot/100000)  %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(estmatedATot/100000)  %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(valueOfworkATot/100000)  %></td>
<td class="gridhdbg" style="text-align: right;"><%=noOfWorksAcompTot  %></td>

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

