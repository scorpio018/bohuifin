package cn.com.bohui.bohuifin.enums;

/**
 * Created by yangyang on 2017/6/26 0026.
 */
public enum EnumAuthGroup {

    MANAGER(2), USER(3), DEALER(4);

    private int value = 0;

    EnumAuthGroup(int value) {
        this.value = value;
    }

    public int value() {
        return this.value;
    }
}
