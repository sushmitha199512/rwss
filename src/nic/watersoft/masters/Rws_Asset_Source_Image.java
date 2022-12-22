package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import nic.watersoft.commons.RwsOffices;

public class Rws_Asset_Source_Image {
	public String getImageExist(String sourceCode){
		System.out.println("inside getImageExist");
		String message="";
		Connection connection=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			connection=RwsOffices.getConn();
			stmt=connection.createStatement();
			String query="select COMPONENT_IMAGE from RWS_ASSET_COMP_IMAGE_TBL where COMPONENT_CODE='"+sourceCode+"' and COMPONENT_IMAGE is not null";
			 rs=stmt.executeQuery(query);
			System.out.println(query);
			if(rs.next()){
				System.out.println("@@@@@@@@@");
				message="Exist";
			}
			else{
				message="Not Exist";
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return message;
		
	}

}
