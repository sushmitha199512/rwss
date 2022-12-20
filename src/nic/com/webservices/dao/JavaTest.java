package nic.com.webservices.dao;
class Super 
{ 
    public Integer getLength() 
    {
        return new Integer(4); 
    } 
} 

public class JavaTest extends Super 
{ 
   
    public static void main(String[] args) 
    { 
        Super sooper = new Super(); 
        JavaTest sub = new JavaTest(); 
        System.out.println( 
        sooper.getLength().toString() + "," + sub.getLength().toString() ); 
    } 
}
class ObjComp {

}

  class JavaTest3 
{
    public static void main(String [] args) 
    {
        System.out.print("1 ");
        synchronized(args)
        {
            System.out.print("2 ");
            try 
            {
                    args.wait(); /* Line 11 */
            }
            catch(InterruptedException e){ }
        }
        System.out.print("3 ");
    }
}
 class JavaTest1 extends A {
	static {

	}

	public static void main(String[] args) {

		
		
		//float[ ] f = new float(3);
		float f2[ ] = new float[2];
		//float[ ]f1 = new float[3];
		float f3[ ] = new float[3];
		float f5[ ] = {1.0f, 2.0f, 2.0f};
		
		int result = 0;
		ObjComp oc = new ObjComp();
		Object o = oc;

		if (o == oc)
			result = 1;
		if (o != oc)
			result = result + 10;
		if (o.equals(oc))
			result = result + 100;
		if (oc.equals(o))
			result = result + 1000;

		System.out.println("result = " + result);
		try {
			Float f1 = new Float("3.0");
			int x = f1.intValue();
			byte b = f1.byteValue();
			System.out.println("byte:" + b);
			double d = f1.doubleValue();
			System.out.println(x + b + d);
		} catch (NumberFormatException e) /* Line 9 */
		{
			System.out.println("bad number"); /* Line 11 */
		}

	}

	@Override
	public void add() {

	}

}

abstract class A {
	int a;

	public abstract void add();

	public int getA() {

		return a;
	}

	public void setA(int a) {
		this.a = a;
	}

}
