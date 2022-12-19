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

function viewWorks(URL)
{
	
var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
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
				<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Pushkar Work Wise Progress Report For Circle:<%=session.getAttribute("circleName").toString() %> and Division:<%=session.getAttribute("divisionName").toString() %> </td>
		</tr>
		
		</table>
		<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
		<tr align=center>
		
		
		<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
		
		<td class=gridhdbg >Mandal</td>
		<td class=gridhdbg><b>Ghat&nbsp;Type(A/B/C)</b></td>
		<td class=gridhdbg >Program</td>
		<td class=gridhdbg >Sub-Program</td>
		<td class=gridhdbg >Work&nbsp;Type (DW/Sanitation/Dress Change Room/Fountain bath)</td>
		<td class=gridhdbg>Name Of Work</td>
		<td class=gridhdbg><b>Est. Cost (Rs.)</b></td>
		<td class=gridhdbg><b>Admn. Sanction No.</b></td>
		<td class=gridhdbg >Admn. Sanction Date</td>
		<td class=gridhdbg >Date Of Grounding</td>
		<td class=gridhdbg >Physical Stage</td>
		<td class=gridhdbg >% Of Completion</td>
		<td class=gridhdbg >Probable Date Of Completion</td>
		<td class=gridhdbg >Value Of Work Done (Rs.)</td>
		<td class=gridhdbg >Exp.</td>
		<td class=gridhdbg >Date Of Completion If Completed</td>
		<td class=gridhdbg >Image </td>






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
<td class=gridhdbg >16</td>
<td class=gridhdbg >17</td>
<td class=gridhdbg >18</td>
</tr>

	<%
	Statement statement=null;
	ResultSet resultSet=null;
	double estCost=0,valueOfWorkDone=0,exp=0,estCostTot=0,valueOfWorkDoneTot=0,expTot=0;
	double percentageOfCompletion=0;
	String workid="",habCode="",mandal="",ghatType="",programme="",subProgramme="",workType="",nameOfWork="",adminSanctionNo="",adminSanctionDate="",dateOfGrounding="",physicalStage="",probableDateOfCompletion="",dateOfCompletion="";
	
	try{
		String query="";
		
		 query="select MNAME,PROGRAMME_NAME,SUBPROGRAMME_NAME,a.PROGRAMME_CODE,a.SUBPROGRAMME_CODE,HABITATION_CODE,GHAT_TYPE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy'),ADMIN_AMOUNT,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-'),nvl(PHYSICAL_STAGE,'-'),nvl(VALUE_OF_WORK_DONE,'0'),nvl(to_char(PROBABLE_DATE_OF_COMP,'dd/mm/yyyy'),'-'),nvl(to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),'-'),nvl(EXP_ON_WORK,'0'),WORK_IMG from RWS_PUSHKAR_WORK_TBL a,rws_mandal_tbl b,RWS_PROGRAMME_TBL c,RWS_SUBPROGRAMME_TBL d where c.PROGRAMME_CODE=d.PROGRAMME_CODE and c.PROGRAMME_CODE=a.PROGRAMME_CODE and d.SUBPROGRAMME_CODE=a.SUBPROGRAMME_CODE and substr(a.HABITATION_CODE,6,2)=b.mcode and b.dcode='"+circle+"' and substr(OFFICE_CODE,2,2)='"+circle+"' and substr(OFFICE_CODE,4,1)='"+division+"'";
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		while(resultSet.next()){
			workid=resultSet.getString(9);
			ghatType=resultSet.getString(7);
			mandal=resultSet.getString(1);
			programme=resultSet.getString(2);
			subProgramme=resultSet.getString(3);
			workType=resultSet.getString(10);
			nameOfWork=resultSet.getString(8);
			adminSanctionNo=resultSet.getString(11);
			 adminSanctionDate=resultSet.getString(12); 
			dateOfGrounding=resultSet.getString(14);
			physicalStage=resultSet.getString(15);
			probableDateOfCompletion=resultSet.getString(17);
			dateOfCompletion=resultSet.getString(18);
			habCode=resultSet.getString(6);
			estCost=resultSet.getInt(13);
			
			valueOfWorkDone=resultSet.getInt(16);
			percentageOfCompletion=(valueOfWorkDone/estCost)*100;
			exp=resultSet.getInt(19);
			java.sql.Blob a = resultSet.getBlob("WORK_IMG");
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
	
	
%>

<tr>
<td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=mandal %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=ghatType %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=programme %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=subProgramme %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=workType%></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=nameOfWork %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=adminSanctionNo %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=adminSanctionDate %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=dateOfGrounding %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=physicalStage %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=percentageOfCompletion%></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=probableDateOfCompletion %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(valueOfWorkDone) %></td>
 <td class="<%=style %>" style="text-align: right;" align="right"><%=ndf.format(exp) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=dateOfCompletion %></td>
<%

if(a==null){
%>
<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>

 <%
  }
else{
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_Pushkar_Work_Image.jsp?workId=<%=workid%>')">View</a></td>
<%} %>

</tr>
<%
estCostTot+=estCost;
valueOfWorkDoneTot+=valueOfWorkDone;
expTot+=exp;
		}
		statement.close();
		resultSet.close();
		
		%>
 		<tr>
<td class="gridhdbg" style="text-align: right;" colspan=7 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(estCostTot) %></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(valueOfWorkDoneTot) %></td>
<td class="gridhdbg" style="text-align: right;"><%=ndf.format(expTot) %></td>
<td class="gridhdbg" style="text-align: right;"></td>
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

