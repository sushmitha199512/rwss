<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
 String districtcode;
 
 if(district==null)
 {
 
  districtcode=request.getParameter("districtcode");
 session.setAttribute("districtcode",districtcode);

  String districtname=request.getParameter("districtname");
  session.setAttribute("dName",districtname);
 }
 else
 {
	 districtcode = district;
	 session.setAttribute("districtcode",districtcode);
 }
 
 String dCode=(String)session.getAttribute("districtCode");
 String mCode=(String)session.getAttribute("mandalCode");
 String dName=(String)session.getAttribute("districtName");
 String assetName=(String)session.getAttribute("assetType");
 String assetType=(String)session.getAttribute("aCode");

 //String districtcode=request.getParameter("districtcode");
 //String districtname=request.getParameter("districtname");
 /*else
 {
	dName=request.getParameter("district1");
	session.setAttribute("dName",dName);
 }	*/

 /* String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
String pname=request.getParameter("pName");*/
 
int a=0; 

//String assetType = (String)session.getAttribute("assetType");
//out.println(assetType);
try
{
/*if(!district.equals("00")  && !district.equals("-1"))
 {
	try {
    query1="delete from TEMP_ASSET_HAB_TBL";
	stmt = conn.createStatement();
	int p = stmt.executeUpdate(query1);
	
	
}catch(Exception e)
{
	System.out.println("drop table exception   "+e);
	e.printStackTrace();
}
finally
	 {
	conn.commit();
	 }
	
	System.out.println("panchayat="+  query1);
	if(!assetType.equals("00"))
	 {
		query1 = "insert into TEMP_ASSET_HAB_TBL (select hab_code, asset_Code from RWS_ASSET_HAB_TBL where  substr(asset_code,5,2)='" +district + "' and  substr(asset_code,7,2)='" +assetType + "' union select hab_code, asset_code from RWS_ASSET_MAST_TBL where substr(asset_code,7,2)='" +assetType + "' and substr(asset_code,5,2)='" +district + "') ";
	 }
	 else
	 {
		query1 = "insert into TEMP_ASSET_HAB_TBL (select hab_code, asset_Code from RWS_ASSET_HAB_TBL where  substr(asset_code,5,2)='" +district + "'  union select hab_code, asset_code from RWS_ASSET_MAST_TBL where   substr(asset_code,5,2)='" +district + "') ";
	 }


	System.out.println("panchayat="+  query1);
	 stmt = conn.createStatement();
	int b= stmt.executeUpdate(query1);
  }*/
	if(!assetType.equals("00") && !dCode.equals("00"))
	 {
	/*query = "SELECT d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where am.asset_code=tm.asset_code and d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + district + "' AND substr(tm.asset_code,7,2) = '" +assetType + "' group by d.division_office_code , d.division_office_name";*/
     query = "SELECT distinct d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count( am.asset_code) as \"Total No. of Assets\", count(am.hab_code) as \"Total No. of Habitations\" from  RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + dCode + "' AND substr(am.asset_code,7,2) = '" +assetType + "' group by d.division_office_code , d.division_office_name";
	
	}
	 else if(assetType.equals("00") && !dCode.equals("00"))
	 
	{
		 /*query = "SELECT d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where am.asset_code=tm.asset_code and d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + district + "'  group by d.division_office_code , d.division_office_name";*/
         //out.println("innnnnnnn else");
		  query = "SELECT  distinct d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(am.asset_code) as \"Total No. of Assets\", count(am.hab_code) as \"Total No. of Habitations\" from  RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where  d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + dCode + "'  group by d.division_office_code , d.division_office_name";
	}
 	if(!assetType.equals("00") && !districtcode.equals("00"))
	 {
	/*query = "SELECT d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where am.asset_code=tm.asset_code and d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + district + "' AND substr(tm.asset_code,7,2) = '" +assetType + "' group by d.division_office_code , d.division_office_name";*/
     query = "SELECT distinct d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count( am.asset_code) as \"Total No. of Assets\", count(am.hab_code) as \"Total No. of Habitations\" from  RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + districtcode + "' AND substr(am.asset_code,7,2) = '" +assetType + "' group by d.division_office_code , d.division_office_name";
	
	}
	else if(assetType.equals("00") && !districtcode.equals("00"))
	 
	{
		 /*query = "SELECT d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where am.asset_code=tm.asset_code and d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + district + "'  group by d.division_office_code , d.division_office_name";*/
         //out.println("innnnnnnn else");
		  query = "SELECT  distinct d.division_office_code , d.division_office_name as \"Division Name\", nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(am.asset_code) as \"Total No. of Assets\", count(am.hab_code) as \"Total No. of Habitations\" from  RWS_ASSET_MAST_TBL am, rws_division_office_tbl d where  d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and  am.circle_office_code = '" + districtcode + "'  group by d.division_office_code , d.division_office_name";
	}
}
catch(Exception e)
{
	e.printStackTrace();
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
<%@ include file = "rws_asset_div_off_rpt_temp.jsp" %>
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
<tr><td align="center" class="mystyle"><font color="navy"><a href="rws_asset_hab_off_frm.jsp">There are No Records</a></font></td></tr>
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