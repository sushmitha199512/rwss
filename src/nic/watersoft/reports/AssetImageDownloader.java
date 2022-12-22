package nic.watersoft.reports;

import java.awt.BorderLayout;
import java.awt.Container;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JProgressBar;
import javax.swing.border.Border;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.reports.Rws_Mpr_Access_DAO;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.healthmarketscience.jackcess.Database;


public class AssetImageDownloader extends Action{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		AssetImageDownloaderDAO assetImageDownloaderDAO=new AssetImageDownloaderDAO();
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId() != null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String mode = "";	  
		OutputStream outStream = null;
		FileInputStream inputStream = null;
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
	    Rws_Asset_FormBean formBean=(Rws_Asset_FormBean)form;
	    if (mode != null && mode.equals("data")) {
			ArrayList districtDetails = new ArrayList();
			formBean.setDistrictname("");
			formBean.setFromDate("");
			formBean.setToDate("");
			districtDetails=assetImageDownloaderDAO.getDistrictDetails();
			session.setAttribute("districtDetails", districtDetails);
			mode="data";
			return mapping.findForward(mode);
		}
		if (mode != null && mode.equals("view")) {
			ArrayList districtDetailss = new ArrayList();
			String dcode=null;
			boolean flag2=false,flag4=false,flag5=false,flag6=false;
			String message = "", mymsg = "";
			String message1 = "";
			String filepath = "", filename = "";
			Connection conn = RwsOffices.getConn();
			int BUFFER_SIZE =1024;
			String dname=null;		
			if(formBean.getDistrictname()!=null){
				String pp=formBean.getDistrictname();			
				String distcodes=assetImageDownloaderDAO.getDistrictDetails(pp);		
				formBean.setDistrictcode(distcodes);
				formBean.setDistrictname(pp);			
			}		
			try {	
				boolean checkingcondition=assetImageDownloaderDAO.getTotalList(formBean);
				if(checkingcondition){	
					 mode="view";
					message="Data Sucessfully Downloaded";	
				}
				else{
					mode="data";
					message = "No Data  Found on that Dates";
				}		
			} catch (Exception e) {
				request.setAttribute("message", message);
				mode = "fail";
				System.out.println("The Exception is in the AssetImageDownloader : "+e.getMessage());
			} 
			request.setAttribute("message", message);	
		}
		if(mode!=null && mode.equalsIgnoreCase("view1")) {
			ArrayList districtDetailss = new ArrayList();
			String dcode=null;
			boolean flag2=false,flag4=false,flag5=false,flag6=false;
			String message = "", mymsg = "";
			String message1 = "";
			String filepath = "", filename = "";
			Connection conn = RwsOffices.getConn();
			int BUFFER_SIZE =1024;
			String dname=null;
			filepath = request.getSession().getServletContext().getRealPath("/")+ "AssetImages";
			File file=new File(filepath);
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
				
			String distnames=formBean.getDistrictname();
			formBean.setDistrictname(distnames);
			districtDetailss=assetImageDownloaderDAO.getImagesBasedOnDistrictDetails(formBean,request);		
			session.setAttribute("districtDetails1", districtDetailss);
			if(districtDetailss.size()>0 ){		
			    mode="view";
			    message = "Zip is Ready To Download";
			}			
			request.setAttribute("message", message);
		}
		if(mode!=null && mode.equalsIgnoreCase("zip")){
			HttpServletResponse response1=response;
			String root = request.getSession().getServletContext().getRealPath("/");
			File fs=new File(root + File.separator +formBean.getDistrictname()+".zip"); 
			String xip=formBean.getDistrictname()+".zip";
			response.setContentType("application/octet-stream");
		    response.setHeader("Content-Disposition","attachment;filename="+formBean.getDistrictname()+".zip");	   
		    try {	    	
		       	FileInputStream in =new FileInputStream(fs); 
		        ServletOutputStream out = response.getOutputStream();
		        byte[] outputByte = new byte[4096];
		        int len;
		        while(in.read(outputByte, 0, 4096) != -1){
		        	out.write(outputByte, 0, 4096);
		        }      
		        in.close();
		        out.close();
		     }catch(Exception e){
		    	System.out.println("The Exception is in the AssetImageDownloader : "+e.getMessage());
		   }	     
		    return null; 
		}
		return mapping.findForward(mode);	
	}
}
