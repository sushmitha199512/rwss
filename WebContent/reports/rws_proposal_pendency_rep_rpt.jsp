<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file = "conn.jsp" %>

	<%
	try {
	Statement st1=null,st2 = null,st3=null,st4=null,st7,st8;
	ResultSet rs1 = null,rs2=null,rs3=null,rs4=null,rs7,rs8=null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt;
	//java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	//RwsOffices rw=new RwsOffices(ds);
	String prgName,subprgName,aType,sentBy, sentTo,act_from,act_to,work_ID="",sentBy1, sentTo1;
	String query = null;
	String repCode=null;
	
	String atype = request.getParameter("assetType");
	if(atype!=null && !atype.equals("0"))
	{
		session.setAttribute("AType",atype);
	}
	else
		session.setAttribute("AType",null);


	repCode=request.getParameter("repname");
	if(repCode!=null && !repCode.equals("0"))
	{
		session.setAttribute("repCode",repCode);
	}
	else
		session.setAttribute("repCode",repCode);

	String fdate=request.getParameter("FDate");
	
	if(fdate!=null && !fdate.equals("0"))
	{
		session.setAttribute("fdate",fdate);
	}
	else
		session.setAttribute("repCode",repCode);

	String tdate=request.getParameter("TDate");
	
	if(tdate!=null && !tdate.equals("0"))
	{
		session.setAttribute("tdate",tdate);
	}
	else
		session.setAttribute("tdate",tdate);


	////System.out.println("pid  "+pid);
%>


<%	
	st1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//SELECT distinct  at.TYPE_OF_ASSET_NAME,wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME  FROM RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e where wp.PROPOSAL_ID=rp.PROPOSAL_ID  and  wp.work_id is  null  and wp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE  order by wp.proposal_id ;
	if(repCode!=null && !repCode.equals("00") && !repCode.equals("0"))
	{
	query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, nvl(rp.ENDORSED_BY,'--'), rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID and rp.rep_code='"+ repCode +"'  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code " ;
	}
	else
	{
		query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, nvl(rp.ENDORSED_BY,'--'), rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'), pr.REP_NAME  FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID   and pr.rep_code=rp.rep_code  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET and rp.rep_code=pr.rep_code " ;
	}
	String a1="  order by wp.proposal_id";
	if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0") )
	{
		query = query + " and to_char(rp.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(rp.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
		//query = query + " and rp.PREPARED_ON >= to_date('" + fdate +"','dd/mm/yyyy') and rp.PREPARED_ON <= to_date('" + tdate +"','dd/mm/yyyy') ";
		
	}

	if(request.getParameter("assetType")!=null)
	{
		query = query + " and  rp.TYPE_OF_ASSET = '"+ request.getParameter("assetType") + "'";
	}
	query = query + a1;
	
	//System.out.println("query    "+query);
	
	rs = st1.executeQuery(query);


	rs.last();
	 Count=rs.getRow();
	// //System.out.println("sadiq   "+Count);
	rs.beforeFirst();
		rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
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

%>
<%@ include file = "rws_proposal_pendency_rep_rpt_temp.jsp" %>


	

<%}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}
		%>

