<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<table bgcolor="#F8FCEE" width="100%" height="40px" cellspacing="0" cellpadding="0" border="0" >
<!-- Page header starts here-->
<tr height="1%">
	<td class="pageHeading" align="center">
		<bean:message key="app.title1" />
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading2" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
</table>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
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
<form>
<%


nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
String dcode=request.getParameter("rDistrict");
String dname=request.getParameter("rDistrictName");
System.out.println("dcode"+dcode);
System.out.println("dname"+dname);
String startyr =request.getParameter("startyr");

String prevyear=request.getParameter("prevyear");

String endyr =request.getParameter("endyr");
System.out.println("startyr"+startyr);
System.out.println("endyr"+endyr);




String scheme="";
if(request.getParameterValues("scheme")!=null){
  String[] schemes=request.getParameterValues("scheme");
	
  
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	////////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("schemes",schemes);
}
System.out.println("scheme"+scheme);


String[] programes=request.getParameterValues("programe");

session.setAttribute("programes",programes);
String programe="";
for(int i=0;i<programes.length;i++)
{
programe += programes[i]+",";
}
////////System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
System.out.println("programe"+programe);
session.setAttribute("programe",programe);
    String qry="";
    int styleCount=0;
    String style="";

    
   	%>
   	
   
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr aligh=center>District:<font color=blue><b><%=dname%></b></font></tr>
	<tr>
	<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>&nbsp;&nbsp;
					</td>
					</tr>
	<tr >
	<tr >
	<td align="center" class="rptHeading" >Ongoing Works & Habitations Abstract</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td>
    <td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation Code</td>
    <td class=gridhdbg rowspan=2>Habitation Name</td>
    <td class=gridhdbg colspan=4>Population</td>
    <td class=gridhdbg rowspan=2>Coverage Status</td>
      
   
   </tr>
   <tr>
   
    <td class=gridhdbg>Total</td>
    <td class=gridhdbg>Plain</td>
    <td class=gridhdbg>SC</td>
    <td class=gridhdbg>ST</td>
   </tr>
       
<%
try
{
	   Statement stmt8=null;
   ResultSet rs8=null;
   int totalppopu=0,totpain=0,totsc=0,totst=0;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
	//String habqry="select  a.work_id,a.work_name,a.SANCTION_AMOUNT,a.ADMIN_DATE from RWS_WORK_ADMN_TBL a,rws_district_tbl i where  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode ";
   String compHabs="select distinct mname,pname,vname,c.hab_code,panch_name,COVERAGE_STATUS,nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view d, rws_district_tbl i where  a.work_id=b.work_id and b.work_id=c.work_id and  c.hab_code=d.panch_code and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode ";
	  if(dcode!=null && !dcode.equals("00")){
		  compHabs+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
	  if(scheme!=null && !scheme.equals("")){
		  compHabs+="and a.type_of_asset in("+scheme+")";
	  }
	  compHabs+=" and a.programme_code in ("+programe+")  group by mname,pname,vname,c.hab_code,panch_name,COVERAGE_STATUS,nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0)";
	  //System.out.println("comphabs:"+compHabs); 
      
   System.out.println("compHabs"+compHabs);   
        
   
	 
  rs8=stmt8.executeQuery(compHabs);
   while(rs8.next())
   {
   	
	int totpopu=rs8.getInt(7)+rs8.getInt(8)+rs8.getInt(9);
	
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>
      <td class="<%=style%> "style="text-align: left;"><%=totpopu%></td>
       <td class="<%=style%> "style="text-align: left;"><%=rs8.getInt(7)%></td>
        <td class="<%=style%> "style="text-align: left;"><%=rs8.getInt(8)%></td>
         <td class="<%=style%> "style="text-align: left;"><%=rs8.getInt(9)%></td>
         
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%></td>
   
  
   
    
      
  
     
  
  	</tr>
  	
<%

totalppopu+=totpopu;
totpain+=rs8.getInt(7);
totsc+=rs8.getInt(8);
totst+=rs8.getInt(9);

}%>
<tr>
	<td class="gridhdbg" style="text-align: left;" colspan=6>Total</td>
		
		<td class="gridhdbg" style="text-align: right;"><%=totalppopu%></td>
		<td class="gridhdbg" style="text-align: right;"><%=totpain%></td>
		<td class="gridhdbg" style="text-align: right;"><%=totsc%></td>
		<td class="gridhdbg" style="text-align: right;"><%=totst%></td>
       <td class="gridhdbg" style="text-align: right;"></td>
  
 
   	</tr>

<%
if(stmt8!=null){
	stmt8.close();
}
if(rs8!=null){
	rs8.close();
}

	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>