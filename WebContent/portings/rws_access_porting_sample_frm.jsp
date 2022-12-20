

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	//////// // System.out.println("***********************FROM BEGINING***********************");
	//String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
   user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user.getUserId();
   //System.out.println("loggeduser:"+loggedUser);
  /*  Statement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String district= null;
    String mandal = null;; */
	
	
	String fileName=(String)session.getAttribute("fname");
	
	
%>
<html>
<head>



</head>
<body bgcolor="#edf2f8" >

<%

/* try{
	String mdbdname="new.mdb";
	String filepath = request.getSession().getServletContext()
			.getRealPath("/")
			+ "portings";
	session.setAttribute("fname", mdbdname);

	String filename = filepath + File.separator + mdbdname;
	Debug.println("my dynamic path" + filename);
	
stmt=conn.createStatement();
query="select * from rws_bill_bank_bridge_tbl";
rs=stmt.executeQuery(query);
Database db1 = DatabaseBuilder.create(Database.FileFormat.V2000,
        new File(filename));
Database db = DatabaseBuilder.open(new File(filename));
new ImportUtil.Builder(db, "rws_bill_bank_bridge_tbl").importResultSet(rs);

stmt1=conn.createStatement();
query="select * from RWS_BILL_PAO_BRIDGE_DET_TBL";
rs1=stmt1.executeQuery(query);

db = DatabaseBuilder.open(new File(filename));
new ImportUtil.Builder(db, "RWS_BILL_PAO_BRIDGE_DET_TBL").importResultSet(rs1);
db.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	try{
		if(conn!=null){
			conn.close();
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
} */
%>
<table align=center cellspacing = 0 cellpadding = 0 rules="rows"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; <a href="javascript:onclick=history.go(-1)">Back  </td>
			</tr>
			</table>
		</caption>
		
</table>

<br><br><br><br><br><br>
<table bordercolor=navy width="50%" height="20%" border=1 rules="rows"
	style="border-collapse: collapse" align=center>
	<tr align=center>
		<td class=rptLabel><%=fileName %>&nbsp; FILE&nbsp;</td>
	</tr>
	<tr align=center>
		<td class=rptValue><html:link action="/DownloadIt.do">Click here for the MDB</html:link>
		</td>
	</tr>

<tr>
<td class=rptValue>
<html:messages id="msg" message="true">
<ul>
       <li><bean:write name="msg" /></li>
       </ul>
   </html:messages>
   </td>
</tr>
</table>




</table>
<%@ include file = "/reports/footer.jsp" %>

</body>
</html>
