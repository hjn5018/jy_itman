package egovframework.usr.com;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.service.EgovProperties;

/*import egovframework.lms.web.service.EgovLmsWebSessionVO;*/

public class EgovframeworkCommonUtil {
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("WL-Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("HTTP_CLIENT_IP"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		} 
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
		    ip = request.getRemoteAddr(); 
		}
		if(ip.contains(",")) {
		    String[] ips = ip.split(",");
		    ip = ips[0];
		}
		

		return ip;
	}

	/*public static EgovLmsWebSessionVO getSession(HttpServletRequest request) {
		return (EgovLmsWebSessionVO) request.getSession().getAttribute("session");
	}

	public static String getSessionId(HttpServletRequest request) {
		try {
			return getSession(request).getUserId();
		}
		catch(Exception e) {
			return "";
		}
	}*/

	public static String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", "");	// ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", "");	// ..\

		return returnValue;
	}
	
	 /**
     * 화폐 콤마(,)찍기
     * @param won
     * @return
     */
	public static String changeWon(String won){
    	if(won.indexOf(".")>-1){
    		won = won.split("\\.")[0];
    	}
    	
    	String minus ="";
    	if(won.indexOf("-")>-1){
    		won = won.replace("-","");
    		minus="-";
    	}
    	
    	int intWon = Integer.parseInt(won);
    	String wonText ="0";
    	DecimalFormat formatter = new DecimalFormat("###,###");
    	if(intWon>0){
    		wonText = formatter.format(intWon);	
    	}
    	return minus+wonText;
    }
	
	public static int getDateDifference(String date1, String date2) {
		Calendar c1 = Calendar.getInstance();
		c1.set(getYearInt(date1), getMonthInt(date1), getDayInt(date1));

		Calendar c2 = Calendar.getInstance();
		c2.set(getYearInt(date2), getMonthInt(date2), getDayInt(date2));
		
		long d1 = c1.getTime().getTime();
		long d2 = c2.getTime().getTime();

		return (int) ((d2 - d1) / (1000 * 60 * 60 * 24));
	}
	
	public static String getAddDate(String dateStr, int addDay) {
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date date = null;
		try {
			date = dateFormat.parse(dateStr.replaceAll("-", ""));
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, addDay);
			dateFormat = new SimpleDateFormat("MM월 dd일");
			return dateFormat.format(cal.getTime());
		} catch (ParseException e) {
			return null;
		}
	}
	
	public static String getDateEng(String dateStr) {
		if(dateStr.contains(".")) {
			String[] tmpStr = dateStr.split(".");
			String y = tmpStr[0];
			String m = tmpStr[1];
			String d = tmpStr[2];
			return d + "." + m + "." + y;
		}
		if(dateStr.contains("-")) {
			String[] tmpStr = dateStr.split("-");
			String y = tmpStr[0];
			String m = tmpStr[1];
			String d = tmpStr[2];
			return d + "-" + m + "-" + y;
		}
		return "";
	}
	
	public static String getDateEngStr(String dateStr) {
		String[] tmpStr;
		String[] monthEngArray = {
			"January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December"
		};
		String y;
		String m;
		String d;
		if(dateStr.contains(".")) {
			tmpStr = dateStr.split(".");
			y = tmpStr[0];
			m = tmpStr[1];
			d = tmpStr[2];
		}
		else {
			tmpStr = dateStr.split("-");
			y = tmpStr[0];
			m = tmpStr[1];
			d = tmpStr[2];
		}
		
		return monthEngArray[Integer.parseInt(m) * 1 - 1] + " " + d + "<span>th</span>, " + y;
	}

	public static String getTodayDateTime(int len) {
		Calendar oCalendar = Calendar.getInstance();

		String year  = Integer.toString(oCalendar.get(Calendar.YEAR));
		String month = Integer.toString(oCalendar.get(Calendar.MONTH) + 1);
		String day   = Integer.toString(oCalendar.get(Calendar.DAY_OF_MONTH));
		String hour  = Integer.toString(oCalendar.get(Calendar.HOUR_OF_DAY));
		String min   = Integer.toString(oCalendar.get(Calendar.MINUTE));
		String sec   = Integer.toString(oCalendar.get(Calendar.SECOND));

		if(month.length() == 1) month = "0" + month;
		if(day.length() == 1) day = "0" + day;
		if(hour.length() == 1) hour = "0" + hour;
		if(min.length() == 1) min = "0" + min;
		if(sec.length() == 1) sec = "0" + sec;

		String tmp = year + month + day + hour + min + sec;
		return (len > 0)?tmp.substring(0, len):tmp;
	}
	
	public static String getCompareDateTime(String dateTime) {
		dateTime = dateTime.replaceAll("-", "");
		dateTime = dateTime.replaceAll(":", "");
		dateTime = dateTime.replaceAll(" ", "");

		if(dateTime.contains(".")) {
			String[] rtnValue = dateTime.split("\\.");
			return rtnValue[0];
		}
		else {
			return "";
		}
	}
	
	public static String getTodayDateTime(String separate) {
		Calendar oCalendar = Calendar.getInstance();
		
		String year  = Integer.toString(oCalendar.get(Calendar.YEAR));
		String month = Integer.toString(oCalendar.get(Calendar.MONTH) + 1);
		String day   = Integer.toString(oCalendar.get(Calendar.DAY_OF_MONTH));
		
		if(month.length() == 1) month = "0" + month;
		if(day.length() == 1) day = "0" + day;

		return year + separate + month + separate + day;
	}
	
	public static String yesterDay(String date, int day) {
		if(date != "") {
			date = date.replace(".","");
			try {
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
				long chStart = df.parse(date).getTime();
				
				chStart -= (day * 24 * 60 * 60 * 1000);
				
				Date dt = new Date(chStart);
				df = new SimpleDateFormat("yyyy.MM.dd");
				date = df.format(dt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return date;
	}
	
	public static String getRand() {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String today = dateFormat.format(date);
		Random random = new Random();
		return today + String.format("%06d", random.nextInt(999999));
	}

	public static String getYearStr(String date) {
		String[] rtnVal = date.split("-");
		return rtnVal[0];
	}
	public static int getYearInt(String date) {
		String[] rtnVal = date.split("-");
		return Integer.parseInt(rtnVal[0]);
	}
	
	public static String getMonthStr(String date) {
		String[] rtnVal = date.split("-");
		return rtnVal[1];
	}
	public static int getMonthInt(String date) {
		String[] rtnVal = date.split("-");
		return Integer.parseInt(rtnVal[1]);
	}
	
	public static String getDayStr(String date) {
		String[] rtnVal = date.split("-");
		return rtnVal[2];
	}
	public static int getDayInt(String date) {
		String[] rtnVal = date.split("-");
		return Integer.parseInt(rtnVal[2]);
	}
	
    /**
     * MD5 암호화 ( 사용금지 AES256 or SHA256 사용 )
     * @param str - 암호화 할 문자
     * @return 암호화된 문자
     */
//	 public static String genMD5(String str)  { 
//	 	byte [] buffer = null; 
//	 	java.lang.StringBuffer s = new java.lang.StringBuffer(); 
//	
//	 	 try 
//	 	  { 
//	 		// Obtain a message digest object. 
//	 		MessageDigest md = MessageDigest.getInstance("MD5"); 
//	
//	 		// Calculate the digest for the given file. 
//	 		md.update(str.getBytes());
//	 		
//	 		// computing digest 
//	 		buffer = md.digest(); 
//	
//	 		for (int i = 0; i < buffer.length; i++) { 
//	 			s.append(Integer.toString((buffer[i] & 0xf0) >> 4, 16)); 
//	 			s.append(Integer.toString(buffer[i] & 0x0f, 16)); 
//	 		} 
//	
//	 		md.reset(); 
//	   } catch (NoSuchAlgorithmException ns) { 
//		  	return ""; 
//	   } catch (Exception ex) { 
//		  	return ""; 		  	
//	  	} 	
//	 	return s.toString(); 
//	 }
	 
	 /**
     * 고유키생성
     * @param prefix - 앞에 붙일 문자
     * @return 암호화된 문자
     */
	 public static String getUniqueKey(String prefix)  {
		 String uniqueKey = "";
		 SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
	        Calendar dateTime = Calendar.getInstance();
	        uniqueKey = prefix + sdf.format(dateTime.getTime()) + (int)(Math.random() * (999 - 100 + 1) + 100);
	 	return uniqueKey;
	 }
	 
	 public static String getUniqueKeyShort(String prefix)  {
		 String uniqueKey = "";
		 SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
	        Calendar dateTime = Calendar.getInstance();
	        uniqueKey = prefix + sdf.format(dateTime.getTime()) + (int)(Math.random() * (999 - 100 + 1) + 100);
	 	return uniqueKey;
	 }
	 
	 /**
	 * 클라이언트(Client)의 OS 정보를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String osInfo OS 정보
	 * @exception Exception
	*/
	public static String getClientOsInfo(HttpServletRequest request) throws Exception {

		String user_agent = request.getHeader("user-agent").replaceAll(" ", "");
		
		String os			=	"";
		String osInfo 	= 	"";
		
		if(user_agent.indexOf("MacOS") > -1) {
			os	=	"Mac";
		} else if(user_agent.indexOf("Win") > -1) {
			os	=	"Windows";
		} else if(user_agent.indexOf("Linux") > -1) {
			os	=	"Linux";
		} else if(user_agent.indexOf("Unix") > -1 || user_agent.indexOf("X11") > -1) {
			os	=	"Unix";
		} else {
			os	=	"Others";
		}
		
		if(os.equals("Mac")) {
			
			if(user_agent.indexOf("iPhone") > -1) {
				/*if(user_agent.indexOf("OS4") > -1) osInfo="iOS 4"; 
				else if(user_agent.indexOf("OS5") > -1) osInfo="iOS 5"; 
				else if(user_agent.indexOf("OS6") > -1) osInfo="iOS 6"; 
				else if(user_agent.indexOf("OS7") > -1) osInfo="iOS 7"; 
				else if(user_agent.indexOf("OS8") > -1) osInfo="iOS 8";
				else if(user_agent.indexOf("OS9") > -1) osInfo="iOS 9";
				else if(user_agent.indexOf("OS10") > -1) osInfo="iOS 10";
				else if(user_agent.indexOf("OS11") > -1) osInfo="iOS 11";
				else*/
					osInfo	=	"iPhone";
			} else if( user_agent.indexOf("iPad") > -1) {
				osInfo	=	"iPad";
			} else {
				/*if(user_agent.indexOf("MacOSX10_1") > -1 ||user_agent.indexOf("MacOSX10.1") > -1) osInfo="Mac OS X Puma"; 
				else if(user_agent.indexOf("MacOSX10_2") > -1 ||user_agent.indexOf("MacOSX10.2") > -1) osInfo="Mac OS X Jaguar";
				else if(user_agent.indexOf("MacOSX10_3") > -1 ||user_agent.indexOf("MacOSX10.3") > -1) osInfo="Mac OS X Panther"; 
				else if(user_agent.indexOf("MacOSX10_4") > -1 ||user_agent.indexOf("MacOSX10.4") > -1) osInfo="Mac OS X Tiger"; 
				else if(user_agent.indexOf("MacOSX10_5") > -1 ||user_agent.indexOf("MacOSX10.5") > -1) osInfo="Mac OS X Leopard"; 
				else if(user_agent.indexOf("MacOSX10_6") > -1 ||user_agent.indexOf("MacOSX10.6") > -1) osInfo="Mac OS X Snow Leopard"; 
				else if(user_agent.indexOf("MacOSX10_7") > -1 ||user_agent.indexOf("MacOSX10.7") > -1) osInfo="Mac OS X Lion"; 
				else if(user_agent.indexOf("MacOSX10_8") > -1 ||user_agent.indexOf("MacOSX10.8") > -1) osInfo="Mac OS X Mountain Lion"; 
				else if(user_agent.indexOf("MacOSX10_9") > -1 ||user_agent.indexOf("MacOSX10.9") > -1) osInfo="Mac OS X Mavericks"; 
				else if(user_agent.indexOf("MacOSX10_10") > -1 ||user_agent.indexOf("MacOSX10.10") > -1) osInfo="Mac OS X Yosemite";
				else if(user_agent.indexOf("MacOSX10_11") > -1 ||user_agent.indexOf("MacOSX10.11") > -1) osInfo="Mac OS X El Capitan";
				else if(user_agent.indexOf("MacOSX10_12") > -1 ||user_agent.indexOf("MacOSX10.12") > -1) osInfo="macOS Sierra";
				else if(user_agent.indexOf("MacOSX10_12") > -1 ||user_agent.indexOf("MacOSX10.12") > -1) osInfo="macOS High Sierra";
				else*/
					osInfo	=	"Mac OS X";
			}
		} else if (os.equals("Windows")) {
			
			if (user_agent.indexOf("WindowsNT4.0") > -1) {
				osInfo	=	"Microsoft Windows NT 4.0";
			} else if (user_agent.indexOf("WindowsNT5.0") > -1) {
				osInfo	=	"Windows 2000";
			} else if (user_agent.indexOf("WindowsNT5.1") > -1) {
				osInfo	=	"Windows XP";
			} else if (user_agent.indexOf("WindowsNT5.2") > -1) {
				osInfo	=	"Windows 2003";
			} else if (user_agent.indexOf("WindowsNT6.0") > -1) {
				osInfo	=	"Windows Vista/Server 2008";
			} else if (user_agent.indexOf("WindowsNT6.1") > -1) {
				osInfo	=	"Windows 7";
			} else if (user_agent.indexOf("WindowsNT6.2") > -1) {
				osInfo	=	"Windows 8";
			} else if (user_agent.indexOf("WindowsNT6.3") > -1) {
				osInfo	=	"Windows 8.1";
			} else if (user_agent.indexOf("WindowsNT6.4") > -1 || user_agent.indexOf("WindowsNT10.0") > -1) {
				osInfo	=	"Windows 10";
			} else if (user_agent.indexOf("Xbox") > -1) {
				osInfo	=	"Xbox";
			} else {
				osInfo	=	"Others";
			}
		} else if (os.equals("Linux")) {
			if(user_agent.indexOf("Android") > -1) {
				osInfo	=	"Android";
			} else if (user_agent.indexOf("Ubuntu") > -1) {
				osInfo	=	"Ubuntu";
			} else if (user_agent.indexOf("BlackBerry") > -1) {
				osInfo	=	"BlackBerry";
			} else if (user_agent.indexOf("PSP") > -1 || user_agent.indexOf("PS2") > -1 || user_agent.indexOf("PLAYSTATION") > -1) {
				osInfo	=	"PlayStation";
			} else {
				osInfo	=	"Others";
			}
		} else {
			osInfo	=	os;
		}
		return osInfo;
	}
	
	/**
	 * 클라이언트(Client)의 웹브라우저 종류를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String webKind 웹브라우저 종류
	 * @exception Exception
	*/
	public static String getClientBrowserKind(HttpServletRequest request) throws Exception {

		String user_agent = request.getHeader("user-agent").toLowerCase();
		
		// 웹브라우저 종류 조회
		String webKind = "";
		
		if (user_agent != null) {
			
			if ((user_agent.indexOf("iphone") > -1 || user_agent.indexOf("ipod") > -1 || user_agent.indexOf("ipad") > -1 || user_agent.indexOf("android") > -1 ) 
							&& user_agent.indexOf("mobile") > -1) {
				// 모바일 웹
			   webKind = "Mobile Web";
			} else if (user_agent.indexOf("trident") > -1 || user_agent.indexOf("msie") > -1) {
				// Internet Explore
				webKind = "Internet Explorer";
			} else if (user_agent.indexOf("chrome") > -1 && user_agent.indexOf("safari") > -1) {
				// Chrome
				webKind = "Chrome";
			} else if (user_agent.indexOf("safari") > -1) {
				// Chrome
				webKind = "Safari";
			} else if (user_agent.indexOf("firefox") > -1) {
				// Firefox
				webKind = "Firefox";
			} else if (user_agent.indexOf("opr") > -1 || user_agent.indexOf("opera") > -1) {
				// Opera
				webKind = "Opera";
			} else if (user_agent.indexOf("netscape") > -1) {
				// Netscape
				webKind = "Netscape";
			}else {
				webKind = "etc";
			}
		} else {
			webKind = "etc";
		}
		return webKind;
	}
	/**
	 * 클라이언트(Client)의 기기 종류를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String deviceKind 기기 종류
	 * @exception Exception
	*/
	public static String getClientDeviceKind(HttpServletRequest request) throws Exception {

		String user_agent = request.getHeader("user-agent").toLowerCase();
		
		// 기기 종류 조회
		String deviceKind	=	"";
		if(user_agent.indexOf("mobile") > -1) {
			deviceKind	=	"mobile";
		} else {
			deviceKind	=	"pc";
		}

		return deviceKind;
	}
	
	public static String alertClose(final ModelMap model, String msg) {
		model.addAttribute("message", msg);
		return "/kr/_inc/alertClose";
	}

	public static String alertMove(final ModelMap model, String msg, String moveUrl) {
		model.addAttribute("message", msg);
		model.addAttribute("returnUrl", moveUrl);
		return "/kr/_inc/alertMove";
	}

	public static String alertMoveRedirect(final ModelMap model, String msg, String moveUrl) {
		model.addAttribute("message", msg);
		model.addAttribute("returnUrl", moveUrl);
		return "redirect:/kr/_inc/alertMove.do";
	}
	
	/**
	 * 모든 HTML 태그를 제거하고 반환한다.
	 * 	진우석
	 * @param html
	 * @throws Exception  
	 */
	public static String removeTag(String html) throws Exception {
		return html.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "");
	}

	public static String getString(HashMap m, String k) {
		if(m != null) {
			Object o = m.get(k);
			if(o != null) {
				return o.toString();
			}
		}
		return "";
	}

	public static String getString(EgovMap m, String k) {
		if(m != null) {
			Object o = m.get(k);
			if(o != null) {
				return o.toString();
			}
		}
		return "";
	}

	public static int getInt(HashMap m, String k) {
		String s = getString(m, k);
		int v = 0;
		if(!s.equals("")) {
			try {
				v = Integer.parseInt(s);
			}
			catch(Exception e) {
				v = 0;
			}
		}
		return v;
	}

	public static int getInt(EgovMap m, String k) {
		String s = getString(m, k);
		int v = 0;
		if(!s.equals("")) {
			try {
				v = Integer.parseInt(s);
			}
			catch(Exception e) {
				v = 0;
			}
		}
		return v;
	}

	public static double getDouble(EgovMap m, String k) {
		String s = getString(m, k);
		double v = 0;
		if(!s.equals("")) {
			try {
				v = Double.parseDouble(s);
			}
			catch(Exception e) {
				v = 0;
			}
		}
		return v;
	}

	public static int getIntPlus1(EgovMap m, String k) {
		return getInt(m, k) + 1;
	}
	
	public static String getTimeStr(int i) {
		int s = i;
		int m = (s - (s % 60)) / 60;
		s = s % 60;

		int h = (m - (m % 60)) / 60;
		m = m % 60;
		
		String v = "";
		if(h > 0) {
			v += h + "시간 ";
		}

		if(m > 0) {
			v += m + "분 ";
		}
		
		if(s > 0) {
			v += s + "초 ";
		}
		return v.substring(0, v.length());
	}

	public static ArrayList<String> getArrayListString(String[] values) {
		if(values != null) {
			ArrayList<String> idxs = new ArrayList<String>();
			for(int i=0; i<values.length; i++) {
				idxs.add(values[i]);
			}
			return idxs;
		}
		else {
			return null;
		}
	}
	
	public static boolean getExternalRefererChk (HttpServletRequest request) {
		boolean result = false;
		
		String siteUrl = EgovProperties.getProperty("Globals.siteUrl");
		String refererUrl = (request.getHeader("Referer") != null) ? request.getHeader("Referer") : "";
		
		if(!refererUrl.contains(siteUrl)) {
			result = true;
		}
		
		return result;
	}
	
	public static Cookie createCookie(String name, String value) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expirationDateTime = now.plusMonths(1);
        
        Date expirationDate = Date.from(expirationDateTime.atZone(ZoneId.systemDefault()).toInstant());
        
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge((int) (expirationDate.getTime() - System.currentTimeMillis()) / 1000);
        cookie.setPath("/");
        
        return cookie;
    } 
	
	public static String getCookie(HttpServletRequest req, String key_name) {
		Cookie[] getCookie = req.getCookies();
		String value = "";
		if(getCookie != null) {
			for(int i=0; i<getCookie.length;i++) {
				Cookie c = getCookie[i];
				if(c.getName().equals(key_name)){
					value = c.getValue();
					break;
				}
			}
		}
		return value;
	}
	
	public static void deleteCookie(HttpServletResponse res, String key_name) {
		Cookie setCookie = new Cookie(key_name,null);	// 쿠키생성
		setCookie.setMaxAge(0);				// 기간 1년 
		setCookie.setPath("/");
		res.addCookie(setCookie);
	}
	
	/**
	 * AES256 암호화
	 * */
	public static String genAES256Enc(String str) {
		String key = "DSCRM-DEVICE-ENC-AES";
		String encStr = "";
		try {
			AES256Util aes256 = new AES256Util(key);
			URLCodec codec = new URLCodec();
			
			encStr = aes256.aesEncode(str);
			
		} catch(InvalidKeyException | UnsupportedEncodingException
				| NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException
				| IllegalBlockSizeException | BadPaddingException e){
			e.printStackTrace();
		}
		
		return encStr;
	}
	
	/**
	 * AES256 복호화
	 * @throws EncoderException 
	 * */
	public static String degenAES256Enc(String str) throws EncoderException {
		String key = "DSCRM-DEVICE-ENC-AES";
		String encStr = "";
		try {
			AES256Util aes256 = new AES256Util(key);
			//URLCodec codec = new URLCodec();
			
			//encStr = codec.encode(AES256Util.aesEncode(str));
			encStr = aes256.aesDecode(str);
			
		} catch(InvalidKeyException | UnsupportedEncodingException
				| NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException
				| IllegalBlockSizeException | BadPaddingException e){
			e.printStackTrace();
		}
		
		return encStr;
	}
	
	/**
	 * 모든 파라메터 출력
	 * */
	public static void getAllparams(HttpServletRequest re) {
		Enumeration params = re.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +re.getParameter(name));
		}
		System.out.println("----------------------------");
	}
}