<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random,java.text.*"%>

<%  
    DecimalFormat ndf = new DecimalFormat("####.00");

	String fromdate=request.getParameter("fdate");
    String todate=request.getParameter("todate");

    SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");   
    SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yy");

    SimpleDateFormat sdfDestination1 = new SimpleDateFormat("dd-MM-yyyy");   
    SimpleDateFormat sdfSource1 = new SimpleDateFormat("dd-MM-yy");
    


      try{
       //parse the string into Date object
       java.util.Date date = sdfSource.parse(fromdate);
       //System.out.println("date1 : " + date);
       //parse the date into another format
       fromdate = sdfDestination.format(date);    
       //System.out.println("Converted date is : " + fromdate);

       //parse the string into Date object
       java.util.Date date1 = sdfSource1.parse(todate);
       //System.out.println("date2 : " + date1);
       //parse the date into another format
       todate = sdfDestination1.format(date1);    
     //  System.out.println("Converted date1 is : " + todate);
	 
	   } 
       catch(ParseException pe)
	   { 
	     System.out.println("Parse Exception : " + pe);
	   }
 int count=0;
 int mon=Integer.parseInt(fromdate.substring(4,5));
 String yr=fromdate.substring(6,10);

 String myreptype=request.getParameter("reptype");
System.out.println("myreptype: " + myreptype);

// System.out.println("mon and year : " + mon+"..."+yr);
%>
<!-- Physical MPR Porting -->
<form name=f1>

<% 


ResultSet  rs1 = null, rs2 = null,rs3=null,rs4=null,rs5=null,rs6=null;

	//Connection con = null, con1 = null;
	%>

<%      
        //String montharry[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
        //String m=montharry[mon-1];
       // System.out.println("monthhhhhhhhh"+montharry[mon-1]);
        String Query = "";
		String insertQuery = "";
        String  SchemeId= "", Monthid= "", YearId= "", Habitationid= "", SCPopCovered= "", STPopCovered= "", GenPopCovered= "",HouseConnection= "",Status= "";
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "";
			int contaminated = 0, rowcount = 0;
						
			 stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();

        String selquery="Select tname from tab where tname like 'PHYSICALMPR'";
        rs4=stmt4.executeQuery(selquery);
        if(!rs4.next())
	    {
            String Query1 = "CREATE table PhysicalMPR(SchemeId varchar2(14),Habitationid varchar(16),Monthid varchar2(4),YearId varchar2(4),SCPopCovered number(8,2),STPopCovered number(8,2),GenPopCovered number(8,2),HouseConnection number(8,2),Status varchar2(2))";
		    stmt.executeUpdate(Query1);
			conn.setAutoCommit(true);
			System.out.println("Query1:" + Query1);
	    }
       else
       {  
        String Query1="delete from PhysicalMPR";
        stmt.executeUpdate(Query1);
		conn.setAutoCommit(true);
		System.out.println("Query1:" + Query1);
       }
	

    String Query2="";

    if(!myreptype.equals(null) && myreptype.equals("ent"))
    {
    //String Query2="SELECT RWS_WORK_COMPLETION_TBL.WORK_ID, RWS_WORK_COMP_HAB_LNK_TBL.HAB_CODE, RWS_COMPLETE_HAB_VIEW.CENSUS_SC_POPU, RWS_COMPLETE_HAB_VIEW.CENSUS_ST_POPU, RWS_COMPLETE_HAB_VIEW.CENSUS_PLAIN_POPU, RWS_WORK_COMP_HAB_LNK_TBL.HOUSE_CONN, RWS_COMPLETE_HAB_VIEW.COVERAGE_STATUS FROM ((RWS_WORK_COMPLETION_TBL INNER JOIN RWS_WORK_COMP_HAB_LNK_TBL ON RWS_WORK_COMPLETION_TBL.WORK_ID = RWS_WORK_COMP_HAB_LNK_TBL.WORK_ID) INNER JOIN IMISMASTERDATA1 ON RWS_WORK_COMP_HAB_LNK_TBL.HAB_CODE = IMISMASTERDATA1.habcode) INNER JOIN RWS_COMPLETE_HAB_VIEW ON IMISMASTERDATA1.habcode = RWS_COMPLETE_HAB_VIEW.PANCH_CODE WHERE (((RWS_WORK_COMPLETION_TBL.UPDATE_DATE) Between #"+fromdate+"# And #"+todate+"#))";
     Query2="select  distinct b.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,d.COVERAGE_STATUS,c.hab_code,to_char(b.update_date,'MON') from RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where b.DATE_OF_COMPLETION is not null and b.work_id=c.work_id and c.hab_code=d.panch_code and  b.update_date>=to_date('"+fromdate+"','dd-mm-yyyy') and b.update_date<=to_date('"+todate+"','dd-mm-yyyy') AND d.COVERAGE_STATUS not in('UI','NSS','NC',' ')";
    }
    else if(!myreptype.equals(null) && myreptype.equals("comp"))
	{
       //Query2="select  distinct a.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,d.COVERAGE_STATUS,c.hab_code,to_char(b.update_date,'MON') from RWS_AAP_SELECTED_TBL a ,RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where a.work_id=b.work_id and  b.work_id=c.work_id and c.hab_code=d.panch_code and b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION>=to_date('"+fromdate+"','dd-mm-yyyy') and b.DATE_OF_COMPLETION<=to_date('"+todate+"','dd-mm-yyyy') AND d.COVERAGE_STATUS not in('UI','NSS','NC',' ')";
    Query2="select  distinct b.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,d.COVERAGE_STATUS,c.hab_code,to_char(b.DATE_OF_COMPLETION,'MON') from RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where   b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION>=to_date('"+fromdate+"','dd-mm-yyyy') and b.DATE_OF_COMPLETION<=to_date('"+todate+"','dd-mm-yyyy') and b.work_id=c.work_id and c.hab_code=d.panch_code AND d.COVERAGE_STATUS not in('UI','NSS','NC',' ')";
   	}
    rs1 = stmt1.executeQuery(Query2);
    System.out.println("select Query2:"+Query2);
	while(rs1.next())
	 {
       String Query4="",pstatus="";
       SchemeId=rs1.getString(1);
       SCPopCovered=rs1.getString(2);
       STPopCovered=rs1.getString(3);
       GenPopCovered  = rs1.getString(4);
       HouseConnection =rs1.getString(5);
       Status=rs1.getString(6);
       Habitationid=rs1.getString(7);
       Monthid=rs1.getString(8);
       if(Status.equals("PC1") || Status.equals("PC2") || Status.equals("PC3") || Status.equals("PC4"))
        pstatus="PC";
       else
       pstatus=Status;
	   if(HouseConnection!=null)
            {
			 Query4="insert into PhysicalMPR values(?,?,?,?,?,?,?,?,?)"; //correct
			 PreparedStatement ps22=conn.prepareStatement(insertQuery);
             ps22.setString(1, SchemeId);
             ps22.setString(2, Habitationid);
             ps22.setString(3, Monthid);
             ps22.setString(4, yr);
             ps22.setString(5, SCPopCovered);
             ps22.setString(6, STPopCovered);
             ps22.setString(7, GenPopCovered);
             ps22.setString(8,HouseConnection);
             ps22.setString(9, pstatus);
             
            }
       else
           {
             Query4="insert into PhysicalMPR values(?,?,?,?,?,?,?,'0',?)"; //correct
		   } 
            //System.out.println("Insert Query4:"+Query4);
			   if(!insertQuery.equals(" "))
			    { 
				   PreparedStatement ps22=conn.prepareStatement(Query4);
		             ps22.setString(1, SchemeId);
		             ps22.setString(2, Habitationid);
		             ps22.setString(3, Monthid);
		             ps22.setString(4, yr);
		             ps22.setString(5, SCPopCovered);
		             ps22.setString(6, STPopCovered);
		             ps22.setString(7, GenPopCovered);
		             ps22.setString(8, pstatus);
			      rcount+=ps22.executeUpdate();
				}
			
		    String sno = "";
	         } 

           //String dropqry="drop table PhysicalMPR";
          // stmt3.executeUpdate(dropqry);
          // conn.setAutoCommit(true);
          // System.out.println("dropqry"+dropqry);
             System.out.println("Records inserted:"+rcount);
          if(rcount>0)
          {
          out.println("<font face=verdana size=2>"+rcount+" no.of Habitations exported Successfully! <a href=rws_physical_mpr_porting_xls.jsp></font><font face=verdana size=3 color=red>Click here for Excel file</a>|<a href=../home.jsp>Home</a>|<a href=javascript:onClick=history.go(-1)>Back</a></font> ");
          }
          else
          {%> 
          <script>
          alert("No Records...");
          document.f1.action="./rws_physical_mpr_porting_frm.jsp";
		  document.f1.submit();
          </script>
          <%
           
          }
    
     }
     catch (Exception e) 
       {
			//System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
%>

