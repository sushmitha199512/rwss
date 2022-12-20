<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file = "conn.jsp" %>
	<%
	try{
	Statement st1=null,st2 = null,st3=null,st4,st5,st6=null,st7,st8;
	ResultSet rs1 = null,rs2=null,rs3=null,rs4,rs5,rs6=null,rs7,rs8=null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt;
	RwsOffices rw=new RwsOffices(ds);
	String prgName,subprgName,aType,sentBy, sentTo,act_from,act_to,work_ID="",sentBy1, sentTo1;
	String query = null;
	String pid=request.getParameter("proposalId");
	 //System.out.println("pid  "+pid);
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	/*String Pid=request.getParameter("pid");
	// //System.out.println("proposal id is "+Pid);*/
	st1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	query="SELECT distinct wp.om_PROPOSAL_ID, wp.ESTIMATE_COST,  wp.ASSET_CODE, nvl(wp.NO_OF_HABS, '0'), to_char(wp.PREPARED_ON,'dd/mm/yyyy'), wp.prepared_by, wp.OFFICE_CODE, wp.FINANCIAL_YEAR, wp.SANCTIONED_AMOUNT, nvl(wp.ADMIN_NO,'--'), nvl(to_char(wp.ADMIN_DATE,'dd/mm/yyyy'),'--'), nvl(wp.GO_NO,'--'), decode(wp.STATE_CENTRAL,'S','State','C','Centre'), nvl(wp.ADMN_SANC_AUTH,'--'), nvl(wp.REMARKS,'--'), wp.FLAG, nvl(wp.WORK_ID,'--')FROM rws_om_proposal_tbl wp,  RWS_OFFICE_TBL o,rws_employee_tbl e where wp.om_PROPOSAL_ID='"+pid+"'   and o.office_code=wp.office_code order by wp.om_proposal_id";
rs = st1.executeQuery(query);

rs.last();
 Count=rs.getRow();
 //System.out.println("sadiq   "+Count);
rs.beforeFirst();
if(Count!=0){
rs.next();
// //System.out.println("sadiq");
String atcode=rs.getString(3);
String progcode=rs.getString(10);
String subprogcode=rs.getString(11);
// //System.out.println("atcode   "+atcode);
// //System.out.println("progcode   "+progcode);
// //System.out.println("subprgcode   "+subprogcode);

if(atcode!=null)
{	
	st3=conn.createStatement();
	String q1="SELECT ASSET_NAME  from RWS_ASSET_MAST_TBL  where ASSET_CODE='"+atcode+"'";
	rs3=st3.executeQuery(q1);
	rs3.next();
	aType=rs3.getString(1);
}
else
{
	aType="---";
	// //System.out.println("name is 3 "); 
}



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
<table align="center" width="100%">
	<tr>
	<td align="center" class="mystyle1"><font color="navy"><h5>O & M Proposal History</h3></font></td>
	</tr><tr><td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>

<style>


.mystyle
{
	border-width:1;
	color:#663300;
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

</style>

<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
		<td   nowrap class="mystyle"> Proposal Id</td>
		<td class="mystyle1"><%=rs.getString(1) %>   </td>
	
		<td  nowrap class="mystyle"> Asset Name </td>
		<td class="mystyle1"><%=aType %> </td>
		<td   class="mystyle">Estimated Cost (in Lakhs)</td> 
		<td  class="mystyle1" align=right><%=rs.getDouble(2)%> </td>
	</tr>

	<!-- <tr>
			<td   nowrap class="mystyle"> Work Id</td>
		<td class="mystyle1"><%=rs.getString(17) %>   </td>
		<td  nowrap class="mystyle" >Financial Year   </td>
		<td  class="mystyle1"><%=rs.getString(8)%> </td>
		<!-- <td  nowrap class="mystyle"> Sancationed Amount(in Lakhs) </td>
		<td colspan=3 class="mystyle1"><%= rs.getDouble(9) %> </td> 
		</tr> -->
		<tr>
	<td  nowrap class="mystyle">Prepared At </td>
	<td class="mystyle1"> <%=rw.getOfficeName(rs.getString(7),true) %>   </td>
	<td  nowrap class="mystyle">Prepared On </td>
	<td class="mystyle1"> <%=rs.getString(5)%>   </td>
	<td  nowrap class="mystyle">Prepared By</td>
	<td  class="mystyle1">  <%=rs.getString(6) %> </td>
	</tr>
	<tr>
		<td  nowrap class="mystyle" >Financial Year   </td>
		<td  class="mystyle1"><%=rs.getString(8)%> </td>
		<td  nowrap class="mystyle">No. of Habitations</td>
		<td colspan=5 class="mystyle1"><%= rs.getString(4)%>  </td>
	</tr>

	 </table>
	<%if(!rs.getString(4).equals("0"))
	{
		 
	 %>	
	<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr><td align="center" colspan=4  nowrap>Habitation Details </td></tr>
	<tr>
	<td  nowrap class="mystyle">Habitation Code </td>
	<td  nowrap class="mystyle">Habitation Name </td>
	<td  nowrap class="mystyle">Population </td>
	<td  nowrap class="mystyle">Status</td>
	</tr>
	<%
		st4=conn.createStatement();
		String q4="SELECT distinct  panch_code, panch_name, CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, coverage_status from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_om_proposal_tbl a, RWS_om_PROPOSAL_HAB_LNK_TBL ah, RWS_HABITATION_DIRECTORY_TBL h where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.om_proposal_id=ah.om_proposal_id and pr.panch_code=ah.hab_code  and  pr.panch_code=h.hab_code  and  a.om_proposal_id='"+pid+"'";

		rs4=st4.executeQuery(q4);
		while(rs4.next())
		{
			
	%>
	<tr>
	<td  class="mystyle1"><%=rs4.getString(1)%>  </td>
	<td  class="mystyle1"><%=rs4.getString(2)%>  </td>	
	<td  class="mystyle1"><%=rs4.getString(3)%>  </td>
	<td  class="mystyle1"><%=rs4.getString(4)%>  </td>
	</tr>
	<%}%>
	</table>
	<%}
		%>

	
	<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr><td align="center" colspan=11  nowrap class="btext">Submission Details </td></tr>
	<tr>
	<td   class="mystyle">Action </td>
	<td   class="mystyle">Action From </td>
	<td   class="mystyle">Action To </td>
	<td   class="mystyle">Action On </td>
	<td   class="mystyle">Submitted By </td>
	<td   class="mystyle">Submitted To </td>	
	<td   class="mystyle">Memo No</td>
	<td   class="mystyle">Date </td>
	<td   class="mystyle">Subject</td>
	<td   class="mystyle">Reference</td>
	<td   class="mystyle">Content</td>
	</tr>
	<%
		st5=conn.createStatement();
		String q5="SELECT decode(ACTION_TYPE,'S','Submitted','F','Forwarded','P','Considered for Sanction'), ACTION_FROM, ACTION_TO, to_char(ACTION_DATE,'dd/mm/yyyy'), SENT_by, SENT_TO ,MEMO_NO, to_char(FOR_SUB_DATE, 'dd/mm/yyyy'),  SUBJECT, REF ,CONTENT  from RWS_OM_PROPOSAL_WORKFLOW_TBL pw where pw.om_proposal_id='"+pid+"' order by track_no";

		rs5=st5.executeQuery(q5);
		while(rs5.next())
		{	
			String officeCode=rs5.getString(2);
			

			String at=rs5.getString(3);
			String officeCode_to=rs5.getString(3);

			String sby=rs5.getString(5);
			String sto=rs5.getString(6);
			// //System.out.println("sby code        "+sby);
			// //System.out.println("sto code        "+sto);
			//// //System.out.println("af ofice        "+af);

			/*
			Statement s1=conn.createStatement();
			Statement s2=conn.createStatement();

			
		
			String qq1="SELECT employee_name, o.city from rws_employee_tbl e,RWS_OFFICE_TBL o where o.office_code=e.office_code and employee_code="+sby;
			String qq2="SELECT employee_name, o.city from rws_employee_tbl e,RWS_OFFICE_TBL o where o.office_code=e.office_code and employee_code="+sto;
			ResultSet r1=s1.executeQuery(qq1);
			ResultSet r2=s2.executeQuery(qq2);
			r1.next();
			r2.next();
			
			sentBy=r1.getString(1);
			sentTo=r2.getString(1);*/
			
		if(rs5.getString(1).equals("Submitted"))
			{
				
			
			////System.out.println("office name is "+officeName);	
			
	%>
				<tr>
					<td class="mystyle1"> <%=rs5.getString(1)%>   </td>
					<td class="mystyle1"> <%=rw.getOfficeName(rs5.getString(2),true) %>   </td>  
					<td class="mystyle1"> <%=rw.getOfficeName(rs5.getString(3),true) %>   </td>  	
					<td class="mystyle1"> <%=rs5.getString(4)%> </td>
					<td class="mystyle1">  <%=sby %> </td>
					<td class="mystyle1">  <%=sto %> </td>
					<td class="mystyle1">  <%=rs5.getString(7) %> </td>
					<td class="mystyle1">  <%=rs5.getString(8) %> </td>
					<td class="mystyle1">  <%=rs5.getString(9) %> </td>
					<td class="mystyle1">  <%=rs5.getString(10) %> </td>
					<td class="mystyle1">  <%=rs5.getString(11) %> </td>
				</tr>
		<%	}
			else if(rs5.getString(1).equals("Considered for Sanction"))
			{	work_ID=rs.getString(17);
				%>
				<tr>
					<td class="btext" align=center colspan=11>
						Proposal Sanctioned At : <%=rw.getOfficeName(rs5.getString(3),true) %>  
					</td>
				</tr>
				<tr>
					<td  class="mystyle">Work Id</td>
					<td	 class="mystyle1" colspan=2><%=rs.getString(17) %>   </td>
					<td  class="mystyle"> Sanctioned No. </td>
					<td	 class="mystyle1"><%=rs.getString(10) %> </td>
					<td  class="mystyle"> Sanctioned Date</td> 
					<td  class="mystyle1"><%=rs.getString(11)%> </td>
					<td  class="mystyle">Estimated Cost (in Lakhs)</td> 
					<td  class="mystyle1" align=right><%=rs.getDouble(2)%> </td>
					<td  class="mystyle">Sanctioned Amount (in Lakhs)</td> 
					<td  class="mystyle1" align=right><%=rs.getDouble(9)%> </td>
				</tr>
				<tr>
					<td  class="mystyle" >GO No. </td>
					<td  class="mystyle1" colspan=2><%=rs.getString(12) %> </td>
					<td  class="mystyle">Sanctioned At </td>
					<td  class="mystyle1"><%=rs.getString(13) %> </td>
					<td  class="mystyle">Sanctioned Authority </td>
					<td	 class="mystyle1" colspan=5 ><%=rs.getString(14) %> </td>
				</tr>
				<tr><td align="center" colspan=11  nowrap class="btext">Forwarded Details </td></tr>
				<tr>
				<td   class="mystyle">Action </td>
				<td   class="mystyle">Action From </td>
				<td   class="mystyle">Action To </td>
				<td   class="mystyle">Action On </td>
				<td   class="mystyle">Submitted By </td>
				<td   class="mystyle">Submitted To </td>	
				<td   class="mystyle">Memo No</td>
				<td   class="mystyle">Date </td>
				<td   class="mystyle">Subject</td>
				<td   class="mystyle">Reference</td>
				<td   class="mystyle">Content</td>
				<tr>
			<%
			}
			 if(rs5.getString(1).equals("Considered for Sanction") || rs5.getString(1).equals("Forwarded") )
			{
			%>
			
			
					<td class="mystyle1"> <%=rs5.getString(1)%>   </td>
					<td class="mystyle1"> <%=rw.getOfficeName(rs5.getString(2),true) %>   </td>  
					<td class="mystyle1"> <%=rw.getOfficeName(rs5.getString(3),true) %>   </td>  	
					<td class="mystyle1"> <%=rs5.getString(4)%> </td>
					<td class="mystyle1">  <%=sby %> </td>
					<td class="mystyle1">  <%=sto %> </td>
					<td class="mystyle1">  <%=rs5.getString(7) %> </td>
					<td class="mystyle1">  <%=rs5.getString(8) %> </td>
					<td class="mystyle1">  <%=rs5.getString(9) %> </td>
					<td class="mystyle1">  <%=rs5.getString(10) %> </td>
					<td class="mystyle1">  <%=rs5.getString(11) %> </td>
				</tr>
			</tr>
	
			
			<%
			}
				
	}	
	
		 
		st6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		String q6="SELECT et.financial_year, st.source_name, et.total_components, et.TS_OFFICE, et.TS_GIVEN_BY, et.TS_NO, to_char(et.TS_DATE,'dd/mm/yyyy'), nvl(et.REMARKS,'--'), et.PREPARED_BY, et.PREPARED_ON  from  RWS_OM_EST_TBL et, RWS_SOURCE_TBL st where et.work_id='"+work_ID+"' and st.source_code=et.source_code";
		
		rs6=st6.executeQuery(q6);
//		rs6.next();
	if(rs6.next())
	{

	%>
	
<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
	<td class="btext" align=center colspan=11>Estimate Details</td>
</tr>
<tr>
		
		<td   nowrap class="mystyle">Financial Year</td>
		<td class="mystyle1"><%=rs6.getString(1) %>   </td>
	
		<td  nowrap class="mystyle"> Source Name</td>
		<td class="mystyle1"><%=rs6.getString(2) %> </td>
		<td   class="mystyle">Total Components</td> 
		<td  class="mystyle1"><%=rs6.getString(3)%> </td>
	</tr>
</table>
<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr><td  class="mystyle2" align="center" colspan=4  nowrap>Components Details </td></tr>
	<tr>
	<td  nowrap class="mystyle">Asset Code </td>
	<td  nowrap class="mystyle">Asset Component Code </td>
	<td  nowrap class="mystyle">Asset Component Name</td>
	<td  nowrap class="mystyle">Amount (Rs. in Lakhs)</td>
	</tr>
	<%
		st7=conn.createStatement();
		String q7="SELECT et.TYPE_OF_ASSET_CODE, ec.ASSET_COMPONENT_CODE, ac.ASSET_COMPONENT_NAME from RWS_OM_EST_TBL et, RWS_ASSET_COMPONENT_TYPE_TBL ac, RWS_OM_EST_COMP_LNK_TBL  ec where et.work_id=ec.work_id and ec.ASSET_COMPONENT_CODE =ac.ASSET_COMPONENT_CODE and ac.TYPE_OF_ASSET_CODE =et.TYPE_OF_ASSET_CODE and ec.work_id='"+work_ID+"'";
		rs7=st7.executeQuery(q7);
		while(rs7.next())
		{
		%>
		<tr>
	<td  class="mystyle1"><%=rs7.getString(1)%>  </td>
	<td  class="mystyle1"><%=rs7.getString(2)%>  </td>	
	<td  class="mystyle1" ><%=rs7.getString(3)%>  </td>
	<!-- <td  class="mystyle1" align=right><%=rs7.getDouble(4)%>  </td> -->
	</tr>
	<%}%>
</table>

<%		st8=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		String q8="SELECT decode(ACTION_TYPE,'S','Submitted','F','Forwarded','P','Considered for Sanction'), ACTION_FROM, ACTION_TO, to_char(ACTION_DATE,'dd/mm/yyyy'), SENT_by, SENT_TO ,MEMO_NO, to_char(FOR_SUB_DATE, 'dd/mm/yyyy'),  SUBJECT, REF ,CONTENT  from  RWS_OM_EST_WORKFLOW_TBL  where work_id='"+work_ID+"' order by track_no";

		rs8=st8.executeQuery(q8);

		if(rs8.next())
		{	
		%>
		<br>
	<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	<td   class="mystyle">Action </td>
	<td   class="mystyle">Action From </td>
	<td   class="mystyle">Action To </td>
	<td   class="mystyle">Action On </td>
	<td   class="mystyle">Submitted By </td>
	<td   class="mystyle">Submitted To </td>	
	<td   class="mystyle">Memo No</td>
	<td   class="mystyle">Date </td>
	<td   class="mystyle">Subject</td>
	<td   class="mystyle">Reference</td>
	<td   class="mystyle">Content</td>
	</tr>
<%
		rs8.beforeFirst();
		while(rs8.next())
		{	
				String officeCode=rs8.getString(2);
				String at=rs8.getString(3);
				String officeCode_to=rs8.getString(3);
	
				String sby=rs8.getString(5);
				String sto=rs8.getString(6);
						
				Statement s1=conn.createStatement();
				Statement s2=conn.createStatement();

				String qq1="SELECT employee_name, o.city from rws_employee_tbl e,RWS_OFFICE_TBL o where o.office_code=e.office_code and employee_code="+sby;
				String qq2="SELECT employee_name, o.city from rws_employee_tbl e,RWS_OFFICE_TBL o where o.office_code=e.office_code and employee_code="+sto;
				ResultSet r1=s1.executeQuery(qq1);
				ResultSet r2=s2.executeQuery(qq2);
				r1.next();
				r2.next();
				
				sentBy1=r1.getString(1);
				sentTo1=r2.getString(1);
			
	%>
				<tr>
					<td class="mystyle1"> <%=rs8.getString(1)%>   </td>
					<td class="mystyle1"> <%=rw.getOfficeName(rs8.getString(2),true) %>   </td>  
					<td class="mystyle1"> <%=rw.getOfficeName(rs8.getString(3),true) %>   </td>  	
					<td class="mystyle1"> <%=rs8.getString(4)%> </td>
					<td class="mystyle1">  <%=sentBy1 %> </td>
					<td class="mystyle1">  <%=sentTo1 %> </td>
					<td class="mystyle1">  <%=rs8.getString(7) %> </td>
					<td class="mystyle1">  <%=rs8.getString(8) %> </td>
					<td class="mystyle1">  <%=rs8.getString(9) %> </td>
					<td class="mystyle1">  <%=rs8.getString(10) %> </td>
					<td class="mystyle1">  <%=rs8.getString(11) %> </td>
				</tr>
	<%
			r1.close();		r2.close();
			s1.close();		s2.close();	
		}
				
		}}
			
			if(rs6.getString(6)!=null)
			{%>
				
<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	

	 	<tr>
				<td class="btext" align=center colspan=11>
						Technical Sanctioned At : <%=rw.getOfficeName(rs6.getString(4),true) %>  
					</td>
				</tr>
				<tr>
					<td   class="mystyle">TS NO. </td>
					<td class="mystyle1">  <%=rs6.getString(6) %> </td>
					<td   class="mystyle">TS Date </td>
					<td class="mystyle1">  <%=rs6.getString(7) %> </td>
					<td   class="mystyle">TS Given By </td>
					<td class="mystyle1">  <%=rs.getString(5)  %> </td>
				</tr>
				<tr>
					<!-- <td   class="mystyle">TS Amount </td>
					<td class="mystyle1" align=right>  <%=rs6.getDouble(11) %> </td> -->
					<!-- <td   class="mystyle">SSR Year </td>
					<td class="mystyle1">  <%=rs6.getString(12) %> </td> -->
					<td   class="mystyle">Remarks </td>
					<td class="mystyle1">  <%=rs6.getString(8) %> </td>
				</tr> 
				</table>
	
<%	}
}

 else {%>
<table align="center" width="100%">
	<tr>
		<td	class="bwborder" align="center" ><font color="navy">Proposal Id :</font>
		<font color="#660033"><%=pid %></font></td>
	</tr>
</table>
 <table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" height="68%" bordercolor=navy style="border-collapse:collapse" bgcolor="#FFFFCC"> 
 <!-- <table align="center" cellspacing = 0 cellpadding = 0  width="100%" height="68%" bordercolor=navy> -->
	<tr>
		<td align="center" class="mystyle">
			<font color="navy">
				This Proposal has not been Considered for Sanction 
			</font>
		</td>
	</tr>
</table>
<%}
	%>


</table>
</p>
</body>
</html>
<%}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}
		%>