<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<script language="JavaScript">
function isSaveAttended(){
	if(document.f1.result.value == "" || document.f1.result.value==null){
		alert("Select any option ");
		return false;
	}
	else {
	 	if(document.f1.result.value=="hab"){
			document.f1.action="./rws_tables_newfrm.jsp";
			document.f1.submit();
		}
		else if(document.f1.result.value=="work"){
			document.f1.action="./rws_works_new_frm.jsp";
			document.f1.submit();
		}
		else if(document.f1.result.value=="asset"){
			document.f1.action="./rws_assets_new_frm.jsp";
			document.f1.submit();
		}	
		else if(document.f1.result.value=="water"){
			document.f1.action="./rws_waterquality_new_frm.jsp";
			document.f1.submit();
		}	
		else if(document.f1.result.value=="school"){
			document.f1.action="./rws_school_newfrm.jsp";
			document.f1.submit();
		}	
	}
}
</script>
<form name="f1" >
	<table border="1" align=center cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
		<caption>
			<table border="0" rules="none" style="border-collapse:collapse" width="100%" align="right" bgcolor="#edf2f8">
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				 <font color="#FFFFFF">Download</font>
			</td>	
		</tr>
		<tr>
			<td>		
				<table  bordercolor="navy" width="100%" height="100%" border="1" rules="rows" style="border-collapse:collapse" align="center">
					<tr align="center">
						<td class="textborder" width="100">Select Any Option:<font color="#FF6666">*</font><font color="#FF6666"></font></td>
						<td class="textborder" width="150">
							<select name="result" styleClass="mycombo" style="width:220px"  >
								<option value="" class="myfontclr1"> Select </option>
								<option value="hab" class="myfontclr1"> Tables Related To Habitations </option>
						        <option value="work" class="myfontclr1"> Tables Related To Works </option>
						        <option value="water" class="myfontclr1"> Tables Related To Water Quality </option> 
						        <option value="asset" class="myfontclr1"> Tables Related To Assets </option> 
						        <option value="school" class="myfontclr1"> Tables Related To Schools </option>  
							</select>
						</td>	
					</tr>
				</table>
			</td>
		</tr>	
		<tr>
			<td class="textborder" align="center">			 
				<input type=button value="click" styleClass="btext"  onclick="isSaveAttended();">		
			</td>
		</tr>
	</table>
</form>
<%@ include file="/commons/rws_footer.jsp"%>