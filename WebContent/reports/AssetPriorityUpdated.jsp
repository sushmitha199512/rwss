<%@ include file="/reports/conn.jsp" %>
<%
Statement st1 = null,st2 = null;
try
{
	conn.setAutoCommit(false);
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	String q1 = "drop table RWS_ALL_ASSET_COUNT_TBL";
	String q2 = "CREATE TABLE RWS_ALL_ASSET_COUNT_TBL AS SELECT B.HAB_CODE,SUM(CASE WHEN TYPE_OF_ASSET_CODE='03' THEN 1 ELSE 0 END)CPWS,SUM(CASE WHEN TYPE_OF_ASSET_CODE='01' THEN 1 ELSE 0 END)PWS,SUM(CASE WHEN TYPE_OF_ASSET_CODE='02' THEN 1 ELSE 0 END)MPWS,SUM(CASE WHEN TYPE_OF_ASSET_CODE='09' THEN 1 ELSE 0 END)DP,SUM(CASE WHEN TYPE_OF_ASSET_CODE='04' THEN 1 ELSE 0 END)HP,SUM(CASE WHEN TYPE_OF_ASSET_CODE='05' THEN 1 ELSE 0 END)SHP,SUM(CASE WHEN TYPE_OF_ASSET_CODE='07' THEN 1 ELSE 0 END)PONDS,SUM(CASE WHEN TYPE_OF_ASSET_CODE='06' THEN 1 ELSE 0 END)OW FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_HAB_TBL B,RWS_ASSET_SCHEME_TBL C,RWS_COMPLETE_HAB_VIEW D WHERE A.ASSET_CODE=B.ASSET_CODE AND B.ASSET_CODE=C.ASSET_CODE AND A.ASSET_CODE=C.ASSET_CODE AND D.PANCH_CODE=B.HAB_CODE(+) GROUP BY B.HAB_CODE";
	//System.out.println(q1);
	//System.out.println(q2);
	st1.executeQuery(q1);
	st2.executeQuery(q2);
	conn.setAutoCommit(true);
	conn.commit();
}
catch(Exception e)
{System.out.println("exception:"+e.getMessage());
conn.rollback();}
finally
{
	try
	{
		if(st2!=null)st2.close();if(st1!=null)st1.close();
		if(conn!=null)conn.close();
	}
	catch(Exception ee)
	{System.out.println("exception in finally:"+ee.getMessage());}
}
%>