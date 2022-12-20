<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
	<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
	<title>WaterSoft</title>
	<script language="JavaScript">
		function fnSubmit(){              
		    var d=document.getElementById('demo1').value;
		    var d1=document.getElementById('demo2').value;
	        var list=document.getElementById('works').value;		
	   		if(document.getElementById('demo1').value!='' || document.getElementById('demo2').value!='' || document.getElementById('works').value!='' || !document.forms[0].mpr[0].checked==false || !document.forms[0].mpr[1].checked==false || !document.forms[0].mpr[2].checked==false){    
	       		if(d!='' && d1!=''){    	       
	          		if(document.getElementById('works').value=='' && document.forms[0].mpr[0].checked==false && document.forms[0].mpr[1].checked==false && document.forms[0].mpr[2].checked==false){
			            var rtype="dates";
			            alert("Porting Type Between "+rtype);
					    document.forms[0].fdate.value=d;
						document.forms[0].todate.value=d1;	
				       	var dd1=d.split("-");
						var dd2=d1.split("-");			
				      	var arr1 = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
						 for( i = 0; i < arr1.length; i++){
				             if(dd1[1]==arr1[i]){ 
				            	 i++;
				               	 dd1[1]=i;
				             }			               
						  }			
				         for( j = 0; j < arr1.length; j++){
						     if(dd2[1]==arr1[j]){ 
						    	 j++;
				               	 dd2[1]=j;
				             }			               
						  }
						var d1 = new Date("October 13, 1975 11:13:00");
						var d2 = new Date("October 19, 1975 11:13:00");					
						d1.setFullYear(dd1[2],dd1[1],dd1[0]);
						d2.setFullYear(dd2[2],dd2[1],dd2[0]);				
						var diffDays = parseInt((d2 - d1) / (1000 * 60 * 60 * 24)); 		
						document.forms[0].action="switch.do?prefix=/reports&page=/PSExcel.do?mode=get&type="+rtype;
						document.forms[0].submit();	               
					} else {  
				         alert("Select ONlY ONE of the Project Shelf Option");
				         return false;
				   }
		   		} else if(list!='') {    
	           		if(document.getElementById('demo1').value=='' && document.getElementById('demo2').value=='' && document.forms[0].mpr[0].checked==false && document.forms[0].mpr[1].checked==false && document.forms[0].mpr[2].checked==false) {
	   			        var rtype="list";
			            alert("Porting Type Given WorkId's "+rtype);
					    document.forms[0].worklist.value=list;
				        document.forms[0].action="switch.do?prefix=/reports&page=/PSExcel.do?mode=get&type="+rtype;
					   	document.forms[0].submit();
			          } else {  
					         alert("Select ONlY ONE of the Project Shelf Option");
					         return false;
					}
			    } else if(document.forms[0].mpr[0].checked==true){     
	           		if(document.getElementById('demo1').value=='' && document.getElementById('demo2').value=='' && document.getElementById('works').value=='' && document.forms[0].mpr[1].checked==false && document.forms[0].mpr[2].checked==false){           
			            var rtype="mpr";
			            var rvalue="finmpr";
			            alert("Porting Type For Financial MPR "+rvalue);
					    document.forms[0].action="switch.do?prefix=/reports&page=/PSExcel.do?mode=get&type="+rtype+"&rvalue="+rvalue;
					   	document.forms[0].submit();
	        		} else {  
				         alert("Select ONlY ONE of the Project Shelf Option");
				         return false;
				 	}
	     		} else if(document.forms[0].mpr[1].checked==true ){      
	           		if(document.getElementById('demo1').value=='' && document.getElementById('demo2').value=='' && document.getElementById('works').value=='' && document.forms[0].mpr[0].checked==false &&  document.forms[0].mpr[2].checked==false){
			            var rtype="mpr";
			            var rvalue="phympr";
			            alert("Porting Type For Physical MPR "+rvalue);
					    document.forms[0].action="switch.do?prefix=/reports&page=/PSExcel.do?mode=get&type="+rtype+"&rvalue="+rvalue;
					   	document.forms[0].submit();
		            } else{  
				         alert("Select ONlY ONE of the Project Shelf Option");
				         return false;
				 	}
	     		} else if(document.forms[0].mpr[2].checked==true){      
		           if(document.getElementById('demo1').value=='' && document.getElementById('demo2').value=='' && document.getElementById('works').value=='' && document.forms[0].mpr[0].checked==false &&  document.forms[0].mpr[1].checked==false){
			            var rtype="mpr";
			            var rvalue="schmpr";
			            alert("Porting Type For Scheme MPR "+rvalue);
					    document.forms[0].action="switch.do?prefix=/reports&page=/PSExcel.do?mode=get&type="+rtype+"&rvalue="+rvalue;
					   	document.forms[0].submit();
		            } else {  
				         alert("Select ONlY ONE of the Project Shelf Option");
				         return false;
					 }
	     		}
			} else{  
		         alert("Select Any of the Option Type to get projectShelf");
		         return false;
	   		}
   		}
		function validate(evt) {
		    var theEvent = evt || window.event;
		    var key = theEvent.keyCode || theEvent.which;
		    key = String.fromCharCode( key );
		    var regex = /[0-9]|\,/;
		  //var x = document.getElementById("myTextarea");
		    if( !regex.test(key) ){  
			     alert("Only Numericals and comma is accepted");
		         theEvent.returnValue = false;
		         if(theEvent.preventDefault) theEvent.preventDefault();
		    }
	    } 
	</script>
	<style>
		.mystyle{
			border-width:1;
			color:#000000;
			font-weight:bold;
			font-family:verdana;
			font-size:9pt;
		}
		.btext{
			border-width:1;
			color:#336600;
			font-weight:bold;
			font-family:verdana;
			font-size:9pt;
			background-color:#ffffff
		}
	</style>
</head>
<body bgcolor="#edf2f8">
	<html:form action="PSExcel.do">
		<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
			<caption>
				<table  border=0 rules=none style="border-collapse:collapse" width=30% align = "right" bgcolor="#edf2f8">
					<tr>
						<td align="right" class="bwborder"><a href="./home.jsp">Home</td> 
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="textborder" colspan="2">
					<font color="#FFFFFF">Project Shelf Porting</font>
				</td>	
			</tr>
			<tr> 
				<td valign="top"  align="center" height="25%" width="30%">
					<table bordercolor="navy" width="100%" height="100%" border="1" rules="rows" style="border-collapse:collapse" align = center>
						<tr>
							<td class=rptLabel>From Date &nbsp;<font color="red">*</font></td>
							<td class=btext class=rptLabel><input id="demo1" type="text" size="10" ><a href="javascript:NewCal('demo1','ddmmmyyyy')"><img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
						</tr>
						<tr>
							<td class=rptLabel>To Date&nbsp;<font color="red">*</font></td>
							<td class=btext class=rptLabel><input id="demo2" type="text" size="10"><a href="javascript:NewCal('demo2','ddmmmyyyy')"><img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
						</tr>
						<tr>
							<td class=rptLabel align="center" colspan=2>OR</td></tr>
						<tr>
							<td class=rptLabel>Enter Work Id's&nbsp;<font color="red">*</font></td>
							<td class=btext><TEXTAREA name="works" id="works" cols="30" rows="2" onkeypress="validate(event)" ></TEXTAREA> </td>
						</tr>
						<tr>
							<td class=rptLabel align="center" colspan=2>OR</td></tr>
						<tr>
							<td class=rptLabel>MPR Works&nbsp;<font color="red">*</font></td>
							<td class=btext><input type="radio" name="mpr"  value="finmpr" >FinancialMPR&nbsp; <input type="radio" name="mpr"  value="phympr" >PhysicalMPR&nbsp; <input type="radio" name="mpr"  value="schmpr">SchoolMPR</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>	
				<td colspan="2" align="center" valign="top" class="rptLabel">
					<table bordercolor="navy" width="40%" border="0" rules="none" style="border-collapse:collapse" align="center">
						<tr>				
							<td colspan=2 align=center><input type=button onclick="fnSubmit()" value="Start" class = btext></td>
						</tr>
					</table>	
				</td>
			</tr>
		</table>
		<br>
		<table width="30%" align=center>
			<tr>
				<td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td>
				<td class=rptValue nowrap>1.Genrating PorjectShelf between dates - Work Admin Sanction Date is considered(<b>Only One Month Data can be Ported at a time</b>). </td>
			</tr>
			<tr>
				<td bordercolor="black"><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td class=rptValue nowrap>2.Genrating PorjectShelf for List of Works - Enter WorkId's in a continue line each WorkId separated by a ','</td>
			</tr>
			<tr>
				<td bordercolor="black"><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td class=rptValue nowrap>3.Genrating PorjectShelf for MPR Works - Make Sure you have done MPR Porting , and can select any of the three MPR's Ported (Financial,Habs,Schools) Works.</td>
			</tr>
		</table>

		<input type="hidden" name="dName"/>
		<input type="hidden" name="fdate">
		<input type="hidden" name="todate">
		<input type="hidden" name="worklist">
	</html:form>
</body>
<script language="javascript">
	<% if(request.getAttribute("message")!=null){%>
	 alert('<%=request.getAttribute("message")%>');
	<%request.removeAttribute("message"); }%>
</script>
<%@ include file="/commons/rws_footer.jsp" %>
</html>
