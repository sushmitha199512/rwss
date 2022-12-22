
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	int Count, Cnt;
	String query = null;
	String query1 = null;
	ResultSetMetaData rsm=null;
 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
String pname=request.getParameter("pName");
// //System.out.println("PPPP NNNNNN  "+pname);

 
  //System.out.println("district="+district);
  //System.out.println("mandal="+mandal);
  //System.out.println("panchayat="+panchayat);
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

if(district.equals("00")  && (mandal.equals("00") || mandal.equals("-1")))
 {

	query1 = "CREATE TABLE TEMP_ASSET_HAB_TBL AS select am.asset_code,am.hab_code from asset_mast1 am, asset_hab1 ah where (am.hab_code = ah.hab_code (+) and am.asset_code  =  ah.asset_code (+)) ";

	//System.out.println("panchayat="+  query);
 }

 else if((mandal.equals("00") || mandal.equals("-1")) && panchayat.equals("-1") && !district.equals("00") && !district.equals("-1"))
 {
		query1 = "CREATE TABLE TEMP_ASSET_HAB_TBL AS select am.asset_code,am.hab_code from asset_mast1 am, asset_hab1 ah where substr(am.hab_code,1,2)='"+district +"'  AND (am.hab_code = ah.hab_code (+) and am.asset_code  =  ah.asset_code (+)) ";
	

 }
 else if((!mandal.equals("00") && !mandal.equals("-1")) && panchayat.equals("-1") && !district.equals("00") && !district.equals("-1"))
 {
		query1 = "CREATE TABLE TEMP_ASSET_HAB_TBL AS select am.asset_code,am.hab_code from asset_mast1 am, asset_hab1 ah where substr(am.hab_code,1,2)='"+district +"' and am.division_office_code='"+ mandal +"' AND (am.hab_code = ah.hab_code (+) and am.asset_code  =  ah.asset_code (+)) ";
	

 }
 else
 {
	query1 = "CREATE TABLE TEMP_ASSET_HAB_TBL AS select am.asset_code,am.hab_code from asset_mast1 am, asset_hab1 ah where substr(am.hab_code,1,2)=? and am.division_office_code=? and am.subdivision_office_code = ? AND (am.hab_code = ah.hab_code (+) and am.asset_code  =  ah.asset_code (+)) ";
 }
 stmt = conn.createStatement();
 PreparedStatement ps1=conn.prepareStatement(query1);
 ps1.setString(1, district);
 ps1.setString(2, mandal);
 ps1.setString(3, panchayat);
 int b= ps1.executeUpdate();
 if(b>0)
 {
	 //System.out.println("TABLE CREATED");
 }
 else
 {
	  //System.out.println("TABLE NOT CREATED");
 }


try
{
if(district.equals("00")  && (mandal.equals("00") || mandal.equals("-1")))
{
	query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am, TEMP_ASSET_HAB_TBL ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code ";
}
else if(!district.equals("00") && mandal.equals("00"))
 {

	query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am, TEMP_ASSET_HAB_TBL ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"'";

	//System.out.println("panchayat="+  query);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
		query="SELECT  "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, ASSET_MAST1  am, TEMP_ASSET_HAB_TBL ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"'";
	

 }
 else
 {
	query="SELECT  "+ q3 +" from  rws_circle_office_tbl c,rws_panchayat_raj_tbl pr, ASSET_MAST1  am, TEMP_ASSET_HAB_TBL ah where c.circle_office_code=am.circle_office_code and pr.panch_code=ah.hab_code  and am.asset_code=ah.asset_code and am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"' and am.subdivision_office_code = '" + panchayat + "'";


 }
// String a1=" order by am.asset_code";
 if(assetType!=null && !assetType.equals("00"))
	{
	 query=query+" and am.type_of_asset_code="+ assetType;
	}
	/*else if(assetType!=null && assetType.equals("04"))
	{
		if(!district.equals("0") && mandal.equals("0"))
		{
			query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am  where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and  am.circle_office_code='"+district +"' and am.type_of_asset_code="+ assetType;
			//System.out.println("panchayat="+  query);
		 }
		 else if(!mandal.equals("0") && panchayat.equals("0"))
		 {
			query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am  where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and  am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"' and am.type_of_asset_code="+ assetType;;
		 }
		else
		{
			query = "SELECT  "+ q3 +" from  rws_circle_office_tbl c, rws_panchayat_raj_tbl pr, ASSET_MAST1  am  where c.circle_office_code=am.circle_office_code and pr.panch_code=am.hab_code  and  am.circle_office_code='"+district +"' and am.division_office_code='"+ mandal +"' and am.subdivision_office_code = '" + panchayat + "' and am.type_of_asset_code="+ assetType;
		}
	}*/
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
try {
query1="drop table TEMP_ASSET_HAB_TBL";
	stmt = conn.createStatement();
	int p = stmt.executeUpdate(query1);
	
	
}catch(Exception e)
{
	//System.out.println("drop table exception   "+e);
	//e.printStackTrace();
}

	
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