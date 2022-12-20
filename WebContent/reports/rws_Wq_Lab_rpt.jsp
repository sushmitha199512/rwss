<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>



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
</script>
<%

java.util.Date date =new  java.util.Date();
int year=date.getYear()+1900;
String currentYear= String.valueOf(year); 
int finYear_Start=2012;


		int mb=0,mc=0,mt=0,umb=0,umc=0,umt=0,t=0,t2=0,pb=0,pc=0,pt=0,ptot=0,mtot=0,umtot=0;
		boolean flag=false;
		double coverage=0.0;
		int tt1=0;
		String q1="",y="",ye="", month="",pmonth="",nmonth="";
		String mode = request.getParameter("mode");
		if(mode!=null)
		{
			session.setAttribute("mode",mode);
		}
         
		 String dname = request.getParameter("dname");
				if(dname!=null)
		{
			session.setAttribute("dname",dname);
		}
     	double gt=0.0,t1=0.0;
		nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = user.getUserId();
		String dcode = request.getParameter("district");
       if(dcode!=null)
		{
			session.setAttribute("dcode",dcode);
		}
		String mon=request.getParameter("month");
		
     
		DecimalFormat ndf = new DecimalFormat("####.00");
		String query = null;
		int sno=1;
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentMonth = dateFormat.format(currentDate).substring(5,7);
		String premonth=""+(Integer.parseInt(currentMonth)-1);
        WorksData1 wd = new WorksData1();
		int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
		String mnth=request.getParameter("month");
        session.setAttribute("nmonth",mnth);
		
           
		if(request.getParameter("year")!=null)
		{		  
		ye=request.getParameter("year");

			if(ye!=null)
		{
		session.setAttribute("ye",ye);
		}
		y=ye.substring(2,4);
		}

		if(y!=null)
		{
		session.setAttribute("y",y);

		}
		
		String y1=y;
		session.setAttribute("y1",y1);
		String compYear="";
		int yea = Calendar.getInstance().get(Calendar.YEAR);
		 int pfye;
		    int m = Calendar.getInstance().get(Calendar.MONTH) + 1;

		    if (m < 4 && ye!="") {
		     
		       if(year1!=Integer.parseInt(ye)+1){
		    	//   System.out.println("inside if");
		    	   compYear=ye;
		       }
		       else{
		    	 //  System.out.println("inside else if");
		    	   if(mnth.equals("JAN") || mnth.equals("FEB") || mnth.equals("MAR")){
		    		   compYear=ye;
		    	   }
		    	   else{
		    	   compYear= String.valueOf(year1);
		    	   }
		    	   
		       }
		       
		    } 
		    else{
		    	compYear=ye;
		    }
		    
  if(mnth !=null) {
	if(mnth.equals("JAN"))
	{
		int pY=Integer.parseInt(y);
		pY=pY-1;
		y1=String.valueOf(pY);
		month="JANUARY";
		pmonth="DEC";
		nmonth="FEB";
       
	}
	else if(mnth.equals("FEB"))
	{
		month="FEBUARY";
		pmonth="JAN";
		nmonth="MAR";
	}
	else if(mnth.equals("MAR"))
	{
        month="MARCH";
		pmonth="FEB";
		nmonth="APR";
	}
	else if(mnth.equals("APR"))
	{
		month="APRIL";
        pmonth="MAR";
        nmonth="MAY";
	}
	else if(mnth.equals("MAY"))
	{
		month="MAY";
		pmonth="APR";
		nmonth="JUN";
	}
	else if(mnth.equals("JUN"))
	{
		month="JUNE";
        pmonth="MAY";
        nmonth="JUL";
        
	}
	else if(mnth.equals("JUL"))
	{
		month="JULY";
		pmonth="JUN";
		nmonth="AUG";
	}
	else if(mnth.equals("AUG"))
	{
		month="AUGUST";
		pmonth="JUL";
		nmonth="SEP";
	}
	else if(mnth.equals("SEP"))
	{
		month="SEPTEMBER";
	    pmonth="AUG";
	    nmonth="OCT";
	}
	else if(mnth.equals("OCT"))
	{
		month="OCTOBER";
        pmonth="SEP";
        nmonth="NOV";
	}
	else if(mnth.equals("NOV"))
	{
		month="NOVEMBER";
		pmonth="OCT";
		nmonth="DEC";
	}
	else if(mnth.equals("DEC"))
	{
		pmonth="NOV";
		month="DECEMBER";
		nmonth="DEC";
	}
}
	if(month!=null)
	{
		session.setAttribute("month",month);
	session.setAttribute("mnth",mnth);
	}
	
	if(pmonth!=null)
	{
		session.setAttribute("pmonth",pmonth);
	}
	
	
	
	
	if(nmonth!=null)
	{
		session.setAttribute("nmonth",nmonth);
		
		
	}
%>
<script>
function fnView()
{
	
     var userId='<%=loggedUser %>';
	if(document.forms[0].district.value=='')
	{
		alert("Please Select District");
		return false;
	}
	else if(document.forms[0].year.value=='')


	{
		alert("Please Select Year");
		return false;
	}



	else if(document.forms[0].month.value=='')


	{
		alert("Please Select Month");
		return false;
	}


	


	else
	{

           if(userId=="admin" || userId=="100000"){
	document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text; 
}
	document.forms[0].mode.value = "report";
	document.forms[0].action= "rws_Wq_Lab_rpt.jsp";
	document.forms[0].submit();
	}
}

</script>

<body bgcolor="#edf2f8">
 <form  > 
<BR>
<BR>
<BR>
<table border = 0 cellspacing = 0 cellpadding = 0 height=1% width="30%"  style="border-collapse:collapse" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td style="text-align:right;" >
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					 <a href="./rws_Wq_Lab_xls1.jsp" target="_new">Excel </a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="gridhdbg" colspan=2><font style="text-transform: uppercase;">Testing of Water Samples  Report </font></td>		
		</tr>
		<tr><td class=gridhdbg>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class="gridhdbg">
		<%
		String dcode1 = request.getParameter("district");
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
			
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
            <option value="">-Select-</option> 
			<option value="00">All</option> 
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
			dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
	<tr><td class=gridhdbg>Year&nbsp;&nbsp;<font color="red">*</font></td>
	<td class="gridhdbg">
	<SELECT name="year" id="combo" class="mycombo" style="width:150px"  >
	<option value="">-Select-</option>
	<%
	for(int i=2012;i<=year1;i++)
	{
		String ii =""+i;
		if(request.getParameter("year")!=null && request.getParameter("year").equals(ii)) {%>
	<option value='<%=i%>' selected><%=i%></option>
	<%
	}
	else
	{%>
	<option value='<%=i%>'><%=i%></option>
	<%
	}}	
	%>

	</select>
	</td>
	</tr>

<tr>
 <td class = "gridhdbg" >Month<font color="red">*</font>
		
		</td>
		<td class = "gridhdbg" colspan=3><SELECT name="month" style="width:150px" class="mycombo" >
		<option value="">-Select-</option>

		 <% 
		
ArrayList months=new ArrayList();
months.add("JAN");months.add("FEB");months.add("MAR");months.add("APR");
months.add("MAY");months.add("JUN");months.add("JUL");months.add("AUG");
months.add("SEP");months.add("OCT");months.add("NOV");months.add("DEC");

  
String cmonth= RwsUtils.getCurrentDate("dd/MMM/yyyy").substring(3,6);
String cyear= RwsUtils.getCurrentDate("dd/MMM/yyyy").substring(7,11);
   
     
	  for(int i=0;i<months.size();i++)
	{
		  
   if(mnth!=null && mnth.equalsIgnoreCase((String)months.get(i))){
     %>
	 <option value="<%= months.get(i) %>" SELECTED><%= months.get(i) %> 
	
	<%}
    else {
   %>
 <option value="<%= months.get(i) %>" ><%= months.get(i) %> 
<% 
}
}
	  
	  String pmn="";String mn="";
	  if(mon!=null && !mon.equals("all")){
		  
		  
		  pmn="and to_char(prepared_on,'MON')='"+pmonth+"'";
		  session.setAttribute("pmn",pmn);
		  mn="and to_char(prepared_on,'MON')='"+mnth+"'";
		  session.setAttribute("mn",mn);
		  
  }

	%>
</tr>

			<tr align="center">
			<td colspan=2 align=center>
				<input type=button value="View Report" class = "gridhdbg" onclick="fnView()">
		</td>
		</tr>
	</table>
		<br>
		<%	if(mode!=null && mode.equals("report")){%>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td style="text-align:right;"  class="gridhdbg">
					B : Bacteriological	 & C :Chemical	</td>
				</tr>
			</table>
		</caption>
	<tr align=center>
		<td class="gridhdbg" rowspan = 2>Sl.No</td>
		<td class="gridhdbg" rowspan = 2>District</td>
		<td class="gridhdbg" rowspan = 2>Location of the Laboratory</td>
		<td class="gridhdbg"   rowspan = 2>Yearly Target no. of Samples<br> (@ 300nos. Per Month  for each Laboratory)</td>
<%	/* if(year1==Integer.parseInt(compYear))
	{ */ %>
		<td class="gridhdbg"  colspan=4>Achievement of Previous Month:<%=pmonth%></td>
		<td class="gridhdbg"  colspan=4>Achievement During the Month:<%=month%></td>
		<td class="gridhdbg"  colspan=4>Achievement Up to the month<br> (Cumulative):<%=month%></td>
		<td class="gridhdbg"  rowspan = 2>% Of Achievement against the Target<br> (12/3)</td>
		<%/* }else{ */%>
		<!-- <td class="gridhdbg"  colspan=3>Achievement upto Year</td>
		<td class="gridhdbg"  rowspan = 2>% Of Achievement against the Target<br> (6/3)</td>
		 --><%//}%>
		</tr>
		<%/* if(ye!=null && year1==Integer.parseInt(compYear))
			{  */%>
	<tr align=center>
	<td class="gridhdbg">B</td>
	<td class="gridhdbg">C</td>
	<td class="gridhdbg">Total</td>
	<td class="gridhdbg">Total No.of Sources tested</td>
	<td class="gridhdbg">B</td>
	<td class="gridhdbg">C</td>
	<td class="gridhdbg">Total</td>
	<td class="gridhdbg">Total No.of Sources tested</td>
	<td class="gridhdbg">B</td>
	<td class="gridhdbg">C</td>
	<td class="gridhdbg">Total</td>
	<td class="gridhdbg">Total No.of Sources tested</td>
	</tr>
	<tr><td align="center" class="gridhdbg">1</td><td align="center" class="gridhdbg">2</td><td align="center" class="gridhdbg">3</td><td align="center" class="gridhdbg">4</td><td align="center" class="gridhdbg">5</td><td align="center" class="gridhdbg">6</td><td align="center" class="gridhdbg">7</td><td align="center" class="gridhdbg">8</td><td align="center" class="gridhdbg">9</td><td align="center" class="gridhdbg">10</td><td align="center" class="gridhdbg">11</td><td align="center" class="gridhdbg">12</td><td align="center" class="gridhdbg">13</td><td align="center" class="gridhdbg">14</td><td align="center" class="gridhdbg">15</td><td align="center" class="gridhdbg">16</td><td align="center" class="gridhdbg">17</td></tr>
	<%/* }else{ */%>
		<!-- </tr>
		<tr align=center>
		<td class="gridhdbg">B</td>
		<td class="gridhdbg">C</td>
		<td class="gridhdbg">Total</td>
		</tr>
		<tr><td align="center" class="gridhdbg">1</td><td align="center" class="gridhdbg">2</td><td align="center" class="gridhdbg">3</td><td align="center" class="gridhdbg">4</td><td align="center" class="gridhdbg">5</td><td align="center" class="gridhdbg">6</td><td align="center" class="gridhdbg">7</td></tr> -->
		<%//}%>
	
	<%	
	String Query="";
		String dcode11=request.getParameter("district");
		if(dcode11.equals("00"))
		{    
	Query="select lab_code,substr(office_code,2,2),location,dname,lab_name from RWS_WATER_QUALITY_LAB_TBL,rws_district_tbl where substr(office_code,2,2)=dcode and status<>'UI' AND STATUS IS NOT NULL order by substr(office_code,2,2)";
		}
		else
		{
	  Query =" select lab_code,substr(office_code,2,2),location,dname,lab_name from  RWS_WATER_QUALITY_LAB_TBL ,rws_district_tbl b  where substr(office_code,2,2)='"+dcode11+"'and substr(office_code,2,2)=dcode AND status<>'UI' AND STATUS IS NOT NULL order by substr(office_code,2,2)";
		}
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		ResultSet rs1 = stmt1.executeQuery(Query); 
	    int targetSum=0; 
	     
	    
	    String style="";int styleCount=0;
		while(rs1.next())
		{ 
targetSum+=3600;
			/* if(year1==Integer.parseInt(compYear))
			{
			 */	
			  q1="select (select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'  and substr(test_id,4,2)='"+y+"'"+mn+") as a,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'  and substr(test_id,4,2)='"+y+"'"+mn+")  as b,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'   and substr(test_id,4,2)='"+y+"' and to_date(prepared_on,'dd/mm/yy')>='01-JAN-"+ye+"' and to_date(prepared_on,'dd/mm/yy')<'01-"+nmonth+"-"+ye+"')as c,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'   and substr(test_id,4,2)='"+y+"' and to_date(prepared_on,'dd/mm/yy')>='01-JAN-"+ye+"' and to_date(prepared_on,'dd/mm/yy')<'01-"+nmonth+"-"+ye+"') as d,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'  and substr(test_id,4,2)='"+y1+"'"+pmn+") as e,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'  and substr(test_id,4,2)='"+y1+"'"+pmn+") as f,(select count(distinct source_code)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"'and substr(test_id,4,2)='"+y+"'"+mn+") as g,(select count(distinct source_code)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"'and substr(test_id,4,2)='"+y1+"'"+pmn+") as h,(select  count(distinct source_code)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"'and substr(test_id,4,2)='"+y+"'and to_date(prepared_on,'dd/mm/yy')>='01-JAN-"+ye+"' and to_date(prepared_on,'dd/mm/yy')<'01-"+nmonth+"-"+ye+"') as i from dual";
			/* }else{
			 q1="select (select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='2'   and substr(test_id,4,2)='"+y+"') as c,(select count(*)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+rs1.getString(2)+"' and substr(test_id,1,3)='"+rs1.getString(1)+"' and test_code='1'   and substr(test_id,4,2)='"+y+"') as d from dual";
			} */
			//System.out.println("q1----"+q1);
			ResultSet rs2 = stmt2.executeQuery(q1);
			
			if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			
			while(rs2.next())
			{ 
     
				
				
			/* if(year1==Integer.parseInt(compYear))
			{ */%>
			<tr>
			<td class=<%=style %> style="text-align:left;"><%=sno++%></td>
			<td class=<%=style %> style="text-align:left;"><%=rs1.getString(4)%></td>
			<td class=<%=style %> style="text-align:left;"><%=rs1.getString(3)%></td>
			<td class=<%=style %> nowrap style="text-align:right;">3600</td>
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_rpt.jsp?testCode=2&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(5)%></a></td>
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_rpt.jsp?testCode=1&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(6)%></a></td>
			<%  t2=rs2.getInt(5)+rs2.getInt(6);%>
			<td class=<%=style %> nowrap style="text-align:right;"><%=t2%></td>
			
            <td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_rpt.jsp?dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(8)%></a></td>
			
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsource_rpt.jsp?testCode=2&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(1)%></a></td>
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsource_rpt.jsp?testCode=1&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(2)%></a></td>
			<%  t=rs2.getInt(1)+rs2.getInt(2);%>
			<td class=<%=style %> nowrap style="text-align:right;"><%=t%></td>
			
			
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsource_rpt.jsp?dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(7)%></a></td>
			
			
			<td class=<%=style %>  style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsou_rpt.jsp?testCode=2&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(3)%></a></td>
			<td class=<%=style %> style="text-align:right;" ><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsou_rpt.jsp?testCode=1&dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(4)%></a></td>
			<%  t1=rs2.getInt(3)+rs2.getInt(4);
			tt1=rs2.getInt(3)+rs2.getInt(4);%>		
			<td class=<%=style %> style="text-align:right;"><%=tt1%></td>
			
			<td class=<%=style %> style="text-align:right;"><a href="#" onclick="viewWorks('rws_wq_lab_drill_totsou_rpt.jsp?dcode=<%=rs1.getString(2)%>&dname=<%=rs1.getString(4)%>&labCode=<%=rs1.getString(1)%>&labname=<%=rs1.getString(5)%>')"><%=rs2.getString(9)%></a></td>
			
			<% coverage=(t1/3600)*100;
			////System.out.println("t2::"+coverage);%>
			<td class=<%=style %>  style="text-align:right;"><%=ndf.format(coverage)%></td>
			
		
			
			</tr>
			<%/* }else{ */%>
			<%-- <tr>
			<td class=<%=style %> style="text-align:center;"><%=sno++%></td>
			<td class="gridhdbg" align="left"><%=rs1.getString(4)%></td>
			<td class="gridhdbg" nowrap align="left"><%=rs1.getString(3)%></td>
			<td class=<%=style %> nowrap style="text-align:center;">3600</td>
			<td class=<%=style %>  style="text-align:right;"><%=rs2.getString(1)%></td>
			<td class=<%=style %> style="text-align:right;" ><%=rs2.getString(2)%></td>
			<%  t1=rs2.getInt(1)+rs2.getInt(2);
			tt1=rs2.getInt(1)+rs2.getInt(2);%>
			<td class=<%=style %> style="text-align:right;"><%=tt1%></td>
			<% coverage=(t1/3600)*100;
			%>
			<td class=<%=style %>  style="text-align:right;"><%=ndf.format(coverage)%></td>
			
			</tr> --%>
			<%/* }	
			if(year1==Integer.parseInt(compYear))
			{ */
			pb+=Integer.parseInt(rs2.getString(5));
			pc+=Integer.parseInt(rs2.getString(6));
			pt+=t2;
			
			ptot+=Integer.parseInt(rs2.getString(8));
			
			mb+=Integer.parseInt(rs2.getString(1));
			mc+=Integer.parseInt(rs2.getString(2));
			mt+=t;
			
			mtot+=Integer.parseInt(rs2.getString(7));
			
			umb+=Integer.parseInt(rs2.getString(3));
			umc+=Integer.parseInt(rs2.getString(4));
			umt+=t1;
			
			umtot+=Integer.parseInt(rs2.getString(9));
			
			
			
			/* }else
			{
            umb+=Integer.parseInt(rs2.getString(1));
			umc+=Integer.parseInt(rs2.getString(2));
			umt+=t1;
			
			} */
			}}


    

gt=umt*100/targetSum;

	
			/* if(request.getParameter("district")!=null  && !ye.equals("") && year1==Integer.parseInt(compYear))
			{ */%>
                         <tr>
						<td class="gridhdbg" colspan="3" style="text-align:right;" >Total : </td>
						<td class="gridhdbg"  style="text-align:right;"></td>
						<td class="gridhdbg"  style="text-align:right;"><%=pb%></td>
						<td class="gridhdbg"  style="text-align:right;"><%=pc%></td>
						<td class="gridhdbg" style="text-align:right;"><%=pt%></td>
						
						
						<td class="gridhdbg" style="text-align:right;"><%=ptot%></td>
						
						
						 
						<td class="gridhdbg"  style="text-align:right;"><%=mb%></td>
						<td class="gridhdbg"  style="text-align:right;"><%=mc%></td>
						<td class="gridhdbg" style="text-align:right;"><%=mt%></td>
						
						<td class="gridhdbg" style="text-align:right;"><%=mtot%></td>
						
						<td class="gridhdbg" style="text-align:right;"><%=umb%></td>
						<td class="gridhdbg" style="text-align:right;"><%=umc%></td>
						<td class="gridhdbg" style="text-align:right;"><%=umt%></td>
						
						<td class="gridhdbg" style="text-align:right;"><%=umtot%></td>
						
						
					<td class="gridhdbg" style="text-align:right;"><%=ndf.format(gt)%></td>
						</tr>
					<%/* }else
					 { */%>
					 <%-- <tr>
						<td class="gridhdbg" colspan="3" style="text-align:right;" >Total : </td>
						<td class="gridhdbg"  style="text-align:right;"></td>
						<td class="gridhdbg" style="text-align:right;"><%=umb%></td>
						<td class="gridhdbg" style="text-align:right;"><%=umc%></td>
						<td class="gridhdbg" style="text-align:right;"><%=umt%></td>
						
						<td class="gridhdbg" style="text-align:right;"><%=ndf.format(gt)%></td>
						</tr>  --%>
						<%//}
			}%>

	</table>
	
	<input type="hidden" name="mode">
	<input type="hidden" name="dname">
	</form>
	</body>

<%@ include file = "footer.jsp" %>
</html>