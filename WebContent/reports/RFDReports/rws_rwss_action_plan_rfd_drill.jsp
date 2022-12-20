<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>


<%

StringBuffer dcode=new StringBuffer();

dcode.append(request.getParameter("dcode"));

StringBuffer type=new StringBuffer();
type.append(request.getParameter("type"));

////System.out.println("dsss");
Calendar cal=Calendar.getInstance();

StringBuffer year=new StringBuffer();
     year.append(""+cal.get(Calendar.YEAR));

  int prevYear=Integer.parseInt(year.toString())-1;     
 // String finYear="";

 StringBuffer finYear=new StringBuffer();
  if(request.getParameter("finyear")!=null){
  	finYear.append(request.getParameter("finyear"));
  }else{
  	finYear.append((StringBuffer)session.getAttribute("finYear"));
  }
 // System.out.println("finYear="+finYear);
  session.setAttribute("finYear",finYear);
   
  
  StringBuffer scheme=new StringBuffer();
  
	  //String scheme="";
	  if(request.getParameterValues("scheme")!=null){
	    String[] schemes=request.getParameterValues("scheme");
	  }else{

		scheme.append((StringBuffer)session.getAttribute("scheme"));
		
	}
	   
	  String[] schemes=request.getParameterValues("scheme");
  	
	     

		//System.out.println("scheme::"+scheme);

		StringBuffer startyr=new StringBuffer();
		startyr.append(finYear.substring(0,4));
		
		StringBuffer endyr=new StringBuffer();
		endyr.append(finYear.substring(5,9));
		
		StringBuffer endyr1=new StringBuffer();
		endyr1.append(finYear.substring(5,9));
		StringBuffer query=new StringBuffer();

		
	   // String startyr =finYear.substring(0,4);
		//String endyr =finYear.substring(5,9);
	   // String endyr1 =finYear.substring(5,9);
	    
	   StringBuffer programe=new StringBuffer();
	    //String programe="";
		  if(request.getParameterValues("programe")!=null){
		    String[] programes=request.getParameterValues("programe");
		  }else{
		    
			  programe.append((StringBuffer)session.getAttribute("programe"));
			
		
		}
	       String[] programes=request.getParameterValues("program");
	    	
	     

		//System.out.println("programe::"+programe);
  
	StringBuffer habTableName=new StringBuffer();	
	StringBuffer s=new StringBuffer();	
  //String habTableName="";
  java.util.Date d=new java.util.Date();
  s.append(finYear.substring(0,4));
  if(finYear.substring(0,4).equals(year))
  {
 habTableName.append("rws_habitation_directory_tbl");

}
else if(finYear.substring(0,4).equals(String.valueOf(prevYear)))
{
 habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
}
else
{
habTableName.append("RWS_HABITATION_DIR_HIS"+s+"_TBL");
}
session.setAttribute("habTableName",habTableName);
//System.out.println("Hab Table"+habTableName);
//String rDist=null,rDistrictName=null;

StringBuffer rDist=new StringBuffer();
StringBuffer style=new StringBuffer();

int styleCount=0;
//String style="";


%>
<html>
 <head>
<title></title>
<form>
<table  style="border-collapse:collapse" >	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan=24>RWSS Action Plan <%=finYear %> Report</td>	
		</tr>

<%
try
{
	
	
	%>
	
	<tr align="center" >
	<% if(type.toString().equals("HcAchvCnt")) { %>
			<td class=gridhdbg >Sno</td>
			<td class=gridhdbg >District</td>	
			<td class=gridhdbg >Mandal Name</td>
			<td class=gridhdbg >Panchayat Name</td>
			<td class=gridhdbg >Village Name</td>
			<td class=gridhdbg >Habitation Code</td>
			<td class=gridhdbg >Habitation Name</td>
			
			<td class=gridhdbg >Coverage Status</td>
			<td class=gridhdbg >House Connections</td>
			<%} else{ %>
			
			<td class=gridhdbg >Sno</td>
			<td class=gridhdbg >District</td>	
			<td class=gridhdbg >Mandal Name</td>
			<td class=gridhdbg >Panchayat Name</td>
			<td class=gridhdbg >Village Name</td>
			<td class=gridhdbg >Habitation Code</td>
			<td class=gridhdbg >Habitation Name</td>
			
			<td class=gridhdbg >Coverage Status</td>
			
			
					
		<%} %>	
 		</tr>
 		
	    

<%
int sno=1;
Statement stmt2=null;
ResultSet rs2=null;
stmt2=conn.createStatement();



if(type!=null && type.toString().equals("PCAchvCnt")){
//Qry for Pc(Achievements)

query.delete(0,query.length());

 query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where (h.COVERAGE_STATUS <> 'NSS') and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where  ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 query.append(" and substr(a.work_id,5,2)='"+dcode+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	query.append("and a.type_of_asset in("+scheme+")");
}
query.append(" and a.programme_code in ("+programe+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
//System.out.println(query);
}



else if(type.toString()!=null && type.toString().equals("QAAchvCnt")){
	//qry for QA(Achievements)
	query.delete(0,query.length());
	
	 	query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where (h.COVERAGE_STATUS = 'NSS') and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
		 if(dcode!=null && !dcode.toString().equals("51")){
			 query.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
		}
	if(scheme!=null && !scheme.toString().equals("")){
		query.append("and a.type_of_asset in("+scheme.toString()+")");
	}
	query.append(" and a.programme_code in ("+programe+") and substr(a.work_id,5,2)='"+dcode+"'");
	//habCovStatusCnt="";
}

else if(type.toString()!=null && type.toString().equals("pwsAchvCnt")){
	

	//qry for PWS(Achievements) 
	
	
	query.delete(0,query.length());

		query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.DISTRIBUTION_LENGTH is not null and  c.DISTRIBUTION_LENGTH>'0' and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
		 if(dcode!=null && !dcode.toString().equals("51")){
			 
			 
			 query.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
		}
	if(scheme!=null && !scheme.toString().equals("")){
		query.append("and a.type_of_asset in("+scheme.toString()+")");
	}
	query.append(" and a.programme_code in ("+programe.toString()+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
	
}
else if(type!=null && type.equals("HcAchvCnt")){
	
	query.delete(0,query.length());
	query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status,c.HOUSE_CONN from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.HOUSE_CONN  is not null and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 query.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	query.append("and a.type_of_asset in("+scheme.toString()+")");
}
query.append(" and a.programme_code in ("+programe.toString()+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
}
else if(type!=null && type.toString().equals("PCAchvCnt")){
	
	query.append("select distinct dcode,NVL(PC_HABS,0),NVL(QA_HABS,0),NVL(PWS_HABS,0),NVL(HOUSE_CONNECTIONS,0) from rws_work_sch_target_tbl where fin_year='"+finYear.toString()+"'");
	
	//System.out.println("HcAchvCnt:"+query);
}
else if(type!=null && type.toString().equals("QAAchvCnt")){
	
	
	query.delete(0,query.length());
	//qry for QA(Achievements) 
	
	
 	query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where (h.COVERAGE_STATUS = 'NSS') and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.equals("51")){
		 query.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	query.append("and a.type_of_asset in("+scheme.toString()+")");
}
query.append(" and a.programme_code in ("+programe.toString()+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
//habCovStatusCnt="";
}
	


else if(type!=null && type.toString().equals("pwsAchvCnt")){
	
	

	//qry for PWS(Achievements)
	
	
query.delete(0,query.length());
		query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.DISTRIBUTION_LENGTH is not null and  c.DISTRIBUTION_LENGTH>'0' and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"'))  and  substr(a.work_id,5,2)=i.dcode ");
		 if(dcode!=null && !dcode.toString().equals("51")){
			 query.append(" and substr(a.work_id,5,2)='"+dcode+"' ");
		}
	if(scheme!=null && !scheme.toString().equals("")){
		query.append("and a.type_of_asset in("+scheme.toString()+")");
	}
	query.append(" and a.programme_code in ("+programe.toString()+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
	
	
}
else if(type!=null && type.toString().equals("HcAchvCnt")){
	
	query.delete(0,query.length());
	query.append("select distinct h.dname,h.mname,h.pname,h.vname,h.panch_code,h.panch_name,h.coverage_status,c.HOUSE_CONN from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i where  c.HOUSE_CONN  is not null and a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where   ((to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr.toString()+"' and to_date(DATE_OF_COMPLETION) <= '31-MAR-"+endyr.toString()+"' )) or ( to_date(PARTIAL_DATE_OF_COMPLETION ) >= '01-Apr-"+startyr.toString()+"' and to_date(PARTIAL_DATE_OF_COMPLETION )<= '31-MAR-"+endyr.toString()+"')) and  substr(a.work_id,5,2)=i.dcode ");
	 if(dcode!=null && !dcode.toString().equals("51")){
		 query.append(" and substr(a.work_id,5,2)='"+dcode.toString()+"' ");
	}
if(scheme!=null && !scheme.toString().equals("")){
	query.append("and a.type_of_asset in("+scheme.toString()+")");
}
query.append(" and a.programme_code in ("+programe.toString()+") and substr(a.work_id,5,2)='"+dcode.toString()+"'");
	
}




//System.out.println("HcAchvCnt:"+query);

rs2=stmt2.executeQuery(query.toString());

Hashtable habCovStatus_Cnt=new Hashtable();

	while(rs2.next())
	{
		
		style.delete(0,style.length());
		if(styleCount%2==0){
			 style.append("gridbg1");
		}else{
			 style.append("gridbg2");
		}
		styleCount++;
	%>	<tr>
	
		<td class="<%=style %>" style="text-align: left;"><%=sno++%></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(1) %></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(2) %></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(3)%></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(4) %></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(5) %></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(6) %></td>
		<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(7) %></td>
	<% if(type.toString().equals("HcAchvCnt")) {%>

<td class="<%=style %>" style="text-align: left;"> <%=rs2.getString(8) %></td>

<% }%>	
		
		</tr>
		

	<% 
	
		//habCovStatus_Cnt.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();

 	
 
 

 	 
	%>
	
	

<%
 //end of if
}//end of catch
catch(Exception e)
{
	e.printStackTrace();
}

finally{
	
	dcode=null;
	type=null;
	year=null;
	finYear=null;
	programe=null;
	s=null;
	scheme=null;
	startyr=null;
	endyr=null;
	endyr1=null;
	query=null;
	
}


	%>
	 
</table>
</form></head>
</html>












  