<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "conn.jsp" %>

<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String st[]=new String[40];
	int Cnt,Count;
	String query = null;
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String panchayat=request.getParameter("panchayat");
	String repcode=request.getParameter("repname");
	// //System.out.println("REp Code     "+repcode);
	String	Consti = request.getParameter("cons");
	String fyr=request.getParameter("finyear");
	// //System.out.println("Constituency name   "   +Consti);
	
	 // //System.out.println("district="+district);
	 // //System.out.println("mandal="+mandal);
	 // //System.out.println("panchayat="+panchayat);
int a=0; 
String assetType=request.getParameter("assetType");
// //System.out.println("panchayat="+assetType);
String ATName=null;
if(assetType!=null)
{
if(assetType.equals("01")){ATName="PWS";}
else if(assetType.equals("02")){ATName="MPWS";} 
else if(assetType.equals("03")){ATName="CPWS";}
else if(assetType.equals("04")){ATName="HANDPUMPS";}
session.setAttribute("atname",ATName);
}
else
session.setAttribute("atname",null);
// //System.out.println("assetType="+assetType); 

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
String q3="a.PROPOSAL_NAME" + " AS \"Work Description \", PANCH_NAME "+ " AS \"Habitation\""+q1;
// //System.out.println("query is "  +q3);		
try
{
		
 
if(!district.equals("0") && mandal.equals("0"))
 {
	query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_Rep_proposal_tbl ra, rws_panchayat_raj_tbl pr,rws_work_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and ra.LEAD_HAB_CODE = ah.hab_code and  ra.proposal_id=a.proposal_id and substr(a.office_code,2,2)="+district;

   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
//// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
//query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_work_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah,rws_Rep_proposal_tbl ra, rws_employee_tbl e where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and ra.proposal_id=a.proposal_id and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and a.prepared_by=e.employee_code and substr(a.office_code,2,2)="+district+" and substr(a.office_code,4,1)="+mandal;

query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_Rep_proposal_tbl ra, rws_panchayat_raj_tbl pr,rws_work_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and ra.LEAD_HAB_CODE = ah.hab_code and  ra.proposal_id=a.proposal_id and substr(a.office_code,2,2)='" + district +"' and substr(a.office_code,4,1)='"+ mandal +"'";

 }
 else
 {	
	//// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
	//query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name, "+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_Rep_proposal_tbl ra, rws_panchayat_raj_tbl pr,rws_work_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah, rws_employee_tbl e where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and a.prepared_by=e.employee_code  and ra.proposal_id=a.proposal_id and substr(a.office_code,2,2)="+district+" and substr(a.office_code,4,1)="+mandal+" and substr(a.office_code,5,2)="+panchayat;
	query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,"+q3+"  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_Rep_proposal_tbl ra, rws_panchayat_raj_tbl pr,rws_work_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and ra.LEAD_HAB_CODE = ah.hab_code and  ra.proposal_id=a.proposal_id and substr(a.office_code,2,2)='" + district +"' and substr(a.office_code,4,1)='"+ mandal +"' and substr(a.office_code,5,2)= '"+panchayat +"'";

 }
 String a1=" order by  a.proposal_id,a.proposal_name" ;
if(assetType!=null)
	 {query=query+ " and a.type_of_asset='"+assetType+"'";}

if(!repcode.equals("0"))
	 { 
		query=query+ " and  ra.REP_CODE="+repcode;
	// //System.out.println("ddQQQQQQQQQQQQQQQ     "+ query); 
	}
if(!Consti.equals("0"))
	{
	query=query+" and substr(ah.hab_CODE,3,3)="+Consti;
	}
if(!fyr.equals("0")&& fyr!=null)
	{
	query=query+" and substr(a.proposal_id,3,4)='"+fyr+"'";
	}

query=query+" "+a1;


/*query="SELECT c.circle_office_name,d.division_office_name,sd.subdivision_office_name,panch_name,proposal_name  from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)='13' and substr(a.office_code,4,1)='1' and substr(a.office_code,5,2)='01' order by a.proposal_id";*/


////System.out.println("uuuuuuuuuu     "+query);


 
}
catch(Exception e)
{
	//System.out.println("for enumeration "+e);
}
// //System.out.println("for enumeration ");
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
rs = stmt.executeQuery(query);
rs.last();
Count = rs.getRow();
rs.beforeFirst();
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
////System.out.println(" Count  is   "+Cnt);

try{
	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int j=0,c=1; j<Cnt;j++,c++)
	{
		colLabel[j]=rsm.getColumnLabel(c);
	}
	labelcol.add(colLabel);

	session.setAttribute("workLabel", labelcol);

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

	session.setAttribute("workList", myList);
RwsOffices rw=new RwsOffices(ds);
session.setAttribute("RSet1",rw);

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
<%@ include file = "rws_work_proposal_hab_rpt_temp.jsp" %>
