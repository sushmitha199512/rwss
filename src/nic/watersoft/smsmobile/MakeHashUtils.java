package nic.watersoft.smsmobile;



import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import org.glassfish.jersey.internal.util.Base64;

public class MakeHashUtils {
	
	public static String sha256(String input) throws NoSuchAlgorithmException {
		
        MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
        String b64Hash = Base64.encodeAsString(sb.toString());
        return b64Hash;
    }
	
	public static String getRandomString(int length)
	{
		char[] charsetArray = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
		SecureRandom random = new SecureRandom();
		char[] result = new char[length];
		for (int i = 0; i < result.length; i++) {
			int randomPick = random.nextInt(charsetArray.length);
			result[i] = charsetArray[randomPick];
		}
		return new String(result);
	}
	
	public static void main(String[] args) throws Exception {
		String str = "hello";
		String firstHash = sha256(str);
		String rand = getRandomString(6);
		//System.out.println("first: "+firstHash);
	//	System.out.println("rand: "+rand);
		String secondHash = sha256(firstHash+rand);
		//System.out.println("second: "+secondHash);
	}
	
}
