<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%////System.out.println("in pao bills");%>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%
String pcode = request.getParameter("pcode");
 if(pcode!=null){
   session.setAttribute("pcode",pcode);

}
NumberFormat formatter = new DecimalFormat("#0.00");
int count = 1,sno=0;
String per = request.getParameter("per");
 if(per !=null){
	session.setAttribute("per",per);
}
if(per==null)per="";
%>
<html>
<style>
.diva
{
	width:14px;
	height:14px;
	clip:rect(0,14,14,0);
	overflow:hidden;
}
.spana
{
background-color:red;
position:relative;
top:-3px;
left:-3px;
}
.checka
{
margin:0;
padding:0;
FILTER:progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50)-moz-opacity:0.1;
}
</style>
<style>

#input_box {
	background-color:white;
	font-weight:bold;
	font-size:10;
	color:green;
	
}
</style>
<script language="javascript">

function checkAll()
{
	for(var i=0;i<document.forms[0].sendBank.length;i++)
	{
		
		document.forms[0].sendBank[i].checked==true;
	}
}

function unCheckAll()
{
	for(var i=0;i<document.forms[0].sendBank.length;i++)
	{
		
		document.forms[0].sendBank[i].checked==false;
	}
}
</script>
<script language="javascript">
function fnClose()
{
	document.forms[0].action="rws_ee_homepage_frm.jsp";
	document.forms[0].submit();	
}
function fnAllBals(){
	var url="rws_bill_tobe_release_programes_rpt.jsp";
	var properties="width=648,height=562,toolbar=no,status=no,menubar=no,location=no,directories=noscrollbars=yes,copyhistory=no,resizable=yes";
	newWindow1 = window.open(url, "_New", properties);
}

function init()
{
	var per ='<%=per%>';
	if(per=="")
	{
		alert("Before Processing the Bills You may view the All Programs Balances Report");
		if(confirm("Do You want View the Report"))
			{
				var url="rws_bill_tobe_release_programes_rpt.jsp";
				var properties="width=648,height=562,toolbar=no,status=no,menubar=no,location=no,directories=noscrollbars=yes,copyhistory=no,resizable=yes";
				newWindow = window.open(url, "_New", properties);
			}
	}
}
function getBills()
{
//	alert("aaaaa");
	var per = document.forms[0].per.value;
	if(per=="")
	{
		alert("Please Select Any District or ALL option");
		return false;
	}
	else
	{
		document.forms[0].action="rws_bill_release_to_pao.jsp?per="+document.forms[0].per.value;
		document.forms[0].submit();
	}
}

function fnAllBills()
{
	 var url="rws_bill_selected_to_encpao_rpt.jsp";
     var properties="width=648,height=562,toolbar=no,status=yes,menubar=no,location=no,directories=no scrollbars=yes,copyhistory=no,resizable=yes";
     newWindow1 = window.open(url, "_New", properties);
}

function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
function fnSave()
{
	var flag = false;
	for(var i=0;i<document.forms[0].sendBank.length;i++)
	{
		
		if(document.forms[0].sendBank[i].checked==true)
		{
			flag=true;
			//if(parseFloat(document.getElementById('statec'+i).value)<0)
			if(parseFloat(document.forms[0].elements["statec"+i].value)<0)
			{
				alert("This bill cannot be Forwarded to ENC Because of Invalid Amount("+document.forms[0].elements["statec"+i].value+") for the Sl. No:"+(i+1));
				document.forms[0].sendBank[i].checked=false;
				document.forms[0].sendBank[i].disabled=true;
				return false;
			}
		}

	}

	if(flag==true)
	{
		if(confirm("Are You Sure"))
		{
			document.forms[0].elements["fnSavve"].disabled=true;
			document.forms[0].elements["fnSavve"].value="Wait...";
			document.forms[0].action="rws_bill_release_to_pao_save.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		document.forms[0].elements["fnSavve"].value="Save";
		document.forms[0].elements["fnSavve"].disabled=false;
		alert("Please Select Atleast One Check Box to Continue");
	}
}
</script>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table.css'/>">
<body  bgcolor="#edf2f8"> <!-- onload="init()" -->
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<form method="post">
<BR><BR>
<table border = 0 align = "right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse">		
				<tr>
					<td align="right" class="bwborder">
							<a href="<rws:context page='/home.jsp'/>" >My Home</a><a href="rws_bill_release_to_pao_print.jsp" target="_new">&nbsp;&nbsp;<img src="../images/print_icon.jpg" width="30" height="30"></a>
<a href="rws_bill_release_to_pao_excel.jsp" target="_new">&nbsp;&nbsp;<img src="../images/excel_icon.jpg" width="30" height="30"></a>

					</td>
				</tr>
			</table>
		</caption>
</table>
		<table align=center>
		<tr  align="center">
			<td class="rptHeading" style="width:50%" align="center">PAO - Payment Due and Releases Entry Form</td>
			<td class="rptHeading"  style="width:50%" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		</table>
		<%
        ////System.out.println("in pao1"+per);
		nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String userid = users.getUserId();
		////System.out.println("user di:"+userid);
		DecimalFormat ndf = new DecimalFormat("####.00");
		double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0;
		Statement st1 = null;
		Statement st2 = null;
		Statement st3 = null;
		Statement st4 = null;
		Statement st5 = null;
		Statement st6 = null;
		Statement stt = null;
		ResultSet rss = null,rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null;
	try
	{
		////System.out.println("in pao1"+per);
		st4 = conn.createStatement();
		rs4 = st4.executeQuery("select circle_office_code,circle_office_name from rws_circle_office_tbl order by circle_office_name");
		%>
		<p align=center>
		<font face=verdana size=2>Select Circle : <select name="per" class="mycombo" onchange="getBills()" >
		<option value="">-Select-</option>
		<%
			if(per!=null && per.equals("ALL"))
			{
		%>
			<option value="ALL" selected>ALL</option>
		<%
			}else if(per!=null && !per.equals("ALL"))
			{
		%>
			<option value="ALL">ALL</option>
		<%}
		while(rs4.next())
		{
			if(per!=null && per.equals(rs4.getString(1)))
			{
				%>
					<option value="<%=rs4.getString(1)%>" selected><%=rs4.getString(2)%></option>
				<%
			}
			else if(per!=null && !per.equals(rs4.getString(1)))
			{
				%>
					<option value="<%=rs4.getString(1)%>"><%=rs4.getString(2)%></option>
				<%
			}
		}
		%>
			</select>
			<input type="button" value="View All Districts Selection" onClick="fnAllBills()" class="gridhdbg">
			<a href="#" onclick="fnAllBals()">View All Balances Report</a>
			</p>
			</br></br>
		<%
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		String dquery = "",dquery1 = "";
		if(per!=null && per.equals(""))
		{

		}
		else
		{
			if(per!=null && per.equals("ALL"))
			{	dquery = "";dquery1 = "";}
			else
			{
				dquery = " and substr(a.work_id,5,2)='"+per+"'";
				dquery1 = " where substr(work_id,5,2)='"+per+"'";
			}
		String q1 = "select work_id,bill_sl_no,nvl(sum(bill_amout_state),0),nvl(sum(bill_amount_central),0) from rws_bill_bank_bridge_tbl "+dquery1+" group by work_id,bill_sl_no order by work_id desc";
			////System.out.println("q111111111:"+q1);
			rs1 = st1.executeQuery(q1);
			Hashtable ht1 = new Hashtable();
			while(rs1.next())
			{
				ht1.put(rs1.getString(1)+rs1.getString(2),rs1.getString(3)+"@"+rs1.getString(4)); 
			}
			
			String q2 = "select work_id,bill_sl_no,bill_amout_state,bill_amount_central from rws_bill_pao_bridge_temp_tbl "+dquery1+"";
			////System.out.println("q122222222:"+q2);
			rs2 = st2.executeQuery(q2);
			Hashtable ht2 = new Hashtable();
			int billCount = 0;
			long billAmt = 0;
			while(rs2.next())
			{
				ht2.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
				billCount++;
				billAmt += Double.parseDouble(rs2.getString(3))+Double.parseDouble(rs2.getString(4));
				////System.out.println("amount:"+billAmt);
			}
					
	String qry = "select circle_office_name,division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100, (nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,d.circle_office_code,sd.division_office_code,to_char (update_date,'dd/mm/yyyy') as update_date,nvl(to_char(EE_FWD_DATE,'dd/mm/yyyy'),'') as EE_FWD_DATE   from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd where substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 "+dquery+"  order by to_date(EE_FWD_DATE,'dd/mm/yyyy') desc";//and rownum<100 and b.work_id='01010401100167'   and b.work_id='15010803090001' and bill_sl_no='1'		////System.out.println("qry:"+qry);
		  
	    System.out.println("Query:"+qry);
	stmt = conn.createStatement();
		  rs = stmt.executeQuery(qry);
		  %>
       <table align=left>
			  <tr><td class=rptValue>
				<font color=red>So far Selected Under this District : <b><%=billCount%></b> Bills and its Amount <b style="font-family: Rupee Foradian;">`</b> <b><%=billAmt%></b></font>
			  </td></tr>
			</table>
		  
		 <br><br>
		<table border = 0  align=center  style="border-collapse:collapse">
			 <tr><td colspan="9" align="right"> <a href="#" onclick="checkAll()">Check All</a>&nbsp;&nbsp;&nbsp;<a href="#" onclick="unCheckAll()">UnCheck All</a></td></tr>
			 <tr align="center">
				<td class=gridhdbg rowspan="2">Sl. No.</td>
				<!-- <td class=gridhdbg rowspan="2">Circle</td> -->
				<td class=gridhdbg rowspan="2">Division</td>
				<td class=gridhdbg rowspan="2">Work ID/<BR>Work Name</td>
				<!-- <td class=gridhdbg rowspan="2">Admin No</td>
				<td class=gridhdbg rowspan="2">Admin Date</td> -->
				<!-- <td class=gridhdbg rowspan="2">Sanction Amount<BR>(In Lakhs)</td> -->
				<td class=gridhdbg rowspan="2">Sanction Amount/<BR>Program/<BR>Sub Program</td>
				<td class=gridhdbg rowspan="2">Bill<BR>No/<BR>Bill Date/<BR>Bill Entered Date/<BR>EE FWD Date</td>
				<td class=gridhdbg rowspan="2">Bill Amt <BR>Contractor/<br>Bill Amt <BR>Admissible</td>
				<td class=gridhdbg colspan="3">Bill Amount Due</td>
				<td class=gridhdbg colspan="3">Already Paid Bill</td>
				<td class=gridhdbg colspan="3">Now recommended </td>
				<td class=gridhdbg rowspan="2">Select</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>State</td>
				<td class=gridhdbg>GOI</td>
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>State</td>
				<td class=gridhdbg>GOI</td>
				<td class=gridhdbg>Actual</td>
				<td class=gridhdbg>State</td>
				<td class=gridhdbg>GOI</td>
			</tr>
		<%
		//	//System.out.println("222222222");  
			String val = "";
			double totalstate=0.0;
  int styleCount=0;
  String style="";
			while(rs.next())
			{
				
				if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
				////System.out.println("33333333:"+rs.getString("work_id"));  
				val = "";
				String duestate = "0",duecentral1 = "0",duecentral="0";
				val = ""+ht1.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
				////System.out.println("444444444:"+val);  
				if(val!=null && !val.equals("null")){}else{val="0@0";}
				String[] vals = val.split("@");
			    boolean flag = false;
				
				if(ht1.containsKey(rs.getString("work_id")+rs.getString("bill_sl_no")))
				{		
					////System.out.println("1111111:"+rs.getString(13)+"--:"+rs.getString(14)+"--:"+rs.getString(15));  					if(Double.parseDouble(rs.getString(13))>(Double.parseDouble(vals[0])+Double.parseDouble(vals[1])))
					{
						////System.out.println("1");
						if((Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]))<0)
						{
							
							duecentral1 = ""+((Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]))+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1])));
						}
						else
						{
							////System.out.println("nbbbbbbbbbbbb");
							duecentral1 = ""+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1]));
						}
						duestate = ""+(Double.parseDouble(rs.getString(14))-Double.parseDouble(vals[0]));
						////System.out.println("dddddddddddddddd:"+duestate);
						duecentral = ""+(Double.parseDouble(rs.getString(15))-Double.parseDouble(vals[1]));
						////System.out.println("dddddddddddddddd:"+duecentral);
						if(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0)
						flag = true;	
					}
				}
				else
				{
					////System.out.println("2222222222");  
					duestate = ""+Double.parseDouble(rs.getString(14));
					//duestate1 = duestate;
					////System.out.println("44444444sss"+duestate);  
					duecentral = ""+Double.parseDouble(rs.getString(15));
					duecentral1 = duecentral;
					////System.out.println("44444444sssfff"+duecentral);  
					if(Double.parseDouble(duestate)+Double.parseDouble(duecentral)>0)
					flag = true;
				}
				if(flag){
				String state = ""+Double.parseDouble(vals[0]);
				////System.out.println("state:"+state);
				String central = ""+Double.parseDouble(vals[1]);
				////System.out.println("central:"+central);
				////System.out.println("555555555");  
			  %>
				<tr onclick="toggleRowColor(this)">
					<td class=<%=style %> style="text-align: left;" nowrap><%=count++%></td>
			
					<!-- <td class=<%=style %> style="text-align: left;" nowrap><%=rs.getString(1)%></td> -->
					<td class=<%=style %> style="text-align: left;"> <input type="text" name="aa" class="mytext" style="width:80px" readonly="true" onmouseover="Tip(this.value,TITLE,'Division')" value="<%=rs.getString(2)%>" onmouseout="UnTip()"/></td>
					
					<td class=<%=style %> style="text-align: left;" nowrap><%=rs.getString(3)%>/<BR><input type="text" name="a" class="mytext" style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')" value="<%=rs.getString(4)%>" onmouseout="UnTip()"/></td>

					<td class=<%=style %> style="text-align: left;" nowrap><b style="font-family: Rupee Foradian;">`</b><%=rs.getString("samtt")%><BR><%=rs.getString(8)%>/<br><%=rs.getString(9)%></td>
						<td class=<%=style %> style="text-align: left;"> <input type="text" name="b" class="mytext" style="width:80px" readonly="true" onmouseover="Tip(this.value,TITLE,'Bill No')" value="<%=rs.getString(10)%>" onmouseout="UnTip()"/><BR><%=rs.getString(11)%>/<br><%=rs.getString("update_date")%>/<br><%=rs.getString("EE_FWD_DATE")==null?"-":rs.getString("EE_FWD_DATE") %> 
					
					<td class=<%=style %> style="text-align: left;" nowrap align="right"><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
					<td class=<%=style %> style="text-align: left;"  nowrap><input type="text" name="tota<%=sno%>"value="<%=formatter.format(Double.parseDouble(duestate)+Double.parseDouble(duecentral))%>" class="mytext" readonly="true" style="width:60px"></td>
					<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="statea<%=sno%>" value="<%=formatter.format(Double.parseDouble(duestate))%>" class="mytext" readonly="true" style="width:60px"></td>
					<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="goia<%=sno%>" value="<%=formatter.format(Double.parseDouble(duecentral1))%>" class="mytext" readonly="true" style="width:60px"></td>

					<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="totb<%=sno%>" value="<%=formatter.format(Math.ceil(Double.parseDouble(state)+Double.parseDouble(central)))%>" class="mytext" readonly="true" style="width:60px"></td>
					<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="stateb<%=sno%>" value="<%=formatter.format(Double.parseDouble(state))%>" class="mytext" readonly="true" style="width:60px"></td>
						<%String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));%>

					<td class=<%=style %> style="text-align: left;" nowrap><input type="text" name="goib<%=sno%>" value="<%=formatter.format(Double.parseDouble(central))%>" class="mytext" readonly="true" style="width:60px"></td>			
					<td class=<%=style %> style="text-align: left;"><input type="text" id="input_box" name="totc<%=sno%>" value="<%=formatter.format((Double.parseDouble(duestate)+Double.parseDouble(duecentral)))%>" class="mytext" readonly style="width:60px" ></td>					<%if(Double.parseDouble(duecentral)<0)duestate=""+(Double.parseDouble(duestate)+Double.parseDouble(duecentral));%>
					<td class=<%=style %> style="text-align: left;" nowrap>
					<%if(val1!=null && !val1.equals("null"))
						{
							////System.out.println(val1);
							String val1s[] = val1.split("@");
							double percentage = ((Double.parseDouble(val1s[0])/(Double.parseDouble(duestate)+Double.parseDouble(duecentral)))*100);
						%>
						<input type="text" id="input_box" style="width:25px" name="stateca<%=sno%>" class="mytext"  onkeypress="return numeralsOnly()" onkeyup="fnCalState('<%=sno%>')" onchange="fnCalState('<%=sno%>')" value="<%=percentage%>">
						<input type="text" id="input_box" name="statec<%=sno%>" value="<%=formatter.format(Double.parseDouble(val1s[0]))%>" class="mytext" style="width:60px" onkeypress="return numeralsOnly()" onkeyup="fnCalStatePer('<%=sno%>')" >
						<%}else{%>
						<input type="text" id="input_box" style="width:25px" name="stateca<%=sno%>" class="mytext"  value="<%=rs.getString("STATE_SHARE")%>" onkeypress="return numeralsOnly()" onkeyup="fnCalState('<%=sno%>')" onchange="fnCalState('<%=sno%>')">
						<input type="text" id="input_box" name="statec<%=sno%>" value="<%=formatter.format(Double.parseDouble(duestate))%>" class="mytext" style="width:60px" onkeypress="return numeralsOnly()" onkeyup="fnCalStatePer('<%=sno%>')">
					<%}%></td>
					<td class=<%=style %> style="text-align: left;"  nowrap>
						<input type="text"  style="width:20px" name="goica<%=sno%>" class="mytext"   value="0" readonly="true">
						<input type="text"  name="goic<%=sno%>" value="0" class="mytext" style="width:20px" readonly="true">
					</td>
					<input type="hidden" name="officeCode<%=sno%>" value="<%=rs.getString("office_code")%>">
					<input type="hidden" name="workId<%=sno%>" value="<%=rs.getString("work_id")%>">
					<input type="hidden" name="billSno<%=sno%>" value="<%=rs.getString("bill_sl_no")%>">
					<input type="hidden" name="progCode<%=sno%>" value="<%=rs.getString("programme_code")%>">
					<input type="hidden" name="progName<%=sno%>" value="<%=rs.getString("programme_name")%>">
					<input type="hidden" name="dcode<%=sno%>" value="<%=rs.getString("circle_office_code")%>">
					<input type="hidden" name="divcode<%=sno%>" value="<%=rs.getString("division_office_code")%>">
					<%
						if(rs.getString(14).equals("0") && rs.getString(15).equals("0"))
						{%>
							<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('State/Central Share Not Given',TITLE,'Error')" onmouseout="UnTip()"><div class="diva"><span class="spana"><input type="checkbox"  disabled name="sendBank" value="<%=sno%>" class="checka"></span></div></td>
							<%
						}
						else
						{
							if(rs.getString("EE_FWD_DATE")==null || (rs.getString("EE_FWD_DATE")!=null && rs.getString("EE_FWD_DATE").equals("")))
								{%>
								<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('EE Not Yet Forwaded',TITLE,'Alert')" onmouseout="UnTip()"><div class="diva"><span class="spana"><input disabled type="checkbox" name="sendBank" value="<%=sno%>" class="checka"></span></div></td>
								<%}
								else
								{
									//String val1 = ""+ht2.get(rs.getString("work_id")+rs.getString("bill_sl_no"));
									if(duestate.substring(0,1).equals("-") || duestate.equals("0.0"))
									{
										
										%>
										<td class=<%=style %> style="text-align: left;" ><input type="checkbox" name="sendBank" value="<%=sno%>" disabled="true"></td>
										<%
									}
									else
									{
										if(val1!=null && !val1.equals("null"))
										{
											////System.out.println("8");  
											%>
											<td class=<%=style %> style="text-align: left;"  align="center"><input type="checkbox" name="sendBank" value="<%=sno%>" checked="true"></td>
											<%
										}
										else
										{
										%>
										<td class=<%=style %> style="text-align: left;"  align="center"><input type="checkbox" name="sendBank" value="<%=sno%>"></td>
										<%}
									}
								}
						}%>
				</tr>
			<%
				}
						
					if(flag)sno++;
					////System.out.println("999");  
					//String pcode=rs.getString("work_id");
//					//System.out.println("pcode value:"+rs.getString("work_id").substring(2,2));
					////System.out.println("pcode:"+pcode);
					//totalstate+=formatter.format((Math.ceil(workData.round(Double.parseDouble(duecentral),2)));

						
			}
		//	//System.out.println("Total State Value:"+formatter.format((totalstate));
			%>
		
		</table><BR>
		<table>
		<tr  align="center">
		</tr></table>
		<table align=center>
		<tr>
			<td align="center">
				<input type=button name=getValues value="Close" onclick="fnClose()" class="gridhdbg">&nbsp;&nbsp;
				<input type=button name=getValues value="Save" onclick="fnSave()" id=fnSavve class="gridhdbg">&nbsp;&nbsp;
				
			</td>
		</tr>	</table>
	<%}
	}
		catch(Exception e){
		//System.out.println("error in report:"+e.getMessage());
		e.printStackTrace();}
		finally{
		try{
			if(rs!=null)rs.close();if(stmt!=null)stmt.close();
			if(rs1!=null)rs1.close();if(st1!=null)st1.close();
			if(rs2!=null)rs2.close();if(st2!=null)st2.close();
			if(rs3!=null)rs3.close();if(st3!=null)st3.close();
			if(rs4!=null)rs4.close();if(st4!=null)st4.close();
			if(rs5!=null)rs5.close();if(st5!=null)st5.close();
			if(rs6!=null)rs6.close();if(st6!=null)st6.close();
			if(conn!=null)conn.close();
		}catch(Exception eee){eee.getMessage();}
		}
	
	%>
	<script>
	function fnCalState(val)
	{
		if(parseInt(document.forms[0].elements["stateca"+val].value)>100)
		{
			document.forms[0].elements["stateca"+val].value = '0';
			document.forms[0].elements["statec"+val].value = '0';
			alert("State Percentage Should be in Between 1-100");
		}
		if((parseInt(document.forms[0].elements["stateca"+val].value)+parseInt(document.forms[0].elements["goica"+val].value))>100)
		{
			document.forms[0].elements["stateca"+val].value = '0';
			document.forms[0].elements["statec"+val].value = '0';
			alert("State+GOI Percentage Should be in Between 1-100");
		}
		else
		{
			var value = parseFloat(document.forms[0].elements["totc"+val].value)*((parseFloat(document.forms[0].elements["stateca"+val].value))/100);
			if(isNaN(value))
			{
				document.forms[0].elements["statec"+val].value = '0';
			}
			else
			{
				document.forms[0].elements["statec"+val].value = Math.round((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
				//document.getElementById('statec'+val).value = Math.round(((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2));
			}
		}
		fnDisable(val);
	}	
	
	function fnDisable(val)
	{
		for(var i=0;i<document.forms[0].sendBank.length;i++)
		{
			if(val==i)
			{
				if(parseFloat(document.forms[0].elements["stateca"+val].value)>0 || document.forms[0].elements["stateca"+val].value=="0.0")
				{
					document.forms[0].sendBank[i].disabled=false;			
				}
				else
				{
					document.forms[0].sendBank[i].disabled=true;
				}
			}
		}
	}
	function fnCheckMax(val)
	{
		fnCalState(val);
		fnCalCentral(val);
		if((parseFloat(document.forms[0].elements["totc"+val].value))>(parseFloat(document.forms[0].elements["tota"+val].value)))
		{
			document.forms[0].elements["totc"+val].value = '0';
			document.forms[0].elements["statec"+val].value = '0';
			document.forms[0].elements["goic"+val].value = '0';
			alert("Now Recommended Amount Should be Less than or Equal to Bill Amount Due");
		}
		fnDisable(val);
	}
	function fnCalStatePer(val)
	{
		
		if(parseFloat(document.forms[0].elements["statec"+val].value)>parseFloat(document.forms[0].elements["totc"+val].value))
		{
			document.forms[0].elements["statec"+val].value = '0';
			document.forms[0].elements["stateca"+val].value = '0';
			alert("State Amount of Now Recommended Should be in Less than or equal to Actual Amount of Now Recommended");
		}
		else
		{
			var value = ((parseFloat(document.forms[0].elements["statec"+val].value))/(parseFloat(document.forms[0].elements["tota"+val].value)))*100;
			if(value=="" || value == null || isNaN(value))
			{
				document.forms[0].elements["stateca"+val].value = '0';
			}
			else
			{
				document.forms[0].elements["stateca"+val].value = value;//formatter.format(((parseFloat(value))*Math.pow(10,2))/Math.pow(10,2);
			}
		}
		fnDisable(val);
	}
	</script>
	<input type="hidden" name="totBills" value='<%=sno%>'>
</form>

</body>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>