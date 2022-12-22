<%
	response.setHeader("Cache-Control","private");
	response.setHeader("Cache-Control","max-age=0");
	response.setHeader("Pragma","no-cache");// HTTP 1.0.
	response.setHeader("Cache-Control","no-cache");// HTTP 1.1.
	response.setHeader("Cache-Control","no-store");
%>