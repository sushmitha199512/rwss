package nic.watersoft.complaints;

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

import nic.watersoft.admin.AdminDAO;
import nic.watersoft.complaints.UserForm;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class UserAgencyAction extends Action {

	ArrayList agencys =  new ArrayList();	
	ArrayList dists =  new ArrayList();
	private String agencycode;
	private String districtCode;
	private String scope;
	private String userId;	
	private String password;
	private String area;	
	private String hint;
	//private String mode;
	private String name;
	private String aadhaar;
	private String email;
	private String mobile;
	private String remarks; 
	private String module;
	int ans = 0;
	private String target;	
	private String errorMessage = null; 
	String message = null;
	
	private Connection conn;
	private PreparedStatement pstat;
	private Statement stat;
	private ResultSet rset;
	
	RwsOffices rwsOffices = null;
		
	
	protected int insertRecord(DataSource dataSource) 
	{
	
		ans = 0;
		try
		{
			/*if(userId==null || password==null || name==null || aadhaar==null || email==null || mobile==null || districtCode==null || agencycode==null){
				errorMessage = "please enter all fields";
			}*/
			
			conn = RwsOffices.getConn();
			String query = " INSERT INTO rws_agency_pwd_tbl(USER_ID, PASSWORD,REMARKS, " 
						 + " MODULE, AGENCY_CODE,AREA,DCODE,EMAIL_ID,MOBILE_NO,account_activation_date, " 
						 + " password_recovery_hint, PERSON_NAME, AADHAAR,PWD_UPDATE_DATE,PERMISSION) "
						 + " VALUES(?,?,?,?,?,?,?,?,?,sysdate,?,?,?,sysdate,'000') ";
			pstat = conn.prepareStatement(query);
			Debug.println(userId);
			//Debug.println(password1);
			
			Debug.println(districtCode);
			
			pstat.setString(1,userId);
			pstat.setString(2,password);
			pstat.setString(3,remarks);
			pstat.setString(4,module);
			pstat.setString(5,agencycode);
			pstat.setString(6,area);
			pstat.setString(7,districtCode);
			pstat.setString(8,email);
			pstat.setString(9,mobile);
			pstat.setString(10,hint);
			pstat.setString(11,name);
			pstat.setString(12,aadhaar);
			ans = pstat.executeUpdate();
			
		}
		catch(SQLException sqle)		{	
			//sqle.printStackTrace();
			//Debug.writeln("SQLException in insertRecord(): \n" + sqle);
			if(sqle.getErrorCode() == 1)
				errorMessage = "User Id already exists.";
			else
				errorMessage = "Cannot create user.";
		}
		catch(Exception e)
		{	
			e.printStackTrace();
			//Debug.writeln("Exception in insertRecord(): \n" + e);
		}
		finally
		{
			if(pstat != null)
			{	try
				{	pstat.close();					
				}
				catch(SQLException sqle){ }
			}
			if(conn != null)
			{	try
				{	conn.close();					
				}
				catch(SQLException sqle){ }
			}
		}
		return ans;
	}
	
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception
	{
		
		String message=null;
		String displaymess=null;
		ArrayList Agencys=null;
		HttpSession session=request.getSession();
		UserForm userForm = (UserForm)form;
		String mode=request.getParameter("mode");
		saveToken(request);
		//String target =userForm.getTarget() ;
		
		
			GenericActionDAO gnDao=new GenericActionDAO(getDataSource(request));		
			//String mode =request.getParameter("mode");		
			System.out.println("Mode is:" + mode);			
			
			if(mode.equalsIgnoreCase("data"))
			{
				try
				{
					agencys = gnDao.getAgencies();
					session.setAttribute("agencys",agencys);
					
					dists = gnDao.getDistricts();
					session.setAttribute("dists",dists);					
					//userForm.setScope("000");
				}
				catch(Exception e)
				{
					System.err.println("The error in rws_AgencyEntryAct_frm in inc is "+e);
				}
				
			}
			
						
		System.out.println("Mode in UserManagementAction " + mode);
		/*
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String userIdd = user.getUserId();
		Debug.println("user:"+userIdd);*/
				
			
							
			if(mode != null && mode.equals("save"))
			{	
						userId = userForm.getUserid();
						Debug.println("User Id:"+userId);
						password = userForm.getPassword1();			
						
						agencycode = userForm.getAgencycode();
						districtCode = userForm.getDistrictCode();
						area = userForm.getArea();
						module=userForm.getModule();
						//scope = userForm.getScope();
						
						name = userForm.getName();
						aadhaar = userForm.getAadhaar();
						email = userForm.getEmail();
						hint = userForm.getHint();
						mobile = userForm.getMobile();
						remarks = userForm.getRemarks();
						
					/*	if((userId=="" ||userId==null) || password==null || name==null || aadhaar==null || email==null || mobile==null || districtCode==null || agencycode==null){
						errorMessage = "please enter all fields";
						mode = "failure";
					}
					*/
							ans = insertRecord(getDataSource(request));
							
							if(ans == 0)
							{
								if(errorMessage != null)
									message = errorMessage;
								else
									message = "Cannot create user."; 
								request.setAttribute("message", message);
							}
							else
							{
								message = "User created successfully.";
								request.setAttribute("message", message);							
							}
							reset(userForm);
							return mapping.findForward("closeWithMessage");	
			}
			
			if(mode != null && mode.equals("view"))
			{
				/*AdminDAO adminDAO = new AdminDAO(getDataSource(request));		
				
				ArrayList users = adminDAO.findAllUsers(officeCode);				
				request.setAttribute("users", users);
				target = "view-success";*/
			}
						
			return(mapping.findForward(mode));
		
	}
	public void reset(UserForm frm)
	{
		frm.setUserId("");
		frm.setPassword("");
		frm.setConfirmPassword("");
		//frm.setPassword("");
		frm.setPassword1("");
		frm.setHint("");
		frm.setAadhaar("");
		frm.setMobile("");
		frm.setRemarks("");
		frm.setName("");
		frm.setHint("");
		frm.setAgencycode("");
		frm.setEmail("");
		
		
		/*frm.setRead("");
		frm.setWrite("");
		frm.setDel("");*/
	}


}
