<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="NewFile.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Highlands Coffee</title>
    <link rel="stylesheet" href="User/dinh-dang.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- HEADER HIGHLANDS -->
    <%@ include file="Header.jsp" %>
    <!-- BANNER SLIDER -->
    <section class="banner-slider">
        <div class="slides">
            <div class="slide"><img src="hinh-anh/imgs/trangchu1.jpg" alt="Banner Highlands 1"></div>
            <div class="slide"><img src="hinh-anh/imgs/trangchu2.jpg" alt="Banner Highlands 2"></div>
            <div class="slide"><img src="hinh-anh/imgs/trangchu3.jpg" alt="Banner Highlands 3"></div>
            <div class="slide"><img src="hinh-anh/imgs/trangchu4.jpg" alt="Banner Highlands 4"></div>
            <div class="slide"><img src="hinh-anh/imgs/trangchu5.png" alt="Banner Highlands 5"></div>
            <div class="slide"><img src="hinh-anh/imgs/trangchu6.jpg" alt="Banner Highlands 6"></div>
        </div>
        <div class="slider-dots">
            <div class="dot active"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </section>

    <!-- DANH SÁCH SẢN PHẨM -->
    
    <section class="section">
        <h2 class="page-title">Món Mới Phải Thử</h2>
        
        <div class="products">
        <c:forEach var="u" items="${listItem}" begin="0" end="3">
        	<div class="item">
        		<a href="${ctx }/chi_tiet/${u.productId}" class="product-link">
            	<img src="${ctx}/hinh-anh/imgs/${u.productIMG}" alt="Phindi Hạnh Nhân">
            	<p>${u.productName}</p>
            	<c:choose>
            	<c:when test="${u.category != 'Bánh'}"><span class="new">${u.sizePrices.sizeS}đ</span></c:when>
            	<c:otherwise><span class="new">${u.price}đ</span></c:otherwise>
            	</c:choose>
            	
            	
            	</a>
            </div>
        </c:forEach>
        </div>  
            
    </section>

    <section class="section">
        <h2 class="page-title">Trà</h2>
        <div class="products">
        <c:forEach var="u" items="${listItem}" begin="6" end="9">
        	<div class="item">
        		<a href="${ctx }/chi_tiet/${u.productId}" class="product-link">
            	<img src="${ctx}/hinh-anh/imgs/${u.productIMG}" alt="Phindi Hạnh Nhân">
            	<p>${u.productName}</p>
            	<c:choose>
            	<c:when test="${u.category != 'Bánh'}"><span class="new">${u.sizePrices.sizeS}đ</span></c:when>
            	<c:otherwise><span class="new">${u.price}đ</span></c:otherwise>
            	</c:choose>
            	
            	
            	</a>
            </div>
        </c:forEach>
        </div>  
    </section>

    <section class="section">
        <h2 class="page-title">Bánh Mì & Đồ Ăn Nhẹ</h2>
        <div class="products">
        <c:forEach var="u" items="${listItem}" begin="12" end="15">
        	<div class="item">
        		<a href="${ctx }/chi_tiet/${u.productId}" class="product-link">
            	<img src="${ctx}/hinh-anh/imgs/${u.productIMG}" alt="Phindi Hạnh Nhân">
            	<p>${u.productName}</p>
            	<c:choose>
            	<c:when test="${u.category != 'Bánh'}"><span class="new">${u.sizePrices.sizeS}đ</span></c:when>
            	<c:otherwise><span class="new">${u.price}đ</span></c:otherwise>
            	</c:choose>
            	
            	
            	</a>
            </div>
        </c:forEach>
        </div>  
    </section>

  <!-- FOOTER HIGHLANDS -->
    <footer class="main-footer">
        <div class="footer-container">
            <div class="footer-column">
                <h4>Về Highlands Coffee</h4>
                <p>Khởi nguồn từ quán cà phê đóng gói tại Hà Nội vào năm 2000, Highlands Coffee đã không ngừng phát triển và trở thành thương hiệu cà phê nổi tiếng nhất Việt Nam.</p>
            </div>
            <div class="footer-column">
                <h4>Thông Tin Liên Hệ</h4>
                <p>Hotline: 1900 1755</p>
                <p>Email: customerservice@highlandscoffee.com.vn</p>
                <p>Địa chỉ: 130-132 Hồng Hà, Phường 9, Quận Phú Nhuận, TP.HCM</p>
            </div>
            <div class="footer-column map-column">
                <h4>Bản đồ Cửa hàng</h4>
                <iframe src="https://maps.google.com/maps?q=Highlands%20Coffee%20Ho%20Chi%20Minh&t=&z=13&ie=UTF8&iwloc=&output=embed" title="Bản đồ Highlands Coffee" width="100%" height="100" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
            <div class="footer-column copyright-column">
                <p class="copy-text">© 2026 Highlands Coffee.<br>Tất cả các quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>

    <!-- Chỉ cần gọi duy nhất file main.js là hệ thống sẽ tự động xử lý Menu và Slider -->
    <script src="main.js"></script>
</body>
</html>