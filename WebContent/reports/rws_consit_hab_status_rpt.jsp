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
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");

 /*String district=String.valueOf(session.getAttribute("dCode"));
 String mandal=String.valueOf(session.getAttribute("mCode"));
 String panchayat=String.valueOf(session.getAttribute("pCode"));*/

 //String	Consti = request.getParameter("cons");
 String	Consti = String.valueOf(session.getAttribute("constiCode"));
 // //System.out.println("Constituency code   "   +Consti);
 
 //String	Costi = request.getParameter("Cons");
 String	Costi = String.valueOf(session.getAttribute("constiName"));
 // //System.out.println("Constituency name   "   +Costi);

 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);
int a=0; 
String q1="",query=null,  b1="";
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
 ////System.out.println("Query   "+q1);
//session.setAttribute("Query",q1);
}

try
{
	  if(fdate!=null && !fdate.equals("0"))
	{
		b1 =  "  and to_char(status_date,'dd/mm/yyyy')  >='" + fdate +"' ";
		session.setAttribute("fdate", fdate);		
	}
	else
	{
		session.setAttribute("fdate", null);
		session.setAttribute("tdate", null);
	}
 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
String q2="SELECT DIVISION_OFFICE_CODE"+ q1+" from rws_habitation_directory_tbl, RWS_HAB_COMPONENT_TBL hc";
rs1 =st1.executeQuery(q2);
 if(!district.equals("0") && mandal.equals("0"))
 {
 query = "SELECT d.dname,m.mname,p.pname,pr.panch_name "+q1+" from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+district+"'"+ b1 ;
   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
	 query = "SELECT d.dname,m.mname,p.pname,pr.panch_name "+q1+" from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code   and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"'"+ b1 ;
 }
 else
 {
	 query = "SELECT d.dname,m.mname,p.pname,pr.panch_name "+q1+" from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and  pr.panch_code=h.hab_code  and substr(h.hab_code,1,2)='"+district+"' and substr(h.hab_code,6,2)='"+mandal+"' and substr(h.hab_code,13,2)='"+panchayat+"'"+ b1 ;

 }
 String a1=" order by substr(h.hab_code,1,2),substr(h.hab_code,6,2)";

 if(!Consti.equals("0") && !Consti.equals("null"))
	{
	query=query+" and substr(h.hab_CODE,3,3)="+Consti;
	}
 query=query+a1;
 //System.out.println("Query   "+query);
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
	
	e.printStackTrace();
}
finally
{
	conn.close();
}
if(Count!=0){%>
	<%@ include file="./rws_consti_hab_rpt_temp.jsp"%>
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
