<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<form>
<center>
<%
String type=request.getParameter("type");
//System.out.println("type"+type);
if(type!=null){
		session.setAttribute("type",type);
}
String dcode=request.getParameter("dcode");
//System.out.println("dcode"+dcode);
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);

int count=0;	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="85%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	

	 <td><a href="./rws_bls_sa_abstract_drill_rpt_excel.jsp">Excel</a></td>
	    
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Base Line Survey Schools & Anganwadi - Detailed Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
    
    <%  
    if(type.equals("1")){
  %>
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
  <% 
   }
    
    else if(type.equals("2")){
    	%>
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
      <% 
       }
        
        else if(type.equals("3")){
        	%>
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
          <% 
           }
            
                        
    
    
   else if(type.equals("4")){
   %>
  <td class=gridhdbg rowspan=2>AnganVadiName</td>
    <td class=gridhdbg rowspan=2>AnganwadiCode</td>
    <td class=gridhdbg rowspan=2>BuildingType_name</td>
    <td class=gridhdbg rowspan=2>TotalEnrollment</td>
    <td class=gridhdbg rowspan=2>Availability of Toilet Facility</td>
    <td class=gridhdbg rowspan=2>BuildingDept</td>
    <td class=gridhdbg rowspan=2>YearBuild</td>
    <td class=gridhdbg rowspan=2>SanitoryUse</td>
    <td class=gridhdbg rowspan=2>FunctionalReason	</td>
    <td class=gridhdbg rowspan=2>Reason for Defunt</td>
    <td class=gridhdbg rowspan=2>Toilet Water Facility Available</td>
    <td class=gridhdbg rowspan=2>DrinkingWaterExist</td>
    <td class=gridhdbg rowspan=2>BinAvailable</td>
    <td class=gridhdbg rowspan=2>PitAvailable</td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
    <%
   }
   else if(type.equals("5")){
	   %>
	  <td class=gridhdbg rowspan=2>AnganVadiName</td>
	    <td class=gridhdbg rowspan=2>AnganwadiCode</td>
	    <td class=gridhdbg rowspan=2>BuildingType_name</td>
	    <td class=gridhdbg rowspan=2>TotalEnrollment</td>
	    <td class=gridhdbg rowspan=2>Availability of Toilet Facility</td>
	    <td class=gridhdbg rowspan=2>BuildingDept</td>
	    <td class=gridhdbg rowspan=2>YearBuild</td>
	    <td class=gridhdbg rowspan=2>SanitoryUse</td>
	    <td class=gridhdbg rowspan=2>FunctionalReason	</td>
	    <td class=gridhdbg rowspan=2>Reason for Defunt</td>
	    <td class=gridhdbg rowspan=2>Toilet Water Facility Available</td>
	    <td class=gridhdbg rowspan=2>DrinkingWaterExist</td>
	    <td class=gridhdbg rowspan=2>BinAvailable</td>
	    <td class=gridhdbg rowspan=2>PitAvailable</td>
	    <td class=gridhdbg rowspan=2>Survey Date </td>
	    <%
	   }
   else if(type.equals("6")){
	   %>
	  <td class=gridhdbg rowspan=2>AnganVadiName</td>
	    <td class=gridhdbg rowspan=2>AnganwadiCode</td>
	    <td class=gridhdbg rowspan=2>BuildingType_name</td>
	    <td class=gridhdbg rowspan=2>TotalEnrollment</td>
	    <td class=gridhdbg rowspan=2>Availability of Toilet Facility</td>
	    <td class=gridhdbg rowspan=2>BuildingDept</td>
	    <td class=gridhdbg rowspan=2>YearBuild</td>
	    <td class=gridhdbg rowspan=2>SanitoryUse</td>
	    <td class=gridhdbg rowspan=2>FunctionalReason	</td>
	    <td class=gridhdbg rowspan=2>Reason for Defunt</td>
	    <td class=gridhdbg rowspan=2>Toilet Water Facility Available</td>
	    <td class=gridhdbg rowspan=2>DrinkingWaterExist</td>
	    <td class=gridhdbg rowspan=2>BinAvailable</td>
	    <td class=gridhdbg rowspan=2>PitAvailable</td>
	    <td class=gridhdbg rowspan=2>Survey Date </td>
	    <%
	   }
 %>
    
	</tr>
	<tr>
       </tr>
       
<%
try
{
	


   //main qry
   Statement stmt3=null;
   ResultSet rs8=null;
   int sno=1;
   
   
   int a=0,b=0;
   int bt=0,gt=0;
   String aa=null,bb=null;
   int gtot=0;
   
   stmt3=conn.createStatement();
 //school queries
   
   if(type.equals("1")){
	   
	   String schoolqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),BINEXIST,PITEXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_school_sani_survey_tbl  b where a.panch_code=b.habitation_code ";
	    if(dcode!=null && !dcode.equals("00")){
	    	schoolqry+="and dcode='"+dcode+"'";
	    }
	    schoolqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(schoolqry);
	   //System.out.println("schoolqry---->"+schoolqry);
	   }
 
   if(type.equals("2")){
	   
	   String schoolqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),BINEXIST,PITEXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_school_sani_survey_tbl  b where a.panch_code=b.habitation_code and DRINKINGWATERFACILITYAVAILABLE='Yes' ";
	    if(dcode!=null && !dcode.equals("00")){
	    	schoolqry+="and dcode='"+dcode+"'";
	    }
	    schoolqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(schoolqry);
	 //  System.out.println("schoolqry---->"+schoolqry);
	   }
 
   if(type.equals("3")){
	   
	   String schoolqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),BINEXIST,PITEXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_school_sani_survey_tbl  b where a.panch_code=b.habitation_code and  (BOYSTOILETSCOUNT>0 or GIRLSTOILETSCOUNT>0) and DRINKINGWATERFACILITYAVAILABLE ='Yes' ";
	    if(dcode!=null && !dcode.equals("00")){
	    	schoolqry+="and dcode='"+dcode+"'";
	    }
	    schoolqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(schoolqry);
	  // System.out.println("schoolqry---->"+schoolqry);
	   }
  
 
 
 
// anganwadi query

   if(type.equals("4")){
	   
	   String anganqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,ANGANVADINAME,ANGANWADICODE,BUILDINGTYPE_NAME,TOTALENROLLMENT,AVAILOFTOILETFACILITY,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),TOILETWATERFACILITYAVAIL,DRINKINGWATEREXIST,BINAVAILABLE,PITAVAILABLE,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl  b where a.panch_code=b.habitation_code ";
	    if(dcode!=null && !dcode.equals("00")){
	    	anganqry+="and dcode='"+dcode+"'";
	    }
	    anganqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(anganqry);
	   }
    

   if(type.equals("5")){
	   
	   String anganqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,ANGANVADINAME,ANGANWADICODE,BUILDINGTYPE_NAME,TOTALENROLLMENT,AVAILOFTOILETFACILITY,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),TOILETWATERFACILITYAVAIL,DRINKINGWATEREXIST,BINAVAILABLE,PITAVAILABLE,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl  b where a.panch_code=b.habitation_code and  DRINKINGWATEREXIST  ='Yes'";
	    if(dcode!=null && !dcode.equals("00")){
	    	anganqry+="and dcode='"+dcode+"'";
	    }
	    anganqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(anganqry);
	   }

   if(type.equals("6")){
	   
	   String anganqry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,ANGANVADINAME,ANGANWADICODE,BUILDINGTYPE_NAME,TOTALENROLLMENT,AVAILOFTOILETFACILITY,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),TOILETWATERFACILITYAVAIL,DRINKINGWATEREXIST,BINAVAILABLE,PITAVAILABLE,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl  b where a.panch_code=b.habitation_code and AVAILOFTOILETFACILITY  ='Yes'  and DRINKINGWATEREXIST  ='Yes' ";
	    if(dcode!=null && !dcode.equals("00")){
	    	anganqry+="and dcode='"+dcode+"'";
	    }
	    anganqry+="order by dcode,mcode,pcode,vcode,panch_code";
	   rs8=stmt3.executeQuery(anganqry);
	   }
    
   
   while(rs8.next())
   {
   	
		
	   count++;
  	
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
<%
if(type.equals("1")||type.equals("2")||type.equals("3"))
  {

 %>  

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

<% 
}
  else if(type.equals("4")||type.equals("5")||type.equals("6"))
  {
 %>

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
if(type.equals("1")||type.equals("2")||type.equals("3"))
{
	 aa=rs8.getString(19);
     bb=rs8.getString(20);
    

a=Integer.parseInt(aa);
b=Integer.parseInt(bb);
bt+=a;
gt+=b;
gtot=0;
gtot=bt+gt;

 
}
   }
   
   
   if(type.equals("3"))
{


	 %>

<tr>
	<td align="center" class="gridhdbg" colspan="12">Boys and Girls Toilets Count</td>
	<td style="text-align: left;" class="gridhdbg" ><%=bt%></td> 
		<td style="text-align: left;" class="gridhdbg" ><%=gt%></td>
		<td align="center" class="gridhdbg" colspan="11"></td>    	
</tr>	
<!-- 
<tr>
	<td align="center" class="gridhdbg" colspan="12">Grand Total of Both Toilets(Girls and Boys</td>
	<td style="text-align: right;" class="gridhdbg" colspan="2"><b><%=gtot%></b></td> 
	<td align="center" class="gridhdbg" colspan="11"></td>	    	
</tr>
 -->
<%
}
   
   
 
   }catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>
<%
if(count==0){
  	 %>
  	 
  	<h3>No Records</h3> 
  	 <%
  	 
   } %>

</center></form>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>