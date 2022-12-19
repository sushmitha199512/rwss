
package nic.watersoft.commons;


public final class Debug
{
	private static final boolean debuggingOn=true;
	
	public static final void print(String message)
	{
		if(debuggingOn)
			System.err.print(message);
	}
	public static final void println(String message)
	{
		if(debuggingOn)
			System.out.println(message);
	}
	
	public static final void write(String message)
	{
		System.err.print(message);
	}
	public static final void writeln(String message)
	{
		System.err.println(message);
	}
}