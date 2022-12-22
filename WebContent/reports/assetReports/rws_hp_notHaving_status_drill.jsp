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

String dcode=request.getParameter("dcode");
//String pcode=request.getParameter("pcode");
System.out.println("dcode"+dcode);

//System.out.println("pcode"+pcode);
//System.out.println("mcode"+mcode);


  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" >HandPumps Not Having Status							
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>
       
     
       <td class=gridhdbg >District</td>
       <td class=gridhdbg >Mandal</td>
       <td class=gridhdbg >Panchayat</td>
       <td class=gridhdbg >Village</td>
        <td class=gridhdbg >Habitation Code</td>
        <td class=gridhdbg >Habitation Name</td>
        <td class=gridhdbg >HandPump Code</td>
        <td class=gridhdbg >Location</td>
        <td class=gridhdbg >Asset Code</td>
       
     
       
	  
   

   </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
   qry="select dcode,dname,mname,pname,vname,panch_code,panch_name,hp_code,a.Location,a.ASSET_CODE from  rws_hp_subcomp_param_tbl a,rws_complete_hab_view b where substr(hp_code,1,16)=b.panch_code  and substr(hp_code,1,2)='"+dcode+"' and  status is null";

   
   
      
   System.out.println("qry"+qry);   
        
   
	 
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
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>
    
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)%></td>
       <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(10)%></td>
        

  
  	</tr>
  	
<%



}%>


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