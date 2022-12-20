<%@ page import ="nic.watersoft.commons.*,java.util.*,java.sql.*"%>
<%@ include file = "conn.jsp" %>

<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String st[]=new String[40];
	int Count,Cnt;
			
	String query = null;
	

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 String repcode=request.getParameter("repname");
 
 String	Consti = request.getParameter("cons");
 String fyr=request.getParameter("finyear");
 int a=0; 
String assetType=request.getParameter("assetType");

String ATName=null;
if(assetType!=null)
{
if(assetType.equals("01")){ATName="PWS";}
else if(assetType.equals("02")){ATName="MPWS";} 
else if(assetType.equals("03")){ATName="CPWS";}
else if(assetType.equals("04")){ATName="HANDPUMPS";}
session.setAttribute("atname",ATName);
}
else
session.setAttribute("atname",null);
// //System.out.println("assetType="+assetType); 
String q1="";
String names[] = request.getParameterValues("ch");
if(names != null)
{
	String[] w1=new String[names.length];	
	// //System.out.println("MMMMM   "  +names.length);
	for (int i=0; i < names.length; i++)
	{
		// //System.out.println(names[i]);
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		// //System.out.println("YYYYYYYY   "+sr1);
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		// //System.out.println("YYYYYYYY   "+sr2);
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
}
String q3="am.Asset_name" + " AS \"Asset Name \", PANCH_NAME "+ " AS \"Habitation\""+q1;
 ////System.out.println("query is "  +q3);		
try
{
		
 
if(!district.equals("0") && mandal.equals("0"))
 {
//query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name," + q3 +" from rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr, rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a where c.circle_office_code=substr(a.office_code,2,2) and sd.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and a.asset_code=am.asset_code  and substr(a.office_code,2,2)='" + district +"'";
query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name," + q3 +" from rws_circle_office_tbl c, rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr, rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a where c.circle_office_code=substr(a.office_code,2,2) and sd.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and pr.panch_code=am.hab_code  and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and a.asset_code=am.asset_code  and substr(a.office_code,2,2)='" + district +"'";



	
   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
	//query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c, rws_division_office_tbl d,rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a, rws_employee_tbl e where c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and  a.asset_code=am.asset_code and a.prepared_by=e.employee_code and substr(a.office_code,2,2)="+district+" and substr(a.office_code,4,1)="+mandal;
	query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c, rws_division_office_tbl d,rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a, rws_employee_tbl e where c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and pr.panch_code=am.hab_code  and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and  a.asset_code=am.asset_code and a.prepared_by=e.employee_code and substr(a.office_code,2,2)='" + district + "' and substr(a.office_code,4,1)='" + mandal +"'";

 }
 else
 {	
	// query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c, rws_division_office_tbl d,rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a, rws_employee_tbl e where c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and  a.asset_code=am.asset_code and a.prepared_by=e.employee_code and substr(a.office_code,2,2)="+district+" and substr(a.office_code,4,1)="+mandal+" and substr(a.office_code,5,2)="+panchayat;
	query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c, rws_division_office_tbl d,rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a, rws_employee_tbl e where c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and pr.panch_code=am.hab_code  and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and  a.asset_code=am.asset_code and a.prepared_by=e.employee_code and substr(a.office_code,2,2)='" + district +"' and substr(a.office_code,4,1)='" + mandal +"' and substr(a.office_code,5,2)='" + panchayat +"'";

 }
 String a1=" order by a.om_proposal_id";

if(assetType!=null)
	 {query=query+ " and am.type_of_asset_code="+assetType;}

/*if(!repcode.equals("0"))
	 { //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
	query=query+ " and  a.REP_CODE="+repcode;
	//System.out.println("ddQQQQQQQQQQQQQQQ     "+ query); }*/

if(!Consti.equals("0"))
	{
	query=query+" and substr(am.hab_code,3,3)="+Consti;
	}
if(!fyr.equals("0")&& fyr!=null)
	{
	query=query+" and a.FINANCIAL_YEAR='"+fyr+"'";
	}
	query=query+" "+a1;


 //System.out.println("uuuuuuuu   "+query);
 
}
catch(Exception e)
{
	//System.out.println("for enumeration "+e);
}

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
rs = stmt.executeQuery(query);
rs.last();
Count = rs.getRow();
rs.beforeFirst();
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
////System.out.println(" Count  is   "+Cnt);

try{
	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int j=0,c=1; j<Cnt;j++,c++)
	{
		colLabel[j]=rsm.getColumnLabel(c);
	}
	labelcol.add(colLabel);

	session.setAttribute("arrayLabel", labelcol);
	String[] record = null;
	ArrayList myList = new ArrayList();
	while(rs.next())
	{
		record = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
		record[z] = rs.getString(c);
		}
		myList.add(record);

	}

	session.setAttribute("arrayList", myList);
RwsOffices rw=new RwsOffices(ds);
session.setAttribute("RSet1",rw);

}catch(Exception e)
{
	//System.out.println("knk error is   "+e);
	//e.printStackTrace();
}
finally
{
	conn.close();
}
%>
<%@ include file = "rws_om_proposal_hab_rpt_temp.jsp" %>
