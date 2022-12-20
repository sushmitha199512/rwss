
<%@ include file = "conn.jsp" %>


<%	Statement st1 = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	//String st[]=new String[40];
		int Count=0,Cnt=0;
	//int start,end,limit = 3;
	
	String dName = String.valueOf(session.getAttribute("dName"));
	
	String dCode = String.valueOf(session.getAttribute("dCode"));

	String fdate=(String)session.getAttribute("FDATE");
    String month=(String)session.getAttribute("MONTH");
	String monthname=(String)session.getAttribute("monName");

	
	//String[] coverStatus = {"FC","PC1","PC2","PC3","PC4","NC","NSS", "UI"};
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

	
	
	//System.out.println("name is "+dCode);
	//String fdate = (String)session.getAttribute("FDATE");
	//String tdate = String.valueOf(session.getAttribute("tdate"));

	String distCode= request.getParameter("district");
	 

int a=0; 
String q1="",query="", b1="";

String names[] = request.getParameterValues("ch");
//out.println(request.getParameterValues("ch"));
if(names != null)
{
	String[] w1=new String[names.length];	
	// System.out.println("MMMMM   "  +names.length);
	for (int i=0; i < names.length; i++)
	{
		// System.out.println(names[i]);
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		// System.out.println("YYYYYYYY   "+sr1);
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		// System.out.println("YYYYYYYY   "+sr2);
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
//System.out.println("Query  dddd "+q1);
//System.out.println("Query  dddd "+q1);
session.setAttribute("Query",q1);
}
else
{
q1=(String)session.getAttribute("Query");
//System.out.println("Query  fffff "+q1);
if(q1==null)
q1="";
}

try
{
	
	 if(fdate!=null && !fdate.equals("0") && month!=null && !month.equals("0"))
	{
	b1 = " and fin_year ='" + fdate +"'  and month='"+month+"'";
	session.setAttribute("fdate", fdate);
	session.setAttribute("month", month);
	session.setAttribute("monthname", monthname);


	//System.out.println("fadate is"+fdate);
	}
	/*else
	{
		session.setAttribute("fdate", null);
		
	}*/
 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
//java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
//java.util.Date currentDate1 = new java.util.Date();

//String currentYear=null;
//currentYear= dateFormat.format(currentDate1).substring(0,4);
//out.println("currentYear"+currentYear);


 //if(fdate.substring(7,11).equals(currentYear))
	//{
      
		//{
		  
	  /*query ="select distinct d.mcode,d.mname,pr.panch_code,pr.panch_name "+q1+" from RWS_HABMAST_TBL a,RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where b.hab_code=a.prhab and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)and b.hab_code = PR.panch_CODE  and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' order by d.mcode,pr.panch_code";*/
      if(!dCode.equals("00"))
 {
	  query = "SELECT distinct pr.programme_name "+q1+" from rws_district_tbl d,rws_programme_tbl pr,rws_mon_fin_phy_progress_tbl h where d.dcode=h.dcode and pr.programme_code=h.programme_code and h.dcode='"+dCode+"' and h.fin_year='"+fdate+"' and h.month='"+month+"'";


 }
  else if(dCode.equals("00"))
 {
	  query = "SELECT distinct pr.programme_name "+q1+" from rws_district_tbl d,rws_programme_tbl pr,rws_mon_fin_phy_progress_tbl h where d.dcode=h.dcode and pr.programme_code=h.programme_code and h.fin_year='"+fdate+"' and h.month='"+month+"'";


 }
		
	      // {
			/* query ="select distinct d.mcode,d.mname,pr.panch_code,pr.panch_name "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' order by d.mcode,pr.panch_code";*/
	      // }

		/*else
		{
			
		query ="select distinct nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),d.mname,pr.panch_name "+q1+",pr.panch_code,d.mcode from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_institute_tbl p where  substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code = PR.panch_CODE  and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' group by d.mcode,d.mname,pr.panch_code,pr.panch_name,to_char(b.UPDATE_DATE,'dd-mm-yyyy') order by d.mcode,pr.panch_code";
       }*/
	
   // System.out.println("panchayat="+panchayat);
 

   String a1=" group by pr.programme_name order by pr.programme_name";

  query=query+a1;
  //out.println("Query   is mmmm : "+query);
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 stmt1 = conn.createStatement();
 rs = stmt.executeQuery(query);
 rs.setFetchSize(1000);
 rs.last();
Count = rs.getRow();
// System.out.println("Total Records = "+Count);
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
	int[] coverrecord ;
	ArrayList myList = new ArrayList();
	coverList = new ArrayList();
	while(rs.next())
	{
		//out.println("next");
		try
		{
		//System.out.println("IIII"+dCode);
		record = new String[Cnt];
		
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
		record[z] = rs.getString(c);
		//mcode = record[0];
		//System.out.println(record[0]);
		}
		
		
	myList.add(record);
		}
		catch(Exception e)
		{
			//System.out.println("exception"+e);
		}
	}
    //myList.add(record);
	session.setAttribute("arrayList",myList);
	%>
	
	<%@ include file="./rws_work_dist_report_temp.jsp"%>
<%}
catch(Exception e)
{
	
}
finally
{
	conn.close();
}
%>
