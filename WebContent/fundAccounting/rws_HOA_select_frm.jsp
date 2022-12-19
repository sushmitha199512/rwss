<%@ include file="/commons/rws_header1.jsp" %>
<%int count=0; %>
<html>

<script language="javascript">
 function abc(index)
 {
 //alert(document.getElementById("rep["+index+"].headOfAccount").value);
 var i = '<%=request.getParameter("get")%>';
  opener.document.getElementById("LOC_DETAILS_LIST["+i+"].headOfAccount").value =document.getElementById("rep["+index+"].headOfAccount").value;
 self.close();
 } 
</script>

<body topmargin="0" leftmargin="0" bgcolor="#edf2f8">
 <form name=f1 method="post">
<table align=center width="100%">
	<tr>
		<td align=right>
		<a href="javascript:window.close()">Close</a>
		</td>
	 </tr>
	
	<tr>
	<td>
	<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td  class="textborder" nowrap>
						Choose Your Head Of Account 
					</td>
				</tr>
			</table>
		</td>
	 </tr>
	<p>&nbsp;</p>
	<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td colspan=10 class="textborder">
						<font color="#ffffff">Head of Account  List</font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">Select</td>
					<td align=center class="clrborder">Major Head Name</td>
					<td align=center class="clrborder">Sub Major Head Name</td>
					<td align=center class="clrborder">Minor Head Name</td>
					<td align=center class="clrborder">Group Sub Head  Name</td>
					<td align=center class="clrborder">Sub Head Name</td>
					<td align=center class="clrborder">Detail Head Name</td>
					<td align=center class="clrborder">Sub Detail Head Name</td>
				</tr>
				<nested:iterate id="rep" name="HoaList" indexId="ndx">
				<tr align="left" bgcolor="#ffffff">
				<td  class="bwborder" align=center>
				<nested:hidden name="rep" property="headOfAccount" indexed="true"/>
				<input type="radio" name="radio"  onClick="abc(<%=count++%>)" ></td>
										
				<td  class="bwborder" >
						<nested:write name="rep" property="majorHead"  />
					</td>
				   <td  class="bwborder" >
					<nested:write name="rep" property="subMajorHead"  />
					</td>
					<td  class="bwborder" >
					<nested:write name="rep" property="minorHead"  />
					</td>
					<td  class="bwborder" >
					<nested:write name="rep" property="groupHead"  />
					</td>
					<td  class="bwborder" >
					<nested:write name="rep" property="subHead"  />
					</td>
					<td  class="bwborder" >
					 <nested:write name="rep" property="detailHead"  />
					</td>
					<td  class="bwborder" >
					 <nested:write name="rep" property="subDetailHead"  />
					</td>
			</nested:iterate>
			
</table>			
</body>
</form>
</html> 