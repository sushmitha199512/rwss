
<html:html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE></TITLE>
</HEAD>

<BODY>
<P>Place content here.</P>
</BODY>
<%!
public String getAssetCodeSeries(String assetcode){
	int assetcod=Integer.parseInt(assetcode);
	String series="";
		switch(assetcod)
		{
		case 1:series="600";break;
		case 2:series="400";break;
		case 3:series="800";break;
		case 4:series="001";break;
		case 5:series="300";break;
		case 6:series="500";break;
		case 7:series="700";break;
		case 8:series="900";break;
		case 9:series="451";break;
		}
		
		return series;
		}
%>



</html:html>
