package cn.com.bohui.bohuifin.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;

@Aspect
public class LogAspect extends InitMenuCheckDecorator {
	
	// 将切入表达式统一定义在一个方法下，便于修改
	@Pointcut("execution(* cn.com.bohui.bohuifin.controller.*.*Controller.*(..))")
	public void anyMethodAop() {}

	// 只在目标方法成功完成后才会被植入
	@AfterReturning(pointcut="anyMethodAop()",returning="rvt")
	public void saveMenu(JoinPoint jp, Object rvt) throws Exception {
		super.saveMenu(jp, rvt);
	}
	
	// 目标方法执行前植入
	/*@Before("anyMethodAop()")
	public void beforeMethodDo(JoinPoint jp) throws Exception {
		Object[] args = jp.getArgs();
//		System.out.println(args);
		System.out.println("before");
	}*/
	
	// Controller出现异常时会调用该方法（目标方法出现异常时植入）
	/*@AfterThrowing(pointcut="anyMethodAop()",throwing="ex")
	public void errorLog(Throwable ex) {
		System.out.println("afterThrowing:" + ex.getMessage());
	}*/
	
	// 不管目标方法如何结束，包括成功完成和遇到异常终止两种情况，它都会被植入
	/*@After("anyMethodAop()")
	public void afterMethodFinish(JoinPoint jp) throws Exception {
		Object[] args = jp.getArgs();
//		System.out.println(args);
		System.out.println("after");
	}*/
	
	/**
	 * 增强处理是功能比较强大的增强处理，它近似等于Before 和 AfterReturning的总和。
	 * 既可在执行目标方法之前织入增强动作，也可在执行目标方法之后织入增强动作。
	 * 甚至可以决定目标方法在什么时候执行，如何执行，更甚者可以完全阻止目标方法的执行。
	 * 可以改变执行目标方法的参数值，也可以改变执行目标方法之后的返回值
	 * 功能虽然强大，但通常需要在线程安全的环境下使用。因此，如果使用普通的Before、AfterReturning就能解决的问 题，就没有必要使用Around了。
	 * 如果需要目标方法执行之前和之后共享某种状态数据，则应该考虑使用Around。
	 * 尤其是需要使用增强处理阻止目标的执 行，或需要改变目标方法的返回值时，则只能使用Around增强处理了。
	 * 当定义一个Around增强处理方法时，该方法的第一个形参必须是 ProceedingJoinPoint 类型，在增强处理方法体内，
	 * 调用ProceedingJoinPoint的proceed方法才会执行目标方法------这就是@Around增强处理 可以完全控制目标方法执行时机、如何执行的关键；
	 * 如果程序没有调用ProceedingJoinPoint的proceed方法，则目标方法不会执行。
	 * 调用ProceedingJoinPoint的proceed方法时，还可以传入一个Object[ ]对象，该数组中的值将被传入目标方法作为实参。
	 * 如果传入的Object[ ]数组长度与目标方法所需要的参数个数不相等，或者Object[ ]数组元素与目标方法所需参数的类型不匹配，程序就会出现异常
	 * @param jp
	 * @return
	 * @throws Throwable
	 */
	/*@Around("anyMethodAop()")
	public Object aroundMethod(ProceedingJoinPoint jp) throws Throwable {
		System.out.println("around start");
		Object rvt = jp.proceed();
		System.out.println("around end,rvt:" + rvt.toString());
		return rvt;
	}*/
	
	
	public String initUrlParams(HttpServletRequest request) throws Exception {
		Enumeration<String> enu = request.getParameterNames();
		StringBuffer strBuf = new StringBuffer();
		while (enu.hasMoreElements()) {
			String paramName=(String)enu.nextElement();
			String paramValue = request.getParameter(paramName);
			if (paramValue.length() >= 100) {
				continue;
			}
			strBuf.append(paramName + "=" + paramValue + "&");
		}
		if (strBuf.length() == 0) {
			return strBuf.toString();
		} else {
			if (strBuf.length() > 300) {
				return strBuf.substring(0, 300);
			} else {
				return strBuf.substring(0, strBuf.length() - 1);
			}
		}
	}
	
}
