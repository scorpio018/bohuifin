package cn.com.bohui.bohuifin.enums;

/**
 * Created by yangyang on 2017/6/30 0030.
 */
public enum EnumMenu {
    IS_MENU("1"), IS_NOT_MENU("2");

    private String value;

    private EnumMenu(String value) {
        this.value = value;
    }

    public String value() {
        return this.value;
    }
}
