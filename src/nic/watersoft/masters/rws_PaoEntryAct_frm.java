package nic.watersoft.masters;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_PaoEntryAct_frm extends Action {
	protected ActionForm buildPaoForm(String paocode, HttpServletRequest request) throws Exception {
		PaoForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getPao(paocode, getDataSource(request));
		if (rwsMaster != null) {
			form = new PaoForm();
			form.setDistcode(rwsMaster.getDistcode());
			form.setPaocode(rwsMaster.getPaocode());
			form.setAddress1(rwsMaster.getAddress1());
			form.setLocation(rwsMaster.getLocation());
			form.setArea(rwsMaster.getArea());
			form.setCity(rwsMaster.getCity());
			form.setPin(rwsMaster.getPin());
			form.setPhone(rwsMaster.getPhone());
			form.setEmail(rwsMaster.getEmail());
			form.setFax(rwsMaster.getFax());
			form.setPaoName(rwsMaster.getPaoName());
			form.setPaoapao(rwsMaster.getPaoapao());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String target = null;
		int ans = 0;
		String message = null;
		ArrayList paos = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		PaoForm frm = (PaoForm) form;
		String mode = frm.getMode();
		int maxPao = 0;
		String maxPao1 = "";
		if (mode.equalsIgnoreCase("data")) {
			try {
				RwsOffices rwsoffice = new RwsOffices(getDataSource(request));
				ArrayList dists = rwsoffice.getDistricts();
				request.setAttribute("districts", dists);
				if (frm.getDistcode() != null && !frm.getDistcode().equals("") && !frm.getDistcode().equals(" ")
						&& !frm.getDistcode().equals("  ") && !frm.getDistcode().equals("00")) {
					maxPao = RwsMasterData.getMaxPao(getDataSource(request), frm.getDistcode());
					maxPao1 = "" + maxPao;
					if (maxPao < 10) {
						maxPao1 = "0" + maxPao;
					}
					request.setAttribute("maxPao", maxPao1);
				} else {
					request.setAttribute("maxPao", "");
				}
			} catch (Exception e) {
				System.err.println(e);
			}
			target = "data";
		}
		if (mode.equalsIgnoreCase("printing")) {
			try {
				paos = RwsMasterData.getPaos(getDataSource(request));
				session.setAttribute("paos", paos);
			} catch (Exception e) {
				System.err.println(e);
			}
			target = "printing";
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				paos = RwsMasterData.getPaos(getDataSource(request));
				session.setAttribute("paos", paos);
			} catch (Exception e) {
				System.err.println(e);
			}
			target = "view";
		}
		if (mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					ValidationUtils validation = new ValidationUtils();			
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setDistcode(frm.getDistcode());
					rwsMaster.setPaocode(frm.getPaocode());
					rwsMaster.setAddress1(frm.getAddress1());
					rwsMaster.setAddress2(frm.getAddress2());
					rwsMaster.setAddress3(frm.getAddress3());
					if (!validation.aphaWithSpaceValidator(frm.getCity())) {
						message = "Invalid Input (City)";
						request.setAttribute("message", message);
						return mapping.findForward("data");
					}
					rwsMaster.setCity(frm.getCity());
					if (!validation.numValidator(frm.getPin())) {
						message = "Invalid Input (Pincode)";
						request.setAttribute("message", message);
						return mapping.findForward("data");
					}					
					rwsMaster.setPin(frm.getPin());
					if (!validation.phoneValidator(frm.getPhone())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("data");
					}
					rwsMaster.setPhone(frm.getPhone());
					if (!validation.emailValidator(frm.getEmail())) {
						message = "Invalid Input (Email)";
						request.setAttribute("message", message);
						return mapping.findForward("data");
					}
					rwsMaster.setEmail(frm.getEmail());						
					rwsMaster.setFax(frm.getFax());
					if (!validation.aphaWithSpaceValidator(frm.getPaoName())) {
						message = "Invalid Input (Pao Name)";
						request.setAttribute("message", message);
						return mapping.findForward("data");
					}
					rwsMaster.setPaoName(frm.getPaoName());
					rwsMaster.setPaoapao(frm.getPaoapao());
					ans = RwsMasterData.insertPao(rwsMaster, getDataSource(request));
					
					RwsOffices rwsoffice = new RwsOffices(getDataSource(request));					
					ArrayList dists = rwsoffice.getDistricts();
					request.setAttribute("districts", dists);
					
					if (frm.getDistcode() != null && !frm.getDistcode().equals("") && !frm.getDistcode().equals(" ")
							&& !frm.getDistcode().equals("  ") && !frm.getDistcode().equals("00")) {
						maxPao = RwsMasterData.getMaxPao(getDataSource(request), frm.getDistcode());
						maxPao1 = "" + maxPao;
						if (maxPao < 10) {
							maxPao1 = "0" + maxPao;
						}
						request.setAttribute("maxPao", maxPao1);
					}
				} catch (SQLException e) {
					// System.out.println("the error is"+e);
				} catch (Exception e) {
					// System.out.println("the error is"+e);
				}
			}
			if (ans < 1) {
				message = "The Record Cant be inserted   ";
			} else {
				message = "Record Inserted Successfully";
			}
			request.setAttribute("message", message);
			target = "save";
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildPaoForm(request.getParameter("paocode"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				// System.out.println("the error is"+e);
			}
			target = "get";
		}
		if (mode.equalsIgnoreCase("edit")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					String paoCode = frm.getPaocode();
					ValidationUtils validation = new ValidationUtils();
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setDistcode(frm.getDistcode());
					rwsMaster.setPaocode(frm.getPaocode());
					rwsMaster.setAddress1(frm.getAddress1());
					rwsMaster.setAddress2(frm.getAddress2());
					rwsMaster.setAddress3(frm.getAddress3());
					if (!validation.aphaWithSpaceValidator(frm.getCity())) {
						message = "Invalid Input (City)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					rwsMaster.setCity(frm.getCity());
					if (!validation.numValidator(frm.getPin())) {
						message = "Invalid Input (Pincode)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}					
					rwsMaster.setPin(frm.getPin());
					if (!validation.phoneValidator(frm.getPhone())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					rwsMaster.setPhone(frm.getPhone());
					if (!validation.emailValidator(frm.getEmail())) {
						message = "Invalid Input (Email)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					rwsMaster.setEmail(frm.getEmail());						
					rwsMaster.setFax(frm.getFax());
					if (!validation.aphaWithSpaceValidator(frm.getPaoName())) {
						message = "Invalid Input (Pao Name)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					rwsMaster.setPaoName(frm.getPaoName());
					rwsMaster.setPaoapao(frm.getPaoapao());
					int updates = RwsMasterData.updatePao(rwsMaster, getDataSource(request));				
					if (updates == 0) {
						request.setAttribute("message", "Record Cannot be Updated");
					} else if (updates == 1) {
						paos = RwsMasterData.getPaos(getDataSource(request));
						session.setAttribute("paos", paos);
						request.setAttribute("message", "Record Updated Successfully");
					}
				} catch (Exception e) {
					System.out.println("the error is" + e);
				}
			}
			target = "view";
		}
		if (mode.equalsIgnoreCase("delete")) {
			try {
				RwsMasterData.removePao(request.getParameter("paocode"), getDataSource(request));
				paos = RwsMasterData.getPaos(getDataSource(request));
				session.setAttribute("paos", paos);
			} catch (Exception e) {
				// System.out.println("the error is"+e);
			}
			target = "delete";
		}
		return (mapping.findForward(target));
	}
}
