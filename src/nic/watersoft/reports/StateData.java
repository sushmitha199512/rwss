package nic.watersoft.reports;
import java.sql.*;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import javax.sql.DataSource;
import java.util.ArrayList;
import nic.watersoft.commons.Debug;

public class StateData 

{	
StateBean state=new StateBean();
public  static ArrayList getDistrictdisplays(DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	ArrayList districtdisplays=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select d.dcode,d.dname,count(m.mcode) from rws_district_tbl d,rws_mandal_tbl m  where d.dcode=m.dcode  " +
     		"  group by d.dcode,d.dname order by d.dcode";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	state.setDcode( rs.getString("dcode"));
	state.setDname(rs.getString("dname"));
    state.setMcount( rs.getInt(3));
    
districtdisplays.add(state);

}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return districtdisplays;
}


public  static ArrayList getPanchayatdisplays(DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	Statement stmt2=null;
	ResultSet rs2=null;
	String query;
	String query1;
	String query2;
	String query3;
	String discode;
	String mancode;
	ResultSet rs3=null;
	ResultSet rs4=null;
	Statement stmt4=null;
	int mcount = 0,pcount = 0,vcount=0,habcount = 0;
	Statement stmt3=null;
	ArrayList panchayatdisplays=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     stmt2=conn.createStatement() ;
     stmt3=conn.createStatement();
     stmt4=conn.createStatement() ;
    // query="select distinct p.pcode,p.pname,m.mcode,m.mname from rws_mandal_tbl m, rws_district_tbl d,rws_panchayat_tbl p where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and d.dcode='"+dcode+"' order by m.mcode,p.pcode ";
     query="select d.dcode,d.dname,count(m.mcode) from rws_district_tbl d,rws_mandal_tbl m  where d.dcode=m.dcode  group by d.dcode,d.dname order by d.dcode";
     rs=stmt.executeQuery(query);
     //Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	discode= rs.getString(1);
	//Debug.println("districtcode"+discode);
	state.setDcode(rs.getString(1));
	state.setDname(rs.getString(2));
    state.setMcount(rs.getInt(3));
    mcount+=rs.getInt(3);
    int count = 0;
    
    query1="select distinct d.dcode||m.mcode||p.pcode from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+discode+"'";
    
    rs2=stmt2.executeQuery(query1);
    //Debug.println("query1"+query1);
    count = 0;
    while(rs2.next())
    	
    {
    	
    	//state.setPcount(rs2.getInt(3) );
    		count ++;
    }
    pcount +=count;
    state.setPcount(count);
    query2="select distinct d.dcode||m.mcode||p.pcode||v.vcode from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+discode+"'";
    
    rs3=stmt3.executeQuery(query2);
    //Debug.println("query2"+query2);
    count = 0;
    while(rs3.next())
    {
    	//state.setVcount(rs3.getInt(3) );
    	count++;
    }
    vcount +=count;
    state.setVcount(count);
    query3="select d.dcode,d.dname,count(h.hab_code) from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.coverage_status <> 'UI' and h.coverage_status is not null and substr (h.hab_code,1,2)='"+discode+"' and h.hab_code=pr.panch_code and d.dcode=m.dcode and    m.mcode=p.mcode and	m.dcode=p.dcode and	v.dcode=d.dcode and	v.mcode=m.mcode and	v.pcode=p.pcode and	 substr(h.hab_code,1,2)=d.dcode and	substr(h.hab_code,6,2)=m.mcode and	substr(h.hab_code,13,2)=p.pcode and substr(h.hab_code,8,3)=v.vcode group by d.dcode,d.dname order by d.dcode ";
	query3 = "select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+discode+"'"; 
    
        //query3="select d.dcode,d.dname,count(pr.panch_code) from rws_district_tbl d,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl rh  where pr.panch_code=rh.hab_code and d.dcode='"+discode+"' and substr(pr.panch_code,1,2)='"+discode+"' and substr(pr.panch_code,1,2)=d.dcode and pr.panch_code=rh.hab_code and rh.coverage_status <> 'UI' group by d.dcode,d.dname order by d.dcode";
    //Debug.println("asdfasdss");
    //Debug.println(query3);
    rs4=stmt4.executeQuery(query3);
    ///Debug.println("query3"+query3);
    count = 0;
    while(rs4.next())
    {
    	//state.setPanchcount( rs4.getInt(1));
    	count ++;
    }
    habcount +=count;
    state.setPanchcount(count);
    state.setTotalMcount(mcount);
    state.setTotalPcount(pcount);
    state.setTotalVcount(vcount);
    state.setTotalHabcount(habcount);
    panchayatdisplays.add(state);
   }
//state=new StateBean();

//panchayatdisplays.add(state);

//Debug.println("mcount:"+mcount);
//Debug.println("pcount:"+pcount);
//Debug.println("vcount:"+vcount);
//Debug.println("habcount:"+habcount);
}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return panchayatdisplays;
}

public  static ArrayList getMandal(String districtcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	
	
	ArrayList mandaldisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     
     query="select distinct mcode,mname from rws_mandal_tbl where dcode='"+districtcode+"' order by mcode";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	
	
	state.setMcode(rs.getString(1));
	state.setMname(rs.getString(2));
    
    
    
    
    mandaldisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return mandaldisplay;
}

//
public  static ArrayList getMandalSearch(String sea,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	String sea1=sea.toUpperCase();
	
	
	
	ArrayList mandaldisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     
     query="select d.dcode,d.dname,m.mcode,m.mname from rws_mandal_tbl m,rws_district_tbl d " +
     	" where d.dcode=m.dcode and  mname like '"+sea1+"%'  order by d.dcode,m.mcode";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	
	state.setDistrictCode(rs.getString(1));
	state.setDistrictName(rs.getString(2));
	state.setMandalCode(rs.getString(3));
	state.setMandalName(rs.getString(4));
    
    
    
    
    mandaldisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return mandaldisplay;
}
//
public  static ArrayList getPanchayatSearch(String sea,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	String sea1=sea.toUpperCase();
	
	
	
	ArrayList panchayatdisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     
     query="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname from rws_mandal_tbl m,rws_district_tbl d,rws_panchayat_tbl p " +
     	" where d.dcode=m.dcode and d.dcode=p.dcode and m.mcode=p.mcode and  pname like '"+sea1+"%'  order by d.dcode,m.mcode,p.pcode ";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	
	state.setDistrictCode(rs.getString(1));
	state.setDistrictName(rs.getString(2));
	state.setMandalCode(rs.getString(3));
	state.setMandalName(rs.getString(4));
	state.setPanchayatCode(rs.getString(5));
	state.setPanchayatName(rs.getString(6));
    
    
    
    
    panchayatdisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return panchayatdisplay;
}
//
public  static ArrayList getVillageSearch(String sea,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	String sea1=sea.toUpperCase();
	
	
	
	ArrayList villagedisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     
     query="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m,rws_district_tbl d,rws_panchayat_tbl p,rws_village_tbl v " +
     	" where d.dcode=m.dcode and d.dcode=p.dcode and m.mcode=p.mcode and d.dcode=v.dcode and m.mcode=v.mcode and p.pcode=v.pcode and    	" +
		
     	"v.vname like '"+sea1+"%'  order by d.dcode,m.mcode,p.pcode,v.vcode ";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	
	state.setDistrictCode(rs.getString(1));
	state.setDistrictName(rs.getString(2));
	state.setMandalCode(rs.getString(3));
	state.setMandalName(rs.getString(4));
	state.setPanchayatCode(rs.getString(5));
	state.setPanchayatName(rs.getString(6));
	state.setVillageCode(rs.getString(7));
	state.setVillageName(rs.getString(8));
    
    
    
    
    villagedisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return villagedisplay;
}

//
//

//
public  static ArrayList getPanchayat(String districtcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	
	
	ArrayList panchayatdisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select distinct p.pcode,p.pname,m.mcode,m.mname from rws_mandal_tbl m, rws_district_tbl d,rws_panchayat_tbl p where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and d.dcode='"+districtcode+"'  order by m.mcode,p.pcode ";
     //query="select distinct p.pcode,p.pname,m.mcode from rws_panchayat_tbl p,rws_mandal_tbl m  where m.mcode=p.mcode and p.dcode='"+districtcode+"' order by m.mcode";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	
	state.setMcode(rs.getString(3));
	state.setMname(rs.getString(4));
	state.setPcode(rs.getString(1));
	state.setPname(rs.getString(2));
    
    
    
    
    panchayatdisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return panchayatdisplay;
}


public  static ArrayList getVillage(String districtcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	
	
	ArrayList villagedisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select distinct v.vcode,v.vname,m.mcode,m.mname,p.pcode,p.pname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and d.dcode='"+districtcode+"' order by m.mcode,p.pcode,v.vcode  ";
     //query="select distinct v.vcode,v.vname,p.pcode from rws_village_tbl v,rws_mandal_tbl m,rws_panchayat_tbl p where v.dcode='"+districtcode+"' and m.mcode=p.mcode and m.mcode=v.mcode and p.pcode=v.pcode   order by p.pcode";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	
	state.setMcode(rs.getString(3));
	state.setMname(rs.getString(4));
	state.setPcode(rs.getString(5));
	state.setPname(rs.getString(6));
	state.setVcode(rs.getString(1));
	state.setVname(rs.getString(2));
    
    
    
    
    villagedisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return villagedisplay;
}



public  static ArrayList getHabitation(String districtcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	
	ArrayList habitationdisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where     d.dcode=m.dcode and	 m.dcode=p.dcode and  "+
	 "m.mcode=p.mcode and  "+
	 "p.pcode=v.pcode and  "+
	 "p.dcode=v.dcode and  "+
	 "v.mcode=m.mcode and  "+
	 "substr(pr.panch_code,1,2)=d.dcode and  "+
	 "substr(pr.panch_code,6,2)=m.mcode and  "+
	 "substr(pr.panch_code,8,3)=v.vcode and  "+
	 "substr(pr.panch_code,13,2)=p.pcode and  "+
	 "substr(h.hab_code,1,2)=d.dcode and  "+
	 "substr(h.hab_code,6,2)=m.mcode and  "+
	 "substr(h.hab_code,8,3)=v.vcode and  "+
	 "substr(h.hab_code,13,2)=p.pcode and  "+
	 "substr(pr.panch_code,1,2)='"+districtcode+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by m.mcode,p.pcode,v.vcode,pr.panch_code";
     Debug.println("query"+query);
     
     //query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and substr(pr.panch_code,1,2)='"+districtcode+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code and substr(h.hab_code,1,2)=d.dcode  order by m.mcode,p.pcode,v.vcode,pr.panch_code      ";
    // query="select distinct p.panch_code,p.panch_name from rws_panchayat_raj_tbl p,rws_habitation_directory_tbl h where p.panch_code=h.hab_code and h.coverage_status <> 'UI' AND substr(panch_code,1,2)='"+districtcode+"'";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	state.setMcode(rs.getString(3));
	state.setMname(rs.getString(4));
	state.setPcode(rs.getString(5));
	state.setPname(rs.getString(6));
	state.setVcode(rs.getString(7));
	state.setVname(rs.getString(8));
	
	state.setPanchcode(rs.getString(1));
	state.setPanchname(rs.getString(2));
	
    
    
    
    
    habitationdisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return habitationdisplay;
}
//
public  static ArrayList getHabitationSearch(String sea,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String sea1=sea.toUpperCase();
	String query;
	
	
	ArrayList habitationdisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,d.dcode,d.dname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where     d.dcode=m.dcode and	 m.dcode=p.dcode and  "+
	 "m.mcode=p.mcode and  "+
	 "p.pcode=v.pcode and  "+
	 "p.dcode=v.dcode and  "+
	 "v.mcode=m.mcode and  "+
	 "substr(pr.panch_code,1,2)=d.dcode and  "+
	 "substr(pr.panch_code,6,2)=m.mcode and  "+
	 "substr(pr.panch_code,8,3)=v.vcode and  "+
	 "substr(pr.panch_code,13,2)=p.pcode and  "+
	 "substr(h.hab_code,1,2)=d.dcode and  "+
	 "substr(h.hab_code,6,2)=m.mcode and  "+
	 "substr(h.hab_code,8,3)=v.vcode and  "+
	 "substr(h.hab_code,13,2)=p.pcode and  "+
	 "pr.panch_name like '"+sea1+"%' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by d.dcode,m.mcode,p.pcode,v.vcode,pr.panch_code";
     Debug.println("query"+query);
     
     //query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and substr(pr.panch_code,1,2)='"+districtcode+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code and substr(h.hab_code,1,2)=d.dcode  order by m.mcode,p.pcode,v.vcode,pr.panch_code      ";
    // query="select distinct p.panch_code,p.panch_name from rws_panchayat_raj_tbl p,rws_habitation_directory_tbl h where p.panch_code=h.hab_code and h.coverage_status <> 'UI' AND substr(panch_code,1,2)='"+districtcode+"'";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	state.setDistrictCode(rs.getString(9));
	state.setDistrictName(rs.getString(10));
	state.setMandalCode(rs.getString(3));
	state.setMandalName(rs.getString(4));
	state.setPanchayatCode(rs.getString(5));
	state.setPanchayatName(rs.getString(6));
	state.setVillageCode(rs.getString(7));
	state.setVillageName(rs.getString(8));
	
	state.setPanchCode(rs.getString(1));
	state.setPanchName(rs.getString(2));
	
    
    
    
    
    habitationdisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return habitationdisplay;
}

//
//
public  static ArrayList getHabitationd(String districtcode,String mcode,String pcode,String vcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String query;
	
	
	ArrayList habitationdisplay=new ArrayList();
	int rowCount=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where     d.dcode=m.dcode and	 m.dcode=p.dcode and  "+
	 "m.mcode=p.mcode and  "+
	 "p.pcode=v.pcode and  "+
	 "p.dcode=v.dcode and  "+
	 "v.mcode=m.mcode and  "+
	 "substr(pr.panch_code,1,2)=d.dcode and  "+
	 "substr(pr.panch_code,6,2)=m.mcode and  "+
	 "substr(pr.panch_code,8,3)=v.vcode and  "+
	 "substr(pr.panch_code,13,2)=p.pcode and  "+
	 "substr(h.hab_code,1,2)=d.dcode and  "+
	 "substr(h.hab_code,6,2)=m.mcode and  "+
	 "substr(h.hab_code,8,3)=v.vcode and  "+
	 "substr(h.hab_code,13,2)=p.pcode and  "+
	 "substr(pr.panch_code,1,2)='"+districtcode+"' and substr(pr.panch_code,6,2)='"+mcode+"' and substr(pr.panch_code,13,2)='"+pcode+"' and substr(pr.panch_code,8,3)='"+vcode+"' and  h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by m.mcode,p.pcode,v.vcode,pr.panch_code";
     Debug.println("query"+query);
     
     //query="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.pcode=v.pcode and p.dcode=v.dcode and v.mcode=m.mcode and substr(pr.panch_code,1,2)='"+districtcode+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code and substr(h.hab_code,1,2)=d.dcode  order by m.mcode,p.pcode,v.vcode,pr.panch_code      ";
    // query="select distinct p.panch_code,p.panch_name from rws_panchayat_raj_tbl p,rws_habitation_directory_tbl h where p.panch_code=h.hab_code and h.coverage_status <> 'UI' AND substr(panch_code,1,2)='"+districtcode+"'";
     rs=stmt.executeQuery(query);
     Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
	state.setMcode(rs.getString(3));
	state.setMname(rs.getString(4));
	state.setPcode(rs.getString(5));
	state.setPname(rs.getString(6));
	state.setVcode(rs.getString(7));
	state.setVname(rs.getString(8));
	
	state.setPanchcode(rs.getString(1));
	state.setPanchname(rs.getString(2));
	
    
    
    
    
    habitationdisplay.add(state);
}




}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return habitationdisplay;
}


//
















public  static ArrayList getDistricts(DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ArrayList districts=new ArrayList();
	int rowCount=0;
	String query="";
	int s;
	int t=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select  count(*),d.dname,d.dcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_district_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code  and d.dcode=b.circle_office_code and b.type_of_asset_code=a.type_of_asset_code  group by d.dname,d.dcode order by d.dcode "; 

    rs=stmt.executeQuery(query);
while(rs.next())
{
	state=new StateBean();
   
	state.setDcode(rs.getString("dcode"));
	state.setDname(rs.getString("dname"));
	state.setDcount(rs.getInt(1));
   

districts.add(state);
}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return districts;
}










public  static ArrayList getMandals(String dcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ArrayList mandals=new ArrayList();
	int rowCount=0;
	String query="";
	int s;
	int t=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select  count(*),d.mname,d.mcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_mandal_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code   and b.type_of_asset_code=a.type_of_asset_code and substr(s.scheme_code,6,2)=d.mcode and substr(s.scheme_code,1,2)=d.dcode and d.dcode='" + dcode + "' group by d.mname,d.mcode order by d.mcode "; 

    rs=stmt.executeQuery(query);
    Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
   
	state.setMcode(rs.getString("mcode"));
	state.setMname(rs.getString("mname"));
	Debug.println("p");
	state.setMcount(rs.getInt(1));
	Debug.println("state"+state.getMcount( ));
   

mandals.add(state);
}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return mandals;
}



public  static ArrayList getPanchayats(String dcode,String mcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ArrayList panchayats=new ArrayList();
	int rowCount=0;
	String query="";
	int s;
	int t=0;
try {
     conn = dataSource.getConnection();
     stmt = conn.createStatement();
     query="select  count(*),d.pname,d.pcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code  and d.dcode='"+dcode+"' and substr(s.scheme_code,1,2)=d.dcode and  substr(s.scheme_code,6,2)=d.mcode and d.mcode='"+mcode+"'  and b.type_of_asset_code=a.type_of_asset_code  and substr(s.scheme_code,13,2)=d.pcode  group by d.pname,d.pcode order by d.pcode "; 
 

    rs=stmt.executeQuery(query);
    Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
   
	state.setPcode(rs.getString("pcode"));
	state.setPname(rs.getString("pname"));
	Debug.println("p");
	state.setPcount(rs.getInt(1));
	Debug.println("state"+state.getMcount( ));
   

panchayats.add(state);
}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return panchayats;
}

public  static ArrayList getVillages(String dcode,String mcode,String pcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ArrayList villages=new ArrayList();
	int rowCount=0;
	String query="";
	int s;
	int t=0;
try {
    conn = dataSource.getConnection();
    stmt = conn.createStatement();
    query="select  count(*),d.vname,d.vcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_village_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code  and  substr(s.scheme_code,1,2)=d.dcode and d.dcode='"+dcode+"' and substr(s.scheme_code,6,2)=d.mcode and d.mcode='"+mcode+ "' and  substr(s.scheme_code,13,2)=d.pcode and d.pcode='"+pcode+"'  and b.type_of_asset_code=a.type_of_asset_code and substr(s.scheme_code,8,3)=d.vcode group by d.vname,d.vcode order by d.vcode ";
    rs=stmt.executeQuery(query);
    Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
   
	state.setVcode(rs.getString("vcode"));
	state.setVname(rs.getString("vname"));
	state.setVcount(rs.getInt(1));
	Debug.println("p");
	
	villages.add(state);
	
}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return villages;
}


public  static ArrayList getPanch(String dcode,String mcode,String pcode,String vcode,DataSource dataSource)
throws Exception {   
	StateBean state=null;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ArrayList panch=new ArrayList();
	int rowCount=0;
	String query="";
	int s;
	int t=0;
try {
    conn = dataSource.getConnection();
    stmt = conn.createStatement();
    query="select  count(*),d.panch_code,d.panch_name,b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code and substr(s.scheme_code,1,2)='"+dcode+"' and substr(s.scheme_code,6,2)='"+mcode+"' and  substr(s.scheme_code,13,2)='"+pcode+"'  and b.type_of_asset_code=a.type_of_asset_code and substr(s.scheme_code,8,3)='"+vcode+"' and  substr(s.scheme_code,1,16)=panch_code group by d.panch_code,d.panch_name,b.asset_code order by d.panch_code ";
    rs=stmt.executeQuery(query);
    Debug.println("query"+query);
while(rs.next())
{
	state=new StateBean();
   
	state.setPanchcode(rs.getString("panch_code"));
	state.setPanchname(rs.getString("panch_name"));
	state.setPanchcount(rs.getInt(1));
	state.setAsset( rs.getString(4));
	Debug.println("p");
	
	panch.add(state);
	
}

}
catch (Exception e)
{
Debug.println(e.getMessage());
}

finally {
	if(rs!=null)
	{
		rs.close();
	}
	if(stmt!=null)
	{
		stmt.close();
		
	}
	if(conn!=null)
	{
		conn.close();
		
	}
}
return panch;
}




public static int getPanchcount(String dcode,String mcode,String pcode,String vcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  
  int s=0;
  int t;
  
  query="select  count(*),d.panch_code,d.panch_name,b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code and substr(s.scheme_code,1,2)='"+dcode+"' and substr(s.scheme_code,6,2)='"+mcode+"' and  substr(s.scheme_code,13,2)='"+pcode+"'  and b.type_of_asset_code=a.type_of_asset_code and substr(s.scheme_code,8,3)='"+vcode+"' and  substr(s.scheme_code,1,16)=panch_code group by d.panch_code,d.panch_name,b.asset_code order by d.panch_code ";
   
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(1);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
   	
   	
   
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}



}

public static String getDistrictname(String dcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;

String message=null;

try {
 
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  
  String distname=null;
    
  query="select dname from rws_district_tbl where dcode='"+dcode+"'"; 
   
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	
  	distname=rs.getString(1);
  	
  }
   	
   	
   
  
  return distname;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}



}



























public static int getPCount(String dcode,String mcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  
  int s=0;
  int t;
  
  query="select  count(*),d.pname,d.pcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code  and  substr(s.scheme_code,1,2)=d.dcode and  d.dcode='"+dcode+"' and substr(s.scheme_code,6,2)=d.mcode and d.mcode='"+mcode+"'   and b.type_of_asset_code=a.type_of_asset_code  and substr(s.scheme_code,13,2)=d.pcode  group by d.pname,d.pcode order by d.pcode "; 
 
   
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(1);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
   	
   	
   
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}



}


public static int getManCount(String dcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  
  int s=0;
  int t;
  
  query="select d.dcode,d.dname,count(m.mcode) from rws_district_tbl d,rws_mandal_tbl m  where d.dcode=m.dcode  group by d.dcode,d.dname order 	by d.dcode"; 
  
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(3);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
   	
   	
   
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}



}


public static int getPanCount(DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query1;
  
  int s=0;
  int t;
  
  query1="select d.dcode,d.dname,count(p.pcode) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p  where d.dcode=m.dcode and d.dcode=p.dcode and p.mcode=m.mcode  group by d.dcode,d.dname order by d.dcode";
 
  
  rs=stmt.executeQuery(query1);
  Debug.println("Query"+query1);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(3);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
   	
   	
   
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}
}
public static int getVillCount(DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query2;
  
  int s=0;
  int t;
  query2="select d.dcode,d.dname,count(v.vcode) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v  where d.dcode=m.dcode and d.dcode=p.dcode and p.mcode=m.mcode and  v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode   group by d.dcode,d.dname order by d.dcode";
  rs=stmt.executeQuery(query2);
  Debug.println("Query"+query2);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(3);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}
}
public static int getPanchCount(DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query3;
  
  int s=0;
  int t;
  query3="select d.dcode,d.dname,count(h.hab_code) from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.coverage_status <> 'UI' and h.coverage_status is not null and  h.hab_code=pr.panch_code and  substr(h.hab_code,1,2)=d.dcode and d.dcode=m.dcode and m.mcode=p.mcode and m.dcode=p.dcode and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and substr(h.hab_code,1,2)=d.dcode and substr(h.hab_code,6,2) =m.mcode and substr(h.hab_code,13,2)=p.pcode and substr(h.hab_code,8,3) =v.vcode group by d.dcode,d.dname order by d.dcode";
  //query3="select d.dcode,d.dname,count(pr.panch_code) from rws_district_tbl d,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl rh where pr.panch_code=rh.hab_code and rh.coverage_status <> 'UI' and rh.coverage_status is not null and  substr(pr.panch_code,1,2)=d.dcode group by d.dcode,d.dname order by d.dcode";
  Debug.println("Query000----"+query3);
  rs=stmt.executeQuery(query3);
  
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(3);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  }
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}
}
public static int getVCO(String dcode,String mcode,String pcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  int s=0;
  int t;
  query="select  count(*),d.vname,d.vcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_village_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code  and  substr(s.scheme_code,1,2)=d.dcode and d.dcode='"+dcode+"' and substr(s.scheme_code,6,2)=d.mcode and d.mcode='"+mcode+"' and  substr(s.scheme_code,13,2)=d.pcode and d.pcode='"+pcode+"' and b.type_of_asset_code=a.type_of_asset_code and substr(s.scheme_code,8,3)=d.vcode group by d.vname,d.vcode order by d.vcode ";
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(1);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}

}
public static int getCount(DataSource dataSource)
	    throws Exception {
		Debug.println("func1");
	    Connection conn = null;
	    Debug.println("func2");
	    Statement stmt = null;
	    ResultSet rs = null;
	    int rcount;
	    String message=null;

	    try {
         Debug.println("func3");
	      conn = dataSource.getConnection();
	      stmt = conn.createStatement();
	      String query;
	      
	      int s=0;
	      int t;
	      
	      query="select  count(*),d.dname,d.dcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_district_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code   and b.type_of_asset_code=a.type_of_asset_code and d.dcode=b.circle_office_code  group by d.dname,d.dcode order by d.dcode "; 
           
	      rs=stmt.executeQuery(query);
	      Debug.println("Query"+query);
	      while(rs.next())
	      {
	      	Debug.println("While(rs.next()"+rs.getInt(1));
	      	t=rs.getInt(1);
	      	Debug.println("Total"+t);
	      	s=s+t;
	      	Debug.println("Sum"+s);
	      	Debug.println( "Total"+s);
	      }
	      Debug.println("s value in"+s);
	      return s;	     
	    }
	    finally {

	      if ( rs != null ) {

	        rs.close();
	      }
	      if ( stmt != null ) {

	        stmt.close();
	      }

	      if ( conn != null ) {

	        conn.close();
	      }
	    }
	    
	   
	   
}
public static int getCount1(String dcode,DataSource dataSource)
throws Exception {
Debug.println("func1");
Connection conn = null;
Debug.println("func2");
Statement stmt = null;
ResultSet rs = null;
int rcount;
String message=null;

try {
 Debug.println("func3");
  conn = dataSource.getConnection();
  stmt = conn.createStatement();
  String query;
  
  int s=0;
  int t;
  
  query="select  count(*),d.mname,d.mcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_mandal_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='01' and b.asset_code=s.asset_code   and b.type_of_asset_code=a.type_of_asset_code and d.mcode=substr(s.scheme_code,6,2) and d.dcode=substr(s.scheme_code,1,2) and d.dcode='" + dcode + "' group by d.mname,d.mcode order by d.mcode "; 
   
  rs=stmt.executeQuery(query);
  Debug.println("Query"+query);
  while(rs.next())
  {
  	Debug.println("While(rs.next()"+rs.getInt(1));
  	t=rs.getInt(1);
  	Debug.println("Total"+t);
  	s=s+t;
  	Debug.println("Sum"+s);
  	Debug.println( "Total"+s);
  	
  }
   	
   	
   
  Debug.println("s value in"+s);
  return s;	     
}
finally {

  if ( rs != null ) {

    rs.close();
  }
  if ( stmt != null ) {

    stmt.close();
  }

  if ( conn != null ) {

    conn.close();
  }
}
}
}







