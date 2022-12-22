
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ include file = "conn3.jsp" %>



<%	
	
	Statement st5=null,st6=null;
	ResultSet rs5=null,rs6=null;
	int start,end,limit =20,slno=0,j,pgcnt,pgno=0;
	int line=0,LNO;	
	int  GOPG;
	String pid=null;
	String wid=null;
	//String stt=request.getParameter("start");
	
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	String stt=request.getParameter("start");

	
	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("repLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	

	ArrayList myList1 = (ArrayList)session.getAttribute("repList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	//System.out.println("name of  count is  "+mylists1);
String fdat=String.valueOf(session.getAttribute("fdate"));
String tdat=String.valueOf(session.getAttribute("tdate"));
String rCde=String.valueOf(session.getAttribute("repcode"));
String rpName=String.valueOf(session.getAttribute("repname"));
//System.out.println("rp name is   "+rpName);
	

 %>
 
<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font>
<br>
<table  width="100%">
	<tr  align=center>
	<td align="center" class="mystyle1"><font color="black"><h5>Pendency Status Details Report</h5></font></td>
	</tr>
	<tr align="right">
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>


<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
.test1
	{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<body>
<table border = 0 cellspacing = 0 cellpadding = 0 width=100%  height="68%" bordercolor=#000000 style="border-collapse:collapse" >
<tr><td valign=top>
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" align=center>	
	<tr>
		<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<%if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="#9900CC">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
	<tr>
<% if(fdat!=null && !fdat.equals("0") && tdat!=null && !tdat.equals("0"))
	{%>
	<tr >
		<td class="textborder" align="center" colspan="14">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdat %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdat %></font></td>
	</tr>
	<%
	}
	
	//System.out.println("rCode is  "+rCde);
	if(!rCde.equals("00") && rCde!=null)
		{
		%>
	<tr>	
	<td align=center colspan=15 class="mystyle1">Represented By:&nbsp;&nbsp;<font color="red"><%= rpName %> </font></td></tr>
	<td class = mystyle1 >S.No</td>
	
	<% } else
		{	%><td class = mystyle1 >S.No</td>
			<td class = mystyle1 >Represented By</td> 
		<%}%>
		<td class = "mystyle1" >Representative Name</td>
		<td   class="mystyle1">Asset Name</td>		
		<td   class="mystyle1"> Proposal Id</td>
		<td   class="mystyle1"> Work Name </td>
		<td   class="mystyle1" > Proposal Date    </td>
		<td   class="mystyle1"> Work Description </td>
		<td   class="mystyle1">Status</td>
		<td   class="mystyle1">Pending At </td>
		<td   nowrap class="mystyle1">Endorsed By<br>/No <br>/Date </td>
		<!-- <td   class="mystyle1">Endorsed No </td>
		<td   class="mystyle1" >Endorsement Date</td> -->
		<td   class="mystyle1" >Estimated Cost (Rs. in Lakhs)</td> 
		<!-- <td   class="mystyle1">Recommenda- -tions</td> -->
		<td   class="mystyle1">Prepared On <br>/By</td>
		<td   class="mystyle1">Prepared At </td>
		
		
		<!--  <td   class="mystyle1">No. of Habitations</td>  -->
		
	</tr>
	<tr>
<%	
	try
	{		
		
//		int slno=0;
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		String panchcode[]=new String[labelNames.length];		
		LNO=6;		

			for(int z = 0,sno=1; z<mylists1; z++,sno++)
		{
				if(mylists1>z && LNO<=50)
			{		
			String[] record1 =(String[])myList1.get(z);		
		   
			if(!rCde.equals("00") && rCde!=null && !rCde.equals("null") && !rpName.equals("null") )
			{	%>
		 
			<td class = mystyle1 ><%= sno %></td>
		<% } else
				{	%>
					<td class = mystyle1 ><%= sno %></td>
					<td  class="mystyle1"><%=  record1[28] %>  </td>
			<%	 }	 %>
		
		<td class="mystyle1"><%=record1[26] %> </td>
		<td  class="mystyle1"><%= record1[27] %>  </td>		
		<td class="mystyle1"><%= record1[0] %>   </td>
		<td class="mystyle1"><%= record1[1] %> </td>
		<td  class="mystyle1"><%= record1[11] %> </td>
		<td  class="mystyle1"><%= record1[15] %> </td>
		<%
			 pid = record1[0];
			 wid = record1[18];
			 //System.out.println(" wid is   "+wid);
			 if(wid!=null)
			{
			st5=conn1.createStatement();
			String q5="select et.TS_NO, et.TS_OFFICE from  RWS_NEW_EST_TBL et where et.work_id='"+wid+"'"  ;	 
				rs5=st5.executeQuery(q5);
			
				if(rs5.next())
				{%>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Technical Sanction </td>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=2> <%=RS1.getOfficeName(rs5.getString(2),true) %> </td>
					
		<% }
				else
				{
					st6=conn1.createStatement();
					String q6="select  ACTION_FROM, ACTION_TO from RWS_PROPOSAL_WORKFLOW_TBL pw where track_no=(sELECT max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL pw where pw.proposal_id='"+ pid +"') and pw.proposal_id='"+pid+"'" ;
					rs6=st6.executeQuery(q6);
					rs6.next();
		%>
				<td  bgcolor=#FFFFFF><font color=#CC00CC size=3>Considered for Sanction</td>
				<td bgcolor=#FFFFFF><font color=#CC00CC size=2> <%=RS1.getOfficeName(rs6.getString(2),true) %> </td>
				
				<% }
			}
			else
			{ %>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Not Considered </td>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3><%=RS1.getOfficeName(record1[12],true) %>   </td>
			

			<%}

			rs5.close();
			st5.close();
		%>
		<td class="mystyle1"> <%=RS1.getOfficeName(record1[12],true) %>   </td>
		<td  class="mystyle1"> <%= record1[3] %> <br><%= record1[4] %><br> <%= record1[5]%>
		<td  class="mystyle1" align=right><%=record1[2]%> </td>
	
		<td class="mystyle1"> <%=record1[13]%> <br>  <%=record1[14] %> </td>
		

	</tr>
<%}else{
				
				LNO=6;
				z--; sno--;
				////System.out.println("Valie os Z ias "+z);
				%>
<table align=center>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>
</TABLE>
		<p style="page-break-before:always">
	
<table align="center" width="100%">
	<tr>
	<td align="center" class="mystyle1"><font color="navy"><h5>Habitation  Status  Report</h3></font></td>
	</tr>
	<tr>
	<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >
	<tr><td valign=top>
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" align=center>	
	<tr>
		<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<%if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="#9900CC">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >	
	<tr>
<% if(fdat!=null && !fdat.equals("0") && tdat!=null && !tdat.equals("0"))
	{%>
	<tr >
		<td class="textborder" align="center" colspan="14">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdat %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdat %></font></td>
	</tr>
	<%
	}
	
	//System.out.println("rCode is  "+rCde);
	if(!rCde.equals("00") && rCde!=null)
		{
		%>
	<tr>	
	<td align=center colspan=15 class="mystyle1">Represented By:&nbsp;&nbsp;<font color="red"><%= rpName %> </font></td></tr>
	<td class = mystyle1 >S.No</td>
	
	<% } else
		{	%><td class = mystyle1 >S.No</td>
			<td class = mystyle1 >Represented By</td> 
		<%}%>
		<td class = "mystyle1" >Representative Name</td>
		<td   class="mystyle1">Asset Name</td>		
		<td   class="mystyle1"> Proposal Id</td>
		<td   class="mystyle1"> Work Name </td>
		<td   class="mystyle1" > Proposal Date    </td>
		<td   class="mystyle1"> Work Description </td>
		<td   class="mystyle1">Status</td>
		<td   class="mystyle1">Pending At </td>
		<td   nowrap class="mystyle1">Endorsed By<br>/No <br>/Date </td>
		<!-- <td   class="mystyle1">Endorsed No </td>
		<td   class="mystyle1" >Endorsement Date</td> -->
		<td   class="mystyle1" >Estimated Cost (Rs. in Lakhs)</td> 
		<!-- <td   class="mystyle1">Recommenda- -tions</td> -->
		<td   class="mystyle1">Prepared On <br>/By</td>
		<td   class="mystyle1">Prepared At </td>
		
		
		<!--  <td   class="mystyle1">No. of Habitations</td>  -->
		
	</tr>
	<tr>
	</p>
<%} //END  OF ELSE
} // end of for loop

	}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{		try
		{
			conn1.close();
		}
		catch(Exception e)
		{
		
		}
}

%>
</table>
</TD></TR>
</TABLE>
</body>
</html>

</TABLE>
<table>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>

</body>
</html>
