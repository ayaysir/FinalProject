<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
 <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> 
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
 <script src="https://code.jquery.com/jquery-3.3.1.js"></script> 
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<html>
<head>
 
<style>
	@import url(https://fonts.googleapis.com/css?family=Open+Sans:300,400,600);
	@import url(https://use.fontawesome.com/releases/v5.0.8/css/all.css);

	/* Base Styles */
	:root {
		/* Base font size */
		font-size: 10px;
	}
	
	*,
	*::before,
	*::after {
		box-sizing: border-box;
	}
	
	body{
 		 border : 1px solid black; 
		 height:auto;
		 font-family: "Open Sans", Arial, sans-serif;
		 min-height: 100vh;
		 padding-bottom: 3rem;  
	 
	 } 

    #allwrapper{
      height:auto;
   }
    
    #navbar{
        border-bottom: 1px solid #ccc;
        position: fixed;
        z-index: 1;
        width: 100%;
        background-color: #35e0db;
    }
    
    #topwrapper{
        height:72px;
    }
    
    #navcontainer{
        max-width: 1000px;
    }
    
    #search{
        height: 30px;
        border: 0.6px solid #ccc;
        width : 300px;
    }
    
    #instagramicon {
        color: white;
        border-right: 1px solid white;
        padding-right: 13px;
    }
    
    .nav-icon{
        font-size: 25px;    	
        color: white;
    }
    
    .nav-item> a {
        margin-left: 25px;
    }
    
    .navbar-nav {
        flex-direction: row;
    }
    
    @media(max-width: 768px){
        .nav-icon {
            font-size: 20px;
        }
    }
    
    @media(min-width: 430px){
        .logo {
                display: flex !important;
                  flex-basis: auto;
        }
    }
    
    @media(max-width: 411.33px){
        .nav-item> a {
            margin-left: 40px;
        }
    }
    
    .logo{
        display: none;
        flex-grow: 1;
    }

    #contents {
      max-width: 1000px;
      margin-left: auto;
      margin-right: auto;
      display: -webkit-box;
    }

    #centerwrapper {
      height: 100%;
    }
    
        /*컨테이너
*/

    .profile-image {
      width: calc(33.333% - 1rem);
      display: flex;
      margin-right: 3rem;
      align-items: center;
      margin-right: 3rem;
    }

    .profile-image img {
      border-radius: 50%;
    }

    .cock {
      float: left;
    }

    .bookmark {
      float: left;
    }

    .icon {
      font-size:20px;  
      color: black;
      border:0.5px;     
       
    }

    .dot {
      font-size: 7px;
      color: lightgray;
    }

    .dot1 {
      font-size: 10px;
      color: #4FC3F7;
    }

    #contcenter h3 {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      width: 60%;
      height: 25px;
    }

    #comment {
      width: 87%;  
      height: 5%;
      border: none;
      font-size: 17px;
      padding-left: 2%;
      margin-right: 2%;
    }

    #contcenter {
      border-bottom: 0.3px solid lightgray;
    }

    .btn {
      font-size: 15px;
    }

    #peed {
      border: 0.3px solid lightgray;
    }
    
    #board {
      width: 62%;
    }

    #side {  
       
      width: 38%;
    }

    #row {
      display: inline-block
    }

    .col {
      border: 1px solid black;
    }  
    
    .idtxt {   
    font-weight:600;      
    }
      
    .boardimg {  
    max-height:600px;
    }
    
 
}

</style>
</head>

<body>

 
      <div id="topwrapper">
          <nav class="navbar navbar-expand-md navbar-light" id="navbar">
            <div class="container" id="navcontainer">
              <i class="fab fa-instagram fa-2x" id="instagramicon"></i>
              <div class="logo"><a class="navbar-brand ml-2 text-white" href="#">SocialWired</a></div>
              <div class="collapse navbar-collapse">
                <form class="form-inline m-0">
                  <input class="form-control" type="text" placeholder="검색" id="search">
                </form>
              </div>
              <div id="nav-icons">
                <ul class="navbar-nav">
                
                 <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-comment-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#" ><i class="fas fa-pencil-alt nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-compass nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-heart nav-icon"></i></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#"><i class="far fa-user nav-icon"></i></a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
      </div>
    <div id="allwrapper">
      <div id="centerwrapper">
          <div class="container" id="contents">
        <div id="board">
        <c:forEach var="tmp" items="${result}">
          <div class="py-2 my-5 " id="peed">   
            <div class="profile-image"> 	 
              <img class="ml-3 mr-2" src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
              <h5 class="mt-1 idtxt">${tmp.id}</h5> 
            </div>    
            <div class="mt-2" id="boardimg">
      
      <script>  
      var num = Math.floor((Math.random() * 4) + 1);
      var img = "timelineimg/"+num+".PNG"; 
      $("#boardimg:last-child").after("<img src='"+img+"' width='100%' class='boardimg'> ");
      </script> 
             </div>
            <div id="cont">
              <nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
                <div class="container">
                  <a class="navbar-brand" href="#">
               			 
                    <i class="far fa-heart icon mr-1"></i>
                    <i class="far fa-comment icon"></i>
                  </a>
                  <ul class="navbar-nav">
                    <i class="fas fa-circle dot1 "></i>
                    <i class="fas fa-circle dot"></i>
                    <i class="fas fa-circle dot"></i>
                  </ul>
                  <a class="btn navbar-btn ml-2 text-white ">
                    <i class="far fa-bookmark icon"></i> 
                  </a> 
                </div>
              </nav>  
              <div id="contcenter" class="mt-2 mx-3 pb-2"> 
            	<h5 class="mt-1 ml-1 idtxt" id="con">${tmp.id}
				<script>  
				var regex = /(#[^#\s,;]+)/gi  ;             
		    	 var txt = "${tmp.contents}";     
		    	var plus = "";    
		    	  if(txt.length > 48) {
		    		  plus = "<a href=''>더보기</a>";
		    	  }
		    	  var newtxt = txt.replace(regex, "<a href=''>"+"$1"+"</a>");        
		    	  $("#con:last-child").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);	      
			
		    	  
		    	  </script>    
				
              </div>   
              <div class="py-2">     	
                <input type="text" placeholder="댓글 달기..." class="ml-2 pl-2" id="comment">   	  
                <i class="fas fa-ellipsis-h btn mr-3"></i>      
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
        <div class="col-md-6 align-self-center" id="side">
          <br> </div>
      </div>
      </div>

      <div class="pt-4 pb-3  " id="footer">
           <div class="container">
              <div class="row" >
                <div class="col-md-10">
                  <p class="lead">SocialWired 정보지원홍보 센터API채용 정보개인정보처리방침약관디렉터리프로필해시태그언어
</p>
                </div>

                <div class="col-4 col-md-2 align-self-center">
                  <p>@2018SocialWired</p>
                </div>
              </div>
          </div>
      </div>
  </div>
 
</body>

</html>