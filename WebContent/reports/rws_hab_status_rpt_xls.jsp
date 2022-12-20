
<%@ include file = "conn.jsp" %>
<%		
	Statement st1 = null;
	Statement st7 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSetMetaData rsm=null;
	//String st[]=new String[40];
		int Count=0,Cnt=0;
	//int start,end,limit = 3;

String dName = String.valueOf(session.getAttribute("dName"));
String dCode = String.valueOf(session.getAttribute("dCode"));
String mName = String.valueOf(session.getAttribute("mName"));
String mCode = String.valueOf(session.getAttribute("mCode"));
String pName = String.valueOf(session.getAttribute("pName"));
String pCode = String.valueOf(session.getAttribute("pCode"));


if( pName == null || pName.equals("null") || pName.equals("-1"))
	{
		pCode = request.getParameter("pcode");
		//pName = request.getParameter("pname");
		session.setAttribute("pCode",pCode);
		pName = request.getParameter("pname");
		session.setAttribute("pName",pName);
	}
	
	 
 String fdate=(String)session.getAttribute("FDATE");

int a=0; 
String q1="",query="", b1="",currentYear=null,query3=null;
String names[] = request.getParameterValues("ch");
if(names != null)
{
	String[] w1=new String[names.length];	
	// Debug.println("MMMMM   "  +names.length);
	for (int i=0; i < names.length; i++)
	{
		// Debug.println(names[i]);
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		// Debug.println("YYYYYYYY   "+sr1);
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		// Debug.println("YYYYYYYY   "+sr2);
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
//Debug.println("Query  dddd "+q1);
session.setAttribute("Query",q1);
}
else
{
q1=(String)session.getAttribute("Query");
//Debug.println("q1 in PANCH  "+q1);
}
if(q1==null)
q1="";
//Debug.println("q1 in PANchhhh1111  "+q1);
try
{
	//Debug.println("q1 in PANc333333333 "+q1);
	 
		b1 = "and status_date ='" + fdate +"' ";
		 //Debug.println("in if"+fdate);
	    session.setAttribute("fdate", fdate);
	
	 /*String currentYear=null;
     java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
     java.util.Date currentDate = new java.util.Date();
     currentYear= dateFormat.format(currentDate).substring(0,4);*/

	  st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query3="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
rs2=st7.executeQuery(query3);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}

	 if(fdate.substring(7,11).equals(currentYear))
	{
	 query = "SELECT pr.panch_name "+q1+",nvl(coverage_status,'--') as \" Coverage Status \" from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h  where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and  pr.panch_code=h.hab_code  and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+pCode+"'and status_date='"+fdate+"' and h.coverage_status is not null and h.coverage_status<>'UI'";
	}
     else
	{
         query = "SELECT pr.panch_name "+q1+",nvl(coverage_status,'--') as \" Coverage Status \" from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_dir_his_tbl h  where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and  pr.panch_code=h.hab_code  and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+pCode+"'and status_date='"+fdate+"' and h.coverage_status is not null and h.coverage_status<>'UI'";
	}
	// Debug.println("Query:"+query);
 //}

 String a1=" group by pr.panch_name,coverage_status order by pr.panch_name";

 query=query+a1;
// Debug.println("Query   is : "+query);
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 rs = stmt.executeQuery(query);
 rs.last();
Count = rs.getRow();
// Debug.println("Total Records = "+Count);
rs.beforeFirst();
//session.setAttribute("RSet",rs);
//session.setAttribute("RSet1",rs1);
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();

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
	%>
	<%@ include file="./rws_hab_rpt_temp_xls.jsp"%>
	<%
}
catch(Exception e)
{
	
}
finally
{
	conn.close();
}
%>
