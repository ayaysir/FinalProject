<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>

<link rel="stylesheet" type="text/css" href="resources/css/oneboard.css">
<script>

function commentover(e){   
	var comment_seq = $(e).attr("value");
	$(e).attr("style","background-color:#E1F5FE");
	$("#commentSection"+comment_seq).attr("style","background-color:#E1F5FE");
	$("#commentdel"+comment_seq).html("삭제");
	$("#commentmod"+comment_seq).html("수정");
}
function commentleave(e){
	var comment_seq = $(e).attr("value");
	$(e).attr("style",false);   
	$("#commentSection"+comment_seq).attr("style",false);  
	$("#commentdel"+comment_seq).html("");
	$("#commentmod"+comment_seq).html("");
} 

$(document).ready(function(){
		

$("#comment").keypress(function(event){

	var keycode=(event.keyCode ? event.keyCode : event.which);
	if(keycode=='13'){
		var comment = $("#comment").val();
		
		if(comment==""){
			alert("댓글을 입력해 주세요");
			comment.focus();
			
		}else{
			$.ajax({
				type : "post",
				data : {board_seq : ${b.board_seq}, comment_contents : comment },
				url : "insertComment.co",
				success: function(resp){
								
					$("#comment").val("");
					
				}
					
				
			});
		}
	}
	
});
})
</script>


<div id="allwrapper">
	<div class="" id="centerwrapper">
		<div class="container" id="contents">
		
		<div id="board">
		<div class="py-2 my-5" id="feed">
                  <div class="profile-image">
                     <img class="ml-3 mr-2"
                        src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=30&amp;h=30&amp;fit=crop&amp;crop=faces">
                     <%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
                     <br> 
                     <a class="mt-1 idtxt" id="id" href="#">
                    
						${b.id}
						
                     
                     </a>
                  </div>
                  
		
		<div class="mt-2" id="boardimg">
							<div id="myCarousel0" class="carousel slide" data-ride="carousel"
								data-interval="false" style="height: 600px;">
								<ul id="carousel-indicators" class="carousel-indicators">
									<li id="firstli" data-target="#myCarousel0" data-slide-to="0"
										class="active"></li>
									<c:forEach begin="1" var="media"
										items="${result2[0]}" varStatus="status2">
										<li data-target="#myCarousel0" data-slide-to="${status2.index}"></li>
									</c:forEach>
								</ul>
								<div id="carousel-inner" class="carousel-inner" style="height: 600px;">
									<div id="firstItem" class="carousel-item active">
										<img class='boardimg' width='100%' src='AttachedMedia/${result2[0][0].system_file_name}' alt=''>
									</div> 
									<c:forEach begin="1" var="media"
										items="${result2[0]}">
										<div class="carousel-item">
											<img class='boardimg' width='100%'
												src="AttachedMedia/${media.system_file_name}" alt="">
										</div>
									</c:forEach>

								</div>

								<a id="carousel-prev0" class="carousel-control-prev" href="#myCarousel0"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next0" class="carousel-control-next"
									href="#myCarousel0" data-slide="next"> <span
									class="carousel-control-next-icon"></span>
								</a>
							</div>

						</div>
		
		<div id="cont">
		
		<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
                        <div class="container">
                           <a class="navbar-brand"> 
                                    <i 
                                       style="cursor: pointer; " id="likeit"
                                       class="far fa-heart icon mr-1" onclick="likeit(this)"></i>
                                    <i 
                                       style="font-weight: bold; display: none; color: red; cursor: pointer;"
                                       id="likecancel" class="far fa-heart icon mr-1"
                                       onclick="unlikeit(this)"></i>
                                 <i class="far fa-comment icon"></i>
                           </a>
                           
                           <a class="btn navbar-btn ml-2 text-white "> 
                                    <i  id="mark"
                                       class="far fa-bookmark icon"
                                       style="cursor: pointer; "
                                       onclick="markit(this)"></i>
                                    <i 
                                       style="cursor: pointer; display: none; font-weight: bold; color: #00B8D4;"
                                       id="markcancel"  class="far fa-bookmark icon"
                                       onclick="unmarkit(this)"></i>
                           </a>
                        </div>
                     </nav>
				
		<div id="contcenter" class="mt-2 mx-3 pb-2">
		
		<div class="navbar-nav">
                           <a class="ml-1 idtxt" id="con"
                              href="">${b.id}</a>

                           <div class='pl-3 mt-1' id="contdiv">
                           ${b.contents}
                           </div>
                           
                           
                           <script> 
                           
                           
                           
     /*      var regex = /(#[^#\s,;]+)/gi  ;            
        var txt = "${tmp.contents}";                    
          var newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");        
          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
      $("#contdiv${tmp.board_seq}").html(newtxt);    
        
      function tag(e) {
         var search = $(e).html().split("#")[1]; 
         $(location).attr("href","search.bo?search="+search); 

      }
 */
      </script>
                        </div>
                     
                        <div class="comment-contents" id="comment-contents">
                       
                        <c:forEach var="item" items="${result}">
                          
                        <ul class="commentline navbar-nav"  onmouseover="commentover(this)" value="${item.comment_seq}" onmouseleave="commentleave(this)">
                        <li id="li1"><a href="#">${item.id}</a></li>
                        <li id="li2"><input type=text id="commentSection${item.comment_seq}" value="${item.comment_contents}" readonly="readonly" class='commenttxt'></li>
                        <li id="li3"><a href="" id="commentdel${item.comment_seq}"></a></li>
                        <li id="li4"><a href="" id="commentmod${item.comment_seq}"></a></li>
                        
                        </ul>                       
                        </c:forEach>
                        
                        
                        </div>
                        
		</div> <!-- contcenter -->
		   <div class="crecodiv py-2 navbar-nav">


                      
                           <input type="text" placeholder="댓글 달기..." name="comment_contents" class="creco  ml-2 " id="comment">

                              <div class="btn-group bg-white">
                                 <i id="modalBoardBtn" onclick="modal(this)" class="fas fa-ellipsis-h btn mr-1"
                                    data-toggle="modal"> </i>
                              </div>

                        
                     </div> <!-- crecodiv -->
		
		</div><!-- cont -->
		
		</div> <!--  feed  -->
		
		</div> <!-- id board -->
		
      </div>
      <!-- container -->
      
     
      
   </div>
   <!-- centerwrapper -->
   
</div>
<!--  allwrapper-->
												
      <%@ include file="include/bottom.jsp"%>