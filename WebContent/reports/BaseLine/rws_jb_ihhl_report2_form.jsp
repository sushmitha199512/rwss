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

//System.out.println("rDistrict**********" +rDistrict);
//System.out.println("rDistrictName**********" +rDistrictName);

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
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	<td><a href="./rws_jb_ihhl_report_excel.jsp">Excel</a></td> 
	   
	</tr>  
	
		</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >IHHL-Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
		<tr>
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >District</td>
      <td class=gridhdbg >Mandal</td>
       <td class=gridhdbg >Panchayat</td>
    <td class=gridhdbg >Habitation</td>
    <td class=gridhdbg >No.Of HouseHolds</td>
    
    <td class=gridhdbg >Toilets Constructed</td>
    <td class=gridhdbg >Toilets Not Constructed</td>
   
    

    
    
     </tr>
    
  
       
<%
try
{
	
	
	   //main qry
	   Statement stmt8=null;
	   ResultSet rs8=null;
	   
		   int sno=1,balcount=0;
		   int habcount=0,householdcount=0,havtoilets=0,nothavtoilets=0,notoilets=0;
	   //
	    
	   
	   
	
	   stmt8=conn.createStatement();
	 
query="select distinct dcode,dname,mcode,mname,pcode,pname,count(distinct hab_code_state),count(FAMILYHEAD),sum(case when ISHAVINGTOILET ='Y' then 1 else 0 end) ,sum(case when ISHAVINGTOILET ='N' then 1 else 0 end ) from rws_ihhl_goi_tbl a,rws_complete_hab_view b where panch_code=HAB_CODE_STATE  and dcode='"+rDistrict+"'  group by dcode,dname,mcode,mname,pcode,pname order by dcode,mcode,pcode,pname ";
	   
	  
	   
	  
	          rs8=stmt8.executeQuery(query);
	      //System.out.println("query**********" +query);
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
	   <td class="<%=style %>" style="text-align: left;"> <%=rs8.getString(4)%></td>
	   <td class="<%=style %>" style="text-align: left;"> <%=rs8.getString(6)%></td>
	   <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_ihhl_jb_report_drill.jsp?drill=yes&dcode=<%=rDistrict %>&mcode=<%=rs8.getString(3)%>&pcode=<%=rs8.getString(5)%>')"> <%=rs8.getInt(7)%></a></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(8)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(9)%></td>
	   <td class="<%=style %>" style="text-align: right;"> <%=rs8.getInt(10)%></td>
	
	   
	   
	   
		
	   	</tr>
	   
	  
	   
	   <%
	   habcount+=rs8.getInt(7);
	   householdcount+=rs8.getInt(8);
	   havtoilets+=rs8.getInt(9);
	   nothavtoilets+=rs8.getInt(10);
	  

		 }
       
	   %>	
	    <tr align="left">
   	<td align="left" class="gridhdbg" colspan="02">Total</td>
   	<td class="<%=style %>" style="text-align: left;"></td>
   	<td  class="<%=style %>" style="text-align: left;"></td>
   	<td  class="<%=style %>" style="text-align: right;"><%=habcount %></td>
   <td  class="<%=style %>" style="text-align: right;"><%=householdcount%></td>
    <td class="<%=style %>" style="text-align: right;"><%=havtoilets%></td>
   	<td  class="<%=style %>" style="text-align: right;"><%=nothavtoilets%></td>
  
 
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