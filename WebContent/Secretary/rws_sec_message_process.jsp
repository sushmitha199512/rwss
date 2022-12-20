
<%@ include file="/reports/conn.jsp" %>
<%@ page import="java.sql.*" %>

<%

  //System.out.println("Start");
      ResultSet rss=null;
      PreparedStatement pst=null;
          String userId=request.getParameter("userid");
String to=request.getParameter("to");
   to=to.substring(0,to.length()-1);
int  priority=Integer.parseInt(request.getParameter("priority"));
String message=request.getParameter("message");
String currentDate=nic.watersoft.commons.RwsUtils.getCurrentDate("dd/MM/yyyy");
String statusMesg="Sent Successfully";
//System.out.println("User"+userId);
 //System.out.println("to"+to);
//System.out.println("Message"+message);
//System.out.println("currentdate"+currentDate);

int count =0;
	try{


           pst=conn.prepareStatement("insert into rws_secretary_message_tbl(MESG_ID,FROM_USERID,TO_OFFICE_LEVEL,MESSAGE_DETAILS,MESSAGE_DATE,MESSAGE_PRIORITY) values(rws_sec_mesg.NEXTVAL,?,?,?,to_date(?,'dd/MM/yyyy'),?)");
        pst.setString(1,userId);
        pst.setString(2,to);
        pst.setString(3,message);
        pst.setString(4,currentDate);
 		pst.setInt(5,priority);
           
     count=pst.executeUpdate();

       if(count>=1){
	}
    else{
    statusMesg="Sending Failed";
}

%>

 <%=statusMesg %>
<% 
		

 }catch(Exception e){
  e.printStackTrace();
}
            

 %>
