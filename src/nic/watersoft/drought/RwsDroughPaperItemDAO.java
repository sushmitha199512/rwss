package nic.watersoft.drought;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.RwsOffices;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsDroughPaperItemDAO {

	/**
	 * 
	 * @param rwsDroughtNewsItemForm
	 * @param request
	 * @return
	 */
	public ArrayList getHabitaionsData(
			RwsDroughtNewsItemForm rwsDroughtNewsItemForm,
			HttpServletRequest request,ActionServlet servletctrx) {

		ArrayList habData = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			int recCount = 0;
			int slNoCount=0;
			conn = RwsOffices.getConn();
			String district=rwsDroughtNewsItemForm.getDistrict();
			String mandal=rwsDroughtNewsItemForm.getMandal();
			String panchayat=rwsDroughtNewsItemForm.getPanchayat();
			String village=rwsDroughtNewsItemForm.getVillage();
			String habitation=rwsDroughtNewsItemForm.getHabitation();
			String sqlQuery ="";
			
			if(district.equals("")&&mandal.equals("")&&panchayat.equals("")&&
					village.equals("")&&habitation.equals("")){		
				request.setAttribute("level", "State");
				
				sqlQuery = "select distinct CLIP_LEVEL,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'') from rws_drought_newspaper_item_tbl  where CLIP_LEVEL=? and DCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy')";
				
				
				
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, rwsDroughtNewsItemForm.getLevel());
			pstmt.setString(2, "00");
			pstmt.setString(3, rwsDroughtNewsItemForm.getPaperDt());
				
				rs = pstmt.executeQuery();

				
				if (rs.next()) {
					rs = pstmt.executeQuery();
					while (rs.next()) {
					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					
					rwsDroughPaperItemRecord.setPaperDate(rs.getString(2));
					rwsDroughPaperItemRecord.setPaperName(rs.getString(3));
					rwsDroughPaperItemRecord.setPaperEdition(rs.getString(4));
					rwsDroughPaperItemRecord.setPaperNews(rs.getString(5));
					rwsDroughPaperItemRecord.setActionReport((rs.getString(6)));
					rwsDroughPaperItemRecord.setRemarks(rs.getString(7));
					rwsDroughPaperItemRecord.setIsSavedRecord("yes");
					rwsDroughPaperItemRecord.setChecks("on");
					rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(8),rs.getString(2),false,servletctrx));
					rwsDroughPaperItemRecord.setNewsId(rs.getString(8));
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(9));
					rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				/*	rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,actionServlet));
					rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,actionServlet));*/
					

					habData.add(rwsDroughPaperItemRecord);
					}
					
					
				}
				else{
					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					
					rwsDroughPaperItemRecord.setPaperDate("");
					rwsDroughPaperItemRecord.setPaperName("");
					rwsDroughPaperItemRecord.setPaperEdition("");
					rwsDroughPaperItemRecord.setPaperNews("");
					rwsDroughPaperItemRecord.setActionReport("");
					rwsDroughPaperItemRecord.setRemarks("");
					rwsDroughPaperItemRecord.setIsSavedRecord("");
					rwsDroughPaperItemRecord.setChecks("");
					rwsDroughPaperItemRecord.setScannedCopyStatus("no");
					rwsDroughPaperItemRecord.setNewsId("");
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
					rwsDroughPaperItemRecord.setAtrimageStatus("no");
					/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,servletctrx));
					rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));*/

					habData.add(rwsDroughPaperItemRecord);
				}
				slNoCount=recCount+1;
				request.setAttribute("slNoCount", slNoCount);
				
				
			}
			else if(!district.equals("")&&!district.equals(null)
					&&mandal.equals("")&&panchayat.equals("")
					&&village.equals("")&&habitation.equals("")){
			
				sqlQuery = "select distinct a.DCODE,a.DNAME,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.DCODE=a.dcode  and b.DCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') AND CLIP_LEVEL=?";
			
			pstmt = conn.prepareStatement(sqlQuery);
			
			pstmt.setString(1, district);
			pstmt.setString(2, rwsDroughtNewsItemForm.getPaperDt());
			pstmt.setString(3, rwsDroughtNewsItemForm.getLevel());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				rs = pstmt.executeQuery();
				while (rs.next()) {

					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
					rwsDroughPaperItemRecord.setPaperDate(rs.getString(3));
					rwsDroughPaperItemRecord.setPaperName(rs.getString(4));
					rwsDroughPaperItemRecord.setPaperEdition(rs.getString(5));
					rwsDroughPaperItemRecord.setPaperNews(rs.getString(6));
					rwsDroughPaperItemRecord.setActionReport(rs.getString(7));
					rwsDroughPaperItemRecord.setRemarks(rs.getString(8));
					rwsDroughPaperItemRecord.setIsSavedRecord("yes");
					rwsDroughPaperItemRecord.setChecks("on");
					rwsDroughPaperItemRecord.setNewsId(rs.getString(9));
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(10));
					rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(9),rs.getString(3),false,servletctrx));
					rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(9),rs.getString(3),true,servletctrx));
					//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
					/*updatePapperData(rwsDroughPaperItemRecord,
							rwsDroughtNewsItemForm,conn);*/

					habData.add(rwsDroughPaperItemRecord);

				}
				
			}
			
			else{

				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME from  rws_complete_hab_view  where DCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport((""));
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,servletctrx));
				rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
*/				/*updatePapperData(rwsDroughPaperItemRecord,
						rwsDroughtNewsItemForm,conn);*/

				habData.add(rwsDroughPaperItemRecord);
			}
			
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&panchayat.equals("")&&village.equals("")&&habitation.equals("")){
			
			sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.MCODE=a.MCODE  and b.DCODE=a.DCODE  and b.DCODE=? and b.MCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
			
			pstmt = conn.prepareStatement(sqlQuery);

			pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
			pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
			pstmt.setString(3, rwsDroughtNewsItemForm.getPaperDt());
			pstmt.setString(4, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(5));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(6));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(8));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(9));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(10));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(11));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(12));
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(11),rs.getString(5),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(11),rs.getString(5),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME from rws_complete_hab_view  where DCODE=? and MCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,servletctrx));
				rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));*/
				habData.add(rwsDroughPaperItemRecord);
			}
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&village.equals("")&&habitation.equals("")){
			
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.PCODE=a.PCODE  and b.DCODE=a.DCODE  and b.MCODE=a.MCODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
			
			pstmt = conn.prepareStatement(sqlQuery);

			pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
			pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
			pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
			pstmt.setString(4, rwsDroughtNewsItemForm.getPaperDt());
			pstmt.setString(5, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(8));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(9));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(10));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(11));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(12));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(13));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(14));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(13),rs.getString(7),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(13),rs.getString(7),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,request));
				rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,request));*/
				habData.add(rwsDroughPaperItemRecord);
			}
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&!village.equals("")&&!village.equals(null)
					&&habitation.equals("")){
			
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and b.VCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
			
			pstmt = conn.prepareStatement(sqlQuery);

			pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
			pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
			pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
			pstmt.setString(4, rwsDroughtNewsItemForm.getVillage());
			pstmt.setString(5, rwsDroughtNewsItemForm.getPaperDt());
			pstmt.setString(6, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setVillageName(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(9));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(10));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(11));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(12));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(13));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(14));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(15));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(16));
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(15),rs.getString(9),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(15),rs.getString(9),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,request));
				rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,request));*/
				habData.add(rwsDroughPaperItemRecord);
			}
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&!village.equals("")&&!village.equals(null)
					&&!habitation.equals("")&&!habitation.equals(null)){
				/*sqlQuery = "select distinct DNAME,DCODE,MNAME,MCODE,PCODE,PNAME,VNAME,VCODE,PANCH_CODE,PANCH_NAME from  rws_complete_hab_view where DCODE=? and MCODE=? and PCODE=? and VCODE=? and PANCH_CODE=?";*/
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,a.PANCH_NAME,a.PANCH_CODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.HAB_CODE=a.PANCH_CODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and b.VCODE=? and b.HAB_CODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
			
			pstmt = conn.prepareStatement(sqlQuery);

			pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
			pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
			pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
			pstmt.setString(4, rwsDroughtNewsItemForm.getVillage());
			pstmt.setString(5, rwsDroughtNewsItemForm.getHabitation());
			pstmt.setString(6, rwsDroughtNewsItemForm.getPaperDt());
			pstmt.setString(7, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setVillageName(rs.getString(7));
				rwsDroughPaperItemRecord.setHabName(rs.getString(9));
				rwsDroughPaperItemRecord.setHabCode(rs.getString(10));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(11));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(12));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(13));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(14));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(15));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(16));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(17));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(18));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(17),rs.getString(11),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(17),rs.getString(11),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_NAME,PANCH_CODE from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=? and PANCH_CODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				preparedStatement.setString(5, habitation);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
					rwsDroughPaperItemRecord.setHabName(resultSet.getString(9));
					rwsDroughPaperItemRecord.setHabCode(resultSet.getString(10));
				}
				
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),false,request));
				rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,request));*/
				habData.add(rwsDroughPaperItemRecord);
			}
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			}
			
			

		} catch (Exception e) {
			e.printStackTrace();
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
				e.printStackTrace();
			}

		}
		return habData;

	}

	/**
	 * 
	 * @param rwsDroughPaperItemRecord
	 * @param rwsDroughtNewsItemForm
	 */

	

	/**
	 * 
	 * @param rwsDroughtNewsItemForm
	 * @param request
	 * @param session
	 */
	public String saveHabitaionsData(
			RwsDroughtNewsItemForm rwsDroughtNewsItemForm,
			HttpServletRequest request, HttpSession session,String targetPath,String targetPath1,ActionServlet actionServlet) {

		ArrayList<RwsDroughPaperItemRecord> habData = (ArrayList) rwsDroughtNewsItemForm.getHabData();
		Connection conn = null;
		PreparedStatement pstmt = null, updatePstmt = null;
		ResultSet rs = null;
		String habcode=null;
		String message="";
		int newsIDno=0;
		try {
			conn = RwsOffices.getConn();
			String district=rwsDroughtNewsItemForm.getDistrict();
			String mandal=rwsDroughtNewsItemForm.getMandal();
			String panchayat=rwsDroughtNewsItemForm.getPanchayat();
			String village=rwsDroughtNewsItemForm.getVillage();
			String habitation=rwsDroughtNewsItemForm.getHabitation();
			String sqlQuery = "",finalNewsId="";
			//System.out.println("scanned copy"+fpath);
			
			

			//String updatesqlQuery = "update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=? where hab_code=?";
		//	updatePstmt = conn.prepareStatement(updatesqlQuery);

			int i = 0;
			int selectedCount = 0;
			FileOutputStream outputStream = null,outputStream1 = null;
			FormFile formFile = null,formFile1=null;
			FileInputStream fis = null,fis1 = null;
			File scannedFile = null,scannedFile1 = null;
			File targetFile = null,targetFile1 = null;
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			String selectedNewsId = request.getParameter("newsId");
			
			//System.out.println("hab data len :"+habData.size());
			for (i=0;i < habData.size();i++) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = habData
						.get(i);
				//System.out.println("checks :"+rwsDroughPaperItemRecord.isChecked());
				if((selectedNewsId != null && !selectedNewsId.isEmpty() && selectedNewsId.equals(rwsDroughPaperItemRecord.getNewsId())) || rwsDroughPaperItemRecord.getScannedCopyStatus().equals("no")){
					//System.out.println("checked items :"+rwsDroughPaperItemRecord.getActionReport());
				
				formFile=rwsDroughPaperItemRecord.getScannedCopy();
				
				//if(!formFile.getFileName().equals("") && formFile.getFileName()!=null){
					//System.out.println("getFileName-------"+formFile.getFileName());
					String s=rwsDroughPaperItemRecord.getPaperDate();
					 String tdsfy1[]=s.split("/");
						String s1 = tdsfy1[0];
						String s2 = tdsfy1[1];
						String s3 = tdsfy1[2];
						s=s1+s2+s3.substring(2,4);
						
					String maxvalueQuery="select nvl(max(substr(NEWS_ID,9,3)),0) from rws_drought_newspaper_item_tbl where substr(NEWS_ID,3,6)='"+s+"'";
					
						Statement statement=conn.createStatement();
						ResultSet resultSet=statement.executeQuery(maxvalueQuery);
						if(resultSet.next()){
							if(resultSet.getInt(1)!=0){
							newsIDno=resultSet.getInt(1);
							newsIDno++;
							
							}
							else{
								newsIDno=101;
								
							}
						}
						
				 
				/*if (rwsDroughPaperItemRecord.getChecks() != null
						&& rwsDroughPaperItemRecord.getChecks().equals("on")) {*/
					String newsId1=rwsDroughPaperItemRecord.getNewsId();
					//System.out.println("exists news id :"+newsId1);
					//System.out.println("length"+rwsDroughPaperItemRecord.getChecks().length());
					if(district.equals("")&&mandal.equals("")&&panchayat.equals("")&&
							village.equals("")&&habitation.equals("")){
						
						if(!isExists(newsId1,conn)){
							
							String paperDate=rwsDroughPaperItemRecord.getPaperDate();
							 String tdsfy[]=paperDate.split("/");
								String paperDatedd = tdsfy[0];
								String paperDatemm = tdsfy[1];
								String paperDateyyyy = tdsfy[2];
							 String newId="00"+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
							
						/*sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,CLIP_LEVEL,NEWS_ID,DCODE,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";*/
							 sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
										+ "ACTION_TAKEN,REMARKS,CLIP_LEVEL,NEWS_ID,DCODE,"
										+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?)";
						
						pstmt = conn.prepareStatement(sqlQuery);
						
						finalNewsId = newId;
						pstmt.setString(7, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(8, newId);
						pstmt.setString(9, "00");
						pstmt.setString(10, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							/*sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where CLIP_LEVEL=? and NEWS_ID=? and DCODE=?";*/
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where CLIP_LEVEL=? and NEWS_ID=? and DCODE=?";
							pstmt = conn.prepareStatement(sqlQuery);
							
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, rwsDroughtNewsItemForm
									.getLevel());
							pstmt.setString(9, newsId1);
							pstmt.setString(10, "00");
							//System.out.println("sqlQuery :"+sqlQuery);
						}
						
					}
					else if(!district.equals("")&&!district.equals(null)
							&&mandal.equals("")&&panchayat.equals("")
							&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
							//System.out.println("inside district leval"+district+"@@@@@@@"+rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
					 /*	sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
					 			+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,DCODE,NEWS_ID,CLIP_LEVEL,"
					 			+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";*/
							sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
						 			+ "ACTION_TAKEN,REMARKS,DCODE,NEWS_ID,CLIP_LEVEL,"
						 			+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?)";
					 	
					 	finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, district);
						pstmt.setString(8, newId);
						pstmt.setString(9, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(10, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							//System.out.println("inside district leval UPDATE"+district+"@@@@@@@"+rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							/*sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where DCODE=? and NEWS_ID=? and CLIP_LEVEL=?";*/
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where DCODE=? and NEWS_ID=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, district);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, rwsDroughtNewsItemForm
									.getLevel());
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&panchayat.equals("")&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						/*sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,MCODE,NEWS_ID,DCODE,CLIP_LEVEL,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?)";*/
						 sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
									+ "ACTION_TAKEN,REMARKS,MCODE,NEWS_ID,DCODE,CLIP_LEVEL,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?)";
						
						finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, mandal);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(11, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							/*sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,"
									+ "EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where MCODE=? and NEWS_ID=? and DCODE=? and CLIP_LEVEL=?";*/
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,"
									+ "EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where MCODE=? and NEWS_ID=? and DCODE=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, mandal);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, rwsDroughtNewsItemForm
									.getLevel());
							
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,"
								+ "PAPER_NEWS,ACTION_TAKEN,REMARKS,PCODE,NEWS_ID"
								+ ",DCODE,MCODE,CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";
						pstmt = conn.prepareStatement(sqlQuery);
						finalNewsId = newId;
						pstmt.setString(7, panchayat);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(12, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? "
									+ ",PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where PCODE=? and NEWS_ID=? and DCODE=? and MCODE=?"
									+ " and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, panchayat);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, mandal);
							pstmt.setString(12, rwsDroughtNewsItemForm
									.getLevel());
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&!village.equals("")&&!village.equals(null)
							&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,VCODE,NEWS_ID,DCODE,MCODE,PCODE,"
								+ "CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?)";
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						pstmt = conn.prepareStatement(sqlQuery);
						
						finalNewsId = newId;
						pstmt.setString(7, village);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, panchayat);
						pstmt.setString(12, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(13, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?"
									+ ",EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where VCODE=? and NEWS_ID=? and DCODE=? and MCODE=? "
									+ "and PCODE=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, village);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, mandal);
							pstmt.setString(12, panchayat);
							pstmt.setString(13, rwsDroughtNewsItemForm
									.getLevel());
							
							
						}
						
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&!village.equals("")&&!village.equals(null)
							&&!habitation.equals("")&&!habitation.equals(null)){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS"
								+ ",ACTION_TAKEN,REMARKS,HAB_CODE,NEWS_ID,DCODE,MCODE,"
								+ "PCODE,VCODE,CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?,?)";
						finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, habitation);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, panchayat);
						pstmt.setString(12, village);
						pstmt.setString(13, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(14, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
					}
					else{
						
						sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
								+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM=? where VCODE=? and NEWS_ID=? and DCODE=? and MCODE=? and "
								+ "PCODE=? and VCODE=? and CLIP_LEVEL=?";
						pstmt = conn.prepareStatement(sqlQuery);
						finalNewsId = newsId1;
						pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						pstmt.setString(8, habitation);
						pstmt.setString(9, newsId1);
						pstmt.setString(10, district);
						pstmt.setString(11, mandal);
						pstmt.setString(12, panchayat);
						pstmt.setString(13, village);
						pstmt.setString(14, rwsDroughtNewsItemForm
								.getLevel());
					}
					}
					//System.out.println("rwsDroughPaperItemRecord.getPaperDate()"+rwsDroughPaperItemRecord.getPaperDate());
					pstmt.setString(1, rwsDroughPaperItemRecord
							.getPaperDate());
					pstmt.setString(2, rwsDroughPaperItemRecord
							.getPaperName());
					pstmt.setString(3, rwsDroughPaperItemRecord
							.getPaperEdition());
					pstmt.setString(4, rwsDroughPaperItemRecord
							.getPaperNews());
					if(!rwsDroughPaperItemRecord.getActionReport().equals("") && rwsDroughPaperItemRecord.getActionReport()!=null){
					pstmt.setString(5, rwsDroughPaperItemRecord
							.getActionReport());
					}
					else{
						pstmt.setString(5, "");
					}
					pstmt.setString(6, rwsDroughPaperItemRecord
							.getRemarks());
					
					
					
						
						/*String fileName = rwsDroughPaperItemRecord.getScannedCopy();*/
						
						formFile=rwsDroughPaperItemRecord.getScannedCopy();
						
						if (formFile != null && formFile.getFileSize() != 0) {
							try {
								String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
								if(!mimeType.equalsIgnoreCase("image/jpeg"))
								{
									message="Allowed only jpg file extensions only.";
									return message;
								}
								String path = actionServlet
										.getServletContext()
										.getRealPath("")
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
								
								if (!documentSanitizerImpl.madeSafe(scannedFile)) {
									message = "Paper Clipping Scanned Copy File is Corrupted";
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
								System.out.println("exception in rwsdroughtpaperitem saveHabitaionsData -- "+e);
//								e.printStackTrace();
							} finally {
								if (fis != null) {
									// fis.close();
								}
							}

							// System.out.println("File Size:"
							// + tenderMemoBean.getPassOrderScanCopy()
							// .getFileSize());
							double fileSizeMB = ((rwsDroughPaperItemRecord.getScannedCopy().getFileSize() / 1024.0) / 1024.0);

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
							/*pstmt.setBinaryStream(7, fis,
									(int) targetFile.length());*/
						
							 String paperDateTemp[]=rwsDroughPaperItemRecord.getPaperDate().split("/");
							 
								String paperDatedd = paperDateTemp[0];
								String paperDatemm = paperDateTemp[1];
								String paperDateyyyy = paperDateTemp[2];
								
							//String commonPath = actionServlet.getServletContext().getRealPath("/");
							//System.out.println("commonPath" + commonPath);
							String paperDate = rwsDroughPaperItemRecord.getPaperDate().replace("/", "-");
							//String imagePath=actionServlet.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate;
							String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
							if(!mimeType.equalsIgnoreCase("image/jpeg"))
							{
								message="Allowed only jpg file extensions only.";
								return message;
							}
							String imagePath=actionServlet.getServletContext().getRealPath("/") ;
							 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
								 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
								 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }else{
								 String sample[]  = imagePath.split( "webapps");
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }
							 imagePath = imagePath+ File.separator+"NewsPaperClippingImages"+ File.separator + paperDate;
						
							//System.out.println("imagePath  " + imagePath);
							File myFilesDir = new File(imagePath);
							if (!myFilesDir.exists())
								myFilesDir.mkdirs();
							
							
							imagePath = imagePath + File.separator ;
							//System.out.println("news paper imagePath----"+imagePath);
							File filepath = new File(imagePath);
							
							File filepathisExits = new File(filepath+File.separator+finalNewsId+".jpg");
							if(filepathisExits.getAbsoluteFile().exists()){
								filepathisExits.delete();
							}
							 byte[] readData = new byte[1024];
								FileOutputStream fout=new FileOutputStream(filepath+File.separator+finalNewsId+".jpg"); 	
								//System.out.println("news paper imagePath----"+(filepath+"\\"+finalNewsId+".jpg"));
								int k = fis.read(readData);
							      while (k != -1) {
							    	  fout.write(readData, 0, k);
							        k = fis.read(readData);
							      }
							      
							     /* byte[] buffer = new byte[1024];
							      while (true) {
							        int bytesRead = fis.read(buffer);
							        if (bytesRead == -1)
							          break;
							        fout.write(buffer, 0, bytesRead);
							      }*/
							    //fout.write(targetFile);  				            
							    fout.close();
							
							pstmt.addBatch();
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
							
							//selectedCount++;
							
						//} 
						
						 
						
						
						

				}else if(!rwsDroughPaperItemRecord.getScannedCopyStatus().equals("no")){
					//System.out.println("in else if scanned copy status :"+rwsDroughPaperItemRecord.getScannedCopyStatus());
					pstmt.addBatch();
				}
						formFile1=rwsDroughPaperItemRecord.getAtrScannedCopy();
					//	System.out.println("formFile1---"+formFile1.getFileSize());
						
						if (formFile1 != null && formFile1.getFileSize()!=0) {
						//	System.out.println("inside if");
							try {
								String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
								if(!mimeType.equalsIgnoreCase("image/jpeg"))
								{
									message="Allowed only jpg file extensions only.";
									return message;
								}
								String path = actionServlet
										.getServletContext()
										.getRealPath("")
										+ formFile1.getFileName();
								//System.out.println("path"+path);

								scannedFile1 = new File(path);
								outputStream1 = new FileOutputStream(
										scannedFile1);
								if (outputStream1 != null) {
									outputStream1.write(formFile1
											.getFileData());
								}

								/**
								 * Compressing the image
								 */

								targetFile1 = new File(targetPath1);
								
								if (!documentSanitizerImpl.madeSafe(scannedFile1)) {
									message = "ATR Scanned Copy File is Corrupted";
									conn.setAutoCommit(true);
									scannedFile1.delete();
									outputStream1.close();
									targetFile1.delete();
									return message;
								} 

								compressImage(scannedFile1, targetFile1);

								fis1 = new FileInputStream(targetFile1);
								if (fis1 != null) {
								}
							} catch (Exception e) {
								e.printStackTrace();
							} finally {
								if (fis1 != null) {
									// fis.close();
								}
							}

							// System.out.println("File Size:"
							// + tenderMemoBean.getPassOrderScanCopy()
							// .getFileSize());
							double fileSizeMB = ((rwsDroughPaperItemRecord.getAtrScannedCopy().getFileSize() / 1024.0) / 1024.0);

							// System.out.println("After fileSizeMB:"+fileSizeMB);
							if (fileSizeMB > 0.2) {
								message = "ATR Scanned Copy File Size Shoud Not Be Allowed More Than 200 KB";
								conn.setAutoCommit(true);
								scannedFile1.delete();
								outputStream1.close();
								targetFile1.delete();
								return message;

							}
							// fis =
							// getFileInputStream(tenderMemoBean.getPassOrderScanCopy());
					//		System.out.println("targetFile1.length()---"+targetFile1.length());
							/*pstmt.setBinaryStream(7, fis1,
									(int) targetFile1.length());*/
							
							String paperDate = rwsDroughPaperItemRecord.getPaperDate().replace("/", "-");
							//String imagePath=actionServlet.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate;
							String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
							if(!mimeType.equalsIgnoreCase("image/jpeg"))
							{
								message="Allowed only jpg file extensions only.";
								return message;
							}
							String imagePath=actionServlet.getServletContext().getRealPath("/") ;
							 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
								 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }else{
								 String sample[]  = imagePath.split( "webapps");
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }
							 imagePath = imagePath+ File.separator+"NewsPaperClippingImages"+ File.separator + paperDate;
						
							
							File myFilesDir = new File(imagePath); 
							if (!myFilesDir.exists())
								myFilesDir.mkdirs();
							
							
							imagePath = imagePath + File.separator ;
							//System.out.println("news paper imagePath----"+imagePath);
							File filepath = new File(imagePath);
							
							File filepathisExits = new File(filepath+File.separator+"ACT_"+finalNewsId+".jpg");
							if(filepathisExits.getAbsoluteFile().exists()){
								filepathisExits.delete();
							}
							 byte[] readData = new byte[1024];
								FileOutputStream fout=new FileOutputStream(filepath+File.separator+"ACT_"+finalNewsId+".jpg"); 	
								//System.out.println("news paper imagePath----"+(filepath+"\\"+"ACT_"+finalNewsId+".jpg"));
								int k = fis1.read(readData);
							      while (k != -1) {
							    	  fout.write(readData, 0, k);
							        k = fis1.read(readData);
							      }
							      
							    fout.close();
							
							
							//pstmt.addBatch();
							if (scannedFile1 != null) {
								scannedFile1.delete();

							}
							if (targetFile1 != null) {
								targetFile1.delete();
							}
							if (outputStream1 != null) {
								// outputStream.close();
							}
							if (fis1 != null) {
								// fis.close();
							}
							
							//selectedCount++;
							
						//} 
			

				}
						
						/*else{
						//	System.out.println("inside else");
							//pstmt.setBinaryStream(7, fis1,(int) 0);
							
							//pstmt.addBatch();
						}*/
						selectedCount++;
			//}
			}
			}

			
			//System.out.println("saving or updating queries :"+pstmt.getFetchSize());
			int rec[] = pstmt.executeBatch();
			//System.out.println("rec  items :"+rec.toString());
			 /*for(int k=0;k<rec.length;k++){
	                System.out.println("Query "+k+" has effected "+rec[k]+" times");
	            }*/
			//System.out.println("saving or updating sizes :"+rec.length+" len :"+selectedCount);
			if (rec.length == selectedCount) {
				
				
				message="Saved Succesfully";
				
			} else {
				
				message="Failed";
				
			}
			
			

		} catch (Exception e) {
			System.out.println("exception in rwsdroughtpaperitem save form -- "+e );
			//e.printStackTrace();
		} finally {
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
				//e.printStackTrace();
			}

		}
		return message;
	}

/*	public String saveHabitaionsData(
			RwsDroughtNewsItemForm rwsDroughtNewsItemForm,
			HttpServletRequest request, HttpSession session,String targetPath,String targetPath1,ActionServlet actionServlet) {

		ArrayList<RwsDroughPaperItemRecord> habData = (ArrayList) rwsDroughtNewsItemForm.getHabData();
		Connection conn = null;
		PreparedStatement pstmt = null, updatePstmt = null;
		ResultSet rs = null;
		String habcode=null;
		String message="";
		int newsIDno=0;
		try {
			conn = RwsOffices.getConn();
			String district=rwsDroughtNewsItemForm.getDistrict();
			String mandal=rwsDroughtNewsItemForm.getMandal();
			String panchayat=rwsDroughtNewsItemForm.getPanchayat();
			String village=rwsDroughtNewsItemForm.getVillage();
			String habitation=rwsDroughtNewsItemForm.getHabitation();
			String sqlQuery = "",finalNewsId="";
			//System.out.println("scanned copy"+fpath);
			
			

			//String sqlQuery = "update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=? where hab_code=?";
		//	updatePstmt = conn.prepareStatement(updatesqlQuery);

			int i = 0;
			int selectedCount = 0;
			FileOutputStream outputStream = null,outputStream1 = null;
			FormFile formFile = null,formFile1=null;
			FileInputStream fis = null,fis1 = null;
			File scannedFile = null,scannedFile1 = null;
			File targetFile = null,targetFile1 = null;
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			String selectedNewsId = request.getParameter("newsId");
			
			//System.out.println("hab data len :"+habData.size());
			for (i=0;i < habData.size();i++) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = habData
						.get(i);
				//System.out.println("checks :"+rwsDroughPaperItemRecord.isChecked());
				if((selectedNewsId != null && !selectedNewsId.isEmpty() && selectedNewsId.equals(rwsDroughPaperItemRecord.getNewsId())) || rwsDroughPaperItemRecord.getScannedCopyStatus().equals("no")){
					//System.out.println("checked items :"+rwsDroughPaperItemRecord.getActionReport());
				
				formFile=rwsDroughPaperItemRecord.getScannedCopy();
				
				//if(!formFile.getFileName().equals("") && formFile.getFileName()!=null){
					//System.out.println("getFileName-------"+formFile.getFileName());
					String s=rwsDroughPaperItemRecord.getPaperDate();
					 String tdsfy1[]=s.split("/");
						String s1 = tdsfy1[0];
						String s2 = tdsfy1[1];
						String s3 = tdsfy1[2];
						s=s1+s2+s3.substring(2,4);
						
					String maxvalueQuery="select nvl(max(substr(NEWS_ID,9,3)),0) from rws_drought_newspaper_item_tbl where substr(NEWS_ID,3,6)='"+s+"'";
					
						Statement statement=conn.createStatement();
						ResultSet resultSet=statement.executeQuery(maxvalueQuery);
						if(resultSet.next()){
							if(resultSet.getInt(1)!=0){
							newsIDno=resultSet.getInt(1);
							newsIDno++;
							
							}
							else{
								newsIDno=101;
								
							}
						}
						
				 
				if (rwsDroughPaperItemRecord.getChecks() != null
						&& rwsDroughPaperItemRecord.getChecks().equals("on")) {
					String newsId1=rwsDroughPaperItemRecord.getNewsId();
					//System.out.println("exists news id :"+newsId1);
					//System.out.println("length"+rwsDroughPaperItemRecord.getChecks().length());
					if(district.equals("")&&mandal.equals("")&&panchayat.equals("")&&
							village.equals("")&&habitation.equals("")){
						
						if(!isExists(newsId1,conn)){
							
							String paperDate=rwsDroughPaperItemRecord.getPaperDate();
							 String tdsfy[]=paperDate.split("/");
								String paperDatedd = tdsfy[0];
								String paperDatemm = tdsfy[1];
								String paperDateyyyy = tdsfy[2];
							 String newId="00"+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
							
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,CLIP_LEVEL,NEWS_ID,DCODE,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";
							 sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
										+ "ACTION_TAKEN,REMARKS,CLIP_LEVEL,NEWS_ID,DCODE,"
										+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?)";
						
						pstmt = conn.prepareStatement(sqlQuery);
						
						finalNewsId = newId;
						pstmt.setString(7, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(8, newId);
						pstmt.setString(9, "00");
						pstmt.setString(10, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where CLIP_LEVEL=? and NEWS_ID=? and DCODE=?";
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where CLIP_LEVEL=? and NEWS_ID=? and DCODE=?";
							pstmt = conn.prepareStatement(sqlQuery);
							
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, rwsDroughtNewsItemForm
									.getLevel());
							pstmt.setString(9, newsId1);
							pstmt.setString(10, "00");
							//System.out.println("sqlQuery :"+sqlQuery);
						}
						
					}
					else if(!district.equals("")&&!district.equals(null)
							&&mandal.equals("")&&panchayat.equals("")
							&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
							//System.out.println("inside district leval"+district+"@@@@@@@"+rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
					 	sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
					 			+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,DCODE,NEWS_ID,CLIP_LEVEL,"
					 			+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";
							sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
						 			+ "ACTION_TAKEN,REMARKS,DCODE,NEWS_ID,CLIP_LEVEL,"
						 			+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?)";
					 	
					 	finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, district);
						pstmt.setString(8, newId);
						pstmt.setString(9, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(10, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							//System.out.println("inside district leval UPDATE"+district+"@@@@@@@"+rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where DCODE=? and NEWS_ID=? and CLIP_LEVEL=?";
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
									+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where DCODE=? and NEWS_ID=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, district);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, rwsDroughtNewsItemForm
									.getLevel());
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&panchayat.equals("")&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,CLIP_IMAGE,ATR_IMAGE,MCODE,NEWS_ID,DCODE,CLIP_LEVEL,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?)";
						 sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
									+ "ACTION_TAKEN,REMARKS,MCODE,NEWS_ID,DCODE,CLIP_LEVEL,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?)";
						
						finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, mandal);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(11, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,"
									+ "EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,CLIP_IMAGE=?,ATR_IMAGE=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where MCODE=? and NEWS_ID=? and DCODE=? and CLIP_LEVEL=?";
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,"
									+ "EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where MCODE=? and NEWS_ID=? and DCODE=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, mandal);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, rwsDroughtNewsItemForm
									.getLevel());
							
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&village.equals("")&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,"
								+ "PAPER_NEWS,ACTION_TAKEN,REMARKS,PCODE,NEWS_ID"
								+ ",DCODE,MCODE,CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?)";
						pstmt = conn.prepareStatement(sqlQuery);
						finalNewsId = newId;
						pstmt.setString(7, panchayat);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(12, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? "
									+ ",PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where PCODE=? and NEWS_ID=? and DCODE=? and MCODE=?"
									+ " and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, panchayat);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, mandal);
							pstmt.setString(12, rwsDroughtNewsItemForm
									.getLevel());
						}
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&!village.equals("")&&!village.equals(null)
							&&habitation.equals("")){
						if(!isExists(newsId1,conn)){
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS,"
								+ "ACTION_TAKEN,REMARKS,VCODE,NEWS_ID,DCODE,MCODE,PCODE,"
								+ "CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?)";
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						pstmt = conn.prepareStatement(sqlQuery);
						
						finalNewsId = newId;
						pstmt.setString(7, village);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, panchayat);
						pstmt.setString(12, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(13, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						}
						else{
							
							sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?"
									+ ",EDITION=? ,PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
									+ "TYPEOF_ADVERSE_NEWS_ITEM=? where VCODE=? and NEWS_ID=? and DCODE=? and MCODE=? "
									+ "and PCODE=? and CLIP_LEVEL=?";
							pstmt = conn.prepareStatement(sqlQuery);
							finalNewsId = newsId1;
							pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
							pstmt.setString(8, village);
							pstmt.setString(9, newsId1);
							pstmt.setString(10, district);
							pstmt.setString(11, mandal);
							pstmt.setString(12, panchayat);
							pstmt.setString(13, rwsDroughtNewsItemForm
									.getLevel());
							
							
						}
						
					}
					else if(!district.equals("")&&!district.equals(null)
							&&!mandal.equals("")&&!mandal.equals(null)
							&&!panchayat.equals("")&&!panchayat.equals(null)
							&&!village.equals("")&&!village.equals(null)
							&&!habitation.equals("")&&!habitation.equals(null)){
						if(!isExists(newsId1,conn)){
						String paperDate=rwsDroughPaperItemRecord.getPaperDate();
						 String tdsfy[]=paperDate.split("/");
							String paperDatedd = tdsfy[0];
							String paperDatemm = tdsfy[1];
							String paperDateyyyy = tdsfy[2];
						 String newId=district+paperDatedd+paperDatemm+paperDateyyyy.substring(2,4)+newsIDno;
						sqlQuery = "insert into rws_drought_newspaper_item_tbl (PAPER_DATE,PAPER_NAME,EDITION,PAPER_NEWS"
								+ ",ACTION_TAKEN,REMARKS,HAB_CODE,NEWS_ID,DCODE,MCODE,"
								+ "PCODE,VCODE,CLIP_LEVEL,TYPEOF_ADVERSE_NEWS_ITEM) values(to_date(?,'dd/mm/yy'),?,?,?,?,?,?,?,?,?,?,?,?,?)";
						finalNewsId = newId;
						pstmt = conn.prepareStatement(sqlQuery);
						pstmt.setString(7, habitation);
						pstmt.setString(8, newId);
						pstmt.setString(9, district);
						pstmt.setString(10, mandal);
						pstmt.setString(11, panchayat);
						pstmt.setString(12, village);
						pstmt.setString(13, rwsDroughtNewsItemForm
								.getLevel());
						pstmt.setString(14, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
					}
					else{
						
						sqlQuery="update rws_drought_newspaper_item_tbl set PAPER_DATE=to_date(?,'dd/mm/yy'),PAPER_NAME=?,EDITION=? ,"
								+ "PAPER_NEWS=?,ACTION_TAKEN=?,REMARKS=?,"
								+ "TYPEOF_ADVERSE_NEWS_ITEM=? where VCODE=? and NEWS_ID=? and DCODE=? and MCODE=? and "
								+ "PCODE=? and VCODE=? and CLIP_LEVEL=?";
						pstmt = conn.prepareStatement(sqlQuery);
						finalNewsId = newsId1;
						pstmt.setString(7, rwsDroughPaperItemRecord.getTypeOfAdverseNewsItem());
						pstmt.setString(8, habitation);
						pstmt.setString(9, newsId1);
						pstmt.setString(10, district);
						pstmt.setString(11, mandal);
						pstmt.setString(12, panchayat);
						pstmt.setString(13, village);
						pstmt.setString(14, rwsDroughtNewsItemForm
								.getLevel());
					}
					}
					//System.out.println("rwsDroughPaperItemRecord.getPaperDate()"+rwsDroughPaperItemRecord.getPaperDate());
					pstmt.setString(1, rwsDroughPaperItemRecord
							.getPaperDate());
					pstmt.setString(2, rwsDroughPaperItemRecord
							.getPaperName());
					pstmt.setString(3, rwsDroughPaperItemRecord
							.getPaperEdition());
					pstmt.setString(4, rwsDroughPaperItemRecord
							.getPaperNews());
					if(!rwsDroughPaperItemRecord.getActionReport().equals("") && rwsDroughPaperItemRecord.getActionReport()!=null){
					pstmt.setString(5, rwsDroughPaperItemRecord
							.getActionReport());
					}
					else{
						pstmt.setString(5, "");
					}
					pstmt.setString(6, rwsDroughPaperItemRecord
							.getRemarks());
					
					
					
						
						String fileName = rwsDroughPaperItemRecord.getScannedCopy();
						
						formFile=rwsDroughPaperItemRecord.getScannedCopy();
						
						if (formFile != null && formFile.getFileSize() != 0) {
							try {
								String path = actionServlet
										.getServletContext()
										.getRealPath("")
										+ formFile.getFileName();
								//System.out.println("path"+path);

								scannedFile = new File(path);
								outputStream = new FileOutputStream(
										scannedFile);
								if (outputStream != null) {
									outputStream.write(formFile
											.getFileData());
								}
								
								
								*//**
								 * Compressing the image
								 *//*

								targetFile = new File(targetPath);
								
								if (!documentSanitizerImpl.madeSafe(scannedFile)) {
									message = "Paper Clipping Scanned Copy File is Corrupted";
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
								System.out.println("exception in rwsdroughtpaperitem saveHabitaionsData -- "+e);
//								e.printStackTrace();
							} finally {
								if (fis != null) {
									// fis.close();
								}
							}

							// System.out.println("File Size:"
							// + tenderMemoBean.getPassOrderScanCopy()
							// .getFileSize());
							double fileSizeMB = ((rwsDroughPaperItemRecord.getScannedCopy().getFileSize() / 1024.0) / 1024.0);

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
							pstmt.setBinaryStream(7, fis,
									(int) targetFile.length());
						
							 String paperDateTemp[]=rwsDroughPaperItemRecord.getPaperDate().split("/");
							 
								String paperDatedd = paperDateTemp[0];
								String paperDatemm = paperDateTemp[1];
								String paperDateyyyy = paperDateTemp[2];
								
							//String commonPath = actionServlet.getServletContext().getRealPath("/");
							//System.out.println("commonPath" + commonPath);
							String paperDate = rwsDroughPaperItemRecord.getPaperDate().replace("/", "-");
							String imagePath=actionServlet.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate;
							File myFilesDir = new File(imagePath);
							if (!myFilesDir.exists())
								myFilesDir.mkdirs();
							
							
							imagePath = imagePath + File.separator ;
							//System.out.println("news paper imagePath----"+imagePath);
							File filepath = new File(imagePath);
							
							File filepathisExits = new File(filepath+File.separator+finalNewsId+".jpg");
							if(filepathisExits.getAbsoluteFile().exists()){
								filepathisExits.delete();
							}
							 byte[] readData = new byte[1024];
								FileOutputStream fout=new FileOutputStream(filepath+File.separator+finalNewsId+".jpg"); 	
								//System.out.println("news paper imagePath----"+(filepath+"\\"+finalNewsId+".jpg"));
								int k = fis.read(readData);
							      while (k != -1) {
							    	  fout.write(readData, 0, k);
							        k = fis.read(readData);
							      }
							      
							      byte[] buffer = new byte[1024];
							      while (true) {
							        int bytesRead = fis.read(buffer);
							        if (bytesRead == -1)
							          break;
							        fout.write(buffer, 0, bytesRead);
							      }
							    //fout.write(targetFile);  				            
							    fout.close();
							
							pstmt.addBatch();
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
							
							//selectedCount++;
							
						//} 
						
						 
						
						
						

				}else if(!rwsDroughPaperItemRecord.getScannedCopyStatus().equals("no")){
					//System.out.println("in else if scanned copy status :"+rwsDroughPaperItemRecord.getScannedCopyStatus());
					pstmt.addBatch();
				}
						formFile1=rwsDroughPaperItemRecord.getAtrScannedCopy();
					//	System.out.println("formFile1---"+formFile1.getFileSize());
						
						if (formFile1 != null && formFile1.getFileSize()!=0) {
						//	System.out.println("inside if");
							try {
								String path = actionServlet
										.getServletContext()
										.getRealPath("")
										+ formFile1.getFileName();
								//System.out.println("path"+path);

								scannedFile1 = new File(path);
								outputStream1 = new FileOutputStream(
										scannedFile1);
								if (outputStream1 != null) {
									outputStream1.write(formFile1
											.getFileData());
								}

								*//**
								 * Compressing the image
								 *//*

								targetFile1 = new File(targetPath1);
								
								if (!documentSanitizerImpl.madeSafe(scannedFile1)) {
									message = "ATR Scanned Copy File is Corrupted";
									conn.setAutoCommit(true);
									scannedFile1.delete();
									outputStream1.close();
									targetFile1.delete();
									return message;
								} 

								compressImage(scannedFile1, targetFile1);

								fis1 = new FileInputStream(targetFile1);
								if (fis1 != null) {
								}
							} catch (Exception e) {
								e.printStackTrace();
							} finally {
								if (fis1 != null) {
									// fis.close();
								}
							}

							// System.out.println("File Size:"
							// + tenderMemoBean.getPassOrderScanCopy()
							// .getFileSize());
							double fileSizeMB = ((rwsDroughPaperItemRecord.getAtrScannedCopy().getFileSize() / 1024.0) / 1024.0);

							// System.out.println("After fileSizeMB:"+fileSizeMB);
							if (fileSizeMB > 0.2) {
								message = "ATR Scanned Copy File Size Shoud Not Be Allowed More Than 200 KB";
								conn.setAutoCommit(true);
								scannedFile1.delete();
								outputStream1.close();
								targetFile1.delete();
								return message;

							}
							// fis =
							// getFileInputStream(tenderMemoBean.getPassOrderScanCopy());
					//		System.out.println("targetFile1.length()---"+targetFile1.length());
							pstmt.setBinaryStream(7, fis1,
									(int) targetFile1.length());
							
							String paperDate = rwsDroughPaperItemRecord.getPaperDate().replace("/", "-");
							String imagePath=actionServlet.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate;
							File myFilesDir = new File(imagePath); 
							if (!myFilesDir.exists())
								myFilesDir.mkdirs();
							
							
							imagePath = imagePath + File.separator ;
							//System.out.println("news paper imagePath----"+imagePath);
							File filepath = new File(imagePath);
							
							File filepathisExits = new File(filepath+File.separator+"ACT_"+finalNewsId+".jpg");
							if(filepathisExits.getAbsoluteFile().exists()){
								filepathisExits.delete();
							}
							 byte[] readData = new byte[1024];
								FileOutputStream fout=new FileOutputStream(filepath+File.separator+"ACT_"+finalNewsId+".jpg"); 	
								//System.out.println("news paper imagePath----"+(filepath+"\\"+"ACT_"+finalNewsId+".jpg"));
								int k = fis1.read(readData);
							      while (k != -1) {
							    	  fout.write(readData, 0, k);
							        k = fis1.read(readData);
							      }
							      
							    fout.close();
							
							
							//pstmt.addBatch();
							if (scannedFile1 != null) {
								scannedFile1.delete();

							}
							if (targetFile1 != null) {
								targetFile1.delete();
							}
							if (outputStream1 != null) {
								// outputStream.close();
							}
							if (fis1 != null) {
								// fis.close();
							}
							
							//selectedCount++;
							
						//} 
			

				}
						
						else{
						//	System.out.println("inside else");
							//pstmt.setBinaryStream(7, fis1,(int) 0);
							
							//pstmt.addBatch();
						}
						selectedCount++;
			//}
			}
			}

			
			//System.out.println("saving or updating queries :"+pstmt.getFetchSize());
			int rec[] = pstmt.executeBatch();
			//System.out.println("rec  items :"+rec.toString());
			 for(int k=0;k<rec.length;k++){
	                System.out.println("Query "+k+" has effected "+rec[k]+" times");
	            }
			//System.out.println("saving or updating sizes :"+rec.length+" len :"+selectedCount);
			if (rec.length == selectedCount) {
				
				
				message="Saved Succesfully";
				
			} else {
				
				message="Failed";
				
			}
			
			

		} catch (Exception e) {
			System.out.println("exception in rwsdroughtpaperitem save form -- "+e );
			//e.printStackTrace();
		} finally {
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
				//e.printStackTrace();
			}

		}
		return message;
	}*/
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

	public void compressImage(InputStream is, OutputStream os)
			throws IOException {

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
		
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		
		writer.write(null, new IIOImage(image, null, null), param);

		
		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}
	
	private boolean isExists(String newsId,Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
		
			query = "select NEWS_ID  from rws_drought_newspaper_item_tbl where NEWS_ID=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, newsId);
			rs = stmt1.executeQuery();
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
				System.out.println("exception in rwsdroughtpaperitem isExists-- "+e);
			}
			
		}

		return false;
	}
	public ArrayList getHabitaionsData1(
			RwsDroughtNewsItemForm rwsDroughtNewsItemForm,
			HttpServletRequest request,ActionServlet servletctrx) {

		ArrayList habData = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			int recCount = 0;
			int slNoCount=0;
			conn = RwsOffices.getConn();
			String district=rwsDroughtNewsItemForm.getDistrict();
			String mandal=rwsDroughtNewsItemForm.getMandal();
			String panchayat=rwsDroughtNewsItemForm.getPanchayat();
			String village=rwsDroughtNewsItemForm.getVillage();
			String habitation=rwsDroughtNewsItemForm.getHabitation();
			String sqlQuery ="";
			
			if(district.equals("")&&mandal.equals("")&&panchayat.equals("")&&
					village.equals("")&&habitation.equals("")){		
				sqlQuery = "select distinct CLIP_LEVEL,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM from rws_drought_newspaper_item_tbl  where CLIP_LEVEL=? and DCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy')";
				
			
				
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, rwsDroughtNewsItemForm.getLevel());
			pstmt.setString(2, "00");
			pstmt.setString(3, rwsDroughtNewsItemForm.getPaperDt());
				rs = pstmt.executeQuery();

				
				if (rs.next()) {
					rs = pstmt.executeQuery();
					while (rs.next()) {
					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					
					rwsDroughPaperItemRecord.setPaperDate(rs.getString(2));
					rwsDroughPaperItemRecord.setPaperName(rs.getString(3));
					rwsDroughPaperItemRecord.setPaperEdition(rs.getString(4));
					rwsDroughPaperItemRecord.setPaperNews(rs.getString(5));
					rwsDroughPaperItemRecord.setActionReport((rs.getString(6)));
					rwsDroughPaperItemRecord.setRemarks(rs.getString(7));
					rwsDroughPaperItemRecord.setIsSavedRecord("yes");
					rwsDroughPaperItemRecord.setChecks("on");
					//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
					rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(8),rs.getString(2),false,servletctrx));
					//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
					rwsDroughPaperItemRecord.setNewsId(rs.getString(8));
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(9));
					rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
					

					habData.add(rwsDroughPaperItemRecord);
					}
					
					if(request.getAttribute("AddRow").equals("AddRow")){
						
						RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
						rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
						
						rwsDroughPaperItemRecord.setPaperDate("");
						rwsDroughPaperItemRecord.setPaperName("");
						rwsDroughPaperItemRecord.setPaperEdition("");
						rwsDroughPaperItemRecord.setPaperNews("");
						rwsDroughPaperItemRecord.setActionReport("");
						rwsDroughPaperItemRecord.setRemarks("");
						rwsDroughPaperItemRecord.setIsSavedRecord("");
						rwsDroughPaperItemRecord.setChecks("");
						rwsDroughPaperItemRecord.setScannedCopyStatus("no");
						rwsDroughPaperItemRecord.setNewsId("");
						rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
						rwsDroughPaperItemRecord.setAtrimageStatus("no");
						habData.add(rwsDroughPaperItemRecord);
					}
					
				}
				else{
					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					
					rwsDroughPaperItemRecord.setPaperDate("");
					rwsDroughPaperItemRecord.setPaperName("");
					rwsDroughPaperItemRecord.setPaperEdition("");
					rwsDroughPaperItemRecord.setPaperNews("");
					rwsDroughPaperItemRecord.setActionReport("");
					rwsDroughPaperItemRecord.setRemarks("");
					rwsDroughPaperItemRecord.setIsSavedRecord("");
					rwsDroughPaperItemRecord.setChecks("");
					rwsDroughPaperItemRecord.setScannedCopyStatus("no");
					rwsDroughPaperItemRecord.setNewsId("");
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
					rwsDroughPaperItemRecord.setAtrimageStatus("no");
					/*updatePapperData(rwsDroughPaperItemRecord,
							rwsDroughtNewsItemForm,conn);*/

					habData.add(rwsDroughPaperItemRecord);
				}
				
			}
			else if(!district.equals("")&&!district.equals(null)
					&&mandal.equals("")&&panchayat.equals("")
					&&village.equals("")&&habitation.equals("")){
				sqlQuery = "select distinct a.DCODE,a.DNAME,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.DCODE=a.dcode  and b.DCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') AND CLIP_LEVEL=?";
				
				pstmt = conn.prepareStatement(sqlQuery);
				
				pstmt.setString(1, district);
				pstmt.setString(2, rwsDroughtNewsItemForm.getPaperDt());
				pstmt.setString(3, rwsDroughtNewsItemForm.getLevel());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				rs = pstmt.executeQuery();
				while (rs.next()) {

					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
					rwsDroughPaperItemRecord.setPaperDate(rs.getString(3));
					rwsDroughPaperItemRecord.setPaperName(rs.getString(4));
					rwsDroughPaperItemRecord.setPaperEdition(rs.getString(5));
					rwsDroughPaperItemRecord.setPaperNews(rs.getString(6));
					rwsDroughPaperItemRecord.setActionReport(rs.getString(7));
					rwsDroughPaperItemRecord.setRemarks(rs.getString(8));
					rwsDroughPaperItemRecord.setIsSavedRecord("yes");
					rwsDroughPaperItemRecord.setChecks("on");
					rwsDroughPaperItemRecord.setNewsId(rs.getString(9));
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(10));
					///rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
					rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(9),rs.getString(3),false,servletctrx));
					rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(9),rs.getString(3),true,servletctrx));
					//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
					/*updatePapperData(rwsDroughPaperItemRecord,
							rwsDroughtNewsItemForm,conn);*/

					habData.add(rwsDroughPaperItemRecord);

				}
				if(request.getAttribute("AddRow").equals("AddRow")){
					RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
					
					rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
					String query="select distinct DCODE,DNAME from  rws_complete_hab_view  where DCODE=?";
					PreparedStatement preparedStatement=conn.prepareStatement(query);
					preparedStatement.setString(1, district);
					ResultSet resultSet=preparedStatement.executeQuery();
					if(resultSet.next()){
						rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					}
					
					rwsDroughPaperItemRecord.setPaperDate("");
					rwsDroughPaperItemRecord.setPaperName("");
					rwsDroughPaperItemRecord.setPaperEdition("");
					rwsDroughPaperItemRecord.setPaperNews("");
					rwsDroughPaperItemRecord.setActionReport((""));
					rwsDroughPaperItemRecord.setRemarks("");
					rwsDroughPaperItemRecord.setIsSavedRecord("");
					rwsDroughPaperItemRecord.setChecks("");
					rwsDroughPaperItemRecord.setNewsId("");
					rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
					rwsDroughPaperItemRecord.setScannedCopyStatus("no");
					rwsDroughPaperItemRecord.setAtrimageStatus("no");
					/*updatePapperData(rwsDroughPaperItemRecord,
							rwsDroughtNewsItemForm,conn);*/

					habData.add(rwsDroughPaperItemRecord);
				}
			}
			
			else{

				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME from  rws_complete_hab_view  where DCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport((""));
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				/*updatePapperData(rwsDroughPaperItemRecord,
						rwsDroughtNewsItemForm,conn);*/

				habData.add(rwsDroughPaperItemRecord);
			}
			
			
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&panchayat.equals("")&&village.equals("")&&habitation.equals("")){
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.MCODE=a.MCODE  and b.DCODE=a.DCODE  and b.DCODE=? and b.MCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
				
				pstmt = conn.prepareStatement(sqlQuery);

				pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
				pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
				pstmt.setString(3, rwsDroughtNewsItemForm.getPaperDt());
				pstmt.setString(4, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(5));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(6));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(8));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(9));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(10));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(11));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(12));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(11),rs.getString(5),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(11),rs.getString(5),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));

				habData.add(rwsDroughPaperItemRecord);

			}
			if(request.getAttribute("AddRow").equals("AddRow")){
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME from rws_complete_hab_view  where DCODE=? and MCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME from rws_complete_hab_view  where DCODE=? and MCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&village.equals("")&&habitation.equals("")){
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.PCODE=a.PCODE  and b.DCODE=a.DCODE  and b.MCODE=a.MCODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
				
				pstmt = conn.prepareStatement(sqlQuery);

				pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
				pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
				pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
				pstmt.setString(4, rwsDroughtNewsItemForm.getPaperDt());
				pstmt.setString(5, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(8));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(9));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(10));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(11));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(12));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(13));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(14));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(13),rs.getString(7),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(13),rs.getString(7),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			if(request.getAttribute("AddRow").equals("AddRow")){
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&!village.equals("")&&!village.equals(null)
					&&habitation.equals("")){
			/*sqlQuery = "select distinct DNAME,DCODE,MNAME,MCODE,PCODE,PNAME,VNAME,VCODE from  rws_complete_hab_view where DCODE=? and MCODE=? and PCODE=? and VCODE=?";*/
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and b.VCODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
				
				pstmt = conn.prepareStatement(sqlQuery);

				pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
				pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
				pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
				pstmt.setString(4, rwsDroughtNewsItemForm.getVillage());
				pstmt.setString(5, rwsDroughtNewsItemForm.getPaperDt());
				pstmt.setString(6, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setVillageName(rs.getString(7));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(9));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(10));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(11));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(12));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(13));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(14));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(15));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(16));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(15),rs.getString(9),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(15),rs.getString(9),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			if(request.getAttribute("AddRow").equals("AddRow")){
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
				}
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			slNoCount=recCount+1;
			request.setAttribute("slNoCount", slNoCount);
			
			}
			else if(!district.equals("")&&!district.equals(null)
					&&!mandal.equals("")&&!mandal.equals(null)
					&&!panchayat.equals("")&&!panchayat.equals(null)
					&&!village.equals("")&&!village.equals(null)
					&&!habitation.equals("")&&!habitation.equals(null)){
				sqlQuery = "select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,a.PANCH_NAME,a.PANCH_CODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,TYPEOF_ADVERSE_NEWS_ITEM  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.HAB_CODE=a.PANCH_CODE and b.DCODE=? and b.MCODE=? and b.PCODE=? and b.VCODE=? and b.HAB_CODE=? and PAPER_DATE=to_date(?,'dd/mm/yy') and CLIP_LEVEL=?";
				
				pstmt = conn.prepareStatement(sqlQuery);

				pstmt.setString(1, rwsDroughtNewsItemForm.getDistrict());
				pstmt.setString(2, rwsDroughtNewsItemForm.getMandal());
				pstmt.setString(3, rwsDroughtNewsItemForm.getPanchayat());
				pstmt.setString(4, rwsDroughtNewsItemForm.getVillage());
				pstmt.setString(5, rwsDroughtNewsItemForm.getHabitation());
				pstmt.setString(6, rwsDroughtNewsItemForm.getPaperDt());
				pstmt.setString(7, rwsDroughtNewsItemForm.getLevel());
			rs = pstmt.executeQuery();

			
			if(rs.next()){
				rs = pstmt.executeQuery();
			while (rs.next()) {
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				rwsDroughPaperItemRecord.setDistrictName(rs.getString(2));
				rwsDroughPaperItemRecord.setMandalName(rs.getString(3));
				rwsDroughPaperItemRecord.setPanchayathName(rs.getString(5));
				rwsDroughPaperItemRecord.setVillageName(rs.getString(7));
				rwsDroughPaperItemRecord.setHabName(rs.getString(9));
				rwsDroughPaperItemRecord.setHabCode(rs.getString(10));
				rwsDroughPaperItemRecord.setPaperDate(rs.getString(11));
				rwsDroughPaperItemRecord.setPaperName(rs.getString(12));
				rwsDroughPaperItemRecord.setPaperEdition(rs.getString(13));
				rwsDroughPaperItemRecord.setPaperNews(rs.getString(14));
				rwsDroughPaperItemRecord.setActionReport(rs.getString(15));
				rwsDroughPaperItemRecord.setRemarks(rs.getString(16));
				rwsDroughPaperItemRecord.setIsSavedRecord("yes");
				rwsDroughPaperItemRecord.setChecks("on");
				rwsDroughPaperItemRecord.setNewsId(rs.getString(17));
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem(rs.getString(18));
				//rwsDroughPaperItemRecord.setScannedCopyStatus("yes");
				rwsDroughPaperItemRecord.setScannedCopyStatus(isImageExists(rs.getString(17),rs.getString(11),false,servletctrx));
				rwsDroughPaperItemRecord.setAtrimageStatus(isImageExists(rs.getString(17),rs.getString(11),true,servletctrx));
				//rwsDroughPaperItemRecord.setIsNewsImgExts(isImageExists(rs.getString(8),rs.getString(2),true,servletctrx));
				habData.add(rwsDroughPaperItemRecord);

			}
			if(request.getAttribute("AddRow").equals("AddRow")){
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_NAME,PANCH_CODE from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=? and PANCH_CODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				preparedStatement.setString(5, habitation);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
					rwsDroughPaperItemRecord.setHabName(resultSet.getString(9));
					rwsDroughPaperItemRecord.setHabCode(resultSet.getString(10));
				}
				
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			}
			else{
				
				RwsDroughPaperItemRecord rwsDroughPaperItemRecord = new RwsDroughPaperItemRecord();
				rwsDroughPaperItemRecord.setSlNo(String.valueOf(++recCount));
				String query="select distinct DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_NAME,PANCH_CODE from rws_complete_hab_view  where DCODE=? and MCODE=? and PCODE=? and VCODE=? and PANCH_CODE=?";
				PreparedStatement preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, district);
				preparedStatement.setString(2, mandal);
				preparedStatement.setString(3, panchayat);
				preparedStatement.setString(4, village);
				preparedStatement.setString(5, habitation);
				ResultSet resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					rwsDroughPaperItemRecord.setDistrictName(resultSet.getString(2));
					rwsDroughPaperItemRecord.setMandalName(resultSet.getString(4));
					rwsDroughPaperItemRecord.setPanchayathName(resultSet.getString(6));
					rwsDroughPaperItemRecord.setVillageName(resultSet.getString(8));
					rwsDroughPaperItemRecord.setHabName(resultSet.getString(9));
					rwsDroughPaperItemRecord.setHabCode(resultSet.getString(10));
				}
				
				
				rwsDroughPaperItemRecord.setPaperDate("");
				rwsDroughPaperItemRecord.setPaperName("");
				rwsDroughPaperItemRecord.setPaperEdition("");
				rwsDroughPaperItemRecord.setPaperNews("");
				rwsDroughPaperItemRecord.setActionReport("");
				rwsDroughPaperItemRecord.setRemarks("");
				rwsDroughPaperItemRecord.setIsSavedRecord("");
				rwsDroughPaperItemRecord.setChecks("");
				rwsDroughPaperItemRecord.setNewsId("");
				rwsDroughPaperItemRecord.setTypeOfAdverseNewsItem("");
				rwsDroughPaperItemRecord.setScannedCopyStatus("no");
				rwsDroughPaperItemRecord.setAtrimageStatus("no");
				habData.add(rwsDroughPaperItemRecord);
			}
			
			}
			
			

		} catch (Exception e) {
			e.printStackTrace();
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
				e.printStackTrace();
			}

		}
		return habData;

	}

	public String deleteNewsClip(String newsID) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String message="";
		try {
			
			conn = RwsOffices.getConn();
			
			String query="delete from rws_drought_newspaper_item_tbl where NEWS_ID=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, newsID);
		int n=pstmt.executeUpdate();
		
			if(n>0){
				message="Deleted Successfully";
			}
			else{
				message="Failed to Delete";
			}

		} catch (Exception e) {
			e.printStackTrace();
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
			System.out.println("exception in deleteNewsClip "+e);
			}

		}
		return message;
		
		
	}
	//added by subbu for downloading images 29-07-2019
/*public String downloadNewsClipImages(HttpServletRequest request) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String message="";
		try {
			
			conn = RwsOffices.getConn();
			
			String imageQuery = "select CLIP_IMAGE,to_char(PAPER_DATE,'dd-mm-yyyy') as paper_date,news_id,ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL";
			pstmt=conn.prepareStatement(imageQuery);
			PreparedStatement pstmt1 = conn.prepareStatement(imageQuery);
			ResultSet rs1 = pstmt1.executeQuery();
	
			while (rs1.next()) {
				if(rs1 != null){
					
				java.sql.Blob a = rs1.getBlob("CLIP_IMAGE");
				//InputStream iStream = b.getBinaryStream();
				if(a!=null && rs1.getString("paper_date") != null){
					Blob b=rs1.getBlob("CLIP_IMAGE");
					String paperDate=rs1.getString("paper_date");
					String newsId=rs1.getString("news_id");
					
					Blob atr_image =rs1.getBlob("ATR_IMAGE");
					
				String imagePath=request.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate ;
				File myFilesDir = new File(imagePath);
				if (!myFilesDir.exists())
					myFilesDir.mkdirs();
				
				
				imagePath = imagePath + File.separator ;
				File filepath = new File(imagePath);
				
				File filepathisExits = new File(filepath+File.separator+newsId+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=b.getBytes(1,(int)b.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+newsId+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				if(atr_image != null){
					File atrFilepathisExits = new File(filepath+File.separator+"ACT_"+newsId+".jpg");
					if(!atrFilepathisExits.getAbsoluteFile().exists()){
						//filepathisExits.delete();
						byte barr[]=atr_image.getBytes(1,(int)atr_image.length());
					    FileOutputStream fout=new FileOutputStream(filepath+File.separator+"ACT_"+newsId+".jpg"); 				
					    fout.write(barr);  				            
					    fout.close(); 
					    
					   
					}	
				}
				
				}
				}
				
				}
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
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
			System.out.println("exception in download NewsClip "+e);
			}
		}
		return message;		
	}*/
public String downloadNewsClipImages(HttpServletRequest request) {
		
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt_tot=null,pstmt_bkp = null,pstmt_update = null;
		ResultSet rs = null,rs_tot=null,rs_bkp = null,rs_update = null;
		
		
		String message="";
		try {
			
			conn = RwsOffices.getConn();
			
			String imageQuery = "select CLIP_IMAGE,to_char(PAPER_DATE,'dd-mm-yyyy') as paper_date,news_id,ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL";
			pstmt=conn.prepareStatement(imageQuery);
			PreparedStatement pstmt1 = conn.prepareStatement(imageQuery);
			ResultSet rs1 = pstmt1.executeQuery();
	
			while (rs1.next()) {
				if(rs1 != null){
					
				java.sql.Blob a = rs1.getBlob("CLIP_IMAGE");
				//InputStream iStream = b.getBinaryStream();
				if(a!=null && rs1.getString("paper_date") != null){
					Blob b=rs1.getBlob("CLIP_IMAGE");
					String paperDate=rs1.getString("paper_date");
					String newsId=rs1.getString("news_id");
					
					Blob atr_image =rs1.getBlob("ATR_IMAGE");
					
				//String imagePath=request.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate ;
				
				
					String imagePath=request.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"NewsPaperClippingImages"+ File.separator + paperDate;
				
				
				
				
				
				
				File myFilesDir = new File(imagePath);
				if (!myFilesDir.exists())
					myFilesDir.mkdirs();
				
				
				//imagePath = imagePath + File.separator ;
				File filepath = new File(imagePath);
				
				File filepathisExits = new File(filepath+File.separator+newsId+".jpg");
				if(!filepathisExits.getAbsoluteFile().exists()){
					//filepathisExits.delete();
					byte barr[]=b.getBytes(1,(int)b.length());
				    FileOutputStream fout=new FileOutputStream(filepath+File.separator+newsId+".jpg"); 				
				    fout.write(barr);  				            
				    fout.close(); 
				    
				   
				}
				if(atr_image != null){
					File atrFilepathisExits = new File(filepath+File.separator+"ACT_"+newsId+".jpg");
					if(!atrFilepathisExits.getAbsoluteFile().exists()){
						//filepathisExits.delete();
						byte barr[]=atr_image.getBytes(1,(int)atr_image.length());
					    FileOutputStream fout=new FileOutputStream(filepath+File.separator+"ACT_"+newsId+".jpg"); 				
					    fout.write(barr);  				            
					    fout.close(); 
					    
					   
					}	
				}
				
				}
				}
				
				}
			String totalQuery="create table RWS_DROUGHT_NEWSPAPER_ITEM_TOT as select *  from RWS_DROUGHT_NEWSPAPER_ITEM_TBL";
			try{
			pstmt_tot = conn.prepareStatement(totalQuery);
			 pstmt_tot.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_DROUGHT_NEWSPAPER_ITEM_TBL processing");}
			
			String backupQuery="create table RWS_DROUGHT_NEWSPAPER_ITEM_BKP as select HAB_CODE,PAPER_DATE,NEWS_ID,CLIP_IMAGE,ATR_IMAGE  from RWS_DROUGHT_NEWSPAPER_ITEM_TBL";
			try{
			pstmt_bkp = conn.prepareStatement(backupQuery);
			 pstmt_bkp.executeQuery();
			}
			catch(Exception e){System.out.println(e+"Exception in RWS_DROUGHT_NEWSPAPER_ITEM_TBL processing");}
			
			try{
			String updateQuery = "update RWS_DROUGHT_NEWSPAPER_ITEM_TBL set CLIP_IMAGE=null , ATR_IMAGE=null";
			pstmt_update = conn.prepareStatement(updateQuery);
			pstmt_update.executeUpdate();
			}catch(Exception e){
				System.out.println(e+"Exception in RWS_DROUGHT_NEWSPAPER_ITEM_TBL processing");
				}
				message="Images Downloaded Successfully.";			

		} catch (Exception e) {
			e.printStackTrace();
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
			System.out.println("exception in download NewsClip "+e);
			}
		}
		return message;		
	}
private String isImageExists(String newsId,String paperDate,Boolean isAtr,ActionServlet request){
	//dd/mm/yyyy
	paperDate = paperDate.replace("/", "-");
	String path = "";
	String imagePath=request.getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator + paperDate ;
	imagePath = imagePath + File.separator ;
	File filepathisExits ;
	if(isAtr){
		path = imagePath+File.separator+"ACT_"+newsId+".jpg";
		filepathisExits = new File(path);
		
	}else{
		path = imagePath+File.separator+newsId+".jpg";
		filepathisExits = new File(path);
	}
	//System.out.println("image file exits :"+isAtr+" : "+filepathisExits.exists()+" "+path);
	if(filepathisExits.getAbsoluteFile().exists())
		return path;
	else
	return "no";
}
}
