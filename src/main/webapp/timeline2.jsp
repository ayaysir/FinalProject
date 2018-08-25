<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/top.jsp"%>
<link rel="stylesheet" type="text/css" href="resources/css/timeline.css">
  
<script> var currentId = "${sessionScope.loginId}"; </script>
<script src="resources/js/timeline.js"></script>
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
    
    function commentover(e) { 
    	
	var seq = $(e).attr("value"); 
    var sessionid = $("#sessionid").val();
	var boardid = $("#boardid").val(); 
	var modstate = $("#modstate"+seq).val();    
	
		$("#ul"+seq).attr("style","background-color:#E1F5FE");
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; word-break:break-all background-color:#E1F5FE"); 
		
		if(sessionid == boardid) {       
		$("#commentdel"+seq).html("삭제"); 
		
		if(modstate == "1") {
			$("#commentmod"+seq).html("수정");
		} 
		else if(modstate =="2") {  
			$("#commentmod"+seq).html("완료");
		}
		
		}  
	
    }
   
    function commentleave(e) { 
    	var seq = $(e).attr("value"); 
		 
		$("#ul"+seq).attr("style",false);            
		$("#commenttxt"+seq).attr("style","word-wrap: break-word; word-break:break-all"); 
		$("#commentdel"+seq).html("");   
		$("#commentmod"+seq).html("");
  
    }
    
    function delComment(e) {
			var board_seq = $(e).attr("value").split(":")[0]; 
			var comment_seq = $(e).attr("value").split(":")[1];
        	$.ajax({
                  type: "POST",  
                  url: "commentdel.co",      
                  data: {board_seq:board_seq,comment_seq:comment_seq},
                  success : function(cnt) {
                	console.log(cnt);    
                   $("#ul"+comment_seq).fadeOut(400,function() { $(this).remove(); });   
                   if(cnt>2){ 
                       $("#myComment"+board_seq).html("&nbsp&nbsp모두 "+cnt+"개의 댓글보기")}
                       else {
                    	   $("#myComment"+board_seq).html("");  
                       }
                  }
                    
             }) //ajax 
    }

    function modComment(e) { 
      	 var comment_seq = $(e).attr("value");  
      	 var modstate = $("#modstate"+comment_seq).val();   
		
		
		if(modstate == "1") {
			$("#commentmod"+comment_seq).html("완료");
			 $("#commenttxt"+comment_seq).attr("contentEditable",true);
          	 $("#commenttxt"+comment_seq).attr("style","border:0.5px solid lightgray");
          	 $("#commenttxt"+comment_seq).focus();  
          	
          	 $("#modstate"+comment_seq).val("2");    

		}
		else if(modstate=="2") {
			$("#commentmod"+comment_seq).html("수정");   
			 var txt = $("#commenttxt"+comment_seq).html();
  			 if(txt == ""){
                 alert("댓글을 입력해주세요");
              }
              else {  
            	$.ajax({    
                      type: "POST",    
                      url: "commentmod.co",    
                      data: {comment_seq:comment_seq, comment_contents:txt},   
                      success : function() {
                    	$("#commenttxt"+comment_seq).attr("contentEditable",false);
		                    $("#commenttxt"+comment_seq).attr("style","border:none"); 
		                   $("#commenttxt"+comment_seq).attr("style","background-color:#E1F5FE");
		                   $("#modstate"+comment_seq).val("1");    
		                   $("#ul"+comment_seq).hide().fadeIn(500);  
		                   
                      }  
                 }); //ajax 
                 }
			
		}
      
    }
    
    
    function goBoard(){
    	var board_seq = $("#modalseq").val();
    	
    	$(location).attr('href','oneBoard.do?board_seq='+board_seq);
    }
    	
    function commentdisplay(e) {   
    	var board_seq = $(e).next().val(); 
    	$(".co"+board_seq).attr("style",false);      
    	$("#commenthide"+board_seq).html("접기");    
     
    }
    
    function commenthide(e) {  
    	var board_seq = $(e).next().val(); 
    	$(".co"+board_seq).attr("style","display:none;");    
    	$("#commenthide"+board_seq).html("");
    }
    
    $(document).ready(function(){
    	
    	var globalThisCommentIsFocusedOnFirst = true;
    	
        $("div[id*=comment]").focus(function() {
        	if(globalThisCommentIsFocusedOnFirst){
        		$(this).html("");
            	globalThisCommentIsFocusedOnFirst = false;
        	}
        	
        });
        
        $("div[id*=comment]").focusout(function() {
        	if($(this).text() == ""){
        		$(this).html("<span class=text-muted>댓글 달기...</span>");
        		globalThisCommentIsFocusedOnFirst = true;
        	}
        })
    	
    	function getCaretPosition(editableDiv) {
    	    var caretPos = 0,
    	        sel, range;
    	    if (window.getSelection) {
    	        sel = window.getSelection();
    	        if (sel.rangeCount) {
    	            range = sel.getRangeAt(0);

    	            // console.log("childs: " + range.commonAncestorContainer.parentNode.parentNode.childNodes.length)
    	            if (range.commonAncestorContainer.parentNode.parentNode == editableDiv) {
    	                caretPos = range.endOffset;
    	                // console.log("caretPos: " + caretPos)


    	                var i = range.commonAncestorContainer.parentNode.parentNode.childNodes.length - 1;
    	                var isEqualOrLower = false;
    	                while (i >= 0) {
    	                    if ($(range.commonAncestorContainer.parentNode.parentNode.childNodes[i]).text() !=
    	                        $(range.commonAncestorContainer).text()) {
    	                        i--;
    	                        continue;
    	                    } else {
    	                        while (i >= 0) {
    	                            var $impl = $(range.commonAncestorContainer.parentNode.parentNode.childNodes[i - 1])
    	                            // console.log($impl.text());
    	                            caretPos += $impl.text().length
    	                            i--;
    	                        }
    	                        break;
    	                    }
    	                }

    	            }
    	        }


    	    } else if (document.selection && document.selection.createRange) {
    	        range = document.selection.createRange();
    	        if (range.parentElement() == editableDiv) {

    	            var tempEl = document.createElement("span");
    	            editableDiv.insertBefore(tempEl, editableDiv.firstChild);
    	            var tempRange = range.duplicate();
    	            tempRange.moveToElementText(tempEl);
    	            tempRange.setEndPoint("EndToEnd", range);
    	            caretPos = tempRange.text.length;
    	        }
    	    }

    	    return caretPos;
    	}
    	
    	var update = function () {
    	    $('#caretposition').val(getCaretPosition(this));
    	    console.log(getCaretPosition(this))
    	    console.log(this)
    	};
    	
    	$("div[id*='comment']").on("mousedown mouseup keydown keyup", update);
    	
    	$("div[id*='comment']").keyup(function (e) {

            if ((e.keyCode === 32)) {

                if (parseInt($('#caretposition').val()) == 0) {
                    // alert('뭐?')                        	 
                } else if (parseInt($('#caretposition').val()) == $(this).text().length) {
                    // alert( parseInt($('#caretposition').val()) + ":" +  $('#editorDiv').text().length);
                } else {
                    // alert('임마?')
                    return;
                }

                var regex = /(#[^#\s,;<>. ]+)/gi;
                if (regex) {
                    var newtxt = "<span class=fugue>" + $(this).text()
                        .replace(regex, "</span><span class=text-danger>" + "$1" +
                            "</span><span class=fugue>") + "</span>"

                    // console.log($('#editorDiv').text().length);   
                    // console.log(newtxt)   
                    newtxt += "<kz></kz>"
                    $(this).html(newtxt)
                    var el = this;
                    console.log("childNodes: " + el.childNodes.length);
                    var range = document.createRange();
                    var sel = window.getSelection();
                    range.setStart(el.lastChild, 0);
                    range.collapse(false);
                    sel.removeAllRanges();
                    sel.addRange(range);

                    $(this).focusout();
                    $(this).focus();
                    if (parseInt($('#caretposition').val()) == $(this).text().length) {

                    }

                }
            }
        })
    	
    });
</script>

<div class="" id="allwrapper">
	<input type="hidden" id=caretposition>
	<div class="" id="centerwrapper">
	
		<div class="container " id="contents">
		
			<div id="board">

				<script>var num = 1;</script>

				<c:forEach var="tmp" items="${result}" varStatus="status"> 

					<div class="py-2 my-5" data-aos="fade-up" data-aos-once="true"
						id="feed">
						<div class="profile-image"> 
							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[tmp.id]}'/>">
							<%--               <h5 class="mt-1 idtxt">${tmp.id}</h5>  --%>
							<br> <a class="mt-1 idtxt" id="id"
								href="board.bo?id=${tmp.id}&cat=1">${tmp.id}<br>Dangsan.South
								Korea
							</a>
						</div>
						<div class="mt-2" id="boardimg" >   
<%-- 						  	<input type=hidden id="maxheight${status.index}" value="0"> --%>    
						  	
						  	   
<%-- 						<c:forEach var="media" items="${result2[status.index]}" varStatus="status3"> --%>
										
<%-- 											<img class='boardimg' id="feedimg${status.index}a${status3.index}" width='100%' style="display:none;" --%>
<%-- 												src="AttachedMedia/${media.system_file_name}" alt=""> --%>
										 
										<script>      
										
// 										var height= $("#feedimg${status.index}a${status3.index}").height()
										
// 										var maxheight = $("#maxheight${status.index}").val();
										
										
// 										if(parseInt(maxheight) < height){
											
// 										$("#maxheight${status.index}").val(height);
  
// 										var realmax= $("#maxheight${status.index}").val();   
										 
										
// 										}     
										
// 										var realmax= $("#maxheight${status.index}").val(); 
// 										$("#myCarousel${status.index}").attr("style"," height:"+realmax+"px;");  
										
										</script>
<%-- 									</c:forEach> --%>
									 
						
									
							<div id="myCarousel${status.index}" class="carousel slide"
								data-ride="carousel" data-interval="false"
								>   
								<ul id="carousel-indicators" class="carousel-indicators">
									<li id="firstli" data-target="#myCarousel${status.index}"
										data-slide-to="0" class="active"></li>
									<c:forEach begin="1" var="media"
										items="${result2[status.index]}" varStatus="status2">
										<li data-target="#myCarousel${status.index}"
											data-slide-to="${status2.index}"></li>
									</c:forEach>
								</ul>
<!-- 								<div id="carousel-inner" class="carousel-inner"          -->
<%-- 									style="height:${maxImgHeight[status.index]}px; max-height:700px"> --%>
										<div id="carousel-inner" class="carousel-inner"         
									>  
									<div id="firstItem" class="carousel-item active">      
										<img class='boardimg'  width='100%'
											src='AttachedMedia/${result2[status.index][0].system_file_name}'
											alt=''>  
									</div>
									<c:forEach begin="1" var="media" 
										items="${result2[status.index]}" varStatus="status3">
										<div class="carousel-item" >
											<img class='boardimg'  width='100%'  
												src="AttachedMedia/${media.system_file_name}" alt="">
										</div>  
										
									</c:forEach>

								</div>

								<a id="carousel-prev${status.index}"
									class="carousel-control-prev" href="#myCarousel${status.index}"
									data-slide="prev"> <span class="carousel-control-prev-icon"></span>
								</a> <a id="carousel-next${status.index}"
									class="carousel-control-next" href="#myCarousel${status.index}"
									data-slide="next"> <span class="carousel-control-next-icon"></span>
								</a>
							</div>

						</div>


						<div id="cont">
							<nav class="navbar navbar-expand-md navbar-dark pl-1 py-1 mt-1">
								<div class="container">
									<a class="navbar-brand"> <c:choose>
											<c:when test="${like.containsKey(tmp.board_seq)}">
												<i value="${tmp.board_seq}" style="display: none;"
													id="likeit" class="far fa-heart icon mr-1 pointer"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red;" id="likecancel"
													class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>
											</c:when>
											<c:otherwise>
												<i value="${tmp.board_seq}" id="likeit"
													class="far fa-heart icon mr-1 pointer"
													onclick="likeit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: red; display: none;"
													id="likecancel" class="far fa-heart icon mr-1 pointer"
													onclick="unlikeit(this)"></i>

											</c:otherwise>
										</c:choose> <i class="far fa-comment icon"></i>
									</a> <a class="btn navbar-btn ml-2 text-white "> <c:choose>
											<c:when test="${bookmark.containsKey(tmp.board_seq)}">

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" style="display: none;"
													onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: #00B8D4;" id="markcancel"
													class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:when>
											<c:otherwise>

												<i value="${tmp.board_seq}" id="mark"
													class="far fa-bookmark icon pointer" onclick="markit(this)"></i>
												<i value="${tmp.board_seq}"
													style="font-weight: bold; color: #00B8D4; display: none;"
													id="markcancel" class="far fa-bookmark icon pointer"
													onclick="unmarkit(this)"></i>

											</c:otherwise>
										</c:choose>




									</a>
								</div>
							</nav>



							<div id="contcenter" class="mt-2 mx-3 pb-2">
								<!-- 글내용자리 -->
								<div class="navbar-nav">
									<a class="ml-1 idtxt" id="con${tmp.board_seq}" 
										href="board.bo?id=${tmp.id}&cat=1" style="font-size: 14px; ">${tmp.id}</a>

									<div class='pl-3' id="contdiv${tmp.board_seq}" style="word-wrap: break-word; word-break:break-all"></div>  
									<script>
							           
							  var txt = "${tmp.contents}"; 
							  var regex = /(#[^#\s,;]+)/gi  ; 
							  var newtxt;
								if(txt != null) {
									 newtxt = txt.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");
								}           
					          // $("#contdiv").after("</h5><h4 class='m-1 conttext' style=' overflow: hidden;text-overflow: ellipsis;white-space: nowrap; width:60%;height: 20px;'>"+newtxt+"</h4>"+plus);           
							$("#contdiv${tmp.board_seq}").html(newtxt);    
							  
							function tag(e) {
								var search = $(e).html().split("#")[1]; 
								$(location).attr("href","search.bo?search="+search); 
					
							}

		</script>
								</div>
								<!-- 글내용자리 -->

								<p class="text-info pointer pt-4 mb-1"
									id="myComment${tmp.board_seq}" onclick="commentdisplay(this)"></p>
								<input type=hidden value="${tmp.board_seq}">
								<div class="comment-contents"
									id="comment-contents${tmp.board_seq}">

									<!-- 댓글자리 -->

									<c:forEach var="commenttmp" items="${commentresult}">
										<c:choose>
											<c:when test="${commenttmp.key == tmp.board_seq}">

												<c:if test="${commenttmp.value.size() > 2 }">
													<script>    
                     $("#myComment${tmp.board_seq}").html("&nbsp&nbsp모두 ${commenttmp.value.size()}개의 댓글보기")
                     var num = 0;
                     </script>
												</c:if>

												<c:forEach var="comment" items="${commenttmp.value}">
									
													<ul id="ul${comment.comment_seq}" style="display: none"
														value="${comment.comment_seq}"
														onmouseover="commentover(this)"
														onmouseleave="commentleave(this)"
														class='commentline navbar-nav co${tmp.board_seq}'>
														<li id='li1'><a href="board.bo?id=${comment.id}&cat=1">${comment.id}</a></li>
														<li id='li2'><div
																id='commenttxt${comment.comment_seq}'  
																class='commenttxt txt${tmp.board_seq}'   
																style='word-wrap: break-word; word-break:break-all'>${comment.comment_contents}</div></li>

														<li id='li3'><a id='commentdel${comment.comment_seq}'
															value="${tmp.board_seq}:${comment.comment_seq}"
															onclick="delComment(this)" class="pointer"></a></li>
														<li id='li4'><a id='commentmod${comment.comment_seq}'
															value="${comment.comment_seq}" onclick="modComment(this)"
															class="pointer"></a></li>

												   </ul>
                                       <script>
                                       var text = $("#commenttxt${comment.comment_seq}").html();  
                           var regex = /(#[^#\s,;]+)/gi  ;            
                               var newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");          
                                $("#commenttxt${comment.comment_seq}").html(newtxt);
                           </script>
                                       
                                       <input type=hidden id='modstate${comment.comment_seq}' value="1">
													<script>
							$("#ul${commenttmp.value[0].comment_seq}").attr("style",false);
							$("#ul${commenttmp.value[1].comment_seq}").attr("style",false);
							</script>

												</c:forEach>

											</c:when>
										</c:choose>

									</c:forEach>
								</div>
								<p class="text-info pointer pt-3 pl-1"
									id="commenthide${tmp.board_seq}" onclick="commenthide(this)"></p>
								<input type=hidden value="${tmp.board_seq}">
							</div>



							<!--               -->


							<div class="crecodiv pl-2 py-2 navbar-nav">



<%-- 								<input type="text" placeholder="댓글 달기..."
									name="comment_contents${tmp.board_seq}" class="creco ml-2 "
									id="comment${tmp.board_seq}"> --%>
									
									<div contenteditable=true class="creco ml-2" id="comment${ tmp.board_seq }"><span class=text-muted>댓글 달기...</span></div>
								
								<div class="btn-group bg-white">
									<i id="modalBoardBtn${tmp.board_seq}"
										value="${tmp.board_seq}:${tmp.id}" onclick="modal(this)"
										class="fas fa-ellipsis-h btn mr-1" data-toggle="modal"> </i>
								</div>


							</div>

							<script>
						
					
								$('#comment${tmp.board_seq}').keypress(function(event){
	                                var keycode = (event.keyCode ? event.keyCode : event.which);
	                                if(keycode == '13'){
	                                   var text = $("#comment${tmp.board_seq}").text();
	                                   if(text == ""){
	                                      alert("댓글을 입력해주세요");
	                                   }
	                                   else {  
	                                      $.ajax({ 
	                                              type: "POST",  
	                                              url: "comment.co",    
	                                              data: {board_seq:${tmp.board_seq}, comment_contents : text},
	                                              success : function(seq) {       
	                                            	  $('#comment${tmp.board_seq}').html("");
	                                              /*  $("#comment${tmp.board_seq}").val("");   */  
	                                              var regex = /(#[^#\s,;]+)/gi  ;            
                                              var newtxt = text.replace(regex, "<a onclick='tag(this)' style='color:red ; cursor: pointer;'>"+"$1"+"</a>");          
                                            
                                                   
	                                               $("#comment-contents${tmp.board_seq}").prepend("<ul class='navbar-nav commentline co${tmp.board_seq}' id='ul"+seq+"' value='"+seq+"' onmouseover='commentover(this)' onmouseleave='commentleave(this)'><li id='li1' ><a href='board.bo?id=${sessionScope.loginId}'>${sessionScope.loginId}</a></li><li id='li2'><div id='commenttxt"+seq+"' style='word-wrap: break-word; word-break:break-all' class='commenttxt'>"+newtxt+"</div></li><li id='li3'><a id='commentdel"+seq+"' onclick='delComment(this)' value='${tmp.board_seq}:"+seq+"' class='pointer'></a> </li><li id='li4'><a id='commentmod"+seq+"' value='"+seq+"' onclick='modComment(this)'  class='pointer'></a></li></ul>"
	                                            		   +"<input type=hidden id='modstate"+seq+"' value='1'>");
	                                               $("#ul"+seq).hide().fadeIn(500);  
	                            				  }
		                                     }); //ajax 
		                                   }    
		                                }  
		                            }); 
							 

						 		</script>    
						</div>
						<!--cont  -->
					</div>
					<!-- feed -->
					<script>
					if("${result2[status.index].size()}" == 1) {
   						$("#carousel-prev${status.index}").hide();
						$("#carousel-next${status.index}").hide();
    	        	   }else {
    	        		   $("#carousel-prev${status.index}").show();
    	        		   $("#carousel-next${status.index}").show();
    	        	   }
					</script>
				</c:forEach>
			</div>
			<!-- board -->
			
			
	
			
		
			
			<div style="position:fixed;border-radius: 1px;">	
				
				  <div class="container" id="float" style="width:300px;margin-top:55px;margin-left:30px;"> 
				  <br>
				  <div class="profile-image"> 
						<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[sessionScope.loginId]}'/>">	  				
						<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${sessionScope.loginId}&cat=1">${sessionScope.loginId}</a>
						
				 </div>		 
		   
				  <hr class="_5mToa">	      				         
				    <p class="text-center" style="font-family:'HelveticaNeue','Arial', sans-serif;font-size:15px;"><a id="followprev" style="color:#919191;" class="pointer pr-3">◀</a>추천 Follow를 추가하세요!!<a id="follownext" style="color:#919191" class="pointer pl-3">▶</a></p>
				  <hr class="_5mToa">  
				  
				    
				    <c:forEach  begin="0" end="${follow_size}" varStatus="status">
<!-- 				      <div id="followContainer" class="myslides">   -->
				      
<%-- 				    	<c:forEach var="followtmp" items="${result3}" varStatus="memstatus" begin="parseInt(${status})" end=""> --%>
				   
<%-- 					  <div class="container recommendmem" id="follow${memstatus.index}">  --%>
<!-- 					    <div class="profile-image">  -->
<%-- 							<img class="ml-3 mr-2 pic" src="AttachedMedia/<c:out value='${profile_pic[followtmp.targetId]}'/>">  	   --%>
<%-- 							<a class="mt-6 idtxt"  style="font-size:16px; font-family:'HelveticaNeue','Arial', sans-serif;" href="board.bo?id=${followtmp.targetId}">${followtmp.targetId}</a>						 --%>
<!-- 				 		</div>				 			       -->
<!-- 					  </div> -->
					  
<%-- 					  </c:forEach> --%>
<!-- 					  </div>	 -->
					</c:forEach>  
					
					<hr class="_5mToa">
				</div> 
				
				

				<!-- <script>
				var slideIndex = 0;
				carousel();
 
				function carousel() {
				    var i;
				    var x = $(".myslides");  
				    for (i = 0; i < x.length; i++) {
				      x[i].style.display = "none"; 
				    }
				    slideIndex++;
				    if (slideIndex > x.length) {slideIndex = 1} 
				    x[slideIndex-1].style.display = "block"; 
				    setTimeout(carousel, 2000); 
				}
				</script> -->
			
				
				
				
				 <div class="pt-4 pb-3  " id="footer" style="font-size:5px;margin-left:20px;">
		           <div class="container">
		              <div class="row" >
		                <div class="col-md-10">
		                  <p>SocialWired.정보.지원.홍보.채용</p>
		                  <p>정보개인정보처리방침 .약관.디렉터리.프로필.해시태그언어  </p>
		                  <p>@2018SocialWired</p>
		                </div>
		              </div>
		           </div>
     			 </div>
					
			</div>	 
		 

		</div>
		<!-- container -->
		
	</div>
	<!-- centerwrapper -->
</div>
<!--  allwrapper-->


<div class="modal fade" id="changeBoardModal" tabindex="-1"
	role="dialog"></div>

<div class="modal" id="changeBoardModal2" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<input type=hidden id=modalseq>
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">신고</h4>
			</div>
			<div class="modal-body">
				<a class="dropdown-item mo" onclick="">폭력 또는 폭력 위협</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">마약 판매 및 홍보</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">괴롭힘 및 따돌림</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">지적 재산권 침해</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item mo" onclick="">스스로 신체적 상해를 입히는 행위</a>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="reportModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<input type=hidden id=modalid>
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">신고</h4>
			</div>
			<div class="modal-body">
				<div style="text-align: left;">
					<p style="color: #262626; font-weight: 600; margin-bottom: 8px;">편파적
						발언 또는 상징으로 신고할까요?</p>
					<p style="margin-bottom: 8px;">삭제 대상:</p>
					<ul style="list-style-type: disc; margin: 0 0 8px 0;">
						<li style="margin-bottom: 8px;">나치 상징(하켄크로이츠)이나 백인 우월주의를 나타내는
							손 모양 등 편파적 발언 또는 상징에 관한 사진</li>
						<li style="margin-bottom: 8px;">폭력을 조장하거나 사람의 정체성을 바탕으로 공격하는
							내용의 게시물</li>
						<li style="margin-bottom: 8px;">신체적 상해, 절도 또는 기물 파손에 대한 협박</li>
					</ul> 
					<p style="margin-bottom: 8px;">다른 사람의 게시물을 신고해도 신고자에 대한 정보는
						공개되지 않습니다.</p>
					<p style="margin-bottom: 8px;">누군가 위급한 위험 상황에 처해 있다면 신속하게 현지 응급
						서비스 기관에 연락하세요.</p>
					<button type="button" class="btn btn-primary" style="width: 100%">제출</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>

<%@ include file="include/bottom.jsp"%>
