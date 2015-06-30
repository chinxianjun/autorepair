////隐藏添加流程信息表单
////var hideAddWorkflowForm = function(){
////	$('#J-add-workflow').fadeOut(300, function(){
////		document.getElementById('J-add-workflow-form').reset();
////		$('.add-workflow-btn').parent().show();
////		$('#J-add-workflow-container').animate({height : 0}, 300);
////	});
////};
//
////新建流程
//var addWorkflow = function(){
////	$('.add-workflow-btn').click(function(){
////		$(this).parent().hide();
////		var targetH = $('#J-add-workflow').outerHeight();
////		$('#J-add-workflow-container').animate({height : targetH}, 300, function(){
////			$('#J-add-workflow').fadeIn(300);
////		});
////	});
//	$('#J-add-workflow-form').submit(function(e){
//		e.preventDefault();
//        var ccustomer = $('#J-add-workflow input[name="customer_name"]');
//        var cphone = $('#J-add-workflow input[name="customer_phone"]');
//		var cfaultplace = $('#J-add-workflow input[name="fault_place"]');
//		var cfaultcarnumber = $('#J-add-workflow input[name="fault_car_number"]');
//		var cfaultdestcription = $('#J-add-workflow textarea[name="fault_description"]');
//        var customer_id = $('#J-workflow_customer_id').val();
//
//		if($.trim(cfaultplace.val()).length === 0){
////			showErrorTip(cfactory, '请配件名称', cfactory);
//            alert('请填写故障地点');
//            return false;
//		}else if($.trim(cfaultcarnumber.val()).length === 0){
////			showErrorTip(ckind, '请填写车型', ckind);
//            alert('请填写故障车牌号');
//            return false;
//		}else if($.trim(cfaultdestcription.val()).length === 0){
////			showErrorTip(cmanager, '请填写经理名', cmanager);
//            alert('请填写故障描述');
//            return false;
//		}else{
//			$.ajax({
//				type: 'GET',
//				url: '/workflows/new?customer_id=' + customer_id,
//				//dataType: 'json',
//				cache: false,
//				data: $('#J-add-workflow-form').serializeArray(),
//				success: function(data){
//					var result = data.workflow;
//                    var customer = data.customer;
//                    var faultdesc = data.faultdesc
//
//					if(result.creator.length > 0){
//
//						var temp = ['<li><div class="workflow-item clrfix">' +
//                            '<span class="customer">',customer.username,'</span>' +
//                            '<span class="phone">',customer.phone,'</span>' +
//                            '<span class="workflowDate">',result.created_at,'</span>' +
//                            '<span class="workflowCreator">',result.creator,'</span>' +
//                            '<span class="workflowStatus">',result.status,'</span>' +
//                            '<span class="tool" id="J-c-',result.id,'">' +
//                            '<a href="#" class="edit-workflow" rel="',customer.username,'|',customer.phone,'|',result.created_at,'|',result.creator,'|',result.status,'|',faultdesc.place,'|',faultdesc.car_number,'|',faultdesc.description,'">编辑</a><a href="#" class="delete-workflow">删除</a></span></div><div class="workflowEditor"></div></li>'].join('');
//						$('.workflow-list').append(temp);
////						hideAddWorkflowForm();
////						editWorkflow();
//					}
//				}
//			});
//		}
//	});
//	$('button.add-workflow-cancel').click(function(e){
//		e.preventDefault();
//		hideAddWorkflowForm();
//	});
//};
//
////隐藏编辑购车信息表单
////var hideEditWorkflowForm = function(){
////	document.getElementById('J-edit-workflow-form').reset();
////	$('.editing_workflow').prev().show();
////	$('#J-edit-workflow').hide();
////	$('.editing_workflow').css('height', 0);
////	$('.editing_workflow').removeClass('editing_workflow');
////
////};
//
////编辑购车信息
////var editWorkflow = function(){
////    var ccustomer = $('#J-edit-workflow input[name="contact_name"]');
////    var cphone = $('#J-edit-workflow input[name="phone"]');
////    var cworkflowdate = $('#J-edit-workflow input[name="workflowDate"]');
////    var cworkflowcreator = $('#J-edit-workflow input[name="workflowCreator"]');
////    var cfaultplace = $('#J-edit-workflow input[name="fault_place"]');
////    var cfaultcarnumber = $('#J-edit-workflow input[name="fault_car_number"]');
////    var cfaultdescription = $('#J-edit-workflow textarea[name="fault_description"]');
////
////    var workflow_id = $('#J-edit-workflow input[name="workflow_id"]');
////    var ccustomer_id = $('#J-edit-workflow input[name="customer_id"]');
////
////	$('a.edit-workflow').click(function(e){
////		e.preventDefault();
////		if($('.editing_workflow').length !== 0){
////			hideEditWorkflowForm();
////		}
////		var editfrm = $('#J-edit-workflow');
////		var container = $(this).parents('.workflow-item').next();
////		var cinfo = $(this).attr('rel').split('|');
////		container.addClass('editing_workflow').append(editfrm);
////		editfrm.show();
////		var targetH = editfrm.outerHeight();
////		$(this).parents('.workflow-item').hide();
////
////		container.animate({height: targetH}, 300, function(){
////			ccustomer.val(cinfo[0]);
////            cphone.val(cinfo[1]);
////            cworkflowdate.val(cinfo[2]);
////			cworkflowcreator.val(cinfo[3]);
////			cfaultplace.val(cinfo[5]);
////			cfaultcarnumber.val(cinfo[6]);
////            cfaultdescription.val(cinfo[7]);
////            workflow_id.val(cinfo[8]);
////		})
////	});
////
////	$('#J-edit-workflow-form').submit(function(e){
////		e.preventDefault();
////		var cur = $('.editing_workflow');
////		var created_at = cur.prev().children('.workflowDate');
////		var creator = cur.prev().children('.workflowCreator');
////		var faultplace = cur.prev().children('.fault_place');
////		var faultcarnumber = cur.prev().children('.fault_car_number');
////		var faultdescription = cur.prev().children('.fault_description');
////
////		if($.trim(cfaultplace.val()).length === 0){
//////			showErrorTip(cfactory, '请配件名称', cfactory);
////            alert('请填写故障地点');
////            return false;
////		}else if($.trim(cfaultcarnumber.val()).length === 0){
//////			showErrorTip(ckind, '请填写车型', ckind);
////            alert('请填写故障车牌号');
////            return false;
////		}else if($.trim(cfaultdescription.val()).length === 0){
//////			showErrorTip(cmanager, '请填写经理名', cmanager);
////            alert('请填写故障描述');
////            return false;
////		}else{
////			$.ajax({
////				type: 'GET',
////				url: '/workflows/' + workflow_id.val() + '/edit',
////				//dataType: 'json',
////				cache: false,
////				data: $('#J-edit-workflow-form').serializeArray(),
////				statusCode: {
////                    200: function(data){
////                        var result = data;
////                        //var result = data;
////                        if(result.creator.length > 0){
////                            faultplace.text(cfaultplace);
////                            faultcarnumber.text(cfaultcarnumber.val());
////                            faultdescription.text(cfaultdescription.val());
////
////                            hideEditWorkflowForm();
////                        }
////                    },
////                    422: function(){
////                        alert("ERROR:422, 内部数据错误,无法提交表单.");
////                    }
////				}
////			});
////		}
////	});
////	$('button.edit-workflow-cancel').click(function(e){
////		e.preventDefault();
////		hideEditWorkflowForm();
////	});
////};
//
//
//$(document).ready(function(){
////    editWorkflow();
//    addWorkflow();
////    hideAddWorkflowForm();
////    hideEditWorkflowForm();
//});