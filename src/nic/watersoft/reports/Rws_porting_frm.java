/*
 * Created on Jan 3, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/*
 * Tables Used
 * Source Table - addldists - an MS Access Table
 * Target Table - rws_hab_dummy_tbl_tmp - Oracle Table 
 * Table To Store Not Ported Records - notPortedTable_TMP - Oracle Table
 * 
 * 
 * 
 */
public class Rws_porting_frm extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		/*
		String district=(String)request.getParameter("selectedDistrict");
		HttpSession session=request.getSession();
		//System.out.println("in portingProcess.java");
		//System.out.println("district is "+request.getParameter("district"));
		int var=0;
		java.sql.Connection conn=null;
		java.sql.Connection orclconn=null;
		java.sql.Connection orclconn2=null;
				try
				{
					int totalNoOfRecords=0;
					int recordsPorted=0;
					int recordsNotPorted=0;
					String habCode=null;
					String status;
					//System.out.println("Connecting to the data base......");
					 
					Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
					Class.forName("oracle.jdbc.driver.OracleDriver");
		            
		            conn=java.sql.DriverManager.getConnection("jdbc:odbc:newDsn","","");
					//System.out.println("Connected  to the data base......");
					String query=null;
		            
					//query="select trim(habcode)as hc,trim(Status)as status1 from addldists where dc='"+district+"'";
					if(district==null)
					query="select trim(habcode)as hc,trim(Status)as status1 from kriwg";
		            else
		            {
		            	query="select trim(habcode)as hc,trim(Status)as status1 from kriwg where dc='"+district+"'";
						//System.out.println("in else");
		            }
						//query="select trim(habcode)as hc,trim(Status)as status1 from addldists";	
		            java.sql.PreparedStatement psmt=conn.prepareStatement(query);
		            //System.out.println("executing access query");
		            //System.out.println("query is "+query);
		            java.sql.ResultSet rs=psmt.executeQuery();
		            //System.out.println("executed access query");
		            
		            java.sql.Statement psmt1=orclconn.createStatement();  
		            
		            
		            java.sql.Statement notPortedStmt=orclconn2.createStatement();
					String query2=null;  
					
					
					
					
					
		            int count=0;
		            Exception exception=new Exception();
					while(rs.next())
					{
						
						try{
						////System.out.println("in while loop");
						
						habCode=rs.getString("hc");
						status=rs.getString("status1");
						////System.out.println("hc is "+habCode);
						////System.out.println("status is "+status);
						//="update rws_hab_dummy_tbl SET HAB_CODE='"+habCode+"',STATUS='"+status+"' WHERE HAB_CODE='"+habCode+"'";
						query="INSERT INTO  rws_hab_dummy_tbl(HAB_CODE,STATUS) VALUES('"+habCode+"','"+status+"')";
				       // //System.out.println("executing oracle insert qeury");
				        ////System.out.println("query is "+query);
				        count=psmt1.executeUpdate(query);
				       // //System.out.println("executed oracle insert qeury");

				        if(count<1)
				        {
				        //System.out.println("count<0");
				        throw exception;	
				        }
				        recordsPorted++;
						}
						catch(Exception e)
						{
							try{
							var++;
							//System.out.println("Exception is:"+e);
							recordsNotPorted++;
							
							query2="insert into HABNOTPORTED_TBL(hab_code,message) values('"+habCode+"','"+e.getMessage()+"')";
							////System.out.println("executing not proted insert query");
							//System.out.println("message is"+e.getMessage());
							 ////System.out.println("query is "+query2);
							int count2=notPortedStmt.executeUpdate(query2);
							////System.out.println("executed not proted insert query");
							}
							catch(Exception exp){//System.out.println("Exception in inserting into notPortedTable"+exp);}
							
						}
						finally{
						totalNoOfRecords++;
						
						}
					}
				
					//System.out.println("recordsPorted is "+recordsPorted);
					//System.out.println("recordsNotPorted is "+recordsNotPorted);
					//System.out.println("Total No. Of. records "+totalNoOfRecords);
					
					session.setAttribute("recordsPorted",recordsPorted+"");
					session.setAttribute("recordsNotPorted",recordsNotPorted+"");
					session.setAttribute("totalNoOfRecords",totalNoOfRecords+"");
					
					
				}
				catch(Exception e)
				{
					
						
					    //System.out.println("Exception is:"+e);
				}
				finally
				{
					try{
							conn.close();
							orclconn.close();
							orclconn2.close();
					}catch(Exception e){//System.out.println("Exception in closing connections"+e);}
				}

		
		
	//remove temp files portingProcess.jsp,portingStatus.jsp and portingResult.jsp from masters
	  
	 */
	return mapping.findForward("portingStatus");
	}
}
