
/*
 * Created on 26-Aug-2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Constants;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Mandal_SubDivisionConAct_frm extends Action{
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList mandalSubdivisions=new ArrayList();
		ArrayList subdivisions=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList dists= new ArrayList();
		ArrayList mandals = new ArrayList();
		String divname="";
		String subdivname="";
		String subdivname1="";
		
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		MandalSubDivisionConForm mandalSubDivisionForm=(MandalSubDivisionConForm) form;
		String mode=mandalSubDivisionForm.getMode();
		RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsMaster rwsMaster = new RwsMaster();		
		if(mode.equalsIgnoreCase("data")){
			try	{
			   dists=rwsOffices.getDistricts();
			   session.setAttribute("dists",dists);
			   mandals=rwsOffices.getMandals(mandalSubDivisionForm.getDcode());
			   session.setAttribute("mandals",mandals);
			   divname=rwsOffices.getDivname(mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getMandal());
			   if(divname != null && !divname.equals("")){
				   String a[]=divname.split("-");
				   subdivname=rwsOffices.getSubDivname(mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getMandal(),a[1]);
				   String b[]=subdivname.split("@");
				   mandalSubDivisionForm.setDname(a[0]);
				   mandalSubDivisionForm.setDnameCode(a[1]);
				   mandalSubDivisionForm.setSdname(b[0]);
				   mandalSubDivisionForm.setSdnameCode(b[1]);
			   }
			   divisions=rwsOffices.getDivisions("1",mandalSubDivisionForm.getDcode());
			   session.setAttribute("divisions",divisions);
			   subdivisions=rwsOffices.getSubdivisions("1",mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getDoc());
			   session.setAttribute("subdivisions",subdivisions);
			   
			 }
			catch(Exception e){
				System.out.println("The Exception in rws_Mandal_SubDivisionConAct_frm : "+e);
				e.printStackTrace();
			}
		}
		
		if(mode.equalsIgnoreCase("msName")){
			try{
				   dists=rwsOffices.getDistricts();
				   session.setAttribute("dists",dists);
				   System.out.println(mandalSubDivisionForm.getDcode());
				   mandals=rwsOffices.getMandals(mandalSubDivisionForm.getDcode());
				   session.setAttribute("mandals",mandals);
				   divisions=rwsOffices.getDivisions("1",mandalSubDivisionForm.getDcode());
				   session.setAttribute("divisions",divisions);
				   subdivisions=rwsOffices.getSubdivisions("1",mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getDoc());
				   session.setAttribute("subdivisions",subdivisions);				 
			 }
			catch(Exception e){
				System.out.println("The Exception in rws_Mandal_SubDivisionConAct_frm : "+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("save1")){
			try	{	
				if (storedToken.equals(token)){						
					rwsMaster.setDcode(mandalSubDivisionForm.getDcode());
					rwsMaster.setSubdivision(mandalSubDivisionForm.getSdname());
					rwsMaster.setDoc(mandalSubDivisionForm.getDoc());
					rwsMaster.setSdoc(mandalSubDivisionForm.getSdoc());
					subdivname1=rwsOffices.getSubDivname1(mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getDoc(),mandalSubDivisionForm.getSdoc());
					RwsMasterData rwsMasterData=new RwsMasterData();
					ans=rwsMasterData.insertMandalSubDivisionName(mandalSubDivisionForm.getSdname(),mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getDoc(),mandalSubDivisionForm.getSdoc());
					mode = "msName";
				}
			}
			catch(Exception e){
				System.out.println("The Exception in rws_Mandal_SubDivisionConAct_frm : "+e.getMessage());
			}
			if(ans <1){
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message="The SubDivision Name Cant be Changed";
		 				
			}
			else {
				message=" '"+subdivname1+"' SubDivision Name Changed To '"+mandalSubDivisionForm.getSdname()+"' Successfully  ";
				reset(mandalSubDivisionForm);		 
			}
			request.setAttribute("message",message);
		}
		
		if(mode.equalsIgnoreCase("save")){
			try	{
				if (storedToken.equals(token)){	
					rwsMaster.setDcode(mandalSubDivisionForm.getDcode());
					rwsMaster.setMandal(mandalSubDivisionForm.getMandal());
					rwsMaster.setDivisionCode(mandalSubDivisionForm.getDnameCode());
					rwsMaster.setSubdivision(mandalSubDivisionForm.getSdnameCode());
					rwsMaster.setDoc(mandalSubDivisionForm.getDoc());
					rwsMaster.setSdoc(mandalSubDivisionForm.getSdoc());
					ans=RwsMasterData.insertMandalSubDivisionCon(rwsMaster);
					subdivname1=rwsOffices.getSubDivname1(mandalSubDivisionForm.getDcode(),mandalSubDivisionForm.getDoc(),mandalSubDivisionForm.getSdoc());
					mode = "save";
				}
			}
			catch(Exception e){
				System.out.println("The Exception in rws_Mandal_SubDivisionConAct_frm : "+e.getMessage());
			}
			if(ans <1){
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message="The Record Cant be inserted";			 				
			}
			else {		
				 message="Mandal and related Works,Assets Changed Successfully From '"+mandalSubDivisionForm.getSdname()+"'Subdivision To '"+subdivname1+"'SubDivision ";
				 reset(mandalSubDivisionForm);
			}
			request.setAttribute("message",message);
		}
	
		return(mapping.findForward(mode));
	}
	
	public void reset(MandalSubDivisionConForm myForm){
		myForm.setDcode("");
		myForm.setMandal("");
		myForm.setDname("");
		myForm.setSdname("");
		myForm.setDoc("");
		myForm.setSdoc("");
	}
}

