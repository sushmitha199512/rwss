package nic.watersoft.masters;


import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;


public class HabReConvertDAO {
	private DataSource dataSource = null;
	private Connection conn = null;
	private Statement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private LabelValueBean labelValueBean = null;
	private RwsLocationBean rwsLocation = null;	
	
	private Statement stmt = null;
	private ResultSet rs = null;	
	
	//Deepak Modified 
		public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			//query = "SELECT DCODE, DNAME FROM  RWS_DISTRICT_TBL WHERE DCODE='22' ORDER BY DCODE,DNAME";
			query = "SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL  ORDER BY DCODE,DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReCovertDAO getDistricts : "+e.getMessage());
		} 
		return dists;
	}
		
	public ArrayList getDistrictMandals1(String dcode) throws Exception {
			ArrayList mandals = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				query = "SELECT mcode, mname FROM rws_mandal_tbl where dcode= ? ORDER BY mname";
				System.out.println("query query :"+query);
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
				System.out.println("The Exception is in HabReConvertDAO getDistrictMandals1 : "+e.getMessage());	
			} 
			return mandals;
		}
		
		//Deepak Modified 
		public ArrayList getPanchayats1(String dcode, String mcode) throws Exception {
			ArrayList panchayats = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				query = " SELECT pcode, pname FROM rws_panchayat_tbl where dcode=? and mcode=? ORDER BY pname";
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
				 System.out.println("The Exception in HabReConvertDAO getPanchayats1 is "+e.getMessage());
			} 
			return panchayats;
		}
		
		//Deepak Modified 
		public ArrayList getVillages1(String dcode, String mcode, String pcode) throws Exception {
			ArrayList villages = new ArrayList();
			try {
					conn = RwsOffices.getConn();
					query = "SELECT vcode, vname FROM rws_village_tbl where dcode=? and mcode=? and pcode=? ORDER BY vname";
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
					 System.out.println("The Exception is in HabReConvertDAO getVillages1 : "+e.getMessage());
				} 
				return villages;
			}
		
		//Deepak Modified 
		public  ArrayList getNewHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception {
			ArrayList habs=new ArrayList();			  
			String query="";
			try	{
				conn = RwsOffices.getConn();
				Statement stmt1 = conn.createStatement();
				query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_directory_tbl b WHERE a.panch_code=b.hab_code and " +
				" SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? ";
				//System.out.println("hab query :"+query);
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
			catch (Exception e)	{
				System.out.println("The Exception is in HabReConvertDAO getNewHabitations : "+e.getMessage());
			}			
			return habs;
		}			
	
	//Deepak Modified 
	public ArrayList getDistricts1() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT dcode, dname FROM aprwssuser.rws_district_tbl where dcode in ('04','05') ORDER BY dcode,dname";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReConvertDAO getDistricts1 : " +e.getMessage());
		} 
		return dists;
	}

	//Deepak Modified 
	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {			
			conn = RwsOffices.getConn();
			query = " SELECT mcode, mname FROM  rws_mandal_tbl where dcode=? ORDER BY mname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReConvertDAO getDistrictMandals : "+e.getMessage());
		} 
		return dists;
	}
	
	//Deepak Modified 
	public ArrayList getPanchayats(String dcode,String mcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT pcode, pname FROM  rws_panchayat_tbl where dcode=? and mcode=? ORDER BY pname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2,mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReConvertDAO getPanchayats : "+e.getMessage());
		} 
		return dists;
	}
	
	//Deepak Modified 
	public ArrayList getVillages(String dcode,String mcode,String pcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {			
			conn = RwsOffices.getConn();			
			query = "SELECT vcode, vname FROM  rws_village_tbl where dcode=? and mcode=? and pcode=? ORDER BY vname";
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
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReConvertDAO getVillages : "+e.getMessage());
		} finally {
			
		}
		return dists;
	}
	
	//Deepak Modified 
	public ArrayList getUIHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM  RWS_PANCHAYAT_RAJ_TBL a, rws_habitation_directory_tbl b "
				+ " WHERE a.panch_code=b.hab_code and SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? ";
			System.out.println("query hab :"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);System.out.println("query dcode :"+dcode);
			ps.setString(2, mcode);System.out.println("query mcode :"+mcode);
			ps.setString(3, pcode);System.out.println("query pcode :"+pcode);
			ps.setString(4, vcode);System.out.println("query vcode :"+vcode);
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
			System.out.println("The Exception is in HabReConvertDAO getUIHabitations : "+e.getMessage());
		}
		return dists;
	}	
	
	public String convertHabStatus(String habCodeOld,String habCodeNew,String coveredStatus,HttpServletRequest request){
		ArrayList supplyList = new ArrayList();		
		String message="";
		Connection con = null;
		String q="",qry="";
		String qry1="";
		 int count=0;
		PreparedStatement stmt = null;
		PreparedStatement stmt4=null;
		try	{
			Connection conn = null;
			PreparedStatement stmt1 = null;
			ResultSet rs = null;
			ResultSet rs2=null;
			PreparedStatement stmt3=null;			
			HabConvertDao hd = new HabConvertDao();			
			conn = RwsOffices.getConn();		
			q = "select HAB_CODE,nvl(SHP_DK_SUPPLY,0),nvl(SHP_NO,0),nvl(CISTERNS_DK_SUPPLY,0),nvl(CISTERNS_NO,0),nvl(GLSRS_DK_SUPPLY,0),nvl(GLSRS_NO,0),nvl(OHSRS_DK_SUPPLY,0),nvl(OHSRS_NO,0),nvl(HPS_OTH_SUPPLY,0),nvl(HPS_NO,0),nvl(OWS_OTH_SUPPLY,0),nvl(OWS_NO,0),nvl(PONDS_OTH_SUPPLY,0),nvl(PONDS_NO,0),nvl(SHWELL_OTH_SUPPLY,0),nvl(SHWELL_NO,0),nvl(PCPD_DRINK,0),nvl(PCPD_OTHERS,0),nvl(STAT_OF_HAB,0),nvl(PWS_SUPPLY,0),nvl(PWS_NO,0),nvl(MPWS_SUPPLY,0),nvl(MPWS_NO,0),nvl(CPWS_SUPPLY,0),nvl(CPWS_NO,0),nvl(DIRECT_PUMPING_SUPPLY,0),nvl(DIRECT_PUMPING_NO,0),nvl(DW_TANKS_SUPPLY,0),nvl(DW_TANKS_NO,0),nvl(CATTLE_SUPPLY,0),nvl(CATTLE_NO,0),nvl(OTHERS_NO,0),nvl(OTHERS_SUPPLY,0),nvl(HPS_OTH_SUPPLY_UNSAFE,0),nvl(HPS_NO_UNSAFE,0),nvl(OTHERS_SUPPLY_SAFE,0),nvl(OTHERS_NO_SAFE,0),nvl(PWS_UNSAFE_SUPPLY,0),nvl(PWS_UNSAFE_NO,0),nvl(MPWS_UNSAFE_SUPPLY,0),nvl(MPWS_UNSAFE_NO,0),nvl(SHP_DK_SUPPLY_SAFE,0),nvl(SHP_NO_SAFE,0) from   rws_hab_supply_status_tbl where  hab_code= ? ";
			stmt3=conn.prepareStatement(q);
			stmt3.setString(1, habCodeOld);
			rs2 = stmt3.executeQuery();
			if(rs2.next()){
				ReconvertionForm form=new ReconvertionForm();	
				form.setHpHabCode(rs2.getString(1));
				form.setShpDkSupply(rs2.getString(2));
				form.setShpNo(rs2.getString(3));
				form.setCisternsDkSupply(rs2.getString(4));
				form.setCisternsNo(rs2.getString(5));
				form.setGlsrDksSupply(rs2.getString(6));
				form.setGlsrNo(rs2.getString(7));
				form.setOhsrDkSupply(rs2.getString(8));
				form.setOhsrNo(rs2.getString(9));
				form.setHpOthSupply(rs2.getString(10));
				form.setHpNo(rs2.getString(11));
				form.setOwsOthSupply(rs2.getString(12));
				form.setOwsNo(rs2.getString(13));
				form.setPondsOthSupply(rs2.getString(14));
				form.setPondsNo(rs2.getString(15));
				form.setShwellOthSuply(rs2.getString(16));
				form.setShwellNo(rs2.getString(17));
				form.setPcpdDrink(rs2.getString(18));
				form.setPcpdOthers(rs2.getString(19));
				form.setStateOfHab(rs2.getString(20));
				form.setPwsSupply(rs2.getString(21));
				form.setPwsNo(rs2.getString(22));
				form.setMpwsSupply(rs2.getString(23));
				form.setMpwsNo(rs2.getString(24));
				form.setCpwsSupply(rs2.getString(25));
				form.setCpwsNo(rs2.getString(26));
				form.setDirectPumpSupply(rs2.getString(27));
				form.setDirectPumpingNo(rs2.getString(28));
				form.setDwTankSupply(rs2.getString(29));
				form.setDwTankNo(rs2.getString(30));
				form.setCattleSupply(rs2.getString(31));
				form.setCattleNo(rs2.getString(32));
				form.setOthersNo(rs2.getString(33));
				form.setOthersSupply(rs2.getString(34));
				form.setHpsOthSupplyUnsafe(rs2.getString(35));
				form.setHpsNoUnsafe(rs2.getString(36));
				form.setOthersSupplySafe(rs2.getString(37));
				form.setOthersNoSafe(rs2.getString(38));
				form.setPwsUnsafeSupply(rs2.getString(39));
				form.setPwsUnsafeNo(rs2.getString(40));
				form.setMpwsUnsafeSupply(rs2.getString(41));
				form.setMpwsUnsafeNo(rs2.getString(42));
				form.setShpDkSupplySafe(rs2.getString(43));
				form.setShpNoSafe(rs2.getString(44));				
				supplyList.add(form);				
				if(!isExists(habCodeNew)){
					qry="insert into rws_hab_supply_status_tbl(HAB_CODE,SHP_DK_SUPPLY,SHP_NO,CISTERNS_DK_SUPPLY,CISTERNS_NO,GLSRS_DK_SUPPLY,GLSRS_NO,OHSRS_DK_SUPPLY,OHSRS_NO,HPS_OTH_SUPPLY,HPS_NO,OWS_OTH_SUPPLY,OWS_NO,PONDS_OTH_SUPPLY,PONDS_NO,SHWELL_OTH_SUPPLY,SHWELL_NO,PCPD_DRINK,PCPD_OTHERS,STAT_OF_HAB ,PWS_SUPPLY,PWS_NO,MPWS_SUPPLY,MPWS_NO,CPWS_SUPPLY,CPWS_NO,DIRECT_PUMPING_SUPPLY,DIRECT_PUMPING_NO,DW_TANKS_SUPPLY,DW_TANKS_NO,CATTLE_SUPPLY,CATTLE_NO,OTHERS_NO,OTHERS_SUPPLY,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE,OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE ,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO,SHP_DK_SUPPLY_SAFE,SHP_NO_SAFE) values('"+habCodeNew+"','"+form.getShpDkSupply()+"','"+form.getShpNo()+"','"+form.getCisternsDkSupply()+"','"+form.getCisternsNo()+"','"+form.getGlsrDksSupply()+"','"+form.getGlsrNo()+"','"+form.getOhsrDkSupply()+"','"+form.getOhsrNo()+"','"+form.getHpOthSupply()+"','"+form.getHpNo()+"','"+form.getOwsOthSupply()+"','"+form.getOwsNo()+"','"+form.getPondsOthSupply()+"','"+form.getPondsNo()+"','"+form.getShwellOthSuply()+"','"+form.getShwellNo()+"','"+form.getPcpdDrink()+"','"+form.getPcpdOthers()+"','"+form.getStateOfHab()+"','"+form.getPwsSupply()+"','"+form.getPwsNo()+"','"+form.getMpwsSupply()+"','"+form.getMpwsNo()+"','"+form.getCpwsSupply()+"','"+form.getCpwsNo()+"','"+form.getDirectPumpSupply()+"','"+form.getDirectPumpingNo()+"','"+form.getDwTankSupply()+"','"+form.getDwTankNo()+"','"+form.getCattleSupply()+"','"+form.getCattleNo()+"','"+form.getOthersNo()+"','"+form.getOthersSupply()+"','"+form.getHpsOthSupplyUnsafe()+"','"+form.getHpsNoUnsafe()+"','"+form.getOthersSupplySafe()+"','"+form.getOthersNoSafe()+"','"+form.getPwsUnsafeSupply()+"','"+form.getPwsUnsafeNo()+"','"+form.getMpwsUnsafeSupply()+"','"+form.getMpwsUnsafeNo()+"','"+form.getShpDkSupplySafe()+"','"+form.getShpNoSafe()+"') ";
				}
				else{
					qry="update rws_hab_supply_status_tbl set SHP_DK_SUPPLY='"+form.getShpDkSupply()+"',SHP_NO='"+form.getShpNo()+"',CISTERNS_DK_SUPPLY='"+form.getCisternsDkSupply()+"',CISTERNS_NO='"+form.getCisternsNo()+"',GLSRS_DK_SUPPLY='"+form.getGlsrDksSupply()+"',GLSRS_NO='"+form.getGlsrNo()+"',OHSRS_DK_SUPPLY='"+form.getOhsrDkSupply()+"',OHSRS_NO='"+form.getOhsrNo()+"',HPS_OTH_SUPPLY='"+form.getHpOthSupply()+"',HPS_NO='"+form.getHpNo()+"',OWS_OTH_SUPPLY='"+form.getOwsOthSupply()+"',OWS_NO='"+form.getOwsNo()+"',PONDS_OTH_SUPPLY='"+form.getPondsOthSupply()+"',PONDS_NO='"+form.getPondsNo()+"',SHWELL_OTH_SUPPLY='"+form.getShwellOthSuply()+"',SHWELL_NO='"+form.getShwellNo()+"',PCPD_DRINK='"+form.getPcpdDrink()+"',PCPD_OTHERS='"+form.getPcpdOthers()+"',STAT_OF_HAB='"+form.getStateOfHab()+"' ,PWS_SUPPLY='"+form.getPwsSupply()+"',PWS_NO='"+form.getPwsNo()+"',MPWS_SUPPLY='"+form.getMpwsSupply()+"',MPWS_NO='"+form.getMpwsNo()+"',CPWS_SUPPLY='"+form.getCpwsSupply()+"',CPWS_NO='"+form.getCpwsNo()+"',DIRECT_PUMPING_SUPPLY='"+form.getDirectPumpSupply()+"',DIRECT_PUMPING_NO='"+form.getDirectPumpingNo()+"',DW_TANKS_SUPPLY='"+form.getDwTankSupply()+"',DW_TANKS_NO='"+form.getDwTankNo()+"',CATTLE_SUPPLY='"+form.getCattleSupply()+"',CATTLE_NO='"+form.getCattleNo()+"',OTHERS_NO='"+form.getOthersNo()+"',OTHERS_SUPPLY='"+form.getOthersSupply()+"',HPS_OTH_SUPPLY_UNSAFE='"+form.getHpsOthSupplyUnsafe()+"',HPS_NO_UNSAFE='"+form.getHpsNoUnsafe()+"',OTHERS_SUPPLY_SAFE='"+form.getOthersSupplySafe()+"',OTHERS_NO_SAFE='"+form.getOthersNoSafe()+"' ,PWS_UNSAFE_SUPPLY='"+form.getPwsUnsafeSupply()+"',PWS_UNSAFE_NO='"+form.getPwsUnsafeNo()+"',MPWS_UNSAFE_SUPPLY='"+form.getMpwsUnsafeSupply()+"',MPWS_UNSAFE_NO='"+form.getMpwsUnsafeNo()+"',SHP_DK_SUPPLY_SAFE='"+form.getShpDkSupplySafe()+"',SHP_NO_SAFE='"+form.getShpNoSafe()+"' where  hab_code='"+habCodeNew+"'";
				}		
				stmt4=conn.prepareStatement(qry);
				stmt4.setString(1, habCodeNew);
				stmt4.setString(2, form.getShpDkSupply());
				stmt4.setString(3, form.getShpNo());
				stmt4.setString(4, form.getCisternsDkSupply());
				stmt4.setString(5, form.getCisternsNo());
				stmt4.setString(6, form.getGlsrDksSupply());
				stmt4.setString(7, form.getGlsrNo());
				stmt4.setString(8, form.getOhsrDkSupply());
				stmt4.setString(9, form.getOhsrNo());
				stmt4.setString(10, form.getHpOthSupply());
				stmt4.setString(11, form.getOthersSupplySafe());
				stmt4.setString(11, x);
				form.getPwsUnsafeNo()
				form.getMpwsUnsafeNo()
				form.getShpDkSupplySafe()
				form.getShpNoSafe()
				count=stmt4.executeUpdate();	
			}				
			if (count >0) {
				message="Records Updated Successfully";				
			} else {				
				message="Updation Failed";
			}			
		}
		catch(Exception e){
			System.out.println("The Exception is in HabReConvertDAO convertHabStatus : "+e.getMessage());
		}		
		return message;
	}	
	
	private boolean isExists(String habCodeNew) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;
		try {
			conn = RwsOffices.getConn();
			query = "select *  from rws_hab_supply_status_tbl  where HAB_CODE= ? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, habCodeNew);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;				
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in HabReConvertDAO isExists : "+e.getMessage());
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in HabReConvertDAO isExists : "+e.getMessage());
			}
		}
		return false;
	}
	
	//Deepak Modified 
	public String covertOldHabToNewHab(String habCodeOld,String habCodeNew,String coveredStatus,HttpServletRequest request) {
		ArrayList returnList = new ArrayList();		
		String message="";
		Connection con = null;
		String q="",qry="";
		String qry1="";
		 int count=0;
		PreparedStatement stmt = null;
		try{
			Connection conn = null;
			PreparedStatement stmt1 = null;
			ResultSet rs = null;
			ResultSet rs1=null;
			PreparedStatement stmt2=null;			
			HabConvertDao hd = new HabConvertDao();			
			conn = RwsOffices.getConn();
			q = "select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,to_char(STATUS_DATE,'dd/mm/yyyy'),PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,to_char(UPDATE_DATE,'dd/mm/yyyy'),QUALITY_AFFECTED,PREVIOUS_YR_STATUS,nvl(PRESENT_YR_STATUS,0),PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY ,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,nvl(NC_SOURCE_TYPE,0),SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED  ,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA  ,HOUSEHOLDS_SC,HOUSEHOLDS_ST,HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU  from  rws_habitation_directory_tbl where hab_code= ? ";
			ps = conn.prepareStatement(q);
			ps.setString(1, habCodeOld);
			rs = ps.executeQuery();
			if(rs.next()){
				ReconvertionForm form=new ReconvertionForm();
				String dcode=habCodeNew.substring(0,2);
				String mcode=habCodeNew.substring(5,7);
				qry1="select circle_office_code,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE from RWS_MANDAL_SUBDIVISION_TBL  where dcode= ? and mcode= ? ";
				 stmt2=conn.prepareStatement(qry1);
				 stmt2.setString(1, dcode);
				 stmt2.setString(2, mcode);
				 rs1=stmt2.executeQuery();
				 if(rs1.next()){
					 form.setDcodenew(rs1.getString(1)); 
					 form.setMcoded(rs1.getString(1));
					 form.setSubcode(rs1.getString(2));
				 }				 
				form.setCircle(rs.getString(1));
				form.setDivision(rs.getString(2));
				form.setSubdivision(rs.getString(3));
				form.setHabcode(rs.getString(4));
				form.setCensusYear(rs.getString(5));
				form.setCensusPlainPopu(rs.getString(6));
				form.setCensuScPopu(rs.getString(7));
				form.setCensusStPopu(rs.getString(8));
				form.setFloatPopu(rs.getString(9));
				form.setFloatPopuReasn(rs.getString(10));
				form.setStatusDate(rs.getString(11));
				form.setPlainPopuCovered(rs.getString(12));
				form.setScPopCov(rs.getString(13));
				form.setSctPopCov(rs.getString(14));
				form.setTotWaterSupply(rs.getString(15));
				form.setExistWaterLevel(rs.getString(16));
				form.setCoverageStatus(rs.getString(17));
				form.setNearSurfaceSource(rs.getString(18));
				form.setNearGroundSource(rs.getString(19));
				form.setRemarks(rs.getString(20));
				form.setQualityEffected(rs.getString(22));
				form.setUpdateDate(rs.getString(21));
				form.setPrevYearStatus(rs.getString(23));
				form.setPresYearStatus(rs.getString(24));
				form.setPraposedFcStatus(rs.getString(25));
				form.setPraposedFcEstAmount(rs.getString(26));
				form.setHabitationType(rs.getString(27));
				form.setHouseholdNo(rs.getString(28));
				form.setSlippageCode(rs.getString(29));
				form.setNoOfCattle(rs.getString(30));
				form.setHabCategory(rs.getString(31));
				form.setExistSourceNo(rs.getString(32));
				form.setSafeSourceNo(rs.getString(33));
				form.setHabSubType1(rs.getString(34));
				form.setNcSourceType(rs.getString(35));
				form.setSourceDistance(rs.getString(36));
				form.setLpcdCooking(rs.getString(37));
				form.setPopuPresCov(rs.getString(38));
				form.setMinorityDomminated(rs.getString(39));
				form.setLwe(rs.getString(40));
				form.setUnsafeLpcd(rs.getString(41));
				form.setSafeLpcd(rs.getString(42));
				form.setHabSubType(rs.getString(43));
				form.setTspNtsp(rs.getString(44));
				form.setDdwsHabcode(rs.getString(45));
				form.setNoOfHouseConnGiven(rs.getString(46));
				form.setIsItDa(rs.getString(47));
				form.setHouseHoldsSc(rs.getString(48));
				form.setHouseHoldsST(rs.getString(49));
				form.setHouseHoldsPlain(rs.getString(50));
				form.setConSc(rs.getString(51));
				form.setConSt(rs.getString(52));
				form.setConPlain(rs.getString(53));
				form.setHouseHoldsMinority(rs.getString(54));
				form.setConMinority(rs.getString(55));
				form.setMinPopuCov(rs.getString(56));
				form.setCensusMinorityPopu(rs.getString(57));				
				returnList.add(form);	
				qry="update rws_habitation_directory_tbl set CIRCLE_OFFICE_CODE= ? ,DIVISION_OFFICE_CODE= ? ,SUBDIVISION_OFFICE_CODE= ? ,CENSUS_YEAR= ? ,CENSUS_PLAIN_POPU= ? ,CENSUS_SC_POPU= ? ,CENSUS_ST_POPU= ? ,FLOAT_POP= ? ,FLOAT_POP_REASONS= ? ,STATUS_DATE=to_date( ? ,'dd/mm/yyyy') ,PLAIN_POPU_COVERED= ? ,SC_POP_COVERED= ? ,ST_POP_COVERED= ? ,TOTAL_WATER_SUPPLY= ? ,EXIST_WATER_LEVEL= ? ,COVERAGE_STATUS= ? ,NEAR_SURFACE_SOURCE= ? ,NEAR_GROUND_SOURCE= ? , REMARKS= ? ,QUALITY_AFFECTED= ? ,UPDATE_DATE=to_date( ? ,'dd/mm/yyyy') ,PREVIOUS_YR_STATUS= ? ,PRESENT_YR_STATUS= ? ,PROPOSED_FC_YEAR= ? ,PROPOSED_FC_EST_AMT= ? ,HABITATION_TYPE= ? ,HOUSEHOLD_NO= ? ,SLIPPAGE_CODE= ? ,NO_OF_CATTLE= ? ,HABITATION_CATEGORY= ? ,EXISTING_SOURCES_NO= ? ,SAFE_SOURCES_NO= ? ,HABITATION_SUB_TYPE= ? ,NC_SOURCE_TYPE= ? ,SOURCE_DISTANCE= ? ,LPCD_COOKING= ? ,POPU_PERCENT_COVERED= ? ,MINORITY_DOMINATED= ? ,LWE= ? ,UNSAFE_LPCD= ? ,SAFE_LPCD= ? ,HAB_SUB_TYPE_40PC_CALC= ? ,TSP_NTSP= ? ,DDWS_HAB_CODE= ? ,NO_OF_HOUSECONN_GIVEN= ? ,IS_ITDA= ? ,HOUSEHOLDS_SC= ? ,HOUSEHOLDS_ST= ? ,HOUSEHOLDS_PLAIN= ? ,CON_SC= ? ,CON_ST= ? ,CON_PLAIN= ? ,HOUSEHOLDS_MINORITY= ? ,CON_MINORITY= ? ,MINORITY_POP_COVERED= ? , CENSUS_MINORITY_POPU= ? where hab_code= ? ";
				stmt1=conn.prepareStatement(qry);
				stmt1.setString(1, form.getDcodenew());
				stmt1.setString(2, form.getMcoded());
				stmt1.setString(3, form.getSubcode());
				stmt1.setString(4, form.getCensusYear());
				stmt1.setString(5, form.getCensusPlainPopu());
				stmt1.setString(6, form.getCensuScPopu());
				stmt1.setString(7, form.getCensusStPopu());
				stmt1.setString(8, form.getFloatPopu());
				stmt1.setString(9, form.getFloatPopuReasn());
				stmt1.setString(10, form.getStatusDate());
				stmt1.setString(11, form.getPlainPopuCovered());
				stmt1.setString(12, form.getScPopCov());
				stmt1.setString(13, form.getSctPopCov());
				stmt1.setString(14, form.getTotWaterSupply());
				stmt1.setString(15, form.getExistWaterLevel());
				stmt1.setString(16, form.getCoverageStatus());
				stmt1.setString(17, form.getNearSurfaceSource());
				stmt1.setString(18, form.getNearGroundSource());
				stmt1.setString(19, form.getRemarks());
				stmt1.setString(20, form.getQualityEffected());
				stmt1.setString(21, form.getUpdateDate());
				stmt1.setString(22, form.getPrevYearStatus());
				stmt1.setString(23, form.getPresYearStatus());
				stmt1.setString(24, form.getPraposedFcStatus());
				stmt1.setString(25, form.getPraposedFcEstAmount());
				stmt1.setString(26, form.getHabitationType());
				stmt1.setString(27, form.getHouseholdNo());
				stmt1.setString(28, form.getSlippageCode());
				stmt1.setString(29, form.getNoOfCattle());
				stmt1.setString(30, form.getHabCategory());
				stmt1.setString(31, form.getExistSourceNo());
				stmt1.setString(32, form.getSafeSourceNo());
				stmt1.setString(33, form.getHabSubType1());
				stmt1.setString(34, form.getNcSourceType());
				stmt1.setString(35, form.getSourceDistance());
				stmt1.setString(36, form.getLpcdCooking());
				stmt1.setString(37, form.getPopuPresCov());
				stmt1.setString(38, form.getMinorityDomminated());
				stmt1.setString(39, form.getLwe());
				stmt1.setString(40, form.getUnsafeLpcd());
				stmt1.setString(41, form.getSafeLpcd());
				stmt1.setString(42, form.getHabSubType());
				stmt1.setString(43, form.getTspNtsp());
				stmt1.setString(44, form.getDdwsHabcode());
				stmt1.setString(45, form.getNoOfHouseConnGiven());
				stmt1.setString(46, form.getIsItDa());
				stmt1.setString(47, form.getHouseHoldsSc());
				stmt1.setString(48, form.getHouseHoldsST());
				stmt1.setString(49, form.getHouseHoldsPlain());
				stmt1.setString(50, form.getConSc());
				stmt1.setString(51, form.getConSt());
				stmt1.setString(52, form.getConPlain());
				stmt1.setString(53, form.getHouseHoldsMinority());
				stmt1.setString(54, form.getConMinority());
				stmt1.setString(55, form.getMinPopuCov());
				stmt1.setString(56, form.getCensusMinorityPopu());
				stmt1.setString(57, habCodeNew);
				count=stmt1.executeUpdate();				
			}
			if (count >0) {
				convertHabStatus(habCodeOld, habCodeNew, coveredStatus, request);
				message="Records Updated Successfully";				
			} else {				
				message="Updation Failed";
			}
		}
		catch(Exception e){
			System.out.println("The Exception in HabReConvertDAO covertOldHabToNewHab : "+e.getMessage());		
		}
		return message;
	}	
	
	public ResultSet getResultSet(String qry,Connection con) throws Exception{
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement(qry);
			rs = stmt.executeQuery();
		}
		catch(Exception e){
			System.out.println("The Exception in HabReConvertDAO getResultSet : "+e.getMessage());
		}
		return rs;
	}
	
	public int executeUpdating(String qry,Connection con) throws Exception {
		PreparedStatement stmt = null;
		int i = 0;
		stmt = con.prepareStatement(qry);
		i = stmt.executeUpdate();
		return i;
	}
	
	public int executeUpdating1(String qry,Connection con) throws Exception {
		PreparedStatement stmt = null;
		int i = 0;
		try	{
			stmt = con.prepareStatement(qry);
			i = stmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("The Exception is in HabReConvertDAO executeUpdating1 : "+e.getMessage());
		}
		finally	{
			try{
				closeStatement(stmt);
			}
			catch(Exception ee)	{
				System.out.println("The Exception is in HabReConvertDAO executeUpdating1 : "+ee.getMessage());
			}			
		}
		return i;
	}
	
	public static void closeResultSet(ResultSet rs)	{
		try {
				if(rs!=null){
					rs.close();
					rs = null;
				}
		}catch (SQLException e){
			System.out.println("The Exception is in HabReConvertDAO closeResultSet : "+e.getMessage());
		}
	}
	
	public static void closeStatement(Statement stmt){
		try {
				if(stmt!=null){
					stmt.close();
					stmt = null;
				}
			} 
			catch (SQLException e){
				System.out.println("The Exception is in HabReConvertDAO closeStatement : "+e.getMessage());
		}
	}
	
	public static void closeConnection(Connection conn){
		try {
				if(conn!=null)
				{
					conn.close();
					conn = null;
				}
			} 
			catch (SQLException e){
				System.out.println("The Exception is in HabReConvertDAO closeConnection : "+e.getMessage());
		}
	}


}
