
<%@page import="nic.watersoft.smsmobile.Rws_Encrypt_Random_Generation"%>
<%
Rws_Encrypt_Random_Generation encrypt_Random_Generation=new  Rws_Encrypt_Random_Generation();
int n=encrypt_Random_Generation.generateEncryptRandomNumber();
out.println(n);
%>
