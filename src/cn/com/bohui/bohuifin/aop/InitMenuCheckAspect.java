package cn.com.bohui.bohuifin.aop;

import org.aspectj.lang.JoinPoint;

public abstract class InitMenuCheckAspect {
	
	// 只在目标方法成功完成后才会被植入
	public abstract void saveMenu(JoinPoint jp, Object rvt) throws Exception;
}
