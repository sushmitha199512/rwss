<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />


<html:html>

    
<style type="text/css">
    body, body a {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 13px !important;
    }
    .btext {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }
</style>





    <%    DecimalFormat ndf = new DecimalFormat("####.00");
        String dcode = request.getParameter("dcode");
        String dname = request.getParameter("dname");
        String mcode = request.getParameter("mcode");
        String mname = request.getParameter("mname");
        String pcode = request.getParameter("pcode");
        String pname = request.getParameter("pname");
        String vcode = request.getParameter("vcode");
        String vname = request.getParameter("vname");
        String statusDate = request.getParameter("statusDate");
        String mode = request.getParameter("mode");
        String mode1 = request.getParameter("mode1");
        int year = Calendar.getInstance().get(Calendar.YEAR);
        
        
        session.setAttribute("dname",dname);
        session.setAttribute("mcode",mcode);
        session.setAttribute("mname",mname);
        session.setAttribute("pcode",pcode);
        session.setAttribute("pname",pname);
        session.setAttribute("vcode",vcode);
        session.setAttribute("vname",vname);
        session.setAttribute("statusDate",statusDate);
        session.setAttribute("mode",mode);
        session.setAttribute("mode1",mode1);
       
        session.setAttribute("dcode",dcode);
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        
    %>


    <table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<!-- <td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td> -->
	<td ><a href="#" onClick="window.close();">Close  &nbsp; </td>
	<!-- <td ><a href="#" onClick="window.close();">Close | &nbsp; </td>-->
	  <td><a href="./rws_drought_category_habs_drill_excel.jsp">Excel</a></td> 
	</tr>  
	</table>
	</caption>
	<tr >
	<%if(mode1.equals("TR") || mode1.equals("ALLTR")){ %>
	<td align="center" class="gridhdbg" >Drought Habitations for Daily Transport <br/> District:<%=dname %>  
	<br/>
	<%if(mcode!=null){
		%>
		Mandal:<%=mname %>
		<%
	}%>
	<%if(pcode!=null){
		%>
		Panchayat:<%=pname %>
		<%
	}%>
	<%if(vcode!=null){
		%>
		Village:<%=vname %>
		<%
	}%>
	</td>
	<%}else{ %>
	<td align="center" class="gridhdbg" >Drought Habitations for District:<%=dname %> and Category: <%=mode1 %>
	<br/>
	<%if(mcode!=null){
		%>
		Mandal:<%=mname %>
		<%
	}%>
	<%if(pcode!=null){
		%>
		Panchayat:<%=pname %>
		<%
	}%>
	<%if(vcode!=null){
		%>
		Village:<%=vname %>
		<%
	}%>
	</td>
	<%} %>
	</tr>
    
	</table>
          
    <table width="1200px" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
        
        
       
        <tr align="center">
            <td class=gridhdbg><b>SL&nbsp;NO </b></td>
            <td class=gridhdbg><b>District</b></td>
            <td class=gridhdbg><b>Mandal</b></td>
            <td class=gridhdbg><b>Panchayat</b></td>
            <td class=gridhdbg><b>Village</b></td>
            <td class=gridhdbg><b>Habitation Name </b></td>
            <td class=gridhdbg><b>Habitation Code</b></td>
            <%if(mode1.equals("TR") || mode1.equals("ALLTR")) {%>
             <td class=gridhdbg><b>Population Served</b></td>
            <td class=gridhdbg><b>No of tanker trips</b></td>
            <td class=gridhdbg><b>Quantity served in KL</b></td>
            <%}else{ %>
            <td class=gridhdbg><b>Coverage Status</b></td>
            <td class=gridhdbg><b>Total Population</b></td>
            <%} %>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
				if(mode.equals("districts")){
					if(mode1.equals("A")){
                	query="select habcode from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
					}
					
					else if(mode1.equals("ALLA")){
	                	query="select habcode from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE  and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
					}
					else if(mode1.equals("TR")){
	                	query="select habitation_code,nvl(POPULATION_SER_TRANSPORT,0),nvl(TANKER_NO_OF_TRIPS,'0'),nvl(tanker_qty,0) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+dcode+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
					}
					else if(mode1.equals("ALLTR")){
	                	query="select habitation_code,nvl(POPULATION_SER_TRANSPORT,0),nvl(TANKER_NO_OF_TRIPS,'0'),nvl(tanker_qty,0) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
					}
					else if(mode1.equals("B")){
					query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";	
					}
					else if(mode1.equals("ALLB")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE  and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";	
						}
					else if(mode1.equals("C")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
					}
					else if(mode1.equals("ALLC")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE  and TRANSPORTATION='N' and YEAR='"+year+"'";
					}
				}
				else if(mode.equals("mandals")){

					if(mode1.equals("A")){
                query="select habcode from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
					}
					else if(mode1.equals("TR")){
	                	query="select habitation_code,nvl(POPULATION_SER_TRANSPORT,0),nvl(TANKER_NO_OF_TRIPS,'0'),nvl(tanker_qty,0) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
					}
					else if(mode1.equals("B")){
					query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";	
					}
					else if(mode1.equals("C")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
					}
				
				}
				else if(mode.equals("panchayats")){

					if(mode1.equals("A")){
                query="select habcode from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
					}
					else if(mode1.equals("TR")){
	                	query="select habitation_code,nvl(POPULATION_SER_TRANSPORT,0),nvl(TANKER_NO_OF_TRIPS,'0'),nvl(tanker_qty,0) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
					}
					else if(mode1.equals("B")){
					query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";	
					}
					else if(mode1.equals("C")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
					}
				
				}
				else if(mode.equals("villages")){

					if(mode1.equals("A")){
                query="select habcode from RWS_DROUGHT_HABITATION_TBL a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and substr(habcode,8,3)='"+vcode+"' and TRANSPORTATION='Y'  and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE and YEAR='"+year+"'";
					}
					else if(mode1.equals("TR")){
	                	query="select habitation_code,nvl(POPULATION_SER_TRANSPORT,0),nvl(TANKER_NO_OF_TRIPS,'0'),nvl(tanker_qty,0) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' AND  TO_CHAR(date_of_entry,'YYYY')='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0) AND substr(habitation_code,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and substr(habcode,8,3)='"+vcode+"' and to_date('"+statusDate+"','dd/mm/yyyy') between FRM_DATE and TO_DATE AND date_of_entry=to_date('"+statusDate+"','dd/mm/yyyy')";
					}
					else if(mode1.equals("B")){
					query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and substr(habcode,8,3)='"+vcode+"' and TRANSPORTATION='Y' and to_date('"+statusDate+"','dd/mm/yyyy') not between FRM_DATE and TO_DATE and YEAR='"+year+"' and FRM_DATE>to_date('"+statusDate+"','dd/mm/yyyy')";	
					}
					else if(mode1.equals("C")){
						query="select habcode from RWS_DROUGHT_HABITATION_TBL  a,rws_habitation_directory_tbl b where a.habcode=b.HAB_CODE and substr(habcode,1,2)='"+dcode+"' and substr(habcode,6,2)='"+mcode+"' and substr(habcode,13,2)='"+pcode+"' and substr(habcode,8,3)='"+vcode+"' and TRANSPORTATION='N' and YEAR='"+year+"'";
					}
				
				}
			//System.out.println(query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {

                	int population = 0;
                    String covStatus = "";

                    String hab_code = rs1.getString(1);
                    if(!mode1.equals("TR") || !mode1.equals("ALLTR")){
                    String habDetails = "select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),COVERAGE_STATUS from rws_habitation_directory_tbl where hab_code='"
                            + hab_code + "' group by COVERAGE_STATUS";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habDetails);
                    if (resultSet.next()) {
                        population = resultSet.getInt(1);
                        covStatus = resultSet.getString(2);
                    }
                    resultSet.close();
                    statement.close();
                    }
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;

                    /* String details = "select dname,mname,pname,vname,panch_code,panch_name  from rws_complete_hab_view where panch_code='" + hab_code + "'"; */
                    String details="select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and e.panch_code='"+hab_code+"'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(details);

                    if (resultSet.next()) {
        %>

        <tr>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(1)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(4)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(6)%></td>
              <%if(mode1.equals("TR") || mode1.equals("ALLTR")){%>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getInt(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getFloat(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getFloat(4)%></td>
            <%}else{ %>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=covStatus%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=population%></td>
            <%} %>
        </tr>

        <%
                        } else {
                           // System.out.println(hab_code);
                        }
                        statement.close();
                        resultSet.close();
                    }
                    st.close();
                    rs1.close();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (conn != null) {
                            conn.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            
        %>
    </table>
    
<br/>
        <table height="20px" align="center">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
<br/>
</html:html>
