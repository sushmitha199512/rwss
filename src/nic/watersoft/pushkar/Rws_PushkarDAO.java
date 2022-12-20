package nic.watersoft.pushkar;

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
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.net.URLConnection;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.drought.DroughtDAOMessage;

public class Rws_PushkarDAO {
	private static DataSource dataSource;

	private static String query;

	private boolean flag;
	private LabelValueBean labelValueBean;

	public int HEAD_OF_OFFICE_COUNT = 1;
	public String errorMessage = "";

	public Rws_PushkarDAO() {
		try {
			Connection conn = RwsOffices.getConn();

		} catch (Exception e) {
		}
	}

	public Rws_PushkarDAO(DataSource dataSource) {
		this.dataSource = dataSource;
		flag = false;
	}

	public DroughtDAOMessage deletePushkarDetails(String proposalId,
			ArrayList viewlist) {
		
		Connection conn = null;
		String q = "";
		PreparedStatement ps = null;
		ResultSet rset = null;
		DroughtDAOMessage daoMessage = new DroughtDAOMessage();
		daoMessage.setOperationSussess(true);
		try {

			conn = RwsOffices.getConn();
			
			conn.setAutoCommit(true);

			for (int i = 0; i < viewlist.size(); i++) {

				PushkarHolder pushkarDto = (PushkarHolder) viewlist.get(i);
				if (pushkarDto != null) {
					
					if (pushkarDto.getProposalId().equals(proposalId)) {
						viewlist.remove(pushkarDto);
						break;

					}
				}
			}

			
			String query = "";
			query = "DELETE FROM RWS_pushkar_work_TBL WHERE WORK_ID=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, proposalId);
			ps.executeUpdate();
			conn.commit();
			daoMessage.setOperationSussess(true);
			daoMessage.setMessage("Record deleted successfully");

		}

		catch (Exception e) {
			Debug.writeln("Exception in deletePushkarDetails : \n" + e);
			daoMessage.setOperationSussess(false);
			daoMessage.setMessage("Record cannot be deleted");
			try {
				conn.rollback();
			} catch (Exception ex) {
			}
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return daoMessage;
	}

	public static String getNextProposalIdForAdminiStrative(
			String headOfficecode, String districtCode, String programmeCode,
			String subprogrammeCode)

	{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);

		String drought = "P";

		String workId = null;

		try {
			conn = RwsOffices.getConn();

			if (subprogrammeCode.equals(""))
				subprogrammeCode = "00";

			if (programmeCode.equals("") || districtCode.equals(""))
				return new String("false");

			workId = programmeCode + subprogrammeCode + districtCode + 0 + 0
					+ currentYear + drought;

			query = " SELECT MAX(SUBSTR(work_id,12,3)) as work_id FROM RWS_PUSHKAR_WORK_TBL  "
					+ " WHERE WORK_ID LIKE ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, workId + "%");
			rset = pstmt.executeQuery();

			if (rset.next()) {
				int sno = rset.getInt(1);

				if (sno == 0)
					workId = workId + "001";
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

						workId = workId + String.valueOf(tempSno);
					}
				}
			}

		} catch (Exception e) {
			Debug.writeln("Exception in getNextProposalIdForAdminiStrative : \n" + e);
			
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return workId;
	}

	public ArrayList getCircles(String headOfficeCode) throws Exception {

		ArrayList circles = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM rws_circle_office_tbl "
					+ " WHERE head_office_code = ?  and circle_office_code in('04','05','06','07','13') "
					+ " ORDER BY circle_office_name";

			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getCircles is " + e);
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return circles;
	}

	public String insertPushkar(Rws_PushkarWorkForm frm, String targetPath,
			ActionServlet actionServlet) throws Exception {

		int recCount = 0;

		Connection conn = null;
		PreparedStatement stmt = null;
		Statement statement = null;

		int selectedCount = 0;
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message = "";
		try {
			Date today = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			String datenewformat = formatter.format(today);
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			
			conn = RwsOffices.getConn();

			for (int i = 0; i < frm.getProposals().size(); i++) {

				PushkarHolder form = (PushkarHolder) frm.getProposals().get(i);

				String pushkarcode = form.getPushkarCode();

				String query = "";

				if (form.getScannedCopy().toString() == "") {

				}
				if (form.getScannedCopy() == null
						|| form.getScannedCopy().toString().trim().equals("")) {

					query = "insert into RWS_PUSHKAR_WORK_TBL(OFFICE_CODE,PROGRAMME_CODE,SUBPROGRAMME_CODE,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TENDER_INVITED,TENDER_AMOUNT,TENDER_APPROVED,TENDER_APPROVED_AMT,AGREE_CONCLUDE,AGREE_CONCLUDE_AMT,GROUNDING_DATE,PHYSICAL_STAGE,VALUE_OF_WORK_DONE,PERCENTAGE_WORK_DONE,PROBABLE_DATE_OF_COMP,WORK_COMPL_DATE,EXP_ON_WORK,REMARKS) values(?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?)";

				} else {
					query = "insert into RWS_PUSHKAR_WORK_TBL(OFFICE_CODE,PROGRAMME_CODE,SUBPROGRAMME_CODE,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TENDER_INVITED,TENDER_AMOUNT,TENDER_APPROVED,TENDER_APPROVED_AMT,AGREE_CONCLUDE,AGREE_CONCLUDE_AMT,GROUNDING_DATE,PHYSICAL_STAGE,VALUE_OF_WORK_DONE,PERCENTAGE_WORK_DONE,PROBABLE_DATE_OF_COMP,WORK_COMPL_DATE,EXP_ON_WORK,REMARKS,WORK_IMG) values(?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?)";
				}

				stmt = conn.prepareStatement(query);

				stmt.setString(1,frm.getHeadOfficeCode() + frm.getCircleOfficeCode()+ frm.getDivisionOfficeCode()+ frm.getSubdivisionOfficeCode());
				stmt.setString(2, frm.getPrograms());
				stmt.setString(3, frm.getSubPrograms());
				stmt.setString(4, form.getHabs());
				stmt.setString(5, frm.getGhatType());
				stmt.setString(6, pushkarcode);
				stmt.setString(7, frm.getUserId());
				stmt.setString(8, datenewformat);
				stmt.setString(9, datenewformat);
				stmt.setString(10, form.getProposalName());
				stmt.setString(11, form.getProposalId());
				stmt.setString(12, form.getWorkType());
				stmt.setString(13, form.getAdminiStrativeNum());
				stmt.setString(14, form.getAdminiStrativeDate());
				stmt.setString(15, form.getSanctionAmout());
				stmt.setString(16, form.getTenderinvited());
				stmt.setString(17, form.getTsno());
				stmt.setString(18, form.getTenderaprvd());
				stmt.setString(19, form.getTenderappamount());
				stmt.setString(20, form.getAgreeconcluded());
				stmt.setString(21, form.getAgreeamount());
				stmt.setString(22, form.getGrounddate());
				stmt.setString(23, form.getPhysicaldetails());
				stmt.setString(24, form.getWorkdonevalue());
				stmt.setString(25, form.getWorkdonedate());
				stmt.setString(26, form.getPrbleDateCompletion());
				stmt.setString(27, form.getCompleteddate());
				stmt.setString(28, form.getExpenditure());
				stmt.setString(29, form.getRemarks());

				formFile = form.getScannedCopy();
				
				if (form.getScannedCopy() == null
						|| form.getScannedCopy().toString().trim().equals("")) {
				
				} else {
					
					try {
						
						String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
						if(!mimeType.equalsIgnoreCase("image/jpeg"))
						{
							message="Allowed only jpg file extensions only.";
							return message;
						}

						String path = actionServlet.getServletContext()
								.getRealPath("")
								+ File.separator
								+ formFile.getFileName();
						

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
						e.printStackTrace();
					} finally {
						if (fis != null) {
							
						}
					}

					
					double fileSizeMB = ((form.getScannedCopy().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;

					}
					
					stmt.setBinaryStream(30, fis, (int) targetFile.length());

					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						
					}
					if (fis != null) {
						
					}

				}
				recCount = stmt.executeUpdate();

				
				if (recCount > 0) {

					message = " Record inserted Successfully";
				} else {
					message = " Record not inserted ";
				}

			}

		}

		catch (Exception e) {
			Debug.writeln("Exception in insertPushkar : \n" + e);

		} finally {
			
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return message;
	}

	public String updatePushkar(Rws_PushkarWorkForm frm, String targetPath,
			ActionServlet actionServlet) throws Exception {

		int recCount = 0;

		Connection conn = null;
		PreparedStatement stmt = null;
		
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message = "";
		try {
			Date today = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			String datenewformat = formatter.format(today);
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			
			conn = RwsOffices.getConn();
			
			String query = "";

			formFile = frm.getScannedCopy();
			if (formFile.getFileName() == null
					|| formFile.getFileName().equals("")) {
				query = "update RWS_PUSHKAR_WORK_TBL set UPDATE_DATE=to_date(?,'dd/mm/yyyy'),WORK_NAME=?,WORK_TYPE=?,PHYSICAL_STAGE=?,VALUE_OF_WORK_DONE=?,PERCENTAGE_WORK_DONE=?,PROBABLE_DATE_OF_COMP=to_date(?,'dd/mm/yyyy'),WORK_COMPL_DATE=to_date(?,'dd/mm/yyyy'),EXP_ON_WORK=?,REMARKS=?,GROUNDING_DATE =?,TENDER_INVITED=?,TENDER_AMOUNT=?,TENDER_APPROVED=?,TENDER_APPROVED_AMT=?,AGREE_CONCLUDE=?,AGREE_CONCLUDE_AMT=?,ADMIN_AMOUNT=?   where WORK_ID=?";
			} else {
				query = "update RWS_PUSHKAR_WORK_TBL set UPDATE_DATE=to_date(?,'dd/mm/yyyy'),WORK_NAME=?,WORK_TYPE=?,PHYSICAL_STAGE=?,VALUE_OF_WORK_DONE=?,PERCENTAGE_WORK_DONE=?,PROBABLE_DATE_OF_COMP=to_date(?,'dd/mm/yyyy'),WORK_COMPL_DATE=to_date(?,'dd/mm/yyyy'),EXP_ON_WORK=?,REMARKS=?,GROUNDING_DATE =?,TENDER_INVITED=?,TENDER_AMOUNT=?,TENDER_APPROVED=?,TENDER_APPROVED_AMT=?,AGREE_CONCLUDE=?,AGREE_CONCLUDE_AMT=?,ADMIN_AMOUNT=?,WORK_IMG=? where WORK_ID=?";

			}
			
			stmt = conn.prepareStatement(query);

			stmt.setString(1, datenewformat);
			stmt.setString(2, frm.getProposalName());
			stmt.setString(3, frm.getWorkType());
			stmt.setString(4, frm.getPhysicaldetails());
			stmt.setString(5, frm.getWorkdonevalue());
			stmt.setString(6, frm.getWorkdonedate());
			stmt.setString(7, frm.getPrbleDateCompletion());
			stmt.setString(8, frm.getCompleteddate());
			stmt.setString(9, frm.getExpenditure());
			stmt.setString(10, frm.getRemarks());
			stmt.setString(11, frm.getGrounddate());
			stmt.setString(12, frm.getTenderinvited());
			stmt.setString(13, frm.getTsno());
			stmt.setString(14, frm.getTenderaprvd());
			stmt.setString(15, frm.getTenderappamount());
			stmt.setString(16, frm.getAgreeconcluded());
			stmt.setString(17, frm.getAgreeamount());
			stmt.setString(18, frm.getSanctionAmout());
			
			if (formFile.getFileName() == null
					|| formFile.getFileName().equals("")) {
				stmt.setString(19, frm.getProposalId());
			} else {
				stmt.setString(20, frm.getProposalId());
				if (formFile != null) {
					try {
						String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
						if(!mimeType.equalsIgnoreCase("image/jpeg"))
						{
							message="Allowed only jpg file extensions only.";
							return message;
						}
						String path = actionServlet.getServletContext()
								.getRealPath("")
								+ File.separator
								+ formFile.getFileName();
						
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
						e.printStackTrace();
					} finally {
						if (fis != null) {
							
						}
					}

					double fileSizeMB = ((frm.getScannedCopy().getFileSize() / 1024.0) / 1024.0);

					
					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}
					
					stmt.setBinaryStream(19, fis, (int) targetFile.length());

					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						
					}
					if (fis != null) {
						
					}

				}

			}

			recCount = stmt.executeUpdate();
			
			if (recCount > 0) {
				
				message = " Record updated Successfully";
			} else {
				message = " Record Cannot be Updated ";
			}

		}

		catch (Exception e) {
			Debug.writeln("Exception in updatePushkar : \n" + e);

		} finally {
			
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return message;
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

	public ArrayList getMandals(String circleOfficeCode, String division,
			String subdivision) throws Exception {
		ArrayList mandals = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;

		try {
			conn = RwsOffices.getConn();
			query = " select b.mcode,b.mname from RWS_MANDAL_SUBDIVISION_TBL a,RWS_MANDAL_TBL b where a.dcode=b.dcode and a.mcode=b.mcode and CIRCLE_OFFICE_CODE ='"
					+ circleOfficeCode
					+ "' and DIVISION_OFFICE_CODE ='"
					+ division
					+ "' and SUBDIVISION_OFFICE_CODE ='"
					+ subdivision + "' ";
			
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				mandals.add(labelValueBean);
			}

		} catch (Exception e) {
			Debug.writeln("Exception in getMandals : \n" + e);
		} finally {

			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		
		}
		return mandals;
	}

	public ArrayList getpanchayts(String mcode, String dcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;

		try {
			conn = RwsOffices.getConn();
			query = " select pcode,pname from  rws_panchayat_tbl  where dcode='"
					+ dcode + "' and mcode='" + mcode + "'";
			
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				panchayats.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.writeln("Exception in getpanchayts : \n" + e);
		} finally {

			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		
		}
		return panchayats;
	}

	public ArrayList pushkarview(String district) throws Exception {
		ArrayList pushkarlist = new ArrayList();
		String query = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			conn = RwsOffices.getConn();

			query = "select PROGRAMME_NAME,SUBPROGRAMME_NAME,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,to_char(PREPARED_ON,'dd/mm/yyyy'),UPDATE_DATE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_AMOUNT,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy'),TENDER_INVITED,TENDER_AMOUNT,TENDER_APPROVED,TENDER_APPROVED_AMT,AGREE_CONCLUDE,AGREE_CONCLUDE_AMT,PHYSICAL_STAGE,VALUE_OF_WORK_DONE,PERCENTAGE_WORK_DONE,to_char(PROBABLE_DATE_OF_COMP,'dd/mm/yyyy'),to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),EXP_ON_WORK,REMARKS from RWS_PUSHKAR_WORK_TBL a,RWS_PROGRAMME_TBL b,RWS_SUBPROGRAMME_TBL  C where a.programme_code=b.programme_code and a.programme_code=c.programme_code and a.subprogramme_code=c.subprogramme_code and substr(office_code,2,2)=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, district);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				Rws_PushkarWorkForm pushkarform = new Rws_PushkarWorkForm();

				pushkarform.setPrograms(rs.getString(1));
				pushkarform.setSubPrograms(rs.getString(2));
				pushkarform.setHabCode(rs.getString(3));
				pushkarform.setGhatType(rs.getString(4));
				pushkarform.setPushkarCode(rs.getString(5));
				pushkarform.setPreparedOn(rs.getString(6));
				pushkarform.setProposalName(rs.getString(8));
				pushkarform.setProposalId(rs.getString(9));
				pushkarform.setWorkType(rs.getString(10));
				pushkarform.setSanctionAmout(rs.getString(11));
				pushkarform.setAdminiStrativeNum(rs.getString(12));
				pushkarform.setAdminiStrativeDate(rs.getString(13));
				pushkarform.setTenderinvited(rs.getString(14));
				pushkarform.setTsno(rs.getString(15));
				pushkarform.setTenderaprvd(rs.getString(16));
				pushkarform.setTenderappamount(rs.getString(17));
				pushkarform.setAgreeconcluded(rs.getString(18));
				pushkarform.setAgreeamount(rs.getString(19));
				pushkarform.setPhysicaldetails(rs.getString(20));
				pushkarform.setWorkdonevalue(rs.getString(21));
				pushkarform.setWorkdonedate(rs.getString(22));
				pushkarform.setPrbleDateCompletion(rs.getString(23));
				pushkarform.setDateOfCompletion(rs.getString(24));
				pushkarform.setExpenditure(rs.getString(25));
				pushkarform.setRemarks(rs.getString(26));

				pushkarlist.add(pushkarform);

			}

		} catch (Exception e) {
			Debug.writeln("Exception in pushkarview : \n" + e);
			
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				}
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return pushkarlist;
	}

	public ArrayList pushkarget(String proposalId, String habid)
			throws Exception {
		ArrayList pushkarlist = new ArrayList();;
		Rws_PushkarWorkForm pushkarform = null;
		
		String query = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			

			conn = RwsOffices.getConn();
			
			query = "select A.PROGRAMME_CODE,A.SUBPROGRAMME_CODE,HABITATION_CODE,GHAT_TYPE,PUSHKAR_CODE,to_char(PREPARED_ON,'dd/mm/yyyy'),UPDATE_DATE,WORK_NAME,WORK_ID,WORK_TYPE,ADMIN_AMOUNT,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy'),TENDER_INVITED,TENDER_AMOUNT,TENDER_APPROVED,TENDER_APPROVED_AMT,AGREE_CONCLUDE,AGREE_CONCLUDE_AMT,PHYSICAL_STAGE,VALUE_OF_WORK_DONE,PERCENTAGE_WORK_DONE,to_char(PROBABLE_DATE_OF_COMP,'dd/mm/yyyy'),to_char(WORK_COMPL_DATE,'dd/mm/yyyy'),EXP_ON_WORK,REMARKS,PROGRAMME_NAME,SUBPROGRAMME_Name,PANCH_NAME,MNAME,PNAME,E.CIRCLE_OFFICE_CODE,E.CIRCLE_OFFICE_NAME,F.DIVISION_OFFICE_NAME,G.SUBDIVISION_OFFICE_NAME,F.DIVISION_OFFICE_CODE,G.SUBDIVISION_OFFICE_CODE from RWS_PUSHKAR_WORK_TBL A,RWS_COMPLETE_HAB_VIEW B,RWS_PROGRAMME_TBL C,RWS_SUBPROGRAMME_TBL D,RWS_CIRCLE_OFFICE_TBL E,RWS_DIVISION_OFFICE_TBL F,RWS_SUBDIVISION_OFFICE_TBL G where WORK_ID=?"
					+ " AND A.HABITATION_CODE=B.PANCH_CODE AND A.PROGRAMME_CODE=C.PROGRAMME_CODE AND A.SUBPROGRAMME_CODE=D.SUBPROGRAMME_CODE AND A.PROGRAMME_CODE=D.PROGRAMME_CODE AND SUBSTR(A.OFFICE_CODE,2,2)=E.CIRCLE_OFFICE_CODE AND E.CIRCLE_OFFICE_CODE=F.CIRCLE_OFFICE_CODE AND F.DIVISION_OFFICE_CODE=SUBSTR(OFFICE_CODE,4,1) AND E.CIRCLE_OFFICE_CODE=G.CIRCLE_OFFICE_CODE AND F.DIVISION_OFFICE_CODE=G.DIVISION_OFFICE_CODE AND G.SUBDIVISION_OFFICE_CODE=SUBSTR(OFFICE_CODE,5,2) ";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, proposalId);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				pushkarform = new Rws_PushkarWorkForm();

				pushkarform.setPrograms(rs.getString(1));
				pushkarform.setSubPrograms(rs.getString(2));
				pushkarform.setHabCode(rs.getString(3));
				pushkarform.setGhatType(rs.getString(4));
				pushkarform.setPushkarCode(rs.getString(5));
				pushkarform.setPreparedOn(rs.getString(6));

				pushkarform.setProposalName(rs.getString(8));
				pushkarform.setProposalId(rs.getString(9));
				pushkarform.setWorkType(rs.getString(10));
				pushkarform.setSanctionAmout(rs.getString(11));
				pushkarform.setAdminiStrativeNum(rs.getString(12));
				pushkarform.setAdminiStrativeDate(rs.getString(13));
				pushkarform.setTenderinvited(rs.getString(14));
				pushkarform.setTsno(rs.getString(15));
				pushkarform.setTenderaprvd(rs.getString(16));
				pushkarform.setTenderappamount(rs.getString(17));
				pushkarform.setAgreeconcluded(rs.getString(18));
				pushkarform.setAgreeamount(rs.getString(19));
				pushkarform.setPhysicaldetails(rs.getString(20));
				pushkarform.setWorkdonevalue(rs.getString(21));
				pushkarform.setWorkdonedate(rs.getString(22));
				pushkarform.setPrbleDateCompletion(rs.getString(23));
				pushkarform.setCompleteddate(rs.getString(24));
				pushkarform.setExpenditure(rs.getString(25));
				pushkarform.setRemarks(rs.getString(26));
				pushkarform.setProgramName(rs.getString(27));
				pushkarform.setSubProgramName(rs.getString(28));
				pushkarform.setHabName(rs.getString(29));
				pushkarform.setMandalName(rs.getString(30));
				pushkarform.setPanchayatName(rs.getString(31));
				pushkarform.setCircleOfficeCode(rs.getString(32));
				pushkarform.setCircleOfficeName(rs.getString(33));
				pushkarform.setDivisionOfficeCode(rs.getString(36));
				pushkarform.setSubdivisionOfficeCode(rs.getString(37));
				pushkarform.setDivisionOfficeName(rs.getString(34));
				pushkarform.setSubdivisionOfficeName(rs.getString(35));

				pushkarlist.add(pushkarform);

			}

		} catch (Exception e) {
			Debug.writeln("Exception in pushkarget : \n" + e);
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				}
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return pushkarlist;
	}

	public ArrayList gethabitations(String headOfficeCode,
			String circleOfficeCode, String mcode, String pcode)
			throws Exception {

		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;

		ResultSet rset = null;

		try {
			conn = RwsOffices.getConn();
			query = "select panch_code,panch_name from rws_complete_hab_view where dcode=? and mcode=? and  pcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				habitations.add(labelValueBean);
			}

		} catch (Exception e) {
			Debug.writeln("Exception in gethabitations : \n" + e);
		}

		finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;
	}

	public ArrayList getpushkarcode(String circleOfficeCode, String mcode,
			String pcode) throws Exception {

		ArrayList pushkar = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;

		try {
			conn = RwsOffices.getConn();
			query = "select PUSHKAR_CODE,PUSHKAR_NAME  FROM RWS_PUSHKAR_GHAT_TBL WHERE DCODE=? and mcode=? and pcode=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				pushkar.add(labelValueBean);
			}

		} catch (Exception e) {
			Debug.writeln("Exception in getpushkarcode : \n" + e);
		}

		finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return pushkar;

	}

	public ArrayList getProgrammes1(String plan, String wrkType, String workCat)
			throws Exception {
		
		ArrayList programmes = new ArrayList();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select programme_code,programme_name from rws_programme_tbl "
					+ "where programme_code in('80','74') "
					+ "  order by programme_code,programme_name";

			ps = conn.prepareStatement(query);
			rset = ps.executeQuery(query);
			while (rset.next()) {
				
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				programmes.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getting getProgrammes1" + e.getMessage());
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return programmes;
	}

	public ArrayList getSubprogrammes(String programmeCode) throws Exception {
		ArrayList subprogrammes = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;

		try {
			query = " SELECT subprogramme_code, subprogramme_name "
					+ " FROM rws_subprogramme_tbl WHERE programme_code=?"
					+ " ORDER BY subprogramme_name ";
			
			if (dataSource != null)
				conn = RwsOffices.getConn();

			ps = conn.prepareStatement(query);
			ps.setString(1, programmeCode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				subprogrammes.add(labelValueBean);
			}
		}
		catch (Exception e) {
			Debug.println("Exception in getting getSubprogrammes" + e.getMessage());
		} 
		finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return subprogrammes;
	}

	public ArrayList getMandals(String circlecode) throws Exception {

		ArrayList mtenderMemo = null;
		String query = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		try {
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL where dcode=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, circlecode);
			rs = ps.executeQuery();

			LabelValueBean dto = null;
			mtenderMemo = new ArrayList();
			while (rs.next()) {
				dto = new LabelValueBean();
				dto.setValue(rs.getString(2));
				dto.setLabel(rs.getString(3));
				mtenderMemo.add(dto);

			}
		} catch (Exception e) {
			Debug.println("Exception in getMandals() " + e);
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		
		return mtenderMemo;
	}

	public ArrayList getSanctionedHabs(String coc) {
		ArrayList habitations = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try {
			String query = "";

			query = "select HABITATION_CODE  from rws_pushkar_work_tbl where source_code='"
					+ coc + "' ";

			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {

				habitations.add(rset.getString(1));
				
			}

		} catch (Exception e) {
			Debug.println("Exception in  getMandals() " + e);
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;
	}
	public ArrayList getAdminStrativeHabitations(String proposalId, String officeCode, String search,String[] mcodes,String all) 
			throws Exception
			{ 
				RwsLocationBean rwsLocation=null;
				ArrayList habitations = new ArrayList(); 
			String scheme=proposalId.substring(4,6);
			
			String qq="";
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			if(all.equals("yes"))
			{
			try{
					if(officeCode == null)
						officeCode = "000000";
			
			
					String circleOfficeCode = proposalId.substring(4,6);
			
					conn = RwsOffices.getConn();

					
					 qq="select * from RWS_ADMIN_HABS_PICK_VIEW where circle_office_code = ?";
			
			        pstmt = conn.prepareStatement(qq);
					pstmt.setString(1, circleOfficeCode);
				rs = pstmt.executeQuery();
				pstmt.setFetchSize(3000);
			 	rs.setFetchSize(300);
			  
				while(rs.next())
				{
					
				
					rwsLocation = new RwsLocationBean();
					rwsLocation.setProposalId(proposalId);
					rwsLocation.setAssemblyCode(rs.getString(1));
					rwsLocation.setAssemblyName(rs.getString(2));
					rwsLocation.setMandalName(rs.getString(3));
				 	rwsLocation.setHabCode(rs.getString(4));
					rwsLocation.setHabName(rs.getString(5));
					rwsLocation.setPopulation(rs.getString(6));
					rwsLocation.setStatus(rs.getString(7));
					habitations.add(rwsLocation);
					
				}
			}
			catch (Exception e) {
				Debug.println("Exception in  getMandals() " + e);
			} finally {
				if (rs != null) {
					try {
						if (rs != null)
							rs.close();
					} catch (SQLException sqle) {
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				}
				if (conn != null) {
					try {
						if (conn != null)
							conn.close();
					} catch (SQLException sqle) {
					}
				}
			}
			}
		return habitations;
	}
	public String[] getMandalCodesFormAdmn(String proposalId)throws Exception 
	{
		Connection conn=null;
		String[] mcodes={};
		String q="";
		ResultSet rs=null;
		PreparedStatement pstmt=null,pstmt1=null;
		try
		{
			String code=proposalId;
			
		   conn=RwsOffices.getConn();
		   
		
		  q="select distinct substr(panch_code,6,2) from rws_complete_hab_view  where dcode=?";
		
		  pstmt=conn.prepareStatement(q);
		  pstmt.setString(1, code);
		  rs=pstmt.executeQuery();
		  int count = 0;
		  
		  while(rs.next())
		  {
		  	count++;
		  }
		  rs.close();
		  mcodes=new String[count];
		
		  q="select distinct substr(panch_code,6,2) from rws_complete_hab_view  where dcode=?";
		  pstmt1=conn.prepareStatement(q);
		  pstmt1.setString(1, code);
		  rs=pstmt1.executeQuery();
		  int i=0;
		  while(rs.next())
		  {
		  	if(rs.getString(1)!=null)
		  	{
		  	mcodes[i]=rs.getString(1);
		  	i++;
		  	}
		  }
			
		}
		catch (Exception e) {
			Debug.println("Exception in  getMandalCodesFormAdmn() " + e);
		} finally {
			if (rs != null) {
				try {
					if (rs != null)
						rs.close();
				} catch (SQLException sqle) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException sqle) {
				}
			}
			if (pstmt1 != null) {
				try {
					pstmt1.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
			}
		return mcodes;
		}
}
