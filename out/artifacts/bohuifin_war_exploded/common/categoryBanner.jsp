<%@page import="cn.com.bohui.bohuifin.consts.SystemConst"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$().ready(function() {
		/* $( "#show-option" ).tooltip({
			show: {
				effect: "slideDown",
				delay: 250
			}
		}); */
		$(".banner_link").mouseover(function() {
			var x = (parseInt($(this).offset().left) - 150) + "px";
			var y = (parseInt($(this).offset().top) - 20) + "px";
			$(this).next().css({
				"top" : y,
				"left" : x,
				"display" : ""
			})
			$(this).parent().siblings().each(function(idx, ele) {
				$(this).find("ul").css("display", "none");
			})
		})
		
		var flag = false;
		
		/* $(".banner-menu").mouseover(function() {
			console.log(1);
			flag = true;
		}) */
		$("body").click(function() {
			$(".banner-menu").css("display", "none");
		})
		
		$(".breadcrumb").children("li").siblings("li").each(function(idx, ele) {
			if (idx == 0) {
				return;
			}
			if ($(this).children().is("ul")) {
				var $ulObj = $(this).find("ul");
				var ulHeight = $ulObj.css("height");
				if (parseInt(ulHeight.substring(0, ulHeight.length - 2)) > 600) {
					$ulObj.css("overflow", "scroll");
					$ulObj.css("height", "600px");
				}
			}
		})
		
		/* $(".banner-menu").mouseout(function() {
			if (flag) {
				$(this).css("display", "none");
				flag = false;
			}
		}) */
		/* $(".banner_link").mouseout(function() {
			$("#menu").css("display", "none");
		}) */
	})
</script>
<div class="main-content">
	<div class="breadcrumbs" id="breadcrumbs">
		<ul class="breadcrumb">
			<li>
				<i class="icon-home home-icon"></i>
				${requestScope.titleName }
			</li>
			<c:forEach items="${requestScope.parentVos }" var="pVo" varStatus="idx">
				<li>
					<a class="banner_link" href="${fn:replace(bannerUrl, '[categoryId]', pVo.categoryId) }">${pVo.categoryName }</a>
					<c:if test="${fn:length(pVo.sameLevelCategoryVos) ne 0 }">
						<ul style="display: none; z-index: 99; position: absolute;" class="ui-menu ui-widget ui-widget-content ui-corner-all banner-menu" role="menu" tabindex="0">
							<c:forEach items="${pVo.sameLevelCategoryVos }" var="subVo">
								<c:choose>
									<c:when test="${fn:length(requestScope.parentVos) ne (idx.index + 1) }">
										<c:choose>
											<c:when test="${requestScope.parentVos[idx.index + 1].categoryId eq subVo.categoryId }">
												<li class="ui-menu-item" role="presentation" aria-disabled="true">
													<a href="${fn:replace(bannerUrl, '[categoryId]', subVo.categoryId) }" class="ui-corner-all ui-state-focus" tabindex="-1" role="menuitem">${subVo.categoryName }</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="ui-menu-item" role="presentation" aria-disabled="true">
													<a href="${fn:replace(bannerUrl, '[categoryId]', subVo.categoryId) }" class="ui-corner-all" tabindex="-1" role="menuitem">${subVo.categoryName }</a>
												</li>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<li class="ui-menu-item" role="presentation" aria-disabled="true">
											<a href="${fn:replace(bannerUrl, '[categoryId]', subVo.categoryId) }" class="ui-corner-all" tabindex="-1" role="menuitem">${subVo.categoryName }</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:forEach>
		</ul><!-- .breadcrumb -->
	</div>
</div><!-- /.main-content -->