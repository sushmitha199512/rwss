<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<html>
	<head>
		<script language="Javascript">
			function close(){
			alert("close");
			this.close();
		}
		</script>
	</head>
<body bgcolor="#edf2f8">

<table align=center>
	<tr>
			<td class=btext>
					<A href="rws_ho_admin_logout.jsp">[Logout]</A>
			</td>
		</tr>
</table>
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=200>		
		
	<TABLE id=AutoNumber16 style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 width="236" border=1 align="center">
		
        <TBODY >
         
        <TR>
          <TD width="100%" height=19><DIV align=center>
              <CENTER>
                <TABLE id=AutoNumber14 style="BORDER-COLLAPSE: collapse" borderColor=#111111 height=69 cellSpacing=0 cellPadding=0 width="96%" border=0>
                  <TBODY>                 
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/admin&page=/resetPassword.do&mode=view">Reset User Password</a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                    </TR>            
                   	<TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/Ifsc.do&mode=data&special=reset">Bank Entry</a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                    </TR>
                    <TR>
                      	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/EE.do&mode=data&special=reset">EE - Entry</a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                    </TR>  
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/MandalSubdivisionCon.do?mode=data">Mandal Subdivision Conversion</a></B></FONT></TD>
                     </TR>
                    <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/workCategory.do&mode=data">Program Linkage</a></B></FONT></TD>
                     </TR>
                     <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/HabConvert.do">Habitation Conversion</a></B></FONT></TD>
                     </TR>                     
                     <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/reconvertion.do">Khammam Habitation Conversion</a></B></FONT></TD>
                     </TR>    
                     <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/assetReconvertion.do">Khammam Assets Conversion</a></B></FONT></TD>
                     </TR>
 					 <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/AssetType.do&mode=data">Asset Type</a></B></FONT></TD>
                      </TR>
                      <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/AssetCompType.do&mode=data">Asset Component</a></B></FONT></TD>
                   	  </TR>
 					  <TR>
                    	 <TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/AssetSubCompType.do&mode=data">Asset SubComponent</a></B></FONT></TD>
                     </TR>
 					 <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/bank.do&mode=data&special=Y">Bank Master</a></B></FONT></TD>
                     </TR>
					 <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/branch.do&mode=data&special=Y">Branch Master</a></B></FONT></TD>
                     </TR>
 					 <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/office.do&mode=data&special=Y">Bank Details Entry Form</a></B></FONT></TD>
                     </TR>
 <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/OfficeChange.do&mode=data&special=reset">Office Change for Work</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ddwsPhyComp.do&mode=data&special=Y">DDWS Physical Component Entry</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ddwsmilestone.do&mode=data&special=Y">DDWS Physical MileStone Entry</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ddwsmilestonestage.do&mode=data&special=Y">DDWS Physical MileStone Stage Entry</a></B></FONT></TD>
                     </TR>
                      <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ddwslnk.do&mode=data&special=Y">DDWS Physical Milestone Link Entry</a></B></FONT></TD>
                     </TR>
<TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/milestone.do&mode=data&special=Y">MileStone Entry</a></B></FONT></TD>
                     </TR>
<TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/milestonestage.do&mode=data&special=Y">MileStone Stage Entry</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/reasons.do&mode=data&special=Y">Reasons for Delay Entry</a></B></FONT></TD>
                     </TR>
                     <tr>
<TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/PaymentChange.do&mode=data&special=reset">Block Change for WorkId Entry Form</a></B></FONT></TD>

                     </TR>
                     <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/HabWork.do&mode=data&special=reset"  class="h4" ><b class="green"></b>Target Entry </a></B></FONT></TD>
                     </TR>

<TR>
                     
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="/pred/reports/portings/rws_mdb_file_frm.jsp" class="h4" ><b class="green"></b>MDB File Download </a></B></FONT></TD>
                     </TR>

<TR>
                     
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="/pred/masters/rws_asset_scheme_code_integration_frm.jsp" class="h4" ><b class="green"></b>Asset Scheme Code Integration</a></B></FONT></TD>
                     </TR>
<TR>
                     
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/IFSCEntry.do&mode=data&special=Y" class="h4" ><b class="green"></b>IFSC Code Entry Form</a></B></FONT></TD>
                     </TR>

					<TR>
                     
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/admin&page=/users.do&mode=data" class="h4" ><b class="green"></b>Users Info</a></B></FONT></TD>
                     </TR>
                    <!-- sairam 05-09-2022  <TR>
                     
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/WorkSanctionAmount.do&mode=circles" class="h4" ><b class="green"></b>Work Sanction Amount Change Form</a></B></FONT></TD>
                     </TR> -->
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/WorkNameChange.do&mode=data&special=reset">Work Name Change Form</a></B></FONT></TD>
                     </TR>
                     <TR>
						<TD width="32%" bgColor=#ffffff height=32><FONT	
								face=Verdana color=#000000 size=2><B><li><a	href="switch.do?prefix=/masters&page=/repair.do&mode=data&special=Y" class="h4"><b class="green"></b>Repair Type Entry Form</a></B></FONT></TD>
				   	 </TR>
					 <TR>
						<TD width="32%" bgColor=#ffffff height=32><FONT
								face=Verdana color=#000000 size=2><B><li><a	href="switch.do?prefix=/masters&page=/repairlnk.do&mode=data&special=Y">Repair Description for Assets and Components Entry</a></B></FONT></TD>
		  			 </TR>
		  			  <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/UiHabData.do?mode=data">Convert UI Habitation To NC</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ImisProgramme.do&mode=data&special=Y">IMIS Program Entry</a></B></FONT></TD>
                     </TR>
		  			  <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/ImisProgrammeLink.do&mode=data&special=Y">IMIS Program Linkage</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/AssetWorkLeadHab.do&mode=data&special=reset">Asset/Work Lead
																						Habitation Change</a></FONT></TD>
                     </TR>
    </TBODY>
    </TABLE>
</form>
</body>
</html>