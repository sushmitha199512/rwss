   
    <%@ include file="conn.jsp"%>
<%
	//System.out.println("************************REPORT BEGINING************************");
	String sqlquery=null;
	String distcode=request.getParameter("dcode");
   String mcode=request.getParameter("mcode");
  String  pcode=request.getParameter("pcode");
   String vcode=request.getParameter("vcode");
  String  prcode=request.getParameter("prcode");
     
	//System.out.println("District = " +distcode);	
try
{
	// conn=ds.getConnection();
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	 if(distcode!=null)
	{
	 sqlquery ="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+distcode+"' order by drill_year";
	}

	if(distcode!=null && mcode !=null)
	{
		sqlquery="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+distcode+"'and substr(hp_code,6,2)='"+mcode+"'order by drill_year";
	}
	if(distcode!=null && mcode !=null && pcode!=null)
	{
		sqlquery="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+distcode+"' and substr(hp_code,6,2)='"+mcode+"'and substr(hp_code,13,2)='"+pcode+"'order by drill_year";
   
	}
    if(distcode!=null && mcode !=null && pcode!=null && vcode!=null)
	{
		sqlquery="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+distcode+"' and substr(hp_code,6,2)='"+mcode+"' and substr(hp_code,13,2)='"+pcode+"' and substr(hp_code,8,3)='"+vcode+"' order by drill_year";
    }
	if(distcode!=null && mcode !=null && pcode!=null && vcode!=null && prcode!=null)
	{
	 sqlquery ="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)='"+distcode+"'and substr(hp_code,6,2)='"+mcode+"'and substr(hp_code,13,2)='"+pcode+"' and substr(hp_code,8,3)='"+vcode+"' and substr(hp_code,1,16)='"+prcode+"' order by drill_year";
	}
	//System.out.println("query is  "+sqlquery);

	rs = stmt.executeQuery(sqlquery);

	rs.setFetchSize(1000);

	rs.last();

	int rsSize = rs.getRow();
     rs.beforeFirst();
	//System.out.println("Giving the value of rsSize " + rsSize);
	session.setAttribute("rsSize", new Integer(rsSize));	
	session.setAttribute("format",rs);%>
		

<%@ include file="page.jsp"%>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}

%>

