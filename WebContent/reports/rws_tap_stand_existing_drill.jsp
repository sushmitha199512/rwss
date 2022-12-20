<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
String dcode=(String)session.getAttribute("dcode");
String mcode=request.getParameter("mcode");
String pcode=request.getParameter("pcode");
//String panch=request.getParameter("panchcode");
//System.out.println("panchcode<<<<<<<<<<<<"+panch);

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" > Habitation House Hold Details								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="2">Sl.No</td>
       
       <td class=gridhdbg rowspan="2">Panchayat</td>
       <td class=gridhdbg rowspan="2">Village</td>
       <td class=gridhdbg rowspan="2">Habitation Code</td>
       <td class=gridhdbg rowspan="2">Habitation Name</td>
       <td class=gridhdbg rowspan="2">Coverage Status</td>
       <td class=gridhdbg rowspan="1" colspan="4">Population</td>
       <td class=gridhdbg rowspan="2">No. of Households</td>
	   <td class=gridhdbg rowspan="2">No.of households having private tap connections</td>
   
    <td class=gridhdbg rowspan="2">No.of households not having private tap connections</td>
    <td class=gridhdbg rowspan="2">Total No.of public Taps</td>
    <td class=gridhdbg rowspan="2">With stand posts</td>
    <td class=gridhdbg rowspan="2">Without Stand Posts</td>
   

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
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalhabs=0,pop=0,housholds=0,hhconnect=0,scpop=0,stpop=0,plainpop=0,ptap=0,totptap=0,totstands=0,totnotstand=0;
   qry="select b.dname,b.mname,b.pname,b.vname,b.panch_code,b.panch_name,a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,HOUSEHOLD_NO,NO_OF_HOUSECONN_GIVEN,b.COVERAGE_STATUS,a.NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS  from rws_habitation_directory_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'  ";

   if(mcode !=null && !mcode.equals(""))
   {
   	qry+="and substr(a.hab_code,6,2)='"+mcode+"' and substr(a.hab_code,13,2)='"+pcode+"'";
   }
   qry+=" order by b.mcode,b.pcode,b.vcode ";
      
   //System.out.println(qry);   
        
   
	 
  rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
	int totalpop=rs8.getInt(7)+rs8.getInt(8)+rs8.getInt(9);	
	ptap=rs8.getInt(10)-rs8.getInt(11);
	
	//System.out.println("ptap"+ptap);
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
  
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=totalpop%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(7)%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(8)%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(9)%></td>

<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(10)%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(11)%></td>
<td  class="<%=style%> "style="text-align: center;"><%= ptap%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(13)%></td>
<td  class="<%=style%> "style="text-align: center;"> <%=rs8.getInt(14)%></td>
<td  class="<%=style%> "style="text-align: center;">0</td>
   
   
        
 
   	</tr>
   	
   	
<%
scpop+=rs8.getInt(8);
stpop+=rs8.getInt(9);
plainpop+=rs8.getInt(7);
pop+=totalpop;
housholds+=rs8.getInt(10);
hhconnect+=rs8.getInt(11);
totptap+=ptap;
totstands+=rs8.getInt(13);
totnotstand+=rs8.getInt(14);
}%>
<tr>
	<td  class=gridhdbg style="text-align: center;" colspan="6">Grand Total</td>
	<td  class=gridhdbg style="text-align: center;"> <%=pop%></td>
<td  class=gridhdbg style="text-align: center;"> <%=plainpop%></td>
<td  class=gridhdbg style="text-align: center;"> <%=scpop%></td>
<td  class=gridhdbg style="text-align: center;"> <%=stpop%></td>


<td   class=gridhdbg style="text-align: center;"> <%=housholds%></td>
<td  class=gridhdbg style="text-align: center;"> <%=hhconnect%></td>
<td  class=gridhdbg style="text-align: center;"><%=totptap %></td>
<td  class=gridhdbg style="text-align: center;"><%=totstands %> </td>
<td  class=gridhdbg style="text-align: center;"><%=totnotstand%></td>
<td  class=gridhdbg style="text-align: center;">0</td>
   
   
        
 
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