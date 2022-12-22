<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


	
	<% 	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = user.getUserId();

	    DecimalFormat ndf = new DecimalFormat("####.##");
		String financialstartyr="";
		
	    double aas=0;
	           String pname="";
		pname=(String)session.getAttribute("pname");
	

		
		financialstartyr=(String)session.getAttribute("financialyr");
		System.out.println("financialstartyr"+financialstartyr);
		String startyr =financialstartyr.substring(0,4);
		String endyr =financialstartyr.substring(5,9);
	    String endyr1 =financialstartyr.substring(5,9);
	   
		
	//System.out.println("Changing");
	    //schemes
	String scheme="",programe="";
	scheme=(String)session.getAttribute("scheme");
	

	programe=(String)session.getAttribute("programe");
		System.out.println("programe::::::::::::"+programe);
	 

		String sysdate=workData.getDate();
		   String sysmon=sysdate.substring(3,5);
		   int mon=Integer.parseInt(sysmon);
		   //System.out.println("sysdate::"+sysdate);
		   String sysyear=sysdate.substring(6,10);
		   int yy=Integer.parseInt(sysyear);
		//System.out.println("startyr"+startyr);
		   //System.out.println("sysyear::"+sysyear);
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

	


	String dcode=(String)session.getAttribute("dcode12");
	//System.out.println("dcode***"+dcode);
	String divCode=(String)session.getAttribute("divCode");
	//System.out.println("divcode***"+divCode);
	String subdivCode=(String)session.getAttribute("subdivCode");
	//tem.out.println("subdivCode***"+subdivCode);

	  if(dcode!=null && !dcode.equals("")){
	  session.getAttribute("dcode");
	  session.getAttribute("divCode");
	  session.getAttribute("subdivCode");
	}

%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=30>Milestone Report for the Financial Year--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>District</td>
<td class=btext rowspan=3>Division</td>
<td class=btext rowspan=3>SubDivision</td>
<td  class=btext  rowspan=3>OnGoing Works</td>

</tr>
<tr>
		

<td  class=btext align="center" style="background-color:lightyellow" colspan=3>Physical <br></td>	
<td  class=btext align="center" style="background-color:lightyellow" colspan=3>Financial <br></td>

</tr>
<tr>
<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Tot Milstones </td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">ach mile stones</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Total Percentage((7/6)*100)</td>
<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Tot Agreement Value</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Ach Value</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Total Percentage((10/9)*100)</td>

</tr>

<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center"  class=btext>9</td><td align="center"  class=btext>10</td><td align="center"  class=btext>11</td></tr>


<%
Statement stmt2=null,stmt22=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
  try{
    stmt2=conn.createStatement();
    stmt22=conn.createStatement();
    stmt3=conn.createStatement();
    stmt4=conn.createStatement();
    stmt5=conn.createStatement();
    stmt6=conn.createStatement();
    stmt7=conn.createStatement();
    
    // ******   Agreement count*****************************************************/
 String agree="";
  if(dcode!=null)
  {
	  agree="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_VAL/100000) FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl  m   where  w.work_id=m.work_id and work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+") and PERCENT_COMPLETED_VAL is not null and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
   if(scheme!=null && !scheme.equals("")){
	   agree+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
   
  }
  else 
  
  {
	  agree="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_VAL/100000)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and PERCENT_COMPLETED_VAL is not null and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
		   agree+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)   order by 1";
	}
  }
   
  
   System.out.println("ach:"+agree);
   		stmt5=conn.createStatement();
   	 rs5=stmt5.executeQuery(agree);
   		Hashtable agre=new Hashtable();
   	while(rs5.next())
   	{
   		agre.put(rs5.getString(1)+rs5.getString(2)+rs5.getString(3),rs5.getString(4));
   	}

          
    
///for component
   // ******   Agreement count*****************************************************/
  String com="";
  if(dcode!=null)
  {
	  com="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_WORK_VAL/100000)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where  w.work_id=m.work_id and work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
   if(scheme!=null && !scheme.equals("")){
	   com+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
   
  }
  else 
  
  {
	  com="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_WORK_VAL/100000) FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   ";
	   if(scheme!=null && !scheme.equals("")){
		   com+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)   order by 1";
	}
  }
   
  
  System.out.println("agree8888888888:"+com);
   		stmt6=conn.createStatement();
   	 rs6=stmt6.executeQuery(com);
   		Hashtable com1=new Hashtable();
   	while(rs6.next())
   	{
   		com1.put(rs6.getString(1)+rs6.getString(2)+rs6.getString(3),rs6.getString(4));
   	}

    
    
    


/////
    
    
    
    
    ///
    
    // ******   Milestone ARCh count*****************************************************/
  String milestonearch="";
  if(dcode!=null)
  {
	  milestonearch="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(COMPONENT_NO_ACH)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where  w.work_id=m.work_id and work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and ACHIEVE_DATE is not null and PERCENT_COMPLETED_VAL is not null  ";
   if(scheme!=null && !scheme.equals("")){
	   milestonearch+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null  and COMPONENT_NO_ACH is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
   
  }
  else 
  
  {
	  milestonearch="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(COMPONENT_NO_ACH)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and ACHIEVE_DATE is not null and PERCENT_COMPLETED_VAL is not null  ";
	   if(scheme!=null && !scheme.equals("")){
		   milestonearch+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null and COMPONENT_NO_ACH is not null  group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)   order by 1";
	}
  }
   
  
 //  System.out.println("Milestone:"+milestonearch);
   		
   	 rs4=stmt4.executeQuery(milestonearch);
   		Hashtable mstonearc=new Hashtable();
   	while(rs4.next())
   	{
   		mstonearc.put(rs4.getString(1)+rs4.getString(2)+rs4.getString(3),rs4.getString(4));
   	}

   
   //////end
   
    
    
    
    ///
      
     // ******   Milestone count*****************************************************/
   String milestone="";
   if(dcode!=null)
   {
	   milestone="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(m.COMPONENT_NO)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m where   w.work_id=m.work_id and work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
    if(scheme!=null && !scheme.equals("")){
    	milestone+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
    
   }
   else 
   
   {
	   milestone="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(m.COMPONENT_NO)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
		   milestone+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)   order by 1";
	}
   }
    
   
   // System.out.println("Milestone:"+milestone);
    		stmt3=conn.createStatement();
    	 rs3=stmt3.executeQuery(milestone);
    		Hashtable mstone=new Hashtable();
    	while(rs3.next())
    	{
    		mstone.put(rs3.getString(1)+rs3.getString(2)+rs3.getString(3),rs3.getString(4));
    	}

    
    //////end
    
   

   // ******   Ongoing works*****************************************************/
   String ongoing="";
   if(dcode!=null)
   {
    ongoing="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_milestone_target_ach_tbl m   where m.work_id=w.work_id and  work_cancel_dt is null and substr(work_id,5,2)='"+dcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
    if(scheme!=null && !scheme.equals("")){
    	ongoing+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
    
   }
   else 
   
   {
	   ongoing="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_milestone_target_ach_tbl m  where m.work_id=w.work_id and work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
	    	ongoing+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)   order by 1";
	}
   }
    
   
 // System.out.println("OngoingWorks:"+ongoing);
    		stmt2=conn.createStatement();
    	ResultSet rs2=stmt2.executeQuery(ongoing);
    		Hashtable Ongoingworks=new Hashtable();
    	while(rs2.next())
    	{
    		Ongoingworks.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
    	}
String ongoing1="";
    	if(dcode!=null)
    	{
    	 ongoing1="select subdivision_office_code,subdivision_office_name,circle_office_code,division_office_code from rws_subdivision_office_tbl where circle_office_code='"+dcode+"'  ";

    	
    	}
    	else
    	{
    		ongoing1="select c.subdivision_office_code,c.subdivision_office_name,a.circle_office_code,b.division_office_code from rws_subdivision_office_tbl c,rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.division_office_code=c.division_office_code and c.circle_office_code=a.circle_office_code order by circle_office_code,division_office_code,subdivision_office_code ";
    	}
    
    
             //System.out.println("OngoingWorks********:"+ongoing1);
    		 stmt22=conn.createStatement();
    	     ResultSet rs22=stmt22.executeQuery(ongoing1);
    		  Hashtable Ongoingworks1=new Hashtable();
    	while(rs22.next())
    	{
    		Ongoingworks1.put(rs22.getString(3)+rs22.getString(4),rs22.getString(2));
    	}
    	
    
    	//



/***********************************End  ************************************/

String query="";
String cricle="",division="",sub="",circlename="",divname="",subdivname="";

	query="select c.subdivision_office_code,c.subdivision_office_name,a.circle_office_code,b.division_office_code,a.circle_office_name,b.division_office_name from rws_subdivision_office_tbl c,rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.division_office_code=c.division_office_code and c.circle_office_code=a.circle_office_code order by circle_office_code,division_office_code,subdivision_office_code"; 


//System.out.println("query::::::::::::::::::::"+query);
rs1=stmt7.executeQuery(query);
int ongoingacount=0;


String dname="";
String exp="",nexp="";
ResultSet rs10=null,rs11=null;
Statement st10=null,st11=null;
st10=conn.createStatement();
st11=conn.createStatement();
double sss=0.0;
int gongoingtot=0,gongoingachtot=0,gachtot=0;
double gpertot=0.0,gfinctotper=0.0,gagtot=0.0,gfinctot=0.0;
while(rs1.next())
{
	
	
	int count=1,ongoingtot=0,ongoingachtot=0,achtot=0,agtot=0,finctot=0;
	double mile=0.0,pertot=0.0;
	double ach=0.0,gn=0;
	double totalach=0.0;
	double l=0.0,milefin=0.0,achfin=0.0,totfin=0.0,fi=0.0;

	double s=0.0,s1=0.0,tots=0.0,totall=0.0,gs=0.0,gs1=0.0,gall=0.0;
	cricle=rs1.getString(1);
	if(cricle.equals("00")){
		continue;
	}
//	System.out.println("ss*******"+cricle);
	divname=rs1.getString(6);
	subdivname=rs1.getString(2);
	
	division=rs1.getString(3);
	sub=rs1.getString(4);
	circlename=rs1.getString(5);
	
	
	
	
	
//String sd=(String)Ongoingworks1.get(rs1.getString(3)+rs1.getString(4));

//exp=(String)spillOverExp.get(rs1.getString(3)+rs1.getString(4));

//ongoingworks
String e=(String)Ongoingworks.get(rs1.getString(3)+rs1.getString(4)+rs1.getString(1));
if(e!=null && !e.equals("") && !e.equals("null")){
}
else
{
	e="0";
}
	
    
//milestone
String m=(String)mstone.get(rs1.getString(3)+rs1.getString(4)+rs1.getString(1));
if(m!=null && !m.equals("") && !m.equals("null")){
}
else
{
	m="0";
}

//milestoneArc

String a=(String)mstonearc.get(rs1.getString(3)+rs1.getString(4)+rs1.getString(1));
if(a!=null && !a.equals("") && !a.equals("null")){
}
else
{
	a="0";
}


//
//Agree

String ag=(String)agre.get(rs1.getString(3)+rs1.getString(4)+rs1.getString(1));
if(ag!=null && !ag.equals("") && !ag.equals("null")){
}
else
{
	ag="0";
}
//
//Agree

String finc=(String)com1.get(rs1.getString(3)+rs1.getString(4)+rs1.getString(1));
if(finc!=null && !finc.equals("") && !finc.equals("null")){
}
else
{
	finc="0";
}
//finance
milefin=Double.parseDouble(ag);
//System.out.println("milefin--------------"+milefin);
//milefin=milefin/100000;


//System.out.println("milefin*******"+milefin);
achfin=Double.parseDouble(finc);
//achfin=achfin/100000;
//System.out.println("achfin*******"+achfin);

if( achfin > 0)
{	
totfin=(milefin/achfin);
//System.out.println("totlefin*************"+fi);
 fi=totfin*100;
//System.out.println("milefin*************"+fi);
}
else
{
	fi=0.0;
}


//physical
mile=Double.parseDouble(m);
//System.out.println("mile*****"+mile);
ach=Double.parseDouble(a);
//System.out.println("ach*****"+ach);
if(mile > 0 )
{	
totalach=(ach/mile);
 l=totalach*100;
//System.out.println("totalach*************"+l);
}
else
{
	l=0;
}


ongoingtot=Integer.parseInt(e);
gongoingtot=ongoingtot+gongoingtot;


ongoingachtot=Integer.parseInt(m);
gongoingachtot=ongoingtot+gongoingtot;

achtot=Integer.parseInt(a);
gachtot=achtot+gachtot;


//percentage
if( gongoingachtot > 0)
{	

pertot=gachtot/gongoingachtot;
sss=pertot*100;
//System.out.println("sssssss"+sss);
gpertot=sss+gpertot;
}
else
{
	sss=0;
}



////agree value

//agtot=Integer.parseInt(ag);
gagtot=milefin+gagtot;

//// ach value
//finctot=Integer.parseInt(finc);
gfinctot=achfin+gfinctot;
/////



//// percentage value
//finctot=Integer.parseInt(finc);
if(gagtot > 0)
{	
gfinctotper=gfinctot/gagtot;
gfinctotper=gfinctotper*100;
}
else
{
	gfinctotper=0;	
}
/////


%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(5))){
dname=rs1.getString(5);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(6) %></td>
<td  class=rptLabel><%=rs1.getString(2)%></td>
<td  class=rptValue><a href="#" onclick="viewWorks('rws_programme_milestone_drill_rpt.jsp?circleofficecode=<%=division%>&divisionofficecode=<%=sub%>&subdivisionofficecode=<%=cricle%>&cname=<%=circlename %>&divname=<%=divname %>&subdivname=<%=subdivname %>')"><%=e %></a></td>
<td  class=rptValue><%=m %></td>
<td  class=rptValue><%=a%></td>
<td  class=rptValue><%=ndf.format(l)%></td>
<td  class=rptValue><%=ndf.format(achfin)%></td>
<td  class=rptValue><%=ndf.format(milefin)%></td>
<td class=rptValue><%=ndf.format(fi)%></td>
</tr>
<% 
//gncovhabs+=ncovhabs;
//tnewWorksComp=0;tspComleted=0;tspSamAmount=0;tsworks=0;tnworws=0;nexpUpto=0;
//gn+=e;
}
%>
<tr><td colspan=4 class=btext align=right>Total:</td>
<td  class=rptLabel><%=gongoingtot %></td>
<td  class=rptLabel><%=gongoingachtot %></td>
<td  class=rptLabel><%=gachtot %></td>
<td  class=rptLabel><%=ndf.format(sss) %></td>
<td  class=rptLabel><%=ndf.format(gagtot)%></td>
<td  class=rptLabel><%=ndf.format(gfinctot) %></td>
<td  class=rptLabel><%=ndf.format(gfinctotper) %></td>
</tr>
<% 

//System.out.println("last:");
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>