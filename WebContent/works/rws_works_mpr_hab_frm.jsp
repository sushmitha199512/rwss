<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
function ajaxFunction(URL,divobj)
{ 
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {
		alert(xmlHttp.responseText);
		document.getElementById('load').style.display='none';
		document.getElementById('cancel').style.display='none';
		document.getElementById('continue').style.display='block';
		//document.getElementById('mode').value='details';
		//submitPage();
	  }
	  else{
		  document.getElementById('cancel').style.display='none';
		  document.getElementById('load').style.display='block';
	  }
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}
function cancelTheWork()
{	
	if(document.getElementById('workId').value=="")
	{
		alert("Please Select the Work");		
	}
	else if(document.forms[0].workCancelledDate.value==null || document.forms[0].workCancelledDate.value=="")
	{
		alert("Please Enter the Date Of Cancellation");		
	}
	else if(document.forms[0].physicalStatus.value=="Grounded")
	{
		dt1=getDateObject(document.forms[0].workCancelledDate.value,"/");
		dt2=getDateObject(document.forms[0].physicalStatusDetails.value,"/");
		if(dt1<dt2)
		{
			alert("Cancellation Date should not be \n Less than to Grounding Date");
		}
		else
		{
			var url="/pred/works/WorkStatus.do?mode=cancelWork&workId="+document.getElementById('workId').value+"&cancelDate="+document.forms[0].workCancelledDate.value;
			ajaxFunction(url,document.getElementById("mydivid"));
		}
	}
	else
	{
		var url="/pred/works/WorkStatus.do?mode=cancelWork&workId="+document.getElementById('workId').value+"&cancelDate="+document.forms[0].workCancelledDate.value;
		ajaxFunction(url,document.getElementById("mydivid"));
	}
}
</SCRIPT>
<body>
<%
stmt = conn.createStatement();
String qry = "select c.*,a.hab_code,c.CENSUS_PLAIN_POPU+c.CENSUS_SC_POPU+c.CENSUS_ST_POPU  as totpop,ddws_hab_code from RWS_WORKS_ACTION_PLAN_HABS_TBL a,rws_habitation_directory_tbl b,rws_complete_hab_view c where a.hab_code=b.hab_code and b.hab_code=c.panch_code and a.hab_code=c.panch_code and a.work_id='"+request.getParameter("workId")+"'";
System.out.println("sqk:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
%>
<table border = 0 cellspacing = 0 cellpadding = 0 width=100%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="javascript:self.close()">Close</a>
			</td>
		</tr>
	</table>
</table>
<p align=center><font face=verdana size=3 color=blue>Habitations for the Work</font></p>
<table align="center" border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>District</td>
			<td class=btext>Mandal</td>
			<td class=btext>Panchayat</td>
			<td class=btext>Village</td>
			<td class=btext>Habitation</td>
			<td class=btext>Hab Code</td>
			<td class=btext>Hab Status</td>
			<td class=btext>DDWS Hab ID</td>
			<td class=btext>Population</td>
			</tr>
<%
while(rs.next())
{
%>
	<tr>
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(10)%></td>
			<td class=rptValue><%=rs.getString(21)%></td>
			<td class=rptValue><%=rs.getString(12)%></td>
			<td class=rptValue><%=rs.getString(23)%></td>
			<td class=rptValue  align=right><%=rs.getString(22)%></td>
	</tr>
<%
}
%>

</table>		
</body>