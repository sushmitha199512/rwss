<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 



<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


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

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";
	
    double aas=0;
    double OtherFundasSC=0,OtherFundaslikelySC=0,gtotlikely=0,gexpendituretot=0,gglikelytot=0,ggexpenditure=0,scPOP=0,ggggtotEST=0,	ggggstatescEST=0,ggggtotalotherscsp=0;
        
    double ggunderscexp=0,ggunderotherexp=0;
    
    String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialstartyr=request.getParameter("finyear");
	}
   String probstrng="";
   if(financialstartyr.equals("2013-2014")){
	   probstrng="PROB_EXP";  
   }
if(financialstartyr.equals("2014-2015")){
	probstrng="PROB_EXP_NXT_YR1";   
   }
if(financialstartyr.equals("2015-2016")){
	probstrng="PROB_EXP_NXT_YR";   
}
if(financialstartyr.equals("2016-2017")){
	probstrng="PROB_EXP_NXT_YR2";   
}
	session.setAttribute("financialyr",financialstartyr);
//////System.out.println("Changing");
    //schemes
String scheme="";
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	//////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("schemes",schemes);
}
  
	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
       String[] programes=request.getParameterValues("program");
    	
       session.setAttribute("programes",programes);
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//////System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);

	//////System.out.println("programe::"+programe);
 

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //////System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(startyr);
   
   String nextfinancialstartyr="";
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr=""+nextFinYear+"-"+nn;
//////System.out.println("startyr"+startyr);
   //////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;

String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();

if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}
String startyr2="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {
endyr1=endyr;
}

//////System.out.println("Startyr:"+startyr);
//////System.out.println("StartyRr2:"+startyr2 );
//////System.out.println("Endyr:"+endyr );

//////System.out.println("Endyr2:"+endyr1);


     //////System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=request.getParameter("district");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

//////System.out.println("dcode"+dcode);
//////System.out.println("DivCode"+divCode);
////System.out.println("satrt year"+startyr);
////System.out.println("end year"+endyr);
String targetyr=(Integer.parseInt(startyr))+"-"+(Integer.parseInt(endyr));
////System.out.println("targetyr year"+targetyr);
	%>
	
	<body>
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="./rws_wrk_hab_target_abstract_frm.jsp">Back|</a><a href="./rws_wrk_hab_target_abstract_excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
	
	
<table border=1 cellspacing=0 cellpadding=0 width="60%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center"><tr >
			<td align="center" class="gridhdbg" colspan=27>Abstract Showing the No.of habitations  proposed to be completed during <%=financialstartyr %> and Aniticipated Expenditure</td>	
	
	</tr>
		<tr>
		<td  class="gridhdbg" rowspan="3">Sl.No</td>
		<td   class="gridhdbg" rowspan="3">District</td>
		<td   class="gridhdbg" rowspan="3">Division</td>
		<td  class="gridhdbg" rowspan="3">No of Works</td>
		<td class="gridhdbg"  rowspan="3">No of Habs</td>
		<td class="gridhdbg"  rowspan="3">Expenditure During <%=financialstartyr %></td>
		<td  class="gridhdbg" rowspan="3">Balance ESt. Cost</td>
        <td  class="gridhdbg" rowspan="1" colspan="10">Completed <%=startyr %>-<%=endyr %></td>
		<td  class="gridhdbg" rowspan="1" colspan="10">To be Completed <%=startyr %>-<%=endyr %></td>
		
		
</tr>
<tr>
<td class="gridhdbg" rowspan="2">Works</td>
<td class="gridhdbg" rowspan="1" colspan="8">Habitations</td>
<td class="gridhdbg" rowspan="2">Exp</td>
<td class="gridhdbg" rowspan="2">Works</td>
<td class="gridhdbg" rowspan="1" colspan="8">Habitations</td>
<td class="gridhdbg" rowspan="2">Exp</td>
</tr>
<tr>
<td class="gridhdbg">Total</td>
<td class="gridhdbg">PC1</td>
<td class="gridhdbg">PC2</td>
<td class="gridhdbg">PC3</td>
<td class="gridhdbg">PC4</td>
<td class="gridhdbg">FC</td>
<td class="gridhdbg">NC</td>
<td class="gridhdbg">NSS</td>
<td class="gridhdbg">Total</td>
<td class="gridhdbg">PC1</td>
<td class="gridhdbg">PC2</td>
<td class="gridhdbg">PC3</td>
<td class="gridhdbg">PC4</td>
<td class="gridhdbg">FC</td>
<td class="gridhdbg">NC</td>
<td class="gridhdbg">NSS</td>

</tr>
<tr>
	<%for(int i=1;i<28;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>

<%
Statement stmt2=null,stmt3=null;
ResultSet rs2=null,rs3=null;
int count=1;
String temp="",dname="",divname="",worknm="",workid="",wrktype="",program="",subprog="",admsandt="",admsanno="",slscmeetingdt="",wrknature="",sourcecd="",sourcenm="",srctype="",location="",grounddt="",probdate="";
String sno="",snamnt="",remarks="";
  try{
	  String workqry="select substr(office_code,2,2), substr(office_code,4,1),count(work_id),sum(sanction_amount) from RWS_WORK_ADMN_TBL where work_cancel_dt is null  and work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
	  if(dcode!=null && !dcode.equals("00")){
		  workqry+=" and substr(work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			workqry+=" and type_of_asset in("+scheme+") ";
		}
		workqry+=" and programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
		System.out.println("workqry a "+workqry);
	  stmt2=conn.createStatement(); 
	  rs2=stmt2.executeQuery(workqry);
	  Hashtable works_hash = new Hashtable();
	  while(rs2.next()){
		  works_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getInt(3)+"@"+rs2.getString(4));
	  }
		  	
	  if(stmt2!=null){
			stmt2.close();
		}
		if(rs2!=null){
			rs2.close();
		}
		//habs
		 String habqry="select substr(office_code,2,2), substr(office_code,4,1),count(distinct b.hab_code) from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and coverage_status<>'UI' ";
		  if(dcode!=null && !dcode.equals("00")){
			  habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				habqry+=" and type_of_asset in("+scheme+") ";
			}
			habqry+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
			System.out.println("habqry b "+habqry);
			 stmt2=conn.createStatement(); 
			  rs2=stmt2.executeQuery(habqry);
			  Hashtable habs_hash = new Hashtable();
			  while(rs2.next()){
				  habs_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getInt(3));
			  }
				  	
			  if(stmt2!=null){
					stmt2.close();
				}
				if(rs2!=null){
					rs2.close();
				}
			///expenditure
			
				String estcost="select substr(office_code,2,2), substr(office_code,4,1),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id ";
				if(dcode!=null && !dcode.equals("00")){
					estcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
				}
				if(scheme!=null && !scheme.equals(""))
				{
					estcost+=" and type_of_asset in("+scheme+") ";
				}
				estcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
				System.out.println("estcost c "+estcost);
				 stmt2=conn.createStatement(); 
				  rs2=stmt2.executeQuery(estcost);
				  Hashtable est_hash = new Hashtable();
				  while(rs2.next()){
					  est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
				  }
					  	
				  if(stmt2!=null){
						stmt2.close();
					}
					if(rs2!=null){
						rs2.close();
					}
					///expenditure dir
					
					String direstcost="select substr(office_code,2,2), substr(office_code,4,1),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,RWS_WORK_DIRECT_VOUCHER_TBL b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id ";
					if(dcode!=null && !dcode.equals("00")){
						direstcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
					}
					if(scheme!=null && !scheme.equals(""))
					{
						direstcost+=" and type_of_asset in("+scheme+") ";
					}
					direstcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
					System.out.println("estcost d "+estcost);
					 stmt2=conn.createStatement(); 
					  rs2=stmt2.executeQuery(direstcost);
					  Hashtable dir_est_hash = new Hashtable();
					  while(rs2.next()){
						  dir_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
					  }
						  	
					  if(stmt2!=null){
							stmt2.close();
						}
						if(rs2!=null){
							rs2.close();
						}
					///expenditure during
					
					String durestcost="select substr(office_code,2,2), substr(office_code,4,1),sum(voucher_Amt)/100000 from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and to_date(VOUCHER_DT)>='01-Apr-"+startyr+"' and to_date(VOUCHER_DT)<='31-Mar-"+endyr+"' ";
					if(dcode!=null && !dcode.equals("00")){
						durestcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
					}
					if(scheme!=null && !scheme.equals(""))
					{
						durestcost+=" and type_of_asset in("+scheme+") ";
					}
					durestcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
				System.out.println("durestcost e "+durestcost);
					 stmt2=conn.createStatement(); 
					  rs2=stmt2.executeQuery(durestcost);
					  Hashtable dur_est_hash = new Hashtable();
					  while(rs2.next()){
						  dur_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
					  }
						  	
					  if(stmt2!=null){
							stmt2.close();
						}
						if(rs2!=null){
							rs2.close();
						}
						
						///expenditure during dir
						
						String dirdurestcost="select substr(office_code,2,2), substr(office_code,4,1),sum(voucher_Amt)/100000 from  RWS_WORK_ADMN_TBL a,RWS_WORK_DIRECT_VOUCHER_TBL b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and to_date(VOUCHER_DT)>='01-Apr-"+startyr+"' and to_date(VOUCHER_DT)<='31-Mar-"+endyr+"' ";
						if(dcode!=null && !dcode.equals("00")){
							dirdurestcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
						}
						if(scheme!=null && !scheme.equals(""))
						{
							dirdurestcost+=" and type_of_asset in("+scheme+") ";
						}
						dirdurestcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
						System.out.println("dirdurestcost f "+dirdurestcost);
						 stmt2=conn.createStatement(); 
						  rs2=stmt2.executeQuery(dirdurestcost);
						  Hashtable dirdur_est_hash = new Hashtable();
						  while(rs2.next()){
							  dirdur_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
						  }
							  	
						  if(stmt2!=null){
								stmt2.close();
							}
							if(rs2!=null){
								rs2.close();
							}
							
					
			////completed works
			
					 String compworkqry="select substr(office_code,2,2), substr(office_code,4,1),count(a.work_id),sum(sanction_amount) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and to_date(DATE_OF_COMPLETION)>='01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION)<='31-Mar-"+endyr+"'  ";
					  if(dcode!=null && !dcode.equals("00")){
						  compworkqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
						}
						if(scheme!=null && !scheme.equals(""))
						{
							compworkqry+=" and type_of_asset in("+scheme+") ";
						}
						compworkqry+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
						System.out.println("compworkqry g"+compworkqry);
					  stmt2=conn.createStatement(); 
					  rs2=stmt2.executeQuery(compworkqry);
					  Hashtable comp_works_hash = new Hashtable();
					  while(rs2.next()){
						  comp_works_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getInt(3)+"@"+rs2.getString(4));
					  }
						  	
					  if(stmt2!=null){
							stmt2.close();
						}
						if(rs2!=null){
							rs2.close();
						}
						//habs
						 String comhabqry="select substr(office_code,2,2), substr(office_code,4,1),count(distinct b.hab_code),coverage_status from RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL b,rws_habitation_directory_tbl c,rws_work_completion_tbl d where a.work_id=b.work_id and b.hab_code=c.hab_code and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and coverage_status<>'UI' and a.work_id=d.work_id and to_date(DATE_OF_COMPLETION)>='01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION)<='31-Mar-"+endyr+"' ";
						  if(dcode!=null && !dcode.equals("00")){
							  comhabqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
							}
							if(scheme!=null && !scheme.equals(""))
							{
								comhabqry+=" and type_of_asset in("+scheme+") ";
							}
							comhabqry+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1),coverage_status  order by  substr(office_code,2,2), substr(office_code,4,1) ";
							System.out.println("comhabqry h"+comhabqry);
							 stmt2=conn.createStatement(); 
							  rs2=stmt2.executeQuery(comhabqry);
							  Hashtable com_habs_hash = new Hashtable();
							  while(rs2.next()){
								  System.out.println(rs2.getString(1)+rs2.getString(2)+rs2.getString(4)+"="+rs2.getInt(3));
								  com_habs_hash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(4),rs2.getInt(3));
							  }
								  	
							  if(stmt2!=null){
									stmt2.close();
								}
								if(rs2!=null){
									rs2.close();
								}
								///expenditure
								
								String comestcost="select substr(office_code,2,2), substr(office_code,4,1),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl d where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and a.work_id=d.work_id and to_date(DATE_OF_COMPLETION)>='01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION)<='31-Mar-"+endyr+"' ";
								if(dcode!=null && !dcode.equals("00")){
									comestcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
								}
								if(scheme!=null && !scheme.equals(""))
								{
									comestcost+=" and type_of_asset in("+scheme+") ";
								}
								comestcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
								System.out.println("comestcost i"+comestcost);
								 stmt2=conn.createStatement(); 
								  rs2=stmt2.executeQuery(comestcost);
								  Hashtable com_est_hash = new Hashtable();
								  while(rs2.next()){
									  com_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
								  }
									  	
								  if(stmt2!=null){
										stmt2.close();
									}
									if(rs2!=null){
										rs2.close();
									}	
									///expendituredir
									
									String dircomestcost="select substr(office_code,2,2), substr(office_code,4,1),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,RWS_WORK_DIRECT_VOUCHER_TBL b,rws_work_completion_tbl d where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and a.work_id=d.work_id and to_date(DATE_OF_COMPLETION)>='01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION)<='31-Mar-"+endyr+"' ";
									if(dcode!=null && !dcode.equals("00")){
										dircomestcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
									}
									if(scheme!=null && !scheme.equals(""))
									{
										dircomestcost+=" and type_of_asset in("+scheme+") ";
									}
									dircomestcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
									System.out.println("comestcost j"+comestcost);
									 stmt2=conn.createStatement(); 
									  rs2=stmt2.executeQuery(dircomestcost);
									  Hashtable dir_com_est_hash = new Hashtable();
									  while(rs2.next()){
										  dir_com_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
									  }
										  	
									  if(stmt2!=null){
											stmt2.close();
										}
										if(rs2!=null){
											rs2.close();
										}		
		//probable works
		
									 String probworkqry="select substr(office_code,2,2), substr(office_code,4,1),count(work_id),sum(case when to_char("+probstrng+") is null then 0.0  else "+probstrng+" end) from RWS_WORK_ADMN_TBL where work_cancel_dt is null  and to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"'  ";
									  if(dcode!=null && !dcode.equals("00")){
										  probworkqry+=" and substr(work_id,5,2)='"+dcode+"' ";
										}
										if(scheme!=null && !scheme.equals(""))
										{
											probworkqry+=" and type_of_asset in("+scheme+") ";
										}
										probworkqry+=" and programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
										System.out.println("probworkqry anu"+probworkqry);
									  stmt2=conn.createStatement(); 
									  rs2=stmt2.executeQuery(probworkqry);
									  Hashtable prob_works_hash = new Hashtable();
									  while(rs2.next()){
										  prob_works_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getInt(3)+"@"+rs2.getString(4));
									  }
										  	
									  if(stmt2!=null){
											stmt2.close();
										}
										if(rs2!=null){
											rs2.close();
										}
										//habs
										 String probhabqry="select substr(office_code,2,2), substr(office_code,4,1),count(distinct b.hab_code),coverage_status  from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where a.work_id=b.work_id and b.hab_code=c.hab_code and work_cancel_dt is null  and coverage_status<>'UI' and to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"' and AAP_TARGET_YEAR='"+financialstartyr+"' ";
										  if(dcode!=null && !dcode.equals("00")){
											  probhabqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
											}
											if(scheme!=null && !scheme.equals(""))
											{
												probhabqry+=" and type_of_asset in("+scheme+") ";
											}
											probhabqry+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1),coverage_status  order by  substr(office_code,2,2), substr(office_code,4,1) ";
											System.out.println("probhabqry k "+probhabqry);
											 stmt2=conn.createStatement(); 
											  rs2=stmt2.executeQuery(probhabqry);
											  Hashtable prob_habs_hash = new Hashtable();
											  while(rs2.next()){
												  prob_habs_hash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(4),rs2.getInt(3));
											  }
												  	
											  if(stmt2!=null){
													stmt2.close();
												}
												if(rs2!=null){
													rs2.close();
												}
											///expenditure
											
												String probestcost="select substr(office_code,2,2), substr(office_code,4,1),sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"' ";
												if(dcode!=null && !dcode.equals("00")){
													probestcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
												}
												if(scheme!=null && !scheme.equals(""))
												{
													probestcost+=" and type_of_asset in("+scheme+") ";
												}
												probestcost+=" and a.programme_code in ("+programe+") group by substr(office_code,2,2), substr(office_code,4,1) order by  substr(office_code,2,2), substr(office_code,4,1) ";
												System.out.println("probestcost l"+probestcost);
												 stmt2=conn.createStatement(); 
												  rs2=stmt2.executeQuery(probestcost);
												  Hashtable prob_est_hash = new Hashtable();
												  while(rs2.next()){
													  prob_est_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
												  }
													  	
												  if(stmt2!=null){
														stmt2.close();
													}
													if(rs2!=null){
														rs2.close();
													}	
		
		int totcomphabpc1=0,totcomphabpc2=0,totcomphabpc3=0,totcomphabpc4=0,totcomphabnc=0,totcomphabfc=0,totcomphabnss=0;
		int totpcomphabpc1=0,totpcomphabpc2=0,totpcomphabpc3=0,totpcomphabpc4=0,totpcomphabnc=0,totpcomphabfc=0,totpcomphabnss=0;
													
		///printing loop qry
		session.setAttribute("works_hash",works_hash);
		session.setAttribute("habs_hash",habs_hash);
		session.setAttribute("est_hash",est_hash);
		session.setAttribute("dir_est_hash",dir_est_hash);
		session.setAttribute("comp_works_hash",comp_works_hash);
		session.setAttribute("com_habs_hash",com_habs_hash);
		session.setAttribute("com_est_hash",com_est_hash);
		session.setAttribute("prob_works_hash",prob_works_hash);
		session.setAttribute("prob_habs_hash",prob_habs_hash);
		session.setAttribute("prob_est_hash",prob_est_hash);
		session.setAttribute("dur_est_hash",dur_est_hash);
		session.setAttribute("dirdur_est_hash",dirdur_est_hash);
		session.setAttribute("dir_com_est_hash",dir_com_est_hash);
		String prinqry="select b.CIRCLE_OFFICE_NAME,c.DIVISION_OFFICE_NAME,c.CIRCLE_OFFICE_CODE ,c.DIVISION_OFFICE_CODE  from RWS_CIRCLE_OFFICE_TBL b,RWS_DIVISION_OFFICE_TBL c where c.CIRCLE_OFFICE_CODE=b.CIRCLE_OFFICE_CODE and status<>'UI' ";
		if(dcode!=null && !dcode.equals("00")){
			
			prinqry+=  "   and c.CIRCLE_OFFICE_CODE='"+dcode+"'";
		}
		prinqry+= " ORDER BY c.CIRCLE_OFFICE_CODE,c.DIVISION_OFFICE_CODE";
		System.out.println("prinqry m "+prinqry);
		stmt3=conn.createStatement(); 
		 rs3=stmt3.executeQuery(prinqry);
		 int rowcount=1;
		 int totwrkcount=0,tothabcount=0,totcomwrkcount=0,totcomhabcount=0,totprobwrkcount=0,totprobhabcount=0;
		 double totbalanceest=0.0,totcombalanceest=0.0,totprobbalanceest=0.0,totexpendduring=0.0;
		  int styleCount=0;
		 String style="";
		while(rs3.next()){
			int wrkcount=0,habcount=0,comwrkcount=0,comhabcount=0,probwrkcount=0,probhabcount=0;
			int comphabpc1=0,comphabpc2=0,comphabpc3=0,comphabpc4=0,comphabnc=0,comphabfc=0,comphabnss=0;
			 int pcomphabpc1=0,pcomphabpc2=0,pcomphabpc3=0,pcomphabpc4=0,pcomphabnc=0,pcomphabfc=0,pcomphabnss=0;
			
			double direxpendduring=0.0,expendduring=0.0,sanctionamnt=0.0,dirvouchamnt=0.0,vouchamnt=0.0,balanceest=0.0,comsanctionamnt=0.0,comvouchamnt=0.0,combalanceest=0.0,probsanctionamnt=0.0,probvouchamnt=0.0,probbalanceest=0.0;
			if(works_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				
				
				 String workssource = (String) works_hash.get(rs3.getString(3)+rs3.getString(4));
					String wrkvalues[] = workssource.split("@");
					wrkcount=Integer.parseInt(wrkvalues[0]);
					if(!wrkvalues[1].equals("")||wrkvalues[1]!=null){
					sanctionamnt=Double.parseDouble(wrkvalues[1]);}
			}
			if(habs_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				habcount=(Integer)habs_hash.get(rs3.getString(3)+rs3.getString(4));
				
			}
			if(est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				vouchamnt=Double.parseDouble((String)est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			if(dir_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				dirvouchamnt=Double.parseDouble((String)dir_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			balanceest=sanctionamnt-(vouchamnt+dirvouchamnt);
			if(comp_works_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				
				
				 String workssource = (String) comp_works_hash.get(rs3.getString(3)+rs3.getString(4));
					String wrkvalues[] = workssource.split("@");
					comwrkcount=Integer.parseInt(wrkvalues[0]);
					if(!wrkvalues[1].equals("")||wrkvalues[1]!=null){
					comsanctionamnt=Double.parseDouble(wrkvalues[1]);}
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC1")!=null){
				comphabpc1=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC1");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"PC1"+"="+comphabpc1);
				
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC2")!=null){
				comphabpc2=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC2");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"PC2"+"="+comphabpc2);
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC3")!=null){
				comphabpc3=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC3");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"PC3"+"="+comphabpc3);
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC4")!=null){
				comphabpc4=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC4");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"PC4"+"="+comphabpc4);
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NC")!=null){
				comphabnc=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NC");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"NC"+"="+comphabnc);
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"FC")!=null){
				comphabfc=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"FC");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"FC"+"="+comphabfc);
			}
			if(com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NSS")!=null){
				comphabnss=(Integer)com_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NSS");
				System.out.println(rs3.getString(3)+rs3.getString(4)+"NSS"+"="+comphabnss);
			}
			comhabcount=comphabpc1+comphabpc2+comphabpc3+comphabpc4+comphabnc+comphabfc+comphabnss;
			if(com_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				comvouchamnt=Double.parseDouble((String)com_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			if(dir_com_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				comvouchamnt+=Double.parseDouble((String)dir_com_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			if(prob_works_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				
				
				 String workssource = (String) prob_works_hash.get(rs3.getString(3)+rs3.getString(4));
					String wrkvalues[] = workssource.split("@");
					probwrkcount=Integer.parseInt(wrkvalues[0]);
					if(!wrkvalues[1].equals("")||wrkvalues[1]!=null){
					probsanctionamnt=Double.parseDouble(wrkvalues[1]);}
			}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC1")!=null){
				pcomphabpc1=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC1");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC2")!=null){
				pcomphabpc2=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC2");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC3")!=null){
				pcomphabpc3=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC3");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC4")!=null){
				pcomphabpc4=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"PC4");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NC")!=null){
				pcomphabnc=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NC");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"FC")!=null){
				pcomphabfc=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"FC");
						}
			if(prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NSS")!=null){
				pcomphabnss=(Integer)prob_habs_hash.get(rs3.getString(3)+rs3.getString(4)+"NSS");
						}
			probhabcount=pcomphabnss+pcomphabfc+pcomphabnc+pcomphabpc1+pcomphabpc2+pcomphabpc3+pcomphabpc4;
			if(prob_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				probvouchamnt=Double.parseDouble((String)prob_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			if(dur_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				expendduring=Double.parseDouble((String)dur_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			if(dirdur_est_hash.get(rs3.getString(3)+rs3.getString(4))!=null){
				direxpendduring=Double.parseDouble((String)dirdur_est_hash.get(rs3.getString(3)+rs3.getString(4)));
				
			}
			
			System.out.println("vou ="+vouchamnt+" expendduring="+expendduring);
			combalanceest=comvouchamnt;
			probbalanceest=probsanctionamnt;
			 if(dname.equals(rs3.getString(1))||temp.equals(rs3.getString(1))){
          	   dname="-";
             }else{
          	   dname=rs3.getString(1);
             }
			
			 
			 if(styleCount%2==0){
 				 style="gridbg1";
 			 }else{
 				 style="gridbg2";
 			 }
 			 styleCount++;
			%>
			<tr>
			<td class=<%=style %> style="text-align: left;"><%=rowcount %></td>
			<td class=<%=style %> style="text-align: left;"><%=dname %></td>
			<td class=<%=style %> style="text-align: left;"><%=rs3.getString(2) %></td>
			<td class=<%=style %> style="text-align: right;"><%=wrkcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=habcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(expendduring+direxpendduring) %></td>
			
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(balanceest) %></td>
			<td class=<%=style %> style="text-align: right;"><%=comwrkcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=comhabcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabpc1 %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabpc2 %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabpc3 %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabpc4 %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabfc %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabnc %></td>
			<td class=<%=style %> style="text-align: right;"><%=comphabnss %></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(combalanceest) %></td>
			<td class=<%=style %> style="text-align: right;"><%=probwrkcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=probhabcount %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabpc1 %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabpc2 %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabpc3 %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabpc4 %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabfc %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabnc %></td>
			<td class=<%=style %> style="text-align: right;"><%=pcomphabnss %></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(probbalanceest) %></td>
				</tr>
			<%
			totwrkcount+=wrkcount;
			tothabcount+=habcount;
			totbalanceest+=balanceest;
			totcomwrkcount+=comwrkcount;
			totcomhabcount+=comhabcount;
			totcombalanceest+=combalanceest;
			totprobwrkcount+=probwrkcount;
			totprobhabcount+=probhabcount;
			totprobbalanceest+=probbalanceest;
			totexpendduring+=(expendduring+direxpendduring);
			totcomphabpc1+=comphabpc1;
			totcomphabpc2+=comphabpc2;
			totcomphabpc3+=comphabpc3;
			totcomphabpc4+=comphabpc4;
			totcomphabfc+=comphabfc;
			totcomphabnc+=comphabnc;
			totcomphabnss+=comphabnss;
			
			totpcomphabpc1+=pcomphabpc1;
			totpcomphabpc2+=pcomphabpc2;
			totpcomphabpc3+=pcomphabpc3;
			totpcomphabpc4+=pcomphabpc4;
			totpcomphabfc+=pcomphabfc;
			totpcomphabnc+=pcomphabnc;
			totpcomphabnss+=pcomphabnss;
			rowcount++;
			temp=rs3.getString(1);
		}
		%>
		<tr>
		<td class="gridhdbg" style="text-align: center;" colspan="3">Grand Total</td>
		<td class="gridhdbg" style="text-align: right;"><%=totwrkcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=tothabcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totexpendduring) %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totbalanceest) %></td>
			
			<td class="gridhdbg" style="text-align: right;"><%=totcomwrkcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomhabcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabpc1 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabpc2 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabpc3 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabpc4 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabfc %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabnc %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totcomphabnss %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totcombalanceest) %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totprobwrkcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totprobhabcount %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabpc1 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabpc2 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabpc3 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabpc4 %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabfc %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabnc %></td>
			<td class="gridhdbg" style="text-align: right;"><%=totpcomphabnss %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totprobbalanceest) %></td>
			
		</tr>
		
		<%
		
		
		 if(stmt3!=null){
				stmt3.close();
			}
			if(rs3!=null){
				rs3.close();
			}
		
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>