<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
	<style>
		#container {
		  margin: 0 auto;
		  width: 330px;
		}
		#container h1 {
		  padding-top: 1em;
		}
		#container h1 a {
		  font-family: "Myriad Pro", "Helvetica Neue", sans-serif;
		  font-size: 0.5em;
		  color: black;
		  text-decoration: none;
		  line-height: 1.5em;
		  font-weight: bold;
		  position: relative;
		}
		#container h1 a .grad {
		  background: -webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, rgba(255, 255, 255, 0.2)), color-stop(50%, rgba(255, 255, 255, 0.3)), color-stop(50%, rgba(255, 255, 255, 0.2)), color-stop(100%, rgba(255, 255, 255, 0.5)));
		  background: -webkit-linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.3) 50%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.5) 100%);
		  background: -moz-linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.3) 50%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.5) 100%);
		  background: -o-linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.3) 50%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.5) 100%);
		  background: -ms-linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.3) 50%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.5) 100%);
		  background: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.3) 50%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.5) 100%);
		  display: block;
		  position: absolute;
		  top: 0;
		  right: 0;
		  bottom: 0;
		  left: 0;
		}
	</style>
	<script type="text/javascript">
		function getDateObject(dateString,dateSeperator){
			var curValue=dateString;
			var sepChar=dateSeperator;
			var curPos=0;
			var cDate,cMonth,cYear;  
			curPos=dateString.indexOf(sepChar);
			cDate=dateString.substring(0,curPos);
			endPos=dateString.indexOf(sepChar,curPos+1);
			cMonth=dateString.substring(curPos+1,endPos);
		  	curPos=endPos;
			endPos=curPos+5;			
			cYear=curValue.substring(curPos+1,endPos);
			dtObject=new Date(cYear,cMonth-1,cDate);	
			return dtObject;
		} 
		 function fnview(){
			 var drill=1;
			 if(document.forms[0].fromDate.value==""){
				 alert("please select From Date");
				 return false;
			 }
			else  if(document.forms[0].toDate.value==""){
				 alert("please select To Date");
				 return false;
			 }
			 else{
				 var fDate=getDateObject(document.forms[0].fromDate.value,"/");
				 var tDate=getDateObject(document.forms[0].toDate.value,"/");	
				 if(fDate<=tDate){
					 document.forms[0].action="./switch.do?prefix=/reports&page=/assetImages.do&mode=view";
					 document.forms[0].submit();
					 return true;			 
				 }else{
					alert("ToDate is  always greater than From Date");   
					return false;
				}
			 }
		 }
		 function pp() {	
			 var msg='<%=request.getAttribute("message")%>';	
			 var distname=document.forms[0].districtname1.value;
			 if(distname!=""){
				 document.forms[0].distname.value=distname;
			 }
			 if(msg=='No Data  Found on that Dates'){
				 alert(msg);		
			 }
			 if(msg=='Data Sucessfully Downloaded') {		
				  document.getElementById('container').style.display='block';
				  $(function() {
			            App.init();  
			      });
				  document.forms[0].action="./switch.do?prefix=/reports&page=/assetImages.do&mode=view1";
				  document.forms[0].submit();
				  return true;
			 }
			 if(msg=='Zip is Ready To Download') {
				  document.getElementById('container').style.display='none';
				  document.forms[0].action="./switch.do?prefix=/reports&page=/assetImages.do&mode=zip";
					 document.forms[0].submit();
					 return true;
			 }	
		}
		function ss(){
			 var distname=document.forms[0].distname.value;		
			 document.forms[0].districtname1.value=distname;
		}
	</script>
	<link href="reports/progressbar/stylesheets/ui-progress-bar.css?1325742643" media="screen" rel="stylesheet" type="text/css" />
	<script src="reports/progressbar/javascripts/application.js?1325742642" type="text/javascript"></script> 
</head>
<body onload="pp();" >
	<html:form action="/assetImages.do" >
		<center>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Asset Component Images " />
			<jsp:param name="TWidth" value="300" />
		</jsp:include>
		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="none" width="340" border=1 style="border-collapse:collapse;" >
			<tr>
				<td  align="center" class=rptvalue>District:&nbsp;<font color="red">*</font>
					<html:select property="districtname" styleClass="mycombo" style="width:170" styleId="distname" onchange="ss()">
						<html:options collection="districtDetails"  property="districtname" labelProperty="districtname" />
					</html:select>
					<html:hidden property="districtname1" styleId="districtname1"/>
				</td>
			</tr>
			<tr>
				<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><html:text property="fromDate" readonly="true" /><a href="javascript:showCalendar(document.forms[0].fromDate);"><img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
			</tr>
			<tr>
				<td  align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="toDate" readonly="true" /><a href="javascript: showCalendar(document.forms[0].toDate);"><img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
			</tr>
			<tr>
				<td align="center" ><html:submit  property="view" value="Download Images" onclick="return fnview();" /></td>
			</tr>
		</table>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="300"/>
		</jsp:include>
		<input type="hidden" name="drill" value="1"/>
		<table>
			<tr>
				<td>        
	  				<div id="container" style="display:none;">
	  					<h1  style="color:skyblue;font-size:15">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please Wait For Some Time..........</h1>   
	      		        <div class="ui-progress-bar ui-container" id="progress_bar">
				           <div class="ui-progress" style="width: 7%;">
				              <span class="ui-label" style="display:none;">
				                Downloading Images............
				                <b class="value">7%</b>
				              </span>
				           </div>
				        </div>       
	        		</div>     
				</td>
			</tr>
		</table>
		</center>
	</html:form>
</body>
</html>