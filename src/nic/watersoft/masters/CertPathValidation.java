// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 02-07-2013 13:22:17
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   CertPathValidation.java

package nic.watersoft.masters;

import java.io.*;
import java.security.KeyStore;
import java.security.cert.*;
import java.util.ArrayList;
import java.util.Properties;

public class CertPathValidation
{

    public CertPathValidation()
    {
    }

    public CertPath createCertPath(ArrayList arraylist)
    {
        CertPath certpath = null;
        try
        {
            CertificateFactory certificatefactory = CertificateFactory.getInstance("X.509");
            certpath = certificatefactory.generateCertPath(arraylist);
            return certpath;
        }
        catch(CertificateEncodingException certificateencodingexception)
        {
            certificateencodingexception.printStackTrace();
        }
        catch(CertificateException certificateexception)
        {
            certificateexception.printStackTrace();
        }
        return certpath;
    }

    public boolean validating(CertPath certpath)
    {
        boolean flag = false;
        try
        {
            Properties properties = new Properties();
            try
            {
                properties.load(getClass().getResourceAsStream("otc.properties"));
            }
            catch(IOException ioexception)
            {
                System.out.println("Could not open Config file");
            }
            String s = properties.getProperty("javahome");
            String s1 = properties.getProperty("keypass");
            FileInputStream fileinputstream = new FileInputStream(s);
            KeyStore keystore = KeyStore.getInstance(KeyStore.getDefaultType());
            keystore.load(fileinputstream, s1.toCharArray());
            PKIXParameters pkixparameters = new PKIXParameters(keystore);
            pkixparameters.setRevocationEnabled(false);
            CertPathValidator certpathvalidator = CertPathValidator.getInstance("PKIX", "BC");
            certpathvalidator.validate(certpath, pkixparameters);
            return flag = true;
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return flag;
    }
}
