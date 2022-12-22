
<%@ include file = "conn.jsp" %>
<%	Statement st1 = null;
    Statement st7 = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt=0;
	String dName = String.valueOf(session.getAttribute("dName"));
	
	String dCode = String.valueOf(session.getAttribute("dCode"));
	
	String[] coverStatus = {"FC","PC1","PC2","PC3","PC4","NC","NSS"};//feild 'UI' is removed 
	ArrayList coverList  = null;
	ArrayList coverLst=new ArrayList();
	String mcode = null;
	if(dName==null || dName.equals("null"))
	{
		dName = request.getParameter("dname");
		session.setAttribute("dName",dName);
	
		dCode = request.getParameter("dcode");	
	
		session.setAttribute("dCode",dCode);
	}

	String fdate = (String)session.getAttribute("FDATE");

	String distCode= request.getParameter("district");

	int a=0; 
	String q1="",query="", b1="",currentYear=null,query3=null;
	
	String names[] = request.getParameterValues("ch");

	if(names != null)
	{
		String[] w1=new String[names.length];	
		for (int i=0; i < names.length; i++)
		{
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
	session.setAttribute("Query",q1);
   }
   else
   {
		q1=(String)session.getAttribute("Query");
		
		if(q1==null)
		q1="";
	}

  try
  {
	
	if(fdate!=null && !fdate.equals("0"))
	{
	b1 = " and status_date ='"+ fdate+"' ";
	session.setAttribute("fdate", fdate);
	}
	/*else
	{
		session.setAttribute("fdate", null);
		
	}*/
	 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
/*	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
	java.util.Date currentDate1 = new java.util.Date();
	String currentYear=null;
	currentYear= dateFormat.format(currentDate1).substring(0,4);
*/

	st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	query3="select distinct to_char(h.status_date,'yyyy') from rws_habitation_directory_tbl h where h.status_date is not null";
	rs2=st7.executeQuery(query3);

	while (rs2.next())
	{
    	currentYear=rs2.getString(1);
	}

 	if(fdate.substring(7,11).equals(currentYear))
	{
		 query = "SELECT m.mcode,m.mname "+q1+" from rws_mandal_tbl m, rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and m.dcode=substr(h.hab_code,1,2) and m.mcode = substr(h.hab_code,6,2) and m.dcode='"+ dCode +"' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' " ;
	}
	else
	{
		 query = "SELECT m.mcode,m.mname "+q1+" from rws_mandal_tbl m, rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and m.dcode=substr(h.hab_code,1,2) and m.mcode = substr(h.hab_code,6,2) and m.dcode='"+ dCode +"' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' " ;
    }
	
	 String a1=" group by m.mcode,m.mname order by m.mname";

	 query=query+a1;
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 stmt1 = conn.createStatement();
	 rs = stmt.executeQuery(query);
	 rs.last();
	 Count = rs.getRow();
	 rs.beforeFirst();
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
	int[] coverrecord ;
	ArrayList myList = new ArrayList();
	coverList = new ArrayList();
	while(rs.next())
	{
		record = new String[Cnt];
		
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
			record[z] = rs.getString(c);
		}
		myList.add(record);

	}	
	
	for(int z = 0; z<myList.size(); z++)
	{	
		String[] record1 =(String[])myList.get(z);		
		coverrecord = new int[8];
		String mandcode=record1[0];
		for(int j=0; j < coverStatus.length; j++)
		{
			if(fdate.substring(7,11).equals(currentYear))
			{
				query = "SELECT count(*) AS cnt FROM rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + dCode + "' and substr(h.hab_code,6,2)='"+mandcode+"' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI'  ";
			}
			else
			{
               query = "SELECT count(*) AS cnt FROM rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + dCode + "' and substr(h.hab_code,6,2)='"+mandcode+"' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI'  ";
			}
		
			rs1 = stmt.executeQuery(query);
			if (rs1.next())
			{
				coverrecord[j] = rs1.getInt("cnt");
			}
			else
			{	
				coverrecord[j] = 0;
			}
			rs1.close();
		}
		coverList.add(coverrecord);
	}
		
		
	session.setAttribute("arrayList", myList);
	session.setAttribute("coverList",coverList);
    String[] coverrecord1=new String[8];
	String query1=null;
	
	for(int j=0; j < coverStatus.length; j++)
	{
		if(fdate.substring(7,11).equals(currentYear))
		{
			query1 = "SELECT count(*) AS cnt FROM rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + dCode + "' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI'  ";
		}
		else
		{
            query1 = "SELECT count(*) AS cnt FROM rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + dCode + "' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI'  ";
		}
		System.out.println("query"+query1);
		rs1 = stmt.executeQuery(query1);
		session.setAttribute("format3",rs1);
		if (rs1.next())
		{
			coverrecord1[j] = rs1.getString("cnt");
		}	
		else
		{	
			coverrecord1[j] = "-";
		}
		rs1.close();
	 }
	  coverLst.add(coverrecord1);
	  session.setAttribute("coverList1",coverLst);
				
%>
		<%@ include file="./rws_hab_mand_rpt_temp.jsp"%>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
