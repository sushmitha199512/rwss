<%
	int workCount = 1;
//System.out.println("***********************************************");
String[] workId = request.getParameterValues("works");
//System.out.println(workId);

String finyear=(String)session.getAttribute("finyear");
System.out.println("finyear"+finyear);
String workIds = "";
String mode = request.getParameter("mode");
//System.out.println("mode:"+mode);
if((mode==null)||(mode!=null && mode.equals("")))
{
%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%}%>
<%@ include file="/reports/conn.jsp" %>
<%@ page language="java" import="jxl.*,java.io.*,java.lang.*,java.util.*,java.sql.*,org.apache.commons.logging.*,jxl.write.*,jxl.write.Number" %>
<body>
<form>
<%
int rec=0;
if((mode==null)||(mode!=null && mode.equals("")))
{
	response.setContentType("text/plain"); 
	for(int i=0;i<workId.length;i++)
	{
		System.out.println("I:"+i+":"+workId[i]);
		workIds += workId[i]+",";
       
	} 
   System.out.println(">>>>>>>>>>>>"+workIds.substring(0,workIds.length()-1));  
	session.setAttribute("works",workIds);

}
else
{
	response.setContentType( "application/vnd.ms-excel" );
	response.setHeader("Content-Disposition", "attachment; filename=mpr.xls");
	workIds = (String)session.getAttribute("works");
    System.out.println(">>>>>>>>>>>>"+workIds.substring(0,workIds.length()-1));  
} 
try
{
	stmt = conn.createStatement();
	Statement stmt1 = conn.createStatement();

	if(workIds.length()>0)
	{
		//String qry = "select a.work_id,b.dname,mname,pname,vname,panch_name,panch_code,ddws_hab_code from  RWS_WORKS_ACTION_PLAN_HABS_TBL a,rws_complete_hab_view b,rws_habitation_directory_tbl c where  a.hab_code=b.panch_code and b.panch_code=c.hab_code and fin_year='2011-2012' and a.hab_code=c.hab_code and work_id in ("+workIds.substring(0,workIds.length()-1)+") order by  substr(a.work_id,5,2)";
	    //updated by swapna on 29/11/2011 for getting habs  by  comparing the work_completion_hab_lnk_table  
        String qry = "select distinct a.work_id,b.dname,mname,pname,vname,panch_name,panch_code,ddws_hab_code from  RWS_WORKS_ACTION_PLAN_HABS_TBL a,rws_complete_hab_view b,rws_habitation_directory_tbl c ,rws_work_comp_hab_lnk_tbl d   where  a.hab_code=b.panch_code and b.panch_code=c.hab_code and fin_year='"+finyear+"' and a.hab_code=c.hab_code and a.work_id in ("+workIds.substring(0,workIds.length()-1)+")  and a.work_id=d.work_id and a.hab_code=d.hab_code and b.panch_code=d.hab_code and c.hab_code=d.hab_code  order by  substr(a.work_id,5,2)"; 
		
		System.out.println("MyQQ:"+qry);
		rs = stmt.executeQuery(qry);
	}
	if(mode==null)
	{
		%>
		<table border = 0 cellspacing = 0 cellpadding = 0 width=100%>
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">
				<tr align="right">
					<td class="bwborder">
						<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</table>
		<p><font face=verdana size=3 color=blue>Habitations for the Selected Works</font></p>
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
			 border=1 style="border-collapse:collapse;" >
			<td class="bwborder" >
			<fieldset>
			<legend  >
					<B>Sanctioned Habitations</B>
			</legend>
			<label>
			<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
				<tr align=center>
				<td class=btext>Sl No.</td>
				<td class=btext>Work ID</td>
				<td class=btext>District</td>
				<td class=btext>Mandal</td>
				<td class=btext>Panchayat</td>
				<td class=btext>Village</td>
				<td class=btext>Habitation Code</td>
				<td class=btext>Habitation ID</td>
				<td class=btext>Habitation Name</td>
				</tr>
		<%
		if(rs.isBeforeFirst())
		{
			while(rs.next())
			{
			%>
			<tr>
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(7)%></td>
			<td class=rptValue><%=rs.getString("ddws_hab_code")%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<%
			}
		}
		else
		{
			%>
			<tr colspan=7><td>No Habitations</td></tr>
			<%
		}
	}
	else
	{
		WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet sheet = workbook.createSheet("First Sheet",0);
		int colCount = 0;
		Label label = null;
		label = new Label(0,colCount,"HabitationId");
		sheet.addCell(label);
		label = new Label(1,colCount,"Month");
		sheet.addCell(label);
		label = new Label(2,colCount,"Year");
		sheet.addCell(label);
		label = new Label(3,colCount,"TargetedSCPopulation");
		sheet.addCell(label);
		label = new Label(4,colCount,"TargetedSTPopulation");
		sheet.addCell(label);
		label = new Label(5,colCount,"TargetedGENPopulation");
		sheet.addCell(label);
		label = new Label(6,colCount,"SchemeId");
		sheet.addCell(label);
		 colCount++;
		%>
		
		<%
			if(rs.isBeforeFirst())
			{
				while(rs.next())
				{
					String mcode = "";
					if(request.getParameter("month").equals("April"))mcode="4";
					else if(request.getParameter("month").equals("May"))mcode="5";
					else if(request.getParameter("month").equals("June"))mcode="6";
					else if(request.getParameter("month").equals("July"))mcode="7";
					else if(request.getParameter("month").equals("August"))mcode="8";
					else if(request.getParameter("month").equals("September"))mcode="9";
					else if(request.getParameter("month").equals("October"))mcode="10";
					else if(request.getParameter("month").equals("November"))mcode="11";
					else if(request.getParameter("month").equals("December"))mcode="12";
					else if(request.getParameter("month").equals("January"))mcode="1";
					else if(request.getParameter("month").equals("February"))mcode="2";
					else if(request.getParameter("month").equals("March"))mcode="3";
	rec++;
                    //System.out.println("Record:"+rec);
				
					String qqry = "insert into rws_ddws_works_mpr_tbl values('"+rs.getString(1)+"','"+rs.getString("ddws_hab_code")+"','"+mcode+"','"+request.getParameter("year")+"')";
					//System.out.println("Insert INto:"+qqry);
					stmt1.addBatch(qqry);
					int l = 0;
					label = new Label(l,colCount,rs.getString("ddws_hab_code"));
					sheet.addCell(label);l++;
					label = new Label(l,colCount,request.getParameter("month"));
					sheet.addCell(label);l++;
					label = new Label(l,colCount,request.getParameter("year"));
					sheet.addCell(label);l++;
					label = new Label(l,colCount,"");
					sheet.addCell(label);l++;
					label = new Label(l,colCount,"");
					sheet.addCell(label);l++;
					label = new Label(l,colCount,"");
					sheet.addCell(label);l++;
					label = new Label(l,colCount,rs.getString(1));
					sheet.addCell(label);l++;
					colCount++;
 				}
			}
			int[] res = stmt1.executeBatch();
			if(res.length>0){
			workbook.write();
			workbook.close();
			}
}
}
catch(Exception e)
{
 conn.rollback();     
e.printStackTrace();}
%>
<%if((mode==null)||(mode!=null && mode.equals("")))
{%>
<tr height="80px">
<td colspan=9 align=center class=rptHeading>Select Month to Export:&nbsp;&nbsp;&nbsp;
	<select name="month" onchange="checkYear()">
	<option value="">-Select-</option>
	<option value="April">April</option>
	<option value="May">May</option>
	<option value="June">June</option>
	<option value="July">July</option>
	<option value="August">August</option>
	<option value="September">September</option>
	<option value="October">October</option>
	<option value="November">November</option>
	<option value="December">December</option>
	<option value="January">January</option>
	<option value="February">February</option>
	<option value="March">March</option>
	</select>
	-
	<input type="text" name="year"> 
<BR><BR>
<%if(workCount>1){
%><input type="button" name="mode" value="Continue and Export to Excel" class="btext" onclick="exporting()">
<%}else
{%>
<input type="button" name="mode" value="Continue and Export to Excel" class="btext" onclick="exporting()" disabled="true">
<%}%>
</td></tr>
<%}%>
</table>		
</table>	
<script language="javascript">
function checkYear()
{
 var month;
           month=document.getElementById("month").value;
if(month=="December")
{

<%
 java.util.Date dt=  new java.util.Date(System.currentTimeMillis());
      int year=dt.getYear()+1900;

 int year1;
year1=year-1;
		%>

 document.getElementById("year").value='<%=year1 %>'
}
else{


document.getElementById("year").value=<%=year %>
}
}
function exporting()
{
	if(document.forms[0].month.value=="")
	{
		alert("Please Select the Month");
	}
	else if(document.forms[0].year.value=="")
	{
		alert("Please Select the Year");
	}
	else
	{
		if(confirm("Are You Sure to Port the Habitations for the Selected Month:"+document.forms[0].month.value+"\n This operation cannot Revert Back"))
		{

			document.forms[0].action="rws_works_mpr_frm_habs.jsp";
			document.location.href="rws_works_mpr_frm.jsp";
			document.forms[0].submit();
		}
	}
}
</script>
</body>
<input type="hidden" name="mode" value="export">
</form>
<%@ include file="/commons/rws_footer.jsp"%>
