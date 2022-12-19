package nic.watersoft.contractor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @version 	1.0
 * @author		 
 */
public class rws_TenderNotificationAction_frm extends Action
{

	protected ActionForm buildTenderNotificationForm(String tenderId,String officeCode,HttpServletRequest request) throws Exception 
	{
		TenderNotificationForm form = null;
		RwsContractorData rwsContractorData=new RwsContractorData(getDataSource(request)); 
		RwsContractor rwsContractor=rwsContractorData.getTenderNotification(tenderId,officeCode,getDataSource(request));
		
			if(rwsContractor!=null)
			{
				form = new TenderNotificationForm();
				form.setTenderIdNo(rwsContractor.getTenderIdNo());
				form.setTenderType(rwsContractor.getTenderType());
				form.setNoOfWorks(rwsContractor.getNoOfWorks());
				form.setTypeOfTender(rwsContractor.getTypeOfTender());
				form.setIssueDate(rwsContractor.getIssueDate());
				form.setCloseDate(rwsContractor.getCloseDate());
				form.setModeOfExecution(rwsContractor.getModeOfExecution());
				form.setCostOfTender(rwsContractor.getCostOfTender());
				form.setSalesTax(rwsContractor.getSalesTax());
				form.setEstContractValue(rwsContractor.getEstContractValue());
				form.setWorkIds(rwsContractorData.getWorkIds(tenderId,officeCode,getDataSource(request)));
			}
			return form;
	}

    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	     //System.out.println("In TenderNotificationAction class");

    		TenderNotificationForm tenderNotificationForm = (TenderNotificationForm) form;
    		RwsContractor rwsContractor = new RwsContractor();
    		RwsContractorData rwsContractorData = new RwsContractorData(getDataSource(request));
    		int ans = 0;
    		int [] rowCount=new int[20];
    		String mode=request.getParameter("mode");
    		//System.out.println("mode="+mode);
    		TenderWorkIdBean tenderWorkIdBean=new TenderWorkIdBean();
    		ArrayList checkedWorkIds=new ArrayList();
    		ArrayList tenderDetails=new ArrayList();
    		HttpSession session=request.getSession();
    		String message=null;
    		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
    		String officeCode=rwsUser.getHeadOfficeCode()+rwsUser.getCircleOfficeCode()+rwsUser.getDivisionOfficeCode()+rwsUser.getSubdivisionOfficeCode();
    		ArrayList workIds = new ArrayList();
    	if(mode.equalsIgnoreCase("Save"))
    	{
    		
    		//System.out.println("in  TenderNotificationAction  save mode");
	        try
			{    rwsContractor.setTenderIdNo(tenderNotificationForm.getTenderIdNo());
			     rwsContractor.setTypeOfTender(tenderNotificationForm.getTypeOfTender());
	        	 rwsContractor.setNoOfWorks(tenderNotificationForm.getNoOfWorks());
	        	 rwsContractor.setIssueDate(tenderNotificationForm.getIssueDate());
	        	 rwsContractor.setCloseDate(tenderNotificationForm.getCloseDate());
	        	 rwsContractor.setTenderType(tenderNotificationForm.getTenderType());
	        	 rwsContractor.setModeOfExecution(tenderNotificationForm.getModeOfExecution());
	        	 rwsContractor.setCostOfTender(tenderNotificationForm.getCostOfTender());
	        	 rwsContractor.setSalesTax(tenderNotificationForm.getSalesTax());
	        	 rwsContractor.setEstContractValue(tenderNotificationForm.getEstContractValue());
	        	 rwsContractor.setOfficeCode(officeCode);
	        	 rwsContractor.setPreparedBy(tenderNotificationForm.getPreparedBy());
	        	 rwsContractor.setPreparedOn(tenderNotificationForm.getPreparedOn());
	        	 checkedWorkIds=(ArrayList)session.getAttribute("tempSelectedWorkIds");
	        	 //System.out.println("size="+checkedWorkIds.size());
	        	 rowCount=rwsContractorData.insertTenderNotification(rwsContractor,checkedWorkIds,getDataSource(request));
	        	 tenderNotificationForm.reset(mapping,request);	         
	
	        }
	        catch (Exception e)
			{
	        	//System.out.println("the error in rws_tenderNotificationAction_frm.java is =  "+e);
	        }
	        if(rowCount.length <1)
			{
				message="The Record Cant be inserted" ;
			}
			else
			{
				message="Record Inserted Successfully";
			} 
	    	request.setAttribute("message",message);
    	}
    	if(mode.equalsIgnoreCase("data"))
    	{
	        try
			{
	        }
	        catch (Exception e)
			{
	        	//System.out.println("the error in rws_tenderNotificationAction_frm.java data is =  "+e);
	        }
    	}
    	if(mode.equalsIgnoreCase("view"))
		{
    		//System.out.println("in  TenderNotificationAction view mode");
			try
			{
				tenderDetails=rwsContractorData.getTenderNotifications(officeCode,getDataSource(request));
				session.setAttribute("tenderDetails",tenderDetails);
			}
			catch(Exception e)
			{
				//System.out.println("error in view"+e.getMessage());
			}
		}
		if(mode.equalsIgnoreCase("dispWork"))
		{
			//System.out.println("in  TenderNotificationAction dispWork mode");
			try
			{
				workIds=rwsContractorData.getWorks(request.getParameter("tenderIdNo"),getDataSource(request));
				 
				for (int i=0;i<workIds.size();i++)
				{
					rwsContractor = (RwsContractor)workIds.get(i);	
					checkedWorkIds.add(new TenderWorkIdBean(rwsContractor.getWorkId(),rwsContractor.getWorkName()));
				}
				tenderNotificationForm.setWorkIds(checkedWorkIds);
				session.setAttribute("noOfWorks",request.getParameter("noOfWorks"));
				session.setAttribute("workIds",workIds);
			}
			catch(Exception e)
			{
				//System.out.println("error in dispWork"+e.getMessage());
			}
			
		}
    	if(mode.equalsIgnoreCase("pickWorkId"))
    	{
    		//System.out.println("in  TenderNotificationAction pickWorkId mode");
	        try
			{
	        	
				ArrayList TenderWorkIds = new ArrayList();
				workIds=rwsContractorData.getWorkIds(getDataSource(request));
				for (int i=0;i<workIds.size();i++)
				{
					rwsContractor = (RwsContractor)workIds.get(i);	
					TenderWorkIds.add(new TenderWorkIdBean(rwsContractor.getWorkId(),rwsContractor.getWorkName()));
				}
				tenderNotificationForm.setWorkIds(TenderWorkIds);
	
			}
	        
	        catch (Exception e)
			{
	        	//System.out.println("Error in pick work id is="+e.getMessage());
			}
    	}
    	
    	if(mode.equalsIgnoreCase("AddWorkId"))
		{
    		//System.out.println("in  TenderNotificationAction AddWorkId mode");
			try
			{
				checkedWorkIds = (ArrayList)tenderNotificationForm.getWorkIds();
				ArrayList tempSelectedWorkIds=new ArrayList();
				//System.out.println("checkedWorkIds.size()="+checkedWorkIds.size());
				for (int i=0;i<checkedWorkIds.size();i++)
				{
					tenderWorkIdBean = (TenderWorkIdBean)checkedWorkIds.get(i);
					if(tenderWorkIdBean.getWork() != null)
					{
						if(tenderWorkIdBean.getWork().equalsIgnoreCase("on"))
						{	//System.out.println("workd id="+tenderWorkIdBean.getWorkId()+"name="+tenderWorkIdBean.getWorkName());
							tempSelectedWorkIds.add(tenderWorkIdBean);
 					    }
					}
			 	}
				//System.out.println("tempselected habs size="+tempSelectedWorkIds.size());
				session.setAttribute("workIds",checkedWorkIds);
				session.setAttribute("tempSelectedWorkIds",tempSelectedWorkIds);
				 
			}
			catch(Exception e)
			{
				//System.out.println("the error in checks"+e);
			}
		}
    	if(mode.equalsIgnoreCase("get"))
		{
    		//System.out.println("in  TenderNotificationAction get mode");
    		
			try 
			{
				form = buildTenderNotificationForm(request.getParameter("tenderIdNo"),officeCode,request);
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
				session.setAttribute("tempSelectedWorkIds",((TenderNotificationForm)form).getWorkIds());
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e.getMessage());
			}
	}
    	if(mode.equalsIgnoreCase("edit"))
		{
    		//System.out.println("in  TenderNotificationAction edit mode");
        	
			try
			{   //System.out.println("mode="+mode);
				rwsContractor.setTenderIdNo(tenderNotificationForm.getTenderIdNo());
				rwsContractor.setTenderType(tenderNotificationForm.getTenderType());
				rwsContractor.setNoOfWorks(tenderNotificationForm.getNoOfWorks());
				rwsContractor.setTypeOfTender(tenderNotificationForm.getTypeOfTender());
				rwsContractor.setIssueDate(tenderNotificationForm.getIssueDate());
				rwsContractor.setCloseDate(tenderNotificationForm.getCloseDate());
				rwsContractor.setModeOfExecution(tenderNotificationForm.getModeOfExecution());
				rwsContractor.setEstContractValue(tenderNotificationForm.getEstContractValue());
				rwsContractor.setSalesTax(tenderNotificationForm.getSalesTax());
				rwsContractor.setCostOfTender(tenderNotificationForm.getCostOfTender());
				ans=rwsContractorData.updateTenderNotification(rwsContractor,officeCode,getDataSource(request));
				if(ans>0)
				{
					message = "Data Updated Succesfully";
				}
				else
				{
					message = "Data cannot be Updated";
				}
				request.setAttribute("message",message); 
				
			}
			catch (Exception e) 
			{
			
			//System.out.println("the error is"+e);
		    }
		}	
    	if(mode.equalsIgnoreCase("delete"))
		{
    		//System.out.println("in  TenderNotificationAction delete mode");
        	
			try 
			{	
				int[] del=rwsContractorData.removeTenderNotification(request.getParameter("tenderIdNo"),getDataSource(request));	
				//System.out.println("del="+del.length);
				if(del.length>0)
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
				//System.out.println("the error in Tender Notification delete is "+e);
			}
		}
        // Finish with
        return (mapping.findForward(mode));

    }
}
