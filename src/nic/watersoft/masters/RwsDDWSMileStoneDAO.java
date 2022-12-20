package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class RwsDDWSMileStoneDAO {

	public static String getMileStoneCode() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.prepareStatement("SELECT NVL(MAX(to_number(MILESTONE_CODE)),0)+1 FROM DDWS_PHY_MILESTONE_TBL");
			rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneCode is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneCode is  = "+ e.getMessage());
			}
		}
		return "";
	}

	public int saveMileStone(String mileStoneCode, String mileStoneName,double phyPercentage) {
		Connection conn = null;
		PreparedStatement stmt = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String q = "insert into  DDWS_PHY_MILESTONE_TBL values( ?, ?,?)";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneCode);
			stmt.setString(2, mileStoneName);
			stmt.setDouble(3, phyPercentage);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in saveMileStone is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in saveMileStone is  = "	+ e.getMessage());
			}
		}
		return 0;
	}

	public int editMileStone(String mileStoneCode, String mileStoneName,double phyPercent) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "update DDWS_PHY_MILESTONE_TBL set MILESTONE_NAME= ?,milestone_percent=? where MILESTONE_CODE= ? ";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneName);
			stmt.setString(3, mileStoneCode);
			stmt.setDouble(2, phyPercent);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in editMileStone is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in editMileStone is  = "+ e.getMessage());
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
			stmt = conn	.prepareStatement("SELECT * FROM DDWS_PHY_MILESTONE_TBL order by MILESTONE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				RwsMileStoneBean rwsMileStoneBean = new RwsMileStoneBean();
				rwsMileStoneBean.setMileStoneCode(rs.getString(1));
				rwsMileStoneBean.setMileStoneName(rs.getString(2));
				rwsMileStoneBean.setPhyPercentage(rs.getDouble(3));
				mileStones.add(rwsMileStoneBean);
			}
			return mileStones;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStones is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStones is  = "+ e.getMessage());
			}
		}
		return null;
	}

	public int saveMileStoneStage(String mileStoneCode,
			String mileStoneStageCode, String mileStoneStageName,
			double mileStoneStagePercentage) {
		Connection conn = null;

		PreparedStatement stmt = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String testQuery = "select MILESTONE_PERCENT,sum(b.MILESTONE_STAGE_PERCENT) from  DDWS_PHY_MILESTONE_TBL a,DDWS_PHY_MILESTONE_STAGE_TBL b where a.MILESTONE_CODE=? and a.MILESTONE_CODE=b.MILESTONE_CODE group by MILESTONE_PERCENT";
			stmt = conn.prepareStatement(testQuery);
			stmt.setString(1, mileStoneCode);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				double milestonestaper = rs.getDouble(2)
						+ mileStoneStagePercentage;
				if (rs.getDouble(1) >= milestonestaper) {

				} else {
					return -1;
				}
			}
			rs.close();
			stmt.close();
			String q = "insert into  DDWS_PHY_MILESTONE_STAGE_TBL values( ?, ?, ?, ?)";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneCode);
			stmt.setString(2, mileStoneStageCode);
			stmt.setString(3, mileStoneStageName);
			stmt.setDouble(4, mileStoneStagePercentage);

			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in saveMileStoneStage is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in saveMileStoneStage is  = "+ e.getMessage());
			}
		}
		return 0;
	}

	public String saveDdwsCompLink(String compCode, String mileStoneCode,
			String mileStoneStageCode, String sourceType, String subSourceType,
			String displayStatus) {
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null;
		ResultSet resultSet = null;
		int count = 0;
		String message = "";
		try {
			conn = RwsOffices.getConn();
			if (isExist(compCode, mileStoneCode, mileStoneStageCode,sourceType, subSourceType)) {
				int id = 0;
				stmt1 = conn.prepareStatement("select NVL(MAX(to_number(component_id)),0)+1 from rws_ddws_comp_mile_stg_lnk_tbl");
				resultSet = stmt1.executeQuery();
				if (resultSet.next()) {
					id = resultSet.getInt(1);
				}
				String q = "insert into rws_ddws_comp_mile_stg_lnk_tbl values( ?, ?, ?, ?, ?, ?,sysdate,?)";
				stmt = conn.prepareStatement(q);
				stmt.setInt(1, id);
				stmt.setString(2, compCode);
				stmt.setString(3, mileStoneCode);
				stmt.setString(4, mileStoneStageCode);
				stmt.setString(5, sourceType);
				stmt.setString(6, subSourceType);
				stmt.setString(7, displayStatus);
				count = stmt.executeUpdate();
			} else {
				return "Component already mapped with milestone and milestonestage";
			}
			if (count > 0) {
				message = "Added Successfully";
			}
			return message;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in saveDdwsCompLink is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (stmt1 != null) {
					stmt1.close();
				}
				if (resultSet != null)
					resultSet.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in saveDdwsCompLink is  = "+ e.getMessage());
			}
		}
		return message;
	}

	private boolean isExist(String compCode, String mileStoneCode,
			String mileStoneStageCode, String sourceType, String subSourceType) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String query1 = "";
		try {
			conn = RwsOffices.getConn();
			query1 = "select * from rws_ddws_comp_mile_stg_lnk_tbl where COMPONENT_CODE= ? and MILESTONE_CODE= ? and MILESTONE_STAGE_CODE= ? and SOURCE_TYPE_CODE= ? and SUBSOURCE_TYPE_CODE= ? ";
			stmt = conn.prepareStatement(query1);
			stmt.setString(1, compCode);
			stmt.setString(2, mileStoneCode);
			stmt.setString(3, mileStoneStageCode);
			stmt.setString(4, sourceType);
			stmt.setString(5, subSourceType);
			rset = stmt.executeQuery();
			if (rset.next()) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in isExist is  = "	+ e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in isExist Get physical Exception in Closing ");
			}
		}
		return false;
	}

	public String editDdwsCompLink(String compCode, String mileStoneCode,
			String mileStoneStageCode, String sourceType, String subSourceType,
			String ddwscode, String displayStatus) {
		Connection conn = null;
		PreparedStatement stmt = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			if (isExist(compCode, mileStoneCode, mileStoneStageCode,sourceType, subSourceType)) {
				String q = "update  rws_ddws_comp_mile_stg_lnk_tbl set COMPONENT_CODE= ? ,MILESTONE_CODE= ? ,MILESTONE_STAGE_CODE= ? ,SOURCE_TYPE_CODE= ? ,SUBSOURCE_TYPE_CODE= ?,DISPLAYSTATUS=? where COMPONENT_ID= ? ";
				stmt = conn.prepareStatement(q);
				stmt.setString(1, compCode);
				stmt.setString(2, mileStoneCode);
				stmt.setString(3, mileStoneStageCode);
				stmt.setString(4, sourceType);
				stmt.setString(5, subSourceType);
				stmt.setString(6, displayStatus);
				stmt.setString(7, ddwscode);
				count = stmt.executeUpdate();
			} else {
				String q1 = "update  rws_ddws_comp_mile_stg_lnk_tbl set DISPLAYSTATUS=? where COMPONENT_ID=?";
				stmt = conn.prepareStatement(q1);
				stmt.setString(1, displayStatus);
				stmt.setString(2, ddwscode);
				count = stmt.executeUpdate();
				return "Component already mapped with milestone and milestonestage";
			}
			if (count > 0) {
				return "Edit Successfully";
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in editDdwsCompLink is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in editDdwsCompLink is  = "+ e.getMessage());
			}
		}
		return "";
	}

	public static String getMileStoneStageCode(String mileStone) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn	.prepareStatement("SELECT nvl(MAX(to_number(MILESTONE_STAGE_CODE)),0)+1 FROM DDWS_PHY_MILESTONE_STAGE_TBL where milestone_code= ? ");
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
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStageCode is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStageCode is  = "+ e.getMessage());
			}
		}
		return "";
	}

	public int editMileStoneStage(String mileStoneCode,
			String mileStoneStageName, String mileStoneStageCode,
			String ddwsLinked, double mileStoneStagePercentage) {
		Connection conn = null;
		PreparedStatement stmt = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String testQuery = "select MILESTONE_PERCENT,sum(b.MILESTONE_STAGE_PERCENT) from  DDWS_PHY_MILESTONE_TBL a,DDWS_PHY_MILESTONE_STAGE_TBL b where a.MILESTONE_CODE=? and a.MILESTONE_CODE=b.MILESTONE_CODE group by MILESTONE_PERCENT";
			stmt = conn.prepareStatement(testQuery);
			stmt.setString(1, mileStoneCode);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				double oldvalue = 0;
				String q = "select b.MILESTONE_STAGE_PERCENT from  DDWS_PHY_MILESTONE_TBL a,DDWS_PHY_MILESTONE_STAGE_TBL b where a.MILESTONE_CODE=? and MILESTONE_STAGE_CODE=? and a.MILESTONE_CODE=b.MILESTONE_CODE";
				PreparedStatement statement = conn.prepareStatement(q);
				statement.setString(1, mileStoneCode);
				statement.setString(2, mileStoneStageCode);
				ResultSet resultSet = statement.executeQuery();
				if (resultSet.next()) {
					oldvalue = resultSet.getDouble(1);
				}
				statement.close();
				resultSet.close();
				double milestonestaper = (rs.getDouble(2) - oldvalue)+ mileStoneStagePercentage;
				if (rs.getDouble(1) >= milestonestaper) {

				} else {
					return -1;
				}
			}
			stmt.close();
			rs.close();
			String q = "update  DDWS_PHY_MILESTONE_STAGE_TBL set MILESTONE_STAGE_NAME= ?,MILESTONE_STAGE_PERCENT=? where MILESTONE_CODE= ? and MILESTONE_STAGE_CODE= ? ";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, mileStoneStageName);
			stmt.setDouble(2, mileStoneStagePercentage);
			stmt.setString(3, mileStoneCode);
			stmt.setString(4, mileStoneStageCode);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in editMileStoneStage is  = "	+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in editMileStoneStage is  = "	+ e.getMessage());
			}
		}
		return 0;
	}

	public ArrayList getMileStonesList() {
		ArrayList mileStoneList = new ArrayList();
		Connection conn = null;
		LabelValueBean labelValueBean = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn	.prepareStatement("SELECT * FROM DDWS_PHY_MILESTONE_TBL order by MILESTONE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2));
				mileStoneList.add(labelValueBean);
			}
			return mileStoneList;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStonesList is  = "	+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStonesList is  = "+ e.getMessage());
			}
		}
		return mileStoneList;
	}

	public ArrayList getDdwsCompList() {
		ArrayList ddwsCompList = new ArrayList();
		Connection conn = null;
		LabelValueBean labelValueBean = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn	.prepareStatement("SELECT * FROM rws_ddws_phy_component_tbl order by COMPONENT_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2));
				ddwsCompList.add(labelValueBean);
			}
			return ddwsCompList;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getDdwsCompList is  = "	+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getDdwsCompList is  = "	+ e.getMessage());
			}
		}
		return ddwsCompList;
	}

	public ArrayList getMileStoneStageList(String milestoneCode) {
		ArrayList mileStoneStageList = new ArrayList();
		Connection conn = null;
		LabelValueBean labelValueBean = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.prepareStatement("SELECT MILESTONE_STAGE_CODE,MILESTONE_STAGE_NAME FROM DDWS_PHY_MILESTONE_STAGE_TBL where MILESTONE_CODE= ? order by MILESTONE_STAGE_CODE");
			stmt.setString(1, milestoneCode);
			rs = stmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2));
				mileStoneStageList.add(labelValueBean);
			}
			return mileStoneStageList;
		} catch (Exception e) {
			System.out
					.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStageList is  = "
							+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out
						.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStageList is  = "
								+ e.getMessage());
			}
		}
		return mileStoneStageList;
	}

	public ArrayList getMileStoneStages() {
		ArrayList mileStones = new ArrayList();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.prepareStatement("SELECT * FROM DDWS_PHY_MILESTONE_STAGE_TBL order by MILESTONE_CODE,MILESTONE_STAGE_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				RwsMileStoneBean rwsMileStoneBean = new RwsMileStoneBean();
				rwsMileStoneBean.setMileStoneCode(rs.getString(1));
				rwsMileStoneBean.setMileStoneStageCode(rs.getString(2));
				rwsMileStoneBean.setMileStoneStageName(rs.getString(3));
				rwsMileStoneBean.setMileStoneStagePercentage(rs.getDouble(4));
				mileStones.add(rwsMileStoneBean);
			}
			return mileStones;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStages is  = "	+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getMileStoneStages is  = "	+ e.getMessage());
			}
		}
		return null;
	}

	public ArrayList getDdwsComponents() {
		ArrayList ddwsComponents = new ArrayList();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.prepareStatement("select com.COMPONENT_NAME,com.COMPONENT_CODE,m.MILESTONE_NAME,m.MILESTONE_CODE,ms.MILESTONE_STAGE_CODE,ms.MILESTONE_STAGE_NAME,COMPONENT_ID,st.SOURCE_TYPE_CODE,st.SOURCE_TYPE_NAME,sst.SUBSOURCE_TYPE_CODE,sst.SUBSOURCE_TYPE_NAME,decode(DISPLAYSTATUS,'Y','YES','N','NO') as DISPLAYSTATUS from rws_ddws_phy_component_tbl com,DDWS_PHY_MILESTONE_TBL m,DDWS_PHY_MILESTONE_STAGE_TBL ms,rws_ddws_comp_mile_stg_lnk_tbl lnk,RWS_SOURCE_TYPE_TBL st,RWS_SUBSOURCE_TYPE_TBL sst where com.COMPONENT_CODE=lnk.COMPONENT_CODE and m.MILESTONE_CODE=ms.MILESTONE_CODE and m.MILESTONE_CODE=lnk.MILESTONE_CODE and ms.MILESTONE_CODE=lnk.MILESTONE_CODE and ms.MILESTONE_STAGE_CODE=lnk.MILESTONE_STAGE_CODE and st.SOURCE_TYPE_CODE=sst.SOURCE_TYPE_CODE and st.SOURCE_TYPE_CODE=lnk.SOURCE_TYPE_CODE and sst.SUBSOURCE_TYPE_CODE=lnk.SUBSOURCE_TYPE_CODE order by lnk.COMPONENT_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				RwsMileStoneBean rwsMileStoneBean = new RwsMileStoneBean();
				rwsMileStoneBean.setDdwsCompCode(rs.getString("COMPONENT_CODE"));
				rwsMileStoneBean.setDdwsCompName(rs.getString("COMPONENT_NAME"));
				rwsMileStoneBean.setMileStoneCode(rs.getString("MILESTONE_CODE"));
				rwsMileStoneBean.setMileStoneName(rs.getString("MILESTONE_NAME"));
				rwsMileStoneBean.setMileStoneStageCode(rs.getString("MILESTONE_STAGE_CODE"));
				rwsMileStoneBean.setMileStoneStageName(rs.getString("MILESTONE_STAGE_NAME"));
				rwsMileStoneBean.setDdwsComp(rs.getString("COMPONENT_ID"));
				rwsMileStoneBean.setSourceType(rs.getString("SOURCE_TYPE_CODE"));
				rwsMileStoneBean.setSourceName(rs.getString("SOURCE_TYPE_NAME"));
				rwsMileStoneBean.setSubSourceType(rs.getString("SUBSOURCE_TYPE_CODE"));
				rwsMileStoneBean.setSubSourceName(rs.getString("SUBSOURCE_TYPE_NAME"));
				rwsMileStoneBean.setDisplayStatus(rs.getString("DISPLAYSTATUS"));
				ddwsComponents.add(rwsMileStoneBean);
			}
			return ddwsComponents;
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in getDdwsComponents is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in getDdwsComponents is  = "+ e.getMessage());
			}
		}
		return null;
	}

	public String editDisplayStatus(String ddwscode, String displayStatus) {
		Connection conn = null;
		PreparedStatement stmt = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String q1 = "update  rws_ddws_comp_mile_stg_lnk_tbl set DISPLAYSTATUS=? where COMPONENT_ID=?";
			stmt = conn.prepareStatement(q1);
			stmt.setString(1, displayStatus);
			stmt.setString(2, ddwscode);
			count = stmt.executeUpdate();
			if (count > 0) {
				return "Display Status Updated Successfully";
			}
		} catch (Exception e) {
			System.out.println("The Exception in RwsDDWSMileStoneDAO in editDisplayStatus is  = "+ e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null)
					conn.close();

			} catch (Exception e) {
				System.out.println("The Exception in RwsDDWSMileStoneDAO in editDisplayStatus is  = "+ e.getMessage());
			}
		}
		return "";
	}

}