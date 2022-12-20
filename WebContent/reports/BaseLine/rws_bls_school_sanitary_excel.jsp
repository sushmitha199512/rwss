<%@ include file="/reports/conn.jsp" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "baselinesurveyschool.xls");

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
	<td align="center" class="gridhdbg" colspan="9"> Base Line Survey School Sanitation Survey - Report</td>
	</tr>
	<tr>
	
		
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation Name /<Br>Habitation Code </td>
    
    
   
    <td class=gridhdbg rowspan=2>SchoolName	</td>
    <td class=gridhdbg rowspan=2>DiseCode	</td>
    <td class=gridhdbg rowspan=2>Locality	</td>
    <td class=gridhdbg rowspan=2>SchoolType	</td>
    <td class=gridhdbg rowspan=2>SchoolCategory	</td>
    <td class=gridhdbg rowspan=2>SchoolEstabilishedBefore2007	</td>
    <td class=gridhdbg rowspan=2>BoysCount	</td>
    <td class=gridhdbg rowspan=2>GirlsCount	</td>
    <td class=gridhdbg rowspan=2>SanitaryExist	</td>
    <td class=gridhdbg rowspan=2>SanitaryBuildingDept	</td>
    <td class=gridhdbg rowspan=2>YearOfBulit	</td>
    <td class=gridhdbg rowspan=2>BoysToiletsCount	</td>
    <td class=gridhdbg rowspan=2>GirlsToiletsCount	</td>
    <td class=gridhdbg rowspan=2>IsWaterExist	</td>
    <td class=gridhdbg rowspan=2>SanitaryUse	</td>
    <td class=gridhdbg rowspan=2>DrinkingWaterFacilityAvailable	</td>
    <td class=gridhdbg rowspan=2>BinExist	</td>
    <td class=gridhdbg rowspan=2>PitExist	</td>
  
      
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
   
   qry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),BINEXIST,PITEXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_school_sani_survey_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";
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
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)!=null && rs8.getString(9).equals("NULL")?"0":rs8.getString(9)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(10)!=null && rs8.getString(10).equals("NULL")?"0":rs8.getString(10)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(11)!=null && rs8.getString(11).equals("NULL")?"0":rs8.getString(11)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(12)!=null && rs8.getString(12).equals("NULL")?"0":rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(13)!=null && rs8.getString(13).equals("NULL")?"0":rs8.getString(13)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(14)!=null && rs8.getString(14).equals("NULL")?"0":rs8.getString(14)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(15)!=null && rs8.getString(15).equals("NULL")?"0":rs8.getString(15)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(16)!=null && rs8.getString(16).equals("NULL")?"0":rs8.getString(16)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(17)!=null && rs8.getString(17).equals("NULL")?"0":rs8.getString(17)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(18)!=null && rs8.getString(18).equals("NULL")?"0":rs8.getString(18)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(19)!=null && rs8.getString(19).equals("NULL")?"0":rs8.getString(19)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(20)!=null && rs8.getString(20).equals("NULL")?"0":rs8.getString(20)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(21)!=null && rs8.getString(21).equals("NULL")?"0":rs8.getString(21)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(22)!=null && rs8.getString(22).equals("NULL")?"0":rs8.getString(22)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(23)!=null && rs8.getString(23).equals("NULL")?"0":rs8.getString(23)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(24)!=null && rs8.getString(24).equals("NULL")?"0":rs8.getString(24)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(25)!=null && rs8.getString(25).equals("NULL")?"0":rs8.getString(25)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(26)!=null && rs8.getString(26).equals("NULL")?"0":rs8.getString(26)%></td>



        
 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

