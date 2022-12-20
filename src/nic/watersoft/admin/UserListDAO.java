package nic.watersoft.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;

public class UserListDAO {
	Connection conn = null;
	ResultSet rset = null;
	String query = null;
	PreparedStatement ps = null;
	UserListForm form = null;

	@SuppressWarnings("unchecked")
	public ArrayList getUsers() throws Exception {
		ArrayList users = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " select  user_id,email_id ,MOBILE_NO from rws_password_tbl order by user_id";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery(query);
			while (rset.next()) {
				form = new UserListForm();
				form.setUserId(rset.getString(1));
				form.setMailId(rset.getString(2));
				form.setMobileNo(rset.getString(3));
				users.add(form);
			}
		} catch (SQLException e) {
			System.out.println("The Exception in UserListDAO in getUsers is  = "+e.getMessage());		
		}
		finally {
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return users;
	}

	@SuppressWarnings("unchecked")
	public ArrayList getUsersList(String userId, UserListForm bean) {
		ArrayList usersList = new ArrayList();
		String query = "";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		try {
			conn = RwsOffices.getConn();			
			query = "select user_id,mobile_no,email_id,office_code  from rws_password_tbl where user_id=?";			
			ps = conn.prepareStatement(query);
			ps.setString(1, userId);
			rset = ps.executeQuery();
			if (rset.next()) {
				bean.setMailId(rset.getString(3));
				bean.setMobileNo(rset.getString(2));
				String officeCode=rset.getString("office_code");
				if(officeCode.length() == 6){
					if(officeCode.equals("000000")){
						bean.setCircle("Guest");
					}
					else if(officeCode.equals("100000")){
						bean.setCircle("Head Office");
					}
					else{
						query = "select circle_office_name from rws_circle_office_tbl where circle_office_code= ? ";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						resultSet=statement.executeQuery();
						if(resultSet.next()){
							bean.setCircle(resultSet.getString(1));					
						}
						statement.close();
						resultSet.close();
						query = "select division_office_name  from rws_division_office_tbl where circle_office_code= ? and division_office_code= ? ";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						statement.setString(2, officeCode.substring(3,4));
						resultSet=statement.executeQuery();
						if(resultSet.next()){					
							bean.setDivision(resultSet.getString(1));
						}
						statement.close();
						resultSet.close();
						query="select subdivision_office_name from rws_subdivision_office_tbl where circle_office_code= ? and division_office_code= ? and subdivision_office_code= ? ";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						statement.setString(2, officeCode.substring(3,4));
						statement.setString(3, officeCode.substring(4,6));
						resultSet=statement.executeQuery();
						if(resultSet.next()){
							bean.setSubdivision(resultSet.getString(1));
						}
						statement.close();
						resultSet.close();
					}
				}
			}
		} catch (SQLException e) {
			System.out.println("The Exception in UserListDAO in getUsersList is  = "+e.getMessage());
		}

		finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in UserListDAO in getUsersList is  = "+e.getMessage());
			}
		}
		return usersList;
	}

	@SuppressWarnings("unchecked")
	public ArrayList viewUsersList() throws Exception {
		ArrayList usersList = new ArrayList();
		String query = "";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		try {
			conn = RwsOffices.getConn();
			query = "select user_id, mobile_no, email_id, office_code  from rws_password_tbl order by user_id";			
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				UsersListManager usersBean = new UsersListManager();
				usersBean.setUserId(rset.getString(1));
				usersBean.setMobileNo(rset.getString(2));
				usersBean.setMailId(rset.getString(3));				
				String officeCode=rset.getString("office_code");
				if(officeCode.length() == 6){
					if(officeCode.equals("000000")){
						usersBean.setCircle("Guest");
					}
					else if(officeCode.equals("100000")){
						usersBean.setCircle("Head Office");
					}
					else{
						query = "select circle_office_name from rws_circle_office_tbl where circle_office_code= ?";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						resultSet=statement.executeQuery();
						if(resultSet.next()){
							usersBean.setCircle(resultSet.getString(1));						
						}
						statement.close();
						resultSet.close();
						
						query = "select division_office_name  from rws_division_office_tbl where circle_office_code= ? and division_office_code= ? ";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						statement.setString(2, officeCode.substring(3,4));
						resultSet=statement.executeQuery();
						if(resultSet.next()){					
							usersBean.setDivision(resultSet.getString(1));
						}
						statement.close();
						resultSet.close();
						query="select subdivision_office_name from rws_subdivision_office_tbl where circle_office_code= ? and division_office_code= ? and subdivision_office_code= ? ";
						statement=conn.prepareStatement(query);
						statement.setString(1, officeCode.substring(1,3));
						statement.setString(2, officeCode.substring(3,4));
						statement.setString(3, officeCode.substring(4,6));
						resultSet=statement.executeQuery();
						if(resultSet.next()){
							usersBean.setSubdivision(resultSet.getString(1));
						}
						statement.close();
						resultSet.close();
					}
				}
				usersList.add(usersBean);
			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("The Exception in UserListDAO in viewUsersList is  = "+e.getMessage());
		}
		finally {
			if (ps != null) {
				ps.close();
			}
		}
		return usersList;
	}

	public int updateUsersDetails(HttpServletRequest request, UserListForm bean) throws Exception {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String query = "";
			if (!checkEmailAndMobileExixts(conn, bean.getMailId(), bean.getMobileNo())) {
				query = " update  rws_password_tbl set mobile_no=?,email_id=? where user_id=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, bean.getMobileNo());
				ps.setString(2, bean.getMailId());
				ps.setString(3, bean.getUserId());
				count = ps.executeUpdate();
				if (count > 0) {
					conn.commit();
				} else {
					conn.rollback();
				}
			}else{
				request.setAttribute("message", "Email Already Exists. Or Mobile Number Exists.");
			}
		} catch (Exception e) {
			System.out.println("The Exception in UserListDAO in updateUsersDetails is  = "+e.getMessage());
		}
		return count;
	}

	private boolean checkEmailAndMobileExixts(Connection conn, String mailId, String mobileNO) {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			String query = "select *from rws_password_tbl where email_id= ? and mobile_no= ?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, mailId);
			stmt.setString(2, mobileNO);
			rs = stmt.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println("The Exception in UserListDAO in checkEmailAndMobileExixts is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in UserListDAO in checkEmailAndMobileExixts is  = "+e.getMessage());
			}
		}
		return false;
	}

	public void loadLoginFormDetails(UserListForm bean,	HttpServletRequest request) throws SQLException {
		String query = "";
		try {
			try {
				conn = RwsOffices.getConn();
				String userId = (String) request.getSession().getAttribute("userId");
				query = " select  user_id,mobile_no,email_id from rws_password_tbl where user_id=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, userId);
				rset = ps.executeQuery();
				while (rset.next()) {
					bean.setUserId(rset.getString(1));
					bean.setMobileNo(rset.getString(2));
					bean.setMailId(rset.getString(3));
				}
			} catch (SQLException e) {
				System.out.println("The Exception in UserListDAO in loadLoginFormDetails is  = "+e.getMessage());
			}
			finally {
				if (ps != null) {
					ps.close();
				}
			}
		}
		finally {
			conn.close();
		}
	}

	public int updateLoginUsersDetails(String user, String cell, String mail) throws Exception {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String query = "";
			query = " update  rws_password_tbl set mobile_no=?,email_id=? where user_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, cell);
			ps.setString(2, mail);
			ps.setString(3, user);
			count = ps.executeUpdate();
			if (count > 0) {
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			System.out.println("The Exception in UserListDAO in updateLoginUsersDetails is  = "+e.getMessage());
		}
		return count;
	}

	public void getUserDetails(String userId, UserListForm bean) {
		String query = "";
		try {
			conn = RwsOffices.getConn();
			query = "select user_id,mobile_no,email_id  from rws_password_tbl where user_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, userId);
			rset = ps.executeQuery();
			if (rset.next()) {
				bean.setMailId(rset.getString(3));
				bean.setMobileNo(rset.getString(2));
			}
		} catch (SQLException e) {
			System.out.println("The Exception in UserListDAO in getUserDetails is  = "+e.getMessage());
		}
		finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in UserListDAO in getUserDetails is  = "+e.getMessage());
			}
		}
	}
}
