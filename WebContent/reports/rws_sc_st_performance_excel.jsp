<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SC/ST_SubPlan_details.xls");

%>

	<% 

String category=(String)session.getAttribute("category");
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";
           String pname="";

	pname=(String)session.getAttribute("pname");

	financialstartyr=(String)session.getAttribute("financialyr");
	
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

//System.out.println("Startyr:"+startyr);
//System.out.println("Startyr2:"+startyr2 );
//System.out.println("Endyr:"+endyr );

//System.out.println("Endyr2:"+endyr1);


     //System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");
%>
<table border=1 cellspacing=0 cellpadding=0 width="80%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center">
	<tr>
		<td align="center" class="gridhdbg" colspan="36">SC/ST Performance Report for(<%=financialstartyr%>)</td>
	</tr>
	<tr>
	<td align="center" class="gridhdbg" rowspan="4">Sl.No</td>
	<td align="center" class="gridhdbg" rowspan="4">District</td>
<td align="center" class="gridhdbg" rowspan="4">Program</td>
	<td align="center" class="gridhdbg" rowspan="4">Percentage</td>
		<td align="center" class="gridhdbg" rowspan="4">Works</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Habs</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Est Cost</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Expenditure</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Population</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="5">Tenders Finalized</td>
	<td align="center" class="gridhdbg"  rowspan="1" colspan="8">Works Completed</td>
	<td align="center" class="gridhdbg" rowspan="2" colspan="3">Likely Expenditure during 2013-14</td>
        <td align="center" class="gridhdbg" rowspan="2" colspan="3">Likely Expenditure during 2014-15</td>
	
	</tr>
	<tr>
	<td align="center" class="gridhdbg" rowspan="3">No of Works</td>
	<td align="center" class="gridhdbg" colspan="4">Est Cost</td>
	<td align="center" class="gridhdbg" rowspan="3">No of Works</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">Habs Completed</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="4">Est Cost</td>
	</tr>
<tr>
	<td align="center" class="gridhdbg" rowspan="2">SC</td>
	<td align="center" class="gridhdbg" rowspan="2">ST</td>

	<td align="center" class="gridhdbg" rowspan="2">Other Habs</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="2">SC</td>
	<td align="center" class="gridhdbg" rowspan="2">ST</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="2">SC>40%</td>
	<td align="center" class="gridhdbg" rowspan="2">ST>40%</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="3">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	<td align="center" class="gridhdbg" rowspan="2">Total</td>
	<td align="center" class="gridhdbg" rowspan="1" colspan="2">State Share</td>
	

	
	</tr>
	<tr>
	
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >Plain</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >Plain</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	<td align="center" class="gridhdbg" >SC</td>
	<td align="center" class="gridhdbg" >ST</td>
	

	
	</tr>
<tr>
	<%for(int i=1;i<37;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
	<%
	Statement stmt2 = null, stmt3 = null,stmt4=null,stmt7 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null, rs12 = null, rs13 = null, rs14 = null, rs15 = null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null, rs23= null, rs24 = null, rs25 = null,rs26 = null,rs27 = null, rs28 = null,rs29 = null,rs30 = null,rs31 = null,rs32 = null,rs33 = null,rs34 = null,rs35 = null,rs36 = null,rs37=null,rs38=null,rs39=null;
	String temp="",dname="";
	double g9=0.0,g10=0.0,g11=0.0,g12=0.0,g13=0.0,g14=0.0,g19=0.0,g20=0.0,g21=0.0,g22=0.0,g25=0.0,g26=0.0,g28=0.0,g29=0.0,g30=0.0,g31=0.0,g32=0.0,g33=0.0,g34=0.0,g35=0.0,g36=0.0;
	int g5=0,g6=0,g7=0,g8=0,g15=0,g16=0,g17=0,g18=0,g23=0,g24=0,g27=0,recCount = 0;
		String style = "";
			try {

			
   Hashtable plain_hash=(Hashtable)session.getAttribute("plain_hash");
   Hashtable works_plain_hash=(Hashtable)session.getAttribute("works_plain_hash");
   Hashtable plain_exp_hash=(Hashtable)session.getAttribute("plain_exp_hash");
   Hashtable plain_tender_hash=(Hashtable)session.getAttribute("plain_tender_hash");
   Hashtable plain_tender_wrk_hash=(Hashtable)session.getAttribute("plain_tender_wrk_hash");
   Hashtable wcplain_tender_hash=(Hashtable)session.getAttribute("wcplain_tender_hash");
   Hashtable wcscst_tender_hash=(Hashtable)session.getAttribute("wcscst_tender_hash");
   Hashtable wcplain_tender_wrk_hash=(Hashtable)session.getAttribute("wcplain_tender_wrk_hash");
   Hashtable wcscst_tender_wrk_hash=(Hashtable)session.getAttribute("wcscst_tender_wrk_hash");
   Hashtable scst_hash=(Hashtable)session.getAttribute("scst_hash");
   Hashtable habscount_scst_sc_hash=(Hashtable)session.getAttribute("habscount_scst_sc_hash");
   Hashtable habscount_scst_st_hash=(Hashtable)session.getAttribute("habscount_scst_st_hash");
   Hashtable habscount_scst_p_hash=(Hashtable)session.getAttribute("habscount_scst_p_hash");
   Hashtable works_scst_hash=(Hashtable)session.getAttribute("works_scst_hash");
   Hashtable scst_exp_hash=(Hashtable)session.getAttribute("scst_exp_hash");
   Hashtable scst_tender_hash=(Hashtable)session.getAttribute("scst_tender_hash");
   Hashtable scst_tender_wrk_hash=(Hashtable)session.getAttribute("scst_tender_wrk_hash");
   Hashtable scpop_works_hab_hash=(Hashtable)session.getAttribute("scpop_works_hab_hash");
   Hashtable sc_bef_exp_hash=(Hashtable)session.getAttribute("sc_bef_exp_hash");
   Hashtable sc_exp_hash=(Hashtable)session.getAttribute("sc_exp_hash");
   Hashtable spillOverWorksHashsc=(Hashtable)session.getAttribute("spillOverWorksHashsc");
   Hashtable tenderHashsc=(Hashtable)session.getAttribute("tenderHashsc");
   Hashtable workscomptdHashsc=(Hashtable)session.getAttribute("workscomptdHashsc");
   Hashtable sc_habcount_sc=(Hashtable)session.getAttribute("sc_habcount_sc");
   Hashtable st_habcount_sc=(Hashtable)session.getAttribute("st_habcount_sc");
   Hashtable p_habcount_sc=(Hashtable)session.getAttribute("p_habcount_sc");
   Hashtable stpop_works_hab_hash=(Hashtable)session.getAttribute("stpop_works_hab_hash");
   Hashtable st_bef_exp_hash=(Hashtable)session.getAttribute("st_bef_exp_hash");
   Hashtable st_exp_hash=(Hashtable)session.getAttribute("st_exp_hash");
   Hashtable spillOverWorksHashst=(Hashtable)session.getAttribute("spillOverWorksHashst");
   Hashtable tenderHashst=(Hashtable)session.getAttribute("tenderHashst");
   Hashtable workscomptdHashst=(Hashtable)session.getAttribute("workscomptdHashst");
   Hashtable sc_habcount_st=(Hashtable)session.getAttribute("sc_habcount_st");
   Hashtable p_habcount_st=(Hashtable)session.getAttribute("p_habcount_st");
   Hashtable st_habcount_st=(Hashtable)session.getAttribute("st_habcount_st");

	  		 stmt7=conn.createStatement(); 	
			//////////////////////////Printing Loop Query/////////////////////////////////////////////
			String newWorksQuery = "select distinct d.dname,c.programme_name,d.dcode,c.programme_code from rws_work_admn_tbl a,rws_district_tbl d,rws_programme_tbl c where substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=c.programme_code and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.WORK_CANCEL_DT  is null ";

	         if(dcode!=null && !dcode.equals("00"))
		  	  {
	        	 newWorksQuery+=" and d.DCODE='"+dcode+"'";
		  	  }

			  if(scheme!=null && !scheme.equals(""))
			  {
				  newWorksQuery+=" and a.type_of_asset in("+scheme+")";
			  }
			  if(category!=null && !category.equals("")){
				  newWorksQuery += " and a.special_cat='"+category+ "'";
	  	  					}
	  			  		
			newWorksQuery += " and c.programme_code in (" + programe+ ") group by d.dname,c.programme_name,d.dcode,c.programme_code order by d.dcode";
			
           // System.out.println("19) Main query....... "+newWorksQuery);
			rs7 = stmt7.executeQuery(newWorksQuery);
			while (rs7.next()) {
				int workcountsc=0,habcountsc=0,scpopcountsc=0,scpopcountst=0,scpopcountp=0,workcountst=0,habcountst=0,stpopcountsc=0,stpopcountst=0,stpopcountp=0,workcountp=0,habcountp=0,ppopcountsc=0,ppopcountst=0,ppopcountp=0;
				double scworkestsc=0.0,scworkestst=0.0,scworkestp=0.0,comptdscSanctionedAmt=0.0,stworkestsc=0.0,stworkestst=0.0,stworkestp=0.0,comptdstSanctionedAmt=0.0,pworkestsc=0.0,pworkestst=0.0,pworkestp=0.0,comptdpSanctionedAmt=0.0;
				double sctenderestsc=0.0,sctenderestst=0.0,sctenderestp=0.0,scspillSanctionedAmt = 0.0,tscSanctionedAmt=0.0,tstSanctionedAmt=0.0,tpSanctionedAmt=0.0, scSanctionedAmt = 0.0,scExpenditureAmt=0.0,scEstimationAmt=0.0,scEstcost2=0.0,scEstcost1=0.0,scExpenditureAmtb=0.0,scL13ExpenditureAmt=0.0,scL14ExpenditureAmt=0.0;
				double sttenderestsc=0.0,sttenderestst=0.0,sttenderestp=0.0,stspillSanctionedAmt = 0.0, stSanctionedAmt = 0.0,stExpenditureAmt=0.0,stEstimationAmt=0.0,stEstcost2=0.0,stEstcost1=0.0,stExpenditureAmtb=0.0,stL13ExpenditureAmt=0.0,stL14ExpenditureAmt=0.0;
				double ptenderestsc=0.0,ptenderestst=0.0,ptenderestp=0.0,pspillSanctionedAmt = 0.0, pSanctionedAmt = 0.0,pExpenditureAmt=0.0,pEstimationAmt=0.0,pEstcost2=0.0,pEstcost1=0.0,pExpenditureAmtb=0.0,pL13ExpenditureAmt=0.0,pL14ExpenditureAmt=0.0;
				int tworkcountsc=0,thabcountsc=0,tscpopcountsc=0,tscpopcountst=0,tscpopcountp=0,tworkcountst=0,thabcountst=0,tstpopcountsc=0,tstpopcountst=0,tstpopcountp=0,tworkcountp=0,thabcountp=0,tppopcountsc=0,tppopcountst=0,tppopcountp=0;
				int comptdworkcountsc=0,comptdhabcountsc=0,comptdscpopcountsc=0,comptdscpopcountst=0,comptdscpopcountp=0,comptdworkcountst=0,comptdhabcountst=0,comptdstpopcountsc=0,comptdstpopcountst=0,comptdstpopcountp=0,comptdworkcountp=0,comptdhabcountp=0,comptdppopcountsc=0,comptdppopcountst=0,comptdppopcountp=0;
				int schabsc=0,schabst=0,schabp=0,sthabsc=0,sthabst=0,sthabp=0;
				double ssscEstcost2=0.0,ssscExpenditureAmt=0.0,ssscL13ExpenditureAmt=0.0,ssscL14ExpenditureAmt=0.0,ssstEstcost2=0.0,ssstExpenditureAmt=0.0,ssstL13ExpenditureAmt=0.0,ssstL14ExpenditureAmt=0.0;
			    double sspEstcost2=0.0,sspExpenditureAmt=0.0,sspL13ExpenditureAmt=0.0,sspL14ExpenditureAmt=0.0,scL13expscshare=0.0,scL13expstshare=0.0,stL13expscshare=0.0,stL13expstshare=0.0,scL14expscshare=0.0,scL14expstshare=0.0,stL14expscshare=0.0,stL14expstshare=0.0,scexpscshare=0.0,scexpstshare=0.0,stexpscshare=0.0,stexpstshare=0.0,scestcostscshare=0.0,scestcoststshare=0.0,stestcostscshare=0.0,stestcoststshare=0.0,plainExpenditureAmt=0.0,scstExpenditureAmt=0.0;
				int scsthabcount=0,pplainhabcount=0,scstpopsc=0,scstpopst=0,scstpopp=0,plainpopsc=0,plainpopst=0,plainpopp=0,plaintotal=0,scsttotal=0;
		        double scstl13exp=0.0,scstl13expscshare=0.0,scstl13expstshare=0.0,scstl14exp=0.0,scstl14expscshare=0.0,scstl14expstshare=0.0,plainl13exp=0.0,plainl14exp=0.0;
		        int plainhabpopp=0,plainhabpopsc=0,plainhabpopst=0,scsthabpopp=0,scsthabpopsc=0,scsthabpopst=0,scsttotworks=0,plaintotworks=0;
		        double scstsnamt=0.0,scstsnamtpshare=0.0,scstsnamtscshare=0.0,scstsnamtstshare=0.0, plainsnamt=0.0, plainsnamtpshare=0.0;
		        double plainexp=0.0,tenderplainsnamt=0.0,tenderscstsnamt=0.0,tenderplainsnamtpshare=0.0,tenderscstsnamtpshare=0.0,tenderscstsnamtscshare=0.0,tenderscstsnamtstshare=0.0,scstexp=0.0;
		        int tenderplainpopp=0,schab=0,sthab=0,plainhab=0,tenderplainpopsc=0,tenderplainpopst=0,tenderplaintotal=0, wctenderplainpopp=0, wctenderplainpopsc=0,wctenderplainpopst=0, wctenderplaintotal=0;
		        int tenderscstpopp=0,tenderscstpopsc=0,tenderscstpopst=0,tenderscsttotal=0,wctenderscstpopp=0,wctenderscstpopsc=0,wctenderscstpopst=0,wctenderscsttotal=0,workscsthabcount=0;
		        int workplainhabcount=0,workscstpopsc=0, workscstpopst=0, workscstpopp=0, workplainpopsc=0,workplainpopst=0,workplainpopp=0,workplaintotal=0,workscsttotal=0;
		        double workscstl13exp=0.0,workscstl14exp=0.0,workplainl13exp=0.0,workplainl14exp=0.0;
		        int workplainhabpopp=0,workplainhabpopsc=0,workplainhabpopst=0,workscsthabpopp=0,workscsthabpopsc=0,workscsthabpopst=0,workscsttotworks=0,workplaintotworks=0;
		        double workscstsnamt=0.0, workscstsnamtpshare=0.0, workplainsnamt=0.0,workplainsnamtpshare=0.0,workplainsnamtscshare=0.0,workplainsnamtstshare=0.0;
		        int tenderplainhabcount=0,tenderscsthabcount=0,sc40count=0,st40count=0;   
		        double scstExpenditureAmtb=0.0,scstExpenditureAmtscshare=0.0,scstExpenditureAmtstshare=0.0,plainExpenditureAmtb=0.0;   
		        double pL13expscshare=0.0, pL13expstshare=0.0, pL14expscshare=0.0,pL14expstshare=0.0, pexpscshare=0.0, pexpstshare=0.0,pestcostscshare=0.0,pestcoststshare=0.0;
		              
		              
			  
					
				String programeCode=rs7.getString(4); 
				
				 int schabcount=0,sthabcount=0,phabcount=0;
					if(habscount_scst_sc_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
						 schabcount=(Integer)habscount_scst_sc_hash.get(rs7.getString(3)+rs7.getString(4));   
			      	  // System.out.println("sc "+schabcount);
			      
					 }
				           if(habscount_scst_st_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
				        	   sthabcount=(Integer)habscount_scst_st_hash.get(rs7.getString(3)+rs7.getString(4)); 
				        	  // System.out.println("st "+sthabcount);
				            }
				           if(habscount_scst_p_hash.get(rs7.getString(3)+rs7.getString(4))!=null){
				        	   phabcount=(Integer)habscount_scst_p_hash.get(rs7.getString(3)+rs7.getString(4));  
				        	   //System.out.println("plain "+phabcount);
			     
				           }
				if(sc_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabsc=(Integer)sc_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(st_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabst=(Integer)st_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(p_habcount_sc.get(rs7.getString(3)+rs7.getString(4))!=null){
					schabp=(Integer)p_habcount_sc.get(rs7.getString(3)+rs7.getString(4));
				}
				if(sc_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabsc=(Integer)sc_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				if(st_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabst=(Integer)st_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				if(p_habcount_st.get(rs7.getString(3)+rs7.getString(4))!=null){
					sthabp=(Integer)p_habcount_st.get(rs7.getString(3)+rs7.getString(4));
				}
				
					if(scpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2))!=null){
		
			
				String scpop = (String) scpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2));
				String scpopValues[] = scpop.split("@");
				 workcountsc = Integer.parseInt(scpopValues[0]);
				 habcountsc = Integer.parseInt(scpopValues[1]);
				 scpopcountsc = Integer.parseInt(scpopValues[3]);
				 scpopcountst = Integer.parseInt(scpopValues[4]);
				 scpopcountp = Integer.parseInt(scpopValues[2]);
				 scSanctionedAmt=Double.parseDouble(scpopValues[5]);
				 scL13ExpenditureAmt=Double.parseDouble(scpopValues[6]);
				 scL14ExpenditureAmt=Double.parseDouble(scpopValues[7]);
				 
					 
				 
				 }
					if(sc_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scExpenditureAmtb=Double.parseDouble((String)sc_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					
					if(sc_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scExpenditureAmt=Double.parseDouble((String)sc_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					if(spillOverWorksHashsc.get(rs7.getString(3)+ rs7.getString(4))!=null){
						scspillSanctionedAmt=Double.parseDouble((String)spillOverWorksHashsc.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					//tender hash table
					if(tenderHashsc.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String tscpop = (String) tenderHashsc.get(rs7.getString(1)+ rs7.getString(2));
						String tscpopValues[] = tscpop.split("@");
						 tworkcountsc = Integer.parseInt(tscpopValues[0]);
						 tscSanctionedAmt=Double.parseDouble(tscpopValues[1]);
						 
						 tscpopcountsc = Integer.parseInt(tscpopValues[3]);
						 tscpopcountst = Integer.parseInt(tscpopValues[4]);
						 tscpopcountp = Integer.parseInt(tscpopValues[2]);
						 double sstscSanctionedAmt=0.0;
						 int totalsc=tscpopcountsc+tscpopcountst+tscpopcountp;
						 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){

						sstscSanctionedAmt=0.5*tscSanctionedAmt;}
						 if(totalsc==0){
								sctenderestsc=0;sctenderestst=0;sctenderestp=0;
							}else{
								sctenderestsc=(sstscSanctionedAmt/totalsc)*tscpopcountsc;
								sctenderestst=(sstscSanctionedAmt/totalsc)*tscpopcountst;
								sctenderestp=(sstscSanctionedAmt/totalsc)*tscpopcountp;
							}
						 }
					
					 if(workscomptdHashsc.get(rs7.getString(1)+ rs7.getString(2))!=null){
							
							
							String workssc = (String) workscomptdHashsc.get(rs7.getString(1)+ rs7.getString(2));
							String worksscValues[] = workssc.split("@");
							comptdworkcountsc = Integer.parseInt(worksscValues[0]);
							comptdscSanctionedAmt=Double.parseDouble(worksscValues[1]);
							comptdhabcountsc = Integer.parseInt(worksscValues[2]);
							comptdscpopcountsc = Integer.parseInt(worksscValues[4]);
							comptdscpopcountst = Integer.parseInt(worksscValues[5]);
							comptdscpopcountp = Integer.parseInt(worksscValues[3]);
							 int worktotalsc=comptdscpopcountsc+comptdscpopcountst+comptdscpopcountp;
							 double sscomptdscSanctionedAmt=0.0;
							 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
								 sscomptdscSanctionedAmt=0.5*comptdscSanctionedAmt;
							 }
							  
							 if(worktotalsc==0){
									scworkestsc=0;scworkestst=0;scworkestp=0;
								}else{
									scworkestsc=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountsc;
									scworkestst=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountst;
									scworkestp=(sscomptdscSanctionedAmt/worktotalsc)*comptdscpopcountp;
								}
							 }	
					
		               scEstcost2= scspillSanctionedAmt-scExpenditureAmtb;
		              // System.out.println("befor  1>"+scEstcost2+"   2>"+scExpenditureAmt+"  3>"+scL13ExpenditureAmt+"  4>"+scL14ExpenditureAmt);
		              // System.out.println("------programeCode-------"+programeCode);
		               if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
							
						 ssscEstcost2=0.5*scEstcost2;
						 ssscExpenditureAmt=0.5*scExpenditureAmt;
						 ssscL13ExpenditureAmt=0.5*scL13ExpenditureAmt;
						 ssscL14ExpenditureAmt=0.5*scL14ExpenditureAmt;
						 //System.out.println("after 1>"+scEstcost2+" 2> "+scExpenditureAmt+" 3>"+scL13ExpenditureAmt+" 4>"+scL14ExpenditureAmt);
						}
						

					 int totpopsc=scpopcountsc+scpopcountst+scpopcountp;
					 if(totpopsc==0){
						 scL13expscshare=0.0;
						 scL14expstshare=0.0;
						 scexpscshare=0.0;
						 scexpstshare=0.0;
						 scestcostscshare=0.0;
						 scL13expstshare=0.0;
						 scestcostscshare=0.0;
						 scL14expscshare=0.0;
					 }
					 else
					 {
						 scL13expscshare=(ssscL13ExpenditureAmt*scpopcountsc)/totpopsc;
						 scL13expstshare=(ssscL13ExpenditureAmt*scpopcountst)/totpopsc;
						scL14expscshare=(ssscL14ExpenditureAmt*scpopcountsc)/totpopsc;
						 scL14expstshare=(ssscL14ExpenditureAmt*scpopcountst)/totpopsc;
						 scexpscshare=(ssscExpenditureAmt*scpopcountsc)/totpopsc;
						 scexpstshare=(ssscExpenditureAmt*scpopcountst)/totpopsc;
						 scestcostscshare=(ssscEstcost2*scpopcountsc)/totpopsc;
						 scestcoststshare=(ssscEstcost2*scpopcountst)/totpopsc;
					 }
					if(schabst==0){
						 scexpstshare=0.0;
						 scL14expstshare=0.0;
						 scL13expstshare=0.0;
						 scestcoststshare=0.0;
						 scworkestst=0.0;
						 sctenderestst=0.0;
					}
					if(schabst==0){
						 scworkestp=0.0;
						 sctenderestp=0.0;	
					}
					
//***sc complete*******

					if(stpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String stpop = (String) stpop_works_hab_hash.get(rs7.getString(1)+ rs7.getString(2));
						String stpopValues[] = stpop.split("@");
						 workcountst = Integer.parseInt(stpopValues[0]);
						 habcountst= Integer.parseInt(stpopValues[1]);
						 stpopcountsc = Integer.parseInt(stpopValues[3]);
						 stpopcountst = Integer.parseInt(stpopValues[4]);
						 stpopcountp = Integer.parseInt(stpopValues[2]);
						 stSanctionedAmt=Double.parseDouble(stpopValues[5]);
						 stL13ExpenditureAmt=Double.parseDouble(stpopValues[6]);
						 stL14ExpenditureAmt=Double.parseDouble(stpopValues[7]);
						
					}
				
					if(st_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stExpenditureAmtb=Double.parseDouble((String)st_bef_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					
					if(st_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stExpenditureAmt=Double.parseDouble((String)st_exp_hash.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
					if(spillOverWorksHashst.get(rs7.getString(3)+ rs7.getString(4))!=null){
						stspillSanctionedAmt=Double.parseDouble((String)spillOverWorksHashst.get(rs7.getString(3)+ rs7.getString(4)));
					
					}
if(tenderHashst.get(rs7.getString(1)+ rs7.getString(2))!=null){
						
						
						String tstpop = (String) tenderHashst.get(rs7.getString(1)+ rs7.getString(2));
						String tstpopValues[] = tstpop.split("@");
						 tworkcountst = Integer.parseInt(tstpopValues[0]);
						 tstSanctionedAmt=Double.parseDouble(tstpopValues[1]);
						 
						 tstpopcountsc = Integer.parseInt(tstpopValues[3]);
						 tstpopcountst = Integer.parseInt(tstpopValues[4]);
						 tstpopcountp = Integer.parseInt(tstpopValues[2]);
						 double sststSanctionedAmt=0.0;
						 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
							 sststSanctionedAmt=0.5*tstSanctionedAmt;
						 }
						int totalst=tstpopcountsc+tstpopcountst+tstpopcountp;
						 if(totalst==0){
								sttenderestsc=0;sttenderestst=0;sttenderestp=0;
							}else{
								sttenderestsc=(sststSanctionedAmt/totalst)*tstpopcountsc;
								sttenderestst=(sststSanctionedAmt/totalst)*tstpopcountst;
								sttenderestp=(sststSanctionedAmt/totalst)*tstpopcountp;
							}
						 }

if(workscomptdHashst.get(rs7.getString(1)+ rs7.getString(2))!=null){
	
	
	String worksst = (String) workscomptdHashst.get(rs7.getString(1)+ rs7.getString(2));
	String worksstValues[] = worksst.split("@");
	comptdworkcountst = Integer.parseInt(worksstValues[0]);
	comptdstSanctionedAmt=Double.parseDouble(worksstValues[1]);
	comptdhabcountst = Integer.parseInt(worksstValues[2]);
	comptdstpopcountsc = Integer.parseInt(worksstValues[4]);
	comptdstpopcountst = Integer.parseInt(worksstValues[5]);
	comptdstpopcountp = Integer.parseInt(worksstValues[3]);
	 int worktotalst=comptdstpopcountsc+comptdstpopcountst+comptdstpopcountp;
	 double sscomptdstSanctionedAmt=0.0;
	 if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
		 sscomptdstSanctionedAmt=0.5*comptdstSanctionedAmt;
	 }
	 if(worktotalst==0){
			stworkestsc=0;stworkestst=0;stworkestp=0;
		}else{
			stworkestsc=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountsc;
			stworkestst=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountst;
			stworkestp=(sscomptdstSanctionedAmt/worktotalst)*comptdstpopcountp;
		}
	 }
stEstcost2= stspillSanctionedAmt-stExpenditureAmtb;
if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	
	 ssstEstcost2=0.5*stEstcost2;
	 ssstL13ExpenditureAmt=0.5*stL13ExpenditureAmt;
	 ssstL14ExpenditureAmt=0.5*stL14ExpenditureAmt;
	 ssstExpenditureAmt=0.5*stExpenditureAmt;
	}
	
int totpopst=stpopcountsc+stpopcountst+stpopcountp;
if(totpopst==0){
	 stL13expscshare=0.0;
	 stL14expstshare=0.0;
	 stexpscshare=0.0;
	 stexpstshare=0.0;
	 stestcostscshare=0.0;
	 stL13expstshare=0.0;
	 stestcostscshare=0.0;
	 stL14expscshare=0.0;

}
else
{
	stL13expscshare=(ssstL13ExpenditureAmt*stpopcountsc)/totpopst;
	 stL13expstshare=(ssstL13ExpenditureAmt*stpopcountst)/totpopst;
	 stL14expscshare=(ssstL14ExpenditureAmt*stpopcountsc)/totpopst;
	 stL14expstshare=(ssstL14ExpenditureAmt*stpopcountst)/totpopst;
	 stexpscshare=(ssstExpenditureAmt*stpopcountsc)/totpopst;
	 stexpstshare=(ssstExpenditureAmt*stpopcountst)/totpopst;
	 stestcostscshare=(ssstEstcost2*stpopcountsc)/totpopst;
	 stestcoststshare=(ssstEstcost2*stpopcountst)/totpopst;
}
if(sthabsc==0){
	 stexpscshare=0.0;
	 stL14expscshare=0.0;
	 stL13expscshare=0.0;
	 stestcostscshare=0.0;
	 sttenderestsc=0.0;
	 stworkestsc=0.0;
}
if(sthabp==0){
	sttenderestp=0.0;
	 stworkestp=0.0;
}

					//st complet
               
               
                
                
               
              
             
				
				 if(plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
            		   {
            	   //System.out.println("hi this is plain");
            	   String plainpop = (String) plain_hash.get(rs7.getString(1)+rs7.getString(2));
					String plainpopValues[] = plainpop.split("@");
					pplainhabcount=Integer.parseInt(plainpopValues[0]);
            	   //System.out.println("plainhabcount is "+plainhabcount);
            	   plainpopp=Integer.parseInt(plainpopValues[1]);
            	   plainpopsc=Integer.parseInt(plainpopValues[2]);
            	   plainpopst=Integer.parseInt(plainpopValues[3]);
            	  
            	   plaintotal=plainpopsc+plainpopst+plainpopp;
               }
				 if(plain_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String tenderplainpop = (String) plain_tender_hash.get(rs7.getString(1)+rs7.getString(2));
				String tenderplainpopValues[] = tenderplainpop.split("@");
				tenderplainhabcount=Integer.parseInt(tenderplainpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   tenderplainpopp=Integer.parseInt(tenderplainpopValues[1]);
      	   tenderplainpopsc=Integer.parseInt(tenderplainpopValues[2]);
      	   tenderplainpopst=Integer.parseInt(tenderplainpopValues[3]);
      	
      	   tenderplaintotal=tenderplainpopsc+tenderplainpopst+tenderplainpopp;
      	  // System.out.println("ptendertotpop"+tenderplaintotal);
         }
				
				 if(scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String scstpop = (String) scst_hash.get(rs7.getString(1)+rs7.getString(2));
				String scstpopValues[] = scstpop.split("@");
      	   scsthabcount=Integer.parseInt(scstpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   scstpopp=Integer.parseInt(scstpopValues[1]);
      	 scstpopsc=Integer.parseInt(scstpopValues[2]);
      	scstpopst=Integer.parseInt(scstpopValues[3]);
      	//System.out.println("scstpopp-"+scstpopp+" scstpops-"+scstpopsc+" scstpopst-"+scstpopst);
      	   scsttotal=scstpopsc+scstpopst+scstpopp;
      	  double scpoppercentage=(scstpopp/scsttotal)*100;
      	 double stpoppercentage=(scstpopp/scsttotal)*100;
      	 double ppoppercentage=(scstpopp/scsttotal)*100;
      	 //if(scpoppercentage>40){
      		// schab=schab+1;
      		 
      	// }
      	// if(stpoppercentage>40)
      	// {
      	//	sthab=sthab+1; 
      	// }
      	//if(ppoppercentage>40)
     	// {
     	//	plainhab=plainhab+1; 
     	// }
         }
				
				 if(scst_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
	      		   {
	      	   //System.out.println("hi this is plain");
	      	   String tenderscstpop = (String) scst_tender_hash.get(rs7.getString(1)+rs7.getString(2));
					String scstplainpopValues[] = tenderscstpop.split("@");
					tenderscsthabcount=Integer.parseInt(scstplainpopValues[0]);
	      	   //System.out.println("plainhabcount is "+plainhabcount);
	      	   tenderscstpopp=Integer.parseInt(scstplainpopValues[1]);
	      	   tenderscstpopsc=Integer.parseInt(scstplainpopValues[2]);
	      	   tenderscstpopst=Integer.parseInt(scstplainpopValues[3]);
	      	  
	      	   tenderscsttotal=tenderscstpopsc+tenderscstpopst+tenderscstpopp;
	      	 //System.out.println("scsttenderscsttotal"+tenderscsttotal);
	         }
				 if(plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
				 {
					 if(!plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)).equals("null")){
	                	  tenderplainsnamt=Double.parseDouble((String)plain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)));
	                	 
	                	  tenderplainsnamtpshare=(tenderplainsnamt/tenderplaintotal)*tenderplainpopp;
	                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	                		  tenderplainsnamtpshare=0.5*tenderplainsnamtpshare;
	                      } 
	                	  
					 }
				 }
				 if(scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
				 {
					 if(!scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)).equals("null")){
	                	  tenderscstsnamt=Double.parseDouble((String)scst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2)));
	                	 
	                	  tenderscstsnamtpshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopp;
	                	  tenderscstsnamtscshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopsc;
	                	  tenderscstsnamtstshare=(tenderscstsnamt/tenderscsttotal)*tenderscstpopst;
	                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	                		  tenderscstsnamtpshare=0.5*tenderscstsnamtpshare;
	                		  tenderscstsnamtscshare=0.5*tenderscstsnamtscshare;
	                		  tenderscstsnamtstshare=0.5*tenderscstsnamtstshare;
	                      } 
	                	  
					 }
				 }
				 
								 if(works_plain_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
									 String plainworkdet=(String)works_plain_hash.get(rs7.getString(1)+rs7.getString(2));
				                	  String plainworkdetvalues[]=plainworkdet.split("@");
				                	  plaintotworks=Integer.parseInt(plainworkdetvalues[0]);
				                	 
				                	  if(!plainworkdetvalues[3].equals("null")){
				                	  plainsnamt=Double.parseDouble(plainworkdetvalues[3]);
				                	 
				                	  plainsnamtpshare=(plainsnamt/plaintotal)*plainhabpopp;
				                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
				("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
				                		  plainsnamtpshare=0.5*plainsnamtpshare;
				                      }
				                	  }
				                	  if(!plainworkdetvalues[1].equals("null")){
				                   	   plainl13exp=Double.parseDouble(plainworkdetvalues[1]);}
				                   	   if(!plainworkdetvalues[2].equals("null")){
				                   	   plainl14exp=Double.parseDouble(plainworkdetvalues[2]);}
				                   	   
									 
								 }
								 if(works_scst_hash.get(rs7.getString(1)+rs7.getString(2))!=null){
									 String scstworkdet=(String)works_scst_hash.get(rs7.getString(1)+rs7.getString(2));
				                	  String scstworkdetvalues[]=scstworkdet.split("@");
				                	  scsttotworks=Integer.parseInt(scstworkdetvalues[0]);
				                	 //System.out.println("aaaa"+scsttotworks);
				                	  if(!scstworkdetvalues[1].equals("null")){
				                		  scstl13exp=Double.parseDouble(scstworkdetvalues[1]);
				                		  scstl13expscshare=(scstl13exp/scsttotal)*scstpopsc;
				                		  scstl13expstshare=(scstl13exp/scsttotal)*scstpopst;
				                	  }
				                   	   if(!scstworkdetvalues[2].equals("null")){
				                   		scstl14exp=Double.parseDouble(scstworkdetvalues[2]);
				                   		scstl14expscshare=(scstl14exp/scsttotal)*scstpopsc;
				                		  scstl14expstshare=(scstl14exp/scsttotal)*scstpopst;
				                   	   
				                   	   }
				                   	   
				                	  if(!scstworkdetvalues[3].equals("null")){
				                		  scstsnamt=Double.parseDouble(scstworkdetvalues[3]);
				                	 
				                		  scstsnamtpshare=(scstsnamt/scsttotal)*scstpopp;
				                		  scstsnamtscshare=(scstsnamt/scsttotal)*scstpopsc;
				                		  scstsnamtstshare=(scstsnamt/scsttotal)*scstpopst;
				                	  
				                	  }
				                	  
				                	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
				              				("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
				              				                		  scstsnamtpshare=0.5*scstsnamtpshare;
				              				                		  scstsnamtscshare=0.5*scstsnamtscshare;
				              				                		  scstsnamtstshare=0.5*scstsnamtstshare;
				              				                		scstl13expscshare=0.5*scstl13expscshare;
				              				                		scstl13expstshare=0.5*scstl13expstshare;
				              				                		scstl14expscshare=0.5*scstl14expscshare;
				              				                		scstl14expstshare=0.5*scstl14expstshare;
				              				                      }
								 }
								 
								 
								 if(plain_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
										plainExpenditureAmt=Double.parseDouble((String)plain_exp_hash.get(rs7.getString(3)+ 
					rs7.getString(4)));
									if(plainpopp==0)
									{
										plainExpenditureAmt=0.0;	
									}
									
									}
					               if(scst_exp_hash.get(rs7.getString(3)+ rs7.getString(4))!=null){
										scstExpenditureAmt=Double.parseDouble((String)scst_exp_hash.get(rs7.getString(3)+ 
					rs7.getString(4)));
										scstExpenditureAmtscshare=(scstExpenditureAmt/scsttotal)*scstpopsc;
										scstExpenditureAmtstshare=(scstExpenditureAmt/scsttotal)*scstpopst;
										if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
												("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
											scstExpenditureAmtscshare=0.5*scstExpenditureAmtscshare;
											scstExpenditureAmtstshare=0.5*scstExpenditureAmtstshare;       		  
												             }
										if(scsttotal==0)
										{
											scstExpenditureAmtscshare=0.0;	
											scstExpenditureAmtstshare=0.0;	
										}
									}
		////works comptd
		
		if(wcplain_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
      		   {
      	   //System.out.println("hi this is plain");
      	   String wctenderplainpop = (String) wcplain_tender_hash.get(rs7.getString(1)+rs7.getString(2));
				String wctenderplainpopValues[] = wctenderplainpop.split("@");
				workplainhabcount=Integer.parseInt(wctenderplainpopValues[0]);
      	   //System.out.println("plainhabcount is "+plainhabcount);
      	   wctenderplainpopp=Integer.parseInt(wctenderplainpopValues[1]);
      	   wctenderplainpopsc=Integer.parseInt(wctenderplainpopValues[2]);
      	   wctenderplainpopst=Integer.parseInt(wctenderplainpopValues[3]);
      	
      	   wctenderplaintotal=wctenderplainpopsc+wctenderplainpopst+wctenderplainpopp;
      	   //System.out.println("ptendertotpop"+tenderplaintotal);
         }
		if(wcscst_tender_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		   {
	   //System.out.println("hi this is plain");
	   String wctenderscstpop = (String) wcscst_tender_hash.get(rs7.getString(1)+rs7.getString(2));
			String wctenderscstpopValues[] = wctenderscstpop.split("@");
			workscsthabcount=Integer.parseInt(wctenderscstpopValues[0]);
	   //System.out.println("plainhabcount is "+plainhabcount);
	   wctenderscstpopp=Integer.parseInt(wctenderscstpopValues[1]);
	   wctenderscstpopsc=Integer.parseInt(wctenderscstpopValues[2]);
	   wctenderscstpopst=Integer.parseInt(wctenderscstpopValues[3]);
	   
	   wctenderscsttotal=wctenderscstpopsc+wctenderscstpopst+wctenderscstpopp;
	   double scpercentage=(wctenderscstpopsc/wctenderscsttotal)*100;
	   double stpercentage=(wctenderscstpopst/wctenderscsttotal)*100;
	   if( scpercentage>40)
	   {
		 sc40count=sc40count+1;
		 
	   }
	   if( stpercentage>40)
	   {
		 st40count=st40count+1;
		 
	   }
	   //System.out.println("ptendertotpop"+tenderplaintotal);
  }		
		 if(wcplain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		 {
			 String wcplainworkdet=(String)wcplain_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2));
       	  String wcplainworkdetvalues[]=wcplainworkdet.split("@");
       	workplaintotworks=Integer.parseInt(wcplainworkdetvalues[0]);
       	 //System.out.println("aaaa"+scsttotworks);
       	  if(!wcplainworkdetvalues[1].equals("null")){
       		workplainsnamt=Double.parseDouble(wcplainworkdetvalues[1]);
       	 
       		workplainsnamtpshare=(workplainsnamt/wctenderplaintotal)*wctenderplainpopp;
       		if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
       		workplainsnamtpshare=0.5*workplainsnamtpshare;
       		
             }
       	  } 
		 }
			               
		 if(wcscst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2))!=null)
		 {
			 String wcscstworkdet=(String)wcscst_tender_wrk_hash.get(rs7.getString(1)+rs7.getString(2));
	       	  String wcscstworkdetvalues[]=wcscstworkdet.split("@");
	       	workscsttotworks=Integer.parseInt(wcscstworkdetvalues[0]);
	       	 //System.out.println("aaaa"+scsttotworks);
	       	  if(!wcscstworkdetvalues[1].equals("null")){
	       		workscstsnamt=Double.parseDouble(wcscstworkdetvalues[1]);
	       	 
	       		workscstsnamtpshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopp;
	       		workplainsnamtscshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopsc;
	       		workplainsnamtstshare=(workscstsnamt/wctenderscsttotal)*wctenderscstpopst;
	       	  
	       	  if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals
	("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
	       		workscstsnamtpshare=0.5*workscstsnamtpshare;
	       		workplainsnamtscshare=0.5*workplainsnamtscshare;
	       		workplainsnamtstshare=0.5*workplainsnamtstshare;  
	             }
	       	  } 
		 }		
	

               if(dname.equals(rs7.getString(1))||temp.equals(rs7.getString(1))){
            	   dname="-";
               }else{
            	   dname=rs7.getString(1);
               }
               
               /////
             
               
               
               ////addhere 1)
                          		   
	%>
	<tr>
		<td rowspan="5" class=<%=style%>><%=++recCount%></td>

		<td rowspan="5" class="gridbg1" style="text-align: left;"><%=dname%></td>
		<td rowspan="5" class="gridbg1" style="text-align: left;"><%=rs7.getString(2)%></td>
		<td class="gridbg1" style="text-align: center;">SC>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc%></td>

		<td class="gridbg1" style="text-align: right;"><%=schabsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabst %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcoststshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpstshare) %></td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp%></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc %></td>
		<td class="gridbg1"  style="text-align: right;"><%=scpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestst) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expstshare) %></td>
	</tr>
	
	<tr>
		<td class="gridbg1" style="text-align: center;">ST>40%</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountst%></td>
       <td class="gridbg1" style="text-align: right;"><%=sthabsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabst %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabp %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stEstcost2) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcostscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc+stpopcountst+stpopcountp %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=stpopcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst) %></td>
		
	
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdstSanctionedAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL13ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=stL14ExpenditureAmt %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare) %></td>
</tr>

	<tr>
		<td class="gridbg1" style="text-align: center;"><40%</td>

		<td class="gridbg1" style="text-align: right;"><%=scsttotworks %></td>
       <td class="gridbg1" style="text-align: right;"><%=schabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=sthabcount %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=phabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstsnamtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstExpenditureAmtstshare) %></td>
	
		<td class="gridbg1" style="text-align: right;"><%=scsttotal %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scstpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tenderscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtpshare) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderscstsnamtstshare) %></td>
	
		<td class="gridbg1" style="text-align: right;"><%=workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=sc40count %></td>
		<td class="gridbg1" style="text-align: right;"><%=st40count %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workscstsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl13expstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14expscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scstl14expstshare) %></td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Plain</td>

		<td class="gridbg1" style="text-align: right;"><%=plaintotworks %></td>
       <td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		
		<td class="gridbg1" style="text-align: right;"><%=pplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainsnamt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=plainpopp %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=plainpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tenderplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamt) %></td>
				<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamtpshare) %></td>
		
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	
		<td class="gridbg1" style="text-align: right;"><%=workplaintotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=workplainhabcount %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtpshare) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainl13exp) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(plainl14exp) %></td>
		<td class="gridbg1" style="text-align: right;">-</td>
		<td class="gridbg1" style="text-align: right;">-</td>
	</tr>
	<tr>
		<td class="gridbg1" style="text-align: center;">Sub Total</td>

		<td class="gridbg1" style="text-align: right;"><%=workcountsc+workcountst+plaintotworks+scsttotworks%></td>

		<td class="gridbg1" style="text-align: right;"><%=schabsc+sthabsc+schabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=schabst+sthabst+sthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=pplainhabcount+phabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scEstcost2+stEstcost2+plainsnamt+scstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scestcostscshare+scstsnamtscshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stestcoststshare+scstsnamtstshare) %></td>
		
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scExpenditureAmt+stExpenditureAmt+plainExpenditureAmt+scstExpenditureAmt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scexpscshare+scstExpenditureAmtscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stexpstshare+scstExpenditureAmtstshare) %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+scpopcountst+scpopcountp+stpopcountsc+stpopcountst+stpopcountp+plainpopp+scsttotal %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountsc+stpopcountsc+scstpopsc %></td>
		<td class="gridbg1" style="text-align: right;"><%=scpopcountst+stpopcountst+scstpopst %></td>
		<td class="gridbg1" style="text-align: right;"><%=tworkcountsc+tworkcountst+tenderplainhabcount+tenderscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tscSanctionedAmt+tstSanctionedAmt+tenderplainsnamt+tenderscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(tenderplainsnamtpshare+tenderscstsnamtpshare+sctenderestp+sttenderestp) %> </td>
        <td class="gridbg1" style="text-align: right;"><%=ndf.format(sctenderestsc+tenderscstsnamtscshare+sttenderestsc) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(sttenderestst+tenderscstsnamtstshare+sctenderestst) %> </td>
		<td class="gridbg1" style="text-align: right;"><%=comptdworkcountsc+comptdworkcountst+workplaintotworks+workscsttotworks %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc+comptdhabcountst+workplainhabcount+workscsthabcount %></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountsc+sc40count%></td>
		<td class="gridbg1" style="text-align: right;"><%=comptdhabcountst+st40count%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(comptdscSanctionedAmt+comptdscSanctionedAmt+workplainsnamt+workscstsnamt) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(workplainsnamtpshare+workscstsnamtpshare+stworkestp+scworkestp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scworkestsc+workplainsnamtscshare+stworkestsc) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stworkestst+workplainsnamtstshare+scworkestst) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13ExpenditureAmt+stL13ExpenditureAmt+plainl13exp+scstl13exp) %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL13expscshare+scstl13expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL13expstshare+scstl13expstshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14ExpenditureAmt+stL14ExpenditureAmt+plainl14exp+scstl14exp)  %></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(scL14expscshare+scstl14expscshare)%></td>
		<td class="gridbg1" style="text-align: right;"><%=ndf.format(stL14expstshare+scstl14expstshare)%></td>
		</tr>
	
		

	<%
	g5+=workcountsc+workcountst+plaintotworks+scsttotworks;
	g6+=schabsc+sthabsc+schabcount;
	g7+=schabst+sthabst+sthabcount;
	g8+=pplainhabcount+phabcount; 
	g9+=scEstcost2+stEstcost2+plainsnamt+scstsnamt;
	g10+=scestcostscshare+scstsnamtscshare;
	g11+=stestcoststshare+scstsnamtstshare;
	g12+=scExpenditureAmt+stExpenditureAmt+plainExpenditureAmt+scstExpenditureAmt;
	g13+=scexpscshare+scstExpenditureAmtscshare;
    g14+=stexpstshare+scstExpenditureAmtstshare;
    g15+=scpopcountsc+scpopcountst+scpopcountp+stpopcountsc+stpopcountst+stpopcountp+plainpopp+scsttotal;
    g16+=scpopcountsc+stpopcountsc+scstpopsc;
    g17+=scpopcountst+stpopcountst+scstpopst;
    g18+=tworkcountsc+tworkcountst+tenderplainhabcount+tenderscsthabcount;
    g19+=tscSanctionedAmt+tstSanctionedAmt+tenderplainsnamt+tenderscstsnamt;
    g20+=tenderplainsnamtpshare+tenderscstsnamtpshare+sctenderestp+sttenderestp;
    g21+=sctenderestsc+tenderscstsnamtscshare+sttenderestsc;
    g22+=sttenderestst+tenderscstsnamtstshare+sctenderestst;
    g23+=comptdworkcountsc+comptdworkcountst+workplaintotworks+workscsttotworks;
    g24+=comptdhabcountsc+comptdhabcountst+workplainhabcount+workscsthabcount; 
   	g25+=comptdhabcountsc+sc40count;
    g26+=comptdhabcountst+st40count;
    g27+=comptdscSanctionedAmt+comptdscSanctionedAmt+workplainsnamt+workscstsnamt;
    g28+=workplainsnamtpshare+workscstsnamtpshare+stworkestp+scworkestp;
    g29+=scworkestsc+workplainsnamtscshare+stworkestsc;
    g30+=stworkestst+workplainsnamtstshare+scworkestst;
    g31+=scL13ExpenditureAmt+stL13ExpenditureAmt+plainl13exp+scstl13exp;
    g32+=scL13expscshare+scstl13expscshare;
    g33+=stL13expstshare+scstl13expstshare;
    g34+=scL14ExpenditureAmt+stL14ExpenditureAmt+plainl14exp+scstl14exp;    
    g35+=scL14expscshare+scstl14expscshare;
    g36+=stL14expstshare+scstl14expstshare;
    	temp=rs7.getString(1);
         
			}
			
	%>
	<tr>
	<td align="center" class="gridhdbg" colspan="4">Grand Total</td>
	<td align="center" class="gridhdbg" ><%=g5 %></td>
	<td align="center" class="gridhdbg" ><%=g6 %></td>
	<td align="center" class="gridhdbg" ><%=g7 %></td>
	<td align="center" class="gridhdbg" ><%=g8 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g9) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g10) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g11) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g12) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g13) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g14) %></td>
	<td align="center" class="gridhdbg" ><%=g15 %></td>
	<td align="center" class="gridhdbg" ><%=g16 %></td>
	<td align="center" class="gridhdbg" ><%=g17 %></td>
	<td align="center" class="gridhdbg" ><%=g18 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g19) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g20) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g21) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g22) %></td>
	<td align="center" class="gridhdbg" ><%=g23 %></td>
	<td align="center" class="gridhdbg" ><%=g24 %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g25) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g26) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g27) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g28) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g29) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g30) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g31) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g32) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g33) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g34) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g35) %></td>
	<td align="center" class="gridhdbg" ><%=ndf.format(g36) %></td>
	
	
	 </tr>






	<%
	if(stmt7!=null){
		stmt7.close();
	}
	if(rs7!=null){
		rs7.close();
	}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>
</body>
</html>