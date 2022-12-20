package nic.watersoft.masters;

import java.math.BigInteger;

import org.apache.struts.action.ActionForm;

public class Rws_EE_Budget_DigitalSign_Form  extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5746454995201072497L;
	/*added by krishna on 030713*/
	private String certificate;
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
	private String designation;
	
	private String eeid;
	private String eename;
	private String officecode;
	private String mode;
	private String isRegistered;
	private String eeDigitalSign;
	
	
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
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
	public BigInteger getSerialNumber() {
		return SerialNumber;
	}
	public void setSerialNumber(BigInteger serialNumber) {
		SerialNumber = serialNumber;
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
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getEeid() {
		return eeid;
	}
	public void setEeid(String eeid) {
		this.eeid = eeid;
	}
	public String getEename() {
		return eename;
	}
	public void setEename(String eename) {
		this.eename = eename;
	}
	public String getOfficecode() {
		return officecode;
	}
	public void setOfficecode(String officecode) {
		this.officecode = officecode;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getIsRegistered() {
		return isRegistered;
	}
	public void setIsRegistered(String isRegistered) {
		this.isRegistered = isRegistered;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getEeDigitalSign() {
		return eeDigitalSign;
	}
	public void setEeDigitalSign(String eeDigitalSign) {
		this.eeDigitalSign = eeDigitalSign;
	}

}
