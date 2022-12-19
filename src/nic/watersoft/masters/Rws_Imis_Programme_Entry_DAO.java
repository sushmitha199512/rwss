/*
 * Created on 30-10-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;


public class Rws_Imis_Programme_Entry_DAO {
	PreparedStatement pstmt=null,pstmt1=null;
	
	public int saveImisProgramme(String imisProgrammeCode, String imisProgrammeName,String fundSupport) {
		Connection conn = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String q = "insert into  RWS_IMIS_PROGRAMME_TBL values(?,?,?)";			
			pstmt = conn.prepareStatement(q);
			pstmt.setString(1, imisProgrammeCode);
			pstmt.setString(2, imisProgrammeName);
			pstmt.setString(3, fundSupport);
			count = pstmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("Exception in saveImisProgramme"+e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if(conn!=null)
					conn.close();
			} catch (Exception e) {
				System.out.println("Exception in saveImisProgramme"+e);
			}
		}
		return 0;
	}
	
	public int editImisProgramme(String imisProgrammeCode, String imisProgrammeName,String fundSupport) {
		Connection conn = null;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String q = "update  RWS_IMIS_PROGRAMME_TBL set IMIS_PROGRAMME_NAME=?,FUNDING_SUPPORT=? where IMIS_PROGRAMME_CODE=?";		
			pstmt=conn.prepareStatement(q);
			pstmt.setString(1, imisProgrammeName);
			pstmt.setString(2, fundSupport);
			pstmt.setString(3, imisProgrammeCode);
			count = pstmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("Exception in editImisProgramme"+e);
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if(conn!=null)
					conn.close();
			} catch (Exception e) {
				System.out.println("Exception in editImisProgramme"+e);
			}
		}
		return 0;
	}

	
	public ArrayList getImisProgrammes() {
		ArrayList ImisProgrammes = new ArrayList();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			pstmt = conn.prepareStatement("SELECT IMIS_PROGRAMME_CODE,IMIS_PROGRAMME_NAME,FUNDING_SUPPORT FROM RWS_IMIS_PROGRAMME_TBL order by to_number(IMIS_PROGRAMME_CODE)");
			rs =pstmt.executeQuery();
			while (rs.next()) {
				Rws_Imis_Programme_Entry_Form Entry_Form = new Rws_Imis_Programme_Entry_Form();
				Entry_Form.setImisProgrammeCode(rs.getString("IMIS_PROGRAMME_CODE"));
				Entry_Form.setImisProgrammeName(rs.getString("IMIS_PROGRAMME_NAME"));
				Entry_Form.setFundSupport(rs.getString("FUNDING_SUPPORT"));
				ImisProgrammes.add(Entry_Form);
			}
			return ImisProgrammes;
		} catch (Exception e) {
			System.out.println("Exception In getImisProgrammes "+e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public ArrayList getProgrammes() {
		ArrayList Programmes = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT PROGRAMME_CODE,PROGRAMME_NAME FROM RWS_PROGRAMME_TBL order by PROGRAMME_CODE");
			while (rs.next()) {
				Rws_Imis_Programme_Entry_Form Link_Form = new Rws_Imis_Programme_Entry_Form();
				Link_Form.setProgrammeCode(rs.getString("PROGRAMME_CODE"));
				Link_Form.setProgrammeName(rs.getString("PROGRAMME_CODE")+"-"+rs.getString("PROGRAMME_NAME"));
				Programmes.add(Link_Form);
			}
			return Programmes;
		} catch (Exception e) {
			System.out.println("Exception In getProgrammes "+e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getProgrammes"+e);
			}
		}
		return null;
	}
	
	public ArrayList getImisProgrammesNames() {
		ArrayList imisProgrammes = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT IMIS_PROGRAMME_CODE,IMIS_PROGRAMME_NAME FROM RWS_IMIS_PROGRAMME_TBL order by IMIS_PROGRAMME_CODE");
			while (rs.next()) {
				Rws_Imis_Programme_Entry_Form Link_Form = new Rws_Imis_Programme_Entry_Form();
				Link_Form.setImisProgrammeCode(rs.getString("IMIS_PROGRAMME_CODE"));
				Link_Form.setImisProgrammeName(rs.getString("IMIS_PROGRAMME_CODE")+"-"+rs.getString("IMIS_PROGRAMME_NAME"));
				imisProgrammes.add(Link_Form);
			}
			return imisProgrammes;
		} catch (Exception e) {
			System.out.println("Exception In getImisProgrammesNames "+e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getImisProgrammesNames"+e);
			}
		}
		return null;
	}
	public int saveIMIS(Rws_Imis_Programme_Entry_Form frm) {
		Connection conn = null;
		int count = 0;
		ResultSet rs=null;
		try {
			conn = RwsOffices.getConn();
			String qry="select * from RWS_IMIS_PROGRAMME_LNK_TBL where programme_code=? and imis_programme_code=? and state_central=? and SUBPROGRAMME_CODE=? and PLACE_AMT_IN=? and PLACE_AMT_IN_SVS=?";
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, frm.getProgramme());
			pstmt.setString(2, frm.getImisProgramme());
			pstmt.setString(3, frm.getBelTo());
			pstmt.setString(4, frm.getSubProgramme());
			pstmt.setString(5, frm.getAmtIn());
			pstmt.setString(6, frm.getAmtInSvs());
			rs=pstmt.executeQuery();
			if(!rs.next()) {
				String q = "insert into RWS_IMIS_PROGRAMME_LNK_TBL(PROGRAMME_CODE,IMIS_PROGRAMME_CODE,state_central,subprogramme_code,Place_amt_in,Place_amt_in_SVS) "
						+ "values (?,?,?,?,?,?)";
				pstmt1=conn.prepareStatement(q);
				pstmt1.setString(1, frm.getProgramme());
				pstmt1.setString(2, frm.getImisProgramme());
				pstmt1.setString(3, frm.getBelTo());
				pstmt1.setString(4, frm.getSubProgramme());
				pstmt1.setString(5, frm.getAmtIn());
				pstmt1.setString(6, frm.getAmtInSvs());
				count = pstmt1.executeUpdate();
			}
			return count;
		} catch (Exception e) {
			System.out.println("Exception in saveIMIS"+e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();				
				if(conn!=null)
					conn.close();
				if(rs!=null)
					rs.close();
				if(pstmt1!=null)
					pstmt1.close();
			}catch (Exception e) {
				System.out.println("Exception in saveIMIS"+e);
			}
		}
		return 0;
	}
	
	public ArrayList getSubProgrammes(String programme) {
		ArrayList Programmes = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select SUBPROGRAMME_CODE,SUBPROGRAMME_NAME from RWS_SUBPROGRAMME_TBL where PROGRAMME_CODE='"+programme+"' order by SUBPROGRAMME_CODE");
			while (rs.next()) {
				Rws_Imis_Programme_Entry_Form Link_Form = new Rws_Imis_Programme_Entry_Form();
				Link_Form.setSubProgrammeCode(rs.getString("SUBPROGRAMME_CODE"));
				Link_Form.setSubProgrammeName(rs.getString("SUBPROGRAMME_CODE")+"-"+rs.getString("SUBPROGRAMME_NAME"));
				Programmes.add(Link_Form);
			}
			return Programmes;
		} catch (Exception e) {
			System.out.println("Exception In getSubProgrammes "+e);
		} finally {
			try {
				if (stmt != null) 
					stmt.close();
				if (rs != null) 
					rs.close();
				if(conn != null) 
					conn.close();
			} catch (Exception e) {
				System.out.println("Exception in getSubProgrammes"+e);
			}
		}
		return null;
	}
	public ArrayList getImisList(Rws_Imis_Programme_Entry_Form frm) {
		ArrayList Programmes = new ArrayList();
		Connection conn = null;
		ResultSet rs = null,rs1=null;
		try {
			conn = RwsOffices.getConn();
			pstmt = conn.prepareStatement("select a.PROGRAMME_CODE,c.PROGRAMME_NAME,a.IMIS_PROGRAMME_CODE,b.IMIS_PROGRAMME_NAME,STATE_CENTRAL,a.SUBPROGRAMME_CODE,PLACE_AMT_IN,PLACE_AMT_IN_SVS from RWS_IMIS_PROGRAMME_LNK_TBL a,RWS_IMIS_PROGRAMME_TBL b,RWS_PROGRAMME_TBL c where a.PROGRAMME_CODE=c.PROGRAMME_CODE and a.IMIS_PROGRAMME_CODE=b.IMIS_PROGRAMME_CODE order by PROGRAMME_CODE,SUBPROGRAMME_CODE");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Rws_Imis_Programme_Entry_Form Link_Form = new Rws_Imis_Programme_Entry_Form();
				Link_Form.setProgrammeName(rs.getString("PROGRAMME_CODE")+"-"+rs.getString("PROGRAMME_NAME"));
				Link_Form.setImisProgrammeName(rs.getString("IMIS_PROGRAMME_CODE")+"-"+rs.getString("IMIS_PROGRAMME_NAME"));
				pstmt1=conn.prepareStatement("select SUBPROGRAMME_CODE,SUBPROGRAMME_NAME from rws_subprogramme_tbl where PROGRAMME_CODE=? and SUBPROGRAMME_CODE=?");
				pstmt1.setString(1, rs.getString("PROGRAMME_CODE"));
				pstmt1.setString(2, rs.getString("SUBPROGRAMME_CODE"));
				rs1=pstmt1.executeQuery();
				if(rs1.next())
					Link_Form.setSubProgrammeName(rs1.getString("SUBPROGRAMME_CODE")+"-"+rs1.getString("SUBPROGRAMME_NAME"));
				else
					Link_Form.setSubProgrammeName("");	
				Link_Form.setBelTo(rs.getString("STATE_CENTRAL"));
				Link_Form.setAmtIn(rs.getString("PLACE_AMT_IN"));
				Link_Form.setAmtInSvs(rs.getString("PLACE_AMT_IN_SVS"));
				Link_Form.setProgramme(rs.getString("PROGRAMME_CODE"));
				Link_Form.setSubProgramme(rs.getString("SUBPROGRAMME_CODE"));
				Link_Form.setImisProgramme(rs.getString("IMIS_PROGRAMME_CODE"));
				Programmes.add(Link_Form);
			}
			return Programmes;
		} catch (Exception e) {
			System.out.println("Exception In getSubProgrammes "+e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (pstmt1 != null) {
					pstmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getSubProgrammes"+e);
			}
		}
		return null;
	}
	public String geteditData(Rws_Imis_Programme_Entry_Form frm)
	{
		Connection conn = null;
		ResultSet rs = null;
		int count=0;
		try
		{
		   	conn = RwsOffices.getConn();
		 		String eqry="update RWS_IMIS_PROGRAMME_LNK_TBL set IMIS_PROGRAMME_CODE=?,PLACE_AMT_IN=?,PLACE_AMT_IN_SVS=?,"
		 				+ "STATE_CENTRAL=? where PROGRAMME_CODE=? and SUBPROGRAMME_CODE=? ";
				pstmt1 = conn.prepareStatement(eqry);
				pstmt1.setString(1, frm.getImisProgramme());
				pstmt1.setString(2, frm.getAmtIn());
				pstmt1.setString(3, frm.getAmtInSvs());
				pstmt1.setString(4, frm.getBelTo());
				pstmt1.setString(5, frm.getProgramme());
				pstmt1.setString(6, frm.getSubProgramme());
			 	count=pstmt1.executeUpdate();
 			 	if(count>0)
			 	{
			 	  return "success";
	 		     }
	 		    else
	 		     {
	 		   	   return "failure";
		 	     }
		}catch(Exception e)
		{
			Debug.println("Exceptiion in geteditData:\n"+e);
		}
		finally{
			try {
				if (pstmt1 != null) {
					pstmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getSubProgrammes"+e);
			}
		}		
		return "";
	}
}