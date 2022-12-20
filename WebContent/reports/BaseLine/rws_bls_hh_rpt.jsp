<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
  	
String hab=request.getParameter("hab");
session.setAttribute("hab",hab);  




    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="100%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_bls_hh_xls.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >Household Details</td>
	</tr>
    
	</table>
   
   <table width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>Habitation Id</td>
    <td class=gridhdbg rowspan=2>Habitation Details</td>
   <td class=gridhdbg rowspan=2><b>Family Details</b></font></td>
	<td class=gridhdbg rowspan=2><b>Status of Baseline</b></font></td>
	<td class=gridhdbg rowspan=2><b>Toilets Status</b></font></td>
	
	<td class=gridhdbg rowspan=2><b>Drinking water Details</b></font></td>
	
	<td class=gridhdbg rowspan=2><b>Survey Date</b></font></td>
	
    
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
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,nvl(Name_of_the_head,'-'),nvl(Father_Husband_Name,'-'),nvl(RelationShip_with_Head,'-'),nvl(Card_Type,'-'),nvl(Card_Number,'-'),nvl(JobCard_Number,'-'),nvl(Total_Family_Members,0),nvl(Female_Count,0),nvl(Male_Count,0),nvl(BaseLine_Status,'-'),nvl(Caste,'-'),nvl(Is_Toilet_Available,'-'),nvl(Constructed_Department,'-'),nvl(Toilet_Type,'-'),nvl(In_Sanitary_Latrine_Serviced,'-'),nvl(Is_Toilet_being_Used,'-'),nvl(Reason_For_Not_Using_Toilets,'-'),nvl(Is_Water_Avail_For_Toilets,'-'),nvl(Is_Toilet_Functional,'-'),nvl(Is_Toilet_Defunt,'-'),nvl(Reason_For_Toilet_Defunt,'-'),nvl(Using_Community_Toilets,'-'),nvl(Drinking_Water_Source,'-'),nvl(Usageof_Water_PerDay_in_Pots,'-'),nvl(Liters_per_One_Pot,0),nvl(Is_Drinking_Water_Available,'-'),nvl(Water_Avail_In_Months,'-'),nvl(Quality_of_Drinking_Water,'-'),nvl(Dist_to_Resource_in_Meters,0),nvl(Household_PhoneNumber,'-'),nvl(Survey_Date,'-') as surveydt,nvl(household_num,0) as household_num from rws_complete_hab_view a,rws_bls_household_tbl  b where a.panch_code=b.habitation_code and b.habitation_code='"+hab+"' order by dcode,mcode,pcode,vcode,panch_code ";


   
   System.out.println("qry is="+qry);
   
	 
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
	 <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
    <td class="<%=style%>"style="text-align: right;"> <%=rs8.getLong("household_num")%></td>
   <td  class="<%=style%>"style="text-align: left;">District:<%=rs8.getString(1)%><br>
   Mandal:<%=rs8.getString(2)%><br>Panchayath:<%=rs8.getString(3)%><br>village:<%=rs8.getString(4)%><br>Hab Code:<%=rs8.getString(6)%><br>Hab Name:<%=rs8.getString(5)%></td>
<td  class="<%=style%>" nowrap>
<FONT class=myfontclr1><font color=navy>Head Name:</font><%=rs8.getString(7) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Husband/Father Name:</font><%=rs8.getString(8) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Relation with Head:</font><%=rs8.getString(9) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Card Type:</font><%=rs8.getString(10) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Card No:</font><%=rs8.getString(11) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Job Card No:</font><%=rs8.getString(12) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Total Family Count:</font><%=rs8.getInt(13) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Female Count:</font><%=rs8.getInt(14) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Male Count:</font><%=rs8.getInt(15) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Caste:</font><%=rs8.getString(17) %></FONT>
<FONT class=myfontclr1><font color=navy>Phone:</font><%=rs8.getString(36) %></FONT>

</td>

<td  class="<%=style%>" >
<FONT class=myfontclr1><%=rs8.getString(16) %></FONT>
</td>
<td  class="<%=style%>" nowrap>
<FONT class=myfontclr1><font color=navy>Toilets available?:</font><%=rs8.getString(18) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Constructed Department:</font><%=rs8.getString(19) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Toilet Type:</font><%=rs8.getString(20) %></FONT><br>
<FONT class=myfontclr1><font color=navy>sanitary latrine serviced?:</font><%=rs8.getString(21) %></FONT><br>
<FONT class=myfontclr1><font color=navy>toilet being used?:</font><%=rs8.getString(22) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Reason for not using:</font><%=rs8.getString(23) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Community toilets using?:</font><%=rs8.getString(28) %></FONT><br>
<FONT class=myfontclr1><font color=navy>toilets defunt?:</font><%=rs8.getString(26) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Defunt Reason:</font><%=rs8.getString(27) %></FONT><br>

</td>
<td  class="<%=style%>" nowrap>
<FONT class=myfontclr1><font color=navy>available?:</font><%=rs8.getString(32) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Source:</font><%=rs8.getString(29) %></FONT><br>
<FONT class=myfontclr1><font color=navy>No of pots per Day:</font><%=rs8.getString(30) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Pot capacity:</font><%=rs8.getDouble(31) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Distance:</font><%=rs8.getDouble(35) %></FONT><br>
<FONT class=myfontclr1><font color=navy>No of Months Water Available:</font><%=rs8.getString(33) %></FONT><br>
<FONT class=myfontclr1><font color=navy>Quality:</font><%=rs8.getString(34) %></FONT><br>

</td>
<td  class="<%=style%>" >
<FONT class=myfontclr1><%=rs8.getString(37) %></FONT>
</td>

   
   
        
 
   	</tr>
   	
   
<%
}
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
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
</p>