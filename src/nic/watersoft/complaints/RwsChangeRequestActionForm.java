package nic.watersoft.complaints;

import org.apache.struts.action.ActionForm;

public class RwsChangeRequestActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String originatorName;

	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}

	public String getOriginatorName() {
		return originatorName;
	}

}
