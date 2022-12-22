<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("loddeduser"+loggedUser.substring(0,4));
	String qry3="";
	String distDtlsQry = null;
    String mndDtlsQry = null;
    String panchDtlsQry = null;
    String villageDtlsQry = null;
    String habDtlsQry = null;
    String dcode="",mcode="",pcode="",vcode="",hcode="",tanker_reg_no="";
	
%>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function isFutureDate(idate){
    var today = new Date().getTime(),
        idate = idate.split("-");
        idate = new Date(idate[2], idate[1] - 1, idate[0]).getTime();
       return (today - idate) < 0;
}
 
function fnSubmitDetailsTnk()
{
	var frmdate=document.getElementById("fromDate1").value;
	var todate=document.getElementById("toDate1").value;
    var distCode=document.getElementById("districts").value;
    var dname = document.f1.districts.options[document.f1.districts.options.selectedIndex].text;
    var mandCode=document.getElementById("mandals").value;
    var mname = document.f1.mandals.options[document.f1.mandals.options.selectedIndex].text;
    var panchCode=document.getElementById("panchayats").value;
    var pname = document.f1.panchayats.options[document.f1.panchayats.options.selectedIndex].text;
    var villCode=document.getElementById("tanker").value;
    var vname = document.f1.tanker.options[document.f1.tanker.options.selectedIndex].text;
    /* var habCode=document.getElementById("habitation").value;
    var hname = document.f1.habitation.options[document.f1.habitation.options.selectedIndex].text; */
	if(document.f1.districts.selectedIndex=="")
    {
	   alert("SELECT DISTRICT...");		
	   return false;
    }
	 if(document.f1.mandals.selectedIndex=="")
	{
		alert("SELECT Mandal...");		
		return false;
	}
	 if(document.f1.panchayats.selectedIndex=="")
		{
			alert("SELECT Panchayat...");		
			return false;
		}
	 if(document.f1.tanker.selectedIndex=="")
		{
			alert("SELECT Tanker...");		
			return false;
		}
	 if(!document.getElementById("fromDate1").value=='')
	{
		 if(document.getElementById("toDate1").value=='')
			{
			alert("please Select To Date");
			return false;
			} 
	}
 if(!document.getElementById("toDate1").value=='')
	{
	 if(document.getElementById("fromDate1").value=='')
		{
		alert("please Select From Date");
		return false;
		}
	} 
 var res = frmdate.split("-", 3);
 var fnfrmdate=res[1]+"/"+res[0]+"/"+res[2];
 var res1 = todate.split("-", 3);
 var fntodate=res1[1]+"/"+res1[0]+"/"+res1[2];
 var date1 = new Date(fnfrmdate); 
 var date2 = new Date(fntodate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timea = date2.getTime() - date1.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Days = Difference_In_Timea / (1000 * 3600 * 24); 
 var today = new Date();
 var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
 var datef1 = new Date(frmdate); 
 var datef2 = new Date(date); 
 // To calculate the time difference of two dates 
 var Difference_In_Timeb = datef1.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf1 = Difference_In_Timeb / (1000 * 3600 * 24);
 var datef3 = new Date(todate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timec = datef3.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf2 = Difference_In_Timec / (1000 * 3600 * 24);    
         from = new Date(frmdate);
          to = new Date(todate);
    if(from > to)
	{
	
	alert("from date is not greater than todate.");
	}
    else
    {
    	document.f1.action="./tanker_movement_serverless_trip_details.jsp";
	     document.f1.submit();
    	
	
}	
}








function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 win.focus();
}
</script>
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<form  name=f1  method="post">
<%
/* String mode=request.getParameter("mode");
session.setAttribute("mode", mode);
String fromdate="";
String todate=""; 
 if(mode.equals("initial")){
	  fromdate="";
	  todate=""; 
 }
 else{
 fromdate=request.getParameter("fromDate");
 todate=request.getParameter("toDate");
 } */
Statement stmt1=null,stmt2=null;
ResultSet rst=null,rst2=null;
int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
   %>
   <%String isModeChange = request.getParameter("mode");
   %>
  
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3> Tanker Movement - Tanker Wise Detailed Report</td>	
	</tr>
	<%
try
{ 
	 dcode = request.getParameter("districts");
	 mcode = request.getParameter("mandals");
	 pcode = request.getParameter("panchayats");
	// vcode = request.getParameter("village");
	// hcode = request.getParameter("habitation");
	tanker_reg_no = request.getParameter("tanker");
	%>
	
	 <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="districts" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
			stmt = conn.createStatement();
    
    
    if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ))
	{
    	
    		distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
	}
    else
	{
		distDtlsQry="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
	}
			rs = stmt.executeQuery(distDtlsQry);
			while(rs.next())
			{
				//System.out.println("rs.getString(1) :"+dcode);
			     		if(rs.getString(1).equals(dcode))
						{
			     			
			%>
							 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
			
							
			<%          // session.setAttribute("dcode",rs.getString(1));
			
			         //request.setAttribute("dname", rs.getString(2));
			            session.setAttribute("dName",rs.getString(2));
			            session.removeAttribute("mName");
			            session.removeAttribute("pName");
			            session.removeAttribute("vName");
			            session.removeAttribute("hName");
			
						}
						else
						{
			%>
							 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
			<%
						}
			  }
						rs.close();			
						stmt.close();
	%>
		</tr>   
				<tr><td class=rptLabel>Mandal <font color="red">*</font></td>
		<td class=btext>
		
		<SELECT name="mandals"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" >
			<option value="0">-Select-</option>
		   
    <%
			stmt = conn.createStatement();
                mndDtlsQry="SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE='"+dcode+ "'   ORDER BY MNAME";
			rs = stmt.executeQuery(mndDtlsQry);
			while(rs.next())
			{
	        if(rs.getString(1).equals(mcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>		  
	<%
	            session.setAttribute("mName",rs.getString(2));
				}
				else
				{
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
	<%
				}
			}
						rs.close();			
						stmt.close();
	%>
	
	</td>
		</tr>
		<tr><td class=rptLabel>Panchayat<font color="red">*</font></td>
		<td class=btext>
		
		<SELECT name="panchayats"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
		    	
    <%
			stmt = conn.createStatement();
    panchDtlsQry="SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE='"+dcode+ "' AND MCODE='"+mcode+ "'  ORDER BY PNAME";
			rs = stmt.executeQuery(panchDtlsQry);
			while(rs.next())
			{
				
	     if(rs.getString(1).equals(pcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("pName",rs.getString(2));	
				}
				else
				{
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
	<%
				}
			}
						rs.close();			
						stmt.close();
	%>
	
	</td>
		</tr>
		
		<tr><td class=rptLabel>Tanker<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="tanker"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" 
		
		>
			<option value="0">-Select-</option>
		    
    <%
			stmt = conn.createStatement();
    villageDtlsQry="SELECT  distinct tanker_reg_no FROM rws_tanker_reg_tbl WHERE substr(habitation_code,1,2)='"+dcode+ "' AND substr(habitation_code,6,2)='"+mcode+ "' AND substr(habitation_code,13,2)='"+pcode+ "' ORDER BY tanker_reg_no";
			rs = stmt.executeQuery(villageDtlsQry);
			while(rs.next())
			{
				
	           if(rs.getString(1).equals(tanker_reg_no))
				{
	        	  
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%></option> 
	<%
	session.setAttribute("tName",rs.getString(1));
				}
				else
				{
					
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
	<%
				}
			}
						rs.close();			
						stmt.close();
	%>
	
	</td>
		</tr> 
	
	<tr>
	<td class=gridhdbg>From&nbsp;Date</td>
	<td class=btext>
		<input type="text" name="fromDate1" id="fromDate" style="width:90" <%if(request.getParameter("fromDate1")!= null) {%>
		value='<%=request.getParameter("fromDate1") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date</td>
	<td class=btext>
		<input type="text" name="toDate1" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate1")!= null) {%>
		value='<%=request.getParameter("toDate1") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<TR>	
<TD colspan=2 align=center valign=top>
<tr>
		<td colspan=2 align=center>
		<input type=button id="tan" onclick="fnSubmitDetailsTnk()" value="Get Data" class = btext></td>
	</tr>
</TD>
</TR>	
	<%	
}
	catch(Exception e)
		{
 System.out.println("Exception in tanker moving Report frm jsp:"+e);
        }
    %>
</table>

	</table>	
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>