package nic.watersoft.reports;

import java.util.Hashtable;

/**
 * 
 * @author RWSS_DPT1
 * 
 */
public class RwsHashTable extends Hashtable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 * @param key
	 * @param value
	 */
	public void putValue(Object key, Object value) {

		super.put(key, value);
	}

	/**
	 * 
	 * @param key
	 * @return
	 */
	public Object getValue(Object key) {

		Object value = super.get(key);
		if (value != null && !value.equals("null") && !value.equals("NULL")
				&& !value.equals("")) {
			return value;
		} else {
			//Debug.println((String) value);
			return "";
		}

	}

}
