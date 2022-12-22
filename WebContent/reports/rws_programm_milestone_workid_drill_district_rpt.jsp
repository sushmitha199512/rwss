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
String workid=request.getParameter("workid");
System.out.println("workid"+workid);

System.out.println("circlename&&&&&&&&&&&&&"+circlename);
String divname=request.getParameter("divname");
String subdivname=request.getParameter("subdivname");


String circleofficecode=request.getParameter("circleofficecode");
System.out.println("circleofficecode************"+circleofficecode);
String divisionofficecode=request.getParameter("divisionofficecode");
String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		System.out.println("dcode*********"+dcode);
		
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

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SL NO   </b></td>
<td class=btext ><b>District  </b></td>
<td class=btext ><b>Division  </b></td>

<td class=btext ><b>SubDivision  </b></td>
<td class=btext ><b>Work Id </b></td>
<td class=btext ><b>Milestone </b></td>
<td class=btext ><b>Component&nbsp;No</b></td>
<td class=btext ><b>Component&nbsp;No&nbsp;Achievement</b></td>
<td class=btext ><b>Percent&nbsp;Completed&nbsp;Work</b></td>
<td class=btext ><b>Percent&nbsp;Completed</b></td>

<td class=btext ><b>Agreement&nbsp;Amount </b></td>
<td class=btext ><b>Achievement&nbsp;Amount </b></td>
<td class=btext ><b>Target&nbsp;Date</b></td>
<td class=btext ><b>Achievement Date</b></td>

  </tr>





	<%
	try
      { 
		int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt11=null,stmt222=null,stmt2222=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       double san=0.0;
       
       stmt3=conn.createStatement();
      stmt222=conn.createStatement();
      stmt2222=conn.createStatement();
      stmt11=conn.createStatement();
boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;
//
 String eebudget22="";
       eebudget22="select circle_office_name,circle_office_code from rws_circle_office_tbl";
        stmt222=conn.createStatement();
	   System.out.println("eebudget22:"+eebudget22);
		ResultSet rs222=stmt222.executeQuery(eebudget22);
		Hashtable eeList22=new Hashtable();
		while(rs222.next())
		{
			eeList22.put(rs222.getString(2),rs222.getString(1));
		}
		if(rs222!=null)rs222.close();
		if(stmt222!=null)stmt222.close();

//
///
 String eebudget222="";
       eebudget222="select division_office_name,division_office_code,circle_office_code from rws_division_office_tbl";
        stmt2222=conn.createStatement();
	   System.out.println("eebudget22:"+eebudget222);
		ResultSet rs2222=stmt2222.executeQuery(eebudget222);
		Hashtable eeList222=new Hashtable();
		while(rs2222.next())
		{
			eeList222.put(rs2222.getString(3)+rs2222.getString(2),rs2222.getString(1));
		}
		if(rs2222!=null)rs2222.close();
		if(stmt2222!=null)stmt2222.close();

//
String eebudget11="";
       eebudget11="select subdivision_office_name,subdivision_office_code,circle_office_code,division_office_code from rws_subdivision_office_tbl ";
        stmt11=conn.createStatement();
	   System.out.println("eebudget11:"+eebudget11);
		ResultSet rs11=stmt11.executeQuery(eebudget11);
		Hashtable eeList11=new Hashtable();
		while(rs11.next())
		{
			eeList11.put(rs11.getString(3)+rs11.getString(4)+rs11.getString(2),rs11.getString(1));
		}
		if(rs11!=null)rs11.close();
		if(stmt11!=null)stmt11.close();

////
//
String query="";
// query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Deeping'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
////query="SELECT  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_bill_tbl c where   substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and w.work_id=c.work_id and c.EE_FWD_DATE is  null and substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,2)='"+divisionofficecode+"'  group by  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE order by 1 ";
//and DATE_OF_COMPLETION is not null 
///

///  
      ////
 

//query="SELECT WORK_ID ,WORK_NAME,SANCTION_AMOUNT,to_char(ADMIN_DATE)    FROM RWS_WORK_ADMN_TBL W   where  work_cancel_dt is null  and w.programme_code in (01,02,18,23,32,48,49,51,58)  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-2013'))   and w.type_of_asset in(01) and substr(office_code,2,2)='"+circleofficecode+"' and substr(office_code,4,1)='"+divisionofficecode+"' and substr(office_code,5,2)='"+subdivisionofficecode+"'  order by 1";


//query="SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),substr(w.office_code,5,2),w.work_id FROM  rws_work_admn_tbl w where w.work_id='"+workid+"'  order by 1";
query="select w.office_code,substr(w.office_code,2,2),substr(w.office_code,4,1),substr(w.office_code,5,2),m.work_id,mm.milestone_name,MAJOR_MILESTONE_CODE,nvl(COMPONENT_NO,0),nvl(COMPONENT_NO_ACH,0),nvl(PERCENT_COMPLETED_WORK,0),nvl(PERCENT_COMPLETED,0),nvl(PERCENT_COMPLETED_WORK_VAL,0),nvl(PERCENT_COMPLETED_VAL,0) ,nvl(to_char(TARGET_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACHIEVE_DATE,'dd/mm/yyyy'),'-') from rws_work_admn_tbl w,rws_milestone_target_ach_tbl m,rws_milestone_tbl mm where mm.milestone_code=m.milestone_code and w.work_id=m.work_id and w.work_id='"+workid+"'";
//if(scheme!=null && !scheme.equals("")){
	//ongoing+=" and w.type_of_asset in("+scheme+")   order by 1";
//}
System.out.println("queryssss********"+query);
//String sw="";
rs3=stmt3.executeQuery(query);
String cirname="";
String cdivname="";
String sdivname="";
while(rs3.next())
{
	
	String off=rs3.getString(1);
	System.out.println("off"+off);
	String off1=rs3.getString(2);
	System.out.println("off1"+off1);
	//
	cirname=(String)eeList22.get(rs3.getString(2));
	System.out.println("cirname"+cirname);
	if(cirname !=null && !cirname.equals("")  )
	{
		
	}
	else
	{
		cirname="-";
	}
	//
	
	cdivname=(String)eeList222.get(rs3.getString(2)+rs3.getString(3));
	System.out.println("divname"+cdivname);
	if(cdivname !=null && !cdivname.equals("") && !cdivname.equals("null"))
	{
		
	}
	else
	{
		cdivname="-";
	}
	sdivname=(String)eeList11.get(rs3.getString(2)+rs3.getString(3)+rs3.getString(4));
	System.out.println("divname"+sdivname);
	if(sdivname !=null && !sdivname.equals("") && !sdivname.equals("null"))
	{
		
	}
	else
	{
		sdivname="-";
	}

%>
<tr><td class=rptValue><%=count++ %></td>


<td class=rptValue><%=cirname%></td>
<td class=rptValue><%=cdivname%></td>
<td class=rptValue><%=sdivname%></td>
<td class=rptValue><%=rs3.getString(5)%></td>
<td class=rptValue><%=rs3.getString(6)%></td>
<td class=rptValue><%=rs3.getString(8)%></td>
<td class=rptValue><%=rs3.getString(9)%></td>
<td class=rptValue><%=rs3.getString(10)%></td>
<td class=rptValue><%=rs3.getString(11)%></td>
<td class=rptValue><%=rs3.getString(12)%></td>
<td class=rptValue><%=rs3.getString(13)%></td>
<td class=rptValue><%=rs3.getString(14)%></td>
<td class=rptValue><%=rs3.getString(15)%></td>


</td>

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

