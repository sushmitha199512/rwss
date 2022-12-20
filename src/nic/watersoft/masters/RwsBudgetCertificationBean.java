package nic.watersoft.masters;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 *
 */
public class RwsBudgetCertificationBean extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String certificate;

	private String isAuthorize;
	
	private String tokenSLNO;
	

	public String getIsAuthorize() {
		if (this.isAuthorize == null || this.isAuthorize.equals("")) {
			return "no";
		}
		return isAuthorize;
	}

	public void setIsAuthorize(String isAuthorize) {

		this.isAuthorize = isAuthorize;
	}

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getTokenSLNO() {
		return tokenSLNO;
	}

	public void setTokenSLNO(String tokenSLNO) {
		this.tokenSLNO = tokenSLNO;
	}

	
}
