<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		//System.out.println("in habStatus ");
	Statement stmt1 = null,s1=null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null,r1;

	Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	ResultSet rs5=null;
    String temp=null;
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">

function unview()
{
    var a=document.getElementById('combo').value;
	//alert(a);
	if(a=="-1")
	{
      // document.getElementById('butview').disabled=true;
	}
}
function fnSubmit()
{
	document.f1.action="./rws_hab_dist_status_report.jsp";
	document.f1.submit();
}
function fnMandSubmit()
{ 
    //alert(document.f1.mandal.value);
    //if(document.f1.mandal.value=="" || document.f1.mandal.value==null)
    //{
    //alert("Please Select Mandal");
    //return false;
    //}
    //else
    //{
	document.f1.action="./rws_hab_mand_status_report.jsp";
	document.f1.submit();
    //}
}
function fnPanchSubmit()
{ 
	document.f1.action="./rws_hab_panch_status_report.jsp";
	document.f1.submit();
}
function fnHabSubmit()
{ 
	document.f1.action="./rws_hab_status_report.jsp";
	document.f1.submit();
}
function valSubmit()
{ 
	alert("Please SELECT District");
}
</script>

<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">

<form name=f1 method="post">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="20%" height="80%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width="20%" height="80%" align = "right" bgcolor="#edf2f8">
		
	<tr>
		<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
	</tr>
	</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="textborder" colspan="2">
			<font color="#FFFFFF">Habitation Status Report</font>
		</td>	
	</tr>
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String Const=null,consCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;
    
try
{%>
<TR> 
   <TD  valign=top  align="center" height="80%" width="20%">
   <table  bordercolor= navy width="20%" height="80%" border=1 rules="rows" style="border-collapse:collapse" align = center>

<%  rDist = request.getParameter("district");
	if(rDist == null || rDist.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");
%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
<%
	session.setAttribute("dCode", null);
	session.setAttribute("dName", rDist);
}
	else if(!rDist.equals("-1"))  
	{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		<!--<option value="00">ALL</option>-->
<%
		session.setAttribute("dCode", rDist);
}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) order by  d.dcode");
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						session.setAttribute("dName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();

%>
			</select>
		</td>
	</tr>
<%
	
	   rMand = request.getParameter("mandal");
		if(rDist == null || rDist.equals("-1")  || rMand == null)
		{	
			//System.out.println("IN CONSTITUENCY STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="">SELECT...</option>
<%
				session.setAttribute("mCode", null);
				session.setAttribute("mName", rMand);
		}
		else
			if(rDist != null || !rDist.equals("-1") || !rDist.equals("00") || rMand != null)
			{
				//System.out.println("IN CONSTITUENCY ALL...");
%>			
		<td class=rptLabel>Mandal<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="">SELECT...</option>				
	
<%
					stmt = conn.createStatement();
					rs = stmt.executeQuery("SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '"+rDist+"'  AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE order by M.MCODE");
					while(rs.next())
					{
						if(rMand != null && rMand.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mName",rs.getString(2));
						session.setAttribute("mCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mCode",rMand);
					rs.close();
					stmt.close();
			}
%>
	</select>
	</td>
	</tr>
<%
		rPanch = request.getParameter("panchayat");
		if(rDist == null  || rDist.equals("-1") || rMand == null || rMand.equals("00") || rMand.equals("-1"))
		{	
			//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("pCode", null);
				session.setAttribute("pName", rPanch);
		}
		else
			if(rDist != null && !rDist.equals("00") || rMand != null || !rMand.equals("00") || !rMand.equals("-1"))
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
					stmt = conn.createStatement();
					rs = stmt.executeQuery("SELECT DISTINCT P.PCODE,P.PNAME FROM RWS_PANCHAYAT_TBL P, RWS_HABITATION_DIRECTORY_TBL HD, RWS_CONSTITUENCY_TBL C WHERE P.PCODE = SUBSTR(HD.HAB_CODE,13,2) AND P.DCODE = SUBSTR(HD.HAB_CODE,1,2)AND P.DCODE = '"+rDist+"'  and P.MCODE = SUBSTR(HD.HAB_CODE,6,2) AND P.MCODE = '"+rMand+"'");
					while(rs.next())
					{
						if(rPanch != null && rPanch.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("pName",rs.getString(2));
						session.setAttribute("pCode",rPanch);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("pCode",rPanch);
					rs.close();
					stmt.close();
			}	
%>
			</select>
		</td>
	</tr>



<!--**************************************************************************************************-->
	
	<tr>

			<td class = btext nowrap >
				<font color=navy><b>Status As On Date</b> </font>
				<font color="red">*</font></td>
			</td>
			<td class = btext >
				<SELECT name="FDate"  class="mycombo" style="width:150px"onChange="this.form.submit()">
				<!--<option value="0">SELECT...</option>-->	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);
     stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	String qrys = " select distinct to_char(h1.status_date,'dd-MON-yyyy'),to_date(h1.status_date,'dd-mm-yyyy') from rws_habitation_directory_tbl h1 where h1.status_date is not null order by 2 desc";
//	rs1=stmt1.executeQuery("select distinct  to_char(status_date,'dd-MON-yyyy') from rws_habitation_dir_his_tbl where to_char(status_date,'yyyy')< to_char(sysDate,'YYYY') and status_date is not null Union select distinct to_char(status_date,'dd-MON-yyyy') from rws_habitation_directory_tbl where status_date is not null"); 
		//.out.println("qry::"+qrys);
		rs1=stmt1.executeQuery(qrys);
    /*rs1=stmt1.executeQuery("select distinct to_char(status_date,'dd-MON-yyyy') from rws_habitation_directory_tbl where to_char(status_date,'yyyy')=to_char(sysDate,'YYYY') and to_char(status_date,'yyyy')<>'2006'");*/

	while(rs1.next()) 
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 FDATE=rs1.getString(1);


	session.setAttribute("FDATE",FDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			</TR>
			<td class = btext nowrap >
				<font color=navy><b>Choose one of the Options</b> </font>
				<font color="red">*</font></td>
			</td>
			<TR>
			<TD class="clrborder"><%if(request.getParameter("assetType")!=null && request.getParameter("assetType").equals("01")){%><INPUT TYPE="radio" NAME="assetType" value="01" checked onClick="showtable('01')"><%}else{%><INPUT TYPE="radio" NAME="assetType" value="01" onClick="showtable('01')"><%}%><font size=2 color="purple">PopulationDetails</font><%if(request.getParameter("assetType")!=null && request.getParameter("assetType").equals("02")){%><INPUT TYPE="radio" NAME="assetType" value="02" checked onClick="showtable('02')"><%}else{%><INPUT TYPE="radio" NAME="assetType" value="02" onClick="showtable('02')"><%} %><font size=2 color="purple">WaterSupplyDetails</font></TD><TD class="clrborder"><%if(request.getParameter("assetType")!=null && request.getParameter("assetType").equals("03")){%><INPUT TYPE="radio" NAME="assetType" value="03" checked onClick="showtable('03')"><%}else{%><INPUT TYPE="radio" NAME="assetType" value="03" onClick="showtable('03')"><%}%><font size=2 color="purple">PublicInstitutions</font></TD><TD class="clrborder">
			<%if(request.getParameter("assetType")!=null && request.getParameter("assetType").equals("04")){ %><INPUT TYPE="radio" NAME="assetType" value="04" checked onClick="showtable('04')"><%}else{%><INPUT TYPE="radio" NAME="assetType" value="04" onClick="showtable('04')"><%} %><font size=2 color="purple">ALL</font></TD></tr>
		</table>
			
</TD>
<!--<TD  valign=top height=40% align="center" width="70%">-->

		 <script>
				function showtable(index)
	{
				   
					document.f1.action="./rws_hab_status_forms.jsp?assetType="+index;
			        document.f1.submit();
	}

	</script>

  <% if(request.getParameter("assetType").equals("01"))
	{%>
	  <TD  valign=top height=60% align="center" width="70%">
	  <div  style="position:relative;overflow-y:auto;left:0;height:150;width:100%;top:0;">
		<% temp="01";%>
		<%@ include file="./rws_hab_detailed_form.jsp"%>
	<% } 
	else if(request.getParameter("assetType").equals("02"))
	{%>
	<TD  valign=top height=40% align="center" width="70%">
	<div  style="position:relative;overflow-y:auto;left:0;height:300;width:100%;top:0;">
		<% temp="02";%>
		<%@ include file="./rws_hab_detailed_form1.jsp"%>
		<%
	}
		else if(request.getParameter("assetType").equals("03"))
	{%>
	<TD  valign=top height=40% align="center" width="70%">
	<div  style="position:relative;overflow-y:auto;left:0;height:270;width:100%;top:0;">
		<% temp="03";%>
		<%@ include file="./rws_hab_detailed_form2.jsp"%>
<%
	}
	else if(request.getParameter("assetType").equals("04"))
	{%>
	<TD  valign=top height=40% align="center" width="70%">
	<div  style="position:relative;overflow-y:auto;left:0;height:300;width:100%;top:0;">
		<% temp="04";
		%>
		<%@ include file="./rws_hab_detailed_form3.jsp"%>
		<%
	}%>
</div>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>      <%if(request.getParameter("assetType").equals("04")){ %>
					<td width="100%" colspan="2" align="center" class = btext ><%}else{%><td width="100%" colspan="2" align="center" class = btext nowrap><%} %>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<A HREF="javascript:clearAll('ch','ck')">clearAll&nbsp;Fields</A>
				</td>
			</tr>	
		</table>
</TD>
<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">
<INPUT TYPE="hidden" name="aType" value="<%=temp%>">


<TR>	
<TD colspan=2 align=center valign=top>	

<% if(rDist!=null && rDist.equals("00")) {

%>

<table bordercolor=navy width="40%" height="80%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" id="butview" value="View Report" class = btext></td>
	</tr>
</table>
<%} else if(rDist!=null && !rDist.equals("00") && !rDist.equals("-1") && (rMand.equals("00") || rMand.equals(""))){
 %>
<table bordercolor=navy width="40%" height="80%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnMandSubmit()" id="butview" value="View Report" class = btext></td>
	</tr>
</table>
<%} else if(rDist!=null && !rDist.equals("00") && !rDist.equals("-1") && rMand!=null && !rMand.equals("00") && !rMand.equals("-1") && (rPanch.equals("00") || rPanch.equals("-1"))){ 
%>
<table bordercolor=navy width="40%" height="80%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnPanchSubmit()" id="butview" value="View Report" class = btext></td>
	</tr>
</table>
<%} else if(rDist!=null && !rDist.equals("00") && !rDist.equals("-1") && rMand!=null && !rMand.equals("00") && !rMand.equals("-1") && !rPanch.equals("00") && !rPanch.equals("-1")){ 
%>
<table bordercolor=navy width="40%" height="80%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnHabSubmit()" id="butview" value="View Report" class = btext></td>
	</tr>
</table>
<%}%>
</TD></TR>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ 
			//e.printStackTrace();
			}
	finally
	{
		if (conn!=null)
		conn.close();
	}%>

	