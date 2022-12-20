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
String rDistrict=(String)session.getAttribute("rDistrict");
String mcode=request.getParameter("mcode");
String pcode=request.getParameter("pcode");
//////System.out.println("rDistrict"+rDistrict);

//System.out.println("pcode"+pcode);
//System.out.println("mcode"+mcode);


  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" > IHHL House Hold Details								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>
       
     
       <td class=gridhdbg >Village</td>
       <td class=gridhdbg >Habitation Code</td>
       <td class=gridhdbg >Habitation Name</td>
     
       <td class=gridhdbg >No.Of HouseHolds</td>
       <td class=gridhdbg >No.Of HouseHolds Having Toilets</td>
	   <td class=gridhdbg >No.Of HouseHolds Not Having Toilets</td>
	  
   

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
   qry="select distinct vcode,vname,panch_code,panch_name,count(FAMILYHEAD),sum(case when ISHAVINGTOILET ='Y'  then 1 else 0 end),sum(case when ISHAVINGTOILET ='N'  then 1 else 0 end) from rws_ihhl_goi_tbl a,rws_complete_hab_view b where  dcode='"+rDistrict+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and panch_code=HAB_CODE_STATE  group by vcode,vname,panch_code,panch_name";

   
   
      
   //System.out.println(qry);   
        
   
	 
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
    
    <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_ihhl_jb_report12_drill.jsp?drill=yes&dcode=<%=rDistrict %>&mcode=<%=mcode %>&pcode=<%=pcode %>&vcode=<%=rs8.getString(1)%>&panchcode=<%=rs8.getString(3)%>')"><%=rs8.getInt(5)%></a></td>
      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(6)%></td>
      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(7)%></td>

  
  	</tr>
  	
<%

totalconstructed+=rs8.getInt(5);
housholdsnc+=rs8.getInt(6);
toilethav+=rs8.getInt(7);

}%>
<tr>
	
  <tr align="left">
   	<td align="right" class="gridhdbg" colspan="02">Total</td>
   	<td  class=gridhdbg style="text-align: left;"></td>
   	<td  class=gridhdbg style="text-align: left;"></td>
   	<td  class=gridhdbg style="text-align: right;"><%=totalconstructed %></td>
   <td  class=gridhdbg style="text-align: right;"><%=housholdsnc%></td>
    <td  class=gridhdbg style="text-align: right;"><%=toilethav%></td>
  
   	
 
 
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