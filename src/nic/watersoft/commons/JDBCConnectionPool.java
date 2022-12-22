/*
 * Created on 09-Feb-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnectionPool extends ObjectPool
{
   private String dsn="", usr="", pwd="";
   public JDBCConnectionPool( String driver, String dsn, String usr, String pwd )
   {
   	  Object o = (driver.getClass());
      try
      {
         Class.forName( driver ).newInstance();
      }
      catch( Exception e )
      {
         e.printStackTrace();
      }
      this.dsn = dsn;
      this.usr = usr;
      this.pwd = pwd;
   }
   public Connection borrowConnection()
   {
      return( ( Connection ) super.checkOut() );
   }
   public void returnConnection( Connection c )
   {
      super.checkIn( c );
   }
	Object create() {
		try
		   {
				return( DriverManager.getConnection( dsn, usr, pwd ) );
		   }
		   catch( SQLException e )
		   {
		      e.printStackTrace();
		      return( null );
		   }
	}
	void expire(Object o) {
		 try
		   {
		      ( ( Connection ) o ).close();
		   }
		   catch( SQLException e )
		   {
		      e.printStackTrace();
		   }
	}
	boolean validate(Object o) {
		try
		   {
		      return( ! ( ( Connection ) o ).isClosed() );
		   }
		   catch( SQLException e )
		   {
		      e.printStackTrace();
		      return( false );
		   }
	}
}