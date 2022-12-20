<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%		
	Statement st1 = null;
	Statement st7 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

	ResultSetMetaData rsm=null;
	int Count=0,Cnt=0;
	ArrayList coverLst=new ArrayList();
	String district=request.getParameter("district");
//	System.out.println("district in xls"+district);
	String fdate=request.getParameter("fdate");
//	System.out.println("fadte"+fdate);
	String dCode=request.getParameter("dCode");
//	System.out.println("dcode"+dCode);
	String[] coverStatus = {"FC","PC1","PC2","PC3","PC4","NC","NSS"};//UI feild is removed by vikas 
	ArrayList coverList  = null;
	int coont=0;
	int a=0; 
	String q1="",query="", b1="",query3=null,currentYear=null;
	//String names[] = request.getParameterValues("ch");
	String names[];
	q1 =(String)session.getAttribute("Query");
	//System.out.println("QS:"+q1);

/*if(names != null)
{
	String[] w1=new String[names.length];	
	for (int i=0; i < names.length; i++)
	{
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
	//System.out.println("q1 value"+q1);
	session.setAttribute("Query",q1);
 }
 else
 {
	session.setAttribute("Query",null);
 }
*/
 try
 {
	if(fdate!=null && !fdate.equals("0"))
	{
	b1 = " and status_date ='" + fdate +"' ";
	session.setAttribute("fdate", fdate);
	}
	else
	{
		session.setAttribute("fdate", null);
	}

	 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");

/*java.util.Date currentDate1 = new java.util.Date();
//String q1=null,q2=null,q3=null,q4=null,q5=null,q6=null,q7=null;
//out.println("in mandal report");
String currentYear=null;
//out.println("datefmt");
//java.util.Date currentDate = new java.util.Date();
//out.println("currentDate"+ currentDate1);
currentYear= dateFormat.format(currentDate1).substring(0,4);
//out.println("currentYear"+currentYear);
*/

	st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	query3="select distinct to_char(h.status_date,'yyyy') from rws_habitation_directory_tbl h where h.status_date is not null";
	rs2=st7.executeQuery(query3);
	while (rs2.next())
	{
	    currentYear=rs2.getString(1);
	}
    //System.out.println("districtvalues "+district);
	if(district.equals("00"))
 	{
 	   //System.out.println("if"+district);
 	//System.out.println("fdate.substring(7,11)"+fdate.substring(7,11)+" "+currentYear);
	 if(fdate.substring(7,11).equals(currentYear))
	 {
		 query = "SELECT d.dcode,d.dname "+q1+" from rws_district_tbl d,rws_habitation_directory_tbl h,rws_panchayat_raj_tbl raj where h.hab_code=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' ";
	 }
	 else
	 {
       query = "SELECT d.dcode,d.dname "+q1+" from rws_district_tbl d, rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl raj where h.hab_code=raj.panch_code and d.dcode=substr(h.hab_code,1,2)  and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' ";
	 }
   }
   String a1=" group by d.dcode,d.dname order by d.dname";
	query=query+a1;
	//System.out.println("query of current year "+query);
 
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs = stmt.executeQuery(query);
	//System.out.println("label column query "+query);
	rs.last();
	Count = rs.getRow();
	rs.beforeFirst();
	rsm=rs.getMetaData();
	Cnt=rsm.getColumnCount();

	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();
	//System.out.println("labelcol.size"+labelcol.size());
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
		
	coverList = new ArrayList();
	for(int z = 0; z<myList.size(); z++)
	{	
		String[] record1 =(String[])myList.get(z);		
		int[] coverrecord = new int[8];
		String distcode=record1[0];
			
			for(int j=0; j < coverStatus.length; j++)
			{
	 		    if(fdate.substring(7,11).equals(currentYear))
	   	   	    {
				    query = "SELECT count(*) AS cnt FROM rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr WHERE h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + distcode + "' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' "; 
			    }
			    else
			    {
					query = "SELECT count(*) AS cnt FROM rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl pr WHERE h.hab_code=pr.panch_code and substr(h.hab_code,1,2) = '" + distcode + "' AND h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' "; 
				}
				//System.out.println("query is"+query);
 				rs1 = stmt.executeQuery(query);
			   // System.out.println("query in for count"+query);
				if (rs1.next())
				{
					coont++;
					//System.out.println("count value of"+coont +"  "+rs1.getInt("cnt"));
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
	 	query1 = "SELECT count(*) AS cnt FROM rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr WHERE h.hab_code=pr.panch_code and h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' "; 
	 }
	 else
	 {
	 	query1 = "SELECT count(*) AS cnt FROM rws_habitation_dir_his_tbl h,rws_panchayat_raj_tbl pr WHERE h.hab_code=pr.panch_code and h.coverage_status = '" + coverStatus[j] + "' and h.status_date ='" + fdate +"' and h.coverage_status is not null and h.coverage_status<>'UI' "; 
	  }
		//System.out.println("query1 is "+query1);
		rs1 = stmt.executeQuery(query1);
	//	System.out.println("query for count 1 "+query1);
		session.setAttribute("format3",rs1);
		if (rs1.next())
		{
			coverrecord1[j] = rs1.getString("cnt");
		}	
		else
		{	
			coverrecord1[j] ="-";
		}
		
		rs1.close();
	}
	//System.out.println("before end ");
	coverLst.add(coverrecord1);
	session.setAttribute("coverList1",coverLst);
	
	if(district.equals("00"))
	{
%>		<%@ include file="./rws_hab_dist_xls_temp.jsp"%>
<%	
	}
		//System.out.println("after end ");
		session.removeAttribute("Query");
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
