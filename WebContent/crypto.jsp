<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<span xmlns="http://www.w3.org/1999/xhtml"><p>
<head id="Head1" runat="server">
    <title> Digital Signature</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<object id="oCAPICOM" classid="clsid:A996E48C-D3DC-4244-89F7-AFA33EC60679" codebase="capicom.cab#version=2,0,0,0"></object>

<script language="jscript">

 

    // CAPICOM constants

    var CAPICOM_STORE_OPEN_READ_ONLY = 0;

    var CAPICOM_CURRENT_USER_STORE = 2;

    var CAPICOM_CERTIFICATE_FIND_SHA1_HASH = 0;

    var CAPICOM_CERTIFICATE_FIND_EXTENDED_PROPERTY = 6;

    var CAPICOM_CERTIFICATE_FIND_TIME_VALID = 9;

    var CAPICOM_CERTIFICATE_FIND_KEY_USAGE = 12;

    var CAPICOM_DIGITAL_SIGNATURE_KEY_USAGE = 0x00000080;

    var CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME = 0;

    var CAPICOM_INFO_SUBJECT_SIMPLE_NAME = 0;

    var CAPICOM_ENCODE_BASE64 = 0;

    var CAPICOM_ENCODE_BINARY = 1;

    var CAPICOM_E_CANCELLED = -2138568446;

    var CERT_KEY_SPEC_PROP_ID = 6;

 

function IsCAPICOMInstalled()

{

            if(typeof(oCAPICOM) == "object")

            {

                        if( (oCAPICOM.object != null) )

                        {

                                    // We found CAPICOM!

                                    return true;

                        }

            }

}

 

function init()

{

               // Filter the certificates to only those that are good for my purpose

               var FilteredCertificates = FilterCertificates();

 

               // if only one certificate was found then lets show that as the selected certificate

               if (FilteredCertificates.Count == 1)

               {

                        txtCertificate.value = FilteredCertificates.Item(1).GetInfo(CAPICOM_INFO_SUBJECT_SIMPLE_NAME);

                        txtCertificate.hash = FilteredCertificates.Item(1).Thumbprint;

               }

               else

               {

                        txtCertificate.value = "";

                        txtCertificate.hash = "";

               }

 

               // clean up

               FilteredCertificates = null;

}

 

 

function FilterCertificates()

{

               // instantiate the CAPICOM objects

               var MyStore = new ActiveXObject("CAPICOM.Store");

               var FilteredCertificates = new ActiveXObject("CAPICOM.Certificates");

 

               // open the current users personal certificate store

               try

               {

                        MyStore.Open(CAPICOM_CURRENT_USER_STORE, "My", CAPICOM_STORE_OPEN_READ_ONLY);

               }

               catch (e)

               {

                        if (e.number != CAPICOM_E_CANCELLED)

                        {

                                    alert("An error occurred while opening your personal certificate store, aborting");

                                    return false;

                        }

               }

 

               // find all of the certificates that:

               // * Are good for signing data

               //       * Have PrivateKeys associated with then - Note how this is being done :)

               // * Are they time valid

               var FilteredCertificates = MyStore.Certificates.Find(CAPICOM_CERTIFICATE_FIND_KEY_USAGE,CAPICOM_DIGITAL_SIGNATURE_KEY_USAGE).Find(CAPICOM_CERTIFICATE_FIND_TIME_VALID).Find(CAPICOM_CERTIFICATE_FIND_EXTENDED_PROPERTY,CERT_KEY_SPEC_PROP_ID);

               return FilteredCertificates;

 

               // Clean Up

               MyStore = null;

               FilteredCertificates = null;

}

 

function FindCertificateByHash(szThumbprint)

{

               // instantiate the CAPICOM objects

               var MyStore = new ActiveXObject("CAPICOM.Store");

 

               // open the current users personal certificate store

               try

               {

                        MyStore.Open(CAPICOM_CURRENT_USER_STORE, "My", CAPICOM_STORE_OPEN_READ_ONLY);

               }

               catch (e)

               {

                        if (e.number != CAPICOM_E_CANCELLED)

                        {

                                    alert("An error occurred while opening your personal certificate store, aborting");

                                    return false;

                        }

               }

 

               // find all of the certificates that have the specified hash

               var FilteredCertificates = MyStore.Certificates.Find(CAPICOM_CERTIFICATE_FIND_SHA1_HASH, szThumbprint);

               return FilteredCertificates.Item(1);

 

               // Clean Up

               MyStore = null;

               FilteredCertificates = null;

}

 

function btnSelectCertificate_OnClick()

{

               // retrieve the filtered list of certificates

               var FilteredCertificates = FilterCertificates();

 

               // if only one certificate was found then lets show that as the selected certificate

               if (FilteredCertificates.Count >= 1)

               {

 

                        try

                        {

                                    // Pop up the selection UI

                            var SelectedCertificate = FilteredCertificates.Select();

                                    txtCertificate.value = SelectedCertificate.Item(1).GetInfo(CAPICOM_INFO_SUBJECT_SIMPLE_NAME);

                                    txtCertificate.hash = SelectedCertificate.Item(1).Thumbprint;

 

                        }

                        catch (e)

                        {

                                    txtCertificate.value = "";

                                    txtCertificate.hash = "";

                        }

               }

               else

               {

                        alert("You have no valid certificates to select from");

               }

 

               // Clean-Up

               SelectedCertificate = null;

               FilteredCertificates = null;

}

 

function btnVerifySig_OnClick()

 {

    // instantiate the CAPICOM objects

             var SignedData = new ActiveXObject("CAPICOM.SignedData");

             var signature = txtsigndata.value;

             var content = txtPlainText.value;

 

             SignedData.Content = content;

 

             try

                {

                 var szverify = SignedData.Verify(signature, false);

                 alert("Signature Verified");

                }

               catch (e)

                        {

                         if (e.number != CAPICOM_E_CANCELLED)

                          {

                        alert("An error occurred when attempting to verify the content, the errot was: " + e.description);

                        return false;

                  }

                      }

 

 }

function btnSignedData_OnClick()

{

               // instantiate the CAPICOM objects

               var SignedData = new ActiveXObject("CAPICOM.SignedData");

               var Signer = new ActiveXObject("CAPICOM.Signer");

               var TimeAttribute = new ActiveXObject("CAPICOM.Attribute");

 

 

                        // only do this if the user selected a certificate

               if (txtCertificate.hash != "")

               {

 

                        // Set the data that we want to sign

                        SignedData.Content = txtPlainText.value;

                        try

                        {

                                    // Set the Certificate we would like to sign with

                                    Signer.Certificate = FindCertificateByHash(txtCertificate.hash);

 

                                    // Set the time in which we are applying the signature

                                    var Today = new Date();

                                    TimeAttribute.Name = CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME;

                                    TimeAttribute.Value = Today.getVarDate();

                                    Today = null;

                                    Signer.AuthenticatedAttributes.Add(TimeAttribute);

 

                                    // Do the Sign operation

                                    var szSignature = SignedData.Sign(Signer, false, CAPICOM_ENCODE_BASE64);

 

                        }

                        catch (e)

                        {

                                    if (e.number != CAPICOM_E_CANCELLED)

                                    {

                                                alert("An error occurred when attempting to sign the content, the errot was: " + e.description);

                                                return false;

                                    }

                        }

 

                        txtsigndata.value=szSignature;

 

 

               }

               else

               {

                        alert("No Certificate has been selected.");

               }

}

</script>
    
</head>
<tr><td ><p>
    <p>
        <br />
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <form id="form1" runat="server">
    <div>
		<input type="text" name="txtFName">
        <br />
        <br />
		<input type="text" name="txtLName">
        <br />
        <br />
		<input type="text" name="txtBOD">
        <br />
        <br />
		<input type="text" name="txtBODYear">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    
        <br />
        <br />
        <br />
        <input id="Sign" type="button" value="button" onclick="btnSignedData_OnClick()"/>
        </div>

       
        <input type="hidden"  id = "HDVSD"/>
    </form>
</td></tr>
</span>

