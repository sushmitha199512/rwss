/*
 * Created on 23-May-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 * @author NIC (Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_UserSerializaion {

	public static RwsUser doSerailization(RwsUser user) {
		try {
			FileOutputStream fos = new FileOutputStream("user");
			ObjectOutputStream oos = new ObjectOutputStream(fos);
			oos.writeObject(user);
			oos.flush();
			oos.close();
		} catch (Exception e) {
			System.out.println("Exception during serialization: " + e);
		}
		return user;
	}

	public static RwsUser doDeserialization() {
		RwsUser user = null;
		try {

			FileInputStream fis = new FileInputStream("user");
			ObjectInputStream ois = new ObjectInputStream(fis);
			user = (RwsUser) ois.readObject();
			ois.close();
			// System.out.println("User: " + user);
		} catch (Exception e) {
			System.out.println("Exception during deserialization: " + e);

		}
		return user;

	}

}
