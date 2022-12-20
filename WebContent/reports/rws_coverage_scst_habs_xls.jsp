<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SC_ST_PlainCoverageOfHabitationsDuringYear.xls");

%>

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
		StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());

	    DecimalFormat ndf = new DecimalFormat("####.##");
		StringBuffer financialstartyr=new StringBuffer();
		StringBuffer pname=new StringBuffer();
		StringBuffer programe=new StringBuffer();
		
	          pname.append((StringBuffer)session.getAttribute("pname"));
		financialstartyr.append((StringBuffer)session.getAttribute("financialyr"));

	    //schemes
	StringBuffer scheme=(StringBuffer)session.getAttribute("scheme");

	 StringBuffer startyr=new StringBuffer();
	  StringBuffer endyr=new StringBuffer();
	  StringBuffer endyr1=new StringBuffer();

		 startyr.append(financialstartyr.substring(0,4));
		 endyr.append(financialstartyr.substring(5,9));
		 endyr1.append(financialstartyr.substring(5,9));
	       String[] programes=request.getParameterValues("program");
	    	

	  programe.append((StringBuffer)session.getAttribute("programe"));
		////System.out.println("programe::"+programe);
	 

	 StringBuffer sysdate=new StringBuffer();
	 
	 sysdate.append(workData.getDate());
	 
StringBuffer sysmon=new StringBuffer();
	 
sysmon.append(sysdate.substring(3,5));


//System.out.println("sysmon::"+sysmon);
	  // String sysmon=sysdate.substring(3,5);
	   int mon=Integer.parseInt(sysmon.toString());
	   //System.out.println("sysdate::"+sysdate);
	   
	   StringBuffer sysyear=new StringBuffer();
	   
	    sysyear.append(sysdate.substring(6,10));
	   int yy=Integer.parseInt(startyr.toString());
	   
	   StringBuffer nextfinancialstartyr=new StringBuffer();
	   
	   int nextFinYear=yy+1;
	   int nn=nextFinYear+1;
	   
	   nextfinancialstartyr.append(""+nextFinYear+"-"+nn);
	//System.out.println("startyr"+startyr);
	   //System.out.println("sysyear::"+sysyear);
	   int prevyear=0,prevmon=0;String fyear,fyear1;

	   
	   
	   StringBuffer prevmonth=new StringBuffer(); 

	   prevmonth.append(nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase());
	   StringBuffer cmonth=new StringBuffer();

	   cmonth.append(nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase());

	   StringBuffer nextmonth=new StringBuffer();
	   nextmonth.append(nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase());

	//String prevmonth=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
	//String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
	//String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

	if(startyr.toString().equals(sysyear) && cmonth.toString().equals("APR")){
   prevmonth=cmonth;
}
StringBuffer startyr2=new StringBuffer();
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1.append(startyr);

}else {
endyr1.append(endyr);
}
//StringBuffer dcode=new StringBuffer();

//dcode.append((StringBuffer)session.getAttribute("dcode"));

StringBuffer dcode=(StringBuffer)session.getAttribute("dcode");

//System.out.println("dcode::"+dcode);

StringBuffer divCode=new StringBuffer();
divCode.append(request.getParameter("divCode"));


//	String currentMonth=nic.watersoft.commons.RwsUtils.getCurrentMont();
	//String nextMonth=nic.watersoft.commons.RwsUtils.getNextMonth();


StringBuffer currentMonth=new StringBuffer();
currentMonth.append(nic.watersoft.commons.RwsUtils.getCurrentMont());


StringBuffer nextMonth=new StringBuffer();
nextMonth.append(nic.watersoft.commons.RwsUtils.getCurrentMont());



	%>
	
	<body>

<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  style="border-collapse:collapse" >
<tr >
		<td align="center" class="gridhdbg" colspan=6>SC/ST WISE COVERAGE OF HABITATIONS DURING THE CURRENT FINANCIAL YEAR -(<%=financialstartyr.toString() %>)--<%=pname.toString() %> .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" >Sl.No</td>
		<td   class="gridhdbg" >District</td>
<td  class="gridhdbg" >SC <br>(% >= 40)</br></td>
<td  class="gridhdbg" >ST <br>(% >= 40)</br></td>
<td  class="gridhdbg" >PLAIN <br>(% >= 40)</br></td>
<td class="gridhdbg"   >Total</td>

<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null;
int count=1;

int styleCount=0;
StringBuffer style=new StringBuffer();
StringBuffer habCountQuery=new StringBuffer();
StringBuffer HabsQuery=new StringBuffer();
StringBuffer dname=new StringBuffer();
StringBuffer key=new StringBuffer();
StringBuffer strValue=new StringBuffer();



  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();


	  /******   SVS- WORKS EXPENDITURE *****************************************************/

	  habCountQuery.delete(0,habCountQuery.length());
	  
	  	habCountQuery.append("select d.dcode,d.dname ,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_comp_hab_lnk_tbl v,rws_complete_hab_view ch,rws_habitation_directory_tbl hd    where hd.hab_code=v.hab_code and v.hab_code=ch.panch_code and  w.WORK_CANCEL_DT is null   and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2) and w.work_id in(select work_id from rws_work_completion_tbl where  (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') )  ");
	   
	  	 if(dcode!=null && !dcode.toString().equals("00")){
	  		habCountQuery.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  habCountQuery.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  habCountQuery.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

	  	//System.out.println("habCountQuery"+habCountQuery);
	  	ResultSet rs2=stmt2.executeQuery(habCountQuery.toString());
	  
	  	Hashtable habCountHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		habCountHash.put(rs2.getString(1),rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();


	    stmt2=conn.createStatement();
	   
      HabsQuery.delete(0,HabsQuery.length());
	    
	    HabsQuery.append("select d.dcode,d.dname ,v.hab_code,nvl(hd.CENSUS_PLAIN_POPU,0),nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_comp_hab_lnk_tbl v,rws_complete_hab_view ch,rws_habitation_directory_tbl hd  where hd.hab_code=v.hab_code and ch.panch_code=v.hab_code   and   w.WORK_CANCEL_DT is null   and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2) and w.work_id in(select work_id from rws_work_completion_tbl where  (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') )   ");
		   
	  	 if(dcode!=null && !dcode.toString().equals("00")){
	  		HabsQuery.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  HabsQuery.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  HabsQuery.append(" and  w.programme_code in ("+programe.toString()+") order by d.dcode  ");

	  	//System.out.println("HabsQuery"+HabsQuery);
	  	 rs2=stmt2.executeQuery(HabsQuery.toString());
	  
	 
	  	
	  	int scHabcount=0,stHabcount=0,plainHabCount=0;
	  	int gscHabcount=0,gstHabcount=0,gplainHabCount=0,gtotHabCount=0;
	  	int i=1;
	  	
	  	//System.out.println("hello");
	  	
	  	
        while(rs2.next()){
        	
        	
        	
	  		key.delete(0,key.length());
	  		 key.append(rs2.getString(1));
	  		 
	  		dname.delete(0,dname.length());
	  		dname.append(rs2.getString(2));
	  		int loopCount=0;
	  		int scPop=0,stPop=0,plainPop=0;
	  		
	  		strValue.delete(0,strValue.length());
	  		 strValue.append((String)habCountHash.get(key.toString()));
	  		if(strValue!=null && !strValue.toString().equals("") && !strValue.toString().equals("0")){
	  			
	  			loopCount=Integer.parseInt(strValue.toString());
	  		}else {
	  			continue;
	  		}
	  	
	  			
	  			
	  			plainPop=Integer.parseInt(rs2.getString(4));
	  			scPop=Integer.parseInt(rs2.getString(5));
	  			stPop=Integer.parseInt(rs2.getString(6));
	  			
	  			int totPop=plainPop+scPop+stPop;
	  			
	  			double plainPer = plainPop>0?((double)plainPop * 100/ (double)totPop):0;
	  			
		 		double scPer = scPop>0?((double)scPop * 100/ (double)totPop):0;
		 		double stPer = stPop>0?((double)stPop * 100/ (double)totPop):0;
	  			
	  			if(scPer>=40){
	  			
	  				scHabcount++;
	  			  	
	  			}else if(stPer>=40){
		  			
	  				stHabcount++;
	  			  	
	  			}else if(plainPer>=40){
		  			
	  				plainHabCount++;
	  			  	
	  			}else {
	  				
	  				//System.out.println("no hab:"+scPer);
	  				//System.out.println("no hab:"+stPer);
	  				//System.out.println("no hab:"+plainPer);
	  			}
	  		
	  			////System.out.println("loopCount:"+loopCount);
	  			if(i==loopCount){
	  				i=0;
	  				
	  				style.delete(0, style.length());
	  				 if(styleCount%2==0){
	  					 style.append("gridbg1");
	  				 }else{
	  					 style.append("gridbg2");
	  				 }
	  				 styleCount++;
	  				 
	  				int totHabCount=scHabcount+plainHabCount+stHabcount;
	  				gscHabcount+=scHabcount;
	  				gstHabcount+=stHabcount;
	  				gplainHabCount+=plainHabCount;
	  				gtotHabCount+=totHabCount;
	  				
	  				%>
	  										
		<tr>
		<td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
		<td class="<%=style %>" style="text-align: left;"><%=dname.toString() %></td>
		<td class="<%=style %>" style="text-align: right;"><%=scHabcount %></a></td>
		<td class="<%=style %>" style="text-align: right;"><%=stHabcount %></td>
		<td class="<%=style %>" style="text-align: right;"><%= plainHabCount %></a></td>
		<td class="<%=style %>" style="text-align: right;"><%= totHabCount %></a></td>
		
		
		
		</tr>
	  				
	  				
	  				<% 
	  				scHabcount=0;stHabcount=0;plainHabCount=0;
	  				
	  			} //end loop
	  		
	  			i++;
	  		
	  	}   //end main loop
	  	
	  	
	 %>
	 
	 <tr>
		<td class="gridhdbg" style="text-align: right;" colspan="2">Total:</td>
		<td class="gridhdbg" style="text-align: right;"><%=gscHabcount %></a></td>
		<td class="gridhdbg" style="text-align: right;"><%=gstHabcount %></td>
		<td class="gridhdbg" style="text-align: right;"><%= gplainHabCount %></a></td>
		<td class="gridhdbg" style="text-align: right;"><%= gtotHabCount %></a></td>
		
		
		
		</tr>
	 <%  	
	  
	  	
	  	 if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
			
}catch(Exception e){
  e.printStackTrace();
}
 finally{
	  
	  dcode=null;
	  divCode=null;
	 habCountQuery=null;
	 nextfinancialstartyr=null;
	 financialstartyr=null;
	 endyr=null;
	 endyr1=null;
	 key=null;
	 nextmonth=null;
	 pname=null;
	 scheme=null;
	 
	 HabsQuery=null;
	 style=null;
	 sysyear=null;
	 
	  
  }
  
  
  
 %>

</table>	
</body>
</html>