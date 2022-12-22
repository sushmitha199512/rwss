
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


	
	<%
	Calendar cal=Calendar.getInstance();
	StringBuffer year=new StringBuffer();
    year.append(""+cal.get(Calendar.YEAR));
    int styleCount=0;
    StringBuffer style=new StringBuffer();

    int PcAchvtot=0,QaAchvtot=0,Achvtot=0,Achvcnt=0,PwsAchvtot=0,HcAchvtot=0,Nsstargets=0,pwstargets=0,hctargets=0,svstargets=0,mvstargets=0,pctargets=0,gPcAchvtot=0,gQaAchvtot=0,gAchvtot=0,gPwsAchvtot=0,gHcAchvtot=0;
    int Nsstargetstot=0,pwstargetstot=0,hctargetstot=0,pctargettot=0,targetcnt=0,targettot=0;
    int tot1=0,tot2=0;
  int prevYear=Integer.parseInt(year.toString())-1;     
  StringBuffer dcode=new StringBuffer();
	StringBuffer finYear=(StringBuffer)session.getAttribute("finYear");
	StringBuffer scheme=(StringBuffer)session.getAttribute("schemes");;
	 StringBuffer habTableName=new StringBuffer();
	 
	
	

	 dcode.append((StringBuffer)session.getAttribute("dcode"));
		StringBuffer startyr=new StringBuffer();
		startyr.append(finYear.substring(0,4));
		
		//System.out.println("startyr:"+startyr);
		StringBuffer endyr=new StringBuffer();
		endyr.append(finYear.substring(5,9));
		
		
		
		StringBuffer endyr1=new StringBuffer();
		endyr1.append(finYear.substring(5,9));
		//System.out.println("endyr1:"+endyr1);
		StringBuffer s=new StringBuffer();
		
	
		StringBuffer habCovStatusCnt=new StringBuffer();
		StringBuffer habCovStatusQaAchvCnt=new StringBuffer();
		StringBuffer PwsAchvqry=new StringBuffer();
		StringBuffer HcAchvqry=new StringBuffer();
		StringBuffer targetsqry=new StringBuffer();
		StringBuffer monthsqry=new StringBuffer();
		StringBuffer getDnameQuery=new StringBuffer();
		StringBuffer PCAchvCnt=new StringBuffer();
		StringBuffer QAAchvCnt=new StringBuffer();
		StringBuffer pwsAchvCnt=new StringBuffer();
		StringBuffer HcAchvCnt=new StringBuffer();
		StringBuffer target_cnt=new StringBuffer();
		StringBuffer target100=new StringBuffer();

		
		
		
		
		
		
		
		
		
		
	 
	 //String startyr =finYear.substring(0,4);
		//String endyr =finYear.substring(5,9);
	   // String endyr1 =finYear.substring(5,9);
	  	 s.append(finYear.toString().substring(0,4));
	  if(finYear.toString().substring(0,4).equals(year))
	  {
	 habTableName.append("rws_habitation_directory_tbl");

	}
	else if(finYear.toString().substring(0,4).equals(String.valueOf(prevYear)))
	{
	 habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
	}
	else
	{
	habTableName.append("RWS_HABITATION_DIR_HIS"+s+"_TBL");
	}
	 // System.out.println("habTableName:"+habTableName);
	  
	  
	  StringBuffer programe=new StringBuffer();
	  
	  programe.append((StringBuffer)session.getAttribute("programe"));
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "inline; filename="
			+ "Target&AchievementReport.xls");
	
	
	
	
	
	%>
			<table  style="border-collapse:collapse" >	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan=24>RWSS Action Plan <%=finYear.toString() %> Report</td>	
		</tr>

<%
try
{
	
	
	%>
	
	<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=3>Sno</td>
			<td class=gridhdbg rowspan=3>District</td>			
			<td class=gridhdbg colspan=10 align=center nowrap>Action Plan for <%=finYear%></td>
			<td class=gridhdbg colspan=12 align=center nowrap>100 Days Action Plan</td>
 		</tr>
 		<tr align="center">
			<td class=gridhdbg  colspan=2>PC</td>
			<td class=gridhdbg  colspan=2>QA</td> 
			<td class=gridhdbg  colspan=2>Total<br>(PC+QA)</td>
			<td class=gridhdbg  colspan=2>PWS</td>
			<td class=gridhdbg  colspan=2>HC</td>
			<td class=gridhdbg  colspan=2>PC/SB</td>
			<td class=gridhdbg  colspan=2>QA</td>
			<td class=gridhdbg  colspan=2>Total Habs</td>
			<td class=gridhdbg  colspan=2>PWS</td>
			<td class=gridhdbg  colspan=2>HC</td>
			<td class=gridhdbg  colspan=2>Solar based coverage of Habitations</td>
		</tr>
	    <tr align="center">
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			<td class=gridhdbg >Target</td>
			<td class=gridhdbg >Ach</td>
			


<%

ResultSet rs1=null,rs2=null,rs3=null,prs = null,vrs =null,hrs = null;
Statement pst = null, vst = null , hst = null,getHabSt=null,stmt1=null,stmt3=null,stmt4=null;

PreparedStatement ps1=null;

//System.out.println("hiii");

// Qry for Pc(Achievements)


habCovStatusCnt.delete(0,habCovStatusCnt.length());
habCovStatusCnt.append("select distinct substr(a.work_id,5,2),count(distinct c.hab_code)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where (h.COVERAGE_STATUS <> 'NSS') and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where  (((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"')) or (to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"')))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode !=null && !dcode.toString().equals("51")){
		habCovStatusCnt.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme !=null && !scheme.toString().equals("")){
	 habCovStatusCnt.append("and a.type_of_asset in("+scheme.toString()+")");
 }
habCovStatusCnt.append(" and a.programme_code in ("+programe.toString()+")  group by  substr(a.work_id,5,2)");
//System.out.println("habCovStatusCnt:"+habCovStatusCnt);
 stmt4=conn.createStatement();
 rs3=stmt4.executeQuery(habCovStatusCnt.toString());
 Hashtable habCovStatus_Cnt=new Hashtable();
 	while(rs3.next())
 	{
 		habCovStatus_Cnt.put(rs3.getString(1),rs3.getString(2));
 	}
 	if(rs3!=null)rs3.close();
 	if(stmt4!=null)stmt4.close();

 	
//qry for QA(Achievements) 
 	habCovStatusQaAchvCnt.delete(0,habCovStatusQaAchvCnt.length());
 	habCovStatusQaAchvCnt.append("select distinct substr(a.work_id,5,2),count(distinct c.hab_code)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where (h.COVERAGE_STATUS = 'NSS') and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where  (((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"')) or (to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))) and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 habCovStatusQaAchvCnt.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	habCovStatusQaAchvCnt.append("and a.type_of_asset in("+scheme.toString()+")");
}
habCovStatusQaAchvCnt.append(" and a.programme_code in ("+programe.toString()+")  group by  substr(a.work_id,5,2)");
//System.out.println("habCovStatusQaAchvCnt:"+habCovStatusQaAchvCnt);
stmt4=conn.createStatement();
rs3=stmt4.executeQuery(habCovStatusQaAchvCnt.toString());
Hashtable habCovStatusQaAchv_Cnt=new Hashtable();
	while(rs3.next())
	{
		habCovStatusQaAchv_Cnt.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

//qry for PWS(Achievements) 	
	PwsAchvqry.delete(0,PwsAchvqry.length());

	PwsAchvqry.append("select distinct substr(a.work_id,5,2),count(distinct c.hab_code)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.DISTRIBUTION_LENGTH is not null and  c.DISTRIBUTION_LENGTH>'0' and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where  (((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"')) or (to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"')))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 PwsAchvqry.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	PwsAchvqry.append("and a.type_of_asset in("+scheme+")");
}
PwsAchvqry.append(" and a.programme_code in ("+programe.toString()+")  group by  substr(a.work_id,5,2)");
//System.out.println("PwsAchvqry:"+PwsAchvqry);
stmt4=conn.createStatement();
rs3=stmt4.executeQuery(PwsAchvqry.toString());
Hashtable PwsAch_Cnt=new Hashtable();
	while(rs3.next())
	{
		PwsAch_Cnt.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

	//qry for House Connections	

	HcAchvqry.delete(0,HcAchvqry.length());
	
	 HcAchvqry.append("select distinct substr(a.work_id,5,2),sum(HOUSE_CONN)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.HOUSE_CONN  is not null and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where  (((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"')) or (to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"')))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 HcAchvqry.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	HcAchvqry.append("and a.type_of_asset in("+scheme.toString()+")");
}
HcAchvqry.append(" and a.programme_code in ("+programe.toString()+")  group by  substr(a.work_id,5,2)");
//System.out.println("HcAchvqry:"+HcAchvqry.toString());
stmt4=conn.createStatement();
rs3=stmt4.executeQuery(HcAchvqry.toString());
Hashtable HcAch_Cnt=new Hashtable();
	while(rs3.next())
	{
		HcAch_Cnt.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();
	
//qry for Targets->NSS_HABS,PWS_HABS,HOUSE_CONNECTIONS

targetsqry.delete(0,targetsqry.length());

targetsqry.append("select dcode,NVL(PC_HABS,0),NVL(QA_HABS,0),NVL(PWS_HABS,0),NVL(HOUSE_CONNECTIONS,0) from rws_work_sch_target_tbl where fin_year='"+finYear.toString()+"'");
//System.out.println("targetsqry:"+targetsqry);
stmt4=conn.createStatement();
rs3=stmt4.executeQuery(targetsqry.toString());
Hashtable target_Cnt=new Hashtable();
	while(rs3.next())
	{
		target_Cnt.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();
	
	monthsqry.delete(0,monthsqry.length());
	monthsqry.append("select dcode,NVL(PC_HABS,0),NVL(QA_HABS,0),NVL(PWS_HABS,0),NVL(HOUSE_CONNECTIONS,0),NVL(solar_habs,0) from rws_target_ach_100days_tbl where fin_year='"+finYear.toString()+"'");
	//System.out.println("monthsqry:"+monthsqry);
	stmt4=conn.createStatement();
	rs3=stmt4.executeQuery(monthsqry.toString());
	Hashtable target_100=new Hashtable();
		while(rs3.next())
		{
			target_100.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6));
		}
		if(rs3!=null)rs3.close();
		if(stmt4!=null)stmt4.close();
	
	
	
	
	
		if(dcode!=null && dcode.toString().equals("51"))
		{
			getDnameQuery.delete(0,getDnameQuery.length());
		    getDnameQuery.append("select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode");
		}
		else{
			
		    getDnameQuery.append("select dcode,dname from rws_district_tbl where dcode='"+dcode.toString()+"'");
		}
		//System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery.toString());
		int sno = 1;
		rs2 = ps1.executeQuery(); 

int gpctargets100=0,gsbtargets100=0,gnsstargets100=0,ghctargets100=0,gqatargets100=0,gpwstargets100=0,gPCAchvCnt=0,gsolorHabsCount=0;
int gQAAchvCnt=0,gpwsAchvCnt=0;
while(rs2.next())
{  
	 //System.out.println("hiii");
	 
		int  pctargets100=0, Nsstargets100=0,  pwstargets100=0, hctargets100=0,solorHabsCount=0;
		PCAchvCnt.delete(0,PCAchvCnt.length());
		 PCAchvCnt.append((String)habCovStatus_Cnt.get(rs2.getString(1)));
		 if(PCAchvCnt==null || PCAchvCnt.toString().equals("null")){
			 
			 PCAchvCnt.delete(0, PCAchvCnt.length());
			 PCAchvCnt.append("0");
		 }
		 PcAchvtot+=Integer.parseInt(PCAchvCnt.toString());
		 //System.out.println("PcAchvtot:"+PcAchvtot);
	 
		 QAAchvCnt.delete(0,QAAchvCnt.length());
		 QAAchvCnt.append((String)habCovStatusQaAchv_Cnt.get(rs2.getString(1)));
		 if(QAAchvCnt==null || QAAchvCnt.toString().equals("null")){
			 
			 QAAchvCnt.delete(0,QAAchvCnt.length());
			 QAAchvCnt.append("0");
		 }
		 QaAchvtot+=Integer.parseInt(QAAchvCnt.toString());
		// System.out.println("QaAchvtot:"+QaAchvtot);
		 
		 Achvcnt=Integer.parseInt(PCAchvCnt.toString())+Integer.parseInt(QAAchvCnt.toString());
		 Achvtot+=Achvcnt;
		 
	 
	 
		 pwsAchvCnt.delete(0,pwsAchvCnt.length());
		 pwsAchvCnt.append((String)PwsAch_Cnt.get(rs2.getString(1)));
		 if(pwsAchvCnt==null || pwsAchvCnt.toString().equals("null")){
			 
			 pwsAchvCnt.delete(0,pwsAchvCnt.length());
			 pwsAchvCnt.append("0");
		 }
		 PwsAchvtot+=Integer.parseInt(pwsAchvCnt.toString());
		 
	 
		 HcAchvCnt.delete(0,HcAchvCnt.length());
			HcAchvCnt.append((String)HcAch_Cnt.get(rs2.getString(1)));
			 if(HcAchvCnt==null || HcAchvCnt.toString().equals("null")){
				 
				 
				 HcAchvCnt.delete(0,HcAchvCnt.length());
				 HcAchvCnt.append("0");
			 }
			 HcAchvtot+=Integer.parseInt(HcAchvCnt.toString());
			// System.out.println("HcAchvtot:"+HcAchvtot);
	 
	 
	 
	
	 
	 if(target_Cnt.get(rs2.getString(1))!=null)
	 {
		 target_cnt.append((String)target_Cnt.get(rs2.getString(1)));
		 String targetvalues[]=target_cnt.toString().split("@");
		 pctargets=Integer.parseInt(targetvalues[0]);
		  Nsstargets=Integer.parseInt(targetvalues[1]);
		  pwstargets=Integer.parseInt(targetvalues[2]);
		  hctargets=Integer.parseInt(targetvalues[3]);
	 }
	 
	// System.out.println("target_cnt:"+target_cnt);
	 
	 if(target_100.get(rs2.getString(1))!=null)
	 {
		target100.append((String)target_100.get(rs2.getString(1)));
		 String targetvalues[]=target100.toString().split("@");
		 pctargets100=Integer.parseInt(targetvalues[0]);
		  Nsstargets100=Integer.parseInt(targetvalues[1]);
		  pwstargets100=Integer.parseInt(targetvalues[2]);
		  hctargets100=Integer.parseInt(targetvalues[3]);
		  solorHabsCount=Integer.parseInt(targetvalues[4]);
	 }
	 gsolorHabsCount+=solorHabsCount;
	 pctargettot+=pctargets;
	 Nsstargetstot+=Nsstargets;
	 pwstargetstot+=pwstargets;
	 hctargetstot+=hctargets;
	 gpctargets100+=pctargets100+Nsstargets100;
	 gsbtargets100+=pctargets100;
	 gqatargets100+=Nsstargets100;
	 gnsstargets100+=Nsstargets100;
	 ghctargets100+=hctargets100;
	 gpwstargets100+=pwstargets100;
	 gPCAchvCnt+=Integer.parseInt(PCAchvCnt.toString());
	 
	 
	 gQAAchvCnt+=Integer.parseInt(QAAchvCnt.toString());
	 
	 gAchvtot+=Integer.parseInt(PCAchvCnt.toString())+Integer.parseInt(QAAchvCnt.toString());
	
	 gpwsAchvCnt+=Integer.parseInt(pwsAchvCnt.toString());
	 gHcAchvtot+=Integer.parseInt(HcAchvCnt.toString());
	 
	 targetcnt=pctargets+Nsstargets;
	 targettot+=targetcnt;
	 
	 
	 
	 style.delete(0, style.length());
		if(styleCount%2==0){
			 style.append("gridbg1");
		}else{
			 style.append("gridbg2");
		}
		styleCount++;
		
	%>
	<tr>
	<td class="<%=style %>" style="text-align: left;"><%=sno++%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(2) %></td>
	<td class="<%=style %>" style="text-align: right;"> <%=pctargets%></td>
    <td class="<%=style %>" style="text-align: right;"> <%=PCAchvCnt.toString()%></td>
    <td class="<%=style %>" style="text-align: right;"><%=Nsstargets %></td>
    <td class="<%=style %>" style="text-align: right;"> <%=QAAchvCnt.toString()%></td>
    <td class="<%=style %>" style="text-align: right;"> <%=targetcnt%></td>
	<td class="<%=style %>" style="text-align: right;"> <%=Achvcnt%></td>
	<td class="<%=style %>" style="text-align: right;"><%=pwstargets %></td>
	<td class="<%=style %>" style="text-align: right;"> <%=pwsAchvCnt.toString()%></td>	
	<td class="<%=style %>" style="text-align: right;"><%=hctargets %></td>
    <td class="<%=style %>" style="text-align: right;"> <%=HcAchvCnt.toString()%></td>
    
    <td class="<%=style %>" style="text-align: right;"> <%=pctargets100%></td>
    <td class="<%=style %>" style="text-align: right;"> <%=PCAchvCnt.toString() %></td>
    <td class="<%=style %>" style="text-align: right;"> <%=Nsstargets100%></td>
    <td class="<%=style %>" style="text-align: right;"> <%=QAAchvCnt.toString() %></td>	
    <td class="<%=style %>" style="text-align: right;"><%=(pctargets100+Nsstargets100) %> </td>
    <td class="<%=style %>" style="text-align: right;"> <%=(Integer.parseInt(PCAchvCnt.toString())+Integer.parseInt(QAAchvCnt.toString())) %></td>
    <td class="<%=style %>" style="text-align: right;"> <%=pwstargets100%></td>
    <td class="<%=style %>" style="text-align: right;"><%=pwsAchvCnt.toString() %> </td>	
    <td class="<%=style %>" style="text-align: right;"> <%=hctargets100%></td>
    <td class="<%=style %>" style="text-align: right;"><%=HcAchvCnt.toString() %> </td>	
	<td class="<%=style %>" style="text-align: right;"><%=solorHabsCount %></td>
    <td class="<%=style %>" style="text-align: right;"> </td>	
	
	
	
	
	
<% 	
//System.out.println("PcAchvtot->"+PcAchvtot);

///tot1+=PcAchvtot;
//System.out.println("tot1->"+tot1);

tot2+=QaAchvtot;
//System.out.println("tot2->"+tot2);

}
%>
<tr>
<td class="gridhdbg" style="text-align: left;" colspan=2>Total</td>
<td class="gridhdbg" style="text-align: right;"><%=pctargettot %></td>
<td class="gridhdbg" style="text-align: right;"><%=PcAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=Nsstargetstot %></td>
<td class="gridhdbg" style="text-align: right;"><%=QaAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=targettot %></td>
<td class="gridhdbg" style="text-align: right;"><%=Achvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=pwstargetstot %></td>
<td class="gridhdbg" style="text-align: right;"><%=PwsAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=hctargetstot %></td>
<td class="gridhdbg" style="text-align: right;"><%=HcAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=gsbtargets100 %></td>
<td class="gridhdbg" style="text-align: right;"><%=gPCAchvCnt %></td>
<td class="gridhdbg" style="text-align: right;"><%=gqatargets100 %></td>
<td class="gridhdbg" style="text-align: right;"><%=gQAAchvCnt %></td>
<td class="gridhdbg" style="text-align: right;"><%=gpctargets100 %></td>
<td class="gridhdbg" style="text-align: right;"><%=gAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=gpwstargets100 %></td>
<td class="gridhdbg" style="text-align: right;"><%=gpwsAchvCnt %></td>
<td class="gridhdbg" style="text-align: right;"><%=ghctargets100%></td>
<td class="gridhdbg" style="text-align: right;"><%=gHcAchvtot %></td>
<td class="gridhdbg" style="text-align: right;"><%=gsolorHabsCount %></td>
<td class="gridhdbg" style="text-align: right;"></td>

<%
 //end of if
}//end of catch
catch(Exception e)
{
	e.printStackTrace();
}
finally{
	
	
	 year=null;
	finYear=null;
	scheme=null;
	startyr=null;
	endyr=new StringBuffer();

	endyr1=null;
	programe=null;
	habTableName=null;
	s=null;
	
	style=null;
	habCovStatusCnt=null;
	habCovStatusQaAchvCnt=null;
	PwsAchvqry=null;
	HcAchvqry=null;
	targetsqry=null;
	monthsqry=null;
	getDnameQuery=null;
	PCAchvCnt=null;
	QAAchvCnt=null;
	pwsAchvCnt=null;
	 HcAchvCnt=null;
	 target_cnt=null;
	 target100=new StringBuffer();
	
	
	
	
}



	%>