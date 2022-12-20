package nic.watersoft.admin;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.Md5Impl;
//import nic.watersoft.commons.AgencyUser;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Rws_UserSerializaion;
import nic.watersoft.smsmobile.NicSmsGateway;
import nic.watersoft.works.WorksData1;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class LoginGrievanceAction extends Action{

		public LoginGrievanceAction() {
		}

		public ActionForward execute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			System.out.println("haiiiii");
			System.gc();
			HttpSession session = request.getSession();
			String target = new String("success");
			GrievanceLoginForm loginForm = (GrievanceLoginForm) form;
			userId = loginForm.getUserId();		
			password = loginForm.getPassword();
			String slt = request.getParameter("slt");
			String otpLogin="";		
					String number=loginForm.getNumber();
					String	capstr = (String)session.getAttribute("forgotkey");

			AdminDAO adminDAO = new AdminDAO(getDataSource(request));
			//AgencyUser user=new AgencyUser();
			RwsUser user=new RwsUser();
			if(number.equals(capstr))
			{
			System.out.println("in authentication");
			 user = adminDAO.authenticateGrievance(userId, password, slt);
			if (user.getErrorMessage() != null
					&& user.getErrorMessage().equals("UserIdAndPwdSame")) {
				request.setAttribute(
						"message",
						"You are not Changed your initial password - Please Update Password to Continue");
				Debug.println("pwdNoChange");
				target = "pwdNoChange";
			}
//			if (user.getErrorMessage() != null
//					&& user.getErrorMessage().equals("UserIdAndPwdExpire")) {
//				request.setAttribute("message",
//						"Your Password is Expired - Please Update Password to Continue");
//				Debug.println("pwdNoChange");
//				target = "pwdNoChange";
//			}
			
			try {
				String requestUri = request.getRequestURI();
				String resourceName = requestUri.substring(
						requestUri.lastIndexOf("/") + 1, requestUri.length());
				if (session.getAttribute("RWS_USER") == null
						&& !resourceName.equalsIgnoreCase("LoginGrievance.do"))
					request.getRequestDispatcher("./sessionExpired.jsp").forward(
							request, response);
				if (user.isAuthenticated()) {
					
					System.out.println("USER"+user);
					System.out.println("userId"+userId);
					synchronized (session) {
						session.setAttribute("RWS_USER", user);
						session.setAttribute("userId", userId);
						session.setAttribute("AGENCY",true);
					}
					WorksData1 worksData = new WorksData1();
					session.setAttribute("serversysdate", worksData.getServerDate());
					//if(userId.equals("ENC") || userId.equals("EE-Budget") || userId.substring(4, 6).equals("EE")){
				
				}
				/*if (user.isAuthenticated()
						&& (request.getParameter("loginMode") == null || request
								.getParameter("loginMode").equals("watersoft"))
						&& !user.getUserId().substring(0, 3).equals("col")) {
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
				}*/
				//System.out.println("autenticated"+user.isAuthenticated());
				if (!user.isAuthenticated()) {
					target = new String("failure");
					if (user.getErrorMessage() != null)
						session.setAttribute("message", user.getErrorMessage());
					else
						session.setAttribute("message","Invalid UserId and Password Combination");
				}
				if (session.getAttribute("loggedSuccessfully") != null
						&& session.getAttribute("loggedSuccessfully").equals(
								"false")) {
					target = new String("failure");
					session.setAttribute("message", "Unable to login");
				}
				//user = Rws_UserSerializaion.doSerailization(user);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			if (userId != null && userId.equals("test01"))
				user.setUserType("Agency for greivance");
			
			if (target.equals("success"))
						target = "grievance";
			}
			else
			{
				target = new String("failure");
				if (user.getErrorMessage() != null)
					session.setAttribute("message", user.getErrorMessage());
				else
					session.setAttribute("message",
							"Captcha mismatched");
				
				Debug.println("in else condition");
				
			}
			
			System.out.println("target"+target);
			return mapping.findForward(target);
		}
		private String userId;
		private String password;
		
	}



