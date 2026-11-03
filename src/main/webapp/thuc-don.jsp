<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include  file="NewFile.jsp"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thực Đơn - Highlands Coffee</title>
    <link rel="stylesheet" href="dinh-dang.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- CÁC THẺ DIV ẨN ĐỂ LÀM BỘ LỌC CSS THUẦN -->
    <div id="tat-ca"></div>
    <div id="ca-phe"></div>
    <div id="tra"></div>
    <div id="freeze"></div>
    <div id="banh-mi"></div>

    <!-- HEADER CHUẨN ĐỒNG BỘ -->
<%@ include file="Header.jsp"%>

    <section class="section">
        <h2 class="page-title">Thực Đơn Highlands</h2>

        <!-- THANH NÚT LỌC SẢN PHẨM -->
        <div class="filter-bar">
            <a href="#tat-ca" class="btn-filter">Tất cả</a>
            <a href="#ca-phe" class="btn-filter">Cà Phê Phin</a>
            <a href="#tra" class="btn-filter">Trà Highlands</a>
            <a href="#freeze" class="btn-filter">Đá Xay (Freeze)</a>
            <a href="#banh-mi" class="btn-filter">Bánh Mì & Snack</a>
        </div>
        <div class="products">
        <c:forEach var="u" items="${listItem}">
        	<div class="item">
        		<a href="${ctx}/chi_tiet/${u.productId}" class="product-link">
            	<img src="${ctx}/hinh-anh/imgs/${u.productIMG}.jpg" alt="${u.productName }">
            	<p>${u.productName}</p>
            	<c:choose>
            	<c:when test="${u.category != 'Bánh'}"><span class="new">${u.sizePrices.sizeS}đ</span></c:when>
            	<c:otherwise><span class="new">${u.price}đ</span></c:otherwise>
            	</c:choose>
            	
            	
            	</a>
            </div>
        </c:forEach>
        </div>  
        
        

        <!-- DANH SÁCH SẢN PHẨM -->
        <!-- <div class="products">
            Nhóm Cà Phê (Lưu ý class "ca-phe")
            3 Món bổ sung thêm cho đủ
            <div class="item ca-phe">
            	<a href="chi-tiet-san-pham.jsp?id=1" class="product-link">
            	<img src="hinh-anh/imgs/PHINDI_HANH_NHAN.jpg" alt="Phindi Hạnh Nhân">
            	<p>Phindi Hạnh Nhân</p>
            	<span class="new">49.000đ</span>
            	</a>
            </div>
            <div class="item ca-phe"><a href="chi-tiet-san-pham.jsp?id=4" class="product-link"><img src="hinh-anh/imgs/PHIN_SUA_DA.jpg" alt="Cà Phê Sữa Đá"><p>Cà Phê Sữa Đá</p><span class="new">29.000đ</span></a></div>
            <div class="item ca-phe"><a href="chi-tiet-san-pham.jsp?id=8" class="product-link"><img src="hinh-anh/imgs/PHIN_SUA_NONG.jpg" alt="Phin Sữa Nóng"><p>Phin Sữa Nóng</p><span class="new">29.000đ</span></a></div>
            
            Các món cũ bạn đã có
            <div class="item ca-phe"><a href="chi-tiet-san-pham.jsp?id=5" class="product-link"><img src="hinh-anh/imgs/phin_sua_da.jpg" alt="Phin Sữa Đá"><p>Phin Sữa Đá</p><span class="new">29.000đ</span></a></div>
            <div class="item ca-phe"><a href="chi-tiet-san-pham.jsp?id=6" class="product-link"><img src="hinh-anh/imgs/phin_den_da.jpg" alt="Phin Đen Đá"><p>Phin Đen Đá</p><span class="new">29.000đ</span></a></div>
            <div class="item ca-phe"><a href="chi-tiet-san-pham.jsp?id=7" class="product-link"><img src="hinh-anh/imgs/bac_siu_1.jpg" alt="Bạc Xỉu Đá"><p>Bạc Xỉu Đá</p><span class="new">33.000đ</span></a></div>
            
            Nhóm Trà (Lưu ý class "tra")
            <div class="item tra"><a href="chi-tiet-san-pham.jsp?id=2" class="product-link"><img src="hinh-anh/imgs/tsv_cu_nang.jpg" alt="Trà Sen Vàng"><p>Trà Sen Vàng (Củ Năng)</p><span class="new">45.000đ</span></a></div>
            <div class="item tra"><a href="chi-tiet-san-pham.jsp?id=13" class="product-link"><img src="hinh-anh/imgs/tra_thanh_dao.jpg" alt="Trà Thanh Đào"><p>Trà Thanh Đào</p><span class="new">45.000đ</span></a></div>
            <div class="item tra"><a href="chi-tiet-san-pham.jsp?id=14" class="product-link"><img src="hinh-anh/imgs/TRA_THACH_VAI_1.jpg" alt="Trà Thạch Vải"><p>Trà Thạch Vải</p><span class="new">45.000đ</span></a></div>
            <div class="item tra"><a href="chi-tiet-san-pham.jsp?id=16" class="product-link"><img src="hinh-anh/imgs/TRA_XANH_DAU_DO.jpg" alt="Trà Xanh Đậu Đỏ"><p>Trà Xanh Đậu Đỏ</p><span class="new">45.000đ</span></a></div>

            Nhóm Freeze (Lưu ý class "freeze")
            <div class="item freeze"><a href="chi-tiet-san-pham.jsp?id=3" class="product-link"><div class="badge-hot">HOT</div><img src="hinh-anh/imgs/freeze_tra_xanh.jpg" alt="Freeze Trà Xanh"><p>Freeze Trà Xanh</p><span class="new">55.000đ</span></a></div>
            <div class="item freeze"><a href="chi-tiet-san-pham.jsp?id=15" class="product-link"><img src="hinh-anh/imgs/FREEZE_COOKIES.jpg" alt="Cookies & Cream"><p>Cookies & Cream</p><span class="new">55.000đ</span></a></div>

            Nhóm Bánh (Lưu ý class "banh-mi")
            <div class="item banh-mi"><a href="chi-tiet-san-pham.jsp?id=10" class="product-link"><img src="hinh-anh/imgs/bmq_ga.jpg" alt="Bánh Mì Que Gà"><p>Bánh Mì Que (Gà)</p><span class="new">19.000đ</span></a></div>
            <div class="item banh-mi"><a href="chi-tiet-san-pham.jsp?id=9" class="product-link"><img src="hinh-anh/imgs/banh_pho_mai_tra_xanh.jpg" alt="Bánh Phô Mai Trà Xanh"><p>Bánh Phô Mai Trà Xanh</p><span class="new">25.000đ</span></a></div>
            <div class="item banh-mi"><a href="chi-tiet-san-pham.jsp?id=11" class="product-link"><img src="hinh-anh/imgs/BANH_TIRAMISU.jpg" alt="Bánh Tiramisu"><p>Bánh Tiramisu</p><span class="old">39.000đ</span><span class="new">35.000đ</span></a></div>
            <div class="item banh-mi"><a href="chi-tiet-san-pham.jsp?id=12" class="product-link"><img src="hinh-anh/imgs/BANH_CHUOI.jpg" alt="Bánh Chuối"><p>Bánh Chuối</p><span class="old">32.000đ</span><span class="new">29.000đ</span></a></div>
        </div> -->
    </section>

    <!-- FOOTER CHUẨN ĐỒNG BỘ -->
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
</body>
</html>