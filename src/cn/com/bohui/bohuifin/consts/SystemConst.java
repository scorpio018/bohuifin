package cn.com.bohui.bohuifin.consts;

import java.io.File;

/**
 * Created by Administrator on 2017/4/27 0027.
 */
public class SystemConst {

    public static String BASE_PATH = "http://exam.enorth.com.cn:9000/";
    public static String STATIC_PATH = "http://exam.enorth.com.cn:9000/upload/";

    public static String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
    public static String DEFAULT_DATETIME_PATTERN = "yyyy-MM-dd HH:mm";

    public static int DEPT_MAX_LEVEL = 6;
    public static int DEPT_SPAN = 3;

    public static String SYSTEM_NAME = "博汇金服";

    public static String BASE_PATH_HTTPS = "";
    /**
     * 系统加密种子，生成种子
     */
    public static String ENCRYPT_SEED = "j348u43nu43g7y6398fnj02";

    /**
     * 附件最大字节数
     */
    public static int ATT_MAX_SIZE = 10485760;

    /**
     * 可上传附件扩展名，多个之间用空格分隔
     */
    public static String ATT_FILE_TYPE = ".jpg .jpeg .gif .png";
    public static String INFO_FILE_TYPE = ".jpg .jpeg .gif .png";
    public static String HEAD_IMG_ROOTDIR = "D:" +  File.separator + "my_workspace" +  File.separator + "bohuifin" +  File.separator + "out" +  File.separator + "artifacts" +  File.separator + "bohuifin_war_exploded" +  File.separator + "upload";
    public static int FILE_SPLIT_NUM = 7;

    /**
     * 每次上传文件最多个数
     */
    public static int ATT_FILE_COUNT = 3;

    /**
     * 邮件账号用户名
     */
    public static String MAIL_USER = "";

    /**
     * 邮件标题
     */
    public static String MAIL_TITLE = "";

    /**
     * 邮件内容模板
     */
    public static String MAIL_TEMPLATE_CONTENT = "";
    public static String MAIL_TEMPLATE_CONTENT_MULTI = "";

    /**
     * 邮件SMTP服务器端口
     */
    public static int MAIL_PORT = 25;

    /**
     * 邮件SMTP服务器密码
     */
    public static String MAIL_PASSWORD = "";

    /**
     * 邮件SMTP服务器IP
     */
    public static String MAIL_HOST = "";

    /**
     * 邮件发件人
     */
    public static String MAIL_FROM = "";

    // 数据状态正常标识
    public static int STATE_DEFAULT = 1;
    // 数据状态删除标识
    public static int STATE_DELETE = -1;
    // 数据状态关闭标识
    public static int STATE_CLOSE = -2;
    // 数据状态隐藏标识
    public static int STATE_HIDDEN = -3;
    // 数据状态锁定标识
    public static int STATE_LOCK = 100;
    // 数据状态通过标识
    public static int STATE_PASS = 2000;
    // 数据状态拒绝标识
    public static int STATE_REFUSE = -2000;

    // 分页的一页显示多少条数据的默认值
    public static int PAGE_SIZE_DEFAULT = 15;

    // 部门是否可接受分拨
    public static int ACCEPT_DELEGATE_YES = 1;

    public static int ACCEPT_DELEGATE_NO = 0;
    /**
     * 产品的状态的时间至少有一个没有设置
     */
    public static int IS_OPER_INTERVAL_SET_UP_NO = 0;
    /**
     * 产品的每一个状态的时间都已经设置
     */
    public static int IS_OPER_INTERVAL_SET_UP_YES = 1;

    public static String MD5_TEMP = "bohuifin_tmp";

    public static long ROOT_DEPT_ID = 0;

    public static long ROOT_CATEGORY_ID = 0;

    public static int AJAX_SUCCESS_CODE = 1;

}
