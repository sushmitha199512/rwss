/*
 * Created on Jan 17, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.contractor;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Locale;

import jxl.*;

 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.estimates.EstimateDAO;
 
import nic.watersoft.proposals.ProposalDTO;
 
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

 
public class Rws_Tender_Schedule_Act_frm extends Action
{
	protected ActionForm buildTenderScheduleAForm(String workId,HttpServletRequest request) throws Exception 
	{
		HttpSession session=request.getSession();
		TenderScheduleForm tenderScheduleForm= null;
		RwsContractorData rwsContractorData=new RwsContractorData(getDataSource(request));
		RwsContractor rwsContractor;
	    rwsContractor=rwsContractorData.getTenderScheduleA(workId,getDataSource(request));
	    if(rwsContractor!=null)
	    {
			tenderScheduleForm = new TenderScheduleForm();
			tenderScheduleForm.setWorkId(rwsContractor.getWorkId());
			tenderScheduleForm.setAssetTypeCode(rwsContractor.getAssetTypeName());
			tenderScheduleForm.setWorkComps(rwsContractor.getWorkComps());
	     }
	    return tenderScheduleForm;
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
        HttpServletRequest request, HttpServletResponse response)
        throws Exception {
		
		//System.out.println("hash code of this object is "+this.hashCode());
		//System.out.println("in action calss Rws_Tender_Schedule_Act_frm ");
		
		int[] ans = new int[5];
		String message=null;
		HttpSession session = request.getSession();
		TenderScheduleForm tenderScheduleForm = (TenderScheduleForm)form;
		TenderScheduleACompForm tenderScheduleACompForm;
		 
		RwsContractor rwsContractor = new RwsContractor();
		RwsContractorData rwsContractorData = new RwsContractorData(getDataSource(request));
		CommonLists commonLists = new CommonLists(getDataSource(request));
		EstimateDAO estimateDao = new EstimateDAO(getDataSource(request));
		String mode=request.getParameter("mode");
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode=rwsUser.getHeadOfficeCode()+rwsUser.getCircleOfficeCode()+rwsUser.getDivisionOfficeCode()+rwsUser.getSubdivisionOfficeCode();
		ArrayList assetTypes = new ArrayList();
		ArrayList workIds = new ArrayList();
		ArrayList workComponents = new ArrayList();
		ArrayList tenderScheduleA=new ArrayList();
		Sheet s=null;
		if(mode.equalsIgnoreCase("data"))
    	{
			
			//System.out.println("I am in data mode");
	        try
			{ 
	        	
	        	assetTypes=commonLists.getAssetTypes();
	        	session.setAttribute("assetTypes",assetTypes);
	        	if(request.getParameter("assetTypeCode")!=null)
	        	{
	        		//System.out.println("asset Tpe code is"+request.getParameter("assetTypeCode"));
	        	
	        		if(request.getParameter("assetTypeCode").length() != 0)
	        		{
	        			
	        			workIds=rwsContractorData.getWorkIds(request.getParameter("assetTypeCode"),officeCode);
	        			//System.out.println("size of workids is"+workIds.size());
	        		}
		       	}
	        	session.setAttribute("workIds",workIds);
			}
	        catch(Exception e)
			{
	        	//System.out.println("the error in Rws_Tender_Schedule_Act_frm data is= "+e);
			}
    	}
		if(mode.equalsIgnoreCase("components"))
		{
			
			//System.out.println("in componets mode");
			try
			{
	        	if(request.getParameter("workId")!=null)
	        	{
	        		if(request.getParameter("workId").length()!=0)
		        	{
	        			//System.out.println("@componets work id is "+request.getParameter("workId"));
		        		request.setAttribute("workDetails","workDetails");
		        		workComponents=rwsContractorData.getWorkComponents(request.getParameter("assetTypeCode"),request.getParameter("workId"),"new");
		        		//System.out.println("workComponents.size= "+workComponents.size());
		        		ArrayList workComps=new ArrayList();
		        		for (int i=0;i<workComponents.size();i++)
						{
		        			rwsContractor = (RwsContractor)workComponents.get(i);
		        			//System.out.println("********asset code="+rwsContractor.getAssetComponent()+"asset="+rwsContractor.getAssetComponentCode()+"sub comp="+rwsContractor.getAssetSubCompTypeCode()+"quantity="+rwsContractor.getQuantity()+"unitrate="+rwsContractor.getUnitRate()+"amount="+rwsContractor.getAmount());
							workComps.add(new TenderScheduleACompForm(rwsContractor.getAssetComponentCode(),rwsContractor.getAssetComponent(),rwsContractor.getAssetSubCompTypeCode(),rwsContractor.getWorkSubComps(),rwsContractor.getQuantity(),rwsContractor.getUnitRate(),rwsContractor.getAmount()));
						}
		        		tenderScheduleForm.setWorkComps(workComps);
		           	}
		       	}
	        	session.setAttribute("workComps",workComponents);
	        	
	        }
	        catch (Exception e)
			{
	        	//System.out.println("the error in Rws_Tender_Schedule_Act_frm.java components is =  "+e);
	        }
    	}
		if(mode.equalsIgnoreCase("workDetails"))
    	{
			//System.out.println("in work details mode");
			ProposalDTO proposalDTO=estimateDao.getWorkDetails(request.getParameter("workId"));
	       	request.setAttribute("proposalDTO", proposalDTO);
	   	}
		if(mode.equals("dispTender"))
		{
			//System.out.println("in dispTender mode");
			try{
				String workId=request.getParameter("workId");
				String fileExtension = null;
				String fileLocation = null;
				InputStream in = null;
				OutputStream out = null;
			 	FormFile tenderForm = tenderScheduleForm.getTenderForm();
			 	String fileName = request.getParameter("file");
				fileName=fileName.substring(fileName.lastIndexOf("\\")+1,fileName.length()); 
				//System.out.println("The File name1 is:" + fileName + "U");
				
				String uploadpath=session.getServletContext().getRealPath("uploads");
				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
					//System.out.println("xls1="+fileExtension);
					if(fileExtension.equals("xls"))
					{
		              //System.out.println("when file extension is xls sheet");
					  fileLocation = uploadpath+"\\NC_DD_"+workId+"."+fileExtension;
					  //System.out.println("File Loaction is "+fileLocation);
					  try
					  {
					  in=tenderForm.getInputStream();
					  }
					  catch(Exception e)
					  {
					  	//System.out.println("Error in getting the file in getting the input stream from tender form:"+e);
					  }
					  out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					  byte[] buffer = new byte[512];
					  while (in.read(buffer) != -1)
					  {
					  	//System.out.println("about to write");
						out.write(buffer);
						
					  }
					} 
		 		 String filename = uploadpath+"\\NC_DD_"+workId+"."+fileExtension;
		 		 //System.out.println("file name1="+filename);
			  }	 
			}
			catch(Exception e)
			{
				//System.out.println("Error in disp tender mode is ="+e.getMessage()+e);
			}
		}
		if(mode.equalsIgnoreCase("Save"))
		{
			  //System.out.println("in save mode");
	          try
			  {
	        	FormFile tenderForm = tenderScheduleForm.getTenderForm();
				String fileExtension = null;
				String fileLocation = null;
				InputStream in = null;
				OutputStream out = null;

				 String fileName = tenderForm.getFileName();
				 //System.out.println("uploading the file to  **** location is"+session.getServletContext().getRealPath("uploads"));
				 String uploadpath=session.getServletContext().getRealPath("uploads");
				 //System.out.println("The File name is:" + fileName + "U");
				
				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
					//System.out.println("xls="+fileExtension);
					if(fileExtension.equalsIgnoreCase("xls"))
					{
						
					  //System.out.println("when sheet name is xl");
					  fileLocation = uploadpath+"\\NC_DD_"+tenderScheduleForm.getWorkId()+"."+fileExtension;
					  in = tenderForm.getInputStream();
					  out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					  byte[] buffer = new byte[512];
					  while (in.read(buffer) != -1)
					  {
						out.write(buffer);
					  }
					} 
		 		   String filename = uploadpath+"\\NC_DD_"+tenderScheduleForm.getWorkId()+"."+fileExtension;
			     WorkbookSettings ws = new WorkbookSettings();
			     ws.setLocale(new Locale("en", "EN"));
			     Workbook w = Workbook.getWorkbook(new File(filename),ws);
			     s = w.getSheet(0);
			     //System.out.println("sheet name="+s.getName());
			     rwsContractor.setOfficeCode(officeCode);
	           	 rwsContractor.setWorkId(tenderScheduleForm.getWorkId());
	           	 
	         //System.out.println("*****@@@@*******"+tenderScheduleForm.getWorkId());
	        	 rwsContractor.setAssetTypeCode(tenderScheduleForm.getAssetTypeCode());
	         //System.out.println("*****@@@@*******"+tenderScheduleForm.getAssetTypeCode());
	        	 rwsContractor.setPreparedBy(tenderScheduleForm.getPreparedBy());
	         //System.out.println("*****@@@@*******"+tenderScheduleForm.getPreparedBy());
	        	 rwsContractor.setPreparedOn(tenderScheduleForm.getPreparedOn());
	         //System.out.println("*****@@@@*******"+tenderScheduleForm.getPreparedOn());
	        	 ArrayList comps = (ArrayList)tenderScheduleForm.getWorkComps();
	         //System.out.println("*****@@@@******size is *"+tenderScheduleForm.getWorkComps().size());
	        
	         //System.out.println("comps size="+comps.size());
	     
	        	 TenderScheduleACompForm tenderScheduleAForm=(TenderScheduleACompForm)comps.get(0);
	         //System.out.println("asset comp code="+tenderScheduleAForm.getAssetComponent());
	        	 ans=rwsContractorData.insertTenderScheduleA(rwsContractor,s,comps,getDataSource(request));
	         //System.out.println("length="+ans.length);
	        	 session=request.getSession();
	    		 ArrayList works=(ArrayList)session.getAttribute("workIds");
	    		 works.clear();
	    		 tenderScheduleForm.reset(mapping,request);
			 }	 
	        }
	        catch (Exception e)
			{
	        	//System.out.println("the error in Rws_Tender_Schedule_Act_frm.java is ="+e);
	        }
	    	if(ans.length < 0)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
	}
		if(mode.equalsIgnoreCase("view"))
		{
			
			//System.out.println("in view mode");
			try
			{
				 tenderScheduleA=rwsContractorData.getTenderScheduleAs(officeCode,getDataSource(request));
			     session.setAttribute("tenderScheduleA",tenderScheduleA);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Circle View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("get"))
		{
			//System.out.println("In get mode");
			try 
			{   //System.out.println("work code="+request.getParameter("workId"));
				form = buildTenderScheduleAForm(request.getParameter("workId"),request);
				session.setAttribute("workId",request.getParameter("workId"));
				workComponents=((TenderScheduleForm)form).getWorkComps();
                //System.out.println("size="+workComponents.size());
				ArrayList workComps=new ArrayList();
        		for (int i=0;i<workComponents.size();i++)
				{
        			rwsContractor = (RwsContractor)workComponents.get(i);
        			//System.out.println("asset code="+rwsContractor.getAssetComponent()+"asset="+rwsContractor.getAssetComponentCode()+"sub comp="+rwsContractor.getAssetSubCompTypeCode()+"quantity="+rwsContractor.getQuantity()+"unitrate="+rwsContractor.getUnitRate()+"amot="+rwsContractor.getAmount());
					workComps.add(new TenderScheduleACompForm(rwsContractor.getAssetComponentCode(),rwsContractor.getAssetComponent(),rwsContractor.getAssetSubCompTypeCode(),rwsContractor.getWorkSubComps(),rwsContractor.getQuantity(),rwsContractor.getUnitRate(),rwsContractor.getAmount()));
				}
        		((TenderScheduleForm)form).setWorkComps(workComps);
        		session.setAttribute("workComps",workComponents);
				if ("request".equals(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				//System.out.println("the error is in getTenderScheduleA:"+e.getMessage());
			}
		
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				String workId=tenderScheduleForm.getWorkId();
				workId=workId.substring(0,workId.indexOf("-"));
				//System.out.println("work Id="+workId);	
				rwsContractor.setOfficeCode(officeCode);
	           	rwsContractor.setWorkId(workId);
	        	rwsContractor.setAssetTypeCode(tenderScheduleForm.getAssetTypeCode());
	        	rwsContractor.setPreparedBy(tenderScheduleForm.getPreparedBy());
	        	rwsContractor.setPreparedOn(tenderScheduleForm.getPreparedOn());
	        	ArrayList comps = (ArrayList)tenderScheduleForm.getWorkComps();
	        	//System.out.println("comps size="+comps.size());
				ans=rwsContractorData.updateTenderScheduleA(workId,rwsContractor,comps,getDataSource(request));
				if(ans.length>0)
					message="Record Updated Successfully";
				else
					message="Record can't updated";
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e);
			}
			
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{  
			try 
			{
				//System.out.println("work id1="+request.getParameter("workId"));
				int res=rwsContractorData.removetenderScheduleA(request.getParameter("workId"),getDataSource(request));
				if(res>0)
				{
					message = "Data deleted Succesfully";
				}
				else
				{
					message = "Data cannot be deleted";
				}
				request.setAttribute("message",message);
			}
			catch (Exception e) 
			{
				//System.out.println("the error in rws_TenderScheduleA_frm delete is "+e.getMessage());	
			}
		}	
		
    // Finish with
    return (mapping.findForward(mode));
    }

}
