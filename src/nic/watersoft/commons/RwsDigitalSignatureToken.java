package nic.watersoft.commons;

import java.math.BigInteger;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsDigitalSignatureToken {

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

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

}
