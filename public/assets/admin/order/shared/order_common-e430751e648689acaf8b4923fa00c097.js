!function(t,e){e.dis=new WebSocketRails(e.location.host+"/websocket"),e.privateChannel=dis.subscribe(t(".userinfo h5").html()),dis.on_open=function(t){console.log("Connection has been established: ",t)},privateChannel.bind("order_detail",function(e){var r=""!==e.order.adult_names?e.order.adult_names.split(";"):[],d=""!==e.order.children_names?e.order.children_names.split(";"):[],n=""!==e.order.infant_names?e.order.infant_names.split(";"):[],o=["Morning","Mid day","Afternoon","Evening"],a=["By money at office","By credit card"];t(".customer_id").html(e.customer.id),t(".customer_group").html(e.customer.group_id),t(".customer_name").html(e.customer.name),t(".customer_phone").html(e.customer.phone),t(".customer_email").html(e.customer.email),t(".order_from").html(e.order.from),t(".order_to").html(e.order.to),t(".order_depart").html(e.order.depart_date+" - "+o[e.order.depart_time_slot]),t(".order_return").html(e.order.return_date+" - "+o[e.order.return_time_slot]||"&nbsp;"),t(".payment_method").html(a[e.order.payment_method]),t(".order_adult_tickets").html(r.length+" adult ticket(s): </br>"+r.join("</br>")),t(".order_children_tickets").html(d.length+" children ticket(s): </br>"+d.join("</br>")),t(".order_infant_tickets").html(n.length+" infant ticket(s): </br>"+n.join("</br>")),t.magnificPopup.open({items:{src:".order-detail",type:"inline"},callbacks:{beforeClose:function(){}}})}),privateChannel.bind("order_filtered",function(e){var r,d,n=t(".footable").data("footable"),o=["<span class='order_status new'>NEW</span>","<span class='order_status viewed'>VIEWED</span>","<span class='order_status sent-email'>SENT EMAIL</span>","<span class='order_status sent-tickets'>SENT TICKETS</span>"];for(t(".footable tbody tr").remove(),r=0,d=e.length;d>r;r++)!function(r){var d=t('<tr class="order_id_'+e[r].id+'"><td>'+e[r].from+"</td><td>"+e[r].to+"</td><td>"+e[r].depart_date+"</td><td>"+(e[r].return_date||"&nbsp;")+"</td><td>"+new Date(e[r].created_at).toLocaleString()+"</td><td>"+o[e[r].status]+'</td><td><button class="view-order view-order btn btn-primary btn-sm"href="#" data-order_id="'+e[r].id+'">View order</button></td><td><button class="preview-email btn btn-primary btn-sm"href="#" data-order_id="'+e[r].id+'">Preview email</button></td><td><button class="send-ticket btn btn-primary btn-sm"href="#" data-order_id="'+e[r].id+'">Send ticket</button></td><td>');n.appendRow(d)}(r)}),t("#start").datepicker({dateFormat:"dd/mm/yy"}),t("#end").datepicker({dateFormat:"dd/mm/yy"}),t(".get-data").click(function(){var e=t("#start").val(),r=t("#end").val(),d=t("#status").val();window.dis.trigger("get_filtered_order_data",{start_time:""===e?null:e,end_time:""===r?null:r,status:""===d?null:d})})}(jQuery,window);