<%@ include file="/reports/conn.jsp" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "baselinesurveyanganwadi.xls");

%>
<form>
<%
String dcode=(String)session.getAttribute("dcode");


String mcode=(String)session.getAttribute("mcode");;

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td align="center" class="gridhdbg" colspan="9"> Base Line Survey - Anganwadi Sanitation Survey - Report</td>
	</tr>
	<tr>
	
		<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation Name /<Br>Habitation Code </td>
    
    
  
    <td class=gridhdbg rowspan=2>AnganVadiName</td>
    <td class=gridhdbg rowspan=2>AnganwadiCode</td>
    <td class=gridhdbg rowspan=2>BuildingType_name</td>
    <td class=gridhdbg rowspan=2>TotalEnrollment</td>
    <td class=gridhdbg rowspan=2>Availability of Toilet Facility</td>
    <td class=gridhdbg rowspan=2>BuildingDept</td>
    <td class=gridhdbg rowspan=2>YearBuild</td>
    <td class=gridhdbg rowspan=2>SanitoryUse</td>
    <td class=gridhdbg rowspan=2>FunctionalReason	</td>
    <td class=gridhdbg rowspan=2>Reason for defunt</td>
    <td class=gridhdbg rowspan=2>Toilet Water Facility Available</td>
    <td class=gridhdbg rowspan=2>DrinkingWaterExist</td>
    <td class=gridhdbg rowspan=2>BinAvailable</td>
    <td class=gridhdbg rowspan=2>PitAvailable</td>
   
  
      
    <td class=gridhdbg rowspan=2>Survey Date </td>
    
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
   
   qry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,ANGANVADINAME,ANGANWADICODE,BUILDINGTYPE_NAME,TOTALENROLLMENT,AVAILOFTOILETFACILITY,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),TOILETWATERFACILITYAVAIL,DRINKINGWATEREXIST,BINAVAILABLE,PITAVAILABLE,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";  

if(mcode !=null && !mcode.equals(""))
{
	qry+="and mcode='"+mcode+"'";
}
qry+="order by dcode,mcode,pcode,vcode,panch_code";
   
   
   
	 
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
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%>/<br>&nbsp;<%=rs8.getString(6)%></br></td>


<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)!=null && rs8.getString(8).equals("NULL")?"0":rs8.getString(8)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)!=null && rs8.getString(9).equals("NULL")?"0":rs8.getString(9)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(10)!=null && rs8.getString(10).equals("NULL")?"0":rs8.getString(10)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(11)!=null && rs8.getString(11).equals("NULL")?"0":rs8.getString(11)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(12)!=null && rs8.getString(12).equals("NULL")?"0":rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(13)!=null && rs8.getString(13).equals("NULL")?"0":rs8.getString(13)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(14)!=null && rs8.getString(14).equals("NULL")?"0":rs8.getString(14)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(15)!=null && rs8.getString(15).equals("NULL")?"0":rs8.getString(15)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(16)!=null && rs8.getString(16).equals("NULL")?"0":rs8.getString(16)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(17)!=null && rs8.getString(17).equals("NULL")?"0":rs8.getString(17)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(18)!=null && rs8.getString(18).equals("NULL")?"0":rs8.getString(18)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(19)!=null && rs8.getString(19).equals("NULL")?"0":rs8.getString(19)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(20)!=null && rs8.getString(20).equals("NULL")?"0":rs8.getString(20)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(21)!=null && rs8.getString(21).equals("NULL")?"0":rs8.getString(21)%> </td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(22)!=null && rs8.getString(22).equals("NULL")?"0":rs8.getString(22)%> </td>

 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

