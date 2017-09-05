<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="cn.com.bohui.bohuifin.consts.SystemConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>

<html>
<head>
    <base href="<%=SystemConst.BASE_PATH%>">
    <title><%=SystemConst.SYSTEM_NAME%>
    </title>
    <%@include file="/common/common.jsp" %>
    <%@include file="/common/showTablePage.jsp" %>
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <%@include file="/common/common-extra.jsp"%>
    <link rel="stylesheet" href="<%=SystemConst.BASE_PATH%>js/assets/css/fullcalendar.css" />
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/ace-extra.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/fullcalendar.min.js"></script>
    <script src="<%=SystemConst.BASE_PATH%>js/assets/js/bootbox.min.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            var error = "${requestScope.error}";
            if (error != "") {
                swal({
                    title : error,
                    type : "warning",
                    confirmButtonColor : "#428bca",
                    confirmButtonText : "确定"
                })
            }

            $("form").submit(function () {

                return true;
            })
        })
    </script>
</head>

<body>

<div class="main-container-inner">
    <div class="main-content">
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="space"></div>

                            <div id="calendar"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="show" style="display: none;">
    <div id="hint" class="alert alert-success alert-dismissible" role="alert"
         style="float: left; height: 35px; padding-top: 5px; margin-left: 5px;">
        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true"
                                                                       style="color: red;">&times;</span><span
                class="sr-only">Close</span></button>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        /* initialize the calendar
         -----------------------------------------------------------------*/

        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var settingIncomeDays = new Array();
        <c:if test="${requestScope.productIncomeRecords ne null}">
        <c:forEach items="${requestScope.productIncomeRecords}" var="vo" varStatus="idx">
            settingIncomeDays.push(new Date("<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.incomeTime}"/> 00:00:00").getTime());
        </c:forEach>
        </c:if>

        var calendar = $('#calendar').fullCalendar({
            buttonText: {
                prev: '<i class="icon-chevron-left"></i>',
                next: '<i class="icon-chevron-right"></i>'
            },

            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month'
            },
            events: [
                <c:if test="${requestScope.productIncomeRecords ne null}">
                <c:forEach items="${requestScope.productIncomeRecords}" var="vo" varStatus="idx">
                <c:if test="${idx.index ne 0}">,</c:if>{
                    title: "${vo.incomeAmount}",
                    start: new Date("<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.incomeTime}"/>"),
                    className: 'label-success'
                }
                </c:forEach>
                </c:if>
                ],
            editable: true,
            droppable: false, // this allows things to be dropped onto the calendar !!!
            selectable: true,
            selectHelper: true,
            select: function (start, end, allDay) {
                if (settingIncomeDays.indexOf(start.getTime()) != -1) {
                    return;
                }
                if (start.getTime() > new Date().getTime()) {
                    errorAlert("设置产品收益不能超过当天");
                    return;
                }
                bootbox.prompt({
                    title: "设置产品收益:",
                    inputType: 'number',
                    callback: function (title) {
                        if (title !== null) {
                            saveIncome(title, start, calendar);
                        }
                    }
                });
                calendar.fullCalendar('unselect');
            },
            eventClick: function (calEvent, jsEvent, view) {
                var form = $("<form class='form-inline'><label>设置产品收益&nbsp;</label></form>");
                form.append("<input class='middle' autocomplete=off type=text value='" + calEvent.title + "' /> ");
                form.append("<button type='submit' class='btn btn-sm btn-success'><i class='icon-ok'></i>保存</button>");

                var div = bootbox.dialog({
                    message: form,
                    buttons: {
                        "delete": {
                            "label": "<i class='icon-trash'></i>删除收益值",
                            "className": "btn-sm btn-danger",
                            "callback": function () {
                                delIncome(calendar, calEvent, calEvent.start.getTime());
                                /*calendar.fullCalendar('removeEvents', function (ev) {
                                    return (ev._id == calEvent._id);
                                })*/
                            }
                        },
                        "close": {
                            "label": "<i class='icon-remove'></i>关闭",
                            "className": "btn-sm"
                        }
                    }
                });

                form.on('submit', function () {
                    var income = form.find("input[type=text]").val();
                    saveIncome(income, calEvent.start, calendar);
                    /*calEvent.title = income;
                    calendar.fullCalendar('updateEvent', calEvent);
                    div.modal("hide");*/
                    return false;
                });
                //console.log(calEvent.id);
                //console.log(jsEvent);
                //console.log(view);

                // change the border color just for fun
                //$(this).css('border-color', 'red');
            }

        });
    });

    function delIncome(calendar, calEvent, time) {
        $.ajax({
            url : "<%=SystemConst.BASE_PATH%>admin/productIncomeRecord/removeIncome",
            type : "POST",
            data : {
                "productId" : ${requestScope.productId},
                "time": time
            },
            dataType : "json",
            success : function (data) {
                if (data.code == 0) {
                    calendar.fullCalendar('removeEvents', function (ev) {
                        return (ev._id == calEvent._id);
                    })
                } else {
                    errorAlert(data.errorMsg);
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                document.write(XMLHttpRequest.responseText);
            }
        })
    }

    function saveIncome(income, time, calendar) {
        if (!/^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(income)) {
            errorAlert("请输入数字");
            return;
        }
        $.ajax({
            url : "<%=SystemConst.BASE_PATH%>admin/productIncomeRecord/saveIncome",
            type : "POST",
            data : {
                "productId": ${requestScope.productId},
                "time": time.getTime(),
                "incomeAmount": income
            },
            dataType : "json",
            success : function (data) {
                if (data.code == 0) {
                    window.location.reload();
                    /*calendar.fullCalendar('renderEvent',
                        {
                            title: income,
                            start: time,
                            end: time,
                            allDay: true
                        },
                        true // make the event "stick"
                    );*/
                } else {
                    errorAlert(data.errorMsg);
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                document.write(XMLHttpRequest.responseText);
            }
        })
    }

    function back() {
        window.history.go(-1);
        <%-- if ("${requestScope.parentVo}" != "") {
            window.location.href="<%=SystemConst.BASE_PATH%>dept/showDept?parentId=${requestScope.parentVo.deptId}";
        } else {
            window.location.href="<%=SystemConst.BASE_PATH%>dept/showDept?parentId=-1";
        } --%>
    }
</script>
</body>
</html>

