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
		String qq = "SELECT DISTINCT  RWS_SOURCE_IDEN_FIN_TBL.WORK_ID, Switch(rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=1,10,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=2,27,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=3,13,rws_source_iden_fin_tbl.source_type_code=1 And rws_source_iden_fin_tbl.subsource_type_code=4,09,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=1,18,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=2,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=3,15,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=4,19,rws_source_iden_fin_tbl.source_type_code=2 And rws_source_iden_fin_tbl.subsource_type_code=5,18,True,('Unspecified')) AS sourcetypeid, IMISMASTERDATA1.Stateid, IMISMASTERDATA1.DistrictId, IMISMASTERDATA1.BlockId, IMISMASTERDATA1.PanchayatId, IMISMASTERDATA1.Villageid, IMISMASTERDATA1.HabitationId, rws_source_tbl.LOCATION, rws_work_completion_tbl.DATE_OF_COMM FROM (((RWS_Schemes INNER JOIN rws_source_iden_fin_tbl ON RWS_Schemes.work_id = rws_source_iden_fin_tbl.WORK_ID) INNER JOIN IMISMASTERDATA1 ON rws_source_iden_fin_tbl.HAB_CODE = IMISMASTERDATA1.HabCode) LEFT JOIN rws_source_tbl ON rws_source_iden_fin_tbl.SOURCE_CODE = rws_source_tbl.SOURCE_CODE) LEFT JOIN rws_work_completion_tbl ON RWS_Schemes.work_id = rws_work_completion_tbl.WORK_ID";
							System.out.println(qq);
		stqq  = conn1.createStatement();
		rsqq = stqq.executeQuery(qq);
		st1 = conn1.createStatement();

		while(rsqq.next())
		{
					
			try
			{
				location = rsqq.getString("location");
				if(location == null)location="";
				date_of_comm = rsqq.getString("date_of_comm");
				if(date_of_comm == null)date_of_comm="";
				 PreparedStatement ps=null;
				if(!date_of_comm.equals(""))
				{
					query = "insert into RWS_SchemeSources(SchemeId,SourceTypeId,StateID,DistrictId,BlockId,PanchayatId,VillageId,HabitationId,Location,DateOfCommissioning)values(?,?,?,?,?,?,?,?,?,?)";
					ps=conn.prepareStatement(query);
                     ps.setString(1, rsqq.getString("work_id"));
						ps.setString(2, rsqq.getString("sourcetypeid"));
						ps.setString(3,rsqq.getString("stateid"));
						ps.setString(4, rsqq.getString("districtid"));
						ps.setString(5,rsqq.getString("blockid"));
						ps.setString(6,rsqq.getString("panchayatid"));
						ps.setString(7,rsqq.getString("villageid"));
						ps.setString(8,rsqq.getString("habitationid"));
						ps.setString(9,location);
						ps.setString(10,date_of_comm);
				}
				else if(date_of_comm.equals(""))
				{
					query = "insert into RWS_SchemeSources(SchemeId,SourceTypeId,StateID,DistrictId,BlockId,PanchayatId,VillageId,HabitationId,Location)values('"+rsqq.getString("work_id")+"','"+rsqq.getString("sourcetypeid")+"','"+rsqq.getString("stateid")+"','"+rsqq.getString("districtid")+"','"+rsqq.getString("blockid")+"','"+rsqq.getString("panchayatid")+"','"+rsqq.getString("villageid")+"','"+rsqq.getString("habitationid")+"','"+location+"')";
					ps=conn.prepareStatement(query);
                    ps.setString(1,rsqq.getString("work_id"));
						ps.setString(2, rsqq.getString("sourcetypeid"));
						ps.setString(3,rsqq.getString("stateid"));
						ps.setString(4, rsqq.getString("districtid"));
						ps.setString(5,rsqq.getString("blockid"));
						ps.setString(6,rsqq.getString("panchayatid"));
						ps.setString(7,rsqq.getString("villageid"));
						ps.setString(8,rsqq.getString("habitationid"));
						ps.setString(9,location);
				}
					System.out.println(query);
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
