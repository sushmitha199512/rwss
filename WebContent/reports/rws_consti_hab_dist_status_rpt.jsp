<%@ page import ="nic.watersoft.commons.*,java.util.*,java.sql.*"%>
<%@ include file = "conn.jsp" %>
<%		
	Statement st1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	//String st[]=new String[40];
		int Count=0,Cnt=0;
	//int start,end,limit = 3;

 String district=request.getParameter("district");
 String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");
  String	Consti = String.valueOf(session.getAttribute("constiCode"));
  String	Costi = String.valueOf(session.getAttribute("constiName"));

int a=0; 
String q1="",query=null, b1="";
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
//System.out.println("Query  dddd "+q1);
session.setAttribute("Query",q1);
}

try
{
	
	 if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		b1 =  "  and to_char(status_date,'dd/mm/yyyy')  >='" + fdate +"' and to_char(status_date,'dd/mm/yyyy')  <= '"+ tdate +"' ";
	session.setAttribute("fdate", fdate);
		session.setAttribute("tdate", tdate);
	}
	else
	{
		session.setAttribute("fdate", null);
		session.setAttribute("tdate", null);
	}
 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);


 if(district.equals("-1"))
 {
 query = "SELECT d.dcode,d.dname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME "+q1+" from rws_district_tbl d,rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h, RWS_CONSTITUENCY_TBL c where d.dcode=substr(h.hab_code,1,2) and pr.panch_code=h.hab_code " + b1 ;
   // //System.out.println("panchayat="+panchayat);
 }
 if(!Consti.equals("0") && !Consti.equals("null"))
	{
	query=query+" and substr(h.hab_CODE,3,3)="+Consti;
	}
 String a1=" group by d.dcode,d.dname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME  order by d.dname";

 query=query+a1;
 //System.out.println("Query   is : "+query);
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 rs = stmt.executeQuery(query);
 rs.last();
Count = rs.getRow();
// //System.out.println("Total Records = "+Count);
rs.beforeFirst();
//session.setAttribute("RSet",rs);
//session.setAttribute("RSet1",rs1);
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();

}
catch(Exception e)
{
	 //System.out.println("for enumeration "+e);
}


try{
	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int  j=0,c=1; j<Cnt;j++,c++)
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
	//RwsOffices rw=new RwsOffices(ds);
	//session.setAttribute("RSet1",rw);

}catch(Exception e)
{
	//System.out.println("knk error is   "+e);
	//e.printStackTrace();
}
finally
{
	conn.close();
}
if(Count!=0){
	if(district.equals("-1"))
	{
%>
		<%@ include file="./rws_consti_hab_dist_rpt_temp.jsp"%>
<%
	}
} 
else {  %>
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
