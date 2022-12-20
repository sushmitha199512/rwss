<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>
<%
	Connection conn=null,conn1=null;
	Statement st1=null,st2=null;
    ResultSet rs2=null,rs1=null;
	int total = 0;
	String workid="",main="0",workname="",stateid="002",dcode="",schemetypeid="",type="",sancyear="",estcost="0",revestcost="0",goicost="0",statecost="0",commcont="0",capacity="0",service="",exp="0",moreexp="0",dofcomm="",dofcomp="",psy="",atm="No",sourcetypeid="";
	double popcov = 0;
	Statement stq1=null,stq2=null,stq3=null,stq31=null,stq4=null,stq5=null,sss=null,prev=null;
	ResultSet rsq1=null,rsq2=null,rsq3=null,rsq31=null,rsq4=null,rsq5=null,prevrs=null,san=null;

    %>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="780" >
<% 			
try{
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft","preduser","preduser");
		
//Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//conn = DriverManager.getConnection("jdbc:odbc:delhidsn1");

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
conn1 = DriverManager.getConnection("jdbc:odbc:schemePorting21082012");
	
   }
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
   }   
   Statement stqq =null,stqq1 =null; 
   ResultSet rsqq = null;
   String query = "";
   String location = "",date_of_comm="";
   try{
		String qq = "SELECT RWS_Schemes.SchemeId,Switch((RWS_Schemes.programme_code='00' or RWS_Schemes.programme_code='10' or RWS_Schemes.programme_code='12' or RWS_Schemes.programme_code='36' or RWS_Schemes.programme_code='37' or RWS_Schemes.programme_code='39' or RWS_Schemes.programme_code='44' or RWS_Schemes.programme_code='46' or RWS_Schemes.programme_code='20' or RWS_Schemes.programme_code='35'or RWS_Schemes.programme_code='63' ),15,(RWS_Schemes.programme_code='01' or RWS_Schemes.programme_code='09'),1,RWS_Schemes.programme_code='04',22,RWS_Schemes.programme_code='05',3,RWS_Schemes.programme_code='01' and RWS_Schemes.subprogramme_code='06',13,(RWS_Schemes.programme_code='34' or RWS_Schemes.programme_code='14' or RWS_Schemes.programme_code='02' or RWS_Schemes.programme_code='25'or RWS_Schemes.programme_code='26'),9,(RWS_Schemes.programme_code='57'),6,RWS_Schemes.programme_code='24',2,RWS_Schemes.programme_code='15',7,RWS_Schemes.programme_code='18',14,RWS_Schemes.programme_code='51',21,(RWS_Schemes.programme_code='49' or RWS_Schemes.programme_code='58' or RWS_Schemes.programme_code='60' or RWS_Schemes.programme_code='53' or RWS_Schemes.programme_code='59' or RWS_Schemes.programme_code='61'),19)AS programme_code1 FROM RWS_Schemes";
		System.out.println(qq);
		stqq  = conn1.createStatement();
		rsqq = stqq.executeQuery(qq);
		st1 = conn1.createStatement();

		while(rsqq.next())
		{
			
			try
			{
				String data1 = rsqq.getString(1);
				String data2 = rsqq.getString(2);

				if(data2!=null && !data2.equals(""))
				{	
					query = "insert into RWS_SchemesProgrammes values('"+data1+"','"+data2+"')";
					total +=st1.executeUpdate(query);
				}
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
		out.println("<font face=verdana size=2>"+total+" no.of Habitations exported Successfully! To download the mdb file Click the following Link:<!-- <a href=d:/habdata/habdata.mdb></font><font face=verdana size=3 color=red>Download</a></font> -->");
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
