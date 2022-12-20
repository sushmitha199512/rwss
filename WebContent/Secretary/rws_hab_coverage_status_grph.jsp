


<%@ page import="java.sql.*" %>



<%
t=0;
     String covNames[]=new String[9];
	 String habCount[]=new String[9];

	try{
      Statement st=conn.createStatement();
 String qs="select (select count(*)  from rws_habitation_directory_tbl where coverage_status='FC')FC,(select count(*)  from rws_habitation_directory_tbl where coverage_status='PC4')PC4,(select count(*)  from rws_habitation_directory_tbl where coverage_status='PC3')PC3,(select count(*)  from rws_habitation_directory_tbl where coverage_status='PC2')PC2,(select count(*)  from rws_habitation_directory_tbl where coverage_status='PC1')PC1,(select count(*)  from rws_habitation_directory_tbl where coverage_status='NSS')NSS,(select count(*)  from rws_habitation_directory_tbl where coverage_status='NC')NC from dual";
   ResultSet rst=st.executeQuery(qs);
  rst.next();
      covNames[t]="FC";
       habCount[t]=rst.getString(1);
	t++;		 
      covNames[t]="PC4";
       habCount[t]=rst.getString(2);
	t++;		 
      covNames[t]="PC3";
       habCount[t]=rst.getString(3);
	t++;		 
      covNames[t]="PC2";
       habCount[t]=rst.getString(4);
	t++;		 
      covNames[t]="PC1";
       habCount[t]=rst.getString(5);
	t++;	
 covNames[t]="NSS";
       habCount[t]=rst.getString(6);
	t++;	
 covNames[t]="NC";
       habCount[t]=rst.getString(7);


 }catch(Exception e){
  e.printStackTrace();
}
        
%>