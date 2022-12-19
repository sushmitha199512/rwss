<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({url:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
 
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");


    String qry="";
    int styleCount=0;
    String style="";
    int totpopu=0;
    int palin=0;
    int st=0;
    int sc=0;
String dcode=request.getParameter("district");
System.out.println("dcode"+dcode);
String dname=request.getParameter("dname");
System.out.println("dname"+dname);
String date=request.getParameter("date");

String date1=request.getParameter("date1");
System.out.println("date1"+date1);
//System.out.println("dcode"+dcode);
    
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "center">
	<tr align=center>
	<td align="center" class="rptHeading">District:<font color="red"><%=dname%></font>
	</tr>
		</table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  &nbsp; </td>
	 
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >News Paper Clippings</td>
	</tr>
    
	</table>
   
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td>
    <td class=gridhdbg rowspan=2>Name Of The Habitation</td>
    <td class=gridhdbg rowspan=2>Population</td>
	<td class=gridhdbg rowspan=2>Status</td>
	<td class=gridhdbg colspan=5>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
    <td class=gridhdbg>Gist of adverse News</td>
    <td class=gridhdbg>Action Taken Report</td>
   
    
    
	</tr>
	
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   
						
qry="select mcode,mname,pcode,pname,panch_code,panch_name,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,COVERAGE_STATUS,to_char(PAPER_DATE,'dd/mm/yyyy'),PAPER_NAME,EDITION,PAPER_NEWS ,ACTION_TAKEN ,REMARKS from  rws_complete_hab_view a,RWS_DROUGHT_NEWSPAPER_ITEM_TBL b where  b.hab_code=a.panch_code and dcode='"+dcode+"' and PAPER_DATE>=to_date('"+date+"','dd/mm/yyyy') and PAPER_DATE<=to_date('"+date1+"','dd/mm/yyyy') order by mcode";
  System.out.println("qry is"+qry);
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   
	   palin=rs8.getInt(7);
	   sc=rs8.getInt(8);
	   st=rs8.getInt(9);
	totpopu=rs8.getInt(7)+rs8.getInt(8)+rs8.getInt(9);
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
 <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(2)%></td>   
      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(4)%></td> 
      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(6)%></td> 
      <td class="<%=style%> "style="text-align: right;"><%=totpopu%></td> 
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(10)%></td>
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(11)%></td>  
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(12)%></td> 
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(13)%></td> 
       <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(14)%></td> 
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(15)%></td>
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(16)%></td> 
             
   
      	</tr>
	
   	
   	
<%


}
   %>
  <tr>
	
   
   
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