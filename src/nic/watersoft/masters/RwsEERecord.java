package nic.watersoft.masters;

import java.io.Serializable;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsEERecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String cirlceName;
	private String divName;
	private String eeName;
	private String eePaoCode;

	// Digital Signature Information
	private String signature;
	private String publicKey;
	private String algorithmType;
	private String issuer;
	private String tokenHolder;
	private String validTo;
	private String validFrom;
	private String tokenSerailNo;
	private String tokenModuleCode;
	
	private String checks;
	
	private String approvedOn;
	
	
	
	
	

	public String getApprovedOn() {
		return approvedOn;
	}

	public void setApprovedOn(String approvedOn) {
		this.approvedOn = approvedOn;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getCirlceName() {
		return cirlceName;
	}

	public void setCirlceName(String cirlceName) {
		this.cirlceName = cirlceName;
	}

	public String getDivName() {
		return divName;
	}

	public void setDivName(String divName) {
		this.divName = divName;
	}

	public String getEeName() {
		return eeName;
	}

	public void setEeName(String eeName) {
		this.eeName = eeName;
	}

	public String getEePaoCode() {
		return eePaoCode;
	}

	public void setEePaoCode(String eePaoCode) {
		this.eePaoCode = eePaoCode;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getPublicKey() {
		return publicKey;
	}

	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}

	public String getAlgorithmType() {
		return algorithmType;
	}

	public void setAlgorithmType(String algorithmType) {
		this.algorithmType = algorithmType;
	}

	public String getIssuer() {
		return issuer;
	}

	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}

	public String getTokenHolder() {
		return tokenHolder;
	}

	public void setTokenHolder(String tokenHolder) {
		this.tokenHolder = tokenHolder;
	}

	public String getTokenSerailNo() {
		return tokenSerailNo;
	}

	public String getValidTo() {
		return validTo;
	}

	public void setValidTo(String validTo) {
		this.validTo = validTo;
	}

	public String getValidFrom() {
		return validFrom;
	}

	public void setValidFrom(String validFrom) {
		this.validFrom = validFrom;
	}

	public void setTokenSerailNo(String tokenSerailNo) {
		this.tokenSerailNo = tokenSerailNo;
	}

	public String getTokenModuleCode() {
		return tokenModuleCode;
	}

	public void setTokenModuleCode(String tokenModuleCode) {
		this.tokenModuleCode = tokenModuleCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
