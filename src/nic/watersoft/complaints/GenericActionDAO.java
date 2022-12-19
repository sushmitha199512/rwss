package nic.watersoft.complaints;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;



import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class GenericActionDAO {
	private DataSource dataSource;
	private String query = null;
	private PreparedStatement ps;
	private  PreparedStatement ps1;
	private  PreparedStatement ps2;
	private Connection conn;
	private Statement stmt;
	private LabelValueBean labelValueBean = null;
	public static String errorMessage;
	private ResultSet rset = null;
	
	public GenericActionDAO() {
		try {
			conn = RwsOffices.getConn();
		} catch (Exception e) {
			Debug.writeln("Exception GenericActionDAO() : \n" + e);
		}
	}
	public GenericActionDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname " + " FROM rws_district_tbl " + "  "
					+ " ORDER BY dcode,dname";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.write("Exception in GenericActionDAO mode getDistricts"+e);
		} finally {

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (rset != null) {
				try {
					rset.close();
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

		return dists;
	}
	public ArrayList getAgencies() throws Exception {
		ArrayList agencys = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT AGENCY_CODE,AGENCY_NAME FROM RWS_AGENCY_TBL ORDER BY AGENCY_CODE,AGENCY_NAME";
			
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				agencys.add(labelValueBean);
			}
		} catch (Exception e) {
			 System.out.println("Exception in getCircles is "+e);
		} finally {
			
		}

		return agencys;
	}
	public ArrayList getDistricts1(String circle) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname " + " FROM rws_district_tbl  where dcode='"+circle+"' " + "  "
					+ " ORDER BY dcode,dname";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.write("Exception in GenericActionDAO mode getDistricts"+e);
		} finally {

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (rset != null) {
				try {
					rset.close();
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

		return dists;
	}
	
	
	

	public ArrayList getgenericDetails(String circle,String dcode,String date,String loggedUser) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			if(loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR"))
			{
				
				query="select distinct dname,mname,pname,vname,HABITATION_CODE,panch_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,p.rep_name,a.name,a.address,nvl(a.phone_no,'-'),ACTION_TAKEN,ACTION_DESC,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),NATURE_PROBLEM,REMARKS   from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p,rws_district_tbl b,rws_mandal_tbl c,rws_panchayat_tbl d,rws_village_tbl e,rws_panchayat_raj_tbl f  where p.rep_code=a.rep_code and substr(HABITATION_CODE,1,2)=b.dcode and  b.dcode=c.dcode and substr(HABITATION_CODE,6,2)=c.mcode and b.dcode=d.dcode and c.mcode=d.mcode and substr(HABITATION_CODE,13,2)=d.pcode and b.dcode=e.dcode and c.mcode=e.mcode and d.pcode=e.pcode and substr(HABITATION_CODE,8,3)=e.vcode and a.HABITATION_CODE=f.panch_code and substr(HABITATION_CODE,1,2)=? and URBAN_WATER ='R' and ATTENDED_DATE is null ";
				if(date!=null && date!="")
				{
					query+=" and a.complaint_date=to_date(?,'dd/mm/yyyy') order by a.complaint_no  ";
				}
			}
			else
			{
			dcode=circle;
				query="select distinct dname,mname,pname,vname,HABITATION_CODE,panch_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,p.rep_name,a.name,a.address,nvl(a.phone_no,'-'),ACTION_TAKEN,ACTION_DESC,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),NATURE_PROBLEM,REMARKS   from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p,rws_district_tbl b,rws_mandal_tbl c,rws_panchayat_tbl d,rws_village_tbl e,rws_panchayat_raj_tbl f  where p.rep_code=a.rep_code and substr(HABITATION_CODE,1,2)=b.dcode and  b.dcode=c.dcode and substr(HABITATION_CODE,6,2)=c.mcode and b.dcode=d.dcode and c.mcode=d.mcode and substr(HABITATION_CODE,13,2)=d.pcode and b.dcode=e.dcode and c.mcode=e.mcode and d.pcode=e.pcode and substr(HABITATION_CODE,8,3)=e.vcode and a.HABITATION_CODE=f.panch_code and substr(HABITATION_CODE,1,2)=? and URBAN_WATER ='R' and ATTENDED_DATE is null";
			if(date!=null && date!="")
			{
				query+=" and a.complaint_date=to_date(?,'dd/mm/yyyy') order by a.complaint_no  ";
			}
			 
			}
			
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			if(date!=null && date!="")
			{
				ps.setString(2, date);	
			}
			rset = ps.executeQuery();

			while (rset.next()) {
				
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
				habMandal.setRemarks(rset.getString(21));
				habs.add(habMandal);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (rset != null) {
				try {
					rset.close();
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
		return habs;
	}
	
public static int insertActiontaken(GenericActionForm form,DataSource dataSource,HttpServletRequest request)
      throws Exception
  {
			
		  int recCount = 0;
      
      Connection conn = null;
  	PreparedStatement ps = null;
      
      try
      {
    	  
    	  conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
    	  
           
          String query ="update RWS_generic_COMPLAINTS_REG_TBL set ATTENDED_DATE=to_date(?,'dd/mm/yyyy') ,ATTENDED_BY=?,ACTION_TAKEN=?,MESSAGE_SENT=?,MESSAGE_SENT_DATE=to_date(?,'dd/mm/yyyy'),ACTION_DESC=?,NATURE_PROBLEM=?,REMARKS=? where COMPLAINT_NO =? AND URBAN_WATER ='R'" ;
        
          ps = conn.prepareStatement(query);
          
          for (int i = 0; i < form.getGeneric().size(); i++) {

        	  GenericActionBean frm = form.getGeneric().get(i);
				
				   if (frm.getChecks() != null
							&& frm.getChecks().equals("on")) {
					  
					   
					    ps.setString(1, frm.getAttendedDate());
						ps.setString(2, frm.getAttendBy());
						ps.setString(3,frm.getActionTaken());
						ps.setString(4,frm.getMesSentToGrevance());
						ps.setString(5,frm.getDateOfSent());
						ps.setString(6,frm.getActionDesc());
						ps.setString(7,frm.getCategory());
						ps.setString(8, frm.getRemarks());
						ps.setString(9,frm.getComplaintNumber());
						
          ps.addBatch();
			recCount++;
		
      }
      }
          
          int res[] = ps.executeBatch();
          if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}
      }
      catch(SQLException sqle)
      {
          int errorCode = sqle.getErrorCode();
          if(errorCode == 1)
              errorMessage = "Record with this name exists.";
      }
      catch(Exception e)
      {
    	  e.printStackTrace();
          Debug.println("The error in insertComplaints" + e);
      }
      finally
      {

			if (ps != null) {
				try {
					ps.close();
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
      return recCount;
  }
	
	
	
	
	private java.sql.Date getJavaSqlDate(String repairdate) {
		// TODO Auto-generated method stub
		return null;
	}

	private java.sql.Date getCurrentJavaSqlDate() {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<LabelValueBean> getUrbDistricts(String distCode) throws Exception {
		ArrayList<LabelValueBean> dists = null;
		try {
			 dists = new ArrayList<LabelValueBean>();
			conn = RwsOffices.getConn();
				String distCodeCol="";
			if(distCode!=null&&(!distCode.trim().equals(""))&&Integer.parseInt(distCode.trim())!=0)
					distCodeCol=" where dcode='"+distCode+"' ";
			else
				distCodeCol=" ";
			query = " SELECT dcode, dname FROM URBAN_DISTRICT_TBL "+distCodeCol+" ORDER BY dname";	
			//query = " SELECT dcode, dname FROM rws_district_tbl  ORDER BY dcode,dname";	
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();		
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));				
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			 System.out.println("Exception in getCircles is "+e);
		} finally {
			 if(ps!=null)
				 ps.close();
	    	  if(conn!=null)
	    		  conn.close();	
		}
		return dists;
	}
	public ArrayList<GenericActionBean> getUrbGenericDetails(String circle,String dcode,String date,String loggedUser) {
		
		ArrayList<GenericActionBean> habs = new ArrayList<GenericActionBean>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			if(loggedUser.equals("admin") || loggedUser.equals("200000") || loggedUser.equals("1000DR")){
				//query="select distinct dname,mname,pname,vname,HABITATION_CODE,panch_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,p.rep_name,a.name,a.address,nvl(a.phone_no,'-'),ACTION_TAKEN,ACTION_DESC,ATTENDED_BY,to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),NATURE_PROBLEM,REMARKS   from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p,rws_complete_hab_view b where p.rep_code=a.rep_code and dcode='"+dcode+"'  and a.complaint_status is null  and habitation_code=panch_code  ";
				/*query="select distinct dname,mname,vname,HABITATION_CODE,LOCALITY,a.complaint_no,"
						+ " to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,"
						+ " p.rep_name,a.name,a.address,nvl(a.phone_no,'-'),ACTION_TAKEN,ACTION_DESC,ATTENDED_BY,"
						+ " to_char(ATTENDED_DATE,'dd/mm/yyyy'),MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),"
						+ " NATURE_PROBLEM,REMARKS from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p,"
						+ " URBAN_DISTRICT_TBL b,URBAN_MANDAL_TBL c,URBAN_VILLAGE_TBL e, URBAN_LOCALITY f  "
						+ " where p.rep_code=a.rep_code and substr(HABITATION_CODE,1,2)=b.dcode and  b.dcode=c.dcode and "
						+ " substr(HABITATION_CODE,3,2)=c.mcode and "
						+ " b.dcode=e.dcode and c.mcode=e.mcode and substr(HABITATION_CODE,5,3)=e.vcode and substr(HABITATION_CODE,1,2)='"+dcode+"' ";
				if(date!=null && date!=""){
					query+=" and a.complaint_date=to_date('"+date+"','dd/mm/yyyy')   ";
				}
				query=query+ " and URBAN_WATER ='U' order by a.complaint_no";*/		
				
				query="select distinct dname,mname,HABITATION_CODE,LOCALITY,a.complaint_no, to_char (a.complaint_date,'dd/mm/yyyy') as complaint_date, nvl(a.complaint_desc,'-') as complaint_desc, p.rep_name,a.name,a.address, nvl(a.phone_no,'-') as phone_no,ACTION_TAKEN,ACTION_DESC,ATTENDED_BY, to_char(ATTENDED_DATE, 'dd/mm/yyyy') as ATTENDED_DATE,MESSAGE_SENT,to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy') as MESSAGE_SENT_DATE, NATURE_PROBLEM, REMARKS from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p, URBAN_DISTRICT_TBL b, URBAN_LOCALITY f, URBAN_MANDAL_TBL c "+  
							" where p.rep_code=a.rep_code and substr(HABITATION_CODE,1,2)=b.dcode and   substr(HABITATION_CODE,1,2)='"+dcode+"'  and a.complaint_date=to_date('"+date+"','dd/mm/yyyy')   and a.HABITATION_CODE=f.hab_code and URBAN_WATER ='U' and b.dcode=c.dcode and  substr(HABITATION_CODE,3,2)=c.mcode and ATTENDED_DATE is null order by a.complaint_no "; 
 
			}						
			
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				
				GenericActionBean habMandal = new GenericActionBean();
				habMandal.setDcode(rset.getString("dname"));
				habMandal.setMcode(rset.getString("mname"));
				habMandal.setPanchCode(rset.getString("HABITATION_CODE"));
				habMandal.setPanchName(rset.getString("LOCALITY"));
				habMandal.setComplaintNumber(rset.getString("complaint_no"));
				habMandal.setComplaintDate(rset.getString("complaint_date"));
				habMandal.setPrblmDesc(rset.getString("complaint_desc"));
				habMandal.setComplaintGivenBy(rset.getString("rep_name"));
				habMandal.setName(rset.getString("name"));
				habMandal.setAddress(rset.getString("address"));
				habMandal.setPhoneNumber(rset.getString("phone_no"));
				habMandal.setActionTaken(rset.getString("ACTION_TAKEN"));
				habMandal.setActionDesc(rset.getString("ACTION_DESC"));
				habMandal.setAttendBy(rset.getString("ATTENDED_BY"));
				habMandal.setAttendedDate(rset.getString("ATTENDED_DATE"));
				habMandal.setMesSentToGrevance(rset.getString("MESSAGE_SENT"));
				habMandal.setDateOfSent(rset.getString("MESSAGE_SENT_DATE"));
				habMandal.setCategory(rset.getString("NATURE_PROBLEM")); 
				habMandal.setRemarks(rset.getString("REMARKS"));
				habs.add(habMandal);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {			
			try {
			if(ps!=null)
				ps.close();
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		return habs;
	}
	public  int updateUrbActiontaken(GenericActionForm form,DataSource dataSource,HttpServletRequest request)
		      throws Exception {
					
			  int recCount = 0;
		     // GenericActionDAO genericActionDAO = null;		      
		      Connection conn = null;
		  	  PreparedStatement stmt = null;
		      
		      try {
		    	//  genericActionDAO = new GenericActionDAO();
		    	  conn = RwsOffices.getConn();
		    	  conn.setAutoCommit(false);		    	  		          	        		          
		          String query ="update RWS_generic_COMPLAINTS_REG_TBL set ATTENDED_DATE=to_date(?,'dd/mm/yyyy') , "
		          		+ " ATTENDED_BY=?,ACTION_TAKEN=?,MESSAGE_SENT=?, MESSAGE_SENT_DATE=to_date(?,'dd/mm/yyyy'),ACTION_DESC=?,"
		          		+ " NATURE_PROBLEM=?,REMARKS=? where COMPLAINT_NO =?  and and URBAN_WATER ='U'" ;

		          stmt = conn.prepareStatement(query);
		          
		          for (int i = 0; i < form.getGeneric().size(); i++) {
		        	  GenericActionBean frm = form.getGeneric().get(i);						
					   if (frm.getChecks() != null&& frm.getChecks().equals("on")) {							  						  							   
						   stmt.setString(1, frm.getAttendedDate());								 
							stmt.setString(2, frm.getAttendBy());
							stmt.setString(3,frm.getActionTaken());
							stmt.setString(4,frm.getMesSentToGrevance());
							stmt.setString(5,frm.getDateOfSent());
							stmt.setString(6,frm.getActionDesc());
							stmt.setString(7,frm.getCategory());
							stmt.setString(8, frm.getRemarks());
							stmt.setString(9,frm.getComplaintNumber());
							stmt.addBatch();
							recCount++;				          
					   }
		          }		          
		          int res[] = stmt.executeBatch();
		          if (res.length>0) {
						request.setAttribute("message", "Records Updated Successfully");
						conn.commit();						
					} else {
						conn.rollback();
						request.setAttribute("message", "Updation Failed");
					}
		      }
		      catch(SQLException sqle){
		    	  sqle.printStackTrace();
		    	  conn.rollback();
		          int errorCode = sqle.getErrorCode();
		          if(errorCode == 1)
		              errorMessage = "Record with this name exists.";
		      }
		      catch(Exception e){
		    	  conn.rollback();
		    	  e.printStackTrace();
		          Debug.println("The Exception in insertComplaints" + e);
		      }
		      finally{		    	 
		          	    	
		    	  if(stmt!=null)
		    		  stmt.close();
		    	  if(conn!=null)
		    		  conn.close();		    	  
		      }
		      return recCount;
		  }	
	
}
