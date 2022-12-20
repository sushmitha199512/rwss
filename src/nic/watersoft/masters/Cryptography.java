package nic.watersoft.masters;

import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

public class Cryptography {
		   Cipher ecipher;
		   Cipher dcipher;
		    
		   private final byte[] salt = {
		      (byte)0xA9, (byte)0x9B, (byte)0xC8, (byte)0x32,
		      (byte)0x56, (byte)0x35, (byte)0xE3, (byte)0x03
		   };
		    
		   private final int iterationCount = 19;
		    
		   Cryptography (String passPhrase) {
		      try {
		         final KeySpec keySpec = new PBEKeySpec(passPhrase.toCharArray(), salt, iterationCount);// Create the key
		         final SecretKey key = SecretKeyFactory.getInstance("PBEWithMD5AndDES").generateSecret(keySpec);
		         ecipher = Cipher.getInstance(key.getAlgorithm());
		         dcipher = Cipher.getInstance(key.getAlgorithm());
		    
		         final AlgorithmParameterSpec paramSpec = new PBEParameterSpec(salt, iterationCount);
		    
		         ecipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);
		         dcipher.init(Cipher.DECRYPT_MODE, key, paramSpec);
		      } catch (java.security.InvalidAlgorithmParameterException e) {
		    	  e.printStackTrace();
		      } catch (java.security.spec.InvalidKeySpecException e) {
		    	  e.printStackTrace();
		      } catch (javax.crypto.NoSuchPaddingException e) {
		    	  e.printStackTrace();
		      } catch (java.security.NoSuchAlgorithmException e) {
		    	  e.printStackTrace();
		      } catch (java.security.InvalidKeyException e) {
		    	  e.printStackTrace();
		      }
		   }
		    
		   public String encrypt(String str) {
		      try {
		        byte[] utf8 = str.getBytes("UTF8");
		        byte[] enc = ecipher.doFinal(utf8);
		    
		         return new sun.misc.BASE64Encoder().encode(enc);
		      } catch (javax.crypto.BadPaddingException e) {
		    	  e.printStackTrace();
		      } catch (javax.crypto.IllegalBlockSizeException e) {
		    	  e.printStackTrace();
		      } catch (java.io.UnsupportedEncodingException e) {
		    	  e.printStackTrace();
		      } catch (java.io.IOException e) {
		    	  e.printStackTrace();
		      }
		      return null;
		   }
		    
		   public String decrypt(String str) {
		      try {
		         byte[] dec = new sun.misc.BASE64Decoder().decodeBuffer(str);
		         byte[] utf8 = dcipher.doFinal(dec);

		         return new String(utf8, "UTF8");

		      } catch (javax.crypto.BadPaddingException e) {
		    	  e.printStackTrace();
		      } catch (javax.crypto.IllegalBlockSizeException e) {
		    	  e.printStackTrace();
		      } catch (java.io.UnsupportedEncodingException e) {
		    	  e.printStackTrace();
		      } catch (java.io.IOException e) {
		    	  e.printStackTrace();
		      }
		      return null;
		   }		   
}
