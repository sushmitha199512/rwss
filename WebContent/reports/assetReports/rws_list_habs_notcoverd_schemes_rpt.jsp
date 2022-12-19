<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;

String dcode=request.getParameter("district");
session.setAttribute("district",dcode);
//System.out.println("distjfdsfksjd");



%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="90%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				
				<td class="bwborder"><a href="./rws_list_habs_notcoverd_schemes_xls.jsp" target=_new>Excel | </a></td>
			</tr>  
		</table>
	</caption>
	

</table>
<table    width="80%"  border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr  align="center">
		<td align="center" class="gridhdbg" colspan="10">Habs Not Covered Schemes(CPWS,PWS,MPWS & DP) Report</td>
</tr>

<tr align=center>

               <td class=gridhdbg  >Sl.No</td>
               <td class=gridhdbg  >District</td>
               <td class=gridhdbg  >Mandal</td>
                <td class=gridhdbg  >Constituency</td>
               <td class=gridhdbg  > Panchayath</td> 
			   <td class=gridhdbg  > Village</td> 
               <td class=gridhdbg  >Habcode</td> 
			     <td class=gridhdbg > HabName</td>
			     <td class=gridhdbg > Coverage Status</td>  
		     <td class=gridhdbg > Population</td> 
              
		   
			   </tr>
			   
<% 
try
{
    String query = "";
	
int sno=1;
  stmt1=conn.createStatement();
  
   query="";
//String qry1="select distinct d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,hd.CENSUS_PLAIN_POPU,hd.CENSUS_SC_POPU,hd.CENSUS_ST_POPU,hd.CENSUS_MINORITY_POPU,d.dcode,m.mcode,p.pcode,v.vcode  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd  where ";

// if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	//{
	// qry1+="   d.dcode='"+dcode+"' and substr (hd.hab_code,1,2)='"+dcode+"' and  ";
	//  }


//qry1+="  hd.hab_code not in(select am.hab_code from RWS_ASSET_MAST_TBL am where am.TYPE_OF_ASSET_CODE in('01','02','03','09'))  and   d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and  p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' order by d.dcode,m.mcode,p.pcode,v.vcode";
 
int styleCount=0;
String style="";
//String qry1="select distinct ch.dname,ch.mname,ch.pname,ch.vname,ch.panch_code,ch.panch_name,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU,a.CENSUS_MINORITY_POPU,ch.dcode,ch.mcode,ch.pcode,ch.vcode,ch.coverage_status  from RWS_ASSET_MAST_TBL  am,rws_complete_hab_view ch,rws_asset_hab_tbl ah,rws_habitation_directory_tbl a   where am.hab_code=ch.panch_code and am.asset_code=ah.asset_code and am.TYPE_OF_ASSET_CODE not in('01','02','03','09') and am.hab_code not in (select ah1.hab_code  from rws_asset_mast_tbl  am1,rws_asset_hab_tbl ah1 where am1.asset_code=ah1.asset_code and TYPE_OF_ASSET_CODE  in('01','02','03','09')) and  am.hab_code=a.hab_code ";
String qry1 = "select distinct ch.dname,ch.mname,ch.pname,ch.vname,ch.panch_code,ch.panch_name,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU,ch.CENSUS_MINORITY_POPU,ch.dcode,ch.mcode,ch.pcode,ch.vcode,ch.coverage_status  from rws_complete_hab_view ch  where  panch_code not in (select b.hab_code from RWS_ASSET_MAST_TBL a,RWS_ASSET_HAB_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TYPE_OF_ASSET_CODE  in ('01','02','03','09') and a.ASSET_CODE=b.ASSET_CODE and b.HAB_CODE=c.PANCH_CODE and a.HAB_CODE in (select panch_code from rws_complete_hab_view)) ";
if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
{
 qry1+=" and  ch.dcode='"+dcode+"'  ";
  }
qry1+=" order by ch.dcode,ch.mcode,ch.pcode,ch.vcode";
//System.out.println("Query"+qry1);
  rs1=stmt1.executeQuery(qry1);
long sc=0,plain=0,st=0,min=0,totpop=0,gtotpop=0;
String constituency="";
  while (rs1.next())
	{
	  
	  String constQuery="select constituency_code,constituency_name from rws_constituency_tbl where dcode='"+rs1.getString("dcode")+"' and mcode='"+rs1.getString("mcode")+"'";
	 Statement  statement=conn.createStatement();
	 ResultSet resultSet=statement.executeQuery(constQuery);
	 if(resultSet.next()){
		 constituency=resultSet.getString(2);
	 }
	 resultSet.close();
	 statement.close();
	  if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
			if(rs1.getString(7)!=null){
                           plain=Long.parseLong(rs1.getString(7));
							}
if(rs1.getString(8)!=null){
                           sc=Long.parseLong(rs1.getString(8));
							}
if(rs1.getString(9)!=null){
                           st=Long.parseLong(rs1.getString(9));
							}
if(rs1.getString(10)!=null){
                           min=Long.parseLong(rs1.getString(10));
							}	

totpop=plain+sc+st+min;
gtotpop+=totpop;


	%>
	<tr>
	 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>
      
      <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(1) %></td> 
  	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(2) %></td>
  	  <td class="<%=style%>" style="text-align: left;"><%=constituency %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(3) %></td>
      <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(4) %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rs1.getString(5) %></td>
	  <td class="<%=style%>" style="text-align: left;" ><%=rs1.getString(6) %></td>
	  <td class="<%=style%>" style="text-align: left;" ><%=rs1.getString("coverage_status") %></td>
	  <td class="<%=style%>" style="text-align: right;"><%=totpop %></td>
	  	</tr>
	<%  
plain=0;sc=0;st=0;min=0;totpop=0;
	}
  rs1.close();
  stmt1.close();

%>
<tr><td colspan=9 class=btext align="center">Total:</td><td class=btext><%=gtotpop %></td></tr>
<% 
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
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

