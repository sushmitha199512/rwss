package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import nic.watersoft.commons.RwsOffices;

public class Rws_WorkChange_Dao {
	public int updateOfficeCode(String workid, String workName) throws Exception {
		int count = 0;
		Connection conn = null;
		try {
			conn = RwsOffices.getConn();
			String query = "update RWS_work_admn_tbl set work_name= ? where work_id= ? ";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, workName);
			stmt.setString(2, workid);
			count = stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_WorkChange_DAO : "+ e.getMessage());
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return count;
	}
}
