package cn.com.bohui.bohuifin.util;

import java.text.DecimalFormat;

/**
 * Created by scorpioyoung on 2017/9/1 0001.
 */
public class NumberUtil {

    private static NumberUtil numberUtil = null;

    private DecimalFormat decimalFormat = null;

    private NumberUtil() {

    }

    public static NumberUtil getInstance() {
        if (numberUtil == null) {
            numberUtil = new NumberUtil();
        }
        return numberUtil;
    }

    public double numberFormatByDigit(Double number, int digit) throws Exception {
        String[] split = number.toString().split("\\.");
        if (digit == 0) {
            return Long.parseLong(split[0]);
        }
        if (split[1].length() < digit) {
            return number;
        }
        StringBuilder sb = new StringBuilder("#.");
        for (int i = 0; i < digit; i++) {
            sb.append("0");
        }
        decimalFormat = new DecimalFormat(sb.toString());
        String formatStr = decimalFormat.format(number);
        return Long.parseLong(formatStr);
    }

}
