package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class Rws_Sanction_Amount_Change_DAO {
	
	//Deepak Modified 
	public ArrayList  getBillDetails(String work_Id) throws Exception{	    	
	    	ResultSet rs=null;
	        PreparedStatement prpStmt = null;
	        Connection connection=null;
	    	ArrayList list=null;
	        try{
	            connection=RwsOffices.getConn();
		        String sqlQuery = "select BILL_SL_NO,BILL_AMOUNT_CENTRAL,to_char(BANK_SEND_DATE,'dd/mm/yyyy'),TXID from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+work_Id+"'";
		        prpStmt = connection.prepareStatement(sqlQuery);
	            rs = prpStmt.executeQuery();
	            list=new ArrayList();
	            tenderMemo tenderMemoBean = null;
	            while(rs.next()){
	            	tenderMemoBean = new  tenderMemo();
	            	tenderMemoBean.setBillSlNo(rs.getString(1));
	            	tenderMemoBean.setBillReleaseAmount(rs.getString(2));
	            	tenderMemoBean.setBillDate(rs.getString(3));
	            	tenderMemoBean.setBillNo(rs.getString(4));
	            	list.add(tenderMemoBean);
	            }
	            if(rs!=null)rs.close();

	        } 
	        catch (SQLException e){
	        	System.out.println("The SQL Exception is in Rws_sanction_Amount_Change_DAO getBillDetails : " +e.getMessage());
	            return null;
	        }
	        catch (Exception e){
	        	System.out.println("The Exception is in Rws_sanction_Amount_Change_DAO getBillDetails : " +e.getMessage());
	            return null;
	        }
	        finally {
				if(prpStmt!=null)
					prpStmt.close();
	          	if(rs!=null)
	          		rs.close();
	            if(connection!=null)
	            	connection.close();
			}
	        return list;
	    }

	//Deepak Modified 
	public int updateSanctionAmount(String workId, String sanctionAmountChange,String admnAmount,String preoaredBy,String ip) throws Exception{		
        PreparedStatement prpStmt = null;
        Connection connection=null;
        int n=0;
        try {
             connection=RwsOffices.getConn();
             double sac=Double.parseDouble(sanctionAmountChange);
             double am=Double.parseDouble(admnAmount);
             if(sac>am){
	             String hisdata="insert into RWS_WORK_ADMN_AMT_HIS_TBL values ( ?, ?, ?, sysdate, ?)";
	             prpStmt = connection.prepareStatement(hisdata);
	             prpStmt.setString(1, workId);
	             prpStmt.setString(2, admnAmount);
	             prpStmt.setString(3, preoaredBy);
	             prpStmt.setString(4, ip);
	             prpStmt.executeUpdate();
	             prpStmt.close();
             
	             String sqlQuery = "update rws_work_admn_tbl set SANCTION_AMOUNT= ? where work_id= ? ";
	             prpStmt = connection.prepareStatement(sqlQuery);
	             prpStmt.setString(1, sanctionAmountChange);
	             prpStmt.setString(2, workId);
	             n=prpStmt.executeUpdate();
	             prpStmt.close();
             }
             else{
            	 n=99;
             }
        } catch ( SQLException e ) {
            System.out.println("The SQL Exception is in Rws_sanction_Amount_Change_DAO updateSanctionAmount : " +e.getMessage());
            return n;
        }
        catch ( Exception e ){
        	System.out.println("The Exception is in Rws_sanction_Amount_Change_DAO updateSanctionAmount : " +e.getMessage());
            return n;
        }
        finally{
			if(prpStmt!=null)prpStmt.close();          	
            if(connection!=null)connection.close();
		}
		return n;
	}
	
	//Deepak Modified 
	public ArrayList getWorks(rws_works_WorkStatus_form bean) throws Exception	{       	
	   ArrayList customerList = new ArrayList();
       ResultSet rs=null;
       PreparedStatement prpStmt = null;
       Connection connection=null;
       try {
          	 	connection=RwsOffices.getConn();
          	 	String query="SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where work_id not in(select work_id from RWS_WORK_COMPLETION_TBL where DATE_OF_COMM is not null or DT_FIN_COMPLETION is not null) and " +
          		       " substr(OFFICE_CODE,2,2)='"+bean.getCircleCode()+"'" +
          		       " and substr(OFFICE_CODE,4,1)='"+bean.getDivCode()+"'" +
          		       " and PLAN_CODE ='"+bean.getPlan()+"'" +
					   " and AUG_NEW_CODE ='"+bean.getWrktype()+"'" +
					   " and CATEGORY_CODE='"+bean.getWorkCat()+"'";// and PREPARED_ON<>'31/MAY/2010'
          	 	if(bean.getProgram() != null && !bean.getProgram().equals(""))
          	 		query=query.concat("and PROGRAMME_CODE ='"+bean.getProgram()+"'");
          	 	if(bean.getSubprogram() != null && !bean.getSubprogram().equals(""))
          	 		query=query.concat("and SUBPROGRAMME_CODE ='"+bean.getSubprogram()+"'");
          	 	if(bean.getSubdivisioncode() != null && !bean.getSubdivisioncode().equals(""))
          	 		query=query.concat("and substr(OFFICE_CODE,5,2)='"+bean.getSubdivisioncode()+"'");
   	        	prpStmt = connection.prepareStatement(query);
   	            rs = prpStmt.executeQuery();
   	            while (rs.next()) {
   	             	bean=new rws_works_WorkStatus_form();
   	             	bean.setWorkId(rs.getString("work_id"));
   	             	bean.setWorkName(rs.getString("work_Name"));
   	             	customerList.add(bean);
   	            } 	             
   	       } catch ( SQLException e ) {
   	    	   System.out.println("The SQL Exception is in Rws_sanction_Amount_Change_DAO getWorks : " +e.getMessage());
               return null;
           } catch ( Exception e ){
        	   System.out.println("The Exception is in Rws_sanction_Amount_Change_DAO getWorks : " +e.getMessage());
               return null;
           }
           finally {
           		try {
           			if(prpStmt!=null)
           				prpStmt.close();
           			if(rs!=null)
           				rs.close();
           			if(connection!=null)
           				connection.close();
           	   }
           	catch(Exception e){
           		System.out.println("The Exception is in Rws_sanction_Amount_Change_DAO getWorks : " +e.getMessage());
           	}
   		   }
           return customerList;
       }
	
	//Deepak Modified 
	public ArrayList getWorks22(rws_works_WorkStatus_form bean,String userId) throws Exception {    	
       	   ArrayList customerList = new ArrayList();
           ResultSet rs=null;
           PreparedStatement prpStmt = null;
           Connection connection=null;
           try	{
        	   connection=RwsOffices.getConn();
        	   String query="SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where work_id not in(select work_id from RWS_WORK_COMPLETION_TBL where DATE_OF_COMM is not null or DT_FIN_COMPLETION is not null) and " +
          		       " substr(OFFICE_CODE,2,2)='"+bean.getCircleCode()+"'" +
          		       " and substr(OFFICE_CODE,4,1)='"+bean.getDivCode()+"'" +
          		       " and PLAN_CODE ='"+bean.getPlan()+"'" +
					   " and AUG_NEW_CODE ='"+bean.getWrktype()+"'" +
					   " and CATEGORY_CODE='"+bean.getWorkCat()+"'";
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
   	           rs = prpStmt.executeQuery();
   	           while (rs.next()){
   	             	bean=new rws_works_WorkStatus_form();
   	             	bean.setWorkId(rs.getString("work_id"));
   	             	bean.setWorkName(rs.getString("work_id")+" - "+rs.getString("work_Name"));
   	             	customerList.add(bean);
   	             }   	             
   	       } catch ( SQLException e ) {
               System.out.println("The SQL Exception is in Rws_sanction_Amount_Change_DAO getWorks22 : " +e.getMessage());
               return null;
           } catch ( Exception e ){
        	   System.out.println("The Exception is in Rws_sanction_Amount_Change_DAO getWorks22 : " +e.getMessage());
               return null;
           }
           finally {
           	try{
	           	 if(prpStmt!=null)
	           		 prpStmt.close();
	           	 if(rs!=null)
	           		 rs.close();
	             if(connection!=null)
	            	 connection.close();
           	   } catch(Exception e) {
           		   System.out.println("The Exception is in Rws_Sanction_Amount_Change_DAO getWorks22 : " +e.getMessage());
           		   return null;
           	   }
   		   }
           return customerList;
     }
	
	//Deepak Modified 
	public ArrayList getWorksForWorkProgress(rws_works_WorkStatus_form bean, String userId) {
		Connection conn = null;
		ArrayList customerList = new ArrayList();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where work_id not in(select work_id from RWS_WORK_COMPLETION_TBL where DATE_OF_COMM is not null or DT_FIN_COMPLETION is not null) and  "
					+ " substr(OFFICE_CODE,2,2)='" + bean.getCircleCode() + "'"
					+ " and substr(OFFICE_CODE,4,1)='" + bean.getDivCode() + "'"
					+ " and PLAN_CODE ='" + bean.getPlan() + "'"
					+ " and AUG_NEW_CODE ='" + bean.getWrktype() + "'"
					+ " and CATEGORY_CODE='" + bean.getWorkCat() + "'";
			if (bean.getProgram() != null && !bean.getProgram().equals(""))
				query = query.concat(" and PROGRAMME_CODE ='" + bean.getProgram() + "'");
			if (bean.getSubprogram() != null && !bean.getSubprogram().equals(""))
				query = query.concat(" and SUBPROGRAMME_CODE ='" + bean.getSubprogram() + "'");
			if (bean.getSubdivisioncode() != null && !bean.getSubdivisioncode().equals(""))
				query = query.concat(" and substr(OFFICE_CODE,5,2)='" + bean.getSubdivisioncode() + "'");
			if (bean.getSchemelist() != null && !bean.getSchemelist().equals(""))
				query = query.concat(" and TYPE_OF_ASSET  ='" + bean.getSchemelist() + "'");
			if (bean.getFinancialyear() != null	&& !bean.getFinancialyear().equals(""))
				query = query.concat(" and (admin_date>='01/APR/" + bean.getFinancialyear() + "' and admin_date<='31/MAR/" + (Integer.parseInt(bean.getFinancialyear()) + 1) + "')");
			query += " order by work_id";
			prpStmt = conn.prepareStatement(query);
			rs = prpStmt.executeQuery();
			while (rs.next()) {
				bean = new rws_works_WorkStatus_form();
				bean.setWorkId(rs.getString("work_id"));
				bean.setWorkName(rs.getString("work_id") + " - " + rs.getString("work_Name"));
				customerList.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("The SQL Exception is in Rws_Sanction_Amount_Change_DAO getWorksForWorkProgress : " + e.getMessage());
			return null;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Sanction_Amount_Change_DAO getWorksForWorkProgress : " + e.getMessage());
			return null;
		} finally {
			try {
				if (prpStmt != null)
					prpStmt.close();
				if (rs != null)
					rs.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Sanction_Amount_Change_DAO getWorksForWorkProgress : " + e.getMessage());
			}
		}
		return customerList;
	}
}
