<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
 <%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.util.*"%> 
<html:html>
<BODY>
<%
String id=request.getParameter("id");
//session.setAttribute("mode1",mode1 );
String scode=request.getParameter("scode");
String circle_code=request.getParameter("ccode");
String districtName=request.getParameter("districtName");
String divName=request.getParameter("divName");

//session.setAttribute("dcode",dcode );
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rd1=null;
    PreparedStatement ps1=null,ps2=null,ps3=null,ps4=null,pd1=null;
    int slno=0;
    ArrayList districts=new ArrayList();
    ArrayList svs_ohsr_list=new ArrayList();
    //String circle_code="";
    int count=0;
    int pws_count=0,mpws_count=0,dp_count=0;
    String svs_ohsr_stat="svs_ohsr";
    String svs_glsr_stat="svs_glsr";
    String mvs_ohsr_stat="mvs_ohsr";
    String mvs_glsr_stat="mvs_glsr";
    %>
   <table  class=gridbg1 border="1" cellspacing="0" cellpadding="0" width="60%" height="60%"
					bordercolor="#000000" style="border-collapse:collapse"   align="center" >
					<caption>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>
	</tr>  
	</table>
	</caption> 
<%
	String sscode[]=scode.split("_");
	String pre=sscode[0].toUpperCase();
			String post=sscode[1].toUpperCase();
	%>
<tr><td class="gridhdbg" colspan="17"><b> <%=pre%>-SR.RESERVOIRS- <%=post%> REPORT </b></td>	</tr>
<tr><td class="btext" colspan="17"><b>District: <%=districtName%>  Division: <%=divName%></b></td></tr>					
					<tr align="center">
						<td  class=btext style="width: 8%;">S No</td>
						<td class=btext align="center" >SUB DIVISION</td>
						<%if(scode.equalsIgnoreCase("svs_ohsr")||scode.equalsIgnoreCase("svs_glsr")) {%>
						  <td class=btext align="center" >PWS</td>
						<td class=btext align="center" >MPWS</td>
						<td class=btext align="center" >DP</td>  
						<%} %>
						<td class=btext align="center" >TOTAL</td>
						</tr>
						<%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						<%
						/* String div_query="SELECT DIVISION_OFFICE_NAME, DIVISION_OFFICE_CODE FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = '1' AND CIRCLE_OFFICE_CODE ='"+circle_code+"' ORDER BY DIVISION_OFFICE_NAME";
						//System.out.println(svs_ohsr);
						pd1=conn.prepareStatement(div_query);
						 rd1=pd1.executeQuery();
						 while(rd1.next())
							 
					   { */
							 //count+=rs1.getInt(1);
						
						//String svs_ohsr="  select count(1),d.division_office_name,SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v  where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code   and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code in ('01','02','09')  and d.circle_office_code='12'  and d.head_office_code='1' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.division_office_name order by  d.division_office_name";
						
						String svs_ohsr="select count(1),d.subdivision_office_name,d.subdivision_office_code,SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP from rws_subdivision_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v  where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code   and d.subdivision_office_code=a.subdivision_office_code   and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code in ('01','02','09')  and d.circle_office_code='"+circle_code+"'and d.division_office_code='"+id+"'  and d.head_office_code='1' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.subdivision_office_name,d.subdivision_office_code order by  d.subdivision_office_name";
						//System.out.println("@@@@@$$$$$$"+svs_ohsr);
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 
							 pws_count+=rs1.getInt(4);
							 mpws_count+=rs1.getInt(5);
							 dp_count+=rs1.getInt(6);
                             count+=rs1.getInt(1);
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(2)%>"><%=rs1.getString(2)%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							<td   style="text-align: right;"><%=rs1.getInt(4)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(5)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(6)+""%></td>
<%-- 							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=id%>&divName=<%=rs1.getString(2)%>"><%=rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)%></a></td>	
 --%>							
 <td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(2)%>"><%=rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)%></a></td>							
							
							</tr>
						
						
					  <% } %>
					  
							
							
							<%-- <%} %> --%>
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr> 
						<%}%>
						
						
						
						
						
						
						
						
						
						
						
						
						
						<%-- <%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						<%
						String div_query="SELECT SUBDIVISION_OFFICE_NAME, SUBDIVISION_OFFICE_CODE FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = '1' AND CIRCLE_OFFICE_CODE ='"+circle_code+"'  AND DIVISION_OFFICE_CODE='"+id+"' ORDER BY SUBDIVISION_OFFICE_NAME";
						//System.out.println(svs_ohsr);
						pd1=conn.prepareStatement(div_query);
						 rd1=pd1.executeQuery();
						 while(rd1.next())
							 
					   {
							 //count+=rs1.getInt(1);
						
						String svs_ohsr="select (select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as pws_count,(select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('02')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code )  as mpws_count, (select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('09')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as dp_count,(select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01','02','09')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as total_count from dual ";
						//System.out.println("$$$$$$$@@ "+svs_ohsr);
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 
							 pws_count+=rs1.getInt(1);
							 mpws_count+=rs1.getInt(2);
							 dp_count+=rs1.getInt(3);
                             count+=rs1.getInt(4);
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rd1.getString(1)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(2)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(3)+""%></td>							
 							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rd1.getString(2)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rd1.getString(1)%>"><%=rs1.getInt(4)+""%></a></td>				
 
							</tr>
						
						
					  <% } %>
					  
							
							
							<%} %>
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr> 
						<%}%>  --%>
						
						
						<%-- <%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						
						<%
						
						String svs_ohsr="select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01','02','09')  and d.division_office_code='"+id+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code   group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
						 ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							
							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
							
							</tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr>
							
							
							<%} %>  --%>
							
							
							<%-- <%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						
						
						<%
						
						String svs_ohsr="select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01','02','09')  and d.division_office_code='"+id+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code   group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
			
 							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
 				
 </tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr>
							
							
							<%} %> --%>
							<%-- <%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						<%
						String div_query="SELECT SUBDIVISION_OFFICE_NAME, SUBDIVISION_OFFICE_CODE FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = '1' AND CIRCLE_OFFICE_CODE ='"+circle_code+"'  AND DIVISION_OFFICE_CODE='"+id+"' ORDER BY SUBDIVISION_OFFICE_NAME";
						//System.out.println(svs_glsr);
						pd1=conn.prepareStatement(div_query);
						 rd1=pd1.executeQuery();
						 while(rd1.next())
							 
					   {
							 //count+=rs1.getInt(1);
						
						String svs_glsr="select (select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as pws_count,(select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('02')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code )  as mpws_count, (select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('09')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as dp_count,(select count(*)  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('01','02','09')  and d.division_office_code='"+id+"'  and d.subdivision_office_code='"+rd1.getString(2)+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code ) as total_count from dual ";
						//System.out.println(svs_glsr);
						ps1=conn.prepareStatement(svs_glsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 
							 pws_count+=rs1.getInt(1);
							 mpws_count+=rs1.getInt(2);
							 dp_count+=rs1.getInt(3);
                             count+=rs1.getInt(4);
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rd1.getString(1)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(2)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(3)+""%></td>							
 							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rd1.getString(2)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rd1.getString(1)%>"><%=rs1.getInt(4)+""%></a></td>				
 
							</tr>
						
						
					  <% } %>
					  
							
							
							<%} %>
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr> 
						<%}%>  --%>
							<%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						<%
						/* String div_query="SELECT DIVISION_OFFICE_NAME, DIVISION_OFFICE_CODE FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = '1' AND CIRCLE_OFFICE_CODE ='"+circle_code+"' ORDER BY DIVISION_OFFICE_NAME";
						//System.out.println(svs_glsr);
						pd1=conn.prepareStatement(div_query);
						 rd1=pd1.executeQuery();
						 while(rd1.next())
							 
					   { */
							 //count+=rs1.getInt(1);
						
						//String svs_glsr="  select count(1),d.division_office_name,SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v  where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code   and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code in ('01','02','09')  and d.circle_office_code='12'  and d.head_office_code='1' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.division_office_name order by  d.division_office_name";
						
						String svs_glsr="select count(1),d.subdivision_office_name,d.subdivision_office_code,SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP from rws_subdivision_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v  where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code   and d.subdivision_office_code=a.subdivision_office_code   and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code in ('01','02','09')  and d.circle_office_code='"+circle_code+"'and d.division_office_code='"+id+"'  and d.head_office_code='1' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.subdivision_office_name,d.subdivision_office_code order by  d.subdivision_office_name";
						//System.out.println("@@@@@$$$$$$"+svs_glsr);
						ps1=conn.prepareStatement(svs_glsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 
							 pws_count+=rs1.getInt(4);
							 mpws_count+=rs1.getInt(5);
							 dp_count+=rs1.getInt(6);
                             count+=rs1.getInt(1);
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(2)%>"><%=rs1.getString(2)%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							<td   style="text-align: right;"><%=rs1.getInt(4)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(5)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(6)+""%></td>
<%-- 							<td  style="text-align: right;" style="font-weight:bold"><a href="man_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=id%>&divName=<%=rs1.getString(2)%>"><%=rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)%></a></td>				
 --%>					
  <td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(3)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(2)%>"><%=rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)%></a></td>							
 		
							</tr>
						
						
					  <% } %>
					  
							
							
							<%-- <%} %> --%>
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr> 
						<%}%>
							<%if(scode.equalsIgnoreCase("mvs_ohsr")) {%>
						
						
						<%
						
						String svs_ohsr="select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('03')  and d.division_office_code='"+id+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code   group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getString(3)%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
						<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
							
							</tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count%></td>
							</tr>
							
							
							<%} %>
							
							
							<%if(scode.equalsIgnoreCase("mvs_glsr")) {%>
						
						
						<%
						
						String svs_ohsr="select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name  from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code  and d.circle_office_code='"+circle_code+"'  and a.type_of_asset_code in ('03')  and d.division_office_code='"+id+"' and   a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code   group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getString(3)%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
							
							</tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count+""%></td>
							</tr>
							
							
							<%} %>
							
							
							
							
							
						</table>
						<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed<br/>Un Identified(UI) Habitations are not displayed</font>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>
</BODY>


</html:html>