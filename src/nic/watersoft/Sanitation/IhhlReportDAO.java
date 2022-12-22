
package nic.watersoft.Sanitation;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import java.sql.ResultSetMetaData;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;

import nic.watersoft.masters.RwsMaster;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.tags.ExpenditureTag;
import nic.watersoft.works.rws_works_factory;
import nic.watersoft.commons.*;

import java.util.*;
/**
 * @author Anupama
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class IhhlReportDAO {
	Connection con=null;
	ResultSet rst=null,rs1=null;  
	PreparedStatement pstmt=null;
	Statement stmt=null,stmt1=null;
	DataSource datasource=null;
	ArrayList workwiseexpendituredata;
	private LabelValueBean labelValueBean;
	private DataSource dataSource = null;
	
	// private Connection conn1 = null;
	private Statement stat = null;
	private ResultSet rset = null;
	private String query = null;
	
	//RwsOffices office = new RwsOffices()
	IhhlReportDAO()
	{
	}
	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;
		
		ResultSet rs = null;
		
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in Wquality" + e);
			}
			rs = null;
		}
		
		
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}
	IhhlReportDAO(DataSource datasource)
	{
		this.datasource=datasource;
	}
	//////////Added by anu for Category,SubCategory and Card Type/////
	
	public ArrayList getCategory() throws Exception
	{
	
		
		ArrayList category=new ArrayList();	
		String query="";
		try
		{	
			
				con=RwsOffices.getConn();
				query="SELECT CATEGORY_CODE,CATEGORY_NAME  FROM  RWS_BPL_CATEGORY_TBL  ORDER BY CATEGORY_CODE,CATEGORY_NAME";
			 	pstmt=con.prepareStatement(query);
			
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 		
			 		labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rst.getString(1));
					
					labelValueBean.setLabel(rst.getString(2));
					labelValueBean.setLabelValue(rst.getString(2) + " - "
							+ rst.getString(1));
					category.add(labelValueBean);
					
				}
			
			
		}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return category;
	}
	
	
	public ArrayList  getSubCategory(String CATEGORY_CODE) throws Exception {
		ArrayList subcategories = new ArrayList();
		String query="";
		try
		{	
			
				con=RwsOffices.getConn();
				query="SELECT SUBCATEGORY_CODE,SUBCATEGORY_NAME "+" FROM  RWS_BPL_SUBCATEGORY_TBL "+" "
					
					+"where CATEGORY_CODE=?"
		
					+"ORDER BY SUBCATEGORY_CODE,SUBCATEGORY_NAME ";
			 	pstmt=con.prepareStatement(query);
			 	
			 	pstmt.setString(1,CATEGORY_CODE);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 		
			 		labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rst.getString(1));
					
					labelValueBean.setLabel(rst.getString(2));
					labelValueBean.setLabelValue(rst.getString(2) + " - "
							+ rst.getString(1));
					subcategories.add(labelValueBean);
					
				}
			
			
		}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return subcategories;
	}
	
	public ArrayList getCardType() throws Exception
	{
	
		ArrayList cardtype=new ArrayList();	
		String query="";
		try
		{	
			
				con=RwsOffices.getConn();
				query="SELECT CARD_TYPE,CARD_NAME "+" FROM  RWS_IHHL_CARDTYPE_TBL "
						+"ORDER BY CARD_TYPE ";
			 	pstmt=con.prepareStatement(query);
			
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 		
			 		labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rst.getString(1));
					
					labelValueBean.setLabel(rst.getString(2));
					labelValueBean.setLabelValue(rst.getString(2) + " - "
							+ rst.getString(1));
					cardtype.add(labelValueBean);
					
				}
			
			
		}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return cardtype;
	}
	
	
	
	///////////////////
	
	public String headerNames(String district)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
			 	pstmt=con.prepareStatement("select d.dname from rws_district_tbl d,rws_mandal_tbl m where d.dcode='"+district+"' and m.dcode='"+district+"' and d.dcode=m.dcode");
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	}
	

	
	public String constituencyheaderNames(String district,String mandal1)
	{
		String conhead=null;
		try
		{	
				con=RwsOffices.getConn();
				String qry="select constituency_name from rws_mandal_tbl m,rws_constituency_tbl c where  m.dcode=c.dcode and c.mcode=m.mcode and m.mcode='"+mandal1+"' and m.dcode='"+district+"'";
			 
				pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 		conhead=rst.getString(1).toUpperCase();
				}
			
			
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return conhead;
	
	}
	//code end
	public String mheaderNames(String district,String mandal1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select mname from rws_mandal_tbl  where mcode='"+mandal1+"' and dcode='"+district+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	
	
	public String mpheaderNames(String district,String mandal1,String panch1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select pname from rws_panchayat_tbl  where dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	
	
	
	public String mpvheaderNames(String district,String mandal1,String panch1,String village1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select vname from rws_village_tbl  where dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"' and vcode='"+village1+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	
	public String mpvhheaderNames(String district,String mandal1,String panch1,String village1,String hab1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select panch_name from rws_complete_hab_view where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"' and substr(panch_code,8,3)='"+village1+"' and panch_code='"+hab1+"' ";
				Debug.println("mpvheadername hab:"+qry);
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
	 	}
		catch (SQLException se)
		{
			Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	/////////anupama card type
	
	
	
	public ArrayList cardType(ArrayList columns,String dist,String cardtypeid)
	{   IhhlFormBean rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	String qry="select d.dcode,d.dname,count(distinct h.HAB_CODE_STATE),CARD_NAME,count(CARDTYPE) ";
 	String ord="";
	boolean added=true;
	boolean ordadded=false;

 	qry+="from RWS_IHHL_GOI_TBL h,rws_district_tbl d,rws_complete_hab_view c, RWS_IHHL_CARDTYPE_TBL d  where h.HAB_CODE_STATE=c.panch_code and d.dcode='"+dist+"'  AND d.dcode=substr(h.HAB_CODE_STATE,1,2) and CARDTYPE='"+cardtypeid+"'and d.CARD_TYPE=h.CARDTYPE   group by d.dcode,d.dname,CARD_NAME "+ord+"";
	//System.out.println("qrycardtype"+qry);
 	pstmt=con.prepareStatement(qry);
 	rst=pstmt.executeQuery();
 	int i=1;
 	while(rst.next())
 	{
 		rwsMaster = new IhhlFormBean();
 		if(columns.contains("District Code"))
        {
          rwsMaster.setDistCode(rst.getString(i));
          i++;
        }
 		if(columns.contains("District Name"))
        {
          rwsMaster.setDistrictName(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of Habitations"))
        {
 			rwsMaster.setNoOfHabs(rst.getInt(i));
          i++;
        }
 		
 		if(columns.contains("Card Name"))
        {
 			rwsMaster.setCardName(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of cards"))
        {
 			rwsMaster.setNoOfCardtype(rst.getInt(i));
          i++;
        }
 		
        
 		dlist.add(rwsMaster);
 		//System.out.println("dlist"+dlist);
 	   }
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	
	public ArrayList Gender(ArrayList columns,String dist,String gen)
	{   IhhlFormBean rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	String qry="select d.dcode,d.dname,count(distinct h.HAB_CODE_STATE),GENDER,count(GENDER) ";
 	String ord="";
	boolean added=true;
	boolean ordadded=false;

 	qry+="from RWS_IHHL_GOI_TBL h,rws_district_tbl d,rws_complete_hab_view c  where h.HAB_CODE_STATE=c.panch_code and d.dcode='"+dist+"'  AND d.dcode=substr(h.HAB_CODE_STATE,1,2)  and GENDER='"+gen+"'  group by d.dcode,d.dname,GENDER "+ord+"";
//	System.out.println("qrycardtype"+qry);
 	pstmt=con.prepareStatement(qry);
 	rst=pstmt.executeQuery();
 	int i=1;
 	while(rst.next())
 	{
 		
 		rwsMaster = new IhhlFormBean();
 		if(columns.contains("District Code"))
        {
          rwsMaster.setDistCode(rst.getString(i));
          i++;
        }
 		if(columns.contains("District Name"))
        {
          rwsMaster.setDistrictName(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of Habitations"))
        {
 			rwsMaster.setNoOfHabs(rst.getInt(i));
          i++;
        }
 		
 		if(columns.contains("Gender"))
        {
 			rwsMaster.setGender(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of Female/Male"))
        {
 			rwsMaster.setNoOfFM(rst.getInt(i));
          i++;
        }
 		
        
 		dlist.add(rwsMaster);
 		//System.out.println("dlist"+dlist);
 	   }
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	
	public ArrayList defaultData(ArrayList columns,String dist)
	{  
		IhhlFormBean rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	String qry="select d.dcode,d.dname,count(hab_code_state) ";
 	String ord="";
	boolean added=true;
	boolean ordadded=false;

 	qry+="from RWS_IHHL_GOI_TBL h,rws_district_tbl d,rws_complete_hab_view c  where h.HAB_CODE_STATE=c.panch_code and d.dcode='"+dist+"'  AND d.dcode=substr(h.HAB_CODE_STATE,1,2) group by d.dcode,d.dname "+ord+"";
	//System.out.println("qry111anu11"+qry);
 	pstmt=con.prepareStatement(qry);
 	rst=pstmt.executeQuery();
 	int i=1;
 	while(rst.next())
 	{
 		rwsMaster = new IhhlFormBean();
 		if(columns.contains("District Code"))
        {
          rwsMaster.setDistCode(rst.getString(i));
          i++;
        }
 		if(columns.contains("District Name"))
        {
          rwsMaster.setDistrictName(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of Habitations"))
        {
 			rwsMaster.setNoOfHabs(rst.getInt(i));
          i++;
        }
 		
        
 		dlist.add(rwsMaster);
 	   }
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	//CONSOLIDATED REPORT FOR A PARTICULAR DISTRICT
	public ArrayList consolData(ArrayList columns,IhhlFormBean rwsm,String dist,String CATEGORYCODE)
	{
		IhhlFormBean rwsMaster=null;
		ArrayList dlist=new ArrayList();
		ArrayList al=new ArrayList();
		try 
		   {
			//System.out.println("category");
			con=RwsOffices.getConn();
			String qry="select d.dcode,d.dname,count(distinct HAB_CODE_STATE),CATEGORY_NAME,count(h.CATEGORY)";
			String ord="";
			boolean added=true;
			boolean ordadded=false;
			
			qry+="from rws_ihhl_goi_tbl h,rws_district_tbl d,RWS_BPL_CATEGORY_TBL C where d.dcode='"+dist+"' and d.dcode=substr(h.HAB_CODE_STATE,1,2) AND  CATEGORY=CATEGORY_NAME AND  C.CATEGORY_CODE ='"+CATEGORYCODE+"'     group by d.dcode,d.dname,CATEGORY_NAME";
			System.out.println("Caetgory QUERY:::: "+qry);
			pstmt=con.prepareStatement(qry);
			
			rst=pstmt.executeQuery();
			int i=4;
			while(rst.next())
			                { 
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setNoOfHabs(rst.getInt(3));
		 		               rwsMaster.setCategoryName(rst.getString(4));
		 		               rwsMaster.setNoOfCategory(rst.getInt(5));
		 		             
		 		              
		 		              
		 		            
		 		               dlist.add(rwsMaster);
				             }
			
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	
	public ArrayList consolData2(ArrayList columns,IhhlFormBean rwsm,String dist,String CATEGORYCODE,String subcat)
	{
		IhhlFormBean rwsMaster=null;
		ArrayList dlist=new ArrayList();
		ArrayList al=new ArrayList();
		try 
		   {
			//System.out.println("category");
			con=RwsOffices.getConn();
			String qry="select d.dcode,d.dname,count(distinct HAB_CODE_STATE),CATEGORY_NAME,count(h.CATEGORY),SUBCATEGORY_NAME,count(h.SUBCATEGORY)";
			String ord="";
			boolean added=true;
			boolean ordadded=false;
			
			qry+="from rws_ihhl_goi_tbl h,rws_district_tbl d,RWS_BPL_CATEGORY_TBL C,RWS_BPL_SUBCATEGORY_TBL D where d.dcode='"+dist+"' and d.dcode=substr(h.HAB_CODE_STATE,1,2) AND  CATEGORY=CATEGORY_NAME AND  SUBCATEGORY=SUBCATEGORY_CODE and   C.CATEGORY_CODE ='"+CATEGORYCODE+"'  and SUBCATEGORY_CODE ='"+subcat+"'    group by d.dcode,d.dname,CATEGORY_NAME,SUBCATEGORY_NAME";
			System.out.println("Caetgory and subcategory QUERY:::: "+qry);
			pstmt=con.prepareStatement(qry);
			
			rst=pstmt.executeQuery();
			int i=4;
			while(rst.next())
			                { 
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setNoOfHabs(rst.getInt(3));
		 		               rwsMaster.setCategoryName(rst.getString(4));
		 		               rwsMaster.setNoOfCategory(rst.getInt(5));

		 		              rwsMaster.setSubcategory(rst.getString(6));
		 		              rwsMaster.setNoOfSubCategory(rst.getInt(7));
		 		             
		 		              
		 		              
		 		            
		 		               dlist.add(rwsMaster);
				             }
			
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	
	
	
	
	public ArrayList categoryData(ArrayList columns,IhhlFormBean rwsm,String dist,String CATEGORYCODE)
	{
		IhhlFormBean rwsMaster=null;
		ArrayList dlist=new ArrayList();
		ArrayList al=new ArrayList();
		try 
		   {
			//System.out.println("category");
			con=RwsOffices.getConn();
			String qry="select d.dcode,d.dname,count(distinct HAB_CODE_STATE),CATEGORY_NAME,count(h.CATEGORY)";
			String ord="";
			boolean added=true;
			boolean ordadded=false;
			
			qry+="from rws_ihhl_goi_tbl h,rws_district_tbl d,RWS_BPL_CATEGORY_TBL C where d.dcode='"+dist+"' and d.dcode=substr(h.HAB_CODE_STATE,1,2) AND  CATEGORY=CATEGORY_NAME AND CATEGORY_CODE ='"+CATEGORYCODE+"'   group by d.dcode,d.dname,CATEGORY_NAME ";
			//System.out.println("Caetgory QUERY "+qry);
			pstmt=con.prepareStatement(qry);
			
			rst=pstmt.executeQuery();
			int i=4;
			while(rst.next())
			                { 
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setNoOfHabs(rst.getInt(3));
		 		               rwsMaster.setCategoryName(rst.getString(4));
		 		               rwsMaster.setNoOfCategory(rst.getInt(5));
		 		              
		 		              
		 		            
		 		               dlist.add(rwsMaster);
				             }
			
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	
	//CONSOLIDATED REPORT FOR A PARTIULAR MANDAL,PANCHAYAT,VILLAGE 
	
	public ArrayList consolData1(ArrayList columns,IhhlFormBean rwsm,String dist)
	{
		IhhlFormBean rwsMaster=null;
int array=0;
		ArrayList dlist=new ArrayList();
		try 
		   {
			con=RwsOffices.getConn();
			
			//FOR VILLAGE
			
			if ( !(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")) && !(rwsm.getPanchCode()==null) && !(rwsm.getPanchCode().equals("")) && !(rwsm.getVillCode()==null) && !(rwsm.getVillCode().equals("")) )
			{
				//System.out.println("DMPV");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,count(distinct h.HAB_CODE_STATE) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				
				qry+=" from rws_ihhl_goi_tbl  h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where substr(h.HAB_CODE_STATE,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and substr(h.HAB_CODE_STATE,6,2)='"+rwsm.getMandalCode()+"' and p.mcode=m.mcode and p.dcode=d.dcode and substr(h.HAB_CODE_STATE,13,2)='"+rwsm.getPanchCode()+"' and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode  and substr(h.HAB_CODE_STATE,8,3)='"+rwsm.getVillCode()+"'";
				
			
				qry+=" and d.dcode='"+dist+"' and d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"'and p.pcode='"+rwsm.getPanchCode()+"' and v.vcode='"+rwsm.getVillCode()+"'   group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vname,v.vcode "+ord+"";
			
				
				
			Debug.println("QUERY IS:1anu--->"+qry);
			pstmt=con.prepareStatement(qry);
			
			rst=pstmt.executeQuery();
			int i=5;
			while(rst.next()) 
			                { 
				
			//	System.out.println("array123445");
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4));
		 		             
		 		            
		 		              if(columns.contains("Mandal Code"))
		 		              {//System.out.println("mcode");
		 		              	rwsMaster.setMandalCode(rst.getString(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Mandal Name"))
		 		              {
		 		             	rwsMaster.setMandalName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Code"))
		 		              {
		 		            	rwsMaster.setPanchCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Name"))
		 		              {
		 		            	rwsMaster.setPanchName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Village Code"))
		 		              {
		 		                rwsMaster.setVillCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Village Name"))
	 		                  {
	 		                  rwsMaster.setVillName(rst.getString(i));
	 		                  i++;
	 		                   }
		 		            
		 		             if(columns.contains("No. Of Habitations"))
	 		                  {
		 		               rwsMaster.setNoOfHabs(rst.getInt(i));
	 		                   i++;
	 		                  }
		 		            /* if(columns.contains("Category Name"))
		 		             {
		 		            	 rwsMaster.setCat(rst.getString(i));
		 		            	 i++;
		 		             }
		 		             if(columns.contains("No. Of Categories"))
		 		             {
		 		            	 rwsMaster.setNoOfCategory(rst.getInt(i));
		 		            	 System.out.println("rwsMaster"+rwsMaster);
		 		            	 i++;
		 		             }
		 		             if(columns.contains("SubCategory Name"))
		 		             {
		 		            	 rwsMaster.setSubcategory(rst.getString(i));
		 		            	 i++;
		 		             }
		 		             if(columns.contains("No. Of SubCategories"))
		 		             {
		 		            	 rwsMaster.setNoOfSubCategory(rst.getInt(i));
		 		            	 i++;
		 		            	 
		 		             }
		 		               */

		 		         
		 		               dlist.add(rwsMaster);
		 		              Debug.println("dlist--->"+dlist);
				             }
			
		   }
			
			//FOR PANCHAYAT
			
			else if ( !(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")) && !(rwsm.getPanchCode()==null) && !(rwsm.getPanchCode().equals("")))
			{
				//System.out.println("DMP");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,count(h.HAB_CODE_STATE) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
			
				
				qry+=" from rws_ihhl_goi_tbl h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p where substr(h.HAB_CODE_STATE,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and substr(h.HAB_CODE_STATE,6,2)='"+rwsm.getMandalCode()+"' and p.mcode=m.mcode and p.dcode=d.dcode and substr(h.HAB_CODE_STATE,13,2)='"+rwsm.getPanchCode()+"' ";
				
				
				qry+=" having d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"'and p.pcode='"+rwsm.getPanchCode()+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname "+ord+"";
			
			Debug.println("QUERY IS:2anu-->"+qry);
			pstmt=con.prepareStatement(qry);
			
			rst=pstmt.executeQuery();
			int i=5;
			while(rst.next())
			                { 
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		              rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4));
		 		              if(columns.contains("Mandal Code"))
		 		              {
		 		              	rwsMaster.setMandalCode(rst.getString(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Mandal Name"))
		 		              {
		 		             	rwsMaster.setMandalName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Code"))
		 		              {
		 		            	rwsMaster.setPanchCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Name"))
		 		              {
		 		            	rwsMaster.setPanchName(rst.getString(i));
		 		                i++;
		 		              }
		 		            
		 		             if(columns.contains("No. Of Habitations"))
	 		                  {
		 		               rwsMaster.setNoOfHabs(rst.getInt(i));
	 		                   i++;
	 		                  }
		 		            
		 		            
		 		            
		 		               dlist.add(rwsMaster);
		 		              Debug.println("QUERY IS:2anu  dlist-->"+dlist);
				             }
			  
				
		   }
			
	
			else if (!(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")))
			{
				//System.out.println("DM");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,count(h.HAB_CODE_STATE) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				
				
					
				qry+="from rws_ihhl_goi_tbl  h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_hab_supply_status_tbl hs where substr(h.HAB_CODE_STATE,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode=m.dcode and substr(h.HAB_CODE_STATE,6,2)='"+rwsm.getMandalCode()+"' and h.HAB_CODE_STATE=hs.hab_code(+) ";
				//System.out.println("Query For Mandal "+qry);
			
				qry+=" and d.dcode=m.dcode having d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname "+ord+"";
			
		Debug.println("Total QUERY IS:3 anu-->"+qry);
			pstmt=con.prepareStatement(qry);
		
			rst=pstmt.executeQuery();
			int i=8;
			while(rst.next())
			                { 
				               rwsMaster = new IhhlFormBean();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4).toUpperCase());
		 		               rwsMaster.setMandalCode(rst.getString(5));
		 		               rwsMaster.setMandalName(rst.getString(6));
		 		               rwsMaster.setNoOfHabs(rst.getInt(7));
		 		             
		 		               dlist.add(rwsMaster);
		 		              Debug.println("Total QUERY IS:3 anu dlist-->"+dlist);
		 		           }
			
		   }
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	// END OF CONSOLIDATED REPORT FOR A PARTICULAR MANDAL,PANCHAYAT,VILLAGE
	

	public ArrayList masterDist()
	{   RwsMaster rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	//String qry1="select d.dname,h.hab_code,p.panch_name from rws_habitation_directory_tbl h,rws_district_tbl d,rws_panchayat_raj_tbl p where substr(h.hab_code,1,2)='"+district+"' and d.dcode=substr(h.hab_code,1,2) and h.hab_code=p.panch_code";
 	String qry2="select dcode,dname from rws_district_tbl";
 	//System.out.println("qry2asasa"+qry2);
	pstmt=con.prepareStatement(qry2);
 	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setDistCode(rst.getString(1));
 		rwsMaster.setDistName4(rst.getString(2));
 		dlist.add(rwsMaster);
 	} 
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	public ArrayList masterMandal(String district)
	{   RwsMaster rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	
 	
	String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname from rws_mandal_tbl m,rws_constituency_tbl c where c.dcode=m.dcode and c.mcode=m.mcode and m.dcode='"+district+"' order by m.mcode";
	pstmt=con.prepareStatement(qry3);
	
 	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setConstituencyCode(rst.getString(1));
 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
 		rwsMaster.setMandalCode(rst.getString(3));
 		rwsMaster.setMandalName(rst.getString(4));
 		dlist.add(rwsMaster);
 	}
	}
 	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	//Master Panchayat Details
	public ArrayList masterPanchayat(String district,String mandal1)
	{   RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	//String qry1="select d.dname,h.hab_code,p.panch_name from rws_habitation_directory_tbl h,rws_district_tbl d,rws_panchayat_raj_tbl p where substr(h.hab_code,1,2)='"+district+"' and d.dcode=substr(h.hab_code,1,2) and h.hab_code=p.panch_code";
 	String qry3="select p.pcode,p.pname from rws_panchayat_tbl p, rws_mandal_tbl m where p.dcode=m.dcode and m.mcode=p.mcode and p.dcode='"+district+"' and  p.mcode='"+mandal1+"'";
 	pstmt=con.prepareStatement(qry3);
	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setPanchCode(rst.getString(1));
 		rwsMaster.setPanchName(rst.getString(2));
 		dlist.add(rwsMaster);
 	}
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;  
	}
	
	public ArrayList masterPanchayat1(String district,String mandal1)
	{   RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
	//String qry3="select m.mcode,m.mname,p.pcode,p.pname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p where p.dcode='"+district+"' and d.dcode=m.dcode and d.dcode=p.dcode and m.dcode=p.dcode and m.mcode=p.mcode order by p.dcode,p.mcode,p.pcode";
	String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname from rws_district_tbl d, rws_constituency_tbl c,rws_mandal_tbl m, rws_panchayat_tbl p where p.dcode='"+district+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and d.dcode=p.dcode and m.dcode=p.dcode and m.mcode=p.mcode order by p.dcode,p.mcode,p.pcode"; 
	pstmt=con.prepareStatement(qry3);
	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setConstituencyCode(rst.getString(1));
 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
 		rwsMaster.setMandalCode(rst.getString(3));
 		rwsMaster.setMandalName(rst.getString(4));
 		rwsMaster.setPanchCode(rst.getString(5));
 		rwsMaster.setPanchName(rst.getString(6));
 		dlist.add(rwsMaster);
 	}
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	
	
	
	
	//Master Village Details
	public ArrayList masterVillage(String district,String mandal1,String panch1)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			String qry3="select vcode,vname from rws_village_tbl where  dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"'";
			pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setVillCode(rst.getString(1));
		 		rwsMaster.setVillName(rst.getString(2));
		 		dlist.add(rwsMaster);
		 	}
		    }
		catch(Exception e) 
		     {
			  //System.out.println(e.getMessage());
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	public ArrayList masterVillage1(String district,String mandal1)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			String qry3="select vcode,vname from rws_village_tbl where  dcode='"+district+"' and mcode='"+mandal1+"'";
			pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setVillCode(rst.getString(1));
		 		rwsMaster.setVillName(rst.getString(2));
		 		dlist.add(rwsMaster);
		 		
		 	}
		    }
		catch(Exception e) 
		     {
			  //System.out.println(e.getMessage());
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	
	
	public ArrayList masterVillage2(String district)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			
			String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode='"+district+"' and d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.dcode=p.dcode and p.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and v.mcode=p.mcode and p.pcode=v.pcode and d.dcode=c.dcode and c.mcode=m.mcode order by c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname";
	        pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())   
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setConstituencyCode(rst.getString(1));
		 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
		 		rwsMaster.setMandalCode(rst.getString(3));
		 		rwsMaster.setMandalName(rst.getString(4));
		 		rwsMaster.setPanchCode(rst.getString(5));
		 		rwsMaster.setPanchName(rst.getString(6));
		 		rwsMaster.setVillCode(rst.getString(7));
		 		rwsMaster.setVillName(rst.getString(8));
		 		dlist.add(rwsMaster);
		 	}
		    }
		catch(Exception e) 
		     {
			
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	

	public ArrayList masterHabitation(String district,String mandal1,String panch1,String village1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from rws_complete_hab_view where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"' and substr(panch_code,8,3)='"+village1+"'";
			pstmt=con.prepareStatement(qry3);
			
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
			
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	
	//habitations under a panchayat
	public ArrayList masterHabitation1(String district,String mandal1,String panch1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from rws_complete_hab_view where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"'";
			pstmt=con.prepareStatement(qry3);
			
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
			
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	//Habitations under a Mandal
	public ArrayList masterHabitation2(String district,String mandal1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from rws_complet_hab_view where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"'";
			pstmt=con.prepareStatement(qry3);
			
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
		
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	
	public ArrayList masterHabitation3(String district)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try   
		  {
			con=RwsOffices.getConn();
			//String qry3="select m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name from rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,"+getPanchRajTabName(district)+" praj where m.dcode=p.dcode and m.dcode='"+district+"' and m.mcode=p.pcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and v.dcode=substr(praj.panch_code,1,2) and v.mcode=substr(praj.panch_code,6,2) and v.pcode=substr(praj.panch_code,13,2) and v.vcode=substr(praj.panch_code,8,3) order by m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name";
			String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name from rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view praj where m.dcode=c.dcode and c.mcode=m.mcode and m.dcode=p.dcode and m.dcode='"+district+"' and m.mcode=p.pcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and v.dcode=substr(praj.panch_code,1,2) and v.mcode=substr(praj.panch_code,6,2) and v.pcode=substr(praj.panch_code,13,2) and v.vcode=substr(praj.panch_code,8,3) order by c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name";
			//System.out.println("qry3anu"+qry3);
			pstmt=con.prepareStatement(qry3);
			
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
     			rwsMaster.setConstituencyCode(rst.getString(1));
			    rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
     			rwsMaster.setMandalCode(rst.getString(3));
			    rwsMaster.setMandalName(rst.getString(4));
			    rwsMaster.setPanchCode(rst.getString(5));
			    rwsMaster.setPanchName(rst.getString(6));
			    rwsMaster.setVillCode(rst.getString(7));
			    rwsMaster.setVillName(rst.getString(8));
			    rwsMaster.setHabCode(rst.getString(9));
			    rwsMaster.setHabName(rst.getString(10));
			    dlist.add(rwsMaster);
			}
			
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	
	
	//Detail Report Begins Here.
	public String queryGenerator(ArrayList columns,IhhlFormBean rwsm,String constituency)
	{
		RwsMaster rwsMaster = null;
		boolean added_one_element=false;
		boolean after_where_added=false;
		String 	qry3="select distinct ";
		String grp="";
		boolean grp_added=false;
		try {	
		con=RwsOffices.getConn();
	
			if (added_one_element)
			qry3+=",";
			qry3+="d.dcode,d.dname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="d.dcode,d.dname";
			grp_added=true;
			
		//}
			//Debug.println("qry gerator 2");
			if(columns.contains("Constituency"))
			{
				//Debug.println("qry gerator3");
				if (added_one_element)
				qry3+=",";
				qry3+="c.constituency_code,c.constituency_name";
				added_one_element=true;
				if(grp_added==false)
				{
			     	grp+="group by ";
				}
				if(grp_added)
			     	grp+=",";
				grp+="c.constituency_code,c.constituency_name";
				grp_added=true;
			}
		if(columns.contains("Mandal"))
		{
			//Debug.println("qry gerator3.1");
			if (added_one_element)
			qry3+=",";
			qry3+="m.mcode,m.mname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="m.mcode,m.mname";
			grp_added=true;
		}
		if(columns.contains("Panchayat"))
		{
			
			if (added_one_element)
			qry3+=",";
			qry3+="panch.pcode,panch.pname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="panch.pcode,panch.pname";
			grp_added=true;
		}
		if(columns.contains("Village"))
		{
			
			if (added_one_element)
			qry3+=",";
			qry3+="v.vcode,v.vname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="v.vcode,v.vname";
			grp_added=true;
		}	
		if(columns.contains("Habitation"))
		{
			
			if (added_one_element)
			qry3+=",";
			qry3+="h.HAB_CODE_STATE,p.panch_name";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.HAB_CODE_STATE,p.panch_name";
			grp_added=true;
		}

		if(columns.contains("Family Head")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.FAMILYHEAD ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.FAMILYHEAD ";
			grp_added=true;
		}
		if(columns.contains("Father/Husband Name")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.FATHERHUSBANDNAME ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.FATHERHUSBANDNAME ";
			grp_added=true;
		}
		if(columns.contains("Gender")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.GENDER  ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.GENDER ";
			grp_added=true;
		}
		if(columns.contains("Card Type")){
			if (added_one_element)
				qry3+=",";
			qry3+="ct.CARD_NAME";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="ct.CARD_NAME";
			grp_added=true;
		}
		if(columns.contains("Card Number")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.CARDNUMBER    ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.CARDNUMBER  ";
			grp_added=true;
		}
		if(columns.contains("Category")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.CATEGORY ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.CATEGORY ";
			grp_added=true;
		}
		if(columns.contains("Sub Category")){
			if (added_one_element)
				qry3+=",";
			qry3+="sc.SUBCATEGORY_NAME";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="sc.SUBCATEGORY_NAME";
			grp_added=true;
		}
		if(columns.contains("Aadhaar Card")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.ADHAARCARD  ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.ADHAARCARD  ";
			grp_added=true;
		}
		
		if(columns.contains("Mobile Number")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.MOBILE ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.MOBILE ";
			grp_added=true;
		}
		if(columns.contains("Toilet Constructed From")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.TOILETCONTRUCTEDFROM";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.TOILETCONTRUCTEDFROM ";
			grp_added=true;
		}
		
		if(columns.contains("Is Having Toilet")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.ISHAVINGTOILET ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.ISHAVINGTOILET  ";
			grp_added=true;
		}
		if(columns.contains("Is Having Toilet Functional")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.ISHAVINGTOILET_FUNCTIONAL";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.ISHAVINGTOILET_FUNCTIONAL";
			grp_added=true;
		}
		
		if(columns.contains("Is Having Toilet Functional Used")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.ISHAVINGTOILET_FUNCTIONAL_USED ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.ISHAVINGTOILET_FUNCTIONAL_USED ";
			grp_added=true;
		}
		
		if(columns.contains("Is WaterFacility Avaliable")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.ISWATERFACILITYAVAILABLE ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.ISWATERFACILITYAVAILABLE";
			grp_added=true;
		}

		if(columns.contains("HabCode State")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.HAB_CODE_STATE ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.HAB_CODE_STATE ";
			grp_added=true;
		}
		
		if(columns.contains("Benificial Id")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.BENFID ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.BENFID ";
			grp_added=true;
		}
		
		if(columns.contains("GramPanchayat Code")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.GRAMPANCHAYATCODE";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.GRAMPANCHAYATCODE ";
			grp_added=true;
		}
		
		if(columns.contains("NBA Village Id")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.NBAVILLAGEID ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.NBAVILLAGEID";
			grp_added=true;
		}
		
		
		qry3+=" from rws_ihhl_goi_tbl h,rws_complete_hab_view p,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_village_tbl v,rws_panchayat_tbl panch,RWS_BPL_CATEGORY_TBL bp,RWS_BPL_SUBCATEGORY_TBL sc,RWS_IHHL_CARDTYPE_TBL ct  where ";
		
		
		if(columns.contains("District"))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" d.dcode=substr(h.HAB_CODE_STATE ,1,2) and d.dcode=substr(p.panch_code,1,2) and substr(h.HAB_CODE_STATE ,1,2)=substr(p.panch_code,1,2) and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode=v.dcode and m.mcode=substr(h.HAB_CODE_STATE ,6,2) and m.mcode=substr(p.panch_code,6,2) and substr(h.HAB_CODE_STATE ,6,2)=substr(p.panch_code,6,2) and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=v.mcode and panch.pcode=substr(h.HAB_CODE_STATE,13,2) and panch.pcode=substr(p.panch_code,13,2) and substr(h.HAB_CODE_STATE ,13,2)=substr(p.panch_code,13,2) and panch.pcode=v.pcode and v.vcode=substr(h.HAB_CODE_STATE ,8,3) and v.vcode=substr(p.panch_code,8,3) and substr(h.HAB_CODE_STATE ,8,3)=substr(p.panch_code,8,3)  ";
			after_where_added=true;
		}
		if(columns.contains("Constituency"))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" d.dcode=c.dcode and c.mcode=m.mcode ";
			after_where_added=true;
		}
		if(columns.contains("Habitation"))
		{
			
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.HAB_CODE_STATE = p.panch_code  ";
			after_where_added=true;
		}	
	
		if (!(rwsm.getDistCode().equals("")) && !(rwsm.getDistCode().equals("ALL")))
		{
			if (!(rwsm.getDistCode().equals("")))
			{
				
				if(after_where_added)
					qry3+=" and";
				
				qry3+=" d.dcode='"+rwsm.getDistCode()+"'";
				after_where_added=true;
			}
			
			
			if (!(rwsm.getMandalCode().equals("")))
			{
				
				if(after_where_added)
					qry3+=" and";
				
				qry3+="  m.mcode='"+rwsm.getMandalCode()+"'";
				after_where_added=true;
			}
			
			if (!(rwsm.getPanchCode().equals("")))
			{
			
				if(after_where_added)
					qry3+=" and";
			
				qry3+=" panch.pcode='"+rwsm.getPanchCode()+"'";
				after_where_added=true;
			}
			
			if (!(rwsm.getVillCode().equals("")))
			{
			
				if(after_where_added)
					qry3+=" and";
				
				qry3+=" v.vcode='"+rwsm.getVillCode()+"'";
				after_where_added=true;
			}
			if (!(rwsm.getHabcode().equals("")))
			{
				
				if(after_where_added)
					qry3+=" and";
				qry3+=" h.HAB_CODE_STATE='"+rwsm.getHabcode()+"'";
				after_where_added=true;
			}
			
			if (!(constituency.equals("")))
			{
				
				if(after_where_added)
					qry3+=" and";
				qry3+=" c.constituency_code='"+constituency+"'";
				after_where_added=true;
			}
			
			
			
		}
		qry3+=" and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and m.dcode=panch.dcode and m.mcode =panch.mcode and panch.dcode=v.dcode and panch.mcode=v.mcode and panch.pcode=v.pcode  and h.HAB_CODE_STATE =p.panch_code and substr(p.panch_code,1,2)=v.dcode and substr(p.panch_code,6,2)=v.mcode and substr(p.panch_code,13,2)=v.pcode and substr(p.panch_code,8,3)=v.vcode  and h.CATEGORY=bp.CATEGORY_NAME and bp.CATEGORY_CODE=sc.CATEGORY_CODE and ct.CARD_TYPE=CARDTYPE    "+grp+" ";
			
		Debug.println("qry3--anu1212223111111111114---> "+qry3);
	
}
catch(Exception e)
 {
	
 }
return qry3;
}
	
	
	
	
	public ArrayList detailReport(IhhlFormBean rwsm,String qry3,String check)
	{
	ArrayList rows=new ArrayList();
	try {
	
	
	Debug.println("view 2 QUERY----18/12/2014---->"+qry3);

	
	
	
	pstmt=con.prepareStatement(qry3);
	rst=pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rst.getMetaData();	
    int noofcolumns = rsmd.getColumnCount();
	String str="",hab_code_state="";
	String lpcd1="";
	String query1="",flag="false";
	
	double lpcd=0,safelpcd=0;	
	boolean pp=false;
	int ival=1,a=0;
	ArrayList row=null;
	 while(rst.next())
 	  {
		 
		hab_code_state=rst.getString("hab_code_state");
		
			row=new ArrayList();
			for (int i=1;i<=noofcolumns;i++) 
		 	{
				str=rst.getString(i);
				
				if(str==null || str.equals("") || str.equals(" ") || str.equals("null"))
		 		str="-";
		 		row.add(str);
		 		flag="true";
		 	}
			if(check.equals("true"))
			{	
			hab_code_state=rst.getString("hab_code_state");	
		
			}
		rows.add(row);
		
	  }
					

	
	
	
	}
 	catch (SQLException se)
	{
		//System.out.println("Exception in detailReport "+se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
               {
               }
	}
	return rows;
	}
	

	public String cheaderNames(String circle)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT circle_office_name FROM rws_circle_office_tbl where circle_office_code='"+circle+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String dheaderNames(String circle,String divison)
	{
		String dohead=null;
		try
		{	
		con=RwsOffices.getConn();
		String qry="SELECT division_office_name FROM rws_division_office_tbl  where circle_office_code='"+circle+"' and division_office_code='"+divison+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	dohead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dohead;
	
	}
	public String sdheaderNames(String circle,String divison,String subdivision)
	{
		String dohead=null;
		try
		{	
		con=RwsOffices.getConn();
		String qry="SELECT subdivision_office_name FROM rws_subdivision_office_tbl  where circle_office_code='"+circle+"' and division_office_code='"+divison+"' and subdivision_office_code='"+subdivision+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	dohead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dohead;
	}
	public String progheaderNames(String program)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT PROGRAMME_NAME FROM rws_programme_tbl where PROGRAMME_CODE = '"+program+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String subprogheaderNames(String program,String subprogram)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT SUBPROGRAMME_NAME FROM rws_subprogramme_tbl where PROGRAMME_CODE = '"+program+"' and SUBPROGRAMME_CODE = '"+subprogram+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	
	public String wcheaderNames(String wc)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT CATEGORY_NAME FROM rws_work_category_tbl where CATEGORY_CODE  = '"+wc+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
	 	nic.watersoft.commons.Debug.println("work categoey in DAO"+chead);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}

	public String planheaderNames(String plan)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT PLAN_NAME  FROM rws_plan_nonplan_tbl where PLAN_CODE    = '"+plan+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String augnewheaderNames(String augnew)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT AUG_NEW_NAME FROM rws_augumentation_new_tbl where AUG_NEW_CODE    = '"+augnew+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
 
	public String schemeheaderNames(String scheme)
		{
			String chead=null;
			try
			{	
			con=RwsOffices.getConn();
			
			String qry="SELECT TYPE_OF_ASSET_NAME  FROM rws_asset_type_tbl where TYPE_OF_ASSET_CODE   = '"+scheme+"'";
		 	pstmt=con.prepareStatement(qry);
		 	//Debug.println("qruy%%%%^:"+qry);
		 	rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 	chead=rst.getString(1);
			}
		 	}
			catch (SQLException se)
			{
				Debug.println(se.getMessage());
			}
			finally
			{
			try{
				rst.close();
				pstmt.close();
				con.close();
		 	    }
			catch (Exception e)
			                   {
			                   }
			}
			return chead;
		
		}

		

		public String panchheaderNames(String district,String mandal,String panchayat)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select pname from rws_panchayat_tbl where dcode = '"+district+"' and mcode = '"+mandal+"' and pcode='"+panchayat+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;

	 
	}

	public String habheaderNames(String district,String mandal,String panchayat,String village,String hab)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select a.panch_name from rws_panchayat_raj_tbl a,rws_complete_hab_view ch  where a.panch_code=ch.panch_code and dcode = '"+district+"' and mcode = '"+mandal+"'" +
				" and pcode='"+panchayat+"' and vcode='"+village+"' and a.panch_code='"+hab+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;


	}



	public String villheaderNames(String district,String mandal,String panchayat,String village)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select vname from rws_village_tbl where dcode = '"+district+"' and mcode = '"+mandal+"'" +
				" and pcode='"+panchayat+"' and vcode='"+village+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;


	}

		

		public static String formatData(int data)
		{
		if(data==0)
			return "--";
		else return data+"";
		}
		

	
	public String distheaderNames(String district)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT dname FROM rws_district_tbl where dcode='"+district+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String conheaderNames(String district,String constituency)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select CONSTITUENCY_NAME from rws_constituency_tbl where DCODE = '"+district+"' and CONSTITUENCY_CODE = '"+constituency+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String mandheaderNames(String district,String mandal)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select mname from rws_mandal_tbl where dcode = '"+district+"' and mcode = '"+mandal+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public void createViewWorks(String qry,String sessionId)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view? AS ?";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			PreparedStatement ps=con.prepareStatement(qry1);
            ps.setString(1, sessionId.substring(0,10));
            ps.setString(2, qry);
			int res=ps.executeUpdate();
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	public void createViewWorks1(String qry)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view1 AS ?";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			PreparedStatement ps=con.prepareStatement(qry1);
			ps.setString(1,qry1);
			int res=ps.executeUpdate();
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	public void createViewWorks2(String qry)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view2 AS  ?";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			PreparedStatement ps=con.prepareStatement(qry1);
            ps.setString(1, qry);
			int res=ps.executeUpdate();
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view2 "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	
	public boolean dropViewWork(String sessionId)
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view?";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	PreparedStatement ps=con.prepareStatement(qry);
        ps.setString(1, sessionId.substring(0,10));
	 	int res=ps.executeUpdate();
	 	nic.watersoft.commons.Debug.println("View work_selection_view Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public boolean dropViewWork1()
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view1";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	nic.watersoft.commons.Debug.println("View work_selection_view1 Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view1 "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public boolean dropViewWork2()
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view2";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	nic.watersoft.commons.Debug.println("View work_selection_view2 Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view2 "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public static float Round(float Rval, int Rpl) {
		  float p = (float)Math.pow(10,Rpl);
		  Rval = Rval * p;
		  float tmp = Math.round(Rval);
		  return (float)tmp/p;
		    }
	




	public static void closeConnection(Connection conn)
	{
		try
		{
			if(conn!=null)conn.close();
			if(!conn.isClosed())conn.close();
			conn=null;
		}
		catch(Exception e)
		{
			Debug.println("Close Connection Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(conn!=null)conn.close();
				if(!conn.isClosed())conn.close();
				conn=null;
			}
			catch(Exception e)
			{
				Debug.println("Close Connection Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeStatement(Statement stmt)
	{
		try
		{
			if(stmt!=null)stmt.close();
			stmt = null;
		}
		catch(Exception e)
		{
			Debug.println("Close Statement Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(stmt!=null)stmt.close();
				stmt = null;
			}
			catch(Exception e)
			{
				Debug.println("Close Statement Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeResultSet(ResultSet rs)
	{
		try
		{
			if(rs!=null)rs.close();
			rs = null;
		}
		catch(Exception e)
		{
			Debug.println("Close RS Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)rs.close();
				rs = null;
			}
			catch(Exception e)
			{
				Debug.println("Close RS Method:"+e.getMessage());
			}
		}
	}
	
	
}
