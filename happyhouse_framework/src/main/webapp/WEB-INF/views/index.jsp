<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="header.jsp" %>   
    
<section id="hero">
      <div class="hero-container" data-aos="fade-up">
        <h1>
          <span style="color: rgb(114, 139, 207)"> Welcome to </span>
          <span class="log"
            >Happy<span id="logo-a " style="color: rgb(217, 219, 252)">House</span></span
          >
        </h1>
        <h2></h2>
        <a href="#services" class="btn-get-started scrollto"><i class="bx bx-chevrons-down"></i></a>
      </div>
    </section>
    <!-- End Hero -->

    <main id="main">
  
      <!-- ======= Services Section ======= -->
      <section id="services" class="services">
        <div class="container">
          <div class="section-title" data-aos="fade-in" data-aos-delay="100">
            <h2>서비스 소개</h2>
            <p>원하는 지역의 주택 실거래가 정보를 조회해보세요.</p>
          </div>

          <div class="row">
            <div
              onclick="location.replace('houseDeal?act=goPage')"
              class="company-button col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0"
            >
              <div class="icon-box" data-aos="fade-up">
                <div class="icon"><i class="bx bxl-dribbble"></i></div>
                <h4 class="title"><a href="houseDeal?act=goPage">주택 실거래가 조회</a></h4>
                <p class="description">
                  	원하는 지역을 선택하면 해당 지역의 주택 실거래가 정보를 제공합니다.
                </p>
              </div>
            </div>

            <div
              onclick="location.replace('main?act=store&cmd=mvInterest')"
              class="company-button col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0"
            >
              <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
                <div class="icon"><i class="bx bx-file"></i></div>
                <h4 class="title"><a href="/interest/list">관심지역조회</a></h4>
                <p class="description">
                  	관심 지역을 설정하면 그 지역의 정보를 조회할 수 있습니다.
                </p>
              </div>
            </div>

            <div
              onclick="location.replace('main?act=store&cmd=mvStore')"
              class="company-button col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0"
            >
              <div class="icon-box" data-aos="fade-up" data-aos-delay="200">
                <div class="icon"><i class="bx bx-tachometer"></i></div>
                <h4 class="title"><a href="/interestinfo/store">주변탐방 업종 정보 조회</a></h4>
                <p class="description">관련 동네 업종 정보를 지도를 통해 제공합니다.</p>
              </div>
            </div>

            <div
              onclick="location.replace('main?act=env&cmd=mvEnv')"
              class="company-button col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0"
            >
              <div class="icon-box" data-aos="fade-up" data-aos-delay="300">
                <div class="icon"><i class="bx bx-world"></i></div>
                <h4 class="title"><a href="/interestinfo/env">주변환경 정보 조회</a></h4>
                <p class="description">동네 주변의 환경 정보를 조회할 수 있습니다.</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- End Services Section -->

      <!-- ======= Counts Section ======= -->
      <section id="counts" class="counts section-bg">
        <div class="container">
          <div class="row no-gutters">
            <div class="col-lg-4 col-md-6 d-md-flex align-items-md-stretch">
              <div class="count-box text-center">
                <i class="bi bi-emoji-smile"></i>
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="232"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p><strong>가입자수</strong></p>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 d-md-flex align-items-md-stretch">
              <div class="count-box text-center">
                <i class="bi bi-headset"></i>
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="1463"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p><strong>운영 시간</strong></p>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 d-md-flex align-items-md-stretch">
              <div class="count-box text-center">
                <i class="bi bi-people"></i>
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="2"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p><strong>직원수</strong></p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- End Counts Section -->

      <!-- ======= Cta Section ======= -->
      <section id="cta-beforeLogin" class="cta logoutOnly">
        <div class="container"  data-aos="zoom-in">
          <div class="text-center">
            <h3>회원가입</h3>
            <p>
              HappyHouse의 편리한 서비스들을 제공받기를 원하시면 지금 바로 회원가입을 진행하세요.
            </p>
            <a class="cta-btn" href="user?act=mvregister">회원가입</a>
          </div>
        </div>
      </section>
      <section id="cta" class="cta d-none loginOnly">
        <div class="container" data-aos="zoom-in">
          <div class="text-center">
            <h3>실거래가 정보 조회</h3>
            <p>지금 바로 HappyHouse의 편리한 서비스를 제공받아보세요.</p>
            <a class="cta-btn" href="#">실거래가 정보 조회하기</a>
          </div>
        </div>
      </section>
      <!-- End Cta Section -->

      <!-- ======= Contact Section ======= -->
      <section id="contact" class="contact section-bg">
        <div class="container" data-aos="fade-up">
          <div class="section-title">
            <h2>고객센터</h2>
            <p>서비스에 불만족스러운 부분이 있다면, 소중한 피드백을 저희에게 주십시오.</p>
          </div>

          <div class="row">
            <div class="col-lg-6">
              <div class="info-box mb-4">
                <i class="bx bx-map"></i>
                <h3>회사 주소</h3>
                <p>싸피광역시 싸피동 11-11, 대한민국</p>
              </div>
            </div>

            <div class="col-lg-3 col-md-6">
              <div class="info-box mb-4">
                <i class="bx bx-envelope"></i>
                <h3>이메일</h3>
                <p>contact@happyhouse.co.kr</p>
              </div>
            </div>

            <div class="col-lg-3 col-md-6">
              <div class="info-box mb-4">
                <i class="bx bx-phone-call"></i>
                <h3>콜센터</h3>
                <p>5959-5959</p>
              </div>
            </div>
          </div>

          
        </div>
      </section>
      <!-- End Contact Section -->
    </main>
    <!-- End #main -->
    
<%@ include file="footer.jsp" %>