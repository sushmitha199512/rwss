package nic.watersoft.wquality;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;

public class SourceHabMasterData {
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	int connCount = 0;
	PreparedStatement ps = null;
	
	public SourceHabMasterData() {	}
	
	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;		
		ResultSet rs = null;		
		int connCount = 0;		
		PreparedStatement ps = null;
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				System.out.println("The exception in SourceHabMasterData = "+e.getMessage());
			}
			rs = null;
		}
		
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				System.out.println("The exception in SourceHabMasterData = "+e.getMessage());
			}
			ps = null;
		}
		
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				System.out.println("The exception in SourceHabMasterData = "+e.getMessage());
			}
			conn = null;
		}
	}
	
	public ArrayList getCircles(DataSource dataSource) throws Exception {
		ArrayList districts;
		String query="";
		SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
		LabelValueBean sourceHabForm = null;
		districts = new ArrayList();
		PreparedStatement ps=null;
		try {
			sourceHabMasterData.conn = RwsOffices.getConn();
			query="select CIRCLE_OFFICE_CODE ,CIRCLE_OFFICE_NAME from RWS_CIRCLE_OFFICE_TBL a,RWS_HEAD_OFFICE_TBL  b where  a.HEAD_OFFICE_CODE =b.HEAD_OFFICE_CODE  and a.HEAD_OFFICE_CODE='1'";
			ps=sourceHabMasterData.conn.prepareStatement(query);	
			sourceHabMasterData.rs=ps.executeQuery();
			while (sourceHabMasterData.rs.next()) {
				sourceHabForm = new LabelValueBean();
				sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
				sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
				sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
				districts.add(sourceHabForm);
			}

		} catch (Exception e) {
			System.out.println("The exception in SourceHabMasterData getCircles = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return districts;
 }

public ArrayList getDistricts1(DataSource dataSource) throws Exception {
	ArrayList districts;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	districts = new ArrayList();
	PreparedStatement ps=null;

	try {
		sourceHabMasterData.conn = RwsOffices.getConn();	
		query = "select  d.dcode,d.dname from rws_district_tbl d where dcode<>'16' order by d.dname";
	    ps=sourceHabMasterData.conn.prepareStatement(query);	
	    sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2)	+ " - " + sourceHabMasterData.rs.getString(1));
			districts.add(sourceHabForm);
		}

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getDistricts1 = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return districts;
}

public ArrayList getHabslist(DataSource dataSource,String dist,String mcode,String pcode,String  vcode) {
		ArrayList habitationslist = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try {
			String query = "select panch_code,panch_name,COVERAGE_STATUS from rws_complete_hab_view a where dcode= ? and mcode= ? and pcode= ? and vcode= ? ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, dist);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setPanchCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setStatus(rset.getString(3));
				habitationslist.add(sourceHabFormBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in SourceHabMasterData getHabslist = "+e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
					System.out.println("The exception in SourceHabMasterData getHabslist = "+sqle.getMessage());
				}
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (SQLException sqle) {
					System.out.println("The exception in SourceHabMasterData getHabslist = "+sqle.getMessage());
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
					System.out.println("The exception in SourceHabMasterData getHabslist = "+sqle.getMessage());
				}
			}
		}
		return habitationslist;
	}

public ArrayList getshowhabs(String sourceCode) {
	ArrayList habitations1 = new ArrayList();
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	try {
		if(sourceCode.substring(19,21).equals("SO")){
			String query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,rws_source_tbl b where a.hab_code=b.hab_code and b.source_code= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
		while (rset.next()) {
			sourceHabFormBean = new SourceHabFormBean();
			sourceHabFormBean.setHabCode(rset.getString(1));
			sourceHabFormBean.setHabName(rset.getString(2));
			sourceHabFormBean.setMandalName(rset.getString(3));
			sourceHabFormBean.setPopulation(rset.getString(4));
			sourceHabFormBean.setStatus1(rset.getString(5));
			habitations1.add(sourceHabFormBean);
		}
	}
	else if(sourceCode.substring(19,21).equals("HP")){
			String query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_HP_SUBCOMP_PARAM_TBL b where a.hab_code=substr(b.hp_code,1,16) and b.HP_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);
			}
		}
		else if(sourceCode.substring(19,21).equals("OW")){
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_OPEN_WELL_MAST_TBL b where a.hab_code=b.HABITATION_CODE  and b.OPENWELL_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);
			}
		}
		else if(sourceCode.substring(19,21).equals("OS")){
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_OHSR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.OHSR_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);
			}
		}
		else if(sourceCode.substring(19,21).equals("GL")){
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_GLSR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.GLSR_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);
			}
		}
		else if(sourceCode.substring(19,21).equals("SH")){
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_SHALLOWHANDPUMPS_TBL b where a.hab_code=b.hab_code  and b.SHALLOWHP_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);			
			}
		}
		else if(sourceCode.substring(19,21).equals("PD")){			
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_OPENWELL_POND_TBL b where a.hab_code=b.hab_code  and b.POND_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);			
			}
		}
		
		else if(sourceCode.substring(19,21).equals("GB")){
			String query="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_GLBR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.GLBR_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			SourceHabFormBean sourceHabFormBean = null;
			
			while (rset.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setHabCode(rset.getString(1));
				sourceHabFormBean.setHabName(rset.getString(2));
				sourceHabFormBean.setMandalName(rset.getString(3));
				sourceHabFormBean.setPopulation(rset.getString(4));
				sourceHabFormBean.setStatus1(rset.getString(5));
				habitations1.add(sourceHabFormBean);			
			}
		}		
		
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getshowhabs = "+e.getMessage());
	} finally {
		if (rset != null) {
			try {
				if (rset != null)
					rset.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getshowhabs = "+sqle.getMessage());
			}
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getshowhabs = "+sqle.getMessage());
			}
		}
		if (conn != null) {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getshowhabs = "+sqle.getMessage());
			}
		}
	}
	return habitations1;
}
	
	public ArrayList getMandals(DataSource dataSource,String dcode) throws Exception {
		ArrayList mandals;
		String query="";
		SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
		LabelValueBean sourceHabForm = null;
		mandals = new ArrayList();
		PreparedStatement ps=null;
		try {
			sourceHabMasterData.conn = RwsOffices.getConn();
			query = "select  distinct mcode,mname from rws_mandal_tbl ,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and dcode='"+dcode+"' order by mname";
			ps=sourceHabMasterData.conn.prepareStatement(query);
			sourceHabMasterData.rs=ps.executeQuery();
			while (sourceHabMasterData.rs.next()) {
				sourceHabForm = new LabelValueBean();
				sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
				sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
				sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
				mandals.add(sourceHabForm);
			}
		} catch (Exception e) {
			System.out.println("The exception in SourceHabMasterData getMandals = "+e.getMessage());
		} finally {
			sourceHabMasterData.closeAll();
		}
		return mandals;
	}


public ArrayList getMandals1(String circleOfficeCode,String circleOfficeCode1) throws Exception {
	ArrayList mandals;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	mandals = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  mcode,mname from rws_mandal_tbl where  dcode= ? ";
		ps=sourceHabMasterData.conn.prepareStatement(query);
		ps.setString(1, circleOfficeCode1);
		sourceHabMasterData.rs=ps.executeQuery();		
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
			mandals.add(sourceHabForm);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getMandals1 = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return mandals;
}

public  ArrayList getMandalsgovt(DataSource dataSource,String circleOfficeCode,String circleOfficeCode1 ) throws Exception {
	ArrayList mandals;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	mandals = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		if(circleOfficeCode.equals("00")){
			query="SELECT  distinct a.MCODE,a.MNAME FROM RWS_MANDAL_TBL a,RWS_MANDAL_SUBDIVISION_TBL b,RWS_CIRCLE_OFFICE_TBL c where b.CIRCLE_OFFICE_CODE =c.CIRCLE_OFFICE_CODE and b.MCODE =a.mcode and a.dcode=c.CIRCLE_OFFICE_CODE and b.CIRCLE_OFFICE_CODE= ?  order by a.mcode";
		}
		else{
			query="SELECT  distinct a.MCODE,a.MNAME FROM RWS_MANDAL_TBL a,RWS_MANDAL_SUBDIVISION_TBL b,RWS_CIRCLE_OFFICE_TBL c where b.CIRCLE_OFFICE_CODE =c.CIRCLE_OFFICE_CODE and b.MCODE =a.mcode and a.dcode=c.CIRCLE_OFFICE_CODE and b.CIRCLE_OFFICE_CODE= ?  order by a.mcode";
		}
		ps=sourceHabMasterData.conn.prepareStatement(query);
		if(circleOfficeCode.equals("00")){
			ps.setString(1, circleOfficeCode1);
		}else{
			ps.setString(1, circleOfficeCode);
		}
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2)	+ " - " + sourceHabMasterData.rs.getString(1));
			mandals.add(sourceHabForm);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getMandalsgovt = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return mandals;
}

public ArrayList getMandals1(DataSource dataSource,String dcode) throws Exception {
	ArrayList mandals;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	mandals = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();	
		query = "select  distinct mcode,mname from rws_mandal_tbl ,RWS_BLS_vwm_COMM_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and dcode= ? order by mname";
			ps=sourceHabMasterData.conn.prepareStatement(query);
			ps.setString(1, dcode);
			sourceHabMasterData.rs=ps.executeQuery();
			while (sourceHabMasterData.rs.next()) {
				sourceHabForm = new LabelValueBean();
				sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
				sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
				sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
				mandals.add(sourceHabForm);
			}
		} catch (Exception e) {
			System.out.println("The exception in SourceHabMasterData getMandals1 = "+e.getMessage());
		} finally {
			sourceHabMasterData.closeAll();		
		}
	return mandals;
}

public ArrayList getPanchayats(DataSource dataSource,String dcode,String mcode) throws Exception {
	ArrayList panchayats;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	panchayats = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  distinct pcode,pname from rws_panchayat_tbl,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and dcode= ? and mcode= ? ";
		ps=sourceHabMasterData.conn.prepareStatement(query);
		ps.setString(1, dcode);
		ps.setString(2, mcode);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
			panchayats.add(sourceHabForm);
		}

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getPanchayats = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return panchayats;
}

public ArrayList getPanchayats1(DataSource dataSource,String dcode,String mcode) throws Exception {
	ArrayList panchayats;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	panchayats = new ArrayList();
	PreparedStatement ps=null;

	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  distinct pcode,pname from rws_panchayat_tbl,rws_bls_vwm_comm_tbl b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and dcode= ? and mcode= ? ";
		ps=sourceHabMasterData.conn.prepareStatement(query);
		ps.setString(1, dcode);
		ps.setString(2, mcode);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2)	+ " - " + sourceHabMasterData.rs.getString(1));
			panchayats.add(sourceHabForm);
		}

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getPanchayats1 = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return panchayats;
}

public ArrayList getPanchayatsgovt(DataSource dataSource,String circleOfficeCode,String CircleOfficeCode1,String mcode) throws Exception {
	ArrayList panchayats;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	panchayats = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		if(circleOfficeCode.equals("00")){
			query="select distinct pcode,pname from rws_panchayat_tbl where dcode= ? and mcode= ? ";
		}
		else{
			query="select distinct pcode,pname from rws_panchayat_tbl where dcode= ? and mcode= ? ";
		}	
		ps=sourceHabMasterData.conn.prepareStatement(query);
		if(circleOfficeCode.equals("00")){
			ps.setString(1, CircleOfficeCode1);
		}else{
			ps.setString(1, circleOfficeCode);
		}
		ps.setString(2, mcode);
	sourceHabMasterData.rs=ps.executeQuery();	
	while (sourceHabMasterData.rs.next()) {
		sourceHabForm = new LabelValueBean();
		sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
		sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
		sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2)	+ " - " + sourceHabMasterData.rs.getString(1));
		panchayats.add(sourceHabForm);
	}
} catch (Exception e) {
	System.out.println("The exception in SourceHabMasterData getPanchayatsgovt = "+e.getMessage());
} finally {
	sourceHabMasterData.closeAll();
}
return panchayats;
}

public ArrayList getVillages(DataSource dataSource,String dcode,String mcode,String pcode) throws Exception {
	ArrayList villages;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	villages = new ArrayList();
	PreparedStatement ps=null;

	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  distinct vcode,vname from rws_village_tbl ,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and substr(habitation_code,8,3)=vcode and dcode= ? and mcode= ? and pcode= ? ";
		ps=sourceHabMasterData.conn.prepareStatement(query);
		ps.setString(1, dcode);
		ps.setString(2, mcode);
		ps.setString(3, pcode);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
			villages.add(sourceHabForm);
		}

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getVillages = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return villages;
}

public ArrayList getVillagesgovt(DataSource dataSource,String circleOfficeCode,String circleOfficeCode1,String mcode,String pcode) throws Exception {
	ArrayList villages;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	villages = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		if(circleOfficeCode.equals("00")){
			query="select distinct vcode,vname from RWS_VILLAGE_TBL where dcode= ? and mcode= ? and pcode= ? ";
		}
		else{
			query="select distinct vcode,vname from RWS_VILLAGE_TBL where dcode= ? and mcode= ? and pcode= ? ";
		}
		ps=sourceHabMasterData.conn.prepareStatement(query);
		if(circleOfficeCode.equals("00")){
			ps.setString(1, circleOfficeCode1);
		}else{
			ps.setString(1, circleOfficeCode);
		}
		ps.setString(2, mcode);
		ps.setString(3, pcode);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2)	+ " - " + sourceHabMasterData.rs.getString(1));
			villages.add(sourceHabForm);
	    }

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getVillagesgovt = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return villages;
}

public ArrayList getSanctionedHabs(String sourceCode) {
	ArrayList habitations = new ArrayList();
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	try {
		String query = "";
		if(sourceCode.substring(19,21).equals("SO")){
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,rws_source_tbl b where a.hab_code=b.hab_code and b.source_code= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}
		else if(sourceCode.substring(19,21).equals("HP")){
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,rws_hp_subcomp_param_tbl b where a.hab_code=substr(b.hp_code,1,16) and b.HP_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";	
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}
		else if(sourceCode.substring(19,21).equals("OW")){
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_OPEN_WELL_MAST_TBL b where a.hab_code=b.HABITATION_CODE  and b.OPENWELL_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}
		else if(sourceCode.substring(19,21).equals("GL")){
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_GLSR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.GLSR_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}			 
		else if(sourceCode.substring(19,21).equals("OS")) {
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_OHSR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.OHSR_CODE = ? union select hab_code as hab from rws_source_habitation_tbl where source_code = ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}
		else if(sourceCode.substring(19,21).equals("SH")){			
			query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_SHALLOWHANDPUMPS_TBL b where a.hab_code=b.hab_code  and b.SHALLOWHP_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code ";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceCode);
			ps.setString(2, sourceCode);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}
		}
		else if(sourceCode.substring(19,21).equals("PD")){
			 query = "select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_OPENWELL_POND_TBL b where a.hab_code=b.hab_code  and b.POND_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				ps.setString(1, sourceCode);
				ps.setString(2, sourceCode);
				rset = ps.executeQuery();
				RwsLocationBean rwsLocationBean = null;
				while (rset.next()) {
					habitations.add(rset.getString(1));
				}			 
		}
		else if(sourceCode.substring(19,21).equals("GB")) {
			 query ="select hab,panch_name,c.mname,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status from (select a.hab_code as hab from rws_habitation_directory_tbl a,RWS_AST_GLBR_SC_PARAM_TBL b where a.hab_code=b.hab_code  and b.GLBR_CODE= ? union select hab_code as hab from rws_source_habitation_tbl where source_code= ? ),rws_complete_hab_view c,rws_habitation_directory_tbl HD where hab=c.panch_code and hab=hab_code";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				ps.setString(1, sourceCode);
				ps.setString(2, sourceCode);
				rset = ps.executeQuery();
				RwsLocationBean rwsLocationBean = null;
				while (rset.next()) {
					habitations.add(rset.getString(1));
				}			 
		}		
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getSanctionedHabs = "+e.getMessage());
	} finally {
		if (rset != null) {
			try {
				if (rset != null)
					rset.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getSanctionedHabs = "+sqle.getMessage());
			}
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getSanctionedHabs = "+sqle.getMessage());
			}
		}
		if (conn != null) {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getSanctionedHabs = "+sqle.getMessage());
			}
		}
	}

	return habitations;
}


public ArrayList getHabsInMandals(String sourceCode, ArrayList sanctionedHabs, String[] mcodes) throws Exception {
	ArrayList habs = new ArrayList();
	ResultSet rs = null;
	PreparedStatement prpStmt = null;
	Connection conn = null;
	String sqlQuery = "";
	try {
		conn = RwsOffices.getConn();
		for (int j = 0; j < mcodes.length; j++) {
			if (mcodes[j] != null) {	
			 
					sqlQuery = "select distinct h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status,m.mname,CONSTITUENCY_NAME from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,RWS_CONSTITUENCY_TBL c "
							+ " where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and "
							+ " h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode= ? and m.mcode= ? and c.dcode=d.dcode and c.mcode=m.mcode order by m.mname,h.panch_name asc";
				prpStmt = conn.prepareStatement(sqlQuery);
				prpStmt.setString(1, sourceCode.substring(0,2));
				prpStmt.setString(2, mcodes[j]);
				rs = prpStmt.executeQuery();
				nic.watersoft.wquality.SourceHabFormBean sourceHabFormBean = null;
				while (rs.next()) {
					sourceHabFormBean = new nic.watersoft.wquality.SourceHabFormBean();
					if (sanctionedHabs != null) {
						for (int i = 0; i < sanctionedHabs.size(); i++) {
							try {
								if (((String) sanctionedHabs.get(i)) != null && ((String) sanctionedHabs.get(i)).equals(rs.getString(1))) {
									sourceHabFormBean.setHabMatch("checked");
								}
							} catch (Exception e) {
								System.out.println("The exception in SourceHabMasterData getHabsInMandals = "+e.getMessage());
							}
						}
					}
					sourceHabFormBean.setHabCode(rs.getString(1));
					sourceHabFormBean.setHabName(rs.getString(2));
					sourceHabFormBean.setPopulation(rs.getString(3));
					sourceHabFormBean.setStatus(rs.getString(4));
					sourceHabFormBean.setConstituencyName(rs.getString(6));
					sourceHabFormBean.setMandalName(rs.getString(5));				
					habs.add(sourceHabFormBean);
				}
			}
		}
		if (rs != null)
			rs.close();
	} catch (SQLException e) {
		System.out.println("The exception in SourceHabMasterData getHabsInMandals = "+e.getMessage());		
		return null;
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getHabsInMandals = "+e.getMessage());
		return null;
	} finally {
		if (prpStmt != null)
			prpStmt.close();
		if (rs != null)
			rs.close();
		if (conn != null)
			conn.close();
	}
	return habs;
}

public ArrayList getHabs(DataSource dataSource,String dcode,String circleOfficeCode1,String mcode,String pcode,String vcode) throws Exception {
	ArrayList habs;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	habs = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  distinct panch_code,panch_name from rws_complete_hab_view b where substr(panch_code,1,2)= ? and substr(panch_code,6,2)= ? and substr(panch_code,13,2)= ? and substr(panch_code,8,3)= ?";
		ps=sourceHabMasterData.conn.prepareStatement(query);
		ps.setString(1, circleOfficeCode1);
		ps.setString(2, mcode);
		ps.setString(3, pcode);
		ps.setString(4, vcode);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(1) + " - " + sourceHabMasterData.rs.getString(2));
			habs.add(sourceHabForm);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getHabs = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();	
	}
	return habs;
}


public ArrayList getVillages1(DataSource dataSource,String dcode,String mcode,String pcode) throws Exception {
	ArrayList villages;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	villages = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select  distinct vcode,vname from rws_village_tbl ,RWS_BLS_vwm_comm_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and substr(habitation_code,8,3)=vcode and dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
			ps=sourceHabMasterData.conn.prepareStatement(query);		
			sourceHabMasterData.rs=ps.executeQuery();			
			while (sourceHabMasterData.rs.next()) {
				sourceHabForm = new LabelValueBean();
				sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
				sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
				sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
				villages.add(sourceHabForm);
			}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getVillages1 = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return villages;
}

public ArrayList getLinkedHabs(String sourceCode,String sourceTypeCode) throws Exception {
	ArrayList linkhabs;
	String query="";
	SourceHabMasterData sourceHabMasterData = new SourceHabMasterData();
	LabelValueBean sourceHabForm = null;
	linkhabs = new ArrayList();
	PreparedStatement ps=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query = "select hab_code,source_code from rws_source_habitation_tbl where source_code='"+sourceCode+"'";	
		ps=sourceHabMasterData.conn.prepareStatement(query);
		sourceHabMasterData.rs=ps.executeQuery();
		while (sourceHabMasterData.rs.next()) {
			sourceHabForm = new LabelValueBean();
			sourceHabForm.setValue(sourceHabMasterData.rs.getString(1));
			sourceHabForm.setLabel(sourceHabMasterData.rs.getString(2));
			sourceHabForm.setLabelValue(sourceHabMasterData.rs.getString(2) + " - " + sourceHabMasterData.rs.getString(1));
			linkhabs.add(sourceHabForm);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getLinkedHabs = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return linkhabs;
}

public ArrayList getAddHabs(SourceHabForm frm) throws Exception {
	ArrayList habsaddlist = new ArrayList();
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	try {
		String query ="select panch_code,panch_name from rws_complete_hab_view ";		
		if (!frm.getDist().equals("-1")) {
			query += " and substr(panch_code,1,2)= ? ";
		}
		if (!frm.getMcode().equals("-1")) {
			query += " and substr(panch_code,6,2)= ? ";
		}
		conn = RwsOffices.getConn();
		ps = conn.prepareStatement(query);
		if (!frm.getDist().equals("-1")) {
			ps.setString(1, frm.getDist());
		}
		if (!frm.getMcode().equals("-1")) {		
			ps.setString(1, frm.getMcode());
		}
		rset = ps.executeQuery();
		SourceHabFormBean sourceHabFormBean = null;
		while (rset.next()) {
			sourceHabFormBean = new SourceHabFormBean();
			sourceHabFormBean.setPanchCode(rset.getString(1));
			sourceHabFormBean.setHabName(rset.getString(2));
			habsaddlist.add(sourceHabFormBean);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getAddHabs = "+e.getMessage());
	} finally {
		if (rset != null) {
			try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				  System.out.println("The exception in SourceHabMasterData getAddHabs = "+sqle.getMessage());
				}
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getAddHabs = "+sqle.getMessage());
			}
		}
		if (conn != null) {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException sqle) {
				System.out.println("The exception in SourceHabMasterData getAddHabs = "+sqle.getMessage());
			}
		}
	}
	return habsaddlist;
}

public ArrayList getSelectedSources(String source,String habCode) throws Exception {
	SourceHabFormBean sourceHabFormBean = null;
	ArrayList selsource = new ArrayList();
	PreparedStatement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
	String qry = "";
	try {
		conn = RwsOffices.getConn();
		if (source != null && source.equals("SS")) {
			qry = "select SOURCE_CODE,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING'),nvl(subCompTbl.source_name,'-'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM	RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09' ) and	SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=1 and subCompTbl.hab_code= ? ";
			ps = conn.prepareStatement(qry);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			while (rs.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setWaterSourcename(rs.getString(5));
				sourceHabFormBean.setLatitude(rs.getString(6));
				sourceHabFormBean.setLongitude(rs.getString(7));
				sourceHabFormBean.setElevation(rs.getString(8));
				sourceHabFormBean.setWaypoint(rs.getString(9));				
				String sname = "", scode = "";
				String sname1 = "", scode1 = "";
				String sname2 = "", scode2 = "";
				String sname3 = "", scode3 = "";
				if (rs.getString(1).substring(16, 17).equals("6")) {
					scode = "0101001";
					sname = "PWS SUBSURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 17).equals("8")) {
					scode = "0301001";
					sname = "CPWS SUBSURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 18).equals("40") || rs.getString(1).substring(16, 18).equals("41") || rs.getString(1).substring(16, 18).equals("42") || rs.getString(1).substring(16, 18).equals("43") || rs.getString(1).substring(16, 18).equals("44")) {
					scode = "0201001";
					sname = "MPWS SUBSURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 18).equals("45")) {
					scode = "0901001";
					sname = "DIRECT PUMPING  SUBSURFACE SOURCE";
				}
				sourceHabFormBean.setSourceTypeCode(scode);
				sourceHabFormBean.setSourceTypeName(sname);
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		}

		else if (source != null && source.equals("SU")) {
			qry = "select SOURCE_CODE ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING'),nvl(subCompTbl.source_name,'-') ,subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or M.TYPE_OF_ASSET_CODE='09') and	SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=2 and	subCompTbl.hab_code= ? ";
			ps = conn.prepareStatement(qry);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			while (rs.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setWaterSourcename(rs.getString(5));	
				sourceHabFormBean.setLatitude(rs.getString(6));
				sourceHabFormBean.setLongitude(rs.getString(7));
				sourceHabFormBean.setElevation(rs.getString(8));
				sourceHabFormBean.setWaypoint(rs.getString(9));
				String sname = "", scode = "";
				if (rs.getString(1).substring(16, 17).equals("6")) {
					scode = "0101002";
					sname = "PWS SURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 17).equals("8")) {
					scode = "0301002";
					sname = "CPWS SURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 18).equals("40") || rs.getString(1).substring(16, 18).equals("41") || rs.getString(1).substring(16, 18).equals("42") || rs.getString(1).substring(16, 18).equals("43") || rs.getString(1).substring(16, 18).equals("44")) {
					scode = "0201002";
					sname = "MPWS SURFACE SOURCE";
				} else if (rs.getString(1).substring(16, 18).equals("45")) {
					scode = "0901002";
					sname = "DIRECT PUMPING SURFACE SOURCE";
				}
				sourceHabFormBean.setSourceTypeCode(scode);
				sourceHabFormBean.setSourceTypeName(sname);
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		} else if (source != null && source.equals("HP")) {
			try {				
				qry = "select distinct subCompTbl.HP_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'04','HANDPUMP'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT   FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND	M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.hab_code=substr(subCompTbl.hp_code,1,16) and m.hab_code= ? order by	substr(subCompTbl.hp_code,21,24)";
				stmt1 = conn.prepareStatement(qry);
				stmt1.setString(1, habCode);
				rs = stmt1.executeQuery();
				while (rs.next()) {
					sourceHabFormBean = new SourceHabFormBean();
					sourceHabFormBean.setSourceCode(rs.getString(1));
					sourceHabFormBean.setLocation(rs.getString(2));
					sourceHabFormBean.setAssetStatus(rs.getString(3));
					sourceHabFormBean.setWaterAssettype(rs.getString(4));
					sourceHabFormBean.setLatitude(rs.getString(5));
					sourceHabFormBean.setLongitude(rs.getString(6));
					sourceHabFormBean.setElevation(rs.getString(7));
					sourceHabFormBean.setWaypoint(rs.getString(8));
					sourceHabFormBean.setSourceTypeCode("0401001");
					sourceHabFormBean.setSourceTypeName("HANDPUMPS BOREWELL");
					selsource.add(sourceHabFormBean);
				}
			} catch (Exception e) {
				Debug.println(" Exception in Handpump displaying:" + e);
			}
			if (rs != null)
				rs.close();
			if (stmt1 != null)
				stmt1.close();
		} else if (source != null && source.equals("OW")) {
			qry = "select subCompTbl.OPENWELL_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT 	WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'06','OPENWELLS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HABITATION_code= ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();
			while (rs.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode("0601001");
				sourceHabFormBean.setSourceTypeName("OPEN WELLS");
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		} else if (source != null && source.equals("SHP")) {
			qry = "select distinct subCompTbl.SHALLOWHP_CODE,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT	WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'05','SHALLOWHANDPUMPS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND	M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HAB_CODE= ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();			
			while (rs.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode("0501001");
				sourceHabFormBean.setSourceTypeName("SHALLOW HANDPUMPS");
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		} else if (source != null && source.equals("PO")) {
			qry = "select distinct subCompTbl.POND_CODE,subCompTbl.POND_LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'07','PONDS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE	M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07'	and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HAB_CODE = ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();;
			while (rs.next()) {
				sourceHabFormBean = new SourceHabFormBean();
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode("0701001");
				sourceHabFormBean.setSourceTypeName("PONDS");
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		}

		else if (source != null && source.equals("GLSR")) {
			qry = "select subCompTbl.glsr_code,subCompTbl.glsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND	M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code= ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();;
			while (rs.next()) {
				String sname1 = "", scode1 = "";
				if (rs.getString(1).substring(16, 17).equals("6")) {
					scode1 = "0104003";
					sname1 = "PWS GLSR";
				} else if (rs.getString(1).substring(16, 17).equals("8")) {
					scode1 = "0304003";
					sname1 = "CPWS GLSR";
				} else if (rs.getString(1).substring(16, 18).equals("40") || rs.getString(1).substring(16, 18).equals("41") || rs.getString(1).substring(16, 18).equals("42") || rs.getString(1).substring(16, 18).equals("43") || rs.getString(1).substring(16, 18).equals("44")) {
					scode1 = "0204003";
					sname1 = "MPWS GLSR";
				}
				sourceHabFormBean = new SourceHabFormBean();
				String glsr = rs.getString(1);
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode(scode1);
				sourceHabFormBean.setSourceTypeName(sname1);
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		}
	
		else if (source != null && source.equals("GLBR")) {
			qry = "select subCompTbl.glbr_code,subCompTbl.glbr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS') ,subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glbr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND	M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or	M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code= ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();;
			while (rs.next()) {
				String sname1 = "", scode1 = "";
				if (rs.getString(1).substring(16, 17).equals("6")) {
					scode1 = "0104004";
					sname1 = "PWS GLBR";
				} else if (rs.getString(1).substring(16, 17).equals("8")) {
					scode1 = "0304004";
					sname1 = "CPWS GLBR";
				} else if (rs.getString(1).substring(16, 18).equals("40") || rs.getString(1).substring(16, 18).equals("41") || rs.getString(1).substring(16, 18).equals("42") || rs.getString(1).substring(16, 18).equals("43") || rs.getString(1).substring(16, 18).equals("44")) {
					scode1 = "0204004";
					sname1 = "MPWS GLBR";
				}
				sourceHabFormBean = new SourceHabFormBean();
				String glsr = rs.getString(1);
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode(scode1);
				sourceHabFormBean.setSourceTypeName(sname1);
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		}

		else if (source != null && source.equals("OHSR")) {
			qry = "select subCompTbl.ohsr_code,subCompTbl.ohsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_ohsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and	subCompTbl.hab_code= ? ";
			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, habCode);
			rs = stmt2.executeQuery();;
			while (rs.next()) {
				String sname1 = "", scode1 = "";
				if (rs.getString(1).substring(16, 17).equals("6")) {
					scode1 = "0104001";
					sname1 = "PWS OHSR";
				} else if (rs.getString(1).substring(16, 17).equals("8")) {
					scode1 = "0304001";
					sname1 = "CPWS OHSR";
				} else if (rs.getString(1).substring(16, 18).equals("40") || rs.getString(1).substring(16, 18).equals("41") || rs.getString(1).substring(16, 18).equals("42") || rs.getString(1).substring(16, 18).equals("43") ||	rs.getString(1).substring(16, 18).equals("44")) {
					scode1 = "0204001";
					sname1 = "MPWS OHSR";
				}
				sourceHabFormBean = new SourceHabFormBean();
				String glsr = rs.getString(1);
				sourceHabFormBean.setSourceCode(rs.getString(1));
				sourceHabFormBean.setLocation(rs.getString(2));
				sourceHabFormBean.setAssetStatus(rs.getString(3));
				sourceHabFormBean.setWaterAssettype(rs.getString(4));
				sourceHabFormBean.setLatitude(rs.getString(5));
				sourceHabFormBean.setLongitude(rs.getString(6));
				sourceHabFormBean.setElevation(rs.getString(7));
				sourceHabFormBean.setWaypoint(rs.getString(8));
				sourceHabFormBean.setSourceTypeCode(scode1);
				sourceHabFormBean.setSourceTypeName(sname1);
				selsource.add(sourceHabFormBean);
			}
			if (rs != null)
				rs.close();
			if (stmt2 != null)
				stmt2.close();
		}

	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getSelectedSources = "+e.getMessage());
	} 
	return selsource;	
}

public int saveIhhl(String sourceCode) throws Exception {
	int count = 0;
	try {
		Connection conn=null;
		conn = RwsOffices.getConn();
		conn.setAutoCommit(false); 
		String query="";
		PreparedStatement pstmt = null;
		ResultSet rs1 = null;              
		SourceHabMasterData sourceHabMasterData=new SourceHabMasterData(); 
        query="insert into RWS_SOURCE_HABITATION_TBL (source_code,HAB_CODE) values( ? )";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, sourceCode);
		count = pstmt.executeUpdate();

		if (count > 0) {
			conn.setAutoCommit(true); 
			conn.commit();
		}
		}
		catch (Exception e){
			System.out.println("The exception in SourceHabMasterData saveIhhl = "+e.getMessage());
		}
		return count;
}

public int insertHabs(SourceHabForm dr) throws Exception{
	return connCount;
}


public static SourceHabFormBean getIhhledit(String habCode) throws Exception {
	ArrayList habs=new ArrayList();
	SourceHabMasterData sourceHabMasterData=new SourceHabMasterData();
	String query="";
	SourceHabFormBean frm1=null;
	try {
		sourceHabMasterData.conn = RwsOffices.getConn();
		query= "select HAB_CODE,HOUSEHOLD_HEAD_NAME,TYPE_OF_ID,ID_NUMBER,MOBILE_NO,ELIG_NONELIG_SUBSIDY,SUBS_AMOUNT_TAKEN,IHHL_CONSTRUCTED,REASONS_FOR_NOT_CONSTRUCT,dname,mname,pname,vname  from rws_jb_ihhl_tbl t,rws_complete_hab_view b where b.panch_code=t.HAB_CODE  and hab_code= ? ";
		sourceHabMasterData.ps = sourceHabMasterData.conn.prepareStatement(query);
		sourceHabMasterData.ps.setString(1, habCode);
		sourceHabMasterData.rs = sourceHabMasterData.ps.executeQuery();
		while (sourceHabMasterData.rs.next()){
			frm1=new SourceHabFormBean();
			 frm1.setHabCode(sourceHabMasterData.rs.getString(1));
			 frm1.setHead(sourceHabMasterData.rs.getString(2));
			 frm1.setTypeid(sourceHabMasterData.rs.getString(3));
			 frm1.setIdnumber(sourceHabMasterData.rs.getString(4));
			 frm1.setMbnum(sourceHabMasterData.rs.getString(5));
			 frm1.setEsubsidy(sourceHabMasterData.rs.getString(6));
			 frm1.setAmunteligible(sourceHabMasterData.rs.getString(7));
			 frm1.setIhhlcon(sourceHabMasterData.rs.getString(8));
			 frm1.setNotcon(sourceHabMasterData.rs.getString(9));
			 frm1.setdName(sourceHabMasterData.rs.getString(10));
			 frm1.setmName(sourceHabMasterData.rs.getString(11));
			 frm1.setpName(sourceHabMasterData.rs.getString(12));
			 frm1.setvName(sourceHabMasterData.rs.getString(13));
			 habs.add(frm1);
		}
	} catch (Exception e) {
		System.out.println("The exception in SourceHabMasterData getIhhledit = "+e.getMessage());
	} finally {
		sourceHabMasterData.closeAll();
	}
	return frm1;
	}
}
