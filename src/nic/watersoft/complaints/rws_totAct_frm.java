
package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class rws_totAct_frm extends Action
{

    public rws_totAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = " ";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        CompForm frm = (CompForm)form;
        String dmessage = "";
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(mode != null && mode.equalsIgnoreCase("get2"))
        {
        	try
			{
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
                reset(frm);
                
            }
       
                complaintMasterData = new ComplaintMasterData();
                districts = complaintMasterData.getCompDistricts(getDataSource(request));
                session.setAttribute("districts", districts);
			}
        	catch(Exception o)
			{
        		o.printStackTrace();
			}
        
        page_to_be_displayed="get2";
    }
        return mapping.findForward(page_to_be_displayed);
    }
    public void reset(CompForm frm)
    {
        frm.setDist("");
          }
}
