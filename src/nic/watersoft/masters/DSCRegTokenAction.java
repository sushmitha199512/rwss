package nic.watersoft.masters;

import java.applet.Applet;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.Security;
import java.security.Signature;
import java.security.cert.Certificate;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

public class DSCRegTokenAction extends Applet  {

	
	private static final long serialVersionUID = 1L;
	
	
	private static final String PKCS11_KEYSTORE_TYPE = "PKCS11";

	private static final String SUN_PKCS11_PROVIDER_CLASS = "sun.security.pkcs11.SunPKCS11";

	public String signFilefromJS(String aPinCode, String input,
			HttpServletRequest requset, String paoCode)
			throws DocumentSignException, IOException {
		String signdatabase64 = null;

		
		String aPkcs11LibraryFileName = null;
		try {
			// aPkcs11LibraryFileName = "/usr/lib/libaetpkss.so" ;
			aPkcs11LibraryFileName = "C:\\Windows\\System32\\aetpkss1.dll";
		} finally {
		}
		if (aPkcs11LibraryFileName.length() == 0) {
			String errorMessage = "It is mandatory to choose a PCKS#11 native "
					+ "implementation library for for eToken (.dll or .so file)!";
			System.out.println("errorMessage :" + errorMessage);
		}

		KeyStore userKeyStore = null;
		try {

			userKeyStore = loadKeyStoreFromSmartCard(aPkcs11LibraryFileName,
					aPinCode);
		} catch (Exception ex) {
			ex.printStackTrace();
				return signdatabase64;
		}

		PrivateKeyAndCertChain privateKeyAndCertChain = null;
		try {
			privateKeyAndCertChain = getPrivateKeyAndCertChain(userKeyStore);
		} catch (GeneralSecurityException gsex) {
			String errorMessage = "Can not extract the private key and "
					+ "certificate from the eToken. Reason: "
					+ gsex.getMessage();
			// System.out.println(" errorMessage :"+errorMessage) ;
			throw new DocumentSignException(errorMessage, gsex);
		}
		PrivateKey privateKey = privateKeyAndCertChain.mPrivateKey;
		if (privateKey == null) {
			String errorMessage = "Can not find the private key on the eToken.";
			// System.out.println(" errorMessage :"+ errorMessage);
			throw new DocumentSignException(errorMessage);
		}
		Certificate[] certChain = privateKeyAndCertChain.mCertificationChain;
		// JOptionPane.showMessageDialog(this,"certChain===>"+certChain);
		if (certChain == null) {
			String errorMessage = "Can not find the certificate on the eToken.";
			// System.out.println(" errorMessage :"+ errorMessage);
			throw new DocumentSignException(errorMessage);
		}
		try {
			/* - - -certificate - - - - */
			X509Certificate cert = (X509Certificate) certChain[0];
								
			
		//	String certbase64 = new sun.misc.BASE64Encoder().encode(cert
			//		.getEncoded());

			/*----  signature  - - -*/
			Signature musig = Signature.getInstance("SHA256withRSA");
			byte[] buffer = input.getBytes();

			String rawInString = new String(buffer);
			// byte[] orgCont = new
			// sun.misc.BASE64Decoder().decodeBuffer(rawInString);
			// System.out.println("orgcont in base64:"+orgCont);
			//String orgbase64 = new sun.misc.BASE64Encoder().encode(rawInString
			//		.toString().getBytes());

			musig.initSign(privateKey);
			musig.update(rawInString.getBytes());

			byte[] signCont = musig.sign();
			//signdatabase64 = new sun.misc.BASE64Encoder().encode(signCont);
			String query = "";
			// int dd = java.util.Calendar.DATE;
			if (!signdatabase64.isEmpty()) {
				try {
					@SuppressWarnings("unused")
					int rcount = 0;
					Connection conn = null;
					Statement stmt = null;
					conn = RwsOffices.getConn();
					stmt = conn.createStatement();
					String dateC = RwsUtils.getCurrentDate("dd-MM-yyyy");
					String userId = (String) requset.getSession().getAttribute(
							"userId");
					// System.out.println("pao - - ->" + pao);
					String circle = userId.substring(1, 3);
					String divC = userId.substring(3, 4);
					System.out.println("divC- - ->" + divC);

					// query =
					// "insert into rws_dsc_reg_token values('01','1234','0000','11223','06-JUN-2013')";
				//	query = "insert into RWS_EE_DS_REG_TBL values('" + circle
				//			+ "','" + divC + "','" + paoCode + "','"
				//			+ signdatabase64 + "','" + certbase64.trim()
				//			+ "','" + orgbase64 + "','" + dateC + "','')";

					Debug.println("query is " + query);
					rcount = stmt.executeUpdate(query);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("exxxxx- - ->" + e);
				}
			} else {

				System.out.println("- - -not sign - - - -");
			}
			musig.initVerify(cert.getPublicKey());
	   	musig.update(rawInString.getBytes()); 

			if (musig.verify(new sun.misc.BASE64Decoder()
					.decodeBuffer(signdatabase64)))
				System.out.println("The signature is good.");
			else
				System.out.println("The signature is bad.");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return signdatabase64;
	}

	@SuppressWarnings("unchecked")
	private KeyStore loadKeyStoreFromSmartCard(String aPKCS11LibraryFileName,
			String aSmartCardPIN) throws GeneralSecurityException, IOException {
		String pkcs11ConfigSettings = "name = SmartCard\n" + "library = "
				+ aPKCS11LibraryFileName;
		byte[] pkcs11ConfigBytes = pkcs11ConfigSettings.getBytes();
		ByteArrayInputStream confStream = new ByteArrayInputStream(
				pkcs11ConfigBytes);
		//Provider pkcs11Provider;
		// Instantiate the provider dynamically with Java reflection
		try {
			Class sunPkcs11Class = Class.forName(SUN_PKCS11_PROVIDER_CLASS);
		
			
			Constructor pkcs11Constr = sunPkcs11Class
					.getConstructor(java.io.InputStream.class);
			Provider pkcs11Provider = (Provider) pkcs11Constr
					.newInstance(confStream);
				Security.addProvider(pkcs11Provider);
		} catch (Exception e) {
			throw new KeyStoreException("Cant initialize Sun PKCS#11 security "
					+ "provider. Reason: " + e.getCause().getMessage());
		}

		// Read the keystore from the eToken
		// System.out.println("aSmartCardPIN :"+aSmartCardPIN);
		char[] pin = aSmartCardPIN.toCharArray();
			Provider p[]=Security.getProviders();
			
			
			System.out.println(""+Security.getProviders().length);
			
		KeyStore keyStore = KeyStore.getInstance(PKCS11_KEYSTORE_TYPE);
		keyStore.load(null, pin);
		System.out.println("keyStore===>" + keyStore);
		confStream.close();
		return keyStore;
	}

	@SuppressWarnings("unchecked")
	private PrivateKeyAndCertChain getPrivateKeyAndCertChain(KeyStore aKeyStore)
			throws GeneralSecurityException {
		Enumeration aliasesEnum = aKeyStore.aliases();
		if (aliasesEnum.hasMoreElements()) {
			String alias = (String) aliasesEnum.nextElement();
			Certificate[] certificationChain = aKeyStore
					.getCertificateChain(alias);
			// System.out.println(" certificationChain===>"+certificationChain);
			PrivateKey privateKey = (PrivateKey) aKeyStore.getKey(alias, null);
			// System.out.println(" privateKey===>"+privateKey);
			PrivateKeyAndCertChain result = new PrivateKeyAndCertChain();
			result.mPrivateKey = privateKey;
			result.mCertificationChain = certificationChain;
			return result;
		} else {
			// System.out.println(" errorMessage :"+ "The keystore is empty!");
			throw new KeyStoreException("The keystore is empty!");
		}
	}

	static class PrivateKeyAndCertChain {
		public PrivateKey mPrivateKey;
		public Certificate[] mCertificationChain;
	}

	static class CertificationChainAndSignatureBase64 {
		public String mCertificationChain = null;
		public String mSignature = null;
	}

	static class DocumentSignException extends Exception {
		private static final long serialVersionUID = 1L;

		public DocumentSignException(String aMessage) {
			super(aMessage);
		}

		public DocumentSignException(String aMessage, Throwable aCause) {
			super(aMessage, aCause);
		}
	}

}
