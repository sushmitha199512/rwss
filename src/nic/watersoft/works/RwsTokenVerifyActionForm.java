package nic.watersoft.works;

import java.math.BigInteger;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Parasad N
 * 
 */
public class RwsTokenVerifyActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String pinValue;

	String isEEDSCSigned;
	String errorMesg;
	String btn;
	String tokenSLNO;

	private String certificate;

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public String getBtn() {
		return btn;
	}

	public void setBtn(String btn) {
		this.btn = btn;
	}

	public String getErrorMesg() {
		return errorMesg;
	}

	public void setErrorMesg(String errorMesg) {
		this.errorMesg = errorMesg;
	}

	public String getIsEEDSCSigned() {
		if (this.isEEDSCSigned == null || this.isEEDSCSigned.equals("")) {
			return "no";
		}
		return isEEDSCSigned;
	}

	public void setIsEEDSCSigned(String isEEDSCSigned) {
		this.isEEDSCSigned = isEEDSCSigned;
	}

	public String getPinValue() {
		return pinValue;
	}

	public void setPinValue(String pinValue) {
		this.pinValue = pinValue;
	}

	public String getTokenSLNO() {
		return tokenSLNO;
	}

	public void setTokenSLNO(String tokenSLNO) {
		this.tokenSLNO = tokenSLNO;
	}

}
