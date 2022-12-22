<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>

<html>
<head>
</head>
<body bgcolor="#edf2f8"><BR><BR><BR><BR><BR><BR>

<table align=center>
	<tr>
			<td class=btext>
					<A href="rws_ENC_logout.jsp">[Logout]</A>
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
          <TD width="100%" height=19><DIV align=center>
              <CENTER>
                <TABLE id=AutoNumber14 style="BORDER-COLLAPSE: collapse" 
                        borderColor=#111111 height=69 cellSpacing=0 
                        cellPadding=0 width="96%" border=0>
                  <TBODY>
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/transferAmount.do?mode=divview">BANK - Bill Process</a></B></FONT></TD>
                     </TR>
                    <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="rws_bill_release_to_pao_division.jsp">PAO - Bill Process</a></B></FONT></TD>
                     </TR>
 <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="rws_div_works_refunds.jsp">Refunds</a></B></FONT></TD>
                     </TR>
                     <tr>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/transferAmount.do?mode=view"  class="h4" >Bank - Contractor Wise</a></B></FONT></TD>
                     </TR>
                     <TR>
                     <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=2><B><li><a href="<c:url value="switch.do?prefix=/masters&page=/encDSRegToken.do&mode=data"></c:url>">Registration DSC Token</a></li> </B></FONT></TD>
                     </TR>
                
    </TBODY>
    </TABLE>
</form>
</body>
</html>