
<%@page import="java.util.Calendar"%>
<%@ page language="java" import="java.sql.*,java.text.*,java.lang.*,java.util.Date,java.io.*,javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean class="hpora.ProdConnection" id="con1" scope="page" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css">
        <link rel="stylesheet" href="css/ui.daterangepicker.css" type="text/css">

        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/date.js"></script>
        <script type="text/javascript" src="js/daterangepicker.jQuery.js"></script>
        <script type="text/javascript">	
            $(function(){
				  
                $(function(){					
                 $('#frdate, #todate').daterangepicker({constrainDates: true,arrows: true,datepickerOptions:{yearRange: "-5:+10"}});
				 });		  
				  
            });
            
            function validateform() {
                var appno = document.getElementById("app_no_id").value;
                if(appno!="") {
                    if(appno.substring(0,2)!="HP") {
                        alert("Please enter valid HP Application no. starting with HP");
                        return false;
                    }else if(appno.length!=10) {
                       alert("Please enter valid HP Application no. of 10 characters");
                        return false; 
                    }
                    document.getElementById("hide_app_no_id").value=appno;
                    return true;
                    
                }else {
                var frmdate = document.getElementById("frdate").value;
                var todate = document.getElementById("todate").value;
                if(frmdate =="" || todate == "") {
                    alert("Please select From and To date");
                    return false;
                }else {
                    return true;
                }
                }
            }
        </script>
		<style>
		  #frdate,#todate { float: left; margin-right: 10px; }
		</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
   
	   TD {font-size: 10pt; 
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:wrap;}
	   </style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vendor Online Payment Report</title>
</head>
<body bgcolor="#fff">
<table width="100%" border=0 cellspacing=1 cellpadding=4>
<tr>
<%
String paymentStat="",year="",validHideHPAppNo="";
boolean validHPAppNo=false;
Date createDate=null;
Connection con = null;
int fy=0;
Statement statQurSt =null;
ResultSet statQurRs=null,paymentreportQurRs = null;
PreparedStatement paymentreportQurPs = null;
String fromdate="",todate=""; 
 boolean isDateRange = false;
  

try {
Calendar currentDate = Calendar.getInstance();
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
SimpleDateFormat formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String dateNow = formatter1.format(currentDate.getTime());
currentDate.add(Calendar.DATE, -7);
String prevdate = formatter1.format(currentDate.getTime());
  
  year = dateNow.substring(6, 10); 
  if(request.getParameter("submit")!=null ) {
      validHideHPAppNo = (request.getParameter("hide_app_no")!=null?request.getParameter("hide_app_no"):"");
      if(!validHideHPAppNo.isEmpty()) {
          validHPAppNo = true;
      }else {   
       isDateRange = true;	  
       fromdate = (request.getParameter("rt_frdt")!=null?request.getParameter("rt_frdt"):"");
       todate = (request.getParameter("rt_todt")!=null?request.getParameter("rt_todt"):"");
       paymentStat = (request.getParameter("paymentstat")!=null?request.getParameter("paymentstat"):"");
      }
     }else {
      fromdate = prevdate;
      todate =dateNow;
      paymentStat="SUCCESS";
  }
 
  
%>
<td align=center> <B><h4 style="background-color:antiquewhite"><u> <font  size="6px"> Vendor Registration Online Payment Report</font></u></B></h4></td>
</tr>
</table>
<center>
    <form name="vendor_online_pay_report" action="" method="post">
<table width="50%" align="center" border="0">

	<tbody>
            <tr>
                <td><font size="2" face="ARIAL" color="darkblue"><b>Enter vendor HP Application No.: </b></font></td>
                <td><input type="text" size="10" name="app_no" id="app_no_id" value=""></td>
            <script>
                        document.getElementById("app_no_id").value='<%=validHideHPAppNo%>';
                    </script>
                <input type="hidden" name="hide_app_no" id="hide_app_no_id" value=""></input>
            </tr>
            
            <tr>
                <td colspan="2" align="center"><font>OR</font></td>
            </tr>
            
            <tr>
                <td><font size="2" face="ARIAL" color="darkblue"><b>Select Online payment status: </b></font></td>
                <td><select name="paymentstat" id="paymentstatid">
                        <option value="All">All</option>
                        <%
                          String statQur= "select distinct(paymentstatus) from paymentdetails";
                          try {
                          con = con1.conn();
                          statQurSt = con.createStatement();
                          statQurRs = statQurSt.executeQuery(statQur);
                          while(statQurRs.next()) {
                        %>
                        <option value="<%=statQurRs.getString(1)%>"><%=statQurRs.getString(1).toUpperCase()%></option>
                        <% } 
                          }catch(Exception ex) {
                          }
  %>
                    </select>
                    <script>
                        document.getElementById("paymentstatid").value='<%=paymentStat%>';
                    </script>
                </td>
            </tr>
            
            <tr> 

		<td>
	        <font size="2" face="ARIAL" color="darkblue"><b>From Date</b></font>
		</td>
		<td> 
			
			<input size="10" type="text" name="rt_frdt" id="frdate" readonly="" value="" class="ui-daterangepicker-dateRange">
			
		</td>

	</tr>
	<tr>
	<td>
			<font size="2" face="ARIAL" color="darkblue"><b>To Date</b></font>
		</td>
		<td> 
			
				<input size="10" type="text" name="rt_todt" id="todate" readonly="" value="" class="ui-daterangepicker-dateRange __web-inspector-hide-shortcut__">					
		</td>			
		
	</tr>
        <tr>
            <td colspan="2" align="center"><input type="submit" name="submit" value="submit" onclick="return validateform();"></input></td>
        </tr>
</tbody></table>
    </form>
</center>
                    <br>
                    <center><h2 style="background-color:gainsboro"><u>
                        <%if(validHPAppNo) {%>
                        <font  size="5px">  Vendors Online Payment Report for HP Application No. <b><%=validHideHPAppNo%></b>   </font>
                        <% } else { %>
                        <font  size="5px">  Vendors Online Payment Report for Payment Status: <b><%=paymentStat%></b> between <b><%=fromdate%></b> and <b><%=todate%></b>  </font>
                        <% } %>
                            </u> </h2>
                    </center>
                    <br>
<center>
<table width=100% >

<tr>
<td align= center bgcolor='#306EFF'  > <font color= white>Sl. No.</td>
<td align= center bgcolor='#306EFF'  > <font color= white>HP Application No.</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Transaction Reference No.</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Transaction Amount</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Payment Request Date </td>
<td align= center bgcolor='#306EFF'  > <font color= white>Payment Response Date</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Merchant Transaction Id</td>
<td align= center bgcolor='#306EFF'  > <font color= white>SBI PayRef No</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Bank Code</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Bank Reference No.</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Payment Status</td>
<td align= center bgcolor='#306EFF'  > <font color= white>Reason</td>
<td align= center bgcolor='#306EFF'  > <font color= white>T+1 status</td>
</tr>
<%
  
 String paymentreportQur ="";
      if(validHPAppNo) {
         paymentreportQur = "select application_no,transrefno,amount,paymentrequestdate,paymentresponsedate,merchanttxnid,sbipayrefno,bankcode,bankrefno,paymentstatus,reason from paymentdetails where application_no=? order by paymentrequestdate desc";
           paymentreportQurPs = con.prepareStatement(paymentreportQur); 
            paymentreportQurPs.setString(1, validHideHPAppNo);
      }else if(paymentStat.equals("All")) {  
           paymentreportQur = "select application_no,transrefno,amount,paymentrequestdate,paymentresponsedate,merchanttxnid,sbipayrefno,bankcode,bankrefno,paymentstatus,reason from paymentdetails where paymentrequestdate  between to_date(to_char(?),'DD-MON-YYYY') and  to_date(to_char(?),'DD-MON-YYYY HH24:MI:SS') order by paymentrequestdate desc";
           paymentreportQurPs = con.prepareStatement(paymentreportQur);
           paymentreportQurPs.setString(1, fromdate);
           paymentreportQurPs.setString(2, todate + "23:59:59");
           
       }else {
           paymentreportQur = "select application_no,transrefno,amount,paymentrequestdate,paymentresponsedate,merchanttxnid,sbipayrefno,bankcode,bankrefno,paymentstatus,reason from paymentdetails where paymentstatus = ? and paymentrequestdate between  to_date(to_char(?),'DD-MON-YYYY') and  to_date(to_char(?),'DD-MON-YYYY HH24:MI:SS') order by paymentrequestdate desc";
           paymentreportQurPs = con.prepareStatement(paymentreportQur);
           paymentreportQurPs.setString(1, paymentStat);
           paymentreportQurPs.setString(2, fromdate);
           paymentreportQurPs.setString(3, todate + "23:59:59");
       }
       paymentreportQurRs = paymentreportQurPs.executeQuery();
       long count=1;

String application_no ="",merchanttxnid="",bankcode="",bankrefno="",paymentstatus="",reason="";
long transrefno=0;
Long sbipayrefno;
Date paymentrequestdate=null,paymentresponsedate=null;
double amount = 0.0;

	while(paymentreportQurRs.next()) {	
	   application_no = paymentreportQurRs.getString(1).trim();
           transrefno = paymentreportQurRs.getInt(2);
           amount = paymentreportQurRs.getDouble(3);
           paymentrequestdate = paymentreportQurRs.getTimestamp(4);
           paymentresponsedate = paymentreportQurRs.getTimestamp(5);
           merchanttxnid = paymentreportQurRs.getString(6)!=null?paymentreportQurRs.getString(6).trim():"";
           sbipayrefno = paymentreportQurRs.getLong(7);
           bankcode = paymentreportQurRs.getString(8)!=null?paymentreportQurRs.getString(8).trim():"";
           bankrefno = paymentreportQurRs.getString(9)!=null?paymentreportQurRs.getString(9).trim():"";
           paymentstatus = paymentreportQurRs.getString(10).trim();
           reason = paymentreportQurRs.getString(11)!=null?paymentreportQurRs.getString(11).trim():"";
           epay.EpayRefundWS_Service service = new epay.EpayRefundWS_Service();
	   epay.EpayRefundWS port = service.getEpayRefundWSPort();	
	   String payoutrequest = "105|ORDER|"+sbipayrefno.toString();;	
	   String result = port.getpayoutstatus(payoutrequest);
	
	
	%>
	<tr>
	<td align= center bgcolor='#e6e6e6'><%=count %></td>
	<td align= center bgcolor='#e6e6e6'><%=application_no %></td>
	<td align= center bgcolor='#e6e6e6'><%=transrefno %></td>
      
	<td align= center bgcolor='#e6e6e6'><%=amount %></td>
	<td align= center bgcolor='#e6e6e6'><%=formatter.format(paymentrequestdate)%></td>
        <% if(paymentresponsedate!=null) { %>
	<td align= center bgcolor='#e6e6e6'><%=formatter.format(paymentresponsedate) %></td>
        <% }else { %>
        <td align= center bgcolor='#e6e6e6'></td>
        <% } %>
	<td align= center bgcolor='#e6e6e6'><%=merchanttxnid %></td>
          <% if(sbipayrefno!=0) {%>
	<td align= center bgcolor='#e6e6e6'><%=sbipayrefno %></td>
        <% }else { %>
        <td align= center bgcolor='#e6e6e6'></td>
        <% } %>
	<td align= center bgcolor='#e6e6e6'><%=bankcode %></td>      
        <td align= center bgcolor='#e6e6e6'><%=bankrefno %></td>
        <td align= center bgcolor='#e6e6e6'><%=paymentstatus %></td>
        <td align= center bgcolor='#e6e6e6'><%=reason %></td>
         <td align= center bgcolor='#e6e6e6'><%=result %></td>
	</tr>


<%
        count++;
        }
        
}catch(Exception ex) {
    out.println("Exception:" + ex);
}finally{
    if(statQurSt!=null) {
        statQurSt.close();
    }
    if(statQurRs!=null) {
        statQurRs.close();
    }
    if(paymentreportQurPs!=null) {
        paymentreportQurPs.close();
    }
    if(paymentreportQurRs!=null) {
        paymentreportQurRs.close();
    }
}
///rs2.close();
//rs1.close();
//ps2.close();
//ps1.close();

%>
<%
 if(isDateRange) {
 	  %>
	  <script>
	  document.getElementById("frdate").value='<%=fromdate%>';
	  document.getElementById("todate").value='<%=todate%>';
	  </script>
	  
 <% }
%>
</table>
</center>
<br><br>



</body>
</html>