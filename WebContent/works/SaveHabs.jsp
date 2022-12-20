<html>
<body >
<%! String[] habs; %>
<center>You have selected: 
<% 
java.util.ArrayList ar=new java.util.ArrayList();
   habs = request.getParameterValues("selectedHabCode");
    
   if (habs != null) 
   {
      for (int i = 0; i < habs.length; i++) 
      {
         ar.add(habs[i]);
         //out.println ("<b>"+habs[i]+"<b>");
      }
      if(ar!=null)
      session.setAttribute("SanctionedHabs",ar);
   }
   else
   {
   habs = request.getParameterValues("selectedRevHabCode");
   if (habs != null) 
   {
      for (int i = 0; i < habs.length; i++) 
      {
         ar.add(habs[i]);
         //out.println ("<b>"+habs[i]+"<b>");
      }
      if(ar!=null)
      session.setAttribute("SanctionedRevHabs",ar);
   }
   }
   
    
%>
<script>
 window.close();
</script>
</center>
</body>
</html>