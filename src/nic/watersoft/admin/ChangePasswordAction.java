package nic.watersoft.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.Md5Impl;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Rws_UserSerializaion;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ChangePasswordAction extends Action {
	private Connection conn;

	private Statement pstat;

	Statement st = null;

	private String userid = null;

	private String oldPassword = null;

	private String newPassword = null;

	private String target = null;

	int ans = 0;

	String message;

	protected int updateRecord(DataSource dataSource) throws SQLException {
		try {
			conn = RwsOffices.getConn();
			Debug.println(newPassword);

			String rsQuery = " select password from rws_password_tbl WHERE user_id = ?";
			
			//System.out.println("*****************"+rsQuery);
			PreparedStatement pst= conn.prepareStatement(rsQuery);
			pst.setString(1, userid);
			ResultSet rs = pst.executeQuery(rsQuery);
			while(rs.next())
			{
				oldPassword = rs.getString(1);
			}
			
			
			if (newPassword.equals(oldPassword)) {
				ans = -1;
			} else {
				String query = " UPDATE rws_password_tbl SET password = ?,"
						
						+ "pwd_update_date = sysdate,status='A'  WHERE user_id = ?";
						
				//System.out.println("Updating query:"+query);
				pstat = conn.createStatement();
				pst=conn.prepareStatement(query);
				pst.setString(1, newPassword);
				pst.setString(2, userid);
				ans = pst.executeUpdate();
			}
		} catch (Exception e) {
			Debug.writeln("In change password: " + e.getMessage());
			ans = -1;
		} finally {
			if (pstat != null) {
				try {
					pstat.close();
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
		return ans;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException {
		//System.out.println("chpwd action classssssssssss:"
		//		+ request.getParameter("mode"));
		HttpSession session = request.getSession();
		RwsUser user = Rws_UserSerializaion.doDeserialization();
		UserForm  userForm = (UserForm) form;

		message = "";
		if (request.getParameter("mode") != null
				&& request.getParameter("mode").equals("init")) {
			//System.out.println("user.getUserId():"+user.getUserId());
			userForm.setUserId(user.getUserId());
			return (mapping.findForward(request.getParameter("mode")));
		} 
		else if (request.getParameter("mode") != null
				&& request.getParameter("mode").equals("general")) {
			String userId=request.getParameter("userId");
			userForm.setUserId(userId);
			return (mapping.findForward("init"));
		}
		else {
			if (form != null) {
				//System.out.println("in else");
				
				
				
				String actualUserId = user.getUserId();
				userid = userForm.getUserId();
				//System.out.println("actualUserId:" + actualUserId);
				//System.out.println("userid:" + userid);
				//oldPassword = userForm.getOldPassword();
				newPassword = userForm.getNewPassword();//Md5Impl.getMd5Code(userForm.getNewPassword());
				
				
				boolean isAllowed = false;
				if (actualUserId.equals("admin")||actualUserId.equals(userid))
					isAllowed = true;

				if (isAllowed) {
					//if (newPassword.equals(confirmPassword)) {
						ans = updateRecord(getDataSource(request));
						if (ans == 0) {
							message = "Cannot change password.";
							target = new String("failure");
						} else if (ans > 0) {
							message = "Password changed successfully.";
							target = new String("success");
						} else if (ans < 0) {
							message = "Old Password & New Password Cannot be Same";
							target = new String("failure");
						}

					/*} else {
						message = "New Password and Confirm Password does not match.";
						target = "failure";
					}*/
				} else {
					message = "You cannot change password for this User Id.";
					target = "failure";
				}
			}
		}
		if (message != null && !message.equals(""))
			request.setAttribute("message", message);

		return (mapping.findForward(target));
	}
}