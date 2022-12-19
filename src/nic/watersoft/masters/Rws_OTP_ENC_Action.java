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

import nic.watersoft.admin.OTPGeneration;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.smsmobile.NicSmsGateway;

public class Rws_OTP_ENC_Action extends Action
{
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		String message=null;
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ENC)))) {
			return mapping.findForward("unAuthorise");	
		}
		String userid = user.getUserId();
		Rws_OTP_ENC_Form frm=(Rws_OTP_ENC_Form) form;
		String mode=frm.getMode();
		OTPGeneration otpGeneration=new  OTPGeneration();
		try{
		if(mode!=null && mode.equalsIgnoreCase("data"))
		{
			reset(frm);
			if(userid.equals("ENC")){
				int otp=otpGeneration.generatePin();
				String mobile=otpGeneration.getMobile(userid);
				if(mobile.equals("0")){
				request.setAttribute("message", "Please Approch the Head Office to update the Mobile Number for OTP");
				}
				String msg="OTP is "+otp;
				System.out.println(msg);
				NicSmsGateway smsGateway=new  NicSmsGateway();
				smsGateway.SMSSend( mobile, msg);
				otpGeneration.sveOtp(userid, mobile, otp);
			}
		}
		if(mode.equalsIgnoreCase("get"))
		{
			String otp=otpGeneration.getOtp(userid);
			String enteredOtp=frm.getOtp();
				if(enteredOtp.equals(otp)){ 
				}
				else 
				{
					mode="data";
					message="Invalid OTP";
					request.setAttribute("message", message);
				}
		}
		/*if(mode!=null && mode.equalsIgnoreCase("save"))
			{
				 message=ifscCode_DAO.saveIFSCCode(frm);
				request.setAttribute("message",message);
				reset(frm);
			}
		if(mode.equalsIgnoreCase("view") || mode.equalsIgnoreCase("ViewReport"))
		{
				ifscdetails=ifscCode_DAO.getIfscDetails();
				session.setAttribute("ifscdetails",ifscdetails);
		}
		if(mode.equalsIgnoreCase("get"))
		{
				form = ifscCode_DAO.getIfsc(request.getParameter("ifscCode"));
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
		}
			if(mode.equalsIgnoreCase("Update"))
		{
				message=ifscCode_DAO.updateIfscDetails(frm);
				request.setAttribute("message",message);
		}
			if(mode.equalsIgnoreCase("delete"))
		{
				message=ifscCode_DAO.removeIfscDetails(request.getParameter("ifscCode"));
				request.setAttribute("message",message);
		}*/
		
		}
		catch(Exception e){
			Debug.println("Exception in Rws_OTP_ENC_Action "+e);
		}
		return(mapping.findForward(mode));
	}
	void reset(Rws_OTP_ENC_Form frm)
	{
		frm.setOtp("");
	}
}
	