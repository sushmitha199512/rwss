<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="nic.watersoft.reports.Rws_Access"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%

	String dcode = request.getParameter("district");
	String financialYear1=request.getParameter("financialYear");

	//System.out.println("&&&&&&&&&&&&&&&&&&&test1");
	Rws_Access rws_Access = new Rws_Access();
	//System.out.println("&&&&&&&&&&&&&&&&&&&test2");
	String filepath = request.getSession().getServletContext().getRealPath("/") + "portings";
	System.out.println("my dynamic path" + filepath);
	String filename = filepath + java.io.File.separator + "WORK_QUALITY_TEST_REPORT.mdb";
	session.setAttribute("fname","WORK_QUALITY_TEST_REPORT.mdb");
	
	//Database database = Rws_Access.createDatabase(filename);
	
	java.io.File dbFile = new java.io.File(filename);
	com.healthmarketscience.jackcess.Database database = com.healthmarketscience.jackcess.DatabaseBuilder.create(com.healthmarketscience.jackcess.Database.FileFormat.V2007, dbFile);
	
	if(rws_Access.writeRWS_WQ_Test_Reports_to_File(database,RwsOffices.getConn(),dcode,financialYear1))
	{
		System.out.println(" ************Successfully Created ");
		response.sendRedirect("/pred/reports/rws_wq_test_results_file.jsp");
	}
	else
	{
		response.sendRedirect("/pred/reports/rws_WQ_Test_Results_frm_rpt.jsp?flag=0");		
	}

%>



