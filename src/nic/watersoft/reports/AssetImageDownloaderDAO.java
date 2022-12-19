package nic.watersoft.reports;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;









import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JFrame;
import javax.swing.JProgressBar;
import javax.swing.border.Border;












import org.apache.catalina.Context;
import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.reports.RwsHashTable;
import nic.watersoft.reports.RwsProjectShelfDAO;

public class AssetImageDownloaderDAO {
	List<String> filesListInDir = new ArrayList<String>();
	private String query = null;
	private PreparedStatement ps;
	private  PreparedStatement ps1;
	private  PreparedStatement ps2;
	private Connection conn;
	private LabelValueBean labelValueBean = null;
	public static String errorMessage;
	private ResultSet rset = null;
	public ArrayList getDistrictDetails() {
		ArrayList distList = new ArrayList();
		String query = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null,rs=null;
		PreparedStatement preparedStatement=null;
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
			System.out.println("The Exception is in the AssetImageDownloaderDAO getDistrictDetails : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					ps.close();
					rset.close();
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the AssetImageDownloaderDAO getDistrictDetails : " + e.getMessage());
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
		ResultSet rset = null,rs=null;
		PreparedStatement preparedStatement=null;
		Rws_Asset_FormBean formBean1=null;		
		String filepath = "", filename = "",filename1="",filenames="",filenames1="";		
		try {
			conn = RwsOffices.getConn();
			String fromDate=formBean.getFromDate();
			String toDate=formBean.getToDate();
			SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat format2 = new SimpleDateFormat("dd-MMM-yy");
			Date dateS = (Date) format1.parse(fromDate);
			Date datet=(Date)format1.parse(toDate);
			String zipFileName=formBean.getDistrictname();
			String fromdates=format2.format(dateS);
			String todates= format2.format(datet);
			query="select * from rws_asset_component_image_tbl where substr(ASSET_CODE,5,2)= ? and  substr(ASSET_COMPONENT,1,2)= ? and to_date(UPDATE_DATE,'dd-MM-yy') between  ? and  ? ";
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, formBean.getDistrictcode());
			preparedStatement.setString(2, formBean.getDistrictcode());
			preparedStatement.setString(3, fromdates);
			preparedStatement.setString(4, todates);
			rset = preparedStatement.executeQuery();
			int i=1;
			File file = null;
			File files=null;
			File file1=null;
			if(!rset.isBeforeFirst()){}
			else{			
				filepath = request.getSession().getServletContext().getRealPath("/")+ "AssetImages";
				File test=new File(filepath);			
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
				filenames = filepath + File.separator +  formBean.getDistrictname()+ File.separator+"MS-ACCESS DATABASE";	
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
				String db=filenames+File.separator+"AssetComponentImages.mdb";
				Database database = Rws_Mpr_Access_DAO.createDatabase(db);			
				AssetImageDownloaderDAO assetImageDownloaderDAO=new AssetImageDownloaderDAO();			
				boolean	flag4 = assetImageDownloaderDAO.writeFinancialMPR(database,formBean);
				filepath=request.getSession().getServletContext().getRealPath("/");
				File dir = new File(filepath + File.separator + "AssetImages"+File.separator+zipFileName);			
		        String zipDirName =filepath + File.separator + zipFileName + ".zip";
		        AssetImageDownloaderDAO zipFiles = new AssetImageDownloaderDAO();	        		
	            zipFiles.zipDirectory(dir, zipDirName);
	            File directory = new File(filepath + File.separator + "AssetImages");
	            if(!directory.exists()){}
	            else{
		            	 database.flush();
		            	 database.close();
		                 rmdir(directory);
	             }    
			}
			preparedStatement.close();
			rset.close();
					
		} catch (Exception e) {
			System.out.println("The Exception is in the AssetImageDownloaderDAO getImagesBasedOnDistrictDetails : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the AssetImageDownloaderDAO getImagesBasedOnDistrictDetails : " + e.getMessage());
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
            System.out.println("The Exception is in the AssetImageDownloaderDAO zipDirectory : " + e.getMessage());
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
	
	public boolean writeFinancialMPR(Database database,Rws_Asset_FormBean formbean) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		Connection conn=null;
		try {
			conn = RwsOffices.getConn();
			String tableName = "rwsassetcomponentimagetbl";
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("ASSET_CODE").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ASSET_COMPONENT").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("COMPO_LAT").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("COMPO_LON").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("UPDATE_DATE").setSQLType(Types.DATE).toColumn()).addColumn(
				new ColumnBuilder("IMAGES_PATH").setSQLType(Types.VARCHAR).toColumn()).toTable(database);			
			String fromdate=formbean.getFromDate();
			String todate=formbean.getToDate();
			SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat format2 = new SimpleDateFormat("dd-MMM-yy");
			Date dateS = (Date) format1.parse(fromdate);
			Date datet=(Date)format1.parse(todate);
			String fromdates=format2.format(dateS);
			String todates= format2.format(datet);
			String dcode=formbean.getDistrictcode();
			String query="SELECT ASSET_CODE,ASSET_COMPONENT,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI FROM rws_asset_component_image_tbl where substr(ASSET_CODE,5,2)= ? and  substr(ASSET_COMPONENT,1,2)= ? and to_date(UPDATE_DATE,'dd-MM-yy') between ? and  ? ";
			/*"SELECT ASSET_CODE,ASSET_COMPONENT,COMPO_LAT,COMPO_LON,UPDATE_DATE,ASSET_COMPONENT FROM rws_asset_component_image_tbl where substr(ASSET_CODE,5,2)='"+dcode+"' and  substr(ASSET_COMPONENT,1,2)='"+dcode+"' and to_date(UPDATE_DATE,'dd-MM-yy') between '"+fromdates+"' and '"+todates+"'"*/
			st = conn.prepareStatement(query);
			st.setString(1, dcode);
			st.setString(2, dcode);
			st.setString(3, fromdates);
			st.setString(4, todates);
			rs = st.executeQuery();
			String distname=formbean.getDistrictname();
			flag = RwsProjectShelfDAO.importResultSet1(rs, table1,distname);
			if(flag){}
		} catch (Exception e) {
			System.out.println("The Exception is in the AssetImageDownloaderDAO writeFinancialMPR : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in the AssetImageDownloaderDAO writeFinancialMPR : " + e.getMessage());
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
		String distList=null;
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null,rs=null;
		PreparedStatement preparedStatement=null;
		Rws_Asset_FormBean formBean=null;
		try {
			conn = RwsOffices.getConn();					
			query="select dcode from rws_district_tbl where dname= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, pp);
			rset = ps.executeQuery();
			while (rset.next()) {
				distList=rset.getString("dcode");
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in the AssetImageDownloaderDAO getDistrictDetails : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					ps.close();
					rset.close();
					conn.close();
				} catch (SQLException e) {
					System.out.println("The Exception is in the AssetImageDownloaderDAO getDistrictDetails : " + e.getMessage());
				}
			}
		}
		return distList;
	}
	
	public boolean getTotalList(Rws_Asset_FormBean formBean) {
		Connection conncheck = null;
		ResultSet rsetcheck = null;
		PreparedStatement pscheck=null;
		boolean checkmessage=false;
		try {
			conncheck = RwsOffices.getConn();
			String fromDate=formBean.getFromDate();
			String toDate=formBean.getToDate();
			SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
			SimpleDateFormat format2 = new SimpleDateFormat("dd-MMM-yy");
			Date dateS = (Date) format1.parse(fromDate);
			Date datet=(Date)format1.parse(toDate);
			String fromdates=format2.format(dateS);
			String todates= format2.format(datet);
			query="select * from rws_asset_component_image_tbl where substr(ASSET_CODE,5,2)= ? and  substr(ASSET_COMPONENT,1,2)= ? and to_date(UPDATE_DATE,'dd-MM-yy') between ? and ? ";
			pscheck = conncheck.prepareStatement(query);
			pscheck.setString(1, formBean.getDistrictcode());
			pscheck.setString(2, formBean.getDistrictcode());
			pscheck.setString(3, fromdates);
			pscheck.setString(4, todates);
			rsetcheck = pscheck.executeQuery();			
			if(rsetcheck.next()){
				checkmessage=true;
			}
			else {
				checkmessage=false;
			}
		}catch(Exception e)	{
			System.out.println("The Exception is in the AssetImageDownloaderDAO getTotalList : " + e.getMessage());
		}
		return checkmessage;
	}
}
