
<%@	page import="java.sql.*, java.util.* " %>

<%
ResultSet rs1=null,rs2=null;
Statement stmt1=null,stmt2=null;

Connection conn1=null,conn=null;
String query=null;
String query1=null;
int i=1;
int count=0;
try
{
	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	
	
	String url="jdbc:odbc:master";
	conn1=DriverManager.getConnection(url,"","");
    //oracle
	DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
    conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.84:1521:wsoft","preduser","preduser");
    //oracle stmt2
    stmt2=conn.createStatement();
//access
    stmt1=conn1.createStatement();
    query="select sno,constno,constituencyname,mandalcode from mandal_const";
	rs1=stmt1.executeQuery(query);
    while(rs1.next())
	{
//     query1="insert into rws_constituency_tbl(rep_code,constituency_code,constituency_name,constituency_type,dcode,mcode) values ( '01','"+rs1.getString(2)+"','"+rs1.getString(3)+"','A','"+rs1.getString(1)+"','"+rs1.getString(4)+"' )";
 query1="insert into rws_constituency_tbl values ( '01','"+rs1.getString(2)+"','"+rs1.getString(3)+"','A','','','"+rs1.getString(1)+"','"+rs1.getString(4)+"')";
	 i=stmt2.executeUpdate(query1);
	 out.println(i+"Records inserted");
     count++;

	}
out.println("count"+count);

}
catch(Exception e)
{
	e.printStackTrace();
	
}

%>
