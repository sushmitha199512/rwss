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
String scode=request.getParameter("scode");
String circle_code=request.getParameter("ccode");
String div_code=request.getParameter("divcode");
String sub_div_code=request.getParameter("subdivcode");
String districtName=request.getParameter("districtName");
String divName=request.getParameter("divName");
String subDivName=request.getParameter("subDivName");
String mandName=request.getParameter("mandName");
//session.setAttribute("dcode",dcode );
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
    PreparedStatement ps1=null,ps2=null,ps3=null,ps4=null;
    int slno=0;
    ArrayList districts=new ArrayList();
    ArrayList svs_ohsr_list=new ArrayList();
    //String circle_code="";
    //int count=0;
    String svs_ohsr_stat="svs_ohsr";
    String svs_glsr_stat="svs_glsr";
    String mvs_ohsr_stat="mvs_ohsr";
    String mvs_glsr_stat="mvs_glsr";
    String qry1;
    PreparedStatement stmt1=null;
    ResultSet rss1=null;
    %>
   <table  class=gridbg1 border="1" cellspacing="0" cellpadding="0" width="60%" height="60%"
					bordercolor="#000000" style="border-collapse:collapse"   align="center" >
					<caption>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  |&nbsp;</td>
	<td ><a href="./habitation_wise_components_list_excel.jsp?id=<%=id%>&scode=<%=scode%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&mandName=<%=mandName%>&divcode=<%=div_code%>&subdivcode=<%=sub_div_code%>">Excel </td>
	</tr>  
	
	</table>
	</caption> 
<%
	String sscode[]=scode.split("_");
	String pre=sscode[0].toUpperCase();
			String post=sscode[1].toUpperCase();
	%>
<tr><td class="gridhdbg" colspan="17"><b> <%=pre%>-RESERVOIRS- <%=post%> REPORT </b></td>	</tr>
				<tr><td class="btext" colspan="17"><b>District: <%=districtName%>  Division: <%=divName%> Sub Division: <%=subDivName%> Mandal: <%=mandName%></b></td></tr>					
			
					<tr align="center">
						<td  class=btext style="width: 8%;">S No</td>
						<td class=btext align="center" >Panchayat</td>
						<td class=btext align="center" >Village</td>
						<td class=btext align="center" >Habitation</td>
						<td class=btext align="center" >Asset Name</td>
						<td class=btext align="center" >Asset Code</td>
						<td class=btext align="center" >OHSR Code</td>
						 <td class=btext align="center" >Habitation Linkage</td> 
						 <td class=btext align="center" >OHSR Location</td>
						 <td class=btext align="center" >OHSR Capacity In Lts</td>
						 <td class=btext align="center" >No.Of Fillings</td>
						 <td class=btext align="center" >OHSR Staging(Mts)</td>
						 <td class=btext align="center" >Water Quality</td>
						</tr>
						
						<%if(scode.equalsIgnoreCase("svs_ohsr")) {%>
						
						<%
							///String svs_ohsr="select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (01,02,09) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"'";
						String svs_ohsr=" select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (01,02,09) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"' and  subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI'";
						   //String svs_ohsr="select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+sub_div_code+"' and substr(a.hab_code,6,2)='"+id+"'";
						
						
					   // System.out.println("^^^^^^$$$$$$$$$$"+svs_ohsr);
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							// count+=rs1.getInt(1);
							 %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString("PNAME")%></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							
							<td  style="text-align: left;"><%=rs1.getString("VNAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("PANCH_NAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("ASSET_NAME")%></a></td>		
							<td  style="text-align: left;"><%=rs1.getString("ASSET_CODE")%></a></td>
							<td  style="text-align: left;"><%=rs1.getString("OHSR_CODE")%></a></td>
							
                               <%
                               qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs1.getString("OHSR_CODE")+"'";
                               stmt1=conn.prepareStatement(qry1);
                               rss1=stmt1.executeQuery();
           		            if(rss1.next())
           		            {%>
           		            	
           		            		
           		            		
           		            		
           		            		
           		            		
           		            		<% String no_of_habs=rss1.getString("NO_OF_HABS");
           		            		if(no_of_habs!=null&&!no_of_habs.equalsIgnoreCase("null")&&!no_of_habs.equalsIgnoreCase("0")){%>
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            		
           		            	
           		            		<% String ohsr_loc=rs1.getString("OHSR_LOC");
           		            		if(ohsr_loc!=null&&!ohsr_loc.equalsIgnoreCase("null")){%>
           		            		<td  style="text-align: left;"><%=rs1.getString("OHSR_LOC")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            		<%-- <td  style="text-align: left;"><%=rs1.getInt("OHSR_CAP_LTS")+""%></td> --%>
           		            		
           		            		
           		            		
           		            		<% int ohsr_cap_ltrs=rs1.getInt("OHSR_CAP_LTS");
           		            		if(ohsr_cap_ltrs>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("OHSR_CAP_LTS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
           		            		<% int ohsr_nooffilling=rs1.getInt("OHSR_NO_OF_FILLING");
           		            		if(ohsr_nooffilling>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("OHSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		<% float ohsr_stages=rs1.getFloat("OHSR_NO_OF_FILLING");
           		            		if(ohsr_stages>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getFloat("OHSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
<%--            		                    <td  style="text-align: left;"><%=rs1.getInt("OHSR_NO_OF_FILLING")+""%></td>
 --%>           		                    
<%--  <td  style="text-align: left;"><%=rs1.getFloat("OHSR_SATGES")%></td>
 --%>           		            
           		            <%}
           		            if(rs1.getString("WATER_QTY")!=null && rs1.getString("WATER_QTY").equals("N"))
           		            {%>
           		            	 
           		            	 <td  style="text-align: left;">Safe Source</td>
           		           <% }
           		            else if(rs1.getString("WATER_QTY")!=null && rs1.getString("WATER_QTY").equals("Y"))
           		            {%>
           		            	 <td  style="text-align: left;">Not Safe Source</td>
           		           <% }
           		            else
           		            {%>
           		            	<td  style="text-align: left;">Safe Source</td>	
           		            <%} 
                               %>
                        
                    </tr>
						
						
					  <% } %>
					  
							<%
							ps1.close();
							 rs1.close();} %>
							
							<%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						
						<%
						
						//String svs_GLSR="select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (01,02,09) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"'";
						 
						String svs_GLSR=" select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (01,02,09) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"' and  subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI'";

						
						ps1=conn.prepareStatement(svs_GLSR);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count+=rs1.getInt(1);
							 %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString("PNAME")%></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							
							<td  style="text-align: left;"><%=rs1.getString("VNAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("PANCH_NAME")%></a></td>	
								<td  style="text-align: left;"><%=rs1.getString("ASSET_NAME")%></a></td>		
							<td  style="text-align: left;"><%=rs1.getString("ASSET_CODE")%></a></td>
							<td  style="text-align: left;"><%=rs1.getString("GLSR_CODE")%></a></td>
							
                               <%
                               qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs1.getString("GLSR_CODE")+"'";
                               stmt1=conn.prepareStatement(qry1);
                               rss1=stmt1.executeQuery();
           		            if(rss1.next())
           		            {%>
           		            <% String no_of_habs=rss1.getString("NO_OF_HABS");
           		            		if(no_of_habs!=null&&!no_of_habs.equalsIgnoreCase("null")&&!no_of_habs.equalsIgnoreCase("0")){%>
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            	
           		            		<%-- <td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td> --%>
           		            		<%-- <td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td> --%>
           		            		<% String ohsr_loc=rs1.getString("GLSR_LOC");
           		            		if(ohsr_loc!=null&&!ohsr_loc.equalsIgnoreCase("null")){%>
           		            		<td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            		<%-- <td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getFloat("GLSR_SATGES")%></td> --%>
           		            
           		            <% int ohsr_cap_ltrs=rs1.getInt("GLSR_CAP_LTS");
           		            		if(ohsr_cap_ltrs>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
           		            		<% int ohsr_nooffilling=rs1.getInt("GLSR_NO_OF_FILLING");
           		            		if(ohsr_nooffilling>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		<% float ohsr_stages=rs1.getFloat("GLSR_NO_OF_FILLING");
           		            		if(ohsr_stages>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getFloat("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            <%
           		         }
           		            if(rs1.getString("water_qty")!=null && !rs1.getString("water_qty").equals("") && rs1.getString("water_qty").equals("N"))
           		            {%>
           		            	 
           		            	 <td  style="text-align: left;">Safe Source</td>
           		           <%} 
           		            else
           		            {%>
           		            	<td  style="text-align: left;">Not Safe Source</td>	
           		            <%} 
                               %>
                        
                    </tr>
						
						
					  <% } %>
					  
							<%
							ps1.close();
							 rs1.close();} %>
						<%-- 	<%if(scode.equalsIgnoreCase("svs_glsr")) {%>
						
						<%
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('01','02','09') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							</tr>
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;">TOTAL</td>
							<td   style="text-align: right;"><%=count%></td>
							</tr>
							
							
							<%} %> --%>
							
							<%-- 
							<%if(scode.equalsIgnoreCase("mvs_ohsr")) {%>
					
						<%
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('03') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							</tr>
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;">TOTAL</td>
							<td   style="text-align: right;"><%=count%></td>
							</tr>
							
							<%} %> --%>
							
							<%if(scode.equalsIgnoreCase("mvs_ohsr")) {%>
						
						<%
						
						String svs_ohsr="select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (03) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"'";
						 ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count+=rs1.getInt(1);
							 %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString("PNAME")%></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							
							<td  style="text-align: left;"><%=rs1.getString("VNAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("PANCH_NAME")%></a></td>	
								<td  style="text-align: left;"><%=rs1.getString("ASSET_NAME")%></a></td>		
							<td  style="text-align: left;"><%=rs1.getString("ASSET_CODE")%></a></td>
							<td  style="text-align: left;"><%=rs1.getString("OHSR_CODE")%></a></td>
							
                               <%
                               qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs1.getString("OHSR_CODE")+"'";
                               stmt1=conn.prepareStatement(qry1);
                               rss1=stmt1.executeQuery();
           		            if(rss1.next())
           		            {%>
           		            <% String no_of_habs=rss1.getString("NO_OF_HABS");
           		            		if(no_of_habs!=null&&!no_of_habs.equalsIgnoreCase("null")&&!no_of_habs.equalsIgnoreCase("0")){%>
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            	
           		            		<%-- <td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td> --%>
           		            		<%-- <td  style="text-align: left;"><%=rs1.getString("OHSR_LOC")%></td> --%>
           		            		<% String ohsr_loc=rs1.getString("OHSR_LOC");
           		            		if(ohsr_loc!=null&&!ohsr_loc.equalsIgnoreCase("null")){%>
           		            		<td  style="text-align: left;"><%=rs1.getString("OHSR_LOC")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            		<% int ohsr_cap_ltrs=rs1.getInt("OHSR_CAP_LTS");
           		            		if(ohsr_cap_ltrs>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("OHSR_CAP_LTS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
           		            		<% int ohsr_nooffilling=rs1.getInt("OHSR_NO_OF_FILLING");
           		            		if(ohsr_nooffilling>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("OHSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		<% float ohsr_stages=rs1.getFloat("OHSR_NO_OF_FILLING");
           		            		if(ohsr_stages>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getFloat("OHSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		<%-- <td  style="text-align: left;"><%=rs1.getInt("OHSR_CAP_LTS")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getInt("OHSR_NO_OF_FILLING")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getFloat("OHSR_SATGES")%></td> --%>
           		            
           		            <%}
           		            if(rs1.getString("WATER_QTY")!=null && rs1.getString("WATER_QTY").equals("N"))
           		            {%>
           		            	 
           		            	 <td  style="text-align: left;">Safe Source</td>
           		           <% }
           		            else if(rs1.getString("WATER_QTY")!=null && rs1.getString("WATER_QTY").equals("Y"))
           		            {%>
           		            	 <td  style="text-align: left;">Not Safe Source</td>
           		           <% }
           		            else
           		            {%>
           		            	<td  style="text-align: left;">Safe Source</td>	
           		            <%} 
                               %>
                        
                    </tr>
						
						
					  <% } %>
					  
							<%ps1.close();
							 rs1.close();} %>
							 <%if(scode.equalsIgnoreCase("mvs_glsr")) {%>
						
						<%
						
						String svs_GLSR="select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (03) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"'";
						 ps1=conn.prepareStatement(svs_GLSR);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count+=rs1.getInt(1);
					   %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString("PNAME")%></td>
							<%-- <td   style="text-align: right;"><%=rs1.getInt(1)+""%></td> --%>
							
							<td  style="text-align: left;"><%=rs1.getString("VNAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("PANCH_NAME")%></a></td>	
								<td  style="text-align: left;"><%=rs1.getString("ASSET_NAME")%></a></td>		
							<td  style="text-align: left;"><%=rs1.getString("ASSET_CODE")%></a></td>
							<td  style="text-align: left;"><%=rs1.getString("GLSR_CODE")%></a></td>
							
                               <%
                               qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs1.getString("GLSR_CODE")+"'";
                               stmt1=conn.prepareStatement(qry1);
                               rss1=stmt1.executeQuery();
           		            if(rss1.next())
           		            {%>
           		            <% String no_of_habs=rss1.getString("NO_OF_HABS");
           		            		if(no_of_habs!=null&&!no_of_habs.equalsIgnoreCase("null")&&!no_of_habs.equalsIgnoreCase("0")){%>
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            	
           		            		<%-- <td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td> --%>
<%--            		            		<td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td>
 --%>     
 						<% String ohsr_loc=rs1.getString("GLSR_LOC");
           		            		if(ohsr_loc!=null&&!ohsr_loc.equalsIgnoreCase("null")){%>
           		            		<td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %> 
           		            		<% int ohsr_cap_ltrs=rs1.getInt("GLSR_CAP_LTS");
           		            		if(ohsr_cap_ltrs>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
           		            		<% int ohsr_nooffilling=rs1.getInt("GLSR_NO_OF_FILLING");
           		            		if(ohsr_nooffilling>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		<% float ohsr_stages=rs1.getFloat("GLSR_NO_OF_FILLING");
           		            		if(ohsr_stages>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getFloat("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>     		            		
                                  <%-- <td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getFloat("GLSR_SATGES")%></td> --%>
           		            
           		            <%
           		         }
           		            if(rs1.getString("water_qty")!=null && !rs1.getString("water_qty").equals("") && rs1.getString("water_qty").equals("N"))
           		            {%>
           		            	 
           		            	 <td  style="text-align: left;">Safe Source</td>
           		           <%} 
           		            else
           		            {%>
           		            	<td  style="text-align: left;">Not Safe Source</td>	
           		            <%} 
                               %>
                        
                    </tr>
						
						
					  <% } %>
					  
							<%ps1.close();
							 rs1.close();} %>
							<%-- <%if(scode.equalsIgnoreCase("mvs_glsr")) {%>
						
						<%
						
						String svs_GLSR=" select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (01,02,09) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"' and  subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI'";

/* 						String svs_GLSR="select subCompTbl.ASSET_CODE,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(GLSR_code,1,16) and substr(m.hab_code,1,2)='"+circle_code+"' and substr(m.hab_code,6,2)='"+id+"' and m.type_of_asset_code in (03) and m.division_office_code='"+div_code+"' and m.subdivision_office_code='"+sub_div_code+"'";
 */						 ps1=conn.prepareStatement(svs_GLSR);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {
							 //count+=rs1.getInt(1);
					   %>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString("PNAME")%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							
							<td  style="text-align: left;"><%=rs1.getString("VNAME")%></a></td>	
							<td  style="text-align: left;"><%=rs1.getString("PANCH_NAME")%></a></td>	
								<td  style="text-align: left;"><%=rs1.getString("ASSET_NAME")%></a></td>		
							<td  style="text-align: left;"><%=rs1.getString("ASSET_CODE")%></a></td>
							<td  style="text-align: left;"><%=rs1.getString("GLSR_CODE")%></a></td>
							
                               <%
                               qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs1.getString("GLSR_CODE")+"'";
                               stmt1=conn.prepareStatement(qry1);
                               rss1=stmt1.executeQuery();
           		            if(rss1.next())
           		            {%>
           		            <% String no_of_habs=rss1.getString("NO_OF_HABS");
           		            		if(no_of_habs!=null&&!no_of_habs.equalsIgnoreCase("null")&&!no_of_habs.equalsIgnoreCase("0")){%>
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            	
           		            		<td  style="text-align: left;"><%=rss1.getString("NO_OF_HABS")%></td>
           		            		<td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td>
           		            		<% String ohsr_loc=rs1.getString("GLSR_LOC");
           		            		if(ohsr_loc!=null&&!ohsr_loc.equalsIgnoreCase("null")){%>
           		            		<td  style="text-align: left;"><%=rs1.getString("GLSR_LOC")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		
           		            		<%} %>
           		            		<% int ohsr_cap_ltrs=rs1.getInt("GLSR_CAP_LTS");
           		            		if(ohsr_cap_ltrs>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		
           		            		<% int ohsr_nooffilling=rs1.getInt("GLSR_NO_OF_FILLING");
           		            		if(ohsr_nooffilling>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		
           		            		
           		            		<% float ohsr_stages=rs1.getFloat("GLSR_NO_OF_FILLING");
           		            		if(ohsr_stages>0){%>
           		            		<td  style="text-align: left;"><%=rs1.getFloat("GLSR_NO_OF_FILLING")%></td>
           		            		<%}else{ %>
           		            		<td  style="text-align: left;">--</td>
           		            		<%} %>
           		            		<td  style="text-align: left;"><%=rs1.getInt("GLSR_CAP_LTS")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getInt("GLSR_NO_OF_FILLING")+""%></td>
           		                    <td  style="text-align: left;"><%=rs1.getFloat("GLSR_SATGES")%></td>
           		            
           		            <%
           		         }
           		            if(rs1.getString("water_qty")!=null && !rs1.getString("water_qty").equals("") && rs1.getString("water_qty").equals("N"))
           		            {%>
           		            	 
           		            	 <td  style="text-align: left;">Safe Source</td>
           		           <%} 
           		            else
           		            {%>
           		            	<td  style="text-align: left;">Not Safe Source</td>	
           		            <%} 
                               %>
                        
                    </tr>
						
						
					  <% } %>
					  
							<%ps1.close();
							 rs1.close();} %> --%>
							
							<%-- <%if(scode.equalsIgnoreCase("mvs_glsr")) {%>
						
						<%
						
						String svs_ohsr="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code in ('03') and man.dcode='"+circle_code+"' and a.circle_office_code='"+circle_code+"' and a.division_office_code='"+div_code+"' and a.subdivision_office_code='"+id+"' group by man.MNAME,man.mcode order by man.MNAME";
						ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 while(rs1.next())
							 
					   {count+=rs1.getInt(1);%>
							<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=rs1.getString(3)%></td>
							<td   style="text-align: right;"><%=rs1.getInt(1)+""%></td>
							</tr>
						
						
					  <% } %>
					  <tr >
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;">TOTAL</td>
							<td   style="text-align: right;"><%=count+""%></td>
							</tr>
							
							
							<%} %> --%>
							
							
							
							
							
						</table>
						<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed<br/>Un Identified(UI) Habitations are not displayed</font>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp"%>
</p>
</BODY>


</html:html>