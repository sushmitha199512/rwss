<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
	DecimalFormat ndf = new DecimalFormat("####.00");
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    int nextYear = Integer.parseInt(currentYear);
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;
     float gepreyrdrsub1=0,geprevdrsub1=0;
	int slno = 0,total=0;

	 
	 String rDistrict="";
	
	rDistrict = request.getParameter("district");
	if(rDistrict!=null)
	{
      session.setAttribute("rDistrict",rDistrict);
	}
    System.out.println("rDistrict"+rDistrict);
	String  pyear = request.getParameter("year");
	if(pyear!=null)
	{session.setAttribute("pyear",pyear);
	}
	String  dname = request.getParameter("dname");
	if(dname!=null)
	{ session.setAttribute("dname",dname);
	}
    int p=Integer.parseInt(pyear);

    String wtype=request.getParameter("wrktype");
    session.setAttribute("wtype",wtype);
    String work_name="";
    System.out.println("My wtype"+wtype);
    if(wtype.equals("1"))
     {
       work_name="PROJECTS";
     }
    else if(wtype.equals("2"))
     {
       work_name="NORMAL";
     }
   else if(wtype.equals("3"))
     {
       work_name="DISTRICT LEVEL";
     }
 session.setAttribute("work_name",work_name);
 
 
 String pname="";
if(request.getParameter("pname")!=null)
{
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}


String[] programes=request.getParameterValues("program");
String programe="";
for(int i=0;i<programes.length;i++)
{
programe += programes[i]+",";
}
System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);

Statement st1=conn.createStatement();

ResultSet r1=st1.executeQuery("select programme_name from rws_programme_tbl where programme_code  in("+programe+")");   
while(r1.next())
{
		pname=pname+r1.getString(1)+",";				
}

System.out.println("Programe name"+pname);
if(pname!=null)
{ session.setAttribute("pname",pname);
}





%>
<html>
    <head>
        <!-- <script type="text/javascript" src="/pred/resources/javascript/jquery-1.10.2.min.js"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
        <script type="text/javascript" src="/pred/resources/javascript/jquery-3.6.0.min.js"></script>
        <script type="text/javascript" src="/pred/resources/javascript/jquery.tablesorter.min.js"></script>        
        <style type="text/css">
             #keywords thead tr th span { 
                padding-right: 20px;
                background-repeat: no-repeat;
                background-position: 100% 100%;
              }
             #keywords thead tr th.headerSortUp span {
                background-image: url('/pred/resources/javascript/images/up-arrow.png') !important;
              }
/*              #keywords thead tr th.headerSortUp, #keywords thead tr th.headerSortDown {
                 background-color: #000000 !important;
              }
              #keywords thead tr th.headerSortUp span, #keywords thead tr th.headerSortDown span {
                 color: #FFFFFF !important;
              }*/
              #keywords thead tr th.headerSortDown span {
                background-image: url('/pred/resources/javascript/images/down-arrow.png') !important;
              }
        </style>
    </head>
<BODY>
<form name=f1 method="post">
	<p align="center">
	<font face=verdana size=2><b>Pending Works Monitoring Report For <%=work_name%> Works </b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%></font>&nbsp; </p>
<font color="blue" face=verdana size=2><b>Programmes:</b></font><font color="black" face=verdana size=2><%=pname.substring(0,pname.length()-1)%></font>&nbsp; </p>
<div id="wrapper">
<table>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		 <tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;</td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;</td>
				<td class="bwborder"><a href="./rws_Pending_works_list_xls.jsp" target="_new">Excel</a></td>
				 
			</tr>
		</table>
	</caption>
</table>
    <table id="keywords"  border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
                    <thead>
                            <tr align=center  align=center>
                                <th class="btext" rowspan = 2><span>Sl.No</span></th>
		<th class="btext" rowspan = 2><span>District</span></th>
		<th class="btext" rowspan = 2><span>Mandal</span></th>
		<th class="btext" rowspan = 2><span>Work ID</span></th>
		<th class="btext" rowspan = 2><span>Work Name</span></th>
		<th class="btext" rowspan = 2><span>Program</span></th>
		
                <th class="btext" rowspan = 2><span>Sub Program</span></th>
		<th class="btext" align="center"><span>Admin Number</span></th>
                <th class="btext" align="center"><span>Admin Date(yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>Admin Est.Cost(In Lakhs)</span></th>
		<th class="btext" align="center"><span>Tech Number</span></th>
                <th class="btext" align="center"><span>TechDate (yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>TechAmount(In Lakhs)</span></th>
		<th class="btext" align="center"><span>Source Name</span></th>
<!--		<th colspan=5 class="gridhdbg" align="center"><span>Contractor Management</span></th>-->
                <th class="btext" align="center"><span>Contractor Name</span></th>
                <th class="btext" align="center"><span>Agreement No</span></th>
                <th class="btext" align="center"><span>Agreement Duration<br>(in months)</span></th>
                <th class="btext" align="center"><span>Agreement Date<br>(yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>SiteHand OverDate(yyyy-mm-dd)</span></th>
                
		<th colspan=1 class="btext" align="center"><span>Programme Schedule</span></th>
		<th colspan=1 class="btext" align="center"><span>Work Expenditure</span></th>				
<!--		<th class="gridhdbg" align="center"><span>Work Completion</span></th>	-->
                <th class="btext" align="center"><span>Stipulated<br>Date Of<br>Completion<br>(yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>ActualDateOf Completion(yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>Date Of <br>Commissioning(yyyy-mm-dd)</span></th>
                <th class="btext" align="center"><span>Habitations<br>Sanctioned</span></th>
                <th class="btext" align="center"><span>Habitations<br>Benefited</span></th>
                <th class="btext" align="center"><span>Physical Stage <br>/Remarks</span></th>
                
                
<!--                
                                                                        <th class="gridhdbg"><span>Admin Number</span></th>
				<th class="gridhdbg"><span>AdminDate(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>Admin Est.Cost(In Lakhs)</span></th>
				<th class="gridhdbg"><span>Tech.Number</span></th>
				<th class="gridhdbg"><span>TechDate (yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>TechAmount(In Lakhs)</span></th>
				<th class="gridhdbg"><span>Source Name</span></th>
				<th class="gridhdbg"><span>Source Code</span></th>
				<th class="gridhdbg"><span>Contractor Name</span></th>
				<th class="gridhdbg"><span>Agreement No</span></th>
				<th class="gridhdbg"><span>Agreement Duration<br>(in months)</span></th>
				<th class="gridhdbg"><span>Agreement Date<br>(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>SiteHand OverDate(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>Grounding Date <br>(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>Total Exp.(In Lakh)</span></th>
				<th class="gridhdbg"><span>Stipulated<br>Date Of<br>Completion<br>(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>ActualDateOf Completion(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>Date Of <br>Commissioning(yyyy-mm-dd)</span></th>
				<th class="gridhdbg"><span>Habitations<br>Sanctioned</span></th>
				<th class="gridhdbg"><span>Habitations<br>Benefited</span></th>
				<th class="gridhdbg"><span>Physical Stage <br>/Remarks</span></th>
                
                -->
                
                
                
                            </tr>
<!--                    
                            <tr>
			<td colspan=1 class=btext align="center"><span>Number</span></td>
			<td colspan=1 class=btext align="center"><span>Date</span></td>
			<td colspan=1 class=btext align="center"><span>Est. Cost<br>(In Lakhs)</span></td>
			<td colspan=1 class=btext align="center"><span>Number</span></td>
			<td colspan=1 class=btext align="center"><span>Date</span></td>
			<td colspan=1 class=btext align="center"><span>Amount<br>(In Lakhs)</span></td>
			<td colspan=1 class=btext align="center"><span>Source Name</span></td>
			<td colspan=1 class=btext align="center"><span>Contractor Name</span></td>
			<td colspan=1 class=btext align="center"><span>Agreement No</span></td>
			<td colspan=1 class=btext align="center"><span>Agreement Duration<br>(in months)</span></td>
			<td colspan=1 class=btext align="center"><span>Agreement Date</span></td>
			<td colspan=1 class=btext align="center"><span>Site Hand <BR> Over Date</span></td>
			<td colspan=1 class=btext align="center"><span>Grounding Date</span></td>
			<td colspan=1 class=btext align="center"><span>Total Exp.(In Lakh)</span></td>
			<td colspan=1 class=btext align="center"><span>Stipulated<br>Date Of<br>Completion</span></td>
			<td colspan=1 class=btext align="center"><span>Actual Date<br>Of Completion</span></td>
			<td colspan=1 class=btext align="center"><span>Date Of <br>Commissioning</span></td>
			<td colspan=1 class=btext align="center"><span>Habitations<br>Sanctioned</span></td>
			<td colspan=1 class=btext align="center"><span>Habitations<br>Benefited</span></td>
			<td colspan=1 class=btext align="center"><span>Physical Stage <br>/ Remarks</span></td>

                                </tr>-->
                        </thead>
                    <tbody>
	<%
      String view1="";
	    ResultSet rs1 = null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,totalrs=null;
		ResultSet rs2 = null,prevrs=null,san=null;
		Statement stmt1 = null,prev=null,sss=null,stmtv1=null;
        Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null;
		PreparedStatement pstmt = null;
	   	String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="",qry8="",qry9="",qry10="";

	try
	{
    

    qry1 = "select distinct a.work_id,b.programme_code,c.subprogramme_code,nvl(work_id,'-'),nvl(WORK_NAME,'-') ,b.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_subprogramme_tbl c where  substr(a.work_id,1,2)=b.programme_code and b.programme_code=c.programme_code and a.category_code='"+wtype+"' and work_cancel_dt is null and  a.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and a.programme_code in ("+programe+")";
   	if(rDistrict!=null && !rDistrict.equals("00"))
     {
   	    qry1+=" and substr(work_id,5,2)='"+rDistrict+"'";
     }
        qry1+=" order by substr(a.work_id,1,2)";
    
    stmt1 = conn.createStatement();
	System.out.println("@@@@@@@@@@@@@@@@qry1:"+qry1);
	rs1=stmt1.executeQuery(qry1);
	Hashtable List1=new Hashtable();
	while(rs1.next())
	{
		List1.put(rs1.getString(1)+rs1.getString(2)+rs1.getString(3),rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
    
   qry2 = "select  prg.work_id,nvl(prg.ADMIN_NO,'0'),nvl(to_char(prg.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(prg.SANCTION_AMOUNT,'0') from rws_work_admn_tbl prg where prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
   if(rDistrict!=null && !rDistrict.equals("00"))
   {
	   qry2+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
   }
   qry2+="order by substr(prg.work_id,1,2)";
   
   stmt2 = conn.createStatement();
  //System.out.println("qry2:"+qry2);
   rs2=stmt2.executeQuery(qry2);
   Hashtable List2=new Hashtable();
	while(rs2.next())
	{
		List2.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();


    qry3 = "select a.work_id,nvl(TS_NO,'0'),nvl(to_char(TS_DATE,'dd-mm-yyyy'),'-'),nvl(TS_AMOUNT,'0') from RWS_NEW_EST_TBL a ,rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
    if(rDistrict!=null && !rDistrict.equals("00"))
    {
 	   qry3+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
    }
    qry3+="order by substr(prg.work_id,1,2)";
    stmt3 = conn.createStatement();
    //System.out.println("qry3:"+qry3);
	rs3=stmt3.executeQuery(qry3);
    Hashtable List3=new Hashtable();
	while(rs3.next())
	{
     List3.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();


   qry4 = "select a.work_id,nvl(source_name,'-') from rws_source_iden_fin_tbl a,rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
   if(rDistrict!=null && !rDistrict.equals("00"))
   {
	   qry4+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
   }
   qry4+="order by substr(prg.work_id,1,2)";
   stmt4 = conn.createStatement();
   //System.out.println("qry4:"+qry4);
   rs4=stmt4.executeQuery(qry4);
   Hashtable List4=new Hashtable();
	while(rs4.next())
	{
           List4.put(rs4.getString(1),rs4.getString(2));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();

  qry5="select distinct con.work_id,nvl(ten.CONTRACTOR_NAME_COMPANY,'-'),nvl(AGREEMENT_REFERENCE_NO,'-'),nvl(AGREEMENT_DURATION,'0'),nvl(to_char (con.AGREEMENT_DATE ,'dd-mm-yyyy'),'-'),nvl(to_char (con.SITE_HAND_OVER_DATE,'dd-mm-yyyy'),'-'),nvl(to_char (con.DATE_OF_COMPLETION ,'dd-mm-yyyy'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_CONTRACTOR_TBL ten, rws_work_admn_tbl prg where  con.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+") and con.CONTRACTOR_CODE =ten.CONTRACTOR_CODE ";
  if(rDistrict!=null && !rDistrict.equals("00"))
  {
	   qry5+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
  }
 
  stmt5 = conn.createStatement();
  //System.out.println("qry5:"+qry5); 
  rs5=stmt5.executeQuery(qry5);
  Hashtable List5=new Hashtable();
	while(rs5.next())
	{
           List5.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3)+"@"+rs5.getString(4)+"@"+rs5.getString(5)+"@"+rs5.getString(6)+"@"+rs5.getString(7));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();

  qry6="select  a.work_id,nvl(to_char (GROUNDING_DATE,'dd-mm-yyyy'),'-') from RWS_WORK_COMMENCEMENT_TBL a, rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
  if(rDistrict!=null && !rDistrict.equals("00"))
  {
	   qry6+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
  }
  stmt6 = conn.createStatement();
  //System.out.println("qry6:"+qry6); 
  rs6=stmt6.executeQuery(qry6);
  Hashtable List6=new Hashtable();
	while(rs6.next())
	{
           List6.put(rs6.getString(1),rs6.getString(2));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();

    qry8 = "select distinct a.WORK_ID,nvl(a.remarks,'-'),NVL(TO_CHAR (a.DATE_OF_COMPLETION,'DD-MM-YYYY'),'-'),NVL(TO_CHAR(a.DATE_OF_COMM,'DD- MM-YYYY'),'-') from RWS_WORK_COMPLETION_TBL  a, rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
    if(rDistrict!=null && !rDistrict.equals("00"))
    {
  	   qry8+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
    }
    stmt8 = conn.createStatement();
    //System.out.println("qry8:"+qry8); 
	rs8=stmt8.executeQuery(qry8);
	
	Hashtable List8=new Hashtable();
	while(rs8.next())
	{
           List8.put(rs8.getString(1),rs8.getString(2)+"@"+rs8.getString(3)+"@"+rs8.getString(4));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
   

    qry9 = "select a.work_id,count(hab_code) from RWS_ADMN_HAB_LNK_TBl a,rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
    if(rDistrict!=null && !rDistrict.equals("00"))
    {
  	   qry9+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
    }
    qry9+="group by a.work_id";
    stmt9 = conn.createStatement();
    //System.out.println("qry9:"+qry9); 
	rs9 = stmt9.executeQuery(qry9);
	
	Hashtable List9=new Hashtable();
	while(rs9.next())
	{
           List9.put(rs9.getString(1),rs9.getString(2));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();


    qry10 = "select a.work_id,count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl prg where  a.work_id=prg.work_id and prg.category_code='"+wtype+"' and work_cancel_dt is null and  prg.work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and prg.programme_code in ("+programe+")";
    if(rDistrict!=null && !rDistrict.equals("00"))
    {
  	   qry10+="and substr(prg.work_id,5,2)='"+rDistrict+"'";
    }
    qry10+="group by a.work_id";

    stmt10 = conn.createStatement();
    //System.out.println("qry10:"+qry10); 
	rs10 = stmt10.executeQuery(qry10);
	
	Hashtable List10=new Hashtable();
	while(rs10.next())
	{
           List10.put(rs10.getString(1),rs10.getString(2));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();






       ///////////////////////////////////////////////////////////////////////////////////////////
    if(rDistrict!=null && rDistrict.equals("00"))
    {
     view1="SELECT distinct work_id,office_code,no_of_habs,d.dname,m.mname,w.programme_code,p.programme_name FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d ,rws_mandal_tbl m,rws_programme_tbl p where substr(work_id,5,2)=d.dcode  and  substr(LEAD_HABITATION,1,2)=m.dcode and substr(LEAD_HABITATION,6,2)=m.mcode and  w.programme_code=p.programme_Code and  w.category_code='"+wtype+"' and work_cancel_dt is null and  work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and w.programme_code in ("+programe+")  ORDER BY (CASE p.programme_name  WHEN 'NRDWP-COV'  THEN 1    WHEN 'APRWSP-WB'  THEN 2   WHEN 'STATE PLAN GRANT'  THEN 3    WHEN 'NABARD'  THEN 4     WHEN '13TH FC'  THEN 5    ELSE 100 END) ASC,d.dname,m.mname";
     //System.out.println("first");
    }
    else
    {
     view1="SELECT distinct work_id,office_code,no_of_habs,d.dname,m.mname,w.programme_code,p.programme_name  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d ,rws_mandal_tbl m,rws_programme_tbl p  where substr(work_id,5,2)=d.dcode  and  substr(LEAD_HABITATION,1,2)=m.dcode and substr(LEAD_HABITATION,6,2)=m.mcode and  w.programme_code=p.programme_Code and  w.category_code='"+wtype+"' and work_cancel_dt is null and  work_id in(select a.work_id from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl) and SYSDATE-grounding_date>365*"+p+") and substr(work_id,5,2)='"+rDistrict+"' and w.programme_code in ("+programe+")  ORDER BY (CASE p.programme_name  WHEN 'NRDWP-COV'  THEN 1    WHEN 'APRWSP-WB'  THEN 2   WHEN 'STATE PLAN GRANT'  THEN 3    WHEN 'NABARD'  THEN 4     WHEN '13TH FC'  THEN 5    ELSE 100 END) ASC,m.mname";
     //System.out.println("second");
    }
	stmtv1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	System.out.println(view1);
	totalrs = stmtv1.executeQuery(view1);
	if(totalrs.isBeforeFirst())
     { String remarks = "";
	   while(totalrs.next())
		{
		%>
               
                <tr>
		<%			
			 String value1=""+List1.get(totalrs.getString(1)+totalrs.getString(1).substring(0,2)+totalrs.getString(1).substring(2,4));
             String FList[]=value1.split("@");
             String value2=""+List2.get(totalrs.getString(1));
             String SList[]=value2.split("@");

             String value3=(String)List3.get(totalrs.getString(1));
             String tv1="",tv2="",tv3=""; 
             if(value3!=null)
	        {     
             String TList[]=value3.split("@");   
              tv1=TList[0];
              tv2=TList[1];
              tv3=TList[2];
            }
            else
			{
                 tv1="-";
                 tv2="-";
                 tv3="-"; 
			}

            String value4=(String)List4.get(totalrs.getString(1));
            String frv1=""; 
             if(value4!=null && !value4.equals(""))
	        {     
              String FrList[]=value4.split("@");   
              frv1=FrList[0];
            }
            else
            {
             frv1="-";
            }

            String value5=(String)List5.get(totalrs.getString(1));
            String fiv1="",fiv2="",fiv3="",fiv4="",fiv5="",fiv6=""; 
             if(value5!=null && !value5.equals(""))
	        {     
              String FiList[]=value5.split("@");   
              fiv1=FiList[0];
			  fiv2=FiList[1];
			  fiv3=FiList[2];
			  fiv4=FiList[3];
			  fiv5=FiList[4];
			  fiv6=FiList[5];

            }
            else
            {
             fiv1="-"; fiv2="-";
			 fiv3="-";
			 fiv4="-";
			 fiv5="-";
			 fiv6="-";
			 
            }

			String value6=(String)List6.get(totalrs.getString(1));
            String sv1=""; 
             if(value6!=null && !value6.equals(""))
	        {     
              String sList[]=value6.split("@");   
              sv1=sList[0];
            }
            else
            {
             sv1="-";
            }
  
            String value8=(String)List8.get(totalrs.getString(1));
            String Ev1="",Ev2="",Ev3=""; 
             if(value8!=null && !value8.equals(""))
	        {     
              String EList[]=value8.split("@");   
              Ev1=EList[0];
			  Ev2=EList[1];
			  Ev3=EList[2];
            }
            else
            {
              Ev1="-";
			  Ev2="-";
			  Ev3="-";
            }
           
           String value9=(String)List9.get(totalrs.getString(1));
            String Nv1=""; 
             if(value9!=null && !value9.equals(""))
	        {     
              String NList[]=value9.split("@");   
              Nv1=NList[0];
			 
            }
            else
            {
              Nv1="-";
			  
            }

           String value10=(String)List10.get(totalrs.getString(1));
            String Tev1=""; 
             if(value10!=null && !value10.equals(""))
	        {     
              String TeList[]=value10.split("@");   
              Tev1=TeList[0];
			 
            }
            else
            {
              Tev1="-";
			  
            }  

		  	%>
				<td class=rptValue ><%=++slno%></td>
				<td class=rptValue ><%=totalrs.getString(4)%></td>
				<td class=rptValue ><%=totalrs.getString(5)%></td>
				<td class=rptValue ><%=FList[0]%></td>
				<td class=rptValue ><%=FList[1]%></td>
				<td class=rptValue ><%=FList[2]%></td>
				<td class=rptValue ><%=FList[3]%></td>
	            <td class=rptValue ><%=SList[0]%></td>
				<td class=rptValue  nowrap><%=SList[1]%></td>
				<td class=rptValue ><%=SList[2]%></td>
                <td class=rptValue  nowrap><%=tv1%></td>
				<td class=rptValue  nowrap><%=tv2%></td>
				<td class=rptValue ><%=tv3%></td>
                <td class=rptValue ><%=frv1%></td>
				<td class=rptValue ><%=fiv1%></td>
				<td class=rptValue ><%=fiv2%></td>
				<td class=rptValue ><%=fiv3%></td>
				<td class=rptValue nowrap><%=fiv4%></td>
				<td class=rptValue nowrap ><%=fiv5%></td>
				<td class=rptValue nowrap ><%=sv1%></td>
             <%
		        qry7="SELECT distinct SUM(CASE WHEN E.EXPENDITURE_UPTO IS NOT NULL and e.year = '"+currentYearPeriod+"' THEN E.EXPENDITURE_UPTO  ELSE 0 END),SUM(CASE WHEN E.EXPENDITURE_DURING  IS NOT NULL and e.year = '"+currentMonth+"' and e.month = '"+currentMonth+"' THEN  E.EXPENDITURE_DURING  ELSE 0 END),SUM(CASE WHEN E1.EXPENDITURE_UPTO_THE_PRE_YEAR  IS NOT NULL  THEN  E1.EXPENDITURE_UPTO_THE_PRE_YEAR ELSE 0 END) FROM RWS_WORK_EXPENDITURE_TBL E,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL E1,RWS_WORK_ADMN_TBL W WHERE W.WORK_ID=E.WORK_ID AND W.WORK_ID=E1.WORK_ID AND E.WORK_ID=E1.WORK_ID AND W.PROGRAMME_CODE=E.PROGRAMME_CODE AND W.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.PROGRAMME_CODE=E1.PROGRAMME_CODE AND E.WORK_ID='"+totalrs.getString(1)+"'";
				double expupto1 = 0,expdur1 = 0,preyearexp1 = 0;
				WorksData1 workData = new WorksData1();	
	     		

			    String aa = "select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"+totalrs.getString(1)+"'";
                prev = conn.createStatement();
			    prevrs = prev.executeQuery(aa);
			    if(prevrs.next())
                {
                 preyearexp1=prevrs.getFloat(1);
                }

			    String bb = "select sum(total) from rws_exp_view where work_id='"+totalrs.getString(1)+"'";
				sss = conn.createStatement();
			    san = sss.executeQuery(bb);
			    if(san.next())
                {
                 preyearexp1 = 0;
                 expdur1=san.getFloat(1);
                }
			 gepreyrdrsub1+=workData.round(preyearexp1,2);
		  	 geprevdrsub1+=workData.round(expdur1,2);
		     stmt7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		     rs7=stmt7.executeQuery(qry7);
		     if(rs7.next())
			 {%>
			   <td class=rptValue align=center><%=ndf.format((workData.round((preyearexp1+expdur1),2)))%></td>	
			 <%
			 }
	     %>
                <td class=rptValue nowrap align="center"><%=fiv6%></td>
				<td class=rptValue nowrap align="center"><%=Ev2%></td>
                <td class=rptValue nowrap align="center"><%=Ev3%></td>
				<td class=rptValue nowrap align="center" title="Click to Get Sanctioned Habitation Details"><b><a href="javascript: void(0)"  onclick="window.open('work_list_report.jsp?hab=2&work_id=<%=totalrs.getString(1)%>',  'windowname1',  'width=500, height=550,scrollbars=yes,top=10'); return false;"><%=Nv1%></a></b></td>
                <td class=rptValue nowrap align="center" title="Click to Get Benefited Habitation Details"><b><a href="javascript: void(0)"   onclick="window.open('work_list_report.jsp?hab=1&work_id=<%=totalrs.getString(1)%>',  'windowname1',  'width=500, height=550,scrollbars=yes'); return false;"><%=Tev1%></a></b></td>      
                <td class=rptValue nowrap align="center"><%=Ev1%></td>
	   <%}
     %>
    </tr>
	<%}
	else
	{
		%>
		<script>
			var dnameee = '<%=dname%>';
			alert("There are no Works in "+dnameee+" Over "+<%=p%>+" Years of Pending");
			document.location.href="rws_Pending_works_rpt.jsp";
		</script>
		<%
	}
 }//try
catch(Exception e)
	{
			e.printStackTrace();
	}
 finally
{
	  try
	{
          
      totalrs.close();
      stmtv1.close();
      conn.close();


	}
	catch(Exception e)
	{
      e.printStackTrace();
	}
}
		%>
</tbody>	
</table>
</div>
<script type="text/javascript">
        $(function(){
          $('#keywords').tablesorter(); 
        });
        </script>
</BODY>
</html>

