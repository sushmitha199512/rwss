package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Constants;	
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_AssetTypeEntryAct_frm extends Action {
	protected ActionForm buildAssetTypeForm(String assetTypeCode,HttpServletRequest request) throws Exception{
		AssetTypeForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getAssetType(assetTypeCode,getDataSource(request));		
			if(rwsMaster!=null){
				form = new AssetTypeForm();
				form.setAssetTypeCode(rwsMaster.getAssetTypeCode());
				form.setAssetTypeName(rwsMaster.getAssetTypeName());
				form.setCodeSeries(rwsMaster.getCodeSeries());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList assetTypes=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");	    
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		AssetTypeForm frm=(AssetTypeForm) form;
		ValidationUtils validate = new ValidationUtils ();
		String mode=frm.getMode();		 
		if(mode.equalsIgnoreCase("data")){
			RwsMasterData.errorMessage=null;
			try{
				request.setAttribute("acode",RwsMasterData.getAssetTypeCode(getDataSource(request)));
			}
			catch(Exception e){
				System.err.println("The Exception in rws_AssetTypeEntryAct_frm in inc is "+ e.getMessage());
			}
		}
		if(mode.equalsIgnoreCase("view")){
			try	{
				assetTypes=RwsMasterData.getAssetTypes(getDataSource(request));
				session.setAttribute("assetTypes",assetTypes);
			}
			catch(Exception e){
				System.err.println("The Exception in rws_AssetTypeEntryAct_frm in view is "+ e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("save")){
			if (storedToken.equals(token)){
				try	{
					RwsMaster rwsMaster = new RwsMaster();					
					rwsMaster.setAssetTypeCode(frm.getAssetTypeCode());
					rwsMaster.setAssetTypeName(frm.getAssetTypeName());
					rwsMaster.setCodeSeries(frm.getCodeSeries());
					if(frm.getAssetTypeCode() != null && validate.numValidator(frm.getAssetTypeCode()) != true){
						RwsMasterData.errorMessage="Asset Type Code Only Contain numbers";
					}
					else if(frm.getAssetTypeName() != null && validate.aphaWithSpaceValidator(frm.getAssetTypeName()) != true){
						RwsMasterData.errorMessage="Asset Type Name Only Contains Alphabets with Space";
					}
					else if(frm.getCodeSeries() != null && validate.numValidator(frm.getCodeSeries()) != true){
						RwsMasterData.errorMessage="Code  Series Only Contain numbers  ";
					}else{
						ans=RwsMasterData.insertAssetType(rwsMaster,getDataSource(request));						
					}
					request.setAttribute("acode",RwsMasterData.getAssetTypeCode(getDataSource(request)));
					reset(frm);
				}			
				catch(Exception e){
					System.err.println("The Exception in rws_AssetTypeEntryAct_frm in insert is "+ e.getMessage());
				}
				if(ans <1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						message = RwsMasterData.errorMessage;
					else
					message="The Record Cant be inserted  ";
				}
				else{
					message="Record Inserted Successfully";
				}			
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("get")){
			try {
				form = buildAssetTypeForm(request.getParameter("assetTypeCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e){
				System.err.println("The Exception in rws_AssetTypeEntryAct_frm in get is "+ e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)){
				try	{
					RwsMaster rwsMaster = new RwsMaster();						
					rwsMaster.setAssetTypeCode(frm.getAssetTypeCode());
					rwsMaster.setAssetTypeName(frm.getAssetTypeName());
					rwsMaster.setCodeSeries(frm.getCodeSeries());					
					ans = RwsMasterData.updateAssetType(rwsMaster, getDataSource(request));									
				}
				catch (Exception e) {
					System.err.println("The error in rws_AssetTypeEntryAct_frm in edit is "+e);
				}
				if(ans <1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0){
						message="The record updated Successfully.";
					}
					else
						message="The record cannot be updated.";
						mode = "get";
						request.setAttribute("message",message);	
						reset(frm);				
				}					
			}
		}
		
		if(mode.equalsIgnoreCase("delete")){
			try {
				ans=RwsMasterData.removeAssetType(request.getParameter("assetTypeCode"),getDataSource(request));
				if(ans>0){
					displaymess = "Data deleted Succesfully";
				}
				else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) {
				System.err.println("The Exception in rws_AssetTypeEntryAct_frm in delete is " + e.getMessage());
			}
		}
		return(mapping.findForward(mode));
	}
	
	public void reset(AssetTypeForm frm){
		 frm.setAssetTypeName("");
		 frm.setCodeSeries("");
	}
}
