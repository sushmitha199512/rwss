<%@ page import="javax.naming.*,javax.sql.*,java.sql.*"%>
<%

     Context ctx = new InitialContext();
 
      DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/pred");
	  Connection conn=null; 
    try
	{
     conn= ds.getConnection();
     
      if (ds != null)
	  {
        
              
        if(conn != null)
		{
            Statement stmt = conn.createStatement();
            ResultSet rst = stmt.executeQuery("SELECT * from rws_district_tbl");
            while(rst.next())
			{
               out.println("dcode= "+rst.getString(1));
               out.println("dname= "+rst.getString(2));
            }
            conn.close();
        }
      }
    }
	catch(Exception e)
	{
      //e.printStackTrace();
    }
    finally
    {
    if(conn!=null)
    conn.close();
    }
%>
