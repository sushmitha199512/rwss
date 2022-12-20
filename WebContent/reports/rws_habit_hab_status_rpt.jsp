<%@ page import ="nic.watersoft.commons.*,java.util.*,java.sql.*"%>
<%@ include file = "conn.jsp" %>
<%		
	Statement st1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	//String st[]=new String[40];
		int Count=0,Cnt=0;
	//int start,end,limit = 3;
String dCode = String.valueOf(session.getAttribute("dCode"));
String mCode = request.getParameter("mcode");
String mName = request.getParameter("mname");
session.setAttribute("mName",mName);
	//System.out.println("name is "+dCode);
String fdate = String.valueOf(session.getAttribute("fdate"));
	String tdate = String.valueOf(session.getAttribute("tdate"));
 

int a=0; 
String q1="",query=null, b1="";
q1= String.valueOf(session.getAttribute("Query"));
//System.out.println("q1 in mandal  "+q1);


try
{
	
	/* if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		b1 =  "  and to_char(status_date,'dd/mm/yyyy')  >='" + fdate +"' and to_char(status_date,'dd/mm/yyyy')  <= '"+ tdate +"' ";
	session.setAttribute("fdate", fdate);
		session.setAttribute("tdate", tdate);
	}
	else
	{
		session.setAttribute("fdate", null);
		session.setAttribute("tdate", null);
	}*/
 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);


 
 query = "SELECT p.pcode,p.pname "+q1+" from rws_panchayat_tbl p,rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where p.dcode=substr(h.hab_code,1,2) and pr.panch_code=h.hab_code and p.mcode = substr(h.hab_code,6,2) and p.pcode = substr(h.hab_code,13,2) and  p.dcode='"+dCode +"' and p.mcode='"+mCode+"'" + b1 ;
   // //System.out.println("panchayat="+panchayat);
 

 String a1=" group by p.pcode,p.pname order by p.pname";

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
	for(int  j=0; j<Cnt;j++)
	{
		colLabel[j]=rsm.getColumnLabel(j+1);
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
	
%>
		<%@ include file="./rws_panch_hab_rpt_temp.jsp"%>
<%
	
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
