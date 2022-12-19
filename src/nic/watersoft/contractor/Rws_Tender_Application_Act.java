package nic.watersoft.contractor;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import nic.watersoft.contractor.Rws_Tender_Application_FormBean;
import nic.watersoft.contractor.Rws_Tender_Application_Bean;


public class Rws_Tender_Application_Act extends Action  {
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
		{
		 ArrayList arryalsit=new ArrayList();
		 HttpSession session =request.getSession();
		 Rws_Tender_Application_FormBean tenderApp=(Rws_Tender_Application_FormBean)form;
		 //System.out.println("in Action calss of Rws_Tender_Application_Act");
         
		 String mode=tenderApp.getString("mode");
		 try{
		   
		 //System.out.println("mode is :"+mode);
		 if(mode.equalsIgnoreCase("data"))
		 {
		 	//System.out.println("in data mdoe");
		 	ArrayList tenderId=new ArrayList();
		 	try{
		 	tenderId=RwsContractorData.getTenderIds(getDataSource(request));
		 	
		 	session.setAttribute("tenderId",tenderId);
		 	
		 	}
		 	catch(Exception e)
			{
			//System.out.println("Exception in action class getin ids"+e);
			}
		 
		 }
		 
		if(mode.equalsIgnoreCase("view"))
		{
			ArrayList tenderAppList=new ArrayList();
			//System.out.println("in view Mode");
			try{
				tenderAppList=new ArrayList();
				tenderAppList=RwsContractorData.getTenderAppDetails(getDataSource(request));
				//System.out.println("number of applicants are"+tenderAppList.size());
				request.setAttribute("tenderAppList",tenderAppList);
				
			   }
			catch(Exception e)
			{
				//System.out.println("Exception in view"+e);
			}
			
		} 
		 
		if(mode.equalsIgnoreCase("save"))
		{	
		 //System.out.println("TendeID:"+tenderApp.get("tenderIdNo"));
		 //System.out.println("TenderAppNo"+tenderApp.get("tenderApplNo"));
		 //System.out.println("contractorRegNo:"+tenderApp.get("contractorRegNo"));
		 //System.out.println("preparedBy:"+tenderApp.get("preparedBy"));
		 //System.out.println("chequeNo:"+tenderApp.get("chequeNo"));
		 //System.out.println("bank:"+tenderApp.get("bank"));
		 //System.out.println("contractorName:"+tenderApp.get("contractorName"));
		 //System.out.println("contractorAdd1:"+tenderApp.get("contractorAdd1"));
		 //System.out.println("contractorAdd2:"+tenderApp.get("contractorAdd2"));
		 //System.out.println("contractorAdd3:"+tenderApp.get("contractorAdd3"));
		 //System.out.println("branch:"+tenderApp.get("branch"));
		 //System.out.println("tenderAmount:"+tenderApp.get("tenderAmount"));
		 //System.out.println("chequeDate:"+tenderApp.get("chequeDate"));
		 try{
		 Rws_Tender_Application_Bean appBean =new Rws_Tender_Application_Bean();
		 
		 appBean.setTenderIdNo((String)tenderApp.get("tenderIdNo"));
		 appBean.setTenderApplNo((String)tenderApp.get("tenderApplNo"));
		 appBean.setContractorRegNo((String)tenderApp.get("contractorRegNo"));
		 appBean.setChequeNo((String)tenderApp.get("chequeNo"));
		 appBean.setBank((String)tenderApp.get("bank"));
		 appBean.setContractorName((String)tenderApp.get("contractorName"));
		 appBean.setContractorAdd1((String)tenderApp.get("contractorAdd1"));
		 appBean.setContractorAdd2((String)tenderApp.get("contractorAdd2"));
		 appBean.setContractorAdd3((String)tenderApp.get("contractorAdd3"));
		 appBean.setBranch((String)tenderApp.get("branch"));
		 appBean.setTenderAmount((String)tenderApp.get("tenderAmount"));
		 appBean.setPreparedBy((String)tenderApp.get("preparedBy"));
		 
		 appBean.setChequeDate((String)tenderApp.get("chequeDate"));
		 boolean status=RwsContractorData.saveTenderAppDetails(getDataSource(request),appBean);
		 //System.out.println("Status is *****"+status);
		  if(status==true)
		  {
		   tenderApp.reset(mapping,request);
		   request.setAttribute("message","Saved successfully");
		  } 
		  else
		  {
		   request.setAttribute("message","Failed to save");
		  }  
		 }
		  catch(Exception e)
		  {
		 	//System.out.println("Exceptioen:"+e);
		  }
		 
		 }
		}
		 catch(Exception e)
		 {
		 	//System.out.println("Exceptione"+e);
		 }
		 
		 //System.out.println("in tender application Action calss");
		 return mapping.findForward(mode);
	    }
       }


