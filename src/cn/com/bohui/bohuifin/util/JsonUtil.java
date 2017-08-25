package cn.com.bohui.bohuifin.util;

import cn.com.bohui.bohuifin.annotation.SharedPreSaveAnnotation;
import com.google.gson.JsonObject;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

/**
 * Created by scorpioyoung on 2017/8/16 0016.
 */
public class JsonUtil {

    /**
     * 将对象以注解中定义的key（如果没有定义，则使用变量名）作为json的key，以保存的变量作为json的value进行返回
     *
     * @param ob
     * @return
     */
    public static JsonObject saveObjectToJson(Object ob) {
        JsonObject jo = new JsonObject();
        Class<?> c = ob.getClass();
//		String clazzName = c.getName();
        Field[] fields = c.getDeclaredFields();
        Method[] declaredMethods = c.getDeclaredMethods();
        int methodLength = declaredMethods.length;
        List<String> methodNames = new ArrayList<String>();
        for (int i = 0; i < methodLength; i++) {
            methodNames.add(declaredMethods[i].getName());
        }
        for (Field field : fields) {
            if (field.isAnnotationPresent(SharedPreSaveAnnotation.class)) {
                SharedPreSaveAnnotation annotation = field.getAnnotation(SharedPreSaveAnnotation.class);
                /*String name = annotation.name();
                if (name.equals("")) {
					name = clazzName;
				}*/
                String fieldName = field.getName();
                String key = annotation.key();
                if (key.equals("")) {
                    key = fieldName;
                }

                Class<?> type = field.getType();
                String getterName;
                if (type == Boolean.class || type == boolean.class) {
                    if (fieldName.substring(0, 2).equals("is")) {
                        getterName = "get" + fieldName.substring(2, 3).toUpperCase(Locale.CHINA) + fieldName.substring(3);
                    } else {
                        getterName = "get" + fieldName.substring(0, 1).toUpperCase(Locale.CHINA) + fieldName.substring(1);
                    }
                } else {
                    getterName = "get" + fieldName.substring(0, 1).toUpperCase(Locale.CHINA) + fieldName.substring(1);
                }

                if (!methodNames.contains(getterName)) {
                    continue;
                }
                Method method = null;
                Object value = null;
                try {
                    method = ob.getClass().getMethod(getterName);
                    value = method.invoke(ob);
                } catch (NoSuchMethodException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                }

                if (checkIsString(type) || checkIsInteger(type) || checkIsLong(type) || checkIsDouble(type) || checkIsBoolean(type)) {
//					SharedPreUtil.put(context, name, key, value);
                    jo.addProperty(key, value.toString());
                } else {
                    if (checkIsList(type)) {
                        System.out.println("目前尚未支持List方法");
                        /*List list = (List) value;
                        int length = list.size();
						// 获得List集合中泛型的对象
						for (int i = 0; i < length; i++) {
							saveObject(list.get(i), context);
						}*/
                    } else if (checkIsMap(type)) {
                            System.out.println("目前尚未支持Map方法~");
                    } else if (checkIsSet(type)) {
                            System.out.println("目前尚未支持Set方法~");
                    } else if (type.isArray()) {
                            System.out.println("目前尚未支持数组方法~");
                    } else {
                        JsonObject subJo = saveObjectToJson(value);
                        jo.add(key, subJo);
                    }
                }
            }
        }
        return jo;
    }

    private static boolean checkIsString(Class<?> type) {
        if (type == String.class) {
            return true;
        } else if (type == CharSequence.class || type == char.class) {
            return true;
        } else if (type == Byte.class || type == byte.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsInteger(Class<?> type) {
        if (type == Integer.class || type == int.class) {
            return true;
        } else if (type == Short.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsLong(Class<?> type) {
        if (type == Long.class || type == long.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsDouble(Class<?> type) {
        if (type == Double.class || type == double.class) {
            return true;
        } else if (type == Float.class || type == float.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsBoolean(Class<?> type) {
        if (type == Boolean.class || type == boolean.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsList(Class<?> type) {
        if (type == List.class) {
            return true;
        } else if (type == ArrayList.class) {
            return true;
        } else if (type == LinkedList.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsMap(Class<?> type) {
        if (type == Map.class) {
            return true;
        } else if (type == HashMap.class) {
            return true;
        } else if (type == LinkedHashMap.class) {
            return true;
        } else if (type == ConcurrentHashMap.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsSet(Class<?> type) {
        if (type == Set.class) {
            return true;
        } else if (type == HashSet.class) {
            return true;
        } else if (type == LinkedHashSet.class) {
            return true;
        } else if (type == ConcurrentSkipListSet.class) {
            return true;
        } else {
            return false;
        }
    }

    private static boolean checkIsFile(Class<?> type) {
        if (type == File.class) {
            return true;
        } else {
            return false;
        }
    }
}
