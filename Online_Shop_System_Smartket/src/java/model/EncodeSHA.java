/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author HP
 */
import java.security.MessageDigest;

import org.apache.tomcat.util.codec.binary.Base64;

public class EncodeSHA {

	public static String transFer(String pass) {
		String code = "ptqkz@46;8kj3f9";
		String result = null;
		
		pass = pass+ code;
		try {
			byte[] encodePass = pass.getBytes("UTF-8");
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			result = Base64.encodeBase64String(md.digest(encodePass));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
}
