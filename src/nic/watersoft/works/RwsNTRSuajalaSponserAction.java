package nic.watersoft.works;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsNTRSuajalaSponserAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RwsNTRSuajalaSponserForm rwsNTRSuajalaSponserForm = (RwsNTRSuajalaSponserForm) form;

		RwsNTRSuajalaSponserDAO rwsNTRSuajalaSponserDAO = new RwsNTRSuajalaSponserDAO();
		String mode = request.getParameter("mode");
		int subMode = getCode(request.getParameter("subMode"));

		RwsOffices rwsoffice = new RwsOffices(getDataSource(request));
		HttpSession session = request.getSession();
		String selectOption = request.getParameter("sMode");
		if (selectOption != null) {
			request.setAttribute("sMode", selectOption);
			session.setAttribute("sMode", selectOption);
			System.out.println("sMode" + selectOption);
		}
		switch (subMode) {
		case 1: {

			reset(rwsNTRSuajalaSponserForm);
			rwsNTRSuajalaSponserForm.setVillageSelection("SelectedBySponser");
			session.setAttribute("circles", rwsoffice.getCircles());
		}
			break;
		case 2: {

			StringBuffer buffNo = new StringBuffer();

			// buffNo.append("Sai");
			// buffNo.append(";");
			// buffNo.append("1");
			// buffNo.append("||");
			//
			// buffNo.append("Raju");
			// buffNo.append(";");
			// buffNo.append("2");
			// // buffNo.append("||");

			session.setAttribute("mandals", rwsoffice
					.getMandals(getValues(rwsNTRSuajalaSponserForm
							.getCircleCode())));
			// response.setContentType("text/html");
			// PrintWriter out = response.getWriter();
			// System.out.println(buffNo.toString());
			// // out.flush();
			// out.println(buffNo.toString());
			// // out.flush();
			// out.close();
			// return null;
		}
			// break;
		case 3: {
			session.setAttribute("panchayats", rwsoffice.getPanchayats(
					getValues(rwsNTRSuajalaSponserForm.getCircleCode()),
					getValues(rwsNTRSuajalaSponserForm.getMandalCode())));
		}
			break;
		case 4: {
			session.setAttribute("villages", rwsoffice.getVillages(
					getValues(rwsNTRSuajalaSponserForm.getCircleCode()),
					getValues(rwsNTRSuajalaSponserForm.getMandalCode()),
					getValues(rwsNTRSuajalaSponserForm.getPanchayathCode())));
		}
			break;
		case 5: {
			session.setAttribute("habitations", rwsoffice.getHabitations(
					getValues(rwsNTRSuajalaSponserForm.getCircleCode()),
					getValues(rwsNTRSuajalaSponserForm.getMandalCode()),
					getValues(rwsNTRSuajalaSponserForm.getPanchayathCode()),
					getValues(rwsNTRSuajalaSponserForm.getVillageCode())));
		}
			break;
		case 6: {

			rwsNTRSuajalaSponserDAO.saveRecord(rwsNTRSuajalaSponserForm,
					request);

		}
			break;

		}

		return mapping.findForward(mode);
	}

	private void reset(RwsNTRSuajalaSponserForm rwsNTRSuajalaSponserForm) {

		rwsNTRSuajalaSponserForm.setSponserName("");
		rwsNTRSuajalaSponserForm.setAddress("");
		rwsNTRSuajalaSponserForm.setAmount("");
		rwsNTRSuajalaSponserForm.setCategory("");
		rwsNTRSuajalaSponserForm.setEmailId("");
		rwsNTRSuajalaSponserForm.setState("");
		rwsNTRSuajalaSponserForm.setCity("");

	}

	private String getValues(String[] circleCode) {

		String code = "";
		if (circleCode != null) {
			for (int j = 0; j < circleCode.length; j++) {

				code += circleCode[j];
				code += ",";
			}
			return code.substring(0, code.length() - 1);
		} else {
			return code;
		}
	}

	private int getCode(String option) {
		int value = 0;

		if (option != null & option.equalsIgnoreCase("init")) {
			value = 1;
		} else if (option != null & option.equalsIgnoreCase("mandals")) {
			value = 2;
		} else if (option != null & option.equalsIgnoreCase("panchayaths")) {
			value = 3;
		} else if (option != null & option.equalsIgnoreCase("villages")) {
			value = 4;
		} else if (option != null & option.equalsIgnoreCase("habs")) {
			value = 5;
		} else if (option != null & option.equalsIgnoreCase("save")) {
			value = 6;
		}
		return value;
	}
}
