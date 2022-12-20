/*
 * Created on Jun 15, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.PanchRaj;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;
public class rws_works_WorksDAO implements WorksDAO
{
	private Connection connection;
    private DataSource dataSource;
    
    public rws_works_WorksDAO(Connection connection) 
    {
    	////System.out.println("Abt to assing the connection to loacl connection");
        this.connection = connection;
    }
   
    public ArrayList getWorks(rws_works_WorkStatus_form bean) throws Exception
   	{
       	
    	Debug.println("In getting the work details");
           ArrayList customerList = new ArrayList();
           ResultSet rs=null;
           PreparedStatement prpStmt = null;
     try
   		{
          String query="SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where " +
          		       " substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and PLAN_CODE =? and AUG_NEW_CODE =? and CATEGORY_CODE=?";
          if(bean.getProgram() != null && !bean.getProgram().equals(""))
     	     query=query.concat("and PROGRAMME_CODE ='"+bean.getProgram()+"'");
          if(bean.getSubprogram() != null && !bean.getSubprogram().equals(""))
    	     query=query.concat("and SUBPROGRAMME_CODE ='"+bean.getSubprogram()+"'");
          if(bean.getSubdivisioncode() != null && !bean.getSubdivisioncode().equals(""))
          	     query=query.concat("and substr(OFFICE_CODE,5,2)='"+bean.getSubdivisioncode()+"'");

          		 prpStmt = connection.prepareStatement(query);
          		prpStmt.setString(1, bean.getCircleCode());
          		prpStmt.setString(2, bean.getDivCode());
          		prpStmt.setString(3, bean.getPlan());
          		prpStmt.setString(4, bean.getWrktype());
          		prpStmt.setString(5, bean.getWorkCat());
          		 
   	             rs = prpStmt.executeQuery();
   	             while (rs.next())
   	             {
   	             	bean=new rws_works_WorkStatus_form();
   	             	bean.setWorkId(rs.getString("work_id"));
   	             	bean.setWorkName(rs.getString("work_Name"));
   	             	customerList.add(bean);
   	             }
   	             
   	       } 
           catch ( SQLException e ) 
   		   {
               System.err.println("SQL Exception occured while accessing the table" );
               e.printStackTrace();
               return null;
           }
           catch ( Exception e ) 
   		   {
        	   Debug.println("Exception in getWorks"+e);
               return null;
           }
           finally
   		   {
           	try{
	           	 if(prpStmt!=null)prpStmt.close();
	           	 if(rs!=null)rs.close();
	             if(connection!=null)connection.close();
           	   }
           	catch(Exception e)
			{}
   		   }
           return customerList;
       }
    public ArrayList getWorks22(rws_works_WorkStatus_form bean,String userId) throws Exception
   	{
    	
           ArrayList customerList = new ArrayList();
           ResultSet rs=null;
           PreparedStatement prpStmt = null;
     try
   		{
          String query="SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where " +
          		       " substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and PLAN_CODE =? and AUG_NEW_CODE =? and CATEGORY_CODE=?"; 
          if(bean.getProgram() != null && !bean.getProgram().equals(""))
    	     query=query.concat(" and PROGRAMME_CODE ='"+bean.getProgram()+"'");
         if(bean.getSubprogram() != null && !bean.getSubprogram().equals(""))
   	     query=query.concat(" and SUBPROGRAMME_CODE ='"+bean.getSubprogram()+"'");
         if(bean.getSubdivisioncode() != null && !bean.getSubdivisioncode().equals(""))
         	     query=query.concat(" and substr(OFFICE_CODE,5,2)='"+bean.getSubdivisioncode()+"'");
         if(bean.getSchemelist() != null && !bean.getSchemelist().equals(""))
     	     query=query.concat(" and TYPE_OF_ASSET  ='"+bean.getSchemelist()+"'");
         if(bean.getFinancialyear()!=null && !bean.getFinancialyear().equals(""))
         	query = query.concat(" and (admin_date>='01/APR/"+bean.getFinancialyear()+"' and admin_date<='31/MAR/"+(Integer.parseInt(bean.getFinancialyear())+1)+"')");
         query +=" order by work_id";
   	             prpStmt = connection.prepareStatement(query);
   	             prpStmt.setString(1, bean.getCircleCode());
   	             prpStmt.setString(2, bean.getDivCode());
   	             prpStmt.setString(3, bean.getPlan());
   	             prpStmt.setString(4, bean.getWrktype());
   	             prpStmt.setString(5, bean.getWorkCat());
   	             rs = prpStmt.executeQuery();
   	             while (rs.next())
   	             {
   	             	bean=new rws_works_WorkStatus_form();
   	             	bean.setWorkId(rs.getString("work_id"));
   	             	bean.setWorkName(rs.getString("work_id")+" - "+rs.getString("work_Name"));
   	             	customerList.add(bean);
   	             }
   	             
   	       } 
           catch ( SQLException e ) 
   		   {
               System.err.println("SQL Exception occured while accessing the table" );
               return null;
           }
           catch ( Exception e ) 
   		   {
        	   Debug.println("Exception in getWorks22:"+e);
               return null;
           }
           finally
   		   {
           	try{
	           	 if(prpStmt!=null)prpStmt.close();
	           	 if(rs!=null)rs.close();
	             if(connection!=null)connection.close();
           	   }
           	catch(Exception e)
			{}
   		   }
           return customerList;
       }
    
    public ArrayList getWorks1(rws_works_WorkStatus_bean bean,String subdiv) throws Exception
	{
    	
    	//System.out.println("In getting the work details");
        ArrayList customerList = new ArrayList();
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
        try
		{

	        String sqlQuery = "SELECT * FROM rws_work_admn_tbl where substr(OFFICE_CODE,2,2)='"+bean.getCircleCode()+"' and " +
	        		" substr(OFFICE_CODE,4,1)='"+bean.getDivCode()+"' and substr(OFFICE_CODE,5,2)='"+subdiv+"'";
	        //System.out.println("QUERY TO GET WORKS1 :"+sqlQuery);
            prpStmt = connection.prepareStatement(sqlQuery);
            rs = prpStmt.executeQuery();

            
            while (rs.next())
            {
            	bean=new rws_works_WorkStatus_bean();
            	bean.setWorkId(rs.getString("work_id"));
            	bean.setWorkName(rs.getString("work_Name"));
            	customerList.add(bean);
            }
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            e.printStackTrace();
            return null;
        }
        catch ( Exception e ) 
		{
            e.printStackTrace();
            return null;
        }
        finally
		{
			if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return customerList;
    }

    
    public rws_works_WorkStatus_form getWorkDetails(rws_works_WorkStatus_form bean) throws Exception
    {
    	
    	ResultSet rs=null,rs1=null;
        PreparedStatement prpStmt = null,prpStmt1 = null;

         
        try
		{
            String work_id=bean.getWorkId();
	         String sqlQuery = "select p.PROGRAMME_NAME ,s.SUBPROGRAMME_NAME,a.TYPE_OF_ASSET_NAME,p.PROGRAMME_code,s.SUBPROGRAMME_CODE,a.TYPE_OF_ASSET_CODE,a.code_series,w.sanction_amount,nvl(to_char(w.WORK_CANCEL_DT,'dd/mm/yyyy'),'') as WORK_CANCEL_DT,to_char(admin_date,'dd/mm/yyyy') as adate,REASON_FOR_NOT_GROUNDING "
	        		+ "from rws_programme_tbl p, rws_subprogramme_tbl s ,rws_asset_type_tbl a,rws_work_admn_tbl w "
	        		+ "where p.PROGRAMME_CODE =w.programme_code and s. PROGRAMME_CODE=w.programme_code and s.SUBPROGRAMME_CODE =w.subprogramme_code and p.programme_code=s.programme_code and w.work_id=? and a.TYPE_OF_ASSET_CODE = substr(?,7,2)";
            prpStmt = connection.prepareStatement(sqlQuery);
            prpStmt.setString(1, work_id);
            prpStmt.setString(2, work_id);
            rs = prpStmt.executeQuery();
            
            String sqlQuery1 = " select nvl(SANCTION_AMOUNT,0) from rws_work_admn_prog_lnk_tbl where work_id=? ";
            prpStmt1 = connection.prepareStatement(sqlQuery1);
            prpStmt1.setString(1, work_id);
            rs1 = prpStmt1.executeQuery();
            double moreThanOneProgAmt = 0;
            if(rs1.next())moreThanOneProgAmt=rs1.getDouble(1);
            while (rs.next())
            {
            	bean=new rws_works_WorkStatus_form();
            	bean.setProgName(rs.getString(1));
            	bean.setSubProgName(rs.getString(2));
            	bean.setScheme(rs.getString(3));
            	bean.setProgCode(rs.getString(4));
            	bean.setSubProgCode(rs.getString(5));
            	bean.setSchemeCode(rs.getString(6));
            	bean.setPumpCode(rs.getString(7));
            	bean.setAdminDate(rs.getString("adate"));
            	bean.setSamount(""+(moreThanOneProgAmt+rs.getDouble("SANCTION_AMOUNT")));
            	if(rs.getString("WORK_CANCEL_DT")!=null)
            		bean.setWorkCancelledDate(rs.getString("WORK_CANCEL_DT"));
            	else 
            		bean.setWorkCancelledDate("");
            	bean.setReasonCodeNotGround(rs.getString("REASON_FOR_NOT_GROUNDING"));
            }
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
            Debug.println("Exception in getWorkDetails"+e);
            return null;
        }
        finally
		{
			if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
          	if(prpStmt1!=null)prpStmt1.close();
          	if(rs1!=null)rs1.close();
            if(connection!=null)connection.close();
		}
        return bean;
    }
    
    public ArrayList getOfficeDetails(String hab_code) throws Exception {

		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		ArrayList details = new ArrayList();

		try {
			String sqlQuery = "select a.DCODE,a.DNAME,a.MCODE,a.MNAME,a.PCODE,a.PNAME,a.VCODE,a.VNAME,a.PANCH_CODE,"
					+ "a.PANCH_NAME,a.PREVIOUS_YR_STATUS,a.COVERAGE_STATUS,a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,"
					+ "a.CENSUS_ST_POPU,a.EXIST_WATER_LEVEL,a.UNSAFE_LPCD,a.SAFE_LPCD,a.HABITATION_SUB_TYPE,"
					+ "a.HAB_SUB_TYPE_40PC_CALC,b.division_office_code,b.division_office_name,c.subdivision_office_code,"
					+ "c.subdivision_office_name from rws_complete_hab_view a,rws_division_office_tbl b,rws_subdivision_office_tbl c,"
					+ "RWS_MANDAL_SUBDIVISION_TBL D WHERE a.dcode=b.circle_office_code and b.circle_office_code=c.circle_office_code "
					+ "and b.division_office_code=c.division_office_code and a.dcode=d.circle_office_code and b.division_office_code=d.division_office_code "
					+ "and c.subdivision_office_code=d.subdivision_office_code and a.dcode=d.dcode and a.mcode=d.mcode and a.panch_code=? ";

			prpStmt = connection.prepareStatement(sqlQuery);
			prpStmt.setString(1, hab_code);
			rs = prpStmt.executeQuery();

			int count = 0;
			while (rs.next()) {
				ArrayList a = new ArrayList();
				a.add(0, rs.getString(1));
				a.add(1, rs.getString(2));
				a.add(2, rs.getString(3));
				a.add(3, rs.getString(4));
				a.add(4, rs.getString(5));
				a.add(5, rs.getString(6));
				a.add(6, rs.getString(7));
				a.add(7, rs.getString(8));
				a.add(8, rs.getString(9));
				a.add(9, rs.getString(10));
				a.add(10, rs.getString(11));
				a.add(11, rs.getString(12));
				a.add(12, rs.getString(13));
				a.add(13, rs.getString(14));
				a.add(14, rs.getString(15));
				a.add(15, rs.getString(16));
				a.add(16, rs.getString(17));
				a.add(17, rs.getString(18));
				a.add(18, rs.getString(19));
				a.add(19, rs.getString(20));
				a.add(20, rs.getString(21));
				a.add(21, rs.getString(22));
				a.add(22, rs.getString(23));
				a.add(23, rs.getString(24));
				details.add(count++, a);
			}
			if (rs != null)
				rs.close();

		} catch (Exception e) {
			System.err.println("Exception getOfficeDetails of rws_works_worksDAO-- " + e);
			return null;
		} finally {
			if (prpStmt != null)
				prpStmt.close();
			if (rs != null)
				rs.close();
			if (connection != null)
				connection.close();
		}
		return details;
	}
    
    
    public ArrayList getCommWorkDetails(rws_works_WorkStatus_form bean) throws Exception {

		ArrayList customerList = new ArrayList();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		try {
			String query = "SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where " + " substr(OFFICE_CODE,2,2)='"
					+ bean.getCircleCode() + "'" + " and substr(OFFICE_CODE,4,1)='" + bean.getDivCode() + "'"
					+ " and PLAN_CODE ='" + bean.getPlan() + "'" + " and AUG_NEW_CODE ='" + bean.getWrktype() + "'"
					+ " and CATEGORY_CODE='" + bean.getWorkCat() + "' and TYPE_OF_ASSET not in ('09') ";

			if (bean.getProgram() != null && !bean.getProgram().equals(""))
				query = query.concat(" and PROGRAMME_CODE ='" + bean.getProgram() + "'");

			if (bean.getSubprogram() != null && !bean.getSubprogram().equals(""))
				query = query.concat(" and SUBPROGRAMME_CODE ='" + bean.getSubprogram() + "'");

			if (bean.getSubdivisioncode() != null && !bean.getSubdivisioncode().equals(""))
				query = query.concat(" and substr(OFFICE_CODE,5,2)='" + bean.getSubdivisioncode() + "'");

			query += " and work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null)  and work_id not in(select asset_code from RWS_ASSET_MAST_TBL) order by work_id";

			prpStmt = connection.prepareStatement(query);

			rs = prpStmt.executeQuery();
			while (rs.next()) {
				bean = new rws_works_WorkStatus_form();
				bean.setWorkId(rs.getString("work_id"));
				bean.setWorkName(rs.getString("work_id") + " - " + rs.getString("work_Name"));
				customerList.add(bean);
			}

		} catch (Exception e) {
			System.out.println("Exception in  getCommWorkDetails of rws_worksWorksDAO-- " + e);
			return null;
		} finally {
			try {
				if (prpStmt != null)
					prpStmt.close();
				if (rs != null)
					rs.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return customerList;
	}
    
	public String getWorkStatus(String workId) throws Exception {
		String result = "";
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		try {
			String query = "select * from rws_asset_mast_tbl where asset_code =? ";
			prpStmt = connection.prepareStatement(query);
			prpStmt.setString(1, workId);
			rs = prpStmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("asset_code");
			}

		} catch (Exception e) {
			Debug.println("Ther exception in getWorkStatus of rws_works_workdao= " + e);
		} finally {
			try {
				if (prpStmt != null)
					prpStmt.close();
				if (rs != null)
					rs.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	public String getDivisionOfficeName(String hoc, String coc, String divcode) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = connection.prepareStatement("SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE "
					+ "HEAD_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?' and DIVISION_OFFICE_CODE=? ");
			stmt1.setString(1, hoc);
			stmt1.setString(2, coc);
			stmt1.setString(3, divcode);

			rs1 = stmt1.executeQuery();

			if (rs1.next())
				name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther exception in getDivisionOfficeName of rws_works_workdao= " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
    
	public String getSubDivisionOfficeName(String hoc, String coc, String divcode, String subdivcode) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {

			String qry = "SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE "
					+ "HEAD_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=? "
					+ "AND SUBDIVISION_OFFICE_CODE=? ";

			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, hoc);
			stmt1.setString(2, coc);
			stmt1.setString(3, divcode);
			stmt1.setString(4, subdivcode);
			rs1 = stmt1.executeQuery();

			if (rs1.next())
				name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception in getSubDivisionOfficeName of rws_works_WorkDAo= " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
    
       
	public String getLeadHab(String workId) throws Exception {
		String hab = "";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			connection = RwsOffices.getConn();

			String qry = "select lead_habitation from rws_work_admn_tbl where work_id=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, workId);
			rs1 = stmt1.executeQuery();
			if (rs1.next())
				if (rs1.getString(1) != null && !rs1.getString(1).equals(""))
					hab = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther exception in  getLeadHab of rws_works_workDAO= " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return hab;
	}
	
	public String getMainSchemeWork(String workId) throws Exception {
		String hab = "";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			connection = RwsOffices.getConn();

			String qry = "select aug_workid from rws_work_admn_tbl where work_id=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, workId);
			rs1 = stmt1.executeQuery();
			if (rs1.next())
				if (rs1.getString(1) != null && !rs1.getString(1).equals(""))
					hab = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in get getMainSchemeWork  of rws_works_WorkDAO = " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return hab;
	}
	
    public String checkMainSchemeWorkConvertedOrNot(String workId) throws Exception
    {
    	String hab = "";
    	Statement stmt1 = null,stmt2 = null;
		ResultSet rs1 = null,rs2 = null;
		try {
				connection = RwsOffices.getConn();
				stmt1 = connection.createStatement();
				String qry = "select * from rws_asset_mast_tbl where asset_code = '"+workId+"'";
				Debug.println("checkMainSchemeWorkConvertedOrNot qry:"+qry);
				rs1 = stmt1.executeQuery(qry);
				if(rs1.next())
					if(rs1.getString(1)!=null && !rs1.getString(1).equals(""))hab = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in get checkMainSchemeWorkConvertedOrNot =" + e);
		} finally {
			try{
				if(rs1!=null)rs1.close();
				if(stmt1!=null)stmt1.close();
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return hab;
    }
    public String getHabName(String habcode) throws Exception {

		String hab = "";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {

			String qry = "select panch_name from rws_panchayat_raj_tbl where panch_code='" + habcode + "'";
			qry = "select mname,panch_name from rws_complete_hab_view where panch_code=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, habcode);
			rs1 = stmt1.executeQuery();
			if (rs1.next())
				hab = rs1.getString(1) + "@" + rs1.getString(2);
		} catch (Exception e) {
			Debug.println("Exception in  getHabName=" + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return hab;

	}
    
    public String getMandalName(String habcode) throws Exception
    {

    	String hab = "";
    	Statement stmt1 = null;
		ResultSet rs1 = null;
		try {
				stmt1 = connection.createStatement();
				String qry = "select mname from rws_mandal_tbl where dcode='"+habcode.substring(0,2)+"' and mcode='"+habcode.substring(5,7)+"'";
				Debug.println("lead mandal name qry:"+qry);
				rs1 = stmt1.executeQuery(qry);
				if(rs1.next())
					hab = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in get sub hab name=" + e);
		} finally {
			try{
				if(rs1!=null)rs1.close();
				if(stmt1!=null)stmt1.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return hab;
    
	}
    public String getWorkName(String workId) throws Exception
    {

    	String hab = "";
    	PreparedStatement ps = null;
		ResultSet rs1 = null;
		try {
				String qry = "select work_name from rws_work_admn_tbl where work_id=?";
				ps=connection.prepareStatement(qry);
				ps.setString(1, workId);
				rs1 = ps.executeQuery();
				if(rs1.next())
					hab = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther Exception in getWorkName=" + e);
		} finally {
			try{
				if(rs1!=null)rs1.close();
				if(ps!=null)ps.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return hab;
    
	}
    public ArrayList getWorkDetails(String workId) throws Exception
    {
       Debug.println("get workdaetails$$$$$$$$$$$$$$$$$");
    	DecimalFormat ndf = new DecimalFormat("####.00");
        ArrayList details = new ArrayList();
    	String hab = "";
    	Statement stmt1 = null,stmt2 = null,stmt3 = null;
		ResultSet rs1 = null,rs2 = null,rs3 = null;
		 double expupto1 = 0,expdur1 = 0,preyearexp1 = 0;
		try {
			Debug.println("get workdaetails$$$$$$$$$$$$$$$$$ 111111111111111111111");
				stmt1 = connection.createStatement();
				String qry = "select to_char(grounding_date,'yyyy'),to_char(date_of_comm,'dd/mm/yyyy') from rws_work_commencement_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and a.work_id='"+workId+"'";
				Debug.println("grounding date qry:"+qry);
				rs1 = stmt1.executeQuery(qry);
				if(rs1.next())
				{
					details.add(0,rs1.getString(1));
					details.add(1,rs1.getString(2)); 
				}
				stmt2 = connection.createStatement();
				qry = "select sum(expenditure_upto_the_pre_year+VALUE_OF_WORK_NOT_PAID)  from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"+workId+"'";
				Debug.println("expenditure qry:"+qry);
				rs2 = stmt2.executeQuery(qry);
				if(rs2.next()){preyearexp1=rs2.getFloat(1);}
				stmt3 = connection.createStatement();
				qry = "select sum(case when year<>'2009-10' then total else 0 end),sum(case when year='2009-10' then total else 0 end) from rws_exp_view where work_id='"+workId+"'";
				Debug.println("exp1 qry:"+qry);
				rs3 = stmt3.executeQuery(qry);
				if(rs3.next()){preyearexp1+=rs3.getFloat(1);expdur1=rs3.getFloat(2);}
				details.add(2,ndf.format((WorksData1.round((preyearexp1+expdur1),2))));
		} catch (Exception e) {
			Debug.println("Ther error in get sub hab name=" + e);
		} finally {
			try{
				if(rs1!=null)rs1.close();
				if(stmt1!=null)stmt1.close();
				if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
				if(rs3!=null)rs3.close();
				if(stmt3!=null)stmt3.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return details;
    
	} 
    public ArrayList getWorkExp(String workId) throws Exception {
		DecimalFormat ndf = new DecimalFormat("####.00");
		ArrayList details = new ArrayList();
		String hab = "";
		PreparedStatement stmt1 = null, stmt2 = null, stmt3 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null;
		double expupto1 = 0, paorel = 0, bankrel = 0;
		try {

			String qry = "select to_char(grounding_date,'yyyy'),to_char(date_of_comm,'dd/mm/yyyy') from rws_work_commencement_tbl a,"
					+ "rws_work_completion_tbl b where a.work_id=b.work_id and a.work_id=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, workId);
			rs1 = stmt1.executeQuery();
			if (rs1.next()) {
				details.add(0, rs1.getString(1));
				details.add(1, rs1.getString(2));
			}

			qry = "select sum(BILL_AMOUNT_CENTRAL) from  rws_bill_bank_bridge_det_tbl where work_id=? ";
			stmt2 = connection.prepareStatement(qry);
			stmt2.setString(1, workId);
			rs2 = stmt2.executeQuery();
			if (rs2.next()) {
				bankrel = rs2.getFloat(1);
			}

			qry = "select sum(BILL_AMOUT_STATE) from  rws_bill_PAO_bridge_det_tbl where work_id=? ";
			stmt3 = connection.prepareStatement(qry);
			stmt3.setString(1, workId);
			rs3 = stmt3.executeQuery();
			if (rs3.next()) {
				paorel = rs3.getFloat(1);
			}
			details.add(2, ndf.format((WorksData1.round((bankrel + paorel) / 100000, 2))));
		} catch (Exception e) {
			Debug.println("exception in getWorkExp of rws_works_WorksDAO= " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (rs2 != null)
					rs2.close();
				if (stmt2 != null)
					stmt2.close();
				if (rs3 != null)
					rs3.close();
				if (stmt3 != null)
					stmt3.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return details;

	}
    public ArrayList getAssetBenDetails(String asset_code, String aCode) throws Exception {
		ArrayList details = new ArrayList();
		String hab = "";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		int habcount = 0, habpop = 0;
		double totPop1 = 0.0;
		ArrayList panchRajs = new ArrayList();
		try {

			if (aCode != null
					&& (aCode.equals("01") || aCode.equals("02") || aCode.equals("03") || aCode.equals("09"))) {

				String qry = "select a.hab_code,b.CENSUS_PLAIN_POPU+b.CENSUS_SC_POPU+b.CENSUS_ST_POPU,c.panch_name from RWS_asset_HAB_TBL a,rws_habitation_directory_tbl b,rws_panchayat_raj_tbl c where asset_code='"
						+ asset_code
						+ "' and a.hab_code=b.hab_code and b.hab_code=c.panch_code and a.hab_code=c.panch_code order by 2 desc";

				qry = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name, "
						+ "CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+FLOAT_POP as tot from rws_district_tbl d,"
						+ "rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,"
						+ "RWS_asset_HAB_TBL wc where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and "
						+ "p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and "
						+ "substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and "
						+ "wc.hab_code=hd.hab_code and wc.asset_code=? ";
				stmt1 = connection.prepareStatement(qry);
				stmt1.setString(1, asset_code);
				rs1 = stmt1.executeQuery();
				while (rs1.next()) {
					habcount++;
					habpop += rs1.getInt("TOT");
					PanchRaj panchRaj = new PanchRaj();
					panchRaj.setMandalName(rs1.getString("DNAME"));
					panchRaj.setHabCode(rs1.getString("PANCH_CODE"));
					panchRaj.setHabName(rs1.getString("PANCH_NAME"));
					panchRaj.setHabPop(rs1.getString("TOT"));
					panchRajs.add(panchRaj);
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				totPop1 = (habpop * Math.pow(1.02, Integer.parseInt(sdf.format(new java.util.Date())) - 2001));
				details.add(0, "" + habcount);
				details.add(1, "" + (int) Math.round(Math.ceil(totPop1)));
				details.add(2, panchRajs);
			} else {
				String qry = "select POPU_BENEFITED  from RWS_asset_mast_TBL wc where wc.asset_code=? ";
				stmt1 = connection.prepareStatement(qry);
				stmt1.setString(1, asset_code);
				rs1 = stmt1.executeQuery();
				if (rs1.next())
					totPop1 = rs1.getInt(1);
				else
					totPop1 = 0;
				details.add(0, "1");
				details.add(1, "" + (int) Math.round(Math.ceil(totPop1)));
				details.add(2, panchRajs);
			}

		} catch (Exception e) {
			Debug.println("Exception in get sub DivisionOfficeName of rws_works_WorkDAO= " + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return details;
	}

    public String getCompInfoAndYieldInfo(String assetCode, String assetTypeCode) throws Exception {
		ArrayList data = null;
		Connection connn = RwsOffices.getConn();
		StringBuffer buffer = new StringBuffer();
		ResultSet rs = null;
		PreparedStatement ps = null;
		String codeSeries = "";
		if (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")
				|| assetTypeCode.equals("09") || assetTypeCode.equals("10")) {
			if (assetTypeCode.equals("01"))
				codeSeries = "6%";
			else if (assetTypeCode.equals("02"))
				codeSeries = "4%";
			else if (assetTypeCode.equals("03"))
				codeSeries = "8%";
			else if (assetTypeCode.equals("09"))
				codeSeries = "45%";
			else if (assetTypeCode.equals("10"))
				codeSeries = "95%";
			try {
				rs = null;
				ps = null;
				String query = "select (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL"
						+ " subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=? and "
						+ "subCompTbl. SOURCE_TYPE_CODE ='1')a,(select count(*) FROM RWS_ASSET_MAST_TBL M, "
						+ "RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE "
						+ "AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and"
						+ " SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? and subCompTbl. SOURCE_TYPE_CODE ='2')b,"
						+ "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_RW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND"
						+ " SUBSTR (S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)c,(select count(*) FROM"
						+ " RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SS_SC_PARAM_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? "
						+ "and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ? and "
						+ "SUBCOMPTBL.ASSET_CODE=?)d,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? and substr(subCompTbl.WTPSC_CODE,20,2)='SS') e, (select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? "
						+ "and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? and substr(subCompTbl.WTPSC_CODE,20,2)='RS')f,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUMP_M_SC_PARAM_TBL subCompTbl "
						+ "WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND"
						+ " M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)g,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_FP_BRIDGE_PARAM_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND"
						+ " M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)h,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPHOUSE_PARAM_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=?"
						+ " and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and "
						+ "SUBCOMPTBL.ASSET_CODE=?)i,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_WATCHMAN_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=?)j,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_CW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=?)k,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and"
						+ " SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? and substr(subCompTbl.WTPSC_CODE,20,2)='MS')l,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=? and "
						+ "substr(subCompTbl.WTPSC_CODE,20,2)='RP')m,(select count(*) FROM RWS_ASSET_MAST_TBL M,"
						+ " RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPINGMAIN_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)n,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GRAVITYMAIN_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)o,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_DISTRI_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND"
						+ " SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)p,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)q,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHBR_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND"
						+ " SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)r,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND"
						+ " M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)s,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLBR_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)t,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_BPT_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)u,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CIS_SC_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND"
						+ " SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)v,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OTHERS_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)w,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CHLORINATION_TBL subCompTbl WHERE"
						+ " M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)x,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OANDM_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND"
						+ " M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)y,(select count(*) FROM "
						+ "RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUBCOMP_PARAM_TBL subCompTbl WHERE "
						+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND "
						+ "M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
						+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=?)z from dual";

				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				ps.setString(4, assetTypeCode);
				ps.setString(5, codeSeries);
				ps.setString(6, assetCode);
				ps.setString(7, assetTypeCode);
				ps.setString(8, codeSeries);
				ps.setString(9, assetCode);
				ps.setString(10, assetTypeCode);
				ps.setString(11, codeSeries);
				ps.setString(12, assetCode);
				ps.setString(13, assetTypeCode);
				ps.setString(14, codeSeries);
				ps.setString(15, assetCode);
				ps.setString(16, assetTypeCode);
				ps.setString(17, codeSeries);
				ps.setString(18, assetCode);
				ps.setString(19, assetTypeCode);
				ps.setString(20, codeSeries);
				ps.setString(21, assetCode);
				ps.setString(22, assetTypeCode);
				ps.setString(23, codeSeries);
				ps.setString(24, assetCode);
				ps.setString(25, assetTypeCode);
				ps.setString(26, codeSeries);
				ps.setString(27, assetCode);
				ps.setString(28, assetTypeCode);
				ps.setString(29, codeSeries);
				ps.setString(30, assetCode);
				ps.setString(31, assetTypeCode);
				ps.setString(32, codeSeries);
				ps.setString(33, assetCode);
				ps.setString(34, assetTypeCode);
				ps.setString(35, codeSeries);
				ps.setString(36, assetCode);
				ps.setString(37, assetTypeCode);
				ps.setString(38, codeSeries);
				ps.setString(39, assetCode);
				ps.setString(40, assetTypeCode);
				ps.setString(41, codeSeries);
				ps.setString(42, assetCode);
				ps.setString(43, assetTypeCode);
				ps.setString(44, codeSeries);
				ps.setString(45, assetCode);
				ps.setString(46, assetTypeCode);
				ps.setString(47, codeSeries);
				ps.setString(48, assetCode);
				ps.setString(49, assetTypeCode);
				ps.setString(50, codeSeries);
				ps.setString(51, assetCode);
				ps.setString(52, assetTypeCode);
				ps.setString(53, codeSeries);
				ps.setString(54, assetCode);
				ps.setString(55, assetTypeCode);
				ps.setString(56, codeSeries);
				ps.setString(57, assetCode);
				ps.setString(58, assetTypeCode);
				ps.setString(59, codeSeries);
				ps.setString(60, assetCode);
				ps.setString(61, assetTypeCode);
				ps.setString(62, codeSeries);
				ps.setString(63, assetCode);
				ps.setString(64, assetTypeCode);
				ps.setString(65, codeSeries);
				ps.setString(66, assetCode);
				ps.setString(67, assetTypeCode);
				ps.setString(68, codeSeries);
				ps.setString(69, assetCode);
				ps.setString(70, assetTypeCode);
				ps.setString(71, codeSeries);
				ps.setString(72, assetCode);
				ps.setString(73, assetTypeCode);
				ps.setString(74, codeSeries);
				ps.setString(75, assetCode);
				ps.setString(76, assetTypeCode);
				ps.setString(77, codeSeries);
				ps.setString(78, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					for (int i = 1; i <= 26; i++) {
						buffer.append(rs.getInt(i) + "/");
					}
				}
			} catch (Exception e) {
				Debug.println("exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		} else if (assetTypeCode.equals("04")) {
			codeSeries = "0%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, rws_Asset_scheme_tbl S,rws_hp_subcomp_param_tbl subCompTbl"
						+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=?"
						+ " and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ? and SUBCOMPTBL.ASSET_CODE=? ";
				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(rs.getInt(1) + "/");
				}
			} catch (Exception e) {
				Debug.println("Exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		} else if (assetTypeCode.equals("06")) {
			codeSeries = "5%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ? "
						+ "and SUBCOMPTBL.ASSET_CODE=? ";
				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(rs.getInt(1) + "/");
				}
			} catch (Exception e) {
				Debug.println("Exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		} else if (assetTypeCode.equals("07")) {
			codeSeries = "7%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? ";
				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(rs.getInt(1) + "/");
				}
			} catch (Exception e) {
				Debug.println("Exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		} else if (assetTypeCode.equals("08")) {
			codeSeries = "9%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_AST_OTHERS_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=?"
						+ " and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? ";
				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(rs.getInt(1) + "/");
				}
			} catch (Exception e) {
				Debug.println("Exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		}

		else if (assetTypeCode.equals("05")) {
			codeSeries = "3%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, rws_asset_scheme_tbl S,"
						+ "RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE ?"
						+ " and SUBCOMPTBL.ASSET_CODE=? ";
				ps = connn.prepareStatement(query);
				ps.setString(1, assetTypeCode);
				ps.setString(2, codeSeries);
				ps.setString(3, assetCode);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(rs.getInt(1) + "/");
				}
			} catch (Exception e) {
				Debug.println("Exception in getCompInfoAndYieldInfo " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			}
		}

		return buffer.toString();
	}
    
    public ArrayList getWorkBenDetails(String workId) throws Exception {
		ArrayList details = new ArrayList();
		String hab = "";
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		int habcount = 0, habpop = 0;
		double totPop1 = 0.0;
		ArrayList panchRajs = new ArrayList();
		try {

			
			String qry = "select distinct dcode,dname,mcode,mname,pcode,pname,vcode,vname,panch_code,panch_name,"
					+ "hd.CENSUS_PLAIN_POPU+hd.CENSUS_SC_POPU+hd.CENSUS_ST_POPU+hd.FLOAT_POP as tot from"
					+ " rws_complete_hab_view c,RWS_WORK_COMP_HAB_LNK_TBL wc,rws_habitation_directory_tbl hd where "
					+ "hd.hab_code=wc.hab_code and hd.hab_code=c.panch_code and wc.hab_code=c.panch_code and wc.work_id=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, workId);
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				habcount++;
				habpop += rs1.getInt("TOT");
				PanchRaj panchRaj = new PanchRaj();
				panchRaj.setDname(rs1.getString("dname"));
				panchRaj.setMandalName(rs1.getString("mname"));
				panchRaj.setPName(rs1.getString("pname"));
				panchRaj.setVname(rs1.getString("vname"));
				panchRaj.setHabCode(rs1.getString("PANCH_CODE"));
				panchRaj.setHabName(rs1.getString("PANCH_NAME"));
				panchRaj.setHabPop(rs1.getString("TOT"));
				panchRajs.add(panchRaj);
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			totPop1 = (habpop * Math.pow(1.02, Integer.parseInt(sdf.format(new java.util.Date())) - 2001));
			details.add(0, "" + habcount);
			details.add(1, "" + (int) Math.round(Math.ceil(totPop1)));
			details.add(2, panchRajs);
		} catch (Exception e) {
			Debug.println("Ther exception  in get getWorkBenDetails=" + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return details;
	}
    public ArrayList getNewAssetCode(String ccode,String divcode,String subdivcode,String hab,String typeofassetcode) throws Exception
	{
    	String finalassetCode = "",assetCode = "",pumpCode="",codeSeries="";
    	ArrayList details = new ArrayList();
    	Statement stmt1 = null;
		ResultSet rs1 = null;
		String qry = "";
		try {
			stmt1 = connection.createStatement();
				qry = "select(select max(substr(s.scheme_code,17,3)) from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where  a.asset_code=s.asset_code and a.type_of_asset_code='"+typeofassetcode+"' and a.hab_code='"+hab+"')a,(SELECT MAX(to_number(ASSET_CODE))+1 FROM RWS_ASSET_MAST_TBL where substr (asset_code,7,2)='"+typeofassetcode+"' and substr(hab_code,1,2)='"+hab.substring(0,2)+"' and substr(hab_code,6,2)='"+hab.substring(5,7)+"')b,(select code_series from rws_asset_type_tbl where type_of_asset_code='"+typeofassetcode+"')c from dual";
				rs1 = stmt1.executeQuery(qry);
				Debug.println("lead hab qry:"+qry);
				if(rs1.next())
					{
						if(rs1.getString(1)!=null)pumpCode=""+(Integer.parseInt(rs1.getString(1))+1);
						assetCode = rs1.getString(2);
						codeSeries = rs1.getString(3);
					}
				Debug.println("assetCode:"+assetCode);
				if (assetCode == null) {
					assetCode = "0001";
				} else if (assetCode.length() == 1) {
					assetCode = "000" + assetCode;
				} else if (assetCode.length() == 2) {
					assetCode = "00" + assetCode;
				} else if (assetCode.length() == 3) {
					assetCode = "0" + assetCode;
				}
				
				if (assetCode.length() == 4)
				{
					Debug.println("in if of assetCode.length()==4");
					assetCode = "0000"+ ccode+ typeofassetcode+ hab.substring(5,7)+ assetCode;
				}
				else if(assetCode.length()==9)
				{
					Debug.println("in else of assetCode.length()==4");
					Debug.println("assetcode is "+assetCode);
					assetCode = "00000" + assetCode;
				}
				else
				{
					Debug.println("in else of assetCode.length()==4");
					Debug.println("assetcode is "+assetCode);
					assetCode = "0000" + assetCode;
				}
				
				if(pumpCode.equals(""))
				{
					pumpCode = codeSeries;
				}
				if(pumpCode.length()==1)
					pumpCode="00"+pumpCode;
				else if(pumpCode.length()==2)
					pumpCode="0"+pumpCode;
				details.add(0,pumpCode);
				details.add(1,assetCode);
				
			} catch (Exception e) {
				Debug.println("Ther error in getNewAssetCode=" + e);
			} finally {
				try{
			if(rs1!=null)rs1.close();
			if(stmt1!=null)stmt1.close();
            if(connection!=null)connection.close();
     	   }
     	catch(Exception e)
		{}
		}
    	return details;
	}
    public int addLeadHab(String workId, String habCode) throws Exception {
		int returnValue = 0;
		PreparedStatement stmt1 = null;
		try {

			String qry = "update rws_work_admn_tbl set lead_habitation=? where work_id=? ";
			stmt1 = connection.prepareStatement(qry);
			stmt1.setString(1, habCode);
			stmt1.setString(2, workId);
			returnValue = stmt1.executeUpdate();
		} catch (Exception e) {
			Debug.println("Ther exception in addLeadHab of rws_works_WorkDAO = " + e);
		} finally {
			try {
				if (stmt1 != null)
					stmt1.close();
				if (connection != null)
					connection.close();
			} catch (Exception e) {
			}
		}
		return returnValue;
	}
    public String saveAsset(rws_works_WorkStatus_form rws_works_WorkStatus_form, HttpServletRequest request,
			DataSource ds) throws Exception {

		String message = "";
		try {
			RwsMaster rwsMaster = new RwsMaster();
			ArrayList habs = new ArrayList();

			HttpSession session = request.getSession();
			rwsMaster.setWorkid(rws_works_WorkStatus_form.getWorkId());
			rwsMaster.setCoc(rws_works_WorkStatus_form.getCircleOfficeCode());
			rwsMaster.setDoc(rws_works_WorkStatus_form.getDivisionOfficeCode());
			rwsMaster.setSdoc(rws_works_WorkStatus_form.getSubdivisionOfficeCode());
			rwsMaster.setHabCode(rws_works_WorkStatus_form.getHabCode());
			rwsMaster.setAssetTypeCode(rws_works_WorkStatus_form.getAssetTypeCode());
			rwsMaster.setAssetCode(rws_works_WorkStatus_form.getAssetCode());
			rwsMaster.setAssetName(rws_works_WorkStatus_form.getAssetName());
			rwsMaster.setDateofCreation(rws_works_WorkStatus_form.getDateofCreation());
			rwsMaster.setLocation(rws_works_WorkStatus_form.getLocation());
			rwsMaster.setAssetCost(rws_works_WorkStatus_form.getAssetCost());
			rwsMaster.setStartYear(rws_works_WorkStatus_form.getStartYear());
			rwsMaster.setAssetStatus(rws_works_WorkStatus_form.getAssetStatus());
			rwsMaster.setPumpCode(rws_works_WorkStatus_form.getPumpCode());
			rwsMaster.setTotPopBenfit(Integer.parseInt(rws_works_WorkStatus_form.getTotPopBenfit()));
			rwsMaster.setRemarks(rws_works_WorkStatus_form.getRemarks());
			rwsMaster.setDefunctReasons("");
			habs = (ArrayList) session.getAttribute("tempSelectedHabs");
			PanchRaj panchRaj = new PanchRaj();
			rwsMaster.setCoc(rws_works_WorkStatus_form.getCircleOfficeCode());
			rwsMaster.setDoc(rws_works_WorkStatus_form.getDivisionOfficeCode());
			rwsMaster.setSdoc(rws_works_WorkStatus_form.getSubdivisionOfficeCode());
			message = RwsMasterData.insertAsset(rwsMaster, habs, "Add New Scheme", ds);

		} catch (Exception e) {

			Debug.println("Exception in saveAsset of rws_works_workDAO--  " + e);
		}
		return message;

	}
    public RwsMaster getAssetDetails(String asset_code) throws Exception {
		RwsMasterData rwsMasterData = new RwsMasterData();
		RwsMaster rwsMaster = null;
		String assetTypeCode = "";
		PreparedStatement stmt = null;
		try {
			Connection conn = RwsOffices.getConn();

			String query = "select a.ASSET_CODE,a.ASSET_NAME,a.LOCATION,to_char(a.DATE_CREATION,'dd/mm/yyyy'),a.ASSET_COST,"
					+ "a.START_YEAR,a.END_YEAR,a.asset_status,nvl(a.DEFUNCT_REASON,'') as DEFUNCT_REASON,nvl(a.POPU_BENEFITED,0) "
					+ "as POPU_BENEFITED,type_of_asset_code,hab_code,scheme_code,"
					+ "decode(type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMPS','05','SHALLOW HAND PUMPS','06','OPEN WELLS','07','PONDS','08','OTHERS','09','DIRECT PUMPING')"
					+ "AS NAME_OF_ASSET,division_office_code,subdivision_office_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where "
					+ "a.asset_code=s.asset_code and a.asset_code=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, asset_code);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				rwsMaster = new RwsMaster();
				rwsMaster.setAssetCode(rs.getString(1));
				rwsMaster.setAssetName(rs.getString(2));
				rwsMaster.setLocation(rs.getString(3));
				if (rs.getString(4) != null)
					rwsMaster.setDateofCreation(rs.getString(4));
				rwsMaster.setAssetCost(rs.getString(5));
				rwsMaster.setStartYear(rs.getString(6));
				rwsMaster.setEndYear(rs.getString(7));
				rwsMaster.setAssetStatus(rs.getString(8));
				rwsMaster.setDefunctReasons(rs.getString("DEFUNCT_REASON"));
				rwsMaster.setTotPopBenfit(rs.getInt("POPU_BENEFITED"));
				assetTypeCode = rs.getString("type_of_asset_code");
				rwsMaster.setAssetTypeCode(assetTypeCode);
				rwsMaster.setHabCode(rs.getString("hab_code"));
				rwsMaster.setPumpCode(rs.getString("scheme_code").substring(16, 19));
				rwsMaster.setSchemeCode(rs.getString("scheme_code"));
				rwsMaster.setAssetTypeName(rs.getString("NAME_OF_ASSET"));
				rwsMaster.setDivisionOfficeCode(rs.getString("division_office_code"));
				rwsMaster.setSubdivisionOfficeCode(rs.getString("subdivision_office_code"));
			}
			rs.close();

			if (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")
					|| assetTypeCode.equals("09") || assetTypeCode.equals("10")) {
				try {
					query = "select count(h.hab_code),Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu + d.FLOAT_POP) from "
							+ "rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and "
							+ "h.asset_code= a.asset_code and a.asset_code=? ";
					stmt = conn.prepareStatement(query);
					stmt.setString(1, rwsMaster.getAssetCode());
					rs = stmt.executeQuery();
					if (rs.next()) {
						rwsMaster.setTotHabs(rs.getInt(1));
						rwsMaster.setTotPopBenfit(rs.getInt(2));
					}
				} catch (Exception e) {
					Debug.println("Exception in getAssetDetails" + e);
				}
			} else {
				rwsMaster.setTotHabs(1);
				rwsMaster.setTotPopBenfit(rs.getInt("POPU_BENEFITED"));
			}
		} catch (Exception e) {
			Debug.println("Exception in getAssetDetails of rws_works_WorkDAO-- " + e.getMessage());
		} finally {
			rwsMasterData.closeAll();
		}
		return rwsMaster;
	}

    public boolean checkMandalSubDivision(String hab_code,String divcode,String subdivcode) throws Exception
	{

    	boolean returnValue=false;
    	Statement stmt1 = null;
    	ResultSet rs = null;
		try {
				stmt1 = connection.createStatement();
				String qry = "select * from rws_mandal_subdivision_tbl where circle_office_code='"+hab_code.substring(0,2)+"' and mcode='"+hab_code.substring(5,7)+"'";
				Debug.println("checkMandalSubDivision qry:"+qry);
				rs = stmt1.executeQuery(qry);
				if(rs.next())
				{
					if(rs.getString(2).equals(divcode) && rs.getString(3).equals(subdivcode))
					{
						returnValue = true;
					}
				}
			} catch (Exception e) {
			Debug.println("Ther error in get sub hab name=" + e);
		} finally {
			try{
				if(rs!=null)rs.close();
				if(stmt1!=null)stmt1.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return returnValue;
	
	}
    public ArrayList getWorkPhysicalStatus(String work_id) throws Exception
	{
    	ArrayList status = new ArrayList();
    	PreparedStatement pstmt1 = null,pstmt2=null,pstmt3=null;
    	ResultSet rs = null,rs1 = null,rs2 = null;
    	try {
			
			String qry = "select to_char(grounding_date,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id=?";
			pstmt1 = connection.prepareStatement(qry);
			pstmt1.setString(1,work_id);
			rs = pstmt1.executeQuery();
			if(rs.next())
			{
				String groundDate = rs.getString(1);
				
				String qry1 = "select to_char(date_of_completion,'dd/mm/yyyy'),to_char(date_of_comm,'dd/mm/yyyy'),to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),to_char(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
				pstmt2 = connection.prepareStatement(qry1);
				pstmt2.setString(1,work_id);
				rs1 = pstmt2.executeQuery();
				if(rs1.next())
				{
					
					
					if(rs1.getString(3)!=null && !rs1.getString(3).equals(""))
					{
						status.add(0,"Financially Completed");
						status.add(1,rs1.getString(3));
					}
					else if(rs1.getString(2)!=null && !rs1.getString(2).equals(""))
					{
						status.add(0,"Commissioned");
						status.add(1,rs1.getString(2));
					}
					else if(rs1.getString(1)!=null  && !rs1.getString(1).equals(""))
					{
						status.add(0,"Completed");
						status.add(1,rs1.getString(1));
					}
					else
					{
						status.add(0,"Grounded");
						status.add(1,groundDate);
					}
					if(rs1.getString(4)!=null  && !rs1.getString(4).equals(""))
					{
						status.add(2,"Partial Completed");
						status.add(3,rs1.getString(4));
					}
				}
				else
				{
					status.add(0,"Grounded");
					status.add(1,groundDate);
				}
			}
			else
			{
				status.add(0,"Not Grounded");
				status.add(1,"");
				String qry1 = "select not_ground_remarks from rws_work_admn_tbl where work_id=?";
				pstmt3 = connection.prepareStatement(qry1);
				pstmt3.setString(1,work_id);
				rs2 = pstmt3.executeQuery();
				if(rs2.next())
				{
					if(rs2.getString(1)!=null)status.add(1,rs2.getString(1));	
				}
				else 
				{
					status.add(1,"");
				}
			}
    	} catch (Exception e) {
			Debug.println("Ther error in get sub hab name=" + e);
		} finally {
			try{
				if(rs!=null)rs.close();
				if(rs1!=null)rs1.close();
				if(rs2!=null)rs2.close();
				if(pstmt1!=null)pstmt1.close();
				if(pstmt2!=null)pstmt2.close();
				if(pstmt3!=null)pstmt3.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return status;
	}
    public boolean addNotGroundRemarks(String work_id,String remarks) throws Exception
	{
    	boolean returnValue=false;
    	PreparedStatement ps = null;
		try {
				String qry = "update rws_work_admn_tbl set not_ground_remarks=? where work_id=?";
				ps=connection.prepareStatement(qry);
				ps.setString(1, remarks);
				ps.setString(2, work_id);
				int val= ps.executeUpdate();
				if(val>0)returnValue=true;
			} catch (Exception e) {
			Debug.println("Ther Exception in addNotGroundRemarks=" + e);
		} finally {
			try{
				if(ps!=null)ps.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return returnValue;
	}
    public boolean saveSchoolLinkedToWork(String work_id,String hab_code,String school_code) throws Exception
	{
    	boolean returnValue=false;
    	Statement stmt1 = null,stmt = null;
		try {
				stmt = connection.createStatement();
				String qry = "delete from RWS_SCHOOL_ASSET_LNK_TBL where asset_code = '"+work_id+"'";
				Debug.println("delete in saveSchoolLinkedToWork qry:"+qry);
				stmt.executeUpdate(qry);
				if(stmt!=null)stmt.close();
				stmt1 = connection.createStatement();
				qry = "insert into RWS_SCHOOL_ASSET_LNK_TBL values('"+hab_code+"','"+school_code+"','"+work_id+"')";
				Debug.println("insert saveSchoolLinkedToWork qry:"+qry);
				int val = stmt1.executeUpdate(qry);
				if(val>0)returnValue=true;
			} catch (SQLException e) {
				if(e.getErrorCode()==1)
				{
					
				}
			Debug.println("Ther error in saveSchoolLinkedToWork=" + e);
		} finally {
			try{
				if(stmt1!=null)stmt1.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return returnValue;
	}
    public int saveSchoolLinkedToWork(String work_id,String[] schools) throws Exception
	{
    	int returnValue=0;
    	PreparedStatement ps = null;
		try {
				
				String qry = "delete from RWS_SCHOOL_ASSET_LNK_TBL where asset_code = ?";
				ps = connection.prepareStatement(qry);
				ps.setString(1, work_id);
				ps.executeUpdate();
				if(ps!=null)ps.close();
				for(int i=1;i<schools.length;i++)
       			{
					String hab_code = schools[i].substring(0,16);
					String school_code = schools[i].substring(16,19);
					
					qry = "insert into RWS_SCHOOL_ASSET_LNK_TBL values(?,?,?)";
					ps = connection.prepareStatement(qry);
					ps.setString(1, hab_code);
					ps.setString(2, school_code);
					ps.setString(3, work_id);
					returnValue += ps.executeUpdate();
       			}
			} catch (Exception e) {
				Debug.println("Ther Exception in saveSchoolLinkedToWork=" + e);
		} finally {
			try{
				if(ps!=null)ps.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return returnValue;
	}
    public ArrayList getSchoolDetails(String workId) throws Exception {
    	ArrayList result = new ArrayList();
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
        int i = 0;
    try
  		{
    	String query="select dname,mname,pname,vname,a.hab_code,panch_name,a.school_code,SCHOOL_NAME from RWS_SCHOOL_ASSET_LNK_TBL a,RWS_SCHOOL_MASTER_TBL B, RWS_complete_hab_view C "
    			+ " WHERE A.HAB_CODE||A.school_code = b.hab_code||b.school_code and B.HAB_CODE=C.PANCH_CODE AND ASSET_CODE = ?";
  	             prpStmt = connection.prepareStatement(query);
  	           prpStmt.setString(1, workId);
  	             rs = prpStmt.executeQuery();
  	             ArrayList habs = new ArrayList();
  	             if(rs.isBeforeFirst())
	             {
  	             	result.add(0,"Work Already Linked to School(s) - Click here to View School(s)");
	  	            while(rs.next())
	  	            {
	  	            	rws_works_WorkStatus_bean bean = new rws_works_WorkStatus_bean();
						bean.setCircleName(rs.getString(1));
						bean.setConName(rs.getString(2));
		            	bean.setPanchayat(rs.getString(3));
		            	bean.setVillage(rs.getString(4));
		            	bean.setHabitation(rs.getString(5)+"-"+rs.getString(6));
		            	bean.setSchoolCode(rs.getString(7)+"-"+rs.getString(8));
		            	habs.add(bean);
	  	            }
	  	            result.add(1,habs);
	             }
  	             else
  	             {
  	             	result.add(0,"Not Yet Linked to any School");
  	             	result.add(1,new ArrayList());
  	             	result.add(2,"");
  	             }
  	           if(WorksData1.checkWorkInProjectShelf(workId,connection))
	             	result.add(2,"Y");
	             else
	             	result.add(2,"N");
  	       } 
          catch ( Exception e ) 
  		   {
              Debug.println("Exception in getSchoolDetails:"+e);
          }
          finally
  		   {
          	try{
	           	 if(prpStmt!=null)prpStmt.close();
	           	 if(rs!=null)rs.close();
	             if(connection!=null)connection.close();
          	   }
          	catch(Exception e)
			{
          		Debug.println("Exception in getSchoolDetails:"+e.getMessage());
          	}
  		   }
    	return result;
	
	}
    public String getNotGroundRemarks(String work_id) throws Exception
	{
    	String remarks = "";
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			
			String qry1 = "select not_ground_remarks from rws_work_admn_tbl where work_id=?";
			ps=connection.prepareStatement(qry1);
			ps.setString(1, work_id);
			rs = ps.executeQuery();
			if(rs.next())
				if(rs.getString(1)!=null)remarks=rs.getString(1);
			} catch (Exception e) {
			Debug.println("Ther Exception in getNotGroundRemarks=" + e);
		} finally {
			try{
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
    	return remarks;
	}
    public rws_works_WorkStatus_form  getAdminAndRevisedDetails(String work_Id) throws Exception
	{
    	
    	ResultSet rs=null;
        PreparedStatement prpStmt = null;

        	String code=work_Id.substring(6,8);
        	    	rws_works_WorkStatus_form bean=null;
        	        try
        			{
        	    	        String sqlQuery = " select ad.SANCTION_AMOUNT ,to_char(ad.ADMIN_DATE ,'dd/mm/yyyy')ADMIN_DATE ";
        		        if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14")))
        				{
        		        	sqlQuery += ",ad.NO_OF_HABS as admin_NO_OF_HABS";
        				}
        				else if(code.equals("11"))
        		 			{
        					sqlQuery += ",ad.NO_OF_SCHOOLS as admin_NO_OF_HABS";
        		 			}
        				else if(code.equals("12"))
        	 			{
        					sqlQuery += ",ad.NO_OF_LABS as admin_NO_OF_HABS";
        	 			}else if(code.equals("14"))
        	 			{
        					sqlQuery += ",ad.NO_OF_PIS as admin_NO_OF_HABS";
        	 			}
        	 			else if(code.equals("13"))
        	 			{
        					sqlQuery += ",ad.NO_OF_ANGANWADIS as admin_NO_OF_HABS";
        	 			}
        		        sqlQuery+=	" ,ad.ADMIN_NO,rv.REV_ADMIN_NO ,to_char(rv.REV_ADMIN_DATE,'dd/mm/yyyy')REV_ADMIN_DATE,rv.REV_SANCTION_AMOUNT as REV_SANCTION_AMOUNT ";
        		        		if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14")))
        		    			{
        		        			sqlQuery += ",rv.NO_OF_HABS as REVISED_NO_OF_HABS";
        		    			}
        		    			else if(code.equals("11"))
        		    	 			{
        		    				sqlQuery += ",rv.NO_OF_SCHOOLS as REVISED_NO_OF_HABS";
        		    	 			}
        		    			else if(code.equals("12"))
        		     			{
        		    				sqlQuery += ",rv.NO_OF_LABS as REVISED_NO_OF_HABS";
        		     			}else if(code.equals("14"))
        		     			{
        		    				sqlQuery += ",rv.NO_OF_PIS as REVISED_NO_OF_HABS";
        		     			}
        		     			else if(code.equals("13"))
        		     			{
        		    				sqlQuery += ",rv.NO_OF_ANGANWADIS as REVISED_NO_OF_HABS";
        		     			}
        		        		sqlQuery += ",ad.office_code from rws_work_admn_tbl ad,RWS_REVISED_ADM_SANC_TBL rv where  ad.work_id= rv.work_id(+) and ad.work_id=? ";
        	             prpStmt = connection.prepareStatement(sqlQuery);
        	             prpStmt.setString(1, work_Id);
        	             rs = prpStmt.executeQuery();
            if(rs.next())
            {
                bean=new rws_works_WorkStatus_form();
            	bean.setAdminAmnt(rs.getString("SANCTION_AMOUNT"));
            	bean.setAdminDate(rs.getString("ADMIN_DATE"));
            	bean.setAdminHabsBen(rs.getString("ADMIN_NO_OF_HABS"));
            	bean.setAdminNo(rs.getString("ADMIN_NO"));
            	bean.setRevAdminAmnt(rs.getString("REV_SANCTION_AMOUNT"));
            	bean.setRevAdminDate(rs.getString("REV_ADMIN_DATE"));
            	bean.setRevAdminNo(rs.getString("REV_ADMIN_NO"));
            	bean.setRevAdminHabsBen(rs.getString("REVISED_NO_OF_HABS"));
            	bean.setOfficeCode(rs.getString("office_code"));
            	 
            }
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
        	Debug.println("Exception in getAdminAndRevisedDetails:"+e);
        	return null;
        }
        finally
		{
			if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return bean;
    }
    public ArrayList  getAdminMoreThanOneProg(String work_Id,rws_works_WorkStatus_bean bean) throws Exception
	{
    	
    	ResultSet rs=null;
        PreparedStatement prpStmt = null;

    	ArrayList list=null;
       try
		{
             
	        String sqlQuery = "select programme_name,SUBPROGRAMME_NAME, SANCTION_AMOUNT,ADMIN_NO ,to_char(ADMIN_DATE ,'dd/mm/yyyy') from " +
	        		" RWS_WORK_ADMN_PROG_LNK_TBL ad,rws_programme_tbl p,rws_subProgramme_tbl s " +
	        		" where ad.PROGRAMME_CODE=p.PROGRAMME_CODE and ad.PROGRAMME_CODE =s.PROGRAMME_CODE " +
	        		" and ad.SUB_PROGRAMME_CODE =s.SUBPROGRAMME_CODE and work_id=?";
            prpStmt = connection.prepareStatement(sqlQuery);
            prpStmt.setString(1, work_Id);
            rs = prpStmt.executeQuery();
              list=new ArrayList();
            while(rs.next())
            {
                bean=new rws_works_WorkStatus_bean();
            	bean.setProgName(rs.getString(1));
            	bean.setSubProgName(rs.getString(2));
            	bean.setAdminAmnt(rs.getString(3));
            	bean.setAdminNo(rs.getString(4));
            	bean.setAdminDate(rs.getString(5));
            	list.add(bean);
            }
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
            Debug.println("Exception in getAdminMoreThanOneProg:"+e);
            return null;
        }
        finally
		{
			if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return list;
    }
    public ArrayList  getRevAdminMoreThanOneProg(String work_Id,rws_works_WorkStatus_bean bean) throws Exception
	{
    	
    	ResultSet rs=null;
        PreparedStatement prpStmt = null;

    	ArrayList list=null;
       try
		{
             
	        String sqlQuery = " select programme_name,SUBPROGRAMME_NAME, REV_SANCTION_AMOUNT ,ADMIN_NO ,to_char(ADMIN_DATE,'dd/mm/yyyy')  from " +
	        		" RWS_REVISED_ADM_PROG_LNK_TBL  ad,rws_programme_tbl p,rws_subProgramme_tbl s " +
	        		" where ad.PROGRAMME_CODE=p.PROGRAMME_CODE and ad.PROGRAMME_CODE =s.PROGRAMME_CODE " +
	        		" and ad.SUB_PROGRAMME_CODE =s.SUBPROGRAMME_CODE and work_id=?";
             prpStmt = connection.prepareStatement(sqlQuery);
             prpStmt.setString(1, work_Id);
             rs = prpStmt.executeQuery();
              list=new ArrayList();
            while(rs.next())
            {
                bean=new rws_works_WorkStatus_bean();
            	bean.setProgName(rs.getString(1));
            	bean.setSubProgName(rs.getString(2));
            	bean.setRevAdminAmnt(rs.getString(3));
            	bean.setRevAdminNo(rs.getString(4));
            	bean.setRevAdminDate(rs.getString(5));
            	list.add(bean);
            }
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
            Debug.println("Exception in getRevAdminMoreThanOneProg"+e);
            return null;
        }
        finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return list;
    }
    public ArrayList getAdminHabs(String workId,String tableName)throws Exception
	{
    	
        ResultSet rs=null,rs1 = null;
        PreparedStatement prpStmt = null,prpStmt1 = null;

    	ArrayList habs=null;
    	String code=workId.substring(6,8);
        String sqlQuery="";
       try
		{
       	if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
       	{
	       sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status,HD.ACT_HOUSE_HOLD,HD.ACT_HOUSE_CONN FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, "+tableName+"  HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.work_id =?";
       	}
       	else if(code.equals("12"))
       	{
       		sqlQuery = " SELECT l.LAB_CODE,LAB_NAME,LOCATION from "
				  + " RWS_WATER_QUALITY_LAB_TBL L, "+tableName+"  HL "
				  + " WHERE L.LAB_CODE = HL.LAB_code "
				  + " AND HL.work_id =?";
       		
       	}
    	else if(code.equals("11"))
       	{
       	 Calendar rightNow = Calendar.getInstance();
     	int year = rightNow.get(Calendar.YEAR);
     	
     	if(year <2021){
     		sqlQuery = " select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,pr.panch_name  from "
  				  + " rws_school_master_tbl s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
  				  + " WHERE s.school_code = HL.school_code "
  				  + " and s.hab_code=hl.hab_code  and hl.hab_code=pr.panch_code and s.hab_code=pr.panch_code "
  				  + " AND HL.work_id =?";     		
     		
     	}else{
     		sqlQuery = " select s.SCHOOL_ID,SCH_NAME,HABITATIONNAME ,INSTITUTIONCATEGORY ,pr.panch_name  from "
  				  + " IMIS_SCHOOLS_TBL  s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
  				  + " WHERE s.SCHOOL_ID = HL.school_code "
  				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
  				  + " AND HL.work_id =?";
     		
     	}
       		
       	}	else if(code.equals("14"))
       	{
       		sqlQuery = " select s.PI_ID,s.LOCATION ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
				  + " WHERE s.PI_ID = HL.PI_CODE "
				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
				  + " AND HL.work_id =?";
       	}
       	else if(code.equals("13"))
       	{
       		/*sqlQuery = " select s.PI_ID,s.LOCATION ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
				  + " WHERE s.PI_ID = HL.PI_CODE "
				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
				  + " AND HL.work_id =?";*/
       		
       		sqlQuery = "select s.school_ID,s.sch_name ,institutioncategory ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from  IMIS_ANGANWADIES_TBL s, "+tableName+"  HL,rws_panchayat_raj_tbl pr  WHERE s.school_ID = HL.anganwadi_CODE  and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code  AND HL.work_id =?";
       		
       	}
            prpStmt = connection.prepareStatement(sqlQuery);
            prpStmt.setString(1, workId);
             rs = prpStmt.executeQuery();
              habs=new ArrayList();
              nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
              String hhQry = "";
  			while(rs.next())
  			{rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
  				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
  		       	{
   				rwsLocationBean.setHabCode(rs.getString(1));
  				rwsLocationBean.setHabName(rs.getString(2));
  				rwsLocationBean.setPopulation(rs.getString(3));
  				rwsLocationBean.setStatus(rs.getString(4));
  				
  				hhQry = "select TOTALHOUSEHOLDS,TOTALHOUSECONNECTIONGIVEN,BALANCEFHTCTOBEGIVEN from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(1)+"'";
  				prpStmt1 = connection.prepareStatement(hhQry);
				///prpStmt1.setString(1, rs.getString(2));
				rs1 = prpStmt1.executeQuery();
				while(rs1.next()){
					rwsLocationBean.setHouseHolds(String.valueOf(rs1.getInt(1)));
					rwsLocationBean.setHouseCons(String.valueOf(rs1.getInt(2)));
					rwsLocationBean.setBalHouseConn(String.valueOf(rs1.getInt(3)));
					

				}
  		       	}
  				else if(code.equals("11"))
  				{
  					rwsLocationBean.setSchoolCode(rs.getString(1));
  	  				rwsLocationBean.setSchoolName(rs.getString(2));
  	  				rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setSchoolClasification(rs.getString(4));
  	  				///rwsLocationBean.setNoofStudents(rs.getString(5));
  	  				///rwsLocationBean.setFacilities(rs.getString(6));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  				}
  				else if(code.equals("12"))
  				{
  					rwsLocationBean.setLabCode(rs.getString(1));
  	  				rwsLocationBean.setLabName(rs.getString(2));
  	  				rwsLocationBean.setLocation(rs.getString(3));
  				}else if(code.equals("14"))
  				{
  					rwsLocationBean.setPiCode(rs.getString(1));
  	  				rwsLocationBean.setPiLocation(rs.getString(2));
  	  				//rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setPiCategory(rs.getString(3));
  	  				rwsLocationBean.setPis_no_tap_conn(rs.getString(4));
  	  				//rwsLocationBean.setFacilities(rs.getString(6));
  	  			rwsLocationBean.setHabCode(rs.getString("panch_code"));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  				}
  				else if(code.equals("13"))
  				{
  					//System.out.println("^^^^^^^^^^^^^");
  					rwsLocationBean.setSchoolCode(rs.getString(1));
  	  				rwsLocationBean.setSchoolName(rs.getString(2));
  	  				//rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setSchoolClasification(rs.getString(3));
  	  				rwsLocationBean.setNoofStudents(rs.getString(4));
  	  				//rwsLocationBean.setFacilities(rs.getString(6));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  	  			    rwsLocationBean.setHabCode(rs.getString(6));
  				}
  				habs.add(rwsLocationBean);
  			}
  			if(rs1 != null) rs1.close();
  			if(prpStmt1 != null) prpStmt1.close();
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            //e.printStackTrace();
            return null;
        }
        catch ( Exception e ) 
		{
            Debug.println("Exception in getAdminHabs:"+e);
            return null;
        }
        finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return habs;
     
     
	}
    public String getTsAccordedBy(String amount)throws Exception
	{
    	
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

    	 
    	String accordedBy =null;
       try
		{
             
	        String sqlQuery = " select t.office,d.designation_acr,t.cost_lower_limit," +
	        		"t.cost_upper_limit from rws_est_ts_work_value_tbl t,rws_designation_tbl d" +
	        		" where d.designation_code=t.designation_code and" +
	        		" "+amount+"<=COST_UPPER_LIMIT and "+amount+">=COST_LOWER_LIMIT";

	        prpStmt = connection.prepareStatement(sqlQuery);
            rs = prpStmt.executeQuery();
              
              nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
  			if(rs.next())
  			{
  				accordedBy=rs.getString(2);
  			}
  			else
  			{
  				accordedBy="CE RWS";
  			}
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            e.printStackTrace();
            return null;
        }
        catch ( Exception e ) 
		{
            e.printStackTrace();
            return null;
        }
        finally
		{
          if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return accordedBy;
     
	}
    public ArrayList getAdminSanctionedHabs(String workId )throws Exception
	{
    	
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
        	String code= workId.substring(6,8);
       	    	ArrayList habs=null;
       	    	String sqlQuery="";
       	       try
       			{
       	             if(!(code.equals("11")||code.equals("12")))
       	             {
       	             	sqlQuery= " SELECT distinct HAB_CODE FROM RWS_ADMN_HAB_LNK_TBL  WHERE WORK_ID=?";
       	             }
       	             else if(code.equals("11"))
       	             {
       	             	sqlQuery= " SELECT distinct HAB_CODE FROM RWS_work_school_LNK_TBL  WHERE WORK_ID=?";
       	             }
       	             else if(code.equals("12"))
       	             {
       	             	sqlQuery= " SELECT distinct lab_CODE FROM RWS_work_lab_LNK_TBL  WHERE WORK_ID=?";
       	             }
       	            prpStmt = connection.prepareStatement(sqlQuery);
       	            prpStmt.setString(1, workId);
       	            rs = prpStmt.executeQuery();
       	              habs=new ArrayList();
  			while(rs.next())
  			{
  				habs.add(rs.getString("HAB_CODE")); 
  			}
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
           Debug.println("Exception in getAdminSanctionedHabs:"+e);
            return null;
        }
        finally
		{
        	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return habs;
     
	}

    public ArrayList getTotHabs(String workId,ArrayList selHabCodes)throws Exception
	{
    	
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

       ArrayList habs=null;
       try
		{
	        String sqlQuery =  " SELECT  distinct P.panch_code, P.panch_name, "
				  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
				  + " H.coverage_status,con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,m.mname  FROM rws_panchayat_raj_tbl P,rws_constituency_tbl con,rws_mandal_tbl m, "
				  + " rws_habitation_directory_tbl H " 
				  +	" WHERE P.panch_code = H.hab_code AND    substr(h.hab_code,3,3)=con.CONSTITUENCY_CODE " +
				  		"and con.CONSTITUENCY_TYPE ='A' and"  
				  + " m.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and"
				  + " H.circle_office_code = ? order by con.CONSTITUENCY_NAME,m.mname,p.panch_name asc";
            prpStmt = connection.prepareStatement(sqlQuery);
            prpStmt.setString(1,  workId.substring(4,6));
            rs = prpStmt.executeQuery();
              habs=new ArrayList();
              nic.watersoft.commons.RwsLocationBean rwsLocation = null; 
  			while(rs.next())
  			{
  				rwsLocation = new nic.watersoft.commons.RwsLocationBean();
				
				for (int i=0;i<selHabCodes.size();i++)
				{
					try
					{
					 
						if(((String) selHabCodes.get(i))!=null &&((String) selHabCodes.get(i)).equals(rs.getString(1)))
						{
							rwsLocation.setHabMatch("checked");
				 
						}
			 		
					}catch(Exception e){
						Debug.println("Exception in getTotHabs:"+e);
					}
				}
			 	rwsLocation.setHabCode(rs.getString(1));
				rwsLocation.setHabName(rs.getString(2));
				rwsLocation.setPopulation(rs.getString(3));
				rwsLocation.setStatus(rs.getString(4));
				rwsLocation.setConstituencyCode(rs.getString(5)) ;
				rwsLocation.setConstituencyName(rs.getString(6)) ;
			 	rwsLocation.setMandalName(rs.getString(7)) ;
			 	habs.add(rwsLocation);
  			}
            if(rs!=null)rs.close();

        } 
        catch ( SQLException e ) 
		{
            System.err.println("SQL Exception occured while accessing the table" );
            return null;
        }
        catch ( Exception e ) 
		{
        	Debug.println("Exception in getTotHabs:"+e);
            return null;
        }
        finally
		{
        	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
        return habs;
	}
    public ArrayList getHabsInMandals(String workId,ArrayList selHabCodes,String[] mcodes)throws Exception
	{
    	
    	ArrayList habs=new ArrayList();
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

        try
 		{
             
            for(int j=0;j<mcodes.length;j++)
    		{
    			if(mcodes[j]!=null)
    			{
 	         String sqlQuery =  "";
  	        sqlQuery = "select distinct h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status,m.mname,CONSTITUENCY_NAME "
  	        		+ " from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,RWS_CONSTITUENCY_TBL c "
  	        		+ " where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode "
  	        		+ " and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? and c.dcode=d.dcode and c.mcode=m.mcode order by m.mname,h.panch_name asc";
             prpStmt = connection.prepareStatement(sqlQuery);
             prpStmt.setString(1, workId.substring(4,6));
             prpStmt.setString(2, mcodes[j]);
             rs = prpStmt.executeQuery();
               
               nic.watersoft.commons.RwsLocationBean rwsLocation = null; 
	   			while(rs.next())
	   			{
	   				rwsLocation = new nic.watersoft.commons.RwsLocationBean();
	 				
	 				if(selHabCodes!=null)
	 				{
		 				for (int i=0;i<selHabCodes.size();i++)
		 				{
		 					try
		 					{
		 					 
		 						if(((String) selHabCodes.get(i))!=null &&((String) selHabCodes.get(i)).equals(rs.getString(1)))
		 						{
		 							rwsLocation.setHabMatch("checked");
		 				 
		 						}
		 			 		
		 					}catch(Exception e){
		 						Debug.println("Exception in getHabsInMandals:"+e);
		 					}
		 				}
	 				}
	 			 	rwsLocation.setHabCode(rs.getString(1));
	 				rwsLocation.setHabName(rs.getString(2));
	 				rwsLocation.setPopulation(rs.getString(3));
	 				rwsLocation.setStatus(rs.getString(4));
	 				rwsLocation.setConstituencyName(rs.getString(6)) ;
	 			 	rwsLocation.setMandalName(rs.getString(5)) ;
	 			 	habs.add(rwsLocation);
	   			}
	   			if(rs!=null)rs.close();
    	    }
           } 
 		}
         catch ( SQLException e ) 
 		{
             System.err.println("SQL Exception occured while accessing the table" );
             return null;
         }
         catch ( Exception e ) 
 		{
            Debug.println("Exception in getHabsInMandals:"+e);
             return null;
         }
         finally
 		{
        	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
 		}
         return habs;
    	
	}
    public ArrayList getHabsDetails(String workId)throws Exception
	{
    	
     ArrayList list=null;
     ResultSet rs=null;
    PreparedStatement prpStmt = null;
     String code=workId.substring(6,8);
System.out.println("code::::::::"+code);
String sqlQuery ="";
      try
		{
      	  //System.out.println("Trying to get the hab details from seesion list");
      	if(!(code.equals("11")||code.equals("12")))
      	{
      		sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, rws_admn_hab_lnk_tbl HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.work_id ='" +  workId + "'";
      	}
         else if(code.equals("11"))
      	{
      		sqlQuery = " select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL "
				  + " WHERE s.school_code = HL.school_code "
				  + " and s.hab_code=hl.hab_code  "
				  + " and work_id='"+workId+"'";
      	}
      	else if(code.equals("12"))
      	{
      		  sqlQuery = " SELECT distinct l.LAB_CODE,LAB_NAME,LOCATION from "
				  + " RWS_WATER_QUALITY_LAB_TBL L, rws_work_lab_lnk_tbl HL "
				  + " WHERE L.LAB_CODE = HL.LAB_code and hl.work_id='"+workId+"'";
			
            	}
           System.out.println("qqq for getting list of all::"+sqlQuery);
           prpStmt = connection.prepareStatement(sqlQuery);
           nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
           list=new ArrayList();
           rs = prpStmt.executeQuery();
           	while(rs.next())
 			{
 				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
 				if(!(code.equals("11")||code.equals("12")))
 		      	{
 					rwsLocationBean.setHabCode(rs.getString(1));
 	 				rwsLocationBean.setHabName(rs.getString(2));
 	 				rwsLocationBean.setPopulation(rs.getString(3));
 	 				rwsLocationBean.setStatus(rs.getString(4));
 		      	}
 				else if(code.equals("11"))
 		      	{
 				rwsLocationBean.setSchoolCode(rs.getString(1));
  				rwsLocationBean.setSchoolName(rs.getString(2));
  				rwsLocationBean.setSchoolLocation(rs.getString(3));
  				rwsLocationBean.setSchoolClasification(rs.getString(4));
  				rwsLocationBean.setNoofStudents(rs.getString(5));
  				rwsLocationBean.setFacilities(rs.getString(6));
 		      	}else if(code.equals("12"))
 		      	{
   				rwsLocationBean.setLabCode(rs.getString(1));
				rwsLocationBean.setLabName(rs.getString(2));
				rwsLocationBean.setLocation(rs.getString(3));
 		      	}
 				list.add(rwsLocationBean);
 			}
           if(rs!=null)rs.close();
      	  
           System.out.println("list"+list.size());

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return list;
  	}
    public ArrayList getTsHabsDetails(String workId)throws Exception
	{
    	
     ArrayList list=null;
     ResultSet rs=null,rs1=null;
    PreparedStatement prpStmt = null,prpStmt1=null;
     String code=workId.substring(6,8);
	String sqlQuery ="";
      try
		{
      	if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
      	{
      		sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status,HD.ACT_HOUSE_HOLD,HD.ACT_HOUSE_CONN FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, RWS_EST_NEW_HAB_LNK_TBL HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.work_id =?";
      	}
      	else if(code.equals("11"))
      	{
        	 Calendar rightNow = Calendar.getInstance();
          	int year = rightNow.get(Calendar.YEAR);
          	
          	if(year <2021){
          		sqlQuery = " select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,pr.panch_name  from "
       				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL,rws_panchayat_raj_tbl pr "
       				  + " WHERE s.school_code = HL.school_code "
       				  + " and s.hab_code=hl.hab_code  and hl.hab_code=pr.panch_code and s.hab_code=pr.panch_code "
       				  + " AND HL.work_id =?";
          		
          		
          	}else{
          		sqlQuery = " select s.SCHOOL_ID,SCH_NAME,HABITATIONNAME ,INSTITUTIONCATEGORY ,pr.panch_name  from "
       				  + " IMIS_SCHOOLS_TBL  s, rws_work_school_lnk_tbl  HL,rws_panchayat_raj_tbl pr "
       				  + " WHERE s.SCHOOL_ID = HL.school_code "
       				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
       				  + " AND HL.work_id =?";
        		
          		
          	}
      	}
      	else if(code.equals("12"))
      	{
      		  sqlQuery = " SELECT distinct l.LAB_CODE,LAB_NAME,LOCATION from "
				  + " RWS_WATER_QUALITY_LAB_TBL L, rws_work_lab_lnk_tbl HL "
				  + " WHERE L.LAB_CODE = HL.LAB_code and hl.work_id=?";
			
            	}else if(code.equals("14"))
               	{
               		sqlQuery = " select s.PI_ID,s.LOCATION ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
        				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, rws_work_pi_lnk_tbl  HL,rws_panchayat_raj_tbl pr "
        				  + " WHERE s.PI_ID = HL.PI_CODE "
        				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
        				  + " AND HL.work_id =?";
               	}
              	
            	else if(code.equals("13"))
               	{
               		/*sqlQuery = " select s.PI_ID,s.LOCATION ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
        				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
        				  + " WHERE s.PI_ID = HL.PI_CODE "
        				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
        				  + " AND HL.work_id =?";*/
               		
               		sqlQuery = "select s.school_ID,s.sch_name ,institutioncategory ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from  IMIS_ANGANWADIES_TBL s, rws_work_ANGANWADI_lnk_tbl  HL,rws_panchayat_raj_tbl pr  WHERE s.school_ID = HL.anganwadi_CODE  and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code  AND HL.work_id =?";
               		
               	}
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
           list=new ArrayList();
           rs = prpStmt.executeQuery();
           String hhQry="";
           	while(rs.next())
 			{
 				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
 				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
 		      	{
 					rwsLocationBean.setHabCode(rs.getString(1));
 	 				rwsLocationBean.setHabName(rs.getString(2));
 	 				rwsLocationBean.setPopulation(rs.getString(3));
 	 				rwsLocationBean.setStatus(rs.getString(4));
 	 				hhQry = "select TOTALHOUSEHOLDS,TOTALHOUSECONNECTIONGIVEN,BALANCEFHTCTOBEGIVEN from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(1)+"'";
 	  				//System.out.println("hhqry :"+hhQry);
 	 				prpStmt1 = connection.prepareStatement(hhQry);
 					///prpStmt1.setString(1, rs.getString(2));
 					rs1 = prpStmt1.executeQuery();
 					while(rs1.next()){
 						rwsLocationBean.setHouseHolds(rs1.getString(1));
 						rwsLocationBean.setHouseCons(rs1.getString(2));
 						rwsLocationBean.setBalHouseConn(rs1.getString(3));
 					}
 		      	}
 				else if(code.equals("11"))
 		      	{
 				rwsLocationBean.setSchoolCode(rs.getString(1));
  				rwsLocationBean.setSchoolName(rs.getString(2));
  				rwsLocationBean.setSchoolLocation(rs.getString(3));
  				rwsLocationBean.setSchoolClasification(rs.getString(4));
  				//rwsLocationBean.setNoofStudents(rs.getString(5));
  				//rwsLocationBean.setFacilities(rs.getString(6));
  				rwsLocationBean.setHabName(rs.getString("panch_name"));
 		      	}else if(code.equals("12"))
 		      	{
   				rwsLocationBean.setLabCode(rs.getString(1));
				rwsLocationBean.setLabName(rs.getString(2));
				rwsLocationBean.setLocation(rs.getString(3));
 		      	}else if(code.equals("14"))
  				{
  					rwsLocationBean.setPiCode(rs.getString(1));
  	  				rwsLocationBean.setPiLocation(rs.getString(2));
  	  			//	rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setPiCategory(rs.getString(3));
  	  				rwsLocationBean.setPis_no_tap_conn(rs.getString(4));
  	  				rwsLocationBean.setHabCode(rs.getString("panch_code"));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  				}
 		      	else if(code.equals("13"))
  				{
  					//System.out.println("^^^^^^^^^^^^^");
  					rwsLocationBean.setSchoolCode(rs.getString(1));
  	  				rwsLocationBean.setSchoolName(rs.getString(2));
  	  				//rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setSchoolClasification(rs.getString(3));
  	  				rwsLocationBean.setNoofStudents(rs.getString(4));
  	  				//rwsLocationBean.setFacilities(rs.getString(6));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  	  			    rwsLocationBean.setHabCode(rs.getString(6));
  				}
 				list.add(rwsLocationBean);
 			}
           if(rs!=null)rs.close();
      	  

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getTsHabsDetails"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return list;
  	}
    public ArrayList getCompHabsDetails(String workId)throws Exception
	{
    	
     ArrayList list=null;
     ResultSet rs=null,rs1=null;
     PreparedStatement prpStmt = null,prpStmt1 = null;
     String code=workId.substring(6,8);
	 String sqlQuery ="";
      try
		{
      	if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
      	{
      		sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status,HD.pending_fhtc,HD.ACT_HOUSE_HOLD,HD.ACT_HOUSE_CONN FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, RWS_WORK_COMP_HAB_LNK_TBL HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.work_id =?";
      	}
         else if(code.equals("11"))
      	{
      		sqlQuery = " select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL "
				  + " WHERE s.school_code = HL.school_code "
				  + " and s.hab_code=hl.hab_code  "
				  + " and work_id=?";
      	}
      	else if(code.equals("12"))
      	{
      		  sqlQuery = " SELECT distinct l.LAB_CODE,LAB_NAME,LOCATION from "
				  + " RWS_WATER_QUALITY_LAB_TBL L, rws_work_lab_lnk_tbl HL "
				  + " WHERE L.LAB_CODE = HL.LAB_code and hl.work_id=?";
			
            	}else if(code.equals("13"))
               	{
               		/*sqlQuery = " select s.PI_ID,s.LOCATION ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
        				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, "+tableName+"  HL,rws_panchayat_raj_tbl pr "
        				  + " WHERE s.PI_ID = HL.PI_CODE "
        				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
        				  + " AND HL.work_id =?";*/
               		
               		sqlQuery = "select s.school_ID,s.sch_name ,institutioncategory ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from  IMIS_ANGANWADIES_TBL s, rws_work_ANGANWADI_lnk_tbl  HL,rws_panchayat_raj_tbl pr  WHERE s.school_ID = HL.anganwadi_CODE  and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code  AND HL.work_id =?";
               		
               	}	else if(code.equals("14"))
               	{
               		sqlQuery = " select s.PI_ID,LOCATION,HABITATIONNAME ,CATEGORY ,NOS_TAP_CONNECTION,pr.panch_name,pr.panch_code  from "
          				  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, RWS_WORK_PI_LNK_TBL  HL,rws_panchayat_raj_tbl pr "
          				  + " WHERE s.PI_ID = HL.PI_code "
          				  + " and s.habcode=hl.hab_code and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
          				  + " and work_id=?";
               		
               		
               		
               	}
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
           list=new ArrayList();
           rs = prpStmt.executeQuery();
           String hhQry="";
           	while(rs.next())
 			{
 				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
 				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
 		      	{
 					rwsLocationBean.setHabCode(rs.getString(1));
 	 				rwsLocationBean.setHabName(rs.getString(2));
 	 				rwsLocationBean.setPopulation(rs.getString(3));
 	 				rwsLocationBean.setStatus(rs.getString(4));
 	 				rwsLocationBean.setPendingFHTC(rs.getString(5));
 	 				hhQry = "select TOTALHOUSEHOLDS,TOTALHOUSECONNECTIONGIVEN,BALANCEFHTCTOBEGIVEN from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(1)+"'";
 	  				//System.out.println("hhqry :"+hhQry);
 	 				prpStmt1 = connection.prepareStatement(hhQry);
 					///prpStmt1.setString(1, rs.getString(2));
 					rs1 = prpStmt1.executeQuery();
 					while(rs1.next()){
 						rwsLocationBean.setHouseHolds(rs1.getString(1));
 						rwsLocationBean.setHouseCons(rs1.getString(2));
 						rwsLocationBean.setBalHouseConn(rs1.getString(3));
 					}
 		      	}
 				else if(code.equals("11"))
 		      	{
 				rwsLocationBean.setSchoolCode(rs.getString(1));
  				rwsLocationBean.setSchoolName(rs.getString(2));
  				rwsLocationBean.setSchoolLocation(rs.getString(3));
  				rwsLocationBean.setSchoolClasification(rs.getString(4));
  				rwsLocationBean.setNoofStudents(rs.getString(5));
  				rwsLocationBean.setFacilities(rs.getString(6));
 		      	}else if(code.equals("12"))
 		      	{
   				rwsLocationBean.setLabCode(rs.getString(1));
				rwsLocationBean.setLabName(rs.getString(2));
				rwsLocationBean.setLocation(rs.getString(3));
 		      	}else if(code.equals("13"))
  				{
  					//System.out.println("^^^^^^^^^^^^^");
  					rwsLocationBean.setSchoolCode(rs.getString(1));
  	  				rwsLocationBean.setSchoolName(rs.getString(2));
  	  				//rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setSchoolClasification(rs.getString(3));
  	  				rwsLocationBean.setNoofStudents(rs.getString(4));
  	  				//rwsLocationBean.setFacilities(rs.getString(6));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  	  			    rwsLocationBean.setHabCode(rs.getString(6));
  				}else if(code.equals("14"))
  				{
  					//System.out.println("^^^^^^^^^^^^^");
  					rwsLocationBean.setPiCode(rs.getString(1));
  	  				rwsLocationBean.setPiLocation(rs.getString(2));
  	  				//rwsLocationBean.setSchoolLocation(rs.getString(3));
  	  				rwsLocationBean.setPiCategory(rs.getString(4));
  	  				rwsLocationBean.setPis_no_tap_conn(rs.getString(5));
  	  				//rwsLocationBean.setFacilities(rs.getString(6));
  	  				rwsLocationBean.setHabName(rs.getString("panch_name"));
  	  			    rwsLocationBean.setHabCode(rs.getString(6));
  				}
 				list.add(rwsLocationBean);
 			}
           if(rs!=null)rs.close();
      	  

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getCompHabsDetails:"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return list;
  	}
  
    public ArrayList getHabsDetails(ArrayList habs)throws Exception
	{
    	
     ArrayList list=null;
     ResultSet rs=null;
     PreparedStatement prpStmt = null;

      try
		{
             String sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD  "
				  + " WHERE PR.panch_code = Hd.hab_code and Hd.hab_code =? ";
           prpStmt = connection.prepareStatement(sqlQuery);
           nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
           list=new ArrayList();
           for(int i=0;i<habs.size();i++)
       	  {
           	  prpStmt.setString(1,(String)habs.get(i));
              rs = prpStmt.executeQuery();
           	while(rs.next())
 			{
 				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
 				rwsLocationBean.setHabCode(rs.getString(1));
 				rwsLocationBean.setHabName(rs.getString(2));
 				rwsLocationBean.setPopulation(rs.getString(3));
 				rwsLocationBean.setStatus(rs.getString(4));
 				list.add(rwsLocationBean);
 			}
           if(rs!=null)rs.close();
      	  }

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getHabsDetails:"+e);
           return null;
       }
       finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return list;
  	}
    
    //added by ramesh 
    
    public ArrayList getHabsDetails(String[] habs)throws Exception
	{
    	
    	ArrayList list=null;
     ResultSet rs=null;
     PreparedStatement prpStmt = null;

      try
		{
      	  //System.out.println("Trying to get the hab details from seesion list");
             String sqlQuery = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD  "
				  + " WHERE PR.panch_code = Hd.hab_code and Hd.hab_code =? ";
           //System.out.println(sqlQuery);
           prpStmt = connection.prepareStatement(sqlQuery);
           nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
           list=new ArrayList();
           for(int i=0;i<habs.length;i++)
       	  {
           	  prpStmt.setString(1,habs[i]);
              rs = prpStmt.executeQuery();
           	while(rs.next())
 			{
 				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
 				rwsLocationBean.setHabCode(rs.getString(1));
 				rwsLocationBean.setHabName(rs.getString(2));
 				rwsLocationBean.setPopulation(rs.getString(3));
 				rwsLocationBean.setStatus(rs.getString(4));
 				list.add(rwsLocationBean);
 			}
           if(rs!=null)rs.close();
      	  }
           //System.out.println("list"+list.size());

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return list;
  	}

    public String insertTsDetails(rws_works_WorkStatus_form bean,ArrayList Habs)throws Exception
	{
    	
   	    java.util.Date d=new java.util.Date();
   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
   	    SimpleDateFormat format  = new SimpleDateFormat("yyyy");
   	    String curruntDate=formatter.format(d);
   	    String currentYear=format.format(d);
   	    String status =null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

      try
		{
            
	       String sqlQuery = "INSERT INTO RWS_NEW_EST_TBL(OFFICE_CODE  ,FINANCIAL_YEAR ,SOURCE_CODE ," +
	       		"WORK_ID,TYPE_OF_ASSET_CODE ,TS_GIVEN_BY ,TS_NO ,TS_DATE,TS_AMOUNT " +
	       		",SSR_YEAR ,PREPARED_BY , PREPARED_ON,ts_office,UPDATE_DATE)" +
	       		"values(?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'))  ";

	       connection.setAutoCommit(false);
	       
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1,bean.getOfficeCode());
           prpStmt.setString(2,currentYear);
           prpStmt.setString(3,"");
           prpStmt.setString(4,bean.getWorkId());
           prpStmt.setString(5,(bean.getWorkId()).substring(6,8));
           prpStmt.setString(6,bean.getTsAccBy());
           prpStmt.setString(7,bean.getTsNo());
           prpStmt.setString(8,bean.getTsDate());
           prpStmt.setString(9,bean.getTsAmnt());
           prpStmt.setString(10,bean.getSyr());
           prpStmt.setString(11,bean.getPreparedBy());
           prpStmt.setString(12,curruntDate);
           prpStmt.setString(13,bean.getTsOffice());
           prpStmt.setString(14,curruntDate);
           prpStmt.addBatch();
           prpStmt.executeBatch();
           
           String schemeno=bean.getWorkId().substring(6,8);
           if(schemeno.equals("12") || schemeno.equals("11")|| schemeno.equals("13")|| schemeno.equals("14"))
           {
           }else{
           sqlQuery="INSERT INTO RWS_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values(?,?)";
           PreparedStatement prpStmtNew = connection.prepareStatement(sqlQuery);
           
           for(int i=0;i<Habs.size();i++)
           {
           	if(!Habs.get(i).equals("00000000000000"))
           	{
	           	prpStmtNew.setString(1, bean.getWorkId());
	           	prpStmtNew.setString(2,(String)Habs.get(i));
	           	prpStmtNew.addBatch();
           	}
           }
           prpStmtNew.executeBatch();
           }
           connection.commit();
           status="true";
   
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
    	   Debug.println("Exception in insertTsDetails"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return status;
      	
	}
    public String insertRevTsDetails(rws_works_WorkStatus_bean bean,ArrayList Habs)throws Exception
	{
    	
   	    java.util.Date d=new java.util.Date();
   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    	SimpleDateFormat format  = new SimpleDateFormat("yyyy");
   	    String curruntDate=formatter.format(d);
   	    String currentYear=format.format(d);
   	    String status =null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null,prpStmtNew=null;

      try
		{
            
	       String sqlQuery = "INSERT INTO RWS_NEW_REVISED_EST_TBL(OFFICE_CODE  ,FINANCIAL_YEAR ,SOURCE_CODE ," +
	       		"WORK_ID ,REV_TS_GIVEN_BY  ,REV_TS_NO  ,REV_TS_DATE ,REV_SANCTIONED_AMOUNT , " +
	       		" PREPARED_BY , PREPARED_ON,REV_TS_OFFICE ,SSR_YEAR  )" +
	       		"values(?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,to_date(?,'dd/mm/yyyy'),?,?) ";
	       //System.out.println(sqlQuery);
	       connection.setAutoCommit(false);
	       
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1,bean.getOfficeCode());
           prpStmt.setString(2,currentYear);
           prpStmt.setString(3,"");
           prpStmt.setString(4,bean.getWorkId());
           prpStmt.setString(5,bean.getTsAccBy());
           prpStmt.setString(6,bean.getRevTsNo());
           prpStmt.setString(7,bean.getRevTsDate());
           prpStmt.setString(8,bean.getRevTsAmnt());
           prpStmt.setString(9,bean.getPreparedBy());
           prpStmt.setString(10,curruntDate);
           prpStmt.setString(11,bean.getTsOffice());
           prpStmt.setString(12,bean.getSyr1());
           
           prpStmt.addBatch();
           prpStmt.executeBatch();
           sqlQuery="INSERT INTO RWS_REV_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values(?,?)";
           //System.out.println("query is "+sqlQuery);
           prpStmtNew = connection.prepareStatement(sqlQuery);
           
           for(int i=0;i<Habs.size();i++)
           {
           	   	prpStmtNew.setString(1, bean.getWorkId());
	           	prpStmtNew.setString(2,(String)Habs.get(i));
	           	prpStmtNew.addBatch();
            }
           prpStmtNew.executeBatch();
           connection.commit();
           status="true";
   
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
       		if(prpStmt!=null)prpStmt.close();
       		if(prpStmtNew!=null)prpStmtNew.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return status;
      	
	}
    public String updateTsDetails(rws_works_WorkStatus_form bean,ArrayList Habs)throws Exception
	{
    	
   	    java.util.Date d=new java.util.Date();
   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    	SimpleDateFormat format  = new SimpleDateFormat("yyyy");
   	    String curruntDate=formatter.format(d);
   	    String currentYear=format.format(d);
   	    String status =null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

      try
		{
            
	       String sqlQuery = "UPDATE RWS_NEW_EST_TBL SET OFFICE_CODE=?  ,FINANCIAL_YEAR=? ,SOURCE_CODE =?," +
	       		"TS_NO =?,TS_DATE=to_date(?,'dd/mm/yyyy'),TS_AMOUNT=? " +
	       		",SSR_YEAR=? ,PREPARED_BY=? , PREPARED_ON =to_date(?,'dd/mm/yyyy'),ts_office=?,update_date=to_date(?,'dd/mm/yyyy') WHERE WORK_ID=?" ;
	       		 
	       connection.setAutoCommit(false);
	       
           prpStmt = connection.prepareStatement(sqlQuery);
           
           prpStmt.setString(1,bean.getOfficeCode());
           prpStmt.setString(2,currentYear);
           prpStmt.setString(3,"");
           prpStmt.setString(4,bean.getTsNo());
           prpStmt.setString(5,bean.getTsDate());
           prpStmt.setString(6,bean.getTsAmnt());
           prpStmt.setString(7,bean.getSyr());
           prpStmt.setString(8,bean.getPreparedBy());
           prpStmt.setString(9,curruntDate);
           prpStmt.setString(10,bean.getTsOffice());
           prpStmt.setString(11,curruntDate);
           prpStmt.setString(12,bean.getWorkId());
           
           
           prpStmt.addBatch();
           prpStmt.executeBatch();
           
           java.sql.Statement stmt=connection.createStatement();
           //System.out.println("DELETE FROM RWS_EST_NEW_HAB_LNK_TBL WHERE WORK_id='"+bean.getWorkId()+"'");
           stmt.executeUpdate("DELETE FROM RWS_EST_NEW_HAB_LNK_TBL WHERE WORK_id='"+bean.getWorkId()+"'");
           
           sqlQuery="INSERT INTO RWS_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values(?,?)";
           PreparedStatement prpStmtNew = connection.prepareStatement(sqlQuery);
            for(int i=0;i<Habs.size();i++)
           {
           	if(!Habs.get(i).equals("00000000000000"))
           	{
	           	prpStmtNew.setString(1, bean.getWorkId());
	           	prpStmtNew.setString(2,(String)Habs.get(i));
	           	prpStmtNew.addBatch();
           	}
           }
           prpStmtNew.executeBatch();
           connection.commit();
           status="true";
   
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
       		if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return status;
      	
	}
	public String updateRevTsDetails(rws_works_WorkStatus_bean bean,ArrayList Habs)throws Exception
	{
		
   	    java.util.Date d=new java.util.Date();
   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    	SimpleDateFormat format  = new SimpleDateFormat("yyyy");
   	    String curruntDate=formatter.format(d);
   	    String currentYear=format.format(d);
   	    String status =null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

      try
		{
            
	       String sqlQuery = "UPDATE RWS_NEW_EST_TBL SET OFFICE_CODE=?  ,FINANCIAL_YEAR=? ,SOURCE_CODE =?," +
	       		"TS_NO =?,TS_DATE=to_date(?,'dd/mm/yyyy'),TS_AMOUNT=? " +
	       		",SSR_YEAR=? ,PREPARED_BY=? , PREPARED_ON =to_date(?,'dd/mm/yyyy'),ts_office=? WHERE WORK_ID=?" ;
	       		 
	       //System.out.println(sqlQuery);
	       connection.setAutoCommit(false);
	       
           prpStmt = connection.prepareStatement(sqlQuery);
           
           prpStmt.setString(1,bean.getOfficeCode());
           prpStmt.setString(2,currentYear);
           prpStmt.setString(3,"");
           prpStmt.setString(4,bean.getTsNo());
           prpStmt.setString(5,bean.getTsDate());
           prpStmt.setString(6,bean.getTsAmnt());
           prpStmt.setString(7,bean.getSyr());
           prpStmt.setString(8,bean.getPreparedBy());
           prpStmt.setString(9,curruntDate);
           prpStmt.setString(10,bean.getTsOffice());
           prpStmt.setString(11,bean.getWorkId());
           
           prpStmt.addBatch();
           prpStmt.executeBatch();
           
           java.sql.Statement stmt=connection.createStatement();
           //System.out.println("DELETE FROM RWS_EST_NEW_HAB_LNK_TBL WHERE WORK_id='"+bean.getWorkId()+"'");
           stmt.executeUpdate("DELETE FROM RWS_EST_NEW_HAB_LNK_TBL WHERE WORK_id='"+bean.getWorkId()+"'");
           
           sqlQuery="INSERT INTO RWS_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values(?,?)";
           PreparedStatement prpStmtNew = connection.prepareStatement(sqlQuery);
            for(int i=0;i<Habs.size();i++)
           {
           	if(!Habs.get(i).equals("00000000000000"))
           	{
	           	prpStmtNew.setString(1, bean.getWorkId());
	           	prpStmtNew.setString(2,(String)Habs.get(i));
	           	prpStmtNew.addBatch();
           	}
           }
           prpStmtNew.executeBatch();
           connection.commit();
           status="true";
   
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
       		if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return status;
      	
	}
    public rws_works_WorkStatus_bean getTsDetails(String workId)throws Exception
	{
    	
    	rws_works_WorkStatus_bean bean=null;
        ResultSet rs=null,rs1=null;
        PreparedStatement prpStmt = null,prpStmt1=null;
              try
		{
           
	        String sqlQuery = " select  " +
	       		" TS_GIVEN_BY ,TS_NO ,to_char(TS_DATE,'dd/mm/yyyy'),TS_AMOUNT " +
	       		",SSR_YEAR ,ts_office  from rws_new_est_tbl  where work_id=? ";
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
           
          
           if(rs.next())
           {
            bean=new rws_works_WorkStatus_bean();
           	bean.setTsAccBy(rs.getString(1));
           	bean.setTsNo(rs.getString(2));
           	String tsdd = "";
           	tsdd = rs.getString(3);
           	if(tsdd == null)tsdd = "";
           	bean.setTsDate(tsdd);
         	bean.setTsAmnt(rs.getString(4));
           	bean.setSyr(rs.getString(5));
           	bean.setTsOffice(rs.getString(6));
           }
            
           	
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
        System.err.println("Exception in getTsDetails:"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return bean;
  	}
    
    public rws_works_WorkStatus_bean getContractorDetails(String workId)throws Exception
	{
    	
    	rws_works_WorkStatus_bean bean=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

       try
		{
            
	       String sqlQuery = " select to_char(AGREEMENT_DATE,'dd/mm/yyyy')   from rws_contractor_selection_tbl where work_id=? ";
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
     
           if(rs.next())
           {
	            bean=new rws_works_WorkStatus_bean();
	           	String tsdd = rs.getString(1);
	           	if(tsdd == null)tsdd = "";
	           	bean.setTsDate(tsdd);
           }
            
           	
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
if			(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return bean;
  	}
    public rws_works_WorkStatus_bean getGroundingDetails(String workId)throws Exception
	{
    	
    	rws_works_WorkStatus_bean bean=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;

       try
		{
            
	       String sqlQuery = " select to_char(GROUNDING_DATE,'dd/mm/yyyy')   from rws_work_commencement_tbl where work_id=?";
	       Debug.println(sqlQuery);
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
     
           if(rs.next())
           {
	            bean=new rws_works_WorkStatus_bean();
	           	String tsdd = rs.getString(1);
	           	if(tsdd == null)tsdd = "";
	           	bean.setTsDate(tsdd);
           }
            
           	
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getGroundingDetails:"+e);
           return null;
       }
       finally
		{
if			(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return bean;
  	}
    public ArrayList getTshabs(String workId)throws Exception
	{
    	
 	 ArrayList habs=null;
     ResultSet rs=null;
     PreparedStatement prpStmt = null;
     String code=workId.substring(6,8);
     String sqlQuery ="";

           try
     		{
                 if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
                 {
                 	sqlQuery= " SELECT distinct  HAB_CODE FROM RWS_EST_NEW_HAB_LNK_TBL  WHERE WORK_ID=?" ;
                 }
                 else if(code.equals("11"))
                 {
                 	sqlQuery= " SELECT distinct  HAB_CODE FROM RWS_work_school_LNK_TBL  WHERE WORK_ID=?" ;
                 }
                 else if(code.equals("12"))
                 {
                 	sqlQuery= " SELECT distinct  lab_CODE FROM RWS_work_lab_LNK_TBL  WHERE WORK_ID=?" ;
                 } else if(code.equals("13"))
                 {
                  	sqlQuery= " SELECT distinct  ANGANWADI_CODE FROM RWS_WORK_anganwadi_LNK_TBL  WHERE WORK_ID=?" ;
                  }
                  else if(code.equals("14"))
                  {
                  	sqlQuery= " SELECT distinct  PI_CODE FROM RWS_WORK_pi_LNK_TBL  WHERE WORK_ID=?" ;
                  }
     	        		 
                prpStmt = connection.prepareStatement(sqlQuery);
                prpStmt.setString(1, workId);
                rs = prpStmt.executeQuery();
                  habs=new ArrayList();
                  
      			while(rs.next())
      			{
      		 		habs.add(rs.getString(1)); 
      			}
                if(rs!=null)rs.close();

            } 
           catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getTshabs:"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return habs;
    
	}
    public DAOMessage delTsDetails(String workId)throws Exception
	{
    	
    	boolean status=false;
		String q="",q1="",q2="",q3="",q4="",q5="",q6="";
		DAOMessage daoMessage=new DAOMessage();
        ResultSet rs=null;
        PreparedStatement ps = null;

    	try
		{
    		connection.setAutoCommit(false);
    		try
			{
				
				int count=0;
				boolean delete=true;
				q1 = "select * from RWS_SOURCE_IDEN_FIN_TBL where work_id=?";
				q2 = "select * from RWS_CONTRACTOR_SELECTION_TBL where work_id=?";
				q3 = "select * from RWS_WORK_COMMENCEMENT_TBL where work_id=?";
				q4 = "select * from RWS_WORK_EXPENDITURE_TBL where work_id=?";
				q5 = "select * from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id=?";
				q6 = "select * from RWS_WORK_COMPLETION_TBL where work_id=?";
				

				
				ps = connection.prepareStatement(q1);
				ps.setString(1, workId);
				ResultSet rset11 = ps.executeQuery();
				
				ps = connection.prepareStatement(q2);
				ps.setString(1, workId);
				ResultSet rset1 = ps.executeQuery();
				
				ps = connection.prepareStatement(q3);
				ps.setString(1, workId);
				ResultSet rset2 = ps.executeQuery();
				
				ps = connection.prepareStatement(q4);
				ps.setString(1, workId);
				ResultSet rset3 = ps.executeQuery();
				
				ps = connection.prepareStatement(q5);
				ps.setString(1, workId);
				ResultSet rset4 = ps.executeQuery();
				
				ps = connection.prepareStatement(q6);
				ps.setString(1, workId);
				ResultSet rset5 = ps.executeQuery();
				
				
				if(rset11.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(rset1.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(rset2.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(rset3.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(rset4.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(rset5.next() && delete)
				{
					delete=false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if(delete)
				{
		    		String sqlQuery = " Delete FROM RWS_EST_NEW_HAB_LNK_TBL  WHERE WORK_ID='"+workId+"'" ;
			        java.sql.Statement stmt = connection.createStatement();
		            stmt.addBatch(sqlQuery);
		            sqlQuery="delete from rws_new_est_tbl WHERE WORK_ID='"+workId+"'" ;
		            stmt.addBatch(sqlQuery);
		            int rValues[]=stmt.executeBatch();
		            if(rValues[1]<1)
		            {
		            	daoMessage.setOperationSussess(false);
		            	daoMessage.setMessage("No Records Deleted");
		            }
		            else
		            {
					connection.commit();
					daoMessage.setOperationSussess(true);
		        	daoMessage.setMessage("Records Deleted Successfully");
		            }
				}
			}
    		catch(SQLException e)
			{
				Debug.writeln("Exception Occured:\n" + e);
				daoMessage.setOperationSussess(false);
				Debug.println("error code is "+e.getErrorCode());
				if(e.getErrorCode()==17081)
				{
					daoMessage.setOperationSussess(false);
					daoMessage.setMessage("Record cannot be deleted as child records exists");
				}
				else
				{
					daoMessage.setOperationSussess(false);
					daoMessage.setMessage("Data Exists in Other Work Stages! Record Cannot be deleted!!");
				}
				try{connection.rollback();}
				catch(Exception ex){}
					
			}
			catch(Exception e)
			{	Debug.writeln("Exception in getSelectedHabitations :\n" + e);
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("Data Exists in Other Work Stages! Record Cannot be deleted!!");
				try{connection.rollback();}
				catch(Exception ex){}
			}
			status=true;
      
       } 
    	catch(SQLException e)
		{
			Debug.writeln("Exception in deleteRevisedDetails :\n" + e);
			
			daoMessage.setOperationSussess(false);
			daoMessage.setDefualtErrorMessage(e.getErrorCode());
		}
       catch ( Exception e ) 
		{
           e.printStackTrace();
           daoMessage.setOperationSussess(false);
           daoMessage.setMessage("Data Exists in Other Work Stages! Record Cannot be deleted!!");
           return daoMessage;
       }
       finally
		{
    	   if(ps!=null)ps.close();
       	   if(connection!=null)connection.close();
       	
       	}
    	return daoMessage;
	}
    public DAOMessage delRevTsDetails(String workId)throws Exception
	{
    	
    	boolean status=false;
    	DAOMessage daoMessage=new DAOMessage();
    	try
		{
    		connection.setAutoCommit(false);
	         java.sql.Statement stmt = connection.createStatement();
            String sqlQuery="delete from RWS_REV_EST_NEW_HAB_LNK_TBL  WHERE WORK_ID='"+workId+"'" ;
            stmt.addBatch(sqlQuery);
            
            sqlQuery = " Delete FROM RWS_NEW_REVISED_EST_TBL   WHERE WORK_ID='"+workId+"'" ;
	        stmt.addBatch(sqlQuery);
	           
           
            int rValues[]=stmt.executeBatch();
			if(rValues[0]<1)
			{
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("No records have been deleted");
			}
			else
			{
            connection.commit();
            daoMessage.setOperationSussess(true);
            daoMessage.setMessage("Records Deleted Successfully");
			}
			status=true;
      
       } 
       catch ( SQLException e ) 
		{
	       	Debug.writeln("Exception in deleteRevisedDetails :\n" + e);
			
			daoMessage.setOperationSussess(false);
			daoMessage.setDefualtErrorMessage(e.getErrorCode());
       }
       catch ( Exception e ) 
	   {
	        e.printStackTrace();
	        daoMessage.setOperationSussess(false);
	        daoMessage.setMessage("Records Cannot be Deleted");
	        return daoMessage;
       }
       finally
		{
            if(connection!=null)connection.close();
		}
    	return daoMessage;
	}
    public long getAdminOtherGrantsAmnt(String workId)throws Exception
	{
    	long amnt=0;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
          try
   		{
               
   	        String sqlQuery = "select sum(p.SANCTION_AMOUNT )from RWS_WORK_ADMN_PROG_LNK_TBL p ," +
   	        		"rws_work_admn_tbl ad where ad.work_id=p.work_id and ad.work_Id=?";
              prpStmt = connection.prepareStatement(sqlQuery);
              prpStmt.setString(1, workId);
              rs = prpStmt.executeQuery();
        
              if(rs.next())
              {
              	amnt= (long)((float)(rs.getDouble(1)*100000));
              }
               
              if(rs!=null)rs.close();

          } 
          catch ( SQLException e ) 
   		{
              System.err.println("SQL Exception occured while accessing the table" );
              return 0;
          }
          catch ( Exception e ) 
   		{
             Debug.println("Exception in getAdminOtherGrantsAmnt:"+e);
              return 0;
          }
          finally
   		{
        	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
   		}
          return amnt;
   	}
    public rws_works_WorkStatus_bean getPopulationDetails(String workID, String tableName) throws Exception {
		rws_works_WorkStatus_bean bean = new rws_works_WorkStatus_bean();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		try {
			String sqlQuery = " SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS "
					+ " SC_POP_TOT,SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM  rws_habitation_directory_tbl h," + " "
					+ tableName + " hl where hl.hab_code=h.hab_code and hl.work_id=? ";

			prpStmt = connection.prepareStatement(sqlQuery);
			prpStmt.setString(1, workID);
			rs = prpStmt.executeQuery();

			while (rs.next()) {
				bean.setAdminPlainPopu(rs.getString(1));
				bean.setAdminScPopu(rs.getString(2));
				bean.setAdminSTPopu(rs.getString(3));
				bean.setAdminTotpopu(rs.getInt(1) + rs.getInt(2) + rs.getInt(3) + "");
			}
			if (rs != null)
				rs.close();
			if (prpStmt != null)
				prpStmt.close();

			sqlQuery = " SELECT count(*) FROM  rws_habitation_directory_tbl h," + " " + tableName
					+ " hl where hl.hab_code=h.hab_code and hl.work_id=? ";
			prpStmt = connection.prepareStatement(sqlQuery);
			prpStmt.setString(1, workID);
			rs = prpStmt.executeQuery();

			while (rs.next()) {
				bean.setRevTsNoOfHabs(rs.getInt(1) + "");
			}
			if (rs != null)
				rs.close();

		} catch (Exception e) {
			System.out.println("exception in getPopulationDetails of rws_works_worksDAO---" + e);
			return null;
		} finally {
			if (prpStmt != null)
				prpStmt.close();
			if (rs != null)
				rs.close();
			if (connection != null)
				connection.close();
		}
		return bean;
	}
    
    public String insertRevTsDetails(ArrayList revTsBeans,ArrayList SanctionedHabs,rws_works_WorkStatus_form bean)throws Exception
    {

   	    java.util.Date d=new java.util.Date();
   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    	SimpleDateFormat format  = new SimpleDateFormat("yyyy");
   	    String curruntDate=formatter.format(d);
   	    String currentYear=format.format(d);
   	    String status =null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
      try
		{
            
	       String sqlQuery = "INSERT INTO RWS_NEW_REVISED_EST_TBL(OFFICE_CODE  ,FINANCIAL_YEAR ,SOURCE_CODE ," +
	       		"WORK_ID ,REV_TS_GIVEN_BY  ,REV_SANCTIONED_AMOUNT ,REV_TS_NO  ,REV_TS_DATE , " +
	       		" PREPARED_BY , PREPARED_ON,REV_TS_OFFICE ,SSR_YEAR  )" +
	       		"values(?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,?) ";
	       
	        
	       connection.setAutoCommit(false);
	       java.sql.Statement stmt=connection.createStatement();
	       stmt.addBatch("Delete from RWS_NEW_REVISED_EST_TBL where work_id='"+bean.getWorkId()+"'");
	       stmt.addBatch("Delete from RWS_REV_EST_NEW_HAB_LNK_TBL where work_id='"+bean.getWorkId()+"'");
	       stmt.executeBatch();
	       
	       prpStmt = connection.prepareStatement(sqlQuery);
           boolean insertAtleastOne=false;
	       for(int i=0;i<revTsBeans.size();i++)
           {
           	rws_works_WorkStatus_bean revTsBean=(rws_works_WorkStatus_bean)revTsBeans.get(i);
           	if(revTsBean.getRevTsAmnt()!=null||revTsBean.getRevTsNo()!=null||revTsBean.getRevTsDate()!=null||revTsBean.getRevSsrYear()!=null)
           	{
           		if(!revTsBean.getRevTsAmnt().equals(""))
           		{
           			insertAtleastOne=true;
           			prpStmt.setString(1,bean.getOfficeCode());
	           		prpStmt.setString(2,currentYear);
	           		prpStmt.setString(3,"");
	           		prpStmt.setString(4,bean.getWorkId());
	           		prpStmt.setString(5,bean.getTsAccBy());
	           		prpStmt.setString(6,(String)revTsBean.getRevTsAmnt());
	           		prpStmt.setString(7,(String)revTsBean.getRevTsNo());
	           		prpStmt.setString(8,(String)revTsBean.getRevTsDate());
	           		prpStmt.setString(9,bean.getPreparedBy());
	           		prpStmt.setString(10,curruntDate);
	           		prpStmt.setString(11,bean.getTsOffice());
	           		prpStmt.setString(12,(String)revTsBean.getSyr1());
	           		prpStmt.addBatch();
           		}
           	}
           }
	       if(insertAtleastOne)
	       prpStmt.executeBatch();
	       sqlQuery="INSERT INTO RWS_REV_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values(?,?)";
           PreparedStatement prpStmtNew = connection.prepareStatement(sqlQuery);
           for(int i=0;i<SanctionedHabs.size();i++)
           {
           	   	prpStmtNew.setString(1, bean.getWorkId());
	           	prpStmtNew.setString(2,(String)SanctionedHabs.get(i));
	           	prpStmtNew.addBatch();
	        }
           prpStmtNew.executeBatch();
           connection.commit();
           status="true";
           
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in insertRevTsDetails:"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
       return status;
     }
    public ArrayList getRevTsDetails(String workId)throws Exception
	{
    	ArrayList revDet=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
    	try
		{
            
	        String sqlQuery = " SELECT  REV_SANCTIONED_AMOUNT,to_char(REV_TS_DATE,'dd/mm/yyyy') ,REV_TS_NO ,SSR_YEAR  " +
	        		          " FROM RWS_NEW_REVISED_EST_TBL   WHERE WORK_ID=?" ;
	        		 
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
           revDet=new ArrayList();
           rws_works_WorkStatus_bean bean=null;
      	   while(rs.next())
 			{
      	     bean=new rws_works_WorkStatus_bean();
      	     bean.setRevTsAmnt(rs.getString(1));
      	     bean.setRevTsDate(rs.getString(2));
      	     bean.setRevTsNo(rs.getString(3));
      	     bean.setSyr1(rs.getString(4));
      	     revDet.add(bean);
 			}
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
            if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
    	return revDet;
	}
    public boolean chkRevTsDetails(String workId)throws Exception
	{
    	boolean status=false;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
    	try
		{
    		 
	        String sqlQuery = " select * from RWS_NEW_REVISED_EST_TBL   WHERE WORK_ID=?" ;
	        
	        prpStmt = connection.prepareStatement(sqlQuery);
	        prpStmt.setString(1, workId);
             rs= prpStmt.executeQuery();             
			 if(rs.next())
			  status=true;
      
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return false;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in chkRevTsDetails:"+e);
           return false;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
    	return status;
	}
     public ArrayList getRevTsHabs(String workId)throws Exception
	 {
 	  ArrayList revDet=null;
 	  
      ResultSet rs=null;
      PreparedStatement prpStmt = null;
    	try
		{
           String sqlQuery = " SELECT   hab_code from RWS_REV_EST_NEW_HAB_LNK_TBL   WHERE WORK_ID=?" ;
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
           revDet=new ArrayList();
            
      	   while(rs.next())
 			{
      	    revDet.add(rs.getString(1));
 			}
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getRevTsHabs:"+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
    	return revDet;
	
	 }
     public ArrayList getMileStones()throws Exception
     {
     	ArrayList mileStones=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
     	try
		{
           String sqlQuery = " SELECT   *  from   rws_milestone_tbl  where MILESTONE_CODE <>'35' order by 1 " ;
           prpStmt = connection.prepareStatement(sqlQuery);
           rs = prpStmt.executeQuery();
           mileStones=new ArrayList();
           rws_works_WorkStatus_bean bean=null;
      	   while(rs.next())
 			{
      	       bean=new rws_works_WorkStatus_bean();
      	       bean.setMileStone(rs.getString("MILESTONE_CODE"));
      	       bean.setMileStoneName(rs.getString("MILESTONE_NAME"));
      	       mileStones.add(bean);
      	 	}
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
    	   Debug.println("Exception in getMileStones:"+e);
           return null;
       }
       finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
     	return mileStones;
     }
     public ArrayList getStages(String mileStoneCode)throws Exception
	 {
     	ArrayList stages=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
     	try
		{
           String sqlQuery = " SELECT   *  from   rws_milestone_stage_tbl  where MILESTONE_CODE =? order by 2" ;
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, mileStoneCode);
           rs = prpStmt.executeQuery();
           stages=new ArrayList();
           rws_works_WorkStatus_bean bean=null;
      	   while(rs.next())
 			{
      	       bean=new rws_works_WorkStatus_bean();
      	       bean.setStage(rs.getString("MILESTONE_stage_CODE"));
      	       bean.setStageName(rs.getString("MILESTONE_stage_NAME"));
      	     stages.add(bean);
      	 	}
           if(rs!=null)rs.close();

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getStages:"+e);
           return null;
       }
       finally
		{
if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
     	return stages;
     
     	
	 }
     public int deleteContractorData(String workId) throws Exception
     {
     	int rValue=-1;
     	Statement stmt=null;
     	boolean deleted=true;
		String q3="",q4="",q5="",q6="";
		PreparedStatement pstat2=null,pstat3=null,pstat4=null,pstat5=null;
		ResultSet rset2 = null,rset3 = null,rset4 = null,rset5 = null;

     	try{
     	connection.setAutoCommit(false);
		
		int count=0;
		boolean delete=true;
		q3 = "select * from RWS_WORK_COMMENCEMENT_TBL where work_id=?";
		pstat2=connection.prepareStatement(q3);
		pstat2.setString(1, workId);
		rset2=pstat2.executeQuery();
		
		q4 = "select * from RWS_WORK_EXPENDITURE_TBL where work_id=?";
		pstat3=connection.prepareStatement(q4);
		pstat3.setString(1, workId);
		rset3=pstat3.executeQuery();
		
		q5 = "select * from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id=?";
		pstat4=connection.prepareStatement(q5);
		pstat4.setString(1, workId);
		rset4=pstat4.executeQuery();
		
		q6 = "select * from RWS_WORK_COMPLETION_TBL where work_id=?";
		pstat5=connection.prepareStatement(q6);
		pstat5.setString(1, workId);
		rset5=pstat5.executeQuery();
		

		if(rset2.next() && delete)
		{
			delete=false;
			rValue = -2;
			throw new SQLException("RECORD EXIST IN CHILD TABLE");
		}
		if(rset3.next() && delete)
		{
			delete=false;
			rValue = -2;
			throw new SQLException("RECORD EXIST IN CHILD TABLE");
		}
		if(rset4.next() && delete)
		{
			delete=false;
			rValue = -2;
			throw new SQLException("RECORD EXIST IN CHILD TABLE");
		}
		if(rset5.next() && delete)
		{
			delete=false;
			rValue = -2;
			throw new SQLException("RECORD EXIST IN CHILD TABLE");
		}
		if(delete)
		{
	     	String query="delete from RWS_CONTRACTOR_SELECTION_TBL where work_id='"+workId+"'";
	     	stmt=connection.createStatement();
	     	stmt.addBatch(query);
	     	query="delete from rws_tender_appl_tbl where work_id='"+workId+"'";
	     	stmt.addBatch(query);
	     	query="delete from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"'";
	     	stmt.addBatch(query);
	     	int rcounts[]=stmt.executeBatch();
			for(int i=0;i<rcounts.length-1;i++)
			{
				if(rcounts[i]<0)
				{
					deleted=false;
				}
				else
				{
					rValue++;
				}
			}
		}
		else
		{
			deleted = false;
		}
     	}catch(Exception e)
		{
     		e.printStackTrace();
     		Debug.println("Exception in deleteContractorData:"+e);
     		deleted=false;
     	}
     	
     	if(deleted)
     	{
     		connection.setAutoCommit(true);
     		connection.commit();
     		return rValue;
     	}
     	else
     		return rValue;
     	}
     	
     
     public rws_works_WorkStatus_bean getContractorData(String workId)throws Exception
	 {
     	rws_works_WorkStatus_bean bean=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
     	try
		{
     		
     		String sqlQuery = " SELECT TENDER_IDNO,AGREEMENT_REFERENCE_NO,"
    			+" AGREEMENT_DURATION,AGREEMENT_VALUE,to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy')SITE_HAND_OVER_DATE," 
    			+" to_char(AGREEMENT_DATE,'dd/mm/yyyy')AGREEMENT_DATE,to_char(TENDER_APPROVED_ON,'dd/mm/yyyy')TENDER_APPROVED_ON,to_char(LOA_ISSUED_ON,'dd/mm/yyyy')LOA_ISSUED_ON,"
    			+" to_char(DATE_OF_COMPLETION,'dd/mm/yyyy')DATE_OF_COMPLETION,TENDER_PERCENT,decode(TENDER_COMMITTEE,'Y','01')TENDER_COMMITTEE,decode(COMPETENT_AUTHORITY,'Y','02')COMPETENT_AUTHORITY,TENDER_NOMINATION,CONTRACTOR_CODE,to_char(PROBABLE_DATE,'dd/mm/yyyy')PROBABLE_DATE from RWS_CONTRACTOR_SELECTION_TBL   "
    			+ " where WORK_ID  =? " ;
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
           bean=new rws_works_WorkStatus_bean(); 
           if(rs.next())
 			{
           	   String arrTmp[]=new String[2];
      	       int i=0;
      	       if(rs.getString("TENDER_COMMITTEE")!=null && rs.getString("TENDER_COMMITTEE").equals("01"))
      	       	arrTmp[i++]=rs.getString("TENDER_COMMITTEE");
      	       if(rs.getString("COMPETENT_AUTHORITY")!=null && rs.getString("COMPETENT_AUTHORITY").equals("02"))
      	       	arrTmp[i++]=rs.getString("COMPETENT_AUTHORITY");
      	       bean.setTenCommiteeArr(arrTmp);
      	   	   bean.setWorkId(workId);
      	       bean.setTenId(rs.getString("TENDER_IDNO"));
      	       bean.setAgrRefNo(rs.getString("AGREEMENT_REFERENCE_NO"));
      	       bean.setAgrDuration(rs.getString("AGREEMENT_DURATION"));
      	       bean.setAgrValue(rs.getString("AGREEMENT_VALUE"));
      	       bean.setSiteHandOverDate(rs.getString("SITE_HAND_OVER_DATE"));
      	       bean.setAgrDate(rs.getString("AGREEMENT_DATE"));
      	       bean.setLoaIssued(rs.getString("LOA_ISSUED_ON"));
      	       bean.setStipulatedDate(rs.getString("DATE_OF_COMPLETION"));
      	       bean.setTenPer(rs.getString("TENDER_PERCENT"));
      	       bean.setTenCommitee(rs.getString("TENDER_COMMITTEE"));
      	       bean.setTenCompetentAuthority(rs.getString("COMPETENT_AUTHORITY"));
      	       bean.setWorkEnt(rs.getString("TENDER_NOMINATION"));
      	       bean.setConName(rs.getString("CONTRACTOR_CODE"));
      	       bean.setProbCompDate(rs.getString("PROBABLE_DATE"));
      	 	}
      	 sqlQuery = " SELECT  CONTRACTOR_NAME,TENDER_AMOUNT,to_char(RECIEVED_ON,'dd/mm/yyyy')RECIEVED_ON "
      	 		+ "from rws_tender_appl_tbl  where WORK_ID  =? " ;
       prpStmt = connection.prepareStatement(sqlQuery);
       prpStmt.setString(1, workId);
       rs = prpStmt.executeQuery();
  	   while(rs.next())
			{
  	       bean.setTenCost(rs.getString("TENDER_AMOUNT"));
  	       bean.setTenAcceptedDate(rs.getString("RECIEVED_ON"));
  	 	   }
           if(rs!=null)rs.close();
       } 
       catch ( SQLException e ) 
		{
       	   Debug.println("Exception in getContractorData is "+e);
           return null;
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in getContractorData is "+e);
           return null;
       }
       finally
		{
    	    if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
     	return bean;
	 }
     
     public ArrayList getContractorMileStonesData(DataSource ds,String workId)throws Exception
	 {
     	ArrayList mileStonesList=new ArrayList();  
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
	
     	rws_works_WorkStatus_bean bean=null;
     	try
		{
     		
     		String sqlQuery = "select MILESTONE_SLNO,WORK_ID,MAJOR_MILESTONE_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,COMPONENT_NO,to_char(TARGET_DATE,'dd/mm/yyyy') TARGET_DATE,PERCENT_COMPLETED_WORK,PERCENT_COMPLETED_WORK*100000 as amnt,PERCENT_COMPLETED,nvl(PERCENT_COMPLETED*100000,0) as amntt1,TYPE_OF_CONTRACTOR,to_char(EOAT_DT,'dd/mm/yyyy') as EOAT_DT,PERCENT_COMPLETED_WORK_VAL "
     				+ "from   rws_MILESTONE_TARGET_ACH_TBL   where  WORK_ID  =? order by MILESTONE_SLNO" ;
           prpStmt = connection.prepareStatement(sqlQuery);
           prpStmt.setString(1, workId);
           rs = prpStmt.executeQuery();
          
           
      	   while(rs.next())
 			{
      	       bean=new rws_works_WorkStatus_bean();
      	       bean.setMileStoneSno(rs.getString("MILESTONE_SLNO"));
      	       bean.setWorkId(rs.getString("WORK_ID"));
      	       bean.setMajorMileStone(rs.getString("MAJOR_MILESTONE_CODE"));
      	       bean.setMileStone(rs.getString("MILESTONE_CODE"));
      	       WorksDAO dao = rws_works_factory.createWorksDAO(ds);
      	       bean.setStages(dao.getStages(rs.getString("MILESTONE_CODE")));
      	       bean.setStage(rs.getString("MILESTONE_STAGE_CODE"));
      	       bean.setCompInNo(rs.getString("COMPONENT_NO"));
      	       bean.setTargetDate(rs.getString("TARGET_DATE"));
      	       bean.setPerCompInWorkValue(rs.getString("PERCENT_COMPLETED_WORK_VAL"));
      	       bean.setPerCompInWork(rs.getString("PERCENT_COMPLETED_WORK"));
      	       bean.setPerComp(rs.getString("PERCENT_COMPLETED"));
      	       bean.setTypeOfContractor(rs.getString("TYPE_OF_CONTRACTOR"));
      	       bean.setEoatTargetDate(rs.getString("EOAT_DT"));
      	       mileStonesList.add(bean);
      	 	}
           if(rs!=null)rs.close();
           
       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured in getContractorMileStonesData" );
           return null;
       }
       catch ( Exception e ) 
		{
    	   Debug.println("Exception in getContractorMileStonesData:"+e);
       }
       finally
		{
    	   	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(connection!=null)connection.close();
		}
     	return mileStonesList;
     
     	
	 }
     
     public int saveContMgtMileStones(DataSource dataSource,ArrayList selectedList,String workCode,rws_works_WorkStatus_bean worksBean) throws Exception
	{
			boolean insertedSuccessfully=true;
			int count=0;
			int contSel=0;
			Statement stmt=null;
			PreparedStatement pstmt2=null,pstmt3=null;
			boolean mileStoneFlag=false;
			ResultSet rset=null;
			String query="";
			try
			{
				rws_works_WorkStatus_bean mileStoneBean=new rws_works_WorkStatus_bean();
				
				connection.setAutoCommit(false);
				stmt=connection.createStatement();
				
			
			query="select count(*) from rws_tender_appl_tbl where  work_id=?";
			pstmt2=connection.prepareStatement(query);
			pstmt2.setString(1, workCode);
			rset=pstmt2.executeQuery();
 		if(rset.next())
 			contSel=rset.getInt(1);
 		if(contSel==0)
 		{
			query = "insert into rws_tender_appl_tbl(WORK_ID,TENDER_IDNO,CONTRACTOR_NAME,TENDER_AMOUNT,RECIEVED_ON  " +
			" ) values('" + workCode + "','" + worksBean.getTenId() + "','" + worksBean.getConName() + "'," +
			" nvl('" + worksBean.getTenCost() + "','')," +
			" to_date('"+worksBean.getTenAcceptedDate()+ "','dd/mm/yyyy')" +
			" )";
 		stmt.addBatch(query);

 		}
 		else
 		{
 			query = "update rws_tender_appl_tbl set " 
 				  +	"TENDER_IDNO='"+worksBean.getTenId()
					  + "',CONTRACTOR_NAME='"+worksBean.getConName()
					  +"',TENDER_AMOUNT=nvl('"+worksBean.getTenCost()
					  +"','') ,RECIEVED_ON= to_date('"
					  +worksBean.getTenAcceptedDate()+ "','dd/mm/yyyy')"
					  +"  where work_id='"+workCode+"'";
     		stmt.addBatch(query);
 		}
			
			query="select count(*) from RWS_CONTRACTOR_SELECTION_TBL where work_id=?";
			pstmt2=connection.prepareStatement(query);
			pstmt2.setString(1, workCode);
			rset=pstmt2.executeQuery();
			
 		if(rset.next())
 			contSel=rset.getInt(1);
 		if(contSel==0)
 		{
 		query=" insert into RWS_CONTRACTOR_SELECTION_TBL(TENDER_NOMINATION ,WORK_ID," 
 			+" TENDER_IDNO,AGREEMENT_REFERENCE_NO,"
			+" AGREEMENT_DURATION,AGREEMENT_VALUE,SITE_HAND_OVER_DATE," 
			+" AGREEMENT_DATE,TENDER_APPROVED_ON,LOA_ISSUED_ON,"
			+" DATE_OF_COMPLETION,TENDER_PERCENT,TENDER_COMMITTEE,COMPETENT_AUTHORITY,CONTRACTOR_CODE,PROBABLE_DATE ) " 
			+" values('"+worksBean.getWorkEnt()+"','"+workCode+"','"+worksBean.getTenId()+"','"
			+worksBean.getAgrRefNo()+"','"+worksBean.getAgrDuration()+"','"
			+worksBean.getAgrValue()+"',to_date('"+RwsMasterData.format(worksBean.getSiteHandOverDate())+"','dd-mm-yyyy'),to_date('"
			+RwsMasterData.format(worksBean.getAgrDate())+"','dd-mm-yyyy'),to_date('"+RwsMasterData.format(worksBean.getTenAcceptedDate())+"','dd-mm-yyyy'),to_date('"
			+RwsMasterData.format(worksBean.getLoaIssued())+"','dd-mm-yyyy'),"
			+"to_date('"+RwsMasterData.format(worksBean.getStipulatedDate())+"','dd-mm-yyyy')," 
			+"'"+worksBean.getTenPer()+"',nvl(decode('"+ worksBean.getTenCommitee()+"','01','Y'),'N')," 
			+"nvl(decode('"+  worksBean.getTenCompetentAuthority()+"','02','Y'),'N'),'"+worksBean.getConName()+"',to_date('"+worksBean.getProbCompDate()+ "','dd/mm/yyyy') )";  
 		stmt.addBatch(query);

 		}
 		else
 		{
 			query="update RWS_CONTRACTOR_SELECTION_TBL set "+
			"TENDER_NOMINATION  = '"+worksBean.getWorkEnt()+"',"+
 			"TENDER_IDNO  ='"+worksBean.getTenId()+"',"+
 			"AGREEMENT_REFERENCE_NO ='"+worksBean.getAgrRefNo()+"',"+  
 			"AGREEMENT_DURATION  = '"+ worksBean.getAgrDuration()+"',"+
 			"AGREEMENT_VALUE  = '"+worksBean.getAgrValue()+"',"+ 
 			"SITE_HAND_OVER_DATE = to_date('"+RwsMasterData.format(worksBean.getSiteHandOverDate())+"','dd-mm-yyyy')," +
 			"AGREEMENT_DATE  = to_date('"+RwsMasterData.format(worksBean.getAgrDate())+"','dd-mm-yyyy')," +
 			"TENDER_APPROVED_ON = to_date('"+ RwsMasterData.format(worksBean.getTenAcceptedDate())+"','dd-mm-yyyy')," +
 			"LOA_ISSUED_ON   = to_date('"+ RwsMasterData.format(worksBean.getLoaIssued())+"','dd-mm-yyyy')," +
 			"TENDER_COMMITTEE = nvl(decode('"+ worksBean.getTenCommitee()+"','01','Y'),'N'),"+
 			"COMPETENT_AUTHORITY =  nvl(decode('"+  worksBean.getTenCompetentAuthority()+"','02','Y'),'N'),"+
 			"DATE_OF_COMPLETION = to_date('"+RwsMasterData.format( worksBean.getStipulatedDate())+"','dd-mm-yyyy') " +
 			",TENDER_PERCENT ='"+worksBean.getTenPer()+"',CONTRACTOR_CODE='"+worksBean.getConName()+"',PROBABLE_DATE=to_date('"+worksBean.getProbCompDate()+ "','dd/mm/yyyy') " +
 			"where work_id='"+workCode+"'" ;
     		stmt.addBatch(query);
		    }	
 		
 		
				for(int i=0;i<selectedList.size();i++)
				{
					mileStoneBean=(rws_works_WorkStatus_bean)selectedList.get(i);
					if(mileStoneBean!=null && mileStoneBean.getMileStone().equals("35")){
						String mileStoneCheck="select *from rws_notgroundworks_status_tbl where work_id=? and PARTACLEARANCE='Y' and PARTACLEARNCEDATE is not null";
						
						pstmt3=connection.prepareStatement(mileStoneCheck);
						pstmt3.setString(1, workCode);
						ResultSet rrrs=pstmt3.executeQuery();
						if(!rrrs.next()){
							mileStoneFlag=false;
							selectedList.remove(mileStoneBean);
							continue;
						}else{
							mileStoneFlag=true;
						}
						
					}
					String qq = "select * from RWS_MILESTONE_TARGET_ACH_TBL where work_id=? and MILESTONE_SLNO=?";
					pstmt3=connection.prepareStatement(qq);
					pstmt3.setString(1, workCode);
					pstmt3.setString(2, mileStoneBean.getMileStoneSno());
					ResultSet ss = pstmt3.executeQuery();
					if(ss.next())
					{
						query = "update RWS_MILESTONE_TARGET_ACH_TBL set " +
								"MAJOR_MILESTONE_CODE='"+mileStoneBean.getMajorMileStone()+"'," +
								"MILESTONE_CODE='"+mileStoneBean.getMileStone()+"'," +
								"MILESTONE_STAGE_CODE='"+mileStoneBean.getStage()+"'," +
								"COMPONENT_NO='"+mileStoneBean.getCompInNo()+"'," +
								"TARGET_DATE=to_date('"+mileStoneBean.getTargetDate()+"','dd/mm/yyyy')," +
								"PERCENT_COMPLETED_WORK='"+mileStoneBean.getPerCompInWork()+"',TYPE_OF_CONTRACTOR='"+mileStoneBean.getTypeOfContractor()+"',EOAT_DT=to_date('"+mileStoneBean.getEoatTargetDate()+"','dd/mm/yyyy'),PERCENT_COMPLETED_WORK_VAL='"+mileStoneBean.getPerCompInWorkValue()+"'" +
								" where work_id='"+workCode+"' and MILESTONE_SLNO='"+mileStoneBean.getMileStoneSno()+"'";
					}
					else
					{
						query 	= "insert into RWS_MILESTONE_TARGET_ACH_TBL " 
							+ "(MILESTONE_SLNO,WORK_ID,MAJOR_MILESTONE_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,COMPONENT_NO,TARGET_DATE,PERCENT_COMPLETED_WORK,TYPE_OF_CONTRACTOR,EOAT_DT,MS_STAGE,PERCENT_COMPLETED_WORK_VAL" 
							+ " ) values ('"+mileStoneBean.getMileStoneSno()+"','"+workCode+"','"+mileStoneBean.getMajorMileStone()+"','"
							+ mileStoneBean.getMileStone()+"','"+mileStoneBean.getStage()
							+"','"+mileStoneBean.getCompInNo()+"',to_date('"+mileStoneBean.getTargetDate()+"','dd/mm/yyyy'),"
							+mileStoneBean.getPerCompInWork()+",'"+mileStoneBean.getTypeOfContractor()+"',to_date('"+mileStoneBean.getEoatTargetDate()+"','dd/mm/yyyy'),'1','"+mileStoneBean.getPerCompInWorkValue()+"')";
					}
					stmt.addBatch(query);
				}
				int rcounts[]=stmt.executeBatch();
				for(int i=selectedList.size()+2;i<rcounts.length;i++){
				if(rcounts[i]<1)
					insertedSuccessfully=false;
				}
				
			}catch(Exception e){
				Debug.println("Exception in saveContMgtMileStones "+e);insertedSuccessfully=false;
			}
			finally{
			if(insertedSuccessfully)
				connection.commit();
			 if(pstmt2!=null)pstmt2.close();
			 if(pstmt3!=null)pstmt3.close();
			 if(stmt!=null)stmt.close();
            if(connection!=null)connection.close();
				
			}
			if(insertedSuccessfully)
			{
				if(!mileStoneFlag){
					return 2;
				}
				return 1;
			}
			else
				return -1;
			
	}
     public int removeMileStones(String workId,String sno)throws Exception
	 {
     	int val = 0;  
        PreparedStatement pstmt = null;
     	try
		{
     		String checkQry = "select nvl(PERCENT_COMPLETED_VAL,0) from rws_MILESTONE_TARGET_ACH_TBL "
     				+ " where work_id=? and MILESTONE_SLNO=?";
     		pstmt = connection.prepareCall(checkQry);
     		pstmt.setString(1, workId);
     		pstmt.setString(2, sno);
           	ResultSet rs = pstmt.executeQuery();
           	if(rs.next() && rs.getInt(1)>0)
           	{
           	}
           	else
           	{
         		String sqlQuery = "delete from rws_MILESTONE_TARGET_ACH_TBL where WORK_ID  =? and MILESTONE_SLNO=? " ;
               	pstmt = connection.prepareStatement(sqlQuery);
               	pstmt.setString(1, workId);
         		pstmt.setString(2, sno);
               	val = pstmt.executeUpdate();
           	}
       } 
       catch ( SQLException e ) 
	   {
           System.err.println("SQL Exception occured in removeMileStones" );
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in removeMileStones:"+e);
           
       }
       finally
		{
       		if(pstmt!=null)pstmt.close();
            if(connection!=null)connection.close();
		}
     	return val;
     
     	
	 }
     public int saveIndividualTapConn(String indTapLoc,int indTapType,String habCode)throws Exception
	 {
     	int val = 0;  
        PreparedStatement pstmt = null;
        
     	try
		{
     		
     		connection = RwsOffices.getConn();
     		String sql = "INSERT INTO RWS_INDIVIDUAL_TAP_CONN(TAP_LOCATION, TAP_CONN_CODE, HAB_CODE, INSERTED_DATE)"
					+ " VALUES(?,?,?, TO_DATE(?,'dd-mm-yyyy HH:MI:SS AM'))";

     	connection.setAutoCommit(false);
     	SimpleDateFormat formatter = new SimpleDateFormat("dd-M-yyyy hh:mm:ss");  
     	   String strDate = formatter.format(new Date());  
     	  //  System.out.println("Date Format with dd-M-yyyy hh:mm:ss : "+strDate);  
     	    
		pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, indTapLoc);
		pstmt.setString(2, String.valueOf(indTapType));
		pstmt.setString(3, habCode);
		pstmt.setString(4, strDate);
		val = pstmt.executeUpdate();
		//if(val>0)returnValue=true;
		
       } 
       catch ( SQLException e ) 
	   {
           System.err.println("SQL Exception occured in removeMileStones" );
       }
       catch ( Exception e ) 
		{
           Debug.println("Exception in removeMileStones:"+e);
           
       }
       finally
		{
       		if(pstmt!=null)pstmt.close();
            if(connection!=null)connection.close();
		}
     	return val;
     
     	
	 }
     public int saveSchoolTapStatus(ArrayList schoolDetailsList) throws Exception
 	{
     	int returnValue=0;
     	PreparedStatement prpStmt = null;
 		try {
 				
 			 String sqlQuery = "UPDATE RWS_SCHOOL_MASTER_TBL SET IS_HAVING_TAP=?  " +
 			       		" WHERE HAB_CODE=? and SCHOOL_CODE=? and SCHOOL_NAME=? and SCHOOL_CLASSIFICATION=? and SCHOOL_CATEGORY_CODE=?" ;
 			       		 
 			       connection.setAutoCommit(false);
 			       
 		           prpStmt = connection.prepareStatement(sqlQuery);
 		           for(int i=0;i<schoolDetailsList.size();i++){
 		        	   RWS_SCHOOL_BEAN bean1 = (RWS_SCHOOL_BEAN) schoolDetailsList.get(i);
 		        	   RWS_SCHOOL_BEAN bean = new RWS_SCHOOL_BEAN((RWS_SCHOOL_BEAN) schoolDetailsList.get(i));
 		        	   prpStmt.setString(1,bean.getIsSchoolHavingTap());
 			           prpStmt.setString(2,bean.getHabCode());
 			           prpStmt.setString(3,bean.getSchoolCode());
 			           prpStmt.setString(4,bean.getSchoolDetails());
 			           prpStmt.setString(5,bean.getSchoolClassification());
 			           prpStmt.setString(6,bean.getSchoolCategoryCode());
 			        // System.out.println("bean 1 is having tap :"+bean1.getIsSchoolHavingTap());
 			           
 			           
 			           prpStmt.addBatch();
 		           }
 		           prpStmt.executeBatch();
 		           connection.commit();
 		           returnValue = 1;
 			} catch (Exception e) {
 				Debug.println("Ther Exception in saveSchoolTapStatus=" + e);
 		} finally {
 			try{
 				if(prpStmt!=null)prpStmt.close();
 	            if(connection!=null)connection.close();
          	   }
          	catch(Exception e)
 			{}
 			}
     	return returnValue;
 	}
	public int cancelTheWork(String workId, String cancelDate) throws Exception {
		int returnValue = 0;
    	String hab = "";
    	PreparedStatement ps = null;
		try {
				connection = RwsOffices.getConn();
				
				String qry = "";
				if(cancelDate!=null && !cancelDate.equals(""))
					qry = "update rws_work_admn_tbl set WORK_CANCEL_DT=to_date('"+cancelDate+"','dd/mm/yyyy') where work_id=?";
				else
					qry = "update rws_work_admn_tbl set WORK_CANCEL_DT='' where work_id=?";
				ps = connection.prepareStatement(qry);
				ps.setString(1, workId);
				returnValue = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("Ther Exception in get cancelTheWork =" + e);
		} finally {
			try{
				if(ps!=null)ps.close();
	            if(connection!=null)connection.close();
         	   }
         	catch(Exception e)
			{}
			}
		return returnValue;
	}
	
public boolean chkMilestoneBillDetails(String workId)throws Exception
{
	boolean status=false,status1=false,finalstatus=false;
    ResultSet rs=null,rs1=null;
    PreparedStatement ps=null,ps1=null;
         
	try
	{
		connection = RwsOffices.getConn();
        String sqlQuery = " select * from rws_milestone_target_ach_tbl WHERE WORK_ID=?" ;
        ps= connection.prepareStatement(sqlQuery);
        ps.setString(1, workId);
        rs=ps.executeQuery();
         if(rs.next())
         status=true;
         
		 String sqlQuery1 = " select * from rws_work_bill_tbl WHERE WORK_ID=?" ;
	        
		 ps1= connection.prepareStatement(sqlQuery1);
	        ps1.setString(1, workId);
	        rs1=ps1.executeQuery();
	     if(rs1.next())
	         status1=true;
	    
		 if(status == true || status1 == true)
		 {
		 	finalstatus=false;
		 }
		 else
		 {
		 	finalstatus=true;
		 }
		 
  
   } 
   catch ( SQLException e ) 
	{
       System.err.println("SQL Exception occured while accessing the table" );
       return false;
   }
   catch ( Exception e ) 
	{
       Debug.println("Exception in chkMilestoneBillDetails:"+e);
       return false;
   }
   finally
	{

      	if(rs!=null)rs.close();
      	if(rs1!=null)rs1.close();
      	if(ps!=null)ps.close();
      	if(ps1!=null)ps1.close();
        if(connection!=null)connection.close();
	}
	return finalstatus;
}
	
}