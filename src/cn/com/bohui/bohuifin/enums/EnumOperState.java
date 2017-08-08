package cn.com.bohui.bohuifin.enums;

/**
 * Created by scorpioyoung on 2017/7/26 0026.
 */
public enum EnumOperState {

    DRAFT_BOX(1),
    WAITING_FOR_START(2),
    TO_RAISE(3),
    IS_INVESTING(4),
    INVESTMENT_OVER(5);

    private int value;

    private EnumOperState(int value) {
        this.value = value;
    }

    public int value() {
        return this.value;
    }
}
