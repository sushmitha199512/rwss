
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	int Count, Cnt;
	String query = null;
	String query1 = null;
	ResultSetMetaData rsm=null;

	String districtcode;
	String mandalcode;
	String panchayatcode;

  String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");

 if(district==null && mandal==null && panchayat==null)
 {
	 
   districtcode=request.getParameter("districtcode");
   mandalcode=request.getParameter("mandalcode");
   panchayatcode=request.getParameter("panchayatcode");
    session.setAttribute("panchayatcode",panchayatcode); 
	String panchayatname=request.getParameter("panchayatname");
	session.setAttribute("panchyatname",panchayatname); 

 }
 else
 {
	 districtcode = district;
	 mandalcode = mandal;
	 panchayatcode=panchayat;
 }
	
/* System.out.println("((((((((((((((("+pName);
if(pName!=null)
 {
   pName = (String)session.getAttribute("pName");
 }
 else
 {
	pName=request.getParameter("pName");
	session.setAttribute("pName",pName);
 }	
 
  System.out.println("district="+district);
  System.out.println("mandal="+mandal);
  System.out.println("panchayat="+panchayat);
int a=0; 
String assetType = (String)session.getAttribute("assetType");
System.out.println("IN HABassetType="+assetType); 
*/
 String dCode=(String)session.getAttribute("districtCode");
 String mCode=(String)session.getAttribute("mandalCode");
  String pCode=(String)session.getAttribute("panchayatCode");
 String dName=(String)session.getAttribute("districtName");
 String mName=(String)session.getAttribute("mandalName");
 String assetName=(String)session.getAttribute("assetType");
 String assetType=(String)session.getAttribute("aCode");

String q1="";
try
{
 if(!assetType.equals("00") && !dCode.equals("00") && !mCode.equals("00") && !pCode.equals("00"))
 {
	query = "SELECT distinct am.asset_name as \"Asset Name\", pr.panch_name as \"Habitation\", nvl(location,'--') as \"Location\", nvl(asset_cost,0) as \"Asset Cost (in Lakhs)\", nvl(am.start_year,'--') as \"Start Year\", nvl(am.end_year,'--') AS \"End Year\" from  RWS_ASSET_MAST_TBL am, rws_panchayat_raj_tbl pr where am.hab_code = pr.panch_code  and am.circle_office_code = '" + dCode + "' AND am.division_office_code = '" + mCode + "'and am.subdivision_office_code='"+pCode+"' AND substr(am.asset_code,7,2) = '" +assetType + "'";
 }
 else if( assetType.equals("00") && !dCode.equals("00") && !mCode.equals("00") && !pCode.equals("00"))
{
	 query = "SELECT distinct am.asset_name as \"Asset Name\", pr.panch_name as \"Habitation\", nvl(location,'--') as \"Location\", nvl(asset_cost,0) as \"Asset Cost (in Lakhs)\", nvl(am.start_year,'--') as \"Start Year\", nvl(am.end_year,'--') AS \"End Year\" from  RWS_ASSET_MAST_TBL am, rws_panchayat_raj_tbl pr where am.hab_code = pr.panch_code and am.circle_office_code = '" + dCode + "' AND am.division_office_code = '" + mCode + "'and am.subdivision_office_code='"+pCode+"'";

}
else if(!assetType.equals("00") && !districtcode.equals("00") && !mandalcode.equals("00") && !panchayatcode.equals("00"))
 {
	query = "SELECT distinct am.asset_name as \"Asset Name\", pr.panch_name as \"Habitation\", nvl(location,'--') as \"Location\", nvl(asset_cost,0) as \"Asset Cost (in Lakhs)\", nvl(am.start_year,'--') as \"Start Year\", nvl(am.end_year,'--') AS \"End Year\" from  RWS_ASSET_MAST_TBL am, rws_panchayat_raj_tbl pr where am.hab_code = pr.panch_code  and am.circle_office_code = '" + districtcode + "' AND am.division_office_code = '" + mandalcode + "'and am.subdivision_office_code='"+panchayatcode+"' AND substr(am.asset_code,7,2) = '" +assetType + "'";
 }
  else if( assetType.equals("00") && !districtcode.equals("00") && !mandalcode.equals("00") && !panchayatcode.equals("00"))
{
	 query = "SELECT distinct am.asset_name as \"Asset Name\", pr.panch_name as \"Habitation\", nvl(location,'--') as \"Location\", nvl(asset_cost,0) as \"Asset Cost (in Lakhs)\", nvl(am.start_year,'--') as \"Start Year\", nvl(am.end_year,'--') AS \"End Year\" from  RWS_ASSET_MAST_TBL am, rws_panchayat_raj_tbl pr where am.hab_code = pr.panch_code and am.circle_office_code = '" + districtcode + "' AND am.division_office_code = '" + mandalcode + "'and am.subdivision_office_code='"+panchayatcode+"'";

}
//System.out.println("In Hab REport1"+query);
}
catch(Exception e)
{
	 //System.out.println("for enumeration "+e);
	 //e.printStackTrace();
}
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = stmt.executeQuery(query);
		rs.last();
Count = rs.getRow();

// System.out.println("Total Records = "+Count);
rs.beforeFirst();
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
 %>
 <%   // System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhHHHHHHHH");
 try{
	if(Count!=0){


	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int j=0,c=1; j<Cnt;j++,c++)
	{
		colLabel[j]=rsm.getColumnLabel(c);
	}
	labelcol.add(colLabel);

	session.setAttribute("arrayLabel", labelcol);
	String[] record2 = null;
	ArrayList myList = new ArrayList();
	while(rs.next())
	{
		record2 = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
		record2[z] = rs.getString(c);
		}
		myList.add(record2);

	}

	session.setAttribute("arrayList", myList);
RwsOffices rw=new RwsOffices(ds);
session.setAttribute("RSet1",rw);



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
<%}

	
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