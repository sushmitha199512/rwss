package nic.watersoft.estimates;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.sql.DataSource;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.commons.LabelValueBean;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class NewEstimateAction extends Action
{
	private String message;
	private String target;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		EstimateForm myForm = (EstimateForm)form;
		String mode = myForm.getMode();
		//System.out.println("In NewEstimateAction ..");
		//System.out.println("The user pressed the " + mode + " button.");
		HttpSession session = request.getSession();

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		EstimateDTO estimateDTO = new EstimateDTO();
		BeanUtils.copyProperties(estimateDTO, myForm);

		if(mode != null && mode.equals("Save"))
		{	
			try
			{	
				FormFile designDrawing = myForm.getDesignDrawing();
				String fileExtension = null;
				String fileLocation = null;
				InputStream in = null;
				OutputStream out = null;

				String fileName = designDrawing.getFileName();
				//System.out.println("The File name is:" + fileName + "U");
				
				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					
					// code added by santosh on 181006
					ServletContext servletContext=session.getServletContext();
					//System.out.println("real path is"+servletContext.getRealPath("uploads/estimates"));
					String path=servletContext.getRealPath("uploads/estimates");
					// end of code added by santosh on 181006
					
					fileLocation = path+"/NW_DD_"+myForm.getWorkId()+fileExtension;
					//System.out.println("fileLocation is"+fileLocation);
					in = designDrawing.getInputStream();
					out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					
					byte[] buffer = new byte[512];
					while (in.read(buffer) != -1)
					{
						out.write(buffer);
					}
				}

				FormFile detailedEstimate = myForm.getDetailedEstimate();
				fileName = detailedEstimate.getFileName();
				//System.out.println("The File name is:" + fileName + "U");

				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					
					//code added by santosh on 181006
					ServletContext servletContext=session.getServletContext();
					//System.out.println("real path is"+servletContext.getRealPath("uploads/estimates"));
					String path=servletContext.getRealPath("uploads/estimates");
					// end of code added by santosh on 181006
					
					
					fileLocation = path+"/NW_DE_"+myForm.getWorkId()+fileExtension;
					//System.out.println("fileLocation path is"+fileLocation);
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
			{	
				//System.out.println("Estimate FormFile Exception");
				//System.out.println(""+e);
				message = "Cannot upload file.\n" + e.getMessage();
			}
			if(	estimateDAO.consider(estimateDTO) )
			{
				message = "One estimate inserted.";
				session.removeAttribute("NewEstimateForm");
			}
			else
				message = "Record cannot be inserted.";
			
			//System.out.println("The message is " + message);
			session.setAttribute("GlobalConstants.Message", message);
			target = new String("insert-success");
			
		}
		else
		if(mode!=null && mode.equals("View"))
		{
			ArrayList estimateList = estimateDAO.viewNewEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("view-success");
		}
		else
		if(mode!=null && mode.equals("Print"))
		{
			//System.out.println("myForm.getOfficeCode() " + myForm.getOfficeCode());
			ArrayList estimateList = estimateDAO.viewNewEstimates(myForm.getOfficeCode());
			//System.out.println("In print estimateList.size() " + estimateList.size());
			
			request.setAttribute("estimateList", estimateList);
			target = new String("print-success");
		}
		else
		if(mode!=null && mode.equals("Excel"))
		{
			ArrayList estimateList = estimateDAO.viewNewEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("excel-success");
		}
		else
		if(mode!=null && mode.equals("Delete"))
		{
			String workId = request.getParameter("workId");
			if(estimateDAO.deleteNewEstimate(workId))
				session.setAttribute("GlobalConstants.Message", "One Estimate deleted successfully.");
			else
				session.setAttribute("GlobalConstants.Message", "Cannot delete estimate.");
			ArrayList estimateList = estimateDAO.viewNewEstimates(myForm.getOfficeCode());
			request.setAttribute("estimateList", estimateList);
			target = new String("view-success");
		}	
		else
			if(mode!=null && mode.equals("generateNewSourceCode"))
			{
				String subdivisionOfficeCode=request.getParameter("subdivisionOfficeCode");
				String circleOfficeCode=request.getParameter("circleOfficeCode");
				String divisionOfficeCode=request.getParameter("divisionOfficeCode");
				
				ArrayList mandals=new ArrayList();
				ArrayList panchyats=new ArrayList();
				ArrayList villages=new ArrayList();
				ArrayList habs=new ArrayList();
				ArrayList dists=new ArrayList();
				ArrayList schemeCodes=new ArrayList();
				ArrayList snos=new ArrayList();
				
				RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
				if(subdivisionOfficeCode!=null && !subdivisionOfficeCode.equals("00") && !subdivisionOfficeCode.equals(""))
				{
					
					mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode,divisionOfficeCode,subdivisionOfficeCode,getDataSource(request));
					
				}

				try
				{
				if(request.getParameter("mandal")!=null)
				{
					if((request.getParameter("mandal")).length() != 0)
					{
						panchyats=rwsLocations.getPanchayats(circleOfficeCode,request.getParameter("mandal"));
					}
				}
				if(request.getParameter("pcode")!=null)
				{
					if((request.getParameter("pcode")).length() != 0)
					{
					villages = rwsLocations.getVillages(circleOfficeCode,request.getParameter("mandal"),request.getParameter("pcode"));
					}
				}
				if(request.getParameter("vcode")!=null)
				{
					if((request.getParameter("vcode")).length() != 0)
					{
						habs = rwsLocations.getHabitations(circleOfficeCode,request.getParameter("mandal"),request.getParameter("pcode"),request.getParameter("vcode"));
					}
				}
				}catch(Exception e)
				{
					//System.out.println("Error is "+e);
				}
				if(myForm.getAssetType()!=null && !myForm.getAssetType().equals(""))
				{
					SubCompMetaData subCompMetaData=new SubCompMetaData();
					subCompMetaData.assignSchemeCodeSeries(myForm.getAssetType());
					String schemeCodeSeries=subCompMetaData.getSchemeCodeSeries();
					
					for(int i=Integer.parseInt(schemeCodeSeries);i<=Integer.parseInt(schemeCodeSeries)+99;i++)
					{
						LabelValueBean labelValueBean=new LabelValueBean();
						labelValueBean.setValue(i+"");
						labelValueBean.setLabel(i+"");
						schemeCodes.add(labelValueBean);
					
					}
					String value="";
					for(int i=1;i<=999;i++)
					{
						LabelValueBean labelValueBean=new LabelValueBean();
						if(i<10)
							value="00"+i;
						else if(i<100)
							value="0"+i;
						else
							value=""+i;
						labelValueBean.setValue(value);
						labelValueBean.setLabel(value);
						snos.add(labelValueBean);
					
					}
				}
				myForm.setDistrictName(RwsMasterData.getDistName(getDataSource(request),myForm.getCircleOfficeCode()));
				session.setAttribute("dists",dists);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchyats",panchyats);
				session.setAttribute("villages",villages);
				session.setAttribute("habs",habs);
				session.setAttribute("schemeCodes",schemeCodes);
				session.setAttribute("snos",snos);
				target = new String("generateNewSourceCode");
				//System.out.println("assetType is "+myForm.getAssetType());
				}
			else
				if(mode!=null && mode.equals("submitNewSourceCode"))
				{
					//System.out.println("in submitNewSourceCode");
					if(RwsMasterData.sourceCodeExists(getDataSource(request),myForm.getSourceCode()))
						request.setAttribute("message","SourceCode Already Exists");
					else
						request.setAttribute("sourceCodeExists","false");
					
					
				}
			
		return mapping.findForward(target);
	}
}