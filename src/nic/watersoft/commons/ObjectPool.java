/*
 * Created on 09-Feb-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.util.Enumeration;
import java.util.Hashtable;

public abstract class ObjectPool 
{
   private long expirationTime;   
   private Hashtable locked, unlocked;        
   abstract Object create();
   abstract boolean validate( Object o );
   abstract void expire( Object o );
   synchronized Object checkOut()
   {
	   System.out.println("in checkout locked :"+locked.size());
	   System.out.println("in checkout unlocked :"+unlocked.size());
	      
		   long now = System.currentTimeMillis();
		   Object o;        
		   if( unlocked.size() > 0 )
		   {
		      Enumeration e = unlocked.keys();  
		      while( e.hasMoreElements() )
		      {
		         o = e.nextElement();           
		         if( ( now - ( ( Long ) unlocked.get( o ) ).longValue() ) > expirationTime )
		         {
		            // object has expired
		            unlocked.remove( o );
		            expire( o );
		            o = null;
		         }
		         else
		         {
		            if( validate( o ) )
		            {
		               unlocked.remove( o );
		               locked.put( o, new Long( now ) );                
		               return( o );
		            }
		            else
		            {
		               // object failed validation
		               unlocked.remove( o );
		               expire( o );
		               o = null;
		            }
		         }
		      }
		   }        
		   // no objects available, create a new one
		   o = create();        
		   locked.put( o, new Long( now ) ); 
		   System.out.println("in checkout locked1 :"+locked.size());
		   System.out.println("in checkout unlocked1 :"+unlocked.size());
		   
		   return( o );
	   }
   synchronized void checkIn( Object o )
   {
      locked.remove( o );
      unlocked.put( o, new Long( System.currentTimeMillis() ) );
      System.out.println("in checkin locked :"+locked.size());
      System.out.println("in checkin unlocked :"+unlocked.size());
      
   }
   ObjectPool()
   {
      expirationTime = 300000; // 300 seconds i.e., 5 Minutes
      locked = new Hashtable();         
      unlocked = new Hashtable();
   }
   
}
