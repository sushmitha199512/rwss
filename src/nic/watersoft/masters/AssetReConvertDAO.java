package nic.watersoft.masters;


import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.works.WorksData1;


public class AssetReConvertDAO {
	private DataSource dataSource = null;
	private Connection conn = null;
	// private Connection conn1 = null;
	private Statement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private LabelValueBean labelValueBean = null;
	private RwsLocationBean rwsLocation = null;
	
	
	private Statement stmt = null;
	private ResultSet rs = null;
	
	
	
	
	public ArrayList getAssets(String habCode) throws Exception {
		ArrayList assets = new ArrayList();
		try {
				conn = RwsOffices.getConn();
				query = " SELECT asset_code,asset_name from preduser.rws_asset_mast_tbl where hab_code='"+habCode+"'";
	
				
				 System.out.println("query in getAssets is "+query);
				ps = conn.prepareStatement(query);
	
				rset = ps.executeQuery();
				// rset = stat.executeQuery(query);
	
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - "
							+ rset.getString(1));
					assets.add(labelValueBean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				
			}
	
			return assets;
		}

		public ArrayList getDistricts() throws Exception { 
			ArrayList dists = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				query = " SELECT dcode, dname FROM preduser.rws_district_tbl where dcode='22' ORDER BY dcode,dname";
				ps = conn.prepareStatement(query);	
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
					dists.add(labelValueBean);
				}
			} catch (Exception e) {
				System.out.println("The Exception in AssetReConvertDAO getDistricts is "+e);
			} 
			return dists;
		}
		
		public ArrayList getDistrictMandals1(String dcode) throws Exception {
			ArrayList mandals = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				if(dcode.equals("04")){
					query = "SELECT mcode, mname FROM rws_mandal_tbl where dcode=? AND MCODE IN('61','62','63','64') ORDER BY mname";
				}
				else if(dcode.equals("05")){
					query = "SELECT mcode, mname FROM rws_mandal_tbl where dcode=? AND MCODE IN('47','48') ORDER BY mname";					
				}				
				ps = conn.prepareStatement(query);
				ps.setString(1, dcode);
				rset = ps.executeQuery();	
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
					mandals.add(labelValueBean);
				}
			} catch (Exception e) {
				System.out.println("The Exception in AssetReConvertDAO getDistrictMandals1 is "+e.getMessage());	
			} 
			return mandals;
		}		

		public ArrayList getPanchayats1(String dcode, String mcode) throws Exception {
			ArrayList panchayats = new ArrayList();
			try {
					conn = RwsOffices.getConn();
					query = "SELECT pcode, pname FROM rws_panchayat_tbl where dcode=? and mcode=? ORDER BY pname";
					ps = conn.prepareStatement(query);
					ps.setString(1, dcode);
					ps.setString(2, mcode);
					rset = ps.executeQuery();
					while (rset.next()) {
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue(rset.getString(1));
						labelValueBean.setLabel(rset.getString(2));
						labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
						panchayats.add(labelValueBean);
					}
				} catch (Exception e) {
					 System.out.println("The Exception in AssetReConvertDAO getPanchayats1 is "+e.getMessage());
				} 
				return panchayats;
			}	
		
		public ArrayList getVillages1(String dcode, String mcode, String pcode) throws Exception {
			ArrayList villages = new ArrayList();
			try {
					conn = RwsOffices.getConn();
					query = " SELECT vcode, vname FROM rws_village_tbl where dcode=? and mcode=? and pcode=? ORDER BY vname";			
					ps = conn.prepareStatement(query);
					ps.setString(1, dcode);
					ps.setString(2, mcode);
					ps.setString(3, pcode);			
					rset = ps.executeQuery();
					while (rset.next()) {
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue(rset.getString(1));
						labelValueBean.setLabel(rset.getString(2));
						labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
						villages.add(labelValueBean);
					}
			} catch (Exception e) {
				System.out.println("The Exception in AssetReConvertDAO getVillages1 is "+ e.getMessage());
			} 
			return villages;
		}
		
		public  ArrayList getNewHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception{
			ArrayList habs=new ArrayList();			  
			String query="";
			try	{
				conn = RwsOffices.getConn();
				query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_directory_tbl b WHERE a.panch_code=b.hab_code and b.coverage_status <> 'UI' and " +
				" SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? ";
				ps = conn.prepareStatement(query);
				ps.setString(1, dcode);
				ps.setString(2, mcode);
				ps.setString(3, pcode);
				ps.setString(4, vcode);
				rs =ps.executeQuery();
				while ( rs.next() ) {
					rwsLocation = new RwsLocationBean();
					rwsLocation.setHabitationCode(rs.getString(1));
					rwsLocation.setHabCode(rs.getString(2));
					rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
					rwsLocation.setPanchayatName(rs.getString(3));
					habs.add(rwsLocation);					
				}
			}
			catch (Exception e){
				System.out.println("The Exception in AssetReConvertDAO getNewHabitations is "+ e.getMessage());
			}
			
			return habs;
		}	
		
		
		
	public ArrayList getDistricts1() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname FROM aprwssuser.rws_district_tbl where dcode in('04','05') ORDER BY dcode,dname";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			 System.out.println("The Exception in AssetReConvertDAO getDistricts1 is "+ e.getMessage());
		} 
		return dists;
	}
	
	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {			
			conn = RwsOffices.getConn();
			query = "SELECT mcode, mname FROM preduser.rws_mandal_tbl where dcode=? AND MCODE IN('09','10','11','12','13','14','15') ORDER BY mname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			 System.out.println("The Exception in AssetReConvertDAO getCircles is "+e.getMessage());
		} 
		return dists;
	}
	
	public ArrayList getPanchayats(String dcode,String mcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT pcode, pname FROM preduser.rws_panchayat_tbl where dcode=? and mcode=?" + " ORDER BY pname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2,mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception in AssetReConvertDAO getPanchayats is "+e.getMessage());
		} 
		return dists;
	}
	
	
	public ArrayList getVillages(String dcode,String mcode,String pcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {			
			conn = RwsOffices.getConn();			
			query = " SELECT vcode, vname FROM preduser.rws_village_tbl where dcode=? and mcode=? and pcode=? ORDER BY vname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception in AssetReConvertDAO getVillages is "+e.getMessage());
		} 
		return dists;
	}
		
	public ArrayList getUIHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM preduser.RWS_PANCHAYAT_RAJ_TBL a,preduser.rws_habitation_directory_tbl b WHERE a.panch_code=b.hab_code and b.coverage_status <> 'UI' and " +
			" SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND " +
			"SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rs =ps.executeQuery();	
			while ( rs.next() ){
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
				rwsLocation.setPanchayatName(rs.getString(3));
				dists.add(rwsLocation);				
			}
		}
		catch (Exception e){
			System.out.println("The Exception in AssetReConvertDAO getUIHabitations ="+e.getMessage());
		}
		return dists;
	}
	
	public String covertOldHabToNewHab(AssetReconvertionForm frm ,HttpServletRequest request){
		ArrayList returnList = new ArrayList();		
		String message="";
		Connection con = null;
		String selectQuery="";		
		int count=0;
		PreparedStatement stmt = null;
		try	{
			int n=0;
			String[] assecodes = frm.getAssetCode();
			Connection conn = null;
			ResultSet rs = null,rs1=null,rs4=null,rs5;
			PreparedStatement preparedStatement=null,preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null;
			PreparedStatement preparedStatement5=null,preparedStatement6=null,preparedStatement7=null;
			HabConvertDao hd = new HabConvertDao();			
			conn = RwsOffices.getConn();			
			for(int i=0;i<assecodes.length;i++)	{
				String checkqry="select old_asset_code,old_hab_code,new_hab_code from rws_khammam_asset_old_tbl where old_asset_code= ? and old_hab_code= ? ";
				preparedStatement4=conn.prepareStatement(checkqry);
				preparedStatement4.setString(1, assecodes[i]);
				preparedStatement4.setString(2, frm.getHabCode());
				rs4=preparedStatement4.executeQuery();
				if(rs4.next()){
					message="This AssetCode is already converted to "+rs4.getString(3)+"  habcode ";
					return message;				
				}
				else{
					selectQuery = "select ASSET_CODE,nvl(ASSET_NAME,' '),TYPE_OF_ASSET_CODE,HAB_CODE,nvl(LOCATION,' '),nvl(to_char(DATE_CREATION,'dd/mm/yyyy'),' '),nvl(ASSET_STATUS,0),nvl(ASSET_COST,0),nvl(START_YEAR,' '),nvl(END_YEAR,' '),nvl(CIRCLE_OFFICE_CODE,' '),nvl(DIVISION_OFFICE_CODE,0),nvl(SUBDIVISION_OFFICE_CODE,' '),nvl(to_char(UPDATE_DATE,'dd/mm/yyyy'),' '),nvl(POPU_BENEFITED,0),nvl(DEFUNCT_REASON,' '),nvl(REMARKS,' '),nvl(DIRECT_PUMPING_YIELD,0),nvl(PROGRAMME_CODE,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.rws_asset_mast_tbl where asset_code= ? and hab_code= ? ";
			 		ps = conn.prepareStatement(selectQuery);
			 		ps.setString(1, assecodes[i]);
			 		ps.setString(2, frm.getHabCode());
			 		rs = ps.executeQuery();			
			 		if(rs.next()){
			 			String habcode=frm.getHabName1();
			 			String divisionCode="";
			 			String subDivisionCode="";
			 			if(habcode.substring(0,2).equals("04")){
							divisionCode="2";
							subDivisionCode="03";
						}
						else if(habcode.substring(0,2).equals("05")){
							divisionCode="1";
							subDivisionCode="03";
						}
						String ac=rs.getString(1);
						String assetcode=ac.substring(0,4)+habcode.substring(0,2)+ac.substring(6,14);
						String finalAssetcode="";
						String checkingQuery="select max(substr(asset_code,11,14)) from rws_asset_mast_tbl where substr(asset_code,1,10)=?";
						preparedStatement1=conn.prepareStatement(checkingQuery);
						preparedStatement1.setString(1, assetcode.substring(0,10));
						rs1=preparedStatement1.executeQuery();				
						if(rs1.next()){
							Integer maxCode=rs1.getInt(1)+1;					
							if(maxCode.toString().length()==1){
								finalAssetcode=assetcode.substring(0,10)+"000"+maxCode.toString();
							}
							else if(maxCode.toString().length()==2){
								finalAssetcode=assetcode.substring(0,10)+"00"+maxCode.toString();
							}
							else if(maxCode.toString().length()==3){
								finalAssetcode=assetcode.substring(0,10)+"0"+maxCode.toString();
							}
							else if(maxCode.toString().length()==4){
								finalAssetcode=assetcode.substring(0,10)+""+maxCode.toString();
							}
						}
						else{
							finalAssetcode=assetcode.substring(0,10)+"0001";
						}
						preparedStatement1.close();
						rs1.close();				
				String inserQuery="insert into rws_asset_mast_tbl (ASSET_CODE,ASSET_NAME,TYPE_OF_ASSET_CODE,HAB_CODE,LOCATION,DATE_CREATION,ASSET_STATUS,ASSET_COST,START_YEAR,END_YEAR,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,UPDATE_DATE,POPU_BENEFITED,DEFUNCT_REASON,REMARKS,DIRECT_PUMPING_YIELD,PROGRAMME_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?)";
				preparedStatement=conn.prepareStatement(inserQuery);
				preparedStatement.setString(1, finalAssetcode);
				preparedStatement.setString(2, rs.getString(2));
				preparedStatement.setString(3, rs.getString(3));
				preparedStatement.setString(4, habcode);
				preparedStatement.setString(5, rs.getString(5));
				preparedStatement.setString(6, rs.getString(6));
				preparedStatement.setString(7, rs.getString(7));
				preparedStatement.setString(8, rs.getString(8));
				preparedStatement.setString(9, rs.getString(9));
				preparedStatement.setString(10, rs.getString(10));
				preparedStatement.setString(11, habcode.substring(0,2));
				preparedStatement.setString(12, divisionCode);
				preparedStatement.setString(13, subDivisionCode);
				preparedStatement.setString(14, rs.getString(14));
				preparedStatement.setString(15, rs.getString(15));
				preparedStatement.setString(16, rs.getString(16));
				preparedStatement.setString(17, rs.getString(17));
				preparedStatement.setString(18, rs.getString(18));
				preparedStatement.setString(19, rs.getString(19));
				preparedStatement.setString(20, rs.getString(20));
				preparedStatement.setString(21, rs.getString(21));
				preparedStatement.setString(22, rs.getString(22));
				preparedStatement.setString(23, rs.getString(23));
				n=preparedStatement.executeUpdate();
				preparedStatement.close();
				
				String oldnewasstdata="insert into rws_khammam_asset_old_tbl(OLD_ASSET_CODE,NEW_ASSET_CODE,OLD_HAB_CODE,NEW_HAB_CODE) values(?,?,?,?)";
				preparedStatement3=conn.prepareStatement(oldnewasstdata);
				preparedStatement3.setString(1, ac);
				preparedStatement3.setString(2, finalAssetcode);
				preparedStatement3.setString(3, frm.getHabCode());
				preparedStatement3.setString(4, habcode);
				preparedStatement3.executeUpdate();
				preparedStatement3.close();
				
				String inserhabQuery="insert into rws_asset_hab_tbl (ASSET_CODE,HAB_CODE) values(?,?)";
				preparedStatement2=conn.prepareStatement(inserhabQuery);
				preparedStatement2.setString(1, finalAssetcode);
				preparedStatement2.setString(2, habcode);
				preparedStatement2.executeUpdate();
				preparedStatement2.close();
				
				String sourceTableQuery="select SOURCE_CODE,nvl(SOURCE_NAME,' '),SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,HAB_CODE,nvl(NO_OF_HABITAITONS_COVERD,0),nvl(POPULATION_BENIFITED,0),nvl(SEASONAL,' '),nvl(WATER_QUALITY,' '),nvl(STATIC_WATER_LEVEL,0),nvl(SUMMER_WATER_LEVEL,0),nvl(YIELD,' '),nvl(DIST_NEAR_PRIVATE_SOURCE,0),nvl(LOCATION,' '),nvl(CIRCLE_OFFICE_CODE,' '),nvl(DIVISION_OFFICE_CODE,0),nvl(SUBDIVISION_OFFICE_CODE,' '),nvl(DEPTH,0),nvl(DIAMETER,0),nvl(SOURCE_CONDITION,' '),nvl(TYPE,' '),ASSET_CODE,nvl(ALT_WATER_SOURCE_DET,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_SOURCE_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(sourceTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(source_code,22,3)) from rws_source_tbl where substr(source_code,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();					
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_SOURCE_TBL (SOURCE_CODE,SOURCE_NAME,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,HAB_CODE,NO_OF_HABITAITONS_COVERD,POPULATION_BENIFITED,SEASONAL,WATER_QUALITY,STATIC_WATER_LEVEL,SUMMER_WATER_LEVEL,YIELD,DIST_NEAR_PRIVATE_SOURCE,LOCATION,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,DEPTH,DIAMETER,SOURCE_CONDITION,TYPE,ASSET_CODE,ALT_WATER_SOURCE_DET,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery);
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, habcode);
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, habcode.substring(0,2));
					preparedStatement6.setString(16, divisionCode);
					preparedStatement6.setString(17, subDivisionCode);
					preparedStatement6.setString(18, rs5.getString(18));
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, finalAssetcode);
					preparedStatement6.setString(23, rs5.getString(23));
					preparedStatement6.setString(24, rs5.getString(24));
					preparedStatement6.setString(25, rs5.getString(25));
					preparedStatement6.setString(26, rs5.getString(26));
					preparedStatement6.setString(27, rs5.getString(27));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String hpTableQuery="select nvl(LOCATION,' '),nvl(DRILL_YEAR,' '),nvl(DIAMETER,0),nvl(CASING,' '),nvl(STATUS,' '),nvl(GEN_CONDITION,' '),nvl(GI_NO,0),nvl(PAINTED,' '),nvl(STATIC_WL,0),nvl(SUMMER_WL,0),nvl(P_COND,' '),nvl(DRY_DURING,0),nvl(SERVICE,' '),nvl(SER_NO,0),nvl(SER_HRS,0),nvl(REPAIRS,' '),nvl(PLATFORM_CONDITION,' '),nvl(DRAIN,' '),nvl(DRAIN_CONDITION,' '),nvl(DRAIN_SD,' '),nvl(DRAIN_LP,' '),nvl(HYGIENE,' '),nvl(AVG_TIME,0),nvl(P_YEILD,0),nvl(PYEILD_LOCAL,' '),nvl(PERIOD,' '),ASSET_CODE,nvl(DEPTH,0),HP_CODE,nvl(QUALITY_AFFECTED,' '),nvl(FLOURIDE,0),nvl(BRAKISH,0),nvl(IRON,0),nvl(OTHERS_SPECIFY_TYPE,' '),nvl(CONT_OTHERS_TYPE,' '),nvl(CONT_OTHERS_PER,0),nvl(PLATFORM_EXISTING,' '),nvl(WATERQUALITY,' '),nvl(PIPE_LENGTH,0),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_HP_SUBCOMP_PARAM_TBL where asset_code=? and substr(hp_code,1,16)=?";
				preparedStatement5=conn.prepareStatement(hpTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(29).substring(16,21);
					String sourcemaxQuery="select max(substr(hp_code,22,3)) from RWS_HP_SUBCOMP_PARAM_TBL where substr(hp_code,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_HP_SUBCOMP_PARAM_TBL (LOCATION,DRILL_YEAR,DIAMETER,CASING,STATUS,GEN_CONDITION,GI_NO,PAINTED,STATIC_WL,SUMMER_WL,P_COND,DRY_DURING,SERVICE,SER_NO,SER_HRS,REPAIRS,PLATFORM_CONDITION,DRAIN,DRAIN_CONDITION,DRAIN_SD,DRAIN_LP,HYGIENE,AVG_TIME,P_YEILD,PYEILD_LOCAL,PERIOD,ASSET_CODE,DEPTH,HP_CODE,QUALITY_AFFECTED,FLOURIDE,BRAKISH,IRON,OTHERS_SPECIFY_TYPE,CONT_OTHERS_TYPE,CONT_OTHERS_PER,PLATFORM_EXISTING,WATERQUALITY,PIPE_LENGTH,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery);
					preparedStatement6.setString(1, rs5.getString(1));
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, rs5.getString(18));
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, rs5.getString(22));
					preparedStatement6.setString(23, rs5.getString(23));
					preparedStatement6.setString(24, rs5.getString(24));
					preparedStatement6.setString(25, rs5.getString(25));
					preparedStatement6.setString(26, rs5.getString(26));
					preparedStatement6.setString(27, finalAssetcode);
					preparedStatement6.setString(28, rs5.getString(28));
					preparedStatement6.setString(29, finalSourceCode);
					preparedStatement6.setString(30, rs5.getString(30));
					preparedStatement6.setString(31, rs5.getString(31));
					preparedStatement6.setString(32, rs5.getString(32));
					preparedStatement6.setString(33, rs5.getString(33));
					preparedStatement6.setString(34, rs5.getString(34));
					preparedStatement6.setString(35, rs5.getString(35));
					preparedStatement6.setString(36, rs5.getString(36));
					preparedStatement6.setString(37, rs5.getString(37));
					preparedStatement6.setString(38, rs5.getString(38));
					preparedStatement6.setString(39, rs5.getString(39));
					preparedStatement6.setString(40, rs5.getString(40));
					preparedStatement6.setString(41, rs5.getString(41));
					preparedStatement6.setString(42, rs5.getString(42));
					preparedStatement6.setString(43, rs5.getString(43));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String shpTableQuery="select HAB_CODE,SHALLOWHP_CODE,nvl(LOCATION,' '),nvl(DIAMETER,0),nvl(DEPTH,0),nvl(HYGIENE,' '),nvl(AVERAGE_HOURS,0),nvl(AVERAGE_TIME,0),nvl(YIELD,0),nvl(WATER_QUALITY,' '),nvl(FLORIDE_PER,0),nvl(BRAKISH_PER,0),nvl(IRON_PER,0),nvl(OTHERS_PER,0),ASSET_CODE,nvl(FLORIDE,' '),nvl(BRAKISH,' '),nvl(IRON,' '),nvl(OTHERS,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_SHALLOWHANDPUMPS_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(shpTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(SHALLOWHP_CODE,22,3)) from RWS_SHALLOWHANDPUMPS_TBL where substr(SHALLOWHP_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();					
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_SHALLOWHANDPUMPS_TBL (HAB_CODE,SHALLOWHP_CODE,LOCATION,DIAMETER,DEPTH,HYGIENE,AVERAGE_HOURS,AVERAGE_TIME,YIELD,WATER_QUALITY,FLORIDE_PER,BRAKISH_PER,IRON_PER,OTHERS_PER,ASSET_CODE,FLORIDE,BRAKISH,IRON,OTHERS,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, habcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, finalAssetcode);
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, rs5.getString(18));
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, rs5.getString(22));
					preparedStatement6.setString(23, rs5.getString(23));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String openwellTableQuery="select ASSET_CODE,HAB_CODE,POND_CODE,nvl(POND_NAME,' '),nvl(POND_LOCATION,' '),nvl(SIZE_AREA,0),nvl(STORAGE_VOL,0),nvl(HYGENITY,' '),nvl(USAGE_PURPOSE,' '),nvl(FED_BY,' '),nvl(FED_NAME,' '),nvl(FED_OTHERS_NAME,' '),nvl(WATER_QUALITY,' '),nvl(FLORIDE,0),nvl(BRAKISH,0),nvl(IRON,0),nvl(OTHER_TYPE,' '),nvl(OTHER_PER,0) from preduser.RWS_OPENWELL_POND_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(openwellTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(3).substring(16,21);
					String sourcemaxQuery="select max(substr(POND_CODE,22,3)) from RWS_OPENWELL_POND_TBL where substr(POND_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_OPENWELL_POND_TBL (ASSET_CODE,HAB_CODE,POND_CODE,POND_NAME,POND_LOCATION,SIZE_AREA,STORAGE_VOL,HYGENITY,USAGE_PURPOSE,FED_BY,FED_NAME,FED_OTHERS_NAME,WATER_QUALITY,FLORIDE,BRAKISH,IRON,OTHER_TYPE,OTHER_PER) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, habcode);
					preparedStatement6.setString(3, finalSourceCode);
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, rs5.getString(18));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String openwellMastTableQuery="select HABITATION_CODE,OPENWELL_CODE,nvl(LOCATION,' '),nvl(DIAMETER,0),nvl(DEPTH,0),nvl(NORMAL_WATER_LEVEL,0),nvl(MIN_WATER_LEVEL,0),nvl(MAX_WATER_LEVEL,0),nvl(PLATFORM_EXISTS,' '),nvl(PLATFORM_CONDITION,' '),nvl(PURPOSE,' '),nvl(QUALITY,' '),nvl(FLOURIDE_PER,0),nvl(BRAKISH_PER,0),nvl(IRON_PER,0),nvl(OTHER_TYPE,' '),nvl(OTHER_PER,0),nvl(RAD_FLOURIDE,' '),nvl(RAD_BRAKISH,' '),nvl(RAD_IRON,' '),nvl(RAD_OTHERS,' '),ASSET_CODE,nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_OPEN_WELL_MAST_TBL where asset_code=? and HABITATION_CODE=?";
				preparedStatement5=conn.prepareStatement(openwellMastTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(OPENWELL_CODE,22,3)) from RWS_OPEN_WELL_MAST_TBL where substr(OPENWELL_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_OPEN_WELL_MAST_TBL (HABITATION_CODE,OPENWELL_CODE,LOCATION,DIAMETER,DEPTH,NORMAL_WATER_LEVEL,MIN_WATER_LEVEL,MAX_WATER_LEVEL,PLATFORM_EXISTS,PLATFORM_CONDITION,PURPOSE,QUALITY,FLOURIDE_PER,BRAKISH_PER,IRON_PER,OTHER_TYPE,OTHER_PER,RAD_FLOURIDE,RAD_BRAKISH,RAD_IRON,RAD_OTHERS,ASSET_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, habcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, rs5.getString(18));
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, finalAssetcode);
					preparedStatement6.setString(23, rs5.getString(23));
					preparedStatement6.setString(24, rs5.getString(24));
					preparedStatement6.setString(25, rs5.getString(25));
					preparedStatement6.setString(26, rs5.getString(26));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String subcompParamTableQuery="select ASSET_CODE,PUMP_CODE,nvl(PUMP_MAKE,' '),nvl(PUMP_CPTY,0),nvl(PUMP_TYPE,' '),nvl(YEAR_COMM,' '),nvl(HR_RUN,0),nvl(USAGE,' '),nvl(DESIGNED_LPM,0),nvl(DESIGNED_HEAD,0),nvl(CONTROL_PANEL,' '),nvl(LOW_VOLT_PROB,' '),nvl(POWER_AVAIL_PER_DAY,0),nvl(FEAS_URBAN_LINE,' '),nvl(COST,0),nvl(URBAN_LINE_DISTANCE,0),nvl(SUGGESTIONS,' '),HAB_CODE,nvl(LOCATION,' '),nvl(FEEDER,' '),nvl(GENERATOR_EXISTING,' '),nvl(GENERATOR_CAPACITY,' '),nvl(GENERATOR_WORKING,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_SUBCOMP_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(subcompParamTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(PUMP_CODE,22,3)) from RWS_AST_SUBCOMP_PARAM_TBL where substr(PUMP_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_SUBCOMP_PARAM_TBL (ASSET_CODE,PUMP_CODE,PUMP_MAKE,PUMP_CPTY,PUMP_TYPE,YEAR_COMM,HR_RUN,USAGE,DESIGNED_LPM,DESIGNED_HEAD,CONTROL_PANEL,LOW_VOLT_PROB,POWER_AVAIL_PER_DAY,FEAS_URBAN_LINE,COST,URBAN_LINE_DISTANCE,SUGGESTIONS,HAB_CODE,LOCATION,FEEDER,GENERATOR_EXISTING,GENERATOR_CAPACITY,GENERATOR_WORKING,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, habcode);
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, rs5.getString(22));
					preparedStatement6.setString(23, rs5.getString(23));
					preparedStatement6.setString(24, rs5.getString(24));
					preparedStatement6.setString(25, rs5.getString(25));
					preparedStatement6.setString(26, rs5.getString(26));
					preparedStatement6.setString(27, rs5.getString(27));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String OHSRTableQuery="select nvl(ASSET_CODE,' '),OHSR_CODE,nvl(OHSR_CAP_LTS,0),nvl(OHSR_LOC,' '),nvl(OHSR_SATGES,0),nvl(OHSR_LWL,0),nvl(OHSR_MWL,0),nvl(OHSR_FILL_HR,0),nvl(OHSR_EMPTY_HR,0),nvl(OHSR_NO_OF_FILLING,0),nvl(HAB_CODE,' '),nvl(WATER_QTY,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_OHSR_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(OHSRTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(OHSR_CODE,22,3)) from RWS_AST_OHSR_SC_PARAM_TBL where substr(OHSR_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_OHSR_SC_PARAM_TBL (ASSET_CODE,OHSR_CODE,OHSR_CAP_LTS,OHSR_LOC,OHSR_SATGES,OHSR_LWL,OHSR_MWL,OHSR_FILL_HR,OHSR_EMPTY_HR,OHSR_NO_OF_FILLING,HAB_CODE,WATER_QTY,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, habcode);
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));	
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String OHBRTableQuery="select nvl(ASSET_CODE,' '),OHBR_CODE,nvl(OHBR_CAP_LTS,0),nvl(OHBR_LOC,' '),nvl(OHBR_SATGES,0),nvl(OHBR_LWL,0),nvl(OHBR_MWL,0),nvl(OHBR_FILL_HR,0),nvl(OHBR_EMPTY_HR,0),nvl(HAB_CODE,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_OHBR_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(OHBRTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(OHBR_CODE,22,3)) from RWS_AST_OHBR_SC_PARAM_TBL where substr(OHBR_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_OHBR_SC_PARAM_TBL (ASSET_CODE,OHBR_CODE,OHBR_CAP_LTS,OHBR_LOC,OHBR_SATGES,OHBR_LWL,OHBR_MWL,OHBR_FILL_HR,OHBR_EMPTY_HR,HAB_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, habcode);
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));	
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String GLSRTableQuery="select nvl(ASSET_CODE,' '),GLSR_CODE,nvl(GLSR_CAP_LTS,0), nvl(GLSR_LOC,' '),nvl(GLSR_SATGES,0),nvl(GLSR_LWL,0),nvl(GLSR_MWL,0),nvl(GLSR_FILL_HR,0),nvl(GLSR_EMPTY_HR,0),nvl(GLSR_NO_OF_FILLING,0), nvl(HAB_CODE,' '),nvl(WATER_QTY,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_GLSR_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(GLSRTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(GLSR_CODE,22,3)) from RWS_AST_GLSR_SC_PARAM_TBL where substr(GLSR_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_GLSR_SC_PARAM_TBL(ASSET_CODE,GLSR_CODE,GLSR_CAP_LTS,GLSR_LOC,GLSR_SATGES,GLSR_LWL,GLSR_MWL,GLSR_FILL_HR,GLSR_EMPTY_HR,GLSR_NO_OF_FILLING,HAB_CODE,WATER_QTY,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, habcode);
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));	
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String GLBRTableQuery="select ASSET_CODE,GLBR_CODE,nvl(GLBR_CAP_LTS,0),nvl(GLBR_LOC,' '),nvl(GLBR_LWL,0),nvl(GLBR_MWL,0),nvl(GLBR_FILL_HR,0),nvl(GLBR_EMPTY_HR,0),nvl(STAGING,0),nvl(HAB_CODE,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_GLBR_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(GLBRTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(GLBR_CODE,22,3)) from RWS_AST_GLBR_SC_PARAM_TBL where substr(GLBR_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_GLBR_SC_PARAM_TBL(ASSET_CODE,GLBR_CODE,GLBR_CAP_LTS,GLBR_LOC,GLBR_LWL,GLBR_MWL,GLBR_FILL_HR,GLBR_EMPTY_HR,STAGING,HAB_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, habcode);
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String CISTableQuery="select nvl(ASSET_CODE,' '),nvl(CIS_NO,0),nvl(CIS_LOC,' '),nvl(CIS_CAP_LTS,0),nvl(CIS_COND,' '),nvl(CIS_FILL,' '),nvl(CIS_MOD_FILL,' '),nvl(CIS_USE,' '),nvl(CIS_PF,' '),nvl(CIS_PF_CON,' '),nvl(CIS_DRAIN,' '),nvl(CIS_TAP,0),nvl(CIS_TAP_COND,' '),nvl(CIS_HR,0),nvl(CIS_HR_ONE,0),nvl(CIS_HR_ALL,0),CISSC_CODE,nvl(HAB_CODE,' '),nvl(WATER_QTY,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_CIS_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(CISTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(17).substring(16,21);
					String sourcemaxQuery="select max(substr(CISSC_CODE,22,3)) from RWS_AST_CIS_SC_PARAM_TBL where substr(CISSC_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_CIS_SC_PARAM_TBL (ASSET_CODE,CIS_NO,CIS_LOC,CIS_CAP_LTS,CIS_COND,CIS_FILL,CIS_MOD_FILL,CIS_USE,CIS_PF,CIS_PF_CON,CIS_DRAIN,CIS_TAP,CIS_TAP_COND,CIS_HR,CIS_HR_ONE,CIS_HR_ALL,CISSC_CODE,HAB_CODE,WATER_QTY,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.setString(17, finalSourceCode);
					preparedStatement6.setString(18, habcode);
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, rs5.getString(22));
					preparedStatement6.setString(23, rs5.getString(23));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String RWCWTableQuery="select RW_COLLWELL_CODE,nvl(DIAMETER,0),nvl(DEPTH,0),nvl(TYPE_OF_FLOORING,' '),nvl(ASSET_CODE,' '),nvl(LOCATION,' '),nvl(CAPACITY,0),nvl(HAB_CODE,' ') from preduser.RWS_AST_RW_COLLWELL_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(RWCWTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(RW_COLLWELL_CODE,22,3)) from RWS_AST_RW_COLLWELL_PARAM_TBL where substr(RW_COLLWELL_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_RW_COLLWELL_PARAM_TBL (RW_COLLWELL_CODE,DIAMETER,DEPTH,TYPE_OF_FLOORING,ASSET_CODE,LOCATION,CAPACITY,HAB_CODE) values(?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, finalAssetcode);
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, habcode);					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String CWCWTableQuery="select CW_COLLWELL_CODE,nvl(DIAMETER,0),nvl(DEPTH,0),nvl(TYPE_OF_FLOORING,' '),ASSET_CODE,nvl(LOCATION,' '),nvl(CAPACITY,0),nvl(HAB_CODE,' ') from preduser.RWS_AST_CW_COLLWELL_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(CWCWTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(CW_COLLWELL_CODE,22,3)) from RWS_AST_CW_COLLWELL_PARAM_TBL where substr(CW_COLLWELL_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;
					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_CW_COLLWELL_PARAM_TBL (CW_COLLWELL_CODE,DIAMETER,DEPTH,TYPE_OF_FLOORING,ASSET_CODE,LOCATION,CAPACITY,HAB_CODE) values(?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, finalAssetcode);
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, habcode);					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String SSSCTableQuery="select ASSET_CODE,SSSC_CODE,nvl(SS_SIZE,0),nvl(CAPACITY_DAYS,0),nvl(CAPACITY_MCUM,0),nvl(TANK_ADEQACY,' '),nvl(LOCATION,' '),nvl(POWER_CON,' '),nvl(POWER_HRS,0),nvl(DEPTH,0),nvl(OTHERS,' '),nvl(HAB_CODE,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_SS_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(SSSCTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(SSSC_CODE,22,3)) from RWS_AST_SS_SC_PARAM_TBL where substr(SSSC_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_SS_SC_PARAM_TBL(ASSET_CODE,SSSC_CODE,SS_SIZE,CAPACITY_DAYS,CAPACITY_MCUM,TANK_ADEQACY,LOCATION,POWER_CON,POWER_HRS,DEPTH,OTHERS,HAB_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, habcode);
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String WTPSCTableQuery="select nvl(ASSET_CODE,' '),WTPSC_CODE,nvl(WTP_TYPW,' '),nvl(WTP_MLD,0),nvl(UNITS_NO,0),nvl(WTP_SIZE,' '),nvl(UNITS_STANDBY,0),nvl(BACKWASH_FEQ,0),nvl(PERFORMANCE,' '),nvl(USE_CAPACITYMLD,0),nvl(EXTENTION_SCOPE,' '),nvl(FREQ_SAND_SCRAP,0),nvl(LOCATION,' '),nvl(CHK_FILTER,' '),nvl(RATE_OF_FILTRATION,0),nvl(HAB_CODE,' '),nvl(SHELTER_EXISTING,' '),nvl(RWS_TANK_EXISTING,' '),nvl(PWS_TANK_EXISTING,' '),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(ELEVATION,0),nvl(WAY_POINT,0) from preduser.RWS_AST_WTP_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(WTPSCTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(WTPSC_CODE,22,3)) from RWS_AST_WTP_SC_PARAM_TBL where substr(WTPSC_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_WTP_SC_PARAM_TBL(ASSET_CODE,WTPSC_CODE,WTP_TYPW,WTP_MLD,UNITS_NO,WTP_SIZE,UNITS_STANDBY,BACKWASH_FEQ,PERFORMANCE,USE_CAPACITYMLD,EXTENTION_SCOPE,FREQ_SAND_SCRAP,LOCATION,CHK_FILTER,RATE_OF_FILTRATION,HAB_CODE,SHELTER_EXISTING,RWS_TANK_EXISTING,PWS_TANK_EXISTING,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, habcode);
					preparedStatement6.setString(17, rs5.getString(17));
					preparedStatement6.setString(18, rs5.getString(18));
					preparedStatement6.setString(19, rs5.getString(19));
					preparedStatement6.setString(20, rs5.getString(20));
					preparedStatement6.setString(21, rs5.getString(21));
					preparedStatement6.setString(22, rs5.getString(22));
					preparedStatement6.setString(23, rs5.getString(23));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String SUMPMTableQuery="select nvl(ASSET_CODE,' '),SUMPCODE,nvl(SUMP_TYPE,' '),nvl(SUMP_CAPACITY,0),nvl(FILLING_HR,0),nvl(EMPTY_TIME_HR,0),nvl(SUMP_CONDITION,' '),nvl(SUMP_MADE_OF,' '),nvl(SUMP_DIAMETER,0),nvl(SUMP_DEPTH,0),nvl(HAB_CODE,' '),nvl(LOCATION,' ') from preduser.RWS_AST_SUMP_M_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(SUMPMTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(SUMPCODE,22,3)) from RWS_AST_SUMP_M_SC_PARAM_TBL where substr(SUMPCODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_SUMP_M_SC_PARAM_TBL(ASSET_CODE,SUMPCODE,SUMP_TYPE,SUMP_CAPACITY,FILLING_HR,EMPTY_TIME_HR,SUMP_CONDITION,SUMP_MADE_OF,SUMP_DIAMETER,SUMP_DEPTH,HAB_CODE,LOCATION) values(?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, habcode);
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String DISTRITableQuery="select ASSET_CODE,nvl(DIS_LEN,0),nvl(DIS_COVE,' '),nvl(DIS_LN,0),nvl(DIS_TLC,0),nvl(DIS_BN,0),DISTRISC_CODE,nvl(DIS_MAT_CODE,' '),nvl(NO_OF_PIPES,0),HAB_CODE,nvl(NO_AIRVALVES,0),nvl(NO_SCOURVALVES,0),nvl(NO_SLUICEVALVES,0),nvl(NO_PR_HC,0),nvl(LOCATION,' '),nvl(NO_STANDPOSTS,0) from preduser.RWS_AST_DISTRI_SC_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(DISTRITableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(7).substring(16,21);
					String sourcemaxQuery="select max(substr(DISTRISC_CODE,22,3)) from RWS_AST_DISTRI_SC_PARAM_TBL where substr(DISTRISC_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_DISTRI_SC_PARAM_TBL(ASSET_CODE,DIS_LEN,DIS_COVE,DIS_LN,DIS_TLC,DIS_BN,DISTRISC_CODE,DIS_MAT_CODE,NO_OF_PIPES,HAB_CODE,NO_AIRVALVES,NO_SCOURVALVES,NO_SLUICEVALVES,NO_PR_HC,LOCATION,NO_STANDPOSTS) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, finalSourceCode);
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, habcode);
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));
					preparedStatement6.setString(15, rs5.getString(15));
					preparedStatement6.setString(16, rs5.getString(16));
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String BPTTableQuery="select BPT_CODE,nvl(CAPACITY,0),nvl(STAGING,0),nvl(BPT_MWL,0),nvl(BPT_LWL,0),ASSET_CODE,nvl(LOCATION,' '),nvl(HAB_CODE,' ') from preduser.RWS_AST_BPT_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(BPTTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(BPT_CODE,22,3)) from RWS_AST_BPT_PARAM_TBL where substr(BPT_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_BPT_PARAM_TBL(BPT_CODE,CAPACITY,STAGING,BPT_MWL,BPT_LWL,ASSET_CODE,LOCATION,HAB_CODE) values(?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, finalAssetcode);
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, habcode);					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String FPBridgeTableQuery="select BRIDGE_CODE,nvl(BRIDGE_TYPE,' '),BRIDGE_LENGTH,BRIDGE_WIDTH,BRIDGE_WALK_WAY_WIDTH,LENGTH_OF_THE_BRIDGE,BRIDGE_SPAN_LENGTH,ASSET_CODE,nvl(HAB_CODE,' '),nvl(LOCATION,' ') from preduser.RWS_AST_FP_BRIDGE_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(FPBridgeTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(BRIDGE_CODE,22,3)) from RWS_AST_FP_BRIDGE_PARAM_TBL where substr(BRIDGE_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_FP_BRIDGE_PARAM_TBL(BRIDGE_CODE,BRIDGE_TYPE,BRIDGE_LENGTH,BRIDGE_WIDTH,BRIDGE_WALK_WAY_WIDTH,LENGTH_OF_THE_BRIDGE,BRIDGE_SPAN_LENGTH,ASSET_CODE,HAB_CODE,LOCATION) values(?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, finalAssetcode);
					preparedStatement6.setString(9, habcode);
					preparedStatement6.setString(10, rs5.getString(10));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String PUMPHOUSETableQuery="select nvl(TYPE,' '),nvl(AREA,0),nvl(HEIGHT,0),nvl(ASSET_CODE,' '),PUMPHOUSE_CODE,nvl(LOCATION,' '),nvl(HAB_CODE,' ') from preduser.RWS_AST_PUMPHOUSE_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(PUMPHOUSETableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(5).substring(16,21);
					String sourcemaxQuery="select max(substr(PUMPHOUSE_CODE,22,3)) from RWS_AST_PUMPHOUSE_PARAM_TBL where substr(PUMPHOUSE_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_PUMPHOUSE_PARAM_TBL(TYPE,AREA,HEIGHT,ASSET_CODE,PUMPHOUSE_CODE,LOCATION,HAB_CODE) values(?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, rs5.getString(1));
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, finalAssetcode);
					preparedStatement6.setString(5, finalSourceCode);
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, habcode);										
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String WATCHMANTableQuery="select nvl(TYPE,' '),nvl(AREA,0),nvl(NO_OF_QTRS,0),nvl(ASSET_CODE,' '),WATCHMAN_CODE,nvl(HAB_CODE,' '),nvl(LOCATION,' ') from preduser.RWS_AST_WATCHMAN_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(WATCHMANTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(5).substring(16,21);
					String sourcemaxQuery="select max(substr(WATCHMAN_CODE,22,3)) from RWS_AST_WATCHMAN_PARAM_TBL where substr(WATCHMAN_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_WATCHMAN_PARAM_TBL(TYPE,AREA,NO_OF_QTRS,ASSET_CODE,WATCHMAN_CODE,HAB_CODE,LOCATION) values(?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, rs5.getString(1));
					preparedStatement6.setString(2, rs5.getString(2));
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, finalAssetcode);
					preparedStatement6.setString(5, finalSourceCode);
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, habcode);										
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String OthersTableQuery="select OTHER_COMP_CODE,ASSET_CODE,nvl(COMP_NAME,' '),nvl(COMP_LOCATION,' '),nvl(REMARKS,' '),HAB_CODE from preduser.RWS_AST_OTHERS_PARAM_TBL where asset_code=? and HAB_CODE=?";
				preparedStatement5=conn.prepareStatement(OthersTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(OTHER_COMP_CODE,22,3)) from RWS_AST_OTHERS_PARAM_TBL where substr(OTHER_COMP_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();	
					
					String insertSourceTableQuery="insert into RWS_AST_OTHERS_PARAM_TBL(OTHER_COMP_CODE,ASSET_CODE,COMP_NAME,COMP_LOCATION,REMARKS,HAB_CODE) values(?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalSourceCode);
					preparedStatement6.setString(2, finalAssetcode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, habcode);															
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String OANDMCODETableQuery="select nvl(ASSET_CODE,' '),nvl(OANDMCODE,' '),nvl(AGENCY_CODE,' '),nvl(POWER_COST,0),nvl(CONSUM_ANNUM,0),nvl(WAGES_ANNUM,0),nvl(SOURCES_FUND,' '),nvl(TARIFF_MONTH,0),nvl(HOUSE_CONN,0),nvl(PUBLIC_STAND_POSTS,0) from preduser.RWS_AST_oandm_param_TBL where asset_code=?";
				preparedStatement5=conn.prepareStatement(OANDMCODETableQuery);
				preparedStatement5.setString(1, ac);
				
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(OANDMCODE,22,3)) from RWS_AST_oandm_param_TBL where substr(OANDMCODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_oandm_param_TBL(ASSET_CODE,OANDMCODE,AGENCY_CODE,POWER_COST,CONSUM_ANNUM,WAGES_ANNUM,SOURCES_FUND,TARIFF_MONTH,HOUSE_CONN,PUBLIC_STAND_POSTS) values(?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, rs5.getString(3));
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));															
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String PUMPINGMAINTableQuery="select nvl(ASSET_CODE,' '),PUMPINGMAIN_CODE,nvl(HAB_CODE,' '),nvl(LENGTH,0),nvl(AIRVALVE_NO,0),nvl(SCOUREVALVE,0),nvl(REFLEXVALVE,0),nvl(SLUICEVALVE,0),nvl(NO_OF_PIPES,' '),nvl(ZERO_VELOCITY_VALVE,0),nvl(AIR_CUSHION_VALVE,0),nvl(LOCATION,' '),nvl(NON_RETURN_VALVE,0) from preduser.RWS_AST_PUMPINGMAIN_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(PUMPINGMAINTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(PUMPINGMAIN_CODE,22,3)) from RWS_AST_PUMPINGMAIN_TBL where substr(PUMPINGMAIN_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_PUMPINGMAIN_TBL(ASSET_CODE,PUMPINGMAIN_CODE,HAB_CODE,LENGTH,AIRVALVE_NO,SCOUREVALVE,REFLEXVALVE,SLUICEVALVE,NO_OF_PIPES,ZERO_VELOCITY_VALVE,AIR_CUSHION_VALVE,LOCATION,NON_RETURN_VALVE) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, habcode);
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String GRAVITYMAINTableQuery="select nvl(ASSET_CODE,' '),GRAVITYMAIN_CODE,nvl(HAB_CODE,' '),nvl(LENGTH,0),nvl(AIRVALVE_NO,0),nvl(SCOUREVALVE,0),nvl(REFLEXVALVE,0),nvl(SLUICEVALVE,0),nvl(MET_TYPE,' '),nvl(NO_OF_PIPES,0),nvl(LOCATION,' '),nvl(ZERO_VELOCITY_VALVE,0),nvl(AIR_CUSHION_VALVE,0),nvl(NON_RETURN_VALVE,0) from preduser.RWS_AST_GRAVITYMAIN_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(GRAVITYMAINTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(2).substring(16,21);
					String sourcemaxQuery="select max(substr(GRAVITYMAIN_CODE,22,3)) from RWS_AST_GRAVITYMAIN_TBL where substr(GRAVITYMAIN_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_GRAVITYMAIN_TBL(ASSET_CODE,GRAVITYMAIN_CODE,HAB_CODE,LENGTH,AIRVALVE_NO,SCOUREVALVE,REFLEXVALVE,SLUICEVALVE,MET_TYPE,NO_OF_PIPES,LOCATION,ZERO_VELOCITY_VALVE,AIR_CUSHION_VALVE,NON_RETURN_VALVE) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, habcode);
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
				String CHLORINATIONTableQuery="select CL_CODE,HAB_CODE,nvl(LOCATION,' '),nvl(WORKING,' '),nvl(BLEACHING,' '),nvl(BLEACHING_WORKING,' '),nvl(LIQUID_CHILORINE,' '),nvl(LIQUID_CHILORINE_WORKING,' '),nvl(GAS_CHILORINE,' '),nvl(GAS_CHILORINE_WORKING,' '),nvl(ONLINE_DOSE,' '),nvl(ONLINE_DOSE_WORKING,' '),nvl(REMARKS,' '),ASSET_CODE from preduser.RWS_AST_CHLORINATION_TBL where asset_code=? and hab_code=?";
				preparedStatement5=conn.prepareStatement(CHLORINATIONTableQuery);
				preparedStatement5.setString(1, ac);
				preparedStatement5.setString(2, frm.getHabCode());
				rs5=preparedStatement5.executeQuery();
				while(rs5.next()){
					String finalSourceCode=habcode+rs5.getString(1).substring(16,21);
					String sourcemaxQuery="select max(substr(CL_CODE,22,3)) from RWS_AST_CHLORINATION_TBL where substr(CL_CODE,1,21)=?";
					preparedStatement1=conn.prepareStatement(sourcemaxQuery);
					preparedStatement1.setString(1, finalSourceCode);
					rs1=preparedStatement1.executeQuery();
					if(rs1.next()){
						Integer sourcemaxCode=rs1.getInt(1)+1;					
						if(sourcemaxCode.toString().length()==1){
							finalSourceCode=finalSourceCode+"00"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==2){
							finalSourceCode=finalSourceCode+"0"+sourcemaxCode.toString();
						}
						else if(sourcemaxCode.toString().length()==3){
							finalSourceCode=finalSourceCode+sourcemaxCode.toString();
						}
					}
					else{
						finalSourceCode=finalSourceCode+"001";
					}
					preparedStatement1.close();
					rs1.close();
					
					String insertSourceTableQuery="insert into RWS_AST_CHLORINATION_TBL(ASSET_CODE,GRAVITYMAIN_CODE,HAB_CODE,LENGTH,AIRVALVE_NO,SCOUREVALVE,REFLEXVALVE,SLUICEVALVE,MET_TYPE,NO_OF_PIPES,LOCATION,ZERO_VELOCITY_VALVE,AIR_CUSHION_VALVE,NON_RETURN_VALVE) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					preparedStatement6=conn.prepareStatement(insertSourceTableQuery); 
					preparedStatement6.setString(1, finalAssetcode);
					preparedStatement6.setString(2, finalSourceCode);
					preparedStatement6.setString(3, habcode);
					preparedStatement6.setString(4, rs5.getString(4));
					preparedStatement6.setString(5, rs5.getString(5));
					preparedStatement6.setString(6, rs5.getString(6));
					preparedStatement6.setString(7, rs5.getString(7));
					preparedStatement6.setString(8, rs5.getString(8));
					preparedStatement6.setString(9, rs5.getString(9));
					preparedStatement6.setString(10, rs5.getString(10));
					preparedStatement6.setString(11, rs5.getString(11));
					preparedStatement6.setString(12, rs5.getString(12));
					preparedStatement6.setString(13, rs5.getString(13));
					preparedStatement6.setString(14, rs5.getString(14));					
					preparedStatement6.executeUpdate();
					preparedStatement6.close();
					
					String schemecode=finalSourceCode.substring(0,19);
					String insertSchemes="insert into RWS_ASSET_SCHEME_TBL values(?,?)";
					preparedStatement7=conn.prepareStatement(insertSchemes);
					preparedStatement7.setString(1, finalAssetcode);
					preparedStatement7.setString(2, schemecode);
					preparedStatement7.executeUpdate();
					preparedStatement7.close();
				}
				preparedStatement5.close();
				rs5.close();
				
			}
			ps.close();
			rs.close();			
			count=count+n;			
			}
				preparedStatement4.close();
				rs4.close();			
			if (count >0) {				
				message="Assets Updated Successfully";					
			} else {				
				message="Updation Failed";
			}
		  }
		}
		catch(Exception e){
			System.out.println("The Exception in AssetReConvertDAO covertOldHabToNewHab is "+e.getMessage());
		}
		return message;
	}
}
