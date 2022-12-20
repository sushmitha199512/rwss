package nic.watersoft.commons;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import nic.watersoft.admin.RwsPasswordBean;


/**
 * 
 * @author Sai Prasad N
 * 
 */

public class Md5Impl {

	public static final String SALT_VALUE = "123456789@#%&*abcdefghijklmnopqrstuvwxyz";


	public static String getSaltedValue() {

		return SALT_VALUE + String.valueOf(new Random().nextLong());

	}

	public static long getRandomNumber() {

		return new Random().nextLong();
	}

	public static String getMd5Code(String plainText) {

		StringBuffer hexString = new StringBuffer();
		byte[] defaultBytes = plainText.getBytes();
		try {
			MessageDigest algorithm = MessageDigest.getInstance("MD5");
			algorithm.reset();

			algorithm.update(defaultBytes);
			byte messageDigest[] = algorithm.digest();

			String tmp;
			for (int i = 0; i < messageDigest.length; i++) {
				tmp = Integer.toHexString(0xFF & messageDigest[i]);
				if (tmp.length() == 1)
					tmp = '0' + tmp;
				hexString.append(tmp);
			}
		} catch (NoSuchAlgorithmException nsae) {

		}
		return new String(hexString);
	}

	public static String getSaltedMD5(String plainText) {

		// plainText = plainText + SALT_VALUE;

		return getMd5Code(getMd5Code(plainText) + SALT_VALUE);

	}

	public static String removeSlt(String hashCode, int slt) {
		int intRep = 0;
		String strRep;
		String result = "";
		for (int i = 0; i < hashCode.length(); i++) {
			intRep = hashCode.charAt(i);
			intRep = intRep - slt;
			result = result + Integer.toString(intRep);
		}

		return result;

	}

	public static void main(String[] args) {

		try {
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void readBarCode(){
		
		
	}
	public  static void sendSMS() throws IOException{
		String email="saiprasad4u2010@gmail.com"; 
		String user="saiprasad.n";
		String pass="sai@123";
		String number="9032905095";
		String msg="Hi Sai Prasad" ; 
		String mURL="http://www.onl9class.com/smsapi/smsir.php?email="+email+"&user="+user+"&pass="+pass+"&number="+number+"&msg="+URLEncoder.encode(msg, "UTF-8");;
		URL url = new URL(mURL);
		BufferedReader reader = null;

		try {
		    try {
				reader = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		    for (String line; (line = reader.readLine()) != null;) {
		        System.out.println(line);
		    }
		} finally {
		    if (reader != null) try { reader.close(); } catch (IOException ignore) {}
		}
	}
}
