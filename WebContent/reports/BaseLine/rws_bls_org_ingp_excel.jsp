<%@ include file="/reports/conn.jsp" %>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "baselinesurveyorganizationsingp.xls");

%>
<form>
<%
String dcode=(String)session.getAttribute("dcode");


String mcode=(String)session.getAttribute("mcode");

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr>
	<td align="center" class=gridhdbg colspan="11" > Base Line Survey Other Organizations in GP								
  - Report</td>
	</tr>
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2>NGOS/<br>(Yes/No) </td>
      <td class=gridhdbg rowspan=2>SHGS/<br>(Yes/No) </td>
	  <td class=gridhdbg rowspan=2>Women Groups /<br>(Yes/No) </td>
<td class=gridhdbg rowspan=2>Other Groups /<br>(Yes/No) </td>
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
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,ngos,shgs,women_grps,other_grps,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_other_org_ingp_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";

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

<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(10)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(11)%></td>
   
   
        
 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

