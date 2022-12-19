package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_AssetCompTypeEntryAct_frm extends Action {
	protected ActionForm buildAssetCompTypeForm(String assetTypeCode,String assetCompTypeCode,HttpServletRequest request) throws Exception {
		AssetCompTypeForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getAssetCompType(assetTypeCode,assetCompTypeCode,getDataSource(request));		
			if(rwsMaster!=null){
				form = new AssetCompTypeForm();
				form.setAssetTypeCode(rwsMaster.getAssetTypeCode()+" "+rwsMaster.getAssetTypeName());
				form.setAssetCompTypeCode(rwsMaster.getAssetCompTypeCode());
				form.setAssetCompTypeName(rwsMaster.getAssetCompTypeName());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList assetCompTypes=null;
		ArrayList assetTypes=new ArrayList();
		AssetCompTypeForm frm=(AssetCompTypeForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		ValidationUtils validate = new ValidationUtils ();
		if(mode.equalsIgnoreCase("data")) {
			try	{
				CommonLists commonLists = new CommonLists(getDataSource(request));
				assetTypes = commonLists.getAssetTypes();
				session.setAttribute("assetTypes",assetTypes);
				if(request.getParameter("assetTypeCode")!=null)	{
					request.setAttribute("code",RwsMasterData.getAssetCompTypeCode(request.getParameter("assetTypeCode"),getDataSource(request)));
				}
			}
			catch(Exception e){
				System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in inc is  = "+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("view")){
			try{
				String typeOfAsset=frm.getAssetTypeCode();
				if(typeOfAsset.indexOf(" ")!=-1)
				typeOfAsset=typeOfAsset.substring(0,2);
				assetCompTypes=RwsMasterData.getAssetCompTypes(typeOfAsset,getDataSource(request));
				session.setAttribute("assetCompTypes",assetCompTypes);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in view is : "+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("save")){
			if (storedToken.equals(token)) {
				try	{
					RwsMaster rwsMaster = new RwsMaster();					
					rwsMaster.setAssetTypeCode(frm.getAssetTypeCode());
					rwsMaster.setAssetCompTypeCode(frm.getAssetCompTypeCode());
					rwsMaster.setAssetCompTypeName(frm.getAssetCompTypeName());	
					if(frm.getAssetTypeCode() != null && validate.numValidator(frm.getAssetTypeCode()) != true){
						RwsMasterData.errorMessage="Please Select Correct Type of Asset.";
					}
					else if(frm.getAssetCompTypeName() != null && validate.aphaWithSpaceValidator(frm.getAssetCompTypeName()) != true){
						RwsMasterData.errorMessage="Asset Component Type Name Only Contains Alphabets with Space";
					}
					else if(frm.getAssetCompTypeCode() != null && validate.numValidator(frm.getAssetCompTypeCode()) != true){
						RwsMasterData.errorMessage="Asset Component Type Code  Only Contain numbers";
					}else{
						ans=RwsMasterData.insertAssetCompType(rwsMaster,getDataSource(request));						
					}					
					frm.reset(mapping,request);				
				}
				catch(Exception e){
					System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in insert is : "+e.getMessage());
				}
				if(ans <1){	
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
						message = RwsMasterData.errorMessage;
					else
					message="The Record Cant be inserted   ";
				}
				else{	
					message="Record Inserted Successfully";
				}
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("get")){
			try {
					form = buildAssetCompTypeForm(request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),request);
					if ("request".equalsIgnoreCase(mapping.getScope())) {
						request.setAttribute(mapping.getAttribute(), form);
					}
					else {
						session.setAttribute(mapping.getAttribute(), form);
					}
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in get is : "+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)) {
				try	{
					RwsMaster rwsMaster = new RwsMaster();						
					rwsMaster.setAssetTypeCode(frm.getAssetTypeCode().substring(0,frm.getAssetTypeCode().indexOf(" ")));
					rwsMaster.setAssetCompTypeCode(frm.getAssetCompTypeCode());
					rwsMaster.setAssetCompTypeName(frm.getAssetCompTypeName());
					ans = RwsMasterData.updateAssetCompType(rwsMaster,getDataSource(request));
				}
				catch (Exception e) {	
					System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in edit is "+e.getMessage());
				}
				if(ans <1){	
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
						message = RwsMasterData.errorMessage;
					else
					message="The record cannot be updated.";
					mode = "get";
					request.setAttribute("message",message);
				}	
			}
		}
		
		if(mode.equalsIgnoreCase("delete")){
			try {
					ans=RwsMasterData.removeAssetCompType(request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),getDataSource(request));
					if(ans>0){
						displaymess = "Data deleted Succesfully";
					}
					else {
						displaymess = "Data cannot be deleted";
					}
					request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e){
				System.out.println("The Exception in rws_AssetCompTypeEntryAct_frm in delete is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
