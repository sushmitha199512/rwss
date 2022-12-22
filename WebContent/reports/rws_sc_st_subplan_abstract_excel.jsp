<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SC/ST_SubPlan_Abstract.xls");

%>

	<% 

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
	<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  style="border-collapse:collapse" align = "center">
<tr >
		<td align="center" class="gridhdbg" colspan=40>Abstract of RWS&S Ongoing Works of different programmes and Budget Provision under Tribal Sub Plan/SC Sub Plan for (<%=financialstartyr %>)--<%=pname %> .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" rowspan="3">Sl.No</td>   	
    	<td  class="gridhdbg" rowspan="3">District</td>
    	<td  class="gridhdbg" rowspan="3">Program</td>
    	<td colspan="6"  class="gridhdbg">No Of Works Proposed </td>
    	<td  class="gridhdbg" rowspan="3">Expenditure During<br></br>(<%=financialstartyr %>)</td>
    	<td  class="gridhdbg" rowspan="3">Total Habs Benifiting</td>
    	
    	
    	<td colspan="4" class="gridhdbg">Under SCSP 11(B)</td>
    	<td colspan="4" class="gridhdbg">Under TSP 11(B)</td>
    	<td colspan="10" class="gridhdbg">Under 11(C)</td>
    	<td colspan="4" class="gridhdbg">Towards Plain habs under Plain Component</td>
    	
    	<td colspan="4" class="gridhdbg">Total State Share</td>	
		</tr>
		
<tr>
	<td  class="gridhdbg" rowspan="2">New</td>
    <td  class="gridhdbg" rowspan="2">Est. cost</td>
    <td  class="gridhdbg" rowspan="2">Spill over</td>
    <td  class="gridhdbg" rowspan="2">Spill Est Cost </td>
    <td  class="gridhdbg" rowspan="2">Total works</td>
	<td  class="gridhdbg" rowspan="2">Total Est Cost</td>
	  <td  class="gridhdbg" rowspan="2">Habs</td>
    <td  class="gridhdbg" rowspan="2">Est. Cost</td>
    <td  class="gridhdbg" rowspan="2">Sate Share</td>
    <td  class="gridhdbg" rowspan="2">Exp During<br></br>(<%=financialstartyr %>)</td>
    <td  class="gridhdbg" rowspan="2">Habs</td>
    <td  class="gridhdbg" rowspan="2">Est. Cost</td>
    <td  class="gridhdbg" rowspan="2">Sate Share</td>
    <td  class="gridhdbg" rowspan="2">Exp During<br></br>(<%=financialstartyr %>)</td>
    <td  class="gridhdbg" rowspan="2">Habs</td>
    <td  class="gridhdbg" rowspan="2">Est. Cost.</td>
    <td  class="gridhdbg" colspan="4">State Share
    </td>
    <td  class="gridhdbg" rowspan="2">Exp During<br></br>(<%=financialstartyr %>)</td>
    <td  class="gridhdbg" colspan="3">Exp State Share<br></br>(<%=financialstartyr %>)</td>
    <td  class="gridhdbg" rowspan="2">Habs</td>
    <td  class="gridhdbg" rowspan="2">Est. Cost</td>
    <td  class="gridhdbg" rowspan="2">Sate Share</td>
    <td  class="gridhdbg" rowspan="2">Exp During<br></br>(<%=financialstartyr %>)</td>
    <td  class="gridhdbg" rowspan="2">Plain</td>
    <td  class="gridhdbg" rowspan="2">SC</td>
    <td  class="gridhdbg" rowspan="2">ST</td>
    <td  class="gridhdbg" rowspan="2">Toal</td>
</tr>
<tr>
<td  class="gridhdbg" rowspan="1" colspan="1">Plain</td>
    <td  class="gridhdbg">SC</td>
    <td  class="gridhdbg">ST</td>
    <td  class="gridhdbg">Toal</td>
    <td  class="gridhdbg" rowspan="1" colspan="1">Plain</td>
    <td  class="gridhdbg">SC</td>
    <td  class="gridhdbg">ST</td>
</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs4=null;
int count=1;
  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();


	  /******  Spill Over  Works *****************************************************/

	  	String spillOverWorks="select d.dcode,substr(work_id,1,2),count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"'    and  substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		spillOverWorks+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  spillOverWorks+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  spillOverWorks+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(work_id,1,2) ";

	  	//System.out.println("spillOverWorks"+spillOverWorks);
	  	ResultSet rs2=stmt2.executeQuery(spillOverWorks);
	  
	  	Hashtable spillOverWorksHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		
		
		//Expenditure
		
		stmt2=conn.createStatement();
		
		String spillOverExpWorks="select d.dcode,substr(w.work_id,1,2),(sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000),(sum(case when (to_date(voucher_dt)>= '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp  where  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		spillOverExpWorks+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  spillOverExpWorks+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  spillOverExpWorks+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	//System.out.println("spillOverExpWorks"+spillOverExpWorks);
	  
	  	rs2=stmt2.executeQuery(spillOverExpWorks);
	  
	  	Hashtable spillOverWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksExpHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		
		/******  Spill Over  Works-habs *****************************************************/

		stmt2=conn.createStatement();
	  	String spillOverWorksHabs="select d.dcode,substr(w.work_id,1,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd  where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"' and  c.work_id=w.work_id and hd.hab_code=c.hab_code and hd.coverage_status<>'UI' and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and WORK_CANCEL_DT  is null ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		spillOverWorksHabs+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  spillOverWorksHabs+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  spillOverWorksHabs+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  //	System.out.println("spillOverWorksHabs"+spillOverWorksHabs);
	  	 rs2=stmt2.executeQuery(spillOverWorksHabs);
	  
	  	Hashtable spillOverWorkshabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorkshabsHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		
		
		//hab pupulation
		
		
		/******  Spill Over  Works-habs --population*****************************************************/

		stmt2=conn.createStatement();
	  	String spillOverWorksHabPop="select d.dcode,substr(w.work_id,1,2),sum(hd.CENSUS_PLAIN_POPU) ,sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd  where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"' and  c.work_id=w.work_id and hd.hab_code=c.hab_code and hd.coverage_status<>'UI' and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and WORK_CANCEL_DT  is null   ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		spillOverWorksHabPop+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  spillOverWorksHabPop+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  spillOverWorksHabPop+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  //	System.out.println("spillOverWorksHabPop"+spillOverWorksHabPop);
	  	 rs2=stmt2.executeQuery(spillOverWorksHabPop);
	  
	  	Hashtable spillOverWorkshabsHashPop=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorkshabsHashPop.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		
		
		//new habs pop
		
		

		stmt2=conn.createStatement();
	  	String newWorksHabPop="select d.dcode,substr(w.work_id,1,2),sum(hd.CENSUS_PLAIN_POPU) ,sum(hd.CENSUS_SC_POPU),sum(hd.CENSUS_ST_POPU) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd  where  c.work_id=w.work_id and hd.hab_code=c.hab_code and hd.coverage_status<>'UI' and   substr(W.WORK_ID,5,2)=D.DCODE and (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"')  and WORK_CANCEL_DT  is null   ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		newWorksHabPop+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  newWorksHabPop+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  newWorksHabPop+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	//System.out.println("newWorksHabPop"+newWorksHabPop);
	  	 rs2=stmt2.executeQuery(newWorksHabPop);
	  
	  	Hashtable newWorkshabsHashPop=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		newWorkshabsHashPop.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		
		
		////
		
		
		 /******  New  Works *****************************************************/

		 
	    stmt2=conn.createStatement();
	  	String newWorks="select d.dcode,substr(work_id,1,2),count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null   ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		newWorks+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  newWorks+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  newWorks+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(work_id,1,2) ";

	  	//System.out.println("newWorks"+newWorks);
	  	 rs2=stmt2.executeQuery(newWorks);
	  
	  	Hashtable newWorksHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		newWorksHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();


	  
		
		
		//new hab
		
		
		stmt2=conn.createStatement();
	  	String newWorksHabs="select d.dcode,substr(w.work_id,1,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"')  and c.work_id=w.work_id and  substr(W.WORK_ID,5,2)=D.DCODE and hd.hab_code=c.hab_code and hd.coverage_status<>'UI'    and WORK_CANCEL_DT  is null  ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		newWorksHabs+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  newWorksHabs+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  newWorksHabs+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";

	  	//System.out.println("newWorksHabs"+newWorksHabs);
	  	 rs2=stmt2.executeQuery(newWorksHabs);
	  
	  	Hashtable newWorksHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		newWorksHabsHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		//programlink
		
		
		
		
	
	    stmt2=conn.createStatement();
		
		
	    String programLinkQuery="select d.dcode,substr(w.work_id,1,2),sum(pl.SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_work_admn_prog_lnk_tbl pl  where  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"' and pl.work_id=w.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		programLinkQuery+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  programLinkQuery+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  programLinkQuery+=" and  w.programme_code in ("+programe+") group by d.dcode,substr(w.work_id,1,2) ";
		


	 	rs2=stmt2.executeQuery(programLinkQuery);
	 	Hashtable programLinkHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		programLinkHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	  	}
		

 	
	 	  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		


		



/******   New  Works *****************************************************/


    stmt2=conn.createStatement();
	String newWorksQuery="select distinct dname,programme_name,dcode,c.programme_code from rws_work_admn_tbl a,rws_district_tbl d,rws_programme_tbl c where substr(work_id,5,2)=d.dcode and substr(work_id,1,2)=c.programme_code    and WORK_CANCEL_DT  is null ";
 
	 if(dcode!=null && !dcode.equals("00")){
         newWorksQuery+="and d.DCODE='"+dcode+"'";
		}

if(scheme!=null && !scheme.equals("")){
          newWorksQuery+="and a.type_of_asset in("+scheme+")";
}
 
 newWorksQuery+=" and  c.programme_code in ("+programe+") order by  dcode,c.programme_code   ";

	
//System.out.println("New Works"+newWorksQuery);
 	rs2=stmt2.executeQuery(newWorksQuery);
	
  int styleCount=0;
  String style="";
  int recCount=0;
  
  
  int ggnWorkCount=0,ggsWorkCount=0,ggTotWorks=0,ggHabs=0,ggScHabs=0,ggSTHabs=0,gg11cHabs=0,ggPlainHabs=0;
  
  double gcScExp=0,gcStExp=0,gcPlainExp=0;
  
  double ggnEst=0,ggsEst=0,ggTotEst=0,ggexpCurrent=0,ggscExp=0,ggstExp=0,ggplainExp=0,ggcExp=0;
  
    double ggScEst=0,ggStEst=0,gg11cEst=0,ggPlainEst=0,ggScStateEst=0,ggStStateEst=0,gg11cStateEst=0,ggplainStateEst=0;
    
    double gg11cPlainSateEst=0,gg11cScStateEst=0,gg11cStStateEst=0,gg11cTotalStateEst=0;
    double ggPlainTotal=0,ggScTotal=0,ggSTTotal=0,ggTotalState=0;
  
String dname="";
  //start printing
	while(rs2.next())
	{
		
		
	String ddCode=rs2.getString(3);
	if(ddCode.equals("23")){
		
		//System.out.println("Testing");
	}
	
	double stateSharePer=0,stateShareExp=0;
		
		double totPlainPop=0,totScPop=0,totStPop=0;
		double gtotPop=0;
		boolean flag=false;
		double spillSanctionedAmt=0.0,newSanctionedAmt=0.0;
	String key=rs2.getString(3)+rs2.getString(4);
	int nWorkCount=0,sWorkCount=0;int gnWorkCount=0,gsWorkCount=0;
	int sHabs=0,nHabs=0;
	double plainPop=0,scPop=0,stPop=0,totPop=0;
	double plainPer=0,scPer=0,stPer=0;
	int scHabCount=0,plainHabCount=0,stHabCount=0,cHabCount=0;
	double scEstCost=0,plainEstCost=0,stEstCost=0,cEstCost=0;
	double cPlainEst=0,cScEst=0,cStEst=0,cTotEst=0;
	double sgtotPop=0;
	
	double scStateEstCost=0,plainStateEstCost=0,stStateEstCost=0,cStateEstCost=0;
	
	double cSCExp=0,cSTExp=0,cPlainExp=0;
	
	double totEstCost=0;
	
	double tPlainEst=0,tScEstCost=0,tStEst=0,tTotEstCost=0;
	
	double exp=0,expCurrent=0;
	double scExp=0,stExp=0,plainExp=0,cExp=0;
	
	double moreProgSanc=0;
	    
	
	//state share
	
	
	//spill over works expenditure
	
	
	  if(spillOverWorksExpHash.get(key)!=null){
		  
		  String expStr=(String)spillOverWorksExpHash.get(key);
		  if(expStr!=null){
			String []aa=expStr.split("@");
				String a1=aa[0];
				String a2=aa[1];
			  
		  exp=Double.parseDouble(a1);
		  expCurrent=Double.parseDouble(a2);
		  
		  }
		  
	  }
	
	//more program sanction
	
	
  if(programLinkHash.get(key)!=null){
		  
		  String sanc=(String)programLinkHash.get(key);
		  if(sanc!=null){
		  moreProgSanc=Double.parseDouble(sanc);
		  }
		  
	  }
	
	
	String programeCode=rs2.getString(4);
	
	
	
		if(spillOverWorksHash.get(key)!=null ){
			flag=true;
			String spillWorks=(String)spillOverWorksHash.get(key);
			String []aa=spillWorks.split("@");
			String a1=aa[0];
			if(a1!=null){
				sWorkCount=Integer.parseInt(a1);
			}
			String a2=aa[1];
			if(a2!=null){
				spillSanctionedAmt=Double.parseDouble(a2);
			}

		}
		
		if(newWorksHash.get(key)!=null ){
			flag=true;
			String nWorks=(String)newWorksHash.get(key);
			String []aa=nWorks.split("@");
			String a1=aa[0];
			if(a1!=null){
				nWorkCount=Integer.parseInt(a1);
			}
			String a2=aa[1];
			if(a2!=null){
				newSanctionedAmt=Double.parseDouble(a2);
			}

		}
		
		//grand total
		
		  ggnWorkCount+=nWorkCount;
		  ggsWorkCount+=sWorkCount;
		
		spillSanctionedAmt-=exp;
		spillSanctionedAmt+=moreProgSanc;
		totEstCost=newSanctionedAmt+spillSanctionedAmt;
		
		ggexpCurrent+=expCurrent;
		
		//grand Total
		ggnEst+=newSanctionedAmt;
		ggsEst+=spillSanctionedAmt;
		
		
		
		
		
		if(spillOverWorkshabsHash.get(key)!=null){
		sHabs=Integer.parseInt((String)spillOverWorkshabsHash.get(key));
		}else{	sHabs=0;}
		if(newWorksHabsHash.get(key)!=null){
		nHabs=Integer.parseInt((String)newWorksHabsHash.get(key));
		}else{nHabs=0;}
		
		
		//grand Total
		ggHabs+=(sHabs+nHabs);
		
		//population
		
		
		
		
		
		//tot population by programe wise sc,st,plain
		
		
	     if(spillOverWorkshabsHashPop.get(key)!=null){
	    	 
	    	 String popQ=(String)spillOverWorkshabsHashPop.get(key);
				String []aa=popQ.split("@");
				String a1=aa[0];
				if(a1!=null){
					totPlainPop=Double.parseDouble(a1);
				}
				String a2=aa[1];
				if(a2!=null){
					totScPop=Double.parseDouble(a2);
				}
				
				String a3=aa[2];
				if(a3!=null){
					totStPop=Double.parseDouble(a3);
				}
				
				gtotPop=totPlainPop+totScPop+totStPop;
				
			
	     }
		
		
		
		//new habs
		
		
 if(newWorkshabsHashPop.get(key)!=null){
	    	 
	    	 String popQ=(String)newWorkshabsHashPop.get(key);
				String []aa=popQ.split("@");
				String a1=aa[0];
				if(a1!=null){
					totPlainPop=Double.parseDouble(a1);
				}
				String a2=aa[1];
				if(a2!=null){
					totScPop=Double.parseDouble(a2);
				}
				
				String a3=aa[2];
				if(a3!=null){
					totStPop=Double.parseDouble(a3);
				}
				
				sgtotPop=totPlainPop+totScPop+totStPop;
				
				gtotPop=gtotPop+sgtotPop;
	     }
		
		
 //	
		
			double perPerson=(totEstCost/gtotPop);
 			double perPersonExp=(expCurrent/gtotPop);
 			
 			
 			
 			
 			//changing code here 
 			
 			
 			
 			if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
 				
 				stateSharePer=0.5*totEstCost;
 				stateShareExp=0.5*expCurrent;
 			}
 			else if(programeCode!=null && (programeCode.equals("65") || programeCode.equals("12") || programeCode.equals("46")|| programeCode.equals("57")|| programeCode.equals("04")|| programeCode.equals("09")|| programeCode.equals("39") || programeCode.equals("15") )){
 				
 				stateSharePer=totEstCost;
 				stateShareExp=expCurrent;
 			}else{
 				System.out.println("Error:"+programeCode);
 			}
 			
 			if(ddCode!=null&& ddCode.equals("12") && programeCode.equals("58")){
 				stateSharePer=0.0;
 				stateShareExp=0.0;
 			}
 			
 			
 			
 			
 			
 			
			double perPersonState=(stateSharePer/gtotPop);
			
			double perPersonExpCurrent=(stateShareExp/gtotPop);
		
		
		
		
		
		String spillpopQuery="select d.dcode,substr(w.work_id,1,2),hd.hab_code,nvl(hd.CENSUS_PLAIN_POPU,0) ,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd  where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr+"' and  d.dcode='"+rs2.getString(3)+"' and substr(w.work_id,1,2)='"+rs2.getString(4)+"' and hd.coverage_status<>'UI' and c.work_id=w.work_id and hd.hab_code=c.hab_code and  substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and WORK_CANCEL_DT  is null ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		spillpopQuery+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  spillpopQuery+="and w.type_of_asset in("+scheme+")";
	  }
	   
	 // spillpopQuery+=" and  w.programme_code in ("+programe+")  ";

	  	//System.out.println("spillpopQuery"+spillpopQuery);
	  	rs3=stmt3.executeQuery(spillpopQuery);
	  	 
	  	 
	  	 while(rs3.next()){
	  		 
	  		plainPop=Double.parseDouble(rs3.getString(4));
	  		scPop=Double.parseDouble(rs3.getString(5));
	  		stPop=Double.parseDouble(rs3.getString(6));
	  		
	  		totPop=plainPop+scPop+stPop;
	  		
		 	plainPer = (plainPop * 100/ totPop);
	 		scPer = (scPop * 100/ totPop);
	 		stPer = (stPop * 100/ totPop);
	 		if(scPer>=40){
	 			
	 			scEstCost+=(totPop*perPerson);
	 			scHabCount+=1;
	 			
	 			scExp+=(totPop*perPersonExp);
	 			
	 			scStateEstCost+=(totPop*perPersonState);
	 			
	 			
	 			
	 			
	 			
	 		}else if(stPer>=40){
	 			stEstCost+=(totPop*perPerson);
	 			stHabCount+=1;
	 			
	 			stExp+=(totPop*perPersonExp);
	 			
	 			stStateEstCost+=(totPop*perPersonState);
	 			
	 		}else{
	 			

	 			if(scPop==0 && stPop==0){
	 				plainEstCost+=(plainPop*perPerson);
	 				plainHabCount+=1;
	 				plainStateEstCost+=(plainPop*perPersonState);
	 							
	 				plainExp+=(plainPop*perPersonExp);
	 				
	 				
	 				
	 			}else{
	 				
	 			
	 				
	 				cEstCost+=(totPop*perPerson);
	 				
	 				cExp+=(totPop*perPersonExp);
	 				
	 				//modified data
	 				cPlainExp+=(plainPop*perPersonExpCurrent);
	 				
	 				cSCExp+=(scPop*perPersonExpCurrent);
	 				cSTExp+=(stPop*perPersonExpCurrent);
	 				
	 				
					cPlainEst+=(plainPop*perPersonState);
	 				
	 				cScEst+=(scPop*perPersonState);
	 				
	 				cStEst+=(stPop*perPersonState);
	 				
	 				
	 				cHabCount+=1;
	 				
	 				
	 			}
	 		}
	  		 
	  	 }    //end pop loop
	  	 
	  	 
	  	 
	  	 //new pop
	  	 
	  	 
	  	String newpopQuery="select d.dcode,substr(w.work_id,1,2),hd.hab_code,nvl(hd.CENSUS_PLAIN_POPU,0) ,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_admn_hab_lnk_tbl c,rws_habitation_directory_tbl hd  where  d.dcode='"+rs2.getString(3)+"' and substr(w.work_id,1,2)='"+rs2.getString(4)+"' and hd.coverage_status<>'UI' and c.work_id=w.work_id and hd.hab_code=c.hab_code and  substr(W.WORK_ID,5,2)=D.DCODE and (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"')  and WORK_CANCEL_DT  is null ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		newpopQuery+="and D.DCODE='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  newpopQuery+="and w.type_of_asset in("+scheme+")";
	  }
	   
	 // newpopQuery+=" and  w.programme_code in ("+programe+")  ";

	  //	System.out.println("newpopQuery"+newpopQuery);
	  	 rs4=stmt4.executeQuery(newpopQuery);
	  	 
	  	 
	  	 while(rs4.next()){
	  		 
	  		plainPop=Double.parseDouble(rs4.getString(4));
	  		scPop=Double.parseDouble(rs4.getString(5));
	  		stPop=Double.parseDouble(rs4.getString(6));
	  		
	  		totPop=plainPop+scPop+stPop;
	  		
		 	plainPer = (plainPop * 100/ totPop);
	 		scPer = (scPop * 100/ totPop);
	 		stPer = (stPop * 100/ totPop);
	 		
				if(scPer>=40){
	 					scEstCost+=(totPop*perPerson);
	 			scHabCount+=1;
	 			scStateEstCost+=(totPop*perPersonState);
	 			scExp+=(totPop*perPersonExp);
	 			 
	 			
	 		}else if(stPer>=40){
	 			stEstCost+=(totPop*perPerson);
	 			stHabCount+=1;
	 			
	 			stStateEstCost+=(totPop*perPersonState);
	 			stExp+=(totPop*perPersonExp);
	 			
	 		}else{
	 			
	 			if(scPop==0 && stPop==0){
	 				plainEstCost+=(plainPop*perPerson);
	 				plainHabCount+=1;
	 				plainStateEstCost+=(plainPop*perPersonState);
	 				plainExp+=(plainPop*perPersonExp);
	 				
	 			}else{
	 				
	 				
	 				
	 				
	 				cEstCost+=(totPop*perPerson);
	 				
	 				
	 				cExp+=(totPop*perPersonExp);
	 				
	 				//modified data
	 				cPlainExp+=(plainPop*perPersonExpCurrent);
	 				
	 				cSCExp+=(scPop*perPersonExpCurrent);
	 				cSTExp+=(stPop*perPersonExpCurrent);
	 				
	 				
	 				cPlainEst+=(plainPop*perPersonState);
	 				
	 				cScEst+=(scPop*perPersonState);
	 				
	 				cStEst+=(stPop*perPersonState);
	 				
	 				
	 				
	 				cHabCount+=1;
	 				
	 				
	 				
	 			}
	 		}
	  		 
	  	   }   //pop calculation end 
	  	 
		
	  	 
		
	  	 cTotEst=(cPlainEst+cScEst+cStEst);
	  	   
	  	   
		 
	  	   
	  	   //total state Share Est Cost
	  	   
	  	   
	  	    tPlainEst=plainStateEstCost+cPlainEst;
	  	   	tScEstCost=scStateEstCost+cScEst;
	  	   	tStEst=stStateEstCost+cStEst;
	  	   
	  	   	
	  	   	
	  	   	tTotEstCost=(tPlainEst+tScEstCost+tStEst);
	  	   	
	  	   	//grandTotal
	  	   	
	  	   	
	  	   	
	  	   	gcScExp+=cSCExp;
	  	  gcStExp+=cSTExp;
	  	gcPlainExp+=cPlainExp;
	  	   	
	  	   	ggPlainHabs+=plainHabCount;
	  	  gg11cHabs+=cHabCount;
	  	ggSTHabs+=stHabCount;
	  	ggScHabs+=scHabCount;
	  	
	  	ggScEst+=scEstCost;
	  	ggPlainEst+=plainEstCost;
	  	ggStEst+=stEstCost;
	  	
	  	ggscExp+=scExp;
	  	ggstExp+=stExp;
	  	ggplainExp+=plainExp;
	  	ggcExp+=cExp;
	  	
	  	
	  	
	  	
	  	gg11cEst+=cEstCost;
	  	
	  	ggScStateEst+=scStateEstCost;
	  	ggplainStateEst+=plainStateEstCost;
	  	ggStStateEst+=stStateEstCost;
	  	gg11cStateEst+=cStateEstCost;
	  	
	  	gg11cPlainSateEst+=cPlainEst;
	  	gg11cScStateEst+=cScEst;
	  	gg11cStStateEst+=cStEst;
	  	
	  	gg11cTotalStateEst+=(cPlainEst+cScEst+cStEst);
	  	
	  	ggScTotal+=tScEstCost;
	  	ggSTTotal+=tStEst;
	  	ggPlainTotal+=tPlainEst;
	  	ggTotalState+=(tScEstCost+tStEst+tPlainEst);
		
		if(!flag){
			continue;
		}
				if(styleCount%2==0){
	 				 style="gridbg1";
	 			 }else{
	 				 style="gridbg2";
	 			 }
	 			 styleCount++;
	 			%>
	 			
	 			
	 			<tr>

<% 
if(!dname.equals(rs2.getString(1)) && !dname.equals("-")){
dname=rs2.getString(1);
recCount++;



%>
<td class=<%=style %>><%=recCount %></td>
<td  class=<%=style %> style="text-align: left;"><%=dname %></td>

<% }else{   %>
<td class=<%=style %>  style="text-align: center;"></td>
<td  class=<%=style %> style="text-align: center;">-</td>

<%} %>

<td class=<%=style %> style="text-align: left;"><%=rs2.getString(2) %></td><td class=<%=style %> style="text-align: right;"><%=nWorkCount %></td><td class=<%=style %> style="text-align: right;"><%=ndf.format(newSanctionedAmt) %></td><td class=<%=style %> style="text-align: right;"><%=sWorkCount %></td><td class=<%=style %> style="text-align: right;"><%=ndf.format(spillSanctionedAmt) %></td><td class=<%=style %> style="text-align: right;"><%=nWorkCount+sWorkCount %></td><td class=<%=style %> style="text-align: right;"><%=ndf.format(spillSanctionedAmt+newSanctionedAmt) %></td>

<td class=<%=style %> style="text-align: right;"><%=ndf.format(expCurrent) %></td>
<td class=<%=style %> style="text-align: right;"><%=sHabs+nHabs %></td>

<td class=<%=style %> style="text-align: right;"><%=scHabCount %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(scEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(scStateEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(scExp) %></td>


<td class=<%=style %> style="text-align: right;"><%=stHabCount %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(stEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(stStateEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(stExp) %></td>

<td class=<%=style %> style="text-align: right;"><%=cHabCount %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cPlainEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cScEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cStEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cTotEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cExp) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cPlainExp) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cSCExp) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(cSTExp) %></td>
<td class=<%=style %> style="text-align: right;"><%=plainHabCount %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(plainEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(plainStateEstCost) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(plainExp) %></td>

<td class=<%=style %> style="text-align: right;"><%=ndf.format(tPlainEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(tScEstCost) %></td>

<td class=<%=style %> style="text-align: right;"><%=ndf.format(tStEst) %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(tTotEstCost) %></td>


</tr>
	 			<% 
	 			
	 			
	 			if(!dname.equals(rs2.getString(1)) && !dname.equals("-")){
	 				%>
	 				<tr><td colspan="3"  class="gridhdbg" style="text-align: right;">Sub Total:</td><td class="gridhdbg" style="text-align: right;">-</td>
	<td class="gridhdbg" style="text-align: right;">-</td>
	<td class="gridhdbg" style="text-align: right;">-</td>
	<td class="gridhdbg" style="text-align: right;">-</td>
	</tr>
	
	 				
	 				<% 
	 				dname="-";
	 								
	 			}
	 			//dname="-";
	 			
	}   //End Main Loop
	
	
	
	
	%>
	
	<tr><td colspan="3"  class="gridhdbg" style="text-align: right;">Grand Total:</td><td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: New Sanctioned Works',TITLE,'Information')" onmouseout="UnTip()"><%=ggnWorkCount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: New Sanctioned Works Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggnEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Spill Over Works',TITLE,'Information')" onmouseout="UnTip()"><%=ggsWorkCount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Spill Over Works Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggsEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Works(Spill+New)',TITLE,'Information')" onmouseout="UnTip()"><%=ggnWorkCount+ggsWorkCount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"> <%=ndf.format(ggnEst+ggsEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure During the Year.',TITLE,'Information')" onmouseout="UnTip()"> <%=ndf.format(ggexpCurrent) %></td>
	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Habs Benifitting.',TITLE,'Information')" onmouseout="UnTip()"><%=ggHabs %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal SCSP-11B Habs.',TITLE,'Information')" onmouseout="UnTip()"><%=ggScHabs %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal SCSP-11B Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggScEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal SCSP-11B State Share.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggScStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure SCSP-11B .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggscExp) %></td>
	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal TSP-11B Habs.',TITLE,'Information')" onmouseout="UnTip()"><%=ggSTHabs %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal TSP-11B Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggStEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal TSP-11B State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggStStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total:  Expenditure TSP-11B.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggstExp) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Habs',TITLE,'Information')" onmouseout="UnTip()"><%=gg11cHabs %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gg11cEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Plain State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gg11cPlainSateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C SC State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gg11cScStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C ST State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gg11cStStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Total State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gg11cTotalStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure Under-11C .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggcExp) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure Under-11C .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gcPlainExp) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure Under-11C .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gcScExp) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Expenditure Under-11C .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gcStExp) %></td>
	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Plain Habs',TITLE,'Information')" onmouseout="UnTip()"><%=ggPlainHabs %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Plain Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggPlainEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Plain State Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggplainStateEst) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Expenditure During Plain .',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggplainExp) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Plain State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggPlainTotal) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C SC State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggScTotal) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C ST State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggSTTotal) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Under-11C Total State Share',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggTotalState) %></td>
	
	
	
	
	</tr>
	<% 
	
	
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>