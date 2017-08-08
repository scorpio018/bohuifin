package cn.com.bohui.bohuifin.common;

import cn.com.bohui.bohuifin.bean.BaseUserBean;
import cn.com.bohui.bohuifin.bean.UsersBean;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import org.apache.log4j.Logger;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.util.zz.FileDeal;
import javax.util.zz.StringUtil;
import javax.util.zz.web.WebUtil;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ResourceBundle;


public class Tools {

    private static Logger logger = Logger.getLogger(Tools.class);

    private static SimpleDateFormat sdf = new SimpleDateFormat(
            SystemConst.DEFAULT_DATE_PATTERN);
    private static SimpleDateFormat sdf2 = new SimpleDateFormat(
            SystemConst.DEFAULT_DATETIME_PATTERN);

    public Tools() {
    }

    public static String formatDate(Date d, String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(d);
    }

    public static String formatDate(Date d) {
        if (d == null)
            return "";
        return sdf.format(d);
    }

    public static String formatDatetime(Date d) {
        if (d == null)
            return "";
        return sdf2.format(d);
    }

    public static Date unformatDate(String datestr) {
        if (StringUtil.isEmpty(datestr))
            return new Date();

        try {
            return sdf.parse(datestr);
        } catch (ParseException ex) {
            logger.error(ex);
            return null;
        }
    }

    public static Date unformatDateTime(String datestr) {
        if (StringUtil.isEmpty(datestr))
            return new Date();

        try {
            return sdf2.parse(datestr);
        } catch (ParseException ex) {
            logger.error(ex);
            return null;
        }
    }

    public static String parseNullStr(String str) {
        return str == null ? "" : str;
    }

    public static String getIp(HttpServletRequest request) {
        String realip = request.getHeader("X-Real-IP");
        if (StringUtil.isEmpty(realip)) {
            realip = request.getHeader("X-Forwarded-For");
            if (StringUtil.isEmpty(realip)) {
                return request.getRemoteAddr();
            } else {
                return realip;
            }
        } else {
            return realip;
        }
    }

    /**
     * 设置用户的salt和密码
     *
     * @param user
     * @param password
     * @throws UnsupportedEncodingException
     */
    public static void setUserSaltAndPassword(BaseUserBean user, String password)
            throws UnsupportedEncodingException {
        if (user == null) {
            return;
        }
        String salt = "";
        if (StringUtil.isEmpty(user.getSalt())) {
            salt = StringUtil.getRandomString(10, StringUtil.SET_ALPHABET_NUMBER);
            user.setSalt(salt);
        } else {
            salt = user.getSalt();
        }
        user.setPwd(encodePassword(password, salt));
    }

    public static String encodePassword(String password, String salt) throws UnsupportedEncodingException {
        String pwdMD5 = StringUtil.MD5(password, "UTF-8");
        return StringUtil.MD5(pwdMD5 + salt, "UTF-8");
    }

    public static void main(String[] args) {
        UsersBean usersBean = new UsersBean();
        try {
            Tools.setUserSaltAndPassword(usersBean, "111111");
            System.out.print(usersBean.getPwd() + ":" + usersBean.getSalt());
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    public static void loadSysParam(ServletContext sc) throws FileNotFoundException, IOException {
        ResourceBundle config = ResourceBundle.getBundle("config/main");
        String systemDir = config.getString("system_dir");
        SystemConst.ATT_FILE_COUNT = Integer.parseInt(config.getString("att_file_count"));
//		SystemConst.ATT_FILE_ROOTURL = config.getString("att_file_rooturl");
        SystemConst.ATT_FILE_TYPE = config.getString("att_file_type");
        SystemConst.INFO_FILE_TYPE = config.getString("info_file_type");
        SystemConst.ATT_MAX_SIZE = Integer.parseInt(config.getString("att_max_size"));
        SystemConst.BASE_PATH = config.getString("web_root");
        if (config.containsKey("web_root_https") && !StringUtil.isEmpty(config.getString("web_root_https"))) {
            SystemConst.BASE_PATH_HTTPS = config.getString("web_root_https");
        } else {
            SystemConst.BASE_PATH_HTTPS = SystemConst.BASE_PATH;
        }

        SystemConst.DEFAULT_DATE_PATTERN = config.getString("date_pattern");
        SystemConst.DEFAULT_DATETIME_PATTERN = config.getString("datetime_pattern");
        SystemConst.DEPT_MAX_LEVEL = Integer.parseInt(config.getString("dept_max_level"));
        SystemConst.DEPT_SPAN = Integer.parseInt(config.getString("dept_span"));

        SystemConst.ENCRYPT_SEED = config.getString("encrypt_seed");
        SystemConst.MAIL_FROM = config.getString("mail_from");
        SystemConst.MAIL_HOST = config.getString("mail_host");
        SystemConst.MAIL_PASSWORD = config.getString("mail_password");
        SystemConst.MAIL_PORT = Integer.parseInt(config.getString("mail_port"));

        // 读取邮件模板
        File mailTemplateFile = WebUtil.getFileInClasses(sc, "config/mail_template.html");
        byte[] content = FileDeal.readBinaryFile(mailTemplateFile);
        SystemConst.MAIL_TEMPLATE_CONTENT = new String(content, "GBK");

        SystemConst.MAIL_TITLE = config.getString("mail_title");
        SystemConst.MAIL_USER = config.getString("mail_user");
        SystemConst.SYSTEM_NAME = config.getString("system_name");

        // 读取系统开关
        ResourceBundle option = ResourceBundle.getBundle("config/option");
        if (option.containsKey("option_accesslog")) {
            SysOption.ENABLE_ACCESS_LOG = option.getString("option_accesslog").equalsIgnoreCase("on");
        }

        if (option.containsKey("option_info")) {
            SysOption.ENABLE_INFO = option.getString("option_info").equalsIgnoreCase("on");
        }

        if (option.containsKey("option_entrust")) {
            SysOption.ENABLE_ENTRUST = option.getString("option_entrust").equalsIgnoreCase("on");
        }

        if (option.containsKey("option_ucenter")) {
            SysOption.ENABLE_UCENTER = option.getString("option_ucenter").equalsIgnoreCase("on");
        }

        if (option.containsKey("option_report")) {
            SysOption.ENABLE_REPORT = option.getString("option_report").equalsIgnoreCase("on");
        }

    }

    private static int getCodeSeed() {
        int sum = 0;
        for (char c : SystemConst.ENCRYPT_SEED.toCharArray()) {
            sum += c;
        }
        int codeSeed = sum % 10000;
        return codeSeed;
    }

    /**
     * 日期友好化显示
     *
     * @param ms
     * @param sketchy 是否粗略显示
     * @return
     */
    public static String getTimeDes(long ms, boolean sketchy, boolean justShowDay) {
        int ss = 1000;
        int mi = ss * 60;
        int hh = mi * 60;
        int dd = hh * 24;

        long day = ms / dd;
        long hour = (ms - day * dd) / hh;
        long minute = (ms - day * dd - hour * hh) / mi;
        long second = (ms - day * dd - hour * hh - minute * mi) / ss;
        long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;

        StringBuilder str = new StringBuilder();
        if (day > 0) {
            str.append(day).append("天,");
        }
        if (!justShowDay) {
            if (hour > 0) {
                str.append(hour).append("小时,");
            }
        }
        if (!sketchy) {
            if (minute > 0) {
                str.append(minute).append("分钟,");
            }
//	 	    if(second>0){
//	 	        str.append(second).append("秒,");
//	 	    }
//	 	    if(milliSecond>0){
//	 	        str.append(milliSecond).append("毫秒,");
//	 	    }
        }
        if (str.length() > 0) {
            str = str.deleteCharAt(str.length() - 1);
        }
        return str.toString();
    }

    /**
     * 文件大小友好化显示
     *
     * @param fileS
     * @return
     */
    public static String FormetFileSize(long fileS) {
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "K";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "M";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "G";
        }
        return fileSizeString;
    }

    private static boolean isValidFile(String filename, String[] extNames) {
        if (StringUtil.isEmpty(filename)) {
            return false;
        }
        if (extNames == null || extNames.length == 0) {
            return false;
        }
        for (String ext : extNames) {
            if (filename.toLowerCase().endsWith(ext.toLowerCase())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 返回是否是可以上传的附件文件
     *
     * @param filename 附件文件名
     * @return
     */
    public static boolean isValidAttFile(String filename) {
        return isValidFile(filename, StringUtil.splitStr(SystemConst.ATT_FILE_TYPE, " "));
    }

    /**
     * 返回是否是可以上传的新闻附件文件
     *
     * @param filename 文件名
     * @return
     */
    public static boolean isValidInfoFile(String filename) {
        return isValidFile(filename, StringUtil.splitStr(SystemConst.INFO_FILE_TYPE, " "));
    }

    /**
     * 通过文件扩展名判断是否为图片文件
     *
     * @param filename
     * @return
     */
    public static boolean isImage(String filename) {
        if (StringUtil.isEmpty(filename)) {
            return false;
        }
        filename = filename.trim().toLowerCase();
        return filename.endsWith(".jpg") || filename.endsWith(".jpeg")
                || filename.endsWith(".png") || filename.endsWith(".gif");
    }

    /**
     * Data Link Escape Character (sql转义字符)
     */
    public static String DLEC(String data) {
        data = StringUtil.replace(data, "%", "\\%");
        data = StringUtil.replace(data, "_", "\\_");
        data = StringUtil.replace(data, "'", "\\'");
//		data = data.replaceAll("", "\\");
        return data;
    }

    public static void createFile(File file, boolean isFile) {
        File parentFile = file.getParentFile();
        if (!parentFile.exists() || !parentFile.isDirectory()) {
            createFile(parentFile, false);
        }
        if (isFile) {
            try {
                boolean newFile = file.createNewFile();
                if (!newFile) {
                    throw  new RuntimeException(ErrorMsgConst.CREATE_FILE_ERROR);
                }
            } catch (IOException e) {
                throw new RuntimeException(ErrorMsgConst.CREATE_FILE_ERROR + ":" + e.getMessage());
            }
        } else {
            boolean mkdir = file.mkdir();
            if (!mkdir) {
                throw new RuntimeException(ErrorMsgConst.CREATE_DIR_ERROR);
            }
        }
    }

}
