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
<title>Employee form</title>
<%
	String working = "", overtime = "", year = "", normal = "", num1 = "", num2 = "";
	Date createDate = null;
	String fromdate = "", todate = "";
	boolean work = false;
	boolean over = false;
	boolean norm = false;
	boolean isDateRange = false;
	boolean numb1 = false;
	boolean numb2 = false;
	Calendar currentDate = Calendar.getInstance();
	SimpleDateFormat formatter = new SimpleDateFormat(
			"dd/MM/yyyy HH:mm:ss");
	SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	String dateNow = formatter1.format(currentDate.getTime());
	currentDate.add(Calendar.DATE, -7);
	String prevdate = formatter1.format(currentDate.getTime());

	year = dateNow.substring(6, 10);
	if (request.getParameter("submit") != null) {

		working = (request.getParameter("workingholiday") != null
				? request.getParameter("workingholiday")
				: "");
		normal = (request.getParameter("normalworkinghours") != null
				? request.getParameter("normalworkinghours")
				: "");
		overtime = (request.getParameter("overtime") != null ? request
				.getParameter("overtime") : "");
		num1 = (request.getParameter("number1") != null ? request
				.getParameter("number1") : "");
		num2 = (request.getParameter("number2") != null ? request
				.getParameter("number2") : "");
		if (!working.isEmpty()) {
			work = true;
		} else if (!normal.isEmpty()) {
			norm = true;
		} else if (!overtime.isEmpty()) {
			over = true;
		} else if (!num1.isEmpty()) {
			numb1 = true;
		} else if (!num2.isEmpty()) {
			numb2 = true;
		}
	} else {
		isDateRange = true;
		fromdate = (request.getParameter("rt_frdt") != null ? request
				.getParameter("rt_frdt") : "");
		todate = (request.getParameter("rt_todt") != null ? request
				.getParameter("rt_todt") : "");
	}
%>
<script type="text/javascript">
$(function(){
	  
    $(function(){					
     $('#frdate, #todate').daterangepicker({constrainDates: true,arrows: true,datepickerOptions:{yearRange: "-5:+10"}});
	 });		  
	  
});    
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

        function validateform()
        {
        	 var location=document.getElementById("location").value;
          	if(location==""){
          		alert("please select location");
          		return false;
          	}
          	        	 
          	var frmdate = document.getElementById("frdate").value;
             var todate = document.getElementById("todate").value;
              if(frmdate =="" || todate == "") {
                 alert("Please select From and To date");
                 return false;
             }
         	var overtime=document.getElementById("overtime").value;
         	if(overtime==""){
         		alert("please select overtime");
         		return false;
         	} 	
         	var workingholiday=document.getElementById("workingholiday").value;
         	if(workingholiday==""){
         		alert("please select workingholiday");
         		return false;
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
<style>
#frdate,#todate {
	float: left;
	margin-right: 10px;
}
</style>
</head>
<body>
	<form action="" method="post">
		<table align="center">
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>LOCATION:</b>
				</font></td>
				<td><select id="location" name="location">
						<option value="">--SELECT--</option>
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
						<option value="">--SELECT--</option>
						<option value="=">=</option>
						<option value="<="><=</option>
						<option value=">=">>=</option>
				</select> <input type="text" id="num1" name="number1"
					onkeypress="return onlyNos(event,this)">
				</td>
			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>WORKING/HOLIDAYS</b>
				</font></td>
				<td><select id="workingholiday" name="workingholiday">
						<option value="">--ALL--</option>
						<option value="holday/weeklyoff">HOLIDAY/WEEKLYOFF</option>
						<option value="normalworkingday">NORMALWORKINGDAY</option>
				</select>
			</tr>
			<tr>
				<td><font size="2" face="ARIAL" color="darkblue"><b>NORMALWORKINGHOURS</b>
				</font></td>
				<td><select id="normalworkinghours" name="normalworkinghours">
						<option value="">--SELECT--</option>
						<option value="=">=</option>
						<option value="<="><=</option>
						<option value=">=">>=</option>
				</select> <input type="text" id="num2" name="number2"
					onkeypress="return onlyNos(event,this)"></td>
			</tr>
			<tr>
				<td></td>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					name="submit" value="submit" onclick="return validateform();"></input>
			</tr>
		</table>
	</form>
</body>
</html>
