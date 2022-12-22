/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;
import java.sql.Connection;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import java.util.*;



/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_BroData {
	DataSource dataSource;
	public Rws_BroData(){
		super();
	}
	public Rws_BroData(DataSource dataSource){
		this.dataSource=dataSource;
	}
	
	Statement stmt=null;
	ResultSet rs=null;
	
	// Code for Bro begins here
	
	public Rws_BroDetailsBean getBro(String BROId)
	{
		////ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT BRO_ID,BRO_REFERENCE," 
	        	+ " to_char(BRO_DATE,'dd/mm/yyyy') BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT," 
				+ " BRO_AMOUNT,fin_year,AMOUNT_REAPPROPRIATED,ADDITION_AMOUNT,gf,scp,tsp FROM rws_bro_master_tbl " 
				+ " where bro_id='"+BROId+"'";
	       // Debug.println("BRO MASTER"+sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);
	        if (rs.next())
            {
            	broDetails.setBro_id(rs.getString("bro_id"));
            	broDetails.setBro_reference(rs.getString("bro_reference"));
            	broDetails.setBro_date(rs.getString("bro_date"));
            	broDetails.setBro_budgetEstimate(rs.getString("budget_estimate"));
            	broDetails.setBro_sanctionAmount(rs.getString("sanction_amount"));
            	broDetails.setBro_amount(rs.getString("bro_amount"));
            	broDetails.setBro_financialYear(rs.getString("FIN_YEAR"));
            	
            	String appFlag = "";String appAmount = "";
            	//System.out.println("amount appropriated:"+rs.getString("AMOUNT_REAPPROPRIATED"));
            	if(rs.getString("AMOUNT_REAPPROPRIATED")!=null && !rs.getString("AMOUNT_REAPPROPRIATED").equals(""))
            	{
            		if(rs.getString("AMOUNT_REAPPROPRIATED").startsWith("-"))
            		{
            			appFlag = "-";
            			appAmount = rs.getString("AMOUNT_REAPPROPRIATED").substring(1,rs.getString("AMOUNT_REAPPROPRIATED").length());
            		}
            		else
            		{
            			appFlag = "+";
            			appAmount = rs.getString("AMOUNT_REAPPROPRIATED");
            		}
            	}
            	
            	
            	broDetails.setAppflag(appFlag);
            	broDetails.setBro_appAmount(appAmount);
            	broDetails.setBro_addAmount(rs.getString("ADDITION_AMOUNT"));
            	broDetails.setGf(rs.getString("gf"));
            	broDetails.setScp(rs.getString("scp"));
            	broDetails.setTsp(rs.getString("tsp"));
            }
	        /*else
	        {
	        	broDetails.setAppflag("");
            	broDetails.setBro_appAmount("");
            	broDetails.setBro_addAmount("");
	        }*/
        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBro" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broDetails;
	}
	public ArrayList getBroList()
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Rws_BroDetailsBean broDetails=null;
        ArrayList broDetailsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT BRO_ID,BRO_REFERENCE," 
	        	+ " to_char(BRO_DATE,'dd/mm/yyyy')BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT," 
				+ " BRO_AMOUNT,FIN_YEAR FROM rws_bro_master_tbl order by fin_year desc" ;
	        Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broDetails=new Rws_BroDetailsBean();
            	broDetails.setBro_id(rs.getString("bro_id"));
            	broDetails.setBro_reference(rs.getString("bro_reference"));
            	broDetails.setBro_date(rs.getString("bro_date"));
            	broDetails.setBro_budgetEstimate(rs.getString("budget_estimate"));
            	broDetails.setBro_sanctionAmount(rs.getString("sanction_amount"));
            	broDetails.setBro_amount(rs.getString("bro_amount"));
            	broDetails.setBro_financialYear(rs.getString("FIN_YEAR"));
            	broDetailsList.add(broDetails);
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBro" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broDetailsList;
	}
	
	public ArrayList getBroList(String financialYear)
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Statement stmt1=null,stmt2=null,stmt3=null;
        ResultSet rs1=null,rs2=null,rs3=null;
        ArrayList brolist=new ArrayList();
        ArrayList broproglist=new ArrayList();
        ArrayList locmast=new ArrayList();
        ArrayList locdet=new ArrayList();
        Rws_BroDetailsBean broDetails=null;
        Rws_BroProgDetailsBean broProgDetails=null;
        Rws_LocDetailsBean locDetails=null;
        Rws_LocProgDetailsBean locProgDetails=null;
        ArrayList broDetailsList=new ArrayList();
        try
		{
 
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            stmt1=conn.createStatement();
            stmt2=conn.createStatement();
            stmt3=conn.createStatement();
            String sqlQuery=null; 
            if(financialYear.equals(""))
            	sqlQuery = "SELECT BRO_ID,BRO_REFERENCE," 
	        	+ " to_char(BRO_DATE,'dd/mm/yyyy')BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT," 
				+ " BRO_AMOUNT,FIN_YEAR FROM rws_bro_master_tbl order by fin_year desc" ;
            else
            	sqlQuery = "SELECT BRO_ID,BRO_REFERENCE," 
    	        	+ " to_char(BRO_DATE,'dd/mm/yyyy')BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT," 
    				+ " BRO_AMOUNT,FIN_YEAR FROM rws_bro_master_tbl where fin_year='"+financialYear+"' order by fin_year desc" ;
               
	       // Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

	        //Hashtable ht= new Hashtable();
	        ArrayList aslist=new ArrayList();
            while (rs.next())
            {
            	broDetails=new Rws_BroDetailsBean();
            	aslist.add(rs.getString("bro_id"));
            	broDetails.setBro_id(rs.getString("bro_id"));
            	broDetails.setBro_reference(rs.getString("bro_reference"));
            	broDetails.setBro_date(rs.getString("bro_date"));
            	broDetails.setBro_budgetEstimate(rs.getString("budget_estimate"));
            	broDetails.setBro_sanctionAmount(rs.getString("sanction_amount"));
            	broDetails.setBro_amount(rs.getString("bro_amount"));
            	broDetails.setBro_financialYear(rs.getString("FIN_YEAR"));
            	broDetailsList.add(broDetails);
            	
            }
            brolist.add(broDetailsList);
            ////System.out.println("arraylist size: " +aslist.size());
            String qry=null;
            for(int i=0;i<aslist.size();i++)
            {
            	
             qry="SELECT BRO_ID,bro_det.PROGRAMME_CODE,HEAD_OF_ACCOUNT,BUDGET_ESTIMATE,B_E_YEAR,bro_det.quarter,AMT_ALREADY_AUTH,AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL,DRAWING_OFFICER,REMARKS,sp.SUBPROGRAMME_CODE,CENTER_STATE,p.programme_name,sp.SUBPROGRAMME_NAME  from rws_bro_details_tbl bro_det,rws_programme_tbl p,rws_subprogramme_tbl sp  where bro_id='"+aslist.get(i)+"' and bro_det.programme_code=p.programme_code" +
            	" and bro_det.PROGRAMME_CODE=p.programme_code and  bro_det.programme_code=sp.programme_code and bro_det.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE ";
             		
             //System.out.println("qry of htable:"+qry);
             
             rs1=stmt1.executeQuery(qry);
           while(rs1.next())
             { 
             	broProgDetails=new Rws_BroProgDetailsBean();
             	//System.out.println("111111");
             	broProgDetails.setBroId(rs1.getString("bro_id"));
             	broProgDetails.setProgrammeCode(rs1.getString("programme_code"));
             	//System.out.println("1.1");
             	broProgDetails.setProgrammeName(rs1.getString("programme_name"));
             	//System.out.println("1.2");
             	broProgDetails.setHeadOfAccount(rs1.getString("HEAD_OF_ACCOUNT"));
             	//System.out.println("1.3");
             	broProgDetails.setHeadOfAccountName(rs1.getString("HEAD_OF_ACCOUNT"));
            	//System.out.println("222222222");
            	broProgDetails.setBudgetEstimate(rs1.getString("budget_estimate"));
            	broProgDetails.setBudgetEstimateYear(rs1.getString("b_e_year"));
            	broProgDetails.setQuarter(rs1.getString("quarter"));
            	broProgDetails.setAmountAlreadyAuthorised(rs1.getString("AMT_ALREADY_AUTH"));
            	//System.out.println("33333333");
            	broProgDetails.setAmountNowAuthorised(rs1.getString("AMT_NOW_AUTH"));
            	broProgDetails.setProcedureForDrawl(rs1.getString("PROCEDURE_OF_DRAWAL"));
            	broProgDetails.setDrawingOfficer(rs1.getString("DRAWING_OFFICER"));
            	broProgDetails.setRemarks(rs1.getString("REMARKS"));
            	//System.out.println("4444444");
            	broProgDetails.setSubprogrammeCode(rs1.getString("SUBPROGRAMME_CODE"));
            	broProgDetails.setSubprogrammeName(rs1.getString("SUBPROGRAMME_NAME"));
            	broProgDetails.setSelects(rs1.getString("CENTER_STATE"));
            	//System.out.println("55555555");
            	broproglist.add(broProgDetails);
             }
           
           
            }
            brolist.add(broproglist);
            ArrayList locldlist=new ArrayList();
            for(int i=0;i<aslist.size();i++)
            {
            String qry1="select LOC_ID,LOC_REF,to_char(LOC_DATE,'dd/mm/yyyy')as LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF,DWA_AUTH_DATE,BRO_ID from rws_loc_master_tbl where bro_id='"+aslist.get(i)+"' ";
           // Debug.println("loc master qry:"+qry1);
            rs2=stmt.executeQuery(qry1);
            while(rs2.next())  
            {
            	locDetails=new Rws_LocDetailsBean();
            	locldlist.add(rs2.getString("LOC_ID"));
            	locDetails.setLocId(rs2.getString("LOC_ID"));
            	//System.out.println("1");
            	locDetails.setLocReference(rs2.getString("LOC_REF"));
            	//System.out.println("1.1");
            	locDetails.setLocRelDate(rs2.getString("LOC_DATE"));
            	//System.out.println("2");
            	locDetails.setLocAmount(rs2.getString("LOC_AMOUNT"));
            	//System.out.println("3");
            	locDetails.setDwaAuthorisationReference(rs2.getString("DWA_AUTH_REF"));
            	//System.out.println("4");
            	locDetails.setDwaAuthorisationDate(rs2.getString("DWA_AUTH_DATE"));
            	//System.out.println("5");
            	locDetails.setBroId(rs2.getString("BRO_ID"));
            	
            	locmast.add(locDetails);
            } 
            }  
            brolist.add(locmast); 
            HashSet h = new HashSet(locldlist);
        	locldlist =new ArrayList(h);
            for(int i=0;i<locldlist.size();i++)
            {  
              // System.out.println("loc:"+locldlist.get(i));
               //System.out.println("bro:"+aslist.get(i));
            	
            	/*Iterator It = h.iterator();
                while(It.hasNext())
                {
                	System.out.println("hash:"+It.next());
                }*/
            	String qry2="SELECT LOC_DET.LOC_ID,LOC_DET.DISTRICT_CODE,D.DNAME,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_CODE," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME,LOC_DET.BRO_ID " 
					+ " FROM rws_loc_details_tbl LOC_DET,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA " 
					+ " WHERE LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+) and LOC_DET.LOC_ID='"+locldlist.get(i)+"'";
            //Debug.println("loc prog qry:"+qry2);
            
            rs3=stmt3.executeQuery(qry2);
            while(rs3.next()) 
            {
            locProgDetails=new Rws_LocProgDetailsBean(); 
        	locProgDetails.setLocId(rs3.getString("loc_id")); 
            //System.out.println("0");
        	locProgDetails.setDistrict(rs3.getString("DISTRICT_CODE"));
        	//System.out.println("wsds");
        	locProgDetails.setDistrictName(rs3.getString("DNAME"));
        	//locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
        	//System.out.println("1");
        	locProgDetails.setProgramName(rs3.getString("programme_name"));
        	locProgDetails.setSubprogram(rs3.getString("SUBPROGRAMME_CODE"));
        	locProgDetails.setSubprogramName(rs3.getString("SUBPROGRAMME_NAME"));
        	locProgDetails.setLocAmount(rs3.getString("LOC_AMOUNT"));
        	locProgDetails.setOfficeFrom(rs3.getString("OFFICE_FROM_CODE"));
        	locProgDetails.setOffice(rs3.getString("OFFICE_TO_CODE"));
        	//System.out.println("2"); 
        	locProgDetails.setPlace(rs3.getString("PLACE"));
        	locProgDetails.setPaoApaoFlag(rs3.getString("PAO_CODE"));
        	locProgDetails.setRemarks(rs3.getString("REMARKS"));
        	locProgDetails.setHeadOfAccount(rs3.getString("HEAD_OF_ACCOUNT"));
        	locProgDetails.setHeadOfAccountName(rs3.getString("HEAD_OF_ACCOUNT_NAME"));
        	locProgDetails.setLocDate(rs3.getString("LOC_DATE"));
        	locProgDetails.setBroId(rs3.getString("BRO_ID"));
        	//System.out.println("3");
        	locdet.add(locProgDetails);
            }
            }
            brolist.add(locdet);
           
        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBro:" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return brolist;
	}
	
	public ArrayList getBroFinancialYearsList()
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Rws_BroDetailsBean broDetails=null;
        ArrayList broDetailsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT distinct FIN_YEAR  FROM rws_bro_master_tbl order by FIN_YEAR desc" ;
	        Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);
	        
            while (rs.next())
            {
            	broDetails=new Rws_BroDetailsBean();
            	broDetails.setBro_financialYear(rs.getString("FIN_YEAR"));
            	broDetailsList.add(broDetails);
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroFinancialYearsList" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broDetailsList;
	}
	public ArrayList getBroIdList()
	{
		////ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        ArrayList broIdList=new ArrayList();
        try
		{
            //System.out.println("in side getBroIDList");
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT distinct(BRO_ID) FROM rws_bro_master_tbl";
	        //Debug.println("GET BM DETAILS "+sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broIdList.add(rs.getString("bro_id"));
            	
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBro" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broIdList;
	}
	
	public ArrayList getBroIdList(String userId)
	{
		////ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        ArrayList broIdList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
            String sqlQuery="";
            if(userId.equals("100000"))
            	sqlQuery = "SELECT BRO_ID FROM rws_bro_master_tbl " ;
            else
            	sqlQuery = "SELECT distinct locMaster.BRO_ID FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locDet.OFFICE_TO_CODE ='"+userId+"'" ;
	        Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broIdList.add(rs.getString("bro_id"));
            	
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBro" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broIdList;
	}
	public ArrayList getBroProgDetails(String BROId)
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Rws_BroProgDetailsBean broProgDetails=null;
        ArrayList broProgDetailsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        /*String sqlQuery = "SELECT BRO_ID,bro_det.PROGRAMME_CODE," +
	        		"ha.HEAD_OF_ACCOUNT,BUDGET_ESTIMATE,B_E_YEAR," +
					"bro_det.quarter,"+
	        		"AMT_ALREADY_AUTH,AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL," +
	        		"DRAWING_OFFICER,REMARKS,SUBPROGRAMME_CODE,CENTER_STATE,p.programme_name,ha.HEAD_OF_ACCOUNT_NAME from rws_bro_details_tbl bro_det," +
	        		"rws_programme_tbl p,RWS_HEAD_OF_ACCOUNT_TBL ha  where bro_id='"+BROId+"' " +
	        		"and bro_det.programme_code=p.programme_code and ha.HEAD_OF_ACCOUNT = bro_det.HEAD_OF_ACCOUNT";  
	        		*/
            String sqlQuery = "SELECT BRO_ID,bro_det.PROGRAMME_CODE,HEAD_OF_ACCOUNT,BUDGET_ESTIMATE,B_E_YEAR,bro_det.quarter,AMT_ALREADY_AUTH,AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL,DRAWING_OFFICER,REMARKS,sp.SUBPROGRAMME_CODE,CENTER_STATE,p.programme_name,sp.SUBPROGRAMME_NAME  from rws_bro_details_tbl bro_det,rws_programme_tbl p,rws_subprogramme_tbl sp  where bro_id='"+BROId+"' and bro_det.programme_code=p.programme_code" +
            		" and bro_det.PROGRAMME_CODE=p.programme_code and  bro_det.programme_code=sp.programme_code and bro_det.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE ";
 	      
            rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broProgDetails=new Rws_BroProgDetailsBean();
            	broProgDetails.setBroId(BROId);
            	broProgDetails.setProgrammeCode(rs.getString("programme_code"));
            	broProgDetails.setProgrammeName(rs.getString("programme_name"));
            	broProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
            	broProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT"));
            	broProgDetails.setBudgetEstimate(rs.getString("budget_estimate"));
            	broProgDetails.setBudgetEstimateYear(rs.getString("b_e_year"));
            	broProgDetails.setQuarter(rs.getString("quarter"));
            	broProgDetails.setAmountAlreadyAuthorised(rs.getString("AMT_ALREADY_AUTH"));
            	broProgDetails.setAmountNowAuthorised(rs.getString("AMT_NOW_AUTH"));
            	broProgDetails.setProcedureForDrawl(rs.getString("PROCEDURE_OF_DRAWAL"));
            	broProgDetails.setDrawingOfficer(rs.getString("DRAWING_OFFICER"));
            	broProgDetails.setRemarks(rs.getString("REMARKS"));
            	broProgDetails.setSubprogrammeCode(rs.getString("SUBPROGRAMME_CODE"));
            	broProgDetails.setSubprogrammeName(rs.getString("SUBPROGRAMME_NAME"));
            	broProgDetails.setSelects(rs.getString("CENTER_STATE"));            	
            	broProgDetailsList.add(broProgDetails);
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroProgDetails" +e );
        }
        finally
		{
          //closeAll();
		}
        return broProgDetailsList;
	}
	
	public ArrayList getBroProgDetails()
	{
		
        Connection conn=null;
        Rws_BroProgDetailsBean broProgDetails=null;
        ArrayList broProgDetailsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT bro_det.BRO_ID,broMaster.BRO_REFERENCE,bro_det.PROGRAMME_CODE," +
	        		"ha.HEAD_OF_ACCOUNT,bro_det.BUDGET_ESTIMATE,bro_det.B_E_YEAR," +
					"bro_det.quarter,"+
	        		"bro_det.AMT_ALREADY_AUTH,bro_det.AMT_NOW_AUTH,bro_det.PROCEDURE_OF_DRAWAL," +
	        		"bro_det.DRAWING_OFFICER,bro_det.REMARKS,p.programme_name,ha.HEAD_OF_ACCOUNT_NAME from rws_bro_master_tbl broMaster,rws_bro_details_tbl bro_det," +
	        		"rws_programme_tbl p,RWS_HEAD_OF_ACCOUNT_TBL ha  " +
	        		"where broMaster.bro_id=bro_det.bro_id and bro_det.programme_code=p.programme_code and ha.HEAD_OF_ACCOUNT = bro_det.HEAD_OF_ACCOUNT order by bro_id";  

 	        Debug.println(sqlQuery);
            rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broProgDetails=new Rws_BroProgDetailsBean();
            	broProgDetails.setBroId(rs.getString("bro_id"));
            	broProgDetails.setBroReference(rs.getString("BRO_REFERENCE"));
            	broProgDetails.setProgrammeCode(rs.getString("programme_code"));
            	broProgDetails.setProgrammeName(rs.getString("programme_name"));
            	broProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
            	broProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME")+" - "+rs.getString("HEAD_OF_ACCOUNT"));
            	broProgDetails.setBudgetEstimate(rs.getString("budget_estimate"));
            	broProgDetails.setBudgetEstimateYear(rs.getString("b_e_year"));
            	broProgDetails.setQuarter(rs.getString("quarter"));
            	broProgDetails.setAmountAlreadyAuthorised(rs.getString("AMT_ALREADY_AUTH"));
            	broProgDetails.setAmountNowAuthorised(rs.getString("AMT_NOW_AUTH"));
            	broProgDetails.setProcedureForDrawl(rs.getString("PROCEDURE_OF_DRAWAL"));
            	broProgDetails.setDrawingOfficer(rs.getString("DRAWING_OFFICER"));
            	broProgDetails.setRemarks(rs.getString("REMARKS"));
            	broProgDetailsList.add(broProgDetails);
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroProgDetails" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
        return broProgDetailsList;
	}
	public String insertBroDetails(Rws_BroDetailsBean bean,ArrayList broProgDetailsList)throws Exception
	{

	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        String message=null;
        boolean recordInserted=true;
        try
			{
	        	conn=RwsOffices.getConn();
	        	//conn.setAutoCommit(false);
	            stmt=conn.createStatement();
	            String query="select count(*) from rws_bro_master_tbl where bro_id='"+bean.getBro_id()+"'";
	            Debug.println("query is "+query);
	            rs=stmt.executeQuery(query);
	            int res[];
	            boolean recordAlreadyExists=false;
	            while(rs.next())
	            {
	            	if(rs.getInt(1)>0)
	            		recordAlreadyExists=true;
	            }
	            
	            if(!recordAlreadyExists)
	            {
	            	String sqlQuery = "INSERT INTO rws_bro_master_tbl(BRO_ID,BRO_REFERENCE," 
	            		+ " BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT,BRO_AMOUNT,FIN_YEAR) values('"
						+ bean.getBro_id()+"','"+bean.getBro_reference()+"',to_date('"+bean.getBro_date()+"','dd/mm/yyyy'),'"
						+ bean.getBro_budgetEstimate()+"','"+bean.getBro_sanctionAmount()+"','"+bean.getBro_amount()+"','"+bean.getBro_financialYear()+"')";
	            	//Debug.println("query is "+sqlQuery);
	            	stmt.addBatch(sqlQuery);
	            	
	            	sqlQuery = "delete from rws_bro_details_tbl where bro_id='"+bean.getBro_id()+"'";
	            	Debug.println("query is "+sqlQuery);
	            	stmt.addBatch(sqlQuery);
	            	
	            	Rws_BroProgDetailsBean broProgDetailsBean=null;
	            	for(int i=0;i<broProgDetailsList.size();i++)
	            	{
	            		broProgDetailsBean=(Rws_BroProgDetailsBean)broProgDetailsList.get(i);
	            		
	            		if(!broProgDetailsBean.getProgrammeCode().equals("")&&!(broProgDetailsBean.getProgrammeCode()==null))
	            		{
	            		sqlQuery = "insert into rws_bro_details_tbl(BRO_ID," 
	            			+ "PROGRAMME_CODE,HEAD_OF_ACCOUNT," 
							+ "BUDGET_ESTIMATE,B_E_YEAR,QUARTER,AMT_ALREADY_AUTH," 
							+ "AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL," 
							+ "DRAWING_OFFICER,REMARKS)values ('"
							+ bean.getBro_id()+"','"+broProgDetailsBean.getProgrammeCode()+"','"
							+ broProgDetailsBean.getHeadOfAccount()+"','"
							+ broProgDetailsBean.getBudgetEstimate()+"','"
							+ broProgDetailsBean.getBudgetEstimateYear()+"','"
							+ broProgDetailsBean.getQuarter()+"','"
							+ broProgDetailsBean.getAmountAlreadyAuthorised()+"','"
							+ broProgDetailsBean.getAmountNowAuthorised()+"','"
							+ broProgDetailsBean.getProcedureForDrawl()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"')";
	            		Debug.println("query is "+sqlQuery);
	            		stmt.addBatch(sqlQuery);
	            		}
	            	}
	            	
	            	res=stmt.executeBatch();
	            	for(int i=0;i<res.length&&i!=1;i++)
	            	{
	            		if(res[i]<1)
	            		{
	            			message="Record Cannot be Inserted";
	            			recordInserted=false;
	            		}
	            	}
	            	if(recordInserted)
	            		message="Record Inserted Successfully";
		        }
	            else
	            {
	            	String sqlQuery = "update rws_bro_master_tbl" 
	            		+ " set BRO_REFERENCE='"+bean.getBro_reference()+"'," 
	            		+ " BRO_DATE=to_date('"+bean.getBro_date()+"','dd/mm/yyyy')," 
						+ " BUDGET_ESTIMATE='"+bean.getBro_budgetEstimate()+"'," 
						+ " SANCTION_AMOUNT='"+bean.getBro_sanctionAmount()+"'," 
						+ " BRO_AMOUNT='"+bean.getBro_amount()+"',"
						+ " FIN_YEAR='"+bean.getBro_financialYear()+"' where bro_id='"+bean.getBro_id()+"'";
						
	            	//Debug.println("query is "+sqlQuery);
	            	stmt.addBatch(sqlQuery);
	            	
	            	sqlQuery = "delete from rws_bro_details_tbl where bro_id='"+bean.getBro_id()+"'";
	            	//Debug.println("query is "+sqlQuery);
	            	stmt.addBatch(sqlQuery);
	            	
	            	Rws_BroProgDetailsBean broProgDetailsBean=null;
	            	for(int i=0;i<broProgDetailsList.size()-1;i++)
	            	{
	            		broProgDetailsBean=(Rws_BroProgDetailsBean)broProgDetailsList.get(i);
	            		if(!broProgDetailsBean.getProgrammeCode().equals("")&&!(broProgDetailsBean.getProgrammeCode()==null))
	            		{
	            		sqlQuery = "insert into rws_bro_details_tbl(BRO_ID," 
	            			+ "PROGRAMME_CODE,HEAD_OF_ACCOUNT," 
							+ "BUDGET_ESTIMATE,B_E_YEAR,QUARTER,AMT_ALREADY_AUTH," 
							+ "AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL," 
							+ "DRAWING_OFFICER,REMARKS)values ('"
							+ bean.getBro_id()+"','"+broProgDetailsBean.getProgrammeCode()+"','"
							+ broProgDetailsBean.getHeadOfAccount()+"','"
							+ broProgDetailsBean.getBudgetEstimate()+"','"
							+ broProgDetailsBean.getBudgetEstimateYear()+"','"
							+ broProgDetailsBean.getQuarter()+"','"
							+ broProgDetailsBean.getAmountAlreadyAuthorised()+"','"
							+ broProgDetailsBean.getAmountNowAuthorised()+"','"
							+ broProgDetailsBean.getProcedureForDrawl()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"')";
	            		Debug.println("query is "+sqlQuery);
	            		stmt.addBatch(sqlQuery);
	            		}
	            	}
	            	
	            	res=stmt.executeBatch();
	            	for(int i=0;i<res.length&&i!=1;i++)
	            	{
	            		if(res[i]<1)
	            		{
	            			message="Record Cannot be Updated";
	            			recordInserted=false;
	            		}
	            		
	            	}
	            	if(recordInserted)
	            		message="Record Updated Successfully";
	            }
	            if(recordInserted)
	           conn.setAutoCommit(true);
		 }catch(Exception e)
		 {
		 	Debug.println("Exception in insertBroDetails is "+e);
		 	message="Record Cannot be Inserted";
		 }
		 finally{if(conn!=null)conn.close();}
		 return message;
	}
	
	
	
	public ArrayList getQuarters(String bro_id)throws Exception {
	    
	    ////ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        String message=null;
        boolean recordInserted=true;
        Statement quarters;
        ResultSet quarterresults;
        conn=RwsOffices.getConn();
        ArrayList quarterlist=new ArrayList();
        String quarterquery="select quarter from rws_bro_details_tbl where bro_id='"+bro_id+"'";
        int i=0;
        try {
           quarters=conn.createStatement(ResultSet.CONCUR_UPDATABLE,ResultSet.TYPE_SCROLL_INSENSITIVE);
           quarterresults=quarters.executeQuery(quarterquery);
           while(quarterresults.next()) {
               quarterlist.add(i,quarterresults.getString(1));
               i++;
               
           }
        }
        catch(Exception exception){
            
            Debug.println("Error"+exception.toString());
        }
        finally{
        	try{
  	         
  			  if(conn!=null)conn.close();
  			} catch(Exception e)
  			{
  				e.printStackTrace();
  			}
        }
        Debug.println("Quarter query"+quarterquery);
        return quarterlist;
       
	    
	}
	 
	public DAOMessage insertBroDetails(Rws_BroDetailsBean bean,ArrayList broProgDetailsList,String mode)throws Exception
	{

	 	
        Connection conn=null;
        String message=null;
        boolean recordInserted=true;
        Statement programexist,updatealreadyexist;
        ResultSet programalreadyexist;
        Statement statforupdate=null;
        
        String programme_code,subprogramme_code,head_of_account,sqlQueryOfBro,beyear,sqlQuery="";
        int quarter;
        Rws_BroProgDetailsBean broProgDetailsBean=null;
        DAOMessage daoMessage=new DAOMessage();
        try
			{
	        	conn=RwsOffices.getConn();
	        	
	            stmt=conn.createStatement();
	            String query="select count(*) from rws_bro_master_tbl where bro_id='"+bean.getBro_id()+"'";
	            Debug.println("query is "+query);
	            rs=stmt.executeQuery(query);
	            boolean recordAlreadyExists=false;
	            String updatealreadyexistquery;
	        	
	            
	            while(rs.next())
	            {
	            	if(rs.getInt(1)>0)
	            		recordAlreadyExists=true;
	            }
	            if(mode!=null&&mode.equals("addNew")&&recordAlreadyExists)
	            {
	            	////closeAll();
	            	//conn.close();
	            	daoMessage.setMessage("Record with BRO Id "+bean.getBro_id()+" already Exists\\nRecord Cannot be inserted");
	            	daoMessage.setCode(-1);
	            	return daoMessage; 
	            } 
	            if(!recordAlreadyExists)
	            {
	            	Debug.println("gf:"+bean.getGf()+":scp:"+bean.getScp()+":tsp:"+bean.getTsp());
	            	 sqlQuery = "INSERT INTO rws_bro_master_tbl(BRO_ID,BRO_REFERENCE," 
	            		+ " BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT,BRO_AMOUNT,FIN_YEAR,AMOUNT_REAPPROPRIATED,ADDITION_AMOUNT,gf,scp,tsp) values('"
						+ bean.getBro_id()+"','"+bean.getBro_reference()+"',to_date('"+bean.getBro_date()+"','dd/mm/yyyy'),'"
						+ bean.getBro_budgetEstimate()+"','"+bean.getBro_sanctionAmount()+"','"+bean.getBro_amount()+"'," +
								"'"+bean.getBro_financialYear()+"','"+bean.getAppflag()+bean.getBro_appAmount()+"'," +
								"'"+bean.getBro_addAmount()+"','"+bean.getGf()+"','"+bean.getScp()+"','"+bean.getTsp()+"')";
	            	
	            	Debug.println("sqlQuery of bro master:"+sqlQuery); 
	            	 stmt.addBatch(sqlQuery);
	            	
	            	sqlQuery = "delete from rws_bro_details_tbl where bro_id='"+bean.getBro_id()+"'";
	            	stmt.addBatch(sqlQuery);
	                	  
	            	for(int i=0;i<broProgDetailsList.size();i++){
	            	    broProgDetailsBean=(Rws_BroProgDetailsBean)broProgDetailsList.get(i);
	            	    programme_code=broProgDetailsBean.getProgrammeCode();
	            	    subprogramme_code=broProgDetailsBean.getSubprogrammeCode();
	            	    head_of_account=broProgDetailsBean.getHeadOfAccount();
	            	    beyear=broProgDetailsBean.getBudgetEstimateYear();
	            	    quarter=Integer.parseInt(broProgDetailsBean.getQuarter());
	            	    //Debug.println("major:"+broProgDetailsBean.getMajorHead());
	            	    //Debug.println("submajor:"+broProgDetailsBean.getSubMajorHead());
	            	    //Debug.println("minor:"+broProgDetailsBean.getMinorHead());
	            	    //Debug.println("group:"+broProgDetailsBean.getGroupHead());
	            	    //Debug.println("subheaf:"+broProgDetailsBean.getSubHead());
	            	    //Debug.println("detail:"+broProgDetailsBean.getDetailHead());
	            	    //Debug.println("subdetail:"+broProgDetailsBean.getSubDetailHead());
	            	    if(!broProgDetailsBean.getProgrammeCode().equals(""))	{
	            	    	/*if(broProgDetailsBean.getSubMajorHead()!=null && broProgDetailsBean.getSubMajorHead().equals(""))
	            	    	{
	            	    		broProgDetailsBean.setSubMajorHead("00");
	            	    	}*/
	            	       sqlQuery = "insert into rws_bro_details_tbl(BRO_ID," 
	            			+ "PROGRAMME_CODE,HEAD_OF_ACCOUNT," 
							+ "BUDGET_ESTIMATE,B_E_YEAR,QUARTER,AMT_ALREADY_AUTH," 
							+ "AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL," //+ broProgDetailsBean.getAmountAlreadyAuthorised()+"','"
							+ "DRAWING_OFFICER,REMARKS,SUBPROGRAMME_CODE,CENTER_STATE)values ('"
							+ bean.getBro_id()+"','"+broProgDetailsBean.getProgrammeCode()+"','"
							+ broProgDetailsBean.getMajorHead() +"-"+broProgDetailsBean.getSubMajorHead()+"-"+broProgDetailsBean.getMinorHead()+
							"-"+broProgDetailsBean.getGroupHead()+"-"+broProgDetailsBean.getSubHead()+"-"+broProgDetailsBean.getDetailHead()+
							"-"+broProgDetailsBean.getSubDetailHead()+"','"
							+ broProgDetailsBean.getBudgetEstimate()+"','"
							+ broProgDetailsBean.getBudgetEstimateYear()+"','"
							+ broProgDetailsBean.getQuarter()+"','"+broProgDetailsBean.getAmountAlreadyAuthorised()+"','"																
							+ broProgDetailsBean.getAmountNowAuthorised()+"','"
							+ broProgDetailsBean.getProcedureForDrawl()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"','"
							+ broProgDetailsBean.getRemarks()+"','"+broProgDetailsBean.getSubprogrammeCode()+"','"+broProgDetailsBean.getSelects()+"')";
	            		
	            	    }
	            	    stmt.addBatch(sqlQuery);
	            	    Debug.println("BRO DETAILS SQL QUERY   "+sqlQuery);
	            	}
	            	
	            	

					int resu[]=stmt.executeBatch();
			    	for(int i=0;i<resu.length&&i!=1;i++) 	{
            		if(resu[i]<1) {
            			message="Record Cannot be Inserted";
            			daoMessage.setCode(-1);
            			daoMessage.setMessage(message);
            			recordInserted=false;
            		}
                 	}
			    	
			    	if(recordInserted){
			    	    message="Record Inserted Successfully";
			    	    daoMessage.setCode(1);
			    	    daoMessage.setMessage(message);
			    	    return daoMessage;
			    	}
	            }	
	            else{ 
	                
	            	 sqlQuery = "update rws_bro_master_tbl" 
	            		+ " set BRO_REFERENCE='"+bean.getBro_reference()+"'," 
	            		+ " BRO_DATE=to_date('"+bean.getBro_date()+"','dd/mm/yyyy')," 
						+ " BUDGET_ESTIMATE='"+bean.getBro_budgetEstimate()+"'," 
						+ " SANCTION_AMOUNT='"+bean.getBro_sanctionAmount()+"'," 
						+ " BRO_AMOUNT='"+bean.getBro_amount()+"',"
						+ " FIN_YEAR='"+bean.getBro_financialYear()+"',"
						+ " AMOUNT_REAPPROPRIATED = '"+bean.getAppflag()+""+bean.getBro_appAmount()+"',"
						+ " ADDITION_AMOUNT = '"+bean.getBro_addAmount()+"',"
						+ " gf= '"+bean.getGf()+"',"
						+ " scp= '"+bean.getScp()+"',"
						+ " tsp= '"+bean.getTsp()+"'"
						+  " where bro_id='"+bean.getBro_id()+"'";
						
	            //Debug.println("query is "+sqlQuery);
	            	stmt.addBatch(sqlQuery);
	            	//Debug.println("LENGTH OF COOKIE"+brodetails.length);
	            	int deletecount=0;
	            	
	            	int deletedbrocount=0;
	            	int dcount=0;
	            	int brocount=0;
	        	
		            sqlQuery="delete from rws_bro_details_tbl where bro_id='"+bean.getBro_id()+"'";
		        	stmt.addBatch(sqlQuery);
		        	
	            	for(int i=0;i<broProgDetailsList.size();i++){
	            		broProgDetailsBean=(Rws_BroProgDetailsBean)broProgDetailsList.get(i);
	            		
	            		programme_code=broProgDetailsBean.getProgrammeCode();
	            	    subprogramme_code=broProgDetailsBean.getSubprogrammeCode();
	            	    head_of_account=broProgDetailsBean.getHeadOfAccount();
	            	    beyear=broProgDetailsBean.getBudgetEstimateYear();
	            	    quarter=Integer.parseInt(broProgDetailsBean.getQuarter());
		            	
		        	   sqlQueryOfBro="select nvl(sum(AMT_NOW_AUTH),0.0)  from rws_bro_details_tbl where  programme_code='"+programme_code+
	            	    "' and subprogramme_code='"+subprogramme_code+"' and head_of_account='"+head_of_account+"' and b_e_year='"+beyear+"'";
	          		
	            		if(!broProgDetailsBean.getProgrammeCode().equals(""))
	            		{   
	            		sqlQuery = "insert into rws_bro_details_tbl(BRO_ID,"  
	            			+ "PROGRAMME_CODE,HEAD_OF_ACCOUNT," 
							+ "BUDGET_ESTIMATE,B_E_YEAR,QUARTER," 
							+ "AMT_ALREADY_AUTH,AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL," 
							+ "DRAWING_OFFICER,REMARKS,SUBPROGRAMME_CODE,CENTER_STATE)values ('"
							+ bean.getBro_id()+"','"+broProgDetailsBean.getProgrammeCode()+"','"
							+ broProgDetailsBean.getMajorHead() +"-"+broProgDetailsBean.getSubMajorHead()+"-"+broProgDetailsBean.getMinorHead()+
							"-"+broProgDetailsBean.getGroupHead()+"-"+broProgDetailsBean.getSubHead()+"-"+broProgDetailsBean.getDetailHead()+
							"-"+broProgDetailsBean.getSubDetailHead()+"','"
							//+ broProgDetailsBean.getHeadOfAccount()+"','"
							+ broProgDetailsBean.getBudgetEstimate()+"','"
							+ broProgDetailsBean.getBudgetEstimateYear()+"','"
							+ broProgDetailsBean.getQuarter()+"','" 
							+ broProgDetailsBean.getAmountAlreadyAuthorised()+"','"							
							+ broProgDetailsBean.getAmountNowAuthorised()+"','"
							+ broProgDetailsBean.getProcedureForDrawl()+"','"
							+ broProgDetailsBean.getDrawingOfficer()+"','"
							+ broProgDetailsBean.getRemarks()+"','"+broProgDetailsBean.getSubprogrammeCode()+"','"+broProgDetailsBean.getSelects()+"')";
	            		stmt.addBatch(sqlQuery);	
	            		Debug.println("QUERY IS"+sqlQuery);
	            		}
	            	}
	            	
	            	
	            	
	            	}	
	            	int res11[];
	           	res11=stmt.executeBatch();
	            	for(int i=0;i<res11.length&&i!=1;i++){
	            		if(res11[i]<1){
	            			message="Record Cannot be Updated";
	            			daoMessage.setCode(-1);
	            			daoMessage.setMessage(message);
	            			recordInserted=false;
	            		}
	            	}
	            	if(recordInserted){
	            		message="BRO details Record Updated Successfully";
	            		daoMessage.setCode(1);
	            		daoMessage.setMessage(message);
	            	}
	            } catch(Exception e)
		 {
		 
		     e.printStackTrace();
		 	return daoMessage;
		 }
		finally
			{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
		 return daoMessage;
		
	}
	 public String deleteBroDetails(String BROId)throws Exception
	 {

		 	////ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String message=null;
	        boolean recordDeleted=false;
	        try
				{
		        	conn=RwsOffices.getConn();
		        	
		        	Statement ss = conn.createStatement();		
		        	ResultSet rs = ss.executeQuery("Select * from rws_loc_master_tbl where bro_id='"+BROId+"'");
		        	if(rs.next())
		        	{
		        		message="Cannot Delete! LOC Details Having with this BROID !!";
		        	}
		        	else
		        	{
		        		//conn.setAutoCommit(false);
			            stmt=conn.createStatement();
			            
			            
			            	
			            	String sqlQuery = "delete from rws_bro_details_tbl where bro_id='"+BROId+"'";
			            	
								
			            	Debug.println("query is "+sqlQuery);
			            	stmt.addBatch(sqlQuery);
			            	
			            	sqlQuery = "delete from rws_bro_master_tbl where bro_id='"+BROId+"'";
			            	
			            	Debug.println("query is "+sqlQuery);
			            	stmt.addBatch(sqlQuery);
			            	
			            	
			            	int res[]=stmt.executeBatch();
			            	if(res[0]>0)
			            	{
			            		message="Record Deleted Successfully";
			            		recordDeleted=true;
			            	}
			            	
			          
			           //if(recordDeleted)
			          // conn.setAutoCommit(true);
		        	}
		        	
			 }catch(Exception e)
			 {
			 	Debug.println("Exception in deleteBroDetails is "+e);
			 	message="Record Cannot be Deleted";
			 }
			 finally{if(conn!=null)conn.close();}
			 return message;
		}
	 public String getProgrammeName(String programmeCode)
		{
			////ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String programmeName="";
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT programme_code,programme_name" 
		        	+ " from rws_programme_tbl where programme_code='"+programmeCode+"'"; 
					
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	programmeName=rs.getString("programme_name");
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getProgrammeName" +e );
	        }
	        finally
			{
	        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
			}
	        return programmeName;
		}
	 
	 public ArrayList getBROReferenceList()
		{
			////ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        ArrayList broReferenceList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT bro_reference FROM rws_BRO_master_tbl " ;
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	broReferenceList.add(rs.getString("bro_reference"));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getBROReferenceList" +e );
	        }
	        finally
			{try{
	          if(rs!=null)rs.close();
	          if(stmt!=null)stmt.close();
			  if(conn!=null)conn.close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			}
	        return broReferenceList;
		}
	 
	 //code for BRO Ends here
	 
	 //code from Loc Starts here
	 public ArrayList getLocIdList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        ArrayList locIdList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT distinct LOC_ID FROM rws_LOC_master_tbl " ;
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	locIdList.add(rs.getString("loc_id"));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocIdList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locIdList;
		}
	 
	 public ArrayList getLocIdList(String broId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        ArrayList locIdList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT distinct LOC_ID FROM rws_LOC_master_tbl where bro_id = '"+broId+"'" ;
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	locIdList.add(rs.getString("loc_id"));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocIdList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locIdList;
		}
	 
	 public ArrayList getLocIdList(String broId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	   //     Debug.println("BRO Id:"+broId);
	        ArrayList locIdList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery ="";
	             /*
	            if(userId.equals("100000"))
		        	sqlQuery = "SELECT LOC_ID FROM rws_LOC_master_tbl where bro_id = '"+broId+"'" ;
		        else
		        	sqlQuery = "SELECT locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_FROM_CODE ='"+userId+"'" ;
		        */
	            if(userId.equals("100000")){
		        	/*sqlQuery = "select distinct locMaster.LOC_ID FROM " 
		        		+ " rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet" 
						+ " where locMaster.loc_id=locDet.loc_id and " 
						+ " locMaster.bro_id = '"+broId+"' and " 
						+ " locDet.OFFICE_FROM_CODE='"+userId+"' union " 
						+ " select loc_id from rws_loc_master_tbl " 
						+ " where loc_id not in(select loc_id from " 
						+ " rws_loc_details_tbl)" ;*/
	            	sqlQuery = "select distinct locMaster.LOC_ID FROM " 
		        		+ " rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet" 
						+ " where locMaster.loc_id=locDet.loc_id and " 
						+ " locMaster.bro_id = '"+broId+"' and " 
						+ " locDet.OFFICE_FROM_CODE='"+userId+"'" ;
	            }
		        else{
		        	
		        	sqlQuery = "SELECT distinct locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"'" ;
					
		        	/*
		        	sqlQuery = "SELECT distinct locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"'" ;
					*/
		        
		        }
		       
		        Debug.println("loc id getting query:"+sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	locIdList.add(rs.getString("loc_id"));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocIdList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locIdList;
		}
	 
	 
	 public ArrayList getCircleLocIdList(String broId,String locId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        ArrayList circleLocIdList=new ArrayList();
	        try
			{
	            Debug.println("In get Cirlce LocId List");

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery ="";
		        /*
	            if(userId.equals("100000"))
		        	sqlQuery = "SELECT LOC_ID FROM rws_LOC_master_tbl where bro_id = '"+broId+"'" ;
		        else
		        	sqlQuery = "SELECT locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_FROM_CODE ='"+userId+"'" ;
		        */
	            if(userId.equals("100000")){
		        	sqlQuery = "select distinct locMaster.LOC_ID FROM " 
		        		+ " rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet" 
						+ " where locMaster.loc_id=locDet.loc_id and " 
						+ " locMaster.bro_id = '"+broId+"' and " 
						+ " locDet.OFFICE_FROM_CODE='"+userId+"' union " 
						+ " select loc_id from rws_loc_master_tbl " 
						+ " where loc_id not in(select loc_id from " 
						+ " rws_loc_details_tbl)" ;
	            }
		        else
		        {
		        	
		        	sqlQuery = "SELECT distinct locDet.CIRCLE_LOC_ID  FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_FROM_CODE ='"+userId+"'" 
						+ " AND locMaster.loc_id='"+locId+"'" ;
					
		        	/*
		        	sqlQuery = "SELECT distinct locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"'" ;
					*/
		        
		        }
		       
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	circleLocIdList.add(rs.getString(1));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocIdList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return circleLocIdList;
		}
	 
	 
	 public ArrayList getCircleLocIdToDivisionList(String broId,String locId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        ArrayList circleLocIdList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery ="";
		        /*
	            if(userId.equals("100000"))
		        	sqlQuery = "SELECT LOC_ID FROM rws_LOC_master_tbl where bro_id = '"+broId+"'" ;
		        else
		        	sqlQuery = "SELECT locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_FROM_CODE ='"+userId+"'" ;
		        */
	           
		        	sqlQuery = "SELECT distinct locDet.CIRCLE_LOC_ID  FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"'" 
						+ " AND locMaster.loc_id='"+locId+"' and locDet.CIRCLE_LOC_ID IS NOT NULL" ;
					
		        	/*
		        	sqlQuery = "SELECT distinct locMaster.LOC_ID FROM rws_LOC_master_tbl locMaster," 
		        		+ " rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
						+ " and locMaster.bro_id = '"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"'" ;
					*/
		        
		       
		       
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	circleLocIdList.add(rs.getString(1));
	            	
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocIdList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return circleLocIdList;
		}
	 
	 public String insertLocDetails(Rws_LocDetailsBean bean,ArrayList locProgDetailsList)throws Exception
		{

		 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String message=null;
	        boolean recordInserted=true;
	        try
				{
		        	conn=RwsOffices.getConn();
		        	conn.setAutoCommit(false);
		            stmt=conn.createStatement();
		            String query="select count(*) from rws_loc_master_tbl where loc_id='"+bean.getLocId()+"'";
		            Debug.println("query is "+query);
		            rs=stmt.executeQuery(query);
		            boolean recordAlreadyExists=false;
		            while(rs.next())
		            {
		            	if(rs.getInt(1)>0)
		            		recordAlreadyExists=true;
		            }
		            
		            if(!recordAlreadyExists)
		            {
		            	String sqlQuery = "INSERT INTO rws_loc_master_tbl(LOC_ID,LOC_REF," 
		            		+ " LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF,DWA_AUTH_DATE,BRO_ID) values('"
							+ bean.getLocId()+"','"+bean.getLocReference()+"',to_date('"+bean.getLocRelDate()+"','dd/mm/yyyy'),'"
							+ bean.getLocAmount()+"','"+bean.getDwaAuthorisationReference()+"','"+bean.getDwaAuthorisationDate()+"','"+bean.getBroId()+"')";
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+bean.getLocId()+"'";
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	Rws_LocProgDetailsBean locProgDetailsBean=null;
		            	for(int i=0;i<locProgDetailsList.size();i++)
		            	{
		            		locProgDetailsBean=(Rws_LocProgDetailsBean)locProgDetailsList.get(i);
		            		if(!locProgDetailsBean.getProgram().equals(""))
		            		{
		            		sqlQuery = "insert into rws_loc_details_tbl(Loc_ID," 
		            			+ "DISTRICT_CODE,PROGRAMME_CODE," 
								+ "SUBPROGRAMME_CODE,HEAD_OF_ACCOUNT ,LOC_AMOUNT,OFFICE_FROM_CODE," 
								+ "PLACE ,PAO_code," 
								+ "REMARKS)values ('"
								+ bean.getLocId()+"','"+locProgDetailsBean.getDistrict()+"','"
								+ locProgDetailsBean.getProgram()+"','"
								+ locProgDetailsBean.getSubprogram()+"','"
								+ locProgDetailsBean.getHeadOfAccount()+"','"
								+ locProgDetailsBean.getLocAmount()+"','"
								+ locProgDetailsBean.getOffice()+"','"
								+ locProgDetailsBean.getPlace()+"','"
								+ locProgDetailsBean.getPaoApaoFlag()+"','"
								+ locProgDetailsBean.getRemarks()+"'"
								+")";
		            		Debug.println("query is "+sqlQuery);
		            		stmt.addBatch(sqlQuery);
		            		}
		            	}
		            	
		            	int res[]=stmt.executeBatch();
		            	for(int i=0;i<res.length&&i!=1;i++)
		            	{
		            		if(res[i]<1)
		            		{
		            			message="Record Cannot be Inserted";
		            			recordInserted=false;
		            		}
		            	}
		            	if(recordInserted)
		            		message="Record Inserted Successfully";
			        }
		            else
		            {
		            	String sqlQuery = "update rws_loc_master_tbl" 
		            		+ " set LOC_REF ='"+bean.getLocReference()+"'," 
		            		+ " LOC_DATE =to_date('"+bean.getLocRelDate()+"','dd/mm/yyyy')," 
							+ " LOC_AMOUNT='"+bean.getLocAmount()+"'," 
							+ " DWA_AUTH_REF ='"+bean.getDwaAuthorisationReference()+"'," 
							+ " DWA_AUTH_DATE=to_date('"+bean.getDwaAuthorisationDate()+"','dd/mm/yyyy')," 
							+ " BRO_ID ='"+bean.getBroId()+"' where loc_id='"+bean.getLocId()+"'";
							
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+bean.getLocId()+"'";
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	Rws_LocProgDetailsBean locProgDetailsBean=null;
		            	for(int i=0;i<locProgDetailsList.size();i++)
		            	{
		            		locProgDetailsBean=(Rws_LocProgDetailsBean)locProgDetailsList.get(i);
		            		if(!locProgDetailsBean.getProgram().equals(""))
		            		{
		            		sqlQuery = "insert into rws_loc_details_tbl(Loc_ID," 
		            			+ "DISTRICT_CODE,PROGRAMME_CODE," 
								+ "SUBPROGRAMME_CODE,HEAD_OF_ACCOUNT ,LOC_AMOUNT,OFFICE_FROM_CODE," 
								+ "PLACE ,PAO_CODE," 
								+ "REMARKS)values ('"
								+ bean.getLocId()+"','"+locProgDetailsBean.getDistrict()+"','"
								+ locProgDetailsBean.getProgram()+"','"
								+ locProgDetailsBean.getSubprogram()+"','"
								+ locProgDetailsBean.getHeadOfAccount()+"','"
								+ locProgDetailsBean.getLocAmount()+"','"
								+ locProgDetailsBean.getOffice()+"','"
								+ locProgDetailsBean.getPlace()+"','"
								+ locProgDetailsBean.getPaoApaoFlag()+"','"
								+ locProgDetailsBean.getRemarks()+"'"
								+")";
		            		Debug.println("query is "+sqlQuery);
		            		stmt.addBatch(sqlQuery);
		            		}
		            	}
		            	
		            	int res[]=stmt.executeBatch();
		            	for(int i=0;i<res.length&&i!=1;i++)
		            	{
		            		if(res[i]<1)
		            		{
		            			message="Record Cannot be Updated";
		            			recordInserted=false;
		            		}
		            		
		            	}
		            	if(recordInserted)
		            		message="Record Updated Successfully";
		            }
		            if(recordInserted)
		           conn.setAutoCommit(true);
			 }catch(Exception e)
			 {
			 	Debug.println("Exception in insertLocDetails is "+e);
			 	message="Record Cannot be Inserted";
			 }
			 finally
				{
		        	try{
			  	          if(rs!=null)rs.close();
			  	          if(stmt!=null)stmt.close();
			  			  if(conn!=null)conn.close();
			  			} catch(Exception e)
			  			{
			  				e.printStackTrace();
			  			}
				}
			
			 return message;
		}
	 
	 public ArrayList getLocList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocDetailsBean locDetails=null;
	        ArrayList locDetailsList=new ArrayList();
	        try
			{

	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT LOC_ID,LOC_REF," 
		        	+ " to_char(LOC_DATE,'dd/mm/yyyy')LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF," 
					+ " to_char(DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE,BRO_ID  FROM rws_LOC_master_tbl " ;
		        Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	locDetails=new Rws_LocDetailsBean();
	            	locDetails.setLocId(rs.getString("LOC_ID"));
	            	locDetails.setLocReference(rs.getString("LOC_REF"));
	            	locDetails.setLocRelDate(rs.getString("LOC_DATE"));
	            	locDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locDetails.setDwaAuthorisationReference(rs.getString("DWA_AUTH_REF"));
	            	locDetails.setDwaAuthorisationDate(rs.getString("DWA_AUTH_DATE"));
	            	locDetails.setBroId(rs.getString("BRO_ID"));
	            	locDetailsList.add(locDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locDetailsList;
		}
	 
	 public ArrayList getLocList(String userId,String officeType,String broid,String locid)
		{
		     Connection conn=null;
	        Rws_LocDetailsBean locDetails=null;
	        ArrayList locDetailsList=new ArrayList();
	        if(broid==null){
	            broid="";
	        }
	        try
			{
	        	Debug.println("officeType:"+officeType);
	        	conn=RwsOffices.getConn();
	        	stmt=conn.createStatement();
	        	String sqlQuery ="";
	        	if(broid.length()>0){ 
	        	if(officeType.equals("Head Office"))
	        	{
	        		sqlQuery = "SELECT LOC_ID,LOC_REF," 
	        			+ " to_char(LOC_DATE,'dd/mm/yyyy')LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF," 
						+ " to_char(DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE,BRO_ID  FROM rws_LOC_master_tbl where bro_id='"+broid+"'" ;
	        		if(locid!=null && !locid.equals(""))
	        		{ sqlQuery+=" and loc_id='"+locid+"' "; }	
	        	}
	        	else if(officeType.equals("Circle Office"))
	        	{
	        		sqlQuery = " SELECT distinct locDet.office_from_code," +
					" locDet.office_to_code,locMaster.LOC_ID," +
					" locDet.circle_loc_id,locMaster.LOC_REF," +
					" to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE," +
					" locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," +
					" to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," +
					" locMaster.BRO_ID  FROM rws_LOC_master_tbl locMaster," +
					" rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " +
					" and OFFICE_FROM_CODE ='"+userId+"'  and bro_id='"+broid+"'";
	        	}
	        	else if(officeType.equals("Division Office"))
	        	{
	        		sqlQuery = "SELECT LOC_ID,LOC_REF," 
	        			+ " to_char(LOC_DATE,'dd/mm/yyyy')LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF," 
						+ " to_char(DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE,BRO_ID  FROM rws_LOC_master_tbl and bro_id='"+broid+"' " ;
	        	}
	        	}
	        	else{
	        	    if(officeType.equals("Head Office"))
		        	{
		        		sqlQuery = "SELECT LOC_ID,LOC_REF," 
		        			+ " to_char(LOC_DATE,'dd/mm/yyyy')LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF," 
							+ " to_char(DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE,BRO_ID  FROM rws_LOC_master_tbl ";
		        		
		        		if(locid!=null && !locid.equals(""))
		        		{ sqlQuery+=" where  loc_id='"+locid+"' "; }	
		        	}
		        	else if(officeType.equals("Circle Office"))
		        	{
		        		sqlQuery = " SELECT distinct locDet.office_from_code," +
						" locDet.office_to_code,locMaster.LOC_ID," +
						" locDet.circle_loc_id,locMaster.LOC_REF," +
						" to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE," +
						" locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," +
						" to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," +
						" locMaster.BRO_ID  FROM rws_LOC_master_tbl locMaster," +
						" rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " +
						" and OFFICE_FROM_CODE ='"+userId+"'";
		        	}
		        	else if(officeType.equals("Division Office"))
		        	{
		        		sqlQuery = "SELECT LOC_ID,LOC_REF," 
		        			+ " to_char(LOC_DATE,'dd/mm/yyyy')LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF," 
							+ " to_char(DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE,BRO_ID  FROM rws_LOC_master_tbl " ;
		        		
		        	}
		        	
	        	}
	        	Debug.println("***************************:"+sqlQuery);
	        	rs = stmt.executeQuery(sqlQuery);
	        	while (rs.next())
	        	{
	        		locDetails=new Rws_LocDetailsBean();
	        		locDetails.setLocId(rs.getString("LOC_ID"));
	        		locDetails.setLocReference(rs.getString("LOC_REF"));
	        		locDetails.setLocRelDate(rs.getString("LOC_DATE"));
	        		locDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	        		locDetails.setDwaAuthorisationReference(rs.getString("DWA_AUTH_REF"));
	        		locDetails.setDwaAuthorisationDate(rs.getString("DWA_AUTH_DATE"));
	        		locDetails.setBroId(rs.getString("BRO_ID"));
	        		if(officeType.equals("Circle Office"))
	        		{
	        			locDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
	        		}
	        		locDetailsList.add(locDetails);
	        	}
	        	
	        	
			} 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocList" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locDetailsList;
		}
	 public ArrayList getLocProgDetails(String LOCId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT LOC_DET.DISTRICT_CODE,D.DNAME,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_CODE," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME " 
					+ " FROM rws_loc_details_tbl LOC_DET,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA " 
					+ " WHERE LOC_DET.LOC_ID='"+LOCId+"' AND LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+)";  

	 	        Debug.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(LOCId);
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_CODE"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	Debug.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	if(locProgDetails.getOffice()!=null&&!locProgDetails.getOffice().substring(3,6).equals("000"))
		            {
		            		locProgDetails.setOfficeList(divisionsList);
		            		locProgDetails.setProject("on");
		            }
		            else
		            {
		            		locProgDetails.setOfficeList(circlesList);
		            		locProgDetails.setProject("off");
		            }
	            	
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locProgDetailsList;
		}
	 
	 public ArrayList getLocProgDetailsViewList(String broId,String locId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource); 
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try  
			{  System.out.println("in method");
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery="select  DISTRICT_CODE,p.PROGRAMME_CODE,sp.SUBPROGRAMME_CODE,remarks,d.dname,ld.loc_id,p.programme_name,sp.subprogramme_name,head_of_account,pao.pao_name,to_char(ld.loc_date,'dd/mm/yyyy')loc_date,ld.loc_amount,place,OFFICE_TO_CODE,OFFICE_FROM_CODE,pao.PAO_CODE from rws_loc_details_tbl ld,rws_loc_master_tbl lm,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_district_tbl d,rws_pao_tbl pao where ld.loc_id=lm.loc_id and  p.programme_code=ld.programme_code and p.programme_code=sp.programme_code and sp.subprogramme_code=ld.subprogramme_code and d.dcode=ld.district_code and "+
	            " ld.pao_code=pao.pao_code and d.dcode=pao.dcode and  lm.bro_id='"+broId+"' and ld.loc_id='"+locId+"' and office_from_code='"+userId+"' ";

	 	        System.out.println("qry on ..."+sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);  

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(locId);
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name")); 
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	Debug.println("111111111111.@@@@@@@");
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	Debug.println("111111111111.$$$$$$$$$$$$$$");
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	Debug.println("111111111111.%%%%%%%%%%");
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	Debug.println("111111111111.!!!!!!!!!!!");
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	Debug.println("111111111111.**************");
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	Debug.println("111111111111.111111111");
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_CODE"));
	            	locProgDetails.setPaoName(rs.getString("PAO_NAME"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	Debug.println("111111111111.222222222");
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE")); 
	            	locProgDetails.setOfficeList(divisionsList);
		       		locProgDetails.setOfficeList(circlesList);
		        	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locProgDetailsList;
		}
	 
	 
	 
	 
	 public ArrayList getLocProgDetails(String LOCId,String userId,String cicode,String bro_id)
		{
			//Debug.println("in getLocProgDetails()");
	 		//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT LOC_DET.DISTRICT_CODE,LOC_DET.CIRCLE_LOC_ID,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_CODE," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME,loc_det.WORK_ID,ww.work_name,WORK_DESC,PROJECT  " 
					+ " FROM rws_loc_details_tbl LOC_DET,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA,rws_work_admn_tbl ww  " 
					+ " WHERE LOC_DET.DISTRICT_CODE(+)=D.DCODE AND LOC_DET.LOC_ID='"+LOCId+"' and LOC_DET.BRO_ID='"+bro_id+"' AND LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) " 
					+ " AND  " 
					+ " LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+) AND loc_det.OFFICE_FROM_CODE='"+userId+"' and loc_det.work_id = ww.work_id(+) order by loc_det.district_code";  

	 	       Debug.println("getLocProgDetails query::"+sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            String work_id = "",project="";
	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	project = rs.getString("PROJECT");
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(LOCId);
	            	locProgDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_CODE"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	work_id = rs.getString("WORK_ID");
	            	if(work_id != null){
	            	if(work_id.equals("null")) {
	            		work_id="";
	            	}
	            	}
	            	locProgDetails.setWorkId(work_id);
	            	locProgDetails.setWorkName(rs.getString("work_name"));
	            	locProgDetails.setWorkDesc(rs.getString("WORK_DESC"));
	            	
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	//Debug.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	
	            	if(project !=null && project.equals("Y"))
            		{
            			locProgDetails.setProject("on");
            		}
            		else
            		{
            			locProgDetails.setProject("off");
            		}
	            	if(userId.equals("100000"))
	            	{
	            		if(project !=null && project.equals("Y"))
	            		{
	            			locProgDetails.setOfficeList(divisionsList);
	            			locProgDetails.setProject("on");
	            		}
	            		else
	            		{
	            			locProgDetails.setOfficeList(circlesList);
	            			locProgDetails.setProject("off");
	            		}
	            	}
	            	else
	            	{
	            		locProgDetails.setOfficeList(getLowerOffices(userId));
	            		
	            	}
	            	
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocProgDetails********" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        //Debug.println("end of getLocProgDetails");
	        return locProgDetailsList;
		}
	 
	 public ArrayList getLocProgDetails(String LOCId,String circleLocId,String userId)
		{
			Debug.println("in getLocProgDetails()");
	 		//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT LOC_DET.DISTRICT_CODE,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_CODE," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME,WORK_ID,WORK_DESC,PROJECT  " 
					+ " FROM rws_loc_details_tbl LOC_DET,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA  " 
					+ " WHERE LOC_DET.DISTRICT_CODE(+)=D.DCODE AND LOC_DET.LOC_ID='"+LOCId+"' AND LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) " 
					+ " AND  LOC_DET.CIRCLE_LOC_ID='"+circleLocId+"' AND " 
					+ " LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+) AND loc_det.OFFICE_FROM_CODE='"+userId+"'";  

	 	        Debug.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(LOCId);
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_CODE"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	locProgDetails.setWorkId(rs.getString("WORK_ID"));
	            	locProgDetails.setWorkDesc(rs.getString("WORK_DESC"));
	            	
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	Debug.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	if(userId.equals("100000"))
	            	{
	            		if(rs.getString("PROJECT")!=null&&rs.getString("PROJECT").equals("Y"))
	            		{
	            			locProgDetails.setOfficeList(divisionsList);
	            			locProgDetails.setProject("on");
	            		}
	            		else
	            		{
	            			locProgDetails.setOfficeList(circlesList);
	            			locProgDetails.setProject("off");
	            		}
	            	}
	            	else
	            	{
	            		locProgDetails.setOfficeList(getLowerOffices(userId));
	            		
	            	}
	            	
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        Debug.println("end of getLocProgDetails");
	        return locProgDetailsList;
		}
	 
	 public Rws_LocDetailsBean getLoc(String LOCId,String BroId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
			RwsOffices rwsOffices=new RwsOffices(dataSource);
	       
		 	
	        Connection conn=null;
	        Rws_LocDetailsBean locDetails=new Rws_LocDetailsBean();
	        try
			{

	        	final String officeType=rwsOffices.getOfficeType(userId);
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery ="";
	            if(!officeType.equals("Circle"))
	            {
	            
	            	sqlQuery = "SELECT locMaster.LOC_ID,locMaster.LOC_REF," 
	            		+ " to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE,locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," 
						+ " to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," 
						+ " locMaster.BRO_ID,broMaster.bro_reference,broMaster.bro_amount,to_char(broMaster.bro_date,'dd/mm/yyyy') as bro_date  FROM rws_LOC_master_tbl locMaster,rws_bro_master_tbl broMaster " 
						+ " where locMaster.loc_id='"+LOCId+"' and locMaster.bro_id='"+BroId+"' and locMaster.bro_id=broMaster.bro_id" ;
	            }
	            else
	            {
	            	sqlQuery = "SELECT locMaster.LOC_ID,locMaster.LOC_REF," 
	            		+ " to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE,locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," 
						+ " to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," 
						+ " locMaster.BRO_ID,broMaster.bro_reference,broMaster.bro_amount,to_char(broMaster.bro_date,'dd/mm/yyyy') as bro_date,locDet.CIRCLE_LOC_ID   FROM rws_LOC_master_tbl locMaster,rws_bro_master_tbl broMaster,rws_loc_details_tbl locDet " 
						+ " where locMaster.loc_id='"+LOCId+"' and locMaster.bro_id='"+BroId+"' and locMaster.bro_id=broMaster.bro_id and locMaster.loc_id=locDet.loc_id(+)" ;
	            }
		     Debug.println("query to get getloc:"+sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	Debug.println("in while");
	            	locDetails.setLocId(rs.getString("LOC_ID"));
	            	locDetails.setLocReference(rs.getString("LOC_REF"));
	            	locDetails.setLocRelDate(rs.getString("LOC_DATE"));
	            	locDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locDetails.setDwaAuthorisationReference(rs.getString("DWA_AUTH_REF"));
	            	locDetails.setDwaAuthorisationDate(rs.getString("DWA_AUTH_DATE"));
	            	locDetails.setBroId(rs.getString("BRO_ID"));
	            	locDetails.setBroReference(rs.getString("BRO_REFERENCE"));
	            	locDetails.setBroAmount(rs.getString("BRO_AMOUNT"));
	            	locDetails.setBrodate(rs.getString("BRO_DATE"));
	            	if(officeType.equals("Circle"))
		            {
	            		locDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
		            }
	            	float broAmountAlreadyAllocatedForLOCs=0;
	            	Debug.println("2wwwwwwwwwwww");
	            	broAmountAlreadyAllocatedForLOCs=getBroAmountAlreadyAllocatedForLOCsExclCurrentLoc(rs.getString("BRO_ID"),LOCId,userId);
	            	locDetails.setBroAmountAlreadyAllocatedForLOCs(broAmountAlreadyAllocatedForLOCs+"");
	            	Debug.println("3wwwwwwwwwwww");
	            	if(userId.equals("100000"))
	            	{
	            		Debug.println("4.1wwwwwwwwwwww");
	            	locDetails.setBroRemainingAmountToBeAllocated((Float.parseFloat(locDetails.getBroAmount())-broAmountAlreadyAllocatedForLOCs)+"");
	            	Debug.println("4.2wwwwwwwwwwww");
	            	}
	            	else
	            	{	Debug.println("5.1wwwwwwwwwwww");
	            		locDetails.setBroRemainingAmountToBeAllocated(getGrantedAmount(rs.getString("BRO_ID"),rs.getString("LOC_ID"),userId)+"");
	            		Debug.println("5.2wwwwwwwwwwww");
	            	}
	            	Debug.println("BroAmountAlreadyAllocatedForLOCs is "+locDetails.getBroAmountAlreadyAllocatedForLOCs());
	            }
	            Debug.println("6wwwwwwwwwwww");

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLoc111" +e );
	        }
	        finally
			{
	        	try{
		  	          //if(rs!=null)rs.close();
		  	          //if(stmt!=null)stmt.close();
		  			  //if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locDetails;
		}
	 public Rws_LocDetailsBean getLoc(String LOCId,String BroId,String circleLocId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
			RwsOffices rwsOffices=new RwsOffices(dataSource);
	       
		 	
	        Connection conn=null;
	        Rws_LocDetailsBean locDetails=new Rws_LocDetailsBean();
	        try
			{

	        	final String officeType=rwsOffices.getOfficeType(userId);
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String sqlQuery ="";
	           
	          /*  	sqlQuery = "SELECT locMaster.LOC_ID,locMaster.LOC_REF," 
	            		+ " to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE,locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," 
						+ " to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," 
						+ " locMaster.BRO_ID,broMaster.bro_reference,broMaster.bro_amount,locDet.CIRCLE_LOC_ID   FROM rws_LOC_master_tbl locMaster,rws_bro_master_tbl broMaster,rws_loc_details_tbl locDet " 
						+ " where locMaster.loc_id='"+LOCId+"' and locMaster.bro_id='"+BroId+"' and locMaster.bro_id=broMaster.bro_id and locMaster.loc_id=locDet.loc_id(+) and locDet.CIRCLE_LOC_ID ='"+circleLocId+"'" ;
	          */
	          	sqlQuery = "SELECT locMaster.LOC_ID,locMaster.LOC_REF," 
            		+ " to_char(locMaster.LOC_DATE,'dd/mm/yyyy')LOC_DATE,locMaster.LOC_AMOUNT,locMaster.DWA_AUTH_REF," 
					+ " to_char(locMaster.DWA_AUTH_DATE,'dd/mm/yyyy')DWA_AUTH_DATE," 
					+ " locMaster.BRO_ID,broMaster.bro_reference,broMaster.bro_amount,locDet.CIRCLE_LOC_ID   FROM rws_LOC_master_tbl locMaster,rws_bro_master_tbl broMaster,rws_loc_details_tbl locDet " 
					+ " where locMaster.loc_id='"+LOCId+"' and locMaster.bro_id='"+BroId+"' and locMaster.bro_id=broMaster.bro_id and locMaster.loc_id=locDet.loc_id";
							
          
	            
		       Debug.println(sqlQuery);
	            
		        rs = stmt.executeQuery(sqlQuery);

	            
	            while (rs.next())
	            {
	            	locDetails.setLocId(rs.getString("LOC_ID"));
	            	locDetails.setLocReference(rs.getString("LOC_REF"));
	            	locDetails.setLocRelDate(rs.getString("LOC_DATE"));
	            	locDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locDetails.setDwaAuthorisationReference(rs.getString("DWA_AUTH_REF"));
	            	locDetails.setDwaAuthorisationDate(rs.getString("DWA_AUTH_DATE"));
	            	locDetails.setBroId(rs.getString("BRO_ID"));
	            	locDetails.setBroReference(rs.getString("BRO_REFERENCE"));
	            	locDetails.setBroAmount(rs.getString("BRO_AMOUNT"));
	            	if(officeType.equals("Circle"))
		            {
	            		locDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
		            }
	            	float broAmountAlreadyAllocatedForLOCs=0;
	            	
	            	broAmountAlreadyAllocatedForLOCs=getBroAmountAlreadyAllocatedForLOCsExclCurrentLoc(rs.getString("BRO_ID"),LOCId,userId);
	            	locDetails.setBroAmountAlreadyAllocatedForLOCs(broAmountAlreadyAllocatedForLOCs+"");
	            	if(userId.equals("100000"))
	            		locDetails.setBroRemainingAmountToBeAllocated((Float.parseFloat(locDetails.getBroAmount())-broAmountAlreadyAllocatedForLOCs)+"");
	            	else
	            		locDetails.setBroRemainingAmountToBeAllocated(getGrantedAmount(rs.getString("BRO_ID"),rs.getString("LOC_ID"),userId)+"");
	            	
	            	Debug.println("BroAmountAlreadyAllocatedForLOCs is "+locDetails.getBroAmountAlreadyAllocatedForLOCs());
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            Debug.println("Exception occured in getLoc2222" +e );
	        }
	        finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
	        return locDetails;
		}
	 public String deleteLocDetails(String LOCId)throws Exception
	 {

		 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        String message=null;
	        boolean recordDeleted=false;
	        try
				{
		        	conn=RwsOffices.getConn();
		        //	conn.setAutoCommit(false);
		            stmt=conn.createStatement();
		            
		            String sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+LOCId+"'";
							
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	
		            sqlQuery = "delete from rws_loc_master_tbl where loc_id='"+LOCId+"'";
		            	Debug.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	
		            	int res[]=stmt.executeBatch();
		            	if(res[0]>0)
		            	{
		            		message="Record Deleted Successfully";
		            		recordDeleted=true;
		            	}
		            	
		          
		          // if(recordDeleted)
		         //  conn.setAutoCommit(true);
			 }catch(Exception e)
			 {
			 	Debug.println("Exception in deleteBroDetails is "+e);
			 	message="Record Cannot be Deleted";
			 }
			 finally
				{
		        	try{
			  	          if(rs!=null)rs.close();
			  	          if(stmt!=null)stmt.close();
			  			  if(conn!=null)conn.close();
			  			} catch(Exception e)
			  			{
			  				e.printStackTrace();
			  			}
				}
			 return message;
		}
	 
	 public DAOMessage insertLocDetails(Rws_LocDetailsBean bean,ArrayList locProgDetailsList,String mode,String userId)throws Exception
		{

			System.out.println("in insertLocDetails()");
	      
	       PreparedStatement updaterwsmaster;
		 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
		    RwsOffices rwsOffices=new RwsOffices(dataSource);
	        final String officeType=rwsOffices.getOfficeType(userId);
		 	Connection conn=null;
	        String message=null;
	        boolean recordInserted=true;
	        DAOMessage daoMessage=new DAOMessage();
	        try
			{ 
	            conn=RwsOffices.getConn();
	            System.out.println("1111111111111111");
		        	
		            stmt=conn.createStatement();
		            String query="";
		            Debug.println("office type in insert is "+officeType+"loc ref:"+bean.getLocReference());
		            query="select count(*) from rws_loc_master_tbl where loc_id='"+bean.getLocId()+"' and bro_id='"+bean.getBroId()+"'";
        			
		            System.out.println("query is "+query);
		            rs=stmt.executeQuery(query);
		            boolean recordAlreadyExists=false;
		            while(rs.next())
		            {
		            	System.out.println("in rs.next");
		            	if(rs.getInt(1)>0)
		            		recordAlreadyExists=true;
		            }
		            if(mode!=null&&mode.equals("addNew")&&recordAlreadyExists&&!officeType.equals("Circle"))
		            {
		            	//closeAll();
		            	daoMessage.setCode(-1);
		            	daoMessage.setMessage("Record with LOC Id: "+bean.getLocId()+" under BRO ID: "+bean.getBroId()+" already Exists\\nRecord Cannot be inserted");
		            	return daoMessage;
		            }
		            System.out.println("recordAlreadyExists is "+recordAlreadyExists);
		            if(!recordAlreadyExists)
		            {
		            	System.out.println("if record alerdy exists ....");
		            	String sqlQuery = "INSERT INTO rws_loc_master_tbl(LOC_ID,LOC_REF," 
		            		+ " LOC_DATE,LOC_AMOUNT,DWA_AUTH_REF ,DWA_AUTH_DATE ,BRO_ID) values('"
							+ bean.getLocId()+"','"+bean.getLocReference()+"',to_date('"+bean.getLocRelDate()+"','dd/mm/yyyy'),'"
							+ bean.getLocAmount()+"','"+bean.getDwaAuthorisationReference()+"',to_date('"+bean.getDwaAuthorisationDate()+"','dd/mm/yyyy'),'"+bean.getBroId()+"')";
		            	
		            	stmt.addBatch(sqlQuery);
		            	
		            	
		            	if(!officeType.equals("Circle"))
	        			{
		            		sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+bean.getLocId()+"' and bro_id='"+bean.getBroId()+"' and OFFICE_FROM_CODE ='"+userId+"'";
	        			}
		            	else
		            	{
		            		sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+bean.getLocId()+"' and bro_id='"+bean.getBroId()+"' and OFFICE_FROM_CODE ='"+userId+"' and CIRCLE_LOC_ID ='"+bean.getCircleLocId()+"'";
		            	}
		            	System.out.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	
		            	
		            	Rws_LocProgDetailsBean locProgDetailsBean=null;
		            	String work_id = "";
		            	for(int i=0;i<locProgDetailsList.size();i++)
		            	{
		            		locProgDetailsBean=(Rws_LocProgDetailsBean)locProgDetailsList.get(i);
		            		if(locProgDetailsBean.getWorkId() != null)
		            			work_id = locProgDetailsBean.getWorkId();
		            		System.out.println("PAO Flag"+locProgDetailsBean.getPaoApaoFlag());
		            		if(!locProgDetailsBean.getProgram().equals(""))
		            		{
		            			System.out.println("officeType is "+officeType);
		            			if(officeType.equals("Division"))
		            			{
		            				String project="";
		            				
		            				//project=locProgDetailsBean.getProject();
		            				//Debug.println("Project"+project);
		            				project= (locProgDetailsBean.getWorkId().equals("")||locProgDetailsBean.getWorkId()==null)? "N" : "Y";
		            				//project= !locProgDetailsBean.getWorkId().equals("")? "on" : "off";
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,CIRCLE_LOC_ID,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE ,OFFICE_TO_CODE,LOC_DATE," 
										+ "PLACE,PAO_CODE ,REMARKS,WORK_ID,WORK_DESC,PROJECT," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ locProgDetailsBean.getCircleLocId()+"','"
										+ bean.getLocReference()+"','"
										+ locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"
										+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ work_id+"','"
										+ locProgDetailsBean.getWorkDesc()+"','"
										+ project+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			}
		            			else if(!officeType.equals("Circle"))
		            			{
		            				String project="";
		            				//project=locProgDetailsBean.getProject();
		            				//Debug.println("Project"+project);
		            				//project= !locProgDetailsBean.getWorkId().equals("")? "on" : "off";
		            				//project= locProgDetailsBean.getProject().equals("on")? "Y" : "N";
		            				project= (locProgDetailsBean.getWorkId().equals("")||locProgDetailsBean.getWorkId()==null)? "N" : "Y";
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE ,OFFICE_TO_CODE,LOC_DATE," 
										+ "PLACE,PAO_code ,REMARKS,WORK_ID,WORK_DESC,PROJECT," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ bean.getLocReference()+"','"
										+locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"
										+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ work_id+"','"
										+ locProgDetailsBean.getWorkDesc()+"','"
										+ project+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			}
		            			else
		            			{
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE ,OFFICE_TO_CODE,LOC_DATE," 
										+ "PLACE,PAO_code ,REMARKS,CIRCLE_LOC_ID ," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ bean.getLocReference()+"','"
										+locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ bean.getCircleLocId()+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			}
		            				
		            			System.out.println("query is "+sqlQuery);
		            		stmt.addBatch(sqlQuery);
		            		}
		            	}
		            	
		            	int res[]=stmt.executeBatch();
		            	for(int i=0;i<res.length&&i!=1;i++)
		            	{
		            		if(res[i]<1)
		            		{
		            			message="Record Cannot be Inserted";
		            			daoMessage.setCode(-1);
		            			daoMessage.setMessage(message);
		            			recordInserted=false;
		            		}
		            	}
		            	if(recordInserted)
		            	{
		            		message="Record Inserted Successfully";
		            		daoMessage.setCode(1);
		            		daoMessage.setMessage(message);
		            	}
		            	conn.setAutoCommit(true);
			        }
		            else
		            {
		            	System.out.println("in else block");
		            	conn=RwsOffices.getConn();
		            	stmt=conn.createStatement();
		                Debug.println("In else");
		                conn.setAutoCommit(true);
		                String sqlQuery;
		            	 sqlQuery = "update rws_loc_master_tbl" 
		            		+ " set LOC_REF ='"+bean.getLocReference()+"'," 
		            		+ " LOC_DATE =to_date('"+bean.getLocRelDate()+"','dd/mm/yyyy')," 
							+ " LOC_AMOUNT ='"+bean.getLocAmount()+"'," 
							+ " DWA_AUTH_REF ='"+bean.getDwaAuthorisationReference()+"'," 
							+ " DWA_AUTH_DATE =to_date('"+bean.getDwaAuthorisationDate()+"','dd/mm/yyyy') where"
							+ " BRO_ID ='"+bean.getBroId()+"'";
		            	
		            	
		            	stmt.addBatch(sqlQuery);
		            	
		            	sqlQuery = "delete from rws_loc_details_tbl where loc_id='"+bean.getLocId()+"' and bro_id='"+bean.getBroId()+"'";
		            	
		            	System.out.println("query is "+sqlQuery);
		            	stmt.addBatch(sqlQuery);
		            	Rws_LocProgDetailsBean locProgDetailsBean=null;
		            	String work_id = "";
		            	
		            	for(int i=0;i<locProgDetailsList.size();i++)
		            	{
		            		System.out.println("Prog details");
		            		locProgDetailsBean=(Rws_LocProgDetailsBean)locProgDetailsList.get(i);
		            		if(locProgDetailsBean.getWorkId() != null)
		            			work_id = locProgDetailsBean.getWorkId();
		            		if(!locProgDetailsBean.getProgram().equals(""))
		            		{
		            			if(officeType.equals("Division"))
		            			{
		            				String project="";
		            				
		            				project= (locProgDetailsBean.getWorkId().equals("")||locProgDetailsBean.getWorkId()==null)? "N" : "Y";
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,CIRCLE_LOC_ID,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE ,OFFICE_TO_CODE,LOC_DATE," 
										+ "PLACE,PAO_code ,REMARKS,WORK_ID,WORK_DESC,PROJECT," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ bean.getLocReference()+"','"
										+ locProgDetailsBean.getCircleLocId()+"','"
										+ locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"
										+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ work_id+"','"
										+ locProgDetailsBean.getWorkDesc()+"','"
										+ project+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			
		            			System.out.println("division");
		            			}
		            			else if(!officeType.equals("Circle")){
		            				String project="";
		            				//project=locProgDetailsBean.getProject();
		            				Debug.println("Project"+project);
		            				project= (locProgDetailsBean.getWorkId().equals("")||locProgDetailsBean.getWorkId()==null)? "N" : "Y";
		            				Debug.println("IN PROJECT"+locProgDetailsBean.getProject()+"Project");
		            				//project= locProgDetailsBean.getProject().equals("on")? "Y" : "N";
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE,OFFICE_TO_CODE ,LOC_DATE," 
										+ "PLACE,PAO_code,REMARKS,WORK_ID,WORK_DESC,PROJECT," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ bean.getLocReference()+"','"
										+locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"
										+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ work_id+"','"
										+ locProgDetailsBean.getWorkDesc()+"','"
										+ project+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			}
		            			else
		            			{
		            				sqlQuery = "insert into rws_loc_details_tbl(LOC_ID,LOC_REF,DISTRICT_CODE ," 
		            					+ "PROGRAMME_CODE,SUBPROGRAMME_CODE ,HEAD_OF_ACCOUNT,LOC_AMOUNT ,OFFICE_FROM_CODE,OFFICE_TO_CODE ,LOC_DATE," 
										+ "PLACE,PAO_code,REMARKS,CIRCLE_LOC_ID ," 
										+ "UPDATE_DATE,bro_id )values ('"
										+ bean.getLocId()+"','"
										+ bean.getLocReference()+"','"
										+locProgDetailsBean.getDistrict()+"','"
										+ locProgDetailsBean.getProgram()+"','"
										+ locProgDetailsBean.getSubprogram()+"','"
										+ locProgDetailsBean.getHeadOfAccount()+"','"
										+ locProgDetailsBean.getLocAmount()+"','"
										+ userId+"','"
										+ locProgDetailsBean.getOffice()+"',to_date('"
										+ locProgDetailsBean.getLocDate()+"','dd/mm/yyyy'),'"
										+ locProgDetailsBean.getPlace()+"','"
										+ locProgDetailsBean.getPaoApaoFlag()+"','"
										+ locProgDetailsBean.getRemarks()+"','"
										+ bean.getCircleLocId()+"'," 
										+ "sysdate,'"+bean.getBroId()+"')";
		            			//System.out.println("In else");
		            			}
		            			System.out.println("^^^^&&**query is "+sqlQuery);
		            		stmt.addBatch(sqlQuery);
		            		}
		            	}
		            	
		            	
		            	
		            	
		            	System.out.println(" before execute batch stmt:"+sqlQuery);
		            	
		            	int res[]=stmt.executeBatch();
		            	for(int i=0;i<res.length&&i!=1;i++)
		            	{
		            		if(res[i]<1)
		            		{
		            			message="Record Cannot be Updated";
		            			daoMessage.setCode(-1);
		            			daoMessage.setMessage(message);
		            			recordInserted=false;
		            		}
		            		
		            	}
		            	
		            	if(recordInserted)
		            	{
		            		message="Record Updated Successfully";
		            		daoMessage.setCode(1);
		            		daoMessage.setMessage(message);
		            	}
		            	else
		            	{
		            	    message="Record cannot be Updated";
		            	    daoMessage.setCode(-1);
		            	    daoMessage.setMessage(message);
		            	    
		            	}
		            	//conn.setAutoCommit(true);
		            }
		        
		            
		            conn.close();
			 }catch(Exception e)
			 {
			     e.printStackTrace();
			 	 message="Record Cannot be Updated/Inserted";
			     daoMessage.setCode(-1);
			     daoMessage.setMessage(message);
			     return daoMessage;
			 }
			 finally
				{
		        	try{
			  	          if(rs!=null)rs.close();
			  	          if(stmt!=null)stmt.close();
			  			  if(conn!=null)conn.close();
			  			} catch(Exception e)
			  			{
			  				e.printStackTrace();
			  			}
				}
			 	return daoMessage;
		}
	 public float getBroAmountAlreadyAllocatedForLOCs(String broId)
	 {
	 	float broAmountAlreadyAllocatedForLOCs=0;
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT locMaster.loc_id,locMaster.bro_id,locDetail.loc_amount FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDetail " 
				+ " where locMaster.bro_id='"+broId+"' and locMaster.loc_id=locDetail.loc_id";
	        Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

            
            while (rs.next())
            {
            	broAmountAlreadyAllocatedForLOCs+=Float.parseFloat(rs.getString("loc_amount"));
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroAmountAlreadyAllocatedForLOCs" +e );
        }
        finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	 	return broAmountAlreadyAllocatedForLOCs;
	 }
	 
	 public float getBroAmountAlreadyAllocatedForLOCsExclCurrentLoc(String broId,String locId,String userId)
	 {
	 	float broAmountAlreadyAllocatedForLOCs=0;
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        String sqlQuery="";
        ResultSet rs1 = null;
        Statement stmt1=null;
        Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
        try
		{

        	conn=RwsOffices.getConn();
            stmt1=conn.createStatement();
            
	        if(userId.equals("100000"))
	        	sqlQuery = "SELECT locMaster.loc_id,locMaster.bro_id,locDetail.loc_amount FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDetail " 
				+ " where locMaster.bro_id='"+broId+"' and locMaster.loc_id=locDetail.loc_id and locMaster.loc_id<>'"+locId+"' and locDetail.OFFICE_FROM_CODE='"+userId+"'";
	        else
	        	sqlQuery = "SELECT locMaster.loc_id,locMaster.bro_id,locDetail.loc_amount FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDetail " 
					+ " where locMaster.bro_id='"+broId+"' and locMaster.loc_id=locDetail.loc_id and locMaster.loc_id<>'"+locId+"' and locDetail.OFFICE_TO_CODE='"+userId+"'";
	        Debug.println(sqlQuery);
            
	        rs1 = stmt1.executeQuery(sqlQuery);

            
            while (rs1.next())
            {
            	broAmountAlreadyAllocatedForLOCs+=Float.parseFloat(rs1.getString("loc_amount"));
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroAmountAlreadyAllocatedForLOCs" +e );
        }
        finally
		{
        	try{
	  	          if(rs1!=null)rs1.close();
	  	          if(stmt1!=null)stmt1.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	 	return broAmountAlreadyAllocatedForLOCs;
	 }
	 public Rws_LocDetailsBean getBroRefDetails(String broId,String userId)
	 {
	 	Rws_LocDetailsBean locDetailsBeanTmp=new Rws_LocDetailsBean();
	 	
	 	
	 	Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	String sqlQuery="";
	 	try
		{
	 		//BeanUtils.copyProperties(locDetailsBeanTmp,locDetailsBean);
	 		
	 		Connection conn=null;
	 		
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		sqlQuery = "SELECT broMaster.bro_id,broMaster.bro_Reference," 
	 			+ " broMaster.bro_Amount,to_char(broMaster.bro_date,'dd/mm/yyyy') as bro_date FROM rws_bro_master_tbl broMaster  " 
				+ " where broMaster.bro_id='"+broId+"'";
	 		Debug.println(sqlQuery);
	 		
	 		rs = stmt.executeQuery(sqlQuery);
	 		locDetailsBeanTmp.broId=broId;
	 		locDetailsBeanTmp.setBroReference("");
	 		locDetailsBeanTmp.setBroAmount("");
	 		if (rs.next())
	 		{
	 			locDetailsBeanTmp.setBroReference(rs.getString("bro_reference"));
	 			locDetailsBeanTmp.setBroAmount(rs.getString("bro_amount"));
	 			locDetailsBeanTmp.setBrodate(rs.getString("bro_date"));
	 			
	 		}
	 		
	 		if(userId.equals("100000"))
	 		{
	 			sqlQuery = "SELECT locMaster.bro_id,broMaster.bro_Reference," +
				"broMaster.bro_Amount,sum(locDetail.loc_amount)amountAllocated " +
				"FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDetail," +
				"rws_bro_master_tbl broMaster  where locMaster.bro_id='"+broId+"'" +
				" and locMaster.loc_id=locDetail.loc_id and " +
				"locMaster.bro_id=broMaster.bro_id and locDetail.OFFICE_FROM_CODE ='"+userId+"' group by locMaster.bro_id," +
				"broMaster.bro_reference,broMaster.bro_amount";
	 			
	 			Debug.println("query is "+sqlQuery);
	 			
	 			rs = stmt.executeQuery(sqlQuery);
	 			
	 			boolean recordExists=false;
	 			while (rs.next())
	 			{
	 				recordExists=true;
	 				//locDetailsBeanTmp.setBroReference(rs.getString("bro_reference"));
	 				//locDetailsBeanTmp.setBroAmount(rs.getString("bro_amount"));
	 				locDetailsBeanTmp.setBroAmountAlreadyAllocatedForLOCs(rs.getString("amountAllocated"));
	 				locDetailsBeanTmp.setBroRemainingAmountToBeAllocated((Float.parseFloat(rs.getString("bro_amount"))-Float.parseFloat(rs.getString("amountAllocated")))+"");
	 				
	 			}
	 			if(!recordExists)
	 			{
	 				locDetailsBeanTmp.setBroAmountAlreadyAllocatedForLOCs("0");
	 				locDetailsBeanTmp.setBroRemainingAmountToBeAllocated(locDetailsBeanTmp.getBroAmount());
	 				
	 			}
	 		}
	 		else
	 		{
	 			locDetailsBeanTmp.setBroRemainingAmountToBeAllocated(getGrantedAmount(broId,userId)+"");
	 		}
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		Debug.println("Exception occured in getBroRefDetails" +e );
		}
	 	finally
		{
        	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	 	
	 	
	 	return locDetailsBeanTmp;
	 }
	 
	 
	 /*
	 public Rws_LocDetailsBean getBroRefDetails(String broId,String locId)
	 {
	 	Rws_LocDetailsBean locDetailsBeanTmp=new Rws_LocDetailsBean();
	 	
	 	
	 	Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	try
		{
	 	//BeanUtils.copyProperties(locDetailsBeanTmp,locDetailsBean);
	 	
        Connection conn=null;
        

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
            String sqlQuery = "SELECT broMaster.bro_id,broMaster.bro_Reference," +
    		"broMaster.bro_Amount " +
    		"FROM rws_bro_master_tbl broMaster  where broMaster.bro_id='"+broId+"'";
		    Debug.println(sqlQuery);
		    
		    rs = stmt.executeQuery(sqlQuery);
		    locDetailsBeanTmp.broId=broId;
		    locDetailsBeanTmp.setBroReference("");
		    locDetailsBeanTmp.setBroAmount("");
		    while (rs.next())
		    {
		    	locDetailsBeanTmp.setBroReference(rs.getString("bro_reference"));
		    	locDetailsBeanTmp.setBroAmount(rs.getString("bro_amount"));
		    	
		    }
            
            sqlQuery = "SELECT locMaster.bro_id,broMaster.bro_Reference," +
	        		"broMaster.bro_Amount,sum(locDetail.loc_amount)amountAllocated " +
	        		"FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDetail," +
	        		"rws_bro_master_tbl broMaster  where locMaster.bro_id='"+broId+"'" +
	        		" and locMaster.loc_id=locDetail.loc_id and " +
	        		"locMaster.bro_id=broMaster.bro_id and locMaster.loc_id<>'"+locId+"' group by locMaster.bro_id," +
	        		"broMaster.bro_reference,broMaster.bro_amount";
	        Debug.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);

            boolean recordExists=false;
            while (rs.next())
            {
            	recordExists=true;
            	//locDetailsBeanTmp.setBroReference(rs.getString("bro_reference"));
            	//locDetailsBeanTmp.setBroAmount(rs.getString("bro_amount"));
            	locDetailsBeanTmp.setBroAmountAlreadyAllocatedForLOCs(rs.getString("amountAllocated"));
            	locDetailsBeanTmp.setBroRemainingAmountToBeAllocated((Float.parseFloat(rs.getString("bro_amount"))-Float.parseFloat(rs.getString("amountAllocated")))+"");
            	
            }
            if(!recordExists)
            {
            	locDetailsBeanTmp.setBroAmountAlreadyAllocatedForLOCs("0");
            	locDetailsBeanTmp.setBroRemainingAmountToBeAllocated(locDetailsBeanTmp.getBroAmount());
            	
            }
           

        } 
        catch ( Exception e ) 
		{
            Debug.println("Exception occured in getBroRefDetails" +e );
        }
        finally
		{
          //closeAll();
		}
        
        
	 	return locDetailsBeanTmp;
	 }
	 */
	 public ArrayList getBroProgrammsList(String broId)
	 {
	 	ArrayList programmes = new ArrayList();
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 		
			try
			{
				Connection conn=RwsOffices.getConn();
		           
				String query = " SELECT broDet.programme_code, prog.programme_name"
							 + " FROM rws_bro_details_tbl broDet,rws_programme_tbl prog where broDet.programme_code=prog.programme_code and broDet.bro_Id='"+broId+"' ORDER BY prog.programme_name ";
							 
				Debug.println("query is "+query);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				LabelValueBean labelValueBean=null;
				while(rs.next())
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rs.getString(1));
					labelValueBean.setLabel(rs.getString(2));
					programmes.add(labelValueBean);
				}
			}
			catch(Exception e){Debug.println("Exception in getBroProgrammsList is "+e);}
			finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  //if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
			return programmes;
		}
	 
	 public ArrayList getBroProgrammsList(String broId,String userId)
	 {
	 	Connection conn=null;
	 	ArrayList programmes = new ArrayList();
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	String query="";
			try
			{
				conn=RwsOffices.getConn();
		           
				if(userId.equals("100000"))
					 query = " SELECT distinct broDet.programme_code, prog.programme_name"
						 + " FROM rws_bro_details_tbl broDet,rws_programme_tbl prog where broDet.programme_code=prog.programme_code and broDet.bro_Id='"+broId+"' ORDER BY prog.programme_name ";
				else
					query = " SELECT distinct locDet.programme_code, prog.programme_name"
								 + " FROM rws_loc_master_tbl locMaster,rws_loc_details_tbl locDet," 
								 + " rws_programme_tbl prog where locDet.loc_id=locMaster.loc_id " 
								 + " and locDet.programme_code=prog.programme_code and " 
								 + " locMaster.bro_Id='"+broId+"' " 
								 + " and locDet.OFFICE_TO_CODE='"+userId+"' ORDER BY prog.programme_name ";
								 
				Debug.println("query is "+query);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				LabelValueBean labelValueBean=null;
				while(rs.next())
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rs.getString(1));
					labelValueBean.setLabel(rs.getString(2));
					programmes.add(labelValueBean);
				}
			}
			catch(Exception e){Debug.println("Exception in getBroProgrammsList is "+e);}
			finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
			return programmes;
		}
	 public ArrayList getAvailableProgsForLocList(String broId,String userId)
	 {
	 	ArrayList programmes = new ArrayList();
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 		Connection conn=null;
			try
			{
				 conn=RwsOffices.getConn();
		        
				String query ="";
				if(userId.equals("100000"))
					query= " SELECT broDet.programme_code, prog.programme_name"
							 + " FROM rws_bro_details_tbl broDet,rws_programme_tbl prog where broDet.programme_code=prog.programme_code and broDet.bro_Id='"+broId+"' ORDER BY prog.programme_name ";
				else
					query= " SELECT distinct locDet.programme_code, prog.programme_name"
						 + " FROM rws_loc_details_tbl locDet,rws_loc_master_tbl locMaster,rws_programme_tbl prog where locMaster.loc_id=locDet.loc_id and locDet.programme_code=prog.programme_code and locMaster.bro_Id='"+broId+"' and locDet.OFFICE_TO_CODE ='"+userId+"' ORDER BY prog.programme_name ";
					
							 
				Debug.println("query is "+query);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				LabelValueBean labelValueBean=null;
				while(rs.next())
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rs.getString(1));
					labelValueBean.setLabel(rs.getString(2));
					programmes.add(labelValueBean);
				}
			}
			catch(Exception e){Debug.println("Exception in getBroProgrammsList is "+e);}
			finally
			{
	        	try{
		  	          if(rs!=null)rs.close();
		  	          if(stmt!=null)stmt.close();
		  			  if(conn!=null)conn.close();
		  			} catch(Exception e)
		  			{
		  				e.printStackTrace();
		  			}
			}
			return programmes;
		}
	 
	 public ArrayList getLowerOffices(String officeCode) throws Exception
		{
			String headOfficeCode = officeCode.substring(0,1);
			String circleOfficeCode = officeCode.substring(1,3);
			String divisionOfficeCode = officeCode.substring(3,4);
			String subdivisionOfficeCode = officeCode.substring(4,6);
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
			ArrayList forwardOffices = new ArrayList();
			String query="";
			if(!subdivisionOfficeCode.equals("00"))
			{
			}
			else
			if(!divisionOfficeCode.equals("0"))
			{
				query = " SELECT (head_office_code||circle_office_code||division_office_code|| "
					  +	" subdivision_office_code) as office_code, "
					  + " subdivision_office_name "
					  + " FROM rws_subdivision_office_tbl WHERE "
					  + " head_office_code = '" + headOfficeCode + "' AND "
					  + " circle_office_code = '" + circleOfficeCode + "' AND "
					  + " division_office_code = '" + divisionOfficeCode + "' " 
					  + " ORDER BY subdivision_office_name ";
			}
			else
			if( !circleOfficeCode.equals("00"))	
			{
				query = " SELECT (head_office_code||circle_office_code||division_office_code|| "
					  + " '00') AS office_code, "
					  + " division_office_name "
					  + " FROM rws_division_office_tbl WHERE "
					  + " head_office_code = '" + headOfficeCode + "' AND "
					  + " circle_office_code = '" + circleOfficeCode + "' "
					  + " ORDER BY division_office_name ";
			}
			else
			if(! headOfficeCode.equals("0"))	
			{
				query = " SELECT (head_office_code||circle_office_code||'000') AS office_code, "
					  + " circle_office_name "
					  + " FROM rws_circle_office_tbl WHERE "
					  + " head_office_code = '" + headOfficeCode + "' "
					  + " ORDER BY circle_office_name ";
			}
			try{
			Debug.println("query is "+query);	
			Connection conn=RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			LabelValueBean labelValueBean = null;

			while(rs.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2)+" - "+rs.getString(1));
				labelValueBean.setLabelValue(rs.getString(2)+" - "+rs.getString(1));
				forwardOffices.add(labelValueBean);
			}
			}
			catch(Exception e){Debug.println("Exception in getLowerOffices is "+e);}
			finally{//closeAll();}
			}
				return forwardOffices;
		}
	 
	 public float getGrantedAmount(String broId,String officeCode) throws Exception
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	String query="select  sum(locDet.loc_amount) from rws_loc_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locMaster.bro_id='"+broId+"' and OFFICE_TO_CODE ='"+officeCode+"'";
	 	float grantedAmount=0;
	 	try{
	 		Debug.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		if(rs.next())
	 			grantedAmount=rs.getFloat(1);
	 	}
	 	catch(Exception e){Debug.println("Exception in getGrantedAmount is "+e);}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmount;
	 }
	 
	 public float getGrantedAmount(String broId,String locId,String officeCode) throws Exception
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	String query="select  sum(locDet.loc_amount) from rws_loc_master_tbl locMaster,rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id and locMaster.bro_id='"+broId+"' and locDet.loc_id='"+locId+"' and OFFICE_TO_CODE ='"+officeCode+"'";
	 	float grantedAmount=0;
	 	try{
	 		Debug.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		if(rs.next())
	 			grantedAmount=rs.getFloat(1);
	 	}
	 	catch(Exception e){Debug.println("Exception in getGrantedAmount is "+e);}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmount;
	 }
	 
	 public float getGrantedAmountForProg(String broId,String officeCode,String progCode) throws Exception
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	String query="select  sum(locDet.loc_amount) from " 
	 		+ " rws_loc_master_tbl locMaster,rws_loc_details_tbl locDet " 
			+ " where locMaster.loc_id=locDet.loc_id and " 
			+ " locMaster.bro_id='"+broId+"' and locDet.OFFICE_TO_CODE ='"+officeCode+"'" 
			+ " and locDet.PROGRAMME_CODE ='"+progCode+"'";
	 	float grantedAmount=0;
	 	try{
	 		Debug.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		if(rs.next())
	 			grantedAmount=rs.getFloat(1);
	 	}
	 	catch(Exception e){Debug.println("Exception in getGrantedAmount is "+e);}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmount;
	 }
	 
	 public ArrayList getGrantedAmtProgWiseList(String broId,String officeCode) throws Exception
	 {
	 	Debug.println("in getGrantedAmtProgWiseList");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Rws_LocDetailsBean locDetailsBean=null;
	 	
	 	ArrayList grantedAmtProgWiseList=new ArrayList();
	 	String query="select locMaster.BRO_ID,locDet.LOC_ID," 
	 		+ " locDet.loc_amount,locDet.programme_code,p.programme_name" 
			+ " from rws_loc_master_tbl locMaster,rws_loc_details_tbl locdet," 
			+ " rws_programme_tbl p where locMaster.loc_id=locDet.loc_id" 
			+ " and locmaster.bro_id='"+broId+"' and " 
			+ " OFFICE_TO_CODE ='"+officeCode+"' and " 
			+ " locDet.programme_code=p.programme_code";
	 	float grantedAmount=0;
	 	try{
	 		Debug.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		while(rs.next())
	 		{
	 			locDetailsBean=new Rws_LocDetailsBean();
	 			locDetailsBean.setBroId(rs.getString("bro_id"));
	 			locDetailsBean.setLocId(rs.getString("loc_id"));
	 			locDetailsBean.setLocAmount(rs.getString("loc_amount"));
	 			locDetailsBean.setProgrammeCode(rs.getString("programme_code"));
	 			locDetailsBean.setProgrammeName(rs.getString("programme_name"));
	 			grantedAmtProgWiseList.add(locDetailsBean);
	 		}
	 		
	 	}
	 	catch(Exception e){Debug.println("Exception in getGrantedAmount is "+e);}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmtProgWiseList;
	 }
	 
	 
	 public ArrayList getGrantedAmtProgWiseList(String broId,String locId,String officeCode) throws Exception
	 {
	 	//Debug.println("in getGrantedAmtProgWiseList with locid");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Rws_LocDetailsBean locDetailsBean=null;
	 	
	 	ArrayList grantedAmtProgWiseList=new ArrayList();
	 	/*
	 	String query="select locMaster.BRO_ID,locDet.LOC_ID," 
	 		+ " locDet.loc_amount,locDet.programme_code,p.programme_name" 
			+ " from rws_loc_master_tbl locMaster,rws_loc_details_tbl locdet," 
			+ " rws_programme_tbl p where locMaster.loc_id=locDet.loc_id" 
			+ " and locmaster.bro_id='"+broId+"' and " 
			+ " OFFICE_TO_CODE ='"+officeCode+"' and " 
			+ " locDet.programme_code=p.programme_code and locDet.loc_id='"+locId+"'";
	 	
	 	*/
	 	String query="select locMaster.BRO_ID,locDet.LOC_ID," 
	 		+ " sum(locDet.loc_amount)loc_amount,locDet.programme_code,p.programme_name" 
			+ " from rws_loc_master_tbl locMaster,rws_loc_details_tbl locdet," 
			+ " rws_programme_tbl p where locMaster.loc_id=locDet.loc_id" 
			+ " and locmaster.bro_id='"+broId+"' and " 
			+ " OFFICE_TO_CODE ='"+officeCode+"' and " 
			+ " locDet.programme_code=p.programme_code and locDet.loc_id='"+locId+"'" 
			+ " group by locMaster.BRO_ID,locDet.LOC_ID,locDet.programme_code,p.programme_name";
	 	
	 	float grantedAmount=0;
	 	try{
	 		//System.out.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		while(rs.next())
	 		{
	 			locDetailsBean=new Rws_LocDetailsBean();
	 			locDetailsBean.setBroId(rs.getString("bro_id"));
	 			locDetailsBean.setLocId(rs.getString("loc_id"));
	 			locDetailsBean.setLocAmount(rs.getString("loc_amount"));
	 			locDetailsBean.setProgrammeCode(rs.getString("programme_code"));
	 			locDetailsBean.setProgrammeName(rs.getString("programme_name"));
	 			grantedAmtProgWiseList.add(locDetailsBean);
	 		}
	 		
	 	}
	 	catch(Exception e){
	 		//System.out.println("Exception in getGrantedAmount is "+e);}
	 	}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmtProgWiseList;
	 }
	 
	 public ArrayList getGrantedAmtProgWiseList(String broId,String locId,String circleLocId,String officeCode) throws Exception
	 {
	 	//System.out.println("in getGrantedAmtProgWiseList with locid");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Rws_LocDetailsBean locDetailsBean=null;
	 	
	 	ArrayList grantedAmtProgWiseList=new ArrayList();
	 	String query="select * from " ;
	 	query=query+" (select locMaster.BRO_ID,locDet.LOC_ID," +
			" locDet.loc_amount , locDet.programme_code ," +
			" p.programme_name from rws_loc_master_tbl locMaster," +
			" rws_loc_details_tbl locdet , rws_programme_tbl p " +
			" where locMaster.loc_id=locDet.loc_id and" +
			" locmaster.bro_id='"+broId+"'  and" +
			"  OFFICE_TO_CODE ='"+officeCode+"' and" +
			" locDet.programme_code=p.programme_code" +
			" and locDet.loc_id='"+locId+"')view1," ;
	 	
	 	
	 	query=query+" (select locDet.programme_code as pcode," +
			" p.programme_name as pname,nvl(sum(locDet.loc_amount),0)as locAmountAllocatedToOtherCLOCs " +
			" from rws_loc_master_tbl locMaster," +
			" rws_loc_details_tbl locDet,rws_programme_tbl p" +
			" where locMaster.loc_id=locDet.loc_id and" +
			" locMaster.bro_id='"+broId+"' and" +
			" locDet.loc_id='"+locId+"' " +
			" AND locDet.circle_loc_id<>'"+circleLocId+"'" +
			" and p.programme_code(+)=locDet.programme_code" +
			" group by locDet.programme_code,p.programme_name)view2 " ;
	 	
	 	query=query+" where view1.programme_code=view2.pcode(+)";
	 	float grantedAmount=0;
	 	try{
	 		//System.out.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		while(rs.next())
	 		{
	 			locDetailsBean=new Rws_LocDetailsBean();
	 			locDetailsBean.setBroId(rs.getString("bro_id"));
	 			locDetailsBean.setLocId(rs.getString("loc_id"));
	 			locDetailsBean.setLocAmount(rs.getString("loc_amount"));
	 			locDetailsBean.setProgrammeCode(rs.getString("programme_code"));
	 			locDetailsBean.setProgrammeName(rs.getString("programme_name"));
	 			locDetailsBean.setAmountAllocatedToOtherCLOCIds(rs.getString("locAmountAllocatedToOtherCLOCs"));
	 			grantedAmtProgWiseList.add(locDetailsBean);
	 		}
	 		
	 	}
	 	catch(Exception e){
	 		//System.out.println("Exception in getGrantedAmount is "+e);}
	 	}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmtProgWiseList;
	 }
	 
	 public ArrayList getWorkIdListForDivision(String broId,String locId,String officeCode) throws Exception
	 {
	 	//System.out.println("in getGrantedAmtProgWiseList with locid");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	
	 	
	 	ArrayList workIdList=new ArrayList();
	 	String query=" select distinct work_id from rws_loc_master_tbl locMaster," 
	 		+ "rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
			+ " and locDet.loc_id='"+locId+"' AND " 
			+ " locMaster.bro_id='"+broId+"' AND locDet.project='Y' " 
			+ " and locDet.OFFICE_TO_CODE ='"+officeCode+"'";
	 	float grantedAmount=0;
	 	try{
	 		//System.out.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		LabelValueBean  labelValueBean=null;
	 		while(rs.next())
	 		{
	 			
	 				labelValueBean= new LabelValueBean();
					labelValueBean.setValue(rs.getString(1));
					labelValueBean.setLabel(rs.getString(1));
					workIdList.add(labelValueBean);
				
	 		}
	 		
	 	}
	 	catch(Exception e){
	 		//System.out.println("Exception in getGrantedAmount is "+e);}
	 	}
	 	finally{
	 		//closeAll();
	 	}
	 	return workIdList;
	 }
	 
	 public ArrayList getWorkIdListForDivision(String broId,String locId,String programmeCode,String officeCode) throws Exception
	 {
	 	//System.out.println("in getGrantedAmtProgWiseList with locid");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	
	 	
	 	ArrayList workIdList=new ArrayList();
	 	String query=" select distinct work_id from rws_loc_master_tbl locMaster," 
	 		+ "rws_loc_details_tbl locDet where locMaster.loc_id=locDet.loc_id " 
			+ " and locDet.loc_id='"+locId+"' AND " 
			+ " locMaster.bro_id='"+broId+"' AND locDet.project='Y' " 
			+ " and locDet.OFFICE_TO_CODE ='"+officeCode+"' and locDet.programme_code='"+programmeCode+"'";
	 	
	 	//-- by kiran System.out.println("***Query in getting work id****"+query);
	 	
	 	
	 	
	 	float grantedAmount=0;
	 	try{
	 		//System.out.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		LabelValueBean  labelValueBean=null;
	 		while(rs.next())
	 		{
	 			
	 				labelValueBean= new LabelValueBean();
					labelValueBean.setValue(rs.getString(1));
					//
					labelValueBean.setLabel(rs.getString(1));

					workIdList.add(labelValueBean);
				
	 		}
	 		
	 	}
	 	catch(Exception e){
	 		//System.out.println("Exception in getGrantedAmount is "+e);}
	 	}
	 	finally{
	 		//closeAll();
	 	}
	 	return workIdList;
	 }
	 
	 public ArrayList getLocAmountForWorks(String broId,String locId,String officeCode) throws Exception
	 {
	 	//System.out.println("in getLocAmountForWorks");
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Rws_LocDetailsBean locDetailsBean=null;
	 	
	 	ArrayList grantedAmtWorkWiseList=new ArrayList();
	 	String query="select locMaster.bro_id,locDet.loc_id,locDet.work_id,workAdmn.work_name," 
	 		+ " sum(locDet.loc_amount)loc_amount from rws_loc_details_tbl locDet," 
			+ " rws_loc_master_tbl locMaster,rws_work_admn_tbl workAdmn where locDet.work_id is not null" 
			+ " and locDet.OFFICE_TO_CODE ='"+officeCode+"' and " 
			+ " locMaster.loc_id=locDet.loc_id and locMaster.bro_id='"+broId+"' " 
			+ " and locDet.loc_id='"+locId+"' and locDet.work_id=workAdmn.work_id " 
			+ " group by locMaster.bro_id,locDet.loc_id,locDet.work_id,workAdmn.work_name";
	 	try{
	 		//System.out.println("query is "+query);	
	 		Connection conn=RwsOffices.getConn();
	 		stmt = conn.createStatement();
	 		rs = stmt.executeQuery(query);
	 		
	 		while(rs.next())
	 		{
	 			locDetailsBean=new Rws_LocDetailsBean();
	 			locDetailsBean.setBroId(rs.getString("bro_id"));
	 			locDetailsBean.setLocId(rs.getString("loc_id"));
	 			locDetailsBean.setWorkId(rs.getString("work_id"));
	 			locDetailsBean.setLocAmount(rs.getString("loc_amount"));
	 			locDetailsBean.setWorkName(rs.getString("work_name"));
	 			grantedAmtWorkWiseList.add(locDetailsBean);
	 		}
	 		
	 	}
	 	catch(Exception e){
	 		//System.out.println("Exception in getLocAmountForWorks is "+e);}
	 	}
	 	finally{
	 		//closeAll();
	 	}
	 	return grantedAmtWorkWiseList;
	 }

//methods for LOC ends here
	 
//methods for reports starts here
	 public ArrayList getLocProgDetailsForRpt(String broId,String userId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT locMaster.loc_id,loc_det.project,LOC_DET.WORK_ID,workAdmn.work_name,LOC_DET.WORK_DESC ,LOC_DET.DISTRICT_CODE,D.DNAME,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_code," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME " 
					+ " FROM rws_loc_details_tbl LOC_DET,rws_work_admn_tbl workAdmn,rws_loc_master_tbl locMaster,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA " 
					+ " WHERE  LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+)" 
					+ " AND locMaster.loc_id=loc_det.loc_id and locMaster.bro_id='"+broId+"' and OFFICE_FROM_CODE ='"+userId+"'" 
					+ " AND loc_det.work_id=workAdmn.work_id(+)";  

	 	        System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(rs.getString("LOC_ID"));
	            	locProgDetails.setWorkId(rs.getString("WORK_ID"));
	            	locProgDetails.setWorkName(rs.getString("WORK_NAME"));
	            	locProgDetails.setWorkDesc(rs.getString("WORK_DESC"));
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_code"));
	            	//
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	//locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME")+" - "+rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	locProgDetails.setProject(rs.getString("PROJECT"));
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	//System.out.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	/*
	            	if(locProgDetails.getOffice()!=null&&!locProgDetails.getOffice().substring(3,6).equals("000"))
		            {
		            		locProgDetails.setOfficeList(divisionsList);
		            		locProgDetails.setProject("on");
		            }
		            else
		            {
		            		locProgDetails.setOfficeList(circlesList);
		            		locProgDetails.setProject("off");
		            }
	            	*/
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return locProgDetailsList;
		}
	 
	 
	 
	 
	 public ArrayList getCircleLocProgDetailsForRpt(String broId,String locId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT locMaster.loc_id,loc_det.circle_loc_id,loc_det.project,LOC_DET.WORK_ID,workAdmn.work_name,LOC_DET.WORK_DESC ,LOC_DET.DISTRICT_CODE,D.DNAME,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_code," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME " 
					+ " FROM rws_loc_details_tbl LOC_DET,rws_work_admn_tbl workAdmn,rws_loc_master_tbl locMaster,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA " 
					+ " WHERE  LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+)" 
					+ " AND locMaster.loc_id=loc_det.loc_id and locMaster.bro_id='"+broId+"' " 
					+ " AND loc_det.work_id=workAdmn.work_id(+) AND locMaster.loc_id='"+locId+"'" 
					+ " AND loc_det.circle_loc_id is not null " 
					+ " order by loc_det.loc_id,circle_loc_id";  

	 	        //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(rs.getString("CIRCLE_LOC_ID"));
	            	//locProgDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
	            	locProgDetails.setWorkId(rs.getString("WORK_ID"));
	            	locProgDetails.setWorkName(rs.getString("WORK_NAME"));
	            	locProgDetails.setWorkDesc(rs.getString("WORK_DESC"));
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_code"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME")+" - "+rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	locProgDetails.setProject(rs.getString("PROJECT"));
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	//System.out.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	/*
	            	if(locProgDetails.getOffice()!=null&&!locProgDetails.getOffice().substring(3,6).equals("000"))
		            {
		            		locProgDetails.setOfficeList(divisionsList);
		            		locProgDetails.setProject("on");
		            }
		            else
		            {
		            		locProgDetails.setOfficeList(circlesList);
		            		locProgDetails.setProject("off");
		            }
	            	*/
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return locProgDetailsList;
		}
	 
	 public ArrayList getProjectLocListForRpt(String broId,String locId)
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_LocProgDetailsBean locProgDetails=null;
	        nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
	        ArrayList locProgDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	ArrayList circlesList=rwsOffices.getAllCirclesWithOfficeCode("1");
	        	ArrayList divisionsList=rwsOffices.getAllDivisionsWithOfficeCode();
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
		        String sqlQuery = "SELECT locMaster.loc_id,loc_det.circle_loc_id,loc_det.project,LOC_DET.WORK_ID,workAdmn.work_name,LOC_DET.WORK_DESC ,LOC_DET.DISTRICT_CODE,D.DNAME,LOC_DET.PROGRAMME_CODE,P.PROGRAMME_NAME," 
		        	+ " LOC_DET.SUBPROGRAMME_CODE ,SP.SUBPROGRAMME_NAME,LOC_DET.LOC_AMOUNT ," 
					+ " LOC_DET.OFFICE_FROM_CODE,LOC_DET.OFFICE_TO_CODE ,LOC_DET.PLACE ,LOC_DET.PAO_code," 
					+ " LOC_DET.REMARKS,LOC_DET.HEAD_OF_ACCOUNT,TO_CHAR(LOC_DET.LOC_DATE,'DD/MM/YYYY')LOC_DATE, " 
					+ " D.DNAME,HA.HEAD_OF_ACCOUNT_NAME " 
					+ " FROM rws_loc_details_tbl LOC_DET,rws_work_admn_tbl workAdmn,rws_loc_master_tbl locMaster,RWS_PROGRAMME_TBL P," 
					+ " RWS_SUBPROGRAMME_TBL SP,RWS_DISTRICT_TBL D,RWS_HEAD_OF_ACCOUNT_TBL HA " 
					+ " WHERE  LOC_DET.PROGRAMME_CODE=P.PROGRAMME_CODE(+)  " 
					+ " AND LOC_DET.PROGRAMME_CODE=SP.PROGRAMME_CODE " 
					+ " AND LOC_DET.SUBPROGRAMME_CODE =SP.SUBPROGRAMME_CODE(+) AND LOC_DET.DISTRICT_CODE=D.DCODE(+) AND LOC_DET.HEAD_OF_ACCOUNT=HA.HEAD_OF_ACCOUNT(+)" 
					+ " AND locMaster.loc_id=loc_det.loc_id and locMaster.bro_id='"+broId+"' " 
					+ " AND loc_det.work_id=workAdmn.work_id(+) AND locMaster.loc_id='"+locId+"'" 
					+ " AND loc_det.circle_loc_id is  null AND LOC_DET.OFFICE_FROM_CODE <>'100000' AND loc_det.WORK_ID IS NOT NULL" 
					+ " order by loc_det.loc_id,circle_loc_id";  

	 	        //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);

	            nic.watersoft.commons.CommonLists commonLists=new nic.watersoft.commons.CommonLists(dataSource);
	            while (rs.next())
	            {
	            	locProgDetails=new Rws_LocProgDetailsBean();
	            	locProgDetails.setLocId(rs.getString("LOC_ID"));
	            	//locProgDetails.setCircleLocId(rs.getString("CIRCLE_LOC_ID"));
	            	locProgDetails.setWorkId(rs.getString("WORK_ID"));
	            	locProgDetails.setWorkName(rs.getString("WORK_NAME"));
	            	locProgDetails.setWorkDesc(rs.getString("WORK_DESC"));
	            	locProgDetails.setDistrict(rs.getString("DISTRICT_CODE"));
	            	locProgDetails.setDistrictName(rs.getString("DNAME"));
	            	locProgDetails.setProgram(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setProgramName(rs.getString("programme_name"));
	            	locProgDetails.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));
	            	locProgDetails.setSubprogramName(rs.getString("SUBPROGRAMME_NAME"));
	            	locProgDetails.setLocAmount(rs.getString("LOC_AMOUNT"));
	            	locProgDetails.setOfficeFrom(rs.getString("OFFICE_FROM_CODE"));
	            	locProgDetails.setOffice(rs.getString("OFFICE_TO_CODE"));
	            	locProgDetails.setPlace(rs.getString("PLACE"));
	            	locProgDetails.setPaoApaoFlag(rs.getString("PAO_code"));
	            	locProgDetails.setRemarks(rs.getString("REMARKS"));
	            	locProgDetails.setHeadOfAccount(rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setHeadOfAccountName(rs.getString("HEAD_OF_ACCOUNT_NAME")+" - "+rs.getString("HEAD_OF_ACCOUNT"));
	            	locProgDetails.setLocDate(rs.getString("LOC_DATE"));
	            	locProgDetails.setProject(rs.getString("PROJECT"));
	            	ArrayList subProgrammesList = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
	            	locProgDetails.setSubProgrammesList(subProgrammesList);
	            	//System.out.println("officeCode is "+locProgDetails.getOffice());
	            	
	            	/*
	            	if(locProgDetails.getOffice()!=null&&!locProgDetails.getOffice().substring(3,6).equals("000"))
		            {
		            		locProgDetails.setOfficeList(divisionsList);
		            		locProgDetails.setProject("on");
		            }
		            else
		            {
		            		locProgDetails.setOfficeList(circlesList);
		            		locProgDetails.setProject("off");
		            }
	            	*/
	            	locProgDetailsList.add(locProgDetails);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getLocProgDetails" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return locProgDetailsList;
		}
	 
	 
	 //Methods for ReleasesVsExpenditure workWise
	 
	 public ArrayList getReleasesVsExpenditureList()
		{
			////ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList releasesVsExpenditureList=new ArrayList();
	        
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
	            String sqlQuery = "SELECT * FROM ("+
				" select LOCDET.work_id AS WORK_ID_FOR_RELEASES," +
				" WORKADMN.WORK_NAME AS WORK_NAME_FOR_RELEASES," +
				" sum(loc_amount)TOTAL_RELEASES from " +
				" rws_loc_details_tbl LOCDET,RWS_WORK_ADMN_TBL WORKADMN " +
				" where  LOCDET.work_id is not null " +
				" and project='Y' AND LOCDET.WORK_ID=WORKADMN.WORK_ID " +
				" group by LOCDET.work_id,WORKADMN.WORK_NAME)WORKMON,"+
				" (SELECT WORKEXP.WORK_ID AS WORK_ID_FOR_EXPENDITURE," +
				" WORKADMN.WORK_NAME AS WORK_NAME_FOR_EXPENDITURE," +
				" NVL(SUM(EXPENDITURE_DURING),0)+(select nvl(sum(EXPENDITURE_UPTO_THE_PRE_YEAR),0) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL  where work_id=workexp.work_id)TOTAL_EXPENDITURE,sum(VALUE_OF_WORK_NOT_PAID)as VALUE_OF_WORK_NOT_PAID " +
				" FROM RWS_WORK_EXPENDITURE_TBL WORKEXP," +
				" RWS_WORK_ADMN_TBL WORKADMN WHERE " +
				" WORKEXP.WORK_ID=WORKADMN.WORK_ID" +
				" GROUP BY WORKEXP.WORK_ID,WORKADMN.WORK_NAME)WORKEXP" +
				" WHERE WORKMON.WORK_ID_FOR_RELEASES=WORKEXP.WORK_ID_FOR_EXPENDITURE(+)"+
				
				" UNION"+
				   
				" SELECT * FROM ("+  
				" select LOCDET.work_id AS WORK_ID_FOR_RELEASES," +
				" WORKADMN.WORK_NAME AS WORK_NAME_FOR_RELEASES," +
				" sum(loc_amount)TOTAL_RELEASES from rws_loc_details_tbl LOCDET," +
				" RWS_WORK_ADMN_TBL WORKADMN where" +
				" LOCDET.work_id is not null and project='Y' " +
				" AND LOCDET.WORK_ID=WORKADMN.WORK_ID group by LOCDET.work_id," +
				" WORKADMN.WORK_NAME)WORKMON2,"+
				" (SELECT WORKEXP.WORK_ID AS WORK_ID_FOR_EXPENDITURE," +
				" WORKADMN.WORK_NAME AS WORK_NAME_FOR_EXPENDITURE," +
				" NVL(SUM(EXPENDITURE_DURING),0)+" +
				" (select nvl(sum(EXPENDITURE_UPTO_THE_PRE_YEAR),0)" +
				" from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL  " +
				" where work_id=workexp.work_id)TOTAL_EXPENDITURE,sum(VALUE_OF_WORK_NOT_PAID)as VALUE_OF_WORK_NOT_PAID  " +
				" FROM RWS_WORK_EXPENDITURE_TBL WORKEXP," +
				" RWS_WORK_ADMN_TBL WORKADMN" +
				" WHERE WORKADMN.WORK_ID=WORKEXP.WORK_ID" +
				" GROUP BY " +
				" WORKEXP.WORK_ID,WORKADMN.WORK_NAME)WORKEXP2 WHERE " +
				" WORKMON2.WORK_ID_FOR_RELEASES(+)=WORKEXP2.WORK_ID_FOR_EXPENDITURE ";
	            Debug.println(" in releasevsexpenditure init mode: "+sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            
	            
	            
	            String workId="";
            	String workName="";
	            while (rs.next())
	            {
	            	if(rs.getString("work_id_for_releases")!=null && !rs.getString("work_id_for_releases").equals(""))
	            	{
	            		workId=rs.getString("work_id_for_releases");
	            		workName=rs.getString("work_name_for_releases");
	            	}
	            	else if(rs.getString("work_id_for_expenditure")!=null && !rs.getString("work_id_for_expenditure").equals(""))
	            	{
	            		workId=rs.getString("work_id_for_expenditure");
	            		workName=rs.getString("work_name_for_expenditure");
	            	}
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setWorkId(workId);
	            	releasesVsExpenditureBean.setWorkName(workName);
	            	releasesVsExpenditureBean.setTotalExpenditure(rs.getString("total_expenditure"));
	            	releasesVsExpenditureBean.setTotalReleases(rs.getString("total_releases"));
	            	releasesVsExpenditureBean.setValueOfWorkDoneButNotPaid(rs.getString("VALUE_OF_WORK_NOT_PAID"));
	            	 
	            	releasesVsExpenditureList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getReleasesVsExpenditureList()" +e );
	        }
	        finally
			{
	          ////closeAll();
			}
	        return releasesVsExpenditureList;
		}
	 
	 
	 public ArrayList getReleasesVsExpenditureDetailsList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList releasesVsExpenditureDetailsList=new ArrayList();
	        
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
	            String sqlQuery = "select locMaster.bro_id,locDet.loc_id," +
	            		"locMaster.loc_ref,locDet.work_id,locDet.head_of_account,workadm.work_name,sum" +
	            		"(locDet.loc_amount)locAmountTot,locDet.programme_code,prog.programme_name from rws_loc_details_tbl locDet," +
	            		"rws_loc_master_tbl locMaster,rws_programme_tbl prog,rws_work_admn_tbl workadm where " +
	            		"locMaster.loc_id=locDet.loc_id and workadm.work_id=locDet.work_id and " +
	            		"locDet.office_from_code='100000'  and " +
	            		" locDet.work_id is not null and prog.programme_code=locDet.programme_code group by locDet.work_id,workadm.work_name,locMaster.bro_id," +
	            		"locDet.loc_id,locMaster.loc_ref,locDet.work_id,head_of_account,locDet.programme_code,prog.programme_name  " +
	            		"order by work_id ";
	 	        //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            while (rs.next())
	            {
	            	
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setBroId(rs.getString("bro_id"));
	            	//System.out.println("broId is "+rs.getString("bro_id"));
	            	releasesVsExpenditureBean.setLocId(rs.getString("loc_id"));
	            	releasesVsExpenditureBean.setLocReference(rs.getString("loc_ref"));
	            	releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
	            	releasesVsExpenditureBean.setHeadOfAccount(rs.getString("head_of_account"));
	            	releasesVsExpenditureBean.setWorkName(rs.getString("work_name"));
	            	releasesVsExpenditureBean.setLocAmount(rs.getString("locAmountTot"));
	            	releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
	            	releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
	            	 
	            	releasesVsExpenditureDetailsList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getReleasesVsExpenditureDetailsList()" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return releasesVsExpenditureDetailsList;
		}
	 
	 
	 public ArrayList getExpenditreDetailsListForRelVsExp()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList expenditureDetailsList=new ArrayList();
	        //System.out.println("in getExpenditreDetailsListForRelVsExp()");
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            String months[]={"January","Feburary","March","April","May","June","July","August","September","October","November","December"};
	            String sqlQuery = "select work_id,workExp.programme_code," +
	            		" prog.programme_name,year,to_number(month)month," +
	            		" expenditure_during,workExp.VALUE_OF_WORK_NOT_PAID  from rws_work_expenditure_tbl workExp," +
	            		" rws_programme_tbl prog where " +
	            		" workExp.programme_code=prog.programme_code" +
	            		" group by work_id,workExp.programme_code," +
	            		" prog.programme_name,year,to_number(month)," +
	            		" expenditure_during,workExp.VALUE_OF_WORK_NOT_PAID order by work_id";
	 	        //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            while (rs.next())
	            {
	            	
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
	            	releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
	            	releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
	            	releasesVsExpenditureBean.setYear(rs.getString("year"));
	            	releasesVsExpenditureBean.setValueOfWorkDoneButNotPaid(rs.getString("VALUE_OF_WORK_NOT_PAID"));
	            	try{
	            	if(rs.getString("month")==null || rs.getString("month").equals(""))
	            		releasesVsExpenditureBean.setMonth(rs.getString("month"));
	            	else
	            		releasesVsExpenditureBean.setMonth(months[Integer.parseInt(rs.getString("month"))-1]);
	            	}catch(Exception e){
	            		releasesVsExpenditureBean.setMonth(rs.getString("month"));
	            		//System.out.println("Exception in typecasting in getExpenditreDetailsListForRelVsExp() is "+e);
	            		}
	            	releasesVsExpenditureBean.setExpenditureDuring(rs.getString("expenditure_during"));
	            	 
	            	expenditureDetailsList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getExpenditreDetailsListForRelVsExp()" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return expenditureDetailsList;
		}
	 
	 public ArrayList getExpenditureUptoPrevYearList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList expenditureUptoPrevYearListList=new ArrayList();
	        
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
	            String sqlQuery = "select expUptoPrevYr.work_id," +
	            		" expUptoPrevYr.programme_code,prog.programme_name," +
	            		" expUptoPrevYr.EXPENDITURE_UPTO_THE_PRE_YEAR  " +
	            		" from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL expUptoPrevYr," +
	            		" rws_programme_tbl prog  where  " +
	            		" expUptoPrevYr.programme_code=prog.programme_code " +
	            		" group by expUptoPrevYr.work_id,expUptoPrevYr.programme_code," +
	            		" prog.programme_name,expUptoPrevYr.EXPENDITURE_UPTO_THE_PRE_YEAR";
	 	        //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            while (rs.next())
	            {
	            	
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
	            	releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
	            	releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
	            	releasesVsExpenditureBean.setExpenditureUptoPrevYear(rs.getString("EXPENDITURE_UPTO_THE_PRE_YEAR"));
	            	 
	            	expenditureUptoPrevYearListList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getExpenditureUptoPrevYearList()" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return expenditureUptoPrevYearListList;
		}
	 //End of Methods for ReleasesVsExpenditure workWise
	 
	 //Methods for ReleasesVsExpenditure officeWist
	 public ArrayList getReleasesDetailsCircleOfficeWiseList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList releasesCircleOfficeWiseList=new ArrayList();
	        
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
	            String sqlQuery="select * from (" +
	            //releases		
					" SELECT SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)circle_office_codeForReleases," +
					" CIROFF.circle_office_name as CIRCLE_OFFICE_NAMEForReleases," +
					" SUM(LOCDET.LOC_AMOUNT)locAmountTot  FROM RWS_LOC_DETAILS_TBL LOCDET," +
					" RWS_CIRCLE_OFFICE_TBL CIROFF WHERE LOCDET.OFFICE_FROM_CODE='100000' AND" +
					" LOCDET.PROJECT='Y'  AND CIROFF.CIRCLE_OFFICE_CODE(+)=SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)" +
					"  GROUP BY SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)," +
					" CIROFF.CIRCLE_OFFICE_NAME" +
					" )releases, " +
				//expenditure
					" (select substr(workExp.work_id,5,2)circle_office_codeForExp," +
					" cirOff.circle_office_name as circle_office_nameForExp," +
					" sum(expenditure_during)expenditure_during from " +
					" rws_work_expenditure_tbl workExp, rws_circle_office_tbl cirOff " +
					" where  substr(workExp.work_id,5,2)=cirOff.circle_office_code  " +
					" group by substr(workExp.work_id,5,2), cirOff.circle_office_name" +
					" )expenditure " +
					" where releases.circle_office_codeForReleases(+)=expenditure.circle_office_codeForExp" +
					
					" union " +
					
					" select * from ( " +
				//releases
					" SELECT SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)circle_office_codeForReleases," +
					" CIROFF.circle_office_name as CIRCLE_OFFICE_NAMEForReleases," +
					" SUM(LOCDET.LOC_AMOUNT)locAmountTotal  FROM RWS_LOC_DETAILS_TBL LOCDET," +
					" RWS_CIRCLE_OFFICE_TBL CIROFF  WHERE LOCDET.OFFICE_FROM_CODE='100000' " +
					" AND  LOCDET.PROJECT='Y' AND CIROFF.CIRCLE_OFFICE_CODE(+)=SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)" +
					" GROUP BY SUBSTR(LOCDET.OFFICE_TO_CODE,2,2), CIROFF.CIRCLE_OFFICE_NAME" +
					" )releases," +
				//expenditure
					" (select substr(workExp.work_id,5,2)circle_office_codeForExp, " +
					" cirOff.circle_office_name as circle_office_nameForExp," +
					" sum(expenditure_during)expenditure_during  " +
					" from rws_work_expenditure_tbl workExp," +
					" rws_circle_office_tbl cirOff where  " +
					" substr(workExp.work_id,5,2)=cirOff.circle_office_code " +
					" group by substr(workExp.work_id,5,2), cirOff.circle_office_name" +
					" )expenditure " +
					" where releases.circle_office_codeForReleases=expenditure.circle_office_codeForExp(+)";
	            
	            //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            while (rs.next())
	            {
	            	
	            	String circleOfficeCode="";
	 	            String circleOfficeName="";
	 	           
	            	if(rs.getString("circle_office_codeForReleases")!=null && !rs.getString("circle_office_codeForReleases").equals(""))
	            	{
	            		circleOfficeCode=rs.getString("circle_office_codeForReleases");
	            		circleOfficeName=rs.getString("circle_office_NameForReleases");
	            	}
	            	else if(rs.getString("circle_office_codeForExp")!=null && !rs.getString("circle_office_codeForExp").equals(""))
	            	{
	            		circleOfficeCode=rs.getString("circle_office_codeForExp");
	            		circleOfficeName=rs.getString("circle_office_nameForExp");
	            	}
	            	
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCode);
	            	releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
	            	releasesVsExpenditureBean.setLocAmount(rs.getString("locAmountTot"));
	            	releasesVsExpenditureBean.setExpenditureDuring(rs.getString("expenditure_during"));
	            	releasesCircleOfficeWiseList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getReleasesDetailsCircleOfficeWiseList()" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return releasesCircleOfficeWiseList;
		}
	 
	 public ArrayList getReleasesDetailsDivisionOfficeWiseList()
		{
			//ConnectionManager connMgr=new ConnectionManager(dataSource);
	        Connection conn=null;
	        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	        ArrayList releasesDivisionOfficeWiseList=new ArrayList();
	        
	        try
			{
	        	
	        	conn=RwsOffices.getConn();
	            stmt=conn.createStatement();
	            
	            String sqlQuery="select * from (" +
	            //releases		
					" SELECT SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)circle_office_codeForReleases," +
					" CIROFF.circle_office_name as CIRCLE_OFFICE_NAMEForReleases," +
					" DIVOFF.division_office_code as div_office_codeForReleases," +
					" DIVOFF.division_office_name as div_office_nameForReleases," +
					" SUM(LOCDET.LOC_AMOUNT)locAmountTot  FROM RWS_LOC_DETAILS_TBL LOCDET," +
					" RWS_CIRCLE_OFFICE_TBL CIROFF, " +
					" RWS_DIVISION_OFFICE_TBL DIVOFF " +
					" WHERE LOCDET.OFFICE_FROM_CODE='100000' AND " +
					" LOCDET.PROJECT='Y'  AND CIROFF.CIRCLE_OFFICE_CODE(+)=SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)" +
					" AND DIVOFF.DIVISION_OFFICE_CODE=SUBSTR(LOCDET.OFFICE_TO_CODE,4,1) " +
					" GROUP BY SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)," +
					" CIROFF.CIRCLE_OFFICE_NAME,DIVOFF.DIVISION_OFFICE_CODE,DIVOFF.DIVISION_OFFICE_NAME" +
					" )releases, " +
				//expenditure
					" (select substr(workExp.work_id,5,2)circle_office_codeForExp," +
					" cirOff.circle_office_name as circle_office_nameForExp," +
					" DIVOFF.division_office_code as div_office_codeForExp," +
					" DIVOFF.division_office_name as div_office_nameForExp," +
					" sum(expenditure_during)expenditure_during from " +
					" rws_work_expenditure_tbl workExp, rws_circle_office_tbl cirOff, " +
					" RWS_DIVISION_OFFICE_TBL DIVOFF " +
					" where  substr(workExp.work_id,5,2)=cirOff.circle_office_code  " +
					" group by substr(workExp.work_id,5,2), cirOff.circle_office_name," +
					" divOff.division_office_code,divOff.division_office_name" +
					" )expenditure " +
					" where releases.circle_office_codeForReleases(+)=expenditure.circle_office_codeForExp" +
					
					" union " +
					
					" select * from ( " +
				//releases
					" SELECT SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)circle_office_codeForReleases," +
					" CIROFF.circle_office_name as CIRCLE_OFFICE_NAMEForReleases," +
					" DIVOFF.division_office_code as div_office_codeForReleases," +
					" DIVOFF.division_office_name as div_office_nameForReleases," +
					" SUM(LOCDET.LOC_AMOUNT)locAmountTotal  FROM RWS_LOC_DETAILS_TBL LOCDET," +
					" RWS_CIRCLE_OFFICE_TBL CIROFF, " +
					" RWS_DIVISION_OFFICE_TBL DIVOFF " +
					" WHERE LOCDET.OFFICE_FROM_CODE='100000' " +
					" AND  LOCDET.PROJECT='Y' AND CIROFF.CIRCLE_OFFICE_CODE(+)=SUBSTR(LOCDET.OFFICE_TO_CODE,2,2)" +
					" AND DIVOFF.DIVISION_OFFICE_CODE=SUBSTR(LOCDET.OFFICE_TO_CODE,4,1) " +
					" GROUP BY SUBSTR(LOCDET.OFFICE_TO_CODE,2,2), CIROFF.CIRCLE_OFFICE_NAME," +
					" DIVOFF.DIVISION_OFFICE_CODE,DIVOFF.DIVISION_OFFICE_NAME" +
					" )releases," +
				//expenditure
					" (select substr(workExp.work_id,5,2)circle_office_codeForExp, " +
					" cirOff.circle_office_name as circle_office_nameForExp," +
					" DIVOFF.division_office_code as div_office_codeForExp," +
					" DIVOFF.division_office_name as div_office_nameForExp," +
					" sum(expenditure_during)expenditure_during  " +
					" from rws_work_expenditure_tbl workExp," +
					" rws_circle_office_tbl cirOff," +
					" RWS_DIVISION_OFFICE_TBL DIVOFF " +
					" where  substr(workExp.work_id,5,2)=cirOff.circle_office_code " +
					" group by substr(workExp.work_id,5,2), cirOff.circle_office_name," +
					" divOff.division_office_code,divOff.division_office_name" +
					" )expenditure " +
					" where releases.circle_office_codeForReleases=expenditure.circle_office_codeForExp(+)";
	            
	            //System.out.println(sqlQuery);
	            rs = stmt.executeQuery(sqlQuery);
	            while (rs.next())
	            {
	            	
	            	String circleOfficeCode="";
	 	            String circleOfficeName="";
	 	            String divisionOfficeCode="";
	 	            String divisionOfficeName="";
	 	           
	            	if(rs.getString("div_office_codeForReleases")!=null && !rs.getString("circle_office_codeForReleases").equals(""))
	            	{
	            		circleOfficeCode=rs.getString("circle_office_codeForReleases");
	            		circleOfficeName=rs.getString("circle_office_NameForReleases");
	            		divisionOfficeCode=rs.getString("div_office_codeForReleases");
	            		divisionOfficeName=rs.getString("div_office_NameForReleases");
	            	}
	            	else if(rs.getString("circle_office_codeForExp")!=null && !rs.getString("circle_office_codeForExp").equals(""))
	            	{
	            		circleOfficeCode=rs.getString("circle_office_codeForExp");
	            		circleOfficeName=rs.getString("circle_office_nameForExp");
	            		divisionOfficeCode=rs.getString("div_office_codeForExp");
	            		divisionOfficeName=rs.getString("div_office_nameForExp");
	            	}
	            	
	            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	            	releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCode);
	            	releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
	            	releasesVsExpenditureBean.setDivisionOfficeCode(divisionOfficeName);
	            	releasesVsExpenditureBean.setDivisionOfficeName(divisionOfficeName);
	            	releasesVsExpenditureBean.setLocAmount(rs.getString("locAmountTot"));
	            	releasesVsExpenditureBean.setExpenditureDuring(rs.getString("expenditure_during"));
	            	releasesDivisionOfficeWiseList.add(releasesVsExpenditureBean);
	            }
	           

	        } 
	        catch ( Exception e ) 
			{
	            //System.out.println("Exception occured in getReleasesDetailsDivisionOfficeWiseList()" +e );
	        }
	        finally
			{
	          //closeAll();
			}
	        return releasesDivisionOfficeWiseList;
		}
	 //End of Methods for ReleasesVsExpenditure officeWise
	 
	 //Methods for ReleasesVsExpenditure SchemeWise
	 public ArrayList getReleasesVsExpenditureSchemeWiseList()
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList releasesVsExpenditureList=new ArrayList();
	 	
	 	try
		{
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		String sqlQuery ="SELECT * FROM (";
	 		sqlQuery += "SELECT * FROM ("+
			" select LOCDET.work_id AS WORK_ID_FOR_RELEASES," +
			" WORKADMN.WORK_NAME AS WORK_NAME_FOR_RELEASES," +
			" WORKADMN.TYPE_OF_ASSET AS TYPE_OF_ASSET_FOR_RELEASES," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME AS ASSET_NAME_FOR_RELEASES," +
			" sum(loc_amount)TOTAL_RELEASES from " +
			" rws_loc_details_tbl LOCDET,RWS_WORK_ADMN_TBL WORKADMN,RWS_ASSET_TYPE_TBL ASSETTYPE " +
			" where  ASSETTYPE.TYPE_OF_ASSET_CODE=WORKADMN.TYPE_OF_ASSET AND LOCDET.work_id is not null " +
			" and project='Y' AND LOCDET.WORK_ID=WORKADMN.WORK_ID " +
			" group by LOCDET.work_id,WORKADMN.WORK_NAME,WORKADMN.TYPE_OF_ASSET," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME)WORKMON,"+
			
			" (SELECT WORKEXP.WORK_ID AS WORK_ID_FOR_EXPENDITURE," +
			" WORKADMN.WORK_NAME AS WORK_NAME_FOR_EXPENDITURE," +
			" WORKADMN.TYPE_OF_ASSET AS TYPE_OF_ASSET_FOR_EXPENDITURE," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME AS ASSET_NAME_FOR_EXPENDITURE," +
			" NVL(SUM(EXPENDITURE_DURING),0)+(select nvl(sum(EXPENDITURE_UPTO_THE_PRE_YEAR),0) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL  where work_id=workexp.work_id)TOTAL_EXPENDITURE,sum(VALUE_OF_WORK_NOT_PAID)as VALUE_OF_WORK_NOT_PAID " +
			" FROM RWS_WORK_EXPENDITURE_TBL WORKEXP," +
			" RWS_ASSET_TYPE_TBL ASSETTYPE," +
			" RWS_WORK_ADMN_TBL WORKADMN WHERE " +
			" WORKEXP.WORK_ID=WORKADMN.WORK_ID AND " +
			" ASSETTYPE.TYPE_OF_ASSET_CODE=WORKADMN.TYPE_OF_ASSET " +
			" GROUP BY WORKEXP.WORK_ID,WORKADMN.WORK_NAME,WORKADMN.TYPE_OF_ASSET,ASSETTYPE.TYPE_OF_ASSET_NAME)WORKEXP" +
			" WHERE WORKMON.WORK_ID_FOR_RELEASES=WORKEXP.WORK_ID_FOR_EXPENDITURE(+)"+
			
			" UNION"+
			
			" SELECT * FROM ("+
			" select LOCDET.work_id AS WORK_ID_FOR_RELEASES," +
			" WORKADMN.WORK_NAME AS WORK_NAME_FOR_RELEASES," +
			" WORKADMN.TYPE_OF_ASSET AS TYPE_OF_ASSET_FOR_RELEASES," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME AS ASSET_NAME_FOR_RELEASES," +
			" sum(loc_amount)TOTAL_RELEASES from " +
			" rws_loc_details_tbl LOCDET,RWS_WORK_ADMN_TBL WORKADMN,RWS_ASSET_TYPE_TBL ASSETTYPE " +
			" where  ASSETTYPE.TYPE_OF_ASSET_CODE=WORKADMN.TYPE_OF_ASSET AND LOCDET.work_id is not null " +
			" and project='Y' AND LOCDET.WORK_ID=WORKADMN.WORK_ID " +
			" group by LOCDET.work_id,WORKADMN.WORK_NAME,WORKADMN.TYPE_OF_ASSET," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME)WORKMON,"+
			
			" (SELECT WORKEXP.WORK_ID AS WORK_ID_FOR_EXPENDITURE," +
			" WORKADMN.WORK_NAME AS WORK_NAME_FOR_EXPENDITURE," +
			" WORKADMN.TYPE_OF_ASSET AS TYPE_OF_ASSET_FOR_EXPENDITURE," +
			" ASSETTYPE.TYPE_OF_ASSET_NAME AS ASSET_NAME_FOR_EXPENDITURE," +
			" NVL(SUM(EXPENDITURE_DURING),0)+(select nvl(sum(EXPENDITURE_UPTO_THE_PRE_YEAR),0) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL  where work_id=workexp.work_id)TOTAL_EXPENDITURE,sum(VALUE_OF_WORK_NOT_PAID)as VALUE_OF_WORK_NOT_PAID " +
			" FROM RWS_WORK_EXPENDITURE_TBL WORKEXP," +
			" RWS_ASSET_TYPE_TBL ASSETTYPE," +
			" RWS_WORK_ADMN_TBL WORKADMN WHERE " +
			" WORKEXP.WORK_ID=WORKADMN.WORK_ID AND " +
			" ASSETTYPE.TYPE_OF_ASSET_CODE=WORKADMN.TYPE_OF_ASSET " +
			" GROUP BY WORKEXP.WORK_ID,WORKADMN.WORK_NAME,WORKADMN.TYPE_OF_ASSET,ASSETTYPE.TYPE_OF_ASSET_NAME)WORKEXP" +
			" WHERE WORKMON.WORK_ID_FOR_RELEASES(+)=WORKEXP.WORK_ID_FOR_EXPENDITURE" ;
			
	 		sqlQuery+=" ) ORDER BY SUBSTR(WORK_ID_FOR_RELEASES,7,2)";
	 		
	 		rs = stmt.executeQuery(sqlQuery);
	 		
	 		//System.out.println("Scheme wise query***"+sqlQuery);
	 		
	 		String workId="";
	 		String workName="";
	 		String typeOfAssetCode="";
	 		String typeOfAssetName="";
	 		
	 		
	 		while (rs.next())
	 		{
	 			if(rs.getString("work_id_for_releases")!=null && !rs.getString("work_id_for_releases").equals(""))
	 			{
	 				workId=rs.getString("work_id_for_releases");
	 				workName=rs.getString("work_name_for_releases");
	 				typeOfAssetCode=rs.getString("type_of_asset_for_releases");
	 				typeOfAssetName=rs.getString("asset_name_for_releases");
	 			}
	 			else if(rs.getString("work_id_for_expenditure")!=null && !rs.getString("work_id_for_expenditure").equals(""))
	 			{
	 				workId=rs.getString("work_id_for_expenditure");
	 				workName=rs.getString("work_name_for_expenditure");
	 				typeOfAssetCode=rs.getString("type_of_asset_for_expenditure");
	 				typeOfAssetName=rs.getString("asset_name_for_expenditure");
	 			}
	 			releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	 			releasesVsExpenditureBean.setWorkId(workId);
	 			releasesVsExpenditureBean.setWorkName(workName);
	 			releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCode);
	 			releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
	 			releasesVsExpenditureBean.setTotalExpenditure(rs.getString("total_expenditure"));
	 			releasesVsExpenditureBean.setTotalReleases(rs.getString("total_releases"));
	 			releasesVsExpenditureBean.setValueOfWorkDoneButNotPaid(rs.getString("VALUE_OF_WORK_NOT_PAID"));
	 			
	 			releasesVsExpenditureList.add(releasesVsExpenditureBean);
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesVsExpenditureList()" +e );
		}
	 	finally
		{
	 		//closeAll();
		}
	 	return releasesVsExpenditureList;
	 }
	 //code modified by sridhar on 06/08/2010
	 public ArrayList getDistinctYearsOfReleasesAndExpenditure(DataSource dataSource)
	 {
	 	
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList yearsList=new ArrayList();
	 	
	 	try 
		{ 
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		String sqlQuery ="SELECT distinct year FROM RWS_WORK_EXPENDITURE_TBL where upper(year) not like '%null%' order by year desc";
	 		
	 		Debug.println("year qry:"+sqlQuery);
	 		rs = stmt.executeQuery(sqlQuery);
	 		 
	 		LabelValueBean labelValueBean=null;
	 		while (rs.next())
	 		{ 
	 			
	 			labelValueBean=new LabelValueBean();
	 			if(rs.getString("YEAR")!=null && !rs.getString("YEAR").equals("null"))
	 			{labelValueBean.setLabel(rs.getString("YEAR"));
	 			labelValueBean.setValue(rs.getString("YEAR"));
	 			yearsList.add(labelValueBean);
	 			}
	 		}
	 		
	 		
		}   
	 	catch ( Exception e ) 
		{
	 		Debug.println("Exception occured in getReleasesVsExpenditureList()" +e );
		}
	 	finally
		{
	 	try{
	 	    if(conn!=null)
	 		conn.close();
	 		}catch(Exception e){
	 			Debug.println(" connection close:"+e);
	 		}
	 		}
		
	 	return yearsList;
	 }
	 
	 
	 public ArrayList getMonths()
	 {
	 	ArrayList monthsList=new ArrayList();
	 	int[] monthsCodes={4,5,6,7,8,9,10,11,12,1,2,3};
	 	String[] monthsNames={"Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan","Feb","Mar",};
	 	try
		{
	 		
	 		LabelValueBean labelValueBean=null;
	 		for (int i=0;i<12;i++)
	 		{
	 			
	 			labelValueBean=new LabelValueBean();
	 			labelValueBean.setValue(monthsCodes[i]+"");
	 			labelValueBean.setLabel(monthsNames[i]);
	 			monthsList.add(labelValueBean);
	 			
	 		}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesVsExpenditureList()" +e );
		}
	 	
	 	return monthsList;
	 }
	 
	 public ArrayList getExpenditureListBetweenDates(DataSource dataSource,String fromYear,String fromMonth,String toYear,String toMonth,String typeOfAssetCode)
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList expenditureList=new ArrayList();
	 	////System.out.println("input values are "+fromYear+" : "+fromMonth+" : "+toYear+" : "+toMonth);
	 	try
		{
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		String query="";
	 		
	 		
	 		String sqlQuery ="SELECT workExp.*,workAdmn.work_name,workAdmn.TYPE_OF_ASSET ,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_WORK_EXPENDITURE_TBL  workExp,RWS_WORK_ADMN_TBL workAdmn,RWS_ASSET_TYPE_TBL ASSETTYPE where workExp.work_id=workAdmn.work_id and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+)  order by workExp.work_id,workExp.year,workExp.month";
	 		//System.out.println(sqlQuery);
	 		rs = stmt.executeQuery(sqlQuery);
	 		String workId="";
	 		String workName="";
	 		//String schemeCode="";
	 		String typeOfAssetCodeLocal="";
	 		String typeOfAssetName="";
	 		//String typeOfAssetName="";
	 		
	 		int totalExp=0;
	 		String workIdTmp="";
	 		
	 		while (rs.next())
	 		{
	 			
	 			////System.out.println("in while");
	 			////System.out.println("actualYear is "+rs.getString("YEAR"));
	 			////System.out.println("actualMonth is "+rs.getString("Month"));
	 			
	 			
	 			////System.out.println("worId: "+rs.getString("work_id")+"fromYear:"+fromYear+" fromMonth:"+fromMonth+" toYear:"+toYear+" toMonth:"+toMonth+" actualYear:"+rs.getString("YEAR")+" actualMonth:"+rs.getString("MONTH")+"falls within:"+doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH")));
	 			////System.out.println(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH"))+"");
	 			if(!workIdTmp.equals(rs.getString("work_id")))
	 			{
	 				if(!workIdTmp.equals(""))
	 				{
		 				if(totalExp!=0)
		 				{
		 					releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
		 					releasesVsExpenditureBean.setWorkId(workId);
		 					releasesVsExpenditureBean.setWorkName(workName);
		 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
		 					releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
		 					releasesVsExpenditureBean.setTotalExpenditure(totalExp+"");
		 					expenditureList.add(releasesVsExpenditureBean);
		 				}
	 				}
	 				workIdTmp=rs.getString("work_id");
	 				totalExp=0;
	 			}
	 			workId=rs.getString("work_id");
	 			workName=rs.getString("work_name");
	 			typeOfAssetCodeLocal=rs.getString("TYPE_OF_ASSET");
	 			typeOfAssetName=rs.getString("TYPE_OF_ASSET_NAME");
	 			
	 			if(rs.getString("EXPENDITURE_DURING")!=null && !rs.getString("EXPENDITURE_DURING").equals(""))
	 			{
	 				
	 					if(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH")))
	 					{
	 						if(typeOfAssetCode.equals(""))
	 		 				{
	 							totalExp=totalExp+Integer.parseInt(rs.getString("EXPENDITURE_DURING"));
	 		 				}
	 						else
	 						{
	 							if(rs.getString("TYPE_OF_ASSET")!=null && typeOfAssetCode.equals(rs.getString("TYPE_OF_ASSET")))
	 								totalExp=totalExp+Integer.parseInt(rs.getString("EXPENDITURE_DURING"));
	 						}
	 						
	 					}
	 				
	 				
	 			}
	 		}
	 		if(!workIdTmp.equals(""))
			{
	 			if(totalExp!=0)
	 			{
	 				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	 				releasesVsExpenditureBean.setWorkId(workId);
	 				releasesVsExpenditureBean.setWorkName(workName);
	 				releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
	 				releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
 					releasesVsExpenditureBean.setTotalExpenditure(totalExp+"");
	 				expenditureList.add(releasesVsExpenditureBean);
	 			}
			}
	 	} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesVsExpenditureList()" +e );
		}
	 	finally
		{
	 		//closeAll();
		}
	 	return expenditureList;
	 }
	 
	 public ArrayList getReleasesListBetweenDates(DataSource dataSource,String fromYear,String fromMonth,String toYear,String toMonth,String typeOfAssetCode)
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList releasesList=new ArrayList();
	 	String typeOfAssetCodeLocal="";
	 		
	 	////System.out.println("input values are "+fromYear+" : "+fromMonth+" : "+toYear+" : "+toMonth);
	 	try
		{
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		String query="";
	 		
	 		
	 		String sqlQuery ="SELECT broDet.*,to_char(loc_date,'yyyy')as locYear,to_char(loc_date,'mm')as locMonth,workAdmn.work_name,workAdmn.TYPE_OF_ASSET,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_LOC_DETAILS_TBL  broDet,RWS_WORK_ADMN_TBL workAdmn ,RWS_ASSET_TYPE_TBL ASSETTYPE where broDet.work_id=workAdmn.work_id  and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+)  order by broDet.work_id";
	 		//System.out.println(sqlQuery);
	 		rs = stmt.executeQuery(sqlQuery);
	 		String workId="";
	 		String workName="";
	 		String typeOfAssetName="";
	 			
	 		int totalReleases=0;
	 		String workIdTmp="";
	 		
	 		while (rs.next())
	 		{
	 			
	 			////System.out.println("in while");
	 			////System.out.println("actualYear is "+rs.getString("YEAR"));
	 			////System.out.println("actualMonth is "+rs.getString("Month"));
	 			
	 			
	 			////System.out.println("worId: "+rs.getString("work_id")+"fromYear:"+fromYear+" fromMonth:"+fromMonth+" toYear:"+toYear+" toMonth:"+toMonth+" actualYear:"+rs.getString("YEAR")+" actualMonth:"+rs.getString("MONTH")+"falls within:"+doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH")));
	 			////System.out.println(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH"))+"");
	 			if(!workIdTmp.equals(rs.getString("work_id")))
	 			{
	 				if(!workIdTmp.equals(""))
	 				{
		 				if(totalReleases!=0)
		 				{
		 					releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
		 					releasesVsExpenditureBean.setWorkId(workId);
		 					releasesVsExpenditureBean.setWorkName(workName);
		 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
		 					releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
		 					releasesVsExpenditureBean.setTotalReleases(totalReleases+"");
		 					releasesList.add(releasesVsExpenditureBean);
		 				}
	 				}
	 				workIdTmp=rs.getString("work_id");
	 				totalReleases=0;
	 			}
	 			workId=rs.getString("work_id");
	 			workName=rs.getString("work_name");
	 			typeOfAssetCodeLocal=rs.getString("TYPE_OF_ASSET");
	 			typeOfAssetName=rs.getString("TYPE_OF_ASSET_NAME");
	 			
	 			if(rs.getString("LOC_AMOUNT")!=null && !rs.getString("LOC_AMOUNT").equals(""))
	 			{
	 				
	 					if(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,getFinancialYear(rs.getString("LOCYEAR"),rs.getString("LOCMONTH")),rs.getString("LOCMONTH")))
	 					{
	 						if(typeOfAssetCode.equals(""))
	 		 				{
	 							totalReleases=totalReleases+Integer.parseInt(rs.getString("LOC_AMOUNT"));
	 		 				}
	 						else
	 						{
	 							if(rs.getString("TYPE_OF_ASSET")!=null && typeOfAssetCode.equals(rs.getString("TYPE_OF_ASSET")))
	 								totalReleases=totalReleases+Integer.parseInt(rs.getString("LOC_AMOUNT"));
	 						}
	 						
	 					}
	 				
	 				
	 			}
	 		}
	 		if(!workIdTmp.equals(""))
			{
	 			if(totalReleases!=0)
	 			{
	 				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	 				releasesVsExpenditureBean.setWorkId(workId);
	 				releasesVsExpenditureBean.setWorkName(workName);
	 				releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
	 				releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
 					releasesVsExpenditureBean.setTotalReleases(totalReleases+"");
	 				releasesList.add(releasesVsExpenditureBean);
	 			}
			}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesListBetweenDates()" +e );
		}
	 	finally
		{
	 		//closeAll();
		}
	 	return releasesList;
	 }
	 
	 public ArrayList getReleasesListBetweenDates(DataSource dataSource,String fromYear,String fromMonth,String toYear,String toMonth,String circleOfficeCode,String typeOfAssetCode)
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList releasesList=new ArrayList();
	 	String typeOfAssetCodeLocal="";
	 		
	 	////System.out.println("input values are "+fromYear+" : "+fromMonth+" : "+toYear+" : "+toMonth);
	 	try
		{ 
	 		 
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		String query="";
	 		
	 		String sqlQuery="";
	 		if(circleOfficeCode==null || circleOfficeCode.equals(""))
	 			sqlQuery ="SELECT broDet.*,substr(broDet.work_id,5,2)as circle_Office_Code,circle.circle_office_name,to_char(loc_date,'yyyy')as locYear,to_char(loc_date,'mm')as locMonth,workAdmn.work_name,workAdmn.TYPE_OF_ASSET,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_LOC_DETAILS_TBL  broDet,RWS_WORK_ADMN_TBL workAdmn ,RWS_ASSET_TYPE_TBL ASSETTYPE,RWS_CIRCLE_OFFICE_TBL CIRCLE where broDet.work_id=workAdmn.work_id  and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+) AND CIRCLE.CIRCLE_OFFICE_CODE=SUBSTR(WORKADMN.WORK_ID,5,2)  order by broDet.work_id";
	 		else
	 			sqlQuery ="SELECT broDet.*,substr(broDet.work_id,5,2)as circle_Office_Code,circle.circle_office_name,to_char(loc_date,'yyyy')as locYear,to_char(loc_date,'mm')as locMonth,workAdmn.work_name,workAdmn.TYPE_OF_ASSET,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_LOC_DETAILS_TBL  broDet,RWS_WORK_ADMN_TBL workAdmn ,RWS_ASSET_TYPE_TBL ASSETTYPE,RWS_CIRCLE_OFFICE_TBL CIRCLE where broDet.work_id=workAdmn.work_id  and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+) and substr(broDet.work_id,5,2)='"+circleOfficeCode+"' AND CIRCLE.CIRCLE_OFFICE_CODE=SUBSTR(WORKADMN.WORK_ID,5,2) order by broDet.work_id";
	 		Debug.println("exp in release details:"+sqlQuery);
	 		rs = stmt.executeQuery(sqlQuery);
	 		String workId="";
	 		String workName="";
	 		String typeOfAssetName="";
	 		String circleOfficeCodeLocal="";
	 		String circleOfficeName="";
	 		
	 		
	 			
	 		int totalReleases=0;
	 		String workIdTmp="";
	 		
	 		while (rs.next())
	 		{
	 			
	 			
	 			if(!workIdTmp.equals(rs.getString("work_id")))
	 			{
	 				if(!workIdTmp.equals(""))
	 				{
		 				if(totalReleases!=0)
		 				{
		 					releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
		 					releasesVsExpenditureBean.setWorkId(workId);
		 					releasesVsExpenditureBean.setWorkName(workName);
		 					releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCodeLocal);
		 					releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
		 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
		 					releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
		 					releasesVsExpenditureBean.setTotalReleases(totalReleases+"");
		 					releasesList.add(releasesVsExpenditureBean);
		 				}
	 				}
	 				workIdTmp=rs.getString("work_id");
	 				totalReleases=0;
	 			}
	 			workId=rs.getString("work_id");
	 			workName=rs.getString("work_name");
	 			typeOfAssetCodeLocal=rs.getString("TYPE_OF_ASSET");
	 			typeOfAssetName=rs.getString("TYPE_OF_ASSET_NAME");
	 			circleOfficeCodeLocal=rs.getString("CIRCLE_OFFICE_CODE");
	 			circleOfficeName=rs.getString("CIRCLE_OFFICE_NAME");
	 			
	 			if(rs.getString("LOC_AMOUNT")!=null && !rs.getString("LOC_AMOUNT").equals(""))
	 			{
	 				
	 					if(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,getFinancialYear(rs.getString("LOCYEAR"),rs.getString("LOCMONTH")),rs.getString("LOCMONTH")))
	 					{
	 						if(typeOfAssetCode.equals(""))
	 		 				{
	 							totalReleases=totalReleases+Integer.parseInt(rs.getString("LOC_AMOUNT"));
	 		 				}
	 						else
	 						{
	 							if(rs.getString("TYPE_OF_ASSET")!=null && typeOfAssetCode.equals(rs.getString("TYPE_OF_ASSET")))
	 								totalReleases=totalReleases+Integer.parseInt(rs.getString("LOC_AMOUNT"));
	 						}
	 						
	 					}
	 				
	 				
	 			}
	 		}
	 		if(!workIdTmp.equals(""))
			{
	 			if(totalReleases!=0)
	 			{
	 				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	 				releasesVsExpenditureBean.setWorkId(workId);
	 				releasesVsExpenditureBean.setWorkName(workName);
	 				releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCodeLocal);
	 				releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
	 				releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
 					releasesVsExpenditureBean.setTotalReleases(totalReleases+"");
	 				releasesList.add(releasesVsExpenditureBean);
	 			}
			}
	 		 
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesListBetweenDates()" +e );
		}
	 	finally
		{
	 		////closeAll();
		}
	 	return releasesList;
	 }
	 
	 public ArrayList getExpenditureListBetweenDates(DataSource dataSource,String fromYear,String fromMonth,String toYear,String toMonth,String circleOfficeCode,String typeOfAssetCode)
	 {
	 	//ConnectionManager connMgr=new ConnectionManager(dataSource);
	 	Connection conn=null;
	 	Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
	 	ArrayList expenditureList=new ArrayList();
	 	////System.out.println("input values are "+fromYear+" : "+fromMonth+" : "+toYear+" : "+toMonth);
	 	try
		{
	 		
	 		conn=RwsOffices.getConn();
	 		stmt=conn.createStatement();
	 		StringBuffer sqlQuery=new StringBuffer("");
	 		
	 		//if(circleOfficeCode==null || circleOfficeCode.equals(""))
	 		sqlQuery.append("SELECT workExp.*,substr(workExp.work_id,5,2)as circle_office_code,CIRCLE.CIRCLE_OFFICE_NAME,workAdmn.work_name,workAdmn.TYPE_OF_ASSET ,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_WORK_EXPENDITURE_TBL  workExp,RWS_WORK_ADMN_TBL workAdmn,RWS_ASSET_TYPE_TBL ASSETTYPE,RWS_CIRCLE_OFFICE_TBL CIRCLE where workExp.work_id=workAdmn.work_id and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+) AND SUBSTR(WORKADMN.WORK_ID,5,2)=CIRCLE.CIRCLE_OFFICE_CODE ");
	 		if(circleOfficeCode!=null && !circleOfficeCode.equals(""))
	 		{
	 			sqlQuery.append(" and substr(workExp.work_id,5,2)='"+circleOfficeCode+"'");
	 		}
	 		sqlQuery.append("order by workExp.work_id,workExp.year,workExp.month");
	 		
	 		//sqlQuery ="SELECT workExp.*,substr(workExp.work_id,5,2)as circle_office_code,CIRCLE.CIRCLE_OFFICE_NAME,workAdmn.work_name,workAdmn.TYPE_OF_ASSET ,ASSETTYPE.TYPE_OF_ASSET_NAME  FROM RWS_WORK_EXPENDITURE_TBL  workExp,RWS_WORK_ADMN_TBL workAdmn,RWS_ASSET_TYPE_TBL ASSETTYPE,RWS_CIRCLE_OFFICE_TBL CIRCLE where workExp.work_id=workAdmn.work_id and workAdmn.TYPE_OF_ASSET=assetType.TYPE_OF_ASSET_CODE(+)  and substr(workExp.work_id,5,2)='"+circleOfficeCode+"' AND CIRCLE.CIRCLE_OFFICE_CODE=SUBSTR(WORKADMN.WORK_ID,5,2) order by workExp.work_id,workExp.year,workExp.month";
	 	
	 		Debug.println("exp b/n dates:"+sqlQuery);
	 		rs = stmt.executeQuery(sqlQuery.toString());
	 		String workId="";
	 		String workName="";
	 		//String schemeCode="";
	 		String typeOfAssetCodeLocal="";
	 		String typeOfAssetName="";
	 		String circleOfficeCodeLocal="";
	 		String circleOfficeName="";
	 		//String typeOfAssetName="";
	 		
	 		
	 		
	 		int totalExp=0;
	 		String workIdTmp=""; 
	 		
	 		while (rs.next()) 
	 		{
	 			Debug.println("Get work id...."+rs.getString("work_id"));
	 			if(!workIdTmp.equals(rs.getString("work_id")))
	 			{
	 				Debug.println("workIdTmp:"+workIdTmp);
	 				if(!workIdTmp.equals(""))
	 				{
	 					Debug.println("workIdTmp 222:"+workIdTmp);
		 				if(totalExp!=0)
		 				{
		 					releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
		 					releasesVsExpenditureBean.setWorkId(workId);
		 					releasesVsExpenditureBean.setWorkName(workName);
		 		 			releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCodeLocal);
		 					releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
		 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
		 					releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
		 					releasesVsExpenditureBean.setTotalExpenditure(totalExp+"");
		 					expenditureList.add(releasesVsExpenditureBean);
		 				}
	 				}
	 				workIdTmp=rs.getString("work_id");
	 				totalExp=0;
	 			}
	 			workId=rs.getString("work_id");
	 			workName=rs.getString("work_name");
	 			typeOfAssetCodeLocal=rs.getString("TYPE_OF_ASSET");
	 			typeOfAssetName=rs.getString("TYPE_OF_ASSET_NAME");
	 			circleOfficeCodeLocal=rs.getString("CIRCLE_OFFICE_CODE");
	 			circleOfficeName=rs.getString("CIRCLE_OFFICE_NAME");
	 			
	 			if(rs.getString("EXPENDITURE_DURING")!=null && !rs.getString("EXPENDITURE_DURING").equals(""))
	 			{
	 				
	 					if(doesDateFallWithInRange(fromYear,fromMonth,toYear,toMonth,rs.getString("YEAR"),rs.getString("MONTH")))
	 					{
	 						if(typeOfAssetCode.equals(""))
	 		 				{
	 							totalExp=totalExp+Integer.parseInt(rs.getString("EXPENDITURE_DURING"));
	 		 				}
	 						else
	 						{
	 							if(rs.getString("TYPE_OF_ASSET")!=null && typeOfAssetCode.equals(rs.getString("TYPE_OF_ASSET")))
	 								totalExp=totalExp+Integer.parseInt(rs.getString("EXPENDITURE_DURING"));
	 						}
	 						
	 					}
	 				
	 				
	 			}
	 		}
	 		if(!workIdTmp.equals(""))
			{
	 			if(totalExp!=0)
	 			{
	 				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
	 				releasesVsExpenditureBean.setWorkId(workId);
	 				releasesVsExpenditureBean.setWorkName(workName);
	 				releasesVsExpenditureBean.setCircleOfficeCode(circleOfficeCodeLocal);
	 				releasesVsExpenditureBean.setCircleOfficeName(circleOfficeName);
 					releasesVsExpenditureBean.setTypeOfAssetCode(typeOfAssetCodeLocal);
	 				releasesVsExpenditureBean.setTypeOfAssetName(typeOfAssetName);
 					releasesVsExpenditureBean.setTotalExpenditure(totalExp+"");
	 				expenditureList.add(releasesVsExpenditureBean);
	 			}
			}
	 		
	 		
		} 
	 	catch ( Exception e ) 
		{
	 		//System.out.println("Exception occured in getReleasesVsExpenditureList()" +e );
		}
	 	finally
		{
	 		////closeAll();
		}
	 	return expenditureList;
	 }

	 
	 
	boolean doesDateFallWithInRange(String fromYear,String fromMonth,String toYear,String toMonth,String actualYear,String actualMonth)
	{
		//Note: empty string is treated as all
		////System.out.println("values in doesDateFallWithInRange are");
		int fromYearInt=0;
		int toYearInt=0;
		int actualYearInt=0;
		int arr[]={0,10,11,12,1,2,3,4,5,6,7,8,9};
		int fromMonth_financial=0;
		int toMonth_financial=0;
		int actualMonth_financial=0;
		
		
		
		if(fromYear!=null && fromYear.length()>3)
			fromYearInt=Integer.parseInt(fromYear.substring(0,4));
		if(toYear!=null && toYear.length()>3)
			toYearInt=Integer.parseInt(toYear.substring(0,4));
		if(actualYear!=null && actualYear.length()>3)
			actualYearInt=Integer.parseInt(actualYear.substring(0,4));
		
		if(fromMonth!=null && !fromMonth.equals(""))
			fromMonth_financial=arr[Integer.parseInt(fromMonth)];
		if(toMonth!=null && !toMonth.equals(""))
			toMonth_financial=arr[Integer.parseInt(toMonth)];
		if(actualMonth!=null && !actualMonth.equals(""))
			actualMonth_financial=arr[Integer.parseInt(actualMonth)];
		
		
		////System.out.println("values in doesDateFallWithInRange are");
		////System.out.println(fromYearInt+" : "+fromMonth_financial+" : "+toYearInt+" : "+toMonth_financial+" : "+actualYearInt+" : "+actualMonth_financial);
		if(fromYear.equals(""))
			return true;
		else if(fromMonth.equals(""))
		{
			if(actualYearInt>fromYearInt||actualYearInt==fromYearInt)
				return true;
			else
				return false;
		}
		else if(toYear.equals(""))
		{
			if((actualYearInt==fromYearInt||actualYearInt>fromYearInt) && (actualMonth_financial==fromMonth_financial||actualMonth_financial>fromMonth_financial))
				return true;
			else
				return false;
		}
		else if(toMonth.equals(""))
		{
			if(fromYearInt==toYearInt)
			{
				if(fromYearInt==actualYearInt)
				{
					if(actualMonth_financial==fromMonth_financial||actualMonth_financial>fromMonth_financial)
						return true;
					else
						return false;
				}
				else 
					return false;
			}
			else if(toYearInt>fromYearInt)
			{
				if(actualYearInt>fromYearInt && actualYearInt<toYearInt)
					return true;
				else if((actualYearInt==fromYearInt||actualYearInt>fromYearInt)  && (actualYearInt==toYearInt||actualYearInt<toYearInt))
				{
					if(actualYearInt==fromYearInt)
					{
						if(actualMonth_financial==fromMonth_financial||actualMonth_financial>fromMonth_financial)
							return true;
						else
							return false;
					}
					else if(actualYearInt>fromYearInt)
					{
						return true;
					}
				}
				else
					return false;
			}
		}
		if(!fromYear.equals("")&&!fromMonth.equals("")&&!toYear.equals("")&&!toMonth.equals("")&&!actualYear.equals("")&&!actualMonth.equals(""))
		{
			if((actualYearInt==fromYearInt || actualYearInt>fromYearInt)&&(actualYearInt==toYearInt || actualYearInt<toYearInt))
			{
				int monthsBetweenStartAndEnd=getNoOfMonthsBetween(fromYearInt,fromMonth_financial,toYearInt,toMonth_financial);
				int monthsBetweenStartAndEndOfActualRec=getNoOfMonthsBetween(fromYearInt,fromMonth_financial,actualYearInt,actualMonth_financial);
				////System.out.println("NoOfMonthsBetweenStartAndEnd : "+monthsBetweenStartAndEnd);
				////System.out.println("NoOfMonthsBetweenActualAndStart : "+monthsBetweenStartAndEndOfActualRec);
				if(monthsBetweenStartAndEndOfActualRec==monthsBetweenStartAndEnd||(monthsBetweenStartAndEndOfActualRec>0&&monthsBetweenStartAndEndOfActualRec<monthsBetweenStartAndEnd))
					return true;
				else
					return false;
			}
		}
			
		return false;
	}
	
	int getNoOfMonthsBetween(int startYear,int startMonth,int endYear,int endMonth)
	{
		int noOfYearsInBetween=endYear-startYear+1;
		int noOfMonths=0;
		if(startYear==endYear)
		{
			noOfMonths=endMonth-startMonth+1;
		}
		else if(noOfYearsInBetween>1)
		{
			noOfMonths=noOfYearsInBetween*12;
			int monthsNotCovered=startMonth-1;
			noOfMonths=noOfMonths-monthsNotCovered;
			monthsNotCovered=12-endMonth;
			noOfMonths=noOfMonths-monthsNotCovered;
			
		}
		return noOfMonths;
	}
	
	String getFinancialYear(String year,String month)
	{
		int intYear=Integer.parseInt(year);
		int intMonth=Integer.parseInt(month);
		String financialYear="";
		if(year==null||year.equals("")||month==null||month.equals(""))
			return null;
		if(intMonth>3)
			financialYear=intYear+"-"+(intYear+1);
		else if(intMonth<4&&intMonth!=0)
			financialYear=(intYear-1)+"-"+intYear;
			
		//System.out.println("financialYear is "+financialYear);
		return financialYear;
	}
	 //End of Methods for ReleasesVsExpenditure SchemeWise
	
	//Begin of Methods for ReleasesVsExpenditure ProgrammeWise
	public ArrayList getReleasesVsExpenditureProgrammesList()
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        LabelValueBean labelValueBean=null;
       
        ArrayList releasesVsExpenditureProgrammesList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT distinct workExp.PROGRAMME_CODE,p.programme_name from  rws_work_expenditure_tbl workExp,rws_programme_tbl p where workExp.programme_code=p.programme_code order by p.programme_name" ;
	      //  System.out.println("**In releases v.s Expenditure Progwise****"+sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);
	        
            while (rs.next())
            {
            	labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString("programme_code"));
				labelValueBean.setLabel(rs.getString("programme_name"));
				releasesVsExpenditureProgrammesList.add(labelValueBean);
            }
           

        } 
        catch ( Exception e ) 
		{
            //System.out.println("Exception occured in getReleasesVsExpenditureProgrammesList" +e );
        }
        finally
		{
          //closeAll();
		}
        return releasesVsExpenditureProgrammesList;
	}
	
	public ArrayList getReleasesVsExpenditureYearsList()
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        LabelValueBean labelValueBean=null;
       
        ArrayList releasesVsExpenditureYearsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT distinct workExp.year from  rws_work_expenditure_tbl workExp order by year desc" ;
	        
            
	        rs = stmt.executeQuery(sqlQuery);
	        
            while (rs.next())
            {
            	labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString("year"));
				labelValueBean.setLabel(rs.getString("year"));
				releasesVsExpenditureYearsList.add(labelValueBean);
            }
           

        } 
        catch ( Exception e ) 
		{
            //System.out.println("Exception occured in getReleasesVsExpenditureYearsList " +e );
        }
        finally
		{
          //closeAll();
		}
        return releasesVsExpenditureYearsList;
	}
	
	//added by ramesh on 17/10/08
	
	public ArrayList getReleasesVsExpenditureYearsList1()
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
        Connection conn=null;
        LabelValueBean labelValueBean=null;
       ArrayList releasesVsExpenditureYearsList=new ArrayList();
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
	        String sqlQuery = "SELECT distinct workExp.year from  rws_work_expenditure_tbl workExp order by year desc" ;
	        //System.out.println(sqlQuery);
            
	        rs = stmt.executeQuery(sqlQuery);
	        int i = 0;
            while (rs.next())
            {
            	releasesVsExpenditureYearsList.add(i++,rs.getString(1));
            }
           

        } 
        catch ( Exception e ) 
		{
            //System.out.println("Exception occured in getReleasesVsExpenditureYearsList " +e );
        }
        finally
		{
          //closeAll();
		}
        return releasesVsExpenditureYearsList;
	}
	
	public ArrayList getReleasesVsExpenditureProgWiseList(String year,String programmeCode)
	{
		////ConnectionManager connMgr=new ConnectionManager(dataSource);
        
		Connection conn=null;
        Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
        Statement stmt2=null;
        ResultSet rs1=null;
        ArrayList releasesVsExpenditureProgWiseList=new ArrayList();
        String[] months={"","January","February","March","April","May","June","July","August","September","October","November","December"};
        try
		{

        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
            
            String sqlQuery="";
            if((programmeCode==null||programmeCode.equals(""))&&(year==null||year.equals("")))
            	sqlQuery = "select distinct workAdmn.work_id,workAdmn.work_name,substr(workAdmn.work_id,5,2)as circle_office_code,cot.circle_office_name,workExp.PROGRAMME_CODE,p.programme_name from rws_work_expenditure_tbl workExp,rws_work_admn_tbl workAdmn,rws_programme_tbl p,rws_circle_office_tbl cot where workExp.work_id=workAdmn.work_id and workExp.programme_code=p.programme_code and substr(workExp.work_id,5,2)=cot.circle_office_code order by workExp.programme_code,substr(workAdmn.work_id,5,2)" ;
            else if((programmeCode==null||programmeCode.equals(""))&&!(year==null||year.equals("")))
            	sqlQuery = "select distinct workAdmn.work_id,workAdmn.work_name,substr(workExp.work_id,5,2)as circle_office_code,cot.circle_office_name,p.programme_name from rws_work_expenditure_tbl workExp,rws_work_admn_tbl workAdmn,rws_programme_tbl p,rws_circle_office_tbl cot where workExp.work_id=workAdmn.work_id and  workExp.programme_code=p.programme_code and year='"+year+"' and substr(workExp.work_id,5,2)=cot.circle_office_code order by workExp.programme_code,substr(workAdmn.work_id,5,2)" ;
	        else if(!(programmeCode==null||programmeCode.equals(""))&&(year==null||year.equals("")))
            	sqlQuery = "select distinct workAdmn.work_id,workAdmn.work_name,substr(workExp.work_id,5,2)as circle_office_code,cot.circle_office_name,p.programme_name from rws_work_expenditure_tbl workExp,rws_work_admn_tbl workAdmn,rws_programme_tbl p,rws_circle_office_tbl cot where workExp.work_id=workAdmn.work_id and   workExp.programme_code=p.programme_code and workExp.programme_code='"+programmeCode+"' and substr(workExp.work_id,5,2)=cot.circle_office_code order by substr(workAdmn.work_id,5,2)" ;
	        else if(!(programmeCode==null||programmeCode.equals(""))&&!(year==null||year.equals("")))
            	sqlQuery = "select distinct workAdmn.work_id,workAdmn.work_name,substr(workExp.work_id,5,2)as circle_office_code,cot.circle_office_name,p.programme_name from rws_work_expenditure_tbl workExp,rws_work_admn_tbl workAdmn,rws_programme_tbl p,rws_circle_office_tbl cot where workExp.work_id=workAdmn.work_id and  workExp.programme_code=p.programme_code and workExp.programme_code='"+programmeCode+"' and year='"+year+"' and substr(workExp.work_id,5,2)=cot.circle_office_code order by substr(workAdmn.work_id,5,2)" ;
	        
	        
	        System.out.println("Expenditure query"+sqlQuery);
	        
	      String qrr = "";
	      int totExp = 0,count=0;
            stmt2 = conn.createStatement();
	        rs = stmt.executeQuery(sqlQuery);
	        while(rs.next())
	        {
	        	count++;
	        	qrr = "select sum(expenditure_during) from rws_work_expenditure_tbl where work_id='"+rs.getString(1)+"'";
	        	rs1 = stmt2.executeQuery(qrr);
	        	if(rs1.next()) totExp = rs1.getInt(1);

            	int month=0;
            	/*try{
            	if(rs.getString("month")!=null)
            		month=Integer.parseInt(rs.getString("month"));
            	}catch(Exception e){
            		//System.out.println("Exception is "+e);}
            	}*/
            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
            	releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
            	releasesVsExpenditureBean.setWorkName(rs.getString("work_name"));
            	//releasesVsExpenditureBean.setYear(rs.getString("year"));
            	//releasesVsExpenditureBean.setMonth(months[month]);
            	releasesVsExpenditureBean.setExpenditureDuring(""+totExp);
            	//releasesVsExpenditureBean.setValueOfWorkDoneButNotPaid(rs.getString("VALUE_OF_WORK_NOT_PAID"));
            	//releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
            	releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
            	releasesVsExpenditureBean.setCircleOfficeCode(rs.getString("circle_office_code"));
            	releasesVsExpenditureBean.setCircleOfficeName(rs.getString("circle_office_name"));
            	//releasesVsExpenditureBean.setCircleOfficeName(convertEnWordToTeWord(rs.getString("circle_office_name")));
            	releasesVsExpenditureProgWiseList.add(releasesVsExpenditureBean);
            	
            	
            
	        	
	        }
	        /*
            while (rs.next())
            {
            	int month=0;
            	try{
            	if(rs.getString("month")!=null)
            		month=Integer.parseInt(rs.getString("month"));
            	}catch(Exception e){
            		//System.out.println("Exception is "+e);}
            	}
            	releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
            	releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
            	releasesVsExpenditureBean.setWorkName(rs.getString("work_name"));
            	releasesVsExpenditureBean.setYear(rs.getString("year"));
            	releasesVsExpenditureBean.setMonth(months[month]);
            	releasesVsExpenditureBean.setExpenditureDuring(rs.getString("expenditure_during"));
            	releasesVsExpenditureBean.setValueOfWorkDoneButNotPaid(rs.getString("VALUE_OF_WORK_NOT_PAID"));
            	releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
            	releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
            	releasesVsExpenditureBean.setCircleOfficeCode(rs.getString("circle_office_code"));
            	releasesVsExpenditureBean.setCircleOfficeName(rs.getString("circle_office_name"));
            	//releasesVsExpenditureBean.setCircleOfficeName(convertEnWordToTeWord(rs.getString("circle_office_name")));
            	releasesVsExpenditureProgWiseList.add(releasesVsExpenditureBean);
            }
           */
//System.out.println("count::"+count);
        } 
        catch ( Exception e ) 
		{
             System.out.println("Exception occured in getReleasesVsExpenditureYearsList " +e );
        }
        finally
		{
          //closeAll();
		}
        return releasesVsExpenditureProgWiseList;
	}
	
	public ArrayList getReleasesVsExpenditureProgWiseDrill(String year)
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
		Connection conn=null;
		Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
		
		ArrayList releasesVsExpenditureProgWiseList=new ArrayList();
		String[] months={"","January","February","March","April","May","June","July","August","September","October","November","December"};
		try
		{
			
			conn=RwsOffices.getConn();
			stmt=conn.createStatement();
			String sqlQuery="";
			if(year.equals(""))
			{
				sqlQuery="select * from " 
					+ " (select workExp.programme_code,p.programme_name," 
					+ " sum(workExp.expenditure_during)as expenditure_during_sum" 
					+ " from rws_work_expenditure_tbl workExp,rws_programme_tbl p" 
					+ " where workExp.programme_code=p.programme_code " 
					+ " group by workExp.programme_code,p.programme_name) t1," 
					+ " (select locDet.programme_code,p.programme_name," 
					+ " sum(locDet.loc_amount)as locSum from rws_loc_details_tbl locDet," 
					+ " rws_programme_tbl p where locDet.programme_code=p.programme_code" 
					+ " and locDet.office_from_code='100000' group by " 
					+ " locDet.programme_code,p.programme_name) t2 where " 
					+ " t1.programme_code(+)=t2.programme_code"; 
				
				sqlQuery+=" union ";
				
				sqlQuery+=" select * from " 
					+ " (select workExp.programme_code,p.programme_name," 
					+ " sum(workExp.expenditure_during)as expenditure_during_sum" 
					+ " from rws_work_expenditure_tbl workExp,rws_programme_tbl p" 
					+ " where workExp.programme_code=p.programme_code  " 
					+ " group by workExp.programme_code,p.programme_name) t1," 
					+ " (select locDet.programme_code,p.programme_name," 
					+ " sum(locDet.loc_amount)as locSum from rws_loc_details_tbl locDet," 
					+ " rws_programme_tbl p where locDet.programme_code=p.programme_code" 
					+ " and locDet.office_from_code='100000' group by " 
					+ " locDet.programme_code,p.programme_name) t2 where " 
					+ " t1.programme_code=t2.programme_code (+)";
				
			}
			else
			{
				sqlQuery="select * from " 
					+ " (select workExp.programme_code,p.programme_name," 
					+ " sum(workExp.expenditure_during)as expenditure_during_sum" 
					+ " from rws_work_expenditure_tbl workExp,rws_programme_tbl p" 
					+ " where workExp.programme_code=p.programme_code and workExp.year='"+year+"' " 
					+ " group by workExp.programme_code,p.programme_name) t1," 
					+ " (select locDet.programme_code,p.programme_name," 
					+ " sum(locDet.loc_amount)as locSum from rws_loc_details_tbl locDet," 
					+ " rws_programme_tbl p where locDet.programme_code=p.programme_code" 
					+ " and locDet.office_from_code='100000' " 
					+ " and getFinancialYear(to_char(locDet.loc_date,'yyyy'),to_char(locDet.loc_date,'mm'))='"+year+"' group by " 
					+ " locDet.programme_code,p.programme_name) t2 where " 
					+ " t1.programme_code(+)=t2.programme_code"; 
				
				sqlQuery+=" union ";
				
				sqlQuery+=" select * from " 
					+ " (select workExp.programme_code,p.programme_name," 
					+ " sum(workExp.expenditure_during)as expenditure_during_sum" 
					+ " from rws_work_expenditure_tbl workExp,rws_programme_tbl p" 
					+ " where workExp.programme_code=p.programme_code   and workExp.year='"+year+"' "
					+ " group by workExp.programme_code,p.programme_name) t1," 
					+ " (select locDet.programme_code,p.programme_name," 
					+ " sum(locDet.loc_amount)as locSum from rws_loc_details_tbl locDet," 
					+ " rws_programme_tbl p where locDet.programme_code=p.programme_code" 
					+ " and locDet.office_from_code='100000'  and " 
					+ " getFinancialYear(to_char(locDet.loc_date,'yyyy'),to_char(locDet.loc_date,'mm'))='"+year+"' group by "
					+ " locDet.programme_code,p.programme_name) t2 where " 
					+ " t1.programme_code=t2.programme_code (+)";
			}
			
			System.out.println("Sql Query:"+sqlQuery);
			rs = stmt.executeQuery(sqlQuery);
			
			while (rs.next())
			{
				String programmeCode="";
				String programmeName="";
				int month=0;
				if(rs.getString(1)!=null)
				{
					programmeCode=rs.getString(1);
					programmeName=rs.getString(2);
				}
				else if(rs.getString(4)!=null)
				{
					programmeCode=rs.getString(4);
					programmeName=rs.getString(5);
				}
				else
				{
					programmeCode="";
					programmeName="";
				}
				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
				releasesVsExpenditureBean.setProgrammeCode(programmeCode);
				releasesVsExpenditureBean.setProgrammeName(programmeName);
				releasesVsExpenditureBean.setTotalExpenditure(rs.getString("EXPENDITURE_DURING_SUM"));
				releasesVsExpenditureBean.setTotalReleases(rs.getString("LOCSUM"));
				releasesVsExpenditureProgWiseList.add(releasesVsExpenditureBean);
			}
			
			
		} 
		catch ( Exception e ) 
		{
			//System.out.println("Exception occured in getReleasesVsExpenditureProgWiseDrill " +e );
		}
		finally
		{
			//closeAll();
		}
		return releasesVsExpenditureProgWiseList;
	}
	public ArrayList getReleasesDetails(String year,String programmeCode)
	{
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
		Connection conn=null;
		Rws_ReleasesVsExp_WorkWise_Bean releasesVsExpenditureBean=null;
		
		ArrayList releasesVsExpenditureProgWiseList=new ArrayList();
		try
		{
			
			conn=RwsOffices.getConn();
			stmt=conn.createStatement();
			String sqlQuery="";
			if((year==null||year.equals(""))&&(programmeCode==null||programmeCode.equals("")))
			{
				sqlQuery="select locDet.*,to_char(locDet.loc_date,'dd/mm/yyyy')as locDate,locDet.district_code as circleOfficeCode,p.programme_name,cot.circle_office_name," 
					+ " workAdmn.work_name from rws_loc_details_tbl locDet," 
					+ " rws_programme_tbl p,rws_work_admn_tbl workAdmn," 
					+ " rws_circle_office_tbl cot where " 
					+ " locDet.district_code=cot.circle_office_code " 
					+ " and locDet.work_id=workAdmn.work_id(+) and " 
					+ " locDet.programme_code=p.programme_code and " 
					+ " locDet.office_from_code='100000' order by locDet.programme_code," 
					+ " locDet.district_code,locDet.work_id";
				
			}
			else if((year==null||year.equals(""))&&!(programmeCode==null||programmeCode.equals("")))
			{
			sqlQuery="select locDet.*,to_char(locDet.loc_date,'dd/mm/yyyy')as locDate,locDet.district_code as circleOfficeCode,p.programme_name,cot.circle_office_name," 
				+ " workAdmn.work_name from rws_loc_details_tbl locDet," 
				+ " rws_programme_tbl p,rws_work_admn_tbl workAdmn," 
				+ " rws_circle_office_tbl cot where " 
				+ " locDet.district_code=cot.circle_office_code " 
				+ " and locDet.work_id=workAdmn.work_id(+) and " 
				+ " locDet.programme_code=p.programme_code and " 
				+ " locDet.office_from_code='100000' and " 
				+ " locDet.programme_code='"+programmeCode+"' " 
				+ " order by locDet.programme_code,locDet.district_code,locDet.work_id";
			}
			else if(!(year==null||year.equals(""))&&(programmeCode==null||programmeCode.equals("")))
			{
			sqlQuery="select locDet.*,to_char(locDet.loc_date,'dd/mm/yyyy')as locDate,locDet.district_code as circleOfficeCode,p.programme_name,cot.circle_office_name," 
				+ " workAdmn.work_name from rws_loc_details_tbl locDet," 
				+ " rws_programme_tbl p,rws_work_admn_tbl workAdmn," 
				+ " rws_circle_office_tbl cot where " 
				+ " locDet.district_code=cot.circle_office_code " 
				+ " and locDet.work_id=workAdmn.work_id(+) and " 
				+ " locDet.programme_code=p.programme_code and " 
				+ " locDet.office_from_code='100000'  and " 
				+ " getFinancialYear(to_char(loc_date,'yyyy'),to_char(loc_date,'mm'))='"+year+"'"
				+ " order by locDet.programme_code,locDet.district_code,locDet.work_id";
			}
			else if(!(year==null||year.equals(""))&&!(programmeCode==null||programmeCode.equals("")))
			{
			sqlQuery="select locDet.*,to_char(locDet.loc_date,'dd/mm/yyyy')as locDate,locDet.district_code as circleOfficeCode,p.programme_name,cot.circle_office_name," 
				+ " workAdmn.work_name from rws_loc_details_tbl locDet," 
				+ " rws_programme_tbl p,rws_work_admn_tbl workAdmn," 
				+ " rws_circle_office_tbl cot where  " 
				+ " locDet.district_code=cot.circle_office_code " 
				+ " and locDet.work_id=workAdmn.work_id(+) and " 
				+ " locDet.programme_code=p.programme_code and " 
				+ " locDet.office_from_code='100000' and " 
				+ " getFinancialYear(to_char(loc_date,'yyyy'),to_char(loc_date,'mm'))='"+year+"'" 
				+ " and locDet.programme_code='"+programmeCode+"'  order by " 
				+ " locDet.programme_code,locDet.district_code,locDet.work_id";
			}
			//System.out.println(sqlQuery);
			
			rs = stmt.executeQuery(sqlQuery);
			
			while (rs.next())
			{
				
				releasesVsExpenditureBean=new Rws_ReleasesVsExp_WorkWise_Bean();
				releasesVsExpenditureBean.setCircleOfficeCode(rs.getString("circleOfficeCode"));
				releasesVsExpenditureBean.setCircleOfficeName(rs.getString("circle_office_name"));
				releasesVsExpenditureBean.setProgrammeCode(rs.getString("programme_code"));
				releasesVsExpenditureBean.setProgrammeName(rs.getString("programme_name"));
				releasesVsExpenditureBean.setLocId(rs.getString("loc_id"));
				releasesVsExpenditureBean.setLocReference(rs.getString("loc_ref"));
				releasesVsExpenditureBean.setLocDate(rs.getString("locDate"));
				releasesVsExpenditureBean.setHeadOfAccount(rs.getString("head_of_account"));
				releasesVsExpenditureBean.setLocAmount(rs.getString("loc_amount"));
				releasesVsExpenditureBean.setOfficeFromCode(rs.getString("office_from_code"));
				releasesVsExpenditureBean.setOfficeToCode(rs.getString("office_to_code"));
				//releasesVsExpenditureBean.setProgrammeName(rs.getString("place"));
				//releasesVsExpenditureBean.setProgrammeName(rs.getString("pao_apao"));
				///releasesVsExpenditureBean.setProgrammeName(rs.getString("remarks"));
				releasesVsExpenditureBean.setWorkId(rs.getString("work_id"));
				releasesVsExpenditureBean.setWorkName(rs.getString("work_name"));
				releasesVsExpenditureBean.setProject(rs.getString("project"));
				releasesVsExpenditureProgWiseList.add(releasesVsExpenditureBean);
			}
			
			
		} 
		catch ( Exception e ) 
		{
			//System.out.println("Exception occured in getReleasesVsExpenditureProgWiseDrill " +e );
		}
		finally
		{
			//closeAll();
		}
		return releasesVsExpenditureProgWiseList;
	}
	public String convertEnWordToTeWord(String sourceString)
	{
		String resultantString="";
		for(int i=0;i<sourceString.length();i++)
		{
			resultantString+=convertEnCharToTeChar(sourceString.charAt(i)+"");
		}
		return resultantString;
	}
	public String convertEnCharToTeChar(String sourceChar)
	{
		String tempChar=new String(sourceChar);
		java.util.HashMap te=new java.util.HashMap();
		//		Phonetic
		te.put("B","b");
		te.put("C","c");
		te.put("F","ph");
		te.put("f","ph");
		te.put("G","g");
		te.put("J","j");
		te.put("K","k");
		te.put("M","m");
		te.put("P","p");
		te.put("Q","q");
		te.put("V","v");
		te.put("W","v");
		te.put("w","v");
		te.put("X","x");
		te.put("Y","y");
		te.put("Z","j");
		
		//		Cons
		te.put("k","\u0C15\u0C4D");
		te.put("c","\u0C1A\u0C4D");
		te.put("T","\u0C1F\u0C4D");
		te.put("D","\u0C21\u0C4D");
		te.put("N","\u0C23\u0C4D");
		te.put("t","\u0C24\u0C4D");
		te.put("d","\u0C26\u0C4D");
		te.put("p","\u0C2A\u0C4D");
		te.put("b","\u0C2C\u0C4D");

		te.put("y","\u0C2F\u0C4D");
		te.put("R","\u0C31\u0C4D");
		te.put("L","\u0C33\u0C4D");
		te.put("v","\u0C35\u0C4D");
		te.put("s","\u0C38\u0C4D");
		te.put("S","\u0C36\u0C4D");
		te.put("H","\u0C39\u0C4D");
		te.put("x","\u0C15\u0C4D\u0C36\u0C4D");
		
		te.put("\u200Dn", "\u0C01");
		te.put("\u200Dm", "\u0C02");
		te.put("m", "\u0C2E\u0C4D");
		te.put("n", "\u0C28\u0C4D");
		te.put(":h", "\u0C03");

		te.put("\u0C15\u0C4Dh", "\u0C16\u0C4D");
		te.put("\u0C28\u0C4Dg", "\u0C19\u0C4D");
		te.put("\u0C1A\u0C4Dh", "\u0C1B\u0C4D");
		te.put("\u0C28\u0C4Dj", "\u0C1E\u0C4D");
		te.put("\u0C1F\u0C4Dh", "\u0C20\u0C4D");
		te.put("\u0C21\u0C4Dh", "\u0C22\u0C4D");
		te.put("\u0C24\u0C4Dh", "\u0C25\u0C4D");
		te.put("\u0C26\u0C4Dh", "\u0C27\u0C4D");
		te.put("\u0C2A\u0C4Dh", "\u0C2B\u0C4D");
		te.put("\u0C2C\u0C4Dh", "\u0C2D\u0C4D");
		te.put("\u0C38\u0C4Dh", "\u0C37\u0C4D");
		te.put("\u0C31\u0C4Dr", "\u0C0B");
		te.put("\u0C33\u0C4Dl", "\u0C0C");
		te.put("\u0C4D\u0C0B", "\u0C43");

		te.put("j", "\u0C1C\u0C4D");
		te.put("\u0C1C\u0C4Dh", "\u0C1D\u0C4D");
		te.put("g", "\u0C17\u0C4D");
		te.put("\u0C17\u0C4Dh", "\u0C18\u0C4D");
		te.put("r", "\u0C30\u0C4D");
		te.put("l", "\u0C32\u0C4D");
		te.put("h", "\u0C39\u0C4D");
		//		VowSmall
		te.put("\u0C4Da", "\u200C");
		te.put("\u0C4Di", "\u0C3F");
		te.put("\u0C4Du", "\u0C41");
		te.put("\u0C0Bu", "\u0C43");
		te.put("\u0C4De", "\u0C46");
		te.put("\u0C4Do", "\u0C4A");
		te.put("\u200Ci", "\u0C48");
		te.put("\u200Cu", "\u0C4C");
		te.put("\u200C-", "\u200D");
		te.put("\u200C:", ":");
		te.put("-", "\u200D");
		//		VowBig
		te.put("\u200Ca", "\u0C3E");
		te.put("\u0C3Fi", "\u0C40");
		te.put("\u0C41u", "\u0C42");
		te.put("\u0C43u", "\u0C44");
		te.put("\u0C46e", "\u0C47");
		te.put("\u0C4Ao", "\u0C4B");
		te.put("\u0C4DA", "\u0C3E");
		te.put("\u0C4DI", "\u0C40");
		te.put("\u0C4DU", "\u0C42");
		te.put("\u0C0BU", "\u0C44");
		te.put("\u0C4DE", "\u0C47");
		te.put("\u0C4DO", "\u0C4B");
		//		Vows
		te.put("\u0C05i", "\u0C10");
		te.put("\u0C05u", "\u0C14");
		te.put("ai", "\u0C10");
		te.put("au", "\u0C14");
		te.put("\u0C05a", "\u0C06");
		te.put("\u0C07i", "\u0C08");
		te.put("\u0C09u", "\u0C0A");
		te.put("\u0C0Ee", "\u0C0F");
		te.put("\u0C12o", "\u0C13");

		te.put("a", "\u0C05");
		te.put("A", "\u0C06");
		te.put("i", "\u0C07");
		te.put("I", "\u0C08");
		te.put("u", "\u0C09");
		te.put("U", "\u0C0A");
		te.put("e", "\u0C0E");
		te.put("E", "\u0C0F");
		te.put("o", "\u0C12");
		te.put("O", "\u0C13");
		te.put("q", "\u0C15\u0C4D");
		//		Nums
		te.put("\u200D1", "\u0C67");
		te.put("\u200D2", "\u0C68");
		te.put("\u200D3", "\u0C69");
		te.put("\u200D4", "\u0C6A");
		te.put("\u200D5", "\u0C6B");
		te.put("\u200D6", "\u0C6C");
		te.put("\u200D7", "\u0C6D");
		te.put("\u200D8", "\u0C6E");
		te.put("\u200D9", "\u0C6F");
		te.put("\u200D0", "\u0C66");
		te.put("(.+)\u200C(.+)", "$1$2");
		if(te.containsKey(tempChar))
		{
			tempChar=(String)te.get(sourceChar);
		}
		if(te.containsKey(tempChar))
		{
			tempChar=(String)te.get(sourceChar);
		}
		if(te.containsKey(tempChar))
		{
			tempChar=(String)te.get(sourceChar);
		}
		if(te.containsKey(tempChar))
		{
			tempChar=(String)te.get(sourceChar);
		}
		
		return tempChar;
	}
	//End of methods for ReleasesVsExpenditureProgrameWise
	
	//modified by sridhar for displaying all division works
	
	public ArrayList getWorks(String district,String division,String program,String wrkcat)
	{
		ArrayList works = new ArrayList();
		String query = "",from = "",to = "";
		//ConnectionManager connMgr=new ConnectionManager(dataSource);
		Connection conn=null;
		LabelValueBean labelValueBean=null;
		
		System.out.println("Distcit code"+district);
		
		boolean where = true;
		boolean and = false;
		try
		{
			
		query = "select work_id,work_name,to_char(ADMIN_DATE,'dd/mm/yyyy') as admin_date,SANCTION_AMOUNT from rws_work_admn_tbl WHERE substr(work_id,5,2)='"+district+"'";
			
			if(division!=null && !division.equals(""))
			{
				query += " and substr(office_code,4,1)="+division;
					
			}
			if(wrkcat!=null && !wrkcat.equals(""))
			{
				query+=" and category_code='"+wrkcat+"'";
			}
			if(program!=null && !program.equals(""))
			{
				query+=" and programme_code='"+program+"'";
			}
			System.out.println("gcsgdfgdsgfdgfhj");
			conn=RwsOffices.getConn();
			stmt=conn.createStatement();
			System.out.println("Query is "+query);
			
			rs = stmt.executeQuery(query);
			
			
			
			while(rs.next())
			{
				Rws_BroDetailsBean broDetails=new Rws_BroDetailsBean();
				
				broDetails.setWork_id(rs.getString("work_id"));
				broDetails.setWork_name(rs.getString("work_name"));
				broDetails.setAdmin_date(rs.getString("admin_date"));
				broDetails.setSanction_amount(rs.getString("sanction_amount"));
				works.add(broDetails);
				
			}
			
			
		}
		catch(Exception e)
		{
		    //System.out.println("final query to get works::"+query);
			System.out.println("Error in getting works:"+e.getMessage());
		    e.printStackTrace();
		}
		finally
		{
			//closeAll();
		}
		return works;
	}
	 public ArrayList getHeadOfAccountListForLOC(String broId) throws Exception
		{
			ArrayList headOfAccountList = new ArrayList();
			
			try
			{
				Connection conn = RwsOffices.getConn();
				Statement stat = conn.createStatement();
				//query = " SELECT HEAD_OF_ACCOUNT , HEAD_OF_ACCOUNT_NAME  FROM RWS_HEAD_OF_ACCOUNT_TBL ORDER BY HEAD_OF_ACCOUNT_NAME";
				String query="select head_of_account from rws_bro_details_tbl where bro_id='"+broId+"'";
				//System.out.println("query is "+query);
				ResultSet rset = stat.executeQuery(query);
				LabelValueBean labelValueBean = new LabelValueBean();
				CommonLists commonLists=new CommonLists();
				while(rset.next())
				{
					Rws_BroProgDetailsBean broProgDetailsBean = new Rws_BroProgDetailsBean();
					String hoa = rset.getString(1);
					broProgDetailsBean.setHeadOfAccount(hoa);
					broProgDetailsBean.setMajorHead(getMajorHeadName(hoa.substring(0,4)));
					if(hoa.length()>=7 && hoa.substring(5,7)!=null && !hoa.substring(5,7).equals("--"))
		    		{
						broProgDetailsBean.setSubMajorHead(getSubMajorHeadName(hoa.substring(0,4),hoa.substring(5,7)));
		    		}
					if(hoa.length()>=11 && hoa.substring(8,11)!=null && !hoa.substring(8,11).equals("---"))
					{
						broProgDetailsBean.setMinorHead(getMinorHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11)));
		    		}
					if(hoa.length()>=14 && hoa.substring(12,14)!=null && !hoa.substring(12,14).equals("--"))
					{
						broProgDetailsBean.setGroupHead(getGrpSubHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14)));
		    		}
					if(hoa.length()>=17 && hoa.substring(15,17)!=null && !hoa.substring(15,17).equals("--"))
	    			{
						broProgDetailsBean.setSubHead(getSubHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17)));
		    		}
					if(hoa.length()>=21 && hoa.substring(18,21)!=null && !hoa.substring(18,21).equals("---"))
	    			{
						broProgDetailsBean.setDetailHead(getDetailedHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17),hoa.substring(18,21)));
		    		}
					if(hoa.length()>=25 && hoa.substring(22,25)!=null && !hoa.substring(22,25).equals("---"))
	    			{
						broProgDetailsBean.setSubDetailHead(getSubDetailedHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17),hoa.substring(18,21),hoa.substring(22,25)));
		    		}
	    			headOfAccountList.add(broProgDetailsBean);
				}
			}
			finally
			{	
				//closeAll();
			}
			return headOfAccountList;
		}
	public boolean findBudgetQuarterValue(Rws_BroProgDetailsBean broDetailsBean){
	    Connection conn=null;
	    try
	    {
	    //ConnectionManager connMgr=new ConnectionManager(dataSource);
        conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		String query="select  distinct quarter  from rws_bro_details_tbl where programme_code='"+broDetailsBean.getProgrammeCode()+"' and subprogramme_code='"+broDetailsBean.getSubprogrammeCode()+"' and head_of_account='"+broDetailsBean.getHeadOfAccount()+"'" +
				"and bro_id='"+broDetailsBean.getBroId()+"'";
		String quarter=broDetailsBean.getQuarter();
		int quartr=Integer.parseInt(quarter);
		rs = stmt.executeQuery(query);
		
	    }
	    catch(SQLException sqe){
	        System.out.println("In budget quareter value");
	        sqe.printStackTrace();
	    }
	    
	    return false;
		  
	    
	}
	public String getMajorHeadName(String majorCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select major_head_name from rws_majorhead_tbl where major_head_code="+majorCode;
	    Debug.println("majhead"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getSubMajorHeadName(String majorCode,String subMajorCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select submajor_head_name from rws_submajorhead_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode;
	    Debug.println("2"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getMinorHeadName(String majorCode,String subMajorCode,String minorCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select MINOR_HEAD_NAME from rws_minorhead_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode+" and MINOR_HEAD_CODE="+minorCode;
	    Debug.println("3"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getGrpSubHeadName(String majorCode,String subMajorCode,String minorCode,String grpSubHeadCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select GRPR_SUBHEAD_NAME from  rws_groupsubhead_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode+" and MINOR_HEAD_CODE="+minorCode+"  and GRP_SUBHEAD_CODE ="+grpSubHeadCode;
	    Debug.println("4"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getSubHeadName(String majorCode,String subMajorCode,String minorCode,String grpSubHeadCode,String subHeadCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select SUBHEAD_NAME from  rws_subhead_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode+" and MINOR_HEAD_CODE="+minorCode+"  and GRP_SUBHEAD_CODE ="+grpSubHeadCode+"   and SUBHEAD_CODE ="+subHeadCode;
	    Debug.println("5"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getDetailedHeadName(String majorCode,String subMajorCode,String minorCode,String grpSubHeadCode,String subHeadCode,String detailCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select DETAIL_HEAD_NAME from  rws_detailhead_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode+" and MINOR_HEAD_CODE="+minorCode+"  and GRP_SUBHEAD_CODE ="+grpSubHeadCode+"   and SUBHEAD_CODE ="+subHeadCode+"   and DETAIL_HEAD_CODE ="+detailCode;
	    Debug.println("5"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	}
	public String getSubDetailedHeadName(String majorCode,String subMajorCode,String minorCode,String grpSubHeadCode,String subHeadCode,String detailCode,String subDetailCode)
	{
		Connection conn = null;
	    String name="";
	    try
	    {
        	conn=RwsOffices.getConn();
            stmt=conn.createStatement();
	    String query="select SUBDETAIL_HEAD_NAME from  rws_subdetail_tbl where major_head_code="+majorCode+" and submajor_head_code="+subMajorCode+" and MINOR_HEAD_CODE="+minorCode+"  and GRP_SUBHEAD_CODE ="+grpSubHeadCode+"   and SUBHEAD_CODE ="+subHeadCode+"   and DETAIL_HEAD_CODE ="+detailCode+" and subDETAIL_HEAD_CODE ="+subDetailCode;
	    Debug.println("6"+query);
	    rs = stmt.executeQuery(query);
	    if(rs.next())
	    name = rs.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    finally
		{
	    	try{
	  	          if(rs!=null)rs.close();
	  	          if(stmt!=null)stmt.close();
	  			  if(conn!=null)conn.close();
	  			} catch(Exception e)
	  			{
	  				e.printStackTrace();
	  			}
		}
	    return name;
	} 
	// Added by Ramesh to get HOA Name on 12112010
	public String getHeadOfAccountName(String hoa)
	{
	    String name="";
    	String mh=getMajorHeadName(hoa.substring(0,4));
    	String smh="->",mih="->",gph="->",sh="->",dh="->",sdh="->";
    	if(hoa.length()>=7 && hoa.substring(5,7)!=null && !hoa.substring(5,7).equals("00"))
    	{
    		smh=getSubMajorHeadName(hoa.substring(0,4),hoa.substring(5,7));
    	}
    	if(hoa.length()>=11 && hoa.substring(8,11)!=null && !hoa.substring(8,11).equals("000"))
    	{
    		mih=getMinorHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11));
    	}
    	if(hoa.length()>=14 && hoa.substring(12,14)!=null && !hoa.substring(12,14).equals("00"))
    	{
    		gph=getGrpSubHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14));
    	}
    	if(hoa.length()>=17 && hoa.substring(15,17)!=null && !hoa.substring(15,17).equals("00"))
    	{
    		sh=getSubHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17));
    	}
    	if(hoa.length()>=21 && hoa.substring(18,21)!=null && !hoa.substring(18,21).equals("000"))
    	{
    		dh=getDetailedHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17),hoa.substring(18,21));
    	}
    	if(hoa.length()>=25 && hoa.substring(22,25)!=null && !hoa.substring(22,25).equals("000"))
    	{
    		sdh=getSubDetailedHeadName(hoa.substring(0,4),hoa.substring(5,7),hoa.substring(8,11),hoa.substring(12,14),hoa.substring(15,17),hoa.substring(18,21),hoa.substring(22,25));
    	}
    	String hoaname = mh+"->"+smh+"->"+mih+"->"+gph+"->"+sh+"->"+dh+"->"+sdh;
	    return hoaname;
	}
/*	public String getFundType(String groupsubhead)
	{
	    Connection sqlconn;
	    String fundtype="";
	    try
	    {
	        sqlconn=dataSource.RwsOffices.getConn();
	    String query="select fund_name from rws_bro_fund_per_tbl fund,rws_hoa_tbl hoa  " +
		   " where hoa.GRP_SUBHEAD_CODE=fund.GRP_SUBHEAD_CODE " +
		   " and hoa.GRP_SUBHEAD_CODE="+groupsubhead;
	    PreparedStatement fundtypestatement=sqlconn.prepareStatement(query);
	    ResultSet results=fundtypestatement.executeQuery();
	    if(results.next())
	    fundtype=results.getString(1);
	    }
	    catch(SQLException sqe)
	    {
	        sqe.printStackTrace();
	    }
	    
	    return fundtype;
	}
	*/
}