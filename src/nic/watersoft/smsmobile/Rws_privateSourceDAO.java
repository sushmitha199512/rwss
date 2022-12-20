package nic.watersoft.smsmobile;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.RwsOffices;

public class Rws_privateSourceDAO {

	public String getNextSource(String habCode) {

		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;

		String NextSourceCode = null, query = null;

		try {
			conn = RwsOffices.getConn();

			NextSourceCode = habCode + "P" + "V" + "T" + "H" + "P";

			query = " SELECT MAX(SUBSTR(SOURCE_CODE,22,3)) as SOURCE_CODE FROM RWS_PVT_SOURCES_TBL  "
					+ " WHERE SOURCE_CODE LIKE  ?  ";

			stat = conn.prepareStatement(query);
			stat.setString(1, NextSourceCode +"%");
			rset = stat.executeQuery();

			if (rset.next()) {
				int sno = rset.getInt(1);
				if (sno == 0)
					NextSourceCode = NextSourceCode + "001";
				else {
					if (sno >= 999)
						throw new Exception("No more WORK ID left.");
					else {
						String tempSno = null;
						if (sno < 9)
							tempSno = "00" + (sno + 1);
						else if (sno < 99)
							tempSno = "0" + (sno + 1);

						else
							tempSno = String.valueOf(sno + 1);

						NextSourceCode = NextSourceCode + String.valueOf(tempSno);
					}
				}
			}

		} catch (Exception e) {
			System.out.println("exeception in getNextSource-- " + e);
			e.printStackTrace();
		} finally {
			try {
				if (rset != null) {

					rset.close();

				}
				if (stat != null) {

					stat.close();

				}
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("exeception in getNextSource-- " + e);
			}

		}
		return NextSourceCode;
	}
//added by nagendra kankatala 13-08-2020
/*	public String downloadPrivateSourceImages(HttpServletRequest request) {
		//System.out.println("&&&&&&&&&&&&&&&&");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String message="";
		PreparedStatement pstmt_bkp = null;
		//ResultSet rs_bkp = null;
		try {
			conn = RwsOffices.getConn();
			String imageQuery = "select SOURCE_IMG,SOURCE_CODE from RWS_PVT_SOURCES_TBL where SOURCE_IMG is  not null and source_code is not null ";
			//pstmt=conn.prepareStatement(imageQuery);
			pstmt = conn.prepareStatement(imageQuery);
			rs = pstmt.executeQuery();
			
			String imagePath=request.getServletContext().getRealPath("/") ;
			 //String sample[]  = imagePath.split("wtpwebapps");webapps
			 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
			//String sample[]  = imagePath.split( File.separator+"webapps");
			 imagePath = sample[0]+ File.separator+"PrivateSourceImages";
			// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
		
			 File myFilesDir = new File(imagePath);
			 if (!myFilesDir.exists())
				 myFilesDir.mkdirs();
		
			 imagePath = imagePath + File.separator ;
			 File filepath = new File(imagePath);
			 java.sql.Blob a = null;
			while (rs.next()) {
				//(rs1 != null){
					//System.out.println("$$$"+rs.getString("SOURCE_CODE"));
				 a = rs.getBlob("SOURCE_IMG");
				//InputStream iStream = b.getBinaryStream();
				if(a!=null && rs.getString("SOURCE_CODE") != null){
					//Blob b=rs1.getBlob("SOURCE_IMG");
					//String paperDate=rs1.getString("paper_date");
					//String privateSourceId=rs1.getString("SOURCE_CODE");
				
				File filepathisExits = new File(filepath+File.separator+rs.getString("SOURCE_CODE")+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=a.getBytes(1,(int)a.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+rs.getString("SOURCE_CODE")+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				
				
				}
								
				}
			String backupQuery="create table RWS_PVT_SOURCES_TBL_BKP as select SOURCE_CODE ,SOURCE_IMG  from RWS_PVT_SOURCES_TBL";
			try{
			pstmt_bkp = conn.prepareStatement(backupQuery);
			 pstmt_bkp.executeQuery();
			}
			catch(Exception e){System.out.println("Exception in RWS_PVT_SOURCES_TBL_BKP processing...");}
			
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
			message="Unable to Download Images.";
		}
		finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
			System.out.println("exception in download private sources images "+e);
			}
		}
		return message;		
	}*/
	/*public String downloadPrivateSourceImages(HttpServletRequest request) {
		//System.out.println("&&&&&&&&&&&&&&&&");
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt_tot=null,pstmt_bkp = null,pstmt_update = null;
		ResultSet rs = null;
		
		//ResultSet rs_bkp = null;

		String message="";
		try {
			conn = RwsOffices.getConn();
			String imageQuery = "select PASS_ORDER_SCAN_COPY,WORK_ID from RWS_WORK_BILL_TBL where PASS_ORDER_SCAN_COPY is  not null and WORK_ID is not null ";
			pstmt = conn.prepareStatement(imageQuery);
			rs = pstmt.executeQuery();
			
			String imagePath=request.getServletContext().getRealPath("/") ;
			 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
				 imagePath = sample[0];
			 }else{
				 String sample[]  = imagePath.split( "webapps");
				 imagePath = sample[0];
			 }
			 imagePath = imagePath+ File.separator+"PassorderScanCopy";
		
			 File myFilesDir = new File(imagePath);
			 if (!myFilesDir.exists())
				 myFilesDir.mkdirs();
		
			 imagePath = imagePath + File.separator ;
			 File filepath = new File(imagePath);
			 java.sql.Blob a = null;
			while (rs.next()) {
				
				 a = rs.getBlob("PASS_ORDER_SCAN_COPY");
				
				if(a!=null && rs.getString("WORK_ID") != null){
					
				
				File filepathisExits = new File(filepath+File.separator+rs.getString("WORK_ID")+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=a.getBytes(1,(int)a.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+rs.getString("WORK_ID")+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				
				
				}
								
				}
			
			
			
			
			
			
			String totalQuery="create table RWS_WORK_BILL_TBL_TOT as select *  from RWS_WORK_BILL_TBL";
			try{
			pstmt_tot = conn.prepareStatement(totalQuery);
			 pstmt_tot.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_WORK_BILL_TBL processing");}
			
			String backupQuery="create table RWS_WORK_BILL_TBL_BKP as select WORK_ID,PASS_ORDER_SCAN_COPY  from RWS_WORK_BILL_TBL";
			try{
			pstmt_bkp = conn.prepareStatement(backupQuery);
			 pstmt_bkp.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_WORK_BILL_TBL processing");}
			
			try{
			String updateQuery = "update RWS_WORK_BILL_TBL set PASS_ORDER_SCAN_COPY=null";
			pstmt_update = conn.prepareStatement(updateQuery);
			pstmt_update.executeUpdate();
			}catch(Exception e){
				System.out.println(e+"Exception in RWS_WORK_BILL_TBL processing");
				}
			
			
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
			message="Unable to Download Images.";
		}
		finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
			System.out.println("exception in download RWS_WORK_BILL_TBL  images "+e);
			}
		}
		return message;		
	}*/
	

	
	public String downloadPrivateSourceImages(HttpServletRequest request) {
		//System.out.println("&&&&&&&&&&&&&&&&");
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt_tot=null,pstmt_bkp = null,pstmt_update = null;
		ResultSet rs = null;
		
		//ResultSet rs_bkp = null;

		String message="";
		try {
			conn = RwsOffices.getConn();
			String imageQuery = "select complaint_no,UPLOADGRIEVANCE from RWS_GENERIC_COMPLAINTS_REG_TBL where UPLOADGRIEVANCE is  not null and complaint_no is not null ";
			//pstmt=conn.prepareStatement(imageQuery);
			pstmt = conn.prepareStatement(imageQuery);
			rs = pstmt.executeQuery();
			String imagePath=request.getServletContext().getRealPath("/") ;
			 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }else{
				 String sample[]  = imagePath.split( "webapps");
				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }
			 imagePath = imagePath+ File.separator+"GrievanceComplaintImages";
			
			//webapps
			 ////////String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
			 //imagePath = imagePath+ File.separator+"PrivateSourceImages";
			 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
		
			 File myFilesDir = new File(imagePath);
			 if (!myFilesDir.exists())
				 myFilesDir.mkdirs();
		
			 imagePath = imagePath + File.separator ;
			 File filepath = new File(imagePath);
			 java.sql.Blob a = null;
			while (rs.next()) {
				//(rs1 != null){
					//System.out.println("$$$"+rs.getString("SOURCE_CODE"));
				 a = rs.getBlob("UPLOADGRIEVANCE");
				//InputStream iStream = b.getBinaryStream();
				if(a!=null && rs.getString("complaint_no") != null){
					//Blob b=rs1.getBlob("SOURCE_IMG");
					//String paperDate=rs1.getString("paper_date");
					//String privateSourceId=rs1.getString("SOURCE_CODE");
				
				File filepathisExits = new File(filepath+File.separator+rs.getString("complaint_no")+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=a.getBytes(1,(int)a.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+rs.getString("complaint_no")+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				
				
				}
								
				}
			
			
			
			
			
			
			String totalQuery="create table RWS_GENERIC_COMPLAINTS_REG_TOT as select *  from RWS_GENERIC_COMPLAINTS_REG_TBL";
			try{
			pstmt_tot = conn.prepareStatement(totalQuery);
			 pstmt_tot.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_GENERIC_COMPLAINTS_REG_TBL processing");}
			
			String backupQuery="create table RWS_GENERIC_COMPLAINTS_REG_BKP as select complaint_no,UPLOADGRIEVANCE  from RWS_GENERIC_COMPLAINTS_REG_TBL";
			try{
			pstmt_bkp = conn.prepareStatement(backupQuery);
			 pstmt_bkp.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_GENERIC_COMPLAINTS_REG_TBL processing");}
			
			try{
			String updateQuery = "update RWS_GENERIC_COMPLAINTS_REG_TBL  set UPLOADGRIEVANCE=null where  UPLOADGRIEVANCE is not null";
			pstmt_update = conn.prepareStatement(updateQuery);
			pstmt_update.executeUpdate();
			}catch(Exception e){
				System.out.println(e+"Exception in RWS_GENERIC_COMPLAINTS_REG_TBL processing");
				}
			
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
			message="Unable to Download Images.";
		}
		finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
			System.out.println("exception in download Grievance images "+e);
			}
		}
		return message;		
	}
	
	
/*	public String downloadPrivateSourceImages(HttpServletRequest request) {
		//System.out.println("&&&&&&&&&&&&&&&&");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String message="";
		try {
			conn = RwsOffices.getConn();
			String imageQuery = "select PASS_ORDER_SCAN_COPY,WORK_ID,to_char(bill_date,'dd-mm-yyyy'),bill_sl_no from RWS_WORK_BILL_TBL_TOT where PASS_ORDER_SCAN_COPY is  not null and WORK_ID is not null ";
			pstmt = conn.prepareStatement(imageQuery);
			rs = pstmt.executeQuery();
			
			String imagePath=request.getServletContext().getRealPath("/") ;
			 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
				 imagePath = sample[0];
			 }else{
				 String sample[]  = imagePath.split( "webapps");
				 imagePath = sample[0];
			 }
			 imagePath = imagePath+ File.separator+"PassorderScanCopys";
			 File myFilesDir = new File(imagePath);
			 if (!myFilesDir.exists())
				 myFilesDir.mkdirs();
		
			 imagePath = imagePath + File.separator ;
			 File filepath = new File(imagePath);
			 java.sql.Blob a = null;
			while (rs.next()) {
				 a = rs.getBlob("PASS_ORDER_SCAN_COPY");
				if(a!=null && rs.getString("WORK_ID") != null){
				File filepathisExits = new File(filepath+File.separator+rs.getString("WORK_ID")+"_"+rs.getString(3)+"_"+rs.getString("bill_sl_no")+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=a.getBytes(1,(int)a.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+rs.getString("WORK_ID")+"_"+rs.getString(3)+"_"+rs.getString("bill_sl_no")+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				
				
				}
								
				}
			
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
			message="Unable to Download Images.";
		}
		finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
			System.out.println("exception in download private sources images "+e);
			}
		}
		return message;		
	}*/
	
	private static String convertToString(String input){
		StringBuilder result = new StringBuilder();
		/*String[] arr = null;
		if(input.contains(" ")){
			arr = input.split(" ");
		}*/
		if(input!=null&&!input.isEmpty()){
		String[] str = input.split(";");
		for(int i=0;i<str.length;i++){
			String s = str[i].trim();
			s = s.replace("&#", "");
			int decimal = Integer.parseInt(s);
			result.append((char) decimal);
		}
		}
		return result.toString();
	}
	
	//modified by nagendra kankatalaon 13-08-2020
	
	
	
	public static String insertSourceDetails(Rws_PrivateSourceForm frm, String targetPath, ActionServlet servlet) {
		int rowCount;
		String message = "";
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {

			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;
			conn = RwsOffices.getConn();
			formFile = frm.getSourceImg();
			if (formFile.getFileName() != null && !formFile.getFileName().equals("")) {
				if (formFile != null) {
					String query = "insert into RWS_PVT_SOURCES_TBL (SOURCE_CODE,SOURCE_LOCATION,SOURCE_OWNER_NAME,"
							+ "SOURCE_OWNER_MOBILE,SOURCE_IMG_LAT,SOURCE_IMG_LOG,SOURCE_LOCATION_TELUGU ) values (?,?,?,?,?,?,?)";
					preparedStatement = conn.prepareStatement(query);
					preparedStatement.setString(1, frm.getPsourceCode());
					preparedStatement.setString(2, frm.getPsourceLoc());
					preparedStatement.setString(3, frm.getPsourceName());
					preparedStatement.setString(4, frm.getPsourceMob());
					preparedStatement.setString(5, frm.getPsourceLat());
					preparedStatement.setString(6, frm.getPsourceLong());
					preparedStatement.setNString(7, convertToString(frm.getPsourceLocT().trim()));
					try {
						String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
						if(!mimeType.equalsIgnoreCase("image/jpeg"))
						{
							message="Allowed only jpg file extensions only.";
							return message;
						}
						String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();
						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {

							outputStream.write(formFile.getFileData());
						}
						targetFile = new File(targetPath);

						if (!documentSanitizerImpl.madeSafe(scannedFile)) {
							message = "Image File is Corrupted";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							targetFile.delete();
							return message;
						}
						compressImage(scannedFile, targetFile);

						fis = new FileInputStream(targetFile);
					} catch (Exception e) {
						System.out.println("exception in insertSourceDetails " + e);
					} finally {
						if (fis != null) {
						}
					}
					double fileSizeMB = ((frm.getSourceImg().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}
					//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
					String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
					if(!mimeType.equalsIgnoreCase("image/jpeg"))
					{
						message="Allowed only jpg file extensions only.";
						return message;
					}
					String imagePath=servlet.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"PrivateSourceImages";
					File myFilesDir = new File(imagePath);
					if (!myFilesDir.exists())
						myFilesDir.mkdirs();
					imagePath = imagePath + File.separator ;
					File filepath = new File(imagePath);
					File filepathisExits = new File(filepath+File.separator+frm.getPsourceCode()+".jpg");
					if(filepathisExits.getAbsoluteFile().exists()){
						filepathisExits.delete();
					}
					 byte[] readData = new byte[1024];
						FileOutputStream fout=new FileOutputStream(filepath+File.separator+frm.getPsourceCode()+".jpg"); 	
						int k = fis.read(readData);
					      while (k != -1) {
					    	  fout.write(readData, 0, k);
					        k = fis.read(readData);
					      }   			            
					    fout.close();
					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						outputStream.close();
					}
					if (fis != null) {
					//	fis.close();
					}
					
					rowCount = preparedStatement.executeUpdate();
				}
			}
			if (rowCount < 1) {
				message = "Source Details Can't be inserted";
			} else {
				message = "Source Details Inserted Successfully";
			}
		}
		catch (Exception e) {
			System.out.println("exception in insertSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}
/*	public static String insertSourceDetails(Rws_PrivateSourceForm frm, String targetPath, ActionServlet servlet) {
		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {

			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;

			conn = RwsOffices.getConn();
			formFile = frm.getSourceImg();
			if (formFile.getFileName() != null && !formFile.getFileName().equals("")) {
				if (formFile != null) {
					String query = "	insert into RWS_PVT_SOURCES_TBL (SOURCE_CODE,SOURCE_LOCATION,SOURCE_OWNER_NAME,"
							+ "SOURCE_OWNER_MOBILE,SOURCE_IMG_LAT,SOURCE_IMG_LOG,SOURCE_IMG,SOURCE_LOCATION_TELUGU) values (?,?,?,?,?,?,?,?)";
					preparedStatement = conn.prepareStatement(query);
					preparedStatement.setString(1, frm.getPsourceCode());
					preparedStatement.setString(2, frm.getPsourceLoc());
					preparedStatement.setString(3, frm.getPsourceName());
					preparedStatement.setString(4, frm.getPsourceMob());
					preparedStatement.setString(5, frm.getPsourceLat());
					preparedStatement.setString(6, frm.getPsourceLong());
					preparedStatement.setNString(8, convertToString(frm.getPsourceLocT().trim()));

					try {

						String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();
						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {

							outputStream.write(formFile.getFileData());
						}

						targetFile = new File(targetPath);

						if (!documentSanitizerImpl.madeSafe(scannedFile)) {
							message = "Image File is Corrupted";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							targetFile.delete();
							return message;
						}
						compressImage(scannedFile, targetFile);

						fis = new FileInputStream(targetFile);
						if (fis != null) {
						}
					} catch (Exception e) {
						System.out.println("exception in insertSourceDetails " + e);
					} finally {
						if (fis != null) {
						}
					}

					double fileSizeMB = ((frm.getSourceImg().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;

					}
					preparedStatement.setBinaryStream(7, fis, (int) targetFile.length());

					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						outputStream.close();
					}
					if (fis != null) {
					//	fis.close();
					}

					rowCount = preparedStatement.executeUpdate();
				}
			}
			if (rowCount < 1) {
				message = "Source Details Can't be inserted";
			} else {
				message = "Source Details Inserted Successfully";


			}

		}

		catch (Exception e) {
			System.out.println("exception in insertSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}*/

	private static void compressImage(File scannedFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(scannedFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		BufferedImage image = ImageIO.read(is);

		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();

		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		writer.write(null, new IIOImage(image, null, null), param);

		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}
	public static String convertToTelugu(String input){
		//System.out.println("**********"+"*******"+input);
		StringBuffer result = new StringBuffer();
		 for (char temp : input.toCharArray()) {
	            int decimal = (int) temp;
	            result.append("&#"+(decimal)+";");
	        }
		return result.toString();	
	}
	public ArrayList<Rws_PrivateSourceForm> getPVTSourceDetails(String circleOfficeCode, DataSource dataSource) {

		Connection conn = null;
		ResultSet rst = null;
		PreparedStatement stmt = null;
		Rws_PrivateSourceForm frm = null;
		ArrayList<Rws_PrivateSourceForm> SourceDetails = new ArrayList<Rws_PrivateSourceForm>();

		try {
			conn = RwsOffices.getConn();

			String qry = "select SOURCE_CODE,SOURCE_LOCATION,SOURCE_OWNER_NAME,SOURCE_OWNER_MOBILE,"
					+ "SOURCE_IMG_LAT,SOURCE_IMG_LOG,dname,mname,pname,vname,panch_name,SOURCE_LOCATION_TELUGU"
					+ " from RWS_PVT_SOURCES_TBL a,rws_complete_hab_view b where "
					+ "substr(a.source_code,1,16)=b.panch_code and substr(a.source_code,1,2)=? ";
			stmt = conn.prepareStatement(qry);
			stmt.setString(1, circleOfficeCode);
			rst = stmt.executeQuery();

			while (rst.next()) {
				frm = new Rws_PrivateSourceForm();
				frm.setPsourceCode(rst.getString("SOURCE_CODE"));
				frm.setPsourceLoc(rst.getString("SOURCE_LOCATION"));
				frm.setPsourceName(rst.getString("SOURCE_OWNER_NAME"));
				frm.setPsourceMob(rst.getString("SOURCE_OWNER_MOBILE"));
				frm.setPsourceLat(rst.getString("SOURCE_IMG_LAT"));
				frm.setPsourceLong(rst.getString("SOURCE_IMG_LOG"));
				frm.setDname(rst.getString("dname"));
				frm.setMname(rst.getString("mname"));
				frm.setPname(rst.getString("pname"));
				frm.setVill(rst.getString("vname"));
				frm.setPanchName(rst.getString("panch_name"));
				if(rst.getString("SOURCE_LOCATION_TELUGU")!=null&&!rst.getString("SOURCE_LOCATION_TELUGU").isEmpty()){
					frm.setPsourceLocT(convertToTelugu(rst.getString("SOURCE_LOCATION_TELUGU").toString().trim()));
					}else
					{
						frm.setPsourceLocT("");
					}
				SourceDetails.add(frm);

			}

		} catch (Exception e) {
			System.out.println("exception in getPVTSourceDetails method of Rws_privateSourceDAO" + e);

		}

		return SourceDetails;
	}

	public void getPrivateDetails(String SourceCode, Rws_PrivateSourceForm frm) throws Exception {

		String qry = "";
		Connection conn = null;
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;

		try {
			conn = RwsOffices.getConn();
			qry = "select SOURCE_CODE,SOURCE_LOCATION,SOURCE_OWNER_NAME,SOURCE_OWNER_MOBILE,"
					+ "SOURCE_IMG_LAT,SOURCE_IMG_LOG,dname,mname,pname,panch_name,SOURCE_LOCATION_TELUGU "
					+ "from RWS_PVT_SOURCES_TBL a,rws_complete_hab_view b  WHERE "
					+ "substr(a.source_code,1,16)=b.panch_code and  SOURCE_CODE=? ";

			stmt2 = conn.prepareStatement(qry);
			stmt2.setString(1, SourceCode);
			rs2 = stmt2.executeQuery();


			while (rs2.next()) {
				frm.setPsourceCode(rs2.getString("SOURCE_CODE"));
				frm.setPsourceLoc(rs2.getString("SOURCE_LOCATION"));
				frm.setPsourceName(rs2.getString("SOURCE_OWNER_NAME"));
				frm.setPsourceMob(rs2.getString("SOURCE_OWNER_MOBILE"));
				frm.setPsourceLat(rs2.getString("SOURCE_IMG_LAT"));
				frm.setPsourceLong(rs2.getString("SOURCE_IMG_LOG"));
				frm.setDistrictName(rs2.getString("dname"));
				frm.setMand(rs2.getString("mname"));
				frm.setPanch(rs2.getString("pname"));
				frm.setPanchName(rs2.getString("panch_name"));
				frm.setPsourceLocT(rs2.getString("SOURCE_LOCATION_TELUGU"));
			}

		} catch (Exception e) {
			System.out.println("exception in getPrivateDetails method of Rws_privateSourceDAO" + e);

		} finally {
			stmt2.close();
			conn.close();
			rs2.close();

		}

	}
	
	//modified by nagendra kankatala 13-08-2020
	public static String updateSourceDetails(Rws_PrivateSourceForm frm, String targetPath, ActionServlet servlet) {
		int rowCount;
		String message = "";
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {

			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;
			conn = RwsOffices.getConn();
			formFile = frm.getSourceImg();
			if (formFile.getFileName() != null && !formFile.getFileName().equals("")) {
				if (formFile != null) {
					String query = "update RWS_PVT_SOURCES_TBL set SOURCE_LOCATION=?,SOURCE_OWNER_NAME=?,SOURCE_OWNER_MOBILE =?,SOURCE_IMG_LAT =?,SOURCE_IMG_LOG =?,SOURCE_LOCATION_TELUGU=? WHERE SOURCE_CODE='"
							+ frm.getPsourceCode() + "' ";
					preparedStatement = conn.prepareStatement(query);

					preparedStatement.setString(1, frm.getPsourceLoc());
					preparedStatement.setString(2, frm.getPsourceName());
					preparedStatement.setString(3, frm.getPsourceMob());
					preparedStatement.setString(4, frm.getPsourceLat());
					preparedStatement.setString(5, frm.getPsourceLong());
					if(!frm.getPsourceLocT().toString().isEmpty()){
						preparedStatement.setNString(6, convertToString(frm.getPsourceLocT()));
						}else
						{
							preparedStatement.setNString(6, "");
						}try {
							String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
							if(!mimeType.equalsIgnoreCase("image/jpeg"))
							{
								message="Allowed only jpg file extensions only.";
								return message;
							}
						String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();
						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {

							outputStream.write(formFile.getFileData());
						}
						targetFile = new File(targetPath);

						if (!documentSanitizerImpl.madeSafe(scannedFile)) {
							message = "Image File is Corrupted";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							targetFile.delete();
							return message;
						}
						compressImage(scannedFile, targetFile);

						fis = new FileInputStream(targetFile);
					} catch (Exception e) {
						System.out.println("exception in insertSourceDetails " + e);
					} finally {
						if (fis != null) {
						}
					}
					double fileSizeMB = ((frm.getSourceImg().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}
					//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
					String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
					if(!mimeType.equalsIgnoreCase("image/jpeg"))
					{
						message="Allowed only jpg file extensions only.";
						return message;
					}
					String imagePath=servlet.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						 //System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						 //System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"PrivateSourceImages";
					File myFilesDir = new File(imagePath);
					if (!myFilesDir.exists())
						myFilesDir.mkdirs();
					imagePath = imagePath + File.separator ;
					File filepath = new File(imagePath);
					File filepathisExits = new File(filepath+File.separator+frm.getPsourceCode()+".jpg");
					if(filepathisExits.getAbsoluteFile().exists()){
						filepathisExits.delete();
					}
					 byte[] readData = new byte[1024];
						FileOutputStream fout=new FileOutputStream(filepath+File.separator+frm.getPsourceCode()+".jpg"); 	
						int k = fis.read(readData);
					      while (k != -1) {
					    	  fout.write(readData, 0, k);
					        k = fis.read(readData);
					      }   			            
					    fout.close();
					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						outputStream.close();
					}
					if (fis != null) {
					//	fis.close();
					}
					
					rowCount = preparedStatement.executeUpdate();
				}
			}
			if (rowCount < 1) {
				message = "Source Details Can't be Updated";
			} else {
				message = "Source Details Updated Successfully";
			}
		}
		catch (Exception e) {
			System.out.println("exception in insertSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}

/*	public static String updateSourceDetails(Rws_PrivateSourceForm frm, String targetPath, ActionServlet servlet)
			throws Exception {
		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;

			conn = RwsOffices.getConn();

			String query = "	update RWS_PVT_SOURCES_TBL set SOURCE_LOCATION=?,SOURCE_OWNER_NAME=?,SOURCE_OWNER_MOBILE =?,SOURCE_IMG_LAT =?,SOURCE_IMG_LOG =?,SOURCE_IMG=?,SOURCE_LOCATION_TELUGU=? WHERE SOURCE_CODE='"
					+ frm.getPsourceCode() + "' ";
			preparedStatement = conn.prepareStatement(query);

			preparedStatement.setString(1, frm.getPsourceLoc());
			preparedStatement.setString(2, frm.getPsourceName());
			preparedStatement.setString(3, frm.getPsourceMob());
			preparedStatement.setString(4, frm.getPsourceLat());
			preparedStatement.setString(5, frm.getPsourceLong());

			try {
				formFile = frm.getSourceImg();
				String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();

				scannedFile = new File(path);
				outputStream = new FileOutputStream(scannedFile);
				if (outputStream != null) {
					outputStream.write(formFile.getFileData());
				}

				targetFile = new File(targetPath);

				if (!documentSanitizerImpl.madeSafe(scannedFile)) {
					message = "Image File is Corrupted";
					conn.setAutoCommit(true);
					scannedFile.delete();
					outputStream.close();
					targetFile.delete();
					return message;
				}
				compressImage(scannedFile, targetFile);

				fis = new FileInputStream(targetFile);
				if (fis != null) {
				}
			} catch (Exception e) {
				System.out.println("exception in updateSourceDetails --  " + e);
			} finally {
				if (fis != null) {
				}
			}

			double fileSizeMB = ((frm.getSourceImg().getFileSize() / 1024.0) / 1024.0);

			if (fileSizeMB > 0.2) {
				message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
				conn.setAutoCommit(true);
				scannedFile.delete();
				outputStream.close();
				targetFile.delete();
				return message;

			}
			preparedStatement.setBinaryStream(6, fis, (int) targetFile.length());
			if(!frm.getPsourceLocT().toString().isEmpty()){
				preparedStatement.setNString(7, convertToString(frm.getPsourceLocT()));
				}else
				{
					preparedStatement.setNString(7, "");
				}

			if (scannedFile != null) {
				scannedFile.delete();

			}
			if (targetFile != null) {
				targetFile.delete();
			}
			if (outputStream != null) {
				outputStream.close();
			}
			if (fis != null) {
			//	fis.close();
			}

			rowCount = preparedStatement.executeUpdate();

			if (rowCount < 1) {
				message = "Source Details Can't be Updated";
			} else {
				message = "Source Details Updated Successfully";

			}
		}

		catch (Exception e) {
			System.out.println("exception in updateSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;

	}*/

	public static String deleteSourceDetails(String psourceCode) {
		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement stmt = null, stmt1 = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			conn = RwsOffices.getConn();

			String query = "select SOURCE_CODE from rws_tanker_movement_tbl where source_code=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, psourceCode);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				message = "Source Can't be deleted";
			} else {
				String qry1 = "delete from RWS_PVT_SOURCES_TBL where source_code=?";
				stmt = conn.prepareStatement(qry1);
				stmt.setString(1, psourceCode);
				rowCount = stmt.executeUpdate();

				if (rowCount > 0)
					message = "Record Deleted Successfully";
				else
					message = "Record Can't be deleted";
			}

		} catch (Exception e) {
			System.out.println("exception in deleteSourceDetails method of Rws_privateSourceDAO" + e);
		}

		return message;
	}

	public String insertSourceDestinationDetails(Rws_PrivateSourceForm frm) {
		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {

			conn = RwsOffices.getConn();

			String query = "	insert into RWS_TANKER_SRC_DEST_DIS_TBL values (?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'))";
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, frm.getPsourceCode());
			preparedStatement.setString(2, frm.getDestination());
			preparedStatement.setString(3, frm.getDistance());
			preparedStatement.setString(4, frm.getFromDate());
			preparedStatement.setString(5, frm.getToDate());

			rowCount = preparedStatement.executeUpdate();

			if (rowCount < 1) {
				message = "Source and Destination Details Can't be inserted";
			} else {
				message = "Source and Destination Details Inserted Successfully";


			}
		}

		catch (Exception e) {
			System.out.println("exception in insertSourceDestinationDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}

	public ArrayList getSources(String dcode, String mcode, String pcode, String vcode, String habcode)
			throws Exception {
		ArrayList sources = new ArrayList();

		String query = "";
		Rws_PrivateSourceForm rwsLocation = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();

			query = "SELECT SOURCE_CODE,nvl(SOURCE_LOCATION,'--') FROM RWS_PVT_SOURCES_TBL WHERE"
					+ " SUBSTR(SOURCE_CODE,1,16)=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, habcode);

			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new Rws_PrivateSourceForm();
				rwsLocation.setPsourceCode(rs.getString(1));
				rwsLocation.setPsourceName(rs.getString(2) + " - " + rs.getString(1));
				sources.add(rwsLocation);

			}
			rs.close();
			stmt.close();

			query = "SELECT HP_CODE,nvl(LOCATION,'--') FROM RWS_HP_SUBCOMP_PARAM_TBL WHERE"
					+ " SUBSTR(HP_CODE,1,16)=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, habcode);
			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new Rws_PrivateSourceForm();
				rwsLocation.setPsourceCode(rs.getString(1));
				rwsLocation.setPsourceName(rs.getString(2) + " - " + rs.getString(1));
				sources.add(rwsLocation);

			}
			rs.close();
			stmt.close();

			query = "SELECT SHALLOWHP_CODE,nvl(LOCATION,'--') FROM RWS_SHALLOWHANDPUMPS_TBL WHERE"
					+ " SUBSTR(SHALLOWHP_CODE,1,16)=?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, habcode);
			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new Rws_PrivateSourceForm();
				rwsLocation.setPsourceCode(rs.getString(1));
				rwsLocation.setPsourceName(rs.getString(2) + " - " + rs.getString(1));
				sources.add(rwsLocation);

			}
			rs.close();
			stmt.close();

			query = "SELECT OPENWELL_CODE,nvl(LOCATION,'--') FROM RWS_OPEN_WELL_MAST_TBL WHERE"
					+ " SUBSTR(OPENWELL_CODE,1,16)=?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, habcode);
			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new Rws_PrivateSourceForm();
				rwsLocation.setPsourceCode(rs.getString(1));
				rwsLocation.setPsourceName(rs.getString(2) + " - " + rs.getString(1));
				sources.add(rwsLocation);

			}
			rs.close();
			stmt.close();

			query = "SELECT SOURCE_CODE,nvl(LOCATION,'--') FROM RWS_SOURCE_TBL WHERE" + " SUBSTR(SOURCE_CODE,1,16)=?";

			stmt = conn.prepareStatement(query);
			stmt.setString(1, habcode);
			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new Rws_PrivateSourceForm();
				rwsLocation.setPsourceCode(rs.getString(1));
				rwsLocation.setPsourceName(rs.getString(2) + " - " + rs.getString(1));
				sources.add(rwsLocation);

			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println("exception in getSources method of Rws_privateSourceDAO" + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return sources;
	}

	public ArrayList<Rws_PrivateSourceForm> getSourceDestDetails(String circleOfficeCode, DataSource dataSource) {

		Connection conn = null;
		ResultSet rst = null;
		PreparedStatement stmt = null;
		Rws_PrivateSourceForm frm = null;
		ArrayList<Rws_PrivateSourceForm> SourceDetails = new ArrayList<Rws_PrivateSourceForm>();

		try {
			conn = RwsOffices.getConn();

			String qry = "select a.SOURCE_CODE as SOURCE_CODE,DESTINATION,EST_DISTANCE_IN_KMS,"
					+ "to_char(FROM_DATE,'dd-mm-yyyy') AS FROM_DATE,nvl(to_char(TO_DATE,'dd-mm-yyyy'),'--') "
					+ "AS TO_DATE,dname,mname,pname,vname,panch_name,SOURCE_LOCATION as LOCATION  from "
					+ "RWS_TANKER_SRC_DEST_DIS_TBL a,rws_complete_hab_view b,RWS_PVT_SOURCES_TBL c where "
					+ "substr(a.source_code,1,16)=b.panch_code and a.source_code=c.source_code and substr(a.source_code,1,2)=?"

					+ " UNION select a.SOURCE_CODE as SOURCE_CODE,DESTINATION,EST_DISTANCE_IN_KMS,"
					+ "to_char(FROM_DATE,'dd-mm-yyyy') AS FROM_DATE,nvl(to_char(TO_DATE,'dd-mm-yyyy'),'--') "
					+ "AS TO_DATE,dname,mname,pname,vname,panch_name,nvl(LOCATION,'--')   from "
					+ "RWS_TANKER_SRC_DEST_DIS_TBL a,rws_complete_hab_view b,RWS_SOURCE_TBL c where "
					+ "substr(a.source_code,1,16)=b.panch_code and a.source_code=c.source_code and substr(a.source_code,1,2)=?"

					+ " UNION select a.SOURCE_CODE as SOURCE_CODE,DESTINATION,EST_DISTANCE_IN_KMS,"
					+ "to_char(FROM_DATE,'dd-mm-yyyy') AS FROM_DATE,nvl(to_char(TO_DATE,'dd-mm-yyyy'),'--') "
					+ "AS TO_DATE,dname,mname,pname,vname,panch_name,nvl(LOCATION,'--')   from "
					+ "RWS_TANKER_SRC_DEST_DIS_TBL a,rws_complete_hab_view b,RWS_HP_SUBCOMP_PARAM_TBL c where "
					+ "substr(a.source_code,1,16)=b.panch_code and a.source_code=c.hp_code and substr(a.source_code,1,2)=?"

					+ " UNION select a.SOURCE_CODE as SOURCE_CODE,DESTINATION,EST_DISTANCE_IN_KMS,"
					+ "to_char(FROM_DATE,'dd-mm-yyyy') AS FROM_DATE,nvl(to_char(TO_DATE,'dd-mm-yyyy'),'--')"
					+ " AS TO_DATE,dname,mname,pname,vname,panch_name,nvl(LOCATION,'--')   from "
					+ "RWS_TANKER_SRC_DEST_DIS_TBL a,rws_complete_hab_view b,RWS_SHALLOWHANDPUMPS_TBL c where"
					+ " substr(a.source_code,1,16)=b.panch_code and a.source_code=c.SHALLOWHP_CODE and substr(a.source_code,1,2)=?"

					+ " UNION select a.SOURCE_CODE as SOURCE_CODE,DESTINATION,EST_DISTANCE_IN_KMS,"
					+ "to_char(FROM_DATE,'dd-mm-yyyy') AS FROM_DATE,nvl(to_char(TO_DATE,'dd-mm-yyyy'),'--') "
					+ "AS TO_DATE,dname,mname,pname,vname,panch_name,nvl(LOCATION,'--')   from "
					+ "RWS_TANKER_SRC_DEST_DIS_TBL a,rws_complete_hab_view b,RWS_OPEN_WELL_MAST_TBL c where "
					+ "substr(a.source_code,1,16)=b.panch_code and a.source_code=c.OPENWELL_CODE and substr(a.source_code,1,2)=?";

			stmt = conn.prepareStatement(qry);
			stmt.setString(1, circleOfficeCode);
			stmt.setString(2, circleOfficeCode);
			stmt.setString(3, circleOfficeCode);
			stmt.setString(4, circleOfficeCode);
			stmt.setString(5, circleOfficeCode);
			rst = stmt.executeQuery();

			while (rst.next()) {

				frm = new Rws_PrivateSourceForm();
				frm.setPsourceCode(rst.getString("SOURCE_CODE"));
				frm.setDestination(rst.getString("DESTINATION"));
				frm.setDistance(rst.getString("EST_DISTANCE_IN_KMS"));
				frm.setFromDate(rst.getString("FROM_DATE"));
				frm.setToDate(rst.getString("TO_DATE"));
				frm.setDname(rst.getString("dname"));
				frm.setMname(rst.getString("mname"));
				frm.setPname(rst.getString("pname"));
				frm.setVill(rst.getString("vname"));
				frm.setPanchName(rst.getString("panch_name"));
				frm.setPsourceLoc(rst.getString("LOCATION"));

				SourceDetails.add(frm);

			}

		} catch (Exception e) {
			System.out.println("exception in getSourceDestDetails method of Rws_privateSourceDAO" + e);

		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in getSourceDestDetails method of Rws_privateSourceDAO" + e);
				}
			}
		}

		return SourceDetails;
	}
}
