<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="NewFile.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header class="main-header">
	
		

        <div class="header-container">
            <div class="logo">Highlands Coffee</div>
            <!-- Dọn trống Nav, nhường quyền kiểm soát cho JavaScript -->
            <nav id="main-nav">
            <a href="${pageContext.request.contextPath}/Index" class="active">Trang chủ</a>
            	<c:choose>
            		<c:when test="${not empty sessionScope.user
                    				and sessionScope.user.role == 'ADMIN'}">
            
            			<a href="${ctx }/DrinkServlet">QL Thực đơn</a>
	                    
	                    <a href="${ctx }/UserList">QL Nhân viên</a>
	                    <a href="${ctx }/Report">Báo cáo</a>
	                    <a href="${ctx }/BillList">Đơn hàng</a>
	                    <a>Xin chào, ${sessionScope.user.userName}</a>
	                    <a href="${ctx}/Logout">Logout</a>
            		</c:when>
            		<c:when test="${not empty sessionScope.user
                    				and sessionScope.user.role == 'BARISTA'}">
            			<a href="barista/dashboard.jsp">Barista</a>
            			<a>Xin chào, ${sessionScope.user.userName}</a>
                    	<a href="${ctx}/Logout">Logout</a>
            		</c:when>
            		<c:when test="${not empty sessionScope.user
                    				and sessionScope.user.role == 'USER'}">
            			<a href="${ctx}/Menu">Thực đơn</a>
                    	<a href="${ctx}/cart">Giỏ hàng</a>
                    	<a>Xin chào, ${sessionScope.user.userName}</a>
                    	<a href="${ctx}/History">Lịch sử mua hàng</a>
                    	<a href="${ctx}/Logout">Logout</a>
            		</c:when>
            		<c:otherwise>
				        <a href="${pageContext.request.contextPath}/Menu">Thực đơn</a>
				        <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
				        <a href="${pageContext.request.contextPath}/dang-ky.jsp">Đăng ký</a>
				        <a href="${pageContext.request.contextPath}/User/dang-nhap.jsp">Đăng nhập</a>
				    </c:otherwise>
            	</c:choose>
            	
            </nav>
        </div>
    </header>

</body>
</html>