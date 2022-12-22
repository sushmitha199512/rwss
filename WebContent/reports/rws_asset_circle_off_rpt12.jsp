
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

 
 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);
int a=0; 
String assetType=request.getParameter("assetType");

session.setAttribute("assetType",assetType);
 //System.out.println("assetType="+assetType); 


if(!assetType.equals("00")  && district.equals("00")  && (mandal.equals("00") || mandal.equals("-1")))
 {

	query1 = "insert into TEMP_ASSET_HAB_TBL (select hab_code, asset_Code from asset_hab1 where  substr(asset_code,7,2)='" +assetType + "'  union select hab_code, asset_code from asset_mast1 where substr(asset_code,7,2)='" +assetType + "') ";

	//System.out.println("panchayat="+  query1);
 }
 else
 {
	query1 = "insert into TEMP_ASSET_HAB_TBL (select hab_code, asset_Code from asset_hab1   union select hab_code, asset_code from asset_mast1) ";
 }

 stmt = conn.createStatement();
 int b= stmt.executeUpdate(query1);
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
if(!assetType.equals("00")  && district.equals("00")  && (mandal.equals("00") || mandal.equals("-1")))
{
	
	query = "SELECT c.circle_office_code , c.circle_office_name as \"Circle Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, ASSET_mast1 am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code and am.asset_code=tm.asset_code and substr(am.asset_code,7,2) = '" +assetType + "' group by c.circle_office_code , c.circle_office_name";
   
}
else
	{
		//query = "SELECT c.circle_office_code , c.circle_office_name as \"Circle Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, ASSET_mast1 am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code and am.asset_code=tm.asset_code  group by c.circle_office_code , c.circle_office_name";

		query = "SELECT c.circle_office_code , c.circle_office_name as \"Circle Name\" from ASSET_mast1 am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code group by c.circle_office_code , c.circle_office_name";
   
	}

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
<%@ include file = "rws_asset_circle_off_rpt_temp.jsp" %>
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
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>