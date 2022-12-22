/*
 * Created on Apr 15, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.estimates;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.SourceDTO;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowSourceDetails extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response) throws ServletException,Exception
	{
		String target = new String("success");
		String sourceCode = request.getParameter("sourceCode");
		//System.out.println("Source Code in  ShowSourceDetails: " + sourceCode);
		CommonLists commonLists = new CommonLists(getDataSource(request));
		SourceDTO sourceDTO = new SourceDTO();
		if(sourceCode != null)
		{
			sourceDTO = commonLists.getSourceDetails(sourceCode);
		}
		
		request.setAttribute("sourceDTO", sourceDTO);
		
		return mapping.findForward(target);
	}
}