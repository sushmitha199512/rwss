<%@ include file="/reports/conn.jsp" %>
<!-- <style>
.visits {
  color: white;
  font-size:small;
  font-weight: bold;
  background: linear-gradient(to bottom, #ffffff 0%, #4A8AC7 100%);
  border-radius: 25px;
  padding: 5px;
  text-shadow: 5px 5px 8px black;
}
</style> -->
<style>
.card-light{
	/* box-shadow:0 1px 3px rgba(0,0,0,.12),0 1px 2px rgba(0,0,0,.24);
	text-shadow:0 1px 3px rgba(0,0,0,.12),0 1px 2px rgba(0,0,0,.24); */
	box-shadow:0 10px 50px rgba(0,0,0,.19),0 10px 6px rgba(0,0,0,.23);
	text-shadow:0 10px 10px rgba(0,0,0,.50),0 10px 10px rgba(0,0,0,.23);
	transition:all .2s ease-in-out;
}
.card-light:hover{
	/* box-shadow:0 10px 50px rgba(0,0,0,.19),0 10px 6px rgba(0,0,0,.23);
	text-shadow:0 10px 10px rgba(0,0,0,.50),0 10px 10px rgba(0,0,0,.23); */
	box-shadow:0 1px 3px rgba(0,0,0,.12),0 1px 2px rgba(0,0,0,.24);
	text-shadow:0 1px 3px rgba(0,0,0,.12),0 1px 2px rgba(0,0,0,.24);
	border-radius:10px;
}
.card-simple{
	border-radius:1px;
	box-shadow:0 1px 2px rgba(0,0,0,.24);
	transition:all .2s ease-in-out;
	overflow:hidden;
}
.card-heading{
	padding:15px 10px 0 15px;
}
.viewport-height{
	height:100vh;
	margin-top:-54px;
	padding:65px 10px 10px;
}
</style>
<%
String hitsCount="0";
try
{
	PreparedStatement pstt=conn.prepareStatement("UPDATE RWS_WEBPAGE_HITS G SET G.PAGE_HITS=G.PAGE_HITS+1");  
	pstt.executeUpdate();  
	pstt.close();
	Statement stt = conn.createStatement();
	ResultSet rss = stt.executeQuery("SELECT TRIM(TO_CHAR(B.PAGE_HITS, '99,99,99,99,99,99,99,99,99,99,99,99,999')) CNT FROM RWS_WEBPAGE_HITS B");
	if(rss.next())
	{
 		hitsCount=rss.getString("CNT");
	}
	rss.close();
	stt.close();
}
catch(Exception e){}
%>
<center>
         <div class="card card-light space-20"><div style="background-color:#4A8AC7;padding: 5px;font-family: Arial, Helvetica, sans-serif;"><font color="white" size="2">Total number of visitors</font><br><b><font size="3" color="white"><%= hitsCount%></font></b></div></div>
</center>