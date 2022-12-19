package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.util.SystemOutLogger;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class Rws_Functional_Status_Dao {	
	
	public static String getRepairCode() {
		Connection conn = null;
		String repaircode = "";
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT nvl(max(repair_code),0)+1 FROM Rws_Repair_Master_Tbl");
			rs = stmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).length() == 1)
					repaircode = "00" + rs.getString(1);
				else if (rs.getString(1).length() == 2)
					repaircode = "0" + rs.getString(1);
				else
					repaircode = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairCode() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairCode Finally" + e);
			}
		}
		return repaircode;
	}
	
	public int saveRepair(String repairCode, String repairName) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "insert into Rws_Repair_Master_Tbl values( ? , ? )";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, repairCode);
			stmt.setString(2, repairName);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao saveRepair : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao saveRepair  Finally : " + e.getMessage());
			}
		}
		return 0;
	}
	
	public ArrayList getRepairs() {
		ArrayList repairs = new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT repair_code,REPAIR_DESC FROM Rws_Repair_Master_Tbl order by repair_code");
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm repair_Entry_Form = new rws_functional_repair_frm();
				repair_Entry_Form.setRepairCode(rs.getString("repair_code"));
				repair_Entry_Form.setRepairName(rs.getString("REPAIR_DESC"));
				repairs.add(repair_Entry_Form);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairs() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairs Finally : " + e.getMessage());
			}
		}
		return repairs;
	}
	
	public int editRepair(String repairCode, String repairName) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;		
		int count = 0;
		try {
			String q = "update Rws_Repair_Master_Tbl set REPAIR_DESC = ? where repair_code = ? ";		
			stmt = conn.prepareStatement(q);
			stmt.setString(1, repairName);
			stmt.setString(2, repairCode);
			count = stmt.executeUpdate();
			return count;
		}  catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao editRepair() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao editRepair() Finally : " + e.getMessage());
			}
		}
		return 0;
	}
	
	public ArrayList getAssetTypeList() throws Exception {
		Connection conn = null;
		ArrayList assets = new ArrayList();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String query="select TYPE_OF_ASSET_CODE,TYPE_OF_ASSET_NAME from rws_asset_type_tbl where type_of_asset_code not in ('07','10','11','12') order by type_of_asset_code";
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm assettypes = new rws_functional_repair_frm();
				assettypes.setAsttype(rs.getString("TYPE_OF_ASSET_CODE"));
				assettypes.setAsttypecode(rs.getString("TYPE_OF_ASSET_CODE")+" - "+rs.getString("TYPE_OF_ASSET_NAME"));
				assets.add(assettypes);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Funtional_Status_DAO getAssetTypeList() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Funtional_Status_DAO getAssetTypeList Finally : " + e.getMessage());
			}
		}
		return assets;
	}
	
	public ArrayList getAllAssetComps(String astType) throws Exception {
		Connection conn = null;
		ArrayList assetsCompList = new ArrayList();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String query="select asset_component_code, asset_component_name from RWS_ASSET_COMPONENT_TYPE_TBL where type_of_asset_code= ? order by asset_component_code";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, astType);
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm assetCompTypes = new rws_functional_repair_frm();
				assetCompTypes.setAstCompCode(rs.getString("asset_component_code"));
				assetCompTypes.setAstCompName(rs.getString("asset_component_code") + " - " + rs.getString("asset_component_name"));
				assetsCompList.add(assetCompTypes);
			}				
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Funtional_Status_DAO getAllAssetComps() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Funtional_Status_DAO getAllAssetComps Finally : " + e.getMessage());
			}
		}
		return assetsCompList;
	}	
	
	public ArrayList getAllAssetSubComps(String astType ,String astComp) throws Exception {
		Connection conn = null;
		ArrayList assetsSubCompList = new ArrayList();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String query="select ASSET_SUBCOMPONENT_CODE, ASSET_SUBCOMPONENT_NAME from Rws_Asset_Subcomponent_Tbl where type_of_asset_code = ?  and  ASSET_COMPONENT_CODE = ? order by ASSET_SUBCOMPONENT_CODE";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, astType);
			stmt.setString(2, astComp);
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm assetSubCompTypes = new rws_functional_repair_frm();
				assetSubCompTypes.setAstSubCompCode(rs.getString("ASSET_SUBCOMPONENT_CODE"));
				assetSubCompTypes.setAstSubCompName(rs.getString("ASSET_SUBCOMPONENT_NAME"));
				assetsSubCompList.add(assetSubCompTypes);
			}				
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Funtional_Status_DAO getAllAssetSubComps : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Funtional_Status_DAO getAllAssetComps Finally : " + e.getMessage() );
			}
		}
		return assetsSubCompList;
	}
	
	public ArrayList getRepairCodeName() {
		ArrayList repairs = new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT repair_code,REPAIR_DESC FROM Rws_Repair_Master_Tbl order by repair_code");
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm repair_Entry_Form = new rws_functional_repair_frm();
				repair_Entry_Form.setRepairCode(rs.getString("repair_code"));
				repair_Entry_Form.setRepairName(rs.getString("repair_code")+" - "+rs.getString("REPAIR_DESC"));
				repairs.add(repair_Entry_Form);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairCodeName() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao getRepairCodeName Finally : " + e.getMessage());
			}
		}
		return repairs;
	}
	
	public String saveRepairAssetCompLink(String astType,String astComp,String repairType,String souType) {
		Connection conn = null;		
		PreparedStatement stmt = null,stmt1 = null;
		ResultSet resultSet=null;
		int count = 0;
		String message="",query="";
		try {
			conn = RwsOffices.getConn();
			if(!isExist(astType,astComp,repairType,souType)){
				if(astComp==null && astComp.equals("")&& souType==null && souType.equals("")){
					query = "insert into  Rws_Asset_Repair_Lnk_Tbl(ASSET_TYPE_CODE,REPAIR_CODE) values('"+astType+"','"+repairType+"')";
				}else if(astComp!=null && !astComp.equals("")&& souType==null && souType.equals("")){
					query = "insert into  Rws_Asset_Repair_Lnk_Tbl(ASSET_TYPE_CODE,ASSET_COMPONENT_CODE,REPAIR_CODE) values('"+astType+"','"+astComp+"','"+repairType+"')";
				}else{
					query = "insert into  Rws_Asset_Repair_Lnk_Tbl(ASSET_TYPE_CODE,ASSET_COMPONENT_CODE,REPAIR_CODE,SOURCE_COMPONENT_CODE) values('"+astType+"','"+astComp+"','"+repairType+"','"+souType+"')";
				}
				stmt = conn.prepareStatement(query);				
				count = stmt.executeUpdate();
			}
			else{
				return "Mapping Already done";
			}
			if(count>0){
				message="Added Successfully";
			}
			return message;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao saveRepairAssetCompLink() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao saveRepairAssetCompLink() Finally : " + e.getMessage());
			}
		}
		return message;
	}
	
	private boolean isExist(String astType, String astComp,String repairType,String souType) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset=null;
		String query1="";
		try{
			conn = RwsOffices.getConn();
			query1 = "select * from Rws_Asset_Repair_Lnk_Tbl where ASSET_TYPE_CODE='"+astType+"' and REPAIR_CODE='"+repairType+"' ";
				if(astComp!=null && !astComp.equals("") ){
					query1 += " and ASSET_COMPONENT_CODE='"+astComp+"' ";
				}if(souType!=null && !souType.equals("") ){
					query1 += " and SOURCE_COMPONENT_CODE='"+souType+"' ";
				}
			stmt = conn.prepareStatement(query1);					
			rset=stmt.executeQuery();
			if(rset.next()){				
				return true;
			}			
		}
		catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao isExist() : " + e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao isExist() Finally : " + e.getMessage());
			}
		}
		return false;
	}
	
	public ArrayList getAssetComponentRepairList(String astType, String astComp,String souType,String repairType) {
		ArrayList assetCompRepairLnkList= new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null,stmt1=null;
		ResultSet rs = null,rs1=null;
		try {
			String query="";
			query="select  nvl(a.ASSET_TYPE_CODE,'-') as ASSET_TYPE_CODE ,B.Type_Of_Asset_Name,nvl(a.REPAIR_CODE,'-') as REPAIR_CODE,C.Repair_Desc,nvl(a.ASSET_COMPONENT_CODE,'-') as ASSET_COMPONENT_CODE,nvl(D.Asset_Component_Name,'-') as Asset_Component_Name,nvl(a.SOURCE_COMPONENT_CODE,'-') as SOURCE_COMPONENT_CODE from Rws_Asset_Repair_Lnk_Tbl a left join Rws_Asset_Component_Type_Tbl d on (A.Asset_Type_Code=D.Type_Of_Asset_Code and A.Asset_Component_Code=D.Asset_Component_Code),Rws_Asset_Type_Tbl b,Rws_Repair_Master_Tbl c where A.Asset_Type_Code=B.Type_Of_Asset_Code and A.Repair_Code=C.Repair_Code ";
			if(!astType.equals("")&& astType!=null){
				query+=" and a.Asset_Type_Code='"+astType+"' ";
			}
			if(!astComp.equals("") && astComp!=null){
				query+=" and a.ASSET_COMPONENT_CODE='"+astComp+"' ";
			}
			if(!souType.equals("") && souType!=null){
				query+=" and a.SOURCE_COMPONENT_CODE='"+souType+"' ";
			}
			if(!repairType.equals("")&& repairType!=null){
				query+=" and a.repair_code='"+repairType+"' ";
			}
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm lnkList = new rws_functional_repair_frm();
				lnkList.setAsttype(rs.getString("ASSET_TYPE_CODE"));
				lnkList.setAst(rs.getString("Type_Of_Asset_Name"));
				lnkList.setRepairType(rs.getString("REPAIR_CODE"));
				lnkList.setRepairName(rs.getString("Repair_Desc"));
				lnkList.setAstComp(rs.getString("ASSET_COMPONENT_CODE"));
				lnkList.setAstCompName(rs.getString("Asset_Component_Name"));
				lnkList.setSouType(rs.getString("SOURCE_COMPONENT_CODE"));
				if(!rs.getString("SOURCE_COMPONENT_CODE").equals("-")){
					String qry="select nvl(B.Subsource_Type_Name,'-') as Subsource_Type_Name from Rws_Source_Type_Tbl a,Rws_Subsource_Type_Tbl b where a.SOURCE_TYPE_CODE=B.Source_Type_Code and a.SOURCE_TYPE_CODE= ? and B.Subsource_Type_Code= ? ";
					stmt1 = conn.prepareStatement(qry);
					stmt1.setString(1, rs.getString("SOURCE_COMPONENT_CODE").substring(0, 1));
					stmt1.setString(2, rs.getString("SOURCE_COMPONENT_CODE").substring(2, 3));
					rs1 = stmt1.executeQuery();
					if(rs1.next())
						lnkList.setSourceTypeName(rs1.getString("Subsource_Type_Name"));
					else
						lnkList.setSourceTypeName("-");
						
				}else{
					lnkList.setSourceTypeName("-");
				}
				assetCompRepairLnkList.add(lnkList);				
			}
			return assetCompRepairLnkList;

		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao getAssetComponentRepairList() : " + e.getMessage());			
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao getAssetComponentRepairList() Finally : " + e.getMessage());				
			}
		}
		return null;
	}
	
	public ArrayList getSubSourceTypes() throws Exception {
		Connection conn = null;
		ArrayList sourceTypes = new ArrayList();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String query="select A.Source_Type_Code,B.Subsource_Type_Code,B.Subsource_Type_Name from Rws_Source_Type_Tbl a,Rws_Subsource_Type_Tbl b  where a.Source_Type_Code in ('1','2') and A.Source_Type_Code=B.Source_Type_Code";
			stmt = conn.prepareStatement(query);
			rs = stmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm assetCompTypes = new rws_functional_repair_frm();
				assetCompTypes.setSourceTypeCode(rs.getString("Source_Type_Code")+","+rs.getString("Subsource_Type_Code"));
				assetCompTypes.setSourceTypeName(rs.getString("Subsource_Type_Name"));
				sourceTypes.add(assetCompTypes);
			}				
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Funtional_Status_DAO getSubSourceTypes : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Funtional_Status_DAO getSubSourceTypes Finally : " + e.getMessage());
			}
		}
		return sourceTypes;
	}
	
	public ArrayList getSubSourceTypes(String astSubComp) throws Exception {
		Connection conn = null;
		ArrayList sourceTypes = new ArrayList();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			//System.out.println("in Sources");
			conn = RwsOffices.getConn();
			String query="select A.Source_Type_Code,B.Subsource_Type_Code,B.Subsource_Type_Name from Rws_Source_Type_Tbl a,Rws_Subsource_Type_Tbl b  where A.Source_Type_Code=B.Source_Type_Code";
			if(astSubComp.equals("001")){
				query+=" and A.Source_Type_Code='1'";
			}
			if(astSubComp.equals("002")){
				query+=" and A.Source_Type_Code='2'";
			}			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				rws_functional_repair_frm assetCompTypes = new rws_functional_repair_frm();
				assetCompTypes.setSourceTypeCode(rs.getString("Source_Type_Code")+","+rs.getString("Subsource_Type_Code"));
				assetCompTypes.setSourceTypeName(rs.getString("Subsource_Type_Name"));
				sourceTypes.add(assetCompTypes);
			}				
		} catch (Exception e) {
			System.out.println("Exception in getSubSourceTypes()" + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getSubSourceTypes Finally" + e);
			}
		}
		return sourceTypes;
	}
	
	public ArrayList getRepairsFunctionalStatus(rws_functional_repair_frm frm) {
		ArrayList repairs = new ArrayList();
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String query="";
			if( !frm.getAsttype().equals("") && frm.getAsttype()!=null && (frm.getAsttype().equals("04") || frm.getAsttype().equals("05") || frm.getAsttype().equals("06"))){
				query="select A.Repair_Code,A.Repair_Desc from Rws_Repair_Master_Tbl a,Rws_Asset_Repair_Lnk_Tbl b where A.Repair_Code=B.Repair_Code and "
						+ "B.Asset_Type_Code=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, frm.getAsttype());
			}else if(!frm.getAsttype().equals("") && frm.getAsttype()!=null 
					&& !frm.getAstComp().equals("01")){
				query="select A.Repair_Code,A.Repair_Desc from Rws_Repair_Master_Tbl a,Rws_Asset_Repair_Lnk_Tbl b where A.Repair_Code=B.Repair_Code and "
						+ "B.Asset_Type_Code=? and B.Asset_Component_Code=? ";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, frm.getAsttype());
				pstmt.setString(2, frm.getAstComp());
			}else if(!frm.getSouType().equals("") && frm.getSouType()!=null 
					&& !frm.getAstSubComp().equals("") && frm.getAstSubComp()!=null
					&& !frm.getAstComp().equals("") && frm.getAstComp()!=null
					&& !frm.getAsttype().equals("") && frm.getAsttype()!=null 
					&& frm.getAstComp().equals("01")){
				query="select A.Repair_Code,A.Repair_Desc from Rws_Repair_Master_Tbl a,Rws_Asset_Repair_Lnk_Tbl b where A.Repair_Code=B.Repair_Code and "
						+ "B.Asset_Type_Code=? and B.Asset_Component_Code=? and B.Source_Component_Code=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, frm.getAsttype());
				pstmt.setString(2, frm.getAstComp());
				pstmt.setString(3, frm.getSouType());
			}
		//	System.out.println("query :  "+query);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rws_functional_repair_frm repairList = new rws_functional_repair_frm();
				repairList.setRepairCode(rs.getString("repair_code"));
				repairList.setRepairName(rs.getString("REPAIR_DESC"));
				repairs.add(repairList);
			}			
		} catch (Exception e) {
			System.out.println("Exception at getRepairsFunctionalStatus of Rws_Funtional_Status_DAO is  : " + e);
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception at Finally block of  getRepairsFunctionalStatus in Rws_Funtional_Status_DAO is: " + e);
			}
		}
		return repairs;
	}
	
	public ArrayList<rws_functional_repair_frm> getAssetCompListForFunctionalStatus(rws_functional_repair_frm frm) {
		ArrayList<rws_functional_repair_frm> sourcesList=new ArrayList<rws_functional_repair_frm>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//System.out.println("in Sources");
			String query="";
			conn = RwsOffices.getConn();
			if(frm.getAsttype().equals("04")){
				query = "select b.asset_code,b.asset_name,a.hp_code as comp_code,'Hand Pump' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
						+" from Rws_Hp_Subcomp_Param_Tbl a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
						+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.Hp_Code and B.Hab_Code=e.Panch_Code";
					if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
						query+= " and substr(a.hp_code,1,2)='"+frm.getDcode()+"'";
					if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
						query+= " and substr(a.hp_code,6,2)='"+frm.getMcode()+"'";
					if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
						query+= " and substr(a.hp_code,13,2)='"+frm.getPanchayat()+"'";
					if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
						query+= " and substr(a.hp_code,8,3)='"+frm.getVcode()+"'";						
			}
			else if(frm.getAsttype().equals("05")){
				query = "select b.asset_code,b.asset_name,a.SHALLOWHP_CODE as comp_code,'Shallow Hand Pump' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
						+" from RWS_SHALLOWHANDPUMPS_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
						+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.SHALLOWHP_CODE and B.Hab_Code=e.Panch_Code";
					if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
						query+= " and substr(a.SHALLOWHP_CODE,1,2)='"+frm.getDcode()+"'";
					if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
						query+= " and substr(a.SHALLOWHP_CODE,6,2)='"+frm.getMcode()+"'";
					if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
						query+= " and substr(a.SHALLOWHP_CODE,13,2)='"+frm.getPanchayat()+"'";
					if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
						query+= " and substr(a.SHALLOWHP_CODE,8,3)='"+frm.getVcode()+"'";						
			}
			else if(frm.getAsttype().equals("06")){
				query = "select b.asset_code,b.asset_name,a.OPENWELL_CODE as comp_code,'OPEN WELL' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
						+" from RWS_OPEN_WELL_MAST_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
						+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OPENWELL_CODE and B.Hab_Code=e.Panch_Code";
					if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
						query+= " and substr(a.OPENWELL_CODE,1,2)='"+frm.getDcode()+"'";
					if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
						query+= " and substr(a.OPENWELL_CODE,6,2)='"+frm.getMcode()+"'";
					if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
						query+= " and substr(a.OPENWELL_CODE,13,2)='"+frm.getPanchayat()+"'";
					if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
						query+= " and substr(a.OPENWELL_CODE,8,3)='"+frm.getVcode()+"'";						
			}else if(frm.getAsttype().equals("08")){
				query = "select b.asset_code,b.asset_name,a.OTHER_COMP_CODE as comp_code,'OTHERS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
						+" from RWS_AST_OTHERS_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
						+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OTHER_COMP_CODE and B.Hab_Code=e.Panch_Code";
					if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
						query+= " and substr(a.OTHER_COMP_CODE,1,2)='"+frm.getDcode()+"'";
					if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
						query+= " and substr(a.OTHER_COMP_CODE,6,2)='"+frm.getMcode()+"'";
					if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
						query+= " and substr(a.OTHER_COMP_CODE,13,2)='"+frm.getPanchayat()+"'";
					if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
						query+= " and substr(a.OTHER_COMP_CODE,8,3)='"+frm.getVcode()+"'";							
			}else if( frm.getAsttype().equals("01") || frm.getAsttype().equals("02") || frm.getAsttype().equals("03") || frm.getAsttype().equals("09")){
				if(frm.getAstComp().equals("06")){
					query = "select b.asset_code,b.asset_name,a.PUMP_CODE as comp_code,'PUMP SET' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
							+" from RWS_AST_SUBCOMP_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
							+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.PUMP_CODE and B.Hab_Code=e.Panch_Code";
						if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
							query+= " and substr(a.PUMP_CODE,1,2)='"+frm.getDcode()+"'";
						if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
							query+= " and substr(a.PUMP_CODE,6,2)='"+frm.getMcode()+"'";
						if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
							query+= " and substr(a.PUMP_CODE,13,2)='"+frm.getPanchayat()+"'";
						if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
							query+= " and substr(a.PUMP_CODE,8,3)='"+frm.getVcode()+"'";
				}else if(frm.getAstComp().equals("05")){
					if(frm.getAstSubComp().equals("001")){
						query = "select b.asset_code,b.asset_name,a.CL_CODE as comp_code,'MISCELLANEOUS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_OTHERS_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OTHER_COMP_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.OTHER_COMP_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.OTHER_COMP_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.OTHER_COMP_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.OTHER_COMP_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("002")){
						query = "select b.asset_code,b.asset_name,a.CL_CODE as comp_code,'CHLORINATION' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_CHLORINATION_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.CL_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.CL_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.CL_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.CL_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.CL_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("003")){
						query = "select b.asset_code,b.asset_name,a.OANDMCODE as comp_code,'O AND M' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_OANDM_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OANDMCODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.OANDMCODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.OANDMCODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.OANDMCODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.OANDMCODE,8,3)='"+frm.getVcode()+"'";
					}
				}else if(frm.getAstComp().equals("04")){
					if(frm.getAstSubComp().equals("001")){
						query = "select b.asset_code,b.asset_name,a.OHSR_CODE as comp_code,'OHSR' as comp_name,a.OHSR_LOC as location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_OHSR_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OHSR_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.OHSR_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.OHSR_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.OHSR_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.OHSR_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("002")){
						query = "select b.asset_code,b.asset_name,a.OHBR_CODE as comp_code,'OHBR' as comp_name,a.OHBR_LOC as location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_OHBR_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.OHBR_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.OHBR_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.OHBR_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.OHBR_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.OHBR_CODE,8,3)='"+frm.getVcode()+"'";				
					}else if(frm.getAstSubComp().equals("003")){
						query = "select b.asset_code,b.asset_name,a.GLSR_CODE as comp_code,'GLSR' as comp_name,a.GLSR_LOC as location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_GLSR_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.GLSR_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.GLSR_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.GLSR_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.GLSR_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.GLSR_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("004")){
						query = "select b.asset_code,b.asset_name,a.GLBR_CODE as comp_code,'GLBR' as comp_name,a.GLBR_LOC as location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_GLBR_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.GLBR_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.GLBR_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.GLBR_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.GLBR_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.GLBR_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("005")){
						query = "select b.asset_code,b.asset_name,a.CISSC_CODE as comp_code,'CISTERNS' as comp_name,a.CIS_LOC as location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_CIS_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.CISSC_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.CISSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.CISSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.CISSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.CISSC_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("006")){
						query = "select b.asset_code,b.asset_name,a.BPT_CODE as comp_code,'BPT' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_BPT_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.BPT_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.BPT_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.BPT_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.BPT_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.BPT_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("007")){
						query = "select b.asset_code,b.asset_name,a.STANDPOST_CODE as comp_code,'STAND POST' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_STANDPOST_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.STANDPOST_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.STANDPOST_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.STANDPOST_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.STANDPOST_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.STANDPOST_CODE,8,3)='"+frm.getVcode()+"'";
					}
				}else if(frm.getAstComp().equals("03")){
					if(frm.getAstSubComp().equals("001")){
						query = "select b.asset_code,b.asset_name,a.PUMPINGMAIN_CODE as comp_code,'PUMPING MAIN' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_PUMPINGMAIN_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.PUMPINGMAIN_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.PUMPINGMAIN_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.PUMPINGMAIN_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.PUMPINGMAIN_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.PUMPINGMAIN_CODE,8,3)='"+frm.getVcode()+"'";					
					}else if(frm.getAstSubComp().equals("002")){
						query = "select b.asset_code,b.asset_name,a.GRAVITYMAIN_CODE as comp_code,'GRAVITY MAIN' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_GRAVITYMAIN_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.GRAVITYMAIN_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.GRAVITYMAIN_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.GRAVITYMAIN_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.GRAVITYMAIN_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.GRAVITYMAIN_CODE,8,3)='"+frm.getVcode()+"'";				
					}else if(frm.getAstSubComp().equals("003")){
						query = "select b.asset_code,b.asset_name,a.DISTRISC_CODE as comp_code,'DISTRIBUTION' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_DISTRI_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.DISTRISC_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.DISTRISC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.DISTRISC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.DISTRISC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.DISTRISC_CODE,8,3)='"+frm.getVcode()+"'";
					}
				}else if(frm.getAstComp().equals("02")){
					if(frm.getAstSubComp().equals("001")){						
						query = "select b.asset_code,b.asset_name,a.RW_COLLWELL_CODE as comp_code,'RAW WATER COLLECTION WELL' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_RW_COLLWELL_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.RW_COLLWELL_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.RW_COLLWELL_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.RW_COLLWELL_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.RW_COLLWELL_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.RW_COLLWELL_CODE,8,3)='"+frm.getVcode()+"'";	
					}else if(frm.getAstSubComp().equals("002")){
						query = "select b.asset_code,b.asset_name,a.SSSC_CODE as comp_code,'SS TANK' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_SS_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.SSSC_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.SSSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.SSSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.SSSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.SSSC_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("003")){
						query = "select b.asset_code,b.asset_name,a.WTPSC_CODE as comp_code,'SS FILTERS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_WTP_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.WTPSC_CODE and substr(a.WTPSC_CODE,20,2)='SS' and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.WTPSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("004")){
						query = "select b.asset_code,b.asset_name,a.WTPSC_CODE as comp_code,'RS FILTERS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_WTP_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.WTPSC_CODE and substr(a.WTPSC_CODE,20,2)='RS' and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.WTPSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,8,3)='"+frm.getVcode()+"'";						
					}else if(frm.getAstSubComp().equals("005")){
						query = "select b.asset_code,b.asset_name,a.SUMPCODE as comp_code,'SUMP' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_SUMP_M_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.SUMPCODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.SUMPCODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.SUMPCODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.SUMPCODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.SUMPCODE,8,3)='"+frm.getVcode()+"'";						
					}else if(frm.getAstSubComp().equals("006")){
						query = "select b.asset_code,b.asset_name,a.BRIDGE_CODE as comp_code,'FOOT PATH BRIDGE' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_FP_BRIDGE_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.BRIDGE_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.BRIDGE_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.BRIDGE_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.BRIDGE_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.BRIDGE_CODE,8,3)='"+frm.getVcode()+"'";						
					}else if(frm.getAstSubComp().equals("007")){
						query = "select b.asset_code,b.asset_name,a.PUMPHOUSE_CODE as comp_code,'PUMP HOUSE' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_PUMPHOUSE_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.PUMPHOUSE_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.PUMPHOUSE_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.PUMPHOUSE_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.PUMPHOUSE_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.PUMPHOUSE_CODE,8,3)='"+frm.getVcode()+"'";							
					}else if(frm.getAstSubComp().equals("008")){
						query = "select b.asset_code,b.asset_name,a.WATCHMAN_CODE as comp_code,'WATCHMAN QUARTER' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_WATCHMAN_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.WATCHMAN_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.WATCHMAN_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.WATCHMAN_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.WATCHMAN_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.WATCHMAN_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("009")){
						query = "select b.asset_code,b.asset_name,a.CW_COLLWELL_CODE as comp_code,'CLEAR WATER COLLECTION WELL' as comp_name,a.location,'' as STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_CW_COLLWELL_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.CW_COLLWELL_CODE and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.CW_COLLWELL_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.CW_COLLWELL_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.CW_COLLWELL_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.CW_COLLWELL_CODE,8,3)='"+frm.getVcode()+"'";
					}else if(frm.getAstSubComp().equals("010")){
						query = "select b.asset_code,b.asset_name,a.WTPSC_CODE as comp_code,'MICRO FILTERS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_WTP_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.WTPSC_CODE and substr(a.WTPSC_CODE,20,2)='MS' and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.WTPSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,8,3)='"+frm.getVcode()+"'";							
					}else if(frm.getAstSubComp().equals("011")){
						query = "select b.asset_code,b.asset_name,a.WTPSC_CODE as comp_code,'ROPLANTS' as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_AST_WTP_SC_PARAM_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.WTPSC_CODE and substr(a.WTPSC_CODE,20,2)='RP' and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.WTPSC_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.WTPSC_CODE,8,3)='"+frm.getVcode()+"'";
					}					
				}else if(frm.getAstComp().equals("01")){
					if(frm.getAstSubComp().equals("001")){
						query = "select b.asset_code,b.asset_name,a.SOURCE_CODE as comp_code,nvl(SOURCE_NAME,'SUBSURFACE SOURCE') as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE "
								+" from RWS_SOURCE_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.SOURCE_CODE and SOURCE_TYPE_CODE='"+frm.getSouType().substring(0, 1)+"' and SUBSOURCE_TYPE_CODE='"+frm.getSouType().substring(2, 3)+"'  and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.SOURCE_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,8,3)='"+frm.getVcode()+"'";						
					}else if(frm.getAstSubComp().equals("002")){
						query = "select b.asset_code,b.asset_name,a.SOURCE_CODE as comp_code,nvl(SOURCE_NAME,'SURFACE SOURCE') as comp_name,a.location,a.STATUS,nvl(c.COMPO_LAT,0) as COMPO_LAT,nvl(c.COMPO_LON,0) as COMPO_LON,dbms_lob.getlength(c.COMPO_IMAGE) as COMPO_IMAGE"
								+" from RWS_SOURCE_TBL a,Rws_Asset_Mast_Tbl b,RWS_ASSET_COMPONENT_IMAGE_TBL c,Rws_Complete_Hab_View e "
								+" where a.asset_code=b.asset_code and C.Asset_Code(+)=a.asset_code and C.Asset_Component(+)= A.SOURCE_CODE and SOURCE_TYPE_CODE='"+frm.getSouType().substring(0, 1)+"' and SUBSOURCE_TYPE_CODE='"+frm.getSouType().substring(2, 3)+"'  and B.Hab_Code=e.Panch_Code";
							if(frm.getDcode()!=null && !frm.getDcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,1,2)='"+frm.getDcode()+"'";
							if(frm.getMcode()!=null && !frm.getMcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,6,2)='"+frm.getMcode()+"'";
							if(frm.getPanchayat()!=null && !frm.getPanchayat().equals(""))	
								query+= " and substr(a.SOURCE_CODE,13,2)='"+frm.getPanchayat()+"'";
							if(frm.getVcode()!=null && !frm.getVcode().equals(""))	
								query+= " and substr(a.SOURCE_CODE,8,3)='"+frm.getVcode()+"'";
					}
				}
			}	
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			while (rs.next()) {						
				rws_functional_repair_frm compList = new rws_functional_repair_frm();
				compList.setAssetCode(rs.getString("asset_code"));
				compList.setAssetName(rs.getString("asset_name"));
				compList.setCompCode(rs.getString("comp_code"));
				compList.setCompName(rs.getString("comp_name"));
				compList.setLocation(rs.getString("location"));
				compList.setStatus(rs.getString("STATUS"));
				compList.setCompLat(rs.getString("COMPO_LAT"));
				compList.setCompLong(rs.getString("COMPO_LON"));
				String RepDateQry="select nvl(status,'') as status,to_char(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_CODE,nvl(REPAIR_COST,0) as REPAIR_COST,nvl(INSPECTED_BY,'') as INSPECTED_BY,nvl(NOT_FUNCTIONAL_STATUS,'') as NOT_FUNCTIONAL_STATUS,nvl(ALT_ARNGMT,'') as ALT_ARNGMT from RWS_ASSET_COMPONENT_REPAIR_TBL where ASSET_CODE='"+rs.getString("asset_code")+"' and ASSET_COMP_CODE='"+rs.getString("comp_code")+"' and update_date=(select max(update_date) from RWS_ASSET_COMPONENT_REPAIR_TBL where ASSET_CODE='"+rs.getString("asset_code")+"' and ASSET_COMP_CODE='"+rs.getString("comp_code")+"')";
				//System.out.println(RepDateQry);
				Statement RepStmt=conn.createStatement();
				ResultSet RepkRs=RepStmt.executeQuery(RepDateQry);
				if(RepkRs.next()){	
					if(rs.getString("STATUS").equals("")){
						compList.setStatus(RepkRs.getString("STATUS"));
					}
					compList.setCompRepairdate(RepkRs.getString("REPAIR_DATE"));
					compList.setCompRepairCode(RepkRs.getString("REPAIR_CODE"));
					compList.setCompRepairCost(RepkRs.getString("REPAIR_COST"));
					compList.setNotFunctionalStatus(RepkRs.getString("NOT_FUNCTIONAL_STATUS"));
					compList.setInspectedBy(RepkRs.getString("INSPECTED_BY"));	
					compList.setAlterArangmts(RepkRs.getString("ALT_ARNGMT"));
				}else{
					compList.setCompRepairdate("");
					compList.setCompRepairCode("");
					compList.setCompRepairCost("0");
					compList.setNotFunctionalStatus("");
					compList.setInspectedBy("");
					compList.setAlterArangmts("");
				}
				int a = rs.getInt("COMPO_IMAGE");
				if(a==0)
					compList.setImgStatus("No");
				else
					compList.setImgStatus("Yes");
				sourcesList.add(compList);
				
			}			
		} catch (Exception e) {
			System.out.println("Exception in getAssetCompList For FunctionalStatus()" + e);
			//e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getAssetCompList For FunctionalStatus Finally" + e);
			}
		}
		return sourcesList;
	}
	
	public void saveFunctionalSatus(rws_functional_repair_frm frm,HttpServletRequest request,String user) {
		ArrayList repairs = new ArrayList();
		Connection conn = null;		
		Statement stmt = null,ps=null,ps1=null;
		ResultSet rs = null;
		String compQuery="";
		try {		
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			if(frm.getAsttype().equals("04")||frm.getAsttype().equals("05")||frm.getAsttype().equals("06") ||frm.getAsttype().equals("08")){
				frm.setAstSubComp("0");
				frm.setAstComp("0");
			}
			String maxIdQry="select max(REPAIR_ID) from RWS_ASSET_COMPONENT_REPAIR_TBL";
			ps = conn.createStatement();
			int id = 0;
			rs=ps.executeQuery(maxIdQry);
			if(rs.next())
				id=rs.getInt(1);	
			rs.close();
			ps.close();
			stmt=conn.createStatement();
			int recCount=0,rscount=0,rs1=0;
			for (int i = 0; i < frm.getSources().size(); i++) {
				//System.out.println("IN LOOP");
				rws_functional_repair_frm soulist = frm.getSources().get(i);
				if (soulist.getChecks() != null && soulist.getChecks().equals("on")) {	
					//System.out.println("soulist.getRepairCode()"+soulist.getCompRepairCode());
					if(soulist.getCompRepairCode()==null || soulist.getCompRepairCode().equals("")){
						soulist.setCompRepairCode("");
					}
					if(soulist.getCompRepairdate()==null)
						soulist.setCompRepairdate("");
					if(soulist.getCompRepairCost()==null)
						soulist.setCompRepairCost("0");
					if(frm.getAsttype().equals("04")){
						compQuery = "update Rws_Hp_Subcomp_Param_Tbl  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and HP_CODE='"+soulist.getCompCode()+"'";									
					}
					else if(frm.getAsttype().equals("05")){
						compQuery = "update RWS_SHALLOWHANDPUMPS_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and SHALLOWHP_CODE='"+soulist.getCompCode()+"'";
					}
					else if(frm.getAsttype().equals("06")){
						compQuery = "update RWS_OPEN_WELL_MAST_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OPENWELL_CODE='"+soulist.getCompCode()+"'";
					}
					else if(frm.getAsttype().equals("08")){
						compQuery = "update RWS_AST_OTHERS_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OTHER_COMP_CODE='"+soulist.getCompCode()+"'";
					}else if( frm.getAsttype().equals("01") || frm.getAsttype().equals("02") || frm.getAsttype().equals("03") || frm.getAsttype().equals("09")){
						if(frm.getAstComp().equals("06")){
							compQuery = "update RWS_AST_SUBCOMP_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and PUMP_CODE='"+soulist.getCompCode()+"'";
						}else if(frm.getAstComp().equals("05")){
							if(frm.getAstSubComp().equals("001")){
								compQuery = "update RWS_AST_OTHERS_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OTHER_COMP_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("002")){
								/*RWS_AST_CHLORINATION_TBL 	*/		
								compQuery = "update RWS_AST_CHLORINATION_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and CL_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("003")){
								/* RWS_AST_OANDM_PARAM_TBL */
								compQuery = "update RWS_AST_OANDM_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OANDMCODE='"+soulist.getCompCode()+"'";
							}
						}else if(frm.getAstComp().equals("04")){
							if(frm.getAstSubComp().equals("001")){
								compQuery = "update RWS_AST_OHSR_SC_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OHSR_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("002")){
								compQuery = "update RWS_AST_OHBR_SC_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and OHBR_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("003")){
								compQuery = "update RWS_AST_GLSR_SC_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and GLSR_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("004")){
								compQuery = "update RWS_AST_GLBR_SC_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and GLBR_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("005")){
								compQuery = "update RWS_AST_CIS_SC_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and CISSC_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("006")){
								compQuery = "update RWS_AST_BPT_PARAM_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and BPT_CODE='"+soulist.getCompCode()+"'";
								/*RWS_AST_BPT_PARAM_TBL*/
							}else if(frm.getAstSubComp().equals("007")){
								compQuery = "update RWS_AST_STANDPOST_TBL  set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and STANDPOST_CODE='"+soulist.getCompCode()+"'";
								/*RWS_AST_STANDPOST_TBL*/
							}						
						}else if(frm.getAstComp().equals("03")){
							if(frm.getAstSubComp().equals("001")){
								compQuery = "update RWS_AST_PUMPINGMAIN_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and PUMPINGMAIN_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("002")){
								compQuery = "update RWS_AST_GRAVITYMAIN_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and GRAVITYMAIN_CODE='"+soulist.getCompCode()+"'";
								/*RWS_AST_GRAVITYMAIN_TBL*/
							}else if(frm.getAstSubComp().equals("003")){
								compQuery = "update RWS_AST_DISTRI_SC_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and DISTRISC_CODE='"+soulist.getCompCode()+"'";
							}
						}else if(frm.getAstComp().equals("02")){
							if(frm.getAstSubComp().equals("001")){	
								compQuery = "update RWS_AST_RW_COLLWELL_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and RW_COLLWELL_CODE='"+soulist.getCompCode()+"'";
								/*RWS_AST_RW_COLLWELL_PARAM_TBL*/
							}else if(frm.getAstSubComp().equals("002")){
								compQuery = "update RWS_AST_SS_SC_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and SSSC_CODE='"+soulist.getCompCode()+"'";
								/*RWS_AST_SS_SC_PARAM_TBL*/
							}else if(frm.getAstSubComp().equals("003")||frm.getAstSubComp().equals("004")||frm.getAstSubComp().equals("010")||frm.getAstSubComp().equals("011")){
								compQuery = "update RWS_AST_WTP_SC_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and WTPSC_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("005")){
								/*RWS_AST_SUMP_M_SC_PARAM_TBL*/
								compQuery = "update RWS_AST_SUMP_M_SC_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and SUMPCODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("006")){
								/*RWS_AST_FP_BRIDGE_PARAM_TBL*/
								compQuery = "update RWS_AST_FP_BRIDGE_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and BRIDGE_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("007")){
								compQuery = "update RWS_AST_PUMPHOUSE_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and PUMPHOUSE_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("008")){
								/*RWS_AST_WATCHMAN_PARAM_TBL*/
								compQuery = "update RWS_AST_WATCHMAN_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and WATCHMAN_CODE='"+soulist.getCompCode()+"'";
							}else if(frm.getAstSubComp().equals("009")){
								/*RWS_AST_CW_COLLWELL_PARAM_TBL*/
								compQuery = "update RWS_AST_CW_COLLWELL_PARAM_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and CW_COLLWELL_CODE='"+soulist.getCompCode()+"'";
							}				
						}else if(frm.getAstComp().equals("01")){
							if(frm.getAstSubComp().equals("001")||frm.getAstSubComp().equals("002")){
								compQuery = "update RWS_SOURCE_TBL set STATUS='"+soulist.getStatus()+"' where ASSET_CODE='"+soulist.getAssetCode()+"' and SOURCE_CODE='"+soulist.getCompCode()+"'";
							}
						}
					}				
					if(!compQuery.equals("")){				
							stmt.addBatch(compQuery);
							//System.out.println(compQuery);
							recCount++;
							/*rs1=stmt.executeUpdate(compQuery);
							if(rs1!=0)
								rscount++;*/
							
					}	
					/*stmt.close();
					stmt=conn.createStatement();*/
					if(!isExistCompInFunctionalSataus(soulist.getAssetCode(),soulist.getCompCode(),soulist.getCompRepairCode(),soulist.getCompRepairCost(),soulist.getCompRepairdate())){
						id=id+1;
						String insertQuery = "insert into Rws_Asset_Component_Repair_Tbl(ASSET_CODE,COMP_SUBCOMP_CODE,ASSET_COMP_CODE,STATUS,REPAIR_CODE,REPAIR_COST,REPAIR_DATE,UPDATE_DATE,PREPARED_BY,REPAIR_ID,INSPECTED_BY,NOT_FUNCTIONAL_STATUS,ALT_ARNGMT) values('"+soulist.getAssetCode()+"','"+frm.getAstComp().trim()+frm.getAstSubComp().trim()+"','"+soulist.getCompCode()+"','"+soulist.getStatus()+"','"+soulist.getCompRepairCode()+"','"+soulist.getCompRepairCost()+"',to_date('"+soulist.getCompRepairdate()+"','dd/mm/yyyy'),sysdate,'"+user+"','"+id+"','"+soulist.getInspectedBy()+"','"+soulist.getNotFunctionalStatus()+"','"+soulist.getAlterArangmts()+"')";
						stmt.addBatch(insertQuery);
						recCount++;
					}
					//stmt.close();
				}					
			}
			int res[] = stmt.executeBatch();
			stmt.close();		
		//System.out.println(res.length+"  "+recCount );
			//if (recCount!=0 && rscount!=0 && recCount==rscount ){
			if (res.length==recCount ){
				request.setAttribute("message", " Records Inserted Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}		
		} catch (Exception e) {
			System.out.println("Exception in saveFunctionalSatus()" + e);
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in saveFunctionalSatus Finally" + e);
			}
		}		
	}
	
	public boolean isExistCompInFunctionalSataus(String asset,String comp,String repairCode,String repairCost,String repairDate){
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String qry="select ASSET_CODE,ASSET_COMP_CODE,REPAIR_CODE,REPAIR_COST from Rws_Asset_Component_Repair_Tbl where ASSET_CODE=? and ASSET_COMP_CODE=? and REPAIR_CODE=? and  REPAIR_COST=? and REPAIR_DATE=?";
		try {
			conn = RwsOffices.getConn();
			stmt=conn.prepareStatement(qry);
			stmt.setString(1, asset);
			stmt.setString(2, comp);
			stmt.setString(3, repairCode);
			stmt.setString(4, repairCost);
			stmt.setString(5, repairDate);			
			rs=stmt.executeQuery();
			if(rs.next()){				
				return true;
			}
		} catch (Exception e) {
			System.out.println("Exception in isExistCompInFunctionalSataus()" + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null){
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExistCompInFunctionalSataus Finally" + e);
			}
		}		
		return false;
	}
	
	public String deleteRepairAssetCompLink(String astType,String astComp,String repairType,String souType) {
		Connection conn = null;		
		PreparedStatement stmt = null;
		int count = 0;
		String message="",query="";
		try {
			conn = RwsOffices.getConn();
			if(!isExistInComponentRepairStatus(astType,astComp,repairType,souType)){				
					query = "delete from Rws_Asset_Repair_Lnk_Tbl where ASSET_TYPE_CODE='"+astType+"' and repair_code='"+repairType+"'";
				 if(!astComp.equals("-") ){
					query +=" and ASSET_COMPONENT_CODE='"+astComp+"' ";
				}if(!souType.equals("-")){
					query += " and SOURCE_COMPONENT_CODE='"+souType+"' ";
				}			
			stmt = conn.prepareStatement(query);					
			count = stmt.executeUpdate();
			}
			else{
				return "Can not be deleted";
			}
			if(count>0){
				message="Deleted Successfully";
			}
			return message;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Functional_Status_Dao deleteRepairAssetCompLink() : " + e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Functional_Status_Dao deleteRepairAssetCompLink() Finally : " + e.getMessage());
			}
		}
		return message;
	}
	private boolean isExistInComponentRepairStatus(String astType, String astComp,String repairType,String souType) {
		Connection conn = null;
		Statement stmt = null,stmt1=null;
		ResultSet rset=null,rset1=null;
		String query1="";
		try{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
		/*	if(astComp.equals("-")&& souType.equals("-")){*/
			
				query1 = "select * from RWS_ASSET_COMPONENT_REPAIR_TBL where substr(ASSET_CODE,7,2)='"+astType+"' and REPAIR_CODE='"+repairType+"'";
			 if(!astComp.equals("-")){
				query1 += " and substr(COMP_SUBCOMP_CODE,1,2)='"+astComp+"' ";
			} 
			 if(!souType.equals("-")){
				query1 = "select * from RWS_ASSET_COMPONENT_REPAIR_TBL a,rws_source_tbl b where a.asset_code=b.asset_code and a.ASSET_COMP_CODE=b.source_code and substr(a.ASSET_CODE,7,2)='"+astType+"' and a.REPAIR_CODE='"+repairType+"' and substr(COMP_SUBCOMP_CODE,1,2)='"+astComp+"' and SOURCE_TYPE_CODE='"+souType.substring(0, 1)+"' and SUBSOURCE_TYPE_CODE='"+souType.substring(2,3)+"'";
			}
		//	System.out.println(query1);
			 rset=stmt.executeQuery(query1);
			if(rset.next()){				
				return true;
			}			
		}
		catch (Exception e) {
			System.out.println("Exception in isExistInComponentRepairStatus()"+e);
			//e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println(" isExist in Closing ");
			}
		}
		return false;
	}
}