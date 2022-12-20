package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class RwsWorkContractorLinkBean extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList contractorList;

	private String workId;

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getWorkId() {
		return workId;
	}

	public void setContractorList(ArrayList contractorList) {
		this.contractorList = contractorList;
	}

	public ArrayList getContractorList() {
		return contractorList;
	}

}
