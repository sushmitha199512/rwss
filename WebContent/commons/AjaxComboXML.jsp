<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="nic.watersoft.commons.AjaxList" %>
<%@ page contentType="text/xml" %>
<%

	String headOfficeCode = request.getParameter("headOfficeCode");
	String circleOfficeCode = request.getParameter("circleOfficeCode");
	String divisionOfficeCode = request.getParameter("divisionOfficeCode");
	String subdivisionOfficeCode = request.getParameter("subdivisionOfficeCode");
	
	String programmeCode = request.getParameter("programmeCode");
	
	String repCode = request.getParameter("repCode");
	String constituencyCode = request.getParameter("constituencyCode");
	 
	String formName = request.getParameter("formName");
	String targetElem = request.getParameter("targetElem");
	
	String xmlContent = null;
	
	
	Context ctx = new InitialContext();
	DataSource dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/pred");
	//System.out.println("DataSource is " + dataSource);
	AjaxList ajaxList = new AjaxList(dataSource, formName, targetElem);
	
	if(targetElem != null)
	{
		if(targetElem.equals("circleOfficeCode"))
		{
			xmlContent = ajaxList.getCircles(headOfficeCode);
		}
		else
		if(targetElem.equals("divisionOfficeCode"))
		{
			xmlContent = ajaxList.getDivisions(headOfficeCode,circleOfficeCode);
		}
		else
		if(targetElem.equals("subdivisionOfficeCode"))
		{
			xmlContent = ajaxList.getSubdivisions(headOfficeCode,circleOfficeCode,divisionOfficeCode);
		}
		else
		if(targetElem.equals("subprogrammeCode"))
		{
			xmlContent = ajaxList.getSubprogrammes(programmeCode);
		}
		else
		if(targetElem.equals("constituencyCode"))
		{
			xmlContent = ajaxList.getConstituencies(repCode);
		}
	}
	
	out.println(xmlContent);

%>
