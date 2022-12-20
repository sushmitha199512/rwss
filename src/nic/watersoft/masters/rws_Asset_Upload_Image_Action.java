package nic.watersoft.masters;
import java.io.File;
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

public class rws_Asset_Upload_Image_Action extends Action
{
	

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList assetTypes=null;
		HttpSession session=request.getSession();
		AssetForm assetForm = (AssetForm) form;
		String mode=(String) request.getParameter("mode");
		String assetCode=(String) request.getParameter("assetCode");
		rws_Asset_Upload_Image_DAO  dao=new  rws_Asset_Upload_Image_DAO();
		try {
			
		if(mode.equalsIgnoreCase("imageUpload"))
		{
			String targetPath = getServlet().getServletContext().getRealPath(
					"")
					+ File.separator + "temp.jpg";
			assetForm.setAssetCode(assetCode);
				message=dao.updateAssetImage(assetForm,targetPath,getServlet());
				request.setAttribute("message", message);
			
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return(mapping.findForward(mode));
	}
	
}
