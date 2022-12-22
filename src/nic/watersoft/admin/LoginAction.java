package nic.watersoft.admin;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.Md5Impl;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Rws_UserSerializaion;
import nic.watersoft.smsmobile.NicSmsGateway;
import nic.watersoft.works.WorksData1;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

//import com.sun.org.apache.xml.internal.security.utils.Base64;

public class LoginAction extends Action {

	public LoginAction() {
	}
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
				System.gc();
				HttpSession session = request.getSession();
				String sessionToken = (String)session.getAttribute("csrfToken");
			    String fieldtoken = request.getParameter("token");
				if (sessionToken == null || fieldtoken == null || !sessionToken.equals(fieldtoken)) {
				//return mapping.findForward("InvalidUser");
				}else {
				}
				String target = new String("success");
				LoginForm loginForm = (LoginForm) form;
				userId = loginForm.getUserId();		//System.out.println("LoginAction-userId :"+userId);	
				password = loginForm.getPassword();
				String slt = session.getAttribute("slt").toString();System.out.println("LoginAction-slt :"+slt);
				String otpLogin="";		
				String number=loginForm.getNumber();
				String	capstr = (String)session.getAttribute("forgotkey");
				
				LogoutDAO LogoutDAO = new LogoutDAO(getDataSource(request));
				//int loginFlag = LogoutDAO.getLoginDetails(userId);
				int loginFlag = LogoutDAO.checkImproperLoginDetails(userId);
				System.out.println("loginFlag :"+loginFlag);
				if(userId==null || userId.equals(""))
				{
					target = new String("failure");
					session.setAttribute("message", "Unable to login");
				}
				else if (loginFlag>1)
				{			
					System.out.println("userId :"+userId);
					target = new String("failure");
					session.setAttribute("message", "User Already Logged in");
					//System.out.println("Else If");
				}
				else{
					//System.out.println("Else");
					AdminDAO adminDAO = new AdminDAO(getDataSource(request));
					RwsUser user=new RwsUser();
		if(number.equals(capstr))
		{
          
		 user = adminDAO.authenticate(userId, password, slt);
		
		if (user.getErrorMessage() != null	&& user.getErrorMessage().equals("UserIdAndPwdSame")) {
			request.setAttribute(
					"message",
					"You are not Changed your initial password - Please Update Password to Continue");
			target = "pwdNoChange";
		}
//		if (user.getErrorMessage() != null
//				&& user.getErrorMessage().equals("UserIdAndPwdExpire")) {
//			request.setAttribute("message",
//					"Your Password is Expired - Please Update Password to Continue");
//			Debug.println("pwdNoChange");
//			target = "pwdNoChange";
//		}
		
		try {
			String requestUri = request.getRequestURI();
			String resourceName = requestUri.substring(
					requestUri.lastIndexOf("/") + 1, requestUri.length());
			if (session.getAttribute("RWS_USER") == null
					&& !resourceName.equalsIgnoreCase("Login.do"))
				request.getRequestDispatcher("./sessionExpired.jsp").forward(
						request, response);
				if (user.isAuthenticated()) {
				synchronized (session) {
					session.setAttribute("RWS_USER", user);
					session.setAttribute("userId", userId);
				}
				WorksData1 worksData = new WorksData1();
				session.setAttribute("serversysdate", worksData.getServerDate());
				//if(userId.equals("ENC") || userId.equals("EE-Budget") || userId.equals("admin")){
				//System.out.println("inside authentication");
				if(userId.equals("admin")){
					
					OTPGeneration otpGeneration=new  OTPGeneration();
				//System.out.println("loginForm.getOtp()-------------------"+loginForm.getOtp());
				if(loginForm.getOtp()==null){
					//System.out.println("inside if &&& @@@@@@@"+loginForm.getOtp());
				session.setAttribute("password", password);
				session.setAttribute("slt", slt);
				session.setAttribute("number",number );
				
				int otp=otpGeneration.generatePin();		
			
				String mobile=otpGeneration.getMobile(userId);
				//System.out.println("mobile number is@@@@@@@@@@@@@@@@@"+mobile);
				if(mobile.equals("0")){
				request.setAttribute("message", "Please Approch the Head Office to update the Mobile Number for OTP");
				}
				//String message="OTP is "+otp;
				//String message = otp+"RWSS-WaterSoft";
				String message="OTP from Watersoft is "+otp;
				//System.out.println(message);
				NicSmsGateway smsGateway=new  NicSmsGateway();
				/////////smsGateway.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobile, message);
				//String entity_id="456",template_id="123";
				//String mmobile="91"+mobile;
				smsGateway.SMSSend( mobile, message);
				otpGeneration.sveOtp(userId, mobile, otp);
				session.setAttribute("otp",otp );
				}
				else{
					String otp=otpGeneration.getOtp(userId);
					//System.out.println("session.getAttribute().toString()----"+session.getAttribute("otp").toString());
					if(otp.equals(loginForm.getOtp())){
						otpLogin="OTPLogin";
					}
				}
			}
		}
			if (user.isAuthenticated()
					&& (request.getParameter("loginMode") == null || request
							.getParameter("loginMode").equals("watersoft"))
					&& !user.getUserId().substring(0, 3).equals("col")) {
				
				//Related to RC,DF,DR for SMS
				int no_of_rcs=adminDAO.getPendingRCS(userId);
				if (no_of_rcs != 0)
					request.setAttribute("NO_OF_RCS",
							String.valueOf(no_of_rcs));
				int no_of_dfs=adminDAO.getPendingDFS(userId);
				if (no_of_dfs != 0)
					request.setAttribute("NO_OF_DFS",
							String.valueOf(no_of_dfs));
				int no_of_drs=adminDAO.getPendingDRS(userId);
				if (no_of_drs != 0)
					request.setAttribute("NO_OF_DRS",
							String.valueOf(no_of_drs));
				int no_of_ohs=adminDAO.getPendingOHS(userId);
				if (no_of_ohs != 0)
					request.setAttribute("NO_OF_OHS",
							String.valueOf(no_of_ohs));
				int no_of_gls=adminDAO.getPendingGLS(userId);
				if (no_of_gls != 0)
					request.setAttribute("NO_OF_GLS",
							String.valueOf(no_of_gls));
				//end******
				
				int no_of_proposals_c = adminDAO.getPendingProposals(userId,
						"C");
				if (no_of_proposals_c != 0)
					request.setAttribute("NO_OF_PROPOSALS_C",
							String.valueOf(no_of_proposals_c));
				int no_of_proposals_a = adminDAO.getPendingProposals(userId,
						"A");
				if (no_of_proposals_a != 0)
					request.setAttribute("NO_OF_PROPOSALS_A",
							String.valueOf(no_of_proposals_a));
				int no_of_proposals_om_c = adminDAO.getOMPendingProposals(
						userId, "C");
				if (no_of_proposals_om_c != 0)
					request.setAttribute("NO_OF_PROPOSALS_OM_C",
							String.valueOf(no_of_proposals_om_c));
				int no_of_proposals_om_a = adminDAO.getOMPendingProposals(
						userId, "A");
				if (no_of_proposals_om_a != 0)
					request.setAttribute("NO_OF_PROPOSALS_OM_A",
							String.valueOf(no_of_proposals_om_a));
				int no_of_estimates = adminDAO.getPendingEstimates(userId);
				if (no_of_estimates != 0)
					request.setAttribute("NO_OF_ESTIMATES",
							String.valueOf(no_of_estimates));
				int no_of_estimates_om = adminDAO.getOMPendingEstimates(userId);
				if (no_of_estimates_om != 0)
					request.setAttribute("NO_OF_ESTIMATES_OM",
							String.valueOf(no_of_estimates_om));
				if (userId.length() == 6 && userId.substring(4, 6).equals("EE")) {
					int no_of_vouchers = adminDAO.getPendingVouchers(userId);
					if (no_of_vouchers != 0)
						request.setAttribute("no_of_vouchers",
								String.valueOf(no_of_vouchers));
					int no_of_bills = adminDAO.getPendingBills(userId);
					if (no_of_bills != 0)
						request.setAttribute("no_of_bills",
								String.valueOf(no_of_bills));
				}
				if (userId.length() == 6 && userId.substring(4, 6).equals("EE")) {
					int no_of_vouchers = adminDAO.getPendingVouchers(userId);
					if (no_of_vouchers != 0)
						request.setAttribute("no_of_vouchers",
								String.valueOf(no_of_vouchers));
					int no_of_bills = adminDAO.getPendingBills(userId);
					if (no_of_bills != 0)
						request.setAttribute("no_of_bills",
								String.valueOf(no_of_bills));
					String bank_process = adminDAO.getBankStatus(userId);
					if (!bank_process.equals(""))
						request.setAttribute("bank_process", bank_process);
				}
				if (userId != null && userId.equals("admin")) {
					String bank_process = adminDAO.getBankStatus(userId);
					if (!bank_process.equals(""))
						request.setAttribute("bank_process", bank_process);
				}
				String sec_alerts = adminDAO.getSecMessages(userId);
				if (sec_alerts != null)
					request.setAttribute("sec_alerts",
							String.valueOf(sec_alerts));
				session.setAttribute("RWS_USER", user);
				session.setAttribute("userId", userId);
			}
			
			if (!user.isAuthenticated()) {
				target = new String("failure");
				if (user.getErrorMessage() != null)
					session.setAttribute("message", user.getErrorMessage());
				else
					session.setAttribute("message",
							"Invalid UserId and Password Combination");
			}
			if (session.getAttribute("loggedSuccessfully") != null
					&& session.getAttribute("loggedSuccessfully").equals(
							"false")) {
				target = new String("failure");
				session.setAttribute("message", "Unable to login");
			}
			user = Rws_UserSerializaion.doSerailization(user);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		if (userId != null && userId.equals("ce_nab"))
			user.setUserType("NABARD");
		else if (userId != null && userId.equals("ce_stp"))
			user.setUserType("STATE PLAN");
		else if (userId != null && userId.equals("ce_vqc"))
			user.setUserType("Vigilance and Quality Control");
		else if (userId != null && userId.equals("cerwss"))
			user.setUserType("NORMAL");
		//else if (userId != null && userId.substring(3,6).equals("vqc"))
		else if (userId != null && (userId.startsWith("1")==true && userId.endsWith("vqc")==true))
		{
			user.setUserType("Vigilance and Quality Control");
		}
		else if (userId != null && userId.equals("pdswsm"))
			user.setUserType("State Water and Sanitation Mission");
		else if (userId != null && userId.equals("pdccdu"))
			user.setUserType("Communication & Capacity Development Unit");
		else
			user.setUserType("");
		if (target.equals("success"))
			if (userId != null	&& (userId.equals("admin") || userId.equals("100000")))
				if(otpLogin.equals("OTPLogin") && userId.equals("admin")){
					target = "otploginadmin";
				}
				else if(userId.equals("100000")){
				target = "otploginadmin";
				}
				else{
					target = "admin";
				}
			else if (userId != null && userId.equals("pdswsm"))
				target = "pdswsm";
			else if (userId != null && userId.equals("pdccdu"))
				target = "pdccdu";
			else if (userId != null && userId.equals("ce_stp"))
				target = "ce_stp";
			else if (userId != null && userId.equals("ce_nab"))
				target = "ce_nab";
			else if (userId != null && userId.equals("ce_nab"))
				target = "ce_nab";
			else if (userId != null && userId.equals("ce_vqc"))
				target = "ce_vqc";
			else if (userId != null && userId.equals("aprwssp"))
				target = "aprwssp";
			else if (userId != null && userId.equals("minrwss"))
				target = "minrwss";
			else if (userId != null && userId.equals("cerwss"))
				target = "cerwss";
			//else if (userId != null && userId.substring(3,6).equals("vqc"))
			else if (userId != null && (userId.startsWith("1")==true && userId.endsWith("vqc")==true))
			{
				target = "vqc";
			}
			else if (userId != null && userId.equals("secrwss"))
				target = "pwrwss";
			else if (userId != null && userId.equals("guest"))
				target = "guest";
			else if (userId != null && userId.equals("ENC")){
				/*if(otpLogin.equals("OTPLogin")){
					target = "otploginenc";
				}
				else{*/
					target = "enc";
				//}
			}
			else if (userId != null && userId.equals("EE-Budget")){
				/*if(otpLogin.equals("OTPLogin")){
					target = "otplogineebudget";
				}
				else{*/
					target = "eebudget";
				//}
			}
			else if (userId != null && userId.substring(0, 3).equals("col"))
				target = "collector";
			else if (userId != null && userId.substring(4, 6).equals("EE"))
				target = "ee";
			else if (userId != null && userId.substring(4, 6).equals("AO"))
				target = "ao";
			else if (userId != null && userId.substring(4, 6).equals("DR"))
				target = "drought";
			else if(userId != null && userId.substring(4 , 6).equals("WQ"))
				target="wquality";
			else if(userId != null && userId.substring(0, 1).equals("2"))
				target="urbanpage";
			else
				target = "user";
		}
		else
		{
			target = new String("failure");
			if (user.getErrorMessage() != null)
				session.setAttribute("message", user.getErrorMessage());
			else
				session.setAttribute("message",
						"Captcha mismatched");
		}
				}
				
		regenerateSession(request);
		

		return mapping.findForward(target);
	}
		

	private void regenerateSession(HttpServletRequest request) {

		HttpSession oldSession = request.getSession(); //System.out.println("oldSession :"+oldSession.getId());
		Enumeration attrNames = oldSession.getAttributeNames();
		Properties props = new Properties();
		while (attrNames != null && attrNames.hasMoreElements()) {
			String key = (String) attrNames.nextElement();
			props.put(key, oldSession.getAttribute(key));
		}
		oldSession.invalidate();
		HttpSession newSession = request.getSession(true);//System.out.println("newSession :"+newSession);
		attrNames = props.keys();
		while (attrNames != null && attrNames.hasMoreElements()) {
			String key = (String) attrNames.nextElement();
			newSession.setAttribute(key, props.get(key));//System.out.println("newSession key:"+key);
			//System.out.println("newSession props.get(key):"+props.get(key));
		}
	}
	private String userId;
	private String password;
}
