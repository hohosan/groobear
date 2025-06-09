<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<header class="header mb-4">
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-5 col-md-5 col-6">
        <div class="header-left d-flex align-items-center">
          <div class="menu-toggle-btn mr-15">
            <button id="menu-toggle" class="main-btn primary-btn btn-hover groobear-btn text-bold">
              <i class="lni lni-chevron-left"></i>MENU
            </button>
          </div>
 		<h3>
          ${title}
          <%--<span class="ms-2" style='font-size:18px; color:gray;'>${copyLight}</span>--%>
        </h3>
          
          <%--임시--%>
          <div class="d-flex justify-content-center my-3 position-absolute top-0 start-50 translate-middle" style="transform: translate(-67%, 17%) !important;">
            <span class="badge bg-danger text-white px-4 py-2" style="font-size: 1.2rem; border-radius: 30px;">
              🎥 "${myEmpInfo.emplNm}" 님 화면 시청 중
            </span>
          </div>
          <%--임시--%>

        </div>
      </div>
      
      <div class="col-lg-7 col-md-7 col-6">
        <div class="header-right">
          <!-- notification start -->
          <div class="notification-box ml-15 d-none d-md-flex">
            <button class="dropdown-toggle" type="button" id="notification" data-bs-toggle="dropdown" aria-expanded="false">
              <%--알림 아이콘 --%>
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M11 20.1667C9.88317 20.1667 8.88718 19.63 8.23901 18.7917H13.761C13.113 19.63 12.1169 20.1667 11 20.1667Z" fill=""></path>
                <path d="M10.1157 2.74999C10.1157 2.24374 10.5117 1.83333 11 1.83333C11.4883 1.83333 11.8842 2.24374 11.8842 2.74999V2.82604C14.3932 3.26245 16.3051 5.52474 16.3051 8.24999V14.287C16.3051 14.5301 16.3982 14.7633 16.564 14.9352L18.2029 16.6342C18.4814 16.9229 18.2842 17.4167 17.8903 17.4167H4.10961C3.71574 17.4167 3.5185 16.9229 3.797 16.6342L5.43589 14.9352C5.6017 14.7633 5.69485 14.5301 5.69485 14.287V8.24999C5.69485 5.52474 7.60672 3.26245 10.1157 2.82604V2.74999Z" fill=""></path>
              </svg>
              <span class="d-none"></span>
            </button>
            
            <ul id="notificationList" class="dropdown-menu dropdown-menu-end overflow-y-scroll" aria-labelledby="notification" style="max-height: 75vh">
              <div class="alert alert-light m-2 text-center" role="alert">
                알림이 없습니다.
              </div>
<%--              --%>
<%--              <c:forEach var="hNotice" items="${myEmpInfo.notificationVOList}">--%>
<%--                <li onclick="readNotification(${hNotice.ntcnSn})">--%>
<%--                  <a href="${hNotice.originPath}">--%>
<%--                    <div class="image">${hNotice.notificationIcon}</div>--%>
<%--                    <div class="content">--%>
<%--                      <h6>${hNotice.ntcnSj}</h6>--%>
<%--                      <p>${hNotice.ntcnCn}</p>--%>
<%--                      <span><fmt:formatDate value="${hNotice.ntcnCreatDt}" pattern="YYYY.MM.dd. HH:mm"/></span>--%>
<%--                    </div>--%>
<%--                  </a>--%>
<%--                </li>--%>
<%--              </c:forEach>--%>
            </ul>
          </div>
          <!-- notification end -->
          
          <!-- message start -->
          <div class="header-message-box ml-15 d-none d-md-flex">
            <button class="dropdown-toggle" type="button" id="messageNoti" data-bs-toggle="dropdown"
                    aria-expanded="false">
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path
                  d="M7.74866 5.97421C7.91444 5.96367 8.08162 5.95833 8.25005 5.95833C12.5532 5.95833 16.0417 9.4468 16.0417 13.75C16.0417 13.9184 16.0364 14.0856 16.0259 14.2514C16.3246 14.138 16.6127 14.003 16.8883 13.8482L19.2306 14.629C19.7858 14.8141 20.3141 14.2858 20.129 13.7306L19.3482 11.3882C19.8694 10.4604 20.1667 9.38996 20.1667 8.25C20.1667 4.70617 17.2939 1.83333 13.75 1.83333C11.0077 1.83333 8.66702 3.55376 7.74866 5.97421Z"
                  fill="" ></path>
                <path
                  d="M14.6667 13.75C14.6667 17.2938 11.7939 20.1667 8.25004 20.1667C7.11011 20.1667 6.03962 19.8694 5.11182 19.3482L2.76946 20.129C2.21421 20.3141 1.68597 19.7858 1.87105 19.2306L2.65184 16.8882C2.13062 15.9604 1.83338 14.89 1.83338 13.75C1.83338 10.2062 4.70622 7.33333 8.25004 7.33333C11.7939 7.33333 14.6667 10.2062 14.6667 13.75ZM5.95838 13.75C5.95838 13.2437 5.54797 12.8333 5.04171 12.8333C4.53545 12.8333 4.12504 13.2437 4.12504 13.75C4.12504 14.2563 4.53545 14.6667 5.04171 14.6667C5.54797 14.6667 5.95838 14.2563 5.95838 13.75ZM9.16671 13.75C9.16671 13.2437 8.7563 12.8333 8.25004 12.8333C7.74379 12.8333 7.33338 13.2437 7.33338 13.75C7.33338 14.2563 7.74379 14.6667 8.25004 14.6667C8.7563 14.6667 9.16671 14.2563 9.16671 13.75ZM11.4584 14.6667C11.9647 14.6667 12.375 14.2563 12.375 13.75C12.375 13.2437 11.9647 12.8333 11.4584 12.8333C10.9521 12.8333 10.5417 13.2437 10.5417 13.75C10.5417 14.2563 10.9521 14.6667 11.4584 14.6667Z"
                  fill="" ></path>
              </svg>
              <span class="d-none"></span>
            </button>
            <ul id="chatNotification" class="dropdown-menu dropdown-menu-end" aria-labelledby="message">
              <div class="alert alert-light m-2 text-center" role="alert">
                읽지 않은 채팅이 없습니다.
              </div>
              
<%--              <c:forEach var="hChat" items="${myEmpInfo.chatRoomVOList}">--%>
<%--                <li data-chat-room-no="${hChat.chttRoomNo}">--%>
<%--                  <a href="/chat/list?chatRoomNo=${hChat.chttRoomNo}" target="_blank">--%>
<%--                    <div class="image">--%>
<%--                      <img class="rounded-circle" src="${hChat.proflPhotoUrl}" alt="채팅방 메인 이미지" onerror="this.src='/assets/images/image-error.png'" />--%>
<%--                    </div>--%>
<%--                    <div class="content">--%>
<%--                      <h6>${hChat.emplNm}</h6>--%>
<%--                      <p>${hChat.lastMsg}</p>--%>
<%--                      <span><fmt:formatDate value="${hChat.chttCreatDt}" pattern="MM.dd. HH:mm"/></span>--%>
<%--                    </div>--%>
<%--                  </a>--%>
<%--                </li>--%>
<%--              </c:forEach>--%>
            </ul>
          </div>
          <!-- message end -->
          
          <!-- profile start -->
          <div class="profile-box ml-15">
            <button class="dropdown-toggle bg-transparent border-0" type="button" id="profile"
                    data-bs-toggle="dropdown" aria-expanded="false">
              <div class="profile-info">
                <div class="info">
                  <div class="image">
                    <img src="/upload/${myEmpInfo.proflPhotoUrl}" alt="" />
                  </div>
                  
                  <div>
                    <h6 class="fw-500">
                      ${myEmpInfo.emplNm}
                    </h6>
                    <p>${myEmpInfo.deptNm}</p>
                  </div>
                </div>
              </div>
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profile">
              <li>
                <div class="author-info flex items-center !p-1">
                  <div class="image">
<%--                    <img src="/assets" alt="image">--%>
                  </div>
                  <div class="content">
                    <h4 class="text-sm">${myEmpInfo.emplNm}</h4>
                    <a class="text-black/40 dark:text-white/40 hover:text-black dark:hover:text-white text-xs" href="#">${myEmpInfo.email}</a>
                  </div>
                </div>
              </li>
              <li class="divider"></li>
              <li>
               <sec:authentication property="principal.empVO" var="emp" />
                <a href="/emplDetailHeader?emplNo=${emp.emplNo}">
                  <i class="lni lni-user"></i> 마이페이지
                </a>
              </li>
              <li>
                <a href="/notification/list">
                  <i class="lni lni-alarm"></i> 알림
                </a>
              </li>
              <li>
                <a href="/chat/list"> <i class="lni lni-wechat"></i> 채팅 </a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="/logout"> <i class="lni lni-exit"></i> 로그아웃 </a>
              </li>
            </ul>
          </div>
          <!-- profile end -->
        </div>
      </div>
    </div>
  </div>
</header>