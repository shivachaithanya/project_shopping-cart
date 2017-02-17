<%@page import="java.util.Calendar"%>
<%@ page language="java"
	import="java.sql.*,java.text.*,java.lang.*,java.util.Date,java.io.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<head>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript" src="js/daterangepicker.jQuery.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css">
<link rel="stylesheet" href="css/ui.daterangepicker.css" type="text/css">
<title></title>
<script type="text/javascript">
        function onlyNos(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
            catch (err) {
                alert(err.Description);
            }
        };
        $(function(){
			  
            $(function(){					
             $('#frdate, #todate').daterangepicker({constrainDates: true,arrows: true,datepickerOptions:{yearRange: "-5:+10"}});
			 });		  
			  
        });
        function validateform()
        {
        	 var frmdate = document.getElementById("frdate").value;
             var todate = document.getElementById("todate").value;
             if(frmdate =="" || todate == "") {
                 alert("Please select From and To date");
                 return false;
             }else {
                 return true;
             }
             var location=document.getElementById("location").value;
         	if(location==""){
         		alert("please select location");
         		return false;
         	}
         	else{
         		return true;
         	}
         	var ovtime=document.getElementById("overtime").value;
         	if(ovtime==""){
         		alert("please select overtime");
         		return false;
         	}
         	else{
         		return true;
         	}
         	var workingholiday=document.getElementById("workingholiday").value;
         	if(workingholiday==""){
         		alert("please select workingholiday");
         		return false;
         	}
         	else{
         		return true;
         	}
         	var normalworkinghours=document.getElementById("normalworkinghours").value;
         	if(normalworkinghours==""){
         		alert("please select normalworkinghours");
         		return false;
         	}
         	else{
         		return true;
         	}
             }
    </script>
</head>
<body>
	<form action="" method="post">
		<table align="center">
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>LOCATION:</b>
				</font></td>
				<td><select id="location" name="location">
						<option value="select">--SELECT--</option>
						<option value="telegana">telegana</option>
						<option value="andhrapradesh">andhrapradesh</option>
						<option value="tamilnadu">tamilnadu</option>
						<option value="karnataka">karnataka</option>
				</select></td>
			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>From
							Date</b> </font></td>
				<td><input size="10" type="text" name="rt_frdt" id="frdate"
					readonly="" value="" class="ui-daterangepicker-dateRange">

				</td>

			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>To
							Date</b> </font></td>
				<td><input size="10" type="text" name="rt_todt" id="todate"
					readonly="" value=""
					class="ui-daterangepicker-dateRange __web-inspector-hide-shortcut__">
				</td>

			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>OVERTIME:</b>
				</font></td>
				<td><select id="overtime" name="overtime">
						<option value="select">--SELECT--</option>
						<option value="=">=</option>
						<option value="<="><=</option>
						<option value=">=">>=</option>
				</select> <input type="text" onkeypress="onlyNos(event,this)"></td>
			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>WORKING/HOLIDAYS</b>
				</font></td>
				<td><select id="workingholiday" name="workingholiday">
						<option value="select">--ALL--</option>
						<option value="holday/weeklyoff">HOLIDAY/WEEKLYOFF</option>
						<option value="normalworkingday">NORMALWORKINGDAY</option>
				</select>
			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>NORMALWORKINGHOURS</b>
				</font></td>
				<td><select id="normalworkinghours" name="normalworkinghours">
						<option value="select">--SELECT--</option>
						<option value="=">=</option>
						<option value="<="><=</option>
						<option value=">=">>=</option>
				</select> <input type="text" onkeypress="onlyNos(event,this)"></td>
			</tr>
			<tr>
				<td></td>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					name="submit" value="submit" onclick="return validateform();"></input>
				</td>
			</tr>

		</table>
	</form>
</body>
</html>
