<%@ include file = "conn.jsp" %>
<%	
	Statement st1=null,st2 = null,st3=null,st4=null,st7,st8;
	ResultSet rs1 = null,rs2=null,rs3=null,rs4=null,rs7,rs8=null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt;
	
	String prgName,subprgName,aType,sentBy, sentTo,act_from,act_to,work_ID="",sentBy1, sentTo1;
	String query = null;
	String repCode=null;
	
	repCode=request.getParameter("repname");
	String fdate=request.getParameter("FDate");
	String tdate=request.getParameter("TDate");
	session.setAttribute("fdate",fdate);
	session.setAttribute("tdate",tdate);

String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 String repcode=request.getParameter("repname");
 // //System.out.println("REp Code     "+repcode);
 String	Consti = request.getParameter("cons");

 // //System.out.println("Constituency name   "   +Consti);


 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);
int a=0; 
String assetType=request.getParameter("assetType");
// //System.out.println("Asset type code="+assetType);
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

	session.setAttribute("assetType",assetType);
	
	st1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//SELECT distinct  at.TYPE_OF_ASSET_NAME,wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME  FROM RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e where wp.PROPOSAL_ID=rp.PROPOSAL_ID  and  wp.work_id is  null  and wp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE  order by wp.proposal_id ;
	if(!district.equals("0") && mandal.equals("0"))
	{
	query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, nvl(rp.ENDORSED_BY,'--'), rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code and  substr(rp.office_code,2,2)='" + district +"' ";
	}
	else if(!mandal.equals("0") && panchayat.equals("0"))
	{
		query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, nvl(rp.ENDORSED_BY,'--'), rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code and  substr(rp.office_code,2,2)= '"+ district +"' and substr(rp.office_code,4,1)='" + mandal + "'";
	}
	else
	{
	query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, nvl(rp.ENDORSED_BY,'--'), rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code and  substr(rp.office_code,2,2)= '"+ district +"' and substr(rp.office_code,4,1)='"+mandal+"' and  substr(rp.office_code,5,2)='"+panchayat+"'";
	}

	String a1="  order by wp.proposal_id";
	
	if(repCode!=null && !repCode.equals("00") && !repCode.equals("0"))
	{
		query = query + " and rp.rep_code='"+ repCode +"' "  ;
	}

	
	if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		query = query + " and to_char(rp.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(rp.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
	}

	if(request.getParameter("assetType")!=null)
	{
		query = query + " and  rp.TYPE_OF_ASSET = '"+ request.getParameter("assetType") + "'";
	}
	if(!Consti.equals("0"))
	{
	query=query+" and substr(rp.lead_hab_CODE,3,3)="+Consti;
	}
	
	query = query + a1;
	
	//System.out.println("query sadiq  "+query);
	
	rs = st1.executeQuery(query);


	rs.last();
	 Count=rs.getRow();
	// //System.out.println("sadiq   "+Count);
	rs.beforeFirst();
	rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
////System.out.println(" Count  is   "+Cnt);

try{
	String[] colLabel=null;
	ArrayList replabelcol = new ArrayList();

	colLabel=new String[Cnt];
	for(int j=0,c=1; j<Cnt;j++,c++)
	{
		colLabel[j]=rsm.getColumnLabel(c);
	}
	replabelcol.add(colLabel);

	session.setAttribute("repLabel", replabelcol);

	String[] record = null;
	ArrayList myList = new ArrayList();
	while(rs.next())
	{
		////System.out.println("knk error is   "+rs.getString(1));
		record = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
		record[z] = rs.getString(c);
		}
		myList.add(record);

		
	}

	session.setAttribute("repList", myList);
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
<%@ include file = "rws_proposal_pendency_consti_rpt_temp.jsp" %>

