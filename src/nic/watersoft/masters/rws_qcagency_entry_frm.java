package nic.watersoft.masters;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;



/*import nic.watersoft.commons.RwsOffices;*/
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
/*import nic.watersoft.smsmobile.Rws_privateSourceDAO;*/

public class rws_qcagency_entry_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String mode="";
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
		}
		else
			mode="QcAgencyEntryFrm";
		QCAgencyForm myForm=(QCAgencyForm)form;
		HttpSession session=request.getSession();
		boolean init = true;
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		RwsQCAgencyData RwsQCAgencyData=new RwsQCAgencyData();
		    //For saving new Agency code and name
			if(mode!=null && mode.equals("saveNew"))
			{ 
				 try
				 {
					if(! user.equals(""))
					{
						boolean flag=myForm.isString(myForm.getAgencyname());
						//System.out.println("String Flag :"+flag);
						if(flag)
						{
						    String LoginUser = (String) session.getAttribute("userId");
							String rcount=RwsQCAgencyData.insertQCAgencyDetails(getDataSource(request),myForm.getAgencycode(),myForm.getAgencyname(),myForm.getFinyear(),LoginUser);
							String msg = "";
							String[] arrOfStr = rcount.split("~");
							if(!arrOfStr[1].equals("*")){
								msg = arrOfStr[0]+" with Agency Code: "+arrOfStr[1];
							}
							else
							{
								msg = arrOfStr[0];
							}
							request.setAttribute("message",msg);
							mode="QcAgencyEntryFrm";
						}
						else
						{
							request.setAttribute("message","Please Provide Valid Agency Name");
							mode="QcAgencyEntryFrm";
						}
					}
					else
					{
						request.setAttribute("message","Request cannot be processed as records have been freezed");
					}
				 }
				catch(Exception e)
				 	{
						Debug.println("Exception in rws_qcagency_edit_frm is "+e);	
					}
			}
			//For View existing Agencies
			if(mode!=null && mode.equals("view"))
				{
					try
					{
						ArrayList QCAgencyDetails;
						RwsQCAgencyData rwsqcageData=new RwsQCAgencyData();
						QCAgencyDetails=rwsqcageData.getQCAgeDetails();
						//System.out.println("QCAgencyDetails :"+QCAgencyDetails);
						session.setAttribute("qcagencyDetails",QCAgencyDetails);
					}
					catch(Exception e)
					{
						Debug.println("Exception in rws_qcagency_edit_frm is "+e);	
					}
				}
		  //Update Existing Agencies
	      if(mode!=null && mode.equals("QCAgencyUpd"))
			{ 
				try
					{
						String rcount="";
						if(! user.equals(""))
						{
							boolean flag=myForm.isString(myForm.getAgencyname());
							//System.out.println("QCAgencyUpdate String Flag :"+flag);
							if(flag==true)
							{
								rcount=RwsQCAgencyData.updateQCAgencyDetails(getDataSource(request),myForm.getAgencycode(),myForm.getAgencyname(),myForm.getFinyear());
								request.setAttribute("message",rcount);
								ArrayList QCAgencyDetails;
								RwsQCAgencyData rwsqcageData=new RwsQCAgencyData();
								QCAgencyDetails=rwsqcageData.getQCAgeDetails();
								session.setAttribute("qcagencyDetails",QCAgencyDetails);
								mode="view";
							}
							else
							{
								request.setAttribute("message","Please Provide Valid Agency Name");
								mode="QCAgencyEdit";
							}
						}
						else
						{
							request.setAttribute("message","Request cannot be processed as records have been freezed");
						}
					}
				catch(Exception e)
					{
						Debug.println("Exception in rws_qcagency_edit_frm is "+e);	
					}
			}
	      
	      
	      if (mode != null && mode.equalsIgnoreCase("delete")) {

				try {

					String ageCode = request.getParameter("agentCode");
					String message="";
					message = RwsQCAgencyData.deleteQCAgentDetails(ageCode);
					request.setAttribute("message", message);
					ArrayList QCAgencyDetails;
					RwsQCAgencyData rwsqcageData=new RwsQCAgencyData();
					QCAgencyDetails=rwsqcageData.getQCAgeDetails();
					session.setAttribute("qcagencyDetails",QCAgencyDetails);
					mode="view";
				} catch (Exception e) {
					System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
				}

				    mode="view";
			}
	      
	      if(init)
			{
	    	  //For View existing Agencies
			  if(mode!=null && mode.equals("QcAgencyEntryFrm"))
				{
				  //System.out.println("mode :"+myForm.getFinyear());
					try
					{
					 /* if((!myForm.getFinyear().equals("")) || (myForm.getFinyear()!=null))
					  {*/
						//System.out.println("IF");
						String QCAgencyCode;
						RwsQCAgencyData agecode=new RwsQCAgencyData();
						QCAgencyCode=agecode.getAgency_Code();//System.out.println("QCAgencyCode :"+QCAgencyCode);
						myForm.setAgencycode(QCAgencyCode);
						myForm.setAgencyname("");
					  /*}
					  else
					  {
						  System.out.println("ELSE");
						  myForm.setAgencycode("");
						  //request.setAttribute("message","Please select valid Financial Year");
						  mode="QcAgencyEntryFrm";
					  }*/
					}
					catch(Exception e)
					{
						Debug.println("Exception in rws_getAgencyCode is "+e);	
					}
				}
			}
		return mapping.findForward(mode);		
	}
}