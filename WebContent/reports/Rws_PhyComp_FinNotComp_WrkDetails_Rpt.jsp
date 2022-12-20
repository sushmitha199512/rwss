<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
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
<style>
tr.even {
  background-color: #ddd;
  width:20px;
  height:15px;
}
tr.odd {
  background-color: #eee;
  width:20px;
  height:15px;
  }
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";

     String completionDate=null;String message=null;

   
message="Works which are completed in last Financial Year but releases are still in Progress";
																		
	
    double aas=0;
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}



	if(request.getParameter("finyear")!=null){
	financialyr=request.getParameter("finyear");
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
   
session.setAttribute("financialyr",financialyr);

    //schemes
String scheme="";
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("scheme",scheme);
}

	String yr =financialyr.substring(0,4);
	////System.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
    String prvyr=""+(Integer.parseInt(yr)-1);
	String nextyr=""+(Integer.parseInt(yr)+1);
	////System.out.println("nextyr:"+nextyr);
    String subnextyr=nextyr.substring(2,4);
    //System.out.println("subnextyr:"+subnextyr);
	
	String[] programes=request.getParameterValues("program");
	
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-2);
session.setAttribute("programe",programe);
	System.out.println("programe::"+programe);
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
   ////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
   //System.out.println("fin ear::"+yr+"sys year::"+sysyear);
   if(yr.equals(sysyear))
   {
     prevyear=yy;
     prevmon=mon-1;
     //System.out.println("else prevyear::"+prevyear+"prevmon::"+prevmon);
    
   }
  else
	{
    prevyear=yy; 
    prevmon=2;
    //System.out.println("if prevyear::"+prevyear+"prevmon::"+prevmon);     
	}
   
  
String mymon=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();


String yr1="",yr2="";
//System.out.println("nextmonth"+nextmonth);
if(nextmonth.equals("JAN") || nextmonth.equals("FEB") ||  nextmonth.equals("MAR")){
//System.out.println("YYYYN"+yr1);
 yr2=""+(Integer.parseInt(yr)+1);
}else{
yr2=yr;
}

if(cmonth.equals("JAN") || cmonth.equals("FEB") || cmonth.equals("MAR")){
//System.out.println("YYYYC"+yr1);
 yr1=""+(Integer.parseInt(yr)+1);
}else{
 yr1=yr;
}


String dcode=request.getParameter("district");
if(dcode!=null && !dcode.equals(""))
{
	  session.setAttribute("dcode",dcode);
}
	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./Rws_PhyComp_FinNotComp_WrkDetails_Excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="gridhdbg" align="center"><font  color="orange" ><b>Note:<%=message %></b></font></td></tr>
	</table>
	
	
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  style="border-collapse:collapse"  align = "center">
<tr >
		<td align="center" class="gridhdbg" colspan=19>Physically Completed - Financially Not Completed Works Details - <font color="yellow"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=gridhdbg rowspan=2>Sl.No</td>
		<td class=gridhdbg rowspan=2>District</td>
		<td class=gridhdbg rowspan=2>Work_id</td>
		<td class=gridhdbg rowspan=2>Work_Name</td>
		<td class=gridhdbg rowspan=2>Sanction Amount</td>
		 <td class=gridhdbg rowspan=2>Exp upto 31 Mar 2013(Total)</td>
		<td class=gridhdbg rowspan=2>Exp during 13-14(Total)</td>
		<td class=gridhdbg rowspan=2>Hab_Code</td>
		<td class=gridhdbg rowspan=2>Hab_Name</td>
		<td class=gridhdbg colspan=4>Population</td>
		<td class=gridhdbg rowspan=2>Clause of Hab</td>		
        <td class=gridhdbg rowspan=2>Exp upto 31 Mar 2013</td>
        <td class=gridhdbg colspan=3>Exp during 13-14</td>
        <td class=gridhdbg rowspan=2>Subplan Submitted</td>
        
</tr>
<tr>
		<td class=gridhdbg align="center">Plain </td>
		<td class=gridhdbg align="center">SC</td>
        <td class=gridhdbg align="center">ST</td>
        <td class=gridhdbg align="center">Total</td>
        <td class=gridhdbg align="center">Total</td>
        <td class=gridhdbg align="center">State Share SC</td>
        <td class=gridhdbg align="center">State Share ST</td>
</tr>
<tr>
<%

for(int i=1;i<=19;i++)
{
%>
	<td class=gridhdbg align="center"><%=i %> </td>
<%
}
%>


</tr>
<%
Statement stmt2=null,stmt4=null,stmt5=null;
ResultSet rs1=null,rs4=null,rs5=null;
int count=1;
  try
  {
    stmt5=conn.createStatement();  
    
    double gexp_amt=0,gdexp_amt=0,sanction_amt=0.0,gghsanction_amt=0,ggsanction_amt=0,gghexp_amt=0,ggghdexp_amt=0,ggsc_hdexp=0,ggst_hdexp=0,gghdexp_amt=0,ggexp_amt=0,ggdexp_amt=0;
    String dname="",work_id="",work_name="",prg_code="";
    String habs="",clauseType="",clauseType1="";
    int styleCount=0;
    String style="";
    int ggplainPOP=0,ggscPOP=0,ggstPOP=0,ggtotpop=0;
    String exp="",pop_exp="";
   ////////////////////////////   
    
   
   
    
	String popQery="select W.WORK_ID, sum(census_plain_popu),sum(census_sc_popu),sum(census_st_popu) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_admn_hab_lnk_tbl l ,rws_habitation_directory_tbl hd  where w.work_id=l.work_id and l.hab_code=hd.hab_code ";

	 if(dcode!=null && !dcode.equals("00")){
		 popQery+="and D.DCODE='"+dcode+"'";
		}

		if(scheme!=null && !scheme.equals("")){
			popQery+="and w.type_of_asset in("+scheme+")";
		}
 
		popQery+=" and  w.programme_code in ("+programe+")   and w.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) group by  w.work_id order by 1";

	
		System.out.println("popQery.."+popQery);
	 	rs5=stmt5.executeQuery(popQery);
	 	Hashtable popQeryHash=new Hashtable();
	  	while(rs5.next()){
	  		  	
	  		popQeryHash.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3)+"@"+rs5.getString(4));
	  	}
	
	  if(rs5!=null)rs5.close();
		if(stmt5!=null)stmt5.close();	
	
   /////////   
   
	    String WorksExpenPrev="select a.work_id,(sum(case when (to_date(voucher_dt)<'01-Apr-"+yr+"' ) then voucher_amt else 0 end)/100000),(sum(case when (to_date(voucher_dt) > '01-Apr-"+yr+"' ) then voucher_amt else 0 end)/100000)    from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id=b.work_id  ";
	    if(dcode!=null && !dcode.equals("00"))
	    {
	    	WorksExpenPrev+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	    } 
	   if(scheme!=null && !scheme.equals(""))
	    {
		   WorksExpenPrev+="and a.type_of_asset in("+scheme+")";
	    }
	   WorksExpenPrev+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) group by  a.work_id order by 1";

   		stmt4=conn.createStatement();
       // System.out.println("WorksExpenPrev"+WorksExpenPrev);
	   	rs4=stmt4.executeQuery(WorksExpenPrev);
	   	Hashtable WorksExpenPrevHash=new Hashtable();
	   	while(rs4.next())
	   	{
	   		WorksExpenPrevHash.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3));
	   	}
	   	if(rs4!=null)rs4.close();
	   	if(stmt4!=null)stmt4.close();

    
    String worksQuery="select b.dcode,b.dname,a.work_id,a.Work_name,c.programme_code,sum(sanction_amount),nvl(SPECIAL_CAT,'-'),NO_OF_HABS,CATEGORY_CODE from rws_work_admn_tbl a,rws_district_tbl b ,rws_programme_tbl c where a.programme_code=c.programme_code and a.work_cancel_dt is null and substr(a.work_id,5,2)=b.dcode";
    if(dcode!=null && !dcode.equals("00"))
    {
    	worksQuery+=" and b.DCODE='"+dcode+"' ";
    }
    if(scheme!=null && !scheme.equals(""))
    {
    	worksQuery+=" and a.type_of_asset in("+scheme+")";
    }
        worksQuery+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null)";
        worksQuery+=" group by b.dcode ,b.dname,a.work_id,a.work_name,c.programme_code,SPECIAL_CAT,NO_OF_HABS,CATEGORY_CODE order by 1";

   	Statement stmt3=conn.createStatement();
    System.out.println("worksQuery...."+worksQuery);
   	ResultSet rs3=stmt3.executeQuery(worksQuery);
   	Hashtable worksHash=new Hashtable();
   	while(rs3.next())
   	{  
   		boolean flag=true;
   		double plainPer=0,scPer=0,stPer=0,plainPOP=0,scPOP=0,stPOP=0;
   		double hsanction_amt=0.0;
   		double exp_amt=0,hexp_amt=0,dexp_amt=0,hdexp_amt=0;
   		double stateshare=0,sc_hdexp=0,st_hdexp=0;
   	    double ghsanction_amt=0,gsanction_amt=0,ghexp_amt=0,ghdexp_amt=0,gsc_hdexp=0,gst_hdexp=0,gplainPer=0,gscPer=0,gstPer=0;
   	    double   gplainPOP=0,gscPOP=0,gstPOP=0;
   	    int totpop=0,gtotpop=0,pop1=0,pop2=0,pop3=0;
   	    
   	    String subPlanSubmitted=rs3.getString(7);
   		
   	    dname=rs3.getString(2);
   	    work_id=rs3.getString(3);
   	    work_name=rs3.getString(4);
   	    prg_code=rs3.getString(5);
   	    sanction_amt=rs3.getDouble(6);
   	    
   	    String nHabsStr=rs3.getString(8);
		if(nHabsStr==null || nHabsStr.equals(""))
		{
			nHabsStr="0";
		}
		int noofHabs=Integer.parseInt(nHabsStr);
		
   	    
		String categoryCode=rs3.getString(9);
   	    
	   	  
   	    
   	    
   	    
   	    
   	    
   	   //if( WorksExpenPrevHash.get(rs1.getString(3))!=null)
   	    exp=(String)WorksExpenPrevHash.get(rs3.getString(3));
	   	if(exp!=null)
	   	{
	   	String []aa=exp.split("@");
	   	String a1=aa[0];
	   	String a2=aa[1];
	   	exp_amt=Double.parseDouble(a1);
	   	dexp_amt=Double.parseDouble(a2);
	   	}
   	    
	   	gexp_amt+=exp_amt;
	   
	   	
	   	
	   	
 		gdexp_amt+=dexp_amt;
	   	
 		
 		
 		
	   	
	   	if(prg_code!=null && (prg_code.equals("01") || prg_code.equals("18") || prg_code.equals("49") || prg_code.equals("51") || prg_code.equals("23")|| prg_code.equals("02") ))
	   	{
			
	   		stateshare=0.5*dexp_amt;
	   		
	   	
	   	}
	   	else if(prg_code!=null && (prg_code.equals("65") || prg_code.equals("12") || prg_code.equals("46")|| prg_code.equals("57")|| prg_code.equals("04")|| prg_code.equals("09")|| prg_code.equals("39") || prg_code.equals("15") ))
	   	{
	   		stateshare=dexp_amt;
	   		
	   	}
	   	
	   	if(work_id.substring(4,6)!=null&& work_id.substring(4,6).equals("12") && prg_code.equals("58"))
		{
	   		stateshare=0.0;
	   		
		}
   	    
	   	%>
	   	
	   	<tr>
    	<td class="gridbg1" style="text-align: left;"  onmouseover="Tip('SLNO',TITLE,'Information')" onmouseout="UnTip()"><%=count++ %></td>
    	<td class="gridbg1" style="text-align: left;"  onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()"><%=dname %></td>  
        <td class="gridbg1" style="text-align: left;"  onmouseover="Tip('Work Id',TITLE,'Information')" onmouseout="UnTip()"><%=work_id  %></td>
	 	<td class="gridbg1" style="text-align: left;"  onmouseover="Tip('Work Name',TITLE,'Information')" onmouseout="UnTip()"><%=work_name %></td>
        <td class="gridbg1" style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(sanction_amt)%></td> 
      	<td  class="gridbg1" style="text-align: right;"  onmouseover="Tip('Exp Upto Prev Fin Yr Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(exp_amt)%></td>
    	<td  class="gridbg1"  style="text-align: right;"  onmouseover="Tip('Exp Upto Yr Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(dexp_amt)%></td>
    	
    
	   	
    	<%
    	int i=1;
    	String habsQuery="select a.panch_code,a.panch_name,b.census_plain_popu,b.census_sc_popu,b.census_st_popu from rws_panchayat_raj_tbl a,rws_habitation_directory_tbl b ,";
    	      habsQuery+="rws_work_admn_tbl c,rws_admn_hab_lnk_tbl l where  c.work_id=l.work_id and l.hab_code=a.panch_code and l.hab_Code=b.hab_code and c.work_id='"+rs3.getString(3)+"' " ;
    	stmt2=conn.createStatement();
    	//System.out.println("habsQuery....."+habsQuery);
    	ResultSet rs2=stmt2.executeQuery(habsQuery);
     	while(rs2.next())
    	  {
     		
     		
     		
     		plainPOP=Double.parseDouble(rs2.getString(3));
     		scPOP=Double.parseDouble(rs2.getString(4));
     		stPOP=Double.parseDouble(rs2.getString(5));
     		
     			
     		totpop=Integer.parseInt(rs2.getString(3))+ Integer.parseInt(rs2.getString(4))+Integer.parseInt(rs2.getString(5));
     		
     		
     		plainPer = (plainPOP * 100/ totpop);
	 		scPer = (scPOP * 100/ totpop);
	 		stPer = (stPOP * 100/ totpop);
     		
     		if(scPer>=40)
     		{
     			clauseType="SC>40%";
     		}
     		else if(stPer>=40)
     		{
     			clauseType="ST>40%";
     		}
    	  else 
    	  {
				if(scPOP==0 && stPOP==0)
				{
					clauseType="Plain Hab";
				}
				else
				{
				clauseType="< 40%";
				}
    	  }
     		//////////////grand totals/////////
     		
     		gplainPOP+=plainPOP;
     		gscPOP+=scPOP;
     		gstPOP+=stPOP;
     		gtotpop+=totpop;
     		
     		ggplainPOP+=plainPOP;
     		ggscPOP+=scPOP;
     		ggstPOP+=stPOP;
     		ggtotpop+=totpop;
     		
     		
     		gplainPer = (gplainPOP * 100/ gtotpop);
	 		gscPer = (gscPOP * 100/ gtotpop);
	 		gstPer = (gstPOP * 100/ gtotpop);
	 		
	 		if(gscPer>=40)
     		{
     			clauseType1="SC>40%";
     		}
     		else if(gstPer>=40)
     		{
     			clauseType1="ST>40%";
     		}
    	  else 
    	  {
				if(gscPOP==0 && gstPOP==0)
				{
					clauseType1="Plain Hab";
				}
				else
				{
				clauseType1="< 40%";
				}
    	  }
     		
	 		hsanction_amt=(sanction_amt/gtotpop)*totpop;
	 		
     		gsanction_amt+=sanction_amt;
     		
     			
     		double myamt=0,scstate=0,ststate=0;
     		
     		
     		int totPop_exp=0;
			 pop_exp=(String)popQeryHash.get(rs3.getString(3));
		    if(pop_exp!=null)
		    {
			 String popValues_exp[]=pop_exp.split("@");
			 
	 		  double plainPOP_exp=Double.parseDouble(popValues_exp[0]);
	 		  double scPOP_exp=Double.parseDouble(popValues_exp[1]);
	 		  double stPOP_exp=Double.parseDouble(popValues_exp[2]);
	 		  totPop_exp=Integer.parseInt(popValues_exp[0])+Integer.parseInt(popValues_exp[1])+Integer.parseInt(popValues_exp[2]);
		    
	 		 hexp_amt=(exp_amt/totPop_exp)*totpop;
	 		 hdexp_amt=(dexp_amt/totPop_exp)*totpop;
	 		 
	 		 //sc_hdexp=(stateshare/scPOP_exp)*scPOP;
     		// st_hdexp=(stateshare/stPOP_exp)*stPOP;
     		 
     		   myamt=(stateshare/totPop_exp);
     		  
     		   sc_hdexp=myamt*scPOP;
     		   st_hdexp=myamt*stPOP;
		    }
     		     		
     		ghexp_amt+=hexp_amt;
     		gghexp_amt+=hexp_amt;
     		
     		
     		ghdexp_amt+=hdexp_amt;
     		
     		gghdexp_amt+=hdexp_amt;
     		
     		
     		
     		gsc_hdexp+=sc_hdexp;
     		gst_hdexp+=st_hdexp;
     		
     		ggsc_hdexp+=sc_hdexp;
     		ggst_hdexp+=st_hdexp;
     		
     		if(styleCount%2==0)
     		{
   			 style="gridbg1";
   		    }
     		else
     		{
   			 style="gridbg2";
   		     }
   		   styleCount++;
   		  
   		   if(dname.equals("-")){
   			   
   			   %>
   			   <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()">-</td>
   			   <% 
   		   }
   		   
   		 if(i>1)
   		 {
    	%>
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
        <td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sanction Amount',TITLE,'Information')" onmouseout="UnTip()" >-</td> 
    
    	<%
    	}
   		 
   		%>
  
     	    	
    	<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Hab Code',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(1) %></td>  
    	<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Hab Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(2) %></td>  
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Plain POP',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(3) %></td>  
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('SC POP',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(4) %></td>  
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('ST POP',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(5) %></td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Total POP',TITLE,'Information')" onmouseout="UnTip()"><%=totpop%></td> 
    	<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Clause Type',TITLE,'Information')" onmouseout="UnTip()"><%=clauseType%></td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Exp Amt',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(hexp_amt)%></td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('During Exp Amt Type',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(hdexp_amt)%></td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('SC State Share During Amt',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(sc_hdexp)%></td> 
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('ST State Share During Amt',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(st_hdexp)%></td>
    	<td class=<%=style %> style="text-align: right;"  onmouseover="Tip('Sub Plan Submitted',TITLE,'Information')" onmouseout="UnTip()"><%= subPlanSubmitted %></td>
    	 
    	</tr> 
    	<%
    	dname="-";
    	work_id="-";
    	work_name="-";
    	i++;
    	//System.out.println(rs3.getString(3)+"...."+rs2.getString(1)+"..."+i);
    	  }
     	
     	if(categoryCode.equals("1") || noofHabs>1)
     	{
		 	%>
      
     	<tr>     	
     	<td  class=gridhdbg style="text-align: right;"   colspan="4">&nbsp;Totals</td>
     	
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(sanction_amt)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(exp_amt)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(dexp_amt)%></td>
        <td  class=gridhdbg>-</td>
     	<td  class=gridhdbg>-</td>
     	<td  class=gridhdbg style="text-align: right;"  ><%=(int)gplainPOP%></td>
     	<td  class=gridhdbg style="text-align: right;"  ><%=(int)gscPOP%></td> 
     	<td  class=gridhdbg style="text-align: right;" ><%=(int)gstPOP%></td> 
     	<td  class=gridhdbg style="text-align: right;"  ><%=gtotpop%></td> 
     	<td  class=gridhdbg align="center"><%=clauseType1%></td> 
     	<td  class=gridhdbg style="text-align: right;"  ><%=ndf.format(ghexp_amt)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(ghdexp_amt)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(gsc_hdexp)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(gst_hdexp)%></td>
     	<td class=gridhdbg style="text-align: center;"  onmouseover="Tip('Sub Plan Submitted',TITLE,'Information')" onmouseout="UnTip()"><%= subPlanSubmitted %></td>
    	</tr>
	<%
	
	//gexp_amt=0;
	//gdexp_amt=0;
	
     	}
 		ggsanction_amt+=sanction_amt;
 		ggexp_amt+=exp_amt;
 		ggdexp_amt+=dexp_amt;
 		
     	sanction_amt=0;
   
	}
	%>
       <tr>
          <td colspan="4" class=gridhdbg align=right>Ground Total:</td>
          <td  class=gridhdbg style="text-align: right;"  ><%=ndf.format(ggsanction_amt)%></td>
         <td  class=gridhdbg style="text-align: right;" ><%=ndf.format(ggexp_amt)%></td>
     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(ggdexp_amt)%></td>
        <td  class=gridhdbg>-</td>
     	  <td  class=gridhdbg>-</td>
          <td  class=gridhdbg align="right"><%=ggplainPOP%></td>
	     	<td  class=gridhdbg align="right"><%=ggscPOP%></td> 
	     	<td  class=gridhdbg align="right"><%=ggstPOP%></td> 
	     	<td  class=gridhdbg align="right"><%=ggtotpop%></td> 
	     	<td  class=gridhdbg align="center">-</td> 
	     	<td  class=gridhdbg align="center"><%=ndf.format(gghexp_amt)%></td> 
	     	<td  class=gridhdbg style="text-align: right;"  ><%=ndf.format(gghdexp_amt)%></td>
	     	<td  class=gridhdbg style="text-align: right;"  ><%=ndf.format(ggsc_hdexp)%></td>
	     	<td  class=gridhdbg style="text-align: right;" ><%=ndf.format(ggst_hdexp)%></td>
	     	<td  class=gridhdbg style="text-align: right;" >-</td>
	       </tr>
    	
  <% 	

  }
  
  
  catch(Exception e)
  {
  e.printStackTrace();
   }

 %>

</table>	
</html>