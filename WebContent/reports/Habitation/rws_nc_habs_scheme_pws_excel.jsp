<%@ include file="/reports/conn.jsp" %>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "notcoveredhabsunderanyscheme.xls");

%>
<form>
<%
String dcode=(String)session.getAttribute("dcode");
String lpcd=(String)session.getAttribute("lpcdstatus");



  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	
	
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr>
	<td align="center" class=gridhdbg colspan="7" >Habitations Which are not Covered under any Scheme(PWS,CPWS,MPWS)								
  - Report</td>
	</tr>
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2>Coverage Status</td>
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
   
   
   qry="select dname,mname,pname,vname,panch_name,panch_code,coverage_status from rws_complete_hab_view a WHERE  NOT EXISTS (SELECT hab_code FROM  RWS_HAB_SUPPLY_STATUS_TBL b WHERE  ";

   if(dcode !=null && !dcode.equals(" ")){
   	qry+=" substr(b.hab_code,1,2)='"+dcode+"' and ";	
   }
   qry+=" b.hab_code = a.panch_code and  ";
   if(lpcd.equals("All")){
	   	qry+="(b.PWS_SUPPLY>0 or b.PWS_UNSAFE_SUPPLY>0 or b.MPWS_SUPPLY>0 or b.MPWS_UNSAFE_SUPPLY>0 or b.CPWS_SUPPLY>0)) ";
	   	
	   }
	   if(lpcd.equals("Safe")){
	   	qry+="(b.PWS_SUPPLY>0  or b.MPWS_SUPPLY>0  or b.CPWS_SUPPLY>0)) ";
	   	
	   }

	   if(lpcd.equals("Unsafe")){
	   	qry+="(b.PWS_UNSAFE_SUPPLY>0 or b.MPWS_UNSAFE_SUPPLY>0)) ";
	   	
	   }     if(dcode !=null && !dcode.equals(" ")){
   	qry+=" and dcode='"+dcode+"' ";	
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
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%>/<br>&nbsp;<%=rs8.getString(6)%></td>

 <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%></td>
   
        
 
   	</tr>
   	
   	
<%
}
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

