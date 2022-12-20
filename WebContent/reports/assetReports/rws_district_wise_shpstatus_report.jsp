<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
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
String rDistrict=request.getParameter("rDistrict");
session.setAttribute("rDistrict",rDistrict);
String rDistrictName=request.getParameter("rDistrictName");
session.setAttribute("rDistrictName",rDistrictName);

System.out.println("rDistrict**********" +rDistrict);
System.out.println("rDistrictName**********" +rDistrictName);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String query="";
    int styleCount=0;
    String style="";

    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="70%"   style="border-collapse:collapse"   ALIGN=CENTER >
	<caption>

	<table  border=0 rules=none style="border-collapse:collapse" align = "center">
	
	
		<table>	<tr><td class="btext">
District:</td><td class="rptvalue"><%=rDistrictName%></td>

			
<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back &nbsp; </td>
	
	   
	</tr>  
	
		</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >District Wise Shallow HandPumps Status Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
		<tr>
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
      <td class=gridhdbg colspan="6">Status</td>
      
    
     </tr>
     
     <tr>
	<td class=gridhdbg >Working</td>
    <td class=gridhdbg >Not Working</td>
      <td class=gridhdbg >Dried</td>
   
      <td class=gridhdbg >Seasonal Dry</td>
         <td class=gridhdbg >Condemned</td>
         <td class=gridhdbg >Not Having Status</td>
      
    
     </tr>
    
  
       
<%
try
{
	
	
	   //main qry
	   Statement stmt8=null;
	   ResultSet rs8=null;
	   
		   int sno=1,balcount=0;
		   int workingtot=0,notworkingtot=0,driedtot=0,condemnedtot=0,seasonalDry=0,nothavingstatus=0;
	   //
	    
	   
	   
	
	   stmt8=conn.createStatement();
	 if(rDistrict!=null  && rDistrict.equals("00") )
	 {
query="select distinct substr(SHALLOWHP_CODE,1,2),dname,sum(case when Status='W' then 1 else 0 end ),sum(case when status='N' then 1 else 0 end ),sum(case when status='D' then 1 else 0 end ),sum(case when status='S' then 1 else 0 end ),sum(case when status='C' then 1 else 0 end ),sum(case when status is null then 1 else 0 end) From RWS_SHALLOWHANDPUMPS_TBL  a,RWS_COMPLETE_HAB_VIEW b   WHERE substr(SHALLOWHP_CODE,1,16)=b.panch_code  group by substr(SHALLOWHP_CODE,1,2),dname ";
	 }
	 else
	 {
		 query="select distinct substr(SHALLOWHP_CODE,1,2),dname,sum(case when Status='W' then 1 else 0 end ),sum(case when status='N' then 1 else 0 end ),sum(case when status='D' then 1 else 0 end ),sum(case when status='S' then 1 else 0 end ),sum(case when status='C' then 1 else 0 end ),sum(case when status is null then 1 else 0 end) From RWS_SHALLOWHANDPUMPS_TBL  a,RWS_COMPLETE_HAB_VIEW b   WHERE substr(SHALLOWHP_CODE,1,16)=b.panch_code and dcode='"+rDistrict+"'  group by substr(SHALLOWHP_CODE,1,2),dname "; 
	 }
System.out.println("query**********" +query);
	   
	  
	          rs8=stmt8.executeQuery(query);
	      System.out.println("query**********" +query);
       while(rs8.next())
       {
    	  
    	
    	   
    	   
    	  
    	   if(styleCount%2==0){
  			 style="gridbg1";
  		 }else{
  			 style="gridbg2";
  		 }
  		 styleCount++;
  		
  		 
	%>
		<tr>
		
	   <td class="<%=style %>" style="text-align: right;"> <%=sno++%></td>
	   <td class="<%=style %>" style="text-align: left;"> <%=rs8.getString(2)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(3)%></td>
	   
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(4)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(5)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(6)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(7)%></td>
	      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_shp_notHaving_status_drill.jsp?dcode=<%=rs8.getString(1)%>')"><%=rs8.getInt(8)%></a></td>
	   
	   
	
	   
	   
	   
		
	   	</tr>
	   
	  
	   
	   <%
	   
	   workingtot+=rs8.getInt(3);
	   notworkingtot+=rs8.getInt(4);
	   driedtot+=rs8.getInt(5);
	   condemnedtot+=rs8.getInt(6);
	   seasonalDry+=rs8.getInt(7);
	   nothavingstatus+=rs8.getInt(8);

		 }
       
	   %>	
	   <tr align="left">
   	<td align="left" class="gridhdbg" colspan="02">Total</td>
   
   	<td style="text-align: right;" class="gridhdbg" ><%=workingtot %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=notworkingtot%></td>
    	<td style="text-align: right;" class="gridhdbg" ><%=driedtot%></td>
   		<td style="text-align: right;" class="gridhdbg" ><%=condemnedtot%></td>
   		<td style="text-align: right;" class="gridhdbg" ><%=seasonalDry%></td>
   		<td style="text-align: right;" class="gridhdbg" ><%=nothavingstatus%></td>
  
 
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