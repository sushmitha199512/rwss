<%	
String q11=null,q22=null,q33=null,q44=null;
int totnss=0,totf=0,tottds=0,tots=0;
String parameterTypes[]=new String [4];
parameterTypes[0]="NSS";parameterTypes[1]="FLOURIDE";parameterTypes[2]="TDS";parameterTypes[3]="SALINITY";

 
try{

                 query="select count(distinct panch_code) as habcount from rws_wq_test_results_tbl w,rws_complete_hab_view v where v.panch_code=substr (source_code,1,16)  and COVERAGE_STATUS='NSS' ";
				 q11="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id   and  testing_parameter_code='13' and testing_parameter_value>'1.5' ";
                 q22="select  count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id  and testing_parameter_code='05' and testing_parameter_value> 2000 ";
				 q33="select count(*) from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b  where v.panch_code=substr (source_code,1,16) and w.test_id=b.test_id     and testing_parameter_code='12' and  (0.03+((1.806*testing_parameter_value)/1000) > 1.836)  ";
				
System.out.println("QQ:"+query);

				Statement stmt = conn.createStatement();
				ResultSet rss = stmt.executeQuery(query);
				
                Statement st1 = conn.createStatement();
				ResultSet rss1 = st1.executeQuery(q11);


				Statement st2 = conn.createStatement();
				ResultSet rss2 = st2.executeQuery(q22);

				Statement st3 = conn.createStatement();
				ResultSet rss3= st3.executeQuery(q33);

				 
				rss.next();			
				rss1.next();
				rss2.next();
				rss3.next();
				
				
         
		totnss=rss.getInt(1);
		totf=rss1.getInt(1);
		tottds=rss2.getInt(1);
		tots=rss3.getInt(1);
		
			// tot=tot+rs.getInt(2);
	    int tot=totnss+totf+tottds+tots;
	    //System.out.println("tot:::::::::;"+tot);
	    
			%>
					
<% }catch(Exception e){
    e.printStackTrace();
} %>
		
	