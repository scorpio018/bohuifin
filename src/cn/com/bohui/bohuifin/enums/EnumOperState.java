package cn.com.bohui.bohuifin.enums;

/**
 * Created by scorpioyoung on 2017/7/26 0026.
 */
public enum EnumOperState {
    // 草稿箱
    DRAFT_BOX(1),
    // 等待开始
    WAITING_FOR_START(2),
    // 募集中
    TO_RAISE(3),
    // 正在投资
    IS_INVESTING(4),
    // 投资结束
    INVESTMENT_OVER(5);

    private int value;

    private EnumOperState(int value) {
        this.value = value;
    }

    public int value() {
        return this.value;
    }
}
