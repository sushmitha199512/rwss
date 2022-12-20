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
/* String names[] = request.getParameterValues("ch");
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
}*/
String q3="Asset_name" + " AS \"Asset Name\", PANCH_NAME "+ " AS \"Habitation\"";
// //System.out.println("query is "  +q3);		
try
{
		
if(!district.equals("0") && mandal.equals("0"))
 {
//SELECT distinct c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, Asset_name AS "Asset Name", PANCH_NAME  AS "Habitation",  a.location, drill_year, diameter, casing, status, gen_condition, gi_no, painted, static_wl, summer_wl, p_cond, dry_during, service, ser_no, ser_hrs, repairs, platform_condition,drain, drain_condition, drain_sd, drain_lp, hygiene, avg_time, p_yeild, pyeild_local, period from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_HP_SUBCOMP_PARAM_TBL  ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code and rownum<200 and a.circle_office_code=04 and a.type_of_asset_code=04 order by a.asset_name;;

query="SELECT distinct c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+",  a.location, drill_year, diameter, casing, status, gen_condition, gi_no, painted, static_wl, summer_wl, p_cond, dry_during, service, ser_no, ser_hrs, repairs, platform_condition,drain, drain_condition, drain_sd, drain_lp, hygiene, avg_time, p_yeild, pyeild_local, period from rws_circle_office_tbl c, rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_HP_SUBCOMP_PARAM_TBL  ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code and rownum<200 and a.circle_office_code='"+district +"'";


   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {

query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+",  a.location, drill_year, diameter, casing, status, gen_condition, gi_no, painted, static_wl, summer_wl, p_cond, dry_during, service, ser_no, ser_hrs, repairs, platform_condition,drain, drain_condition, drain_sd, drain_lp, hygiene, avg_time, p_yeild, pyeild_local, period from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_HP_SUBCOMP_PARAM_TBL  ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code  and a.circle_office_code='" + district +"' and a.division_office_code="+mandal;

 }
 else
 {
query="SELECT  c.circle_office_name, d.division_office_name, sd.subdivision_office_name, a.type_of_asset_code, "+q3+",  a.location, drill_year, diameter, casing, status, gen_condition, gi_no, painted, static_wl, summer_wl, p_cond, dry_during, service, ser_no, ser_hrs, repairs, platform_condition,drain, drain_condition, drain_sd, drain_lp, hygiene, avg_time, p_yeild, pyeild_local, period from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_HP_SUBCOMP_PARAM_TBL  ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.hab_code=p.panch_code and a.asset_code=ac.asset_code  and a.circle_office_code='"+district+"' and a.division_office_code='"+mandal+"' and a.subdivision_office_code='"+panchayat+"'";

/*query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, rws_asset_hab_tbl h, RWS_ASSET_SUBCOMP_PARAM_TBL ac where a.hab_code=h.hab_code and a.hab_code=p.panch_code and h.hab_code=p.panch_code and a.asset_code=ac.asset_code and a.asset_code=h.asset_code and ac.asset_code=h.asset_code";*/

 }
 String a1=" order by a.asset_name";
 if(assetType!=null)
	 {// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
	query=query+ " and a.type_of_asset_code="+assetType;}

 query=query+a1;
 //System.out.println("query     is "  +query);		
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
<%@ include file = "rws_asset_new_subcomp_temp1.jsp" %>
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