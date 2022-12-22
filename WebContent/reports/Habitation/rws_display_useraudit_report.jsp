<%@ include file="/commons/rws_header1.jsp"%>
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
String laggdate=request.getParameter("laggdate");
String UserId=request.getParameter("UserId");

System.out.println("laggdate"+laggdate);
System.out.println("UserId"+ UserId);

//System.out.println("pcode"+pcode);
//System.out.println("mcode"+mcode);


  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
   	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"   style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<br><br>
			<a href="#" onClick="window.close();">Close</a>

 <!--  &nbsp;| &nbsp;<a href="./rws_habitation_status_rpt_xls.jsp?type=drill">Excel</a>  -->


  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >User Logged Details</td>
</tr>

</table>
   
    <table width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr>
	<td class=gridhdbg >Sl.No</td>
         
       <td class=gridhdbg >USER_ID</td>
       <td class=gridhdbg >ACCESS_DATE</td>
       <td class=gridhdbg >ACCESS_TIME</td>
     
       <td class=gridhdbg >PAGE</td>
       <td class=gridhdbg >ADDRESS</td>
	   <td class=gridhdbg >BROWSER</td>
   

   </tr>
       
<%
try
{
	
   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
//    int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
   qry="select USER_ID,to_char(ACCESS_DATE,'dd/mm/yyyy'),ACCESS_TIME ,PAGE,ADDRESS,BROWSER from rws_log_tbl a where user_id='"+UserId+"' and trunc(ACCESS_DATE)=to_date('"+laggdate+"','dd/mm/yyyy')";

   
   
      
   System.out.println("qry"+qry);   
        
   
	 
  rs8=stmt8.executeQuery(qry);
  int i=1;
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
	<td  class="<%=style%> "style="text-align: left;"> <%=i++%></td>
    <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>  
    <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td> 
    <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td> 
    <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td> 
     <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>  
      <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%></td>

   	</tr>
  	<%

}%>
<tr>

   	
 
 
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
finally{
	try{
		if(conn!=null){
			conn.close();
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
}


%>
    
</table>

