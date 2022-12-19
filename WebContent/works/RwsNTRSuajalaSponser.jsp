
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%

String value=String.valueOf(request.getAttribute("sMode"));
if(value==null || value.equals("null")){
value=String.valueOf(session.getAttribute("sMode"));
if(value==null || value.equals("null")){
	value="0";
}
}


System.out.print("sMode"+value);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
div.img {
    padding: 5px;
    height: auto;
    width: auto;
    float: right;
    text-align: center;
}	

div.img img {
    display: inline;
    margin: 5px;
    border: 1px solid #ffffff;
}

div.img a:hover img {
    
}

div.desc {
  text-align: center;
  font-weight: normal;
  width: 120px;
  margin: 5px;
}
</style>
<style>
/* unvisited link */
a:link {
    color: #FF0000;
}

/* visited link */
a:visited {
    color: #00FF00;
}

/* mouse over link */
a:hover {
    color: #FF00FF;
}

/* selected link */
a:active {
    color: #0000FF;
}
</style>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt;
	 text-align:left;
}

fieldset {
	border: 1px solid #1E90FF
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid #1E90FF;
	color: #1E90FF;
	font-size: 90%;
	text-align: right;
	font-weight:bold;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</style>


<link rel="stylesheet" href="/pred/resources/style/demos.css">
<link rel="stylesheet" href="/pred/resources/style/form_style.css">

<title>Sujala Sponser</title>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<script >

function eMailCheck(str) {
	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str.indexOf(at)==-1){
	   alert("Invalid E-mail ID")
	   return false;
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   alert("Invalid E-mail ID")
	   return false;
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    alert("Invalid E-mail ID")
	    return false;
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    alert("Invalid E-mail ID")
	    return false;
	 }
	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    alert("Invalid E-mail ID")
	    return false;
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    alert("Invalid E-mail ID7")
	    return false;
	 }
	
	 if (str.indexOf(" ")!=-1){
	    alert("Invalid E-mail ID")
	    return false;
	 }

		 return true;					
}
function numeralsOnly(evt)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57))
	{
        alert("Only numbers are allowed in this field.");
        return false;
    }
	return true;
}
function enable(value){
	
	
	var rElement=document.forms[0].selection;
		if(value=='0'){
	
			rElement[0].checked="true";
		
			
	}else 
		if(value=='1'){
			rElement[1].checked="true";
		
				
		}else if(value=='2'){
			rElement[2].checked="true";
			
				
		}else if(value=='3'){
			rElement[3].checked="true";
		
				
		}else if(value=='4'){
			rElement[4].checked="true";
		
	}
}
function ajaxFunction()  
{  
  
 url = "switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=mandals";  
  
    if (window.XMLHttpRequest) { // Non-IE browsers  
      req = new XMLHttpRequest();  
      req.onreadystatechange = processStateChange;  
      try {  
        req.open("GET", url, true); //was get  
        alert('open') ;
      } catch (e) {  
        alert("Problem Communicating with Server\n"+e);  
      }  
     req.send(null);  
    } else if (window.ActiveXObject) { // IE  
        
      req = new ActiveXObject("Microsoft.XMLHTTP");  
      if (req) {  
        req.onreadystatechange = processStateChange;  
        req.open("GET", url, true);  
        req.send();  
      }  
    }  
  }  
    
  function processStateChange() {  
    
      if (req.readyState == 4) { // Complete  
      if (req.status == 200) { // OK response  
       // alert('ready') ;
        //alert("Ajax response:"+req.responseText);  
      //  var pono = req.responseText;  
        var returnElements=req.responseText.split("||");
        alert(returnElements) ;
        for ( var i=0; i<returnElements.length; i++ ){
        	if(returnElements[i]!="")
        	{
        	valueLabelPair = returnElements[i].split(";");
        	document.forms[0].elements['mandalCode'].options.length= returnElements.length;
        	//document.getElementById('mandalCode').options.length= returnElements.length;    
        	//document.getElementById('mandalCode').options[i] = new Option(valueLabelPair[0], valueLabelPair[1]);
        	document.forms[0].elements['mandalCode'].options[i] = new Option(valueLabelPair[0], valueLabelPair[1]);
        	}

        	}
        
        
        //var splitPONO = pono.split(",");  
       // alert(splitPONO.length)  
       // document.getElementById('pono').options.length = splitPONO.length;  
     //document.getElementById("mandalCode").innerHTML = req.responseText;  
         
          
      } else {  
        alert("Problem with server response:\n " + req.responseText);  
      }  
    }  
  }  

 function fnValidate(){
	 
 }

  function fnSave(){
	 
	  
	  if(document.forms[0].elements["sponserName"].value==""){
		  alert("Please Enter Sponsor Name");
		  return;
	  }
	  if(document.forms[0].elements["address"].value==""){
		  alert("Please Enter Address");
		  return;
	  }
	  if(document.forms[0].elements["city"].value==""){
		  alert("Please Enter City");
		  return;
	  }
	  if(document.forms[0].elements["state"].value==""){
		  alert("Please Enter State / Province / Region ");
		  return;
	  }
	  if(document.forms[0].elements["country"].value==""){
		  alert("Please Select Country");
		  return;
	  }
	  
	  if(document.forms[0].elements["mobileNo"].value==""){
		  alert("Please Enter Mobile Number.");
		  return;
	  }
	  
	  if(document.forms[0].elements["mobileNo"].value.length<10){
		  alert("Mobile Number Should Be 10 Digit.");
		  return;
	  }
	  
	  if(document.forms[0].elements["emailId"].value==""){
		  alert("Please Enter Email ID.");
		  return;
	  }
	  eMailCheck(document.forms[0].elements["emailId"].value);
	  if(document.forms[0].elements["amount"].value=="" || document.forms[0].elements["amount"].value=="0"){
		  alert("Please Enter Valid Amount");
		  return;
	  }
	  	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=save";
		document.forms[0].submit();
	 
	  
  }
function openForm(){
	var URL="tankCost.html";
	TINY.box.show({url:URL,boxid:'frameless',width:500,height:500,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}
function openJS(){}
function closeJS(){}

function changeOpt(value ){

	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=mandals&sMode="+value;
	document.forms[0].submit();
}
function getMandals()
{
	
	
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=mandals";
	document.forms[0].submit();  
	
} 

function getVillages()
{
    //alert("hai");
    
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=villages";
	document.forms[0].submit();  
     
	
} 

function getPanchayats()
{
    //alert("hai");
     //var rElement=document.forms[0].selection;
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=panchayaths";
	document.forms[0].submit();  
     
	
} 

function getHabs()
{
    //alert("hai");
    
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujalaSponser.do?mode=data&subMode=habs";
	document.forms[0].submit();  
     
	
} 
</script>
</head>
<center>
<body onload="enable('<%=value %>');" >
<br></br>

<div class="img"><a href="/pred/index.html"><img width="60" height="60" src="/pred/images/homepage.png"></a> </div>


<html:form action="ntrSujalaSponser.do" styleClass="smart-green">

 <h1>Sujala Pathakam Sponsor Information
        <span></span>
    </h1>
<table width="70%" style="border-collapse: collapse;" >
	
	
		<tr>
			<td >
			<fieldset><legend>Sponsor Details</legend> 
			<table>
			<tr><td >Name <font color="red"><b>*</b></font></td> <td><html:text styleClass="smart-green" property="sponserName" ></html:text></td>
			<td  >Category <font color="red"><b>*</b></font></td> <td><html:select styleClass="smart-green" property="category" ><option value="Industrail">Industrail</option>
			<option value="Firm">Firm</option>
			<option value="Corporate">Corporate</option>
			<option value="NRI">NRI</option>
			<option value="Individual">Individual</option>
			<option value="other">Other</option>
			</html:select></td>
			</tr>
			<tr><td  >Address <font color="red"><b>*</b></font> </td> <td><html:text styleClass="smart-green" property="address" ></html:text></td>
			<td >City <font color="red"><b>*</b></font></td> <td><html:text  styleClass="smart-green"  property="city"></html:text></td>
			</tr>
			<tr>
			<td >State / Province / Region <font color="red"><b>*</b></font></td> <td><html:text  styleClass="smart-green"  property="state"></html:text></td>
			<td >Country <font color="red"><b>*</b></font></td> <td><html:select  property="country" styleClass="smart-green" style="width:135px" >									<option value="" selected="selected"></option>
									<option value="United States" >United States</option>
									<option value="United Kingdom" >United Kingdom</option>
									<option value="Australia" >Australia</option>
									<option value="Canada" >Canada</option>
									<option value="France" >France</option>
									<option value="New Zealand" >New Zealand</option>
									<option value="India" >India</option>
									<option value="Brazil" >Brazil</option>
									<option value="----" >----</option>
									<option value="Afghanistan" >Afghanistan</option>
									<option value="Åland Islands" >Åland Islands</option>
									<option value="Albania" >Albania</option>
									<option value="Algeria" >Algeria</option>
									<option value="American Samoa" >American Samoa</option>
									<option value="Andorra" >Andorra</option>
									<option value="Angola" >Angola</option>
									<option value="Anguilla" >Anguilla</option>
									<option value="Antarctica" >Antarctica</option>
									<option value="Antigua and Barbuda" >Antigua and Barbuda</option>
									<option value="Argentina" >Argentina</option>
									<option value="Armenia" >Armenia</option>
									<option value="Aruba" >Aruba</option>
									<option value="Austria" >Austria</option>
									<option value="Azerbaijan" >Azerbaijan</option>
									<option value="Bahamas" >Bahamas</option>
									<option value="Bahrain" >Bahrain</option>
									<option value="Bangladesh" >Bangladesh</option>
									<option value="Barbados" >Barbados</option>
									<option value="Belarus" >Belarus</option>
									<option value="Belgium" >Belgium</option>
									<option value="Belize" >Belize</option>
									<option value="Benin" >Benin</option>
									<option value="Bermuda" >Bermuda</option>
									<option value="Bhutan" >Bhutan</option>
									<option value="Bolivia" >Bolivia</option>
									<option value="Bosnia and Herzegovina" >Bosnia and Herzegovina</option>
									<option value="Botswana" >Botswana</option>
									<option value="British Indian Ocean Territory" >British Indian Ocean Territory</option>
									<option value="Brunei Darussalam" >Brunei Darussalam</option>
									<option value="Bulgaria" >Bulgaria</option>
									<option value="Burkina Faso" >Burkina Faso</option>
									<option value="Burundi" >Burundi</option>
									<option value="Cambodia" >Cambodia</option>
									<option value="Cameroon" >Cameroon</option>
									<option value="Cape Verde" >Cape Verde</option>
									<option value="Cayman Islands" >Cayman Islands</option>
									<option value="Central African Republic" >Central African Republic</option>
									<option value="Chad" >Chad</option>
									<option value="Chile" >Chile</option>
									<option value="China" >China</option>
									<option value="Colombia" >Colombia</option>
									<option value="Comoros" >Comoros</option>
									<option value="Democratic Republic of the Congo" >Democratic Republic of the Congo</option>
									<option value="Republic of the Congo" >Republic of the Congo</option>
									<option value="Cook Islands" >Cook Islands</option>
									<option value="Costa Rica" >Costa Rica</option>
									<option value="C&ocirc;te d'Ivoire" >C&ocirc;te d'Ivoire</option>
									<option value="Croatia" >Croatia</option>
									<option value="Cuba" >Cuba</option>
									<option value="Cyprus" >Cyprus</option>
									<option value="Czech Republic" >Czech Republic</option>
									<option value="Denmark" >Denmark</option>
									<option value="Djibouti" >Djibouti</option>
									<option value="Dominica" >Dominica</option>
									<option value="Dominican Republic" >Dominican Republic</option>
									<option value="East Timor" >East Timor</option>
									<option value="Ecuador" >Ecuador</option>
									<option value="Egypt" >Egypt</option>
									<option value="El Salvador" >El Salvador</option>
									<option value="Equatorial Guinea" >Equatorial Guinea</option>
									<option value="Eritrea" >Eritrea</option>
									<option value="Estonia" >Estonia</option>
									<option value="Ethiopia" >Ethiopia</option>
									<option value="Faroe Islands" >Faroe Islands</option>
									<option value="Fiji" >Fiji</option>
									<option value="Finland" >Finland</option>
									<option value="Gabon" >Gabon</option>
									<option value="Gambia" >Gambia</option>
									<option value="Georgia" >Georgia</option>
									<option value="Germany" >Germany</option>
									<option value="Ghana" >Ghana</option>
									<option value="Gibraltar" >Gibraltar</option>
									<option value="Greece" >Greece</option>
									<option value="Grenada" >Grenada</option>
									<option value="Guatemala" >Guatemala</option>
									<option value="Guinea" >Guinea</option>
									<option value="Guinea-Bissau" >Guinea-Bissau</option>
									<option value="Guyana" >Guyana</option>
									<option value="Haiti" >Haiti</option>
									<option value="Honduras" >Honduras</option>
									<option value="Hong Kong" >Hong Kong</option>
									<option value="Hungary" >Hungary</option>
									<option value="Iceland" >Iceland</option>
									<option value="Indonesia" >Indonesia</option>
									<option value="Iran" >Iran</option>
									<option value="Iraq" >Iraq</option>
									<option value="Ireland" >Ireland</option>
									<option value="Israel" >Israel</option>
									<option value="Italy" >Italy</option>
									<option value="Jamaica" >Jamaica</option>
									<option value="Japan" >Japan</option>
									<option value="Jordan" >Jordan</option>
									<option value="Kazakhstan" >Kazakhstan</option>
									<option value="Kenya" >Kenya</option>
									<option value="Kiribati" >Kiribati</option>
									<option value="North Korea" >North Korea</option>
									<option value="South Korea" >South Korea</option>
									<option value="Kuwait" >Kuwait</option>
									<option value="Kyrgyzstan" >Kyrgyzstan</option>
									<option value="Laos" >Laos</option>
									<option value="Latvia" >Latvia</option>
									<option value="Lebanon" >Lebanon</option>
									<option value="Lesotho" >Lesotho</option>
									<option value="Liberia" >Liberia</option>
									<option value="Libya" >Libya</option>
									<option value="Liechtenstein" >Liechtenstein</option>
									<option value="Lithuania" >Lithuania</option>
									<option value="Luxembourg" >Luxembourg</option>
									<option value="Macedonia" >Macedonia</option>
									<option value="Madagascar" >Madagascar</option>
									<option value="Malawi" >Malawi</option>
									<option value="Malaysia" >Malaysia</option>
									<option value="Maldives" >Maldives</option>
									<option value="Mali" >Mali</option>
									<option value="Malta" >Malta</option>
									<option value="Marshall Islands" >Marshall Islands</option>
									<option value="Mauritania" >Mauritania</option>
									<option value="Mauritius" >Mauritius</option>
									<option value="Mexico" >Mexico</option>
									<option value="Micronesia" >Micronesia</option>
									<option value="Moldova" >Moldova</option>
									<option value="Monaco" >Monaco</option>
									<option value="Mongolia" >Mongolia</option>
									<option value="Montenegro" >Montenegro</option>
									<option value="Morocco" >Morocco</option>
									<option value="Mozambique" >Mozambique</option>
									<option value="Myanmar" >Myanmar</option>
									<option value="Namibia" >Namibia</option>
									<option value="Nauru" >Nauru</option>
									<option value="Nepal" >Nepal</option>
									<option value="Netherlands" >Netherlands</option>
									<option value="Netherlands Antilles" >Netherlands Antilles</option>
									<option value="Nicaragua" >Nicaragua</option>
									<option value="Niger" >Niger</option>
									<option value="Nigeria" >Nigeria</option>
									<option value="Norway" >Norway</option>
									<option value="Oman" >Oman</option>
									<option value="Pakistan" >Pakistan</option>
									<option value="Palau" >Palau</option>
									<option value="Palestine" >Palestine</option>
									<option value="Panama" >Panama</option>
									<option value="Papua New Guinea" >Papua New Guinea</option>
									<option value="Paraguay" >Paraguay</option>
									<option value="Peru" >Peru</option>
									<option value="Philippines" >Philippines</option>
									<option value="Poland" >Poland</option>
									<option value="Portugal" >Portugal</option>
									<option value="Puerto Rico" >Puerto Rico</option>
									<option value="Qatar" >Qatar</option>
									<option value="Romania" >Romania</option>
									<option value="Russia" >Russia</option>
									<option value="Rwanda" >Rwanda</option>
									<option value="Saint Kitts and Nevis" >Saint Kitts and Nevis</option>
									<option value="Saint Lucia" >Saint Lucia</option>
									<option value="Saint Vincent and the Grenadines" >Saint Vincent and the Grenadines</option>
									<option value="Samoa" >Samoa</option>
									<option value="San Marino" >San Marino</option>
									<option value="Sao Tome and Principe" >Sao Tome and Principe</option>
									<option value="Saudi Arabia" >Saudi Arabia</option>
									<option value="Senegal" >Senegal</option>
									<option value="Serbia" >Serbia</option>
									<option value="Seychelles" >Seychelles</option>
									<option value="Sierra Leone" >Sierra Leone</option>
									<option value="Singapore" >Singapore</option>
									<option value="Slovakia" >Slovakia</option>
									<option value="Slovenia" >Slovenia</option>
									<option value="Solomon Islands" >Solomon Islands</option>
									<option value="Somalia" >Somalia</option>
									<option value="South Africa" >South Africa</option>
									<option value="Spain" >Spain</option>
									<option value="Sri Lanka" >Sri Lanka</option>
									<option value="Sudan" >Sudan</option>
									<option value="Suriname" >Suriname</option>
									<option value="Swaziland" >Swaziland</option>
									<option value="Sweden" >Sweden</option>
									<option value="Switzerland" >Switzerland</option>
									<option value="Syria" >Syria</option>
									<option value="Taiwan" >Taiwan</option>
									<option value="Tajikistan" >Tajikistan</option>
									<option value="Tanzania" >Tanzania</option>
									<option value="Thailand" >Thailand</option>
									<option value="Togo" >Togo</option>
									<option value="Tonga" >Tonga</option>
									<option value="Trinidad and Tobago" >Trinidad and Tobago</option>
									<option value="Tunisia" >Tunisia</option>
									<option value="Turkey" >Turkey</option>
									<option value="Turkmenistan" >Turkmenistan</option>
									<option value="Tuvalu" >Tuvalu</option>
									<option value="Uganda" >Uganda</option>
									<option value="Ukraine" >Ukraine</option>
									<option value="United Arab Emirates" >United Arab Emirates</option>
									<option value="United States Minor Outlying Islands" >United States Minor Outlying Islands</option>
									<option value="Uruguay" >Uruguay</option>
									<option value="Uzbekistan" >Uzbekistan</option>
									<option value="Vanuatu" >Vanuatu</option>
									<option value="Vatican City" >Vatican City</option>
									<option value="Venezuela" >Venezuela</option>
									<option value="Vietnam" >Vietnam</option>
									<option value="Virgin Islands, British" >Virgin Islands, British</option>
									<option value="Virgin Islands, U.S." >Virgin Islands, U.S.</option>
									<option value="Yemen" >Yemen</option>
									<option value="Zambia" >Zambia</option>
									<option value="Zimbabwe" >Zimbabwe</option>
							</html:select></td>
			</tr>
		    <tr><td >Mobile <font color="red"><b>*</b></font></td> <td ><html:text styleClass="smart-green" onkeypress="return numeralsOnly()" maxlength="10" property="mobileNo"></html:text> </td><td   >Email <font color="red"><b>*</b></font> </td> <td><html:text property="emailId" styleClass="smart-green" > </html:text></td>
		    </tr>
		    <tr>
		    <td >Sponser Amount <font color="red"><b>*</b></font></td> <td ><html:text onkeypress="return numeralsOnly()"  styleClass="smart-green"  property="amount" ></html:text><font color="red"></font></td> 
		    
			</tr>
			
			<tr><td colspan="2" ><html:radio  onclick="sponserVillage.disabled = false;"  property="villageSelection"   value="SelectedBySponser"></html:radio>Want To Identify Particular Village  </td></tr>
			<tr><td colspan="2" ><html:radio onclick="sponserVillage.disabled = true;" property="villageSelection"  value="SelectedByGovt"></html:radio>Govt To Indentify the village to be sponser.
			
			<a href="#"  onclick="openForm()">Plant Details</a>
			</td>
			
			</tr>
			</table>
			</fieldset>
			</td>
		</tr>
	
	
	
	
	
	
		<tr align="left">
			<td>
			<fieldset id="sponserVillage">
			<legend>Sponsered Village Details</legend> 
			<table>
			<tr >
			<td ><html:radio   onclick="changeOpt(0);" property="selection" value="0"></html:radio> District </td>
		
		
			<td  ><html:radio  property="selection"  onclick="changeOpt(1);"  value="1"></html:radio> Mandal </td>
		
		<td  ><html:radio  property="selection"  onclick="changeOpt(2);" value="2"></html:radio> Panchayath </td>
			<td   ><html:radio  property="selection"  onclick="changeOpt(3);"  value="3"> </html:radio>Village </td>
		
		<td   ><html:radio  property="selection"  onclick="changeOpt(4);"  value="4" > </html:radio>Habitation </td>
		
			</tr>
			</table>
			<%
			   if(value!=null && value.equals("0")){
			%>
			
			<jsp:include page="dist.jsp" />
			
			<%}  else   if(value!=null && value.equals("1")){%>
			
			<jsp:include page="mandal.jsp" />
			<%} else if(value!=null && value.equals("2")){  %>
			<jsp:include page="panchayat.jsp" />
			<%} else if(value!=null && value.equals("3")){  %>
			<jsp:include page="village.jsp" />
			<% } else if (value!=null && value.equals("4")){   %>
			<jsp:include page="habitations.jsp" />
			<%} %>
			</fieldset>
			</td>
		</tr>
		<tr><td    align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input  onclick="fnSave()" class="button" disabled="true" style="width:140px" type="button" value="Save"></td></tr>
		
	</table>
	
	
		
</html:form>
</body>
<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	</script>
<%
 }
 %>

</center>
</html>