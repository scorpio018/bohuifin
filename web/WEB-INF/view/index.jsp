<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=SystemConst.SYSTEM_NAME%>
    </title>
    <link rel="stylesheet" type="text/css" href="<%=SystemConst.BASE_PATH%>css/ui.css"/>
</head>
<body>
<!-- head -->
<div class="head">
    <div class="header">
        <ul class="logo">
            <li><a href="#"><img src="<%=SystemConst.BASE_PATH%>images/index/logo_betterment.png" class="logo-img"
                                 alt=""/></a></li>
        </ul>
        <ul class="nav">
            <li><a href="#">首页</a></li>
            <li><a href="#">合买</a></li>
            <li><a href="#">财富论</a></li>
            <li><a href="#">封神榜</a></li>
            <li><a href="#">新手入门</a></li>
            <li><a href="#">成为交易员</a></li>
        </ul>
        <ul class="login">
            <li>
                <div class="language">
                    <a href="#" class="cn active">简体中文</a>
                    <a href="#" class="en">English</a>
                </div>
            </li>
            <c:choose>
                <c:when test="${sessionScope.userLogin eq null}">
                    <li><a href="<%=SystemConst.BASE_PATH%>login/userLogin?act=login" class="button flat">网站登录</a></li>
                    <li><a href="<%=SystemConst.BASE_PATH%>login/userLogin?act=regist" class="button sign-up">网站注册</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li><span>欢迎你，${sessionScope.userLogin.trueName}</span></li>
                </c:otherwise>
            </c:choose>

            <li class="mob-menu-btn"><a href="#" class="button flat menu"><i class="demo-icon icon-menu"></i></a></li>
        </ul>
    </div>
</div>

<!-- mob nav -->
<div class="mob-nav">
    <li><a href="#">首页</a></li>
    <li><a href="#">合买</a></li>
    <li><a href="#">财富论</a></li>
    <li><a href="#">封神榜</a></li>
    <li><a href="#">新手入门</a></li>
    <li><a href="#">成为交易员</a></li>
</div>

<!-- banner -->
<div class="main_visual">
    <div class="flicking_con">
        <div class="flicking_inner">
            <a href="javascript:">1</a>
            <a href="javascript:">2</a>
            <a href="javascript:">3</a>
            <a href="javascript:">4</a>
        </div>
    </div>
    <div class="main_image">
        <ul>
            <li><span class="span_img"
                      style="background-image: url(<%=SystemConst.BASE_PATH%>images/index/1.png);"></span></li>
            <li><span class="span_img"
                      style="background-image: url(<%=SystemConst.BASE_PATH%>images/index/2.png);"></span></li>
            <li><span class="span_img"
                      style="background-image: url(<%=SystemConst.BASE_PATH%>images/index/3.png);"></span></li>
            <li><span class="span_img"
                      style="background-image: url(<%=SystemConst.BASE_PATH%>images/index/4.png);"></span></li>
        </ul>
        <a href="javascript:;" id="btn_prev"></a>
        <a href="javascript:;" id="btn_next"></a>
    </div>
</div>

<!-- 四个特性 -->
<div class="features wrap">
    <ul>
        <li class="border">
            <a href="#">
                <img src="<%=SystemConst.BASE_PATH%>images/index/icon-features01.svg"/>
                <p class="h1">新手入门第一段</p>
                <p class="p">xinshourumendiyiduan</p>
            </a>
        </li>
        <li class="border">
            <a href="#">
                <img src="<%=SystemConst.BASE_PATH%>images/index/icon-features02.svg"/>
                <p class="h1">新手入门第二段</p>
                <p class="p">xinshourumendierduan</p>
            </a>
        </li>
        <li class="border">
            <a href="#">
                <img src="<%=SystemConst.BASE_PATH%>images/index/icon-features04.svg"/>
                <p class="h1">新手入门第三段</p>
                <p class="p">xinshourumendisanduan</p>
            </a>
        </li>
        <li>
            <a href="#">
                <img src="<%=SystemConst.BASE_PATH%>images/index/icon-features03.svg"/>
                <p class="h1">T*24投资机会</p>
                <p class="p">T*24touzijihui</p>
            </a>
        </li>
    </ul>
</div>

<!-- 合买项目+财富论  -->
<div class="project">
    <div id="main" class="cf">
        <div class="content">
            <div class="c-title">合买项目<a href="#"><span class="more">更多&gt;&gt;</span></a></div>
            <c:forEach items="${requestScope.products}" var="product">
                <!-- 合买项目单元 -->
                <div class="buy-item" style="margin-top:16.0px;">
                    <div class="item-left" style="position:relative;">
                        <div class="star level_stars">
                            <i class="demo-icon icon-star"></i><i class="demo-icon icon-star"></i><i
                                class="demo-icon icon-star"></i><i class="demo-icon icon-star-half-alt"></i>
                        </div>
                        <a href="#" title="">
                            <img class="photo" src="${product.dealerBean.headImg}" alt="">
                        </a>
                        <div class="user-name"><a href="#">${product.dealerBean.nickName}</a></div>
                    </div>
                    <div class="item-center">
                        <div style="margin-top:20px; padding-left:20px;">
                            <div style="float:left;">
                                <span class="radius loan_type_icon showTip L30 layer_tip_1 poshytip" title="${product.productTypeBean.description}">保本型</span>
                                <span class="radius product_icon">股票</span>
                            </div>
                            <a href="#" title="">
                                <div class="item-name">${product.productName}</div>
                            </a>
                            <div class="clear"></div>
                        </div>
                        <div>
                            <ul class="item-data-row item-title-row">
                                <li style="width:108px;">最高金额</li>
                                <li style="width:85px;">交易周期</li>
                                <li style="width:85px;">项目佣金</li>
                                <li style="width:102px;"> 止损值</li>
                            </ul>
                            <div class="blank_none"></div>
                            <ul class="item-data-row">
                                <li style="width:108px;"><span class="big">${product.projectAmount}</span>&nbsp;万元</li>
                                <li style="width:85px;">T+<span class="big">${product.tradingCycle}</span></li>
                                <li style="width:85px;"><span class="big">${product.managementCost}</span>&nbsp;%</li>
                                <li style="width:102px;"><span class="big">${product.stopLossValue}</span>&nbsp;%</li>
                            </ul>
                        </div>
                    </div>
                    <div class="item-right">
                        <div class="fund-ctext">
                            <div class="fund-money">可投金额:<span>${product.investableAmount}</span>元</div>
                        </div>
                        <button class="view-button bg_orange" onclick="#">${product.operStateBean.operStateName}</button>
                    </div>
                </div>
                <!-- 合买项目 结束 -->
            </c:forEach>
        </div>

        <!-- sildebar -->
        <div class="sidebar">
            <div class="c-title">股神说<a href="/forum"><span class="more">更多&gt;&gt;</span></a></div>
            <div class="gs-view">
                <!-- 股神说单元 -->
                <div class="view-item">
                    <div>
                        <a href="# title=" 股神在线的观点"><img class="view-head"
                                                         src="<%=SystemConst.BASE_PATH%>images/index/img-user2.png"
                                                         alt="股神在线"></a>
                        <div class="view-name-out">
                            <div class="view-user-name"><a href="#" title="">股神在线</a></div>
                            <div class="time-ago">3小时前</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="view-second-title"><a href="#">#一票定乾坤（5）#合买宣言</a></div>
                    <div class="view-content"><a href="#">一票定乾坤（5）</a></div>
                </div>
                <!-- 股神说单元 结束 -->

                <!-- 股神说单元 -->
                <div class="view-item">
                    <div>
                        <a href="# title=" 股神在线的观点"><img class="view-head"
                                                         src="<%=SystemConst.BASE_PATH%>images/index/img-user2.png"
                                                         alt="股神在线"></a>
                        <div class="view-name-out">
                            <div class="view-user-name"><a href="#" title="">股神在线</a></div>
                            <div class="time-ago">3小时前</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="view-second-title"><a href="#">#一票定乾坤（5）#合买宣言</a></div>
                    <div class="view-content"><a href="#">一票定乾坤（5）</a></div>
                </div>
                <!-- 股神说单元 结束 -->

                <!-- 股神说单元 -->
                <div class="view-item">
                    <div>
                        <a href="# title=" 股神在线的观点"><img class="view-head"
                                                         src="<%=SystemConst.BASE_PATH%>images/index/img-user2.png"
                                                         alt="股神在线"></a>
                        <div class="view-name-out">
                            <div class="view-user-name"><a href="#" title="">股神在线</a></div>
                            <div class="time-ago">3小时前</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="view-second-title"><a href="#">#一票定乾坤（5）#合买宣言</a></div>
                    <div class="view-content"><a href="#">一票定乾坤（5）</a></div>
                </div>
                <!-- 股神说单元 结束 -->

                <!-- 股神说单元 -->
                <div class="view-item">
                    <div>
                        <a href="# title=" 股神在线的观点"><img class="view-head"
                                                         src="<%=SystemConst.BASE_PATH%>images/index/img-user2.png"
                                                         alt="股神在线"></a>
                        <div class="view-name-out">
                            <div class="view-user-name"><a href="#" title="">股神在线</a></div>
                            <div class="time-ago">3小时前</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="view-second-title"><a href="#">#一票定乾坤（5）#合买宣言</a></div>
                    <div class="view-content"><a href="#">一票定乾坤（5）</a></div>
                </div>
                <!-- 股神说单元 结束 -->

                <!-- 股神说单元 -->
                <div class="view-item">
                    <div>
                        <a href="# title=" 股神在线的观点"><img class="view-head"
                                                         src="<%=SystemConst.BASE_PATH%>images/index/img-user2.png"
                                                         alt="股神在线"></a>
                        <div class="view-name-out">
                            <div class="view-user-name"><a href="#" title="">股神在线</a></div>
                            <div class="time-ago">3小时前</div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="view-second-title"><a href="#">#一票定乾坤（5）#合买宣言</a></div>
                    <div class="view-content"><a href="#">一票定乾坤（5）</a></div>
                </div>
                <!-- 股神说单元 结束 -->
            </div>

            <div class="c-title" style="margin-top:20px;">战神榜<a href="@"><span class="more">更多&gt;&gt;</span></a></div>
            <div class="gs-top">
                <div>
                    <div class="gs-top-title selected">综合榜</div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

                <!-- 战神榜单元 -->
                <div class="gs-top-item">
                    <a href="#" title=""><img class="view-head top-head"
                                              src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg" alt=""></a>
                    <div class="view-name-out top-name-out">
                        <div class="view-user-name"><a href="#" title="">胜者为王</a><img class="v-img"
                                                                                      src="<%=SystemConst.BASE_PATH%>images/index/icon_v.png"
                                                                                      alt=""></div>
                        <div class="time-ago">夏普率：4.18</div>
                    </div>
                    <div class="clear"></div>
                </div>
                <!-- 战神榜单元 结束 -->

            </div>

        </div>
        <!-- sildebar end -->
    </div>
</div>
<!-- 合买项目+财富论  结束 -->

<!-- 人气榜 -->
<div class="pop">
    <div class="wrap cf">
        <!--人气榜列表 -->
        <div class="pop-list">
            <div class="pop-list-title">人气榜</div>
            <div class="pop-list-cnt cf">
                <ul>
                    <li>
                        <a href="#">
                            <div class="pop-list-cell">
                                <img src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg"/>
                                <p class="pop-list-name">
                                    胜者为王
                                    <span class="pop-list-star">
												<i class="demo-icon icon-star"></i><i
                                            class="demo-icon icon-star-half-alt"></i>
											</span>
                                </p>
                                <p class="pop-list-info">一票定乾坤</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pop-list-cell">
                                <img src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg"/>
                                <p class="pop-list-name">
                                    胜者为王
                                    <span class="pop-list-star">
												<i class="demo-icon icon-star"></i><i class="demo-icon icon-star"></i><i
                                            class="demo-icon icon-star"></i><i class="demo-icon icon-star-half-alt"></i>
											</span>
                                </p>
                                <p class="pop-list-info">一票定乾坤</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pop-list-cell">
                                <img src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg"/>
                                <p class="pop-list-name">
                                    胜者为王
                                    <span class="pop-list-star">
												<i class="demo-icon icon-star"></i><i
                                            class="demo-icon icon-star-half-alt"></i>
											</span>
                                </p>
                                <p class="pop-list-info">一票定乾坤</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pop-list-cell">
                                <img src="<%=SystemConst.BASE_PATH%>images/index/img-user.jpg"/>
                                <p class="pop-list-name">
                                    胜者为王
                                    <span class="pop-list-star">
												<i class="demo-icon icon-star"></i><i
                                            class="demo-icon icon-star-half-alt"></i>
											</span>
                                </p>
                                <p class="pop-list-info">一票定乾坤</p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="pop-list-btn">
                <a href="#">查看更多</a>
            </div>
        </div>
        <!--人气榜列表 结束 -->
        <!-- 右侧 数字 -->
        <div class="pop-cnt cf">
            <ul>
                <li>
                    <div class="pop-cnt-feature">最大回撤<i class="demo-icon icon-info-circled poshytip" title="最大回撤"></i>
                    </div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
                <li>
                    <div class="pop-cnt-feature">最大回撤<i class="demo-icon icon-info-circled poshytip" title="最大回撤"></i>
                    </div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
                <li class="no-border">
                    <div class="pop-cnt-feature">最大回撤</div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
                <li>
                    <div class="pop-cnt-feature">最大回撤<i class="demo-icon icon-info-circled poshytip" title="最大回撤"></i>
                    </div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
                <li>
                    <div class="pop-cnt-feature">最大回撤</div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
                <li class="no-border">
                    <div class="pop-cnt-feature">最大回撤<i class="demo-icon icon-info-circled poshytip" title="最大回撤"></i>
                    </div>
                    <div class="pop-cnt-info">-7.81%</div>
                </li>
            </ul>
            <img src="<%=SystemConst.BASE_PATH%>images/index/pop-num.png" style="margin-top: 10px;margin-left: 15px;"
                 alt=""/>
        </div>
        <!-- 右侧 数字 结束 -->
    </div>
</div>
<div class="clear"></div>
<!-- 人气榜 结束 -->

<div class="media-out">
    <div class="media-main cf">
        <!-- 媒体报道 -->
        <div class="media-left">
            <div class="c-title">媒体报道</div>
            <div class="media-in-out">
                <div class="media-item cf"
                     style="background: url(<%=SystemConst.BASE_PATH%>images/index/new.png) no-repeat 640px 16px;">
                    <div class="media-content">
                        <span class="media-title"><a href="#" target="_blank">[温州日报] 陈浩：一起来做“淘股神”之梦</a></span>
                    </div>
                </div>
                <div class="media-item cf">
                    <div class="media-content">
                        <span class="media-title"><a href="#" target="_blank">[温州日报] 陈浩：一起来做“淘股神”之梦</a></span>
                    </div>
                </div>
                <div class="media-item cf">
                    <div class="media-content">
                        <span class="media-title"><a href="#" target="_blank">[温州日报] 陈浩：一起来做“淘股神”之梦</a></span>
                    </div>
                </div>
                <div class="media-item cf">
                    <div class="media-content">
                        <span class="media-title"><a href="#" target="_blank">[温州日报] 陈浩：一起来做“淘股神”之梦</a></span>
                    </div>
                </div>
            </div>
        </div>
        <!--媒体报道 结束 -->
        <div class="media-right">
            <div class="c-title">帮助中心<a href="#"><span class="more">更多&gt;&gt;</span></a></div>
            <div class="help-out">
                <div class="help-item">
                    <a href="#">
                        <i class="demo-icon icon-angle-right"></i>
                        <span>什么是淘股神</span>
                    </a>
                </div>
                <div class="help-item">
                    <a href="#">
                        <i class="demo-icon icon-angle-right"></i>
                        <span>什么是淘股神</span>
                    </a>
                </div>
                <div class="help-item">
                    <a href="#">
                        <i class="demo-icon icon-angle-right"></i>
                        <span>什么是淘股神</span>
                    </a>
                </div>
                <div class="help-item">
                    <a href="#">
                        <i class="demo-icon icon-angle-right"></i>
                        <span>什么是淘股神</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>

<!-- 合作机构 -->
<div class="bottom-security">
    <div class="bottom-security-container cf">
        <div class="bottom-security-col">
            <div class="bottom-security-images">
                <img src="<%=SystemConst.BASE_PATH%>images/index/sipc_logo_black.png">
            </div>
            <div class="bottom-security-content">
                <h3>Member of Securities Investor Protection Corporation</h3>
                <p>Betterment Securities is a member of SIPC. Securities in your account protected up to $500,000. For
                    details, please see <a href="@" target="_blank" rel="nofollow noreferrer">www.sipc.org</a>.</p>
            </div>
        </div>
        <div class="bottom-security-col">
            <div class="bottom-security-images">
                <img src="<%=SystemConst.BASE_PATH%>images/index/sipc_logo_black.png">
            </div>
            <div class="bottom-security-content">
                <h3>Member of Securities Investor Protection Corporation</h3>
                <p>Betterment Securities is a member of SIPC. Securities in your account protected up to $500,000. For
                    details, please see <a href="@" target="_blank" rel="nofollow noreferrer">www.sipc.org</a>.</p>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<!-- 合作机构 结构-->

<!-- 联系方式 -->
<div class="footer-contact">
    <ul class="wrapper">
        <li class="questions">Questions? Visit the <a href="#">Support Center</a>, or get in touch:</li>
        <li>
            <a href="tel:+18884289482" class="phone">
                <span class="phone-link-prompt"><i class="demo-icon icon-mobile"></i>&nbsp;Call Us</span>
                <span class="phone-link">(888)&nbsp;428-9482</span>
            </a>
        </li>
        <li>
            <a href="mailto:support@betterment.com" class="email">
                <span class="email-link-prompt"><i class="demo-icon icon-mail-alt"></i>&nbsp;Email Us</span>
                <span class="email-link">support@betterment.com</span>
            </a>
        </li>
        <li>
            <a href="#" class="chat">
                <span class="text"><i class="demo-icon icon-comment"></i>&nbsp;Ask a Question</span>
            </a>
        </li>
        <li class="clear"></li>
    </ul>
</div>

<!-- 关于我们 -->
<div class="box_black mpg bot_logo">
    <div class="about-us">

        <div style="width:50%; float:left;">
            <img src="<%=SystemConst.BASE_PATH%>images/index/bot_logo.png" style="z-index:100" class="nime">
            <span class="bold big white nouim" style="text-align:center; left:0px;">让股神为你操盘！
		                <a href="#" style="display:block; left:-12px; margin:auto;" class="box_org quire radius"><span
                                class="white mid">立即注册</span></a>
		            </span>
        </div>

        <div style="width:50%; float:left; padding-top:20px; text-align:left;">
            <ul class="contentLink">
                <li style="padding-left:38px;">
                    <h3>关于我们</h3>
                    <div><a href="#">关于淘股神</a></div>
                    <div><a href="#">最新动态</a></div>
                    <div><a href="#">加入我们</a></div>
                    <div><a href="#">联系我们</a></div>
                </li>
                <li>
                    <h3>安全保障</h3>
                    <div><a href="#">资金安全</a></div>
                    <div><a href="#">法规保障</a></div>
                    <div><a href="#">免责声明</a></div>
                    <div><a href="#">网站规则</a></div>
                </li>
                <li>
                    <h3>发现</h3>
                    <div><a href="#">精选项目</a></div>
                    <div><a href="#">股神观点</a></div>
                    <div><a href="#">合作伙伴</a></div>
                    <div><a href="#">在线反馈</a></div>
                </li>
            </ul>
        </div>

    </div>
</div>


<!-- 友情链接 -->
<div class="all_foot box_black" style="height:160px; line-height:30px; padding-top:20px; font-family:'微软雅黑'">
    <div>
        <span class="gray">版权所有：深圳前海韦恩互联网金融服务有限公司&nbsp;&nbsp;<a target="_blank"
                                                                href="http://www.miitbeian.gov.cn/publish/query/indexFirst.action">粤ICP备15007148号</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
            class="gray">Copyright © 2014 - 2016 TAOGUSHEN.COM All Rights Reserved.</span>
    </div>
    <div class="blank_none"></div>
    <div class="gray">友情提示：股市有风险，投资需谨慎</div>
    <div id="bottom_versign_c">


		            <span class="bottom_versign">
		                 <a href="#" target="_blank"><img src="<%=SystemConst.BASE_PATH%>images/index/newGovIcon.gif"
                                                          title="深圳市市场监督管理局企业主体身份公示" alt="深圳市市场监督管理局企业主体身份公示"
                                                          width="112" height="40" border="0"
                                                          style="border-width:0px;border:hidden; border:none;"></a>
		            </span>

        <span class="bottom_versign">
		                 <a href="#" target="_blank"><img src="<%=SystemConst.BASE_PATH%>images/index/cert_cx.png"
                                                          height="40" title="诚信网站"></a>
		            </span>

        <span class="bottom_versign">
		                 <a key="5567c6f0efbfb03ac5bf9ce0" logo_size="124x47" logo_type="business" href="#"><img
                                 src="<%=SystemConst.BASE_PATH%>images/index/hy_124x47.png" alt="安全联盟认证" width="124"
                                 height="47" style="border: none;"></a>
		            </span>
    </div>
</div>

<!-- 客服浮动栏 -->
<div id="float_contact_bar_wx" class="float_contact_bar_wx"></div>
<div id="float_contact_bar_qq" class="float_contact_bar_qq">
    <div style="position: absolute;top:1px;left:1px;width:140px;height:140px;overflow: hidden;background-color:#FFF;line-height:18px;">
        <div style="margin-left:12px;">
            <h3 style="margin-top:16px;font-size:12px;color:#30ACE2;">在线客服工作时间：</h3>
            <div style="font-size:12px;color:#7D7D7D;">工作日 9:00 - 21:00</div>
            <h3 style="margin-top:10px;font-size:12px;color:#30ACE2;">客服电话：</h3>
            <div><b style="font-size:14px;">4008-579-779</b></div>
            <div style="font-size:12px;color:#7D7D7D;">工作日 9:00 - 18:00</div>
        </div>

    </div>
</div>
<div id="right_fr_ct_bar" class="float_contact_bar">
    <a class="r_btn wx_ico" href="#"></a>
    <a class="r_btn wb_ico" href="#" target="_blank"></a>
    <a class="r_btn kf_ico" href="#" target="_blank" title="点我联系在线客服"></a>
    <a class="r_btn top_ico" href="#"></a>
</div>
<!-- 客服浮动栏 结束 -->


<script src="<%=SystemConst.BASE_PATH%>js/jquery-1.11.2.js"></script>
<script src="<%=SystemConst.BASE_PATH%>js/index/jquery.touchSlider.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=SystemConst.BASE_PATH%>js/index/jquery.poshytip.min.js" type="text/javascript"></script>
<script src="<%=SystemConst.BASE_PATH%>js/index/index.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
