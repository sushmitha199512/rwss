<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
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
   //System.out.println("jdjdfjdlgjdflkj");
  
String circlename=request.getParameter("cname");
//System.out.println("circlename************"+circlename);

String divname=request.getParameter("divname");
String subdivname=request.getParameter("subdivname");

String scheme=(String)session.getAttribute("scheme");
//System.out.println("scheme******************"+scheme);

String circleofficecode=request.getParameter("circleofficecode");
//System.out.println("circleofficecode************"+circleofficecode);
String divisionofficecode=request.getParameter("divisionofficecode");
String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
//System.out.println("programes*****"+programes);
String pro=(String)session.getAttribute("programe");
//System.out.println("pro********************"+pro);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Amount In Rupees </td>
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="center" class="rptHeading" >District:<%=circlename%>&nbsp&nbsp&nbsp Division:<%=divname%> &nbsp&nbsp&nbsp SubDivision:<%=subdivname%> </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SL NO   </b></td>
<td class=btext ><b>Work Id   </b></td>
<td class=btext ><b>Work Name  </b></td>
<td class=btext ><b>Sanction Amount <br>(In  Lakhs ) </b></td>
<td class=btext ><b>Admin Date </b></td>
<td class=btext ><b>Milestone Name </b></td>
<td class=btext ><b>Component No  </b></td>
<td class=btext ><b>Component NO <br>Achievement  </b></td>
<td class=btext ><b>Achievement Date </b></td>


<td class=btext ><b>Percent Completed Work Val  </b></td>
<td class=btext ><b>Percent Completed Val </b></td>


  </tr>


	<%
	try
      { 
		int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       double san=0.0;
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
// query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Deeping'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
////query="SELECT  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_bill_tbl c where   substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and w.work_id=c.work_id and c.EE_FWD_DATE is  null and substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,2)='"+divisionofficecode+"'  group by  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE order by 1 ";
//and DATE_OF_COMPLETION is not null 
///
String eebudget="select programme_name,programme_code from rws_programme_tbl";
    //System.out.println("eebudget"+eebudget);

	Statement stmt22=conn.createStatement();
	  // System.out.println("eebudget:"+eebudget);
		ResultSet rs22=stmt22.executeQuery(eebudget);
		Hashtable eeList=new Hashtable();
		while(rs22.next())
		{
			eeList.put(rs22.getString(2),rs22.getString(1));
		}
		if(rs22!=null)rs22.close();
		if(stmt22!=null)stmt22.close();

///
 

query="SELECT w.WORK_ID ,WORK_NAME,SANCTION_AMOUNT,to_char(ADMIN_DATE,'dd/mm/yyyy'),substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),nvl(COMPONENT_NO,0),nvl(COMPONENT_NO_ACH,0) ,nvl(PERCENT_COMPLETED_WORK_VAL,0) ,nvl(PERCENT_COMPLETED_VAL,0),nvl(mm.milestone_name,''),nvl(to_char(m.ACHIEVE_DATE,'dd/mm/yyyy'),'-') FROM RWS_WORK_ADMN_TBL W LEFT OUTER JOIN  rws_milestone_target_ach_tbl m on  w.work_id =m.work_id LEFT OUTER JOIN rws_milestone_tbl mm on  m.milestone_code=mm.milestone_code    where    work_cancel_dt is null   and w.programme_code in ("+pro+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-2013'))    and substr(office_code,2,2)='"+circleofficecode+"' and substr(office_code,4,1)='"+divisionofficecode+"' and substr(office_code,5,2)='"+subdivisionofficecode+"'  ";
if(scheme!=null && !scheme.equals("")){
	query+=" and w.type_of_asset in("+scheme+")   order by 1";
}
System.out.println("queryssss********"+query);
String mileStoneName="";
rs3=stmt3.executeQuery(query);

String work_id="";
while(rs3.next())
{
	
	if(rs3.getString(12)==null ||  rs3.getString(12).equals("null")){
		
		mileStoneName="";
	}else{
		
		mileStoneName=rs3.getString(12);
	}

%>
<tr><td class=rptValue><%=count++ %></td>



<% 
if(!work_id.equals(rs3.getString(1))){
	work_id=rs3.getString(1);
%>
<td  class=rptValue><a href="rws_programm_milestone_workid_drill_rpt.jsp?workid=<%=rs3.getString(1)%> "><%=rs3.getString(1) %></a></td>
<td  class=rptValue><%=rs3.getString(2) %></td>
<td class=rptValue><%=rs3.getString(3)%></td>
<td class=rptValue><%=rs3.getString(4)%></td>

<% }
else{
%>
<td  class=rptValue align="center">''</td>
<td  class=rptValue align="center">''</td>
<td  class=rptValue align="center">''</td>
<td  class=rptValue align="center">''</td>

<%} %>

<td class=rptValue><%=mileStoneName %></td>
<td class=rptValue><%=rs3.getString(8) %></td>
<td class=rptValue><%=rs3.getString(9)%></td>
<td class=rptValue><%=rs3.getString(13)%></td>
<td class=rptValue><%=rs3.getString(10)%></td>

<td class=rptValue><%=rs3.getString(11)%></td>


</tr>
<% 

}
}

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

