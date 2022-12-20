/*
 * Created on 20-Jun-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.lang.RandomStringUtils;

/**
 * @author NIC(N.Sai Prasad)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsUtils {

	/**
	 * File Name: BBBBTTTTPPPDDMMYYYY.RXX.YYYYMMDD-HHMMSS BBBB - First Four
	 * Characters of the Banks’ IFSC Code. Values: ANDB TTTT - Transaction Type.
	 * Values: INTR (means Internal), RTGS, NEFT PPP – Program Name RWS – Rural
	 * Water Supply DDMMYYYY – Date of file generation at NREGS Server R – ‘R’
	 * represents Response File. Values: R XX – Serial Number of files of
	 * particular File Type generated on that day to that Nodal bank. Values –
	 * 01, 02, 03 ….99 YYYYMMDD-HHMMSS – Timestamp of response file generated at
	 * Nodal Bank
	 * 
	 * Example of Response File Names from Andhra Bank: File Type 1:
	 * ANDBINTRRWS07072011.R01.20110707-121531 File Type 2:
	 * ANDBRTGSRWS07072011.R01.20110707-121532 File Type 3:
	 * ANDBNEFTRWS07072011.R01.20110707-121534
	 */
	public static boolean validateResponseFile(String fileName) {

		try {
			if (fileName != null
					&& !fileName.substring(0, 4)
							.equals(RWSBankUtills.BANK_NAME)) {
				return false;
			}
			if (fileName != null && fileName.length() < 39) {
				return false;
			}

			return true;

		} catch (Exception e) {
			return false;
		}

	}

	public static String GetFileExtension(String fileName) {

		// String file = fileName.substring(fileName.lastIndexOf("/"));
		String extension = fileName.substring(fileName.indexOf("."));
		return extension;
	}

	public static String getRandomString() {

		RandomStringUtils r = new RandomStringUtils();

		return r.randomAlphanumeric(15).getBytes().toString();
	}

	public static String getCurrentYear() {

		Date date = new Date();
		int year = date.getYear();
		year += 1900;
		return "" + year;

	}

	public static String getCurrentDate(String format) {

		SimpleDateFormat dateFormatter = new SimpleDateFormat(format);
		String currentDate = dateFormatter.format(new Date(System
				.currentTimeMillis()));
		return currentDate;
	}

	public static String getCurrentMont() 
	{
		Calendar cal = GregorianCalendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("MMM");

		Date currentMonth = new Date();
		cal.setTime(currentMonth);

		String currentMonthAsSting = df.format(cal.getTime());
		return currentMonthAsSting;
	}

	public static String getNextMonth() {
		Calendar cal = GregorianCalendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("MMM");

		Date currentMonth = new Date();
		cal.setTime(currentMonth);

		cal.add(Calendar.MONTH, 1);
		String nextMonthAsString = df.format(cal.getTime());
		return nextMonthAsString;
	}

	public static String getPreviousMonth() {
		Calendar cal = GregorianCalendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("MMM");

		Date currentMonth = new Date();
		cal.setTime(currentMonth);

		cal.add(Calendar.MONTH, -1);
		String prevMonthasString = df.format(cal.getTime());
		return prevMonthasString;
	}

	/*
	 * Returns the Last Previous Month
	 */
	public static String getPreviousMonth1() {
		Calendar cal = GregorianCalendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat("MMM");

		Date currentMonth = new Date();
		cal.setTime(currentMonth);

		cal.add(Calendar.MONTH, -2);
		String prevMonthasString = df.format(cal.getTime());
		return prevMonthasString;
	}

	public static boolean isCurrentFinancialYear(String finYear) {

		String finYearL = finYear.substring(0, 4);
		String finYearU = finYear.substring(5, 9);
		int currentMonth = new Date().getMonth();

		return false;
	}

	public static Date addMonths(Date date, int months) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, months); // minus number would decrement the
		// days
		return cal.getTime();
	}

	public static void fileMove(File sourceFile, File destinationDir) {
		boolean success = sourceFile.renameTo(new File(destinationDir,
				sourceFile.getName()));
		if (!success) {
			System.out.print("not good");
		}

	}

	public static void fileMove(File sourceFile, File destinationFile,
			boolean flag) {
		InputStream inStream = null;
		OutputStream outStream = null;

		try {

			inStream = new FileInputStream(sourceFile);
			outStream = new FileOutputStream(destinationFile);

			byte[] buffer = new byte[4096];

			int length;
			// copy the file content in bytes
			while ((length = inStream.read(buffer)) > 0) {

				outStream.write(buffer, 0, length);

			}

			inStream.close();
			outStream.close();

			// delete the original file
			sourceFile.delete();

			System.out.println("File is copied successful!");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Sample Response File :ANDBINTRRWS07072011.R01.20110707-121531
	 * 
	 * ANDB\NEFT\2013\Aug-2013\17-08-2013\REQUEST
	 * 
	 * @param fileName
	 * @return
	 * @author Sai Prasad N
	 */
	public static String getResponseFilePath(String fileName) {

		String responsePath = null;
		if (fileName != null
				&& fileName.substring(4, 8).equals(RWSBankUtills.NEFT)) {
			responsePath = RWSBankUtills.BANK_NEFT_PATH;
		} else if (fileName != null
				&& fileName.substring(4, 8).equals(RWSBankUtills.INTR)) {
			responsePath = RWSBankUtills.BANK_INTR_PATH;
		} else if (fileName != null
				&& fileName.substring(4, 8).equals(RWSBankUtills.RTGS)) {
			responsePath = RWSBankUtills.BANK_RTGS_PATH;
		}
		responsePath += File.separatorChar + fileName.substring(15, 19);
		responsePath += File.separatorChar
				+ getMonth(fileName.substring(13, 15)) + "-"
				+ fileName.substring(15, 19);

		responsePath += File.separatorChar + fileName.substring(11, 13) + "-"
				+ fileName.substring(13, 15) + "-" + fileName.substring(15, 19);
		responsePath += File.separatorChar + RWSBankUtills.BANK_RESPONSE_FOLDER;
		responsePath += File.separatorChar + fileName;

		return responsePath;
	}

	private static String getMonth(String monthNo) {

		int month = Integer.parseInt(monthNo);
		switch (month) {

		case 1:
			return "Jan";
		case 2:
			return "Feb";
		case 3:
			return "Mar";
		case 4:
			return "Apr";
		case 5:
			return "May";
		case 6:
			return "Jun";
		case 7:
			return "Jul";
		case 8:
			return "Aug";
		case 9:
			return "Sep";
		case 10:
			return "Oct";
		case 11:
			return "Nov";
		case 12:
			return "Dec";

		}
		return "";
	}

	
	public static void prepareX509Certificate(String base64value,
			RwsDigitalSignatureToken token) throws ParseException, IOException,CertificateException 
	{
//
//		byte[] certCont = new sun.misc.BASE64Decoder().decodeBuffer(base64value
//				.trim());
//		InputStream inStream = new ByteArrayInputStream(certCont);
//		CertificateFactory cf = CertificateFactory.getInstance("X.509");
//
//		java.security.cert.Certificate cert = cf.generateCertificate(inStream);
//		X509Certificate xCert = (X509Certificate) cert;
//		// System.out.println("Certificate Type: " + cf.getType());
//		// System.out.println("Public Key: \n" + cert.getPublicKey());
//		try {
//			// System.out.println("Signature Algorithm -- >"+
//			// xCert.getSigAlgName());
//			// System.out.println("IssuerDN :---> " + xCert.getIssuerDN());
//			// System.out.println("Serial Number : --> "+
//			// xCert.getSerialNumber());
//			// System.out.println("SubjectDN : " + xCert.getSubjectDN());
//			// System.out.println("Validity  To - - ->"+ xCert.getNotAfter());
//			// System.out.println("Validity FROM  - - ->"+
//			// xCert.getNotBefore());
//		} catch (Exception exp) {
//			exp.printStackTrace();
//		}
//
//		Date todate = xCert.getNotAfter();
//		Date fromdate = xCert.getNotBefore();
//
//		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
//		String validFrom = dateFormatter.format(fromdate);
//		String validTo = dateFormatter.format(todate);
//
//		token.setValidFrom(validFrom);
//
//		token.setValidTo(validTo);
//		token.setIssuer(xCert.getIssuerDN().toString());
//		token.setIssuerName(xCert.getSubjectDN().toString());
//		token.setSerialNumber(xCert.getSerialNumber());
//
//		inStream.close();
//
//	}
	}
	
	public static void main(String[] args) {
		
		String value="workname";
		
		System.out.println(value.indexOf("alert"));
		
		
	}

}