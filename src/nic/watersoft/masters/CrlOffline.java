// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 02-07-2013 13:22:24
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   CrlOffline.java

package nic.watersoft.masters;

import java.io.*;
import java.security.cert.*;
import java.util.Date;

public class CrlOffline
{

    public CrlOffline()
    {
    }

    public boolean CheckCrloffline(X509Certificate x509certificate, String s, Date date)
    {
        boolean flag = false;
        try
        {
            FileInputStream fileinputstream = new FileInputStream(s);
            CertificateFactory certificatefactory = CertificateFactory.getInstance("X.509");
            X509CRL x509crl = (X509CRL)certificatefactory.generateCRL(fileinputstream);
            X509CRLEntry x509crlentry = x509crl.getRevokedCertificate(x509certificate.getSerialNumber());
            System.out.println((new StringBuilder()).append("crlentry==>").append(x509crlentry).toString());
            if(x509crlentry == null)
            {
                Date date1 = x509certificate.getNotAfter();
                System.out.println((new StringBuilder()).append(" Certificate ExpiredDate==>").append(date1).toString());
                System.out.println((new StringBuilder()).append("signingDate==>").append(date).toString());
                if(date.before(date1))
                {
                    flag = true;
                } else
                {
                    System.out.println("Certificate has expired");
                    flag = false;
                }
            } else
            {
                flag = false;
                System.out.println("Certificate Revoked");
            }
        }
        catch(FileNotFoundException filenotfoundexception)
        {
            filenotfoundexception.printStackTrace();
        }
        catch(CertificateException certificateexception)
        {
            certificateexception.printStackTrace();
        }
        catch(CRLException crlexception)
        {
            crlexception.printStackTrace();
        }
        return flag;
    }

    private static final X509Certificate X509Certificate = null;

}
