<%@ include file="/reports/conn.jsp" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "baselinesurveyvwmcommitte.xls");

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
	<td align="center" class="gridhdbg" colspan="9"> Base Line Survey VWS Committe - Report</td>
	</tr>
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation Name /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2>VWSC is Formed /<br>(Yes/No)</td>
    <td class=gridhdbg rowspan=2>VWSC is Functional	/<br>(Yes/No) </td>
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
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,VWSC_FORMED,(case when VWSM_FUNCTIONAL is null then 'No' else  VWSM_FUNCTIONAL end),to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";

//qry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,VWSC_FORM,VWSM_FUNC,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_vwm_comm_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";

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

   
   
        
 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

