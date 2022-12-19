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
import nic.watersoft.commons.ValidationUtils;

public class AdminDAO implements Serializable{
	
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
	public AdminDAO() {
		try {
			conn = RwsOffices.getConn();
		} catch (Exception e) {
			Debug.writeln("Exception AdminDAO() : \n" + e);
		}
	}

	public AdminDAO(DataSource dataSource) {
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

	public boolean log(LogBean logBean, ServletRequest request) {
		this.session = ((HttpServletRequest) request).getSession();
		System.out.println("log this.session :"+this.session);
		ArrayList previousVisitedModules = null;
		ArrayList paths = new ArrayList();
		boolean visited = false;
		String page = logBean.getPage();
		String presentModule = "";
		boolean loggedSuccessfully = true;	
		try {
			if (dataSource != null)
				conn = RwsOffices.getConn();					
			String path = "";
			int slashAt = 0;
			int slashCount = 0;
			for (int i = 0; i < page.length(); i++) {
				if (page.charAt(i) == '/' || page.charAt(i) == '.') {
					if (i != 0) {
						path = page.substring(slashAt + 1, i);
						paths.add(path);
					}
					slashCount++;
					slashAt = i;
				}
			}
			if (((String) paths.get(1)).equalsIgnoreCase("switch")) {
				String prefix = (String) request.getParameter("prefix");
				prefix = prefix.substring(1, prefix.length());
				page = (String) request.getParameter("page");
				page = page.substring(1, page.length());
				logBean.setPage("/" + prefix + "/" + page);
				paths.set(1, prefix);

			}
			presentModule = (String) paths.get(1);
			previousVisitedModules = (ArrayList) session.getAttribute("visitedModules");
			if (previousVisitedModules != null) {
				for (int i = 0; i < previousVisitedModules.size(); i++) {
					if (presentModule.equals((String) previousVisitedModules.get(i)))
						visited = true;
				}
			} else {
				visited = false;
				previousVisitedModules = new ArrayList();
			}
			//System.out.println("Logout AdminDAO visited :"+visited);
			if (visited == false) {
				query = "INSERT INTO RWS_LOG_TBL(USER_ID,AUTH_TYPE,ACCESS_DATE,ACCESS_TIME,MODULE,PAGE,ADDRESS,HOST,BROWSER) VALUES(?, ?, SYSDATE, ?, ?, ?, ?, ?, ?)";
				stat = conn.prepareStatement(query);
				stat.setString(1, logBean.getUserId());
				stat.setString(2, logBean.getAuthType());
				stat.setString(3, logBean.getAccessTime());
				stat.setString(4, logBean.getModule());
				stat.setString(5, logBean.getPage());
				stat.setString(6, logBean.getAddress());
				stat.setString(7, logBean.getHost());
				stat.setString(8, logBean.getBrowser());
				int rcount = stat.executeUpdate();//System.out.println("rcount : "+rcount);
				previousVisitedModules.add(paths.get(1));
				session.setAttribute("visitedModules", previousVisitedModules);				
			}
		} catch (Exception e) {
			e.printStackTrace();
			Debug.writeln("The Exception is in AdminDAO log : \n" + e.getMessage());
			loggedSuccessfully = false;
			session.setAttribute("logException", e + "");
		} finally {
			closeAll();
		}
		return loggedSuccessfully;
	}

	public boolean logout(LogBean logBean, ServletRequest request,Boolean flag) {
		this.session = ((HttpServletRequest) request).getSession();	
		System.out.println("GENERAL LOGOUT this.session :"+this.session);
		int rcount=0;		
		try {			
			conn = RwsOffices.getConn();		
	        if(flag){
	        	query = "UPDATE RWS_AGENCY_LOG_TBL SET LOGOUT_TIME =? WHERE SESSION_ID=? ";
	        	System.out.println("LogOut Updated");
	        	psat=conn.prepareStatement(query);
	        	ValidationUtils validation = new ValidationUtils();
	        	psat.setString(1, logBean.getAccessTime());
	        	psat.setString(2, session.getId());
	        	rcount = psat.executeUpdate();	
	        }			
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO logout : \n" + e.getMessage());					
		} finally {
			closeAll();
			if(psat!=null)
				try {
					psat.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		if(rcount>0)
			return true;
		else
			return false;
	}
	
	/**
	 * Authenticate the user based on the userid and password. Store the user
	 * details in the session, if valid.
	 * 
	 * @param userId
	 * @param password
	 */
	public RwsUser authenticate(String userId, String password, String slt) {
		String officeCode = null, officeName = null, designationCode = null, designationName = null;
		String scopeOfAccess = null, permissions = null, headOfficeCode = null, headOfficeName = null;
		String circleOfficeCode = null, circleOfficeName = null, divisionOfficeCode = null;
		String divisionOfficeName = null, subdivisionOfficeCode = null, subdivisionOfficeName = null;
		String lastLoginTime = null;
		RwsUser user = new RwsUser();

		boolean validUser = false, validUser1 = false, validUser2 = false;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT P.office_code, P.designation_code, D.designation_acr, "
					+ " P.scope_of_access, P.permission ,P.password,round((sysdate-45)-pwd_update_date) as dd,P.status,p.EMAIL_ID,(SELECT NVL(TO_CHAR(MAX(t.access_date),'DD-MON-YYYY HH24:MI:SS'),'-')  FROM RWS_LOG_TBL T WHERE t.user_id=P.user_id AND T.ACCESS_DATE NOT IN (SELECT MAX(TT.ACCESS_DATE)  FROM RWS_LOG_TBL TT WHERE TT.USER_ID=T.USER_ID)) LASTLOGIN"
					+ " FROM rws_password_tbl P, rws_designation_tbl D "
					+ " WHERE user_id LIKE ? "
					+ " AND (account_deactivation_date IS NULL OR account_deactivation_date <= SYSDATE) "
					+ " AND P.designation_code = D.designation_code ";

			ps = conn.prepareStatement(query);
			ps.setString(1, userId);
			rset = ps.executeQuery();
			int rowCount = 0;
			while (rset.next()) {
				if (rset.getString("EMAIL_ID") != null) {
					user.setIsEmailRegistered("true");
				} else {
					user.setIsEmailRegistered("false");
				}
				rowCount++;
				officeCode = rset.getString(1);
				designationCode = rset.getString(2);
				designationName = rset.getString(3);
				scopeOfAccess = rset.getString(4);
				permissions = rset.getString(5);
				String dbPwd = rset.getString("password");//System.out.println("AdminDAO-dbPwd :"+dbPwd);
				lastLoginTime = rset.getString("LASTLOGIN");//System.out.println("lastLoginTime :"+lastLoginTime);
				String firstPwdHash = new String(Base64.decode(dbPwd));//System.out.println("AdminDAO-firstPwdHash :"+firstPwdHash);
				String saltedFirstHash = firstPwdHash+slt;
				//System.out.println("AdminDAO-firstPwdHash :"+firstPwdHash);
				//System.out.println("AdminDAO-slt :"+slt);
				//System.out.println("AdminDAO-saltedFirstHash :"+saltedFirstHash);
				String secondHash = MakeHashUtils.sha256(saltedFirstHash);
				//System.out.println("AdminDAO-secondHash :"+secondHash);
				//System.out.println("firstPwdHash :"+firstPwdHash);
				//System.out.println("saltedFirstHash :"+saltedFirstHash);
				//System.out.println("UserAth :"+secondHash);
				
				if(password != null && password.equals(secondHash)) {
					validUser = true;
					if (userId.equals(rset.getString("password"))) {
						validUser1 = true;
					}
					if (!validUser1) {
						if (rset.getString("dd") == null || rset.getInt("dd") > 0) {
							validUser2 = true;
						}
					}
				}
			}
			if (validUser1) {
				user.setErrorMessage("UserIdAndPwdSame");
			}
			if (validUser2) {
				user.setErrorMessage("UserIdAndPwdExpire");
			}
			if (rowCount == 0 || validUser == false) {
				user.setAuthenticated(false);
			} else {
				headOfficeCode = officeCode.substring(0, 1);
				circleOfficeCode = officeCode.substring(1, 3);
				divisionOfficeCode = officeCode.substring(3, 4);
				subdivisionOfficeCode = officeCode.substring(4, 6);
				user.setHeadOfficeCode(headOfficeCode);
				user.setCircleOfficeCode(circleOfficeCode);
				user.setDivisionOfficeCode(divisionOfficeCode);
				user.setSubdivisionOfficeCode(subdivisionOfficeCode);
				user.setOfficeName("");
				if (!headOfficeCode.equals("0")) {
					query = "SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE =  ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						headOfficeName = rset.getString(1);
					}
					user.setOfficeName("Head Office");
					user.setHeadOfficeName(headOfficeName);
				}
				if (!circleOfficeCode.equals("00")) {
					query = "SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						circleOfficeName = rset.getString(1);
					}
					user.setOfficeName("Circle Office");
					user.setCircleOfficeName(circleOfficeName);
					String districtOfficeName = "";
					query = "SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE = ?";
					stat = conn.prepareStatement(query);
					stat.setString(1, circleOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						districtOfficeName = rset.getString(1);
					}
					user.setDistrictOfficeName(districtOfficeName);
				}

				if (!divisionOfficeCode.equals("0")) {
					query = "SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					stat.setString(3, divisionOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						divisionOfficeName = rset.getString(1);
					}
					user.setOfficeName("Division Office");
					user.setDivisionOfficeName(divisionOfficeName);
				}

				if (!subdivisionOfficeCode.equals("00")) {
					query = "SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					stat.setString(3, divisionOfficeCode);
					stat.setString(4, subdivisionOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						subdivisionOfficeName = rset.getString(1);
					}
					user.setOfficeName("Sub Division Office");
					user.setSubdivisionOfficeName(subdivisionOfficeName);
				}
				if (!userId.equalsIgnoreCase("admin") && !userId.equalsIgnoreCase("ENC") && !userId.equalsIgnoreCase("guest") && subdivisionOfficeCode.equals("00") && (userId.substring(4, 6).equals("AO") || userId.substring(4, 6).equals("EE"))) {
					query = "SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL  WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					stat.setString(3, divisionOfficeCode);
					stat.setString(4, subdivisionOfficeCode);					
					rset = stat.executeQuery();
					while (rset.next()) {
						subdivisionOfficeName = rset.getString(1);
					}
					if (userId.substring(4, 6).equals("AO"))
						user.setOfficeName("Divisional Accounts Officer");
					else if (userId.substring(4, 6).equals("EE"))
						user.setOfficeName("Executive Engineer");
					user.setSubdivisionOfficeName(subdivisionOfficeName);
				}
				user.setUserId(userId);
				user.setOfficeCode(officeCode);
				user.setDesignationCode(designationCode);
				if (userId.equalsIgnoreCase("guest"))
					user.setOfficeName("Guest ");
				user.setDesignationName(designationName);
				user.setScopeOfAccess(scopeOfAccess);
				user.setPermissions(permissions);
				user.setLastLoginTime(lastLoginTime);//System.out.println("lastLoginTime_2 :"+lastLoginTime);
				user.setAuthenticated(true);
				user.setHeadOfOffice(false);
				query = "SELECT COUNT(*) FROM RWS_HEAD_OF_OFFICE_TBL WHERE OFFICE LIKE UPPER( ? ) AND DESIGNATION_CODE = ? ";
				if (stat != null)
					stat.close();
				stat = conn.prepareStatement(query);
				stat.setString(1, user.getOfficeName());
				stat.setString(2, user.getDesignationCode());
				rset = stat.executeQuery();
				if (rset.next()) {
					if (rset.getInt(1) == 1)
						user.setHeadOfOffice(true);
				}
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO authenticate : \n" + e.getMessage());
			if (conn == null)
				user.setErrorMessage(("Cannot Connect to the Server"));
			user.setException(e);
		} finally {
			closeAll();
		}
		return user;
	}
	public RwsUser authenticateGrievance(String userId, String password, String slt) {
		String agencyCode = null, officeName = null, designationCode = null, designationName = null;
		String scopeOfAccess = null, permissions = null, headOfficeCode = null, headOfficeName = null;
		String circleOfficeCode = null, circleOfficeName = null, divisionOfficeCode = null;
		String divisionOfficeName = null, subdivisionOfficeCode = null, subdivisionOfficeName = null;
		RwsUser user = new RwsUser();
		boolean validUser = false, validUser1 = false, validUser2 = false;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT AGENCY_CODE,USER_ID,PASSWORD,SCOPE_OF_ACCESS,PERMISSION,ACCOUNT_ACTIVATION_DATE,ACCOUNT_DEACTIVATION_DATE,PASSWORD_RECOVERY_HINT,ROUND((SYSDATE-45)-PWD_UPDATE_DATE) AS DD,EMAIL_ID,MOBILE_NO,STATUS,REMARKS  FROM RWS_AGENCY_PWD_TBL  WHERE USER_ID LIKE ? AND (ACCOUNT_DEACTIVATION_DATE IS NULL OR ACCOUNT_DEACTIVATION_DATE <= SYSDATE)";
			ps = conn.prepareStatement(query);
			ps.setString(1, userId);
			rset = ps.executeQuery();
			int rowCount = 0;
			while (rset.next()) {
				if (rset.getString("EMAIL_ID") != null) {
					user.setIsEmailRegistered("true");
				} else {
					user.setIsEmailRegistered("false");
				}
				rowCount++;
				user.setUserId(userId);
				agencyCode = rset.getString("AGENCY_CODE");
				scopeOfAccess = rset.getString("SCOPE_OF_ACCESS");
				permissions = rset.getString("PERMISSION");
				String dbPwd = rset.getString("password");
				String firstPwdHash = new String(Base64.decode(dbPwd));
				String saltedFirstHash = firstPwdHash+slt;
				String secondHash = MakeHashUtils.sha256(saltedFirstHash);
				//System.out.println("secondHash1 :"+secondHash);
				if (password != null && password.equals(secondHash)) {
					validUser = true;
					if (userId.equals(rset.getString("password"))) {
						validUser1 = true;
					}
					if (!validUser1) {
						if (rset.getString("dd") == null || rset.getInt("dd") > 0) {
							validUser2 = true;
						}
					}
				}
			}
			if (validUser1) {
				user.setErrorMessage("UserIdAndPwdSame");
			}
			if (validUser2) {
				user.setErrorMessage("UserIdAndPwdExpire");
			}
			if (rowCount == 0 || validUser == false) {
				user.setAuthenticated(false);
			} else {
				user.setAuthenticated(true);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO authenticateGrievance : \n" + e.getMessage());
			if (conn == null)
				user.setErrorMessage(("Cannot Connect to the Server"));
			user.setException(e);
		} finally {
			closeAll();
		}
		return user;
	}

	public int getPendingProposals(String userId, String proposalType) {
		int no_of_proposals = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_WORK_PROPOSAL_TBL PT, RWS_PROPOSAL_WORKFLOW_TBL PWT WHERE PT.PROPOSAL_ID = PWT.PROPOSAL_ID AND PT.FLAG = ? AND SENT_TO = ? AND PWT.FLAG='N'";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalType);
			stat.setString(2, userId);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_proposals = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingProposals : \n" + e.getMessage());
		} finally {
			closeAll();
		}
		return no_of_proposals;
	}

	public int getOMPendingProposals(String userId, String proposalType) {
		int no_of_proposals = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_OM_PROPOSAL_TBL OPT, RWS_OM_PROPOSAL_WORKFLOW_TBL OPWT WHERE OPT.OM_PROPOSAL_ID = OPWT.OM_PROPOSAL_ID AND OPT.FLAG = ?  AND SENT_TO = ? AND OPWT.FLAG='N'";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalType);
			stat.setString(2, userId);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_proposals = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getOMPendingProposals : \n" + e.getMessage());
		} finally {
			closeAll();
		}
		return no_of_proposals;
	}

	public int getPendingEstimates(String userId) {
		int no_of_estimates = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_NEW_EST_TBL E, RWS_NEW_EST_WORKFLOW_TBL W WHERE E.WORK_ID = W.WORK_ID AND W.FLAG = 'N' AND W.SENT_TO = ? ";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, userId);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_estimates = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingEstimates : \n" + e.getMessage());
		} finally {
			closeAll();
		}
		return no_of_estimates;
	}

	public int getOMPendingEstimates(String userId) {
		int no_of_estimates = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_OM_EST_TBL E, RWS_OM_EST_WORKFLOW_TBL W WHERE E.WORK_ID = W.WORK_ID AND W.FLAG = 'N' AND W.SENT_TO = ? ";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, userId);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_estimates = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getOMPendingEstimates : \n" + e.getMessage());
		} finally {
			closeAll();
		}
		return no_of_estimates;
	}

	public int getPendingVouchers(String userId) {
		int no_of_proposals = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_WORK_EXP_VOUCHER_TBL A,RWS_WORK_ADMN_TBL B WHERE A.WORK_ID=B.WORK_ID AND SUBSTR(B.OFFICE_CODE,2,3)= ? AND (CHEQUE_NO IS NULL OR CHEQUE_DT IS NULL)";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, userId.substring(1, 4));
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_proposals = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingProposals : \n" + e.getMessage());
		} finally {
			closeAll();
		}
		return no_of_proposals;
	}

	public int updateUser(AdminDTO adminDTO) {
		int updateCount = 0;
		char modules[] = new char[8];
		char permissions[] = new char[3];		
		if (adminDTO.getProposals() != null	&& adminDTO.getProposals().equals("1"))
			modules[0] = '1';
		else
			modules[0] = '0';
		
		if (adminDTO.getEstimates() != null	&& adminDTO.getEstimates().equals("1"))
			modules[1] = '1';
		else
			modules[1] = '0';
		
		if (adminDTO.getWaterquality() != null && adminDTO.getWaterquality().equals("1"))
			modules[2] = '1';
		else
			modules[2] = '0';
		
		if (adminDTO.getContractor() != null && adminDTO.getContractor().equals("1"))
			modules[3] = '1';
		else
			modules[3] = '0';
		
		if (adminDTO.getWorks() != null && adminDTO.getWorks().equals("1"))
			modules[4] = '1';
		else
			modules[4] = '0';
		
		if (adminDTO.getAssets() != null && adminDTO.getAssets().equals("1"))
			modules[5] = '1';
		else
			modules[5] = '0';
		
		if (adminDTO.getFunds() != null && adminDTO.getFunds().equals("1"))
			modules[6] = '1';
		else
			modules[6] = '0';

		if (adminDTO.getMasters() != null && adminDTO.getMasters().equals("1"))
			modules[7] = '1';
		else
			modules[7] = '0';

		if (adminDTO.getRead() != null && adminDTO.getRead().equals("1"))
			permissions[0] = '1';
		else
			permissions[0] = '0';

		if (adminDTO.getWrite() != null && adminDTO.getWrite().equals("1"))
			permissions[1] = '1';
		else
			permissions[1] = '0';

		if (adminDTO.getDel() != null && adminDTO.getDel().equals("1"))
			permissions[2] = '1';
		else
			permissions[2] = '0';

		try {
			conn = RwsOffices.getConn();
			query = "UPDATE RWS_PASSWORD_TBL SET SCOPE_OF_ACCESS = ?, PERMISSION = ?, PASSWORD_RECOVERY_HINT = ? WHERE USER_ID = ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, String.valueOf(modules));
			stat.setString(2, String.valueOf(permissions));
			stat.setString(3, adminDTO.getHint());
			stat.setString(4, adminDTO.getUserid());
			updateCount = stat.executeUpdate();			
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO  updateUser : " + e.getMessage());
		} finally {
			closeAll();
		}
		return updateCount;
	}

	public int removeUser(String userId) {
		int updateCount = 0;
		try {
			conn = RwsOffices.getConn();
			query = "DELETE FROM RWS_PASSWORD_TBL WHERE USER_ID = ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, userId);
			updateCount = stat.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO  removeUser : " + e.getMessage());
		} finally {
			closeAll();
		}
		return updateCount;
	}

	public AdminDTO getUserDetails(String userid) {
		adminDTO = new AdminDTO();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT USER_ID, DECODE(SUBSTR(SCOPE_OF_ACCESS, 1,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 2,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 3,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 4,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 5,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 6,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 7,1), '1', '1',''), "
					+ " DECODE(SUBSTR(SCOPE_OF_ACCESS, 8,1), '1', '1',''), "
					+ " DECODE(SUBSTR(PERMISSION, 1,1), '1', '1',''), "
					+ " DECODE(SUBSTR(PERMISSION, 2,1), '1', '1',''), "
					+ " DECODE(SUBSTR(PERMISSION, 3,1), '1', '1',''), "
					+ " PASSWORD_RECOVERY_HINT, D.DESIGNATION_ACR, SUBSTR(OFFICE_CODE,1,1),"
					+ " SUBSTR(OFFICE_CODE,2,2), SUBSTR(OFFICE_CODE,4,1), SUBSTR(OFFICE_CODE,5,2) "
					+ " FROM RWS_PASSWORD_TBL P, RWS_DESIGNATION_TBL D "
					+ " WHERE P.DESIGNATION_CODE = D.DESIGNATION_CODE "
					+ " AND USER_ID = ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, userid);
			rset = stat.executeQuery();
			if (rset.next()) {
				adminDTO.setUserid(rset.getString(1));
				adminDTO.setProposals(rset.getString(2));
				adminDTO.setEstimates(rset.getString(3));
				adminDTO.setWaterquality(rset.getString(4));
				adminDTO.setContractor(rset.getString(5));
				adminDTO.setWorks(rset.getString(6));
				adminDTO.setAssets(rset.getString(7));
				adminDTO.setFunds(rset.getString(8));
				adminDTO.setMasters(rset.getString(9));
				adminDTO.setRead(rset.getString(10));
				adminDTO.setWrite(rset.getString(11));
				adminDTO.setDel(rset.getString(12));
				adminDTO.setHint(rset.getString(13));
				adminDTO.setDesignation(rset.getString(14));
				String headOfficeCode = rset.getString(15);
				String circleOfficeCode = rset.getString(16);
				String divisionOfficeCode = rset.getString(17);
				String subdivisionOfficeCode = rset.getString(18);			
				
				if (userid.substring(0,2).equals("MD")) {
					query = "SELECT MNAME FROM RWS_MANDAL_TBL WHERE DCODE = ? AND MCODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, userid.substring(2,4));
					stat.setString(2, userid.substring(4,6));
					rset = stat.executeQuery();
					if (rset.next())
						adminDTO.setMandal(rset.getString(1));
				}
				
				if (subdivisionOfficeCode != null && !subdivisionOfficeCode.equals("00")) {
					query = "SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					stat.setString(3, divisionOfficeCode);
					stat.setString(4, subdivisionOfficeCode);
					rset = stat.executeQuery();
					if (rset.next())
						adminDTO.setSubdivisionOfficeName(rset.getString(1));
				}
				if (divisionOfficeCode != null && !divisionOfficeCode.equals("0")) {
					query = "SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					stat.setString(3, divisionOfficeCode);
					rset = stat.executeQuery();
					if (rset.next())
						adminDTO.setDivisionOfficeName(rset.getString(1));
				}
				if (circleOfficeCode != null && !circleOfficeCode.equals("00")) {
					query = "SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					rset = stat.executeQuery();
					if (rset.next())
						adminDTO.setCircleOfficeName(rset.getString(1));
				}
				if (headOfficeCode != null && !headOfficeCode.equals("0")) {
					query = "SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					rset = stat.executeQuery();
					if (rset.next())
						adminDTO.setHeadOfficeName(rset.getString(1));
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO  getUserDetails : " + e.getMessage());
		} finally {
			closeAll();
		}
		return adminDTO;
	}

	public ArrayList findAllUsers(String officeCode) {
		ArrayList users = new ArrayList();
		rwsOffices = new RwsOffices(dataSource);
		try {
			conn = RwsOffices.getConn();
			query = " SELECT P.USER_ID, "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),1,1), '1', 'PROPOSALS', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),2,1), '1', 'ESTIMATES', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),3,1), '1', 'WATER QUALITY MANAGEMENT', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),4,1), '1', 'CONTRACTOR MANAGEMENT', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),5,1), '1', 'WORKS MONITORING', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),6,1), '1', 'ASSET MANAGEMENT AND COMPLAINTS MONITORING', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),7,1), '1', 'FUND ACCOUNTING', ''), "
					+ " DECODE(SUBSTR(NVL(P.SCOPE_OF_ACCESS,'00000000'),8,1), '1', 'MASTERS', ''), "
					+ " DECODE(SUBSTR(NVL(P.PERMISSION,'000'),1,1), '1', 'READ', ''), "
					+ " DECODE(SUBSTR(NVL(P.PERMISSION,'000'),2,1), '1', 'WRITE', ''), "
					+ " DECODE(SUBSTR(NVL(P.PERMISSION,'000'),3,1), '1', 'DELETE', ''), "
					+ " TO_CHAR(P.ACCOUNT_ACTIVATION_DATE,'DD/MM/YYYY'), D.DESIGNATION_ACR, P.OFFICE_CODE "
					+ " FROM RWS_PASSWORD_TBL P, RWS_DESIGNATION_TBL D "
					+ " WHERE P.DESIGNATION_CODE = D.DESIGNATION_CODE ";
			if (!officeCode.equals(""))
				query += " AND OFFICE_CODE LIKE ? ";
			stat = conn.prepareStatement(query);
			if (!officeCode.equals("")){
				stat.setString(1, officeCode+"%");
			}
			rset = stat.executeQuery();
			Employee employee = null;
			while (rset.next()) {
				employee = new Employee();
				employee.setUserid(rset.getString(1));
				employee.setProposals(rset.getString(2));
				employee.setEstimates(rset.getString(3));
				employee.setWaterquality(rset.getString(4));
				employee.setContractor(rset.getString(5));
				employee.setWorks(rset.getString(6));
				employee.setAssets(rset.getString(7));
				employee.setFunds(rset.getString(8));
				employee.setMasters(rset.getString(9));
				employee.setRead(rset.getString(10));
				employee.setWrite(rset.getString(11));
				employee.setDelete(rset.getString(12));
				employee.setAccountActivationDate(rset.getString(13));
				employee.setDesignation(rset.getString(14));
				employee.setOfficeName(rwsOffices.getOfficeName(rset.getString(15), true, conn));
				users.add(employee);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO  findAllUsers : " + e.getMessage());
		} finally {
			closeAll();
		}
		return users;
	}

	public int getNextRoleId() {
		int roleId = 0;
		try {
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement("SELECT MAX(ROLE_ID) FROM RWS_ROLES_TBL");
			rset = stat.executeQuery();
			if (rset.next()) {
				roleId = rset.getInt(1);
				roleId++;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO  getNextRoleId : " + e);
		} finally {
			closeAll();
		}
		return roleId;
	}

	public int insertRole(String roleId, String roleName, String roleDesc) {
		int updateCount = 0;
		try {
			conn = RwsOffices.getConn();
			query = " INSERT INTO RWS_ROLES_TBL VALUES(?, ?, ?)";
			stat = conn.prepareStatement(query);
			stat.setString(1, roleId);
			stat.setString(2, roleName);
			stat.setString(3, roleDesc);
			updateCount = stat.executeUpdate();
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO insertRole : " + e);
		} finally {
			closeAll();
		}
		return updateCount;
	}

	public int updateRole(String roleId, String roleName, String roleDesc) {
		int updateCount = 0;
		try {
			conn = RwsOffices.getConn();
			query = "UPDATE RWS_ROLES_TBL SET ROLE_NAME = UPPER(?), ROLE_DESCRIPTION = UPPER(?) WHERE ROLE_ID = ?";
			stat = conn.prepareStatement(query);
			stat.setString(1, roleName);
			stat.setString(2, roleDesc);
			stat.setString(3, roleId);
			updateCount = stat.executeUpdate();
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO updateRole : " + e);
		} finally {
			closeAll();
		}
		return updateCount;
	}

	public int removeRole(String roleId) {
		int updateCount = 0;
		try {
			conn = RwsOffices.getConn();
			query = "DELETE FROM RWS_ROLES_TBL WHERE ROLE_ID = ?";
			stat = conn.prepareStatement(query);	
			stat.setString(1, roleId); 
			updateCount = stat.executeUpdate();
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO removeRole : " + e);
		} finally {
			closeAll();
		}
		return updateCount;
	}

	public AdminDTO getRoleDetails(String roleId) {
		try {
			conn = RwsOffices.getConn();
			query = "SELECT ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION FROM RWS_ROLES_TBL WHERE ROLE_ID = ?";
			stat = conn.prepareStatement(query);
			stat.setString(1, roleId);
			rset = stat.executeQuery();
			adminDTO = new AdminDTO();
			if (rset.next()) {
				adminDTO.setRoleId(rset.getString(1));
				adminDTO.setRoleName(rset.getString(2));
				adminDTO.setRoleDesc(rset.getString(3));
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getRoleDetails : " + e);
		} finally {
			closeAll();
		}
		return adminDTO;
	}

	public ArrayList getRoles() {
		ArrayList roles = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION FROM RWS_ROLES_TBL ORDER BY ROLE_ID ";
			stat = conn.prepareStatement(query);			
			rset = stat.executeQuery();
			AdminDTO adminDTO = null;
			while (rset.next()) {
				adminDTO = new AdminDTO();
				adminDTO.setRoleId(rset.getString(1));
				adminDTO.setRoleName(rset.getString(2));
				adminDTO.setRoleDesc(rset.getString(3));
				roles.add(adminDTO);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getRoles : " + e);
		} finally {
			closeAll();
		}
		return roles;
	}

	public ArrayList getDesignations(int heirarchyCode) {
		ArrayList designations = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT D.designation_acr, D.designation_code FROM rws_designation_tbl D, rws_designation_heirarchy_tbl H "
					+ " WHERE D.designation_code = H.designation_code AND H.heirarchy_code  >= ? ";
			stat = conn.prepareStatement(query);
			stat.setInt(1, heirarchyCode);			
			rset = stat.executeQuery();
			LabelValueBean labelValueBean = null;
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setValue(rset.getString(2));
				designations.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getDesignations : " + e);
		} finally {
			closeAll();
		}
		return designations;
	}

	public String getCaptchaCode() {
		String capstr = "Error";
		Random rdm = new Random();
		int rl = rdm.nextInt(54545451);
		try {
			String hash1 = Integer.toHexString(rl);
			while (hash1.length() < 6) {
				rl = rdm.nextInt(54545451);
				hash1 = Integer.toHexString(rl);
			}
			capstr = hash1.substring(0, 6).toUpperCase();
			System.out.println("AdminDAO getCaptchaCode :"+capstr);
			
		} catch (Exception e) {
			System.out.println("The exception in AdminDAo getCaptchaCode = "+e.getMessage());
		}
		return capstr;
	}

	public String getNewUserId(String hoc, String coc, String doc, String sdoc,String mcode) {
		String userId = "";
		try {
			if (hoc != null && !hoc.equals(""))
				userId += hoc;
			if (coc != null && !coc.equals(""))
				userId += coc;
			else
				userId += "00";
			if (doc != null && !doc.equals(""))
				userId += doc;
			else
				userId += "0";
			if (sdoc != null && !sdoc.equals(""))
				userId += sdoc;
			else
				userId += "00";
			if(mcode != null && !mcode.equals("") && !mcode.equals("00"))
				userId="MD"+coc+mcode;
			
		} catch (Exception e) {
			System.out.println("The exception in AdminDAO getNewUserId = " +e.getMessage());
		} 
		return userId;
	}

	public int getPendingBills(String userId) {
		int no_of_proposals = 0;
		try {
			query = "SELECT COUNT(*) FROM RWS_WORK_BILL_TBL A,RWS_WORK_ADMN_TBL B WHERE A.WORK_ID=B.WORK_ID AND EE_FWD_DATE IS NULL AND BILL_SL_NO<> 0 AND SUBSTR(B.OFFICE_CODE,2,3)= ? ";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, userId.substring(1, 4));
			rset = stat.executeQuery();
			if (rset.next()) {
				no_of_proposals = rset.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("The exception in AdminDAO getPendingBills = " +e.getMessage());
		} finally {
			closeAll();
		}

		return no_of_proposals;
	}

	public boolean getHabFreezUnfreez(int hyear, String pyear, String fyear) {
		Connection conn = null;
		Statement stmt = null;
		int[] mycount = null;
		boolean flag = true;
		String myresult = "";
		String extbl = "", stdt1 = "", stdt2 = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt=conn.createStatement();
			query = "SELECT TNAME FROM TAB WHERE TNAME=?";
			stat1 = conn.prepareStatement(query);
			stat1.setString(1, "RWS_HABITATION_DIR_HIS"+hyear+"_TBL");			
			rset = stat1.executeQuery();
			if (rset.next()) {
				extbl = rset.getString(1);
			}
			
			qry = "SELECT DISTINCT SUBSTR((TO_CHAR(STATUS_DATE,'DD-MM-YYYY')),9,10) AS TDT FROM RWS_HABITATION_DIR_HIS_TBL WHERE STATUS_DATE IS NOT NULL";
			stat2 = conn.prepareStatement(qry);
			rset1 = stat2.executeQuery();
			if (rset1.next()) {
				stdt1 = rset1.getString(1);
			}
			
			que = "SELECT DISTINCT SUBSTR((TO_CHAR(STATUS_DATE,'DD-MM-YYYY')),9,10) FROM RWS_HABITATION_DIRECTORY_TBL WHERE STATUS_DATE IS NOT NULL";
			stat3 = conn.prepareStatement(que);
			rset2 = stat3.executeQuery();
			if (rset2.next()) {
				stdt2 = rset2.getString(1);
			}
			
			if (!extbl.equals("")) {
				flag = false;
			}
			else if (stdt1.equals(pyear)) {
				flag = false;

			} else if (stdt2.equals(fyear)) {
				flag = false;

			} else {
				String query1 = "create table RWS_HABITATION_DIR_HIS" + hyear + "_TBL as select * from RWS_HABITATION_DIR_HIS_TBL";
				stmt.addBatch(query1);
				String query2 = "drop table RWS_HABITATION_DIR_HIS_TBL";
				stmt.addBatch(query2);
				String query3 = "create table RWS_HABITATION_DIR_HIS_TBL as select * from rws_habitation_directory_tbl";
				stmt.addBatch(query3);
				String query4 = "update rws_habitation_dir_dyna_tbl set status_date='01-APR-"+ fyear + "',PREVIOUS_YR_STATUS=coverage_status";
				stmt.addBatch(query4);
				String query5 = "update RWS_HABITATION_DIRECTORY_TBL a set(CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,"						
						+ "CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,"
						+ "NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,"
						+ "HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,"
						+ "POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,"
						+ "HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,"
						+ "NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,SCHEMESOURCE)"
						+ "=(select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,"
						+ "PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,"
						+ "UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,"
						+ "EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,"
						+ "HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,"
						+ "CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,"
						+ "SCHEMESOURCE from RWS_HABITATION_DIR_DYNA_TBL b where a.HAB_CODE=b.HAB_CODE)";
				stmt.addBatch(query5);
				mycount = stmt.executeBatch();
				for (int i = 0; i < mycount.length; i++) {
					if (mycount[i] == 1)
						flag = false;
				}
				flag = true;
				if (flag)
					conn.commit();
				conn.setAutoCommit(true);
				myresult = "success";
			}
		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println("The Exception is in AdminDAO getHabFreezUnfreez = " + e.getMessage());
		} finally {
			closeAll();
		}
		return flag;
	}

	public String getHYear() {
		String cyear = "";
		Connection conn = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			query = "SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') FROM DUAL";
			stat1 = conn.prepareStatement(query);
			rset = stat1.executeQuery();
			if (rset.next()) {
				cyear = rset.getString(1);
			}	
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getHYear : " + e.getMessage());
		} finally{
			closeAll();
		}
		return cyear;
	}

	public String getBankStatus(String userId) {
		String bank_status = "";
		try {
			query = "SELECT TO_CHAR(SEND_DATE,'DD/MM/YYYY') FROM  RWS_BILL_BANK_SETTLEMENT_TBL WHERE BILL_ACTIVATION_FLAG='I' ";
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			if (rset.next()) {
				bank_status = rset.getString(1);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getPendingProposals : " + e.getMessage());
		} finally {
			closeAll();
		}
		return bank_status;
	}

	public String getSecMessages(String userId) {
		String sec_msgs = "";
		String loginuserid = "", myuserid = "";
		try {
			if ((userId != null && userId.equals("guest"))) {
				return "";
			}
			loginuserid = userId;
			int size = loginuserid.length();
			if (loginuserid.equals("admin") || loginuserid.equals("100000")	|| loginuserid.equals("secrwss") || loginuserid.equals("minrwss") || loginuserid.equals("EE-Budget") || loginuserid.equals("ENC")) {
				myuserid = "where";
			}
			if (!loginuserid.equals("admin") && !loginuserid.equals("100000") && (size == 6)) {
				if (!loginuserid.substring(1, 3).equals("00") && loginuserid.substring(3, 4).equals("0") && loginuserid.substring(4, 6).equals("00")) {
					myuserid = "where TO_OFFICE_LEVEL ='HO,CO' and ";
				}
				if (!loginuserid.substring(1, 3).equals("00") && !loginuserid.substring(3, 4).equals("0") && loginuserid.substring(4, 6).equals("00")) {
					myuserid = "where TO_OFFICE_LEVEL ='HO,CO,DO' and ";
				}
				if (!loginuserid.substring(1, 3).equals("00") && !loginuserid.substring(3, 4).equals("0") && !loginuserid.substring(4, 6).equals("00")) {
					myuserid = "where TO_OFFICE_LEVEL ='HO,CO,DO,SO' and";
				}
				if (!loginuserid.substring(1, 3).equals("00")
						&& !loginuserid.substring(3, 4).equals("0")
						&& !loginuserid.substring(4, 6).equals("00")) {
					myuserid = "where TO_OFFICE_LEVEL ='HO,CO,DO,SO' and";
				}

			}
		query = "SELECT SUBSTR(MESSAGE_DETAILS,1,5),TO_CHAR(MESSAGE_DATE,'DD-MON-YYYY'),MESSAGE_PRIORITY FROM RWS_SECRETARY_MESSAGE_TBL "
					+ myuserid
					+ " MESSAGE_DATE =(SELECT MAX(MESSAGE_DATE) FROM  RWS_SECRETARY_MESSAGE_TBL ) ";

		    conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				sec_msgs = "MSG: " + rset.getString(1) + " &nbsp;Date: " + rset.getString(2);
			}
		} catch (Exception e) {
			System.out.println("query : " + query);
			System.out.println("The Exception is in AdminDAO getSecMessages : " + e);
		} finally {
			closeAll();
		}

		return sec_msgs;
	}
	public int getPendingRCS(String userid){
		int no_of_rcs=0;
		try {
			/*System.out.println("AdminDAO userid :"+userid);
			System.out.println("AdminDAO userid :"+userid.substring(3,6));
			System.out.println("AdminDAO userid :"+userid.substring(1,3));*/
			if(userid.equals("admin") || userid.equals("100000") || userid.equals("secrwss") || userid.equals("minrwss")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_RESIDUAL_CHLORINE_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ " and PPM_VALUE<0.2 and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			else if(userid.substring(3,6).equals("vqc")){
				/*System.out.println("ELSE IF");*/
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_RESIDUAL_CHLORINE_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and substr(b.HABITATION_CODE,1,2)="+userid.substring(1,3);
				//System.out.println("ELSE IF query: "+query);
				//stat.setString(1,userid.substring(1,3));
			}
			else{
			query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_RESIDUAL_CHLORINE_SMS_TBL c "
					+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
					+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
					+ "and CIRCLE_OFFICE_CODE= "+userid.substring(1,3);
			   //stat.setString(1,userid.substring(1,3));
			if(!userid.substring(3,4).equals("0")){
						query	+= "and DIVISION_OFFICE_CODE= "+userid.substring(3,4);
						// stat.setString(2,userid.substring(3,4));
					}
					if(!userid.substring(4,6).equals("00")){
					query	+= "and SUBDIVISION_OFFICE_CODE= "+userid.substring(4,6);
					// stat.setString(3,userid.substring(4,6));
					}
							query	+= " and PPM_VALUE<0.2 and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			
			
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				if(userid.substring(3,6).equals("vqc")){
					no_of_rcs = 1;
				}
				else
				no_of_rcs = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingRCS query : \n" + query);
			e.printStackTrace();
			Debug.writeln("The Exception is in AdminDAO getPendingRCS : \n" + e);
		} finally {
			closeAll();
		}
		return no_of_rcs;
		
	}
	public int getPendingDFS(String userid){
		int no_of_dfs=0;
		try {
			if(userid.equals("admin") || userid.equals("100000") || userid.equals("secrwss") || userid.equals("minrwss")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_SCHEME_STATUS_SMS_TBL c "
						+ "where c.SMS_MOBILE=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			
			else if(userid.substring(3,6).equals("vqc")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_SCHEME_STATUS_SMS_TBL c "
						+ "where c.SMS_MOBILE=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and substr(b.HABITATION_CODE,1,2)= "+ userid.substring(1,3);
				       // stat.setString(1, userid.substring(1,3));
			}
			
			else{
			query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_SCHEME_STATUS_SMS_TBL c "
					+ "where c.SMS_MOBILE=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
					+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
					+ "and CIRCLE_OFFICE_CODE= "+userid.substring(1,3);
			        //stat.setString(1, userid.substring(1,3));        
			
					if(!userid.substring(3,4).equals("0")){
						query	+= "and DIVISION_OFFICE_CODE="+userid.substring(3,4);
						//stat.setString(2, userid.substring(3,4));
					}
					if(!userid.substring(4,6).equals("00")){
						query	+=  "and SUBDIVISION_OFFICE_CODE="+userid.substring(4,6);
						//stat.setString(3,userid.substring(4,6));
					}
					query	+= "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_dfs = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingDFS : \n" + e);
		} finally {
			closeAll();
		}
		return no_of_dfs;
		
	}
	public int getPendingDRS(String userid){
		int no_of_drs=0;
		try {
			if(userid.equals("admin") || userid.equals("100000") || userid.equals("secrwss") || userid.equals("minrwss")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_DROUGHT_TANKER_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			else if(userid.substring(3,6).equals("vqc")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_DROUGHT_TANKER_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and substr(b.HABITATION_CODE,1,2)= "+userid.substring(1,3);
				//stat.setString(1, userid.substring(1,3));
			}
			else{
			query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_DROUGHT_TANKER_SMS_TBL c "
					+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE "
					+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
					+ "and CIRCLE_OFFICE_CODE="+ userid.substring(1,3);
			        //stat.setString(1, userid.substring(1,3));
					if(!userid.substring(3,4).equals("0")){
						query	+= "and DIVISION_OFFICE_CODE= "+ userid.substring(3,4);
						//stat.setString(2, userid.substring(3,4));
					}
					if(!userid.substring(4,6).equals("00")){
					query	+= "and SUBDIVISION_OFFICE_CODE="+userid.substring(4,6);
					//stat.setString(3,userid.substring(4,6));
					}
					query	+= "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_drs = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingDRS : \n" + e);
		} finally {
			closeAll();
		}
		return no_of_drs;
		
	}
	public int getPendingOHS(String userid){
		int no_of_ohs=0;
		try {
			if(userid.equals("admin") || userid.equals("100000") || userid.equals("secrwss") || userid.equals("minrwss")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='O'"
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			else if(userid.substring(3,6).equals("vqc")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='O'"
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and substr(b.HABITATION_CODE,1,2)="+userid.substring(1,3);
			    // stat.setString(1, userid.substring(1,3));
			}
			else{
			query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
					+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='O'"
					+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
					+ "and CIRCLE_OFFICE_CODE= "+userid.substring(1,3);
			   // stat.setString(1, userid.substring(1,3));
					if(!userid.substring(3,4).equals("0")){
						query	+= "and DIVISION_OFFICE_CODE= "+userid.substring(3,4);
						 //stat.setString(2,userid.substring(3,4));
					}
					if(!userid.substring(4,6).equals("00")){
					query	+= "and SUBDIVISION_OFFICE_CODE="+userid.substring(4,6);
					// stat.setString(3,userid.substring(4,6));
					}
					query	+= "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_ohs = rset.getInt(1);
			}
		} catch (Exception e) {
			Debug.writeln("The Exception is in AdminDAO getPendingOHS : \n" + e);
		} finally {
			closeAll();
		}
		return no_of_ohs;
		
	}
	public int getPendingGLS(String userid){
		int no_of_gls=0;
		try {
			if(userid.equals("admin") || userid.equals("100000") || userid.equals("secrwss") || userid.equals("minrwss")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='G'"
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			
			else if(userid.substring(3,6).equals("vqc")){
				query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
						+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='G'"
						+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
						+ "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and substr(b.HABITATION_CODE,1,2)="+userid.substring(1,3);
				     //stat.setString(1, userid.substring(1,3));
			}
			else{
			query = "select count(SMS_MOBILE) from  RWS_MANDAL_SUBDIVISION_TBL a,RWS_MOBILE_SMS_REGISTER_TBL b,RWS_OHSR_GLSR_SMS_TBL c "
					+ "where to_char(c.SMS_MOBILE)=b.MOBILE and substr(b.HABITATION_CODE,1,2)=a.DCODE and GLSR_OHSR='G'"
					+ "and substr(b.HABITATION_CODE,6,2)=a.MCODE "
					+ "and CIRCLE_OFFICE_CODE="+userid.substring(1,3);
			        //stat.setString(1,userid.substring(1,3));
					if(!userid.substring(3,4).equals("0")){
						query	+= "and DIVISION_OFFICE_CODE= "+userid.substring(3,4);
						//stat.setString(2,userid.substring(3,4));
					}
					if(!userid.substring(4,6).equals("00")){
					query	+= "and SUBDIVISION_OFFICE_CODE= "+userid.substring(4,6);
					//stat.setString(3, userid.substring(4,6));
					}
					query	+= "and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";
			}
			//System.out.println("admin DAO pending GLS :"+query);
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				no_of_gls = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Debug.writeln("The Exception is in AdminDAO getPendingGLS : \n" + e);
		} finally {
			closeAll();
		}
		return no_of_gls;
		
	}
	
	public String randomNumber(int count){
		final String ALPHA_NUMERIC_STRING = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";		
		StringBuilder builder = new StringBuilder();
		while (count-- != 0) {
		int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
		builder.append(ALPHA_NUMERIC_STRING.charAt(character));
		}
		return builder.toString();		
	}
}
