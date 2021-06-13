<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>PATIENT</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
th,td
{
color:white;
    font-weight: bold;
}
#example{
margin:10px;
}
.iplabel{
margin-left:25px;
}
#bplabel{
margin-right:25px;
}
</style>
</head>
<body>
	<div class="container">
		<label>OXYGEN LEVEL :</label>
		<input class="form-control form-control-sm" type="text" required name="vital" id="vital" style="display:inline-block; width:200px;margin-top:20px;"">
		<label class="iplabel">TEMPERATURE :</label>
		<input class="form-control form-control-sm" type="text" required name="temp" id="temp" style="display:inline-block; width:200px;margin-top:20px;"">
		<label class="iplabel">HEART BEAT :</label>
		<input class="form-control form-control-sm" type="text" required name="heart" id="heart" style="display:inline-block; width:200px;margin-top:20px;"">
		<br>
		<label id="bplabel">BLOOD PRESSURE </label>
		<label class="iplabel">SYSTOLIC :</label>
		<input class="form-control form-control-sm" type="text" required name="BPS" id="BPS" style="display:inline-block; width:200px;margin-top:20px;"">
		<label class="iplabel">DIASTOLIC :</label>
		<input class="form-control form-control-sm" type="text" required name="BPD" id="BPD" style="display:inline-block; width:200px;margin-top:20px;"">
		<label>ADDRESS :</label>
		<input class="form-control form-control-sm" type="text" required name="add" id="add" style="display:inline-block; width:170px;margin-top:20px;"">
		<br /><br />
		<center><button onclick="sendVitals();" class="btn btn-success btn-sm">Submit</button></center>
		<table id="example" class="table">
			<thead>
				<tr>
					<th>Medicine</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
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
				if(details.length>2)
				{
					row.innerHTML="<td>"+details[1]+"</td><td>"+details[2]+"</td>";		
				}
				else
				{
					alert(details[0]+" Summoned an ambulance");
					row.innerHTML="<td>-</td><td>Doctor Summoned an ambulance</td>";	
				}
				
				
			}
		}
		function sendVitals()
		{
			websocket.send(vital.value+","+temp.value+","+heart.value+","+BPS.value+","+BPD.value+","+add.value);
			vital.value="";
			temp.value="";
			heart.value="";
			BPS.value="";
			BPD.value="";
		}
	</script>
</body>
</html>