package nic.watersoft.smsmobile;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
public class Rws_Telugutranslation_DAO
{
	private Connection conn = null;
	private PreparedStatement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private PreparedStatement ps_dist;
	private PreparedStatement ps_mand;
	private PreparedStatement ps_panch;
	private PreparedStatement ps_vill;
	private PreparedStatement ps_hab;
	/*private ResultSet rset_dist = null;
	private ResultSet rset_mand = null;
	private ResultSet rset_panch = null;
	private ResultSet rset_vill = null;
	private ResultSet rset_hab = null;*/
	private LabelValueBean labelValueBean = null;
	Statement stmt = null;
	
	
	
	public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL ORDER BY DCODE,DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDistricts : "+e.getMessage());
		} finally {
			closeAll();
		}

		return dists;
	}
	
	public String getDistrictName(String dcode) throws Exception {
		String districtName = "";
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				districtName = rset.getString("dname");
			}
		} catch (Exception e) {
			System.out.println("The Exceptiion is in RwsOffices getDistrictName : "+e.getMessage());
		} finally {
			closeAll();
		}
		return districtName;
	}
	
	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDistrictMandals : "+e.getMessage());
		} finally {
			closeAll();
		}

		return mandals;
	}
	
	public ArrayList getPanchayats(String dcode, String mcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE=? AND MCODE=? ORDER BY PNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				panchayats.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getPanchayats : "+e.getMessage());
		} finally {
			closeAll();
		}
		return panchayats;
	}
	
	public ArrayList getVillages(String dcode, String mcode, String pcode) throws Exception {
		ArrayList villages = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "SELECT VCODE, VNAME FROM RWS_VILLAGE_TBL WHERE DCODE=? AND MCODE=? AND PCODE=? ORDER BY VNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getVillages : "+e.getMessage());
		} finally {
			closeAll();
		}
		return villages;
	}
	
	public static String convertToTelugu(String input){
		//System.out.println("**********"+"*******"+input);
		StringBuffer result = new StringBuffer();
		 for (char temp : input.toCharArray()) {
	            int decimal = (int) temp;
	            result.append("&#"+(decimal)+";");
	        }
		return result.toString();	
	}
	
	public ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode) throws Exception {
		ArrayList habs = new ArrayList();
		String query = "";
		
		try {
			conn = RwsOffices.getConn();
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME,RAJ.PANCH_NAME_TELUGU FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)= ? AND SUBSTR(RAJ.HAB_CODE,6,2)= ? AND "
					+ "SUBSTR(RAJ.HAB_CODE,13,2)= ? AND SUBSTR(RAJ.HAB_CODE,8,3)= ? AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				/*labelValueBean.setTlabel(rset.getString(4));*/
				
				if(rset.getString(4)!=null){
				labelValueBean.setTlabels(convertToTelugu(rset.getString(4)));
				}
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return habs;
	}
	
	
	
	
	private static String convertToString(String input){
		StringBuilder result = new StringBuilder();
		/*String[] arr = null;
		if(input.contains(" ")){
			arr = input.split(" ");
		}*/
		if(input!=null&&!input.isEmpty()){
		String[] str = input.split(";");
		for(int i=0;i<str.length;i++){
			String s = str[i].trim();
			s = s.replace("&#", "");
			int decimal = Integer.parseInt(s);
			result.append((char) decimal);
		}
		}
		return result.toString();
	}
	public String getDistrictTelugunameStr(String dcode) throws Exception {
		//ArrayList dis_telugu = new ArrayList();
		String query ;
		StringBuffer result = new StringBuffer();
		try {
			
			conn = RwsOffices.getConn();
			//query = "";
			query = "select DCODE,DNAME,DNAME_TELUGU from rws_district_tbl WHERE DCODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				if(rset.getString(3)!=null){
					 for (char temp : rset.getString(3).toCharArray()) {
				            int decimal = (int) temp;
				            result.append("&#"+(decimal)+";");
				        }
				}
			}
		} catch (Exception e) {
			 System.out.println("The error in Rws telugu translation dao="+e);
		} finally {
			closeAll();
		}
		return result.toString();
	}
	
	
	public String getMandalTelugunameStr(String dcode,String mcode) throws Exception {
		//ArrayList dis_telugu = new ArrayList();
		String query ;
		StringBuffer result = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			query = "select MCODE,MNAME,MNAME_TELUGU from rws_mandal_tbl WHERE dcode=? and MCODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				if(rset.getString(3)!=null){
					 for (char temp : rset.getString(3).toCharArray()) {
				            int decimal = (int) temp;
				            result.append("&#"+(decimal)+";");
				        }
				}
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return result.toString();
	}
	
	public String getPanchayatTelugunameStr(String dcode,String mcode,String pcode) throws Exception {
		//ArrayList dis_telugu = new ArrayList();
		String query ;
		StringBuffer result = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			query = "select PCODE,PNAME,PNAME_TELUGU from rws_panchayat_tbl WHERE dcode=? and MCODE=? and PCODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {	
				
				if(rset.getString(3)!=null){
					 for (char temp : rset.getString(3).toCharArray()) {
				            int decimal = (int) temp;
				            result.append("&#"+(decimal)+";");
				        }
				}
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return result.toString();
	}
	
	
	public String getVillageTelugunameStr(String dcode,String mcode,String pcode,String vcode) throws Exception {
		//ArrayList dis_telugu = new ArrayList();
		String query ;
		StringBuffer result = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			query = "select vCODE,vNAME,vNAME_TELUGU from rws_village_tbl WHERE dcode=? and MCODE=? and PCODE=? and vCODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {	
				
				if(rset.getString(3)!=null){
					
					 for (char temp : rset.getString(3).toCharArray()) {
				            int decimal = (int) temp;
				            result.append("&#"+(decimal)+";");
				        }
				}
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return result.toString();
	}
	
 
 public String insertDetails( String dcode,String mcode,String pcode,String vcode,String dname,String mname,String pname,String vname,ArrayList habcodeslist,ArrayList telugunameslist)	throws Exception 
	{
		String query_mname ="";
		String query_pname ="";
		String query_vname ="";
		String query_hname ="";
		String msg = "";
		try {
			conn = RwsOffices.getConn();
			query_mname = "update rws_mandal_tbl set MNAME_TELUGU=?  where dcode=? and mcode=?";
			ps_mand = conn.prepareStatement(query_mname);
			ps_mand.setNString(1, convertToString(mname));
			ps_mand.setString(2, dcode);
			ps_mand.setString(3, mcode);
			int m_count=ps_mand.executeUpdate();
			//System.out.println(m_count+"%%%%%%%%%%%%%%");
			
			query_pname = "update rws_panchayat_tbl set PNAME_TELUGU=?  where dcode=? and mcode=? and pcode=?";
				ps_panch = conn.prepareStatement(query_pname);
				ps_panch.setNString(1, convertToString(pname));
				ps_panch.setString(2, dcode);
				ps_panch.setString(3, mcode);
				ps_panch.setString(4, pcode);
				//ps_panch.addBatch();
				int p_count=ps_panch.executeUpdate();
				//System.out.println(p_count+"%%%%%%%%%%%%%%");
				
				query_vname = "update rws_village_tbl set VNAME_TELUGU=?  where dcode=? and mcode=? and pcode=? and vcode=?";
				ps_vill = conn.prepareStatement(query_vname);
				ps_vill.setNString(1, convertToString(vname));
				ps_vill.setString(2, dcode);
				ps_vill.setString(3, mcode);
				ps_vill.setString(4, pcode);
				ps_vill.setString(5, vcode);
				//ps_vill.addBatch();
				int v_count=ps_vill.executeUpdate();
				//System.out.println(v_count+"%%%%%%%%%%%%%%");
				
				query_hname = " update RWS_PANCHAYAT_RAJ_TBL set PANCH_NAME_TELUGU=? where PANCH_CODE=?";
				ps = conn.prepareStatement(query_hname);
				 for(int i=0;i<habcodeslist.size();i++)
		    	 {
					 ps.setNString(1, convertToString(telugunameslist.get(i).toString()));
					 ps.setString(2, habcodeslist.get(i).toString());
					 ps.addBatch();
		    		 
		    	 }
				
				
				
				
				int res[]=ps.executeBatch();
				if (res.length > 0)
				{
					msg = "Saved Successfully...";
				}
					
			
		} catch (Exception e) {
			Debug.println("The Exception in TVMDaO" + e);
			msg = "Cannot be Saved,Try Again...";
		} finally {
			closeAll();
		}
		return msg;
	}

	 public void closeAll() throws Exception 
	 {
		if (rset != null) 
		{
			try 
			{
				rset.close();
			} catch (Exception e) 
			{
				System.out.println("The exception in TVMDaO closeAll = "+e.getMessage());
			}
			rset = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				System.out.println("The exception in TVMDaO closeAll = "+e.getMessage());
			}
			rset = null;
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (Exception e) {
				System.out.println("The exception in TVMDaO closeAll = "+e.getMessage());
			}
			stat = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				System.out.println("The exception in TVMDaO closeAll = "+e.getMessage());
			}
			conn = null;
		}
		
	}
}
