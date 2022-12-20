package nic.watersoft.admin;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.sun.org.apache.xml.internal.security.utils.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.MakeHashUtils;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

public class LogoutDAO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private DataSource dataSource;
	private Connection conn;
	private PreparedStatement stat, stat1, stat2, stat3;
	private PreparedStatement ps;
	private ResultSet rset, rset1, rset2;;
	private String query, que, qry;
	private RwsOffices rwsOffices;
	private AdminDTO adminDTO;
	private HttpSession session;
	private PreparedStatement psat;
	public LogoutDAO() {
		try {
			conn = RwsOffices.getConn();
		} catch (Exception e) {
			Debug.writeln("Exception AdminDAO() : \n" + e);
		}
	}

	public LogoutDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	private void closeAll() {
		if (rset != null) {
			try {
				rset.close();
			} catch (SQLException sqle) {
			}
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (SQLException sqle) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
		}
	}

	public String logoutupdate(LogBean logBean, ServletRequest request) {
		String loggedSuccessfully = "Logged Out Successfully";	
		try {
			if (dataSource != null)
				conn = RwsOffices.getConn();
				query = "UPDATE RWS_LOG_TBL T SET T.LOGOUT_TIME=TO_DATE(TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS') WHERE T.USER_ID=? AND T.LOGOUT_TIME IS NULL";
				stat = conn.prepareStatement(query);
				stat.setString(1, logBean.getUserId());
				int rcount = stat.executeUpdate();System.out.println("rcount : "+rcount);
			} 
		catch (Exception e) {
			e.printStackTrace();
			Debug.writeln("The Exception is in LogoutDAO log : \n" + e.getMessage());
			loggedSuccessfully = "Problem in Logged Out";
			session.setAttribute("logException", e + "");
		} finally {
			closeAll();
		}
		return loggedSuccessfully;
	}
	
	public int getLoginDetails(String userId) {
		int LoginCount = 0;
		try {
			if (dataSource != null)
				conn = RwsOffices.getConn();			
				query = "SELECT COUNT(*) FROM RWS_LOG_TBL T WHERE T.USER_ID='"+userId+"' AND T.LOGOUT_TIME IS NULL AND T.ACCESS_DATE = (SELECT MAX(TT.ACCESS_DATE) FROM RWS_LOG_TBL TT WHERE TT.USER_ID=T.USER_ID)";
				stat = conn.prepareStatement(query);
				rset = stat.executeQuery();
				if (rset.next()) {
					LoginCount = rset.getInt(1); //System.out.println("LoginCount :"+LoginCount);
				}
		} catch (Exception e) {
			e.printStackTrace();
			Debug.writeln("The Exception is in LogoutDAO log : \n" + e.getMessage());
			LoginCount = 0;
			session.setAttribute("logException", e + "");
		} finally {
			closeAll();
		}
		return LoginCount;
	}
	
	public int checkImproperLoginDetails(String userId) {
		int LoginCount = 0,chkflag=0;
		try {
			if (dataSource != null)
				conn = RwsOffices.getConn();			
				query = "SELECT COUNT(*) FROM RWS_LOG_TBL T WHERE T.USER_ID='"+userId+"' AND T.LOGOUT_TIME IS NULL";
				stat = conn.prepareStatement(query);
				rset = stat.executeQuery();
				if (rset.next()) {
					LoginCount = rset.getInt(1); System.out.println("LoginCount :"+LoginCount);
				}
				
				if(LoginCount>0) 
				{
					query = "SELECT COUNT(*) FROM RWS_LOG_TBL T WHERE T.USER_ID='"+userId+"' AND T.LOGOUT_TIME IS NULL AND T.ACCESS_DATE+(1/1440*1)<=SYSDATE";
					stat = conn.prepareStatement(query);
					rset = stat.executeQuery();
					if (rset.next()) {
						chkflag = rset.getInt(1); System.out.println("chkflag :"+chkflag);
					}
					if (chkflag>0)
					{
						query = "UPDATE RWS_LOG_TBL T SET T.LOGOUT_TIME=TO_DATE(TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS') WHERE T.USER_ID='"+userId+"' AND T.LOGOUT_TIME IS NULL AND T.ACCESS_DATE+(1/1440*1)<=SYSDATE";
						stat = conn.prepareStatement(query);
						int rcount = stat.executeUpdate();
					}
					
					query = "SELECT COUNT(*) FROM RWS_LOG_TBL T WHERE T.USER_ID='"+userId+"' AND T.LOGOUT_TIME IS NULL";
					stat = conn.prepareStatement(query);
					rset = stat.executeQuery();
					if (rset.next()) {
						LoginCount = rset.getInt(1); System.out.println("LoginCount :"+LoginCount);
					}
				}
				
		} catch (Exception e) {
			e.printStackTrace();
			Debug.writeln("The Exception is in LogoutDAO log : \n" + e.getMessage());
			LoginCount = 0;
			session.setAttribute("logException", e + "");
		} finally {
			closeAll();
		}
		return LoginCount;
	}	
	
	
	
	
}
