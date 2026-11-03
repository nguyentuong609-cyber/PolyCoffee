<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/NewFile.jsp" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Theo dõi đơn hàng - PolyCoffee</title>
	<link rel="stylesheet" href="dinh-dang.css">
    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f7f5f2;
            color: #29231f;
        }

        .container {
            width: 92%;
            max-width: 1250px;
            margin: 0 auto;
        }


        /* ================= HEADER ================= */

        .header {
            height: 80px;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .back-btn {
            width: 42px;
            height: 42px;

            border: none;
            border-radius: 50%;

            background: white;

            font-size: 22px;

            cursor: pointer;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

            transition: 0.2s;
        }

        .back-btn:hover {
            background: #eee8e2;
        }

        .page-title {
            font-size: 26px;
            font-weight: 700;
        }


        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification {
            font-size: 22px;
            cursor: pointer;
        }

        .user {
            display: flex;
            align-items: center;
            gap: 10px;

            font-weight: 600;
        }

        .avatar {
            width: 40px;
            height: 40px;

            border-radius: 50%;

            background: #6f4e37;
            color: white;

            display: flex;
            justify-content: center;
            align-items: center;
        }


        /* ================= COMMON CARD ================= */

        .card {
            background: white;

            border-radius: 16px;

            padding: 28px 30px;

            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.06);
        }


        /* ================= ORDER HEADER ================= */

        .order-header {
            display: flex;

            justify-content: space-between;
            align-items: center;

            margin-bottom: 20px;
        }

        .order-info {
            display: flex;
            align-items: center;

            gap: 20px;
        }

        .order-icon {
            width: 65px;
            height: 65px;

            border-radius: 50%;

            background: #3b2a20;
            color: white;

            display: flex;
            justify-content: center;
            align-items: center;

            font-size: 28px;
        }

        .order-info h2 {
            margin-bottom: 8px;

            font-size: 22px;
        }

        .order-info p {
            margin-top: 5px;

            color: #777;
            font-size: 14px;
        }

        .order-info strong {
            color: #6f4e37;
        }


        /* ================= STATUS ================= */

        .order-status {
            text-align: right;
        }

        .status {
            color: red;

            font-size: 20px;
            font-weight: 700;
        }

        .update-time {
            margin-top: 10px;

            background: #f4eee8;

            padding: 10px 15px;

            border-radius: 8px;

            font-size: 14px;

            color: #666;
        }



			/* =========================
			   TRACKING
			========================= */
			
			.tracking-wrapper {
			    position: relative;
			    width: 100%;
			    height: 150px;
			
			    display: flex;
			    align-items: flex-start;
			
			    box-sizing: border-box;
			}
			
			
			/* =========================
			   STEP
			========================= */
			
			.tracking-step {
			    position: relative;
			
			    width: 33.333333%;
			    flex: 0 0 33.333333%;
			
			    text-align: center;
			
			    z-index: 3;
			}
			
			
			/* =========================
			   CIRCLE
			========================= */
			
			.step-circle {
			    width: 72px;
			    height: 72px;
			
			    margin: 0 auto;
			
			    border-radius: 50%;
			
			    display: flex;
			    align-items: center;
			    justify-content: center;
			
			    background: #bdbdbd;
			    color: white;
			
			    font-size: 32px;
			
			    box-sizing: border-box;
			}
			
			
			/* Chưa tới bước */
			.tracking-step:not(.active):not(.completed) .step-circle {
			    background: #bdbdbd;
			    color: white;
			}
			
			
			/* Đang ở bước */
			.tracking-step.active .step-circle {
			    background: rgb(205, 14, 14);
			    color: white;
			
			    box-shadow: 0 8px 20px rgba(205, 14, 14, 0.25);
			}
			
			
			/* Đã qua bước */
			.tracking-step.completed .step-circle {
			    background: #5caf4e;
			    color: white;
			}
			
			/* Khi đơn đã hoàn thành → bước 3 màu xanh */
			.tracking-wrapper.finished .tracking-step.active .step-circle {
			    background: #5caf4e;
			    color: white;
			    box-shadow: none;
			}
			
			
			/* =========================
			   TITLE
			========================= */
			
			.step-title {
			    margin-top: 18px;
			
			    font-size: 20px;
			    font-weight: 700;
			
			    color: #222;
			
			    white-space: nowrap;
			}
			
			
			/* =========================
			   LINE NỀN
			========================= */
			
			.tracking-line {
			    position: absolute;
			
			    top: 36px;
			    left: 16.666667%;
			
			    width: 66.666666%;
			    height: 5px;
			
			    background: #bdbdbd;
			
			    border-radius: 10px;
			
			    z-index: 1;
			}
			
			
			/* =========================
			   LINE PROGRESS
			========================= */
			
			.tracking-progress {
			    position: absolute;
			
			    top: 36px;
			    left: 16.666667%;
			
			    height: 5px;
			
			    border-radius: 10px;
			
			    z-index: 2;
			
			    transition:
			        width 0.4s ease,
			        background-color 0.4s ease;
			
			    box-sizing: border-box;
			}
			
			
			/* PENDING
			   Chưa qua bước nào
			*/
			.tracking-progress.progress-0 {
			    width: 0;
			    background: #bdbdbd;
			}
			
			
			/* MAKING
			   Đã qua step 1
			   → line đỏ tới step 2
			*/
			.tracking-progress.progress-50 {
			    width: 33.333333%;
			    background: rgb(205, 14, 14);
			}
			
			
			/* COMPLETED
			   → toàn bộ line xanh
			*/
			.tracking-progress.progress-100 {
			    width: 66.666666%;
			    background: #5caf4e;
			}
        /* ================= MAIN CONTENT ================= */

        .main-grid {

            display: grid;

            grid-template-columns: 1.5fr 1fr;

            gap: 20px;

            margin-bottom: 25px;
        }


        /* ================= PRODUCTS ================= */

        .product-item {

            display: flex;

            align-items: center;

            padding: 10px 0;

            border-bottom: 1px solid #eee;
        }

        .product-item:last-child {

            border-bottom: none;
        }


        .product-image {

            width: 95px;
            height: 95px;

            border-radius: 12px;

            object-fit: cover;

            background: #eee;

            margin-right: 20px;
        }


        .product-info {

            flex: 1;
        }

        .product-name {

            font-size: 17px;

            font-weight: 700;

            margin-bottom: 8px;
        }

        .product-detail {

            color: #777;

            font-size: 14px;

            margin-bottom: 7px;
        }

        .product-quantity {

            font-weight: 600;

            font-size: 14px;
        }

        .product-price {

            font-weight: 600;

            font-size: 16px;

            white-space: nowrap;
        }


        /* ================= CUSTOMER ================= */

        .customer-section {

            margin-bottom: 20px;
        }

        .customer-section:last-child {

            margin-bottom: 0;
        }

        .customer-title {

            font-size: 16px;

            font-weight: 700;

            margin-bottom: 15px;
        }


        .customer-row {

            display: flex;

            gap: 12px;

            margin-bottom: 14px;

            color: #555;

            line-height: 1.5;
        }


        .customer-icon {

            width: 25px;

            flex-shrink: 0;

            font-size: 17px;
        }


        .divider {

            height: 1px;

            background: #eee;

            margin: 20px 0;
        }


        /* ================= NOTE ================= */

        .note {

            background: #fff8e9;

            padding: 14px;

            border-radius: 10px;

            color: #604b32;

            font-size: 14px;
        }


        /* ================= FOOTER ================= */

        .footer {

            text-align: center;

            color: #777;

            padding: 5px 0 30px;

            font-size: 14px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .main-grid {

                grid-template-columns: 1fr;
            }


            .tracking {

                overflow-x: auto;
            }


            .tracking-wrapper {

                min-width: 800px;
            }
        }


        @media (max-width: 600px) {

            .container {

                width: 94%;
            }


            .header-right {

                display: none;
            }


            .page-title {

                font-size: 21px;
            }


            .order-header {

                flex-direction: column;

                align-items: flex-start;

                gap: 20px;
            }


            .order-status {

                text-align: left;
            }


            .card {

                padding: 20px;
            }


            .product-image {

                width: 70px;
                height: 70px;

                margin-right: 12px;
            }


            .product-name {

                font-size: 15px;
            }


            .product-detail {

                font-size: 12px;
            }


            .product-price {

                font-size: 14px;
            }
        }

    </style>

</head>


<body>


<div class="container">


    <!-- ================================================= -->
    <!-- HEADER                                            -->
    <!-- ================================================= -->
    <div style="width: 120%"><%@ include file="/Header.jsp" %></div>
    

    

            <h1 class="" style="margin: 20px">

                Chi tiết đơn hàng

            </h1>

      


    <!-- ================================================= -->
    <!-- ORDER HEADER                                      -->
    <!-- ================================================= -->

    <section class="card order-header">


        <div class="order-info">


            <div class="order-icon">

                🧾

            </div>


            <div>

                <h2>

                    Đơn hàng # ${bill.billId }

                </h2>

            </div>

        </div>



     

            <div class="status">

                ☕ ${bill.status}

            </div>


            
        </div>

    </section>



    <!-- ================================================= -->
    <!-- TRACKING                                          -->
    <!-- ================================================= -->

    <section class="card tracking" style="width: 90%; margin: 10px auto">


       <c:set var="currentStep" value="1" />

<c:choose>
    <c:when test="${bill.status == 'PENDING'}">
        <c:set var="currentStep" value="1" />
    </c:when>

    <c:when test="${bill.status == 'MAKING'}">
        <c:set var="currentStep" value="2" />
    </c:when>

    <c:when test="${bill.status == 'COMPLETED'}">
        <c:set var="currentStep" value="3" />
    </c:when>
</c:choose>


<div class="tracking-wrapper ${currentStep == 3 ? 'finished' : ''}">

    <!-- Đường nền -->
    <div class="tracking-line"></div>

    <!-- Đường tiến trình -->
    <div class="tracking-progress
        ${currentStep == 1 ? 'progress-0' :
          currentStep == 2 ? 'progress-50' :
          'progress-100'}">
    </div>


   <!-- STEP 1 -->
<div class="tracking-step
    ${currentStep > 1 ? 'completed' :
      currentStep == 1 ? 'active' : ''}">

    <div class="step-circle">
        ${currentStep > 1 ? '✓' : '🧾'}
    </div>

    <div class="step-title">
        Đã nhận
    </div>
</div>


<!-- STEP 2 -->
<div class="tracking-step
    ${currentStep > 2 ? 'completed' :
      currentStep == 2 ? 'active' : ''}">

    <div class="step-circle">
        ${currentStep > 2 ? '✓' : '☕'}
    </div>

    <div class="step-title">
        Đang làm
    </div>
</div>



<!-- STEP 3 -->
<div class="tracking-step
    ${currentStep == 3 ? 'active' : ''}">

    <div class="step-circle">
        ✓
    </div>

    <div class="step-title">
        Hoàn thành
    </div>

</div>

</div>
    </section>



    <!-- ================================================= -->
    <!-- MAIN CONTENT                                      -->
    <!-- ================================================= -->

    <div class="main-grid" style="width: 90%; margin: 0 auto">


        <!-- ================================================= -->
        <!-- PRODUCTS                                           -->
        <!-- ================================================= -->

        <section class="card">


            <h2 class="section-title">

                SẢN PHẨM

            </h2>



            <!-- PRODUCT 1 -->
			<c:forEach items="${bill.billDetails}" var="u">
            <div class="product-item">


                <img
                    class="product-image"
                    src="${ctx}/hinh-anh/imgs/${u.product.productIMG}"
                    alt="Cappuccino"
                >


                <div class="product-info">


                    <div class="product-name">

                        ${u.product.productName}

                    </div>




                    <div class="product-quantity">

                        x${u.quantity }

                    </div>

                </div>


                <div class="product-price">

                    ${u.price }

                </div>

            </div>
            
         </c:forEach>

        </section>



        <!-- ================================================= -->
        <!-- CUSTOMER                                           -->
        <!-- ================================================= -->

        <section class="card">


            <div class="customer-section">


                <h2 class="customer-title">

                    THÔNG TIN KHÁCH HÀNG

                </h2>


                <div class="customer-row">

                    <span class="customer-icon">
                        👤
                    </span>

                    <span>
                        ${bill.user.userName }
                    </span>

                </div>


                <div class="customer-row">

                    <span class="customer-icon">
                        ☎
                    </span>

                    <span>
                        ${bill.user.userPhone }
                    </span>

                </div>


                <div class="customer-row">

                    <span class="customer-icon">
                        ✉
                    </span>

                    <span>
                        ${bill.user.email }
                    </span>

                </div>

            </div>



            <div class="divider"></div>



            <!-- ADDRESS -->

        

          

            <!-- NOTE -->

            <div class="customer-section">


                <h3 class="customer-title">

                    GHI CHÚ ĐƠN HÀNG

                </h3>


                <div class="note">

                    📝 
                    ${bill.note}

                </div>

            </div>

        </section>

    </div>



    <!-- ================================================= -->
    <!-- FOOTER                                             -->
    <!-- ================================================= -->

    <footer class="footer">

        🤎 &nbsp;

        Cảm ơn bạn đã chọn PolyCoffee.

        Chúc bạn một ngày tuyệt vời! ☕

    </footer>




<script type="text/javascript">
const socket = new WebSocket(
	    "ws://localhost:8080/PolyCoffee/websocket"
	);

	socket.onopen = function() {
	    console.log("USER: WebSocket đã kết nối");
	};

	socket.onmessage = function(event) {
	    console.log("USER: Server gửi:", event.data);

	    if (event.data === "STATUS_CHANGED") {
	        console.log("USER: Có thay đổi → F5");
	        location.reload();
	    }
	};

	socket.onerror = function(error) {
	    console.error("USER: WebSocket ERROR:", error);
	};

	socket.onclose = function(event) {
	    console.log(
	        "USER: WebSocket CLOSED:",
	        event.code,
	        event.reason
	    );
	};
</script>


</body>

</html>