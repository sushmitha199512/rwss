package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class ShowComponentDetails extends Action
{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		
		String target="";
		RwsMasterData rwsMasterData = new RwsMasterData();
		String typeOfAssetCode = request.getParameter("typeOfAssetCode");
		String habCode = request.getParameter("habCode");
		ArrayList assets = rwsMasterData.getComponentDetails(typeOfAssetCode, habCode, getDataSource(request));
		HttpSession session=request.getSession();
		//System.out.println("size="+assets.size());
		
		/*else if(typeOfAssetCode.equals("07"))
		{	
			session.setAttribute("dwtanks",assets);
			if(assets.size()>0) request.setAttribute("value","dwtanks");
		}*/
		if(typeOfAssetCode.equals("01"))
		{	
			 session.setAttribute("PWS", assets);
			 if(assets.size()>0) request.setAttribute("value","PWS");
		}
		else if(typeOfAssetCode.equals("02"))
		{	
			 session.setAttribute("MPWS", assets);
			 if(assets.size()>0) request.setAttribute("value","MPWS");
		}
		else if(typeOfAssetCode.equals("03"))
		{
			session.setAttribute("CPWS", assets);
			if(assets.size()>0) request.setAttribute("value","CPWS");
		}
		else if(typeOfAssetCode.equals("04"))
		{
			session.setAttribute("components", assets);
			if(assets.size()>0) request.setAttribute("value","handpumps");
		}
		else if(typeOfAssetCode.equals("05"))
		{
			session.setAttribute("shallowhandpumps", assets);
			if(assets.size()>0) request.setAttribute("value","shallowhandpumps");
		}
		
		else if(typeOfAssetCode.equals("06"))
		{	
			session.setAttribute("openwells",assets);
			if(assets.size()>0) request.setAttribute("value","openwells");
		}
		else if(typeOfAssetCode.equals("07"))
		{	
			session.setAttribute("ponds",assets);
			if(assets.size()>0) request.setAttribute("value","ponds");
			session.removeAttribute("components");
		}
		
		
		else{
			session.removeAttribute("PWS");
			session.removeAttribute("ponds");
		}
		if(typeOfAssetCode.equals("04"))
		   target = new String("data-success");
	    else
			   target = new String("success");
		return mapping.findForward(target);
	}
}
