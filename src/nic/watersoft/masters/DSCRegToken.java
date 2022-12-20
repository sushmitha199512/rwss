package nic.watersoft.masters;

import java.math.BigInteger;

import org.apache.struts.action.ActionForm;

public class DSCRegToken extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String circleOffice = "";
	private String divisionOffice = "";
	private String paoCode = "";
	private String eeName = "";
	private String dateofPresent = "";
	private String dateofReleaving = "";
	private String mode = "";
	private String circleName = "";
	private String divisionName = "";
	private String isRegistered;

	// Krishna

	public String getIsRegistered() {
		if (this.isRegistered == null || this.isRegistered.equals("")) {
			return "No";
		}
		System.out.println("sss" + this.isRegistered);
		return isRegistered;
	}

	public void setIsRegistered(String isRegistered) {
		this.isRegistered = isRegistered;
	}

	private String tokenPwd;
	private String certificateType;
	private String certificateKey;
	private String algorithm;
	private String issuer;
	private String issuerName;
	private BigInteger SerialNumber;
	private String validFrom;
	private String validTo;
	private String signature;
	private String certificate;
	private String encName;

	public String getCircleOffice() {
		return circleOffice;
	}

	public void setCircleOffice(String circleOffice) {
		this.circleOffice = circleOffice;
	}

	public String getDivisionOffice() {
		return divisionOffice;
	}

	public void setDivisionOffice(String divisionOffice) {
		this.divisionOffice = divisionOffice;
	}

	public String getPaoCode() {
		return paoCode;
	}

	public void setPaoCode(String paoCode) {
		this.paoCode = paoCode;
	}

	public String getEeName() {
		return eeName;
	}

	public void setEeName(String eeName) {
		this.eeName = eeName;
	}

	public String getDateofPresent() {
		return dateofPresent;
	}

	public void setDateofPresent(String dateofPresent) {
		this.dateofPresent = dateofPresent;
	}

	public String getDateofReleaving() {
		return dateofReleaving;
	}

	public void setDateofReleaving(String dateofReleaving) {
		this.dateofReleaving = dateofReleaving;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getCircleName() {
		return circleName;
	}

	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getTokenPwd() {
		return tokenPwd;
	}

	public void setTokenPwd(String tokenPwd) {
		this.tokenPwd = tokenPwd;
	}

	public String getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(String certificateType) {
		this.certificateType = certificateType;
	}

	public String getCertificateKey() {
		return certificateKey;
	}

	public void setCertificateKey(String certificateKey) {
		this.certificateKey = certificateKey;
	}

	public String getAlgorithm() {
		return algorithm;
	}

	public void setAlgorithm(String algorithm) {
		this.algorithm = algorithm;
	}

	public String getIssuer() {
		return issuer;
	}

	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}

	public String getIssuerName() {
		return issuerName;
	}

	public void setIssuerName(String issuerName) {
		this.issuerName = issuerName;
	}

	public String getValidFrom() {
		return validFrom;
	}

	public void setValidFrom(String validFrom) {
		this.validFrom = validFrom;
	}

	public String getValidTo() {
		return validTo;
	}

	public void setValidTo(String validTo) {
		this.validTo = validTo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public BigInteger getSerialNumber() {
		return SerialNumber;
	}

	public void setSerialNumber(BigInteger serialNumber) {
		SerialNumber = serialNumber;
	}

	public String getEncName() {
		return encName;
	}

	public void setEncName(String encName) {
		this.encName = encName;
	}

}
