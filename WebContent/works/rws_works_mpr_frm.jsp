<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<SCRIPT LANGUAGE="JavaScript">
function selectAllCheckBoxes() 
{     
    var formObj; 
    var fldObj; 
    formObj = document.forms[0]; 
    for (var i=0;i < formObj.length;i++)  
    { 
         
    fldObj = formObj.elements[i]; 
    if (fldObj.type == 'checkbox') 
     {  
     if ( fldObj.name== 'checkall') 
      {  
      fldObj.checked = true; 
      } 
     }  
    }  
} 
 function uncheckAllCheckBoxes() {     
     var formObj; 
     var fldObj; 
     formObj = document.forms[0]; 
      // alert("in uncheck all function"); 
    for (var i=0;i < formObj.length;i++) { 
         fldObj = formObj.elements[i]; 
             
        if (fldObj.type == 'checkbox')  
        {  
        if (fldObj.name == 'fields') 
         {  
            fldObj.checked = false; 
          } 
        }  
        } 
 } 
function playCheckBoxes() 
{ 
    var button=document.forms[0].checkall.checked; 
    if (button==true)
    {
   //  alert("in2");
    for(var i=0;i<document.forms[0].works.length;i++) 
    { 
        document.forms[0].works[i].checked = true ; 
    }
     }
     else
     {
  //   alert("in3");
    for(var i=0;i<document.forms[0].works.length;i++) 
    { 
        document.forms[0].works[i].checked = false ; 
    }
     } 
} 
function getHabs(workId)
{
	var zURL = "../works/rws_works_mpr_hab_frm.jsp?workId="+workId;
	var popFeatures = "width=950,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
</SCRIPT>
<body>
<form method="post">
<%
try
{
//added by jyothi on 27-02-12 for dynamic year display
WorksData1 wd = new WorksData1();
int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
int finyear1=year1-1;
System.out.println("current year"+year1);
System.out.println("previous year"+finyear1);
String finyear=finyear1+ "-" + year1;
System.out.println("Finacial year"+finyear);
session.setAttribute("finyear",finyear);
//end



ArrayList works = new ArrayList();
ArrayList worksColors = new ArrayList();
   int i = 0;
ResultSet habrs = null;
Statement stmt1 = conn.createStatement();
Statement stmt2 = conn.createStatement();
String qq = "select distinct work_id,month from rws_ddws_works_mpr_tbl where (TO_NUMBER(month)>=4 and year='"+finyear1+"') or (TO_NUMBER(month)<=3 and year='"+year1+"')";
ResultSet rs1 = stmt1.executeQuery(qq);
System.out.println("qry:"+qq);
 while(rs1.next())
{
	works.add(i,rs1.getString(1));
	worksColors.add(i++,rs1.getString(1)+rs1.getString(2));
}
//System.out.println("******************select count(*),work_id from RWS_WORKS_ACTION_PLAN_HABS_TBL group by work_id");
habrs = stmt2.executeQuery("select count(*),work_id from RWS_WORKS_ACTION_PLAN_HABS_TBL where fin_year='"+finyear+"' group by work_id");
Hashtable hashtable = new Hashtable();
System.out.println("1111111111111111");
while(habrs.next())
{
	hashtable.put(habrs.getString(2),habrs.getString(1)); 
}
Iterator iterator = hashtable.keySet().iterator();
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs = stmt.executeQuery("select a.work_id,to_char(b.date_of_completion) as doc,b.date_of_completion,w.work_name,to_char(w.admin_date,'dd/mm/yyyy'),w.sanction_amount,dname from rws_work_admn_tbl w,rws_ddws_scheme_data_port a,rws_work_completion_tbl b,rws_district_tbl c where a.work_id=b.work_id(+) and w.work_id=a.work_id and work_asset='W' and fin_year='"+finyear+"' and substr(w.work_id,5,2) =c.dcode order by dname,DATE_OF_COMPLETION desc");

int workCount = 1;
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
<p><font face=verdana size=3 color=blue>Scheme MPR Generation</font></p>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=black style="border-collapse:collapse" width="28%">
<tr><td width="20%" bgcolor="#cccc99"></td><td class=rptValue> - Already Submitted</td></tr>
<tr><td bgcolor="white"> </td><td class=rptValue>- Not Completed</td></tr>
<tr><td bgcolor="#CCCCff"> </td><td class=rptValue>- Completed but Not Yet Submitted</td></tr>
</table>
<BR>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Works Details</B>
		</legend>
		<label>
		<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr  align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Select</td>
			<td class=btext>District</td>
			<td class=btext>Work ID</td>
			<td class=btext>Habs</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin No</td>
			<td class=btext>Cost</td>
			<td class=btext>Completion Date</td>
			</tr>
<%
while(rs.next())
{
	String cdate = rs.getString(2);
	if(works.contains(rs.getString(1)) && (cdate!=null && !cdate.equals("")))
	{%>
		<tr  bgcolor="#CCCC99">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue><%=rs.getString("dname")%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue align="center"><a href="#" onClick="getHabs('<%=rs.getString(1)%>')"><%=hashtable.get(rs.getString(1))%></a></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%if(cdate!=null && !cdate.equals(""))
			out.println(cdate);
			else out.println("-");%></td>
		</tr>
	<%
	}
}
%>
</table>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Select</td>
			<td class=btext>District</td>
			<td class=btext>Work ID</td>
			<td class=btext>Habs</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin No</td>
			<td class=btext>Cost</td>
			<td class=btext>Completion Date</td>
			</tr>
<%
//rs.first();
rs.absolute(1); 
workCount = 1;
while(rs.next())
{
	String cdate = rs.getString(2);
	if(cdate==null || (cdate!=null && cdate.length()<8))
	{%>
		<tr  bgcolor="white">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue align="center">-</td>
			<td class=rptValue><%=rs.getString("dname")%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue align="center"><a href="#" onClick="getHabs('<%=rs.getString(1)%>')"><%=hashtable.get(rs.getString(1))%></a></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%if(cdate!=null && !cdate.equals(""))
			out.println(cdate);
			else out.println("-");%></td>
		</tr>
	<%
	}
}
%>
</table>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Select</td>
			<td class=btext>District</td>
			<td class=btext>Work ID</td>
			<td class=btext>Habs</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin No</td>
			<td class=btext>Cost</td>
			<td class=btext>Completion Date</td>
			</tr>
<%
//rs.first();
if(rs!=null)rs.close();
rs = stmt.executeQuery("select distinct a.work_id,to_char(b.date_of_completion) as doc,b.date_of_completion,w.work_name,to_char(w.admin_date,'dd/mm/yyyy'),w.sanction_amount,dname from rws_work_admn_tbl w,rws_ddws_scheme_data_port a,rws_work_completion_tbl b,rws_district_tbl c where a.work_id=b.work_id(+) and w.work_id=a.work_id and work_asset='W' and fin_year='"+finyear+"' and substr(w.work_id,5,2) =c.dcode order by DATE_OF_COMPLETION desc");
workCount = 1;
while(rs.next())
{
	String cdate = rs.getString(2);
	if(!works.contains(rs.getString(1)) && (cdate!=null && !cdate.equals("")))
	{%>
		<tr  bgcolor="#CCCCff">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue align="center"><input type="checkbox" name="works" value="<%=rs.getString(1)%>"></td>
			<td class=rptValue><%=rs.getString("dname")%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue align="center"><a href="#" onClick="getHabs('<%=rs.getString(1)%>')"><%=hashtable.get(rs.getString(1))%></a></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%if(cdate!=null && !cdate.equals(""))
			out.println(cdate);
			else out.println("-");%></td>
		</tr>
	<%
	}
}
//System.out.println(workCount);
}
catch(Exception e)
{e.printStackTrace();}
%>
<!-- <tr height="80px"><td colspan=9 align=center>&nbsp;</td></tr>
<tr><td colspan=9 align=center><input type="button" name="mode" value="Get Habitations for Selected Works" class="btext" onclick="getHabs()"></td></tr>
<tr><td colspan=9 align=center>&nbsp;</td></tr> -->
<!-- <tr><td colspan=9 align=center><input type="button" name="mode" value="Get Habitations for Selected Works" class="btext" onclick="getHabss()"></td></tr>
 -->

<tr><td colspan="9"><INPUT type="checkbox" name="checkall" value="true" onclick="playCheckBoxes()"><font color="indigo" face="verdana" size=2><B>Check All</B></font>&nbsp;&nbsp;<input type="button" name="mode" value="Get Habitations for Selected Works" class="btext" onclick="getHabss()"></td></tr> 

</table>		
</table>	
<script>
function getHabss()
{
	var selectCount = 0;
	for(i=0;i<document.forms[0].works.length;i++)
	{
		if(document.forms[0].works[i].checked)
		{
			selectCount++;
		}
	}
	if(selectCount>0)
	{
		if(confirm("Are You Sure to Get Habitations for the Selected Work(s)"))
		{
			document.forms[0].action="rws_works_mpr_frm_habs.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Please Select Atleast one Work to Submit MPR");
	}
}
</script>
</body>
</form>
<%@ include file="/commons/rws_footer.jsp"%>
