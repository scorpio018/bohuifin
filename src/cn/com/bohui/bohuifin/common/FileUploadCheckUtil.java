package cn.com.bohui.bohuifin.common;

import cn.com.bohui.bohuifin.consts.SystemConst;
import org.springframework.web.multipart.MultipartFile;

import javax.util.zz.FileDeal;

public class FileUploadCheckUtil {

    private static String[] exts = null;

    public static String checkFileCanUpload(MultipartFile file) throws Exception {
        String result = null;
        if (!file.isEmpty()) {

            result = checkFileSizeCanUpload(file);
            if (result != null) {
                return result;
            }

            result = checkFileNameCanUpload(file);
            if (result != null) {
                return result;
            }
            result = checkFileExtCanUpload(file);
            if (result != null) {
                return result;
            }
        }
        return null;
    }

    /**
     * 检查文件大小是否可以上传
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static String checkFileSizeCanUpload(MultipartFile file) throws Exception {
        if (file.getSize() > SystemConst.ATT_MAX_SIZE) {
            return "上传文件【" + file.getName() + "】的文件大小超过系统规定最大值";
        } else {
            return null;
        }
    }

    public static String checkFileNameCanUpload(MultipartFile file) throws Exception {
        String name = file.getOriginalFilename();
        if (name.startsWith("../")) {
			return "上传文件的命名非法，不允许上传";
        }

        return null;
    }

    /**
     * 检查文件类型是否可以上传
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static String checkFileExtCanUpload(MultipartFile file) throws Exception {
        if (exts == null) {
            exts = SystemConst.INFO_FILE_TYPE.split(" ");
        }
        String fileName = file.getOriginalFilename();
        String extName = FileDeal.getFileExtName(fileName);
//		String extName = fileName.substring(fileName.lastIndexOf("."), fileName.length());
        for (String ext : exts) {
            if (extName.equalsIgnoreCase(ext)) {
                return null;
            }
        }
        return "上传文件【" + fileName + "】的扩展名不允许上传";
    }

}
