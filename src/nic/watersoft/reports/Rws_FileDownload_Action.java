package nic.watersoft.reports;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.text.SimpleDateFormat;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_FileDownload_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || user.getUserId().equals("pdswsm")))) {
			return mapping.findForward("unAuthorise");	
		}
		String fname = (String) session.getAttribute("fname");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename="+ fname);
		try {
			WorksData1 wd = new WorksData1();
			String mydate = wd.getServerDate();
			SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
			SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
			try {
				java.util.Date date = sdfSource.parse(mydate);
				mydate = sdfDestination.format(date);
			} catch (Exception pe) {
				System.out.println("The Exception in Rws_FileDownload_Action is  = "+pe.getMessage());
			}
			URL url = getServlet().getServletContext().getResource("/portings" + File.separator + fname);
			if (url != null) {
				InputStream in = url.openStream();
				ServletOutputStream out = response.getOutputStream();
				byte[] outputByte = new byte[4096];
				while (in.read(outputByte, 0, 4096) != -1) {
					out.write(outputByte, 0, 4096);
				}
				in.close();
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception in Rws_FileDownload_Action is  = "+e.getMessage());
		}
		return null;
	}
}
