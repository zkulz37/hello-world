<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>


var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 


function BodyInit()
{          
    setInterval("window.clipboardData.clearData()",20);
    tmp_id.text="<%=session("EMP_ID")%>";
    lblName2.text = "<%=session("EMP_ID")%>" + "-" +  "<%=session("USER_NAME")%>";
    datPayslip.Call();
}


//-----------------------------------------------
function OnDataError(oData)
{
  //alert(eval(oData).errmsg);
    if (eval(oData).errno == 20001)
    {
		alert("Database problem 1: "+ eval(oData).errmsg);
    }
    else if (eval(oData).errno == 20002)
    {
		alert("Database problem 2: "+ eval(oData).errmsg);
    }
	else if (eval(oData).errno > 0)
	{
		alert("Unexpected error: "+ eval(oData).errmsg);
	}	
	
}

</script>
<body bgcolor='#F5F8FF'>
<!--ko cho in noi dung -->
<style media="print">
body {
display : none;
}
</style>
<!---------------------main employee tab data control------------------>
 
 <gw:data id="datPayslip" onreceive=""  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_payslip_posco" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="tmp_id" />
                </input> 
                <output>
                    <output bind="nm1" /> 
                    <output bind="nm2" />
                    <output bind="nm3" />
                    <output bind="nm4" />
                    <output bind="nm5" />
                    <output bind="nm6" />
                    <output bind="nm7" />
                    <output bind="nm8" />
                    <output bind="nm9" />
                    <output bind="nm10" />
                    <output bind="nm11" /> 
                    <output bind="nm12" />
                    <output bind="nm13" />
                    <output bind="nm14" />
                    <output bind="nm15" />
                    <output bind="nm16" />
                    <output bind="nm17" />
                    <output bind="nm18" />
                    <output bind="nm19" />
                    <output bind="nm20" />
                    <output bind="nm21" /> 
                    <output bind="nm22" />
                    <output bind="nm23" />
                    <output bind="nm24" />
                    <output bind="nm25" />
                    <output bind="nm26" />
                    <output bind="nm27" />
                    <output bind="nm28" />
                    <output bind="nm29" />
                    <output bind="nm30" />
                    <output bind="nm31" /> 
                    <output bind="nm32" />
                    <output bind="nm33" />
                    <output bind="nm34" />
                    <output bind="nm35" />
                    <output bind="nm36" />
                    <output bind="nm37" />
                    <output bind="nm38" />
                    <output bind="nm39" />
                    <output bind="nm40" />
                    <output bind="nm41" /> 
                    <output bind="nm42" />
                    <output bind="nm43" />
                    <output bind="nm44" />
                    <output bind="nm45" />
                    <output bind="nm46" />
                    <output bind="nm47" />
                    <output bind="nm48" />
                    <output bind="nm49" />
                    <output bind="nm50" />
                    <output bind="nm51" /> 
                    <output bind="nm52" />
                    <output bind="nm53" />
                    <output bind="nm54" />
                    <output bind="nm55" />
                    <output bind="nm56" />
                    <output bind="nm57" />
                    <output bind="nm58" />
                    <output bind="nm59" />
                    <output bind="nm60" />
                    <output bind="nm61" /> 
                    <output bind="nm62" />
                    <output bind="nm63" />
                    <output bind="nm64" />
                    <output bind="nm65" />
                    <output bind="nm66" />
                    <output bind="nm67" />
                    <output bind="nm68" />
                    <output bind="nm69" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<form name="Main E" id="form1" >
     <table id="main"  cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
            <tr style="height:1%">
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                    <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
            </tr>
            <tr style="height:auto">
                    <td colspan=20  style="border:0; text-align:right" ><gw:label id="lblName1"  text="WORK MON" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:20" /></td>
                    <td colspan=10  style="border:0; text-align:right"><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>"  onchange="datPayslip.Call()"/></td>
                    <td colspan=40 style="border:0;text-align:center"><gw:label id="lblName2"  text="" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:20" /></td>
                    <td colspan=15   style="border:0; text-align:right"><gw:label id="lblName111"  text="THỰC NHẬN" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:20" /></td>
                    <td colspan=25   style="border:0; text-align:center"><gw:textbox  id="nm69" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:20" /></td>
             </tr>
             <tr style="height:auto">
                    <td colspan=20  style="border:0; text-align:right" ><gw:label id="lblName3"  text="Ngày Vào" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=10  style="border:0; text-align:right"><gw:label id="nm1"  text="" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=25 style="border:0; text-align:right"><gw:label id="lblName4"  text="Bộ phận" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=45 style="border:0; text-align:center"><gw:label id="nm2"  text="" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                   
             </tr>
             <tr style="height:auto">
                    
                    <td colspan=16  style="border:0; text-align:right" ><gw:label id="lblName5"  text="Lương cơ bản" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm3" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm4" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName6"  text="Lương CB trả thêm" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm5" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm6" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName7"  text="Lương CB vận hành" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm7" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=9 style="border:0; text-align:right"><gw:textbox  id="nm8" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    
             </tr>
             <tr style="height:auto">
                    <td colspan=16  style="border:0; text-align:right" ><gw:label id="lblName9"  text="P/C trách nhiệm" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm9" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm10" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName10"  text="T/C đi lại" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm11" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm12" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName11"  text="T/C chuyên cần" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm13" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=9 style="border:0; text-align:right"><gw:textbox  id="nm14" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
             </tr>
             <tr style="height:auto">
                    
                    
                    <td colspan=16  style="border:0; text-align:right" ><gw:label id="lblName12"  text="T/C điện thoại" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm15" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8  style="border:0; text-align:right"><gw:textbox  id="nm16" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName13"  text="T/C tiếng hàn" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm17" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm18" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=16 style="border:0; text-align:right"><gw:label id="lblName114"  text="T/C chức vụ" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=8 style="border:0; text-align:right"><gw:textbox  id="nm19" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=9 style="border:0; text-align:right"><gw:textbox  id="nm20" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
             </tr>
              <tr style="height:auto">
                    <td colspan=100  style="border:0; text-align:center" ><gw:label id="lbla1"  text="CHI TIẾT THANH TOÁN LƯƠNG" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:20" /></td>
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName14"  text="Giờ Làm việc:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm21" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm22" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm23" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName15"  text="Nghỉ phép năm:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm24" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm25" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm26" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName16"  text="Nghỉ Lễ:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm27" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm28" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=9 style="border:0"><gw:textbox  id="nm29" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    
                   
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName17"  text="Nghỉ không lương:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm30" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm31" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm32" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName18"  text="Tăng ca 1.5:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm33" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm34" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm35" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName19"  text="Tăng ca 2.0:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm36" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm37" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=9 style="border:0"><gw:textbox  id="nm38" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                   
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName20"  text="Tăng ca 3.0:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm39" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm40" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm41" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName21"  text="P/C đêm 0.3:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm42" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=1 style="border:0; text-align:center"><b>-</b></td>
                    <td colspan=5  style="border:0"><gw:textbox  id="nm43" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center">(H)</td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm44" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName22"  text="P/c Trách Nhiệm:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm45" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName23"  text="T/C đi lại:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm46" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName24"  text="T/C Chuyên cần:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm47" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName25"  text="T/C cơm:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm48" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName26"  text="T/C độc hại:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm49" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName27"  text="T/C chức vụ:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm50" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName28"  text="T/C điện thoại:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm51" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName29"  text="T/C tiếng hàn:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm52" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName30"  text="T/C khác:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm53" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName31"  text="Bù lương:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm54" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName32"  text="PN thôi việc:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=6 style="border:0; text-align:center"></td>
                    <td colspan=5 style="border:0; text-align:center"><gw:textbox  id="nm55" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center"><b>(D)</b></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm56" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName33"  text="T/C thôi việc:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=6 style="border:0; text-align:center"></td>
                    <td colspan=5 style="border:0; text-align:center"><gw:textbox  id="nm57" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=2 style="border:0; text-align:center"><b>(M)</b></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm58" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName34"  text="Tiền Thưởng:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm59" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                    <td colspan=100  style="border:0; text-align:center" ><gw:label id="lbla"  text="CÁC KHOẢN KHẤU TRỪ" maxlen = "100" styles="color:black;width:100%;font-weight: bold;font-size:20" /></td>
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName35"  text="BHXH:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm60" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName36"  text="BHYT:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm61" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName37"  text="BHTN:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm62" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName38"  text="Trừ thẻ BH:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm63" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName39"  text="Trừ tiền ĐT:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm64" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName40"  text="Trừ khác:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm65" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
                    
             </tr>
             <tr style="height:auto">
                   
                    <td colspan=12  style="border:0; text-align:right" ><gw:label id="lblName41"  text="Thuế TN:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm66" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName42"  text="Truy thu PIT:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=13 style="border:0; text-align:center"></td>
                    <td colspan=8 style="border:0"><gw:textbox  id="nm67" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>
                    <td colspan=12 style="border:0; text-align:right"><gw:label id="lblName43"  text="P/N còn lại:" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td colspan=11 style="border:0; text-align:center"></td>
                    <td colspan=11  style="border:0"><gw:textbox  id="nm68" type="number" format="#,###,###,###.##R" text="" styles="width:100%;font-weight: bold;font-size:13" /></td>                    
             </tr>
                    
                    
                </table>
            </td>
        </tr>
    </table>
</form> 

<gw:textbox  id="tmp_id" text="" styles="display:none" />  
</body>



