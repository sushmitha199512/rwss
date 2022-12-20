<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<html><body><form>
<%
	int benHabsCount = Integer.parseInt(request.getParameter("benHabsCount"));
	//System.out.println("qrryyyyyyyyy:"+request.getParameter("work_id"));
	//for(int i=1;i<=benHabsCount;i++)
	//{
		//System.out.println(request.getParameter("hab"+i));
		//System.out.println(request.getParameter("sp"+i));
		//System.out.println(request.getParameter("hc"+i));
		//System.out.println(request.getParameter("dlen"+i));
	//}

	try{
		conn.setAutoCommit(false);
		String upQry = "update RWS_work_comp_hab_lnk_tbl set HOUSE_CONN = ?,STAND_POSTS =?,distribution_length=?  where WORK_ID=? and HAB_CODE =?";
		//System.out.println(upQry);
		PreparedStatement stt = conn.prepareStatement(upQry);
		for(int i=1;i<=benHabsCount;i++)
		{

		stt.setInt(1,Integer.parseInt(request.getParameter("hc"+i)));
			stt.setInt(2,Integer.parseInt(request.getParameter("sp"+i)));
			stt.setString(3,request.getParameter("dlen"+i));
			stt.setString(4,request.getParameter("work_id"));
			stt.setString(5,request.getParameter("hab"+i));
			stt.executeUpdate();
		}
		conn.setAutoCommit(true);
		conn.commit();
		%>
		<script>
			alert("Saved Successfully");
			var workId='<%=request.getParameter("work_id")%>';
			var workName='<%=request.getParameter("workName")%>';

			document.location.href="rws_showHabsToEnterStandPostsAndHouseConns.jsp?workId="+workId+"&workName="+workName;
		</script>
		<%
	}
	catch(Exception e){
	//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		e.getMessage();
	try
	{
		conn.rollback();
	}
	catch(Exception ee){}
}
%>
</form>
</body>
</html>