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
String div_code=request.getParameter("divcode");
String districtName=request.getParameter("districtName");
String divName=request.getParameter("divName");
String subDivName=request.getParameter("subDivName");
//session.setAttribute("dcode",dcode );
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rd1=null;
    PreparedStatement ps1=null,ps2=null,ps3=null,ps4=null,pd1=null;
    int slno=0;
    ArrayList districts=new ArrayList();
    ArrayList svs_ohsr_list=new ArrayList();
    //String circle_code="";
    int count=0,count_final=0;
    int pws_count=0,mpws_count=0,dp_count=0;
    String svs_ohsr_stat="svs_ohsr";
    String svs_glsr_stat="svs_glsr";
    String mvs_ohsr_stat="mvs_ohsr";
    String mvs_glsr_stat="mvs_glsr";
    
    
    /*
     select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='05' and substr(m.hab_code,6,2)='45' and m.type_of_asset_code in (01,02,09)

            select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='12' and substr(m.hab_code,6,2)='05' and m.type_of_asset_code in (01,02,09)

            select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='05' and substr(m.hab_code,6,2)='45' and m.type_of_asset_code in (03)

            select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='12' and substr(m.hab_code,6,2)='05' and m.type_of_asset_code in (03)

    */
    
    
    
    
    
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
		<tr align="center">
				<tr><td class="btext" colspan="17"><b>District: <%=districtName%>  Division: <%=divName%> Sub Division: <%=subDivName%></b></td></tr>					
						
						<td  class=btext style="width: 8%;">S No</td>
						<td class=btext align="center" >MANDAL</td>
						<%if(scode.equalsIgnoreCase("svs_ohsr")||scode.equalsIgnoreCase("svs_glsr")) {%>
						  <td class=btext align="center" >PWS</td>
						<td class=btext align="center" >MPWS</td>
						<td class=btext align="center" >DP</td>  
						<%} %>
						<td class=btext align="center" >TOTAL</td>
						</tr>
							<%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						<%
						
							 //count+=rs1.getInt(1);
						//						String svs_ohsr="select (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as pws_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('02') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' )  as mpws_count, (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as dp_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as total_count from dual ";

						//String svs_ohsr="select COUNT(CASE a.type_of_asset_code WHEN '01' THEN 1 END) as pws,COUNT(CASE a.type_of_asset_code WHEN '02' THEN 1 END) as mpws,COUNT(CASE a.type_of_asset_code WHEN '09' THEN 1 END) as dp,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						
						//String svs_ohsr="   select COUNT(CASE a.type_of_asset_code WHEN '01' THEN 1  else 0 END) as pws, COUNT(CASE a.type_of_asset_code WHEN '02' THEN 1 else 0 END) as mpws,COUNT(CASE a.type_of_asset_code WHEN '09' THEN 1 ELSE 0  END) as dp, man.mcode,trim(man.MNAME)as Mandal  from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t ,rws_complete_hab_view v   where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='12' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by man.MNAME,man.mcode order by man.MNAME";
						String svs_ohsr="select SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP, man.mcode,trim(man.MNAME)as Mandal  from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t ,rws_complete_hab_view v   where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by man.MNAME,man.mcode order by man.MNAME";
						//System.out.println("####@@@&&& "+svs_ohsr);
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count=0;
							 pws_count+=rs1.getInt(1);
							 mpws_count+=rs1.getInt(2);
							 dp_count+=rs1.getInt(3);
                             count=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3);
                             count_final+=count;
                             
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString("MCODE")%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString("MANDAL")%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getString("MANDAL")%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(2)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(3)+""%></td>							
<%--  							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rd1.getString(2)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rd1.getString(1)%>"><%=rs1.getInt(4)+""%></a></td>				
 --%> 
 							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString("MCODE")%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString("MANDAL")%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=count+""%></a></td>				
 
							</tr>
						
						
					  <% } %>
					  
							
							
							
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count_final%></td>
							</tr> 
						<%}%> 
						
						<%-- <%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						
						<%
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						 ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							
							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=svs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
							
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
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>"><%=rs1.getInt(1)+""%></a></td>				
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
						String div_query="select m.mname,sd.mcode from RWS_MANDAL_SUBDIVISION_TBL sd,rws_mandal_tbl m  where circle_office_code='"+circle_code+"' and division_office_code='"+div_code+"' and subdivision_office_code='"+id+"' and m.dcode='"+circle_code+"' and m.mcode=sd.mcode ORDER BY m.mname";
						//System.out.println(svs_glsr);
						pd1=conn.prepareStatement(div_query);
						 rd1=pd1.executeQuery();
						 while(rd1.next())
							 
					   {
							 //count+=rs1.getInt(1);
						//						String svs_glsr="select (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as pws_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('02') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' )  as mpws_count, (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as dp_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as total_count from dual ";

						String svs_glsr="select (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01') and man.dcode='"+circle_code+"' and substr(a.hab_code,6,2) = '"+rd1.getString(2)+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as pws_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('02') and man.dcode='"+circle_code+"' and substr(a.hab_code,6,2) = '"+rd1.getString(2)+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' )  as mpws_count, (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('09') and man.dcode='"+circle_code+"' and substr(a.hab_code,6,2) = '"+rd1.getString(2)+"'  and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as dp_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"'  and substr(a.hab_code,6,2) = '"+rd1.getString(2)+"'  and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as total_count from dual ";
						System.out.println(svs_glsr);
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
 
 							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rd1.getString(2)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rd1.getString(1)%>"><%=rs1.getInt(4)+""%></a></td>				
 
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
						<%}%> --%>
							
								<%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						<%
						
							 //count+=rs1.getInt(1);
						//						String svs_glsr="select (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as pws_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('02') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' )  as mpws_count, (select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as dp_count,(select count(*) from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' ) as total_count from dual ";

/* 						String svs_glsr="select COUNT(CASE a.type_of_asset_code WHEN '01' THEN 1 END) as pws,COUNT(CASE a.type_of_asset_code WHEN '02' THEN 1 END) as mpws,COUNT(CASE a.type_of_asset_code WHEN '09' THEN 1 END) as dp,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
 */						//System.out.println("@@@ "+svs_glsr);
	               String svs_glsr=" select SUM(CASE WHEN a.type_of_asset_code ='01' then 1 else 0 END) PWS  , SUM(CASE WHEN a.type_of_asset_code ='02' then 1 else 0 END) MPWS, SUM(CASE WHEN a.type_of_asset_code ='09' then 1 else 0 END) DP, man.mcode,trim(man.MNAME)as Mandal  from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t ,rws_complete_hab_view v   where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by man.MNAME,man.mcode order by man.MNAME";

                 ps1=conn.prepareStatement(svs_glsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count=0;
							 pws_count+=rs1.getInt(1);
							 mpws_count+=rs1.getInt(2);
							 dp_count+=rs1.getInt(3);
                             count=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3);
                             count_final+=count;
                             
                         %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString("MCODE")%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString("MANDAL")%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getString("MANDAL")%></a></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(2)+""%></td>
							<td   style="text-align: right;"><%=rs1.getInt(3)+""%></td>							
<%--  							<td  style="text-align: right;" style="font-weight:bold"><a href="mandal_wise_components_list.jsp?id=<%=rd1.getString(2)%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&divcode=<%=id%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=rd1.getString(1)%>"><%=rs1.getInt(4)+""%></a></td>				
 --%> 
 							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString("MCODE")%>&scode=<%=svs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString("MANDAL")%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=count+""%></a></td>				
 
							</tr>
						
						
					  <% } %>
					  
							
							
							
						 
						 <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_count%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count_final%></td>
							</tr> 
						<%}%> 
							<%if(scode.equalsIgnoreCase("mvs_ohsr")) {%>
						
						
						<%
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('03') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getString(3)%></a></td>
							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_ohsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getInt(1)+""%></a></td>				
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
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('03') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						
						
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getString(3)%></a></td>
							<td  style="text-align: right;" style="font-weight:bold"><a href="habitation_wise_components_list.jsp?id=<%=rs1.getString(2)%>&scode=<%=mvs_glsr_stat%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&divName=<%=divName%>&subDivName=<%=subDivName%>&mandName=<%=rs1.getString(3)%>&divcode=<%=div_code%>&subdivcode=<%=id%>"><%=rs1.getInt(1)+""%></a></td>				
							</tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=count+""%></td>
							</tr>
							
							
							<%} %>
							
							
							
							
							
						</table>
<p align=center>
						<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed<br/>Un Identified(UI) Habitations are not displayed</font>

<%@ include file = "/commons/rws_footer.jsp" %>
</p>
</BODY>


</html:html>