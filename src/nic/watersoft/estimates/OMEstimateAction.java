package nic.watersoft.estimates;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

//import nic.watersoft.commons.Debug;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class OMEstimateAction extends Action
{
	DataSource dataSource;
	Connection conn;
	Statement stat;
	String query;
	String message;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("insert-success");
				
		EstimateForm myForm = (EstimateForm)form;
		String mode = myForm.getMode();
		dataSource = getDataSource(request);
		//System.out.println("In OMEstimateAction ..");
		//System.out.println("The user pressed the " + mode + " button.");
		HttpSession session = request.getSession();

		EstimateDAO estimateDAO = new EstimateDAO(dataSource);
		EstimateDTO estimateDTO = new EstimateDTO();
		BeanUtils.copyProperties(estimateDTO, myForm);

		if(mode != null && mode.equals("Save"))
		{	
			
			FormFile layout = myForm.getLayout();
			String fileExtension = null;
			String fileLocation = null;
			InputStream in = null;
			OutputStream out = null;

			String fileName = layout.getFileName();
			//System.out.println("The Layout File name is:" + fileName);
			//String location = "apd8//watersoftLatest//webapps//uploads//estimates//";
			String location = "";
			boolean fileCheck = true;
			try
			{
			
				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					fileLocation = location+"OM_LY"+myForm.getWorkId()+fileExtension;
					in = layout.getInputStream();
					out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					
					byte[] buffer = new byte[512];
					while (in.read(buffer) != -1)
					{
						out.write(buffer);
					}
				}

				FormFile detailedEstimate = myForm.getDetailedEstimate();
				fileName = detailedEstimate.getFileName();
				//System.out.println("The Detailed Estimate File name is:" + fileName);

				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					fileLocation = location+"OM_DE"+myForm.getWorkId()+fileExtension;
					in = detailedEstimate.getInputStream();
					out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					
					byte[] buffer = new byte[512];
					while (in.read(buffer) != -1)
					{
						out.write(buffer);
					}
				}
			 }
			 catch(Exception e)
			 {	//System.out.println("Exception in uploading OM Estimates " + e);
			 	fileCheck = false; 
			 }
				
			if(fileCheck)	
			{
				if(estimateDAO.omConsider(estimateDTO))
					message = "Estimate saved successfully.";
				else
					message = "Cannot save estimate(s)";
					
			}
			else
				message = "Cannot upload files.";
			
			session.setAttribute("GlobalConstants.Message", message);
			target = new String("insert-success");

		}
		else
		if(mode!=null && mode.equals("View"))
		{
			ArrayList estimateList = estimateDAO.viewOMEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("view-success");
		}
		else
		if(mode!=null && mode.equals("Print"))
		{
			ArrayList estimateList = estimateDAO.viewOMEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("print-success");
		}
		else
		if(mode!=null && mode.equals("Excel"))
		{
			ArrayList estimateList = estimateDAO.viewOMEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("excel-success");
		}
		else
		if(mode!=null && mode.equals("Edit"))
		{
			ArrayList estimateList = estimateDAO.viewOMEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("edit-success");
		}
		else
		if(mode!=null && mode.equals("Delete"))
		{
			String workId = request.getParameter("workId");
			if(estimateDAO.deleteOMEstimate(workId))
				session.setAttribute("GlobalConstants.Message", "One O&M estimate deleted successfully.");
			else
				session.setAttribute("GlobalConstants.Message", "Cannot delete estimate.");
			ArrayList estimateList = estimateDAO.viewOMEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("view-success");
		}	
		
		return mapping.findForward(target);
	}
}

