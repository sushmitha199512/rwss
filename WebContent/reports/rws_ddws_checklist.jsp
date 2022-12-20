<%query="select distinct nvl(w.WORK_NAME,'-') as WORK_NAME,nvl(w.work_id,'-') as work_id,nvl(w.office_code,'-') as office_code,nvl(to_char(w.admin_date,'yyyy'),'-') as admin_date,nvl(w.approved_under,'-') as approved_under from RWS_WORK_ADMN_TBL w,RWS_DDWS_WORK_FIELDS_TBL dd where dd.work_id=w.work_id  and w.work_id='"+wCode+"'";
//query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_WORK_COMMENCEMENT_TBL con where w.work_id=con.work_id  and w.work_id='"+wCode+"'";
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
   //  System.out.println("query in ddws"+query);
	 //t.println(query);
String ApprovedName="";
  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  //and w.work_id=ten.work_id,RWS_MILESTONE_TARGET_ACH_TBL ten

  rs = stmt.executeQuery(query);
  rs.setFetchSize(500);
  rs.last();
  Count = rs.getRow();
  rs.beforeFirst();
  int slnum=1;
  String ApprovedUnder="";
String queryAPP="select distinct nvl(w.approved_under,'-') as approved_under from RWS_WORK_ADMN_TBL w,RWS_DDWS_WORK_FIELDS_TBL dd where dd.work_id=w.work_id  and w.work_id='"+wCode+"'";
rapp=ss.executeQuery(queryAPP);
while(rapp.next())
{
	ApprovedUnder=rapp.getString(1);
	//System.out.println("Approved Under "+rapp.getString(1));
}

 
  int slnum2=2;%>

<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>VIII. DDWS Data Details</font></td>	
	</tr>
	
<%	
	try
	{
	if(Count!=0)
	{
	 while(rs.next())
	 {
	//	System.out.println("inside rs"+rs.getString(1));
	/*String qury1="select distinct sd.subdivision_office_name, com.officer_assigned_to,com.grounding_date,m.milestone_name, st.milestone_stage_name,mil.TARGET_DATE,mil.ACHIEVE_DATE,mil.PERCENT_COMPLETED from rws_work_commencement_tbl com,rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st,rws_subdivision_office_tbl sd  where substr(com.office_code,5,2)=sd.subdivision_office_code and m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and com.work_id='"+rs.getString(1)+"'";*/
	/*String qury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(To_Char (com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+rs.getString(1)+"'";*/
	//String pqury1="select distinct sd.subdivision_office_name,NVL(com.officer_assigned_to,'-'),NVL(com.officer_assigned_to1,'-'),NVL(com.officer_assigned_to2,'-'),NVL(com.officer_assigned_to3,'-'),NVL(To_Char(com.grounding_date,'DD-MON-YYYY'),'-') from rws_work_commencement_tbl com,rws_subdivision_office_tbl sd where substr(com.office_code,2,2) =sd.circle_office_code and substr(com.office_code,4,1)=sd.division_office_code and substr(com.office_code,5,2) =sd.subdivision_office_code and com.work_id='"+wCode+"'";

	//out.println(qury1);
	//String pqury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(mil.ACHIEVE_DATE,'DD-MON-YYYY'),'-'),nvl(mil.PERCENT_COMPLETED,'0') from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+wCode+"'";

	/*String qury2="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(1)+"'";*/

       // rs1 = st1.executeQuery(pqury1);
       // rs1.beforeFirst();
         
		//rs2 = st2.executeQuery(pqury2);
      //  rs2.last();
      //  Cnt = rs2.getRow();
      //  rs2.beforeFirst();
		   
	//	while(rs1.next())
	
		
 %>
	  	<tr bgcolor="#ffffff" >
		<td class="btext" >1. Slno</td>
		<td class=rptValue ><%=slnum++%></td>
		</tr>
		
		<tr bgcolor="#ffffff" >
		<td class="btext" >2. Approved Under</td>
		<td class=rptValue ><%=rs.getString(5)%></td>
		</tr>
		<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
		<%	
			
int countnum=1;
//if(Count!=0)
//System.out.println("rs.getString $$$$$$"+rs.getString(5));
 ApprovedName=rs.getString(5);
 int slnum1=1;
if(countnum==1)
{
if(ApprovedName.equalsIgnoreCase("Normal Coverage") || ApprovedName.equalsIgnoreCase("Sustainability"))
{ 
%>
	<tr align=center bgcolor="#ffffff">
		<td class= "btext">S.NO</td>
		<td class="btext">GOICOST</td>
		<td class="btext">STATECOST</td>
		<td class="btext">COMMCONT</td>
		<td class="btext">AGENCY</td>
		<td class="btext">PRIVATE_SOURCE</td>
		<td class="btext">SOURCE_TYPE</td> 
		<td class="btext">SUBSOURCE_TYPE</td>
		<td class="btext">SOURCE_LOCATION</td>
		<td class="btext">SCHEME_APPROVED_UNDER</td>
		<td class="btext">DATE_OF_COMP_ACTION_PLAN</td>
		<td class="btext">DDWS_SCHEME</td>
	</tr>
	<%} if(ApprovedName.equals("Submission(Water Quality)"))
{%>		
		<tr align=center bgcolor="#ffffff">
		<td class= "btext" rowspan=2>S.NO</td>
		<td class="btext">TURBIDITY</td>
		<td class="btext">ARSENIC</td>
		<td class="btext">FLUORIDE</td>
		<td class="btext">IRON</td>
		<td class="btext">CHLORIDE</td>
		<td class="btext">NITRATE</td>
		<td class="btext">SULPHATES</td>
		<td class="btext">CALCIUM</td>
		<td class="btext">MAGNESIUM</td>
		<td class="btext">MANGANESE</td>
		<td class="btext">COPPER     </td>
		<td class="btext">SALINITY     </td>
		<td class="btext">TDS  </td> 
		<td class="btext">HARDNESS  </td>
		<td class="btext">RESI_CHLORINE  </td>
		<td class="btext">ALKALINITY     </td>
		<td class="btext">FAECAL_COLIFORM   </td>
		<td class="btext">PH  </td>
		<td class="btext">METHODOLOGY</td>
 	   </tr>
	<% }
	countnum++;
	}
	//System.out.println(" COND "+ApprovedName.equalsIgnoreCase("Normal Coverage"));
if(ApprovedName.equalsIgnoreCase("Normal Coverage") || ApprovedName.equalsIgnoreCase("Sustainability"))
{ 

String query1="select nvl(dd.GOICOST,'0') as GOICOST,nvl(dd.STATECOST,'0') as STATECOST,nvl(dd.COMMCONT,'0') as STATECOST,nvl(dd.AGENCY_CODE,'0') as agency_code,nvl(dd.PRIVATE_SOURCE,'-') as private_source,nvl(dd.SOURCE_TYPE,'-') as source_type,nvl(dd.SUBSOURCE_TYPE,'-') as subsource_type,nvl(dd.SOURCE_LOCATION,'-') as source_location,nvl(dd.SCHEME_APPROVED_UNDER,'-') as scheme_app,nvl(to_char(dd.DATE_OF_COMP_ACTION_PLAN,'dd/mm/yyyy'),'-') as date_comm,nvl(dd.DDWS_SCHEME,'-') as ddws_scheme from rws_work_admn_tbl w,RWS_DDWS_WORK_FIELDS_TBL  dd where dd.work_id=w.work_id  and w.work_id='"+rs.getString(2)+"'";//and w.work_id='"+rss.getString(2)+"' 
//System.out.println("query2 "+query1);
rs1=st1.executeQuery(query1);
 rs1.last();
 Cnt = rs1.getRow();
 rs1.beforeFirst();
try
{
if(Cnt!=0)
{
while(rs1.next())
{
slnum2++;
String scheme="";
if(rs1.getString(4).equals("001"))
{
scheme="RWS";
}
else
{
scheme="-";
}

%>
  <tr bgcolor="#ffffff">
		<td class=rptValue  ><%=slnum1++%></td>			
		<td class=rptValue align="center" nowrap>&nbsp;<%=rs1.getString(1)%>&nbsp;</td>
		<td class=rptValue align="center">&nbsp;<%=rs1.getString(2)%>&nbsp;</td>
		<td class=rptValue align="center"><%=rs1.getString(3)%></td>
		<td class=rptValue align="center"><%=scheme%></td>
		<td class=rptValue align="center"><%=rs1.getString(5)%></td>
		<td class=rptValue align="center"><%=rs1.getString(6)%></td>
		<td class=rptValue align="center"><%=rs1.getString(7)%></td>
		<td class=rptValue align="center"><%=rs1.getString(8)%></td>
		<td class=rptValue align="center"><%=rs1.getString(9)%></td>
		<td class=rptValue align="center"><%=rs1.getString(11)%></td>
		
	</tr>
<%}
}
else
{
%>
 <tr bgcolor="#ffffff">
		<td class=rptValue><%=slnum1++%></td>			
		<td class=rptValue>-</td>
		<td class=rptValue align="center" nowrap>-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
	</tr>
<%
}
}catch(Exception e)
{
System.out.println("Exception in DDWSrpt"+e.getMessage());
}
}
if(ApprovedName.equalsIgnoreCase("Submission(Water Quality)"))
{
String query12=" select nvl(wq.TURBIDITY,'-') as turbidity,nvl(wq.ARSENIC,'-') as turbidity,nvl(wq.FLUORIDE,'-') as Floride,nvl(wq.IRON,'-') as iron,nvl(wq.CHLORIDE,'-') as chloride,nvl(wq.NITRATE,'-') as nitrate,nvl(wq.SULPHATES,'-') as sulphates,nvl(wq.CALCIUM,'-') as calcium,nvl(wq.MAGNESIUM,'-') as magnesium,nvl(wq.MANGANESE,'-') as manganese,nvl(wq.COPPER,'-') as copper,nvl(wq.SALINITY,'-') as salinity,nvl(wq.TDS,'-') as tds,nvl(wq.HARDNESS,'-') as hardness,nvl(wq.RESI_CHLORINE,'-') as resi_chlorine,nvl(wq.ALKALINITY,'-') as alkalinity,nvl(wq.FAECAL_COLIFORM,'-') as faecal,nvl(wq.PH,'-') as ph,nvl(upper(wq.METHODOLOGY),'-') as methodology from rws_work_admn_tbl w,RWS_DDWS_SUBMISSION_WQ_TBL wq where wq.work_id=w.work_id and w.work_id='"+rs.getString(2)+"' ";
rs2=st2.executeQuery(query12);
rs2.last();
 Cnt = rs2.getRow();
 rs2.beforeFirst();
//System.out.println("query12 "+query12);

try{

if(Cnt!=0)
{
while(rs2.next())
{
slnum2++;
%>
<tr bgcolor="#ffffff">
		<td class=rptValue rowspan=2 ><%=slnum1++%></td>			
		<td class="rptValue" align="center"><%=rs2.getString(1)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(2)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(3)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(4)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(5)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(6)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(7)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(8)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(9)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(10)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(11)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(12)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(13)%></td> 
		<td class="rptValue" align="center"><%=rs2.getString(14)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(15)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(16)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(17)%></td>
		<td class="rptValue" align="center"><%=rs2.getString(18)%></td>
		<td class="rptValue" nowrap><%=rs2.getString(19)%></td>
 	   </tr>

<%}
}
else
{
%>
<tr bgcolor="#ffffff">
		<td class=rptValue rowspan=2 ><%=slnum1++%></td>			
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td> 
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" align="center">-</td>
		<td class="rptValue" nowrap>-</td>
 	   </tr>
<%
}
}catch(Exception e)
{
}
}
	}	
	}
	else
	{
	//System.out.println("ELSE PART ");
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	  	
	<tr bgcolor="#ffffff">	
		<td class=rptValue>1.</td>			
		<td class=rptValue>-</td>
		<td class=rptValue align="center" nowrap>-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
	</tr>
	<%} 
	}catch(Exception e)
	{
	}		


%>		 
</table>

