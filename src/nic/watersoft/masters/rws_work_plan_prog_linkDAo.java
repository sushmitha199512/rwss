/*
 * Created  on Jun 5, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


import nic.watersoft.admin.AdminDTO;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import javax.servlet.http.HttpSession;
import nic.watersoft.commons.RwsOffices;
/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_work_plan_prog_linkDAo {

	private DataSource dataSource;
	private Connection conn;
	private Statement stat;
	private PreparedStatement ps;
	private ResultSet rset;
	private String query;
	private LabelValueBean labelValueBean;
	private SimpleDateFormat dateFormatter;
	
	public rws_work_plan_prog_linkDAo() 
	{
		
	}

	public rws_work_plan_prog_linkDAo(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	private void closeAll()
	{
		if(rset != null)
		{
			try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{
			try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(ps != null)
		{
			try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	
	//Deepak Modified
	public String insertData(String plan,String wrktype,String category, String program) throws Exception {
		Connection proglink;
		try	{
			 proglink=RwsOffices.getConn();
			String qry="select PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,PROGRAMME_CODE from rws_work_prog_lnk_tbl where PLAN_CODE= ? and AUG_NEW_CODE= ? and CATEGORY_CODE= ? and PROGRAMME_CODE= ?";
			ps = proglink.prepareStatement(qry);
			ps.setString(1, plan);
			ps.setString(2, wrktype);
			ps.setString(3, category);
			ps.setString(4, program);
			rset=ps.executeQuery();
			if(!rset.next()){
				String squery="insert into rws_work_prog_lnk_tbl(PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,PROGRAMME_CODE)" +
			   			"values( ?, ?, ?, ?)";
				ps=proglink.prepareStatement(squery);
				ps.setString(1, plan);
				ps.setString(2, wrktype);
				ps.setString(3, category);
				ps.setString(4, program);
				int status=ps.executeUpdate();
	 		   if(status>0){
	 		   		return "success";
	 		   }
	 		   else {
	 		   		return "failure";
	 		   }
	 	   }
			else{
				return "exist";
			}
		}
		catch(Exception e){
			System.out.println("The Exceptiion is in rws_work_plan_prog_linkDAO getProgrammes : "+e.getMessage());		
		}  
		finally{
			closeAll();
		}
		return ""; 
	}
	
	//Deepak Modified
	public ArrayList getviewData(String plan,String wrktype,String category, String program) throws Exception {
		ArrayList viewsum = new ArrayList();		
		try	{
			conn = RwsOffices.getConn();
			String qry;
			rws_work_prog_link_DTO progDTO = null;
			String qryy = "select p.plan_name,c.category_name,a.aug_new_name,pm.programme_name ";
			String where="";
			if(plan!=null && !plan.equals("")){
				where+=" and p.plan_code='"+plan+"'";
			}
			if(wrktype!=null && !wrktype.equals("")){
				where+=" and a.aug_new_code='"+wrktype+"'";
			}
			if(category!=null && !category.equals("")){
				where+=" and c.category_code='"+category+"'";
			}
			if(program!=null && !program.equals("")){
				where+=" and pm.programme_code='"+program+"'";
			}
			qryy+=",pl.* from rws_plan_nonplan_tbl p, rws_work_category_tbl c,RWS_AUGUMENTATION_NEW_TBL a,rws_programme_tbl pm, rws_work_prog_lnk_tbl pl where p.plan_code=pl.plan_code and c.category_code=pl.category_code and a.aug_new_code=pl.aug_new_code and pm.programme_code=pl.programme_code "+where;
			ps = conn.prepareStatement(qryy);
			rset = ps.executeQuery();			
		    while(rset.next()){		    	
				progDTO = new rws_work_prog_link_DTO();
				progDTO.setPlan(rset.getString(1));
				progDTO.setWrktype(rset.getString(2));
				progDTO.setCategory(rset.getString(3));
				progDTO.setProgram(rset.getString(4));				
				progDTO.setPlancode(rset.getString(5));
				progDTO.setWorkcode(rset.getString(6));
				progDTO.setCategorycode(rset.getString(7));
				progDTO.setProgramcode(rset.getString(8));			
				
				 String qry1="select count(*) from rws_work_admn_tbl WHERE PLAN_CODE= ? and AUG_NEW_CODE= ? and CATEGORY_CODE= ? and PROGRAMME_CODE= ? ";
				 PreparedStatement stt = conn.prepareStatement(qry1); 
				 stt.setString(1, rset.getString(5));
				 stt.setString(2, rset.getString(6));
				 stt.setString(3, rset.getString(7));
				 stt.setString(4, rset.getString(8));
				 ResultSet rrs = stt.executeQuery();
				 int count = 0;
				 if(rrs.next())count = rrs.getInt(1); 
				 progDTO.setCount(count);
			     viewsum.add(progDTO);		
			}			
		}
		catch(Exception e){	
			System.out.println("The Exceptiion is in rws_work_plan_prog_linkDAO getviewData :"+e.getMessage());
		}
		finally	{	
			closeAll();			
		}		
		return viewsum;
	}

	//Deepak Modified
	public String getdeleteData(rws_work_categoryForms fb){
		int rcount=0;		
		try{			
			String plancode=fb.getPlan();
			String workcode=fb.getWrktype();
			String categorycode=fb.getWorkCategory();
			String programcode=fb.getProgram();
			conn=RwsOffices.getConn();
			String qry="delete from rws_work_prog_lnk_tbl where PLAN_CODE= ? and AUG_NEW_CODE= ? and CATEGORY_CODE= ? and PROGRAMME_CODE= ? ";
			ps=conn.prepareStatement(qry);
			ps.setString(1, plancode);
			ps.setString(2, workcode);
			ps.setString(3, categorycode);
			ps.setString(4, programcode);
			rcount = ps.executeUpdate();
			if(rcount>0) {
	 		   		return "success";
	 		   }
	 		   else{
	 		   		return "failure";
	 		   }	 	   			 
		}catch(Exception e){   
			System.out.println("The Exceptiion is in rws_work_plan_prog_linkDAO getdeleteData : "+e.getMessage());			
		}finally{
			closeAll();
		}
		return "";
	}

	//Deepak Modified
	public String geteditData(rws_work_categoryForms form1,String pcode) {		
        int count=0;    
		try	{
		   	conn = RwsOffices.getConn();
			PreparedStatement ps1=null;
			ResultSet rs1=null;
		 	String qry="select PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,PROGRAMME_CODE from rws_work_prog_lnk_tbl where PLAN_CODE = ? and AUG_NEW_CODE= ? and CATEGORY_CODE= ? and PROGRAMME_CODE= ? ";
		 	ps = conn.prepareStatement(qry);
		 	ps.setString(1, form1.getPlan());
		 	ps.setString(2, form1.getWrktype());
		 	ps.setString(3, form1.getWorkCategory());
		 	ps.setString(4, form1.getProgram());
		 	ResultSet rs=ps.executeQuery();
		 	if(!rs.next()){
		 		String eqry="update rws_work_prog_lnk_tbl set PROGRAMME_CODE= ? where PLAN_CODE= ? and AUG_NEW_CODE= ? and CATEGORY_CODE= ? and PROGRAMME_CODE= ? ";
 		 		ps1 = conn.prepareStatement(eqry); 
			 	ps1.setString(1, form1.getProgram());
			 	ps1.setString(2, form1.getPlan());
			 	ps1.setString(3, form1.getWrktype());
			 	ps1.setString(4, form1.getWorkCategory());
			 	ps1.setString(5, pcode);
			 	count=ps1.executeUpdate();
			 	if(count>0){
			 		return "success";
	 		     }
	 		    else{
	 		    	return "failure";
		 	     }
		 	}
		 	else {
		 		 return "exist";
		 	}
		 
		}catch(Exception e){
			System.out.println("The Exceptiion is in rws_work_plan_prog_linkDAO geteditData : "+e.getMessage());
		}
		finally{
			closeAll();  
		}		
		return "";
	}
	
}
