$(document).on("click","#addCdtBtn",function () {
	
	let around=$("#around-cdt").val();
	let transportaion=$("#transportaion-cdt").val()
	let distance=$("#distance-cdt").val()
	
	if (distance==""){
		$("#check-msg").removeClass("d-none");
	} else {
		$("#check-msg").addClass("d-none");
		let str = `
			<div class="form-check">
			<label class="form-check-label" for="station">
			${around}
			</label>
			<span class="distance-input-box">
			<span class="transportation-input-box">
			${transportaion}
			</span>
			<input class="form-distance distance-input" type="text" value="${distance}">
			분 이내
			</span>
			
			<button id="deleteCdtBtn">
			<img src="img/toDoBtnIcon/deleteBtn.png">
			</button>
			
			</div>
			`;
		$("#around-conditions").append(str);
	}
	                
	
});

$(document).on("click","#deleteCdtBtn",function () {
	$(this).parent().remove();
});

