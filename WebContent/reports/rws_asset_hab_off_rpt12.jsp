
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	int Count, Cnt;
	String query = null;
	ResultSetMetaData rsm=null;
 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
String pname=request.getParameter("pName");
// //System.out.println("PPPP NNNNNN  "+pname);

 
 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);
int a=0; 
String assetType=request.getParameter("assetType");

session.setAttribute("assetType",assetType);

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
String q3="Asset_name" + " AS \"Asset Name\", PANCH_NAME "+ " AS \"Habitation\""+q1;
// //System.out.println("query is "  +q3);		
try
{
		

if(!district.equals("0") && mandal.equals("0"))
 {
	
	//query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and d.division_office_code=am.division_office_code and sd.subdivision_office_code=am.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and ah.asset_code=am.asset_code and am.circle_office_code="+district;
	//query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, RWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and am.circle_office_code='"+district +"'";
	query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am, asset_hab1 ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"'";

	//System.out.println("panchayat="+  query);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
	//query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,tRWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and d.division_office_code=am.division_office_code and sd.subdivision_office_code=am.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=am.hab_code and am.circle_office_code="+district+" and am.division_office_code="+mandal;

	//query="SELECT  "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, RWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"'";
		query="SELECT  "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, ASSET_MAST1  am,asset_hab1 ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"'";
	

 }
 else
 {
	
	//query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+" from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,rws_panchayat_raj_tbl pr,rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and d.division_office_code=am.division_office_code and sd.subdivision_office_code=am.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=am.hab_code and am.circle_office_code="+district+" and am.division_office_code="+mandal+" and am.subdivision_office_code="+panchayat;
	
//query="SELECT distinct "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, RWS_ASSET_MAST_TBL  am where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"' and am.subdivision_office_code= '"+panchayat +"'";
//query="SELECT "+ q3 +" from  RWS_ASSET_MAST_TBL am, rws_panchayat_raj_tbl pr where am.hab_code = pr.panch_code and circle_office_code='"+district +"' and am.division_office_code='"		+ mandal +"' and subdivision_office_code= '"+panchayat +"'";
	query="SELECT  "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, ASSET_MAST1  am, asset_hab1 ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"' and am.subdivision_office_code = '" + panchayat + "'";


 }
// String a1=" order by am.asset_code";
 if(assetType!=null)
	{
	 query=query+" and am.type_of_asset_code="+ assetType;
	}
//	query = query + " and panch_name = 'GANGIRENIGUDEM'";
	query = query + " ORDER BY start_year";
 //query=query+a1;
 	//System.out.println("panchayat="+  query);
}
catch(Exception e)
{
	 //System.out.println("for enumeration "+e);
}
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(query);
		rs.last();
Count = rs.getRow();

// //System.out.println("Total Records = "+Count);
rs.beforeFirst();
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
 %>
 <%   // //System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhHHHHHHHH");
	if(Count!=0){

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
<%@ include file = "rws_asset_hab_off_rpt_temp.jsp" %>
	<%} else {  %>
	<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<body bgcolor="#edf2f8"><%	//out.println(query);%>

<TABLE bordercolor= navy width=100% height="100%" border=0 rules=none style="border-collapse:collapse" align = center valign=top>
<TR width=100% height="1%" valign=top>
<TD >

<table border=0 align=center height="70%" width="100%">
<tr><td align="center" class="mystyle"><font color="navy">There are No Records </font></td></tr>
</table>
</TD></TR>	
</body>
</html>
<%}%>