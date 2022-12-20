package nic.watersoft.reports;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import nic.watersoft.commons.Debug;
import java.sql.SQLException;
 

import javax.sql.DataSource;
 public class CheckListMasterData {
  
 //modified code for getPublicInstitutions on 18-09-08
	public static ArrayList getPublicInstitutions(DataSource dataSource)throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		int totno=0,totcov=0,pno=0,pcov=0,tno=0,tcov=0,phno=0,phcov=0,ano=0,acov=0,libno=0,libcov=0,cno=0,ccov=0,upno=0,upcov=0,
			hsno=0,hscov=0,bcno=0,bccov=0,scno=0,sccov=0,stno=0,stcov=0;//code added to get the total of all columns on 17-09-08	
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
		  conn = dataSource.getConnection();
			//  System.out.println("connection "+conn.getMetaData().getURL());
			//  System.out.println("DataSource "+dataSource.getConnection().getMetaData().getURL());
			  
			/* query1="select sum(p_inst_no), sum(p_inst_covered),d.dName ,d.dcode " +
			  		   "from rws_hab_institute_tbl,rws_district_tbl d where " +
			  		   "d.dcode=substr(hab_code,1,2) and p_inst_no is not null  "; 
 			    String query2= " group by d.dName,d.dcode ";
			*/
			query1="select sum(hab.p_inst_no) as no,sum(hab.p_inst_covered) as covered,d.dname,d.dcode from rws_hab_institute_tbl hab,rws_district_tbl d where substr(hab.hab_code,1,2)=d.dcode and hab.p_inst_no is not null group by d.dcode,d.dname";
			  
		 	String finalqry=query1;//+query2;		 	  
		 	PreparedStatement psmt1=conn.prepareStatement(finalqry);
			ResultSet rs1=psmt1.executeQuery();
			  
			while(rs1.next())
			{
		 	  	
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    totno+=rs1.getInt(1);
			    bean.setIsnCov(rs1.getString(2));
			    totcov+=rs1.getInt(2);
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			    PreparedStatement psmt2=conn.prepareStatement(inCode);			    
			    ResultSet rs2=psmt2.executeQuery();
			    
			    try
				{
			     while(rs2.next())
			     {
			    	String instCode=rs2.getString("INST_CODE");
			    	conn2=dataSource.getConnection();
			    	String instsumQry="select sum(p_inst_no),sum(p_inst_covered)" +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"'";
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	ResultSet rs3=psmt3.executeQuery();

			    	try
					{
			    	 if(rs3.next())
			    	 {
				       if(instCode.equals("01"))
				       {
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 pno+=rs3.getInt(1);
				    	 bean.setPrimaryCov(rs3.getString(2));
				    	 pcov+=rs3.getInt(2);
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1));
				    	 tno+=rs3.getInt(1);
				    	 bean.setTemplesCov(rs3.getString(2));
				    	 pcov+=rs3.getInt(2);
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1));
				    	 phno+=rs3.getInt(1);
				    	 bean.setPhCov(rs3.getString(2));
				    	 phcov+=rs3.getInt(2);
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1));
				    	 ano+=rs3.getInt(1);
				    	 bean.setAngCov(rs3.getString(2));
				    	 acov+=rs3.getInt(2);
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1));
				    	 libno+=rs3.getInt(1);
				    	 bean.setLibCov(rs3.getString(2));
				    	 libcov+=rs3.getInt(2);
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				         cno+=rs3.getInt(1);
				    	 bean.setCommCov(rs3.getString(2));
				    	 ccov+=rs3.getInt(2);
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				         upno+=rs3.getInt(1);
				    	 bean.setUpschCov(rs3.getString(2));
				    	 upcov+=rs3.getInt(2);
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				         hsno+=rs3.getInt(1);
				    	 bean.setHighCov(rs3.getString(2));
				    	 hscov+=rs3.getInt(2);
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				         bcno+=rs3.getInt(1);
				    	 bean.setBcHosCov(rs3.getString(2));
				    	 bccov+=rs3.getInt(2);
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				         scno+=rs3.getInt(1);
				    	 bean.setScCov(rs3.getString(2));
				    	 sccov+=rs3.getInt(2);
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
				         stno+=rs3.getInt(1);
					     bean.setStCov(rs3.getString(2));
					     stcov+=rs3.getInt(2);
			 	    	}
			    	}
				    				    	
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs3"+e);
				}
			    finally
				{
			    	rs3.close();
			    	psmt3.close();
			    	conn2.close();
			    }
			}
		  }
		  catch(Exception e)
		  {
			Debug.println("Error in rs2"+e);
		  }
		  		//code added to retrieve the total of all columns
		    	bean.setTotno1(totno+"");
		    	bean.setTotcov1(totcov+"");
		    	bean.setPno1(pno+"");
		    	bean.setPcov1(pcov+"");
		    	bean.setTno1(tno+"");
		    	bean.setTcov1(tcov+"");
		    	bean.setPhno1(phno+"");
		    	bean.setPhcov1(phcov+"");
		    	bean.setAno1(ano+"");
		    	bean.setAcov1(acov+"");
		    	bean.setLibno1(libno+"");
		    	bean.setLibcov1(libcov+"");
		    	bean.setCno1(cno+"");
		    	bean.setCcov1(ccov+"");
		    	bean.setUpno1(upno+"");
		    	bean.setUpcov1(upcov+"");
		    	bean.setHsno1(hsno+"");
		    	bean.setHscov1(hscov+"");
		    	bean.setBcno1(bcno+"");
		    	bean.setBccov1(bccov+"");
		    	bean.setScno1(scno+"");
		    	bean.setSccov1(sccov+"");
		    	bean.setStno1(stno+"");
		    	bean.setStcov1(stcov+"");
		    	
			   institutes.add(bean);
 			  }
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		finally {
        	try {
        		if (conn != null)
        		{
        			conn.close();
        		}
        	   }
        	   catch (SQLException e)
			   {
        		Debug.println("Exception "+e);
        	   }
        	   }
		return  institutes;
	}
 	
 	
 	
 	/*	public static ArrayList getPublicInstitutions(DataSource dataSource)throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
			  conn = dataSource.getConnection();
			  
			  query1="select  sum(p_inst_no), sum(p_inst_covered),d.dName ,d.dcode " +
			  		"  from rws_hab_institute_tbl,rws_district_tbl d where " +
			  		"d.dcode=substr(hab_code,1,2) and p_inst_no is not null  "; 
			  
			  String query2= " group by d.dName,d.dcode ";
			  
		 	  String finalqry=query1+query2;
		 	  Debug.println(" FINAL QUERY:"+ finalqry);
			  PreparedStatement psmt1=conn.prepareStatement(finalqry);
			  ResultSet rs1=psmt1.executeQuery();
			  while(rs1.next())
			  {
		 	  //	Debug.println("in while");
		 	  	
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    bean.setIsnCov(rs1.getString(2));
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			   // Debug.println(" code get qry:"+ inCode);
			    PreparedStatement psmt2=conn.prepareStatement(inCode);
			    
			    ResultSet rs2=psmt2.executeQuery();
			    try{
			    while(rs2.next())
			    {
			    	String instCode=rs2.getString("INST_CODE");
			    	conn2=dataSource.getConnection();
			    	String instsumQry="select sum(p_inst_no),sum(p_inst_covered)" +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"'";
			    	
			    	 //Debug.println(" instsumQry  qry:"+ instsumQry);
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	
			    	ResultSet rs3=psmt3.executeQuery();
			    	try{
			    	if(rs3.next())
			    	{
				    	if(instCode.equals("01"))
				    	{
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 bean.setPrimaryCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1)); 
				    	 bean.setTemplesCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1)); 
				    	 bean.setPhCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1)); 
				    	 bean.setAngCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1)); 
				    	 bean.setLibCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				    	 bean.setCommCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				    	 bean.setUpschCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				    	 bean.setHighCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				    	 bean.setBcHosCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				    	 bean.setScCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
					     bean.setStCov(rs3.getString(2));  
			 	    	}
			    	}
			    	}
			    	catch(Exception e)
					{
			    		Debug.println("Error in rs3"+e);
					}
			    	finally{
			    		rs3.close();
			    		psmt3.close();
			    		conn2.close();
			    	}
			    }
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs2"+e);
				}
			    institutes.add(bean);
 			  }
			  
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  institutes;
	}
 	*/
 	
 	public static ArrayList getManPublicInstitutions(DataSource dataSource,String dcode )throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
			  conn = dataSource.getConnection();
			
			  
			  query1="select sum(p_inst_no), sum(p_inst_covered ),d.dName ,d.dcode,m.mname,m.mcode " +
			  		" from rws_hab_institute_tbl,rws_district_tbl d,rws_mandal_tbl m where " +
			  		"d.dcode=substr(hab_code,1,2) and  m.dcode=substr(hab_code,1,2) " +
			  		"and m.mcode=substr(hab_code,6,2) and p_inst_no is not null and substr(hab_code,1,2)='"+dcode+"'"; 
			  
			  String query2= " group by d.dName,d.dcode,M.mname,m.mcode ";
			  
		 	  String finalqry=query1+query2;
		 	  Debug.println(" FINAL QUERY:"+ finalqry);
			  PreparedStatement psmt1=conn.prepareStatement(finalqry);
			  ResultSet rs1=psmt1.executeQuery();
			  while(rs1.next())
			  {
		 	  	Debug.println("in while");
		 	  	
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    bean.setIsnCov(rs1.getString(2));
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    bean.setManName(rs1.getString(5));
			    bean.setManCode(rs1.getString(6));
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			    Debug.println(" code get qry:"+ inCode);
			    PreparedStatement psmt2=conn.prepareStatement(inCode);
			    
			    ResultSet rs2=psmt2.executeQuery();
			    try{
			    while(rs2.next())
			    {
			    	conn2=dataSource.getConnection();
			    	String instCode=rs2.getString("INST_CODE");
			    	
			    	String instsumQry="select sum(p_inst_no),sum(p_inst_covered)" +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"' and substr(hab_code,6,2)='"+rs1.getString(6)+"'";
			    	
			    	 //Debug.println(" instsumQry  qry:"+ instsumQry);
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	
			    	ResultSet rs3=psmt3.executeQuery();
			    	try{
			    	if(rs3.next())
			    	{
				    	if(instCode.equals("01"))
				    	{
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 bean.setPrimaryCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1)); 
				    	 bean.setTemplesCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1)); 
				    	 bean.setPhCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1)); 
				    	 bean.setAngCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1)); 
				    	 bean.setLibCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				    	 bean.setCommCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				    	 bean.setUpschCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				    	 bean.setHighCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				    	 bean.setBcHosCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				    	 bean.setScCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
					     bean.setStCov(rs3.getString(2));  
			 	    	}
			    	}
			    	}
			    	catch(Exception e)
					{
			    		Debug.println("Error in rs3"+e);
					}
			    	finally{
			    	psmt3.close();
			    	rs3.close();
			    	conn2.close();	
			    	
			    	}
			    }
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs2"+e);
				}
			    institutes.add(bean);
 			  }
			  
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  institutes;
	}
 	
 	public static ArrayList getPnPublicInstitutions(DataSource dataSource,String dcode,String mandal )throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
			  conn = dataSource.getConnection();
			  
			  query1="select sum(p_inst_no), sum(p_inst_covered ),d.dName ,d.dcode,m.mname,m.mcode " +
			  		",p.pname,p.pcode  from rws_hab_institute_tbl,rws_district_tbl d,rws_mandal_tbl m " +
			  		",rws_panchayat_tbl p where d.dcode=substr(hab_code,1,2) and  m.dcode=substr(hab_code,1,2) " +
			  		"and m.mcode=substr(hab_code,6,2)and p.dcode=substr(hab_code,1,2)" +
			  		" and p.mcode=substr(hab_code,6,2) and p.pcode=substr(hab_code,13,2) and p_inst_no is not" +
			  		" null and substr(hab_code,1,2)='"+dcode+"'"; 
			  if(mandal!=null)
			  {
			  	if(!mandal.equals(""))
			   {
			  	query1=query1+"  and substr(hab_code,6,2)='"+mandal+"'";
			   }
			  }
			  String query2= " group by d.dName,d.dcode,M.mname,m.mcode,p.pcode,p.pname  ";
			  
		 	  String finalqry=query1+query2;
		 	  Debug.println(" FINAL QUERY:"+ finalqry);
			  PreparedStatement psmt1=conn.prepareStatement(finalqry);
			  ResultSet rs1=psmt1.executeQuery();
			  while(rs1.next())
			  {
		 	  	Debug.println("in while");
		 	  
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    bean.setIsnCov(rs1.getString(2));
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    bean.setManName(rs1.getString(5));
			    bean.setManCode(rs1.getString(6));
			    bean.setPName(rs1.getString(7));
			    bean.setPCode(rs1.getString(8));
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			    Debug.println(" code get qry:"+ inCode);
			    PreparedStatement psmt2=conn.prepareStatement(inCode);
			    
			    ResultSet rs2=psmt2.executeQuery();
			    try{
			    while(rs2.next())
			    {
			    	String instCode=rs2.getString("INST_CODE");
			    	conn2=dataSource.getConnection();
			    	String instsumQry="select sum(p_inst_no),sum(p_inst_covered)" +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"' and substr(hab_code,6,2)='"+rs1.getString(6)+"'" +
			  		" and substr(hab_code,13,2)='"+rs1.getString(8)+"'";
			    	
			    	 //Debug.println(" instsumQry  qry:"+ instsumQry);
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	
			    	ResultSet rs3=psmt3.executeQuery();
			    	try{
			    	if(rs3.next())
			    	{
				    	if(instCode.equals("01"))
				    	{
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 bean.setPrimaryCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1)); 
				    	 bean.setTemplesCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1)); 
				    	 bean.setPhCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1)); 
				    	 bean.setAngCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1)); 
				    	 bean.setLibCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				    	 bean.setCommCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				    	 bean.setUpschCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				    	 bean.setHighCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				    	 bean.setBcHosCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				    	 bean.setScCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
					     bean.setStCov(rs3.getString(2));  
			 	    	}
			    	}
			    	}
			    	catch(Exception e)
					{
			    		Debug.println("Error in rs3"+e);
					}
			    	finally{
			    		rs3.close();
			    		psmt3.close();
			    		conn2.close();
			    	}
			    }
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs2"+e);
				}
			    institutes.add(bean);
 			  }
			  
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  institutes;
	}
 	
 	public static ArrayList getVilPublicInstitutions(DataSource dataSource,String dcode,String mandal,String Panchayat )throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
			  conn = dataSource.getConnection();
			  
			  query1="select  sum(p_inst_no), sum(p_inst_covered ),d.dName ,d.dcode,m.mname,m.mcode " +
			  		",p.pname,p.pcode ,v.vName,v.vcode from rws_hab_institute_tbl,rws_district_tbl d," +
			  		"rws_mandal_tbl m ,rws_panchayat_tbl p ,rws_village_tbl v where d.dcode=substr(hab_code,1,2) " +
			  		"and  m.dcode=substr(hab_code,1,2) and m.mcode=substr(hab_code,6,2)and " +
			  		"p.dcode=substr(hab_code,1,2) and p.mcode=substr(hab_code,6,2) and p.pcode=substr(hab_code,13,2)" +
			  		" and v.dcode=substr(hab_code,1,2) and v.mcode=substr(hab_code,6,2) and " +
			  		"v.pcode=substr(hab_code,13,2)and v.vcode=substr(hab_code,8,3) and p_inst_no is not null" +
			  		" and substr(hab_code,1,2)='"+dcode+"'";
			  if(mandal!=null)
			  {
			  	if(!mandal.equals(""))
			   {
			  	query1=query1+"  and substr(hab_code,6,2)='"+mandal+"'";
			  	if(!Panchayat.equals(""))
			  	{
			  		query1=query1+"  and substr(hab_code,13,2)='"+Panchayat+"'";
			  	}
			   }
			  	 
			  }
			  String query2=" group by d.dName,d.dcode,M.mname,m.mcode,p.pcode,p.pname,hab_code,v.vcode,v.vname ";
			  query1=query1+query2;
		  	  String finalqry=query1 ;
		 	  Debug.println(" FINAL QUERY:"+ finalqry);
			  PreparedStatement psmt1=conn.prepareStatement(finalqry);
			  ResultSet rs1=psmt1.executeQuery();
			  while(rs1.next())
			  {
		 	  	Debug.println("in while");
		 	  	
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    bean.setIsnCov(rs1.getString(2));
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    bean.setManName(rs1.getString(5));
			    bean.setManCode(rs1.getString(6));
			    bean.setPName(rs1.getString(7));
			    bean.setPCode(rs1.getString(8));
			    bean.setVilName(rs1.getString(9));
			    bean.setVilCode(rs1.getString(10));
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			    Debug.println(" code get qry:"+ inCode);
			    PreparedStatement psmt2=conn.prepareStatement(inCode);
			    
			    ResultSet rs2=psmt2.executeQuery();
			    try{
			    while(rs2.next())
			    {
			    	String instCode=rs2.getString("INST_CODE");
			    	conn2=dataSource.getConnection();
			    	String instsumQry="select sum(p_inst_no),sum(p_inst_covered) " +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"' and substr(hab_code,6,2)='"+rs1.getString(6)+"'" +
			  		" and substr(hab_code,13,2)='"+rs1.getString(8)+"' and substr(hab_code,8,3)='"+rs1.getString(10)+"'";
			    	
			    	 //Debug.println(" instsumQry  qry:"+ instsumQry);
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	
			    	ResultSet rs3=psmt3.executeQuery();
			    	try{
			    	if(rs3.next())
			    	{
				    	if(instCode.equals("01"))
				    	{
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 bean.setPrimaryCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1)); 
				    	 bean.setTemplesCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1)); 
				    	 bean.setPhCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1)); 
				    	 bean.setAngCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1)); 
				    	 bean.setLibCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				    	 bean.setCommCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				    	 bean.setUpschCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				    	 bean.setHighCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				    	 bean.setBcHosCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				    	 bean.setScCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
					     bean.setStCov(rs3.getString(2));  
			 	    	}
			    	}
			    	}
			    	catch(Exception e)
					{
			    		Debug.println("Error in rs3"+e);
			    		
					}
			    	finally{
			    		rs3.close();
			    		psmt3.close();
			    		conn2.close();
			    	}
			    }
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs2"+e);
				}
			    institutes.add(bean);
 			  }
			  
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  institutes;
	}
 	
 	
	
 	public static ArrayList getHabPublicInstitutions(DataSource dataSource,String dcode,String mandal,String Panchayat,String village ,String habitation)throws Exception
	{
	 	Connection conn=null;
	 	Connection conn2=null;
		ArrayList institutes=new ArrayList();
		 
		String query1="";
		rws_hab_publicins_bean bean=null;
		try
		{
			  conn = dataSource.getConnection();
			  
			  query1="  select  sum(p_inst_no), sum(p_inst_covered ),d.dName " +
			  		",d.dcode,m.mname,m.mcode ,p.pname,p.pcode ,v.vName,v.vcode,pr.panch_name," +
			  		"pr.panch_code from rws_hab_institute_tbl ins,rws_district_tbl d,rws_mandal_tbl m " +
			  		",rws_panchayat_tbl p ,rws_village_tbl v ,rws_panchayat_raj_tbl pr where" +
			  		" d.dcode=substr(ins.hab_code,1,2) and  m.dcode=substr(ins.hab_code,1,2) " +
			  		"and m.mcode=substr(ins.hab_code,6,2)and p.dcode=substr(ins.hab_code,1,2) " +
			  		"and p.mcode=substr(ins.hab_code,6,2) and p.pcode=substr(ins.hab_code,13,2)" +
			  		" and v.dcode=substr(ins.hab_code,1,2) and v.mcode=substr(ins.hab_code,6,2) " +
			  		"and v.pcode=substr(ins.hab_code,13,2)and v.vcode=substr(ins.hab_code,8,3) " +
			  		"and pr.panch_code=ins.hab_code and p_inst_no is not null" +
			  		" and substr(ins.hab_code,1,2)='"+dcode+"'";
			  if(mandal!=null)
			  {
			  	if(!mandal.equals(""))
			   {
			  	query1=query1+"  and substr(ins.hab_code,6,2)='"+mandal+"'";
			  	if(!Panchayat.equals(""))
			  	{
			  		query1=query1+"  and substr(ins.hab_code,13,2)='"+Panchayat+"'";
			  		if(!village.equals(""))
				  	{
				  		query1=query1+"  and v.vcode='"+village+"'";
				  		
				  		if(!habitation.equals(""))
				  		{
				  			query1=query1+"  and ins.hab_code='"+habitation+"'";
				  		}
				  	}
			  	}
			   }
 			  }
			  String query2=" group by d.dName,d.dcode,M.mname,m.mcode,p.pcode,p.pname," +
			  		" v.vcode,v.vname,ins.hab_code,pr.panch_name,pr.panch_code";
			  query1=query1+query2;
		  	  String finalqry=query1 ;
		 	  //Debug.println(" FINAL QUERY:"+ finalqry);
			  PreparedStatement psmt1=conn.prepareStatement(finalqry);
			  ResultSet rs1=psmt1.executeQuery();
			  while(rs1.next())
			  {
		 	  	Debug.println("in while");
		 	  	
			  	bean=new rws_hab_publicins_bean ();
			    bean.setInstNum(rs1.getString(1));
			    bean.setIsnCov(rs1.getString(2));
			    bean.setDisName(rs1.getString(3));
			    bean.setDisCode(rs1.getString(4));
			    bean.setManName(rs1.getString(5));
			    bean.setManCode(rs1.getString(6));
			    bean.setPName(rs1.getString(7));
			    bean.setPCode(rs1.getString(8));
			    bean.setVilName(rs1.getString(9));
			    bean.setVilCode(rs1.getString(10));
			    bean.setHabName(rs1.getString(11));
			    bean.setHabCode(rs1.getString(12));
			    String inCode="select inst_code from RWS_PUBLIC_INSTITUTE_TBL order by inst_code";
			    Debug.println(" code get qry:"+ inCode);
			    PreparedStatement psmt2=conn.prepareStatement(inCode);
			    
			    ResultSet rs2=psmt2.executeQuery();
			    try{
			    while(rs2.next())
			    {
			    	String instCode=rs2.getString("INST_CODE");
			    	conn2=dataSource.getConnection();
			    	String instsumQry="select  sum(p_inst_no), sum(p_inst_covered) " +
			  		"  from rws_hab_institute_tbl where p_inst_code='"+instCode+"' and" +
			  		" substr(hab_code,1,2)='"+rs1.getString(4)+"' and substr(hab_code,6,2)='"+rs1.getString(6)+"'" +
			  		" and substr(hab_code,13,2)='"+rs1.getString(8)+"' and substr(hab_code,8,3)='"+rs1.getString(10)+"'" +
			  		" and hab_code='"+rs1.getString(12)+"'";
			    	
			    	 //Debug.println(" instsumQry  qry:"+ instsumQry);
			    	 
			    	PreparedStatement psmt3=conn2.prepareStatement(instsumQry);
			    	
			    	ResultSet rs3=psmt3.executeQuery();
			    	try{
			    	if(rs3.next())
			    	{
				    	if(instCode.equals("01"))
				    	{
				    	 bean.setPrimarySchool(rs3.getString(1)); 
				    	 bean.setPrimaryCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("02"))
				    	{
				    	 bean.setTemples(rs3.getString(1)); 
				    	 bean.setTemplesCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("03"))
				    	{
				    	 bean.setPhCentre(rs3.getString(1)); 
				    	 bean.setPhCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("04"))
				    	{
				    	 bean.setAnganwadiCentre(rs3.getString(1)); 
				    	 bean.setAngCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("05"))
				    	{
				    	 bean.setLib(rs3.getString(1)); 
				    	 bean.setLibCov(rs3.getString(2)); 
				    	}
				    	if(instCode.equals("06"))
				    	{
				         bean.setCommHall(rs3.getString(1));
				    	 bean.setCommCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("07"))
				    	{
				         bean.setUpSch(rs3.getString(1));
				    	 bean.setUpschCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("08"))
				    	{
				         bean.setHigSch(rs3.getString(1));
				    	 bean.setHighCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("09"))
				    	{
				         bean.setBcHos(rs3.getString(1));
				    	 bean.setBcHosCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("10"))
				    	{
				         bean.setScHos(rs3.getString(1));
				    	 bean.setScCov(rs3.getString(2)); 
			 	    	}
				    	if(instCode.equals("11"))
				    	{
				         bean.setStHos(rs3.getString(1));
					     bean.setStCov(rs3.getString(2));  
			 	    	}
			    	}
			    	}
			    	catch(Exception e)
					{
			    		Debug.println("Error in rs3"+e);
					}
			    	finally{
			    		rs3.close();
			    		psmt3.close();
			    		conn2.close();
			    	}
			    }
			    }
			    catch(Exception e)
				{
			    	Debug.println("Error in rs2"+e);
				}
			    institutes.add(bean);
 			  }
			  
	 	}
		catch(Exception e)
		{
			Debug.println("Exception  in rs1 "+e);
		}
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  institutes;
	}
 	
	public static ArrayList getAssetCpwsPumpingMainReport(DataSource dataSource,String query)throws Exception
	{
	
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsPm;
		
		try
		{
			  conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.PUMPINGMAIN_CODE ,subCompTbl.AIRVALVE_NO,"+
							" subCompTbl.SCOUREVALVE ,subCompTbl.REFLEXVALVE,subCompTbl.SLUICEVALVE ,subCompTbl.NO_OF_PIPES,"+ 
							" subCompTbl.ZERO_VELOCITY_VALVE ,subCompTbl.AIR_CUSHION_VALVE ,subCompTbl.LOCATION,subCompTbl.NON_RETURN_VALVE,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        Debug.println( "final:"+finalQuery);
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);
		    ResultSet rs=psmt1.executeQuery();
		     
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	  
	        	     Statement stmt2 = conn.createStatement();
		    	      Statement stmt3 = conn.createStatement();
		             ResultSet  rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPINGMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
		             ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPINGMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
		           
		            cpwsPm=new ArrayList();
		            cpwsPm.add(sno);    
		        	try{rs3.next();
		            
		        	cpwsPm.add(rs3.getString("PNAME"));
		        	
		            }catch(Exception e){
		            	cpwsPm.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	//commented by pranavi on 21-04-09
		        	cpwsPm.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		cpwsPm.add("");
		        		Debug.println("exception:"+e);}
		        
		        cpwsPm.add(formatData(rs.getString("ASSET_NAME")));	
	        	cpwsPm.add(formatData(rs.getString("PUMPINGMAIN_CODE")));
	        	//cpwsPm.add(formatData(rs.getInt("LENGTH")));
	         	cpwsPm.add(formatData(rs.getInt("AIRVALVE_NO")));
	        	 cpwsPm.add(formatData(rs.getInt("SCOUREVALVE")));
	        	 cpwsPm.add(formatData(rs.getInt("REFLEXVALVE")));
	        	 cpwsPm.add(formatData(rs.getInt("SLUICEVALVE")));
	        	 cpwsPm.add(formatData(rs.getInt("NO_OF_PIPES")));
	        	cpwsPm.add(formatData(rs.getInt("ZERO_VELOCITY_VALVE")));
	        	cpwsPm.add(formatData(rs.getInt("AIR_CUSHION_VALVE")));
	        	cpwsPm.add(formatData(rs.getInt("NON_RETURN_VALVE")));
	        	cpwsReport.add(cpwsPm);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData in while catch"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
		    
			return  cpwsReport;
	}
	public static ArrayList getAssetCpwsDistributionReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGm;
		
		try
		{   conn = dataSource.getConnection();
			String finalQuery="select  subCompTbl.*,ASSET_NAME" ;
			finalQuery=finalQuery+query;
			 
	       
	    	Statement stmt = conn.createStatement();
	    	   ResultSet rs=stmt.executeQuery( finalQuery);
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsGm=new ArrayList();
	            cpwsGm.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGm.add(rs3.getString("PNAME"));
	        	  }catch(Exception e){
	            	cpwsGm.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGm.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGm.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGm.add(formatData(rs.getString("DISTRISC_CODE")));
	        	cpwsGm.add(formatData(rs.getInt("NO_OF_PIPES")));
	        	cpwsGm.add(formatData(rs.getInt("NO_AIRVALVES"))+"");
	        	cpwsGm.add(formatData(rs.getInt("DIS_LN"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_SLUICEVALVES"))+"");
	        	cpwsGm.add(formatData(rs.getFloat("DIS_TLC"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_SCOURVALVES"))+"");
	        	cpwsGm.add(formatData(rs.getString("DIS_COVE"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_PR_HC"))+"");
	        	cpwsGm.add(formatData(rs.getFloat("DIS_BN"))+"");
	        	cpwsGm.add(formatData(rs.getInt("NO_STANDPOSTS"))+"");
	        	cpwsReport.add( cpwsGm);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
        	try {
        		if (conn != null)
        		{
        	    
        			conn.close();
        		}
        	} catch (SQLException e) {
        		Debug.println("Exception "+e);
        	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsGravityMainReport(DataSource dataSource,String query)throws Exception
	{ 
		Connection conn=null;	
    ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGm;
	
	try
	{
		  conn = dataSource.getConnection();
		String finalQuery="select  subCompTbl.*,M.ASSET_NAME";
        finalQuery=finalQuery+query;
     	Statement stmt = conn.createStatement();
    	     Debug.println( finalQuery);
	        ResultSet rs=stmt.executeQuery( finalQuery);
	        //Debug.println( finalQuery);
	        try{
	        	String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsGm=new ArrayList();
            cpwsGm.add(sno);
        	try{rs3.next();
            
        	cpwsGm.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsGm.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	//commented by pranavi on 21-04-09
        	cpwsGm.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGm.add("");
        		Debug.println("exception:"+e);}
        	cpwsGm.add(formatData(rs.getString("ASSET_Name")));
        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
        	cpwsGm.add(formatData(rs.getString("LENGTH")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
            cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
        	cpwsGm.add(formatData(rs.getString("NO_OF_PIPES")));
        	cpwsGm.add(formatData(rs.getString("ZERO_VELOCITY_VALVE")));
        	cpwsGm.add(formatData(rs.getString("NON_RETURN_VALVE")));
        	cpwsGm.add(formatData(rs.getString("AIR_CUSHION_VALVE")));
        	cpwsReport.add( cpwsGm);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	     
	}
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	    
    			conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}
		return  cpwsReport;
 	}
	public static ArrayList getAssetPwsGravityMainReport(DataSource dataSource, String query)throws Exception
	{ 
    Connection conn=null;	
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsGm;
	
	try
	{  conn = dataSource.getConnection();
		String finalQuery="select  subCompTbl.*,ASSET_NAME";
        finalQuery=finalQuery+query;
        Statement stmt = conn.createStatement();
         ResultSet rs=stmt.executeQuery( finalQuery);
	         try{
	        	String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GRAVITYMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsGm=new ArrayList();
            cpwsGm.add(sno);
        	try{rs3.next();
            
        	cpwsGm.add(rs3.getString("PNAME"));
           }catch(Exception e){
            	cpwsGm.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsGm.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsGm.add("");
        		Debug.println("exception:"+e);}
        	cpwsGm.add(formatData(rs.getString("ASSET_Name")));
        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
        	cpwsGm.add(formatData(rs.getString("LENGTH")));
        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
            cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
        	cpwsGm.add(formatData(rs.getString("NO_OF_PIPES")));
        	cpwsGm.add(formatData(rs.getString("ZERO_VELOCITY_VALVE")));
        	cpwsGm.add(formatData(rs.getString("NON_RETURN_VALVE")));
        	cpwsGm.add(formatData(rs.getString("AIR_CUSHION_VALVE")));
        	cpwsReport.add( cpwsGm);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	       
	}
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	    
    			conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}
		return  cpwsReport;


	}
	public static ArrayList getAssetALLSourceReport(DataSource dataSource,String query)throws Exception
	{Connection conn=null;
		 
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhsr;
		try
		{ conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;
		    PreparedStatement psmt1=conn.prepareStatement(finalQuery);	
		    Debug.println(finalQuery);
	        ResultSet rs2=psmt1.executeQuery();
		      try
			   {
		      	String sno="1";
	            while(rs2.next())
	           { 
	            PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
	            psmt2.setString(1,(String)rs2.getString("SOURCE_CODE"));
	            psmt3.setString(1,(String)rs2.getString("SOURCE_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	              cpwsOhsr=new ArrayList();
	        	cpwsOhsr.add(sno);
	            try{
	            	rs3.next();
	            
	        	cpwsOhsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhsr.add("");
	            	Debug.println("Exception"+e);
	            
	            	}
	        	try{rs4.next();
	        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhsr.add("");
	        		Debug.println("exception:"+e);}
		        	cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("SOURCE_CODE")));
		        	//cpwsOhsr.add("Surface Source");
		            if(rs2.getString("SOURCE_TYPE_CODE")!=null && rs2.getString("SOURCE_TYPE_CODE").equals("2"))
		            {
		            	cpwsOhsr.add("Surface Source");
		            }
		            if(rs2.getString("SOURCE_TYPE_CODE").equals("2")&& rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("1"))
		            {
		            	 cpwsOhsr.add("CANAL");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("2") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("2"))
		            {
		            	cpwsOhsr.add("RIVER");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("2") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("3"))
		            {
		            	cpwsOhsr.add("INTAKE WELL");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("2") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("4"))
		            {
		            	cpwsOhsr.add("SPRINGS");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("2") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("5"))
		            {
		            	cpwsOhsr.add("RESERVOIR");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("2") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null)
		            {
		            	cpwsOhsr.add("-");
		            }
		            
		        	cpwsOhsr.add(formatData(rs2.getString("SOURCE_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("LOCATION"))+"");
		            //commented by Sridhar  on 02-10-09
		           // cpwsOhsr.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD")));
		        	//cpwsOhsr.add(formatData(rs2.getInt("POPULATION_BENIFITED")));
		        	//cpwsOhsr.add(formatData(rs2.getString("SEASONAL")));
		        	cpwsOhsr.add(formatData(rs2.getString("SOURCE_CONDITION")));
		        	cpwsOhsr.add(formatData(rs2.getInt("STATIC_WATER_LEVEL")));
		        	//cpwsOhsr.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL")));
		        	cpwsOhsr.add(formatData(rs2.getString("YIELD")));
		        	
		        	/*String distnear=formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE"));
		        	String alt=formatData(rs2.getInt("ALT_WATER_SOURCE_DET"));
		        	if(alt.equals("1"))
		        	{
		        		alt="Sub Surface Source ";
		        	}
		        	else if(alt.equals("2")){ alt="Surface Source";}
		        	
		        	cpwsOhsr.add(alt +"at" +distnear +"kms");*/
		        	cpwsOhsr.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE")));
		        	//Debug.println(" asdsfsfsdf dg fgfgfdgfdg fgf");
		        	if(rs2.getString("WATER_QUALITY")!=null && rs2.getString("WATER_QUALITY").equals("SS"))
		        	{
		        		Debug.println("11111111111");
		        		cpwsOhsr.add(formatData("Safe Source"));
		        	}
		        	else{
		        		Debug.println("222222222");
		        		cpwsOhsr.add(formatData("Not Safe Source"));
		        	}
		        	//cpwsOhsr.add(formatData(rs2.getString("WATER_QUALITY")));
		        	Debug.println(" sssssssssssssssssssssss");
		        	cpwsReport.add( cpwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
	            
		    }
		        catch(Exception e)
				 {
		        	Debug.println("error in adding data  to  arraylist  in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		   
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in retriving data  in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetALLSourceSubSurfaceReport(DataSource dataSource,String query)throws Exception
	{Connection conn=null;
		 
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhsr;
		try
		{   conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        Debug.println("final query:"+finalQuery);
		  
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);	
	        ResultSet rs2=psmt1.executeQuery();
		       
		     try
			   {
		      	String sno="1";
	            while(rs2.next())
	           { 
	            PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
	            psmt2.setString(1,(String)rs2.getString("SOURCE_CODE"));
	            psmt3.setString(1,(String)rs2.getString("SOURCE_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	              cpwsOhsr=new ArrayList();
	        	cpwsOhsr.add(sno);
	            try{
	            	rs3.next();
	            
	        	cpwsOhsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhsr.add("");
	            	Debug.println("Exception"+e);
	            
	            	}
	        	try{rs4.next();
	        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhsr.add("");
	        		Debug.println("exception:"+e);}
		        	cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("SOURCE_CODE")));
		            if(rs2.getString("SOURCE_TYPE_CODE")!=null && rs2.getString("SOURCE_TYPE_CODE").equals("1"))
		            {
		            	cpwsOhsr.add("Subsurface Source");	
		            }
		            
		            if(rs2.getString("SOURCE_TYPE_CODE").equals("1")&& rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("1"))
		            {
		            	 cpwsOhsr.add("BOREWELL");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("1") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("2"))
		            {
		            	cpwsOhsr.add("FILTER POINT");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("1") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("3"))
		            {
		            	cpwsOhsr.add("INFILTARATION WELL");
		            }
		            else if(rs2.getString("SOURCE_TYPE_CODE").equals("1") && rs2.getString("SUBSOURCE_TYPE_CODE")!=null && rs2.getString("SUBSOURCE_TYPE_CODE").equals("4"))
		            {
		            	cpwsOhsr.add("OPEN WELL");
		            }
		           
		            
		            cpwsOhsr.add(formatData(rs2.getString("LOCATION"))+"");
		           //commented by pranavi on 22-04-09
		            //cpwsOhsr.add(formatData(rs2.getInt("NO_OF_HABITAITONS_COVERD")));
		        	//cpwsOhsr.add(formatData(rs2.getInt("POPULATION_BENIFITED")));
		        	// cpwsOhsr.add(formatData(rs2.getString("SEASONAL")));
		        	cpwsOhsr.add(formatData(rs2.getString("SOURCE_CONDITION")));
		        	cpwsOhsr.add(formatData(rs2.getInt("STATIC_WATER_LEVEL")));
		        	//cpwsOhsr.add(formatData(rs2.getInt("SUMMER_WATER_LEVEL")));
		        	cpwsOhsr.add(formatData(rs2.getString("YIELD")));
		        	//cpwsOhsr.add(formatData(rs2.getFloat("DIAMETER")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("DEPTH")));
		        	cpwsOhsr.add(formatData(rs2.getInt("DIST_NEAR_PRIVATE_SOURCE")));
		        	 if(rs2.getString("WATER_QUALITY")!=null && rs2.getString("WATER_QUALITY").equals("SS"))
		        	 {
		        	//cpwsOhsr.add(formatData(rs2.getString("WATER_QUALITY")));
		        	 	cpwsOhsr.add(formatData("Safe Source"));
		        	 }
		        	 else {
		        	 	cpwsOhsr.add(formatData("Not Safe Source"));
		        	 }
		          	cpwsReport.add( cpwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
	            
		    }
		        catch(Exception e)
				 {
		        	Debug.println("error in adding data  to  arraylist  in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		      
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in retriving data  in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsOhsrReport(DataSource dataSource,String query)throws Exception
	{  //System.out.println("in the function");
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhsr;
		
		try
		{
			  conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC," +
					"subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES," +
					"subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code," +
					" subCompTbl.WATER_QTY,ASSET_NAME";
	        finalQuery=finalQuery+query;
		    PreparedStatement psmt1=conn.prepareStatement(finalQuery);	
	        ResultSet rs2=psmt1.executeQuery();
		       
		     try
			   {
		      	String sno="1";
	            while(rs2.next())
	           { 
	            PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
	            psmt2.setString(1,(String)rs2.getString("OHSR_CODE"));
	            psmt3.setString(1,(String)rs2.getString("OHSR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	            PreparedStatement psmt4=conn.prepareStatement(" select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?");
	            psmt4.setString(1,(String)rs2.getString("OHSR_CODE"));
	          //  System.out.println("select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE="+rs2.getString("OHSR_CODE"));
	            ResultSet  rs5=psmt4.executeQuery();
	            cpwsOhsr=new ArrayList();
	        	cpwsOhsr.add(sno);
	            try{
	            	rs3.next();
	            
	        	cpwsOhsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhsr.add("");
	            	Debug.println("Exception"+e);
	            
	            	}
	          
	        	try{rs4.next();
	        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhsr.add("");
	        		Debug.println("exception:"+e);}
		        	cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
		            try{
		            	rs5.next();
		            	//Debug.println("in noofhabs try block");
		        	 cpwsOhsr.add(formatData(rs5.getString("NO_OF_HABS")));
		        	//System.out.println("noofhabs-->"+rs5.getString("NO_OF_HABS"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	cpwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            
		            	}
		        	cpwsOhsr.add(formatData(rs2.getString("OHSR_LOC")));
		        	cpwsOhsr.add(formatData(rs2.getInt("OHSR_CAP_LTS"))+"");
		            cpwsOhsr.add(formatData(rs2.getInt("OHSR_NO_OF_FILLING"))+"");
		            cpwsOhsr.add(formatData(rs2.getFloat("OHSR_SATGES")));
		            if(rs2.getString("WATER_QTY")!=null && rs2.getString("WATER_QTY").equals("N"))
		            {
		            	 cpwsOhsr.add("Safe Source");
		            }
		            else if(rs2.getString("WATER_QTY")!=null && rs2.getString("WATER_QTY").equals("Y"))
		            {
		            	 cpwsOhsr.add("Not Safe Source");
		            }
		            else
		            {
		            	 cpwsOhsr.add("Safe Source");	
		            }
		            
		        	//cpwsOhsr.add(formatData(rs2.getFloat("OHSR_MWL")));
		        	//cpwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HR")));
		        	//cpwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY_HR")));
		        	cpwsReport.add( cpwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
	            
		    }
		        catch(Exception e)
				 {
		        	Debug.println("error in adding data  to  arraylist  in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		   
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in retriving data  in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsCisternsReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		 
        ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhsr;
		try
		{ conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.*," +
					"ASSET_NAME";
	        finalQuery=finalQuery+query;
		    PreparedStatement psmt1=conn.prepareStatement(finalQuery);	
	        ResultSet rs2=psmt1.executeQuery();
		       
		     try
			   {
		      	String sno="1";
	            while(rs2.next())
	           { 
	            PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
	            psmt2.setString(1,(String)rs2.getString("CISSC_CODE"));
	            psmt3.setString(1,(String)rs2.getString("CISSC_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	            PreparedStatement psmt4=conn.prepareStatement(" select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?");
	            psmt4.setString(1,(String)rs2.getString("CISSC_CODE"));
	            cpwsOhsr=new ArrayList();
	            ResultSet  rs5=psmt4.executeQuery();
	        	cpwsOhsr.add(sno);
	            try{
	            	rs3.next();
	            
	        	cpwsOhsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhsr.add("");
	            	Debug.println("Exception"+e);
	            
	            	}
	        	try{rs4.next();
	        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhsr.add("");
	        		Debug.println("exception:"+e);}
		        	cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("CISSC_CODE")));
		            try{
		            	rs5.next();
		        
		        	// cpwsOhsr.add(formatData(rs5.getString("NO_OF_HABS")));
		        
		            }catch(Exception e){
		            	cpwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            
		            	}
		        	cpwsOhsr.add(formatData(rs2.getString("CIS_LOC")));
		        	cpwsOhsr.add(formatData(rs2.getFloat("CIS_CAP_LTS"))+"");
		            cpwsOhsr.add(formatData(rs2.getString("CIS_HR"))+"");
		            cpwsOhsr.add(formatData(rs2.getString("CIS_PF")));
		            cpwsOhsr.add(formatData(rs2.getString("CIS_PF_CON")));
		        	cpwsOhsr.add(formatData(rs2.getString("CIS_DRAIN")));
		        	if(rs2.getString("Water_qty")!=null && rs2.getString("Water_qty").equals("N"))
		        	{
		        		cpwsOhsr.add("Safe Source");
		        	}
		        	else if(rs2.getString("Water_qty")!=null && rs2.getString("Water_qty").equals("Y"))
			        {
			        cpwsOhsr.add("Not Safe Source");
			         
		        	}
		        	else
		        	{
		        		cpwsOhsr.add("Safe Source");
		        	}
		        	
		        	cpwsReport.add( cpwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
	            
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in adding data  to  arraylist  in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		     
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in retriving data  in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsOhbrReport(DataSource dataSource ,String query)throws Exception
	{
		Connection conn=null;
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhbr;
	    try
		{  conn = dataSource.getConnection();
		 	String finalQuery="select subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS," +
			"subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR," +
			"subCompTbl.OHBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        Debug.println("Quer is "+finalQuery);
			PreparedStatement psmt1=conn.prepareStatement( finalQuery);
	        ResultSet rs=psmt1.executeQuery();
		     
		        try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,16)=substr(panch_code,1,16)");
	            psmt2.setString(1,(String)rs.getString("OHBR_CODE"));
	            psmt3.setString(1,(String)rs.getString("OHBR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	        	cpwsOhbr=new ArrayList();
	        	cpwsOhbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsOhbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsOhbr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsOhbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhbr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
	        	//commented by pranavi on 21-04-09 
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_LWL")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_MWL")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_FILL_HR")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_EMPTY_HR")));
	        	cpwsReport.add( cpwsOhbr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		      
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetPwsReservoirsOhbrReport(DataSource dataSource,String query)throws Exception
	{
		//Debug.println("getting data from CheckListMasterData for cpws reservoirs ohbr  report");
		Connection conn=null;
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsOhbr;
		
		try
		{
			 conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS," +
			"subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR," +
			"subCompTbl.OHBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);
	    	Statement stmt = conn.createStatement();
	           ResultSet rs= psmt1.executeQuery();
		         try{
		        	String sno="1";
	        while(rs.next())
	        {
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,16)=substr(panch_code,1,16)");
	            psmt2.setString(1,(String)rs.getString("OHBR_CODE"));
	            psmt3.setString(1,(String)rs.getString("OHBR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	        	cpwsOhbr=new ArrayList();
	        	cpwsOhbr.add(sno);
	        	try{rs3.next();
	        	cpwsOhbr.add(rs3.getString("PNAME"));
	              }catch(Exception e){
	            	cpwsOhbr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsOhbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsOhbr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
	        	cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
	        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
	        	//commented by pranavi on 23-04-09
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_LWL")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_MWL")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_FILL_HR")));
	        	//cpwsOhbr.add(formatData(rs.getFloat("OHBR_EMPTY_HR")));
	        	cpwsReport.add( cpwsOhbr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		  
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsrGlsrReport(DataSource dataSource, String query)throws Exception
	{    Connection conn=null;
	 	 
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
			conn = dataSource.getConnection();
		 	String finalQuery="select subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS," +
			"subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR," +
			"subCompTbl.GLSR_EMPTY_HR,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.water_qty,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
	        PreparedStatement psmt1=conn.prepareStatement(finalQuery);
		    ResultSet rs= psmt1.executeQuery();
		 
		        try{String sno="1";
	        while(rs.next())
	        {
	        	PreparedStatement psmt2=conn.prepareStatement(" select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
	            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where substr(?,1,16)=substr(panch_code,1,16)");
	            psmt2.setString(1,(String)rs.getString("GLSR_CODE"));
	            psmt3.setString(1,(String)rs.getString("GLSR_CODE"));
	            ResultSet rs3=psmt2.executeQuery();
	            ResultSet  rs4=psmt3.executeQuery();
	            PreparedStatement psmt4=conn.prepareStatement(" select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?");
	            psmt4.setString(1,(String)(String)rs.getString("GLSR_CODE"));
	            ResultSet  rs5=psmt4.executeQuery();
	            cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlsr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
	        	 try{
	            	rs5.next();
	            	//Debug.println("in noofhabs try block");
	            	//cpwsGlsr.add(formatData(rs5.getString("NO_OF_HABS")));
	        	//System.out.println("noofhabs-->"+rs5.getString("NO_OF_HABS"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlsr.add(""); 
	            	Debug.println("Exception"+e);
	             
	            	} 
	            cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));                                                                                                        
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_NO_OF_FILLING")));
	            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES")));
	        	if( rs.getString("water_qty")!=null && !rs.getString("water_qty").equals("") && rs.getString("water_qty").equals("N"))
	        		{
	        		   cpwsGlsr.add("Safe Source");
	        	     }else 
	        			{
	        				cpwsGlsr.add("Not Safe Source");
	        			}
	        	
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	 	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsrGlbrReport(DataSource dataSource, String query)throws Exception
	{
		//Debug.println("getting data from CheckListMasterData for cpws reservoirs glbr  report");
		Connection conn=null;
	 	 
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlbr;
		
		try
		{
			  conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.GLBR_CODE,subCompTbl.GLBR_LOC,subCompTbl.GLBR_CAP_LTS," +
			"subCompTbl.GLBR_LWL,subCompTbl.GLBR_MWL,subCompTbl.GLBR_FILL_HR,subCompTbl.GLBR_EMPTY_HR,ASSET_NAME";
	        finalQuery=finalQuery+query;
            Statement stmt = conn.createStatement();
	           ResultSet rs=stmt.executeQuery(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLBR_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLBR_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsGlbr=new ArrayList();
	            cpwsGlbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlbr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlbr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlbr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
	        	
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
	 	        cpwsReport.add( cpwsGlbr);
	 	        int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		   
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
			return  cpwsReport;

	}
	public static ArrayList getAssetPwsReservoirsrGlbrReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
	      ArrayList cpwsReport=new ArrayList();
		 ArrayList cpwsGlbr;
	  	try
		{
	  	  conn = dataSource.getConnection();
		 	String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;

		   Statement stmt = conn.createStatement();
	           ResultSet rs=stmt.executeQuery(finalQuery);
		         try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLBR_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLBR_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsGlbr=new ArrayList();
	            cpwsGlbr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlbr.add(rs3.getString("PNAME"));
	         }catch(Exception e){
	            	cpwsGlbr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlbr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlbr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
	        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
	        
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
	        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
	 	        cpwsReport.add( cpwsGlbr);
	 	        int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		   
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsReservoirsBptReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
		 ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsBpt;
	 	try
		{	 conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.BPT_CODE,subCompTbl.Location,subCompTbl.CAPACITY,subCompTbl.STAGING," +
			"subCompTbl.BPT_MWL,subCompTbl.BPT_LWL,ASSET_NAME";
	        finalQuery=finalQuery+query;
		    Statement stmt = conn.createStatement();
	    	    ResultSet rs=stmt.executeQuery(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BPT_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BPT_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsBpt=new ArrayList();
	            cpwsBpt.add(sno);
	        	try{rs3.next();
	            
	        	cpwsBpt.add(rs3.getString("PNAME"));
	        	 
	            }catch(Exception e){
	            	cpwsBpt.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsBpt.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsBpt.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("Location")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	 //commented by pranavi on 21-04-09
	        	// cpwsBpt.add(formatData(rs.getFloat("BPT_MWL")));
	        	// cpwsBpt.add(formatData(rs.getFloat("BPT_LWL")));
	             cpwsReport.add(cpwsBpt);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;

	}
	public static ArrayList getAssetPwsReservoirsBptReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null; 
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsBpt;
	  	try
		{
			 conn = dataSource.getConnection();
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;
		 	Statement stmt = conn.createStatement();
	           ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BPT_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BPT_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsBpt=new ArrayList();
	            cpwsBpt.add(sno);
	        	try{rs3.next();
	            
	        	cpwsBpt.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsBpt.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsBpt.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsBpt.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("LOCATION")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	//commented by pranavi on 23-04-09
	        	// cpwsBpt.add(formatData(rs.getFloat("BPT_MWL")));
	        	 //cpwsBpt.add(formatData(rs.getFloat("BPT_LWL")));
	        	  
	             cpwsReport.add(cpwsBpt);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		       }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	    
	    			conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;

	}
	public static ArrayList getAssetCpwsHeadWorksRcWellReport(DataSource dataSource, String query)throws Exception
	{
    Connection conn=null; 
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRwcWell;
	 
	try
	{
		 conn = dataSource.getConnection();
		String finalQuery="select subCompTbl.RW_COLLWELL_CODE,subCompTbl.Location,subCompTbl.Capacity,ASSET_NAME";
        finalQuery=finalQuery+query;
        Debug.println("1111:"+finalQuery);
	   
    	Statement stmt = conn.createStatement();
        ResultSet rs=stmt.executeQuery( finalQuery);
	         try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRwcWell=new ArrayList();
            cpwsRwcWell.add(sno);
        	try{rs3.next();
          	cpwsRwcWell.add(rs3.getString("PNAME"));
        	  }catch(Exception e){
            	cpwsRwcWell.add("");
            	Debug.println("Exception"+e);
            	} 
        	try{rs4.next();
        	cpwsRwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRwcWell.add("");
        		Debug.println("exception:"+e);}
        	cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
        	cpwsRwcWell.add(formatData(rs.getString("LOCATION")));
        	cpwsRwcWell.add(formatData(rs.getFloat("CAPACITY")));
        	//commented by pranavi on 21-04-09
        	//cpwsRwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
            cpwsReport.add(cpwsRwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	     }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	    
    			conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}			
		return  cpwsReport;

	}
	public static ArrayList getAssetPwsHeadWorksRcWellReport(DataSource dataSource, String query)throws Exception
	{
    Connection conn=null; 
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRwcWell;
    
	try
	{
		 conn = dataSource.getConnection();
		String finalQuery="select subCompTbl.RW_COLLWELL_CODE,subCompTbl.Location,subCompTbl.Capacity," +
		"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
        finalQuery=finalQuery+query;
	
    	Statement stmt = conn.createStatement();
    	       ResultSet rs=stmt.executeQuery( finalQuery);
	         try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("RW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRwcWell=new ArrayList();
            cpwsRwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsRwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRwcWell.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRwcWell.add("");
        		Debug.println("exception:"+e);}
        	cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
        	cpwsRwcWell.add(formatData(rs.getString("Location")));
        	cpwsRwcWell.add(formatData(rs.getString("Capacity")));
        	//commented by pranavi on 22-04-09
        	//cpwsRwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
            cpwsReport.add(cpwsRwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	     }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	    
    			conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;

	}
	public static ArrayList getAssetCpwsHeadWorksSSTankReport(DataSource dataSource,String query)throws Exception
	{ 
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSsTank;
	
	try
	{
		String finalQuery="select subCompTbl.SSSC_CODE,subCompTbl.SS_SIZE,subCompTbl.CAPACITY_DAYS," +
				"subCompTbl.CAPACITY_MCUM,subCompTbl.TANK_ADEQACY," +
				"subCompTbl.LOCATION,subCompTbl.POWER_CON,subCompTbl.POWER_HRS,subCompTbl.DEPTH,subCompTbl.OTHERS," +
				"ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SSSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SSSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSsTank=new ArrayList();
            cpwsSsTank.add(sno);
        	try{rs3.next();
            
        	cpwsSsTank.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSsTank.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSsTank.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSsTank.add("");
        		Debug.println("exception:"+e);}
        	cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
        	Debug.println("11111");
        	cpwsSsTank.add(formatData(rs.getString("SS_SIZE")));
        	cpwsSsTank.add(formatData(rs.getFloat("DEPTH")));
        	Debug.println("2222");
        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_DAYS")));
        	Debug.println("3333");
        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_MCUM")));
        	Debug.println("4444");
        	if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Urban"))
        	{
        		cpwsSsTank.add("Canal");
        	}
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Rural"))
        	{
        		cpwsSsTank.add("River");
        	}
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Dedicated"))
        	{
        		cpwsSsTank.add("Reserviors");
        	}
        	
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Others"))
        	{
        		if(rs.getString("OTHERS")!=null)
        		cpwsSsTank.add(formatData(rs.getString("OTHERS")));
        	}
        	//cpwsSsTank.add(formatData(rs.getString("TANK_ADEQACY")));
        	//cpwsSsTank.add(formatData(rs.getString("OTHERS")));
        	Debug.println("5555");
        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
        	// commented by pranavi on 21-04-09
        	//cpwsSsTank.add(formatData(formatData(rs.getString("POWER_CON"))));
        	//cpwsSsTank.add(formatData(rs.getString("POWER_HRS"))+"");
        	Debug.println("6666");
        	
        	Debug.println("7777");
        	//
        	Debug.println("8888");
            cpwsReport.add(cpwsSsTank);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	  }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	    
    			conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksSSTankReport(DataSource dataSource,String query)throws Exception
	{ 
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSsTank;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME";
		finalQuery=finalQuery+query;
	    conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
         ResultSet rs=stmt.executeQuery(finalQuery);
	       
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SSSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SSSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSsTank=new ArrayList();
            cpwsSsTank.add(sno);
        	try{rs3.next();
            
        	cpwsSsTank.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSsTank.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSsTank.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSsTank.add("");
        		Debug.println("exception:"+e);}
        	cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
        	Debug.println("11111");
        	cpwsSsTank.add(formatData(rs.getInt("SS_SIZE")));
        	cpwsSsTank.add(formatData(rs.getFloat("DEPTH")));
        	Debug.println("2222");
        	cpwsSsTank.add(formatData(rs.getInt("CAPACITY_DAYS")));
        	Debug.println("3333");
        	cpwsSsTank.add(formatData(rs.getFloat("CAPACITY_MCUM")));
        	Debug.println("4444");
        	if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Urban"))
        	{
        		cpwsSsTank.add("Canal");
        	}
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Rural"))
        	{
        		cpwsSsTank.add("River");
        	}
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Dedicated"))
        	{
        		cpwsSsTank.add("Reserviors");
        	}
        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Others"))
        	{
        		cpwsSsTank.add("Others");
        	}
        	//cpwsSsTank.add(formatData(rs.getString("TANK_ADEQACY")));
        	//cpwsSsTank.add(formatData(rs.getString("OTHERS")));
        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
        	
     
        	cpwsReport.add(cpwsSsTank);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	  }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksSSFilterReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
		
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
					"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, " +
					"subCompTbl.FREQ_SAND_SCRAP,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.Location,subCompTbl.CHK_FILTER,ASSET_NAME ";
			
			finalQuery=finalQuery+query;
		    conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	
	      
		  Debug.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	Debug.println("1");
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	Debug.println("2");
	        	cpwsSsFilter.add(formatData(rs.getString("LOCATION")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
	        	Debug.println("3");
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	        	Debug.println("4");
	        	cpwsSsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
	        	Debug.println("5");
	        	//cpwsSsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	        	Debug.println("111111111:"+rs.getString("CHK_FILTER"));
	        	String chkfilter=rs.getString("CHK_FILTER");
	        	
	        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
				{
	        		Debug.println("22222222"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
				{
	        		Debug.println("3333"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
				{
	        		Debug.println("4444"+ rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	Debug.println("5:"+rs.getString("CHK_FILTER"));
	            cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;
	}
	
	
	//code added by sridhar  for Micro Filters
	public static ArrayList getAssetCpwsHeadWorksMicroFilterReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
		
		ArrayList cpwsReport=new ArrayList();      
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.WTPSC_CODE,subCompTbl.Location,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ," +
					"subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, " +
					"subCompTbl.SHELTER_EXISTING,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.CHK_FILTER,ASSET_NAME ";
			finalQuery=finalQuery+query;
		    conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	
	      
		  //Debug.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1"; 
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	         	 if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
	         	 {
	         	 	cpwsSsFilter.add("Y");
	         	 } 
	         	 else
	         	 {
	         	 	cpwsSsFilter.add("N");
	         	 }
	        	
	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
	        	//cpwsSsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	        	String chkfilter=rs.getString("CHK_FILTER");
	        	
	        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
				{
	        		Debug.println("22222222"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
				{
	        		Debug.println("3333"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
				{
	        		Debug.println("4444"+ rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	} 
	        	cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;
	}
	// code added by sridhar for RoPlants 
	public static ArrayList getAssetCpwsHeadWorksRoPlantsReport(DataSource dataSource, String query)throws Exception
	{
		Connection conn=null;
		
		ArrayList cpwsReport=new ArrayList();      
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.WTPSC_CODE ,subCompTbl.Location ,subCompTbl.WTP_MLD ," +
					"subCompTbl.UNITS_NO,subCompTbl.UNITS_STANDBY , subCompTbl.RATE_OF_FILTRATION," +
					"subCompTbl.RWS_TANK_EXISTING, subCompTbl.PWS_TANK_EXISTING,subCompTbl.SHELTER_EXISTING,ASSET_NAME ";
			finalQuery=finalQuery+query;
		    conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	
	      
		  //Debug.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	
	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
	        	//cpwsSsFilter.add(formatData(rs.getFloat("Capacity")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
	        	//cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	        	if(rs.getString("RWS_TANK_EXISTING")!=null && rs.getInt("RWS_TANK_EXISTING")==1)
	        	{
	        		cpwsSsFilter.add("Y");	
	        	}else
	        	{
	        		cpwsSsFilter.add("N");	
	        	}
	        	if(rs.getString("PWS_TANK_EXISTING")!=null && rs.getInt("PWS_TANK_EXISTING")==1)
	        	{
	        		cpwsSsFilter.add("Y");	
	        	}else
	        	{
	        		cpwsSsFilter.add("N");	
	        	}
	        	if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
	        	{
	        		cpwsSsFilter.add("Y");	
	        	}else
	        	{
	        		cpwsSsFilter.add("N");	
	        	}
	        	
	        	
	        	// cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	        	
	        	
	            cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;
	}
	
	public static ArrayList getAssetPwsHeadWorksSSFilterReport(DataSource dataSource, String query)throws Exception
	{
		//Debug.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsSsFilter;
		
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME ";
			finalQuery=finalQuery+query;
		     conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	
	      
		  //Debug.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsSsFilter=new ArrayList();
	            cpwsSsFilter.add(sno);
	        	try{rs3.next();
	            
	        	cpwsSsFilter.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsSsFilter.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsSsFilter.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsSsFilter.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
	        	Debug.println("1");
	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
	        	Debug.println("2");
	        	cpwsSsFilter.add(formatData(rs.getString("LOCATION")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
	        	Debug.println("3");
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
	        	Debug.println("4");
	        	cpwsSsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
	        	Debug.println("5");
	        	//cpwsSsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
	        	Debug.println("111111111:"+rs.getString("CHK_FILTER"));
	        	String chkfilter=rs.getString("CHK_FILTER");
	        	
	        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
				{
	        		Debug.println("22222222"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
				{
	        		Debug.println("3333"+rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
				{
	        		Debug.println("4444"+ rs.getString("CHK_FILTER"));
	        		cpwsSsFilter.add("Y");
				}
	        	else
	        	{
	        		cpwsSsFilter.add("N");
	        	}
	        	  cpwsReport.add(cpwsSsFilter);
	             int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		       
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksRSFilterReport(DataSource dataSource,String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME ";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	        Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		Debug.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	//Debug.println("1");
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	//Debug.println("2");
        	cpwsRsFilter.add(formatData(rs.getString("Location")));
        	//Debug.println("3");
        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
        	//Debug.println("4");
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	//Debug.println("5");
        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
        	//Debug.println("6");
        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
        	//Debug.println("7");
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
        	//Debug.println("8");
         	cpwsRsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
        	//cpwsRsFilter.add((rs.getString("PERFORMANCE")));
        	
        	//cpwsRsFilter.add((rs.getString("EXTENTION_SCOPE")));
        	if((rs.getString("CHK_FILTER")!=null) && (rs.getString("CHK_FILTER").substring(0,2)).equals("01"))
        	{
        		cpwsRsFilter.add("Y");
        	}
        	 else
        	{
        		cpwsRsFilter.add("N");
        	}
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	     
	}
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	// code added by sridhar for pws micro filters 
	public static ArrayList getAssetPwsHeadWorksMicroFilterReport(DataSource dataSource, String query)throws Exception
	{
	Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME ";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		Debug.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	cpwsRsFilter.add(formatData(rs.getString("Location")));
        	cpwsRsFilter.add(formatData(rs.getFloat("WTP_MLD")));
        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
         	 if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
         	 {
         	 	cpwsRsFilter.add("Y");
         	 } 
         	 else
         	 {
         	 	cpwsRsFilter.add("N");
         	 }
        	
        	cpwsRsFilter.add(formatData(rs.getString("PERFORMANCE")));
        	cpwsRsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
        	String chkfilter=rs.getString("CHK_FILTER");
        	
        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
			{
        		Debug.println("22222222"+rs.getString("CHK_FILTER"));
        		cpwsRsFilter.add("Y");
			}
        	else
        	{
        		cpwsRsFilter.add("N");
        	}
        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
			{
        		Debug.println("3333"+rs.getString("CHK_FILTER"));
        		cpwsRsFilter.add("Y");
			}
        	else
        	{
        		cpwsRsFilter.add("N");
        	}
        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
			{
        		Debug.println("4444"+ rs.getString("CHK_FILTER"));
        		cpwsRsFilter.add("Y");
			}
        	else
        	{
        		cpwsRsFilter.add("N");
        	}
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	     	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;  
	}
	// code end 
	
// code added by sridhar for pws Ro Plants 
	
	public static ArrayList getAssetPwsHeadWorksRoplantsReport(DataSource dataSource, String query)throws Exception
	{
	Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME ";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		Debug.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	cpwsRsFilter.add(formatData(rs.getString("Location")));
        	cpwsRsFilter.add(formatData(rs.getFloat("WTP_MLD")));
        	
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
        	
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
        	if(rs.getString("RWS_TANK_EXISTING")!=null && rs.getInt("RWS_TANK_EXISTING")==1)
        	{
        		cpwsRsFilter.add("Y");	
        	}else
        	{
        		cpwsRsFilter.add("N");	
        	}
        	if(rs.getString("PWS_TANK_EXISTING")!=null && rs.getInt("PWS_TANK_EXISTING")==1)
        	{
        		cpwsRsFilter.add("Y");	
        	}else
        	{
        		cpwsRsFilter.add("N");	
        	}
        	if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
        	{
        		cpwsRsFilter.add("Y");	
        	}else
        	{
        		cpwsRsFilter.add("N");	
        	}
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	     	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;  
	}

	
// code end 	
	public static ArrayList getAssetPwsHeadWorksRSFilterReport(DataSource dataSource, String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks rs filter  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsRsFilter;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME ";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WTPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsRsFilter=new ArrayList();
            cpwsRsFilter.add(sno);
        	try{rs3.next();
            
        	cpwsRsFilter.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsRsFilter.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsRsFilter.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsRsFilter.add("");
        		Debug.println("exception:"+e);}
        	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
        	Debug.println("1");
        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
        	Debug.println("2");
        	cpwsRsFilter.add(formatData(rs.getString("Location")));
        	Debug.println("3");
        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
        	Debug.println("4");
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
        	Debug.println("5");
        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
        	Debug.println("6");
        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
        	Debug.println("7");
        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
        	Debug.println("8");
         	cpwsRsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
        	//cpwsRsFilter.add((rs.getString("PERFORMANCE")));
        	
        	//cpwsRsFilter.add((rs.getString("EXTENTION_SCOPE")));
        	if((rs.getString("CHK_FILTER")!=null) && (rs.getString("CHK_FILTER").substring(0,2)).equals("01"))
        	{
        		cpwsRsFilter.add("Y");
        	}
        	 else
        	{
        		cpwsRsFilter.add("N");
        	}
            cpwsReport.add(cpwsRsFilter);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	     	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksSumpReport(DataSource dataSource, String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks Sump  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.SUMPCODE,subCompTbl.Location ,subCompTbl.SUMP_CAPACITY ," +
				" subCompTbl.SUMP_DEPTH,subCompTbl.SUMP_DIAMETER, DECODE(subCompTbl.SUMP_CONDITION,'G','GOOD','B','BAD')SUMP_CONDITION,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SUMPCODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SUMPCODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSump.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		Debug.println("exception:"+e);}
        
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
        	cpwsSump.add(formatData(rs.getString("LOCATION")));
        	cpwsSump.add(formatData(rs.getFloat("SUMP_DIAMETER")));
        	cpwsSump.add(formatData(rs.getFloat("SUMP_DEPTH")));
        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
        	
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 	}
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksSumpReport(DataSource dataSource, String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks Sump  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.*,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("SUMPCODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("SUMPCODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsSump.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		Debug.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
        	cpwsSump.add(formatData(rs.getString("LOCATION")));
        	cpwsSump.add(formatData(rs.getFloat("SUMP_DIAMETER")));
        	cpwsSump.add(formatData(rs.getFloat("SUMP_DEPTH")));
        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	  }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksFootPtahReport(DataSource dataSource ,String query)throws Exception
	{
     //Debug.println("getting data from CheckListMasterData for cpws headWorks foot path bride  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.BRIDGE_CODE,subCompTbl.BRIDGE_TYPE,subCompTbl.BRIDGE_LENGTH ," +
				"subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH," +
				"subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,subCompTbl.Location,ASSET_NAME ";
		finalQuery=finalQuery+query;
	    conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BRIDGE_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BRIDGE_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	
            }catch(Exception e){
            	cpwsSump.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	   cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		Debug.println("exception:"+e);}
            // commented by pranavi on 22-04-09
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
        	cpwsSump.add(formatData(rs.getString("LOCATION")));
        	//cpwsSump.add(formatData(rs.getString("BRIDGE_TYPE")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_LENGTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_WIDTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_WALK_WAY_WIDTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_SPAN_LENGTH")+""));
        	
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	    
	}
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksFootPtahReport(DataSource dataSource, String query)throws Exception
	{
     //Debug.println("getting data from CheckListMasterData for cpws headWorks foot path bride  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsSump;
	
	try
	{
		String finalQuery="select subCompTbl.BRIDGE_CODE,subCompTbl.LOCATION,subCompTbl.BRIDGE_LENGTH ," +
				"subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH," +
				"subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,ASSET_NAME ";
		finalQuery=finalQuery+query;
	      conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("BRIDGE_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("BRIDGE_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsSump=new ArrayList();
            cpwsSump.add(sno);
        	try{rs3.next();
            
        	cpwsSump.add(rs3.getString("PNAME"));
        	
            }catch(Exception e){
            	cpwsSump.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsSump.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsSump.add("");
        		Debug.println("exception:"+e);}
        	cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
        	cpwsSump.add(formatData(rs.getString("LOCATION")));
        	//commented by pranavi on 23-04-09
        	//cpwsSump.add(formatData(rs.getString("BRIDGE_TYPE")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_LENGTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_WIDTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_WALK_WAY_WIDTH")+""));
        	//cpwsSump.add(formatData(rs.getFloat("BRIDGE_SPAN_LENGTH")+""));
        	
            cpwsReport.add(cpwsSump);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksPumpHouseReport(DataSource dataSource,String query)throws Exception
	{Connection conn=null;
	 ArrayList cpwsReport=new ArrayList();
	ArrayList cpwspumpHouse;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ," +
				"subCompTbl.PUMPHOUSE_CODE,subCompTbl.Location,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwspumpHouse=new ArrayList();
            cpwspumpHouse.add(sno);
        	try{rs3.next();
            
        	cpwspumpHouse.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwspumpHouse.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwspumpHouse.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwspumpHouse.add("");
        		Debug.println("exception:"+e);}
        	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
        	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
        	cpwspumpHouse.add(formatData(rs.getString("Location")));
        	cpwspumpHouse.add(formatData(rs.getString("AREA")));
        	
        	//cpwspumpHouse.add(formatData(rs.getFloat("HEIGHT")));
        	
        	cpwsReport.add(cpwspumpHouse);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksPumpHouseReport(DataSource dataSource, String query)throws Exception
	{
	//Debug.println("getting data from CheckListMasterData for cpws headWorks pump House  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwspumpHouse;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ," +
				"subCompTbl.PUMPHOUSE_CODE,subCompTbl.Location,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwspumpHouse=new ArrayList();
            cpwspumpHouse.add(sno);
        	try{rs3.next();
            
        	cpwspumpHouse.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwspumpHouse.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwspumpHouse.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwspumpHouse.add("");
        		Debug.println("exception:"+e);}
        	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
        	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
        	//commented by pranavi on 23-04-09
        	cpwspumpHouse.add(formatData(rs.getString("Location")));
        	cpwspumpHouse.add(formatData(rs.getFloat("AREA")));
        	//cpwspumpHouse.add(formatData(rs.getFloat("HEIGHT")));
        	
        	cpwsReport.add(cpwspumpHouse);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	  }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksWatchmanReport(DataSource dataSource, String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks watch Man report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwswatch;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ," +
				"subCompTbl.WATCHMAN_CODE,subCompTbl.Location,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WATCHMAN_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WATCHMAN_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwswatch=new ArrayList();
            cpwswatch.add(sno);
        	try{rs3.next();
            
        	cpwswatch.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwswatch.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwswatch.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwswatch.add("");
        		Debug.println("exception:"+e);
        		}
         	//Debug.println("2");
        	cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
        	//Debug.println("3");
        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
        	cpwswatch.add(formatData(rs.getString("Location")));
        	//Debug.println("4");
        	//commented by pranavi on 22-04-09
        	//cpwswatch.add(formatData(rs.getString("TYPE")));
        	//Debug.println("5");
        	//cpwswatch.add(formatData(rs.getFloat("AREA")));
        	//Debug.println("6");
        	//cpwswatch.add(formatData(rs.getInt("NO_OF_QTRS"))+"");
         	//Debug.println("7");	
        	cpwsReport.add(cpwswatch);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat inadding to arrayllsit"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
	 }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksWatchmanReport(DataSource dataSource, String query)throws Exception
	{//Debug.println("getting data from CheckListMasterData for cpws headWorks watch Man report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwswatch;
	
	try
	{
		
		String finalQuery="select subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ," +
				"subCompTbl.WATCHMAN_CODE,subCompTbl.Location,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("WATCHMAN_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("WATCHMAN_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwswatch=new ArrayList();
            cpwswatch.add(sno);
        	try{rs3.next();
            
        	cpwswatch.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwswatch.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwswatch.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwswatch.add("");
        		Debug.println("exception:"+e);}
         	//Debug.println("2");
        	cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
        	//Debug.println("3");
        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
        	cpwswatch.add(formatData(rs.getString("LOCATION")));
        	//Debug.println("4");
        	//commented by pranavi on 23-04-09
        	//cpwswatch.add(formatData(rs.getString("TYPE")));
        	//Debug.println("5");
        	//cpwswatch.add(formatData(rs.getFloat("AREA")));
        	//Debug.println("6");
        	//cpwswatch.add(formatData(rs.getInt("NO_OF_QTRS"))+"");
         	//Debug.println("7");	
        	cpwsReport.add(cpwswatch);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat inadding to arrayllsit"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
    }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
		return  cpwsReport;
	}
	public static ArrayList getAssetCpwsHeadWorksCWCWellReport(DataSource dataSource,String query)throws Exception
	{
	//Debug.println("getting data from CheckListMasterData for cpws headWorks cwc well  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsCwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.CW_COLLWELL_CODE ,subCompTbl.DIAMETER,subCompTbl.DEPTH ," +
				" subCompTbl.LOCATION,subCompTbl.CAPACITY,ASSET_NAME";
		finalQuery=finalQuery+query;
	     conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsCwcWell=new ArrayList();
            cpwsCwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsCwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsCwcWell.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsCwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsCwcWell.add("");
        		Debug.println("exception:"+e);}
        	cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
        	cpwsCwcWell.add(formatData(rs.getString("LOCATION")));
        	cpwsCwcWell.add(formatData(rs.getFloat("CAPACITY")));
        	//cpwsCwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
        	
        	cpwsReport.add(cpwsCwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
     }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}		
		return  cpwsReport;
	}
	public static ArrayList getAssetPwsHeadWorksCWCWellReport(DataSource dataSource, String query)throws Exception
	{
	//Debug.println("getting data from CheckListMasterData for cpws headWorks cwc well  report");
		Connection conn=null;
	ArrayList cpwsReport=new ArrayList();
	ArrayList cpwsCwcWell;
	
	try
	{
		String finalQuery="select subCompTbl.CW_COLLWELL_CODE ,subCompTbl.LOCATION,subCompTbl.CAPACITY, " +
				"subCompTbl.TYPE_OF_FLOORING,ASSET_NAME";
		finalQuery=finalQuery+query;
	    conn = dataSource.getConnection();
    	Statement stmt = conn.createStatement();
    	
      
	  //Debug.println(finalQuery);
	        ResultSet rs=stmt.executeQuery(finalQuery);
	        //Debug.println(finalQuery);
	        try{String sno="1";
        while(rs.next())
        {
        	Statement stmt2 = conn.createStatement();
    	    Statement   stmt3 = conn.createStatement();
            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("CW_COLLWELL_CODE")+"',1,16)=substr(panch_code,1,16)");
           
            cpwsCwcWell=new ArrayList();
            cpwsCwcWell.add(sno);
        	try{rs3.next();
            
        	cpwsCwcWell.add(rs3.getString("PNAME"));
        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
            }catch(Exception e){
            	cpwsCwcWell.add("");
            	Debug.println("Exception"+e);
            	}
        	try{rs4.next();
        	cpwsCwcWell.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e){
        		cpwsCwcWell.add("");
        		Debug.println("exception:"+e);}
        	cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
        	cpwsCwcWell.add(formatData(rs.getString("LOCATION")));
        	cpwsCwcWell.add(formatData(rs.getFloat("CAPACITY")));
        	//commented by pranavi on 23-04-09
        	//cpwsCwcWell.add(formatData(rs.getString("TYPE_OF_FLOORING")));
        	cpwsReport.add(cpwsCwcWell);
             int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
        	
         }
	    }
	        catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
     }
	 catch(Exception e)
	 {
	 	Debug.println("error in getig dat in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	cpwsReport.add(ExceptionReport);
	 	return 	cpwsReport;
	 }
	 finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}		
		return  cpwsReport;
	}
    public static ArrayList getAssetCpwsPumpDetailsReport(DataSource dataSource ,String query)throws Exception
    {
    	//Debug.println("getting data from CheckListMasterData for cpws pumpset pumpDetails  report");
    	Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
	 String finalQuery="select  subCompTbl.PUMPDET_CODE," +
	"subCompTbl.PUMPCODE,subCompTbl.HP,subCompTbl.TYPE,subCompTbl.DUTY_CON," +
	"subCompTbl.HEAD_MTS,subCompTbl.DISCHARGE_LPM,subCompTbl.STANDBY_HP," +
	"subCompTbl.YEARS_USED,subCompTbl.FAILURE_FREQ,subCompTbl.AVG_HR_PUMPING_DAY," +
	"subCompTbl.REPAIR_COST_YEAR,DECODE(subCompTbl.CAPASITOR,'Y','YES','N','NO')CAPASITOR," +
	"DECODE(subCompTbl.CONTROL_PANEL,'Y','YES','N','NO')CONTROL_PANEL," +
	"subCompTbl.POWER_HOURS,subCompTbl.WORK_HRS,subCompTbl.QTY_WATER_CUM,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
		    conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		   //Debug.println(finalQuery);
		        ResultSet rs=stmt.executeQuery(finalQuery);
		        //Debug.println(finalQuery);
		        try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("PUMPDET_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("PUMPDET_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
	            }catch(Exception e){
	            	cpwsGlsr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("PUMPDET_CODE")));
	        	cpwsGlsr.add(formatData(rs.getString("PUMPCODE")));
	        	cpwsGlsr.add(formatData(rs.getInt("HP"))+"");
	            cpwsGlsr.add(formatData(rs.getString("TYPE"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("DUTY_CON"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("HEAD_MTS"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("DISCHARGE_LPM")));
	        	cpwsGlsr.add(formatData(rs.getInt("STANDBY_HP"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("YEARS_USED"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("FAILURE_FREQ")));
	        	cpwsGlsr.add(formatData(rs.getFloat("AVG_HR_PUMPING_DAY")));
	        	cpwsGlsr.add(formatData(rs.getFloat("REPAIR_COST_YEAR")));
	        	cpwsGlsr.add(formatData(rs.getString("CAPASITOR"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("CONTROL_PANEL")));	
	        	cpwsGlsr.add(formatData(rs.getInt("POWER_HOURS"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("WORK_HRS"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("QTY_WATER_CUM")));
	        	
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	  	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}			
			return  cpwsReport;

    }
    public static ArrayList getDistrictcts(DataSource dataSource,String query)throws Exception
    {
    	Connection conn=null;
    	rws_asset_cpws_DrillDownBean cpwsGrill; 
		ArrayList cpwsReport=new ArrayList();
		int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		    
		        ResultSet rs=stmt.executeQuery(query);
		        
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("DNAME"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	cpwsGrill.setDCode(rs.getString("DCODE"));
	        	tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 }
		        
		        cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	 
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
	        	
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;	
    }	
    // code added by sridhar for get divisons for MPWS
    public static ArrayList getDivisions(DataSource dataSource,String query)throws Exception
    {
    	Connection conn=null;
    	rws_asset_cpws_DrillDownBean cpwsGrill; 
		ArrayList cpwsReport=new ArrayList();
		int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		    
		        ResultSet rs=stmt.executeQuery(query);
		        
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("division_office_name"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	cpwsGrill.setDivCode(rs.getString("division_office_code"));
	        	tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getting Divison method in CheckListMasterData"+e);
				 }
		        
		        cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	 
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
	        	
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig division method in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;	
    }	
    
    // code added by sridhar for subdiv wise report for MPWS
    
    
    public static ArrayList getSubdivisions(DataSource dataSource,String query)throws Exception
    {
    	Connection conn=null;
    	rws_asset_cpws_DrillDownBean cpwsGrill; 
		ArrayList cpwsReport=new ArrayList();
		int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		    
		        ResultSet rs=stmt.executeQuery(query);
		        
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("subdivision_office_name"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	cpwsGrill.setSubdivCode(rs.getString("subdivision_office_code"));
	        	tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getting Subdivison method in CheckListMasterData"+e);
				 }
		        
		        cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	 
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
	        	
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig subdivision method in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}		
			return  cpwsReport;	
    }	
    
    
    // code end 
    public static ArrayList getMandalsForCpws(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)throws Exception
         {
    	        Connection conn=null;
          	    rws_asset_cpws_DrillDownBean cpwsGrill=null; 
		        ArrayList cpwsReport=new ArrayList();
    	     
		        String query="";
		        String q1="";
		        if(subcompCode.equals("OANDMCODE"))
		        {
		        q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
    			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
    			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
    			" and substr(a.hab_code,1,2) = man.dcode " +
    			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
    			" and d.dcode=man.dcode  and a.type_of_asset_code='03'" +
    			"and man.dcode='"+Dcode+"'";
		        }
		        else
		        {
		        	 q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
		    			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
		    			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
		    			" and substr(a.hab_code,1,2) = man.dcode " +
		    			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
		    			" and d.dcode=man.dcode  and substr(subCompTbl."+subcompCode+",17,3) like '8%' and a.type_of_asset_code='03'" +
		    			"and man.dcode='"+Dcode+"'";	
		        }
		        
		        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
		        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
    	        String q3= " group by dname,man.MNAME,man.mcode order by man.MNAME";
    	        if(!(Div.equals("")))
    	        {  
    	        	 
    	        	query=q1+q2;
    	        	 if(!(subDiv.equals("")))
    	        	 {
    	        	 query=query+q4;	
    	        	 }
    	        }  query=query+q3;
    	        if((Div.equals("")))
    	        {
    	          query=q1+q3;
    	        }
    	        int tot=0;
    			try
    			{    
    			     conn = dataSource.getConnection();
    		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    			    
    			        ResultSet rs=stmt.executeQuery(query);
    			         
    			        try{String sno="1";
    		        while(rs.next())
    		         {     
    		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
    		        	cpwsGrill.setSno(sno);
    		        	cpwsGrill.setName(rs.getString("Mandal"));
    		        	cpwsGrill.setMCode(rs.getString("mcode"));
    		        	cpwsGrill.setTotal(rs.getString("COUNT"));
    		            tot=tot+Integer.parseInt(rs.getString("count"));
    		            
        		       
    		            cpwsReport.add(cpwsGrill);
    		            int no=Integer.parseInt(sno);
    		        	no++;
    		            sno=""+no;
    		        	
    		         }
    		        
    		        
    			    }
    			        catch(Exception e)
    					 {
    					 	Debug.println("error in getig dat in CheckListMasterData"+e);
    					 	java.util.Vector ExceptionReport =new java.util.Vector();
    					 	ExceptionReport.add(e);
    					 	cpwsReport.add(ExceptionReport);
    					 	return 	cpwsReport;
    					 }
    			     
    			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
        		        	cpwsGrill.setSno("**");
        		        	cpwsGrill.setName("Total");
        		        	cpwsGrill.setTotal(Integer.toString(tot));
        		        	cpwsReport.add(cpwsGrill);
        		        	        		        
    			         
    			}
    			
    			 catch(Exception e)
    			 {
    			 	Debug.println("error in getig dat in CheckListMasterData"+e);
    			 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
    			 }
    			 finally {
    		    	try {
    		    		if (conn != null)
    		    		{
    		    	 		conn.close();
    		    		}
    		    	} catch (SQLException e) {
    		    		Debug.println("Exception "+e);
    		    	}}	
    				
    				return  cpwsReport;	

     }
    public static ArrayList getMandalsForALLSurce(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv,String asetCode
    		,String scheme,String sourcetyp)throws Exception
    {
    	    Connection conn=null;
     	    rws_asset_cpws_DrillDownBean cpwsGrill=null; 
	        ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode  and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"' and a.type_of_asset_code='"+asetCode+"'" +
			"and  subCompTbl.SOURCE_TYPE_CODE='"+sourcetyp+"' and man.dcode='"+Dcode+"'";
	        
	        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	        String q3= " group by dname,man.MNAME,man.mcode order by man.MNAME";
	        if(!(Div.equals("")))
	        {  
	        	 
	        	query=q1+q2;
	        	 if(!(subDiv.equals("")))
	        	 {
	        	 query=query+q4;	
	        	 }
	        }  query=query+q3;
	        if((Div.equals("")))
	        {
	          query=q1+q3;
	        }
	        int tot=0;
			try
			{    
			    conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			    
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("mcode"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			         
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
    // code added by sridhar for div report for open wells 
    
  public static  ArrayList getDivisionQueryForOpenWells(DataSource dataSource,String tabName,String Dcode,String subcompCode,String scheme)throws Exception
{     
	   Connection conn=null;
	   rws_asset_cpws_DrillDownBean cpwsGrill=null; 
	   ArrayList cpwsReport=new ArrayList();
  
     String query="";
     String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,";
 	String q2=tabName;
 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+Dcode+"'and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"'"+
		" group by d.division_office_name,d.division_office_code order by d.division_office_name";
     query=q1+q2+q3;
 	int tot=0;
		try
		{    
		   conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		   Debug.println("query is "+query); 
		        ResultSet rs=stmt.executeQuery(query);
		         
		        try{String sno="1";
	        while(rs.next())
	         {     
	        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("division_office_name"));
	        	cpwsGrill.setDivCode(rs.getString("division_office_code"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	            tot=tot+Integer.parseInt(rs.getString("count"));
	            
	       
	            cpwsReport.add(cpwsGrill);
	            int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
	        
	        
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		     
		            cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno("**");
	        	cpwsGrill.setName("Total");
	        	cpwsGrill.setTotal(Integer.toString(tot));
	        	cpwsReport.add(cpwsGrill);
	        	        		        
		        
		}
		
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
			
			return  cpwsReport;	

}
    
   
    // code added by sridhar for div report for hand pumps 
    public static  ArrayList getDivisionQueryForHp(DataSource dataSource,String tabName,String Dcode,String subcompCode)throws Exception
    {     
    	   Connection conn=null;
     	   rws_asset_cpws_DrillDownBean cpwsGrill=null; 
     	   ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+Dcode+"'and substr(subCompTbl."+subcompCode+",17,3) like '0%'"+
			" group by d.division_office_name,d.division_office_code order by d.division_office_name";
	        query=q1+q2+q3;
	    	int tot=0;
			try
			{    
			   conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			   Debug.println("query is "+query); 
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("division_office_name"));
		        	cpwsGrill.setDivCode(rs.getString("division_office_code"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
 // code for sub division report for hand pumps 
    
    
    public static  ArrayList getSubdivisionQueryForHp(DataSource dataSource,String tabName,String Dcode,String divi,String subcompCode)throws Exception
    {     
    	   Connection conn=null;
     	   rws_asset_cpws_DrillDownBean cpwsGrill=null; 
     	   ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+Dcode+"'and substr(subCompTbl."+subcompCode+",17,3) like '0%'"+
			" and d.division_office_code='"+divi+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;
	    	int tot=0;
			try
			{    
			   conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			   Debug.println("query is "+query); 
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("subdivision_office_name"));
		        	cpwsGrill.setSubdivCode(rs.getString("subdivision_office_code"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
    
    
   
    // code  for sub div report for open wells 
    
    public static  ArrayList getSubdivisionQueryForOpenWells(DataSource dataSource,String tabName,String Dcode,String divi,String subcompCode,String scheme)throws Exception
    {     
    	   Connection conn=null;
     	   rws_asset_cpws_DrillDownBean cpwsGrill=null; 
     	   ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+Dcode+"'and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"'"+
			" and d.division_office_code='"+divi+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;
	    	int tot=0;
			try
			{    
			   conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			   Debug.println("query is "+query); 
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("subdivision_office_name"));
		        	cpwsGrill.setSubdivCode(rs.getString("subdivision_office_code"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
  
   // code end  
    public static  ArrayList getMandalsForHandPumps(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)throws Exception
    {    
    	   Connection conn=null;
     	   rws_asset_cpws_DrillDownBean cpwsGrill=null; 
     	   ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode  and (substr(subCompTbl."+subcompCode+",17,3) like '0%' or substr(subCompTbl."+subcompCode+",17,3) like '1%' or substr(subCompTbl."+subcompCode+",17,3) like '2%') " +
			"and man.dcode='"+Dcode+"'";
	        
	        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	        String q3= " group by dname,man.MNAME,man.mcode order by man.MNAME";
	        if(!(Div.equals("")))
	        {  
	        	 
	        	query=q1+q2;
	        	 if(!(subDiv.equals("")))
	        	 {
	        	 query=query+q4;	
	        	 }
	        }  query=query+q3;
	        if((Div.equals("")))
	        {
	          query=q1+q3;
	        }
	        int tot=0;
			try
			{    
			   conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			   Debug.println("query is###: "+query); 
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("mcode"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
    public static  ArrayList getMandalsForShallow_openwels_ponds(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv,String scheme)throws Exception
    {       Connection conn=null;
     	    rws_asset_cpws_DrillDownBean cpwsGrill=null; 
     	   ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode  and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"' " +
			"and man.dcode='"+Dcode+"'";
	        
	        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	        String q3= " group by dname,man.MNAME,man.mcode order by man.MNAME";
	        if(!(Div.equals("")))
	        {  
	        	 
	        	query=q1+q2;
	        	 if(!(subDiv.equals("")))
	        	 {
	        	 query=query+q4;	
	        	 }
	        }  query=query+q3;
	        if((Div.equals("")))
	        {
	          query=q1+q3;
	        }
	        int tot=0;
			try
			{    
			     conn = dataSource.getConnection();
		      Statement  stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			    
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("mcode"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}
    public static ArrayList getMandalsForMpws(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)throws Exception
    {      
    	    Connection conn=null;
     	    rws_asset_cpws_DrillDownBean cpwsGrill=null; 
	        ArrayList cpwsReport=new ArrayList();
	     
	        String query="";
	        String q1="";
	        if(subcompCode.equals("OANDMCODE"))
	        {
			q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode  and a.type_of_asset_code='02' " +
			"and man.dcode='"+Dcode+"'";
	        }
	        else
	        {
	        	q1="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
				"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
				"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
				" and substr(a.hab_code,1,2) = man.dcode " +
				"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
				" and d.dcode=man.dcode  and substr(subCompTbl."+subcompCode+",17,3) like '4%' and a.type_of_asset_code='02' " +
				"and man.dcode='"+Dcode+"'";
	        }
	        String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	        String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	        String q3= " group by dname,man.MNAME,man.mcode order by man.MNAME";
	        if(!(Div.equals("")))
	        {  
	        	 
	        	query=q1+q2;
	        	 if(!(subDiv.equals("")))
	        	 {
	        	 query=query+q4;	
	        	 }
	        }  query=query+q3;
	        if((Div.equals("")))
	        {
	          query=q1+q3;
	        }
	        int tot=0;
			try
			{    
			     conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			    
			        ResultSet rs=stmt.executeQuery(query);
			         
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("mcode"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
   		       
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
   		        	cpwsGrill.setSno("**");
   		        	cpwsGrill.setName("Total");
   		        	cpwsGrill.setTotal(Integer.toString(tot));
   		        	cpwsReport.add(cpwsGrill);
   		        	        		        
			        
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally {
		    	try {
		    		if (conn != null)
		    		{
		    	 		conn.close();
		    		}
		    	} catch (SQLException e) {
		    		Debug.println("Exception "+e);
		    	}}	
				
				return  cpwsReport;	

}

    public static String  getDName(DataSource dataSource,String Dcode)throws Exception
     {
    	 Connection conn=null; 
      	  String dcode="";
      	try
      
  		{
      	     conn = dataSource.getConnection();
  	       Statement stmt = conn.createStatement();
  	       ResultSet  res=stmt.executeQuery("select dname from rws_district_tbl where dcode='"+Dcode+"'");
  	       		
  	       res.next();
  	       dcode=res.getString(1);
  	        
  	    }
      	catch(Exception e)
  		{ 
      		Debug.println("Exception in geting data fro dname"+e);
  		}
      	finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
      	return dcode;
       }
    // code added by sridhar for to get division code and name 
    
    public static String  getDivName(DataSource dataSource,String Dcode,String Divcode)throws Exception
    {
   	 Connection conn=null; 
     	  String divcode="";
     	try
     
 		{
     	     conn = dataSource.getConnection();
 	       Statement stmt = conn.createStatement();
 	       ResultSet  res=stmt.executeQuery("select division_office_name from rws_division_office_tbl where circle_office_code='"+Dcode+"' and division_office_code='"+Divcode+"'");
 	       		
 	       res.next();
 	       divcode=res.getString(1);
 	        
 	    }
     	catch(Exception e)
 		{ 
     		Debug.println("Exception in geting data fro divsion name"+e);
 		}
     	finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
     	return divcode;
      }
    
    
    // code end 
    public static String  getDcode(DataSource dataSource,String District)throws Exception
        {
    	 Connection conn=null; 
    	  String dcode="";
    	try
    
		{
    	    conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
	       ResultSet  res=stmt.executeQuery("select dcode from rws_district_tbl where trim(dname)='"+District+"'");
	       		
	       res.next();
	       dcode=res.getString(1);
	        
	    }
    	catch(Exception e)
		{ 
    		Debug.println("Exception in geting data fro dcode"+e);
		}
    	finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
    	return dcode;
     }
    public static String  getMcode(DataSource dataSource,String Mandal,String dcode)throws Exception
        {
          Connection conn=null; 
    	  String mcode="";
    	try
    
		{
    		 String query="select mcode from rws_mandal_tbl where mcode='"+Mandal+"' And DCODE='"+dcode+"'";
    	     conn = dataSource.getConnection();
	         Statement stmt = conn.createStatement();
	         ResultSet  res=stmt.executeQuery(query);
	         res.next();
	         mcode=res.getString(1);
	        
	    }
    	catch(Exception e)
		{ 
    		Debug.println("Exception in getting data from check list master for mcode "+e);
     	}
    	finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
     	return mcode;
     }
    public static String  getMname(DataSource dataSource,String Mandal,String dcode)throws Exception
        {
    	Connection conn=null; 
       	  String mcode="";
    	  try
          {
    		String query="select mname from rws_mandal_tbl where mcode='"+Mandal+"' And DCODE='"+dcode+"' order by Mname";
    	     Debug.println("QUEry "+query);
    	     conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
	       ResultSet  res=stmt.executeQuery(query);
	       		
	       res.next();
	       mcode=res.getString(1);
	        
	    }
    	catch(Exception e)
		{ 
    		Debug.println("Exception in getting data from check list master for mcode "+e);
    		
		}
    	finally {
	    	try {
	    		if (conn != null)
	    		{
	    	 		conn.close();
	    		}
	    	} catch (SQLException e) {
	    		Debug.println("Exception "+e);
	    	}}	
    	return mcode;
     }
   
    public static String getCount(DataSource dataSource,String query )throws Exception
    {
	Connection conn=null; 
   	  String count="";
	  try
      {
	   Debug.println("QUEry "+query);
	   conn = dataSource.getConnection();
       Statement stmt = conn.createStatement();
       ResultSet  res=stmt.executeQuery(query);
       		
       res.next();
       count=res.getString(1);
        
    }
	catch(Exception e)
	{ 
		Debug.println("Exception in getting data from check list master for mcode "+e);
		
	}
	finally {
    	try {
    		if (conn != null)
    		{
    	 		conn.close();
    		}
    	} catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}}	
	return count;
 }
    // code modified by sridhar
    public static   ArrayList getAssetHandpumpsBorewellReport(DataSource dataSource, String query,String first)throws SQLException
	{
	  
	ArrayList Borewells1=new ArrayList();
	ArrayList Borewells2=new ArrayList();
	ArrayList Borewells=new ArrayList();
	ArrayList Borewells3=new ArrayList();
	ResultSet rs2=null;
	ResultSet rs3=null;
	ResultSet  rs4=null;
	Connection conn=null;
	try
	{
    	ArrayList hpReport;
		ArrayList hpReport1;
		int pagesize=10;
		if(first.equals("")||first==null||first.equals("0"))
		{
			first="0";
			//System.out.println("first"+first);
		}
		int temp1=Integer.parseInt(first);
		temp1=(temp1)*pagesize+1;
		first=Integer.toString(temp1);
		int temp2=temp1+pagesize-1;
		
		String last=Integer.toString(temp2);
	 	String finalQuery="select * from (select a.*,rownum r from(select subCompTbl.*,decode(subCompTbl.PAINTED ,'Y','YES','N','NO')paint," +
				          "decode(subCompTbl.PLATFORM_CONDITION ,'G','GOOD','B','BAD','','-')pcond, ASSET_NAME";
        //finalQuery=finalQuery+query+")a)where r BETWEEN "+first+" AND "+last;
	 	finalQuery=finalQuery+query+")a)";
        Debug.println("Handpums qury is"+finalQuery);
        
	     conn =dataSource.getConnection();
	     Debug.println("Connection reference:::::::"+conn);
         PreparedStatement psmt1=conn.prepareStatement(finalQuery,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs2=psmt1.executeQuery();
	     try
		   {
	       	String sno=first;
            while(rs2.next())
            {
            	String qq = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and panch_code=substr(?,1,16) order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
	            PreparedStatement psmt2=conn.prepareStatement(qq);
	            psmt2.setString(1,(String)rs2.getString("HP_CODE"));
                rs3=psmt2.executeQuery();
                hpReport1=new ArrayList();
                hpReport1.add(sno);
	            try
				{
	            	rs3.next();
	            	hpReport1.add(rs3.getString("PNAME"));
	            	hpReport1.add(rs3.getString("panch_name"));
				}
	            catch(Exception e)
				{
	            	hpReport1.add("");
	            	hpReport1.add("");
	            	Debug.println("Exception"+e);
            	}
                
                hpReport1.add(formatData(rs2.getString("ASSET_NAME")));
        	    hpReport1.add(formatData(rs2.getString("HP_CODE")));
        	    hpReport1.add(formatData(rs2.getString("LOCATION")));
        	    hpReport1.add(formatData(rs2.getFloat("DIAMETER")));
        	    hpReport1.add(formatData(rs2.getFloat("DEPTH")));
        	    hpReport1.add(formatData(rs2.getString("CASING"))); 
        	    hpReport1.add(formatData(rs2.getInt("GI_NO")));
        	    hpReport1.add(formatData(rs2.getInt("PIPE_LENGTH")));
        	    hpReport1.add(formatData(rs2.getString("GEN_CONDITION"))); 
        	    hpReport1.add(formatData(rs2.getFloat("STATIC_WL"))); 
        	    hpReport1.add(formatData(rs2.getFloat("SUMMER_WL"))); 
        	    hpReport1.add(formatData(rs2.getFloat("SER_HRS"))); 
        	    hpReport1.add(formatData(rs2.getInt("SER_NO"))); 
            	hpReport1.add(formatData(rs2.getString("PAINTED"))); 
            	hpReport1.add(formatData(rs2.getString("REPAIRS")));
            	hpReport1.add(formatData(rs2.getString("PLATFORM_EXISTING")));
            	hpReport1.add(formatData(rs2.getString("PLATFORM_CONDITION"))); 
            	hpReport1.add(formatData(rs2.getString("DRAIN"))); 
            	hpReport1.add(formatData(rs2.getString("DRAIN_CONDITION"))); 
            	hpReport1.add(formatData(rs2.getString("DRAIN_SD"))); 
            	hpReport1.add(formatData(rs2.getString("DRAIN_LP"))); 
            	hpReport1.add(formatData(rs2.getString("HYGIENE"))); 
            	hpReport1.add(formatData(rs2.getString("PYEILD_LOCAL"))); 
            	hpReport1.add(formatData(rs2.getInt("P_YEILD"))); 
            	hpReport1.add(formatData(rs2.getString("QUALITY_AFFECTED")));
            	Borewells3.add(hpReport1);
            	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
           }
            Borewells.add( Borewells1);
            Borewells.add( Borewells2);
            Borewells.add( Borewells3);
	    }
	        catch(Exception e)
			 {
	        	Debug.println("error in adding data  to arraylist  in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	Borewells.add(ExceptionReport);
			 	return 	Borewells;
			 }
	 }
	 catch(SQLException e)
	 {
	  	Debug.println("error in retriving data  in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	Borewells.add(ExceptionReport);
	 	return 	Borewells;
	 }
	 finally 
	 {
    	try {
        		if (conn != null)
        		{
       			conn.close();
        		}
    	   } 
    	catch (SQLException e) {
    		Debug.println("Exception "+e);
    	}
      }
			return  Borewells;
 	}
    public static   ArrayList getAssetShallowHandPumpsReport(DataSource dataSource, String query,String first)throws SQLException
	{
	ArrayList shallowPumps=new ArrayList();
	ResultSet rs2=null;
	ResultSet rs3=null;
	ResultSet  rs4=null;
	Connection conn=null;
	try
	{
    	ArrayList hpReport;
		ArrayList hpReport1;
		int pagesize=10;
		if(first.equals("")||first==null||first.equals("0"))
		{
			first="0";
		}
		int temp1=Integer.parseInt(first);
		temp1=(temp1)*pagesize+1;
		first=Integer.toString(temp1);
		int temp2=temp1+pagesize-1;
		String last=Integer.toString(temp2);
	 	String finalQuery="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME";
        //finalQuery=finalQuery+query+")a)where r BETWEEN "+first+" AND "+last;
	 	finalQuery=finalQuery+query+")a)";
        Debug.println("Handpums qury is"+finalQuery);
        conn =dataSource.getConnection();
	     Debug.println("COnnection reference:::::::"+conn);
         PreparedStatement psmt1=conn.prepareStatement(finalQuery,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs2=psmt1.executeQuery();
	     try
		   {
	       	String sno=first;
            while(rs2.next())
            {
            PreparedStatement psmt2=conn.prepareStatement("select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
            psmt2.setString(1,(String)rs2.getString("SHALLOWHP_CODE"));
            psmt3.setString(1,(String)rs2.getString("SHALLOWHP_CODE"));
            rs3=psmt2.executeQuery();
            rs4=psmt3.executeQuery();
            hpReport=new ArrayList();
              hpReport.add(sno);
              try{
            	rs3.next();
             	hpReport.add(rs3.getString("PNAME"));
             }catch(Exception e){
            	hpReport.add("");
            	Debug.println("Exception"+e);
            
            	}
        	try{rs4.next();
        	hpReport.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e)
			    {
        		hpReport.add("");
        		Debug.println("exception:"+e);
        		}   hpReport.add(formatData(rs2.getString("ASSET_NAME")));
	        	    hpReport.add(formatData(rs2.getString("SHALLOWHP_CODE")));
	        	    hpReport.add(formatData(rs2.getString("LOCATION")));
	        	    hpReport.add(formatData(rs2.getFloat("DIAMETER")));
	        	    hpReport.add(formatData(rs2.getFloat("DEPTH")));
	        	    hpReport.add(formatData(rs2.getString("HYGIENE"))); 
	        	    hpReport.add(formatData(rs2.getFloat("AVERAGE_HOURS"))); 
	        	    //hpReport.add(formatData(rs2.getFloat("AVERAGE_TIME"))); 
	        	    hpReport.add(formatData(rs2.getFloat("YIELD"))); 
	        	    hpReport.add(formatData(rs2.getString("WATER_QUALITY"))); 
	        	    shallowPumps.add(hpReport);
         	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
  	    }
	        catch(Exception e)
			 {
	        	Debug.println("error in adding data  to arraylist  in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	shallowPumps.add(ExceptionReport);
			 	return 	shallowPumps;
			 }
	 }
	 catch(SQLException e)
	 {
	  	Debug.println("error in retriving data  in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	shallowPumps.add(ExceptionReport);
	 	return 	shallowPumps;
	 }
	 finally 
	 {
    	try {
	    		if (conn != null)
	    		{
	     			conn.close();
	    		}
    	    } 
    	catch (SQLException e) 
		{
    		Debug.println("Exception "+e);
    	}
      }
	    
        
		return  shallowPumps;

	}
    public static   ArrayList getAssetOpenWellsReport(DataSource dataSource, String query,String first)throws SQLException
	{
	 
	ArrayList shallowPumps=new ArrayList();
	 
	ResultSet rs2=null;
	ResultSet rs3=null;
	ResultSet  rs4=null;
	Connection conn=null;
	try
	{
    	ArrayList hpReport;
		ArrayList hpReport1;
		int pagesize=10;
		if(first.equals("")||first==null||first.equals("0"))
		{
			first="0";
		}
		int temp1=Integer.parseInt(first);
		temp1=(temp1)*pagesize+1;
		first=Integer.toString(temp1);
		int temp2=temp1+pagesize-1;
		
		String last=Integer.toString(temp2);
	 	String finalQuery="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME";
        //finalQuery=finalQuery+query+")a)where r BETWEEN "+first+" AND "+last;
	 	finalQuery=finalQuery+query+")a)";
        Debug.println("Handpums qury is"+finalQuery);
         
	       conn =dataSource.getConnection();
	      Debug.println("COnnection reference:::::::"+conn);
         PreparedStatement psmt1=conn.prepareStatement(finalQuery,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs2=psmt1.executeQuery();
	     
	     try
		   {
	       	String sno=first;
            while(rs2.next())
            {
            PreparedStatement psmt2=conn.prepareStatement("select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
            psmt2.setString(1,(String)rs2.getString("OPENWELL_CODE"));
            psmt3.setString(1,(String)rs2.getString("OPENWELL_CODE"));
                rs3=psmt2.executeQuery();
                rs4=psmt3.executeQuery();
            hpReport=new ArrayList();
              hpReport.add(sno);
              try{
            	rs3.next();
            
            	hpReport.add(rs3.getString("PNAME"));
        	 
            }catch(Exception e){
            	hpReport.add("");
            	Debug.println("Exception"+e);
            
            	}
        	try{rs4.next();
        	hpReport.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e)
			    {
        		hpReport.add("");
        		Debug.println("exception:"+e);
        		}   hpReport.add(formatData(rs2.getString("ASSET_NAME")));
	        	    hpReport.add(formatData(rs2.getString("OPENWELL_CODE")));
	        	    hpReport.add(formatData(rs2.getString("LOCATION")));
	        	    hpReport.add(formatData(rs2.getFloat("DIAMETER")));
	        	    hpReport.add(formatData(rs2.getFloat("DEPTH")));
	        	    hpReport.add(formatData(rs2.getFloat("NORMAL_WATER_LEVEL"))); 
	        	    hpReport.add(formatData(rs2.getFloat("MIN_WATER_LEVEL"))); 
	        	    hpReport.add(formatData(rs2.getFloat("MAX_WATER_LEVEL"))); 
	        	    hpReport.add(formatData(rs2.getString("PLATFORM_EXISTS"))); 
	        	    hpReport.add(formatData(rs2.getString("PURPOSE")));
	        	    hpReport.add(formatData(rs2.getString("QUALITY"))); 
	        	    shallowPumps.add(hpReport);
               
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
  	    }
	        catch(Exception e)
			 {
	        	Debug.println("error in adding data  to arraylist  in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	shallowPumps.add(ExceptionReport);
			 	return 	shallowPumps;
			 }
	 }
	 catch(SQLException e)
	 {
	  	Debug.println("error in retriving data  in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	shallowPumps.add(ExceptionReport);
	 	return 	shallowPumps;
	 }
	 finally 
	 {
    	try {
	    		if (conn != null)
	    		{
	     			conn.close();
	    		}
    	    } 
    	catch (SQLException e) 
		{
    		Debug.println("Exception "+e);
    	}
      }
	    
        
		return  shallowPumps;

	}
    public static   ArrayList getAssetPondsReport(DataSource dataSource, String query,String first)throws SQLException
	{
	 
	ArrayList shallowPumps=new ArrayList();
	 
	ResultSet rs2=null;
	ResultSet rs3=null;
	ResultSet  rs4=null;
	Connection conn=null;
	try
	{
    	ArrayList hpReport;
		ArrayList hpReport1;
		int pagesize=10;
		if(first.equals("")||first==null||first.equals("0"))
		{
			first="0";
		}
		int temp1=Integer.parseInt(first);
		temp1=(temp1)*pagesize+1;
		first=Integer.toString(temp1);
		int temp2=temp1+pagesize-1;
		
		String last=Integer.toString(temp2);
	 	String finalQuery="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME";
        //finalQuery=finalQuery+query+")a)where r BETWEEN "+first+" AND "+last;
    	finalQuery=finalQuery+query+")a)";
        Debug.println("Handpums qury is"+finalQuery);
         
	       conn =dataSource.getConnection();
	      Debug.println("COnnection reference:::::::"+conn);
         PreparedStatement psmt1=conn.prepareStatement(finalQuery,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs2=psmt1.executeQuery();
	     
	     try
		   {
	       	String sno=first;
            while(rs2.next())
            {
            PreparedStatement psmt2=conn.prepareStatement("select pname from rws_panchayat_name_view where substr(?,1,16)=substr(panch_code,1,16)");
            PreparedStatement psmt3=conn.prepareStatement("select PANCH_NAME  from rws_panchayat_raj_tbl where panch_code=substr(?,1,16)");
            psmt2.setString(1,(String)rs2.getString("POND_CODE"));
            psmt3.setString(1,(String)rs2.getString("POND_CODE"));
                rs3=psmt2.executeQuery();
               rs4=psmt3.executeQuery();
            hpReport=new ArrayList();
              hpReport.add(sno);
              try{
            	rs3.next();
            
            	hpReport.add(rs3.getString("PNAME"));
        	 
            }catch(Exception e){
            	hpReport.add("");
            	Debug.println("Exception"+e);
            
            	}
        	try{rs4.next();
        	hpReport.add(rs4.getString("PANCH_NAME"));
        	}
        	catch(Exception e)
			    {
        		hpReport.add("");
        		Debug.println("exception:"+e);
        		} 
        	        hpReport.add(formatData(rs2.getString("ASSET_NAME")));
	        	    hpReport.add(formatData(rs2.getString("POND_CODE")));
	        	    hpReport.add(formatData(rs2.getString("FED_BY")));
	        	    hpReport.add(formatData(rs2.getString("HYGENITY")));
	        	    hpReport.add(formatData(rs2.getFloat("STORAGE_VOL")));
	        	    hpReport.add(formatData(rs2.getString("POND_NAME"))); 
	        	    hpReport.add(formatData(rs2.getString("USAGE_PURPOSE"))); 
	        	    hpReport.add(formatData(rs2.getString("POND_LOCATION"))); 
	        	    //hpReport.add(formatData(rs2.getString("FED_NAME"))); 
	         	    hpReport.add(formatData(rs2.getFloat("SIZE_AREA")));
	        	    hpReport.add(formatData(rs2.getString("WATER_QUALITY"))); 
	        	    shallowPumps.add(hpReport);
         	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
           }
  	    }
	        catch(Exception e)
			 {
	        	Debug.println("error in adding data  to arraylist  in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	shallowPumps.add(ExceptionReport);
			 	return 	shallowPumps;
			 }
	 }
	 catch(SQLException e)
	 {
	  	Debug.println("error in retriving data  in CheckListMasterData"+e);
	 	java.util.Vector ExceptionReport =new java.util.Vector();
	 	ExceptionReport.add(e);
	 	shallowPumps.add(ExceptionReport);
	 	return 	shallowPumps;
	 }
	 finally 
	 {
    	try {
	    		if (conn != null)
	    		{
	     			conn.close();
	    		}
    	    } 
    	catch (SQLException e) 
		{
    		Debug.println("Exception "+e);
    	}
      }
	    
        
		return  shallowPumps;

	}
    public static ArrayList getAssetPwsReservoirsOhsrReport(DataSource dataSource, String query)throws Exception
		{   
    	    Connection conn=null;
			ArrayList cpwsReport=new ArrayList();
			ArrayList cpwsOhsr;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			      conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        //Debug.println( finalQuery);
			     try
				   {
			     	
			     				     
			     	
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("OHSR_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("OHSR_CODE")+"',1,16)=substr(panch_code,1,16)");
		            PreparedStatement psmt4=conn.prepareStatement(" select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?");
		            psmt4.setString(1,(String)rs2.getString("OHSR_CODE"));
		            ResultSet  rs5=psmt4.executeQuery();
		            //Debug.println(rs2.getString("OHSR_CODE"));
		            cpwsOhsr=new ArrayList();
		        	cpwsOhsr.add(sno);
		            try{rs3.next();
		            
		        	cpwsOhsr.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	cpwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	cpwsOhsr.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		cpwsOhsr.add("");
		        		Debug.println("exception:"+e);
		        		}
		        	 cpwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		            cpwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
		            try{
		            	rs5.next();
		            	//Debug.println("in noofhabs try block");
		        	cpwsOhsr.add(formatData(rs5.getString("NO_OF_HABS")));
		        	//System.out.println("noofhabs-->"+rs5.getString("NO_OF_HABS"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	cpwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            
		            	}
		            cpwsOhsr.add(formatData(rs2.getString("OHSR_LOC")));
		        	cpwsOhsr.add(formatData(rs2.getInt("OHSR_CAP_LTS"))+"");
		            cpwsOhsr.add(formatData(rs2.getInt("OHSR_NO_OF_FILLING"))+"");
		            cpwsOhsr.add(formatData(rs2.getFloat("OHSR_SATGES")));
		            if(rs2.getString("WATER_QTY")!=null && rs2.getString("WATER_QTY").equals("N"))
		            {
		            	 cpwsOhsr.add("Safe Source");
		            }
		            else if(rs2.getString("WATER_QTY")!=null && rs2.getString("WATER_QTY").equals("Y"))
		            {
		            	 cpwsOhsr.add("Safe Source");
		            }
		            
		            else
		            {
		            	 cpwsOhsr.add("Safe Source");	
		            }
		            //commented by pranavi on 23-04-09
		        	//cpwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HR")));
		        	//cpwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY_HR")));
		        	//cpwsOhsr.add(formatData(rs2.getString("OHSR_MWL")));
		        	//cpwsOhsr.add(formatData(rs2.getString("OHSR_LWL")));
		        	cpwsReport.add( cpwsOhsr);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
				   }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
		    
			}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{ 
		    		Debug.println("Exception "+e);
		    	}
		      }
				return  cpwsReport;

		}
    public static ArrayList getAssetPwsReservoirsGlsrReport(DataSource dataSource ,String query)throws Exception
		{
    	Connection conn=null;
    	ArrayList cpwsReport=new ArrayList();
			ArrayList pwsOhsr;
			try
			{

	        	
	String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			      conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	
		    	// ohbr
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        Debug.println( finalQuery);
			     try
				   {  
			     
			     	String sno="1";
		            while(rs2.next())
		           { 
		            	
		            Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
		            PreparedStatement psmt4=conn.prepareStatement(" select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?");
		            psmt4.setString(1,(String)(String)rs2.getString("GLSR_CODE"));
		            ResultSet  rs5=psmt4.executeQuery();
		            pwsOhsr=new ArrayList();
		            pwsOhsr.add(sno);
		            try{rs3.next();
		            
		            pwsOhsr.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        	    pwsOhsr.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsOhsr.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	pwsOhsr.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsOhsr.add(formatData(rs2.getString("GLSR_CODE")));
		        	 try{
		            	rs5.next();
		            	//Debug.println("in noofhabs try block");
		            	pwsOhsr.add(formatData(rs5.getString("NO_OF_HABS")));
		        	//System.out.println("noofhabs-->"+rs5.getString("NO_OF_HABS"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsOhsr.add("");
		            	Debug.println("Exception"+e);
		            
		            	}
		            pwsOhsr.add(formatData(rs2.getString("GLSR_LOC")));
		            pwsOhsr.add(formatData(rs2.getFloat("GLSR_CAP_LTS")));
		            pwsOhsr.add(formatData(rs2.getInt("GLSR_NO_OF_FILLING")));
		            //cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES")));
		        	if(rs2.getString("water_qty")!=null && !rs2.getString("water_qty").equals("")&& rs2.getString("water_qty").equals("N"))
		        	{
		        		pwsOhsr.add("Safe Source");	
		        	}
		           else
		           {
		           	pwsOhsr.add(" Not Safe Source");	
		           }
		        	
		        	
		        	//pwsOhsr.add(formatData(rs2.getString("GLSR_EMPTY_HR")));
		        	
		        	//pwsOhsr.add(formatData(rs2.getString("GLSR_SATGES")));
		        	//pwsOhsr.add(formatData(rs2.getString("GLSR_MWL")));
		        	//pwsOhsr.add(formatData(rs2.getString("GLSR_LWL")));
		        	cpwsReport.add( pwsOhsr);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			 }
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  cpwsReport;

		}
   	public static ArrayList getAssetPwsReservoirsCisternsReport(DataSource dataSource, String query)throws Exception
		{
   		    Connection conn=null;
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			      conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	
		    	

		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        //Debug.println( finalQuery);
			     try
				   {
			      	String sno="1";
		            while(rs2.next())
		           { 
		            Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CISSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CISSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	//cpwsOhsr.add(rs2.getString("PANCH_NAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next(); 
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		
		        		//pwsCistern.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
	        		pwsCistern.add(formatData(rs2.getString("CISSC_CODE"))); 
		        	pwsCistern.add(formatData(rs2.getString("CIS_LOC")));
		        	pwsCistern.add(formatData(rs2.getFloat("CIS_CAP_LTS"))+"");
		        	pwsCistern.add(formatData(rs2.getString("CIS_HR"))+"");
		        	pwsCistern.add(formatData(rs2.getString("CIS_PF")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_PF_CON")));
		        	pwsCistern.add(formatData(rs2.getString("CIS_DRAIN")));
		        	if(rs2.getString("Water_qty")!=null && rs2.getString("Water_qty").equals("Y"))
		        	{
		        		pwsCistern.add("Safe Source");
		        	} 
		        	else
		        	{
		        		pwsCistern.add("Not Safe Source");
		        	}
		           	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
		    }
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  cpwsReport;

		}
	public static ArrayList getAssetPwsSourcePumpSetReport(DataSource dataSource, String query)throws Exception
		{
			 Connection conn=null;
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			      conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	Debug.println("pws pumpsets query:"+finalQuery);
		     	    ResultSet rs2=stmt.executeQuery( finalQuery);
		    	    
			        
			     try
				   {
			     
			     	String sno="1";
		            while(rs2.next())
		           { 
		            Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PUMP_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PUMP_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            
		            pwsCistern.add(rs3.getString("PNAME"));
		        	 
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		//commented by pranavi on 22-04-09
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("PUMP_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("LOCATION")));
		        	pwsCistern.add(formatData(rs2.getString("PUMP_MAKE")));
		        	pwsCistern.add(formatData(rs2.getString("PUMP_TYPE")));
		         	pwsCistern.add(formatData(rs2.getFloat("PUMP_CPTY")));
		        	pwsCistern.add(formatData(rs2.getString("YEAR_COMM")));
		        	pwsCistern.add(formatData(rs2.getInt("HR_RUN")));
		        	pwsCistern.add(formatData(rs2.getString("USAGE")));
		        	pwsCistern.add(formatData(rs2.getFloat("DESIGNED_HEAD")));
		        	pwsCistern.add(formatData(rs2.getFloat("DESIGNED_LPM")));
		        	//pwsCistern.add(formatData(rs2.getString("CONTROL_PANEL")));
		         	//pwsCistern.add(formatData(rs2.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs2.getFloat("POWER_AVAIL_PER_DAY"))); 
		        	//pwsCistern.add(formatData(rs2.getFloat("COST")));
		        	// pwsCistern.add(formatData(rs2.getString("FEAS_URBAN_LINE")));
		        	//pwsCistern.add(formatData(rs2.getFloat("URBAN_LINE_DISTANCE")));
		        	pwsCistern.add(formatData(rs2.getString("LOW_VOLT_PROB")));
		        	pwsCistern.add(formatData(rs2.getString("SUGGESTIONS")));
		        	Debug.println("1111111111111:"+rs2.getString("SUGGESTIONS"));
		        	pwsCistern.add(formatData(rs2.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs2.getString("GENERATOR_EXISTING")));
		        	//pwsCistern.add(formatData(rs2.getString("GENERATOR_CAPACITY")));
		        	//pwsCistern.add(formatData(rs2.getString("GENERATOR_WORKING")));
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
		    
			}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  cpwsReport;

		}
    public static ArrayList getAssetPwsPumpsetsPhReport(DataSource dataSource, String query)throws Exception
		{
			Connection conn=null;
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			     conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		     	    ResultSet rs2=stmt.executeQuery( finalQuery);
		        try
				   {
			     	String sno="1";
		            while(rs2.next())
		           { 
		             Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PUMPHOUSE_CODE")+"',1,16)=substr(panch_code,1,16)");
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		             pwsCistern.add(rs3.getString("PNAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("PUMPHOUSE_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("CONDITION")));
		        	pwsCistern.add(formatData(rs2.getString("TYPE")));
		        	pwsCistern.add(formatData(rs2.getString("AREA")));
		        	pwsCistern.add(formatData(rs2.getString("HEIGHT")));
		        	
		        	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
		   	}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  cpwsReport;

		}
    public static ArrayList getAssetPwsPumpsetsCpReport(DataSource dataSource, String query)throws Exception
		{
    	    Connection conn=null;
			ArrayList cpwsReport=new ArrayList();
			ArrayList pwsCistern;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
			    conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		          try
				   {
			      	String sno="1";
		            while(rs2.next())
		           { 
		             Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CPSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            pwsCistern=new ArrayList();
		            pwsCistern.add(sno);
		            try{rs3.next();
		            pwsCistern.add(rs3.getString("PNAME"));
		            }catch(Exception e){
		            	pwsCistern.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		pwsCistern.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsCistern.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsCistern.add(formatData(rs2.getString("CPSC_CODE")));
		        	pwsCistern.add(formatData(rs2.getString("CP_EXES")));
		        	pwsCistern.add(formatData(rs2.getString("CP_COND")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CAP")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CAP_CON")));
		        	pwsCistern.add(formatData(rs2.getString("CP_MS")));
		        	pwsCistern.add(formatData(rs2.getString("CP_PL")));
		        	pwsCistern.add(formatData(rs2.getString("CP_CUT")));
		        	pwsCistern.add(formatData(rs2.getString("CP_PP")));
		        	pwsCistern.add(formatData(rs2.getString("CP_VM")));
		        	pwsCistern.add(formatData(rs2.getString("CP_AM")));
		        	pwsCistern.add(formatData(rs2.getString("CP_STA")));
		        	pwsCistern.add(formatData(rs2.getString("CP_MS1")));
		        	pwsCistern.add(formatData(rs2.getString("CP_SB")));
		         	cpwsReport.add( pwsCistern);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  cpwsReport;

		}
	public static ArrayList getAssetPwsPipelinePumpingmainReport(DataSource dataSource, String query)throws Exception
		{
		    Connection conn=null;
		   ArrayList pwsReport=new ArrayList();
			ArrayList pwsPipelinePumpingMain;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
		         conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	 
		    	    ResultSet rs2=stmt.executeQuery( finalQuery);
			      try
				   {
			         String sno="1";
		            while(rs2.next())
		           { 
		        	pwsPipelinePumpingMain=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PUMPINGMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PUMPINGMAIN_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            pwsPipelinePumpingMain=new ArrayList();
		            pwsPipelinePumpingMain.add(sno);
		            try{rs3.next();
		            
		            pwsPipelinePumpingMain.add(rs3.getString("PNAME"));
		             }catch(Exception e){
		            	pwsPipelinePumpingMain.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		//commented by pranavi on 23-04-09
		        		pwsPipelinePumpingMain.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsPipelinePumpingMain.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getString("ASSET_NAME")));	
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getString("PUMPINGMAIN_CODE")));
			         pwsPipelinePumpingMain.add(formatData(rs2.getInt("AIRVALVE_NO")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("SCOUREVALVE")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("REFLEXVALVE")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("SLUICEVALVE")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("NO_OF_PIPES")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("ZERO_VELOCITY_VALVE")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("AIR_CUSHION_VALVE")));
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getInt("NON_RETURN_VALVE")));
			    	 pwsReport.add( pwsPipelinePumpingMain);
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	pwsReport.add(ExceptionReport);
					 	return 	pwsReport;
					 }
		 	}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  pwsReport;

		}
	public static ArrayList getAssetOthersMisceLlaneousRpt(DataSource dataSource, String query)throws Exception
		{
		    Connection conn=null;
			ArrayList CpwsReport=new ArrayList();
			ArrayList CpwsMisLan;
			try
			{
				String finalQuery="select subCompTbl.* ,ASSET_NAME";
		        finalQuery=finalQuery+query;
		        
			    Debug.println("Query is "+finalQuery);
			    conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	     ResultSet rs2=stmt.executeQuery( finalQuery);
			      try
				   {
			        String sno="1";
		            while(rs2.next())
		           { 
		            	CpwsMisLan=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("OTHER_COMP_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("OTHER_COMP_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            CpwsMisLan=new ArrayList();
		            CpwsMisLan.add(sno);
		            try{rs3.next();
		            
		            CpwsMisLan.add(rs3.getString("PNAME"));
		           }catch(Exception e){
		            	CpwsMisLan.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		CpwsMisLan.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		CpwsMisLan.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	
		        	CpwsMisLan.add(formatData(rs2.getString("ASSET_NAME"))+""); 
		        	CpwsMisLan.add(formatData(rs2.getString("COMP_NAME"))+""); 
		        	CpwsMisLan.add(formatData(rs2.getString("OTHER_COMP_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs2.getString("COMP_LOCATION"))+"");
		        	CpwsMisLan.add(formatData(rs2.getString("REMARKS"))+"");
		        	CpwsReport.add( CpwsMisLan);
			     	
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	CpwsReport.add(ExceptionReport);
					 	return 	CpwsReport;
					 	
					 }
			 }
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	CpwsReport.add(ExceptionReport);
			 	return 	CpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  CpwsReport;

		}
	
	// code added by sridhar  for chlorination 
	
	public static ArrayList getAssetOthersChlorinationRpt(DataSource dataSource, String query)throws Exception
	{
	    Connection conn=null;
		ArrayList CpwsReport=new ArrayList();
		ArrayList CpwsMisLan;
		try
		{
			String finalQuery="select subCompTbl.* ,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        
		    Debug.println("Query is "+finalQuery);
		    conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	     ResultSet rs2=stmt.executeQuery( finalQuery);
		      try
			   {
		        String sno="1";
	            while(rs2.next())
	           { 
	            	CpwsMisLan=new ArrayList();
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CL_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CL_CODE")+"',1,16)=substr(panch_code,1,16)");
	            
	            CpwsMisLan=new ArrayList();
	            CpwsMisLan.add(sno);
	            try{rs3.next();
	            
	            CpwsMisLan.add(rs3.getString("PNAME"));
	           }catch(Exception e){
	            	CpwsMisLan.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try
				{
	        		rs4.next();
	        		CpwsMisLan.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e)
				{
	        		CpwsMisLan.add("");
	        		Debug.println("exception:"+e);
	        	}
	        	
	        	CpwsMisLan.add(formatData(rs2.getString("ASSET_NAME"))+""); 
	        	// CpwsMisLan.add(formatData(rs2.getString("COMP_NAME"))+""); 
	        	CpwsMisLan.add(formatData(rs2.getString("CL_CODE"))+""); 
	        	CpwsMisLan.add(formatData(rs2.getString("LOCATION"))+"");
	        	CpwsMisLan.add(formatData(rs2.getString("WORKING"))+"");
	        	
	        	CpwsMisLan.add(formatData(rs2.getString("BLEACHING_WORKING"))+"");
	        	CpwsMisLan.add(formatData(rs2.getString("LIQUID_CHILORINE_WORKING"))+"");
	        	CpwsMisLan.add(formatData(rs2.getString("GAS_CHILORINE_WORKING"))+"");
	        	CpwsMisLan.add(formatData(rs2.getString("ONLINE_DOSE_WORKING"))+"");
	        	CpwsMisLan.add(formatData(rs2.getString("REMARKS"))+"");
	        	 
	        	CpwsReport.add(CpwsMisLan);
		     	
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	CpwsReport.add(ExceptionReport);
				 	return 	CpwsReport;
				 	
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	CpwsReport.add(ExceptionReport);
		 	return 	CpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  CpwsReport;

	}
	// code end for Chlorination 
	
	// code added by sridhar for O and M
	public static ArrayList getAssetOthersOandMRpt(DataSource dataSource, String query)throws Exception
	{
	    Connection conn=null;
		ArrayList CpwsReport=new ArrayList();
		ArrayList CpwsMisLan;
		try
		{
			String finalQuery="select subCompTbl.* ,ASSET_NAME,M.HAB_CODE ";
	        Debug.println("tttQry:"+query);
			finalQuery=finalQuery+query;
	        
		    Debug.println("Query is "+finalQuery);
		    conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	        ResultSet rs2=stmt.executeQuery( finalQuery);
	        
	        Debug.println(" final qurry:"+finalQuery); 
		      try
			   {
		        String sno="1";
		        Debug.println("sss");
		        while(rs2.next())
	           { 
		        	Debug.println("sss.1");
	           	CpwsMisLan=new ArrayList();
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	    	    Debug.println("sss.2");
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("HAB_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("HAB_CODE")+"',1,16)=substr(panch_code,1,16)");
	            Debug.println("sss.3");
	            CpwsMisLan=new ArrayList();
	            CpwsMisLan.add(sno);
	            Debug.println("0");   
	            try{rs3.next(); 
	            
	            CpwsMisLan.add(rs3.getString("PNAME"));
	           }catch(Exception e){
	            	CpwsMisLan.add(""); 
	            	Debug.println("Exception"+e); 
	            	}  
	        	try  
				{
	        		rs4.next();
	        		CpwsMisLan.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e)
				{
	        		CpwsMisLan.add("");
	        		Debug.println("exception:"+e);
	        	}
	        	
	        	Debug.println("0.1");
	        	
	        	CpwsMisLan.add(formatData(rs2.getString("ASSET_NAME"))+""); 
	        	 
	        	//CpwsMisLan.add(formatData(rs2.getString("OANDMCODE"))+""); 
	        	if(rs2.getString("AGENCY_CODE")!=null && rs2.getString("AGENCY_CODE").equals("1"))
	        	{
	        		CpwsMisLan.add("ZP");	
	        	}
	        	 else if(rs2.getString("AGENCY_CODE")!=null && rs2.getString("AGENCY_CODE").equals("2"))
	        	{
	        		CpwsMisLan.add("Mandal");	
	        	}
	        	else if(rs2.getString("AGENCY_CODE")!=null && rs2.getString("AGENCY_CODE").equals("3"))
	        	{
	        		CpwsMisLan.add("GP");	
	        	}
	        	//CpwsMisLan.add(formatData(rs2.getString("AGENCY_CODE")));
	        	Debug.println("1");
	        	CpwsMisLan.add(formatData(rs2.getInt("POWER_COST")));
	        	Debug.println("2");
	        	CpwsMisLan.add(formatData(rs2.getInt("CONSUM_ANNUM")));
	        	Debug.println("3");
	        	CpwsMisLan.add(formatData(rs2.getInt("WAGES_ANNUM")));
	        	Debug.println("4");
	        	CpwsMisLan.add(formatData(rs2.getInt("POWER_COST")+rs2.getInt("CONSUM_ANNUM")+rs2.getInt("WAGES_ANNUM")));
	        	Debug.println("5");
	        	if(rs2.getString("SOURCES_FUND")!=null && rs2.getString("SOURCES_FUND").equals("1"))
	        	{
	        		CpwsMisLan.add("RWS");	
	        	}
	        	Debug.println("6");
	        	//CpwsMisLan.add(formatData(rs2.getString("SOURCES_FUND")));
	        	CpwsMisLan.add(formatData(rs2.getInt("HOUSE_CONN")));
	        	Debug.println("7");
	        	CpwsMisLan.add(formatData(rs2.getInt("TARIFF_MONTH")));
	        	Debug.println("8");
	        	CpwsMisLan.add(formatData(rs2.getInt("TARIFF_MONTH")*rs2.getInt("HOUSE_CONN")*12));
	        	 
	        	
	        	CpwsReport.add( CpwsMisLan);
	        	
	        	

		     	
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	CpwsReport.add(ExceptionReport);
				 	return 	CpwsReport;
				 	
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	CpwsReport.add(ExceptionReport);
		 	return 	CpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  CpwsReport;

	}
	// code end 
	// code modified by sridhar 
	public static ArrayList getAssetPwsPipelineDistributionReport(DataSource dataSource,String query)throws Exception
		{ 
		   Connection conn=null;
		   ArrayList pwsReport=new ArrayList();
			ArrayList pwsPipelineDistribution;
			try
			{
				String finalQuery="select subCompTbl.*,ASSET_NAME";
		        finalQuery=finalQuery+query;
		        Debug.println("Query is&&&"+finalQuery);
			    conn = dataSource.getConnection();
		    	Statement stmt = conn.createStatement();
		    	     ResultSet rs2=stmt.executeQuery( finalQuery);
			            try
				   {
			     	
                    String sno="1";
		            while(rs2.next())
		           { 
		        	pwsPipelineDistribution=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            
		            pwsPipelineDistribution=new ArrayList();
		            pwsPipelineDistribution.add(sno);
		            try{rs3.next();
		             pwsPipelineDistribution.add(rs3.getString("PNAME"));
		            }catch(Exception e){
		            	pwsPipelineDistribution.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		//Commented by pranavi on 23-04-09
		        		pwsPipelineDistribution.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		pwsPipelineDistribution.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	pwsPipelineDistribution.add(formatData(rs2.getString("ASSET_NAME")));
		        	pwsPipelineDistribution.add(formatData(rs2.getString("DISTRISC_CODE")));
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_OF_PIPES")));
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_AIRVALVES"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("DIS_LN"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_SLUICEVALVES"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_TLC"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_SCOURVALVES"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getString("DIS_COVE"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_PR_HC"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_BN"))+"");
		        	pwsPipelineDistribution.add(formatData(rs2.getInt("NO_STANDPOSTS"))+"");
		        	
		        	
			     	pwsReport.add( pwsPipelineDistribution);
			     	
		        	int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		           }
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	pwsReport.add(ExceptionReport);
					 	return 	pwsReport;
					 	
					 }
	 		}
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	pwsReport.add(ExceptionReport);
			 	return 	pwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }	
				return  pwsReport;

		}
     public static String formatData(float data)
	{
	int temp;
	float fraction;
	if(data==0)
	{
		return "--";
	}
	temp=(int)data;
	fraction=data-temp;
	if(fraction==0)
	{
		return temp+"";
	}
	
	return data+"";
	
	}
	public static String formatData(String data)
	{
	if(data==null)
	{
		return "--";
	}
	if(!(data==null))
	{
	if(data.equals("null"))
	{
	return "--";	
	}
	if(data.equals("0"))
		return "--";
	if(data.equals("Y"))
		return "YES";
	if(data.equals("N"))
		return "NO";
	if(data.equals("G"))
		return "GOOD";
	if(data.equals("B"))
		return "BAD";
	if(data.equals("E"))
		return "EXISTS";
	}
	
	return data;
	}
	public static String formatData(int data)
	{
	if(data==0)
		return "--";
	else return data+"";
	}
	public static ArrayList getMandalsForFilters(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv,String Filtertype,String seq,String assetCode)throws Exception
	{
	 	    //Debug.println("getting data from CheckListMasterData for districts grill  report");
		   Connection conn=null;
	       rws_asset_cpws_DrillDownBean cpwsGrill=null; 
	       ArrayList cpwsReport=new ArrayList();
	    
	       String query="";
	       String q1="select count(*)COUNT,dname ,mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and subStr(subCompTbl.WTPSC_CODE ,20,2)='"+Filtertype+"'" +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode   and SUBSTR("+subcompCode+",17,3) LIKE '"+seq+"'and a.type_of_asset_code='"+assetCode+"' " +
			"and man.dcode='"+Dcode+"'";
	       
	       String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	       String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	       String q3= " group by dname,man.MNAME ,mcode order by man.MNAME";
	       if(!(Div.equals("")))
	       {  
	       	//Debug.println("in div block");
	       	query=q1+q2;
	       	 if(!(subDiv.equals("")))
	       	 {
	       	 query=query+q4;	
	       	 }
	       }  query=query+q3;
	       if((Div.equals("")))
	       {
	         query=q1+q3;
	       }
	       int tot=0;
			try
			{    
			    conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			   //Debug.println(query);
			        ResultSet rs=stmt.executeQuery(query);
			        Debug.println(query);
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("Mcode"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            
			        //Debug.println("Total Districts is "+tot);
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		        	
		         }
		        
		        
			    }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
			     
			            cpwsGrill=new rws_asset_cpws_DrillDownBean();
			        	cpwsGrill.setSno("**");
			        	cpwsGrill.setName("Total");
			        	cpwsGrill.setTotal(Integer.toString(tot));
			        	cpwsReport.add(cpwsGrill);
			        	        		        
			         
			}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }		return  cpwsReport;	
	
	}
	public static ArrayList getMandalsForPws(DataSource dataSource,String tabName,String Dcode,String subcompCode,String Div,String subDiv)throws Exception
	{
	 	     
		Connection conn=null;
	       rws_asset_cpws_DrillDownBean cpwsGrill=null; 
	       ArrayList cpwsReport=new ArrayList();
	    
	       String query="";
	       String q1="";
	       if(subcompCode.equals("OANDMCODE"))
	       {
	       	q1="select count(*)COUNT,dname ,mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode and a.type_of_asset_code='01' " +
			"and man.dcode='"+Dcode+"'";
	       }
	       else
	       {
	       	q1="select count(*)COUNT,dname ,mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			"rws_asset_mast_tbl a,"+tabName+" subCompTbl ," +
			"rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code " +
			" and substr(a.hab_code,1,2) = man.dcode " +
			"and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code " +
			" and d.dcode=man.dcode and substr(subCompTbl."+subcompCode+",17,3) like '6%' and a.type_of_asset_code='01' " +
			"and man.dcode='"+Dcode+"'";
	       	
	       }
	       
	       String q2="and a.circle_office_Code='"+Dcode+"'and a.DIVISION_OFFICE_CODE='"+Div+"'";
	       String q4=" and a.SUBDIVISION_OFFICE_CODE='"+subDiv+"'";
	       String q3= " group by dname,man.MNAME,mcode order by man.MNAME";
	       if(!(Div.equals("")))
	       {  
	       	query=q1+q2;
	       	 if(!(subDiv.equals("")))
	       	 {
	       	 query=query+q4;	
	       	 }
	       }  query=query+q3;
	       if((Div.equals("")))
	       {
	         query=q1+q3;
	       }
	       int tot=0;
			try
			{    
			  conn = dataSource.getConnection();
		       Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			    
			        ResultSet rs=stmt.executeQuery(query);
			        Debug.println(query);
			        try{String sno="1";
		        while(rs.next())
		         {     
		        	cpwsGrill=new rws_asset_cpws_DrillDownBean();
		        	cpwsGrill.setSno(sno);
		        	cpwsGrill.setName(rs.getString("Mandal"));
		        	cpwsGrill.setMCode(rs.getString("MCODE"));
		        	cpwsGrill.setTotal(rs.getString("COUNT"));
		            tot=tot+Integer.parseInt(rs.getString("count"));
		            cpwsReport.add(cpwsGrill);
		            int no=Integer.parseInt(sno);
		        	no++;
		            sno=""+no;
		          }
		         }
			        catch(Exception e)
					 {
					 	Debug.println("error in getig dat in CheckListMasterData"+e);
					 	java.util.Vector ExceptionReport =new java.util.Vector();
					 	ExceptionReport.add(e);
					 	cpwsReport.add(ExceptionReport);
					 	return 	cpwsReport;
					 }
		               cpwsGrill=new rws_asset_cpws_DrillDownBean();
			        	cpwsGrill.setSno("**");
			        	cpwsGrill.setName("Total");
			        	cpwsGrill.setTotal(Integer.toString(tot));
			        	cpwsReport.add(cpwsGrill);
		 	}
			
			 catch(Exception e)
			 {
			 	Debug.println("error in getig dat in CheckListMasterData"+e);
			 	java.util.Vector ExceptionReport =new java.util.Vector();
			 	ExceptionReport.add(e);
			 	cpwsReport.add(ExceptionReport);
			 	return 	cpwsReport;
			 }
			 finally 
			 {
		    	try {
			    		if (conn != null)
			    		{
			     			conn.close();
			    		}
		    	    } 
		    	catch (SQLException e) 
				{
		    		Debug.println("Exception "+e);
		    	}
		      }		
				return  cpwsReport;	
	
	}
	public static ArrayList getAssetMpwsPipelineDistributionReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList pwsReport=new ArrayList();
		ArrayList pwsPipelineDistribution;
		try
		{
		 	String finalQuery="select subCompTbl.*,decode(subcompTbl.DIS_COVE,'Y','YES','N','NO')DIS_COVE1,ASSET_NAME";
	        finalQuery=finalQuery+query+" and substr(subCompTbl.DISTRISC_CODE,17,3) like '4%'";
	          conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		      try
			   {
		       String sno="1";
	            while(rs2.next())
	           { 
	        	pwsPipelineDistribution=new ArrayList();
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement(); 
	    	    ResultSet rs3=null;
	    	    ResultSet  rs4=null;
	    	    try{
	    	      rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
	        	}catch(Exception e){Debug.println("not executed rs3"+e);}  
	    	    try{
	        	rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("DISTRISC_CODE")+"',1,16)=substr(panch_code,1,16)");
	    	    }catch(Exception e){Debug.println("not executed rs4"+e); }
	        	     pwsPipelineDistribution=new ArrayList();
		            pwsPipelineDistribution.add(sno);
		        	try{rs3.next();
		          	pwsPipelineDistribution.add(rs3.getString("PNAME"));
		           }catch(Exception e){
		            	pwsPipelineDistribution.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	pwsPipelineDistribution.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		pwsPipelineDistribution.add("");
		        		Debug.println("exception:"+e);}
	        	try{
	        		pwsPipelineDistribution.add(formatData(rs2.getString("ASSET_NAME")));
	        		pwsPipelineDistribution.add(formatData(rs2.getString("DISTRISC_CODE")));
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_OF_PIPES")));
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_AIRVALVES"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("DIS_LN"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_SLUICEVALVES"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_TLC"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_SCOURVALVES"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getString("DIS_COVE"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_PR_HC"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getFloat("DIS_BN"))+"");
	        		pwsPipelineDistribution.add(formatData(rs2.getInt("NO_STANDPOSTS"))+"");
	        	
	        	}catch(Exception e){Debug.println("error in adding"+e);}
	        	pwsReport.add( pwsPipelineDistribution);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
		 	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	pwsReport.add(ExceptionReport);
		 	return 	pwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }
			return  pwsReport;
	
	}
	public static ArrayList getAssetMpwsPumpsetsPumpHouseReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList pwsReport=new ArrayList();
		ArrayList record;
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;
	          conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	         ResultSet rs2=stmt.executeQuery( finalQuery);
		      try
			   {
		      String sno="1";
	            while(rs2.next())
	           { 
	            	record=new ArrayList();
	            	record.add(sno);
	            	record.add(formatData(rs2.getString("ASSET_NAME"))+""); 
	            	record.add(formatData(rs2.getString("PUMPHOUSE_CODE"))+""); 
	            	record.add(formatData(rs2.getString("CONDITION"))+"");
	            	record.add(formatData(rs2.getString("TYPE"))+""); 
	            	record.add(formatData(rs2.getFloat("AREA "))+"");
	            	record.add(formatData(rs2.getFloat("HEIGHT"))+"");    
			     	  	   	  
	        	pwsReport.add(record);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
	 	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	pwsReport.add(ExceptionReport);
		 	return 	pwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  pwsReport;
	
	}
	public static ArrayList getAssetMpwsReservoirsrGlsrReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
		 	String finalQuery="select subcompTbl.* ,ASSET_NAME,decode(subcompTbl.GLSR_DRA_COND,'Y','YES','N','NO')GLSR_DRA_COND1 ," +
					"decode(subcompTbl.GLSR_HYG,'G','GOOD','B','BAD')GLSR_HYG1";
	        finalQuery=finalQuery+query;
	        conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		        ResultSet rs=stmt.executeQuery(finalQuery);
		         try{String sno="1";
	        while(rs.next())
	        {
	        	Statement   stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	             cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	            
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	             }catch(Exception e){
	            	cpwsGlsr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
	           	cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));
	         	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS"))+"");
		     	cpwsGlsr.add(formatData(rs.getString("GLSR_MADE"))+"");
		     	cpwsGlsr.add(formatData(rs.getString("GLSR_COND"))+"");
		     	cpwsGlsr.add(formatData(rs.getFloat("GLSR_FILL_HRS"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_EMPTY_HRS"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_DRA_COND1"))+"");
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_HYG1"))+"");
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	     }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  cpwsReport;
	
	}
	public static ArrayList getAssetMpwsReservoirsrGlbrReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
	   ArrayList cpwsReport=new ArrayList();
		ArrayList cpwsGlsr;
		try
		{
			
	
			String finalQuery="select *,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        conn = dataSource.getConnection();
	       Statement stmt = conn.createStatement();
		        ResultSet rs=stmt.executeQuery(finalQuery);
		         try{String sno="1";
	        while(rs.next())
	        {
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs.getString("GLSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	             cpwsGlsr=new ArrayList();
	            cpwsGlsr.add(sno);
	        	try{rs3.next();
	        	cpwsGlsr.add(rs3.getString("PNAME"));
	             }catch(Exception e){
	            	cpwsGlsr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	cpwsGlsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		cpwsGlsr.add("");
	        		Debug.println("exception:"+e);}
	        	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
	        	cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS"))+"");
	            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_LWL"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_MWL"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_FILL_HR"))+"");
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_EMPTY_HR"))+"");
	        	cpwsGlsr.add(formatData(rs.getInt("GLSR_NO_OF_FILLING"))+"");
	            cpwsReport.add( cpwsGlsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	        	
	         }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 	
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  cpwsReport;
	
	}
	public static ArrayList getAssetMpwsReservoirsCisternsReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null; 
		ArrayList cpwsReport=new ArrayList();
		ArrayList pwsCistern;
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME,decode(subcompTbl.CIS_PF,'Y','YES','N','NO')CIS_PF1," +
					"decode(subcompTbl.CIS_PF_CON,'G','GOOD','B','BAD')CIS_PF_CON1,decode(subcompTbl.CIS_DRAIN,'Y','YES','N','NO')CIS_DRAIN1";
	        finalQuery=finalQuery+query;
		      conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	     	    ResultSet rs2=stmt.executeQuery( finalQuery);
	        try
			   {
		      	String sno="1";
	            while(rs2.next())
	           { 
	            Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("CISSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("CISSC_CODE")+"',1,16)=substr(panch_code,1,16)");
	             pwsCistern=new ArrayList();
	            pwsCistern.add(sno);
	            try{rs3.next();
	             pwsCistern.add(rs3.getString("PNAME"));
	            }catch(Exception e){
	            	pwsCistern.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try
				{
	        		rs4.next();
	        		pwsCistern.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e)
				{
	        		pwsCistern.add("");
	        		Debug.println("exception:"+e);
	        	}
	        	pwsCistern.add(formatData(rs2.getString("ASSET_NAME")));
	        	pwsCistern.add(formatData(rs2.getString("CISSC_CODE")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_LOC")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_CAP_LTS")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_COND")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_PF1")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_PF_CON1")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_DRAIN1")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_TAP")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_TAP_COND")));
	        	pwsCistern.add(formatData(rs2.getString("CIS_HR")));
	        	cpwsReport.add( pwsCistern);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
	 	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }
			return  cpwsReport;
	
	}
	 
	public static ArrayList getAssetMpwsPumpsetsPumpDetailsReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList pwsReport=new ArrayList();
		ArrayList record;
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query;
	        conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	// ohbr
	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		        //Debug.println( finalQuery);
		     try
			   {
		         String sno="1";
	            while(rs2.next())
	           { 
	            	record=new ArrayList();
	            	record.add(sno);
	            	record.add(formatData(rs2.getString("ASSET_NAME"))+""); 
	            	record.add(formatData(rs2.getString("PUMPDET_CODE"))+"");  
	            	record.add(formatData(rs2.getInt("HP"))+"");  
	            	record.add(formatData(rs2.getString("DUTY_CON"))+""); 
	            	record.add(formatData(rs2.getFloat("DISCHARGE_LPM"))+"");  
	            	record.add(formatData(rs2.getInt("YEARS_USED"))+"");  
	            	record.add(formatData(rs2.getFloat("AVG_HR_PUMPING_DAY"))+""); 
	            	record.add(formatData(rs2.getString("CAPASITOR"))+""); 
	            	record.add(formatData(rs2.getFloat("POWER_SUPPLY_AVAILABLE_HRS"))+"");
	            	record.add(formatData(rs2.getFloat("QTY_WATER_CUM"))+""); 
	            	record.add(formatData(rs2.getString("PUMPCODE"))+""); 
	            	record.add(formatData(rs2.getString("TYPE"))+""); 
	            	record.add(formatData(rs2.getInt("HEAD_MTS"))+""); 
	            	record.add(formatData(rs2.getInt("STANDBY_HP"))+"");      
	            	record.add(formatData(rs2.getString("FAILURE_FREQ"))+"");    
	            	record.add(formatData(rs2.getFloat("REPAIR_COST_YEAR"))+"");         
	            	record.add(formatData(rs2.getString("CONTROL_PANEL"))+"");        
	            	record.add(formatData(rs2.getInt("WORK_HRS"))+"");    
		    	pwsReport.add(record);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
	     }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	pwsReport.add(ExceptionReport);
		 	return 	pwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  pwsReport;
	
	}
	public static ArrayList getAssetMpwsPipelineStandPostsReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList pwsReport=new ArrayList();
		ArrayList record;
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME,decode(subcompTbl.PC_LV,'Y','YES','N','NO')PC_LV1";
	        finalQuery=finalQuery+query+" and subStr(subCompTbl.SPHCPCSC_CODE,17,3) like '4%'";
	        conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	     ResultSet rs2=stmt.executeQuery( finalQuery);
		      try
			   {
		     	
		       String sno="1";
	            while(rs2.next())
	           { 
	            	record=new ArrayList();
	            	record=new ArrayList();
		        	Statement stmt2 = conn.createStatement();
		    	    Statement   stmt3 = conn.createStatement();
		            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("SPHCPCSC_CODE")+"',1,16)=substr(panch_code,1,16)");
		             record=new ArrayList();
		            record.add(sno);
		            try{rs3.next();
		            
		            record.add(rs3.getString("PNAME"));
		           }catch(Exception e){
		            	record.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try
					{
		        		rs4.next();
		        		record.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e)
					{
		        		record.add("");
		        		Debug.println("exception:"+e);
		        	}
		        	record.add(formatData(rs2.getString("ASSET_NAME"))+"");
	            	 record.add(formatData(rs2.getString("SPHCPCSC_CODE"))+"");
	            	 record.add(formatData(rs2.getInt("SP_NO"))+"");  
	            	 record.add(formatData(rs2.getInt("HC_NO"))+""); 
	            	 record.add(formatData(rs2.getString("PC_RF"))+"");
	            	 record.add(formatData(rs2.getString("PC_UF"))+""); 
	            	 record.add(formatData(rs2.getFloat("PC_HRS"))+"");       
			     	 record.add(formatData(rs2.getString("PC_LV1"))+"");     
			     	 record.add(formatData(rs2.getString("PC_SUG"))+"");       
			     	 record.add(formatData(rs2.getString("PC_FEA"))+"");     
			     	 record.add(formatData(rs2.getFloat("PC_COST"))+"");      
			     	 record.add(formatData(rs2.getInt("PC_DIS"))+""); 
			     pwsReport.add(record);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	pwsReport.add(ExceptionReport);
		 	return 	pwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }
			return  pwsReport;
	
	}
	public static ArrayList getAssetMpwsPipelinePumpingmainReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList pwsReport=new ArrayList();
		ArrayList pwsPipelinePumpingMain;
		try
		{
			String finalQuery="select subCompTbl.*,ASSET_NAME";
	        finalQuery=finalQuery+query+" and substr(subCompTbl.PM_CODE,17,3) like '4%'";
	         conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	         ResultSet rs2=stmt.executeQuery( finalQuery);
		      try
			   {
		     	   	
		        String sno="1";
	            while(rs2.next())
	           { 
	            	
	        	pwsPipelinePumpingMain=new ArrayList();
	        	Statement stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement(); 
	    	    Statement stmt4 = conn.createStatement(); 
	    	    ResultSet  rs4=null;
	    	    ResultSet rs3=null;
	    	    try{
	    	    rs3=stmt3.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("PM_CODE")+"',1,16)=substr(panch_code,1,16)");
	        	}catch(Exception e){Debug.println("Exception in statement2"+e);}
	        	try{
	        	rs4=stmt4.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("PM_CODE")+"',1,16)=substr(panch_code,1,16)");
	        	}catch(Exception e){Debug.println("exception in stmt3"+e);}    
	        
		            pwsPipelinePumpingMain=new ArrayList();
		            pwsPipelinePumpingMain.add(sno);
		        	try{rs3.next();
		            
		        	pwsPipelinePumpingMain.add(rs3.getString("PNAME"));
		              }catch(Exception e){
		            	pwsPipelinePumpingMain.add("");
		            	Debug.println("Exception"+e);
		            	}
		        	try{rs4.next();
		        	pwsPipelinePumpingMain.add(rs4.getString("PANCH_NAME"));
		        	}
		        	catch(Exception e){
		        		pwsPipelinePumpingMain.add("");
		        		Debug.println("exception:"+e);}
		        	
		        	 pwsPipelinePumpingMain.add(formatData(rs2.getString("ASSET_NAME"))+""); 
		        
		      pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_CODE"))+"");       
	        	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_MAT"))+"");       
		     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_CLA"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getFloat("PM_DIA"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_LEN"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_COND"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getString("PM_REP"))+"");       
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_NO"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_CON_G"))+"");       
	
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_AV_CON_B"))+"");       
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_NO"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_COND_G"))+"");         
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SCRV_COND_B"))+"");        
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_NO"))+"");     
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_COND_G"))+"");        
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_SV_COND_B"))+"");      
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_NO"))+"");     
		     	pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_COND_G"))+"");         
		        pwsPipelinePumpingMain.add(formatData(rs2.getInt("PM_RV_COND_B"))+"");       
	
	        	pwsReport.add( pwsPipelinePumpingMain);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	pwsReport.add(ExceptionReport);
				 	return 	pwsReport;
				 }
		 	}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	pwsReport.add(ExceptionReport);
		 	return 	pwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  pwsReport;
	
	}
	public static ArrayList getAssetMpwsReservoirsOhsrReport(DataSource dataSource,String query)throws Exception
	{
		Connection conn=null;
		ArrayList cpwsReport=new ArrayList();
		ArrayList pwsOhsr;
		try
		{
		 String finalQuery="select  subCompTbl.*,ASSET_NAME,decode(subcompTbl.OHSR_FEN,'Y','YES','N','NO')OHSR_FEN1," +
					"decode(subcompTbl.OHSR_HYG,'G','GOOD','B','BAD')OHSR_HYG1";
	 		finalQuery=finalQuery+query;
	         conn = dataSource.getConnection();
	    	Statement stmt = conn.createStatement();
	    	 
	    	    ResultSet rs2=stmt.executeQuery( finalQuery);
		        
		     try
			   {
		        String sno="1";
	            while(rs2.next())
	           { 
	         	Statement    stmt2 = conn.createStatement();
	    	    Statement   stmt3 = conn.createStatement();
	            ResultSet rs3=stmt2.executeQuery("select pname from rws_panchayat_name_view where substr('"+rs2.getString("OHSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	            ResultSet  rs4=stmt3.executeQuery("select PANCH_NAME  from rws_panchayat_raj_tbl where substr('"+rs2.getString("OHSR_CODE")+"',1,16)=substr(panch_code,1,16)");
	           
	            pwsOhsr=new ArrayList();
	            pwsOhsr.add(sno);
	        	try{rs3.next();
	            
	        	pwsOhsr.add(rs3.getString("PNAME"));
	         
	            }catch(Exception e){
	            	pwsOhsr.add("");
	            	Debug.println("Exception"+e);
	            	}
	        	try{rs4.next();
	        	pwsOhsr.add(rs4.getString("PANCH_NAME"));
	        	}
	        	catch(Exception e){
	        		pwsOhsr.add("");
	        		Debug.println("exception:"+e);}
	        	try{
	        	pwsOhsr.add(rs2.getString("ASSET_NAME"));
	        	}
	        	catch(Exception e)
				{
	        		Debug.println("Exception in assetname"+e);
	        		pwsOhsr.add("");
				}
	        	pwsOhsr.add(formatData(rs2.getString("OHSR_CODE")));
	        	pwsOhsr.add(formatData(rs2.getString("OHSR_LOCATION")));
	        	pwsOhsr.add(formatData(rs2.getInt("OHSR_NO"))+"");
	            pwsOhsr.add(formatData(rs2.getFloat("OHSR_LTS"))+"");
	           	pwsOhsr.add(formatData(rs2.getString("OHSR_MADE"))+"");
	        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_HT"))+"");
	        	pwsOhsr.add(formatData(rs2.getString("OHSR_COND"))+"");
	        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_FILL_HRS"))+"");
	        	pwsOhsr.add(formatData(rs2.getFloat("OHSR_EMPTY"))+"");
	        	pwsOhsr.add(formatData(rs2.getString("OHSR_HYG1"))+"");
	        	pwsOhsr.add(formatData(rs2.getString("OHSR_FEN1"))+"");
	        	pwsOhsr.add(formatData(rs2.getInt("OHSR_NO_OF_FILLING"))+"");
	        	
	        	cpwsReport.add( pwsOhsr);
	        	int no=Integer.parseInt(sno);
	        	no++;
	            sno=""+no;
	           }
		    }
		        catch(Exception e)
				 {
				 	Debug.println("error in getig dat in CheckListMasterData"+e);
				 	java.util.Vector ExceptionReport =new java.util.Vector();
				 	ExceptionReport.add(e);
				 	cpwsReport.add(ExceptionReport);
				 	return 	cpwsReport;
				 }
		        finally{
			        stmt.close();	
			        conn.close();  
		        	}
	        
		}
		 catch(Exception e)
		 {
		 	Debug.println("error in getig dat in CheckListMasterData"+e);
		 	java.util.Vector ExceptionReport =new java.util.Vector();
		 	ExceptionReport.add(e);
		 	cpwsReport.add(ExceptionReport);
		 	return 	cpwsReport;
		 }
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }	
			return  cpwsReport;
	
	}
	
	public  static ArrayList getPanchayats(DataSource datasource,String dcode,String mcode)throws Exception
	{   Connection conn=null;
		ArrayList panchayats=null;
		rws_asset_CheckList_Bean pan=null;
		try{
			panchayats=new ArrayList();
			Debug.println("in getCircles ");
		   String query="select pcode,pname from RWS_PANCHAYAT_TBL where dcode='"+dcode+"'and mcode='"+mcode+"'";
		   Debug.println("query"+query);
		   conn=datasource.getConnection();
		   PreparedStatement ps=conn.prepareStatement(query);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
		   	pan=new rws_asset_CheckList_Bean();
		   	pan.setPanchayatCode(rs.getString(1)+"");
		   	pan.setPanchayatName(rs.getString(2)+"");
		   	panchayats.add(pan);
		   }
	 	}
		catch(Exception e)
		{
			Debug.println("Exception while geting circles"+e);
		}
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }
		return panchayats;
	}

 
	public  static ArrayList getMandals(DataSource datasource,String district)throws Exception
	{
		Connection conn=null;
		ArrayList mandals=null;
		rws_asset_CheckList_Bean mandal=null;
		try{
			mandals=new ArrayList();
			Debug.println("in getCircles ");
		   String query="select mcode,mname from RWS_MANDAL_TBL  where dcode='"+district+"'order by Mname";
		   Debug.println("query"+query);
		   conn=datasource.getConnection();
		   PreparedStatement ps=conn.prepareStatement(query);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
		   	mandal=new rws_asset_CheckList_Bean();
		   	mandal.setMandalCode(rs.getString(1)+"");
		   	mandal.setMandalName(rs.getString(2)+"");
		    mandals.add(mandal);
		   }
	 	}
		catch(Exception e)
		{
			Debug.println("Exception while geting circles"+e);
		}
		 finally 
		 {
	    	try {
		    		if (conn != null)
		    		{
		     			conn.close();
		    		}
	    	    } 
	    	catch (SQLException e) 
			{
	    		Debug.println("Exception "+e);
	    	}
	      }
		return mandals;
	}

}
