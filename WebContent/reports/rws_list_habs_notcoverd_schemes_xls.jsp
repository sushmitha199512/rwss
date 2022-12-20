<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_list_habs_notcoverd_schemes_xls.xls");
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;

String dcode=(String)session.getAttribute("district");
//System.out.println("distjfdsfksjd");



%>
<table    width="80%"  border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align="center">
		<td align="center" class="gridhdbg" colspan="8">Habs Not Covered Schemes Report</td>
</tr>

<tr align=center>

               <td class=gridhdbg  >Sl.No</td>
               <td class=gridhdbg  >District</td>
               <td class=gridhdbg  >Mandal</td>
               <td class=gridhdbg  > Panchayath</td> 
			   <td class=gridhdbg  > Village</td> 
               <td class=gridhdbg  >Habcode</td> 
			     <td class=gridhdbg > HabName</td> 
		     <td class=gridhdbg > Population</td> 
              
		   
			   </tr>
			   
<% 
try
{
    String query = "",style="";
	int styleCount=0;
	
int sno=1;
  stmt1=conn.createStatement();
  
   query="";
   String qry1="select distinct ch.dname,ch.mname,ch.pname,ch.vname,ch.panch_code,ch.panch_name,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU,a.CENSUS_MINORITY_POPU,ch.dcode,ch.mcode,ch.pcode,ch.vcode  from RWS_ASSET_MAST_TBL  am,rws_complete_hab_view ch,rws_asset_hab_tbl ah,rws_habitation_directory_tbl a   where am.hab_code=ch.panch_code and am.asset_code=ah.asset_code and am.TYPE_OF_ASSET_CODE not in('01','02','03','09') and am.hab_code not in (select am1.hab_code  from rws_asset_mast_tbl  am1 where am1.TYPE_OF_ASSET_CODE  in('01','02','03','09')) and  am.hab_code=a.hab_code ";
   if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
   {
    qry1+="   ch.dcode='"+dcode+"'  ";
     }
   qry1+="order by ch.dcode,ch.mcode,ch.pcode,ch.vcode";
  
  
  
//System.out.println("Query"+qry1);
  rs1=stmt1.executeQuery(qry1);
  while (rs1.next())
	{
	  if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
				

	%>
	<tr>
	 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>
      
      <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(1) %></td> 
  	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(2) %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(3) %></td>
      <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(4) %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(5) %></td>
	  <td class="<%=style%>" style="text-align: left;" ><%=rs1.getString(6) %></td>
	  <td class="<%=style%>" style="text-align: right;"><%=totpop %></td>
	  	</tr>
	<%  
	}
 }
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	
	}

%>
</table>
</form>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
