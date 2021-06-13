<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>DOCTOR</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<style>
    body {
    background:linear-gradient(rgba(0, 0, 0, 0.5),rgba(0, 0, 0, 0.5)), url(1.jpg);
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: 1300px 700px;
    font-family: 'Open Sans', sans-serif;
    margin: auto;
    color:white;
    font-weight: bold;
}
	.btn{
		margin:0 5px;
	}
	.btn:hover{
		box-shadow:3px 3px 8px #888888;
	}
	.hide{
		display:none;
	}
	.show{
		display:inline-block;
	}
	th,td
{
color:white;
    font-weight: bold;
}
</style>
<body>
	<div class="container">
		<label style="margin-top:30px;">Patient's Status will be displayed here</label>
		<table id="example" class="table" style="margin-top:30px;">
			<thead>
				<tr>
					<th>NAME</th>
					<th>OXYGEN LEVEL</th>
					<th>TEMPERATURE</th>
					<th>HEART BEAT</th>
					<th>BP</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content" style="background-image: url(2.jpg)">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Online Prescription</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <label>Medicine Name</label>
	        <input type="text" class="form-control" id="medicine_name" style="margin:10px 0;" required>
	        <label>Description</label>
	        <textarea id="medicine_description" class="form-control" required></textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-success" id="submit_btn">Submit</button>
	      </div>
	    </div>
	  </div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script>	
		var websocket=new WebSocket("ws://localhost:7007/WebSocketPT/VitalCheckEndPoint");
		websocket.onmessage=function processVital(vital){
			var jsonData=JSON.parse(vital.data);
			if(jsonData.message!=null)
				{
					var details=jsonData.message.split(',');
					var row=document.getElementById('example').insertRow();																																									                                                                                                                                                      							
					//alert(details.length);                                                                         
					var address=details[0]+":"+details[6];
					//0-name
					//6-address
					row.innerHTML="<td>"+details[0]+"</td><td>"+details[1]+"</td>"+"<td>"+details[2]+"</td><td>"+details[3]+"</td><td>"+details[4]+"/"+details[5]+"</td><td><button class=\"btn btn-danger btn-sm\" onclick=\"sendInstructions('"+address+"','ambulance')\">Summon Ambulance</button><button type=\"button\" class=\"btn btn-primary btn-sm\" onclick=\"sendInstructions('"+details[0]+"','medication')\">Suggest Medication</button></td>";
				}
		}
		function sendInstructions(username,message)
		{
			if(message=='medication')
			{
				$('#exampleModal').modal('show');	
				document.getElementById("submit_btn").addEventListener("click",function(){
					var medicine=medicine_name.value;
					var description=medicine_description.value;
					websocket.send(username+','+message+','+medicine+','+description);
					medicine_name.value="";
					medicine_description.value="";
					$('#exampleModal').modal('hide');
				});
			}
			else
			{
				
				websocket.send(username+','+message);
			}
		}
	</script>
</body>
</html>