<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>
<%
	Connection conn=null,conn1=null;
	Statement st1=null,st2=null;
    ResultSet rs2=null,rs1=null;
	int total = 0;
	String workid="",main="0",workname="",stateid="002",dcode="",schemetypeid="",type="",sancyear="",estcost="0",revestcost="0",goicost="0",statecost="0",commcont="0",capacity="0",service="",exp="0",moreexp="0",dofcomm="",dofcomp="",psy="",atm="No";
	double popcov = 0;
	Statement stq1=null,stq2=null,stq3=null,stq31=null,stq4=null,stq5=null,sss=null,prev=null;
	ResultSet rsq1=null,rsq2=null,rsq3=null,rsq31=null,rsq4=null,rsq5=null,prevrs=null,san=null;

    %>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="780" >
<% 			
try{
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.84:1521:wsoft","preduser","preduser");

	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	conn1 = DriverManager.getConnection("jdbc:odbc:master");
	
   }
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
   }   
   Statement stqq =null,stqq1 =null; 
   ResultSet rsqq = null;
   String query = "";
   try{
		String qq = "select * from RWS_DDWS_SCHEME_DATA_PORT a,rws_school_asset_lnk_tbl b where a.work_id=b.asset_code";
		stqq  = conn.createStatement();
		rsqq = stqq.executeQuery(qq);
		st1 = conn1.createStatement();

		while(rsqq.next())
		{
			String slipreason = "";
			int prstatus = 0,prestatus = 0;
			try{
					query = "insert into Rws_SchoolMpr(School_code,Month,Year,WorkId,HabCode) values(?,'February','2010',?,?)";
						//System.out.println("final query:"+query);
						PreparedStatement ps=conn1.prepareStatement(query); 
						 ps.setString(1, rsqq.getString(5));
						 ps.setString(2, rsqq.getString(2));
						 ps.setString(3, rsqq.getString(4));
						total +=ps.executeUpdate();
		    	}
		    	catch(Exception e)
		    	{
					System.out.println(query);
					System.out.println("Exception in conn1:"+e.getMessage());
		    	}
				finally{
				try{
				//if(st1!=null)st1.close();
				}catch(Exception e){}
		   	}
		}
		out.println("<font face=verdana size=2>"+total+" no.of Habitations exported Successfully! ></font><font face=verdana size=3 color=red></a></font> -->");
   }
	  catch(Exception e)
   {
		System.out.println("Exception in conn"+e);
   }
   finally{
   try{
	rsqq.close();
	stqq.close();			
	}catch(Exception e){}	
   }
	%>
