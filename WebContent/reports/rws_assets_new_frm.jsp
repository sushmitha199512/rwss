<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<script language="JavaScript">
	function hide(){
		document.getElementById('text').style.display='none';
	}
	function show(){
		if(document.f1.habresult.value=="assethab" || document.f1.habresult.value=="assetmast" || document.f1.habresult.value=="assethandpump" || document.f1.habresult.value=="assetscheme" || document.f1.habresult.value=="assetprojshelf"  || document.f1.habresult.value=="rw" || document.f1.habresult.value=="cw" || document.f1.habresult.value=="glsr" || document.f1.habresult.value=="glbr" || document.f1.habresult.value=="ohsr" || document.f1.habresult.value=="ohbr" || document.f1.habresult.value=="source"  ||  document.f1.habresult.value=="filter" || document.f1.habresult.value=="sstank" || document.f1.habresult.value=="sump" || document.f1.habresult.value=="fp" || document.f1.habresult.value=="pumphouse" || document.f1.habresult.value=="watch" || document.f1.habresult.value=="pumpingmain" || document.f1.habresult.value=="gravity" || document.f1.habresult.value=="dis" || document.f1.habresult.value=="bpt" || document.f1.habresult.value=="cis" || document.f1.habresult.value=="other" || document.f1.habresult.value=="oandm" || document.f1.habresult.value=="pumpset" || document.f1.habresult.value=="cl" ){
			document.getElementById('text').style.display='block';
		}
		else{
			document.getElementById('text').style.display='none';
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
		if(document.f1.habresult.value=="assethab" || document.f1.habresult.value=="assetmast" || document.f1.habresult.value=="assethandpump"  || document.f1.habresult.value=="assetscheme" || document.f1.habresult.value=="assetprojshelf" || document.f1.habresult.value=="rw" || document.f1.habresult.value=="cw" || document.f1.habresult.value=="glsr" || document.f1.habresult.value=="glbr" || document.f1.habresult.value=="ohsr" || document.f1.habresult.value=="ohbr" || document.f1.habresult.value=="source"  ||  document.f1.habresult.value=="filter" || document.f1.habresult.value=="sstank" || document.f1.habresult.value=="sump" || document.f1.habresult.value=="fp" || document.f1.habresult.value=="pumphouse" || document.f1.habresult.value=="watch" || document.f1.habresult.value=="pumpingmain" || document.f1.habresult.value=="gravity" || document.f1.habresult.value=="dis" || document.f1.habresult.value=="bpt" || document.f1.habresult.value=="cis" || document.f1.habresult.value=="other" || document.f1.habresult.value=="oandm" || document.f1.habresult.value=="pumpset" || document.f1.habresult.value=="cl" ){
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
<form name="f1" >

<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
        <table border="0" rules="none" style="border-collapse:collapse" align="right">			
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
			<table  border="0"  width="100%"  align="center"  style="margin-bottom:0;margin-top:0">		       
				<tr align="center">
					<td class="textborder" width="100">Select tables for download<font color="#FF6666">*</font><font color="#FF6666"></font></td>
					<td class="textborder" width="150">
						<select name="habresult" styleClass="mycombo" style="width:300px" onchange="show()"  >
							<option value="0" class="myfontclr1">Select</option>
							<option value="assethab" class="myfontclr1">Assets - Asset Hab Table</option>
							<option value="assetmast" class="myfontclr1">Assets - Asset Master Table</option>
							<option value="assetscheme" class="myfontclr1">Assets - Asset Scheme Table</option>
					        <option value="assetprojshelf" class="myfontclr1">Assets - Sent to DDWS</option> 
					        <option value="assethandpump" class="myfontclr1">Assets - Handpumps Table</option>
							<option value="source" class="myfontclr1">Assets Source Table</option>
							<option value="rw" class="myfontclr1">Assets RawWater Collection Well Table</option>
							<option value="sstank" class="myfontclr1">Assets SSTank Table</option>
							<option value="filter" class="myfontclr1">Assets Filters Table</option>							
							<option value="sump" class="myfontclr1">Assets Sump Table</option>
							<option value="fp" class="myfontclr1">Assets Foot path Bridge Table</option>
							<option value="pumphouse" class="myfontclr1">Assets PumpHouse Table</option>
							<option value="watch" class="myfontclr1">Assets Watchman Quarter Table</option>
							<option value="cw" class="myfontclr1">Assets Clear Water Collection Well Table</option>							
							<option value="pumpingmain" class="myfontclr1">Assets PumpingMain Table</option>
							<option value="gravity" class="myfontclr1">Assets Gravity Main Table</option>
							<option value="dis" class="myfontclr1">Assets Distribution Table</option>							
							<option value="bpt" class="myfontclr1">Assets Bpt Table</option>
							<option value="glbr" class="myfontclr1">Assets GLBR Table</option>
							<option value="glsr" class="myfontclr1">Assets GLSR Table</option>							
							<option value="ohbr" class="myfontclr1">Assets OHBR Table</option>
							<option value="ohsr" class="myfontclr1">Assets OHSR Table</option>
							<option value="cis" class="myfontclr1">Assets Cisterns Table</option>
							<option value="cl" class="myfontclr1">Assets Chlorination Table</option>
							<option value="oandm" class="myfontclr1">Assets OandM Table</option>							
							<option value="pumpset" class="myfontclr1">Assets Pumpsets Table</option>
						</select>
					</td>	
				</tr>	
			</table>
		</td>		
	</tr>
	<tr>
    	<td class="textborder">   
			<div id="text"  style="display:none;">
    			<table  border="0"  width="100%" align="center"  style="margin-bottom:0;margin-top:0">
					<tr>
					<% 
						rDist = request.getParameter("district");
						if(rDist==null || rDist.equals("0")){
					%>	
						<td class = btext ><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
						<td class = btext colspan=3>
							<select name="district" style="width:150px" class="mycombo" >
								<option value="0">SELECT...</option>		
								<%		request.setAttribute("dName",null);
										session.setAttribute("dCode",rDist);
										} else if(rDist != null && rDist.equals("51")){
								%>
						<td class = btext><font color=navy><b>District</b> </font><font color="red"><b>*</b></font></td>
						<td class = btext colspan=3>
							<select name="district" style="width:150px" class="mycombo" >
								<option value="0">SELECT...</option>	
								<% 
										request.setAttribute("dName",null);
										session.setAttribute("dCode",rDist);
									} else if(!rDist.equals("0"))  {
								%>
					   <td class = btext><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
					   <td class = btext colspan=3>
					   	<select name="district" style="width:150px" class="mycombo">
							<option value="0">SELECT...</option>	
							<%	
									session.setAttribute("dCode",rDist);	
								}
								ps = conn.prepareStatement("SELECT distinct dcode,dname  from rws_district_tbl where dcode<>'16'  order by dname");
								rs =ps.executeQuery();	
								while(rs.next()){		
									if(rDist != null && rDist.equals(rs.getString(1)) ){
							%>
							<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
							<% 			
									request.setAttribute("dName",rs.getString(2));
									session.setAttribute("dCode",rDist);
								} else {
							%>	
							<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
							<%		   session.setAttribute("dCode",rDist);						
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
<%@ include file="/reports/connClose.jsp" %><%}finally{}%>


