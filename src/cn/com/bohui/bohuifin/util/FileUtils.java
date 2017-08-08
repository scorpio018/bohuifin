package cn.com.bohui.bohuifin.util;

import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.SystemConst;
import org.springframework.web.multipart.MultipartFile;

import javax.util.zz.FileDeal;
import javax.util.zz.StringUtil;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;


public class FileUtils {

    public static byte XOR_CONST = 0x12;

    /**
     * 系统加密种子，生成办件查询码的种子
     */
    public static String ENCRYPT_SEED = "j348u43nu43g7y6398fnj02";

    /**
     * 把用splitFile方法分裂的文件组合起来
     *
     * @param file 原文件全路径
     * @param n    原文件被分裂的块数
     * @return
     * @throws FileNotFoundException
     * @throws IOException
     */
    public static byte[] mergeFile(File file, int n)
            throws FileNotFoundException, IOException {
        // File file = new File(pathfilename);
        // File parent = file.getParentFile();
        // String filename = file.getName();
        byte[] content = null;
        int len = 0;
        List<byte[]> temp = new ArrayList<byte[]>();
        for (int i = 0; i < n; i++) {
            // String fn = StringUtil.MD5(filename + i +
            // SystemConst.ENCRYPT_SEED,
            // "UTF-8");
            // File f = new File(parent, fn);
            File f = getTargetFilePath(file, i);
            byte[] b = FileDeal.readBinaryFile(f);
            temp.add(xorByteArray(b));
            len += b.length;
        }
        content = new byte[len];
        int j = 0;
        for (int i = 0; i < len; i++) {
            if (i % n == 0 && i > 1) {
                j++;
            }
            content[i] = temp.get(i % n)[j];
        }
        return content;
    }

    /**
     * 把指定的文件分裂为数个文件
     *
     * @param bs   文件的二进制内容
     * @param file 原文件全路径
     * @param n    分裂的个数
     * @throws FileNotFoundException
     * @throws IOException
     */
    public static void splitFile(byte[] bs, File file, int n)
            throws FileNotFoundException, IOException {
        // System.out.println(bs.length);
        List<byte[]> temp = new ArrayList<byte[]>();
        int len1 = bs.length % n;
        int len2 = n - len1;
        for (int i = 0; i < len1; i++) {
            temp.add(new byte[bs.length / n + 1]);
        }
        for (int i = 0; i < len2; i++) {
            temp.add(new byte[bs.length / n]);
        }
        int j = 0;
        for (int i = 0; i < bs.length; i++) {
            if (i % n == 0 && i > 1) {
                j++;
            }
            temp.get(i % n)[j] = bs[i];
        }

        // File file = new File(pathfilename);
        // File parent = file.getParentFile();
        // String filename = file.getName();
        for (int i = 0; i < temp.size(); i++) {
            // String fn = filename + i + SystemConst.ENCRYPT_SEED;
            // File f = new File(parent, StringUtil.MD5(fn, "UTF-8"));
            File f = getTargetFilePath(file, i);
            FileDeal.writeFile(f, xorByteArray(temp.get(i)), 1024);
        }
    }

    public static String saveFile(MultipartFile file) throws Exception {
        return saveFile(file, null);
    }

    public static String saveFile(MultipartFile file, String fileNameNoExt) throws Exception {
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH);
        int day = now.get(Calendar.DAY_OF_MONTH);
        String imgDirPath = year + File.separator + month + File.separator + day;
        String fileName;
        if (StringUtil.isEmpty(fileNameNoExt)) {
            fileName = UUID.randomUUID().toString().replaceAll("-", "") + FileDeal.getFileExtName(file.getOriginalFilename());
        } else {
            fileName = fileNameNoExt + FileDeal.getFileExtName(file.getOriginalFilename());
        }
        File dir = new File(SystemConst.HEAD_IMG_ROOTDIR, imgDirPath);
        File saveFile = new File(dir, fileName);
        Tools.createFile(saveFile, true);
        file.transferTo(saveFile);
        /*boolean copy = FileDeal.copy(file.getName(), saveFile.getAbsolutePath());
        if (!copy) {
            throw new Exception(ErrorMsgConst.COPY_FILE_ERROR);
        }*/
        return SystemConst.STATIC_PATH + imgDirPath + File.separator + fileName;
    }

    private static File getTargetFilePath(File file, int index)
            throws UnsupportedEncodingException {
        File parent = file.getParentFile();
        String filename = file.getName();
        String fn = StringUtil.MD5(filename + index + ENCRYPT_SEED,
                "UTF-8");
        fn = fn.toLowerCase();
        char[] ca = fn.toCharArray();
        String dir = "" + ca[0] + ca[1] + "/" + ca[2] + ca[3] + "/";
        File f = new File(parent, dir + fn);
        return f;
    }

    private static byte[] xorByteArray(byte[] content) {
        for (int i = 0; i < content.length; i++) {
            content[i] ^= XOR_CONST;
        }
        return content;
    }

}
