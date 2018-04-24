<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%  ESysLib.SetUser("hr")%>
</head>

<script>

var pk= 0,
p_close= 1,
p_org= 2,
p_id =3,
p_full=4,
p_Ability= 5,
p_Ability_Result= 6,
p_behaviour_w= 7,
p_behaviour_p= 8,
p_behaviour_Safe= 9,
p_behaviour_total= 10,
p_QSS_point= 11,
p_QSS_remark= 12,
p_Reward= 13,
p_Reward_remark= 14,
p_Total = 15;
var binit=true;

function BodyInit()
{
    var data="";
	     txtEva_Emp_PK.text = "<%=session("EMPLOYEE_PK")%>";
     data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);    
    datLoadEvaData.Call();
	
}
function OnSearch()
{
  
}
function OnPrint()
{
  
}


function auto_resize_column(obj,col1,col2,font_size)
{
  
}
function OnDataReceive(obj){
   
}
function OnChangeMaster(){
    datLoadEvaData.Call();
   
}
function TotalItem()
 {
    
 }

function OnSave()
{ 
}

function OnShowPopup()
{     
}

</script>
<style type="text/css">
TABLE {
	FONT-WEIGHT: normal; FONT-SIZE: 13px; COLOR: #000000; FONT-STYLE: normal; FONT-FAMILY: tahoma, verdana, arial, helvetica
}
TR {
	FONT-WEIGHT: normal;height:30pt; FONT-SIZE: 13px; COLOR: #323232; FONT-STYLE: normal; FONT-FAMILY: tahoma, verdana, arial, helvetica
}
td   		{ font-size:13pt; font-family: "Tahoma"; font-weight:bold;} 

select {  font-family: "Tahoma"; font-size:13pt!important; }
</style>
<body>
    
	<!------------------------------------------------------>
<gw:data id="datLoadEvaData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_eva_per" > 
                <input >
                    <input bind="txtEva_Emp_PK" /> 
                    <input bind="lstEvaMaster" /> 
                   
                </input>
                <output >
                    <output bind="lblName" /> 
                    <output bind="lblID" /> 
                    <output bind="lblOrg" /> 
					<output bind="lblGroup" /> 
					<output bind="lblJoindt" /> 
					<output bind="lblPosition" /> 
					<output bind="lblJob" /> 
					<output bind="lblEvaName" /> 
					<output bind="lblAbilityP" /> 
					<output bind="lblXeploai" /> 
					<output bind="lblHr1" /> 
					<output bind="lblHr2" /> 
					<output bind="lblHr3" /> 
					<output bind="lblHrTotal" /> 
					<output bind="lblQSS" /> 
					<output bind="lblQSSRemark" /> 
					<output bind="lblKT" /> 
					<output bind="lblKTRemark" /> 
					<output bind="lblTotal" /> 
					
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
	
    <table  border=1 align="center">
        <tr style="width: 100%; height: 0%">
           <td style="width: 10%;"></td><td style="width: 10%;"></td><td style="width: 10%;"></td>
		   <td style="width: 10%;"></td><td style="width: 10%;"></td><td style="width: 10%;"></td>
		   <td style="width: 10%;"></td><td style="width: 10%;"></td><td style="width: 10%;"></td>
		   <td style="width: 10%;"></td>
        </tr>
		<tr >
		 <td  colspan="5" align="right" border=0 >
		Thời điểm đánh giá 	  
		 </td>
		 <td  colspan="5" align="left" border=0 >
		 <gw:list id="lstEvaMaster" onchange="OnChangeMaster()" styles="width:100px" />
		 </td>
		 
		</tr>
		<tr >
		 <td colspan=2>Họ tên:</td>
		 <td colspan=4 align="center">
		 <gw:label id="lblName" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" />
		 </td>
		 <td colspan=2>Mã số:</td>
		 <td colspan=2 align="center"><gw:label id="lblID" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="222222222" /></td>
		</tr>
		
		<tr >
		 <td colspan=2>Bộ phận:</td>
		 <td colspan=4 align="center">
		 <gw:label id="lblOrg" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" />
		 </td>
		 <td colspan=2>Nhóm:</td>
		 <td colspan=2 align="center"><gw:label id="lblGroup" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="222222222" /></td>
		</tr>
		
		<tr >
		 <td colspan=2>Ngày vào:</td>
		 <td colspan=8 align="center">
		 <gw:label id="lblJoindt" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" />
		 </td>
		 
		</tr>
		
		<tr >
		 <td colspan=2>Chức vụ:</td>
		 <td colspan=4 align="center">
		 <gw:label id="lblPosition" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" />
		 </td>
		 <td colspan=2>Chức trách:</td>
		 <td colspan=2 align="center"><gw:label id="lblJob" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		
		<tr >
		 <td colspan=2>Người đánh giá:</td>
		 <td colspan=8 align="center">
		 <gw:label id="lblEvaName" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" />
		 </td>
		 
		</tr>
		<tr style="width: 100%; ">
		<td colspan=10 ><font color="blue">I. Đánh giá năng lực(60 điểm)</font></td>
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Điểm</td>
			<td colspan=2 align="center"> <gw:label id="lblAbilityP" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
			<td colspan=3>+ Xếp loại</td>
			<td colspan=2 align="center"> <gw:label id="lblXeploai" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		
		<tr style="width: 100%; ">
		<td colspan=10 ><font color="blue">II. Đánh giá nhân sự (20 điểm)</font></td>
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Thái độ làm việc(6 điểm)</td>
			<td colspan=2 align="center"> <gw:label id="lblHr1" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
			<td colspan=5 rowspan=3 align="center" ><gw:label id="lblHrTotal" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
			
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Thái độ chính sách(10 điểm)</td>
			<td colspan=2 align="center"> <gw:label id="lblHr2" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Nhận thức an toàn(4 điểm)</td>
			<td colspan=2 align="center"> <gw:label id="lblHr3" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		
		<tr style="width: 100%; ">
		<td colspan=10 ><font color="blue">III. Tham gia QSS(10 điểm)</font></td>
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Điểm</td>
			<td colspan=2 align="center"> <gw:label id="lblQSS" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
			<td colspan=5 align="center"> <gw:label id="lblQSSRemark" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		
		<tr style="width: 100%; ">
		<td colspan=10 ><font color="blue">IV. Khen thưởng (10 điểm)</font></td>
		</tr>
		<tr style="width: 100%; ">
			<td colspan=3>+ Điểm</td>
			<td colspan=2 align="center"> <gw:label id="lblKT" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
			<td colspan=5 align="center"> <gw:label id="lblKTRemark" styles='color:red;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		<tr style="width: 100%; ">
		<td colspan=8 ><font color="green">***Tổng điểm</font></td>
		<td colspan=2 align="center"> <gw:label id="lblTotal" styles='color:green!important;width:100%;font-weight: bold;font-size:16'  text="aaaaaaaaa" /> </td>
		</tr>
		
    </table>
    <gw:textbox id="txtEva_Emp_PK" styles="display:none" />
    <gw:list id="lstEvaluator" onchange="OnSearch()" styles="display:none" />
    
</body>
</html>
