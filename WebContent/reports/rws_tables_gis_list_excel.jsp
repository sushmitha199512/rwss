<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>
<%! public String isNull(String str){
		if(str==null)
			return "-";
		else 
			return str;
	} 
%>
<%
	PreparedStatement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt12=null,stmt13=null,stmt14=null,stmt15=null,stmt16=null,stmt17=null,stmt18=null,stmt19=null,stmt20=null,stmt21=null,stmt22=null,stmt23=null,stmt24=null,stmt25=null,stmt26=null,stmt27=null,stmt28=null,stmt29=null,stmt30=null,stmt31=null,stmt32=null,stmt33=null,stmt34=null,stmt35=null,stmt36=null,stmt37=null,stmt38=null,stmt39=null,stmt40=null,stmt41=null,stmt42=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null,rs23=null,rs24=null,rs25=null,rs26=null,rs27=null,rs28=null,rs29=null,rs30=null,rs31=null,rs32=null,rs33=null,rs34=null,rs35=null,rs36=null,rs37=null,rs38=null,rs39=null,rs40=null,rs41=null,rs42=null,rs43=null;
	String dcode="";
	String query1="";
	String query2="";
	String query3="",query4="",query5="",query6="",query7="",query8="",query9="",query10="",query11="",query12=" ",query13=" ",query14=" ",query15=" ",query16=" ",query17=" ",query18=" ",query19=" ",query20=" ",query21=" ",query22=" ",query23=" ",query24=" ",query25=" ",query26=" ",query27=" ",query28=" ",query29=" ",query30=" ",query31=" ",query32=" ",query33=" ",query34=" ",query35=" ",query36=" ",query37=" ",query38=" ",query39=" ",query40=" ",query41=" ";
	dcode=request.getParameter("district");
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
%>
<table border="1">
	<tr><b>District_tbl</b></tr>
	<tr>
	<%	try	{
			query1="select a.* from rws_district_tbl a where dcode= ? ";			
			stmt1=conn.prepareStatement(query1);	
			stmt1.setString(1, district);
			rs1=stmt1.executeQuery();
			ResultSetMetaData rsmd1=rs1.getMetaData();
			for(int i=1;i<=rsmd1.getColumnCount();i++){
	%>
      <td><b><%=rsmd1.getColumnName(i) %></b></td>
	<%		} %>
	</tr>
	<%	while(rs1.next()) { %>
	<tr bgcolor="#ffffff">
	<%		for(int i=1;i<=rsmd1.getColumnCount();i++)	{	%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs1.getString(i))%></td>
	<%			}		%>
	</tr>
	<%			}
			} catch(Exception e) {
				System.out.println("The Exception is in rws_tables_gis_list_excel District Table : "+e.getMessage());
			}
			finally {
				try {
					if(rs1!=null) {
						rs1.close();
					}
					if(stmt1!=null)	{
						stmt1.close();		
					}
				} catch(Exception o) {
					System.out.println("The Exception is in rws_tables_gis_list_excel District Table : "+o.getMessage());
				}
			}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Mandal_tbl</b></tr>
	<tr>
	<%
		try	{
    		query2="select a.* from rws_mandal_tbl a where dcode= ? and mcode= ? ";			
			stmt2=conn.prepareStatement(query2); 
			stmt2.setString(1, district);
			stmt2.setString(2, mandal);
			rs2=stmt2.executeQuery();
			ResultSetMetaData rsmd2=rs2.getMetaData();
			for(int i=1;i<=rsmd2.getColumnCount();i++){
	%>
       <td><b><%=rsmd2.getColumnName(i) %></b></td>
	<%		}%>
	</tr>
	<%	while(rs2.next()){	%>
	<tr bgcolor="#ffffff">
	<%		for(int i=1;i<=rsmd2.getColumnCount();i++) {	%>
       <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs2.getString(i))%></td>
	<% 			}			%>
	</tr>
	<%		}
		}catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Mandal Table : "+e.getMessage());
		} finally {
			try {			
				if(rs2!=null){
					rs2.close();
				}
				if(stmt2!=null){
					stmt2.close();				
				}			
			 } catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Mandal Table : "+o.getMessage());
			 }
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Panchayat_tbl</b></tr>
	<tr>
	<%	try	{
    		query3="select * from rws_panchayat_tbl where dcode= ? and mcode= ? ";			
			stmt3=conn.prepareStatement(query3);
			stmt3.setString(1, district);
			stmt3.setString(2, mandal);
			rs3=stmt3.executeQuery();
			ResultSetMetaData rsmd3=rs3.getMetaData();
			for(int i=1;i<=rsmd3.getColumnCount();i++){
	%>
       <td><b><%=rsmd3.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs3.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd3.getColumnCount();i++){		%>
    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs3.getString(i))%></td>
	<%			}			%>
	</tr>
	<% 		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Panchayat Table : "+e.getMessage());
		}
		finally	{
			try	{		
				if(rs3!=null){
					rs3.close();
				}
				if(stmt3!=null)	{
					stmt3.close();				
				}		
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Panchayat Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Village_tbl</b></tr>
	<tr>
	<%	try	{
    		query4="select * from rws_village_tbl v where  dcode= ? and mcode= ? "; 			
			stmt4=conn.prepareStatement(query4);
			stmt4.setString(1, district);
			stmt4.setString(2, mandal);
			rs4=stmt4.executeQuery();
			ResultSetMetaData rsmd4=rs4.getMetaData();
			for(int i=1;i<=rsmd4.getColumnCount();i++) {
	%>
       <td><b><%=rsmd4.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs4.next()) {	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd4.getColumnCount();i++){	%>
       <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs4.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Village Table : "+e.getMessage());
		} finally {
			try {
				if(rs4!=null){
					rs4.close();
				}
				if(stmt4!=null){
					stmt4.close();					
				}	
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Village Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Panchayat Raj_tbl</b></tr>
	<tr>
	<%	try	{
    		query5="select a.* from rws_panchayat_raj_tbl a,rws_complete_hab_view b where a.panch_code=b.panch_code and substr(a.panch_code,1,2)= ? and substr(a.hab_code,6,2)= ? "; 			
			stmt5=conn.prepareStatement(query5);
			stmt5.setString(1, district);
			stmt5.setString(2, mandal);
			rs5=stmt5.executeQuery();
			ResultSetMetaData rsmd5=rs5.getMetaData();
			for(int i=1;i<=rsmd5.getColumnCount();i++){
	%>
        <td><b><%=rsmd5.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs5.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd5.getColumnCount();i++){		%>
       <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs5.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}	
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Panchayat Raj Table : "+e.getMessage());
		} finally {
			try	{		
				if(rs5!=null){
					rs5.close();
				}
				if(stmt5!=null){
					stmt5.close();				
				}			
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Panchayat Raj Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Works- Admin Sanction Table</b></tr>
	<tr>
	<%	try	{
    		query6="select OFFICE_CODE,NO_OF_HABS,WORK_NAME,PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY,PREPARED_ON,WORK_ID,FLAG,TYPE_OF_ASSET,ADMIN_NO,ADMIN_DATE,SANCTION_AMOUNT,WORK_CATEGORY ,PLAN_CODE ,AUG_NEW_CODE,CATEGORY_CODE ,LEAD_HABITATION  from rws_work_admn_tbl a where substr(a.work_id,5,2)= ? and substr(lead_habitation,6,2)= ? "; 			
			stmt6=conn.prepareStatement(query6);
			stmt6.setString(1, district);
			stmt6.setString(2, mandal);
			rs6=stmt6.executeQuery();
			ResultSetMetaData rsmd6=rs6.getMetaData();
			for(int i=1;i<=rsmd6.getColumnCount();i++){
	%>
        <td><b><%=rsmd6.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs6.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd6.getColumnCount();i++){	%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs6.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Works- Admin Sanction Table : "+e.getMessage());
		} finally {
			try {		
				if(rs6!=null){
					rs6.close();
				}
				if(stmt6!=null)	{
					stmt6.close();			
				}			
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Works- Admin Sanction Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Works-Admin Hab Link Table</b></tr>
	<tr>
	<%	try	{
    		query7="select a.WORK_ID ,a.HAB_CODE from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl w,rws_admn_hab_lnk_tbl b where w.work_id=a.work_id and substr(a.work_id,5,2)= ? and a.work_id=b.work_id and substr(b.hab_code,6,2)= ? "; 			
			stmt7=conn.prepareStatement(query7);	
			stmt7.setString(1, district);
			stmt7.setString(2, mandal);
			rs7=stmt7.executeQuery();
			ResultSetMetaData rsmd7=rs7.getMetaData();
			for(int i=1;i<=rsmd7.getColumnCount();i++) {
	%>
       <td><b><%=rsmd7.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs7.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd7.getColumnCount();i++)	{		%>
     		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs7.getString(i))%></td>
	<%			} %>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Works-Admin Hab Link Table : "+e.getMessage());
		} finally	{
			try	{		
				if(rs7!=null){
					rs7.close();
				}
				if(stmt7!=null){
					stmt7.close();			
				}			
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Works-Admin Hab Link Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Source Identification tbl</b></tr>
	<tr>
	<% try {
		    query8="select a.HAB_CODE ,a.SOURCE_CODE ,a.WORK_ID  from RWS_SOURCE_IDEN_FIN_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and substr(a.work_id,5,2)= ? and substr(a.hab_code,6,2)= ? "; 			
			stmt8=conn.prepareStatement(query8);
			stmt8.setString(1, district);
			stmt8.setString(2, mandal);
			rs8=stmt8.executeQuery();
			ResultSetMetaData rsmd8=rs8.getMetaData();
			for(int i=1;i<=rsmd8.getColumnCount();i++) {
	%>
        <td><b><%=rsmd8.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs8.next()) { %>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd8.getColumnCount();i++) {	%>
       	 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs8.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}	
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Source Identification Table : "+e.getMessage());
		} finally {
			try {
				if(rs8!=null) {
					rs8.close();
				}
				if(stmt8!=null)	{
					stmt8.close();		
				}
			}
			catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Source Identification Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Circle Office tbl</b></tr>
	<tr>
	<%	try	{
		    query9="select * from RWS_circle_office_TBL where CIRCLE_OFFICE_CODE = ? ";
			stmt9=conn.prepareStatement(query9);
			stmt9.setString(1, district);
			rs9=stmt9.executeQuery();
			ResultSetMetaData rsmd9=rs9.getMetaData();
			for(int i=1;i<=rsmd9.getColumnCount();i++) {
	%>
        <td><b><%=rsmd9.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs9.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd9.getColumnCount();i++){		%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs9.getString(i))%></td>
	<%			}%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Circle Office Table : "+e.getMessage());
		} finally {
			try {
				if(rs9!=null){
					rs9.close();
				}
				if(stmt9!=null)	{
					stmt9.close();		
				}	
			}	catch(Exception o)	{
				System.out.println("The Exception is in rws_tables_gis_list_excel Circle Office Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Division Office tbl</b></tr>
	<tr>
	<% try{
    		query10="select * from RWS_division_office_TBL where CIRCLE_OFFICE_CODE= ? "; 			
			stmt10=conn.prepareStatement(query10);
			stmt10.setString(1, district);
			rs10=stmt10.executeQuery();
			ResultSetMetaData rsmd10=rs10.getMetaData();
			for(int i=1;i<=rsmd10.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd10.getColumnName(i) %></b></td>
	<%		}	%>
	</tr>
	<%		while(rs10.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd10.getColumnCount();i++){ %>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs10.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Division Office Table : "+e.getMessage());
		} finally {
			try	{		
				if(rs10!=null){
					rs10.close();
				}
				if(stmt10!=null) {
					stmt10.close();				
				}			
			}
			catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Division Office Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Sub Division Office tbl</b></tr>
	<tr>
	<%	try	{
    		query11="select * from RWS_subdivision_office_TBL where CIRCLE_OFFICE_CODE = ? "; 		
			stmt11=conn.prepareStatement(query11);	
			stmt11.setString(1, district);
			rs11=stmt11.executeQuery();
			ResultSetMetaData rsmd11=rs11.getMetaData();
			for(int i=1;i<=rsmd11.getColumnCount();i++){
	%>
        <td><b><%=rsmd11.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs11.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd11.getColumnCount();i++){%>
      	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs11.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Sub Division Office Table : "+e.getMessage());
		} finally {
			try {
				if(rs11!=null){
					rs11.close();
				}
				if(stmt11!=null){
					stmt11.close();				
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Sub Division Office Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets - Asset Type Table</b></tr>
	<tr>
	<%  try {
        	query12="select a.* from rws_asset_type_tbl a"; 	
			stmt12=conn.prepareStatement(query12);
			rs12=stmt12.executeQuery();
			ResultSetMetaData rsmd12=rs12.getMetaData();
			for(int i=1;i<=rsmd12.getColumnCount();i++)	{
	%>
        <td><b><%=rsmd12.getColumnName(i) %></b></td>
	<%		}	%>
	</tr>
	<%		while(rs12.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd12.getColumnCount();i++)	{		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs12.getString(i))%></td>
	<%			} %>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Type Table : "+e.getMessage());
		} finally {
			try {
				if(rs12!=null){
					rs12.close();
				}
				if(stmt12!=null) {
					stmt12.close();		
				}	
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Type Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets - Asset Hab Table</b></tr>
	<tr>
	<% 	try	{
    		query13="select a.* from rws_asset_hab_tbl a ,rws_complete_hab_view r,rws_asset_mast_tbl b,rws_asset_scheme_tbl s where s.asset_code=b.asset_code and b.asset_code=a.asset_code and  r.panch_code=a.hab_code and  substr(a.hab_code,1,2)= ? and substr(a.hab_code,6,2)= ? ";
			stmt13=conn.prepareStatement(query13);
			stmt13.setString(1, district);
			stmt13.setString(2, mandal);
			rs13=stmt13.executeQuery();
			ResultSetMetaData rsmd13=rs13.getMetaData();
			for(int i=1;i<=rsmd13.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd13.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs13.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd13.getColumnCount();i++)	{			%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs13.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}
		}	catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Hab Table : "+e.getMessage());
		} finally {
			try {
				if(rs13!=null){
					rs13.close();
				}
				if(stmt13!=null){
					stmt13.close();		
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Hab Table : "+o.getMessage());
			}
		}
%>
</table>
<br/>
<table border="1">
	<tr><b>Assets - Asset Master Table</b></tr>
	<tr>
	<%	try{
    		query14="select a.ASSET_CODE,a.ASSET_NAME,a.TYPE_OF_ASSET_CODE,a.HAB_CODE,a.LOCATION,a.DATE_CREATION,a.ASSET_STATUS,a.ASSET_COST,a.START_YEAR	,a.END_YEAR,a.CIRCLE_OFFICE_CODE,a.DIVISION_OFFICE_CODE	,a.SUBDIVISION_OFFICE_CODE	,a.UPDATE_DATE,a.POPU_BENEFITED	,a.PROGRAMME_CODE  from rws_asset_mast_tbl a,rws_complete_hab_view r,rws_asset_scheme_tbl s,rws_asset_hab_tbl h where h.asset_code=a.asset_code and s.asset_code=a.asset_code  and  r.panch_code=a.hab_code and  substr(a.hab_code,1,2)= ? and substr(a.hab_code,6,2)= ? "; 			
    		stmt14=conn.prepareStatement(query14);	
    		stmt14.setString(1, district);
			stmt14.setString(2, mandal);
    		rs14=stmt14.executeQuery();
			ResultSetMetaData rsmd14=rs14.getMetaData();
			for(int i=1;i<=rsmd14.getColumnCount();i++) {
	%>
   		<td><b><%=rsmd14.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs14.next()){		%>
		<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd14.getColumnCount();i++){	%>
         	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs14.getString(i))%></td>
	<%			} 	%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Master Table : "+e.getMessage());
		} finally {
			try {
				if(rs14!=null){
					rs14.close();
				}
				if(stmt14!=null){
					stmt14.close();		
				}	
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Asset Master Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets - Handpumps Table</b></tr>
	<tr>
	<%	try	{
		    query15="select a. LOCATION ,a.DRILL_YEAR, a. DIAMETER , a.CASING , a.STATUS,a.GEN_CONDITION, a.GI_NO,a. PAINTED,	a. STATIC_WL,a.SUMMER_WL,a. P_COND,	a. DRY_DURING	,a. SERVICE,a. SER_NO,a. SER_HRS,a. REPAIRS,a. PLATFORM_CONDITION	,a. DRAIN	,a. DRAIN_CONDITION,a. DRAIN_SD,	 a.DRAIN_LP	,a. HYGIENE	,a. AVG_TIME,a. P_YEILD,	a. PYEILD_LOCAL,	a. PERIOD	,a. ASSET_CODE,a. HP_CODE from rws_hp_subcomp_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hp_code,1,2)= ? and substr(a.hp_code,6,2)= ? ";			
			stmt15=conn.prepareStatement(query15);
			stmt15.setString(1, district);
			stmt15.setString(2, mandal);
			rs15=stmt15.executeQuery();
			ResultSetMetaData rsmd15=rs15.getMetaData();
			for(int i=1;i<=rsmd15.getColumnCount();i++)	{
	%>
       	<td><b><%=rsmd15.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs15.next()) { %>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd15.getColumnCount();i++)	{ %>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs15.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Handpumps Table : "+e.getMessage());
		} finally {
			try{			
				if(rs15!=null){
					rs15.close();
				}
				if(stmt15!=null){
					stmt15.close();					
				}				
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Handpumps Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Source Type Table</b></tr>
	<tr>
	<%	try	{
		    query16="select a.* from rws_source_type_tbl a";			
			stmt16=conn.prepareStatement(query16);
			rs16=stmt16.executeQuery();
			ResultSetMetaData rsmd16=rs16.getMetaData();
			for(int i=1;i<=rsmd16.getColumnCount();i++)	{
	%>
      	<td><b><%=rsmd16.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs16.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd16.getColumnCount();i++)	{	%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs16.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		}	catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Source Type Table : "+e.getMessage());
		} finally	{
			try	{
				if(rs16!=null)	{
					rs16.close();
				}
				if(stmt16!=null){
					stmt16.close();		
				}		
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Source Type Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Sub Source Type Table</b></tr>
	<tr>
	<%
		try {
		    query17="select a.* from rws_subsource_type_tbl a"; 			
			stmt17=conn.prepareStatement(query17);
			rs17=stmt17.executeQuery();
			ResultSetMetaData rsmd17=rs17.getMetaData();
			for(int i=1;i<=rsmd17.getColumnCount();i++){
	%>
       	<td><b><%=rsmd17.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs17.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd17.getColumnCount();i++)	{	%>
    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs17.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}
		}	catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Sub Source Type Table : "+e.getMessage());
		} finally {
			try	{
				if(rs17!=null){
					rs17.close();
				}
				if(stmt17!=null){
					stmt17.close();		
				}	
			}catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Sub Source Type Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Source Table</b></tr>
	<tr>
	<%	try	{
    		query18="select a.* from rws_source_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt18=conn.prepareStatement(query18);
			stmt18.setString(1, district);
			stmt18.setString(2, mandal);
			rs18=stmt18.executeQuery();
			ResultSetMetaData rsmd18=rs18.getMetaData();
			for(int i=1;i<=rsmd18.getColumnCount();i++) {
	%>
         <td><b><%=rsmd18.getColumnName(i) %></b></td>
	<%		}	%>
	</tr>
	<%		while(rs18.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd18.getColumnCount();i++)	{	%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs18.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Source Table : "+e.getMessage());
		} finally {
			try {
				if(rs18!=null){
					rs18.close();
				}
				if(stmt18!=null){
					stmt18.close();					
				}	
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Source Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets RawWater Collection Well Table </b></tr>
	<tr>
	<%	try	{
    		query19="select a.* from rws_ast_rw_collwell_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
 			stmt19=conn.prepareStatement(query19);
 			stmt19.setString(1, district);
 			stmt19.setString(2, mandal);
			rs19=stmt19.executeQuery();
			ResultSetMetaData rsmd19=rs19.getMetaData();
			for(int i=1;i<=rsmd19.getColumnCount();i++) {
	%>
         <td><b><%=rsmd19.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs19.next()) {	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd19.getColumnCount();i++)	{	%>
    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs19.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}     
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Raw Water Collection Well Table : "+e.getMessage());
		} finally {
			try	{			
			if(rs19!=null){
					rs19.close();
				}
				if(stmt19!=null){
					stmt19.close();					
				}				
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Raw Water Collection Well Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets SSTank Table</b></tr>
	<tr>
	<%	try	{
    		query20="select a.* from  rws_ast_ss_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt20=conn.prepareStatement(query20);
			stmt20.setString(1, district);
			stmt20.setString(2, mandal);
			rs20=stmt20.executeQuery();
			ResultSetMetaData rsmd20=rs20.getMetaData();
			for(int i=1;i<=rsmd20.getColumnCount();i++)	{
	%>
		<td><b><%=rsmd20.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs20.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd20.getColumnCount();i++)	{		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs20.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets SSTank Table : "+e.getMessage());
		} finally {
			try {
				if(rs20!=null){
					rs20.close();
				}
				if(stmt20!=null){
					stmt20.close();					
				}				
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets SSTank Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Filters Table</b></tr>
	<tr>
	<%	try	{
    		query21="select a.* from rws_ast_wtp_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt21=conn.prepareStatement(query21);
			stmt21.setString(1, district);
			stmt21.setString(2, mandal);
			rs21=stmt21.executeQuery();
			ResultSetMetaData rsmd21=rs21.getMetaData();
			for(int i=1;i<=rsmd21.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd21.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs21.next()){	%>
	<tr bgcolor="#ffffff">
    <%			for(int i=1;i<=rsmd21.getColumnCount();i++){		%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs21.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Filters Table : "+e.getMessage());
		} finally {
			try {
				if(rs21!=null) {
					rs21.close();
				}
				if(stmt21!=null) {
					stmt21.close();					
				}
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Filters Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Sump Table </b></tr>
	<tr>
	<% 	try{
    		query22="select a.* from  rws_ast_sump_m_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt22=conn.prepareStatement(query22);
			stmt22.setString(1, district);
			stmt22.setString(2, mandal);
			rs22=stmt22.executeQuery();
			ResultSetMetaData rsmd22=rs22.getMetaData();
			for(int i=1;i<=rsmd22.getColumnCount();i++) {
	%>
         <td><b><%=rsmd22.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs22.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd22.getColumnCount();i++){		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs22.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}	
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Sump Table : "+e.getMessage());
		} finally {
			try {
				if(rs22!=null) {
					rs22.close();
				}
				if(stmt22!=null) {
					stmt22.close();					
				}
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Sump Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Foot path Bridge Table</b></tr>
	<tr>
	<%	try	{
    		query23="select a.* from  RWS_AST_FP_BRIDGE_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt23=conn.prepareStatement(query23);
			stmt23.setString(1, district);
			stmt23.setString(2, mandal);
			rs23=stmt23.executeQuery();
			ResultSetMetaData rsmd23=rs23.getMetaData();
			for(int i=1;i<=rsmd23.getColumnCount();i++) {
	%>
         <td><b><%=rsmd23.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs23.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd23.getColumnCount();i++){	%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs23.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		}	catch(Exception e)	{
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Foot path Bridge Table : "+e.getMessage());
		} finally {
			try {
				if(rs23!=null){
					rs23.close();
				}
				if(stmt23!=null){
					stmt23.close();					
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Foot path Bridge Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets PumpHouse Table</b></tr>
	<tr>
	<%	try {
    		query24="select a.* from rws_ast_pumphouse_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt24=conn.prepareStatement(query24);
			stmt24.setString(1, district);
			stmt24.setString(2, mandal);
			rs24=stmt24.executeQuery();
			ResultSetMetaData rsmd24=rs24.getMetaData();
			for(int i=1;i<=rsmd24.getColumnCount();i++) {
	%>
         <td><b><%=rsmd24.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs24.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd24.getColumnCount();i++){	%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs24.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		}catch(Exception e)	{
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets PumpHouse Table : "+e.getMessage());
		}
		finally	{
			try	{		
				if(rs24!=null){
					rs24.close();
				}
				if(stmt24!=null){
					stmt24.close();				
				}		
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets PumpHouse Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Watchman Quarter Table</b></tr>
	<tr>
	<%	try	{
    		query25="select a.* from RWS_AST_WATCHMAN_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt25=conn.prepareStatement(query25);
			stmt25.setString(1, district);
			stmt25.setString(2, mandal);
			rs25=stmt25.executeQuery();
			ResultSetMetaData rsmd25=rs25.getMetaData();
			for(int i=1;i<=rsmd25.getColumnCount();i++)	{
	%>
       <td><b><%=rsmd25.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs25.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd25.getColumnCount();i++){		%>
       	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs25.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}	%>
	<%	}catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Watchman Quarter Table : "+e.getMessage());
		} finally {
			try {
				if(rs25!=null){
					rs25.close();
				}
				if(stmt25!=null){
					stmt25.close();					
				}	
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Watchman Quarter Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Clear Water Collection Well Table</b></tr>
	<tr>
	<%	try	{
    		query26="select a.* from rws_ast_cw_collwell_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt26=conn.prepareStatement(query26);
			stmt26.setString(1, district);
			stmt26.setString(2, mandal);
			rs26=stmt26.executeQuery();
			ResultSetMetaData rsmd26=rs26.getMetaData();
			for(int i=1;i<=rsmd26.getColumnCount();i++)	{
	%>
        <td><b><%=rsmd26.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs26.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd26.getColumnCount();i++)	{		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs26.getString(i))%></td>
	<%			}		%>
	</tr>
	<%		}	
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Clear Water Collection Well Table : "+e.getMessage());
		} finally {
			try {
				if(rs26!=null) {
					rs26.close();
				}
				if(stmt26!=null){
					stmt26.close();					
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Clear Water Collection Well Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets PumpingMain Table</b></tr>
	<tr>
	<%	try	{
    		query27="select a.* from  RWS_AST_PUMPINGMAIN_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt27=conn.prepareStatement(query27);	
			stmt27.setString(1, district);
			stmt27.setString(2, mandal);
			rs27=stmt27.executeQuery();
			ResultSetMetaData rsmd27=rs27.getMetaData();
			for(int i=1;i<=rsmd27.getColumnCount();i++){
	%>
          <td><b><%=rsmd27.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs27.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd27.getColumnCount();i++)	{			%>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs27.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets PumpingMain Table : "+e.getMessage());
		} finally {
			try {
				if(rs27!=null){
					rs27.close();
				}
				if(stmt27!=null){
					stmt27.close();		
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets PumpingMain Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Gravity Main Table</b></tr>
	<tr>
	<%	try {
    		query28="select a.* from  RWS_AST_GRAVITYMAIN_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt28=conn.prepareStatement(query28);
			stmt28.setString(1, district);
			stmt28.setString(2, mandal);
			rs28=stmt28.executeQuery();
			ResultSetMetaData rsmd28=rs28.getMetaData();
			for(int i=1;i<=rsmd28.getColumnCount();i++){
	%>
        <td><b><%=rsmd28.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs28.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd28.getColumnCount();i++){			%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs28.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Gravity Main Table : "+e.getMessage());
		} finally {
			try	{				
				if(rs28!=null){
					rs28.close();
				}
				if(stmt28!=null){
					stmt28.close();						
				}					
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Gravity Main Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Distribution Table </b></tr>
	<tr>
	<%	try	{
    		query29="select a.* from  RWS_AST_DISTRI_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt29=conn.prepareStatement(query29);
			stmt29.setString(1, district);
			stmt29.setString(2, mandal);
			rs29=stmt29.executeQuery();
			ResultSetMetaData rsmd29=rs29.getMetaData();
			for(int i=1;i<=rsmd29.getColumnCount();i++){
	%>
    <td><b><%=rsmd29.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs29.next()) {		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd29.getColumnCount();i++){	%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs29.getString(i))%></td>
	<%			}	%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Distribution Table : "+e.getMessage());
		} 
		finally {
			try {
				if(rs29!=null){
					rs29.close();
				}
				if(stmt29!=null){
					stmt29.close();		
				}	
			}
			catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Distribution Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Bpt Table</b></tr>
	<tr>
	<%	try	{
    		query30="select a.* from RWS_AST_BPT_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt30=conn.prepareStatement(query30);
			stmt30.setString(1, district);
			stmt30.setString(2, mandal);
			rs30=stmt30.executeQuery();
			ResultSetMetaData rsmd30=rs30.getMetaData();
			for(int i=1;i<=rsmd30.getColumnCount();i++)	{
	%>
        <td><b><%=rsmd30.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs30.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd30.getColumnCount();i++){	%>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs30.getString(i))%></td>
	<%			}			%>
	</tr>
	<%			}	%>
	<%		} catch(Exception e) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Bpt Table : "+e.getMessage());
			} finally {
				try {
					if(rs30!=null) {
						rs30.close();
					}
					if(stmt30!=null) {
						stmt30.close();						
					}
				} catch(Exception o) {
					System.out.println("The Exception is in rws_tables_gis_list_excel Assets Bpt Table : "+o.getMessage());
				}
			}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets GLBR Table </b></tr>
	<tr>
	<%	try {
    		query31="select a.* from  rws_ast_glbr_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt31=conn.prepareStatement(query31);
			stmt31.setString(1, district);
			stmt31.setString(2, mandal);
			rs31=stmt31.executeQuery();
			ResultSetMetaData rsmd31=rs31.getMetaData();
			for(int i=1;i<=rsmd31.getColumnCount();i++)	{
	%>
        <td><b><%=rsmd31.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs31.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd31.getColumnCount();i++)	{			%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs31.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets GLBR Table : "+e.getMessage());
		} finally {
			try {
				if(rs31!=null){
					rs31.close();
				}
				if(stmt31!=null){
					stmt31.close();					
				}
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets GLBR Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets GLSR Table</b></tr>
	<tr>
	<%	try	{
    		query32="select a.* from rws_ast_glsr_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt32=conn.prepareStatement(query32);	
			stmt32.setString(1, district);
			stmt32.setString(2, mandal);
			rs32=stmt32.executeQuery();
			ResultSetMetaData rsmd32=rs32.getMetaData();
			for(int i=1;i<=rsmd32.getColumnCount();i++)	{
	%>
        <td><b><%=rsmd32.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs32.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd32.getColumnCount();i++)	{			%>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs32.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		}catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets GLSR Table : "+e.getMessage());
		}
		finally {
			try{
				if(rs32!=null){
					rs32.close();
				}
				if(stmt32!=null){
					stmt32.close();					
				}	
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets GLSR Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets OHBR Table</b></tr>
	<tr>
	<% 	try	{
   	 		query33="select a.* from  rws_ast_ohbr_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt33=conn.prepareStatement(query33);
			stmt33.setString(1, district);
			stmt33.setString(2, mandal);
			rs33=stmt33.executeQuery();
			ResultSetMetaData rsmd33=rs33.getMetaData();
			for(int i=1;i<=rsmd33.getColumnCount();i++)	{
	%>
       <td><b><%=rsmd33.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs33.next()){	%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd33.getColumnCount();i++){			%>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs33.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}	
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets OHBR Table : "+e.getMessage());
		}
		finally {
			try {
				if(rs33!=null){
					rs33.close();
				}
				if(stmt33!=null){
					stmt33.close();		
				}	
			} catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets OHBR Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets OHSR Table</b></tr>
	<tr>
	<%	try	{
    		query34="select a.* from  rws_ast_ohsr_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt34=conn.prepareStatement(query34);
			stmt34.setString(1, district);
			stmt34.setString(2, mandal);
			rs34=stmt34.executeQuery();
			ResultSetMetaData rsmd34=rs34.getMetaData();
			for(int i=1;i<=rsmd34.getColumnCount();i++)	{
	%>
    	<td><b><%=rsmd34.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs34.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd34.getColumnCount();i++)	{			%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs34.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}	
		}
		catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets OHSR Table : "+e.getMessage());
		}
		finally {
			try{
				if(rs34!=null){
					rs34.close();
				}
				if(stmt34!=null){
					stmt34.close();		
				}
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets OHSR Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Cisterns Table</b></tr>
	<tr>
	<%	try	{
    		query35="select a.* from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt35=conn.prepareStatement(query35);
			stmt35.setString(1, district);
			stmt35.setString(2, mandal);
			rs35=stmt35.executeQuery();
			ResultSetMetaData rsmd35=rs35.getMetaData();
			for(int i=1;i<=rsmd35.getColumnCount();i++)	{
	%>
       <td><b><%=rsmd35.getColumnName(i) %></b></td>
	<%			}			%>
	</tr>
	<%		while(rs35.next())	{			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd35.getColumnCount();i++)	{			%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs35.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}	
		}
		catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Cisterns Table : "+e.getMessage());
		}
		finally	{
			try	{		
				if(rs35!=null)	{
					rs35.close();
				}
				if(stmt35!=null){
					stmt35.close();				
				}			
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Cisterns Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Chlorination Table</b></tr>
	<tr>
	<%	try	{
    		query36="select a.* from  rws_ast_chlorination_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt36=conn.prepareStatement(query36);		
			stmt36.setString(1, district);
			stmt36.setString(2, mandal);
			rs36=stmt36.executeQuery();
			ResultSetMetaData rsmd36=rs36.getMetaData();
			for(int i=1;i<=rsmd36.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd36.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs36.next()){		%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd36.getColumnCount();i++)	{		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs36.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Chlorination Table : "+e.getMessage());
		}
		finally {
			try {
				if(rs36!=null) {
					rs36.close();
				}
				if(stmt36!=null){
					stmt36.close();		
				}	
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Chlorination Table : "+o.getMessage());
			}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets OandM Table</b></tr>
	<tr>
	<% 	try	{
   			query37="select a.* from  rws_ast_oandm_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.asset_code,5,2)= ? and substr(b.hab_code,6,2)= ? ";
			stmt37=conn.prepareStatement(query37);
    		stmt37.setString(1, district);
			stmt37.setString(2, mandal);
			rs37=stmt37.executeQuery();
			ResultSetMetaData rsmd37=rs37.getMetaData();
			for(int i=1;i<=rsmd37.getColumnCount();i++){
	%>
         <td><b><%=rsmd37.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs37.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd37.getColumnCount();i++)	{			%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs37.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets OandM Table : "+e.getMessage());
		}
		finally {
			try {
				if(rs37!=null){
					rs37.close();
				}
				if(stmt37!=null){
					stmt37.close();					
				}	
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets OandM Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Pumpsets Table</b></tr>
	<tr>
	<%	try {
    		query38="select a.* from  rws_ast_subcomp_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)= ? and  substr(a.hab_code,6,2)= ? ";
			stmt38=conn.prepareStatement(query38);
			stmt38.setString(1, district);
			stmt38.setString(2, mandal);
			rs38=stmt38.executeQuery();
			ResultSetMetaData rsmd38=rs38.getMetaData();
			for(int i=1;i<=rsmd38.getColumnCount();i++)	{
	%>
          <td><b><%=rsmd38.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs38.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd38.getColumnCount();i++){			%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs38.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e) {
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Pumpsets Table : "+e.getMessage());
		} finally {
			try {
				if(rs38!=null){
					rs38.close();
				}
				if(stmt38!=null){
					stmt38.close();					
				}				
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Pumpsets Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Open Well Master Table</b></tr>
	<tr>
	<%	try	{
    		query39="select a.* from  RWS_OPEN_WELL_MAST_TBL a where substr(a.habitation_code,1,2)= ? and substr(a.habitation_code,6,2)= ? ";
			stmt39=conn.prepareStatement(query39);			
			stmt39.setString(1, district);
			stmt39.setString(2, mandal);
			rs39=stmt39.executeQuery();
			ResultSetMetaData rsmd39=rs39.getMetaData();
			for(int i=1;i<=rsmd39.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd39.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs39.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd39.getColumnCount();i++)	{			%>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs39.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		}
		catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Open Well Master Table : "+e.getMessage());
		}
		finally	{
			try	{		
				if(rs39!=null){
					rs39.close();
				}
				if(stmt39!=null){
					stmt39.close();				
				}			
			} catch(Exception o) {
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Open Well Master Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Open Well Table</b></tr>
	<tr>
	<%	try	{
	    	query40="select a.* from  RWS_OPENWELL_POND_TBL a where substr(a.hab_code,1,2)= ? and substr(a.hab_code,6,2)= ? ";		
			stmt40=conn.prepareStatement(query40);		        
			stmt40.setString(1, district);
			stmt40.setString(2, mandal);
			rs40=stmt40.executeQuery();
			ResultSetMetaData rsmd40=rs40.getMetaData();
			for(int i=1;i<=rsmd40.getColumnCount();i++){
	%>
		<td><b><%=rsmd40.getColumnName(i) %></b></td>
	<%		}			%>
	</tr>
	<%		while(rs40.next()){				%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd40.getColumnCount();i++)	{			%>
	     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs40.getString(i))%></td>
	<%			}				%>
	</tr>
	<%		}	
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Open Well Table : "+e.getMessage());
		}
		finally{
			try{			
				if(rs40!=null){
					rs40.close();
				}
				if(stmt40!=null){
					stmt40.close();			
				}			
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Open Well Table : "+o.getMessage());
			}
		}
	%>
</table>
<br/>
<table border="1">
	<tr><b>Assets Shallow Handpumps Table</b></tr>
	<tr>
	<%	try	{
    		query41="select a.* from  rws_shallowhandpumps_tbl a where substr(a.hab_code,1,2)= ? and substr(a.hab_code,6,2)= ? ";
			stmt41=conn.prepareStatement(query41);
			stmt41.setString(1, district);
			stmt41.setString(2, mandal);
			rs41=stmt41.executeQuery();
			ResultSetMetaData rsmd41=rs41.getMetaData();
			for(int i=1;i<=rsmd41.getColumnCount();i++)	{
	%>
         <td><b><%=rsmd41.getColumnName(i) %></b></td>
	<%		}		%>
	</tr>
	<%		while(rs41.next()){			%>
	<tr bgcolor="#ffffff">
	<%			for(int i=1;i<=rsmd41.getColumnCount();i++)	{		%>
         <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs41.getString(i))%></td>
	<%			}			%>
	</tr>
	<%		}
		} catch(Exception e){
			System.out.println("The Exception is in rws_tables_gis_list_excel Assets Shallow Handpumps Table : "+e.getMessage());
		}
		finally	{
			try	{			
				if(rs41!=null){
					rs41.close();
				}
				if(stmt41!=null){
					stmt41.close();					
				}				
			}
			catch(Exception o){
				System.out.println("The Exception is in rws_tables_gis_list_excel Assets Shallow Handpumps Table : "+o.getMessage());
			}
		}
		}
	%>
</table>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

