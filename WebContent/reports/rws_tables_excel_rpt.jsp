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
	PreparedStatement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	String dist="";
	String tab="";
	dist=request.getParameter("habresult");
	String dcode="";
	String query21="";
	String query23="";
	String query22="";
	dcode=request.getParameter("district");
	if(dist.equals("dist")){
		tab="rws_district_tbl";
	}
	else if(dist.equals("habstatus")) {
		tab="rws_hab_supply_status_tbl";
	}
	else if(dist.equals("workcompletion")){
		tab="rws_work_completion_tbl";
	}
	else if(dist.equals("man")){
		tab="rws_mandal_tbl";
	}
	else if(dist.equals("panraj")){
		tab="rws_panchayat_raj_tbl";
	}
	else if(dist.equals("habitation")){
		tab="rws_habitation_directory_tbl";
	}
	else if(dist.equals("assethandpump")){
		tab="rws_hp_subcomp_param_tbl";
	}
	else if(dist.equals("admn")){
		tab="rws_work_admn_tbl";
	}
	else if(dist.equals("workexpenditure")){
		tab="rws_work_expenditure_tbl";
	}
	else if(dist.equals("workcategory")){
		tab="rws_work_category_tbl";
	}
	else if(dist.equals("condet")){
		tab="RWS_CONTRACTOR_TBL";
	}
	else if(dist.equals("admnhablnk")){
		tab="RWS_ADMN_HAB_LNK_TBL";
	}
	else if(dist.equals("workcommencement")){
		tab="rws_work_commencement_tbl";
	}
	else if(dist.equals("workexpenditureprevious")){
		tab="rws_work_exp_upto_pre_year_tbl";
	}
	else if(dist.equals("assethab")){
		tab="rws_asset_hab_tbl";
	}
	else if(dist.equals("assetmast")){
		tab="rws_asset_mast_tbl";
	}
	else if(dist.equals("assetscheme")){
		tab="rws_asset_scheme_tbl";
	}
	else if(dist.equals("source")){
		tab="rws_source_tbl";
	}
	else if(dist.equals("rw")){
		tab="rws_ast_rw_collwell_param_tbl";
	}
	else if(dist.equals("cw")){
		tab="rws_ast_cw_collwell_param_tbl";
	}
	else if(dist.equals("glbr")){
		tab="rws_ast_glbr_sc_param_tbl";
	}
	else if(dist.equals("glsr")){
		tab="rws_ast_glsr_sc_param_tbl";
	}
	else if(dist.equals("ohsr")){
		tab="rws_ast_ohsr_sc_param_tbl";
	}
	else if(dist.equals("ohbr")){
		tab="rws_ast_ohbr_sc_param_tbl";
	}
	else if(dist.equals("sstank")){
		tab="rws_ast_ss_sc_param_tbl";
	}
	else if(dist.equals("filters")){
		tab="rws_at_wtp_sc_param_tbl";
	}
	else if(dist.equals("sump")){
		tab="rws_ast_sump_m_sc_param_tbl";
	}
	else if(dist.equals("cis")){
		tab="rws_ast_cis_sc_param_tbl";
	}
	else if(dist.equals("other")){
		tab="rws_ast_others_param_tbl";
	}
	else if(dist.equals("cl")){
		tab="rws_ast_chlorination_tbl";
	}
	else if(dist.equals("oandm")){
		tab="rws_ast_oandm_param_tbl";
	}
	else if(dist.equals("pumpset")){
		tab="rws_ast_subcomp_param_tbl";
	}
	else if(dist.equals("watersample")){
		tab="rws_water_sample_collect_tbl";
	}
	else if(dist.equals("ftk")){
		tab="rws_ftk_testing_tbl";
	}
	else if(dist.equals("imis")){
		tab="rws_complete_hab_view";
	}
	else if(dist.equals("projshelf")){
		tab="rws_work_admn_tbl";
	}
	else if(dist.equals("techsan")){
		tab="RWS_NEW_EST_TBL";
	}
	else if(dist.equals("sourceiden")){
		tab="RWS_SOURCE_IDEN_FIN_TBL  ";
	}
	else if(dist.equals("tender")){
		tab="rws_contractor_selection_tbl";
	}
	else if(dist.equals("parameter")){
		tab="RWS_WQ_PARA_TEST_TBL";
	}
	else if(dist.equals("schoolmast")){
		tab="rws_school_master_tbl";
	}
	else if(dist.equals("schoolimis")){
		tab="RWS_DDWS_SCHOOLS_MPR_TBL";
	}
	else if(dist.equals("schoolcategory")){
		tab="rws_school_category_tbl";
	}
	else if(dist.equals("assetprojshelf")){
		tab="rws_asset_mast_tbl";
	}
	else if(dist.equals("bpt")){
		tab="RWS_AST_BPT_PARAM_TBL";
	}
	else if(dist.equals("bpt")){
		tab="RWS_AST_BPT_PARAM_TBL";
	}
	else if(dist.equals("dis")){
		tab="rws_ast_distri_sc_param_tbl";
	}
	else if(dist.equals("gravity")){
		tab="RWS_AST_GRAVITYMAIN_TBL";
	}
	else if(dist.equals("pumpingmain")){
		tab="RWS_AST_PUMPINGMAIN_TBL";
	}
	else if(dist.equals("watch")){
		tab="RWS_AST_WATCHMAN_PARAM_TBL";
	}
	else if(dist.equals("fp")){
		tab="RWS_AST_FP_BRIDGE_PARAM_TBL";
	}
	else if(dist.equals("pumphouse")){
		tab="rws_ast_pumphouse_param_tbl";
	}
	else if(dist.equals("filter")){
		tab="rws_ast_wtp_sc_param_tbl";
	}
	else if(dist.equals("watertest")){
		tab="RWS_WQ_TEST_RESULTS_TBL";
	}
	else if(dist.equals("waterlab")){
		tab="RWS_WATER_QUALITY_LAB_TBL";
	}
%>
<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
<%
	try {
		if(dist.equals("pan")) {
			query21="select distinct p.dcode,p.mcode,p.pcode,p.pname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v,rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and substr(h.hab_code,1,2)=p.dcode and substr (h.hab_code,6,2)=p.mcode and substr (h.hab_code,13,2)=p.pcode and substr (h.hab_code,8,3)=v.vcode and coverage_status<>'UI' and coverage_status is not null and pr.panch_code=h.hab_code order by p.dcode";
			stmt3=conn.prepareStatement(query21);
			rs1=stmt3.executeQuery();
%>
<tr>
	<td>DCODE</td>
	<td>MCODE</td>
	<td>PCODE</td>
	<td>PNAME</td>
</tr>
<%		while(rs1.next()){ %>
<tr>
	<td><%=rs1.getString(1)%></td>
	<td><%=rs1.getString(2)%></td>
	<td><%=rs1.getString(3)%></td>
	<td><%=rs1.getString(4)%></td>
</tr>
<%			}
		}
	} catch(Exception o) {
		System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+o.getMessage());
	}
	finally {
		try{
			if(rs1!=null){
				rs1.close();
			}
			if(stmt3!=null){
				stmt3.close();
			}
		}catch(Exception r){
			System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+r.getMessage());
		}
	}
	try {
		if(dist.equals("vil")) {
			query23="select distinct v.dcode,v.mcode,v.pcode,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v,rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and substr(h.hab_code,1,2)=p.dcode and substr (h.hab_code,6,2)=p.mcode and substr (h.hab_code,13,2)=p.pcode and substr (h.hab_code,8,3)=v.vcode and coverage_status<>'UI' and coverage_status is not null and pr.panch_code=h.hab_code order by v.dcode"; 
			stmt4=conn.prepareStatement(query23);
			rs4=stmt4.executeQuery();
%>
<tr>
	<td>DCODE</td>
	<td>MCODE</td>
	<td>PCODE</td>
	<td>VCODE</td>
	<td>VNAME</td>
</tr>
<%			while(rs4.next()){ %>
<tr>
	<td><%=rs4.getString(1)%></td>
	<td><%=rs4.getString(2)%></td>
	<td><%=rs4.getString(3)%></td>
	<td><%=rs4.getString(4)%></td>
	<td><%=rs4.getString(5)%></td>
</tr>
<%			}
		}
	}catch(Exception o){
		System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+o.getMessage());
	}
	finally {
		try {
			if(rs4!=null){
				rs4.close();
			}
			if(stmt4!=null){
				stmt4.close();
			}
		}catch(Exception r) {
			System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+r.getMessage());
		}
	}
%>
<tr>
<%
	try	{
		query22="select a.* from "+tab+" a ";			
		if(dist.equals("watersample")   ){
	  	    query22 += ",rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'";
	     }
		if(dist.equals("habitation")){
	  	    query22 += ",rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'";
		}
		if(dist.equals("habstatus")){
	  	    query22 += ",rws_complete_hab_view b where a.hab_code=b.panch_code and substr(a.hab_code,1,2)='"+dcode+"'";
		}
    	else if(dist.equals("assethandpump")) {
        	query22+=",rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hp_code,1,2)='"+dcode+"'";
      	}
    	else if(dist.equals("panraj")){
       		query22+=",rws_complete_hab_view b where a.panch_code=b.panch_code and substr(a.panch_code,1,2)='"+dcode+"'";
      	}
    	else if(dist.equals("dist")) {
       		query22+="where dcode<>'16'";
       	}
     	else if(dist.equals("imis")){
         	query22+="where substr(panch_code,1,2)='"+dcode+"'";
        }
	 	else if(dist.equals("admn")){
	        query22 += " where substr(a.work_id,5,2)='"+dcode+"'";
        }
     	else if(dist.equals("workcompletion")){
          	query22+= ",rws_work_admn_tbl w where w.work_id=a.work_id and substr(a.work_id,5,2)='"+dcode+"' ";
        } 
    	else if(dist.equals("workexpenditure")){
          	query22+=",rws_work_admn_tbl w where w.work_id=a.work_id and substr(a.work_id,5,2)='"+dcode+"'";
         } 
		else if(dist.equals("assethab")){
	        query22 += " ,rws_complete_hab_view r,rws_asset_mast_tbl b,rws_asset_scheme_tbl s where s.asset_code=b.asset_code and b.asset_code=a.asset_code and   r.panch_code=a.hab_code and  substr(a.hab_code,1,2)='"+dcode+"'";
       	}
    	else if(dist.equals("assetmast")){
        	query22+=",rws_complete_hab_view r,rws_asset_scheme_tbl s,rws_asset_hab_tbl h where h.asset_code=a.asset_code and s.asset_code=a.asset_code  and   r.panch_code=a.hab_code and  substr(a.hab_code,1,2)='"+dcode+"'";
        }
	 	else if(dist.equals("assetscheme")){
	        query22 += " ,rws_complete_hab_view r,rws_asset_mast_tbl b,rws_asset_hab_tbl h where h.asset_code=b.asset_code and  b.asset_code=a.asset_code and  r.panch_code=substr(a.scheme_code,1,16) and substr(a.scheme_code,1,2)='"+dcode+"'";
        }	       
     	else if(dist.equals("workexpenditureprevious")){
          	query22+=" ,rws_work_admn_tbl w where a.work_id=w.work_id ";
        }          
     	else if(dist.equals("sourceiden")){
         	query22+=" ,rws_work_admn_tbl w where a.work_id=w.work_id and substr(a.work_id,5,2)='"+dcode+"'  ";
        }
     	else if(dist.equals("techsan")){
          	query22+=" ,rws_work_admn_tbl w where a.work_id=w.work_id and substr(w.work_id,5,2)='"+dcode+"' ";
        }
    	else if(dist.equals("workcommencement")){
        	query22+=",rws_work_admn_tbl w where w.work_id=a.work_id and substr(w.work_id,5,2)='"+dcode+"'";
        } 
     	else if(dist.equals("tender")){
         	query22+=",rws_work_admn_tbl w where w.work_id=a.work_id and substr(a.work_id,5,2)='"+dcode+"'";
        }           
    	else if(dist.equals("projshelf")){
          	query22+=",rws_ddws_scheme_data_port r where  r.work_id=a.work_id and r.work_asset='W' and substr(a.work_id,5,2)='"+dcode+"'";
        }	
    	else if(dist.equals("ftk")){
         	query22+=",rws_complete_hab_view r where substr(source_code,1,16)=r.panch_code and substr(a.source_code,1,2)='"+dcode+"' ";
        }
    	else if(dist.equals("parameter")){
          	query22+=",rws_water_sample_collect_tbl r,rws_complete_hab_view p,rws_test_results_lnk_tbl l,rws_test_results_tbl r where r.test_id=l.test_id and r.test_id=p.test_id and l.test_id=p.test_id and p.panch_code=r.hab_code and substr(p.panch_code,1,2)='"+dcode+"' ";
        }
    	else if(dist.equals("schoolmast")){
          	query22+=",rws_complete_hab_view r where r.panch_code=a.hab_code and substr(a.hab_code,1,2)='"+dcode+"'";
        }          
    	else if(dist.equals("schoolimis")){
          	query22+=",rws_school_master_tbl r where r.hab_code=a.hab_code and substr(a.work_id,5,2)='"+dcode+"'   ";
        }
   		else if(dist.equals("assetprojshelf")){
			query22+=",rws_ddws_scheme_data_port r where r.work_id=a.asset_code and r.work_asset='A' and substr(a.hab_code,1,2)='"+dcode+"'";
		}
  		else if(dist.equals("rw") || dist.equals("cw") || dist.equals("ohsr") || dist.equals("ohbr") || dist.equals("glbr") || dist.equals("glsr") || dist.equals("sstank") || dist.equals("filter") || dist.equals("source") || dist.equals("sump") || dist.equals("fp") || dist.equals("pumphouse") || dist.equals("watch") || dist.equals("pumpingmain") || dist.equals("gravity") || dist.equals("dis")|| dist.equals("bpt") || dist.equals("bpt") || dist.equals("cis")  || dist.equals("other")  || dist.equals("pumpset") || dist.equals("cl")){
        	query22+=",rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.hab_code,1,2)='"+dcode+"'";
		}
 		else if(dist.equals("oandm")){
 			query22+=",rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where r.panch_code=b.hab_code and b.asset_code=s.asset_code and a.asset_code=b.asset_code and substr(a.asset_code,5,2)='"+dcode+"'";
		}
		else if(dist.equals("watertest")){
    		query22+=",rws_water_sample_collect_tbl r,rws_complete_hab_view p where p.panch_code=substr(r.source_code,1,16) and  r.test_id=a.test_id and substr(a.source_code,1,2)='"+dcode+"'";
		}
			stmt2=conn.prepareStatement(query22);
			rs2=stmt2.executeQuery();
			ResultSetMetaData rsmd=rs2.getMetaData();
			for(int i=1;i<=rsmd.getColumnCount();i++)	{
%>
	<td><%=rsmd.getColumnName(i) %></td>
<%			} %>
</tr>
<%		while(rs2.next()){	%>
<tr bgcolor="#ffffff">
<%			for(int i=1;i<=rsmd.getColumnCount();i++) {			%>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=isNull(rs2.getString(i))%></td>
<%			} %>
</tr>
<%		}			
	}catch(Exception e){
		System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+e.getMessage());
	} finally {
		try {
			if(rs2!=null){
				rs2.close();
			}
			if(stmt2!=null){
				stmt2.close();		
			}	
		}catch(Exception o){
			System.out.println("The Exception is in rws_tables_excel_rpt.jsp : "+o.getMessage());
		}
	}
%>
</table>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>