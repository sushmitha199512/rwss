<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	int Count, Cnt;
	String query = null;
	ResultSetMetaData rsm=null;
	 String district=request.getParameter("district");
	 String mandal=request.getParameter("mandal");
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
String q3="PANCH_NAME"+ " AS \"Habitation\""+q1;
// //System.out.println("query is "  +q3);		
try
{
		

if(!district.equals("0") && mandal.equals("0"))
 {
query="SELECT "+q3+" from rws_panchayat_raj_tbl pr, RWS_SOURCE_TBL  sh where    pr.panch_code=sh.hab_code and  sh.SOURCE_TYPE_CODE ="+district;

	// //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && !district.equals("0"))
 {

query="SELECT "+q3+" from rws_panchayat_raj_tbl pr, RWS_SOURCE_TBL  sh where  pr.panch_code=sh.hab_code and  sh.SOURCE_TYPE_CODE ="+district+" and sh.SUBSOURCE_TYPE_CODE ="+mandal;

 }
 String a1=" order by sh.hab_code";
 query=query+a1;
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
	conn.close();
%>
<%@ include file = "rws_source_hab_rpt_temp.jsp" %>
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
%>