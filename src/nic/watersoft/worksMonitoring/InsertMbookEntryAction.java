package nic.watersoft.worksMonitoring;
import javax.servlet.*;
import java.io.*;
import org.apache.struts.action.*;
import javax.servlet.http.*;

public class InsertMbookEntryAction extends Action
{
	public ActionForward execute (ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		String target = new String("success");
		return mapping.findForward(target);
	}
}
