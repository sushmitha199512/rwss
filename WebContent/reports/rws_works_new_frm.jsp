<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<script language="JavaScript">
	function hide(){
		document.getElementById('text').style.display='none';
	}
	function show(){
		if(document.f1.habresult.value=="admn" || document.f1.habresult.value=="tender" || document.f1.habresult.value=="techsan" || document.f1.habresult.value=="sourceiden"  || document.f1.habresult.value=="workcommencement" || document.f1.habresult.value=="workexpenditure" || document.f1.habresult.value=="workcompletion" || document.f1.habresult.value=="projshelf"){
			document.getElementById('text').style.display='block';
			document.f1.district.value='0';      
		} else {
			document.getElementById('text').style.display='none';
			document.f1.district.value='0';      
		}
	}
	function getItem(id){
	    var itm = false;
	    if(document.getElementById)
	        itm = document.getElementById(id);
	    else if(document.all)
	        itm = document.all[id];
	    else if(document.layers)
	        itm = document.layers[id];
	    return itm;
	}
	function isSaveAttended(){
		if(document.f1.habresult.value=="admn" || document.f1.habresult.value=="tender" || document.f1.habresult.value=="techsan" ||  document.f1.habresult.value=="sourceiden" || document.f1.habresult.value=="workcommencement" || document.f1.habresult.value=="workexpenditure"  ||  document.f1.habresult.value=="workcompletion" || document.f1.habresult.value=="projshelf" ){
			if(document.f1.habresult.value=="" || document.f1.habresult.value==null || document.f1.habresult.value=="0"){
				alert("Select any  table for download");
			}
			else if(document.f1.district.value=="0" || document.f1.district.value=="" || document.f1.district.value==null){
				alert("select District");
			}
			else{
				var h=document.f1.habresult.value;
				var d=document.f1.district.value;
				document.f1.action="./rws_tables_excel_rpt.jsp?habresult="+h+"&district="+d;
				document.f1.submit();
				init();
			}
		}
		else if(document.f1.habresult.value=="" || document.f1.habresult.value==null || document.f1.habresult.value=="0"){
			alert("Select any  table for download");            
		}		
		else{
			var h=document.f1.habresult.value;			
			document.f1.action="./rws_tables_excel_rpt.jsp?habresult="+h;
			document.f1.submit();
			init();
		}
	}
	function init(){
		document.f1.habresult.value='0';
		document.f1.district.value='0';
	}
</script>
<%String rDist=null; %>
<form name="f1">

<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border="0" rules="none" style="border-collapse:collapse" align="right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>			
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
			<table border="0" width="100%" align="center" style="margin-bottom:0;margin-top:0">        
				<tr align="center">
					<td class="textborder" width="100">Select tables for download<font color="#FF6666">*</font><font color="#FF6666"></font></td>
					<td class="textborder" width="150">
						<select name="habresult" styleClass="mycombo" style="width:300px" onchange="show()" >
							<option value="0" class="myfontclr1">Select</font></option>					
					        <option value="admn" class="myfontclr1">Admin Sanction Table</font></option>
					        <option value="techsan" class="myfontclr1">Technical Sanction Table</font></option>
					        <option value="sourceiden" class="myfontclr1">Source Identification Table</font></option>
					        <option value="condet" class="myfontclr1"> Contractor Details Table</option>
					        <option value="tender" class="myfontclr1">Contractor Management Table</font></option>
					        <option value="workcommencement" class="myfontclr1">Programme Schedule Table</option>
					        <option value="workexpenditure" class="myfontclr1">Work Expenditure Table</option>
					       	<option value="workcompletion" class="myfontclr1">Work Completion Table</option> 
							<option value="projshelf" class="myfontclr1">Project Shelf Works sent to DDWS Table </option>
						</select>
					</td>			
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
   		<td class="textborder">   
			<div id="text"  style="display:none;">
    			<table border="0" width="100%" align="center" style="margin-bottom:0;margin-top:0">
					<tr>
						<% 
							rDist = request.getParameter("district");
							if(rDist==null || rDist.equals("0")){
						%>
						<td class="btext" ><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
						<td class="btext" colspan="3">
							<select name="district" style="width:150px" class="mycombo" >
								<option value="0">SELECT...</option>		
								<%		
										request.setAttribute("dName",null);
										session.setAttribute("dCode",rDist);
									}
									else if(rDist != null && rDist.equals("51")){
								%>
						<td class = btext><font color=navy><b>District</b> </font><font color="red"><b>*</b></font></td>
						<td class = btext colspan=3>
							<select name="district" style="width:150px" class="mycombo" >
								<option value="0">SELECT...</option>	
								<% 
										request.setAttribute("dName",null);
										session.setAttribute("dCode",rDist);	
									} else if(!rDist.equals("0")) {
								%>
						<td class = btext><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
						<td class = btext colspan=3>
							<select name="district" style="width:150px" class="mycombo">
								<option value="0">SELECT...</option>	
								<%			session.setAttribute("dCode",rDist);									
										}
									ps = conn.prepareStatement("SELECT distinct dcode,dname  from rws_district_tbl where dcode<>'16'  order by dname");
									rs =ps.executeQuery();								
									while(rs.next()){									
										if(rDist != null && rDist.equals(rs.getString(1))){
								%>
								<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
								<% 			
										request.setAttribute("dName",rs.getString(2));
										session.setAttribute("dCode",rDist);
									} else {
								%>		
								<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
								<%			
													session.setAttribute("dCode",rDist);
												} 
											}
								%>
							</select>
						</td>
					</tr>		
				</table>
			</div>
		</td>
	</tr>	
	<tr>
		<td class="textborder" align=center>			 
			<input type=button value="Download" styleClass="btext"  onclick="isSaveAttended();">		
		</td>
	</tr>
</table>
</form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/reports/connClose.jsp" %> <%}finally{}%>


