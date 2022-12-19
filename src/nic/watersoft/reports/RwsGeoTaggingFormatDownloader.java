package nic.watersoft.reports;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;


public class RwsGeoTaggingFormatDownloader extends Action{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RwsGeoTaggingFormatDownloaderDAO geoTagDao=new RwsGeoTaggingFormatDownloaderDAO();
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId() != null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		ArrayList districtDetails=null;
		String mode = "";	  
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		System.out.println("mode    "+mode);
	    Rws_Asset_FormBean formBean=(Rws_Asset_FormBean)form;
	    if (mode != null && mode.equals("data")) {
			districtDetails = new ArrayList();
			formBean.setDistrictname("");
			formBean.setFromDate("");
			formBean.setToDate("");
			districtDetails=geoTagDao.getDistrictDetails();
			session.setAttribute("districtDetails", districtDetails);
			mode="data";
			return mapping.findForward(mode);
		}
		if (mode != null && mode.equals("view")) {
			String message = "";
			if(formBean.getDistrictname()!=null){
				String distcodes=geoTagDao.getDistrictDetails(formBean.getDistrictname());		
				formBean.setDistrictcode(distcodes);
			}		
			try {	
				boolean checkingcondition=geoTagDao.isExistData(formBean);
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
				System.out.println("The Exception is in the RwsGeoTaggingFormatDownloader : "+e.getMessage());
			} 
			request.setAttribute("message", message);	
		}
		if(mode!=null && mode.equalsIgnoreCase("view1")) {
			ArrayList districtDetailss = new ArrayList();
			String message = "";
			String filepath = "";
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
			districtDetailss=geoTagDao.getImagesBasedOnDistrictDetails(formBean,request);		
			session.setAttribute("districtDetails1", districtDetailss);
			if(districtDetailss.size()>0 ){		
			    mode="view";
			    message = "Zip is Ready To Download";
			}			
			request.setAttribute("message", message);
		}
		if(mode!=null && mode.equalsIgnoreCase("zip")){
			String root = request.getSession().getServletContext().getRealPath("/");
			File fs=new File(root + File.separator +formBean.getDistrictname()+".zip"); 
			String xip=formBean.getDistrictname()+".zip";
			response.setContentType("application/octet-stream");
		    response.setHeader("Content-Disposition","attachment;filename="+formBean.getDistrictname()+".zip");	   
		    try {	    	
		       	FileInputStream in =new FileInputStream(fs); 
		        ServletOutputStream out = response.getOutputStream();
		        byte[] outputByte = new byte[4096];
		        while(in.read(outputByte, 0, 4096) != -1){
		        	out.write(outputByte, 0, 4096);
		        }      
		        in.close();
		        out.close();
		     }catch(Exception e){
		    	System.out.println("The Exception is in the RwsGeoTaggingFormatDownloader : "+e.getMessage());
		   }	     
		    return null; 
		}
		return mapping.findForward(mode);	
	}
}
