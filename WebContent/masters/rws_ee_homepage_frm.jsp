<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_ee_header1.jsp"%>

<html>
<head>
</head>
<body bgcolor="#edf2f8"><BR><BR><BR><BR><BR><BR>

<table align=center>
	<tr>
			<td class=btext>
					<A href="rws_ee_logout.jsp">[Logout]</A>
			</td>
		</tr>
</table>

<table align=center>
	<tr>
			<td class=btext>
					Choose One Option
			</td>
		</tr>
</table>
<BR><BR>
<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=200>		
		
	<TABLE id=AutoNumber16 style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 width="236" border=1 align="center">
		
        <TBODY >
         
        <TR>
          <TD width="100%" height=25><DIV align=center>
              <CENTER>
                <TABLE id=AutoNumber14 style="BORDER-COLLAPSE: collapse" 
                        borderColor=#111111 height=69 cellSpacing=0 
                        cellPadding=0 width="126%" border=0>
                  <TBODY>
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/verifyCertificate.do&mode=init">BANK - Bill Selection</a></B></FONT></TD>
                     </TR>
                    <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="rws_bill_release_to_pao.jsp">PAO - Bill Selection</a></B></FONT></TD>
                     </TR>
   <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/works&page=/WorkReleases.do&mode=data&mode1=clear">Refunds</a></B></FONT></TD>
                     </TR>
                     
                      <tr>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/eeDigitalSign.do&mode=certpage">Registration Digital Signature</a></B></FONT></TD>
                     </TR>
			
                     <tr>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/eeAuthentication.do&mode=data">EE's Authentication Form</a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                     </TR>
                     <tr>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/bankConfirm.do&mode=view">Bank Pending Files </a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                     </TR>
                     <tr>
                     <TD width="40%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/bankConfirm.do&mode=fileBrowse">Bank - Contractor Check Files </a></B></FONT> <img src="../images/new.gif"  height="20" ></img></TD>
                     </TR>
                     <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="../works/rws_files_browse.jsp">BANK  Check Files</a></B></FONT></TD>
                     </TR>
                     
                      
                     
    </TBODY>
    </TABLE>
</form>
</body>
</html>