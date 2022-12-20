package nic.watersoft.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class UserManagementAction extends Action  {
	private String userId;
	private String password1;
	private String hint;
	private String designationCode; 
	private String officeCode;
	private char[] modules = new char[8];
	private char[] permissions = new char[3];
	private String proposals = "0";
	private	String estimates = "0";
	private String waterquality = "0";
	private String contractor = "0";
	private String works = "0";
	private String assets = "0";
	private String funds = "0";
	private String masters = "0";
	private String read = "0";
	private String write = "0";
	private String delete = "0";
	private String mode;
	private String mandal;
	int ans = 0;
	private String target;
	String headOfOffice = "", headOfOfficeCode = "";
	private String errorMessage = null; 
	String message = null;	
	private Connection conn;
	private PreparedStatement pstat;
	private Statement stat;
	private ResultSet rset;
	
	RwsOffices rwsOffices = null;		
	protected int insertRecord(DataSource dataSource) {		
		ans = 0;
		try	{
			conn = RwsOffices.getConn();
			String query = " INSERT INTO rws_password_tbl(user_id, password, " 
						 + " scope_of_access, permission, account_activation_date, " 
						 + " password_recovery_hint, designation_code, office_code,PWD_UPDATE_DATE) "
						 + " VALUES(?,?,?,?,sysdate,?,?,?,sysdate)";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,userId);
			pstat.setString(2,password1);   //System.out.println("password1 :"+password1);
			pstat.setString(3,String.valueOf(modules));
			pstat.setString(4,String.valueOf(permissions));
			pstat.setString(5,hint);
			pstat.setString(6,designationCode);
			pstat.setString(7,officeCode);			
			ans = pstat.executeUpdate();			
		}
		catch(SQLException sqle){	
			System.out.println("The exception in UserManagementAction insertRecord = "+sqle.getMessage());
			if(sqle.getErrorCode() == 1)
				errorMessage = userId + "- User Id already exists.";
			else
				errorMessage = userId + " - Cannot create user.";
		}
		catch(Exception e){	
			System.out.println("The exception in UserManagementAction insertRecord = "+e.getMessage());			
		}
		finally {
			if(pstat != null){	
				try	{	
					pstat.close();					
				}
				catch(SQLException sqle){ 
					System.out.println("The exception in UserManagementAction insertRecord = "+sqle.getMessage());					
				}
			}
			if(conn != null){	
				try {	
					conn.close();					
				}
				catch(SQLException sqle){ 
					System.out.println("The exception in UserManagementAction insertRecord = "+sqle.getMessage());					
				}
			}
		}
		return ans;
	}
	
	public int checkHeadOfOffice(DataSource dataSource){
		int headCount = 0;
		PreparedStatement ps = null;
		Connection conn=null;		
		try	{
			conn = rwsOffices.getConn();
			String query = "SELECT COUNT(*) FROM rws_password_tbl WHERE office_code = '"+ officeCode + "' AND designation_code = '" + designationCode+ "'";
				if(headOfOfficeCode.equals("7"))
				   query += " AND designation_code = 7";
				else
				if(headOfOfficeCode.equals("6"))
					   query += " AND designation_code = 6";
				else
				if(headOfOfficeCode.equals("5"))
					   query += " AND designation_code = 5";
				else
				if(headOfOfficeCode.equals("2"))
						   query += " AND designation_code = 1";
				if(!mandal.equals("00")){
					query += " AND user_id = '"+userId+"'";
				}
			
			ps = conn.prepareStatement(query);			
			rset = ps.executeQuery();
			if(rset.next())
				headCount = rset.getInt(1);
		}
		catch(Exception e){
			System.out.println("The exception in UserManagementAction checkHeadOfOffice = "+e.getMessage());		
		}
		finally	{
			if(rset != null){	
				try	{	
					rset.close();					
				}
				catch(SQLException sqle){ }
			}
			if(ps != null){	
				try	{	
					ps.close();					
				}
				catch(SQLException sqle){ }
			}
			if(conn != null){	
				try {	
					conn.close();					
				}
				catch(SQLException sqle){ }
			}
		}
		return headCount;
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
					
		UserForm userForm = (UserForm)form;
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
	    saveToken(request);
		mode = userForm.getMode();
		message = "";		
		rwsOffices = new RwsOffices(getDataSource(request));			
		String headOfficeCode = userForm.getHeadOfficeCode();//System.out.println("Action headOfficeCode :"+headOfficeCode);
		String circleOfficeCode = userForm.getCircleOfficeCode();//System.out.println("Action circleOfficeCode :"+circleOfficeCode);
		String divisionOfficeCode = userForm.getDivisionOfficeCode();//System.out.println("Action divisionOfficeCode :"+divisionOfficeCode);
		String subdivisionOfficeCode = userForm.getSubdivisionOfficeCode();//System.out.println("Action subdivisionOfficeCode :"+subdivisionOfficeCode);
		//System.out.println("Action mandal :"+userForm.getMandal());
		int heirarchyCode = 0;		
		if(!subdivisionOfficeCode.equals("00")){
			heirarchyCode = 9;
			headOfOffice = "DEE";
			headOfOfficeCode = "7";
		}
		else if(!divisionOfficeCode.equals("0")){
			heirarchyCode = 8;
			headOfOffice = "EE";
			headOfOfficeCode = "6";
		}
		else if(!circleOfficeCode.equals("00")){
			heirarchyCode = 7;
			headOfOffice = "SE";
			headOfOfficeCode = "5";
		}
		else if(!headOfficeCode.equals("0")){
			heirarchyCode = 5;
			headOfOffice = "CE(RWS)";
			headOfOfficeCode = "2";
		}
		String userIdd = user.getUserId();
		if(userIdd.equals("admin") || userIdd.equals("100000")){
			officeCode = headOfficeCode + circleOfficeCode + divisionOfficeCode + subdivisionOfficeCode; 
			//System.out.println("User Management officeCode: " +officeCode);
			designationCode = userForm.getDesignationCode();
			userId = userForm.getUserid();//System.out.println("new userId :"+userId);
			password1 = userForm.getPassword1();
			hint = userForm.getHint();
			proposals = userForm.getProposals();
			estimates = userForm.getEstimates();
			waterquality = userForm.getWaterquality();
			contractor = userForm.getContractor();
			works = userForm.getWorks();
			assets = userForm.getAssets();
			funds = userForm.getFunds();
			masters = userForm.getMasters();
			read = userForm.getRead();
			write = userForm.getWrite();
			delete = userForm.getDel();
			mandal=userForm.getMandal();			
			if(proposals != null && proposals.equalsIgnoreCase("on"))
				modules[0] = '1';
			else
				modules[0] = '0';
			if(estimates != null && estimates.equalsIgnoreCase("on"))
				modules[1] = '1';
			else
				modules[1] = '0';
			if(waterquality != null && waterquality.equalsIgnoreCase("on"))
				modules[2] = '1';
			else
				modules[2] = '0';
			if(contractor != null && contractor.equalsIgnoreCase("on"))
				modules[3] = '1';
			else
				modules[3] = '0';
			if(works != null && works.equalsIgnoreCase("on"))
				modules[4] = '1';
			else
				modules[4] = '0';
			if(assets != null && assets.equalsIgnoreCase("on"))
				modules[5] = '1';
			else
				modules[5] = '0';
			if(funds != null && funds.equalsIgnoreCase("on"))
				modules[6] = '1';
			else
				modules[6] = '0';
			if(masters != null && masters.equalsIgnoreCase("on"))
				modules[7] = '1';
			else
				modules[7] = '0';
			if(read != null && read.equalsIgnoreCase("on"))
				permissions[0] = '1';
			else
				permissions[0] = '0';
			if(write != null && write.equalsIgnoreCase("on"))
				permissions[1] = '1';
			else
				permissions[1] = '0';
			if(delete != null && delete.equalsIgnoreCase("on"))
				permissions[2] = '1';
			else
				permissions[2] = '0';							
			if(mode != null && mode.equals("Save"))	{
				 if (storedToken.equals(token)) {							
					String key=(String)session.getAttribute("key");
					String userr = request.getParameter("number");
					AdminDAO adminDAO = new AdminDAO(getDataSource(request));
					String generatedVal = adminDAO.getNewUserId(headOfficeCode,circleOfficeCode,divisionOfficeCode,subdivisionOfficeCode,mandal);
					System.out.println("user Id :"+userId+" generated val :"+generatedVal);
					if(userId.equals(generatedVal)){
					
					if(key.compareTo(userr)==0)	{					
						int headCount = checkHeadOfOffice(getDataSource(request));
						if(headCount > 0) {
							message = "Head of office account exists in " + rwsOffices.getOfficeName(officeCode, true);
							target = "failure";	
						}
						else {

							ans = insertRecord(getDataSource(request));						
							if(ans == 0){
								if(errorMessage != null)
									message = errorMessage;
								else
									message = "Cannot create user - "+ userId; 
								target = "failure";
							}
							else {
								message = "User created successfully with User Id - "+ userId;
								target = new String("success");
								session.removeAttribute("key");
							}
						}					
					}
					else{
						session.removeAttribute("key");
						message = "You have entered wrong verification code!! Please re-enter proper value.";
						target = "failure";
					}
					}else{
						message = "Cannot create user."; 
						target = "failure";
					}
					//AdminDAO adminDAO = new AdminDAO(getDataSource(request));
					session.setAttribute("key",adminDAO.getCaptchaCode());
					reset(userForm);
				 }
			}
			else if(mode != null && mode.equals("View")){
				AdminDAO adminDAO = new AdminDAO(getDataSource(request));
				officeCode = "";
				if(headOfficeCode != null && !headOfficeCode.equals(""))
					officeCode += headOfficeCode;
				if(circleOfficeCode != null && !circleOfficeCode.equals("00"))
					officeCode += circleOfficeCode;
				if(divisionOfficeCode != null && !divisionOfficeCode.equals("0"))
					officeCode += divisionOfficeCode;
				if(subdivisionOfficeCode != null && !subdivisionOfficeCode.equals("00"))
					officeCode += subdivisionOfficeCode;				
				ArrayList users = adminDAO.findAllUsers(officeCode);				
				request.setAttribute("users", users);
				target = "view-success";
			}			
			if(message != null && !message.equals(""))
			session.setAttribute("GlobalConstants.Message", message);	
			return(mapping.findForward(target));
		}
		else{
			return mapping.findForward("unauthorized-access");
		}
	}
	public void reset(UserForm frm)	{
		frm.setUserId("");
		frm.setPassword("");
		frm.setConfirmPassword("");
		frm.setNewPassword("");
		frm.setOldPassword("");
		frm.setHint("");
		frm.setProposals("");
		frm.setEstimates("");
		frm.setWaterquality("");
		frm.setContractor("");
		frm.setWorks("");
		frm.setAssets("");
		frm.setFunds("");
		frm.setStocks("");
		frm.setMasters("");
		frm.setRead("");
		frm.setWrite("");
		frm.setDel("");
	}
}
