package nic.watersoft.reports;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Mdb_File_Porting_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String tablesName=request.getParameter("tablesName");
		String mode="";
		Rws_Mdb_File_Porting_DAO dao=new Rws_Mdb_File_Porting_DAO();
		try	{
			if (storedToken.equals(token)) {
				if(tablesName!=null && tablesName.equals("Bank Related Tables")){
					String mdbdname="Bank Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createBankRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Works Related Tables")){
					String mdbdname="Works Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createWorkRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Habitation Related Tables")){
					String mdbdname="Habitation Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createHabRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Sources Related Tables")){
					String mdbdname="Sources Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")	+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createSourceRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Asset Related Tables")){
					String mdbdname="Asset Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createAssetRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Drought Related Tables")){
					String mdbdname="Drought Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/") + "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createDroughtRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("School Related Tables")){
					String mdbdname="School Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")	+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createSchoolRelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("YDU Related Tables")){
					String mdbdname="YDU Related Tables.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createYDURelatedMdb(filename);
					mode="get";
				}
				else if(tablesName!=null && tablesName.equals("Total Habitations Related Table")){
					String mdbdname="Total Habitations Related Table.mdb";
					String filepath = request.getSession().getServletContext().getRealPath("/")	+ "portings";
					session.setAttribute("fname", mdbdname);
					String filename = filepath + File.separator + mdbdname;
					dao.createTotalHabitationsRelatedTable(filename);
					mode="get";
				}
				else{
					request.setAttribute("message", "Failed To Download the file");
					mode="fail";
				}
			}
		}
		catch(Exception e){
			System.out.println("The Exception in rws_Mdb_File_Porting_Act is  = "+e.getMessage());
		}
		return mapping.findForward(mode);
	}
}