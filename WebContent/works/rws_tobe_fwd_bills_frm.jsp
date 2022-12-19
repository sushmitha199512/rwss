<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
	int count = 0;
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	  if(userid!=null && !Constants.IsEEUser(userid)){
   	   response.sendRedirect("../commons/rws_not_authorization.jsp");
      }
	  String pCopy = null;
%>
<style>
.thumbnail {
	position: relative;
	z-index: 0;
}

.thumbnail:hover {
	background-color: transparent;
	z-index: 60;
}

.thumbnail span { /*CSS for enlarged image*/
	position: absolute;
	background-color: lightyellow;
	padding: 4px;
	left: -1000px;
	border: 1px dashed gray;
	visibility: hidden;
	color: black;
	text-decoration: none;
}

.thumbnail span img { /*CSS for enlarged image*/
	border-width: 0;
	padding: 2px;
}

.thumbnail:hover span { /*CSS for enlarged image on hover*/
	visibility: visible;
	top: -120px;
	left: -350px;
	/*position where enlarged image should offset horizontally */
}
</style>

<head>
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css"
	type="text/css">
<script type="text/javascript"
	src="/pred/resources/javascript/wz_tooltip1.js"></script>
<script>

function openFile(workId,bslno,billdate){
	var URL="./switch.do?prefix=/works&page=/WorkStatus.do&mode=showScannedCopy&slNo="+bslno+"&workId="+workId+"&billDate="+billdate;	
	var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
	
}
function fnShowHabs(workid)
{

	var workId=workid.name;
	//var url = "showHabs.jsp?workId="+workId;
	var url="./switch.do?prefix=/works&page=/WorkStatus.do&mode=admnHabs&workId="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function workPhysicalStatus(workid)
{
	//alert(status);
		var zURL = "./switch.do?prefix=/fundAccounting&page=/BANKBillAction.do&mode=milestones&workid="+workid;
		//alert(zURL);
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();
	
}
</script>


</head>

<form>
	<body>
		<table width="100%">
			<tr>
				<td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
					<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a></td>
			</tr>
		</table>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Bills to be forward to ENC" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
		<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
			style="border-collapse: collapse">
			<tr>
				<td class="clrborder" align="center">S.No.</td>
				<td class="clrborder" align="center">Work ID&nbsp;/<br>Work
					Name
				</td>
				<td class="clrborder" align="center">Program Name&nbsp;/<br>SubProgram
					Name
				</td>
				<td class="clrborder" align="center">Sanction No&nbsp;/<br>Sanction
					date
				</td>
				<td class="clrborder" align="center">Est. Cost<br>(In
					Rupees)
				</td>
				<td class="clrborder" align="center">Category</td>
				<td class="clrborder" align="center">Work Type</td>
				<td class="clrborder" align="center">Habs</td>
				<td class="clrborder" align="center">Bill No</td>
				<td class="clrborder" align="center">Bill Date</td>
				<td class="clrborder" align="center">Bill Enter Date</td>
				<td class=clrborder align="center">DEE Name/<br></br> M.Book
					No.s & Page No.s
				</td>
				<td class=clrborder align="center">Date of Check measurement</td>

				<td class=clrborder align="center">EE Name/ <br></br> M.Book
					No.s & Page No.s
				</td>
				<td class=clrborder align="center">Date of Super Check
					measurement</td>
				<td class=clrborder align="center">SE Name / <br></br> M.Book
					No.s & Page No.s
				</td>
				<td class=clrborder align="center">Date of Super Check
					measurement</td>
				<td class=clrborder align="center">Pass Order Scan Copy</td>
				<td class="clrborder" align="center">% of Physical Completion</td>
				<td class="clrborder" align="center">WIP Image</td>

				<td class="clrborder" align="center">Bill Amt Contractor<br>(In
					Rupees)
				</td>
				<td class="clrborder" align="center">Bill Amt Admissible<br>(In
					Rupees)
				</td>
				<td class="clrborder" align="center">Select Verified Bill Only</td>
			</tr>

			<%
				PreparedStatement st1 = null, stmtN = null;
				ResultSet rs1 = null, rsN = null;
				try {

					String queryEmp = "select EMPLOYEE_CODE,EMPLOYEE_NAME,EMPLOYEE_SURNAME from rws_employee_tbl";
					stmtN = conn.prepareStatement(queryEmp);
					rsN = stmtN.executeQuery();

					Hashtable hashEmp = new Hashtable();

					while (rsN.next()) {
						hashEmp.put(rsN.getString(1), rsN.getString(2) + "  " + rsN.getString(3));

					}
					if (stmtN != null) {
						stmtN.close();
					}
					if (rsN != null) {
						rsN.close();
					}

					String qry = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT*100000 AS SANCTION_AMOUNT,nvl(NO_OF_HABS,0) as NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintenance') as type,BILL_NO,bill_sl_no,TO_CHAR(BILL_DATE,'DD/MM/YYYY') AS BILL_DATE,TO_CHAR(c.UPDATE_DATE,'DD/MM/YYYY') AS UPDATE_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE, nvl(CM_BY_DEE,'-') as CM_BY_DEE,nvl(CM_MBOOK_PG_NO,'-') as CM_MBOOK_PG_NO ,nvl(to_char(CM_DT,'dd/mm/yyyy'),'') as CM_DT,nvl(SCM_BY_EE,'-') as SCM_BY_EE ,nvl(SCM_MBOOK_PG_NO,'-') as SCM_MBOOK_PG_NO,nvl(to_char(SCM_DT,'dd/mm/yyyy'),'') as SCM_DT,nvl(SCM_BY_SE,'-') as SCM_BY_SE,nvl(SCM_SE_MBOOK_PG_NO,'-') as SCM_SE_MBOOK_PG_NO,nvl(to_char(SCM_SE_DT,'dd/mm/yyyy'),'') as SCM_SE_DT,length(PASS_ORDER_SCAN_COPY) as pCopy from rws_programme_tbl p,rws_subprogramme_tbl s,rws_work_bill_tbl c,rws_work_admn_tbl a   where   substr(a.OFFICE_CODE,2,3)=?  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE  and a.work_id=c.work_id  and bill_sl_no<> 0 and ee_fwd_date is null";
					st1 = conn.prepareStatement(qry);
					st1.setString(1, userid.substring(1, 4));
					rs1 = st1.executeQuery();
					while (rs1.next()) {
						String imgqry = "select work_image from RWS_WORK_IMAGE_TBL where work_id=? ";
						PreparedStatement pst = conn.prepareStatement(imgqry);
						pst.setString(1, rs1.getString(2));
						ResultSet resultSet = pst.executeQuery();
						java.sql.Blob a = null;
						if (resultSet.next()) {
							a = resultSet.getBlob("work_image");
						}
						
						
						
						
						
						
						//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
						String imagePath=getServletContext().getRealPath("/") ;
						 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
							 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
							 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
							 imagePath = sample[0];
							 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
						 }else{
							 String sample[]  = imagePath.split( "webapps");
							// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
							 imagePath = sample[0];
							//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
						 }
						 imagePath = imagePath+ File.separator+"PassorderScanCopys";
						File myFilesDir = new File(imagePath);
						if (!myFilesDir.exists())
							myFilesDir.mkdirs();
						imagePath = imagePath + File.separator ;
						File filepath = new File(imagePath);
						//pstmt.setString(15, workId);
						//pstmt.setString(16,tenderMemoBean.getBillSlNo());
						//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
						//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));
              //						System.out.println(rs1.getString("WORK_ID")+":"+rs1.getString("BILL_DATE").replace("/", "-")+":"+rs1.getString("bill_sl_no"));

						File filepathisExits = new File(filepath+File.separator+rs1.getString("work_id")+"_"+rs1.getString("BILL_DATE").replace("/", "-")+"_"+rs1.getString("bill_sl_no")+".jpg");
						if(filepathisExits.getAbsoluteFile().exists()){
							//System.out.println("YYYYYYYYYYYYYYYY");
							pCopy="Yes";
							//record.setPassOrderScanCopyAvailable("Yes");	
						}
						else
						{
							pCopy=null;
							//System.out.println("NNNNNNNNNNN");
							//record.setPassOrderScanCopyAvailable("No");
						}
						
						
						
						
						

						//String pCopy = rs1.getString("pCopy");
			%>
			<tr align="left">
				<td class="bwborder"><%=++count%></td>
				<td class="bwborder"><%=rs1.getString(2)%>&nbsp;/<br><%=rs1.getString(1)%></td>
				<td class="bwborder"><%=rs1.getString("PROGRAMME_NAME")%>&nbsp;/<br><%=rs1.getString("SUBPROGRAMME_NAME")%></td>
				<td class="bwborder"><%=rs1.getString("ADMIN_NO")%>&nbsp;/<br><%=rs1.getString("ADMIN_DATE")%><br></td>
				<td class="bwborder"><%=rs1.getString("SANCTION_AMOUNT")%></td>
				<td class="bwborder"><%=rs1.getString("CAT")%></td>
				<td class="bwborder"><%=rs1.getString("TYPE")%></td>
				<td class="bwborder" nowrap><%=rs1.getString("NO_OF_HABS")%>
					&nbsp;<input type="button" value="..."
					name="<%=rs1.getString("work_id")%>" title="Show Selected Habs"
					class="btext" onclick="javascript:fnShowHabs(this)"></td>
				<td class="bwborder"><%=rs1.getString("BILL_NO")%></td>
				<td class="bwborder"><%=rs1.getString("BILL_DATE")%></td>
				<td class="bwborder"><%=rs1.getString("UPDATE_DATE")%></td>
				<td class=bwborder nowrap align="center"><%=hashEmp.get(rs1.getString("CM_BY_DEE")) != null
							? hashEmp.get(rs1.getString("CM_BY_DEE"))
							: "-"%>
					<br></br><%=rs1.getString("CM_MBOOK_PG_NO")%></td>
				<td class=bwborder nowrap align="center"><%=rs1.getString("CM_DT") != null && !rs1.getString("CM_DT").equals("null")
							? rs1.getString("CM_DT")
							: "-"%></td>
				<td class=bwborder nowrap align="center"><%=hashEmp.get(rs1.getString("SCM_BY_EE")) != null
							? hashEmp.get(rs1.getString("SCM_BY_EE"))
							: "-"%>
					<br></br> <%=rs1.getString("SCM_MBOOK_PG_NO")%></td>
				<td class=bwborder nowrap align="center"><%=rs1.getString("SCM_DT") != null && !rs1.getString("SCM_DT").equals("null")
							? rs1.getString("SCM_DT")
							: "-"%></td>
				<td class=bwborder nowrap align="center"><%=hashEmp.get(rs1.getString("SCM_BY_SE")) != null
							? hashEmp.get(rs1.getString("SCM_BY_SE"))
							: "-"%><br></br><%=rs1.getString("SCM_SE_MBOOK_PG_NO")%></td>
				<td class=bwborder nowrap align="center"><%=rs1.getString("SCM_SE_DT") != null && !rs1.getString("SCM_SE_DT").equals("null")
							? rs1.getString("SCM_SE_DT")
							: "-"%></td>

				<%
					if (pCopy != null && !pCopy.equals("null")) {
				%>
				<td class=bwborder style="text-align: left;" nowrap align="center"><a
					href="#"
					<%String datez=rs1.getString("BILL_DATE").replace("/", "-"); %>
					onclick="openFile('<%=rs1.getString("work_id")%>','<%=rs1.getString(12)%>','<%=datez%>')">View</a></td>

				<%
					} else {
				%>
				<td class=bwborder style="text-align: left;" nowrap align="center">NA</td>
				<%
					}
				%>
				<td class="bwborder"><input type="button" value="..."
					onclick="workPhysicalStatus(<%=rs1.getString(2)%>)"
					onmouseover="Tip(this.value,TITLE,'Click Here To Update Physical Progress')"
					onmouseout="UnTip()" /></td>
				<td class="bwborder">
					<%
						if (a != null) {
					%> <a class="thumbnail" href="#thumb"><img
						src="../reports/works/workImage.jsp?workid=<%=rs1.getString(2)%>&mode=image1"
						width="30px" height="30px" border="0" /><span><img
							src="../reports/works/workImage.jsp?workid=<%=rs1.getString(2)%>&mode=image1"
							width="350px" height="230px" /></span></a> <%
 	} else {
 %>
					<p>
						<font style="font-size: 9px">Image not Exist</font>
						<%
							}
						%>
					
				</td>


				<td class="bwborder" align="right"><%=rs1.getString("BILL_AMT_CONTRACTOR")%></td>
				<td class="bwborder" align="right"><%=rs1.getString("BILL_AMT_ADMISSIBLE")%></td>
				<%
					if (pCopy != null && !pCopy.equals("null")) {
				%>
				<td><input type="checkbox" name="checks"
					value="<%=rs1.getString("work_id") + rs1.getString("bill_sl_no")%>" />
					<%
						} else {
					%>
				<td
					onmouseover="Tip('Disabled this option due  to PassOrder Scan Copy Not Avaialable',TITLE,'Message')"
					onmouseout="UnTip()"><input type="checkbox" disabled="true"
					name="checks"
					value="<%=rs1.getString("work_id") + rs1.getString("bill_sl_no")%>" />
					<%
						}
					%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan=24 class="rptValue" align="center"><input
					type="checkbox" name="verify">&nbsp;I Verified the Selected
					Bills and Ceritfy that these Bills are entered as per the Pass
					Order in the M Book</td>
			</tr>

			<%
				if (count == 0) {
			%>
			<%
				} else {
			%><tr>
				<td colspan="16" align="center"><input type=button
					value="Forward Selected Bills" class="btext" onClick="fnSave();"></td>
			</tr>
			<%
				}
			%>
			<input type="hidden" name="resultCount" value="<%=count%>">
		</table>
		<%
			} catch (Exception e) {
				System.out.println("exception in rws-tobe_fwd_bills_frm.jsp-- " + e);
			} finally {
				if (rs1 != null) {
					rs1.close();
					rs1 = null;
				}
				if (st1 != null) {
					st1.close();
					st1 = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
		%>
		<script>
function fnSave(){

    var len=document.forms[0].resultCount.value;
    var yes=0;      
	
	if(len==1)
	{
		if(document.forms[0].checks.checked==false){
			yes = 1;
		}
		else if(document.forms[0].checks.checked==true){
			yes = 0;
		}

	}
	else{
	for( var i=0;i<len;i++)
	{     
			if(document.forms[0].checks[i].checked == false)
		    { 
		       yes=1; 
		      
		     }
		    else if(document.forms[0].checks[i].checked==true)
		        { 
		      
		        yes=0;
				break;
		        }
		 
      }
	}
	  if(yes==1)
	   {
		 alert("Select Atleast one Bill to forward ENC by Selecting Check Box to Save");
       }
	  else if(yes==0){
		  if(document.forms[0].verify.checked==false)
		  {
			  alert("You Should Verify the Selected Bills before Forward the Bills to ENC Office");
		  }
		  else if(document.forms[0].verify.checked==true)
		  {
			  if(confirm("Are You Sure To forward The Selected Bill(s) to ENC Office\nThis Decision Cannot be Undone")) {
				  document.forms[0].action="rws_tobe_fwd_bills_save.jsp";
			  document.forms[0].submit();
			  }
		  }
	  }
}
</script>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
		<input type="hidden" name="userId" value="<%=userid%>">
</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>