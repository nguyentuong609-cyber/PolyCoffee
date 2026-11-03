<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - PolyCoffee</title>
    <link rel="stylesheet" href="dinh-dang.css">
</head>
<body class="auth-body">
    <a href="${pageContext.request.contextPath}/Index" class="back-home">← Quay lại Trang chủ</a>

    <div class="auth-container">
        <div class="form-box">
            <h2 style="color: var(--dark-bg); margin-bottom: 10px;">Đổi mật khẩu</h2>
<!--             <p style="color: #666; margin-bottom: 20px; font-size: 14px;">Trở thành khách hàng thân thiết của PolyCoffee</p> -->

            <!-- Khối hiển thị thông báo lỗi từ Servlet (nếu đăng ký thất bại) -->
            <% if (request.getAttribute("mess") != null) { %>
                <div style="color: red; margin-bottom: 15px; font-size: 14px;">
                    <%= request.getAttribute("mess") %>
                </div>
            <% } %>

            <!-- Form chuyển tiếp dữ liệu đến Servlet /dang_ky bằng phương thức POST -->
            <form action="${pageContext.request.contextPath}/ChangePass" method="post">
            	<input type="password" name="pass" placeholder="Mật khẩu hiện tại" autocomplete="tel" required>
                <input type="password" name="newPass" placeholder="Mật khẩu mới" autocomplete="email" required>
                <input type="password" name="newPass2" placeholder="Xác nhận mật khẩu mới" autocomplete="new-password" required>
                
                <button type="submit" style="background-color: var(--dark-bg);">Đổi mật khẩu</button>
            </form>
            
           <%--  <p style="margin-top: 15px; font-size: 14px;">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/User/dang-nhap.jsp" style="color: var(--dark-bg); text-decoration: none; font-weight: bold;">Đăng nhập</a>
            </p> --%>
        </div>
    </div>
</body>
</html>