package nic.watersoft.masters;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class rws_Asset_Upload_Image_DAO

{
public String updateAssetImage(AssetForm assetForm,String targetPath,ActionServlet actionServlet)
			throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String assetcode=assetForm.getAssetCode();
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message="";
		try {
			conn = RwsOffices.getConn();
			
			if (!isExists(conn,assetcode)) {

				query = "insert into rws_asset_image_tbl (ASSET_IMAGE,ASSET_CODE) values(?,?)";
				
			} else {

				query = "update rws_asset_image_tbl set ASSET_IMAGE=? where ASSET_CODE=?";

			}

		
			pstmt=conn.prepareStatement(query);
			
			formFile=assetForm.getUploadAsset();
			
			if (formFile != null) {
				try {
					String path = actionServlet
							.getServletContext()
							.getRealPath("")
							+ File.separator
							+ formFile.getFileName();
					//System.out.println("path"+path);

					scannedFile = new File(path);
					outputStream = new FileOutputStream(
							scannedFile);
					if (outputStream != null) {
						outputStream.write(formFile
								.getFileData());
					}

					/**
					 * Compressing the image
					 */

					targetFile = new File(targetPath);

					compressImage(scannedFile, targetFile);

					fis = new FileInputStream(targetFile);
					if (fis != null) {
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (fis != null) {
						// fis.close();
					}
				}

				// System.out.println("File Size:"
				// + tenderMemoBean.getPassOrderScanCopy()
				// .getFileSize());
				double fileSizeMB = ((assetForm.getUploadAsset().getFileSize() / 1024.0) / 1024.0);

				// System.out.println("After fileSizeMB:"+fileSizeMB);
				if (fileSizeMB > 0.2) {
					message = "Scanned Copy File Size Shoud Not Be Allowed More Than 200 KB";
					conn.setAutoCommit(true);
					scannedFile.delete();
					outputStream.close();
					targetFile.delete();
					return message;

				}
				// fis =
				// getFileInputStream(tenderMemoBean.getPassOrderScanCopy());
				pstmt.setBinaryStream(1, fis,
						(int) targetFile.length());
				pstmt.setString(2, assetcode);
				
				if (scannedFile != null) {
					scannedFile.delete();

				}
				if (targetFile != null) {
					targetFile.delete();
				}
				if (outputStream != null) {
					// outputStream.close();
				}
				if (fis != null) {
					// fis.close();
				}
				
				
				
			//} 
			
			 
			
			
			

	}
			rcount=pstmt.executeUpdate();
			if(rcount>0){
				message="Image Uploaded Successfully";
				System.out.println(message);
			}
			else
			{
				message="Failed to Upload Image";
				System.out.println(message);
			}

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in insertSarpanch=" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		}
		return message;
	}

	/**
	 * @param location
	 * @return
	 */
	private boolean isExists(Connection conn,String assetCode) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select ASSET_CODE from rws_asset_image_tbl where ASSET_CODE='"+assetCode+"'";
			rs = stmt1.executeQuery(query);
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}
	public void compressImage(File srcFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(srcFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		// create a BufferedImage as the result of decoding the supplied
		// InputStream
		BufferedImage image = ImageIO.read(is);

		// get all image writers for JPG format
		Iterator<ImageWriter> writers = ImageIO
				.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();
		// compress to a given quality
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		// appends a complete image stream containing a single image and
		// associated stream and image metadata and thumbnails to the output
		writer.write(null, new IIOImage(image, null, null), param);

		// close all streams
		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}
	
}