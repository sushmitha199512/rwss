package nic.watersoft.reports;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;

public class RwsGeoTaggingFormatDownloaderDAO {
	List<String> filesListInDir = new ArrayList<String>();
	private String query = null;
	private PreparedStatement ps;
	public static String errorMessage;
	public ArrayList getDistrictDetails() {
		ArrayList distList = new ArrayList();
		String query = "";
		Connection conn = null;
		ResultSet rset = null;
		Rws_Asset_FormBean formBean=null;
		try {
			conn = RwsOffices.getConn();			
			query="select dcode,dname from rws_district_tbl";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				formBean=new Rws_Asset_FormBean();
				formBean.setDistrictcode(rset.getString("dcode"));
				formBean.setDistrictname(rset.getString("dname"));
				distList.add(formBean);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getDistrictDetails : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					ps.close();
					rset.close();
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getDistrictDetails : " + e.getMessage());
				}
			}
		}
		return distList;
	}
	public void download(String fileURL, String destinationDirectory,String Filename) throws IOException {
        String downloadedFileName = Filename;
        URL url = new URL(fileURL);
        InputStream is = url.openStream();
        FileOutputStream fos = new FileOutputStream(destinationDirectory + "/" + downloadedFileName);	        
        byte[] buffer = new byte[4096];
        int bytesRead = 0;
        while ((bytesRead = is.read(buffer)) != -1) {
            fos.write(buffer,0,bytesRead);
        }	      
        fos.close();
        is.close();
	}   
	
	public ArrayList getImagesBasedOnDistrictDetails(Rws_Asset_FormBean formBean,HttpServletRequest request) {
		ArrayList<Rws_Asset_FormBean> distList = new ArrayList<Rws_Asset_FormBean>();
		String query = "";
		Connection conn = null;
		ResultSet rset = null;
		PreparedStatement preparedStatement=null;
		Rws_Asset_FormBean formBean1=null;		
		String filepath = "", filename = "",filename1="",filenames="";		
		try {
			conn = RwsOffices.getConn();
			String zipFileName=formBean.getDistrictname();
			int i=1;
			File file = null;
			File files=null;
			File file1=null;
			filepath = request.getSession().getServletContext().getRealPath("/")+ "AssetImages";
			filename = filepath + File.separator +  formBean.getDistrictname();
			filename1 = filepath + File.separator +  formBean.getDistrictname()+ File.separator+"IMAGES";				
			file = new File(filename);
			if (!file.exists()) {
				file.mkdir();
			} else {
				String[]entries = file.list();
				for(String s: entries){
				    File currentFile = new File(file.getPath(),s);
				    currentFile.delete();				    
				}
				if (!file.exists()) {
					file.mkdir();
				}
			}
			 file1 = new File(filename1);
			 if (!file1.exists()) {
				file1.mkdir();
			 }
			 else {
				 String[]entries = file1.list();
				 for(String s: entries){
					  File currentFile = new File(file1.getPath(),s);
					  currentFile.delete();					    
				  }
				  if (!file1.exists()) {
					file1.mkdir();
				  }
			}
			filenames = filepath + File.separator +  formBean.getDistrictname()+ File.separator+"MDB FILE";	
			files = new File(filenames);
			if (!files.exists()) {
				files.mkdir();
			} else {
				String[]entries = files.list();
				for(String s: entries){
				    File currentFile = new File(files.getPath(),s);
				    currentFile.delete();				    
				}
				if (!files.exists()) {
					files.mkdir();
				}
			}
			String db=filenames+File.separator+"AssetGEOTagging.mdb";
			Database database = Rws_Mpr_Access_DAO.createDatabase(db);			
			RwsGeoTaggingFormatDownloaderDAO geoTagDAO=new RwsGeoTaggingFormatDownloaderDAO();		
			boolean flag1=false,flag2=false,flag3=false;
			//flag3 = geoTagDAO.createAssetGeoTagging(formBean, conn);
			if (database != null) {
				flag2 = geoTagDAO.writeAssetCompImagesDataWithIMISIds(database,formBean);
			}
			
			query="select distinct a.COMPO_IMAGE,ASSET_COMPONENT from rws_asset_component_image_tbl a,ASSET_GEO_TAGGING_DATA b where a.ASSET_CODE=b.SCHEMEID_STATE and a.ASSET_COMPONENT=b.SCHEMESSOURCESID_STATE and dcode= ?  ";
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, formBean.getDistrictcode());
			
			System.out.println(query);
			rset = preparedStatement.executeQuery();
			
			if(!rset.isBeforeFirst()){}
			else{
				while (rset.next()) {
					if(rset.getBlob("COMPO_IMAGE")!=null){
						formBean1=new Rws_Asset_FormBean();
						Blob b=rset.getBlob("COMPO_IMAGE");
						String ComponentName=rset.getString("ASSET_COMPONENT");
						byte barr[]=b.getBytes(1,(int)b.length());
					    FileOutputStream fout=new FileOutputStream(file1+"\\"+ComponentName+".jpg"); 				
					    fout.write(barr);  				            
					    fout.close(); 				
					    i++;
					}				 
					distList.add(formBean1);
				}
			}
			preparedStatement.close();
			rset.close();	
			filepath=request.getSession().getServletContext().getRealPath("/");
			File dir = new File(filepath + File.separator + "AssetImages"+File.separator+zipFileName);			
	        String zipDirName =filepath + File.separator + zipFileName + ".zip";
	        RwsGeoTaggingFormatDownloaderDAO zipFiles = new RwsGeoTaggingFormatDownloaderDAO();	        		
            zipFiles.zipDirectory(dir, zipDirName);
            File directory = new File(filepath + File.separator + "AssetImages");
            if(!directory.exists() || !flag1 ){}
            else{
	            	 database.flush();
	            	 database.close();
	                 rmdir(directory);
             }    
		} catch (Exception e) {
			System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getImagesBasedOnDistrictDetails : " + e.getMessage());
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getImagesBasedOnDistrictDetails : " + e.getMessage());
				}
			}
		}
		return distList;
	}
	
	 public static void delete(File file) throws IOException{
    	if(file.isDirectory()){
    		if(file.list().length==0){
    		   file.delete();
    		}else{
        	   String files[] = file.list();
        	   for (String temp : files) {
        	      File fileDelete = new File(file, temp);
        	      delete(fileDelete);
        	   }
        	   if(file.list().length==0){
           	     file.delete();
        	   }
    		}
    	}else{
    		file.delete();
    	}
	}
	private void zipDirectory(File dir, String zipDirName) {
        try {
            populateFilesList(dir);
            FileOutputStream fos = new FileOutputStream(zipDirName);
            ZipOutputStream zos = new ZipOutputStream(fos);
            for(String filePath : filesListInDir){
                ZipEntry ze = new ZipEntry(filePath.substring(dir.getAbsolutePath().length()+1, filePath.length()));
                zos.putNextEntry(ze);
                FileInputStream fis = new FileInputStream(filePath);
                byte[] buffer = new byte[1024];
                int len;
                while ((len = fis.read(buffer)) > 0) {
                    zos.write(buffer, 0, len);
                }
                zos.closeEntry();
                fis.close();
            }
            zos.close();
            fos.close();
        } catch (IOException e) {
            System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO zipDirectory : " + e.getMessage());
        }
    }
	
	public static void rmdir(final File folder) {
		if (folder.isDirectory()) {
			File[] list = folder.listFiles();
			if (list != null) {
				for (int i = 0; i < list.length; i++) {
                  File tmpF = list[i];	                 
                  if (tmpF.isDirectory()) {
                      rmdir(tmpF);
                  }	                  
                  tmpF.delete();
				}
			}
		}	     
	}
	
	private void populateFilesList(File dir) throws IOException {
        File[] files = dir.listFiles();
        for(File file : files){
            if(file.isFile()) 
            	filesListInDir.add(file.getAbsolutePath());
            else populateFilesList(file);
        }
    }
	
	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}
	
		
	public boolean writeAssetCompImagesDataWithIMISIds(Database database,Rws_Asset_FormBean formbean) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		Connection conn=null;
		try {
			//System.out.println("in dta");
			conn = RwsOffices.getConn();
			String tableName = "RwsGEOTaggingAssetsFormat";
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SCHEMEID").setSQLType(Types.VARCHAR).toColumn()).addColumn(	
				new ColumnBuilder("STATE_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DISTRICT_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("BLOCK_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("PANCHAYAT_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("VILLAGE_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HABITATION_ID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HABITATION_NAME").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HABITATIONID_STATE").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SCHEMEID_STATE").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SCHEME_NAME").setSQLType(Types.LONGVARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SCHEMESSOURCESID").setSQLType(Types.VARCHAR).toColumn()).addColumn(	
				new ColumnBuilder("SCHEMESOURCESID_STATE").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ISFUNCTION").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("LATITUDE").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("LONGITUDE").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("SURVEY_DATE_TIME").setSQLType(Types.DATE).toColumn()).addColumn(
				new ColumnBuilder("IMAGES_PATH").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			String query="SELECT distinct SCHEMEID,trim(statename),trim(DistrictName),trim(blockname),trim(panchayatname),trim(villagename),trim(HABITATIONID),trim(habitationname),trim(Habitationid_State),trim(SchemeId_State),trim(Schemename),SCHEMESSOURCESID,trim(SchemesSourcesId_state),trim(ISFUNCTIONAL),Latitude,Longitude,SurveyDateandTime,SchemesSourcesId_state from ASSET_GEO_TAGGING_DATA where dcode=?";
			st = conn.prepareStatement(query);
			st.setString(1, formbean.getDistrictcode());
			rs = st.executeQuery();
			String distname=formbean.getDistrictname();
			flag = RwsProjectShelfDAO.importResultSetForGeoTagging(rs, table1,distname);
			if(flag){}
		} catch (Exception e) {
			System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO writeAssetCompImagesDataWithIMISIds : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO writeAssetCompImagesDataWithIMISIds : " + e.getMessage());
			}
		}
		return flag;
	}	
	
	public static void recursiveDelete(File file) {
        if (!file.exists())
            return;
        if (file.isDirectory()) {
            for (File f : file.listFiles()) {
                recursiveDelete(f);
            }
        }
        file.delete();
    }
	
	public String getDistrictDetails(String pp) {
		String distCode=null;
		String query = "";
		Connection conn = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();					
			query="select dcode from rws_district_tbl where dname= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, pp);
			rset = ps.executeQuery();
			while (rset.next()) {
				distCode=rset.getString("dcode");
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getDistrictDetails : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					ps.close();
					rset.close();
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getDistrictDetails : " + e.getMessage());
				}
			}
		}
		return distCode;
	}
	
	public boolean isExistData(Rws_Asset_FormBean formBean) {
		Connection conncheck = null;
		ResultSet rsetcheck = null;
		PreparedStatement pscheck=null;
		boolean checkmessage=false;
		try {
			conncheck = RwsOffices.getConn();
			query="select * from RWS_ASSET_COMPONENT_IMAGE_TBL a,RWS_ASSET_MAST_TBL b where a.ASSET_CODE=b.ASSET_CODE and substr(a.ASSET_CODE,5,2)= ? and  substr(ASSET_COMPONENT,1,2)= ?  ";
			pscheck = conncheck.prepareStatement(query);
			pscheck.setString(1, formBean.getDistrictcode());
			pscheck.setString(2, formBean.getDistrictcode());
			rsetcheck = pscheck.executeQuery();			
			if(rsetcheck.next()){
				checkmessage=true;
			}
			else {
				checkmessage=false;
			}
		}catch(Exception e)	{
			System.out.println("The Exception is in the RwsGeoTaggingFormatDownloaderDAO getTotalList : " + e.getMessage());
		}
		return checkmessage;
	}
	
	public boolean createAssetGeoTagging(Connection conn) {
		boolean finflag = true;
		ResultSet rs1 = null,resultSet=null;
		PreparedStatement stmt1=null, st9 = null,pstmt=null;
		try {
			isTableExists("ASSET_GEO_TAGGING_DATA", conn, "CREATE table ASSET_GEO_TAGGING_DATA(statename varchar2(50),Dcode varchar2(2),DistrictName varchar2(50),blockname varchar2(32),"
					+ "panchayatname varchar2(40),villagename varchar2(40),Habitationid_State varchar2(16),Habitationid varchar2(15),habitationname varchar2(50),"
					+ "SchemeId_State varchar2(14),type_of_asset varchar2(2),SchemeId varchar(16),Schemename varchar2(150),SchemesSourcesId_state varchar2(24),SchemesSourcesId varchar2(14),"
					+ "IsFunctional varchar2(15),Latitude NUMBER(12,8),Longitude NUMBER(12,8), SurveyDateandTime Date)");
			String Query2 = "",Query3="";int recCount=0;
			
			Query2 = "insert into ASSET_GEO_TAGGING_DATA(statename,Dcode,DistrictName,blockname,panchayatname,villagename,Habitationid_State,habitationname,SchemeId_State,"
					+ "Schemename,IsFunctional,type_of_asset) "
					+ "(select distinct  'ANDHRA PRADESH' as StateName,c.Dcode,c.DNAME as DistrictName,c.MNAME as blockname,c.PNAME as panchayatname,c.VNAME as villagename,"
					+ "c.PANCH_CODE as Habitationid_State,c.PANCH_NAME as habitationname,a.ASSET_CODE as SchemeId_State,b.ASSET_NAME as Schemename,(case when d.asset_status='1' then 'YES' else 'NO' end) as  IsFunctional,b.type_of_asset_code as type_of_asset"
					+ " from RWS_ASSET_COMPONENT_IMAGE_TBL a,RWS_ASSET_MAST_TBL b,RWS_COMPLETE_HAB_VIEW c,RWS_AST_ALL_COMP_ALL_IMG_VIEW d where "
					+ " a.ASSET_CODE=d.ASSET_CODE and a.ASSET_COMPONENT=d.SOURCE_CODE and a.ASSET_CODE=b.ASSET_CODE and b.HAB_CODE=c.PANCH_CODE )";
			System.out.println(Query2);
			stmt1 = conn.prepareStatement(Query2);
			recCount= stmt1.executeUpdate();
			stmt1.close();
			Query3="update ASSET_GEO_TAGGING_DATA  a set a.HABITATIONID=(select nvl(b.HABITATIONID,'-') from IMISMASTERDATA1 b where  b.habcode=a.Habitationid_State)";
			stmt1 = conn.prepareStatement(Query3);
			stmt1.executeUpdate();
			stmt1.close();
			Statement stmt=null;
			Query2="select SCHEMEID_STATE from ASSET_GEO_TAGGING_DATA ";
			stmt1 = conn.prepareStatement(Query2);
		//	System.out.println("Query2");
			rs1=stmt1.executeQuery();
			while(rs1.next())
			{
				String schemeSource="select STANDPOST_CODE,c.compo_lat,c.compo_lon,c.update_date from RWS_AST_STANDPOST_TBL b,RWS_ASSET_COMPONENT_IMAGE_TBL c where b.asset_code=c.asset_code and b.STANDPOST_CODE=c.asset_component and b.asset_code=? ";
				pstmt=conn.prepareStatement(schemeSource);
			//	System.out.println("schemeSource");
				pstmt.setString(1, rs1.getString("SCHEMEID_STATE"));
				resultSet= pstmt.executeQuery();
				if(resultSet.next()) {
			//		System.out.println("query2");
					Query3="update ASSET_GEO_TAGGING_DATA  a set SchemesSourcesId_state=?,Latitude=?,Longitude=?,SurveyDateandTime=? where SCHEMEID_STATE=? ";
					st9= conn.prepareStatement(Query3);
					st9.setString(1, resultSet.getString("STANDPOST_CODE"));
					st9.setString(2, resultSet.getString("compo_lat"));
					st9.setString(3, resultSet.getString("compo_lon"));
					st9.setDate(4, resultSet.getDate("update_date"));
					st9.setString(5, rs1.getString("SCHEMEID_STATE"));
					st9.executeUpdate();
					st9.close();
				}
				pstmt.close();
				resultSet.close();
			}
			stmt1.close();
			rs1.close();
			
			Query2="select SCHEMEID_STATE from ASSET_GEO_TAGGING_DATA where  SchemesSourcesId_state is null or SchemesSourcesId_state='' AND TYPE_OF_ASSET IN ('04','05','06','07','08')";
			stmt1 = conn.prepareStatement(Query2);
			//System.out.println("Query2");
			rs1=stmt1.executeQuery();
			while(rs1.next())
			{
				String schemeSource="select  source_code,b.compo_lat,b.compo_lon,b.update_date from RWS_AST_ALL_COMP_ALL_IMG_VIEW a,RWS_ASSET_COMPONENT_IMAGE_TBL b where a.asset_code=? and a.asset_code=b.asset_code and a.source_code=b.asset_component ";
				pstmt=conn.prepareStatement(schemeSource);
			//	System.out.println("schemeSource");
				pstmt.setString(1, rs1.getString("SCHEMEID_STATE"));
				resultSet= pstmt.executeQuery();
				if(resultSet.next()) {
				//	System.out.println("query2");
					Query3="update ASSET_GEO_TAGGING_DATA  a set SchemesSourcesId_state=?,Latitude=?,Longitude=?,SurveyDateandTime=? where SCHEMEID_STATE=? ";
					st9= conn.prepareStatement(Query3);
					st9.setString(1, resultSet.getString("SOURCE_CODE"));
					st9.setString(2, resultSet.getString("compo_lat"));
					st9.setString(3, resultSet.getString("compo_lon"));
					st9.setDate(4, resultSet.getDate("update_date"));
					st9.setString(5, rs1.getString("SCHEMEID_STATE"));
					st9.executeUpdate();
					st9.close();
				}
				pstmt.close();
				resultSet.close();
			}
			stmt1.close();
			rs1.close();

			Query2="select SCHEMEID_STATE from ASSET_GEO_TAGGING_DATA where  SchemesSourcesId_state is null or SchemesSourcesId_state=''";
			stmt1 = conn.prepareStatement(Query2);
		//	System.out.println("Query2");
			rs1=stmt1.executeQuery();
			while(rs1.next())
			{
				String schemeSource="select case when source_name='OHSR@' then source_code when source_name='GLSR@' then source_code " + 
						"when source_name='OHBR@' then source_code " + 
						"when source_name='GLBR@' then source_code else '' end as source_code,b.compo_lat,b.compo_lon,b.update_date from RWS_AST_ALL_COMP_ALL_IMG_VIEW a,RWS_ASSET_COMPONENT_IMAGE_TBL b where a.asset_code=? and typename ='SR.RESERVOIRS' and a.asset_code=b.asset_code and a.source_code=b.asset_component ";
				pstmt=conn.prepareStatement(schemeSource);
			//	System.out.println("schemeSource");
				pstmt.setString(1, rs1.getString("SCHEMEID_STATE"));
				resultSet= pstmt.executeQuery();
				if(resultSet.next()) {
					//System.out.println("query2");
					Query3="update ASSET_GEO_TAGGING_DATA  a set SchemesSourcesId_state=?,Latitude=?,Longitude=?,SurveyDateandTime=? where SCHEMEID_STATE=? ";
					st9= conn.prepareStatement(Query3);
					st9.setString(1, resultSet.getString("SOURCE_CODE"));
					st9.setString(2, resultSet.getString("compo_lat"));
					st9.setString(3, resultSet.getString("compo_lon"));
					st9.setDate(4, resultSet.getDate("update_date"));
					st9.setString(5, rs1.getString("SCHEMEID_STATE"));
					st9.executeUpdate();
					st9.close();
				}
				pstmt.close();
				resultSet.close();
			}
			stmt1.close();
			rs1.close();

			Query2="select SCHEMEID_STATE from ASSET_GEO_TAGGING_DATA where  SchemesSourcesId_state is null or SchemesSourcesId_state=''";
			stmt1 = conn.prepareStatement(Query2);
			//System.out.println("Query2");
			rs1=stmt1.executeQuery();
			while(rs1.next())
			{
				String schemeSource="select  source_code,b.compo_lat,b.compo_lon,b.update_date from rws_source_tbl a,RWS_ASSET_COMPONENT_IMAGE_TBL b where a.asset_code=? and a.asset_code=b.asset_code and a.source_code=b.asset_component ";
				pstmt=conn.prepareStatement(schemeSource);
				//System.out.println("schemeSource");
				pstmt.setString(1, rs1.getString("SCHEMEID_STATE"));
				resultSet= pstmt.executeQuery();
				if(resultSet.next()) {
					//System.out.println("query2");
					Query3="update ASSET_GEO_TAGGING_DATA  a set SchemesSourcesId_state=?,Latitude=?,Longitude=?,SurveyDateandTime=? where SCHEMEID_STATE=? ";
					st9= conn.prepareStatement(Query3);
					st9.setString(1, resultSet.getString("SOURCE_CODE"));
					st9.setString(2, resultSet.getString("compo_lat"));
					st9.setString(3, resultSet.getString("compo_lon"));
					st9.setDate(4, resultSet.getDate("update_date"));
					st9.setString(5, rs1.getString("SCHEMEID_STATE"));
					st9.executeUpdate();
					st9.close();
				}
				pstmt.close();
				resultSet.close();
			}
			stmt1.close();
			rs1.close();
	//		System.out.println("rescount"+recCount+"      "+habCount);
			if(recCount>0)
				finflag = true;
		/*	if (recCount.length == rec) {
				finflag = true;
			}*/
		} catch (Exception e) {
			System.out.println("The Exception at createAssetGeoTagging in RwsGeoTaggingFormatDownloaderDAO : "+e.getMessage());
			e.printStackTrace();
		}
		finally{
			try{
				if(rs1 != null)					
					rs1.close();
				if(stmt1 != null)					
					stmt1.close();
				if(st9 != null)					
					st9.close();
			} catch (Exception e) {
				System.out.println("The Exception at Finally block of createAssetComponentsWithIMISData in RwsGeoTaggingFormatDownloaderDAO : "+e.getMessage());
			}
		}
		return finflag;
	}
	
	private void isTableExists(String tableName, Connection conn, String tableQuery) throws SQLException {PreparedStatement stmt =null,pstmt=null;
	ResultSet rs7 =null;
	try {
		String qry7 = "Select tname from tab where tname like ? ";
		stmt = conn.prepareStatement(qry7);
		stmt.setString(1, tableName);
		rs7 = stmt.executeQuery();
		if (!rs7.next()) {
			pstmt =  conn.prepareStatement(tableQuery);
			pstmt.executeUpdate();
		} else {
			String qry8 ="DELETE FROM "+tableName;			
			pstmt =  conn.prepareStatement(qry8);
			pstmt.executeUpdate();
		}
	}catch (Exception e) {
		System.out.println("The Exception at isTableExists in RwsGeoTaggingFormatDownloaderDAO : "+e.getMessage());
	}finally {
		if (stmt != null) {
			stmt.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (rs7 != null) {
			rs7.close();
		}
	}}
}
