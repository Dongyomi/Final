package web.util;

//import java.io.File;
//import java.io.FileNotFoundException;
//import java.io.FileReader;
//import java.io.IOException;
//import java.util.Properties;

import java.util.HashMap;
import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SmsService {
	
	public void sendSms(String toNumber, String num) {
		
//		@Value("${coolsms.devHee.apikey}")
//		private String apiKey;

//		@Value("${coolsms.devHee.apisecret}")
//		private String apiSecret;

//		@Value("${coolsms.devHee.fromnumber}")
//		private String fromNumber;
		
		String apiKey = "NCSHJPV0EMCE2QCA";
		String apiSecret = "ZWHCWFRGKBISKNQ0EQL9VBWHJOQFOSWG";
		String fromNumber = "07045818950";
		
		Message coolsms = new Message(apiKey, apiSecret);

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", toNumber);
		params.put("from", fromNumber);
		params.put("type", "SMS");
		params.put("text", "인증번호 : " + num);
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
}
	
