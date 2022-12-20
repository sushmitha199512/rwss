package nic.watersoft.reports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;



import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.complaints.CompForm;
import nic.watersoft.complaints.ComplaintMasterData;
import nic.watersoft.masters.HabitationNewEntry_Form;
import nic.watersoft.masters.RwsHPRecord;

public class GenericActionDAO {

	private String query = null;
	private PreparedStatement ps;
	private  PreparedStatement ps1;
	private  PreparedStatement ps2;
	private Connection conn;
	private Statement stmt;
	
	public static String errorMessage;

	public ArrayList getgenericDetails(String circle) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query="select distinct dname,mname,pname,vname,HABITATION_CODE,panch_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,p.rep_name,a.name,a.address,nvl(a.phone_no,'-'),ACTION_TAKEN,ACTION_DESC,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),NATURE_PROBLEM   from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p,rws_complete_hab_view b where p.rep_code=a.rep_code  and a.complaint_status is null  and habitation_code=panch_code and substr(HABITATION_CODE,1,2)='"+circle+"'  order by a.complaint_no ";
			 System.out.println("HAB query  anuuu- ->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				GenericActionBean habMandal = new GenericActionBean();
				habMandal.setDcode(rset.getString(1));
				habMandal.setMcode(rset.getString(2));
				habMandal.setPcode(rset.getString(3));
				habMandal.setVcode(rset.getString(4));
				habMandal.setPanchCode(rset.getString(5));
				habMandal.setPanchName(rset.getString(6));
				habMandal.setComplaintNumber(rset.getString(7));
				habMandal.setComplaintDate(rset.getString(8));
				habMandal.setPrblmDesc(rset.getString(9));
				habMandal.setComplaintGivenBy(rset.getString(10));
				habMandal.setName(rset.getString(11));
				habMandal.setAddress(rset.getString(12));
				habMandal.setPhoneNumber(rset.getString(13));
				habMandal.setActionTaken(rset.getString(14));
				habMandal.setActionDesc(rset.getString(15));
				habMandal.setAttendBy(rset.getString(16));
				habMandal.setAttendedDate(rset.getString(17));
				habMandal.setMesSentToGrevance(rset.getString(18));
				habMandal.setDateOfSent(rset.getString(19));
				habMandal.setCategory(rset.getString(20)); 
				habs.add(habMandal);
				System.out.println("habs"+habs.size());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	
	  public static int insertActiontaken(String complaintno,String pnum,String actiontaken,String sctiondesc,String attendedby,String attendedate,String messentgrevence,String dateofsent,String category, DataSource dataSource)
      throws Exception
  {
      int rowCount;
      GenericActionDAO genericActionDAO = new GenericActionDAO();
      rowCount = 0;
      
      try
      {
    	  
    	  genericActionDAO.conn = RwsOffices.getConn();
    	  genericActionDAO.stmt = genericActionDAO.conn.createStatement();
          Debug.println("Before Insert anupama");
          
          String query ="update RWS_generic_COMPLAINTS_REG_TBL set ATTENDED_DATE=to_date('"+attendedate+"','dd/mm/yyyy') ,ATTENDED_BY='"+attendedby+"',ACTION_TAKEN='"+actiontaken+"',MESSAGE_SENT='"+messentgrevence+"',MESSAGE_SENT_DATE=to_date('"+dateofsent+"','dd/mm/yyyy'),ACTION_DESC='"+sctiondesc+"',NATURE_PROBLEM='"+category+"' where COMPLAINT_NO ='"+complaintno+"'  " ;
          Debug.println("After UPDATE generic************" + query);
          rowCount = genericActionDAO.stmt.executeUpdate(query);
          Debug.println("After Insert ANUPAMA" + query);
      }
      catch(SQLException sqle)
      {
          int errorCode = sqle.getErrorCode();
          if(errorCode == 1)
              errorMessage = "Record with this name exists.";
      }
      catch(Exception e)
      {
          Debug.println("The error in insertComplaints" + e);
      }
      finally
      {
    	 
          Debug.println("ConnCount after closing is ");
      }
      return rowCount;
  }
	
	
	
	
	private java.sql.Date getJavaSqlDate(String repairdate) {
		// TODO Auto-generated method stub
		return null;
	}

	private java.sql.Date getCurrentJavaSqlDate() {
		// TODO Auto-generated method stub
		return null;
	}

	

	
	
	
	
}
