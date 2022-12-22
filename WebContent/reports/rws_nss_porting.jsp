<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>
<%
		Connection conn = null, conn1 = null;
		Statement st1 = null, st2 = null;
		ResultSet rs2 = null, rs1 = null;
		int total = 0;
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No", sourcetypeid = "";
		double popcov = 0;
		Statement stq1 = null, stq2 = null, stq3 = null, stq31 = null, stq4 = null, stq5 = null, sss = null, prev = null;
		ResultSet rsq1 = null, rsq2 = null, rsq3 = null, rsq31 = null, rsq4 = null, rsq5 = null, prevrs = null, san = null;
		int reccount=0;
		%>

	<%try {

	
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser",
					"preduser");

			//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			//conn = DriverManager.getConnection("jdbc:odbc:delhidsn1");

			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			conn1 = DriverManager.getConnection("jdbc:odbc:NSSDSN");

		
		Statement stqq = null, stqq1 = null;
		ResultSet rs = null;
 Statement mainStmt=null,mainStmt1=null,st5=null;
  ResultSet mainRs=null, mainRs1=null;
  st5=conn.createStatement();
  
  mainStmt=conn.createStatement();
  mainStmt1=conn1.createStatement();
  
  String habQuery="SELECT HAB_CODE ,CONT_TYPE FROM RWS_HAB_CONTAMINATION_TBL";
  
  System.out.println("habQuery:"+habQuery);
  ResultSet rh=st5.executeQuery(habQuery);
  
  
  while(rh.next()){
	  
	  String new_contamination_status="NILL";
	  String old_status="";
	  String ctype="";
	  String cPValue="";
		  
		 String cValue=rh.getString(2);

	    if(cValue.equals("01")){
	    	old_status="FLOURIDE";
	    	    }
	    if(cValue.equals("02")){
	    	old_status="BRAKISH";
	    	
	    }
	    if(cValue.equals("03")){
	    	old_status="IRON";
	    	
	    }
	    if(cValue.equals("05")){
	    	old_status="NITRATE";
	    	
	    }
      String hab_code=rh.getString(1);
         String q1="select a.TEST_ID,b.TESTING_PARAMETER_CODE,b.TESTING_PARAMETER_VALUE  from RWS_WQ_TEST_RESULTS_TBL a,RWS_WQ_TEST_RESULTS_LNK_TBL b where  substr(a.test_id,4,2) in ('10','11','12','13') and   (a.PREPARED_ON=(select  MAX(c.prepared_on) from  RWS_WQ_TEST_RESULTS_TBL  c where c.source_code=a.source_code))   and a.test_id=b.test_id and substr(a.source_code,1,16)='"+hab_code+"'";
           rs=mainStmt.executeQuery(q1);
           boolean flag1=false;
           while(rs.next()){
        	   
        	   
        	   if(rs.getString(2).equals("13")){    //  FLOURID
        		   
        		   if(rs.getString(3)!=null && !rs.getString(3).equals("")){
        		     double value=Double.parseDouble(rs.getString(3));
        		     if(value>1.5){
        		    	 new_contamination_status="FLOURIDE";
        		    	 ctype="01";
        		    	 cPValue=String.valueOf(value);
        		    	 if(old_status.equals(new_contamination_status)){
        		    	  	 break;
        		    	 }
        		    	 
        		     }
        		           		     
        		   }
        			}
				else if(rs.getString(2).equals("05")){  // TDS
					 if(rs.getString(3)!=null && !rs.getString(3).equals("")){
	        		     double value=Double.parseDouble(rs.getString(3));
	        		     if(value>2000){
	        		    	 new_contamination_status="BRAKISH";
	        		    	 ctype="02";
	        		    	 cPValue=String.valueOf(value);
	        		    	 if(old_status.equals(new_contamination_status)){
	        		    	  	 break;
	        		    	 }
	        		    
	        		     }
	        		           		     
	        		   }}
				else if(rs.getString(2).equals("15")){  // NITRATE
					 if(rs.getString(3)!=null && !rs.getString(3).equals("")){
	        		     double value=Double.parseDouble(rs.getString(3));
	        		     if(value>45){
	        		    	 ctype="05";
	        		    	 cPValue=String.valueOf(value);
	        		    	 new_contamination_status="NITRATE";
	        		    	 if(old_status.equals(new_contamination_status)){
	        		    	  	 break;
	        		    	 }
	        		    
	        		     }
	        		           		     
	        		   }}
				else if(rs.getString(2).equals("16")){  // IRON
					 if(rs.getString(3)!=null && !rs.getString(3).equals("")){
	        		     double value=Double.parseDouble(rs.getString(3));
	        		     if(value>1.0){
	        		    	 new_contamination_status="IRON";
	        		    	 ctype="03";
	        		    	 cPValue=String.valueOf(value);
	        		    	 if(old_status.equals(new_contamination_status)){
	        		    	  	 break;
	        		    	 }
	        		    
	        		    	 
	        		     }
	        		           		     
	        		   }}
        	   
        	   
           }
           
           if(new_contamination_status!=null && !new_contamination_status.equals("NILL")){
               String updateNssHab="update HAB_CONTAMINATION set CONT_TYPE=?,CONT_PERC=?,NEW_STATUS=? WHERE HAB_CODE=?";
            reccount++;
        System.out.println("updateNssHab:"+reccount+"-"+updateNssHab);
        PreparedStatement ps=conn.prepareStatement(updateNssHab);
        ps.setString(1, ctype);
        ps.setString(2, cPValue);
        ps.setString(3, new_contamination_status);
        ps.setString(4, hab_code);
         ps.executeUpdate();
        
           }
        
           
  } //end hab_loop
                        


  
	} catch (Exception e) {
		System.out.println("EXCEPTION IN getting Connection"
				+ e.getMessage());
	}
           
           %>
  
  
  
  
  
  