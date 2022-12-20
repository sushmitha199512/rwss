package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class Rws_Rfd_Trainings_Dao

{

	Connection conn = null;
	Statement stmt = null;
	String query = "";
	PreparedStatement pstat = null;
	ResultSet rset = null;

	ResultSet rs = null;

	ResultSet rset1 = null;

	WorksData1 worksData = new WorksData1();
	String d = worksData.getServerDate();
	 
	Rws_Rfd_Trainings_Frm frm = null;

	public int insertWQTrainingDetails(DataSource dataSource,
			Rws_Rfd_Trainings_Frm frm, String user) {
		int count = 0;
		try {
			int cyear = Calendar.getInstance().get(Calendar.YEAR);
			 int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			 int yearStart=0;
			 int yearEnd=0;
			if (month <= 3) {
		        yearStart = cyear - 1;
		        yearEnd = cyear;
		    } else {
		        yearStart = cyear;
		        yearEnd = cyear + 1;
		    }
			String finYear=yearStart+"-"+yearEnd;
			
			conn = RwsOffices.getConn();


			query = "insert into RWS_WQ_TRAINING_TBL(DCODE,MCODE,PCODE,VWSC_MEMBERS_TRAINED,USAGE_OF_FTK_KITS,PREPARED_BY,UPDATE_DATE,FIN_YEAR) "
					+ "values(?,?,?,?,?,?,to_date('" + d + "','dd/mm/yyyy'),?)  ";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, frm.getDist());
			pstat.setString(2, frm.getMand());
			pstat.setString(3, frm.getPanch());
			pstat.setString(4, frm.getVwscAchmt());
			pstat.setString(5, frm.getFtkAchmt());
			pstat.setString(6, user);
			pstat.setString(7, finYear);
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in insertWQTrainingDetails:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public ArrayList WQTrainedList(DataSource dataSource, String dcode,
			String mcode, String pcode) {
		ArrayList wqList = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query = "SELECT distinct b.dname,c.mname,d.pname,a.vwsc_members_trained,a.usage_of_ftk_kits,a.prepared_by,to_char(a.update_date,'dd/mm/yyyy')"
					+ " FROM RWS_WQ_TRAINING_TBL a ,rws_district_tbl b,rws_mandal_tbl c ,rws_panchayat_tbl d "
					+ "where a.dcode=b.dcode and a.dcode=c.dcode and a.mcode=c.mcode and a.dcode=d.dcode and a.mcode=d.mcode and a.pcode=d.pcode "
					+ "and a.dcode=? and a.mcode=? and a.pcode=? ";
			
			pstat = conn.prepareStatement(query);
			pstat.setString(1, dcode);
			pstat.setString(2, mcode);
			pstat.setString(3, pcode);
			rset = pstat.executeQuery();
			Rws_Rfd_Trainings_Frm frm = null;
			while (rset.next()) {
				frm = new Rws_Rfd_Trainings_Frm();
				frm.setDistName(rset.getString(1));
				frm.setMandalName(rset.getString(2));
				frm.setPanchayatName(rset.getString(3));
				frm.setVwscAchmt(rset.getString(4));
				frm.setFtkAchmt(rset.getString(5));
				frm.setPreparedBy(rset.getString(6));
				frm.setUpdateDate(rset.getString(7));
				wqList.add(frm);
			}
		} catch (Exception e) {
			Debug.println("Exception in WQTrainedList():" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return wqList;
	}

	public ArrayList WQTrainedList(DataSource dataSource, String dcode) {
		ArrayList wqList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT distinct b.dname,c.mname,d.pname,a.vwsc_members_trained,a.usage_of_ftk_kits,a.prepared_by,to_char(a.update_date,'dd/mm/yyyy')"
					+ " FROM RWS_WQ_TRAINING_TBL a ,rws_district_tbl b,rws_mandal_tbl c ,rws_panchayat_tbl d "
					+ "where a.dcode=b.dcode and a.dcode=c.dcode and a.mcode=c.mcode and a.dcode=d.dcode and a.mcode=d.mcode and a.pcode=d.pcode "
					+ "and a.dcode=? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, dcode);
			rset = pstat.executeQuery();
			Rws_Rfd_Trainings_Frm frm = null;
			while (rset.next()) {
				frm = new Rws_Rfd_Trainings_Frm();
				frm.setDistName(rset.getString(1));
				frm.setMandalName(rset.getString(2));
				frm.setPanchayatName(rset.getString(3));
				frm.setVwscAchmt(rset.getString(4));
				frm.setFtkAchmt(rset.getString(5));
				frm.setPreparedBy(rset.getString(6));
				frm.setUpdateDate(rset.getString(7));
				wqList.add(frm);
			}
		} catch (Exception e) {
			Debug.println("Exception in WQTrainedList():" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return wqList;
	}

	public ArrayList WQTrainedList(DataSource dataSource, String dcode,
			String mcode) {
		ArrayList wqList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT distinct b.dname,c.mname,d.pname,a.vwsc_members_trained,a.usage_of_ftk_kits,a.prepared_by,to_char(a.update_date,'dd/mm/yyyy')"
					+ " FROM RWS_WQ_TRAINING_TBL a ,rws_district_tbl b,rws_mandal_tbl c ,rws_panchayat_tbl d "
					+ "where a.dcode=b.dcode and a.dcode=c.dcode and a.mcode=c.mcode and a.dcode=d.dcode and a.mcode=d.mcode and a.pcode=d.pcode "
					+ "and a.dcode=? and a.mcode=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, dcode);
			pstat.setString(2, mcode);
			rset = pstat.executeQuery();
			Rws_Rfd_Trainings_Frm frm = null;
			while (rset.next()) {
				frm = new Rws_Rfd_Trainings_Frm();
				frm.setDistName(rset.getString(1));
				frm.setMandalName(rset.getString(2));
				frm.setPanchayatName(rset.getString(3));
				frm.setVwscAchmt(rset.getString(4));
				frm.setFtkAchmt(rset.getString(5));
				frm.setPreparedBy(rset.getString(6));
				frm.setUpdateDate(rset.getString(7));
				wqList.add(frm);
			}
		} catch (Exception e) {
			Debug.println("Exception in WQTrainedList():" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return wqList;
	}

	public ArrayList WQTrainedMembersData(DataSource dataSource, String dist,
			String mand, String panch) {
		ArrayList wqList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "SELECT  a.vwsc_members_trained,a.usage_of_ftk_kits"
					+ " FROM RWS_WQ_TRAINING_TBL a" + " where a.dcode='" + dist
					+ "' and a.mcode='" + mand + "' and a.pcode='" + panch
					+ "' ";
			Debug.println("query..............." + query);
			rset = stmt.executeQuery(query);
			Rws_Rfd_Trainings_Frm frm = null;
			while (rset.next()) {
				frm = new Rws_Rfd_Trainings_Frm();
				frm.setVwscAchmt(rset.getString(1));
				frm.setFtkAchmt(rset.getString(2));
				wqList.add(frm);
			}
		} catch (Exception e) {
			Debug.println("Exception in WorkStageList():" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return wqList;
	}

	public void WQTrainedMembersData(DataSource dataSource,
			Rws_Rfd_Trainings_Frm frm) {
		try {
			conn = RwsOffices.getConn();

			query = "SELECT  a.vwsc_members_trained,a.usage_of_ftk_kits"
					+ " FROM RWS_WQ_TRAINING_TBL a where a.dcode=? and a.mcode=? and a.pcode=? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, frm.getDist());
			pstat.setString(2, frm.getMand());
			pstat.setString(3, frm.getPanch());
			rset = pstat.executeQuery();	
						
			if (rset.next()) {
				frm.setVwscAchmt(rset.getString(1));
				frm.setFtkAchmt(rset.getString(2));
			}
		} catch (Exception e) {
			Debug.println("Exception in WQTrainedMembersData():" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

	}

}
