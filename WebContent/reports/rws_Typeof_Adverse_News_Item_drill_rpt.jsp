<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
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





<%


int count=1;
String dname=request.getParameter("dname");
String dcode=request.getParameter("dcode");
String fromDate=request.getParameter("fromDate");
String toDate=request.getParameter("toDate");
String actionTaken=request.getParameter("actionTaken");
//System.out.println("fromDate"+fromDate);
//System.out.println("toDate"+toDate);
String yn="";
session.setAttribute("dname",dname);
session.setAttribute("dcode",dcode);
session.setAttribute("fromDate",fromDate);
session.setAttribute("toDate",toDate);
session.setAttribute("actionTaken",actionTaken);
 %>

<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

<!-- &nbsp; | &nbsp;<a href="./rws_Action_Taken_drill_rpt_xls.jsp" >Excel</a> -->


  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=dname %>(<%=actionTaken %>)<br>&nbsp;&nbsp;From Date:<%=fromDate %>&nbsp;&nbsp;To Date:<%=toDate %> </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg >SL&nbsp;NO</td>

<td class=gridhdbg >Clip Level</td>
<td class=gridhdbg >Mandal<br/>/Panchayat<br/>/Village<br/>/Habitation</td>
<td class=gridhdbg >Paper Name</td>
<td class=gridhdbg >Paper Date</td>
<td class=gridhdbg >Edition</td>
<td class=gridhdbg >Paper News</td>
<td class=gridhdbg >Action Taken</td>
<td class=gridhdbg >Remarks</td>
<td class=gridhdbg >Paper clipping Scanned Copy</td>
<td class=gridhdbg >ATR Scanned Copy </td>
  </tr>


	<%
	Statement statement=null,statement1=null;
	ResultSet resultSet=null,resultSet1=null;
	String mcode="",pcode="",vcode="",habCode="",districtCode="";
	try{
		String query="";
		if(actionTaken.equals("ALL")){
			query="select to_char(PAPER_DATE,'dd/mm/yyyy'),PAPER_NAME,EDITION,PAPER_NEWS,ACTION_TAKEN,nvl(REMARKS,'-'),CLIP_LEVEL,DCODE,nvl(MCODE,'-'),nvl(PCODE,'-'),nvl(VCODE,'-'),nvl(HAB_CODE,'-'),CLIP_IMAGE,NEWS_ID,ATR_IMAGE  from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM in('Water Availability','Water Quality Related','Both WS AND WC','Maintenance Problem','Others') and DCODE='"+dcode+"' and PAPER_DATE between to_date('"+fromDate+"','dd/mm/yyyy')  and  to_date('"+toDate+"','dd/mm/yyyy')";
		}
		else{
		 
		 query="select to_char(PAPER_DATE,'dd/mm/yyyy'),PAPER_NAME,EDITION,PAPER_NEWS,ACTION_TAKEN,nvl(REMARKS,'-'),CLIP_LEVEL,DCODE,nvl(MCODE,'-'),nvl(PCODE,'-'),nvl(VCODE,'-'),nvl(HAB_CODE,'-'),CLIP_IMAGE,NEWS_ID,ATR_IMAGE  from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='"+actionTaken+"' and DCODE='"+dcode+"' and PAPER_DATE between to_date('"+fromDate+"','dd/mm/yyyy')  and  to_date('"+toDate+"','dd/mm/yyyy')";
		}
		
		statement=conn.createStatement();
		resultSet=statement.executeQuery(query);
		//System.out.println("Query:"+query);
		
		while(resultSet.next()){
			districtCode=resultSet.getString(8);
			 mcode=resultSet.getString(9);
			 pcode=resultSet.getString(10);
			 vcode=resultSet.getString(11);
			 habCode=resultSet.getString(12);
			 String pname=resultSet.getString(2);
			 String pdate=resultSet.getString(1);
			 String edition=resultSet.getString(3);
			 String pnews=resultSet.getString(4);
			 String at=resultSet.getString(5);
			 String remarks=resultSet.getString(6);
			 java.sql.Blob clipImage = resultSet.getBlob(13);
			 java.sql.Blob atrImage = resultSet.getBlob(15);
			 String newsId=resultSet.getString(14);
			 String clip_Level=resultSet.getString(7);
			
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
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(7) %></td>
<%
String getDataQuery="";
if(clip_Level.equals("Mandal")){
	getDataQuery="select mname from rws_complete_hab_view where dcode='"+districtCode+"' and mcode='"+mcode+"'";
	statement1=conn.createStatement();
	resultSet1=statement1.executeQuery(getDataQuery);
	if(resultSet1.next()){
	%>
	<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet1.getString(1) %></td>
	<%
	}
	statement1.close();
	resultSet1.close();
}
else if(clip_Level.equals("Panchayat")){
	getDataQuery="select mname,pname from rws_complete_hab_view where dcode='"+districtCode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
	statement1=conn.createStatement();
	resultSet1=statement1.executeQuery(getDataQuery);
	if(resultSet1.next()){
	%>
	<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet1.getString(1) %><br/>/<%=resultSet1.getString(2) %></td>
	<%
	}
	statement1.close();
	resultSet1.close();
}
else if(clip_Level.equals("Village")){
	getDataQuery="select mname,pname,vname from rws_complete_hab_view where dcode='"+districtCode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and vcode='"+vcode+"'";
	statement1=conn.createStatement();
	resultSet1=statement1.executeQuery(getDataQuery);
	if(resultSet1.next()){
	%>
	<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet1.getString(1) %><br/>/<%=resultSet1.getString(2) %><br/>/<%=resultSet1.getString(3) %></td>
	<%
	}
	statement1.close();
	resultSet1.close();
}
else if(clip_Level.equals("Habitation")){
	getDataQuery="select mname,pname,vname,panch_name from rws_complete_hab_view where dcode='"+districtCode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and vcode='"+vcode+"' and panch_code='"+habCode+"'";
	statement1=conn.createStatement();
	resultSet1=statement1.executeQuery(getDataQuery);
	if(resultSet1.next()){
	%>
	<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet1.getString(1) %><br/>/<%=resultSet1.getString(2) %><br/>/<%=resultSet1.getString(3) %><br/>/<%=resultSet1.getString(4) %></td>
	<%
	}
	statement1.close();
	resultSet1.close();
	
}
else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">--</td>
	<%
}
//System.out.println("end of ");
%>


 <td class="<%=style %>" style="text-align: left;" align="right"><%=pname %></td>
			 <td class="<%=style %>" style="text-align: left;" align="right"><%=pdate %></td>
			 <td class="<%=style %>" style="text-align: left;" align="right"><%=edition %></td>
			 <td class="<%=style %>" style="text-align: left;" align="right"><%=pnews %></td>
			 <td class="<%=style %>" style="text-align: left;" align="right"><%=at %></td>
			 <td class="<%=style %>" style="text-align: left;" align="right"><%=remarks %></td>
<%
	
	//InputStream iStream = b.getBinaryStream();
	if(clipImage==null){
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}
	else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&mode=clipImage')">View</a></td>
<%}%>

<%
	
	//InputStream iStream = b.getBinaryStream();
	if(atrImage==null){
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}
	else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&mode=atrImage')">View</a></td>
<%}%>







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

