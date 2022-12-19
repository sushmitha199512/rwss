package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_ContractorEntryAct_frm extends Action {

	ArrayList projectsexecuted = new ArrayList();

	ArrayList projectsexecutedintime = new ArrayList();

	ArrayList projectsinhand = new ArrayList();

	int year = 0;

	Cryptography encrypter = null;
	String decrypted = null;

	int lastfiveyear = 0;

	String five = "";

	ArrayList circles = new ArrayList();

	ArrayList divisions1 = new ArrayList();

	ArrayList projectlastfive = new ArrayList();

	ArrayList divisionwise = new ArrayList();

	String headofficecode = "";

	protected ActionForm buildContractorForm(String contractorCode, HttpServletRequest request, String amount,
			String circle) throws Exception {
		ContractorForm contractForm = null;
	
		RwsMaster rwsMaster = RwsMasterData.getContractor(contractorCode, getDataSource(request));
		if (rwsMaster != null) {
			contractForm = new ContractorForm();

			contractForm.setContractorCode(rwsMaster.getContractorCode());
			contractForm.setContractorClass(rwsMaster.getContractorClass());
			contractForm.setContractorRating(rwsMaster.getContractorRating());
			contractForm.setContractorRegno(rwsMaster.getContractorRegno());
			contractForm.setRegisterAt(rwsMaster.getRegisterAt());
			contractForm.setRegistrationDate(rwsMaster.getRegistrationDate());
			contractForm.setStreet(rwsMaster.getStreet());
			contractForm.setArea(rwsMaster.getArea());
			contractForm.setCity(rwsMaster.getCity());
			contractForm.setPin(rwsMaster.getPin());
			contractForm.setPhone(rwsMaster.getPhone());
			contractForm.setMobile(rwsMaster.getMobile());
			contractForm.setFax(rwsMaster.getFax());
			contractForm.setEmail(rwsMaster.getEmail());
			contractForm.setPanNo(rwsMaster.getPanNo());
			contractForm.setTinNo(rwsMaster.getTinNo());
			contractForm.setValidFrom(rwsMaster.getValidFrom());
			contractForm.setValidTo(rwsMaster.getValidTo());
			contractForm.setVoterId(rwsMaster.getVoterId());
			
			if ((rwsMaster.getAdharNo() != null && !rwsMaster.getAdharNo().equalsIgnoreCase(""))) {
				encrypter = new Cryptography("Welcome To Rwss Department!");
				decrypted = encrypter.decrypt(rwsMaster.getAdharNo());
			}
			contractForm.setAdharNo((decrypted != null && !decrypted.equalsIgnoreCase(""))
					? ("XXXXXXXX" + decrypted.substring(decrypted.length() - 4, decrypted.length()))
					: decrypted);
			contractForm.setBankName(rwsMaster.getBankName());
			contractForm.setBranchName(rwsMaster.getBranchName());
			contractForm.setIfscCode(rwsMaster.getIfscCode());
			contractForm.setAccountNo(rwsMaster.getAccountNo());
			contractForm.setBranchAddress(rwsMaster.getBranchAddress());

			year = RwsMasterData.getProjectsyear();
			lastfiveyear = year - 5;
			five = "" + lastfiveyear;
			
			projectsexecuted = RwsMasterData.getProjectsexecuted(request.getParameter("contractorCode"), amount,
					circle);
			request.setAttribute("projectsexecuted", projectsexecuted);
			
			projectsinhand = RwsMasterData.getProjectsinhand(request.getParameter("contractorCode"), amount, circle);
			request.setAttribute("projectsinhand", projectsinhand);
			
			projectsexecutedintime = RwsMasterData.getProjectscompletedintime(request.getParameter("contractorCode"),
					amount, circle);
			request.setAttribute("projectsexecutedintime", projectsexecutedintime);
			
			projectlastfive = RwsMasterData.getProjectscompletedintimelastfive(request.getParameter("contractorCode"),
					five, amount, circle);
			request.setAttribute("projectlastfive", projectlastfive);
		
			contractForm.setProjectsCompletedInTime(rwsMaster.getProjectsCompletedInTime());
			contractForm.setProjectsAbandoned(rwsMaster.getProjectsAbandoned());
			contractForm.setNoofEoat(rwsMaster.getNoofEoat());
			contractForm.setNoofSupplentary(rwsMaster.getNoofSupplentary());
			contractForm.setNoofPenalised(rwsMaster.getNoofPenalised());
			contractForm.setRemarks(rwsMaster.getRemarks());
			contractForm.setVatNo(rwsMaster.getVatNo());
			contractForm.setSpecialize(rwsMaster.getSpecialize());
			contractForm.setFirstName(rwsMaster.getFirstName());
			contractForm.setLastName(rwsMaster.getLastName());
			contractForm.setMiddleName(rwsMaster.getMiddleName());

		}
		return contractForm;
	}

	protected ActionForm buildContractorFormByContractorName(String contractorCode, HttpServletRequest request)
			throws Exception {
		ContractorForm contractForm = null;
		RwsMaster rwsMaster = RwsMasterData.getContractor(contractorCode, getDataSource(request));
		if (rwsMaster != null) {
			contractForm = new ContractorForm();

			contractForm.setContractorCode(rwsMaster.getContractorCode());
			contractForm.setContractorClass(rwsMaster.getContractorClass());
			contractForm.setContractorRating(rwsMaster.getContractorRating());
			contractForm.setContractorRegno(rwsMaster.getContractorRegno());
			contractForm.setRegisterAt(rwsMaster.getRegisterAt());
			contractForm.setRegistrationDate(rwsMaster.getRegistrationDate());
			contractForm.setStreet(rwsMaster.getStreet());
			contractForm.setArea(rwsMaster.getArea());
			contractForm.setCity(rwsMaster.getCity());
			contractForm.setPin(rwsMaster.getPin());
			contractForm.setPhone(rwsMaster.getPhone());
			contractForm.setMobile(rwsMaster.getMobile());
			contractForm.setFax(rwsMaster.getFax());
			contractForm.setEmail(rwsMaster.getEmail());
			contractForm.setPanNo(rwsMaster.getPanNo());
			contractForm.setTinNo(rwsMaster.getTinNo());
			contractForm.setValidFrom(rwsMaster.getValidFrom());
			contractForm.setValidTo(rwsMaster.getValidTo());
			contractForm.setProjectsExecuted(rwsMaster.getProjectsExecuted());
			contractForm.setProjectsInhand(rwsMaster.getProjectsInhand());
			contractForm.setProjectsCompletedLastYear(rwsMaster.getProjectsCompletedLastYear());
			contractForm.setProjectsCompletedInTime(rwsMaster.getProjectsCompletedInTime());
			contractForm.setProjectsAbandoned(rwsMaster.getProjectsAbandoned());
			contractForm.setNoofEoat(rwsMaster.getNoofEoat());
			contractForm.setNoofSupplentary(rwsMaster.getNoofSupplentary());
			contractForm.setNoofPenalised(rwsMaster.getNoofPenalised());
			contractForm.setRemarks(rwsMaster.getRemarks());
			contractForm.setVatNo(rwsMaster.getVatNo());
			contractForm.setSpecialize(rwsMaster.getSpecialize());
			contractForm.setFirstName(rwsMaster.getFirstName());
			contractForm.setLastName(rwsMaster.getLastName());
			contractForm.setMiddleName(rwsMaster.getMiddleName());
			contractForm.setVoterId(rwsMaster.getVoterId());

			if ((rwsMaster.getAdharNo() != null && !rwsMaster.getAdharNo().equalsIgnoreCase(""))) {
				encrypter = new Cryptography("Welcome To Rwss Department!");
				decrypted = encrypter.decrypt(rwsMaster.getAdharNo());
			}
	
			contractForm.setAdharNo((decrypted != null && !decrypted.equalsIgnoreCase(""))
					? ("XXXXXXXX" + decrypted.substring(decrypted.length() - 4, decrypted.length()))
					: decrypted);
			contractForm.setBankName(rwsMaster.getBankName());
			contractForm.setBranchName(rwsMaster.getBranchName());
			contractForm.setIfscCode(rwsMaster.getIfscCode());
			contractForm.setAccountNo(rwsMaster.getAccountNo());
			contractForm.setBranchAddress(rwsMaster.getBranchAddress());

		}
		return contractForm;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList contractors = null;
		RwsMaster rwsMaster = new RwsMaster();
		ContractorForm contractForm = (ContractorForm) form;
		String mode = contractForm.getMode();
		HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {

			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		if (mode.equalsIgnoreCase("data")) {
			try {
				request.setAttribute("code", RwsMasterData.getContractorCode(getDataSource(request)));
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm data is " + e);
			}
		}
		
		
		if (mode.equalsIgnoreCase("projexecuted")) {
			try {
		
				String cir = request.getParameter("circleOfficeCode");
				String amount = (String) session.getAttribute("amountwise");
				projectsexecuted = RwsMasterData.getProjectsexecuted(request.getParameter("contractorCode"), amount,
						cir);

				request.setAttribute("projectsexecuted", projectsexecuted);

			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm projexecuted is " + e);
			}

			return (mapping.findForward(mode));

		}
		if (mode.equalsIgnoreCase("projinhand")) {
			try {
				String cir = request.getParameter("circleOfficeCode");
				String amount = (String) session.getAttribute("amountwise");
				projectsinhand = RwsMasterData.getProjectsinhand(request.getParameter("contractorCode"), amount, cir);
				request.setAttribute("projectsinhand", projectsinhand);

			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm projinhand is " + e);
			}

			return (mapping.findForward(mode));

		}

		if (mode.equalsIgnoreCase("projcompletedintime")) {
			try {
				String amount = (String) session.getAttribute("amountwise");
				String cir = request.getParameter("circleOfficeCode");
				projectsexecutedintime = RwsMasterData
						.getProjectscompletedintime(request.getParameter("contractorCode"), amount, cir);
				request.setAttribute("projectsexecutedintime", projectsexecutedintime);

			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm projcompletedintime is " + e);
			}

			return (mapping.findForward(mode));

		}
		if (mode.equalsIgnoreCase("projlast")) {
			try {
				year = RwsMasterData.getProjectsyear();
				lastfiveyear = year - 5;
				five = "" + lastfiveyear;
				String cir = request.getParameter("circleOfficeCode");
				String amount = (String) session.getAttribute("amountwise");
				projectlastfive = RwsMasterData
						.getProjectscompletedintimelastfive(request.getParameter("contractorCode"), five, amount, cir);
				request.setAttribute("projectlastfive", projectlastfive);
		
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm projlast is " + e);
			}

			return (mapping.findForward(mode));

		}
		
		try {
			RwsOffices rwsOffices = new RwsOffices();
			circles = rwsOffices.getCircles();
			session.setAttribute("circles", circles);
		} catch (Exception e) {
			System.out.println("Exception" + e);
		}

		if (mode.equals("getCircles")) {
		
			try {
				RwsOffices rwsOffices = new RwsOffices();
				circles = rwsOffices.getCircles();
				session.setAttribute("circles", circles);
			
				String circleofficecode = request.getParameter("circleOfficeCode");
		
				divisions1 = rwsOffices.getDivisions1(circleofficecode);
				session.setAttribute("divisions1", divisions1);
				
			} catch (Exception e) {
				System.out.println("e getcirces" + e);
			}
			return (mapping.findForward(mode));
		}
		
		if (mode.equalsIgnoreCase("viewdivisionwiseContractor")) {
			try {
				session.removeAttribute("amountwise");
				RwsMasterData rwsMasterData = new RwsMasterData();
				String circlecode = contractForm.getCircleOfficeCode();
				String cir = request.getParameter("circleOfficeCode");
			
				session.setAttribute("circode", cir);

				String cirname = RwsMasterData.getCircleName(getDataSource(request), circlecode);
				session.setAttribute("cirname", cirname);
				divisionwise = RwsMasterData.getContractordivisionwise(contractForm.getCircleOfficeCode(),
						contractForm.getDivisionOfficeCode(), contractForm.getCategory());
				session.setAttribute("divisionwise", divisionwise);
			} catch (Exception e) {
				System.out.println("Exception in viewdivisionwiseContractor " + e);
			}

		}
		if (mode.equalsIgnoreCase("getContractorlist")) {
			try {
				year = RwsMasterData.getProjectsyear();
			
				lastfiveyear = year - 5;
				five = "" + lastfiveyear;
				String amount = request.getParameter("amount");
				projectlastfive = RwsMasterData
						.getProjectscompletedintimelastfive(request.getParameter("contractorCode"), five, amount, null);
				request.setAttribute("projectlastfive", projectlastfive);
		
			} catch (Exception e) {
				 System.out.println("the error in rws_ContractorEntryAct_frm getContractorlist is "+e);
			}

			return (mapping.findForward(mode));

		}
		if (mode != null && mode.equalsIgnoreCase("amountwisecontractors")) {
			String cir = request.getParameter("circleOfficeCode");
			String amount = request.getParameter("amount");
			try {
				divisionwise = RwsMasterData.getContractoramountwise(amount, cir);
				session.setAttribute("divisionwise", divisionwise);
				session.setAttribute("amountwise", amount);
				
			} catch (Exception e) {
				 System.out.println("the error in rws_ContractorEntryAct_frm amountwisecontractors is "+e);
			}
			mode = "viewdivisionwiseContractor";
			return (mapping.findForward(mode));
		}
		
		
		if (mode.equalsIgnoreCase("viewContractor")) {
			try {
				String cir = request.getParameter("circleOfficeCode");
				contractors = RwsMasterData.getContractors(getDataSource(request), contractForm.getFirstName(), cir);
				session.setAttribute("contractors", contractors);
			} catch (Exception e) {
				 System.out.println("the error in rws_ContractorEntryAct_frm viewContractor is "+e);
			}
		}
		if (mode.equalsIgnoreCase("getContractorreport")) {
			try {
				String amount = (String) session.getAttribute("amountwise");
				String circle = (String) session.getAttribute("circode");
				form = buildContractorForm(request.getParameter("contractorCode"), request, amount, circle);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm get is "+e);
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			int del = 0;
			try {
				del = RwsMasterData.removeContractor(request.getParameter("contractorCode"), getDataSource(request));
				if (del > 0) {
					displaymess = "Record deleted Succesfully";
				} else {
					displaymess = "Record cannot be deleted - Work(s) Linked with this Contractor ";
				}
				request.setAttribute("message", displaymess);
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm delete is " + e);
			}
			mode = "close";
			return (mapping.findForward(mode));
		}

		if (mode.equalsIgnoreCase("view")) {
			try {
				String cir = request.getParameter("circleOfficeCode");
				contractors = RwsMasterData.getContractors(getDataSource(request), contractForm.getFirstName(), cir);
				session.setAttribute("contractors", contractors);
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm view is " + e);
			}
		}
		
		if (mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			
			if (storedToken.equals(token)) {
				try {

					rwsMaster.setContractorCode(contractForm.getContractorCode());
					rwsMaster.setContractorClass(contractForm.getContractorClass());
					rwsMaster.setContractorRating(contractForm.getContractorRating());
					rwsMaster.setContractorRegno(contractForm.getContractorRegno());
					rwsMaster.setRegisterAt(contractForm.getRegisterAt());
					rwsMaster.setRegistrationDate(contractForm.getRegistrationDate());
					rwsMaster.setStreet(contractForm.getStreet());
					rwsMaster.setArea(contractForm.getArea());
					rwsMaster.setCity(contractForm.getCity());
					rwsMaster.setPin(contractForm.getPin());
					rwsMaster.setPhone(contractForm.getPhone());
					rwsMaster.setMobile(contractForm.getMobile());
					rwsMaster.setFax(contractForm.getFax());
					rwsMaster.setEmail(contractForm.getEmail());
					rwsMaster.setPanNo(contractForm.getPanNo());
					rwsMaster.setTinNo(contractForm.getTinNo());
					rwsMaster.setValidFrom(contractForm.getValidFrom());
					rwsMaster.setValidTo(contractForm.getValidTo());
					rwsMaster.setProjectsExecuted(contractForm.getProjectsExecuted());
					rwsMaster.setProjectsInhand(contractForm.getProjectsInhand());
					rwsMaster.setProjectsCompletedLastYear(contractForm.getProjectsCompletedLastYear());
					rwsMaster.setProjectsCompletedInTime(contractForm.getProjectsCompletedInTime());
					rwsMaster.setProjectsAbandoned(contractForm.getProjectsAbandoned());
					rwsMaster.setNoofEoat(contractForm.getNoofEoat());
					rwsMaster.setNoofSupplentary(contractForm.getNoofSupplentary());
					rwsMaster.setNoofPenalised(contractForm.getNoofPenalised());
					rwsMaster.setRemarks(contractForm.getRemarks());
					rwsMaster.setVatNo(contractForm.getVatNo());
					rwsMaster.setSpecialize(contractForm.getSpecialize());
					rwsMaster.setFirstName(contractForm.getFirstName());
					rwsMaster.setLastName(contractForm.getLastName());
					rwsMaster.setMiddleName(contractForm.getMiddleName());
					rwsMaster.setVoterId(contractForm.getVoterId());
					rwsMaster.setDcode(request.getParameter("dCode"));

					final Cryptography encrypter = new Cryptography("Welcome To Rwss Department!");
					final String encrypted = encrypter.encrypt(contractForm.getAdharNo());
					rwsMaster.setAdharNo(encrypted);

					rwsMaster.setIfscCode(contractForm.getIfscCode());
					rwsMaster.setAccountNo(contractForm.getAccountNo());
					ans = RwsMasterData.insertContractor(rwsMaster, getDataSource(request));
					if (ans == 1) {
						displaymess = "Record Inserted Successfully with the Name:" + rwsMaster.getFirstName()
								+ " and Code is:" + rwsMaster.getContractorCode();
						request.setAttribute("exist", "YES");
						request.setAttribute("conName", rwsMaster.getContractorName());
						request.setAttribute("conCode", rwsMaster.getContractorCode());
					} else {
						displaymess = "Contractor Already Existed with Providing PanNo (or) Regn No. (or) VoterId";
						request.setAttribute("exist", "NO");
						contractForm.reset(mapping, request);
					}
					request.setAttribute("message", displaymess);

					request.setAttribute("code", RwsMasterData.getContractorCode(getDataSource(request)));

				} catch (Exception e) {
					System.out.println("the error in rws_ContractorEntryAct_frm  insert is " + e);
				}
			}
		}

		if (mode.equalsIgnoreCase("get")) {
			
			try {
				String circle = (String) session.getAttribute("circode");
				form = buildContractorForm(request.getParameter("contractorCode"), request, null, circle);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm get is " + e);
			}
		}
		
		if (mode.equalsIgnoreCase("getContractorByName")) {
			try {
				form = buildContractorFormByContractorName(request.getParameter("contractorName"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm getContractorByName is "+e);
			}
		}

		if (mode.equalsIgnoreCase("edit")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try {
			
				rwsMaster.setFirstName(contractForm.getFirstName());
				rwsMaster.setContractorCode(contractForm.getContractorCode());
				rwsMaster.setContractorClass(contractForm.getContractorClass());
				rwsMaster.setContractorRating(contractForm.getContractorRating());
				rwsMaster.setContractorRegno(contractForm.getContractorRegno());
				rwsMaster.setRegisterAt(contractForm.getRegisterAt());
				rwsMaster.setRegistrationDate(contractForm.getRegistrationDate());
				rwsMaster.setStreet(contractForm.getStreet());
				rwsMaster.setArea(contractForm.getArea());
				rwsMaster.setCity(contractForm.getCity());
				rwsMaster.setPin(contractForm.getPin());
				rwsMaster.setPhone(contractForm.getPhone());
				rwsMaster.setMobile(contractForm.getMobile());
				rwsMaster.setFax(contractForm.getFax());
				rwsMaster.setEmail(contractForm.getEmail());
				rwsMaster.setPanNo(contractForm.getPanNo());
				rwsMaster.setTinNo(contractForm.getTinNo());
				rwsMaster.setValidFrom(contractForm.getValidFrom());
				rwsMaster.setValidTo(contractForm.getValidTo());
				rwsMaster.setProjectsExecuted(contractForm.getProjectsExecuted());
				rwsMaster.setProjectsInhand(contractForm.getProjectsInhand());
				rwsMaster.setProjectsCompletedLastYear(contractForm.getProjectsCompletedLastYear());
				rwsMaster.setProjectsCompletedInTime(contractForm.getProjectsCompletedInTime());
				rwsMaster.setProjectsAbandoned(contractForm.getProjectsAbandoned());
				rwsMaster.setNoofEoat(contractForm.getNoofEoat());
				rwsMaster.setNoofSupplentary(contractForm.getNoofSupplentary());
				rwsMaster.setNoofPenalised(contractForm.getNoofPenalised());
				rwsMaster.setRemarks(contractForm.getRemarks());
				rwsMaster.setVatNo(contractForm.getVatNo());
				rwsMaster.setSpecialize(contractForm.getSpecialize());
				rwsMaster.setLastName(contractForm.getLastName());
				rwsMaster.setMiddleName(contractForm.getMiddleName());
				rwsMaster.setVoterId(contractForm.getVoterId());

				final Cryptography encrypter = new Cryptography("Welcome To Rwss Department!");
				final String encrypted = encrypter.encrypt(contractForm.getAdharNo());
	
				rwsMaster.setAdharNo(encrypted);
				rwsMaster.setBankName(contractForm.getBankName());
				rwsMaster.setBranchName(contractForm.getBranchName());
				rwsMaster.setIfscCode(contractForm.getIfscCode());
				rwsMaster.setAccountNo(contractForm.getAccountNo());

				int count = RwsMasterData.updateContractor(rwsMaster, getDataSource(request));
				
				if (count > 0) {
					displaymess = "Record Updated Successfully";
				} else {
					displaymess = "Updation Failed - Contractor Already Existed with Providing PanNo (or) Regn No. (or) VoterId";
				}
				request.setAttribute("message", displaymess);
				mode = "close";
				return (mapping.findForward(mode));
			} catch (Exception e) {
				System.out.println("the error in rws_ContractorEntryAct_frm edit is " + e);
			}
		}
		}
	
		return (mapping.findForward(mode));
	}
}