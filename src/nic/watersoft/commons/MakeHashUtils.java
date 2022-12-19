package nic.watersoft.commons;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.sun.jersey.core.util.Base64;

public class MakeHashUtils {
	
	public static String sha256(String input) throws NoSuchAlgorithmException {
		String secureHash=null;
        MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
        //System.out.println("MakeHashUtils-input :"+input);
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
        byte[] b64Hash = Base64.encode(sb.toString());
        secureHash = new String(b64Hash);
        return secureHash;
    }
	
	public static String getRandomString(int length){
		char[] charsetArray = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
		SecureRandom random = new SecureRandom();
		char[] result = new char[length];
		for (int i = 0; i < result.length; i++) {
			int randomPick = random.nextInt(charsetArray.length);
			result[i] = charsetArray[randomPick];
		}
		return new String(result);
	}
	
	private static final String symbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*-+_=";

		public static String genPassword() {
		    while(true) {
		    	SecureRandom random = new SecureRandom();				
		    	char[] password = new char[random.nextBoolean()?8:12];
		        boolean hasUpper = false, hasLower = false, hasDigit = false, hasSpecial = false;
		        for(int i=0; i<password.length; i++) {
		            char ch = symbols.charAt(random.nextInt(symbols.length()));
		            if(Character.isUpperCase(ch))
		                hasUpper = true;
		            else if(Character.isLowerCase(ch))
		                hasLower = true;
		            else if(Character.isDigit(ch))
		                hasDigit = true;
		            else
		                hasSpecial = true;
		            password[i] = ch;
		        }
		        if(hasUpper && hasLower && hasDigit && hasSpecial) {
		            return new String(password);
		        }
		    }
		}
	
	public long encryptAllPwds()
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Statement stmt = null;
		long count=0;
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String rsQuery = "select user_id,password from rws_password_tbl";
			rs = stmt.executeQuery(rsQuery);
			while(rs.next())
			{
				String updateQuery = "update rws_password_tbl set password=? where user_id=?";
				ps = conn.prepareStatement(updateQuery);
				ps.setString(1, sha256(rs.getString(2)));
				ps.setString(2, rs.getString(1));
				int flag = ps.executeUpdate();
				if(flag>0)
				{
					count++;
				}
				ps.close();
			}
			stmt.close();
			ps.close();
			rs.close();
			conn.close();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		finally
		{
			stmt = null;
			ps = null;
			rs = null;
			conn = null;
		}
		return count;
	}
	
	public static void main(String args[]) throws Exception
	{
		Connection conct = null;
		DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
		conct=DriverManager.getConnection("jdbc:oracle:thin:@10.160.19.167:1521:orastg","aprwssuser","aprwssuser");
		
		Statement stmtt = conct.createStatement();
		Statement stmtt2 = conct.createStatement();
		int i = stmtt2.executeUpdate("update rws_password_tbl set password='temp' where user_id='HO-ADMIN'");
		System.out.println("update count="+i);
		String rsQuery = "select user_id,password from rws_password_tbl where user_id='HO-ADMIN'";
		ResultSet rss = stmtt.executeQuery(rsQuery);
		while(rss.next())
		{
			System.out.println("user_id: "+rss.getString(1)+", Password: "+rss.getString(2));
		}
		rss.close();
		stmtt2.close();
		stmtt.close();
		conct.close();
		
	}
	
}
