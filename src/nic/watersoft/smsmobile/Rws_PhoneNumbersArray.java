package nic.watersoft.smsmobile;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;



public class Rws_PhoneNumbersArray {
	
	
	
	
	
	
	public ArrayList<String> getPhoneNumbers(String habcode)
	{
		ArrayList<String> phonenumbers=new ArrayList<String>();
		Statement stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null;
		ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
		String query="",qry1="",qry2="",qry3="",qry4="";
		Connection conn=null;
		try
		{
			
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			 //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.137:1521:orcl","aprwssuser","aprwssuser");
			 conn=DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft","aprwssuser","aprwssuser");
		//	phonenumbers.add("9989274858");
			//phonenumbers.add("9440440672");
			//phonenumbers.add("8019949854");
			//phonenumbers.add("9177079613");
			
			String dcode=habcode.substring(0, 2);
			String mcode=habcode.substring(5, 7);
			String pcode=habcode.substring(12, 14);
			
			
			
			
			stmt=conn.createStatement();
			query="select MOBILE_NO from RWS_MRO_MPDO_TBL where dcode='"+dcode+"'  and mcode='"+mcode+"' and mobile_no is not null ";


			rs=stmt.executeQuery(query);
			while(rs.next())
			{
				phonenumbers.add(rs.getString(1));
				
				
			}
			rs.close();
			stmt.close();
			
			
			stmt4=conn.createStatement();
			qry4="SELECT DLPO_MOBILE FROM RWS_DLPO_TBL  a,RWS_DLPO_DIVISION_TBL  b where a.CIRCLE_OFFICE_CODE =b.CIRCLE_OFFICE_CODE and a.division_office_code=b.division_office_code and   a.circle_office_code='"+dcode+"' and b.mcode='"+mcode+"'";
			rs4=stmt4.executeQuery(qry4);
			while(rs4.next())
			{
				phonenumbers.add(rs4.getString(1));
			}
			rs4.close();
			stmt4.close();
			
			
			
			
			stmt1=conn.createStatement();
			qry1="select MOBILE_NO from RWS_PANCHAYAT_SARPANCH_TBL where substr(LOCATION,1,2)='"+dcode+"' and substr(LOCATION,3,2)='"+mcode+"' and substr(LOCATION,5,2)='"+pcode+"' and mobile_no is not null ";
			
			rs1=stmt1.executeQuery(qry1);
			while(rs1.next())
			{
				phonenumbers.add(rs1.getString(1));
				
				
			}
			
			rs1.close();
			stmt1.close();
			
			stmt3=conn.createStatement();
			qry3="select DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE  from  rws_mandal_subdivision_tbl  where dcode='"+dcode+"' and mcode='"+mcode+"'  ";
			
			rs3=stmt3.executeQuery(qry3);
			while(rs3.next())
			{
				String divcode=rs3.getString(1);
				String subdivcode=rs3.getString(2);
				
				String officecode=1+dcode+divcode+subdivcode;
				stmt2=conn.createStatement();
				String  qrydlpo="select DLPO_MOBILE from rws_dlpo_tbl where circle_office_code='"+dcode+"' and division_office_code='"+divcode+"' ";
				rs2=stmt2.executeQuery(qrydlpo);
				while(rs2.next())
				{
					phonenumbers.add(rs2.getString(1));
				}
				rs2.close();
				stmt2.close();
				
				
				
				
				stmt2=conn.createStatement();
			qry2="select PHONE  from  RWS_OFFICE_TBL where office_code='"+officecode+"'  and PHONE is not null ";
			
			rs2=stmt2.executeQuery(qry2);
			
			
			while(rs2.next())
			{
				phonenumbers.add(rs2.getString(1));
				
				
			}
			rs2.close();
			stmt2.close();
			
			
			stmt=conn.createStatement();
			query="select MOBILE from rws_employee_tbl where OFFICE_CODE='"+officecode+"'  and mobile is not null ";


			rs=stmt.executeQuery(query);
			while(rs.next())
			{
				phonenumbers.add(rs.getString(1));
				
				
			}
			rs.close();
			stmt.close();
			
			
			
			
			}
			
			rs3.close();
			stmt3.close();
			
			
			
			
			
			
			
			
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	
		
		
		return phonenumbers;
		
	}
	
	
	public ArrayList<String> getPhoneNumbers1(String habcode)
	{
		//System.out.println("inphonenumbers");
		ArrayList<String> phonenumbers1=new ArrayList<String>();
		Statement stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
		ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
		String query="",qry1="",qry2="",qry3="",qry4="",qry5="";
		Connection conn=null;
		try
		{
			String dcode=habcode.substring(0, 2);
			String mcode=habcode.substring(5, 7);
			String pcode=habcode.substring(12, 14);
			
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			 //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.137:1521:orcl","aprwssuser","aprwssuser");
			 conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
			stmt=conn.createStatement();
			query="select MOBILE_NO from RWS_MRO_MPDO_TBL where dcode='"+dcode+"'  and mcode='"+mcode+"' and mobile_no is not null ";


			rs=stmt.executeQuery(query);
			while(rs.next())
			{
				phonenumbers1.add(rs.getString(1));
				//System.out.println("1----------"+rs.getString(1));
				
			}
			
			rs.close();
			stmt.close();
			
			stmt5=conn.createStatement();
			qry5="SELECT DLPO_MOBILE FROM RWS_DLPO_TBL  a,RWS_DLPO_DIVISION_TBL  b where a.CIRCLE_OFFICE_CODE =b.CIRCLE_OFFICE_CODE and a.division_office_code=b.division_office_code  and a.circle_office_code='"+dcode+"' and b.mcode='"+mcode+"'";
			rs5=stmt5.executeQuery(qry5);
			while(rs5.next())
			{
				phonenumbers1.add(rs5.getString(1));
			}
			rs5.close();
			stmt5.close();
			
			
			
			stmt1=conn.createStatement();
			qry1="select MOBILE_NO from RWS_PANCHAYAT_SARPANCH_TBL where substr(LOCATION,1,2)='"+dcode+"' and substr(LOCATION,3,2)='"+mcode+"' and substr(LOCATION,5,2)='"+pcode+"' and mobile_no is not null ";
			
			rs1=stmt1.executeQuery(qry1); 
			while(rs1.next())
			{
				phonenumbers1.add(rs1.getString(1));
				//System.out.println("2----------"+rs1.getString(1));
				
				
			}
			
			rs1.close();
			stmt1.close();
			
			stmt4=conn.createStatement();
			qry4="select MOBILE from RWS_MOBILE_SMS_REGISTER_TBL where   Habitation_code='"+habcode+"'";
			rs4=stmt4.executeQuery(qry4);
			//System.out.println("qry4"+qry4);
			if(rs4.next())
			{
			
				phonenumbers1.add(rs4.getString(1));
				//System.out.println("3----------"+rs4.getString(1));
			
			}
			
			rs4.close();
			stmt4.close();
			
			
			//System.out.println("smsphone222222");
			stmt3=conn.createStatement();
			qry3="select DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE  from  rws_mandal_subdivision_tbl  where dcode='"+dcode+"' and mcode='"+mcode+"'  ";
			
			rs3=stmt3.executeQuery(qry3);
			while(rs3.next())
			{
				String divcode=rs3.getString(1);
				String subdivcode=rs3.getString(2);
			
			
				String officecode=1+dcode+divcode+subdivcode;
			
				
				stmt2=conn.createStatement();
				String  qrydlpo="select DLPO_MOBILE from rws_dlpo_tbl where circle_office_code='"+dcode+"' and division_office_code='"+divcode+"' ";
				rs2=stmt2.executeQuery(qrydlpo);
				while(rs2.next())
				{
					phonenumbers1.add(rs2.getString(1));
				}
				rs2.close();
				stmt2.close();
				
				
				stmt2=conn.createStatement();
			qry2="select PHONE  from  RWS_OFFICE_TBL where office_code='"+officecode+"'  and PHONE is not null ";
			
			rs2=stmt2.executeQuery(qry2);
			
			
			while(rs2.next())
			{
				phonenumbers1.add(rs2.getString(1));
				//System.out.println("4----------"+rs2.getString(1));
				
			}
			rs2.close();
			stmt2.close();
			
			
			
			stmt=conn.createStatement();
			query="select MOBILE from rws_employee_tbl where OFFICE_CODE='"+officecode+"'  and mobile is not null ";


			rs=stmt.executeQuery(query);
			while(rs.next())
			{
				phonenumbers1.add(rs.getString(1));
				//System.out.println("5----------"+rs.getString(1));
				
			}
			rs.close();
			stmt.close();
			
			
			
			
			}	
			
			rs3.close();
			stmt3.close();
			
			
			
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	
		
		
		return phonenumbers1;
		
	}
	
	
	


}
