<%@ include file = "conn3.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html>
<head>
 <script>
   window.history.forward(1);
 </script>
</head>
<%

	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st41=null;
	Statement st11=null,st22=null;
	ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs41=null;
	ResultSetMetaData rsm=null;
	String query1=null,query2=null,query3=null,query4=null,query5=null,query6=null;	
		
%>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border="1">

<tr>
	<td align="center" colspan="45"> List of Ongoing(Spill+New) and Completed </td>	
</tr>
<tr align="center">
	<td class="btext" rowspan="2">S.No.</td>
    <td class="btext"  rowspan="2">Work Id</td>
    <td  class="btext" rowspan="2">Work Name</td>
     <td  class="btext" rowspan="2">District</td>
    <td  class="btext" rowspan="2">Division</td>
        <td  class="btext" rowspan="2">Sub Division</td>
    <td class="btext"  rowspan="2">Programme</td>
    <td class="btext"  rowspan="2" >Sub Programme</td>
    <td  class="btext" rowspan="2">Sanctioned Year</td>
    <td  class="btext" rowspan="2">Scheme Approved Under<BR>(Normal Coverage/Submission)<BR>(Water Quality/Sustainability)</td>
    <td  class="btext" rowspan="2">Type Of Scheme<BR>(Work Type)(CPWS/PWS/Aug<BR>Extn/HP/Tubewell)</td>
    <td  class="btext" rowspan="2" align="center">Source Type Category(Ground/Surface/Rain<BR>/Traditional/Others)</td>
    <td  class="btext" colspan="5">Type of Source</td>
    <td  class="btext" rowspan="2">Location</td>
        <td  class="btext" rowspan="2">Est. Cost(Lakhs)</td>
    <td  class="btext" rowspan="2">Rev.Est.Cost(Lakhs)</td>
    <td  class="btext" rowspan="2">GOI Share(Lakhs)</td>
    <td  class="btext" rowspan="2">State/Other Share(Lakhs)</td>
    <td  class="btext" rowspan="2">Community Contribution <br>Deposited(Lakhs)</td>
    <td  class="btext" rowspan="2" align="right">Administrative Sanction<BR>Date(dd/mmm/yyyy)</td>
    <td  class="btext" rowspan="2">Grounded Date </td>
    <td  class="btext" colspan="2">Expenditure</td>
    <td  class="btext" rowspan="2">Physical Stage<BR>(Completed/Progress)</td>
    <td  class="btext" rowspan="2">Target Date of completion<BR>as per agreement</td>
    <td  class="btext" rowspan="2">Target Date of completion<BR>as per action plan</td>
    <td  class="btext" rowspan="2">Date Of Completion</td>
    <td  class="btext" rowspan="2">Implementing Agency<BR>(RWS/P&RD Dept./Zilla Parishid<BR>/GP/Others)</td>
    <td  class="btext" rowspan="2">Is This Scheme<BR>in School(Yes/No)</td>
    <td  class="btext" rowspan="2">If Yes<BR>School Name</td>
    <td  class="btext" rowspan="2">Habitation Status<BR>After Completion of the scheme</td>
    <td  class="btext" rowspan="2">Remarks</td>
    <td  class="btext" rowspan="2">No Of Habs</td>
    <td  class="btext" colspan="8">Habitation Details</td>
    
    
  </tr>
  <tr align="center">

    <td  class="btext">Ground Water<BR>Openwell/Deep Tubewell/Shallow Tubewell/Infilitration Gallery/Infilitration well</td>
    <td  class="btext">Surface Water<BR>Pond/River/Lake/Stream<BR>/Canal/Spring/Treated Surface water</td>
    <td  class="btext">Rain Water<BR>Roof top structure/<BR>Ground collection</td>
    <td  class="btext">Traditional<BR>Khadins/Nadis<BR>	/Tankas/Ponds</td>
    <td  class="btext">Others<BR>Non Conventional methods<BR>/Filter points</td>
    <td class="btext" >Upto 31.3.08</td>
    <td class="btext" >During the Year<BR>Upto Oct.08</td>
    <td  class="btext">Constituency</td>
    <td class="btext" >Mandal</td>
    <td class="btext" >Village</td>
    <td class="btext" >GP</td>
    <td class="btext" >Habitation Name </td>
    <td class="btext" >Habitation Code </td>
    <td class="btext" >Existing Status </td>
    <td class="btext" >Pop Covered </td>
  </tr>
  <tr>
<td align="center" class="rptValue">1</td>
<td align="center" class="rptValue">2</td>
<td align="center" class="rptValue">3</td>
<td align="center" class="rptValue">4</td>
<td align="center" class="rptValue">5</td>
<td align="center" class="rptValue">6</td>
<td align="center" class="rptValue">7</td>
<td align="center" class="rptValue">8</td>
<td align="center" class="rptValue">9</td>
<td align="center" class="rptValue">10</td>
<td align="center" class="rptValue">11</td>
<td align="center" class="rptValue">12</td>
<td align="center" class="rptValue">13</td>
<td align="center" class="rptValue">14</td>
<td align="center" class="rptValue">15</td>
<td align="center" class="rptValue">16</td>
<td align="center" class="rptValue">17</td>
<td align="center" class="rptValue">18</td>
<td align="center" class="rptValue">19</td>
<td align="center" class="rptValue">20</td>
<td align="center" class="rptValue">21</td>
<td align="center" class="rptValue">22</td>
<td align="center" class="rptValue">23</td>
<td align="center" class="rptValue">24</td>
<td align="center" class="rptValue">25</td>
<td align="center" class="rptValue">26</td>
<td align="center" class="rptValue">27</td>
<td align="center" class="rptValue">28</td>
<td align="center" class="rptValue">29</td>
<td align="center" class="rptValue">30</td>
<td align="center" class="rptValue">31</td>
<td align="center" class="rptValue">32</td>
<td align="center" class="rptValue">33</td>
<td align="center" class="rptValue">34</td>
<td align="center" class="rptValue">35</td>
<td align="center" class="rptValue">36</td>
<td align="center" class="rptValue">37</td>
<td align="center" class="rptValue">38</td>
<td align="center" class="rptValue">39</td>
<td align="center" class="rptValue">40</td>
<td align="center" class="rptValue">41</td>
<td align="center" class="rptValue">42</td>
<td align="center" class="rptValue">43</td>
<td align="center" class="rptValue">44</td>
<td align="center" class="rptValue">45</td>
</tr>
<% 
String district = (String)session.getAttribute("district");
String schemes = (String)session.getAttribute("scheme");
try
{
int slno = 1;
  st2 = conn.createStatement();
    query1 = "select w.work_id,w.office_code,w.work_name,to_char(w.admin_date,'dd/MON/yyyy') as admin_date,to_char(w.admin_date,'dd/mm/yyyy') as admin_year,w.no_of_habs from rws_work_admn_tbl w where  category_code = '"+schemes+"' and length(office_code)>='4' and substr(work_id,5,2)='"+district+"' and substr(work_id,1,2) in (select programme_code from rws_programme_tbl)"; 

  rs2=st2.executeQuery(query1);
  String q1="",q2="",q3="",q4="",q5="",q6="",q7="",q8="";
  try{
  while(rs2.next())
  {
  	String dates = rs2.getString(5);
  	String finalSancYear="";
  	int da = Integer.parseInt(dates.substring(3,5));
  	int ye = Integer.parseInt(dates.substring(6,10));
  	if(da<=03)finalSancYear = ye-1+"-"+ye;
  	else finalSancYear = ye+"-"+(ye+1);
	q2 = "select hab_code from rws_admn_hab_lnk_tbl where work_id='"+rs2.getString(1)+"'";
	//System.out.println("q2 query:"+q2);
	st4 = conn1.createStatement();
	rs4 = st4.executeQuery(q2);
	//System.out.println("rs2.getString(1)"+rs2.getString(1));
	//System.out.println("rs2.getString(1).substring(0,2)"+rs2.getString(1).substring(0,2));
	String loop ="";
	
	if(rs2.getString(2).length() <= 4)
	{
		loop = "1";
		q1 = "select distinct d.dname,div.division_office_name,p.programme_name, sp.subprogramme_name,ass.TYPE_OF_ASSET_NAME  from rws_district_tbl d,rws_division_office_tbl div,rws_programme_tbl p,rws_subprogramme_tbl sp,RWS_ASSET_type_TBL ass  where d.dcode='"+rs2.getString(1).substring(4,6)+"' and div.division_office_code='"+rs2.getString(2).substring(3,4)+"' and  p.programme_code='"+rs2.getString(1).substring(0,2)+"' and sp.subprogramme_code='"+rs2.getString(1).substring(2,4)+"' and div.circle_office_code=d.dcode and sp.programme_code=p.programme_code and ass.TYPE_OF_ASSET_CODE='"+rs2.getString(1).substring(6,8)+"'";
		
	}
	else if(rs2.getString(2).substring(4,6).equals("00")  )
	{
		loop = "1";
		q1 = "select distinct d.dname,div.division_office_name,p.programme_name, sp.subprogramme_name,ass.TYPE_OF_ASSET_NAME  from rws_district_tbl d,rws_division_office_tbl div,rws_programme_tbl p,rws_subprogramme_tbl sp,RWS_ASSET_type_TBL ass  where d.dcode='"+rs2.getString(1).substring(4,6)+"' and div.division_office_code='"+rs2.getString(2).substring(3,4)+"' and  p.programme_code='"+rs2.getString(1).substring(0,2)+"' and sp.subprogramme_code='"+rs2.getString(1).substring(2,4)+"' and div.circle_office_code=d.dcode and sp.programme_code=p.programme_code and ass.TYPE_OF_ASSET_CODE='"+rs2.getString(1).substring(6,8)+"'";
	}
	else
	{
		loop = "2";
		q1 = "select distinct d.dname,div.division_office_name,sdiv.subdivision_office_name,p.programme_name, sp.subprogramme_name,ass.TYPE_OF_ASSET_NAME  from rws_district_tbl d,rws_division_office_tbl div,rws_subdivision_office_tbl sdiv,rws_programme_tbl p,rws_subprogramme_tbl sp,RWS_ASSET_type_TBL ass  where d.dcode='"+rs2.getString(1).substring(4,6)+"' and div.division_office_code='"+rs2.getString(2).substring(3,4)+"' and sdiv.subdivision_office_code='"+rs2.getString(2).substring(4,6)+"' and p.programme_code='"+rs2.getString(1).substring(0,2)+"' and sp.subprogramme_code='"+rs2.getString(1).substring(2,4)+"' and sdiv.division_office_code=div.division_office_code and sdiv.circle_office_code=d.dcode and div.circle_office_code=d.dcode and sp.programme_code=p.programme_code and ass.TYPE_OF_ASSET_CODE='"+rs2.getString(1).substring(6,8)+"'";
	}
	//System.out.println("Query11:"+q1);

		String sdiv = "",prog="",subprog="",dist="",div="",scheme="";
	try{
	st3 = conn1.createStatement();
	rs3 = st3.executeQuery(q1);
	if(rs3.next()){
	dist = rs3.getString(1);
	div = rs3.getString(2);
	if(loop.equals("2"))
	{
		scheme = rs3.getString(6);
		sdiv=rs3.getString(3); 
		prog= rs3.getString(4);
		subprog = rs3.getString(5);
	}
	else
	{
		 scheme = rs3.getString(5);
		 sdiv = "&nbsp;";
		 prog= rs3.getString(3);
		 subprog = rs3.getString(4);
	}
	}
	}catch(Exception e){}finally{rs3.close();st3.close();}
%>
<tr bgcolor="#edf2f8">
	<td  class="rptValue" ><%=slno++%></td>
	<td class="rptValue">&nbsp;<%=rs2.getString(1)%></td>
	<td class="rptValue">&nbsp;<%=rs2.getString(3)%></td>
	<td class="rptValue"><%=dist%></td>
	<td class="rptValue"><%=div%></td>
	<td class="rptValue"><%=sdiv%></td>
	<td class="rptValue"><%=prog%></td>
	<td class="rptValue"><%=subprog%></td>
	<td class="rptValue" align="right"><%=finalSancYear%></td>	
	<td class="rptValue">&nbsp;</td>
	<td class="rptValue"><%=scheme %></td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
		

<%
	q4 = "select nvl(e.TS_amount,'0.0') from rws_new_est_tbl e where e.work_id='"+rs2.getString(1)+"'";
	q5 = "select nvl(r.REV_SANCTIONED_AMOUNT,'0.0') from RWS_NEW_REVISED_EST_TBL r where r.work_id='"+rs2.getString(1)+"'";
	//System.out.println("q4 query:"+q4);
	try{
	st6 = conn1.createStatement();
	rs6 = st6.executeQuery(q4);
	if(rs6.isBeforeFirst()){
	if(rs6.next()){
	%>
	<td class="rptValue"><%=rs6.getDouble(1)%></td>
	<%}
	}
	else
	{
	%>
	<td class="rptValue">0.0</td>
	<%}
	}catch(Exception e){}finally{rs6.close();st6.close();}
	try{
	st10 =  conn1.createStatement();
	rs10 = st10.executeQuery(q5);

	
	if(rs10.isBeforeFirst()){
	if(rs10.next()){
	%>
	<td class="rptValue"><%=rs10.getDouble(1)%></td>
	<%}
	}
	else
	{
	%>
	<td class="rptValue">0.0</td>
	<%}
	}catch(Exception e){}finally{rs10.close();st10.close();}
%>	
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td class="rptValue"><%=rs2.getString(4)%></td><%
	String agdate="&nbsp;",tardate="&nbsp;",grounddate="&nbsp;";
	String q41 = "select nvl(to_char(c.grounding_DATE,'dd/mm/yyyy'),' - '),nvl(to_char (con.AGREEMENT_DATE,'dd/mm/yyyy'),' - '),nvl(to_char (con.date_of_completion,'dd/mm/yyyy'),' - ') from rws_contractor_selection_tbl con,rws_work_commencement_tbl c where con.work_id=c.work_id and con.work_id='"+rs2.getString(1)+"'";
	//Debug.println("q41 query:"+q41);
	try{
	st41 = conn1.createStatement();
	rs41 = st41.executeQuery(q41);
	
	if(rs41.next()){agdate=rs41.getString(2);tardate=rs41.getString(3);grounddate=rs41.getString(1);}
	}catch(Exception e){}finally{rs41.close();st41.close();}
	%>
	<td class="rptValue"><%=grounddate%></td>
	<%
	q5 = "select nvl(sum(expenditure_upto),'0.0') from rws_work_expenditure_tbl where year <> '2007- 2008' and work_id='"+rs2.getString(1)+"' and work_id not in(select work_id from rws_work_completion_tbl)";
	//Debug.println("q5 query:"+q5);
	try{
	st7 = conn1.createStatement();
	rs7 = st7.executeQuery(q5);
	if(rs7.next()){
	%>
	<td class="rptValue"><%=rs7.getDouble(1)%></td>
	<%}}catch(Exception e){}finally{rs7.close();st7.close();}
	q6 = "select nvl(sum(expenditure_during),'0.0') from rws_work_expenditure_tbl where year = '2007- 2008' and work_id='"+rs2.getString(1)+"' and work_id not in(select work_id from rws_work_completion_tbl)";
	//Debug.println("q6 query:"+q6);
	try{
	st8 = conn1.createStatement();
	rs8 = st8.executeQuery(q6);
	if(rs8.next()){
	%>
	<td class="rptValue"><%=rs8.getDouble(1)%></td>
	<%
	}}catch(Exception e){}finally{rs8.close();st8.close();}
	q7 = "select nvl(to_char(date_of_completion,'dd/mm/yyyy'),'   -   ')  from rws_work_completion_tbl where work_id='"+rs2.getString(1)+"'";
	//Debug.println("q7 query:"+q7);
		String stat = "",doc="&nbsp;";
	try{
	st9 = conn1.createStatement();
	rs9 = st9.executeQuery(q7);

	if(rs9.next()) {stat = "Completed";doc=rs9.getString(1);} else stat = "Progress";
	}catch(Exception e){}finally{rs9.close();st9.close();}
	%>
	<td class="rptValue"><%=stat%></td>
	<td class="rptValue"><%=tardate%>
	<td class="rptValue">&nbsp;</td>
	<td class="rptValue"><%=doc%></td>
	
	<td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td class="rptValue"><%=rs2.getString(6)%></td>
	 
<%	
//System.out.println("enter into rs4");
try{
while(rs4.next()){

q3 = "select distinct d.dname,m.mname,v.vname,p.pname,h.panch_name,h.panch_code,hd.coverage_status,sum (CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+FLOAT_POP) as a,con.constituency_name from rws_mandal_tbl m,rws_village_tbl v,rws_panchayat_tbl p,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_constituency_tbl con where hd.hab_code=h.panch_code and M.DCODE=D.DCODE AND P.DCODE=M.DCODE AND P.MCODE=M.MCODE AND V.DCODE=P.DCODE AND V.MCODE=P.MCODE AND V.PCODE=P.PCODE AND SUBSTR (h.PANCH_CODE,1,2)=D.DCODE AND SUBSTR (h.PANCH_CODE,6,2)=M.MCODE AND SUBSTR(h.PANCH_CODE,13,2)=P.PCODE AND SUBSTR (h.PANCH_CODE,8,3)=V.VCODE and hd.coverage_status is not null and hd.coverage_status <>'UI' and h.panch_code='"+rs4.getString(1)+"' and con.dcode= d.dcode and con.constituency_code=substr(h.panch_code,3,3)  group by d.dname,m.mname,v.vname,p.pname,h.panch_name,h.panch_code,hd.coverage_status,con.constituency_name";

//	System.out.println("q32 query:"+q3);
try{
	st5 = conn1.createStatement();
	rs5 = st5.executeQuery(q3);
	if(rs5.isBeforeFirst()){
	if(rs5.next()){
 %>

 	
	<td class="rptValue"><%=rs5.getString(9)%></td>
	<td class="rptValue"><%=rs5.getString(2)%></td>
	<td class="rptValue"><%=rs5.getString(3)%></td>
	<td class="rptValue"><%=rs5.getString(4)%></td>
	<td class="rptValue"><%=rs5.getString(5)%></td>
	<td class="rptValue">&nbsp;<%=rs5.getString(6)%></td>
	<td class="rptValue"><%=rs5.getString(7)%></td>
	<td class="rptValue"><%=rs5.getInt(8)%></td>
	 <tr bgcolor="#edf2f8">
	 <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
 	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
 	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td>
	
	<%
	}
	}
	}catch(Exception e){}finally{rs5.close();st5.close();}
	}
	}catch(Exception e){}finally{rs4.close();st4.close();}
	%>
	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
	<td>&nbsp;</td><td>&nbsp;</td>
	<%
	//System.out.println("Record Printed with S NO:"+slno);
	} 
	}
	catch(Exception e)
   	{
   		try{
   		}
   		catch(Exception ee){System.out.println("error in closing resources:"+ee.getMessage());}
   		if(conn1!=null)try{conn1.close();}catch(Exception eee){System.out.println("error:"+eee.getMessage());}
   		if(conn1==null)System.out.println("Conn");else System.out.println("No");
  	    conn1=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
   		System.out.println("Exception "+e);
   	}
	 
  }catch(Exception e)
   {
     conn.close();
  	 conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
  	 System.out.println("Exception1 "+e);
  	 
   }
   finally
   {
   	rs2.close();
   	st2.close();
   }
   %>
   <tr>
   <td colspan="45">
   Note: 1. Please Donot add any columns in between.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		 2. Please follow date format(dd/mmm/yyyy).<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		3. Amount should be in lakhs.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		4. The schemes(works) shall be furnished including sanctions at district level.<BR>
		</td>
     </tr>
     </table>
   <%
  
%>