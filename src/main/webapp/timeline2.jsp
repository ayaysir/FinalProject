<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="include/top.jsp"%>
    <link rel="stylesheet" type="text/css" href="resources/css/timeline.css">

    <script>
    AOS.init();
    function likeit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "like.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_liked : "y"
    		},
    		success : function(resp) {
    			$(e).next().show();
    			$(e).hide();
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }

    function unlikeit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "like.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_liked : "n"
    		},
    		success : function(resp) {
    			$(e).prev().show();
    			$(e).hide();
    			
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }
    function markit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "bookmark.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_marked : "y"
    		},
    		success : function(resp) {
    			$(e).next().show();
    			$(e).hide();
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }

    function unmarkit(e) {
    	var board_seq = $(e).attr("value");
    	$.ajax({
    		url : "bookmark.bo",
    		type : "get",
    		data : {
    			board_seq : board_seq,
    			id : "${sessionScope.loginId}",
    			is_marked : "n"
    		},
    		success : function(resp) {
    			$(e).prev().show();
    			$(e).hide();
    			
    			
    			
    			
    		},
    		error : function() {
    			console.log("에러 발생!");
    			}
    		})
    }
    </script>
<div id="allwrapper">  
      <div class=""id="centerwrapper">
          <div class="container" id="contents">
        <div id="board" >
        
        <script>var num = 1;</script>
        
        <c:forEach var="tmp" items="${result}">
        
          <div class="py-2 my-5" data-aos="fade-up" data-aos-once="true" id="feed">   
            <div class="profile-image"> 	 
              <img class="ml-3 mr-2" src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
<%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
              <br><a class="mt-1 idtxt" id="id" href="board.bo?id=${tmp.id}">${tmp.id}<br>Dangsan.South Korea</a>
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
                  <a class="navbar-brand">
               			 
                    <i value="${tmp.board_seq}" style="cursor: pointer;" id="likeit" class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
                    <i value="${tmp.board_seq}" style="font-weight: bold; color: red; display: none; cursor: pointer;" id="likecancel" class="far fa-heart icon mr-1" onclick="unlikeit(this)"></i>
                    <i class="far fa-comment icon"></i>
                  </a>
                  <ul class="navbar-nav">
                    <i class="fas fa-circle dot1 "></i>&nbsp
                    <i class="fas fa-circle dot"></i>&nbsp
                    <i class="fas fa-circle dot"></i>&nbsp  
                  </ul>
                  <a class="btn navbar-btn ml-2 text-white ">
                    <i value="${tmp.board_seq}" id="mark" class="far fa-bookmark icon" onclick="markit(this)"></i>
                    <i value="${tmp.board_seq}" style="font-weight: bold; color: #28a745; display: none;" id="markcancel" class="far fa-bookmark icon" onclick="unmarkit(this)"></i>
                  </a> 
                </div>
              </nav> 
              
               
              <div id="contcenter" class="mt-2 mx-3 pb-2"> 
				<a class="mt-1 ml-1 idtxt" id="con" href="board.bo">${tmp.id}</a>

				<div class="hidden" id="hidden${tmp.board_seq}">
				
	 		   	<script>
				//   	
				   //	$("#${tmp.board_seq}").click(function() { 
				   		$("#myContents${tmp.board_seq}").attr("style","overflow:visible");  
				  // 	});
				   	
// 				   		var x = document.getElementById("hidden${tmp.board_seq}");
// 					    if (x.style.display === "none") {
// 					        x.style.display = "block";
// 					    } else {
// 					        x.style.display = "none";
// 					    }    
   
					
		    	
					/* function myFunction() {   
					    var x = document.getElementById("hidden${tmp.board_seq}");
					    if (x.style.display === "none") {
					        x.style.display = "block";
					    } else {
					        x.style.display = "none";
					    }
					} */
					
			 /* 	
					var regex = /(#[^#\s,;]+)/gi  ;             
	 		    	var txt = "${tmp.contents}";     
			    	
			    	  var newtxt = txt.replace(regex, "<a href=''>"+"$1"+"</a>");        
	 		    	  $("#con:last-child").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);	        
			 */

				 </script>
				 
		 
				 
				<p id="myContents${tmp.board_seq}">${tmp.contents}

					<script>    
					var plus = "";    
					var txt = "${tmp.contents}";       
			    	  if(txt.length > 48) {                
			    		  plus = "<p id='${tmp.board_seq}' >&nbsp-더보기</p>";
	 		    	  }
			     
					$("#myContents${tmp.board_seq}:last-child").after("</p>"+plus);   			
					
					
				  	
				   	$("#${tmp.board_seq}").click(function() { 
				   		$("#myContents${tmp.board_seq}").attr("style","overflow:visible");  
				   	});
				   	
					</script>
							</div>
							
						<p class="text-info" id="myComment">&nbsp&nbsp모두 14개의 댓글보기</p>
						<div class="comment-contents" id="comment-contents${tmp.board_seq}">   
						
						<!-- 댓글자리 -->
						  
						<c:forEach var="commenttmp" items="${commentresult}">
						<c:choose>      
						<c:when test="${commenttmp.key == tmp.board_seq}">  
						<c:forEach var="comment" items="${commenttmp.value}">
					 
					
						
						
							<ul id="ul${comment.comment_seq}">     
							<li id='li1'><a href="#">${comment.id}</a></li> 
							<li id='li2'>${comment.comment_contents}</li> 
							
							<c:choose>  
							<c:when test ="${sessionScope.loginId == comment.id}">  
							<li id='li3'><a id='commentdel${comment.comment_seq}'>x</a> </li>    
							</c:when>
							</c:choose>
							</ul>
					
				       
				      
				      				<script>  
						    
				      				$("#commentdel${comment.comment_seq}").click(function() {  
				                        $.ajax({
				                                  type: "POST",  
				                                  url: "commentdel.co",    
				                                  data: {comment_seq:${comment.comment_seq}},
				                                  success : function() {
				                                   $("#ul${comment.comment_seq}").remove();  
				                                  }
				                                    
				                             }) //ajax 
				                            
				                        
				                     })    
				            
		
						
						</script>
				      
						</c:forEach>
							</c:when>  
								</c:choose>
								
								
		
						</c:forEach>
					
					
						
						</div>


								</div>
								<!--               -->
								
								
								<div class="py-2">
  

									<input type="hidden" id="board_seq" name="board_seq" value="${tmp.board_seq}"> &nbsp&nbsp&nbsp
									<input type="text" placeholder="댓글 달기..." name="comment_contents${tmp.board_seq}" class="ml-2 pl-2" id="comment${tmp.board_seq}"> 
									
									 <c:choose>
				<c:when test="${result[0].id == sessionScope.loginId}">
              
		          <div class="btn-group bg-white">
		            <button class="btn dropdown-toggle bg-white" data-placement="top"  data-toggle="dropdown"> </button>
		            <div class="dropdown-menu">
		              <a class="dropdown-item" href="#">보관</a>
		              <div class="dropdown-divider" id="modifydiv"></div>
		              <a class="dropdown-item" id="modify" href="#">수정</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" id="modifysubmitbtn" href="#">수정완료</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item"  name=delete id="delete" href="#">삭제</a>
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" href="#">부적절한콘텐츠신고</a>
		            </div>
		          </div>
        
        	<script>
				
			</script>
	         
	         </c:when>
				<c:otherwise>  
					<div class="btn-group bg-white">
		            <button class="btn dropdown-toggle bg-white"  data-placement="top" data-toggle="dropdown"> </button>
		            <div class="dropdown-menu" >
		              <a class="dropdown-item" href="#">보관</a>	              
		              <div class="dropdown-divider"></div>
		              <a class="dropdown-item" href="#">부적절한콘텐츠신고</a> 
		            </div>
		          </div>
		          
		          
				
		           </c:otherwise>
			</c:choose>


								</div>
								
								<script>
						
								$('#comment${tmp.board_seq}').keypress(function(event){
	                                var keycode = (event.keyCode ? event.keyCode : event.which);
	                                if(keycode == '13'){
	                                   
	                                   var text = $("#comment${tmp.board_seq}").val();
	                                   if(text == ""){
	                                      alert("댓글을 입력해주세요");
	                                   }
	                                   else {  
	                                       
	                                      $.ajax({
	                                              type: "POST",  
	                                              url: "comment.co",    
	                                              data: {board_seq:${tmp.board_seq}, comment_contents : text},
	                                              success : function(seq) {
	                                               $("#comment${tmp.board_seq}").val("");        
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul id='ul"+seq+"'><li style='display: inline-block; width:15%'><a href='#'>${sessionScope.loginId}</a></li><li style='display: inline-block; width:69%'>"+text+"</li><li style='display: inline-block; width:15%'><a id='commentdel"+seq+"'>x</a> </li></ul> ")
	                                               

	                                             $("#commentdel"+seq).click(function() {  
	                                                $.ajax({
	                                                          type: "POST",  
	                                                          url: "commentdel.co",    
	                                                          data: {comment_seq:seq},
	                                                          success : function() {
	                                                           $("#ul"+seq).remove(); 
	                                                          }
	                                                            
	                                                     }) //ajax  
	                                                      
	                                                
	                                             })    
	                                 
	                                             
	                                               
	                                               
	                                              }
	                                   
	                                         }) //ajax 
	                                      
	                                   }    
	                                }
	                            }); 
						 		</script>
							</div> <!--cont  -->
						</div> <!-- feed -->
					</c:forEach>
				</div> <!-- board -->
	

        </div>  <!-- container -->
        <div class="col-md-6 align-self-center" id="side">
          <br> 
        </div>
      </div>  <!-- centerwrapper -->
      </div>  <!--  allwrapper-->
      <%@ include file="include/bottom.jsp"%>
  