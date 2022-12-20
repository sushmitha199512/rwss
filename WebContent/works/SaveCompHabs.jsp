<html>
<body >
<center>You have selected: 
<% 
java.util.ArrayList ar=new java.util.ArrayList();
String hiddenValue = request.getParameter("hidd");
System.out.println("HIdden Value:"+hiddenValue);
String habs[] = hiddenValue.split(",");
    
   if (habs != null) 
   {
      for (int i = 0; i < habs.length; i++) 
      {
         ar.add(habs[i]);
         System.out.println ("<b>"+habs[i]+"<b>");
      }
      if(ar!=null)
      session.setAttribute("SanctionedCompHabs",habs);
	  session.removeAttribute("selHabCodes");
  	  session.setAttribute("selHabCodes",habs);
   }
%>
<script>
 window.close();
</script>
</center>
</body>
</html>