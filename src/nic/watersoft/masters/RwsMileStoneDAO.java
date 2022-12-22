package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class RwsMileStoneDAO {

	public static String getMileStoneCode() {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT MAX(to_number(MILESTONE_CODE))+1 FROM rws_milestone_tbl");
			rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in getMileStoneCode is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in getMileStoneCode is  = "+e.getMessage());
			}
		}
		return "";
	}

	public int saveMileStone(String mileStoneCode, String mileStoneName,String ddwsStatus) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "insert into  rws_milestone_tbl values(? , ? , ?)";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneCode);
			stmt.setString(2, mileStoneName);
			stmt.setString(3, ddwsStatus);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in saveMileStone is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in saveMileStone is  = "+e.getMessage());
			}
		}
		return 0;
	}

	public int editMileStone(String mileStoneCode, String mileStoneName,String ddwsStatus) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q ="update  rws_milestone_tbl set MILESTONE_NAME= ? , DDWS_RELATED= ? where MILESTONE_CODE= ?";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneName);
			stmt.setString(2, ddwsStatus);
			stmt.setString(3, mileStoneCode);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in editMileStone is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in editMileStone is  = "+e.getMessage());
			}
		}
		return 0;
	}

	public ArrayList getMileStones() {
		ArrayList mileStones = new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT *FROM rws_milestone_tbl order by MILESTONE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				RwsMileStoneBean rwsMileStoneBean = new RwsMileStoneBean();
				rwsMileStoneBean.setMileStoneCode(rs.getString(1));
				rwsMileStoneBean.setMileStoneName(rs.getString(2));
				rwsMileStoneBean.setDdwsStatus(rs.getString(3));
				mileStones.add(rwsMileStoneBean);
			}
			return mileStones;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in getMileStones is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in getMileStones is  = "+e.getMessage());
			}
		}
		return null;
	}

	public int saveMileStoneStage(String mileStoneCode, String mileStoneStageCode, String mileStoneStageName,String ddwsLinked) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "insert into  rws_milestone_stage_tbl values(?, ?, ?, ?)";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneCode);
			stmt.setString(2, mileStoneStageCode);
			stmt.setString(3, mileStoneStageName);
			stmt.setString(4, ddwsLinked);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in saveMileStoneStage is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in saveMileStoneStage is  = "+e.getMessage());
			}
		}
		return 0;
	}

	public static String getMileStoneStageCode(String mileStone) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT MAX(to_number(MILESTONE_STAGE_CODE))+1 FROM rws_milestone_stage_tbl where milestone_code= ? ");
			stmt.setString(1, mileStone);
			rs = stmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1) != null) {
					return rs.getString(1);
				} else {
					return "1";
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in getMileStoneStageCode is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in getMileStoneStageCode is  = "+e.getMessage());
			}
		}
		return "";
	}

	
	public int editMileStoneStage(String mileStoneCode,	String mileStoneStageName, String mileStoneStageCode,String ddwsLinked) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "update rws_milestone_stage_tbl set MILESTONE_STAGE_NAME= ? ,DDWS_RELATED= ? where MILESTONE_CODE= ? and MILESTONE_STAGE_CODE= ? ";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneStageName);
			stmt.setString(2, ddwsLinked);
			stmt.setString(3, mileStoneCode);
			stmt.setString(4, mileStoneStageCode);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in editMileStoneStage is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in editMileStoneStage is  = "+e.getMessage());
			}
		}
		return 0;
	}

	public ArrayList getMileStonesList() {
		ArrayList mileStoneList = new ArrayList();
		Connection conn = null;
		LabelValueBean labelValueBean = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT *FROM rws_milestone_tbl order by MILESTONE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2));
				mileStoneList.add(labelValueBean);
			}
			return mileStoneList;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in getMileStonesList is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in getMileStonesList is  = "+e.getMessage());
			}
		}
		return mileStoneList;
	}

	public ArrayList getMileStoneStages() {
		ArrayList mileStones = new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT *FROM rws_milestone_stage_tbl order by MILESTONE_CODE,MILESTONE_STAGE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				RwsMileStoneBean rwsMileStoneBean = new RwsMileStoneBean();
				rwsMileStoneBean.setMileStoneCode(rs.getString(1));
				rwsMileStoneBean.setMileStoneStageCode(rs.getString(2));
				rwsMileStoneBean.setMileStoneStageName(rs.getString(3));
				rwsMileStoneBean.setDdwsLinked(rs.getString(4));
				mileStones.add(rwsMileStoneBean);
			}
			return mileStones;
		} catch (Exception e) {
			System.out.println("The Exception in RwsMileStoneDAO in getMileStoneStages is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in RwsMileStoneDAO in getMileStoneStages is  = "+e.getMessage());
			}
		}
		return null;
	}

}