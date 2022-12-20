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
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_household_con_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Habitation House Hold/House Connections Details								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>District</td>
    
    <td class=gridhdbg>Mandal</td>
    <td class=gridhdbg>No. of Habitations</td>
    <td class=gridhdbg>Population</td>
      <td class=gridhdbg>No. of Households</td>
	  <td class=gridhdbg>No. of House Connections<br>given with piped water supply</td>

	</tr>
	
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalhabs=0,pop=0,housholds=0,hhconnect=0;
   qry="select b.dname,b.mname,b.mcode,count(b.panch_code),sum(a.CENSUS_PLAIN_POPU),sum(a.CENSUS_SC_POPU),sum(a.CENSUS_ST_POPU),sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN)  from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'  ";

   if(mcode !=null && !mcode.equals(""))
   {
   	qry+="and substr(a.hab_code,6,2)='"+mcode+"'";
   }
   qry+=" group by b.dname,b.mname,b.mcode order by b.mcode ";
      
   //System.out.println(qry);   
        
   String dname="",temp="";
	 
  rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   if(dname.equals(rs8.getString(1))||temp.equals(rs8.getString(1))){
      	   dname="-";
         }else{
      	   dname=rs8.getString(1);
         }
	int totalpop=rs8.getInt(6)+rs8.getInt(7)+rs8.getInt(5);	
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: center;"> <%=dname%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_household_con_drill_rpt.jsp?drill=yes&dcode=<%=dcode %>&mcode=<%=rs8.getString(3)%>')"> <%=rs8.getInt(4)%></td>

<td  class="<%=style%> "style="text-align: right;"> <%=totalpop%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(8)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(9)%></td>

   
   
        
 
   	</tr>
   	
   	
<%
totalhabs+=rs8.getInt(4);
pop+=totalpop;
housholds+=rs8.getInt(8);
hhconnect+=rs8.getInt(9);
temp=rs8.getString(1);
}%>
<tr>
	<td  class=gridhdbg style="text-align: center;" colspan="3">Grand Total</td>
<td  class=gridhdbg style="text-align: right;"> <%=totalhabs%></td>

<td  class=gridhdbg style="text-align: right;"> <%=pop%></td>
<td   class=gridhdbg style="text-align: right;"> <%=housholds%></td>
<td  class=gridhdbg style="text-align: right;"> <%=hhconnect%></td>

   
   
        
 
   	</tr>

<%
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>