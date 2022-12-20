package nic.watersoft.smsmobile;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
public class Rws_tvm_DAO 
{
	private Connection conn = null;
	private PreparedStatement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private LabelValueBean labelValueBean = null;
	Statement stmt = null;
	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select distinct mcode,mname from rws_complete_hab_view,rws_mobile_sms_register_tbl c   where panch_code=c.habitation_code and  DCODE=?  and c.designation='Panch Volunteer'  order by mname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) 
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
		}
		catch (Exception e) 
		{
			System.out.println("The Exception is in TVM getDistrictMandals : "+e.getMessage());
		} 
		finally 
		{
			closeAll();
		}
		return mandals;
	}
	
	public ArrayList getPanchayats(String dcode, String mcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select distinct pcode,pname from rws_complete_hab_view,rws_mobile_sms_register_tbl c  where panch_code=c.habitation_code and  DCODE=?  and MCODE=? and c.designation='Panch Volunteer'  order by pname";
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
		} 
		catch (Exception e) 
		{
			System.out.println("The Exception is in TVM getPanchayats : "+e.getMessage());
		} 
		finally 
		{
			closeAll();
		}
		return panchayats;
	}
	public ArrayList getVillages(String dcode, String mcode, String pcode) throws Exception 
	{
		ArrayList villages = new ArrayList();
		try 
		{
			conn = RwsOffices.getConn();
			query = "select distinct vcode,vname from rws_complete_hab_view,rws_mobile_sms_register_tbl c   where panch_code=c.habitation_code and  DCODE=?  and MCODE=?  and pcode=? and c.designation='Panch Volunteer'  order by vname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) 
		{
			System.out.println("The Exception is in TVM getVillages : "+e.getMessage());
		} finally {
			closeAll();
		}
		return villages;
	}
	public  ArrayList getHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception 	{
		ArrayList habs=new ArrayList();		  
		 String query="";
		try{
			conn = RwsOffices.getConn();
			query = "select distinct panch_code,panch_name from rws_complete_hab_view,rws_mobile_sms_register_tbl c  where panch_code=c.habitation_code and  DCODE=?  and MCODE=?  and pcode=? and vcode=? and c.designation='Panch Volunteer'  order by panch_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset =ps.executeQuery();
			while ( rset.next() ) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2)+" - "+rset.getString(1));
				habs.add(labelValueBean);				
			}
		}
		catch (Exception e)
		{
			System.out.println("Exception at getHabitations in TVM *****  "+e);//e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
public ArrayList getRegTankers(String hcode,String mobile,String dcode,String mcode) throws Exception {
		ArrayList tankers = new ArrayList();
		ArrayList<String> regTankers = new ArrayList<String>();
		try {
			//String dcode = habCode.substring(0, 2);
			//String mcode = habCode.substring(5, 7);
			String pcode = hcode.substring(12, 14);
			String vcode = hcode.substring(7, 10);
			conn = RwsOffices.getConn();
			query = "select tanker_regno,mobile from rws_tanker_vol_mapp_tbl where mobile=? order by tanker_regno";
			ps = conn.prepareStatement(query);
			ps.setString(1, mobile);
			rset = ps.executeQuery();
			
			while (rset.next()) 
			{
				regTankers.add(rset.getString(1));
			}
			rset.close();
			ps.close();
			query = "select tanker_reg_no,tanker_owner_name from rws_tanker_reg_tbl where substr(habitation_code,1,2)=? and substr(habitation_code,6,2)=? and substr(HABITATION_CODE,13,2)=? and substr(HABITATION_CODE,8,3)=?";
			//query = "select tanker_reg_no,tanker_owner_name from rws_tanker_reg_tbl where habitation_code=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) 
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				if(regTankers.contains(rset.getString(1)))
				{
					labelValueBean.setTankerStatus(true);
				}
				tankers.add(labelValueBean);
			}
		} 
		catch (Exception e) 
		{
			System.out.println("The Exception is in TVMDaO : "+e.getMessage());
		} 
		finally 
		{
			closeAll();
		}
		return tankers;
	}
	public ArrayList getVolunteers(String hcode) throws Exception 
	{
		ArrayList volunteers = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select mobile,data_collector_name  from  rws_mobile_sms_register_tbl  where habitation_code=? and designation='Panch Volunteer' and TASK_AUTHORISED_CODE='04' order by data_collector_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, hcode);
			rset = ps.executeQuery();
			while (rset.next()) 
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				volunteers.add(labelValueBean);
			}
		} 
		catch (Exception e)
		{
			System.out.println("The Exception is in TVMDaO : "+e.getMessage());
		} 
		finally
		{
			closeAll();
		}
		return volunteers;
	}
 public  ArrayList getHabitationTVMDetails(String dcode,String mcode,String mandalName,String pcode,String pname,String vcode,String vname,String hcode,String mobile) throws Exception 
	 {   
		 	Rws_TVM_Frm rws_tvm_frm = null;
			ArrayList habitaitonDetails = new ArrayList();
			String query="";	
			if(!dcode.equals("")&&!mcode.equals("")&&pcode.equals("")) {				
				query="select pcode,pname,vcode,vname,panch_code,panch_name,c.data_collector_name,vm.tanker_regno,c.mobile  from  rws_complete_hab_view,rws_mobile_sms_register_tbl c,rws_tanker_vol_mapp_tbl vm    where panch_code=c.habitation_code and  dcode='"+dcode+"' and mcode='"+mcode+"' and c.designation='Panch Volunteer' and vm.mobile=c.mobile  order by c.data_collector_name";

			}			
			else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&vcode.equals("")){			
				
				query="select pcode,pname,vcode,vname,panch_code,panch_name,c.data_collector_name,vm.tanker_regno,c.mobile  from  rws_complete_hab_view,rws_mobile_sms_register_tbl c,rws_tanker_vol_mapp_tbl vm    where panch_code=c.habitation_code and  dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and c.designation='Panch Volunteer' and vm.mobile=c.mobile  order by c.data_collector_name";
		
				
			}
			else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&!vcode.equals("")&&hcode.equals("")) {				
				query="select pcode,pname,vcode,vname,panch_code,panch_name,c.data_collector_name,vm.tanker_regno,c.mobile  from  rws_complete_hab_view,rws_mobile_sms_register_tbl c,rws_tanker_vol_mapp_tbl vm    where panch_code=c.habitation_code and  dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'  and vcode='"+vcode+"' and c.designation='Panch Volunteer' and vm.mobile=c.mobile  order by c.data_collector_name";
			
			}
			else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&!vcode.equals("")&&!hcode.equals(""))
			{
				
				if(mobile.equalsIgnoreCase("")||mobile.equalsIgnoreCase("00")||mobile.equalsIgnoreCase(null)){
				
				query="select pcode,pname,vcode,vname,panch_code,panch_name,c.data_collector_name,vm.tanker_regno,c.mobile  from  rws_complete_hab_view,rws_mobile_sms_register_tbl c,rws_tanker_vol_mapp_tbl vm    where panch_code=c.habitation_code and  panch_code='"+hcode+"'  and c.designation='Panch Volunteer' and vm.mobile=c.mobile  order by c.data_collector_name";
					
				}else
				{
					query="select pcode,pname,vcode,vname,panch_code,panch_name,c.data_collector_name,vm.tanker_regno,c.mobile  from  rws_complete_hab_view,rws_mobile_sms_register_tbl c,rws_tanker_vol_mapp_tbl vm    where panch_code=c.habitation_code and  panch_code='"+hcode+"'  and c.designation='Panch Volunteer' and vm.mobile=c.mobile and vm.mobile='"+mobile+"' order by c.data_collector_name";

				}
			
			}
			Connection conn=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			try {
				conn = RwsOffices.getConn();
				stmt = conn.prepareStatement(query);
				rs = stmt.executeQuery();
		while (rs.next()) {
			rws_tvm_frm = new Rws_TVM_Frm();
			if(pcode.equals("")){
				rws_tvm_frm.setPcode(rs.getString("PCODE"));
				rws_tvm_frm.setPname(rs.getString("PNAME"));
			}
			if(vcode.equals("")) {
				rws_tvm_frm.setVcode(rs.getString("VCODE"));
				rws_tvm_frm.setVname(rs.getString("VNAME"));
			}
			rws_tvm_frm.setHabCode(rs.getString("panch_CODE"));
			rws_tvm_frm.setHabName(rs.getString("PANCH_NAME"));
			rws_tvm_frm.settRegno(rs.getString("tanker_regno"));
			rws_tvm_frm.setVolName(rs.getString("data_collector_name"));
			rws_tvm_frm.setVolMobile(rs.getString("mobile"));
			habitaitonDetails.add(rws_tvm_frm);
		}				
		rs.close();
		stmt.close();		
		} catch (Exception e) {
			Debug.println("The Exception is in TVMDaO : " + e.getMessage());
		} finally {			
			if(conn!=null){
				conn.close();
			}
		}		
		return habitaitonDetails;
	}
     public String insertTVM( String mobile,ArrayList duplicatevalues1,String typeop)	throws Exception 
		{
			String query = "";
			String msg = "";
			try {
				conn = RwsOffices.getConn();
					query = " insert into RWS_TANKER_VOL_MAPP_TBL(mobile,tanker_regno) values(?,?)";
					ps = conn.prepareStatement(query);
					for (Object strTemp : duplicatevalues1){
						ps.setString(1, mobile);
						ps.setString(2, strTemp.toString());
						ps.addBatch();
						}
					int res[]=ps.executeBatch();
					
					if (res.length > 0)
						if(typeop.equalsIgnoreCase("save")){
						msg = "Saved Successfully...";
						}else{
							msg = "Updated Successfully...";
						}
					//System.out.println("msg in dao is :"+msg);		
					/*}else
						msg = "You havn't perform any operation";*/
				
			} catch (Exception e) {
				Debug.println("The Exception in TVMDaO" + e);
				msg = "Cannot be Saved,Try Again...";
			} finally {
				closeAll();
			}
			return msg;
		}
	 public String deleteTVM( String mobile,ArrayList duplicatevalues1,String typeop)	throws Exception 
		{
			String query = "";
			String msg = "";
			try {
				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				query = " delete  from rws_tanker_vol_mapp_tbl  where mobile=? and tanker_regno=?  ";
					ps = conn.prepareStatement(query);
					for (Object strTemp : duplicatevalues1){
						ps.setString(1, mobile);
						ps.setString(2, strTemp.toString());
						ps.addBatch();
						}
					int res[]=ps.executeBatch();
					if (res.length > 0)
						if(typeop.equalsIgnoreCase("save")){
							conn.commit();
						msg = "Saved Successfully...";
						}else{
							conn.commit();
							msg = "Updated Successfully...";
						}
					//System.out.println("msg in dao is :"+msg);	
					/*else
						msg = "You havn't perform any operation";*/
				
			} catch (Exception e) 
			{
				Debug.println("The Exception in TVMDaO" + e);
				msg = "Cannot be Saved,Try Again...";
			} finally {
				closeAll();
			}
			return msg;
		}
	 public String deleteAllTVM(String mobile,String typeop)
				throws Exception {
            String query = "";
			String msg = "";
			int rcount = 0;

			try {
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();

				query = "delete  from rws_tanker_vol_mapp_tbl  where mobile='" + mobile + "'";
				rcount = stmt.executeUpdate(query);
				if (rcount > 0)
					if(typeop.equalsIgnoreCase("save")){
					msg = "Saved Successfully...";
					}else{
						msg = "Updated Successfully...";
					}

			} catch (Exception e) {
				msg = "Record Cannot be Deleted";
				Debug.println("The Exception in deleteVillage=" + e);
			} finally {

				closeAll();
			}
			return msg;
		}
	 public ArrayList getMappedTankers(String mobile) throws Exception {
			ArrayList mappedtankers = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				query = "select tanker_regno,mobile from rws_tanker_vol_mapp_tbl where mobile=? order by tanker_regno";
				ps = conn.prepareStatement(query);
				ps.setString(1, mobile);
				rset = ps.executeQuery();
				while (rset.next()) 
				{
					mappedtankers.add(rset.getString(1));
				}
			} catch (Exception e) 
			{
				System.out.println("The Exception is in TVMDaO getVillages : "+e.getMessage());
			} 
			finally 
			{
				closeAll();
			}
			return mappedtankers;
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
