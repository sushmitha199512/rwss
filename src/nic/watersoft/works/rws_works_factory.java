package nic.watersoft.works;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import javax.sql.DataSource;

public class rws_works_factory {
	public rws_works_factory (){}
  	public static WorksDAO createWorksDAO(DataSource ds){
  		Connection connection=null;
  		try	{
  			connection = RwsOffices.getConn();
		}
  		catch(Exception e){
  			System.out.println("The Exception is in rws_works_factory : "+e.getMessage());
		}
  		 return new rws_works_WorksDAO(connection);
    }
}
