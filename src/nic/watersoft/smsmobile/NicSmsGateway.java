package nic.watersoft.smsmobile;

import java.io.*;
import java.net.*;
import java.security.*;
import java.security.cert.X509Certificate;
import java.sql.*;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

public class NicSmsGateway {
    
    HttpURLConnection httpURLCon = null;
    
/* public  String SMSSend(String username,String pin,String signature,String mnumber,String message) throws IOException, KeyManagementException, NoSuchAlgorithmException, SQLException
*/  public  String SMSSend(String mnumber,String message) throws IOException, KeyManagementException, NoSuchAlgorithmException, SQLException

    {
	String entity_id="1001740276724392728",template_id="1007800200499011268";
	//String entity_id="1001740276724392728",template_id="1007083892591656319";
	 final String username = "rwss.sms";
		final String pin = "Wr$7vF4$bA";
		final String signature = "APRWSS";
    String url = null;
     String https_url = null;
 
    String res = null;
   
    String result = "success";
    
    Integer resCode = 0;
    try {

    	
        //url = "https://smsgw.sms.gov.in/failsafe/HttpLink";
    	url = "https://smsgw.sms.gov.in/failsafe/MLink";
        
      // pwd = "Password";
      //  senderId = "SENDERID";
        message = URLEncoder.encode(message, "UTF-8");
        
        if(mnumber.trim().length()==10)
        	mnumber ="91"+mnumber;
       /////// https_url = (new StringBuilder()).append(url).append("?username=").append(username).append("&pin=").append(pin).append("&message=").append(message).append("&mnumber=").append(mnumber).append("&signature=").append(signature).toString();
        https_url = (new StringBuilder()).append(url).append("?username=").append(username).append("&pin=").append(pin).append("&message=").append(message).append("&mnumber=").append(mnumber).append("&signature=").append(signature).append("&dlt_entity_id=").append(entity_id).append("&dlt_template_id=").append(template_id).toString();

        SSLContext ssl_ctx = SSLContext.getInstance("TLS");

        TrustManager[] trust_mgr = new TrustManager[]{new X509TrustManager() {
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }

            public void checkClientTrusted(X509Certificate[] certs, String t) {
            }

            public void checkServerTrusted(X509Certificate[] certs, String t) {
            }
        }};

        if (trust_mgr != null) {
            ssl_ctx.init(null, trust_mgr, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx.getSocketFactory());
            URL urlCon = new URL(https_url);
            httpURLCon = (HttpsURLConnection) urlCon.openConnection();
            if (httpURLCon != null) {
                res = httpURLCon.getResponseMessage();
                resCode = httpURLCon.getResponseCode();
                String resMessage = httpURLCon.getResponseMessage();
                if (resCode == 200) {
                        if(result.equals("success"))
                        result="Deliverd";
                        else
                        result="not Deliverd";    
                    httpURLCon.disconnect();
                }
                System.out.println("NIC SMS GATEWAY :resCode : "+resCode+" resMessage : "+resMessage);
            } else {
                System.out.println("httpURLCon is null");
            }
        } else {
            System.out.println("trust_mgr is null");
        }

        System.out.println("Success :" + https_url);

    } 
    catch (UnsupportedEncodingException uex) {
        System.out.println("UnsupportedEncodingException SMS Failed");
    } catch (MalformedURLException muex) {
        System.out.println("MalformedURLException SMS Failed");
    } catch (IOException ioex) {
        System.out.println("IOException SMS Failed");
    } finally {
        if (httpURLCon != null) {
            httpURLCon.disconnect();
        }
    }
return result;
        }
 
}


