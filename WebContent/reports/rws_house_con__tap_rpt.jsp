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
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);
String dname=request.getParameter("dname");
session.setAttribute("dname",dname);
//System.out.println("dname**********" +dname);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">	
	<table><tr><td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_house_conn_tap_rpt_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >Tap Connections & StandPost Details								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>

   <td class=gridhdbg >Mandal</td>
  <td class=gridhdbg >Gram Panchayat</td>
    
    <td class=gridhdbg >Habitation Name<br>/Habitation Code</td>
    
    
    
    <td class=gridhdbg >Total Population</td>
    <td class=gridhdbg >Total HouseHolds</td>
    <td class=gridhdbg>No.of households having private tap connections</td>
   
    <td class=gridhdbg >No.of households not having private tap connections</td>
    <td class=gridhdbg >Total No.of public Taps</td>
    <td class=gridhdbg>With stand posts</td>
    <td class=gridhdbg>Without Stand Posts</td>
    
    
     </tr>
    
       
<%
try
{
	
	 Statement stmt8=null;
	   ResultSet rs8=null;
	    

   //main qry
     int sno=1;
   stmt8=conn.createStatement();
   
   int totalhabs=0,pop=0,housholds=0,hhconnect=0,hhptaps=0,hhptapsstand=0,hhpnottap=0;
   qry="select b.dname,b.mname,b.mcode,b.pcode,b.pname,count(b.panch_code),sum(a.CENSUS_PLAIN_POPU),sum(a.CENSUS_SC_POPU),sum(a.CENSUS_ST_POPU),sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN),nvl(a.NO_OF_PUBLIC_TAPS,0),nvl(a.NO_OF_TAPS_WITH_STANDPOSTS,0)  from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'  ";

   if(mcode !=null && !mcode.equals(""))
   {
   	qry+="and substr(a.hab_code,6,2)='"+mcode+"'";
   }
   qry+=" group by b.dname,b.mname,b.mcode,b.pcode,b.pname,nvl(a.NO_OF_PUBLIC_TAPS,0),nvl(a.NO_OF_TAPS_WITH_STANDPOSTS,0) order by b.mcode ";
      
   //System.out.println(qry);   
        
 
	 
  rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   
	int totalpop=rs8.getInt(7)+rs8.getInt(8)+rs8.getInt(9);	
	
	int houseHolds=rs8.getInt(10);
	int houseconn=rs8.getInt(11);
	int totprnotconn=0;

	
	totprnotconn=(houseHolds)-(houseconn);
	
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 // qry="select b.dname,b.mname,b.mcode,,b.pcode,b.pname,count(b.panch_code),sum(a.CENSUS_PLAIN_POPU),sum(a.CENSUS_SC_POPU),sum(a.CENSUS_ST_POPU),sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN),nvl(c.NO_OF_PUBLIC_TAPS,0),nvl(c.NO_OF_TAPS_WITH_STANDPOSTS,0)  from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'  ";
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>
<td  class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_house_conn_rpt_drill_rpt.jsp?drill=yes&dcode=<%=dcode %>&mcode=<%=rs8.getString(3)%>&pcode=<%=rs8.getString(4)%>')"> <%=rs8.getInt(6)%></td>

<td  class="<%=style%> "style="text-align: right;"> <%=totalpop%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(10)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(11)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=totprnotconn%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(13)%></td>
<td  class="<%=style%> "style="text-align: right;">0</td>
   
   
        
 
   	</tr>
   	
   	
<%

totalhabs+=rs8.getInt(6);
pop+=totalpop;
housholds+=rs8.getInt(10);
hhconnect+=rs8.getInt(11);
hhpnottap+=totprnotconn;
hhptaps+=rs8.getInt(12);
hhptapsstand+=rs8.getInt(13);


}%>

<tr>
	<td  class=gridhdbg style="text-align: center;" colspan="3">Grand Total</td>
<td  class=gridhdbg style="text-align: right;"> <%=totalhabs%></td>

<td  class=gridhdbg style="text-align: right;"> <%=pop%></td>
<td   class=gridhdbg style="text-align: right;"> <%=housholds%></td>
<td  class=gridhdbg style="text-align: right;"> <%=hhconnect%></td>

<td  class=gridhdbg style="text-align: right;"> <%=hhpnottap%></td>
   <td  class=gridhdbg style="text-align: right;"> <%=hhptaps%></td>
   <td  class=gridhdbg style="text-align: right;"> <%=hhptapsstand%></td>
 <td  class=gridhdbg style="text-align: right;">0</td>
        
 
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