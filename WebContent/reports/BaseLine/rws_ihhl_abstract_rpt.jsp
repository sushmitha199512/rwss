<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
 
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");


    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_ihhl_abs_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >IHHL Abstract Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Sanctioned</td>
    <td class=gridhdbg rowspan=2>Constructed</td>
    <td class=gridhdbg rowspan=2>Cost(Rs. in lakhs)</td> 
		
    
    
	</tr>
	<tr>
       </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totbenificiaries=0,totapl=0,totbpl=0;
   Double toiletcost=0.0;
qry="select dname,substr(AP_HAB_CODE,1,2),count(BENIF_ID),sum(TOTALTOILETCOST)/100000,sum(case when CONSTRUCTED_YEAR is not null then 1 else 0 end) as concount from rws_ihhl_tbl a,rws_district_tbl b where substr(AP_HAB_CODE,1,2)=dcode group by dname,substr(AP_HAB_CODE,1,2) order by substr(AP_HAB_CODE,1,2)";
   System.out.println("qry is="+qry);
   
	 
   rs8=stmt8.executeQuery(qry);
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
	
     <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;"><%=rs8.getString(1)%></td>
   <td  class="<%=style%> "style="text-align: right;"><%=rs8.getInt(3)%></td>
   <td  class="<%=style%> "style="text-align: right;"><%=rs8.getInt(5)%></td>
   <td  class="<%=style%> "style="text-align: right;"><%=ndf.format(rs8.getDouble(4))%></td>
               
      	</tr>
	
   	
   	
<%
totbenificiaries+=rs8.getInt(3);
toiletcost+=rs8.getDouble(4);
totapl+=rs8.getInt(5);

}
   %>
  <tr>
	
     <td class=gridhdbg colspan="2" style="text-align: center;"> Total</td>
   <td  class=gridhdbg style="text-align: right;"><%=totbenificiaries%></td>
    <td  class=gridhdbg style="text-align: right;"><%=totapl%></td>
      <td  class=gridhdbg style="text-align: right;"><%=ndf.format(toiletcost)%></td>
     
      
      
   
      	</tr>
   	
   
   <%
   
	if(rs8!=null){
		rs8.close();
	}
	if(stmt8!=null){
		stmt8.close();
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