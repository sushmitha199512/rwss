<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "ALL Schemes AAP Report.xls");

%>

	<% 

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="",nextfinancialstartyr="",nxtfinancialstartyr="";
           String pname="",distname="" ,myreptype="";
        		 int  nextyr=0;

	pname=(String)session.getAttribute("pname");
	myreptype=(String)session.getAttribute("myreptype");
	nextyr=(Integer)session.getAttribute("nextyr");
	financialstartyr=(String)session.getAttribute("financialyr");
	nextfinancialstartyr=(String)session.getAttribute("nextfinancialstartyr");
	nxtfinancialstartyr=(String)session.getAttribute("nxtfinancialstartyr");
	
	distname=(String)session.getAttribute("distname");
	String scheme=(String)session.getAttribute("scheme");

	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
      	

    String programe=(String)session.getAttribute("programe");
	String sysdate=workData.getDate();
    String sysmon=sysdate.substring(3,5);
    int mon=Integer.parseInt(sysmon);
     String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);

   int prevyear=0,prevmon=0;String fyear,fyear1;

String prevmonth=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

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
//////System.out.println("Startyr2:"+startyr2 );
//////System.out.println("Endyr:"+endyr );

//////System.out.println("Endyr2:"+endyr1);


     //////System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");

 

	%>
	

		<%
		Statement stmt1 = null, stmt2 = null, stmt3 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null;
		String spillValues = "", newValues = "", augValues = "", spillexpValues = "", mainValues = "", spill_compValues = "", spill_compexpValues = "", new_compValues = "", aug_compValues = "", main_compValues = "", spill_tarValues = "", new_tarValues = "", aug_tarValues = "", main_tarValues = "";
		String spill_habs = "", new_habs = "", aug_habs = "", main_habs = "", spill_comphabs = "", new_comphabs = "", aug_comphabs = "", main_comphabs = "", spill_tarhabs = "", new_tarhabs = "", aug_tarhabs = "", main_tarhabs = "";
		int newcnt = 0, spillcnt = 0, augcnt = 0, maincnt = 0, gtot1 = 0, gtot3 = 0, gtot4 = 0, spillcompcnt = 0, newcompcnt = 0, augcompcnt = 0, maincompcnt = 0, spilltarcnt = 0, newtarcnt = 0, augtarcnt = 0, maintarcnt = 0, spillanicnt = 0, newanticnt = 0, auganticnt = 0, mainanticnt = 0, bfivecnt = 0, bfivecompcnt = 0, bfiveanticnt = 0, bfivetarcnt = 0, lbfivecnt = 0, lbfivecompcnt = 0, lbfiveanticnt = 0, lbfivetarcnt = 0;
		double new_amt = 0, spill_amt = 0, aug_amt = 0, spill_exp = 0,spill_antiexp = 0,spill_tarexp = 0, spillsan_amt = 0, main_amt = 0, spill_compamt = 0, spill_compexp = 0, spill_compcost = 0, new_compamt = 0, aug_compamt = 0, main_compamt = 0, spill_taramt = 0, new_taramt = 0, aug_taramt = 0, main_taramt = 0, spill_aniamt = 0, new_antiamt = 0, aug_antiamt = 0, main_antiamt = 0, bfive_amt = 0, bfive_compamt = 0, bfive_antiamt = 0, bfive_taramt = 0, lbfive_amt = 0, lbfive_compamt = 0, lbfive_antiamt = 0, lbfive_taramt = 0;
		double gtot2 = 0, ggtot = 0;
		int spill_habcnt = 0, new_habcnt = 0, aug_habcnt = 0, main_habcnt = 0, spill_comphabcnt = 0, new_comphabcnt = 0, aug_comphabcnt = 0, main_comphabcnt = 0, spill_tarhabcnt = 0, new_tarhabcnt = 0, aug_tarhabcnt = 0, main_tarhabcnt = 0, spill_anihabcnt = 0, new_antihabcnt = 0, aug_antihabcnt = 0, main_antihabcnt = 0, bfive_habcnt = 0, bfive_comphabcnt = 0, bfive_antihabcnt = 0, bfive_tarhabcnt = 0, lbfive_habcnt = 0, lbfive_comphabcnt = 0, lbfive_antihabcnt = 0, lbfive_tarhabcnt = 0;
        int augnewcnt = 0, augspillcnt = 0,augspillAnticnt = 0,augspill_habcnt = 0, augnew_habcnt = 0,augspill_antihabcnt = 0, augnew_antihabcnt = 0,augnewAnticnt = 0,augspill_targethabcnt = 0, augnew_targethabcnt = 0,augspillTargetcnt = 0,augnewTargetcnt = 0;
        int  mainnewcnt = 0, mainspillcnt = 0,mainspillAnticnt = 0,mainspill_habcnt = 0, mainnew_habcnt = 0,mainspill_antihabcnt = 0, mainnew_antihabcnt = 0,mainnewAnticnt = 0,mainspill_targethabcnt = 0, mainnew_targethabcnt = 0,mainspillTargetcnt = 0,mainnewTargetcnt = 0;
        double augnew_amt = 0, augspill_amt = 0,augnew_antiamt = 0, augspill_antiamt = 0,augnew_targetamt = 0, augspill_targetamt = 0,augspill_exp = 0,augspill_antiexp = 0,augspill_targetexp = 0,augspill_compexp = 0;
        double mainnew_amt = 0, mainspill_amt = 0,mainspill_exp = 0,mainnew_antiamt = 0, mainspill_antiamt = 0,mainspill_antiexp = 0,mainnew_targetamt = 0,mainspill_targetexp = 0, mainspill_targetamt = 0;
        //int mainnewcnt = 0,mainspillcnt = 0,mainspill_habcnt = 0,mainnew_habcnt = 0;
       // double mainnew_amt = 0,mainspill_amt = 0;
        int gnewcnt = 0,gspillcnt = 0,gspill_habcnt = 0,gnew_habcnt = 0;
        double gnew_amt = 0,gspill_amt = 0;
        int lnewcnt = 0,lspillcnt = 0,lspill_habcnt = 0,lnew_habcnt = 0;
        double lnew_amt = 0,lspill_amt = 0,gspill_exp = 0;
       
        int augspillcompcnt = 0, augnewcompcnt = 0,augspill_comphabcnt = 0, augnew_comphabcnt = 0;
        double augspill_compamt = 0,augnew_compamt=0;
        int mainspillcompcnt = 0, mainnewcompcnt = 0,mainspill_comphabcnt = 0, mainnew_comphabcnt = 0;
        double mainspill_compamt = 0,mainspill_compexp = 0,mainnew_compamt=0;
        int gnew_tarhabcnt=0,gspill_tarhabcnt=0,gnew_antihabcnt=0,gspill_antihabcnt=0,gnew_comphabcnt=0,gspill_comphabcnt=0,gspillhabcnt=0,gnewhabcnt=0,gspillcompcnt=0,gnewcompcnt=0,gspillcomphabcnt=0,gnewcomphabcnt=0,gspillanticnt=0,gnewanticnt=0,gspillantihabcnt=0,gnewantihabcnt=0,gspilltarcnt=0,gnewtarcnt=0,gspilltarhabcnt=0,gnewtarhabcnt=0;
		double gnew_taramt=0,gspill_comexp =0, gspill_compamt=0,gspill_compexp=0,gspill_antiamt=0,gspill_antiexp=0,gspill_taramt=0,gspill_tarexp=0;
        double gnew_compamt=0,gnew_antiamt=0,lspill_exp=0,lspill_compamt=0,lspill_compexp =0,lnew_compamt=0,lspill_antiamt=0,lspill_antiexp=0,lnew_antiamt =0,lspill_taramt=0,lspill_tarexp=0,lnew_taramt =0,lspill_comexp =0;
        int lspillcompcnt=0,lspill_comphabcnt=0,lnewcompcnt=0,lnew_comphabcnt=0,lspillanticnt =0,lspill_antihabcnt=0,lnewanticnt=0,lnew_antihabcnt=0,lspilltarcnt=0,lspill_tarhabcnt=0,lnewtarcnt=0,lnew_tarhabcnt=0,lspillcomphabcnt =0,lnewcomphabcnt =0,lspillantihabcnt=0,lnewantihabcnt=0,lspilltarhabcnt=0,lnewtarhabcnt =0;
		//////////////pop varibales//////////////////////////////////
		String work_id="";
		int ppop=0,scpop=0,stpop=0,totpop=0;
		double plainper=0,scper=0,stper=0;
		////////////////////////////////////////////////
          String myids="",myids1="",myids2="",plainworks="",scworks="",stworks="",worksType="";
		double spill_direxp=0,spill_compdirexp=0,spill_antidirexp=0,spill_tardirexp=0,augspill_direxp=0,augspill_compdirexp=0,augspill_antidirexp=0,augspill_targetdirexp=0;
		double mainspill_direxp=0,mainspill_compdirexp=0,mainspill_antidirexp=0,mainspill_targetdirexp=0;
		double gspill_direxp=0, gspill_compdirexp=0,gspill_antidirexp=0,gspill_tardirexp=0;
		double lspill_direxp=0, lspill_compdirexp=0,lspill_antidirexp=0,lspill_tardirexp=0;
        try {

			stmt1 = conn.createStatement();

			int styleCount = 0, recCount = 0;
			String style = "", dname = "", prg_code = "";

		
	////////////////////////////////////////////Spill Works Population//////////////////////////////////////////////////////////////////////////////////////////		
			
			
			
		    stmt2 = conn.createStatement();
			String PopQuery = "select distinct a.work_id,sum(census_plain_popu),sum(census_sc_popu),sum(census_st_popu),sum(census_plain_popu+census_sc_popu+census_st_popu) FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id  and b.hab_code=c.panch_code "
					+ " and work_cancel_dt is null and a.work_id not in (select work_id from rws_work_completion_tbl)";
			if (dcode != null && !dcode.equals("00")) {
				PopQuery += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				PopQuery += "and type_of_asset in(" + scheme + ")";
			}

			PopQuery += " and  programme_code in (" + programe + ") group by a.work_id";
			////System.out.println("PopQuery ............" + PopQuery);
			rs2 = stmt2.executeQuery(PopQuery);
			
			while (rs2.next())
			{
				work_id=rs2.getString(1);
				ppop= rs2.getInt(2);
				scpop= rs2.getInt(3);
				stpop= rs2.getInt(4);
				totpop= rs2.getInt(5);
						
					
				if(ppop>0)
				{
					
					plainper=((double)ppop*100/totpop);
				}
				
				if(scpop>0)
				{
					
					scper=((double)scpop*100/totpop);
				}
				
				if(stpop>0)
				{
					
					stper=((double)stpop*100/totpop);
				}
				
				
				if(plainper>=40)
				{
					
					myids+=work_id+",";
					plainworks=myids.substring(0, myids.length() - 1);
				}
				 
				
			   if(scper>=40)
				{
					
					myids1+=work_id+",";
					scworks=myids1.substring(0, myids1.length() - 1);
				}
			
				
				 if(stper>=40)
				{
					
					myids2+=work_id+",";
					stworks=myids2.substring(0, myids2.length() - 1);
				}
				 
				else
				{
					continue;
				}
				
				
				 
			}

			//System.out.println("my ids"+plainworks);
			//System.out.println("my ids1"+scworks);
			//System.out.println("my ids2"+stworks);
		//	////System.out.println("my ids1"+myids1);
		//	////System.out.println("my ids2"+myids2);
		
		
		if(myreptype != null && myreptype.equals("Plain") && !plainworks.equals(""))
		{
			worksType="PLAIN Works";
		}
		
		else if(myreptype != null && myreptype.equals("SC") && !scworks.equals(""))
		{
			worksType="SC Works";
		}
		
		
		else if(myreptype != null && myreptype.equals("ST") && !stworks.equals(""))
		{
			worksType="ST Works";
		}
		
		else if(myreptype != null && myreptype.equals("All"))
		{
			worksType="ALL Works";
		}
		
		else
      
		{
			worksType="No "+myreptype+" Works Instead Showing ALL Works";
		}
		
			
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();	
			%>
			
			
			<table border=1 cellspacing=0 cellpadding=0 width="76%"
					bordercolor=#000000 style="border-collapse: collapse"
					bgcolor="#ffffff" align="center">
					<tr>
						<td align="center" class="gridhdbg" colspan=18>AAP Report (All
							Schemes) for (<%=pname%>) <%=financialstartyr%> : [<%=distname%>] : [<%=worksType %>] 
						</td>
					</tr>
					<tr>
						<td class="gridhdbg" rowspan=2>Scheme/work Type</td>
						<td class="gridhdbg" colspan=3>Total Ongoing Works as on <br>
							1.4.<%=startyr%></td>
						<td class="gridhdbg" colspan=3>Completed during <br><%=financialstartyr%>
							so far
						</td>
						<td class="gridhdbg" colspan=3>Anticipated Completion during <br><%=financialstartyr%>
						</td>
						<td class="gridhdbg" colspan=3>Target (To be completed during <br><%=nxtfinancialstartyr%>)
						</td>
					</tr>
					<tr>
						<td class="gridhdbg">No.</td>
						<td class="gridhdbg">Est. Cost</td>
						<td class="gridhdbg">Habitations</td>
						<td class="gridhdbg">No.</td>
						<td class="gridhdbg">Est. Cost</td>
						<td class="gridhdbg">Habitations</td>
						<td class="gridhdbg">No.</td>
						<td class="gridhdbg">Est. Cost</td>
						<td class="gridhdbg">Habitations</td>
						<td class="gridhdbg">No.</td>
						<td class="gridhdbg">Est. Cost</td>
						<td class="gridhdbg">Habitations</td>

					</tr>

	
		
			
<% 

/////////////////////////////////////////////////////ALL Works////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
			
			//////////////////////// Spill ////////////////////////////////////////////////////
			stmt2 = conn.createStatement();
			String spillWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a where  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "'  and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				spillWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillWorks += " and a.work_id in(" + stworks + ")";
			}
			spillWorks += " and  programme_code in (" + programe + ") ";
			
			//System.out.println("spillWorks ............" + spillWorks);

			rs2 = stmt2.executeQuery(spillWorks);
			
			while (rs2.next()) {
				spillcnt += rs2.getInt(1);
				spill_amt += rs2.getDouble(2);

			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			

	stmt2 = conn.createStatement();
	String spillWorksExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
			+ startyr
			+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
			+ startyr + "'))";
	if (dcode != null && !dcode.equals("00")) {
		spillWorksExp += "and substr(a.work_id,5,2)='" + dcode
				+ "'";
	}
	if (scheme != null && !scheme.equals("")) {
		spillWorksExp += "and a.type_of_asset in(" + scheme + ")";
	}
	if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
	{
		spillWorksExp += " and a.work_id in(" + plainworks + ")";
		
	}
	if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
	{    
		spillWorksExp += " and a.work_id in(" + scworks + ")";
	}
	if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
	{    
		spillWorksExp += " and a.work_id in(" + stworks + ")";
	}

	spillWorksExp += " and  a.programme_code in (" + programe+ ") ";

	rs2 = stmt2.executeQuery(spillWorksExp);
	//System.out.println("spillWorksExp ............" + spillWorksExp);

	while (rs2.next()) {
		spill_exp += rs2.getDouble(1);
	}
	if (rs2 != null)
		rs2.close();
	if (stmt2 != null)
		stmt2.close();
	
	
	
	stmt2 = conn.createStatement();
	String spillWorksDirExp = "select  nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
			+ startyr
			+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
			+ startyr + "'))";
	if (dcode != null && !dcode.equals("00")) {
		spillWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
				+ "'";
	}
	if (scheme != null && !scheme.equals("")) {
		spillWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
	}
	if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
	{
		spillWorksDirExp += " and a.work_id in(" + plainworks + ")";
		
	}
	if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
	{    
		spillWorksDirExp += " and a.work_id in(" + scworks + ")";
	}
	if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
	{    
		spillWorksDirExp += " and a.work_id in(" + stworks + ")";
	}

	spillWorksDirExp += " and  a.programme_code in (" + programe+ ") ";

	rs2 = stmt2.executeQuery(spillWorksDirExp);
	//System.out.println("spillWorksDirExp ............" + spillWorksDirExp);

	while (rs2.next()) {
		spill_direxp += rs2.getDouble(1);
	}
	if (rs2 != null)
		rs2.close();
	if (stmt2 != null)
		stmt2.close();

		

        	stmt2 = conn.createStatement();
			String spillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				spillHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillHabs += " and a.work_id in(" + stworks + ")";
			}
		
			spillHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillHabs);
			//System.out.println("spillHabs ............" + spillHabs);

			while (rs2.next()) {
				spill_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			/////////////////////////////////////////////Spill Completed/////////////////////////////////////////////////
			stmt2 = conn.createStatement();
			String spillCompWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillCompWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillCompWorks += " and type_of_asset in(" + scheme + ")";
			}
			
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillCompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillCompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillCompWorks += " and a.work_id in(" + stworks + ")";
			}
		
			spillCompWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillCompWorks);
			//System.out.println("spillCompWorks ............"+ spillCompWorks);
			while (rs2.next()) {
				spillcompcnt += rs2.getInt(1);
				spill_compamt += rs2.getDouble(2);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			
			stmt2 = conn.createStatement();
			String spillCompWorksExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
							+ startyr
							+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillCompWorksExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillCompWorksExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillCompWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillCompWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillCompWorksExp += " and a.work_id in(" + stworks + ")";
			}
			spillCompWorksExp += " and  a.programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillCompWorksExp);
			//System.out		.println("spillCompWorksExp ............" + spillCompWorksExp);

			while (rs2.next()) {
				spill_compexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String spillCompWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl  b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
							+ startyr
							+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillCompWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillCompWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillCompWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillCompWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillCompWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			spillCompWorksDirExp += " and  a.programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillCompWorksDirExp);
			//System.out		.println("spillCompWorksDirExp ............" + spillCompWorksDirExp);

			while (rs2.next()) {
				spill_compdirexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String spillCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c ,rws_complete_hab_view d  where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_code=d.panch_code and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and   a.work_cancel_dt is null and  to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillCompHabs += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillCompHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillCompHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillCompHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillCompHabs += " and a.work_id in(" + stworks + ")";
			}
			
			spillCompHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillCompHabs);
			//System.out						.println("spillCompHabs ............" + spillCompHabs);

			while (rs2.next()) {
				spill_comphabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			/////////////////////////////////////////Spill Anticipated///////////////////////////////////////////////////////
				stmt2 = conn.createStatement();
			String spillAntiWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a where to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillAntiWorks += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillAntiWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			spillAntiWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillAntiWorks);
			//System.out.println("spillAntiWorks ............"						+ spillAntiWorks);

			while (rs2.next()) {
				spillanicnt += rs2.getInt(1);
				spill_aniamt += rs2.getDouble(2);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			
			stmt2 = conn.createStatement();
			String spillAntiWorksExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id  and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				spillAntiWorksExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillAntiWorksExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillAntiWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillAntiWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillAntiWorksExp += " and a.work_id in(" + stworks + ")";
			}
			spillAntiWorksExp += " and  a.programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillAntiWorksExp);
			//System.out						.println("spillAntiWorksExp ............" + spillAntiWorksExp);

			while (rs2.next()) {
				spill_antiexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String spillAntiWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id  and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				spillAntiWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillAntiWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillAntiWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillAntiWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillAntiWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			spillAntiWorksDirExp += " and  a.programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillAntiWorksDirExp);
			//System.out						.println("spillAntiWorksDirExp ............" + spillAntiWorksDirExp);

			while (rs2.next()) {
				spill_antidirexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			

			stmt2 = conn.createStatement();
			String spillAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "'";
			if (dcode != null && !dcode.equals("00")) {
				spillAntiHabs += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillAntiHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillAntiHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillAntiHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillAntiHabs += " and a.work_id in(" + stworks + ")";
			}
			spillAntiHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillAntiHabs);
			//System.out						.println("spillAntiHabs ............" + spillAntiHabs);

			while (rs2.next()) {
				spill_anihabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
//////////////////////////////////////////////Spill Targeted////////////////////////////////////////////////////////////////////////////
			stmt2 = conn.createStatement();
			String spillTargetWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where "
					+ "to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				spillTargetWorks += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTargetWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			
			spillTargetWorks += " and  programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillTargetWorks);
		    //System.out.println("spillTargetWorks ............"						+ spillTargetWorks);

			while (rs2.next()) {
				spilltarcnt += rs2.getInt(1);
				spill_taramt += rs2.getDouble(2);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			
			
			
			
			
			stmt2 = conn.createStatement();
			String spillTarWorksExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				spillTarWorksExp += " and substr(a.work_id,5,2)='" + dcode+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTarWorksExp += " and a.type_of_asset in(" + scheme + ")";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTarWorksExp += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillTarWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillTarWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillTarWorksExp += " and a.work_id in(" + stworks + ")";
			}
			spillTarWorksExp += " and  a.programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillTarWorksExp);
		    //System.out						.println("spillTarWorksExp ............" + spillTarWorksExp);

			while (rs2.next()) {
				spill_tarexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
				
			stmt2 = conn.createStatement();
			String spillTarWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				spillTarWorksDirExp += " and substr(a.work_id,5,2)='" + dcode+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTarWorksDirExp += " and a.type_of_asset in(" + scheme + ")";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTarWorksDirExp += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillTarWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillTarWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillTarWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			spillTarWorksDirExp += " and  a.programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(spillTarWorksDirExp);
		    //System.out						.println("spillTarWorksDirExp ............" + spillTarWorksDirExp);

			while (rs2.next()) {
				spill_tardirexp += rs2.getDouble(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();	
			
			
			
			
			
			
			stmt2 = conn.createStatement();
			String spillTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id and b.hab_code=c.panch_code "
					+ " and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "'";
			if (dcode != null && !dcode.equals("00")) {
				spillTargetHabs += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				spillTargetHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				spillTargetHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				spillTargetHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				spillTargetHabs += " and a.work_id in(" + stworks + ")";
			}
			spillTargetHabs += " and  programme_code in (" + programe
					+ ") ";

			rs2 = stmt2.executeQuery(spillTargetHabs);
			//System.out.println("spillTargetHabs ............"						+ spillTargetHabs);

			while (rs2.next()) {
				spill_tarhabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

		

				%>
	<tr>
		<td class="gridbg1" style="text-align: left;">Spill</td>
		<td class="gridbg1" style="text-align: right;"><%=spillcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_amt-(spill_exp+spill_direxp))%></td>
		<td class="gridbg1" style="text-align: right;"><%=spill_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=spillcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_compamt-(spill_compexp+spill_compdirexp))%></td>
		<td class="gridbg1" style="text-align: right;"><%=spill_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=spillanicnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_aniamt-(spill_antiexp+spill_antidirexp))%></td>
		<td class="gridbg1" style="text-align: right;"><%=spill_anihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=spilltarcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(spill_taramt-(spill_tarexp+spill_tardirexp))%></td>
		<td class="gridbg1" style="text-align: right;"><%=spill_tarhabcnt%></td>

	</tr>
	
<%


/////////////////////////////////////////////////////New Works/////////////////////////////////////////////////////////////////////////////////////////

            stmt2 = conn.createStatement();
			String newWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null ";
			if (dcode != null && !dcode.equals("00")) {
				newWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newWorks += " and a.work_id in(" + stworks + ")";
			}
			newWorks += " and  programme_code in (" + programe + ")  ";

			rs2 = stmt2.executeQuery(newWorks);
			//System.out.println("newWorks ............" + newWorks);

			while (rs2.next()) {
				newcnt += rs2.getInt(1);
				new_amt += rs2.getDouble(2);
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String newHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_Code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"	+ endyr + "' and work_cancel_dt is null ";
			if (dcode != null && !dcode.equals("00")) {
				newHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newHabs += " and a.work_id in(" + stworks + ")";
			}
			newHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newHabs);
			//System.out.println("newHabs ............" + newHabs);

			while (rs2.next()) {
				new_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
//////////////////////////////////////////////New Completed///////////////////////////////////////////////////////////
			stmt2 = conn.createStatement();
			String newCompWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where a.work_id=b.work_id and to_date(a.ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(a.ADMIN_DATE) <'01-Apr-"
					+ endyr
					+ "' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				newCompWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newCompWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newCompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newCompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newCompWorks += " and a.work_id in(" + stworks + ")";
			}
			newCompWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newCompWorks);
			//System.out.println("newCompWorks ............" + newCompWorks);

			while (rs2.next()) {
				newcompcnt += rs2.getInt(1);
				new_compamt += rs2.getDouble(2);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String newCompHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d  where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and  to_date(a.ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(a.ADMIN_DATE) <'01-Apr-"
					+ endyr
					+ "' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				newCompHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newCompHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newCompHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newCompHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newCompHabs += " and a.work_id in(" + stworks + ")";
			}
			newCompHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newCompHabs);
			//System.out.println("newCompHabs ............" + newCompHabs);

			while (rs2.next()) {
				new_comphabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			////////////////////////////////////New Anticipated Works////////////////////////////////////////////////////
			
			stmt2 = conn.createStatement();
			String newAntiWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where   to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				newAntiWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newAntiWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			newAntiWorks += " and  programme_code in (" + programe + ")  ";

			rs2 = stmt2.executeQuery(newAntiWorks);
			//System.out.println("newAntiWorks ............" + newAntiWorks);

			while (rs2.next()) {
				newanticnt += rs2.getInt(1);
				new_antiamt += rs2.getDouble(2);
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String newAntiHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c  where  a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "'";
			if (dcode != null && !dcode.equals("00")) {
				newAntiHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newAntiHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newAntiHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newAntiHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newAntiHabs += " and a.work_id in(" + stworks + ")";
			}
			newAntiHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newAntiHabs);
			//System.out.println("newAntiHabs ............" + newAntiHabs);

			while (rs2.next()) {
				new_antihabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			/////////////////////////////////////////////////New Targeted Works//////////////////////////////////////////////////////////////////////////////
			
			stmt2 = conn.createStatement();
			String newTargetWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where  "
					+ "to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr
					+ "' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				newTargetWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newTargetWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			newTargetWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newTargetWorks);
		   //System.out.println("newTargetWorks ............"		+ newTargetWorks);

			while (rs2.next()) {
				newtarcnt += rs2.getInt(1);
				new_taramt += rs2.getDouble(2);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String newTargetHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"
					+ endyr
					+ "-"
					+ nextyr
					+ "' and   to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr
					+ "' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				newTargetHabs += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				newTargetHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				newTargetHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				newTargetHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				newTargetHabs += " and a.work_id in(" + stworks + ")";
			}
			newTargetHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(newTargetHabs);
			//System.out.println("newTargetHabs ............" + newTargetHabs);

			while (rs2.next()) {
				new_tarhabcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

%>

  <tr>
		<td class="gridbg1" style="text-align: left;">New</td>
		<td class="gridbg1" style="text-align: right;"><%=newcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_amt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=new_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=newcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_compamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=new_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=newanticnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_antiamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=new_antihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=newtarcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(new_taramt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=new_tarhabcnt%></td>


	</tr>
	<tr>
		<td class="gridhdbg" style="text-align: right;">Total</td>
		<td class="gridhdbg" style="text-align: right;"><%=spillcnt + newcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_amt-(spill_exp+spill_direxp)) + new_amt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spill_habcnt + new_habcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spillcompcnt + newcompcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_compamt-(spill_compexp+spill_compdirexp)) + new_compamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spill_comphabcnt + new_comphabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spillanicnt + newanticnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_aniamt-(spill_antiexp+spill_antidirexp)) + new_antiamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spill_anihabcnt + new_antihabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spilltarcnt + newtarcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((spill_taramt-(spill_tarexp+spill_tardirexp)) + new_taramt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=spill_tarhabcnt + new_tarhabcnt%></td>


	</tr>
	

<%

////////////////////////////////////////////////Augmentation Works////////////////////////////////////////////////////////////////////////////////

         String augcode="";
			
			stmt2 = conn.createStatement();
			String augspillWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),AUG_NEW_CODE  FROM RWS_WORK_ADMN_TBL a where  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				augspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillWorks += " and a.work_id in(" + stworks + ")";
			}
			augspillWorks += " and  programme_code in (" + programe + ") group by AUG_NEW_CODE ";

			rs2 = stmt2.executeQuery(augspillWorks);
			//System.out.println("augspillWorks ............" + augspillWorks);
			while (rs2.next()) 
			{
				
				if(rs2.getInt(3)==2)
				{
					augspillcnt += rs2.getInt(1);
					augspill_amt += rs2.getDouble(2);
				}
				
				if(rs2.getInt(3)==1)
				{
					mainspillcnt += rs2.getInt(1);
					mainspill_amt += rs2.getDouble(2);
				}

			}

		/* 	//System.out.println("augspillcnt ............" + augspillcnt);
			//System.out.println("augspill_amt ............" + augspill_amt);
			//System.out.println("augcode ............" + augcode);
		 */	
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String augspillWorksExp = "select nvl(sum(voucher_Amt)/100000,0),AUG_NEW_CODE  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				augspillWorksExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillWorksExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillWorksExp += " and a.work_id in(" + stworks + ")";
			}
			augspillWorksExp += " and  a.programme_code in (" + programe + ") group by AUG_NEW_CODE ";

			rs2 = stmt2.executeQuery(augspillWorksExp);
			//System.out.println("augspillWorksExp ............" + augspillWorksExp);

			while (rs2.next())
			{     
					 if(rs2.getInt(2)==2)
				    {
					   augspill_exp += rs2.getDouble(1);
				    }
				   if(rs2.getInt(2)==1)
				    {
					   mainspill_exp += rs2.getDouble(1);
				    }
				 
				 
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			 stmt2 = conn.createStatement();
			String augspillWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0),AUG_NEW_CODE  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				augspillWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			augspillWorksDirExp += " and  a.programme_code in (" + programe	+ ") group by AUG_NEW_CODE ";

			rs2 = stmt2.executeQuery(augspillWorksDirExp);
			//System.out.println("augspillWorksDirExp ............" + augspillWorksDirExp);

			while (rs2.next()) 
			{   if(rs2.getInt(2)==2)
		        {
				 augspill_direxp += rs2.getDouble(1);
		        }
			
				if(rs2.getInt(2)==1)
		        {
				 mainspill_direxp += rs2.getDouble(1);
		        }
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close(); 
			
			
			
			
			stmt2 = conn.createStatement();
			String augnewWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT) ,AUG_NEW_CODE FROM RWS_WORK_ADMN_TBL a  where  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null";
			if (dcode != null && !dcode.equals("00")) {
				augnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewWorks += " and a.work_id in(" + stworks + ")";
			}
			augnewWorks += " and  programme_code in (" + programe + ") group by AUG_NEW_CODE ";

			rs2 = stmt2.executeQuery(augnewWorks);
			//System.out.println("augnewWorks ............" + augnewWorks);

			while (rs2.next())
			{   if(rs2.getInt(3)==2)
	            {
				augnewcnt += rs2.getInt(1);
				augnew_amt += rs2.getDouble(2);
	            }
				else
				{
					mainnewcnt += rs2.getInt(1);
					mainnew_amt += rs2.getDouble(2);
				}
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String augspillHabs = "select count(distinct b.hab_code),AUG_NEW_CODE FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where  a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))";
			if (dcode != null && !dcode.equals("00")) {
				augspillHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillHabs += " and a.work_id in(" + stworks + ")";
			}
			augspillHabs += " and  programme_code in (" + programe + ") group by AUG_NEW_CODE ";

			rs2 = stmt2.executeQuery(augspillHabs);
		    //System.out.println("augspillHabs ............" + augspillHabs);

			while (rs2.next()) 
				{
				if(rs2.getInt(2)==2)
	            {
				 augspill_habcnt += rs2.getInt(1);
	            }
				else
				{
					mainspill_habcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String augnewHabs = "select count(distinct b.hab_code) ,AUG_NEW_CODE FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c  where  a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null ";
			if (dcode != null && !dcode.equals("00")) {
				augnewHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewHabs += " and a.work_id in(" + stworks + ")";
			}
			augnewHabs += " and  programme_code in (" + programe + ")  group by AUG_NEW_CODE";

			rs2 = stmt2.executeQuery(augnewHabs);
			//System.out.println("augnewHabs ............" + augnewHabs);

			while (rs2.next())
			{
				if(rs2.getInt(2)==2)
				{
				  augnew_habcnt += rs2.getInt(1);
				}
				else
				{
					mainnew_habcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			/////////////////Agumentaion completion Works////////////////////////////
			
			
			
			stmt2 = conn.createStatement();
			String augspillCompWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where  a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augspillCompWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillCompWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillCompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillCompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillCompWorks += " and a.work_id in(" + stworks + ")";
			}
			augspillCompWorks += " and  programme_code in (" + programe + ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augspillCompWorks);
			//System.out.println("augspillCompWorks ............"	+ augspillCompWorks);
			while (rs2.next()) 
			{
				if(rs2.getInt(3)==2)
	            {
					augspillcompcnt += rs2.getInt(1);
				    augspill_compamt += rs2.getDouble(2);
	            }
				else
				{
					mainspillcompcnt += rs2.getInt(1);
				    mainspill_compamt += rs2.getDouble(2);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String augspillCompWorksExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl c   where  a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
							+ startyr
							+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augspillCompWorksExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillCompWorksExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillCompWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillCompWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillCompWorksExp += " and a.work_id in(" + stworks + ")";
			}
			augspillCompWorksExp += " and  a.programme_code in (" + programe
					+ ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augspillCompWorksExp);
			//System.out						.println("augspillCompWorksExp ............" + augspillCompWorksExp);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				   augspill_compexp += rs2.getDouble(1);
	            }
				else
				{
					mainspill_compexp += rs2.getDouble(1);
				
				}
				
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			 stmt2 = conn.createStatement();
			String augspillCompWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b,rws_work_completion_tbl c   where  a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
							+ startyr
							+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augspillCompWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillCompWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillCompWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillCompWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillCompWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			augspillCompWorksDirExp += " and  a.programme_code in (" + programe
					+ ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augspillCompWorksDirExp);
			//System.out						.println("augspillCompWorksDirExp ............" + augspillCompWorksDirExp);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				   augspill_compdirexp += rs2.getDouble(1);
	            }
				else
				{
					 mainspill_compdirexp += rs2.getDouble(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close(); 
			
			
			stmt2 = conn.createStatement();
			String augspillCompHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c ,rws_complete_hab_view d  where  a.work_id=b.work_id  and a.work_id=c.work_id and  b.hab_code=d.panch_code and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and   a.work_cancel_dt is null and  to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augspillCompHabs += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillCompHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillCompHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillCompHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillCompHabs += " and a.work_id in(" + stworks + ")";
			}
			augspillCompHabs += " and  programme_code in (" + programe + ") group by aug_new_code ";

			rs2 = stmt2.executeQuery(augspillCompHabs);
			//System.out						.println("augspillCompHabs ............" +augspillCompHabs);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augspill_comphabcnt += rs2.getInt(1);
	            }
				else
				{
					mainspill_comphabcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String augnewCompWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where a.work_id=b.work_id and to_date(a.ADMIN_DATE) >= '01-Apr-"
					+ startyr
					+ "' and  a.work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augnewCompWorks += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewCompWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewCompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewCompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewCompWorks += " and a.work_id in(" + stworks + ")";
			}
			augnewCompWorks += " and  programme_code in (" + programe + ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augnewCompWorks);
			//System.out.println("augnewCompWorks ............"	+ augnewCompWorks);
			while (rs2.next()) {
				if(rs2.getInt(3)==2)
	            {
				augnewcompcnt += rs2.getInt(1);
				augnew_compamt += rs2.getDouble(2);
	            }
				else 
				{
				mainnewcompcnt += rs2.getInt(1);
				mainnew_compamt += rs2.getDouble(2);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

			stmt2 = conn.createStatement();
			String augnewCompHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c ,rws_complete_hab_view d   where a.work_id=b.work_id  and a.work_id=c.work_id and b.hab_code=d.panch_code and  to_date(a.ADMIN_DATE) >= '01-Apr-"
					+ startyr
					+ "' and   a.work_cancel_dt is null and  to_date(DATE_OF_COMPLETION) >= '01-Apr-"
					+ startyr
					+ "' and to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augnewCompHabs += " and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewCompHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewCompHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewCompHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewCompHabs += " and a.work_id in(" + stworks + ")";
			}
			augnewCompHabs += " and  programme_code in (" + programe + ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augnewCompHabs);
			//System.out						.println("augnewCompHabs ............" +augnewCompHabs);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augnew_comphabcnt += rs2.getInt(1);
	            }
				else
				{
					mainnew_comphabcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();


//////////////////////////////////////////////////Augumentation Anticipated Works///////////////////////////////////////////////////////////////////////////////////////




            stmt2 = conn.createStatement();
			String augspillAntiWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a where   to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augspillAntiWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillAntiWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			augspillAntiWorks += " and  programme_code in (" + programe + ") group by aug_new_code ";

			rs2 = stmt2.executeQuery(augspillAntiWorks);
			//System.out.println("augspillAntiWorks ............" + augspillAntiWorks);
			while (rs2.next()) {
				if(rs2.getInt(3)==2)
	            {
				augspillAnticnt += rs2.getInt(1);
				augspill_antiamt += rs2.getDouble(2);
	            }
				else
				{
					mainspillAnticnt += rs2.getInt(1);
					mainspill_antiamt += rs2.getDouble(2);
				}
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String augspillAntiWorksExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where  a.work_id=b.work_id  and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				augspillAntiWorksExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillAntiWorksExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillAntiWorksExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillAntiWorksExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillAntiWorksExp += " and a.work_id in(" + stworks + ")";
			}
			augspillAntiWorksExp += " and  a.programme_code in (" + programe
					+ ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augspillAntiWorksExp);
			//System.out						.println("augspillAntiWorksExp ............" + augspillAntiWorksExp);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augspill_antiexp += rs2.getDouble(1);
	            }
				else
				{
					mainspill_antiexp += rs2.getDouble(1);
				}
	
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			 stmt2 = conn.createStatement();
			String augspillAntiWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where  a.work_id=b.work_id  and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
							+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "'";
			if (dcode != null && !dcode.equals("00")) {
				augspillAntiWorksDirExp += "and substr(a.work_id,5,2)='" + dcode
						+ "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillAntiWorksDirExp += "and a.type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillAntiWorksDirExp += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillAntiWorksDirExp += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillAntiWorksDirExp += " and a.work_id in(" + stworks + ")";
			}
			augspillAntiWorksDirExp += " and  a.programme_code in (" + programe
					+ ") group by aug_new_code";

			rs2 = stmt2.executeQuery(augspillAntiWorksDirExp);
			//System.out						.println("augspillAntiWorksDirExp ............" + augspillAntiWorksDirExp);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augspill_antidirexp += rs2.getDouble(1);
	            }
				else
				{
					mainspill_antidirexp += rs2.getDouble(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close(); 
			
			stmt2 = conn.createStatement();
			String augnewAntiWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a  where  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' ";
			if (dcode != null && !dcode.equals("00")) {
				augnewAntiWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewAntiWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			augnewAntiWorks += " and  programme_code in (" + programe + ") group by aug_new_code ";

			rs2 = stmt2.executeQuery(augnewAntiWorks);
			//System.out.println("augnewAntiWorks ............" +augnewAntiWorks);

			while (rs2.next()) {
				if(rs2.getInt(3)==2)
	            {
				augnewAnticnt += rs2.getInt(1);
				augnew_antiamt += rs2.getDouble(2);
	            }
				else
				{
					mainnewAnticnt += rs2.getInt(1);
					mainnew_antiamt += rs2.getDouble(2);
				}
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String augspillAntiHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where  a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "'";
			if (dcode != null && !dcode.equals("00")) {
				augspillAntiHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augspillAntiHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augspillAntiHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augspillAntiHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augspillAntiHabs += " and a.work_id in(" + stworks + ")";
			}
			augspillAntiHabs += " and  programme_code in (" + programe + ") group by aug_new_code ";

			rs2 = stmt2.executeQuery(augspillAntiHabs);
			//System.out.println("augspillAntiHabs ............" + augspillAntiHabs);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augspill_antihabcnt += rs2.getInt(1);
	            }
				else
				{
					mainspill_antihabcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String augnewAntiHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where  a.work_id=b.work_id and b.hab_code=c.panch_code and   to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ startyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ endyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ startyr+ "-"	+ endyr+ "'";
			if (dcode != null && !dcode.equals("00")) {
				augnewAntiHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				augnewAntiHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				augnewAntiHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				augnewAntiHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				augnewAntiHabs += " and a.work_id in(" + stworks + ")";
			}
			augnewAntiHabs += " and  programme_code in (" + programe + ") group by aug_new_code ";

			rs2 = stmt2.executeQuery(augnewAntiHabs);
			//System.out.println("augnewAntiHabs ............" + augnewAntiHabs);

			while (rs2.next()) {
				if(rs2.getInt(2)==2)
	            {
				augnew_antihabcnt += rs2.getInt(1);
	            }
				else
				{
					mainnew_antihabcnt += rs2.getInt(1);
				}
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();


//////////////////////////////////////////////////Augumentation Targeted Works///////////////////////////////////////////////////////////////////////////////////////




stmt2 = conn.createStatement();
String augspillTargetWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a where   to_date(a.ADMIN_DATE) < '01-Apr-"
+ startyr
+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
+ startyr + "')) and  to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
if (dcode != null && !dcode.equals("00")) {
augspillTargetWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augspillTargetWorks += "and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augspillTargetWorks += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augspillTargetWorks += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augspillTargetWorks += " and a.work_id in(" + stworks + ")";
}
augspillTargetWorks += " and  programme_code in (" + programe + ") group by aug_new_Code";

rs2 = stmt2.executeQuery(augspillTargetWorks);
//System.out.println("augspillTargetWorks ............" + augspillTargetWorks);
while (rs2.next()) {
if(rs2.getInt(3)==2)
{
augspillTargetcnt += rs2.getInt(1);
augspill_targetamt += rs2.getDouble(2);
}
else
{
	mainspillTargetcnt += rs2.getInt(1);
	mainspill_targetamt += rs2.getDouble(2);

}

}

if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

stmt2 = conn.createStatement();
String augspillTarWorksExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where  a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
	+ startyr
	+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
			+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "'";
if (dcode != null && !dcode.equals("00")) {
augspillTarWorksExp += " and substr(a.work_id,5,2)='" + dcode+ "'";
}
if (scheme != null && !scheme.equals("")) {
augspillTarWorksExp += " and a.type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augspillTarWorksExp += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augspillTarWorksExp += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augspillTarWorksExp += " and a.work_id in(" + stworks + ")";
}
augspillTarWorksExp += " and  a.programme_code in (" + programe + ") group by aug_new_code";

rs2 = stmt2.executeQuery(augspillTarWorksExp);
//System.out.println("augspillTarWorksExp ............" + spillTarWorksExp);

while (rs2.next()) {
if(rs2.getInt(2)==2)
{
augspill_targetexp += rs2.getDouble(1);
}
else
{
	mainspill_targetexp += rs2.getDouble(1);
}
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

stmt2 = conn.createStatement();
String augspillTarWorksDirExp = "select nvl(sum(voucher_Amt)/100000,0),aug_new_code FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where  a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
	+ startyr
	+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
			+ startyr + "')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "'";
if (dcode != null && !dcode.equals("00")) {
augspillTarWorksDirExp += " and substr(a.work_id,5,2)='" + dcode+ "'";
}
if (scheme != null && !scheme.equals("")) {
augspillTarWorksDirExp += " and a.type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augspillTarWorksDirExp += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augspillTarWorksDirExp += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augspillTarWorksDirExp += " and a.work_id in(" + stworks + ")";
}
augspillTarWorksDirExp += " and  a.programme_code in (" + programe + ") group by aug_new_code ";

rs2 = stmt2.executeQuery(augspillTarWorksDirExp);
//System.out.println("augspillTarWorksDirExp ............" + augspillTarWorksDirExp);

while (rs2.next())
{   if(rs2.getInt(2)==2)
{
augspill_targetdirexp += rs2.getDouble(1);
}
else
{
	mainspill_targetdirexp += rs2.getDouble(1);
}
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();  



stmt2 = conn.createStatement();
String augnewTargetWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT),aug_new_code  FROM RWS_WORK_ADMN_TBL a  where  to_date(ADMIN_DATE) >='01-Apr-"
+ startyr
+ "' and to_date(ADMIN_DATE) <'01-Apr-"
+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' ";
if (dcode != null && !dcode.equals("00")) {
augnewTargetWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augnewTargetWorks += " and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augnewTargetWorks += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augnewTargetWorks += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augnewTargetWorks += " and a.work_id in(" + stworks + ")";
}
augnewTargetWorks += " and  programme_code in (" + programe + ") group by aug_new_code ";

rs2 = stmt2.executeQuery(augnewTargetWorks);
//System.out.println("augnewTargetWorks ............" +augnewTargetWorks);

while (rs2.next()) 
{
if(rs2.getInt(3)==2)
{
	augnewTargetcnt += rs2.getInt(1);
	augnew_targetamt += rs2.getDouble(2);
}
else
{
	mainnewTargetcnt += rs2.getInt(1);
	mainnew_targetamt += rs2.getDouble(2);
}
}

if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();


stmt2 = conn.createStatement();
String augspillTargetHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where  a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
+ startyr
+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
+ startyr + "'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "'";
if (dcode != null && !dcode.equals("00")) {
augspillTargetHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augspillTargetHabs += "and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augspillTargetHabs += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augspillTargetHabs += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augspillTargetHabs += " and a.work_id in(" + stworks + ")";
}
augspillTargetHabs += " and  programme_code in (" + programe + ") group by aug_new_code";

rs2 = stmt2.executeQuery(augspillTargetHabs);
//System.out.println("augspillTargetHabs ............" + augspillTargetHabs);

while (rs2.next()) {
if(rs2.getInt(2)==2)
{
augspill_targethabcnt += rs2.getInt(1);
}
else
{
	mainspill_targethabcnt += rs2.getInt(1);
}
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();

stmt2 = conn.createStatement();
String augnewTargetHabs = "select count(distinct b.hab_code),aug_new_code FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c  where  a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
+ startyr
+ "' and to_date(ADMIN_DATE) <'01-Apr-"
+ endyr + "' and work_cancel_dt is null  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+ endyr+ "' and to_date(TARGET_DATE_COMP) < '01-Apr-"+ nextyr + "' and  AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+ endyr+ "-"	+ nextyr+ "'";
if (dcode != null && !dcode.equals("00")) {
augnewTargetHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
}
if (scheme != null && !scheme.equals("")) {
augnewTargetHabs += " and type_of_asset in(" + scheme + ")";
}
if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
{
augnewTargetHabs += " and a.work_id in(" + plainworks + ")";

}
if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
{    
augnewTargetHabs += " and a.work_id in(" + scworks + ")";
}
if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
{    
augnewTargetHabs += " and a.work_id in(" + stworks + ")";
}
augnewTargetHabs += " and  programme_code in (" + programe + ") group by aug_new_code";

rs2 = stmt2.executeQuery(augnewTargetHabs);
//System.out.println("augnewTargetHabs ............" + augnewTargetHabs);

while (rs2.next()) {
if(rs2.getInt(2)==2)
{
augnew_targethabcnt += rs2.getInt(1);
}
else
{
	mainnew_targethabcnt += rs2.getInt(1);
}
}
if (rs2 != null)
rs2.close();
if (stmt2 != null)
stmt2.close();





/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



%>



<tr>
		<td class="gridbg1" style="text-align: left;">Augmentation</td>
		<td class="gridbg1" style="text-align: right;"><%=augspillcnt+augnewcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_amt-(augspill_exp+augspill_direxp))+augnew_amt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspill_habcnt+augnew_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspillcompcnt+augnewcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_compamt-(augspill_compexp+augspill_compdirexp))+augnew_compamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspill_comphabcnt+augnew_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspillAnticnt+augnewAnticnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_antiamt-(augspill_antiexp+augspill_antidirexp))+augnew_antiamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspill_antihabcnt+augnew_antihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspillTargetcnt+augnewTargetcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((augspill_targetamt-(augspill_targetexp+augspill_targetdirexp))+augnew_targetamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=augspill_targethabcnt+augnew_targethabcnt%></td>
		

	</tr>


<tr>
		<td class="gridbg1" style="text-align: left;">Main</td>
		<td class="gridbg1" style="text-align: right;"><%=mainspillcnt+mainnewcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_amt-(mainspill_exp+mainspill_direxp))+mainnew_amt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspill_habcnt+mainnew_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspillcompcnt+mainnewcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_compamt-(mainspill_compexp+mainspill_compdirexp))+mainnew_compamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspill_comphabcnt+mainnew_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspillAnticnt+mainnewAnticnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_antiamt-(mainspill_antiexp+mainspill_antidirexp))+mainnew_antiamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspill_antihabcnt+mainnew_antihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspillTargetcnt+mainnewTargetcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((mainspill_targetamt-(mainspill_targetexp+mainspill_targetdirexp))+mainnew_targetamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=mainspill_targethabcnt+mainnew_targethabcnt%></td>
		

	</tr>


<tr>
		<td class="gridhdbg" style="text-align: right;">Total</td>
		<td class="gridhdbg" style="text-align: right;"><%=augspillcnt+augnewcnt+mainspillcnt+mainnewcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_amt-(augspill_exp+augspill_direxp)) +augnew_amt+(mainspill_amt-(mainspill_exp+mainspill_direxp))+mainnew_amt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspill_habcnt+augnew_habcnt+mainspill_habcnt+mainnew_habcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspillcompcnt+augnewcompcnt +mainspillcompcnt+mainnewcompcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_compamt-(augspill_compexp+augspill_compdirexp))+augnew_compamt+(mainspill_compamt-(mainspill_compexp+mainspill_compdirexp))+mainnew_compamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspill_comphabcnt+augnew_comphabcnt+mainspill_comphabcnt+mainnew_comphabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspillAnticnt+augnewAnticnt+mainspillAnticnt+mainnewAnticnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_antiamt-(augspill_antiexp+augspill_antidirexp))+augnew_antiamt+(mainspill_antiamt-(mainspill_antiexp+mainspill_antidirexp))+mainnew_antiamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspill_antihabcnt+augnew_antihabcnt+mainspill_antihabcnt+mainnew_antihabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspillTargetcnt+augnewTargetcnt+mainspillTargetcnt+mainnewTargetcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((augspill_targetamt-(augspill_targetexp+augspill_targetdirexp))+augnew_targetamt+(mainspill_targetamt-(mainspill_targetexp+mainspill_targetdirexp))+mainnew_targetamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=augspill_targethabcnt+augnew_targethabcnt+mainspill_targethabcnt+mainnew_targethabcnt%></td>

	</tr>


<%

//////////////////////////////////////////////////////////////Sanction greater than 5 yrs///////////////////////////////////////////////////////////////////////////////////////////////////

			stmt2 = conn.createStatement();
			String gspillWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a where  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))   and (sysdate -  a.admin_date>5*365 ) ";
			if (dcode != null && !dcode.equals("00")) {
				gspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				gspillWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillWorks += " and a.work_id in(" + stworks + ")";
			}
			gspillWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(gspillWorks);
			//System.out.println("gspillWorks ............" + gspillWorks);
			while (rs2.next()) {
				gspillcnt += rs2.getInt(1);
				gspill_amt += rs2.getDouble(2);

			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2=conn.createStatement();
			  String gspillWorksExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   and (sysdate -  a.admin_date>5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gspillWorksExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gspillWorksExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gspillWorksExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gspillWorksExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gspillWorksExp += " and a.work_id in(" + stworks + ")";
			  }
			  gspillWorksExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gspillWorksExp);
			    //System.out.println("gspillWorksExp ............"+gspillWorksExp);
			  	
			  	while(rs2.next())
			  	{
			  		gspill_exp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			
			  	stmt2=conn.createStatement();
				  String gspillWorksDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   and (sysdate -  a.admin_date>5*365 )";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  gspillWorksDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  gspillWorksDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  gspillWorksDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  gspillWorksDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  gspillWorksDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  gspillWorksDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(gspillWorksDirExp);
				    //System.out.println("gspillWorksDirExp ............"+gspillWorksDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		gspill_direxp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
			
			stmt2 = conn.createStatement();
			String gnewWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null  and (sysdate -  a.admin_date>5*365 )";
			if (dcode != null && !dcode.equals("00")) {
				gnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				gnewWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gnewWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gnewWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gnewWorks += " and a.work_id in(" + stworks + ")";
			}
			gnewWorks += " and  programme_code in (" + programe + ")  ";

			rs2 = stmt2.executeQuery(gnewWorks);
			//System.out.println("gnewWorks ............" + gnewWorks);

			while (rs2.next()) {
				gnewcnt += rs2.getInt(1);
				gnew_amt += rs2.getDouble(2);
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String gspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))     and (sysdate -  a.admin_date>5*365 ) ";
			if (dcode != null && !dcode.equals("00")) {
				gspillHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				gspillHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillHabs += " and a.work_id in(" + stworks + ")";
			}
			gspillHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(gspillHabs);
			//System.out.println("gspillHabs ............" +gspillHabs);

			while (rs2.next()) {
				gspill_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String gnewHabs = "select count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where  a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null and (sysdate -  a.admin_date>5*365 )";
			if (dcode != null && !dcode.equals("00")) {
				gnewHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				gnewHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gnewHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gnewHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gnewHabs += " and a.work_id in(" + stworks + ")";
			}
			gnewHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(gnewHabs);
			//System.out.println("gnewHabs ............" + gnewHabs);

			while (rs2.next()) {
				gnew_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

//////////////////////////////////////////////////////////>5yrs completed works//////////////////////////////////////////////////////////////////////////////////////////////////////

            stmt2=conn.createStatement();
			String gspillcompWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b where  a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' )and (sysdate -  admin_date>5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillcompWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillcompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillcompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillcompWorks += " and a.work_id in(" + stworks + ")";
			}
			gspillcompWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillcompWorks);
			//System.out.println("gspillcompWorks ............"+gspillcompWorks);
			
			while(rs2.next())
			{
				gspillcompcnt+=rs2.getInt(1);
				gspill_compamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String gspillCompExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' )and (sysdate -  admin_date>5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gspillCompExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gspillCompExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gspillCompExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gspillCompExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gspillCompExp += " and a.work_id in(" + stworks + ")";
			  }
			  gspillCompExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gspillCompExp);
			    //System.out.println("gspillCompExp ............"+gspillCompExp);
			  	
			  	while(rs2.next())
			  	{
			  		gspill_compexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();
			  	
			  	stmt2=conn.createStatement();
				  String gspillComDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' )and (sysdate -  admin_date>5*365 )";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  gspillComDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  gspillComDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  gspillComDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  gspillComDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  gspillComDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  gspillComDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(gspillComDirExp);
				    //System.out.println("gspillComDirExp ............"+gspillComDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		gspill_compdirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();
				  	
			
			stmt2=conn.createStatement();
			String gspillcomphabs="select count(distinct c.hab_code)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date>5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillcomphabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillcomphabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillcomphabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillcomphabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillcomphabs += " and a.work_id in(" + stworks + ")";
			}
			gspillcomphabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillcomphabs);
			//System.out.println("gspillcomphabs ............"+gspillcomphabs);
			
			while(rs2.next())
			{
				gspill_comphabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			
			stmt2=conn.createStatement();
		
		    String gnewcompWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where a.work_id=b.work_id and to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' and (sysdate -  admin_date>5*365 )";
				
			if(dcode!=null && !dcode.equals("00"))
			{
				gnewcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gnewcompWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gnewcompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gnewcompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gnewcompWorks += " and a.work_id in(" + stworks + ")";
			}
			gnewcompWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gnewcompWorks);
			//System.out.println("gnewcompWorks ............"+gnewcompWorks);
			
			while(rs2.next())
			{
				gnewcompcnt+=rs2.getInt(1);
				gnew_compamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			stmt2=conn.createStatement();
			String gnewCompHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d  where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and  to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gnewCompHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
		      if(scheme!=null && !scheme.equals(""))
		      {
		    	  gnewCompHabs+=" and type_of_asset in("+scheme+")";
			  }
		      if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
		      {
		    	  gnewCompHabs += " and a.work_id in(" + plainworks + ")";
		      	
		      }
		      if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
		      {    
		    	  gnewCompHabs += " and a.work_id in(" + scworks + ")";
		      }
		      if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
		      {    
		    	  gnewCompHabs += " and a.work_id in(" + stworks + ")";
		      }
		      gnewCompHabs+=" and  programme_code in ("+programe+") "; 
		      
			  	rs2=stmt2.executeQuery(gnewCompHabs);
			    //System.out.println("gnewCompHabs ............"+gnewCompHabs);
			  	
			  	while(rs2.next())
			  	{
			  		gnew_comphabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();  
	  	
	  		
	////////////////////////////////////////////>5yrs Anticipated Works////////////////////////////////////////////////////////////		
			
		    stmt2=conn.createStatement();
			String gspillantiWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where   work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )  ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillantiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillantiWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillantiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillantiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillantiWorks += " and a.work_id in(" + stworks + ")";
			}
			gspillantiWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillantiWorks);
			//System.out.println("gspillantiWorks ............"+gspillantiWorks);
			
			while(rs2.next())
			{
				gspillanticnt+=rs2.getInt(1);
				gspill_antiamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			 stmt2=conn.createStatement();
			  String gspillAntiExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )  ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gspillAntiExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gspillAntiExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gspillAntiExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gspillAntiExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gspillAntiExp += " and a.work_id in(" + stworks + ")";
			  } 
			  gspillAntiExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gspillAntiExp);
			    //System.out.println("gspillAntiExp ............"+gspillAntiExp);
			  	
			  	while(rs2.next())
			  	{
			  		gspill_antiexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			  	
			  	stmt2=conn.createStatement();
				  String gspillAntiDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )  ";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  gspillAntiDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  gspillAntiDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  gspillAntiDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  gspillAntiDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  gspillAntiDirExp += " and a.work_id in(" + stworks + ")";
				  } 
				  gspillAntiDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(gspillAntiDirExp);
				    //System.out.println("gspillAntiDirExp ............"+gspillAntiDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		gspill_antidirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 

			
			
			stmt2=conn.createStatement(); 
			String gspillantihabs="select count(distinct hab_code)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c  where  a.work_id=b.work_id and b.hab_code=c.panch_Code and work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and  a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 ) and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillantihabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillantihabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillantihabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillantihabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillantihabs += " and a.work_id in(" + stworks + ")";
			}
			gspillantihabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillantihabs);
			//System.out.println("gspillantihabs ............"+gspillantihabs);
			
			while(rs2.next())
			{
				gspill_antihabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 	
			
	
			stmt2=conn.createStatement();
			String gnewAntiWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 )   ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gnewAntiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gnewAntiWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gnewAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gnewAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gnewAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			gnewAntiWorks+=" and  programme_code in ("+programe+")  "; 
			
			rs2=stmt2.executeQuery(gnewAntiWorks);
			//System.out.println("gnewAntiWorks ............"+gnewAntiWorks);
			
			while(rs2.next())
			{
				gnewanticnt+=rs2.getInt(1);
				gnew_antiamt+=rs2.getDouble(2);
			}
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String gnewantiHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date>5*365 ) and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gnewantiHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gnewantiHabs+=" and type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gnewantiHabs += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gnewantiHabs += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gnewantiHabs += " and a.work_id in(" + stworks + ")";
			  } 
			  gnewantiHabs+=" and  programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gnewantiHabs);
			    //System.out.println("gnewantiHabs ............"+gnewantiHabs);
			  	
			  	while(rs2.next())
			  	{
			  		gnew_antihabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();   
			  				
			
			
	//////////////////////////////////////////////////////>5yrs Targeted Works///////////////////////////////////////////////////////////////////////////////////////////////////////		
			
	        stmt2=conn.createStatement();
			String gspillTargetWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a    where  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillTargetWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			gspillTargetWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillTargetWorks);
			//System.out.println("gspillTargetWorks ............"+gspillTargetWorks);
			
			while(rs2.next())
			{
				gspilltarcnt+=rs2.getInt(1);
				gspill_taramt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			
			  stmt2=conn.createStatement();
			  String gspillTargetExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 )  ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gspillTargetExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gspillTargetExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gspillTargetExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gspillTargetExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gspillTargetExp += " and a.work_id in(" + stworks + ")";
			  }
			  gspillTargetExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gspillTargetExp);
			    //System.out.println("gspillTargetExp ............"+gspillTargetExp);
			  	
			  	while(rs2.next())
			  	{
			  		gspill_tarexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			  	
			  	stmt2=conn.createStatement();
				  String gspillTargetDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 )  ";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  gspillTargetDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  gspillTargetDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  gspillTargetDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  gspillTargetDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  gspillTargetDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  gspillTargetDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(gspillTargetDirExp);
				    //System.out.println("gspillTargetDirExp ............"+gspillTargetDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		gspill_tardirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
			
			
			stmt2=conn.createStatement();
			String gspillTargethabs="select count(distinct hab_Code) FROM RWS_WORK_ADMN_TBL a  ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where  a.work_id=b.work_id and b.hab_code=c.panch_code and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and  work_cancel_dt is null  and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				gspillTargethabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gspillTargethabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gspillTargethabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gspillTargethabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gspillTargethabs += " and a.work_id in(" + stworks + ")";
			}
			gspillTargethabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(gspillTargethabs);
			//System.out.println("gspillTargethabs ............"+gspillTargethabs);
			
			while(rs2.next())
			{
				gspill_tarhabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
					
			
			stmt2=conn.createStatement();
			String gnewTargetWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 )";
			if(dcode!=null && !dcode.equals("00"))
			{
				gnewTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				gnewTargetWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				gnewTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				gnewTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				gnewTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			gnewTargetWorks+=" and  programme_code in ("+programe+")  "; 
			
			rs2=stmt2.executeQuery(gnewTargetWorks);
			//System.out.println("gnewTargetWorks ............"+gnewTargetWorks);
			
			while(rs2.next())
			{
				gnewtarcnt+=rs2.getInt(1);
				gnew_taramt+=rs2.getDouble(2);
			}
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String gnewTargetHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date>5*365 ) and  AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"'";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  gnewTargetHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  gnewTargetHabs+=" and type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  gnewTargetHabs += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  gnewTargetHabs += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  gnewTargetHabs += " and a.work_id in(" + stworks + ")";
			  }
			  gnewTargetHabs+=" and  programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(gnewTargetHabs);
			    //System.out.println("gnewTargetHabs ............"+gnewTargetHabs);
			  	
			  	while(rs2.next())
			  	{
			  		gnew_tarhabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();   			
		
			
				
%>

 <tr>
		<td class="gridbg1" style="text-align: left;">Greater than 5 years</td>
		<td class="gridbg1" style="text-align: right;"><%=gspillcnt+gnewcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_amt-(gspill_exp+gspill_direxp))+gnew_amt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspill_habcnt+gnew_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspillcompcnt+gnewcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_compamt-(gspill_compexp+gspill_compdirexp))+gnew_compamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspill_comphabcnt+gspill_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspillanticnt+gnewanticnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_antiamt-(gspill_antiexp+gspill_antidirexp))+gnew_antiamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspill_antihabcnt+gnew_antihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspilltarcnt+gnewtarcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((gspill_taramt-(gspill_tarexp+gspill_tardirexp))+gnew_taramt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=gspill_tarhabcnt+gnew_tarhabcnt%></td>


	</tr>


<%
///////////////////////////////////////////////////////////////<5yrs////////////////////////////////////////////////////////////////////////////////////////////



stmt2 = conn.createStatement();
			String lspillWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a where  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))   and (sysdate -  a.admin_date<5*365 ) ";
			if (dcode != null && !dcode.equals("00")) {
				lspillWorks += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				lspillWorks += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillWorks += " and a.work_id in(" + stworks + ")";
			}
			lspillWorks += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(lspillWorks);
			//System.out.println("lspillWorks ............" + lspillWorks);
			while (rs2.next()) {
				lspillcnt += rs2.getInt(1);
				lspill_amt += rs2.getDouble(2);

			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2=conn.createStatement();
			  String lspillWorksExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   and (sysdate -  a.admin_date<5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lspillWorksExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  lspillWorksExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lspillWorksExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lspillWorksExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lspillWorksExp += " and a.work_id in(" + stworks + ")";
			  }
			  lspillWorksExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lspillWorksExp);
			    //System.out.println("lspillWorksExp ............"+lspillWorksExp);
			  	
			  	while(rs2.next())
			  	{
			  		lspill_exp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			
			  	stmt2=conn.createStatement();
				  String lspillWorksDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   and (sysdate -  a.admin_date<5*365 )";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  lspillWorksDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  lspillWorksDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  lspillWorksDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  lspillWorksDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  lspillWorksDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  lspillWorksDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(lspillWorksDirExp);
				    //System.out.println("lspillWorksDirExp ............"+lspillWorksDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_direxp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();
			
			stmt2 = conn.createStatement();
			String lnewWorks = "select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null  and (sysdate -  a.admin_date<5*365 )";
			if (dcode != null && !dcode.equals("00")) {
				lnewWorks += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				lnewWorks += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lnewWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lnewWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lnewWorks += " and a.work_id in(" + stworks + ")";
			}
			lnewWorks += " and  programme_code in (" + programe + ")  ";

			rs2 = stmt2.executeQuery(lnewWorks);
			//System.out.println("lnewWorks ............" + lnewWorks);

			while (rs2.next()) {
				lnewcnt += rs2.getInt(1);
				lnew_amt += rs2.getDouble(2);
			}

			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			
			stmt2 = conn.createStatement();
			String lspillHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c  where a.work_id=b.work_id and  b.hab_code=c.panch_code and  to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"
					+ startyr + "'))     and (sysdate -  a.admin_date<5*365 ) ";
			if (dcode != null && !dcode.equals("00")) {
				lspillHabs += "and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				lspillHabs += "and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillHabs += " and a.work_id in(" + stworks + ")";
			}
			lspillHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(lspillHabs);
			//System.out.println("lspillHabs ............" +lspillHabs);

			while (rs2.next()) {
				lspill_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();
			
			stmt2 = conn.createStatement();
			String lnewHabs = "select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where  a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"
					+ startyr
					+ "' and to_date(ADMIN_DATE) <'01-Apr-"
					+ endyr + "' and work_cancel_dt is null and (sysdate -  a.admin_date<5*365 )";
			if (dcode != null && !dcode.equals("00")) {
				lnewHabs += " and substr(a.work_id,5,2)='" + dcode + "'";
			}
			if (scheme != null && !scheme.equals("")) {
				lnewHabs += " and type_of_asset in(" + scheme + ")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lnewHabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lnewHabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lnewHabs += " and a.work_id in(" + stworks + ")";
			}
			lnewHabs += " and  programme_code in (" + programe + ") ";

			rs2 = stmt2.executeQuery(lnewHabs);
			//System.out.println("lnewHabs ............" + lnewHabs);

			while (rs2.next()) {
				lnew_habcnt += rs2.getInt(1);
			}
			if (rs2 != null)
				rs2.close();
			if (stmt2 != null)
				stmt2.close();

//////////////////////////////////////////////////////////<5yrs completed works//////////////////////////////////////////////////////////////////////////////////////////////////////

            stmt2=conn.createStatement();
			String lspillcompWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b where  a.work_id=b.work_id and  work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date<5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillcompWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillcompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillcompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillcompWorks += " and a.work_id in(" + stworks + ")";
			}
			lspillcompWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillcompWorks);
			//System.out.println("lspillcompWorks ............"+lspillcompWorks);
			
			while(rs2.next())
			{
				lspillcompcnt+=rs2.getInt(1);
				lspill_compamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String lspillCompExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and a.work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"
						+ startyr
						+ "' and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date<5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lspillCompExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  lspillCompExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lspillCompExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lspillCompExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lspillCompExp += " and a.work_id in(" + stworks + ")";
			  }
			  lspillCompExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lspillCompExp);
			    //System.out.println("lspillCompExp ............"+lspillCompExp);
			  	
			  	while(rs2.next())
			  	{
			  		lspill_compexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();
			  	
			  	
			  	stmt2=conn.createStatement();
				  String lspillCompDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b,rws_work_completion_tbl c   where a.work_id=b.work_id and a.work_id=c.work_id and a.work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"
							+ startyr
							+ "' and  (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date<5*365 )";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  lspillCompDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  lspillCompDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  lspillCompDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  lspillCompDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  lspillCompDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  lspillCompDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(lspillCompDirExp);
				    //System.out.println("lspillCompDirExp ............"+lspillCompDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_compdirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close();
			
			stmt2=conn.createStatement();
			String lspillcomphabs="select count(distinct hab_code)  FROM RWS_WORK_ADMN_TBL a  ,rws_work_completion_tbl b ,RWS_WORK_COMP_HAB_LNK_TBL c ,rws_complete_hab_view d where  a.work_id=b.work_id and a.work_id=c.work_id and c.hab_Code=d.panch_code and   work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"
					+ startyr
					+ "' and (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"'  and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' ) and (sysdate -  admin_date<5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillcomphabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillcomphabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillcomphabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillcomphabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillcomphabs += " and a.work_id in(" + stworks + ")";
			}
			lspillcomphabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillcomphabs);
			//System.out.println("lspillcomphabs ............"+lspillcomphabs);
			
			while(rs2.next())
			{
				lspill_comphabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			
			stmt2=conn.createStatement();
		
		    String lnewcompWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b  where a.work_id=b.work_id and to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"' and (sysdate -  admin_date<5*365 )";
				
			if(dcode!=null && !dcode.equals("00"))
			{
				lnewcompWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lnewcompWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lnewcompWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lnewcompWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lnewcompWorks += " and a.work_id in(" + stworks + ")";
			}
			lnewcompWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lnewcompWorks);
			//System.out.println("lnewcompWorks ............"+lnewcompWorks);
			
			while(rs2.next())
			{
				lnewcompcnt+=rs2.getInt(1);
				lnew_compamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			stmt2=conn.createStatement();
			String lnewCompHabs="select count(distinct hab_code) FROM RWS_WORK_ADMN_TBL a,RWS_WORK_COMP_HAB_LNK_TBL   b ,rws_work_completion_tbl c,rws_complete_hab_view d  where a.work_id=b.work_id and a.work_id=c.work_id and b.hab_code=d.panch_code and  to_date(a.ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(a.ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"' and to_date(DATE_OF_COMPLETION) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lnewCompHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
		      if(scheme!=null && !scheme.equals(""))
		      {
		    	  lnewCompHabs+=" and type_of_asset in("+scheme+")";
			  }
		      if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
		      {
		    	  lnewCompHabs += " and a.work_id in(" + plainworks + ")";
		      	
		      }
		      if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
		      {    
		    	  lnewCompHabs += " and a.work_id in(" + scworks + ")";
		      }
		      if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
		      {    
		    	  lnewCompHabs += " and a.work_id in(" + stworks + ")";
		      }
		      lnewCompHabs+=" and  programme_code in ("+programe+") "; 
		      
			  	rs2=stmt2.executeQuery(lnewCompHabs);
			    //System.out.println("lnewCompHabs ............"+lnewCompHabs);
			  	
			  	while(rs2.next())
			  	{
			  		lnew_comphabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();  
	  	
	  		
	////////////////////////////////////////////<5yrs Anticipated Works////////////////////////////////////////////////////////////		
			
		    stmt2=conn.createStatement();
			String lspillantiWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where   work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )  ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillantiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillantiWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillantiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillantiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillantiWorks += " and a.work_id in(" + stworks + ")";
			}
			lspillantiWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillantiWorks);
			//System.out.println("lspillantiWorks ............"+lspillantiWorks);
			
			while(rs2.next())
			{
				lspillanticnt+=rs2.getInt(1);
				lspill_antiamt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			 stmt2=conn.createStatement();
			  String lspillAntiExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )  ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lspillAntiExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  lspillAntiExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lspillAntiExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lspillAntiExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lspillAntiExp += " and a.work_id in(" + stworks + ")";
			  }
			  lspillAntiExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lspillAntiExp);
			    //System.out.println("lspillAntiExp ............"+lspillAntiExp);
			  	
			  	while(rs2.next())
			  	{
			  		lspill_antiexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			  	
			  	
			  	 stmt2=conn.createStatement();
				  String lspillAntiDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )  ";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  lspillAntiDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  lspillAntiDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  lspillAntiDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  lspillAntiDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  lspillAntiDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  lspillAntiDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(lspillAntiDirExp);
				    //System.out.println("lspillAntiDirExp ............"+lspillAntiDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_antidirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 

			
			
			stmt2=conn.createStatement(); 
			String lspillantihabs="select count(distinct hab_code)  FROM RWS_WORK_ADMN_TBL a ,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c  where  a.work_id=b.work_id and b.hab_code=c.panch_Code and work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and  a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 ) and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillantihabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillantihabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillantihabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillantihabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillantihabs += " and a.work_id in(" + stworks + ")";
			}
			lspillantihabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillantihabs);
			//System.out.println("lspillantihabs ............"+lspillantihabs);
			
			while(rs2.next())
			{
				lspill_antihabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 	
			
	
			stmt2=conn.createStatement();
			String lnewAntiWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 )   ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lnewAntiWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lnewAntiWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lnewAntiWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lnewAntiWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lnewAntiWorks += " and a.work_id in(" + stworks + ")";
			}
			lnewAntiWorks+=" and  programme_code in ("+programe+")  "; 
			
			rs2=stmt2.executeQuery(lnewAntiWorks);
			//System.out.println("lnewAntiWorks ............"+lnewAntiWorks);
			
			while(rs2.next())
			{
				lnewanticnt+=rs2.getInt(1);
				lnew_antiamt+=rs2.getDouble(2);
			}
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String lnewantiHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+endyr+"'  and (sysdate -  admin_date<5*365 ) and AAP_TARGET_YEAR ='"+startyr+"-"+endyr+"' ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lnewantiHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				 lnewantiHabs+=" and type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lnewantiHabs += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lnewantiHabs += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lnewantiHabs += " and a.work_id in(" + stworks + ")";
			  }
			  lnewantiHabs+=" and  programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lnewantiHabs);
			    //System.out.println("lnewantiHabs ............"+lnewantiHabs);
			  	
			  	while(rs2.next())
			  	{
			  		lnew_antihabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();   
			  				
			
			
	//////////////////////////////////////////////////////<5yrs Targeted Works///////////////////////////////////////////////////////////////////////////////////////////////////////		
			
	        stmt2=conn.createStatement();
			String lspillTargetWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a   where   work_cancel_dt is null and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillTargetWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			lspillTargetWorks+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillTargetWorks);
			//System.out.println("lspillTargetWorks ............"+lspillTargetWorks);
			
			while(rs2.next())
			{
				lspilltarcnt+=rs2.getInt(1);
				lspill_taramt+=rs2.getDouble(2);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			
			
			  stmt2=conn.createStatement();
			  String lspillTargetExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 )  ";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lspillTargetExp+="and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  lspillTargetExp+="and a.type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lspillTargetExp += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lspillTargetExp += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lspillTargetExp += " and a.work_id in(" + stworks + ")";
			  }
			  lspillTargetExp+=" and  a.programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lspillTargetExp);
			    //System.out.println("lspillTargetExp ............"+lspillTargetExp);
			  	
			  	while(rs2.next())
			  	{
			  		lspill_tarexp+=rs2.getDouble(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close(); 
			  	
			  	
			  	stmt2=conn.createStatement();
				  String lspillTargetDirExp="select nvl(sum(voucher_Amt)/100000,0)  FROM RWS_WORK_ADMN_TBL a,rws_work_direct_voucher_tbl b   where a.work_id=b.work_id and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"' and a.work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 )  ";
				  if(dcode!=null && !dcode.equals("00"))
				  {
					  lspillTargetDirExp+="and substr(a.work_id,5,2)='"+dcode+"'";
				  }
				  if(scheme!=null && !scheme.equals(""))
				  {
					  lspillTargetDirExp+="and a.type_of_asset in("+scheme+")";
				  }
				  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
				  {
					  lspillTargetDirExp += " and a.work_id in(" + plainworks + ")";
				  	
				  }
				  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
				  {    
					  lspillTargetDirExp += " and a.work_id in(" + scworks + ")";
				  }
				  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
				  {    
					  lspillTargetDirExp += " and a.work_id in(" + stworks + ")";
				  }
				  lspillTargetDirExp+=" and  a.programme_code in ("+programe+") "; 
				  
				  	rs2=stmt2.executeQuery(lspillTargetDirExp);
				    //System.out.println("lspillTargetDirExp ............"+lspillTargetDirExp);
				  	
				  	while(rs2.next())
				  	{
				  		lspill_tardirexp+=rs2.getDouble(1);
				  	}
				  	if(rs2!=null)rs2.close();
				  	if(stmt2!=null)stmt2.close(); 
			
			
			stmt2=conn.createStatement();
			String lspillTargethabs="select count(distinct hab_Code) FROM RWS_WORK_ADMN_TBL a  ,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where  a.work_id=b.work_id and b.hab_code=c.panch_code and AAP_TARGET_YEAR  is not null  and AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"' and  work_cancel_dt is null  and to_date(a.ADMIN_DATE) < '01-Apr-"+startyr+"'  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 ) ";
			if(dcode!=null && !dcode.equals("00"))
			{
				lspillTargethabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lspillTargethabs+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lspillTargethabs += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lspillTargethabs += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lspillTargethabs += " and a.work_id in(" + stworks + ")";
			}
			lspillTargethabs+=" and  programme_code in ("+programe+") "; 
			
			rs2=stmt2.executeQuery(lspillTargethabs);
			//System.out.println("lspillTargethabs ............"+lspillTargethabs);
			
			while(rs2.next())
			{
				lspill_tarhabcnt+=rs2.getInt(1);
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
					
			
			stmt2=conn.createStatement();
			String lnewTargetWorks="select count(distinct a.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL a  where to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 )";
			if(dcode!=null && !dcode.equals("00"))
			{
				lnewTargetWorks+=" and substr(a.work_id,5,2)='"+dcode+"'";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				lnewTargetWorks+=" and type_of_asset in("+scheme+")";
			}
			if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			{
				lnewTargetWorks += " and a.work_id in(" + plainworks + ")";
				
			}
			if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			{    
				lnewTargetWorks += " and a.work_id in(" + scworks + ")";
			}
			if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			{    
				lnewTargetWorks += " and a.work_id in(" + stworks + ")";
			}
			lnewTargetWorks+=" and  programme_code in ("+programe+")  "; 
			
			rs2=stmt2.executeQuery(lnewTargetWorks);
			//System.out.println("lnewTargetWorks ............"+lnewTargetWorks);
			
			while(rs2.next())
			{
				lnewtarcnt+=rs2.getInt(1);
				lnew_taramt+=rs2.getDouble(2);
			}
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close(); 
			
			  stmt2=conn.createStatement();
			  String lnewTargetHabs="select count(distinct b.hab_code) FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and  to_date(ADMIN_DATE) >='01-Apr-"+startyr+"' and to_date(ADMIN_DATE) <'01-Apr-"+endyr+"' and work_cancel_dt is null and to_date(TARGET_DATE_COMP) >= '01-Apr-"+endyr+"' and to_date(TARGET_DATE_COMP) < '01-Apr-"+nextyr+"'  and (sysdate -  admin_date<5*365 ) and  AAP_TARGET_YEAR ='"+endyr+"-"+nextyr+"'";
			  if(dcode!=null && !dcode.equals("00"))
			  {
				  lnewTargetHabs+=" and substr(a.work_id,5,2)='"+dcode+"'";
			  }
			  if(scheme!=null && !scheme.equals(""))
			  {
				  lnewTargetHabs+=" and type_of_asset in("+scheme+")";
			  }
			  if ( myreptype != null && myreptype.equals("Plain") && !plainworks.equals("")) 
			  {
				  lnewTargetHabs += " and a.work_id in(" + plainworks + ")";
			  	
			  }
			  if (myreptype != null && myreptype.equals("SC") && !scworks.equals("")) 
			  {    
				  lnewTargetHabs += " and a.work_id in(" + scworks + ")";
			  }
			  if (myreptype != null && myreptype.equals("ST") && !stworks.equals("")) 
			  {    
				  lnewTargetHabs += " and a.work_id in(" + stworks + ")";
			  }
			  lnewTargetHabs+=" and  programme_code in ("+programe+") "; 
			  
			  	rs2=stmt2.executeQuery(lnewTargetHabs);
			    //System.out.println("lnewTargetHabs ............"+lnewTargetHabs);
			  	
			  	while(rs2.next())
			  	{
			  		lnew_tarhabcnt+=rs2.getInt(1);
			  	}
			  	if(rs2!=null)rs2.close();
			  	if(stmt2!=null)stmt2.close();   			
		
			  	// //System.out.println(lspill_compamt+"...."+lspill_comexp);
				
%>

 <tr>
		<td class="gridbg1" style="text-align: left;">Less than 5 years</td>
		<td class="gridbg1" style="text-align: right;"><%=lspillcnt+lnewcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_amt-(lspill_exp+lspill_direxp)) + lnew_amt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspill_habcnt+lnew_habcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspillcompcnt+lnewcompcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_compamt-(lspill_compexp+lspill_compdirexp))+lnew_compamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspill_comphabcnt+lnew_comphabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspillanticnt+lnewanticnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_antiamt-(lspill_antiexp+lspill_antidirexp))+lnew_antiamt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspill_antihabcnt+lnew_antihabcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspilltarcnt+lnewtarcnt%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format((lspill_taramt-(lspill_tarexp+lspill_tardirexp))+lnew_taramt)%></td>
		<td class="gridbg1" style="text-align: right;"><%=lspill_tarhabcnt+lnew_tarhabcnt%></td>


	</tr>

<tr>

		<td class="gridhdbg" style="text-align: right;">Total</td>
		<td class="gridhdbg" style="text-align: right;"><%=gspillcnt+gnewcnt+lspillcnt+lnewcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_amt-(gspill_exp+gspill_direxp))+gnew_amt+(lspill_amt-(lspill_exp+lspill_direxp))+ lnew_amt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspill_habcnt+gnew_habcnt+lspill_habcnt+lnew_habcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspillcompcnt+gnewcompcnt+lspillcompcnt+lnewcompcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_compamt-(gspill_compexp+gspill_compdirexp))+gnew_compamt+(lspill_compamt-(lspill_compexp+lspill_compdirexp))+lnew_compamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspill_comphabcnt+gnew_comphabcnt+lspill_comphabcnt+lnew_comphabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspillanticnt+gnewanticnt+lspillanticnt+lnewanticnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_antiamt-(gspill_antiexp+gspill_antidirexp))+gnew_antiamt+(lspill_antiamt-(lspill_antiexp+lspill_antidirexp))+lnew_antiamt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspill_antihabcnt+gnew_antihabcnt+lspill_antihabcnt+lnew_antihabcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspilltarcnt+gnewtarcnt+lspilltarcnt+lnewtarcnt%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format((gspill_taramt-(gspill_tarexp+gspill_tardirexp))+gnew_taramt+(lspill_taramt-(lspill_tarexp+lspill_tardirexp))+lnew_taramt)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=gspill_tarhabcnt+gnew_tarhabcnt+lspill_tarhabcnt+lnew_tarhabcnt%></td>

	</tr>



	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</table>
</body>
