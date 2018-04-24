<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Training List</title>
</head>
<script>

var flag_YN    = 'N';
var emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var emp_name   = "<%=Session("USER_NAME")%>";
var emp_id     = "<%=Session("User_ID")%>";
var v_language = "<%=Session("SESSION_LANG")%>";

var col_train_cost = 6;
var col_status     = 7;
var col_cancel     = 9;

function BodyInit()
{   
    if (v_language!="ENG")
        System.Translate(document); 
	
	<%=ESysLib.SetGridColumnComboFormat( "grdAdj" , 4 , "select '+','Thu (+)' from dual union select '-','Chi (-)' from dual") %>; 
	OnChangeMonth();
}

 

function OnSearch()
{
    dsohr_chhs00030_s_01.Call("SELECT") ;
}



function OnDataReceive(obj)
{
    switch(obj.id)
    {
          
		case 'dsohr_chhs00030_s_01':
			dsohr_chhs00030_s_03.Call("SELECT");					
		break;
		case 'dsohr_chhs00030_p_04':
			if (txtResult.text == 'Y')
			{
				idBtnClose.SetEnable(false);
				btnAddNew.SetEnable(false);
				btnDelete.SetEnable(false);
				btnSave.SetEnable(false);
				idBtnProcess.SetEnable(false);
			}
		break;
		case 'dsohr_chhs00030_p_06':
			if (txtResult.text == 'Y')
			{
				idBtnClose.SetEnable(false);
				btnAddNew.SetEnable(false);
				btnDelete.SetEnable(false);
				btnSave.SetEnable(false);
				idBtnProcess.SetEnable(false);
				lblAnnoucement.text="Đã khóa sổ";
			}
			else
			{
				idBtnClose.SetEnable(true);
				btnAddNew.SetEnable(true);
				btnDelete.SetEnable(true);
				btnSave.SetEnable(true);
				idBtnProcess.SetEnable(true);
				lblAnnoucement.text="Chưa khóa sổ";
			}
			OnSearch();
					
		break;
    }
}

function OnAddNew()
{	//alert(1)
	grdAdj.AddRow();
	grdAdj.SetGridText(grdAdj.rows - 1 , 2, grdAdj.rows - 1);
	grdAdj.SetGridText(grdAdj.rows - 1 , 8, lstLocation.value);
}
function OnSave()
{
	if(confirm("Bạn có chắc chắn save?"))
	{
		dsohr_chhs00030_s_01.Call();
	}
}
function OnClose()
{
	if(confirm('Bạn có chắc sẽ khóa sổ tháng này ?'))
		dsohr_chhs00030_p_04.Call();
}

function OnProcess()
{
	if(confirm('Bạn sẽ tạm tính doanh thu tháng này ?'))
		dsohr_chhs00030_p_05.Call();
}
function OnChangeMonth()
{
	dsohr_chhs00030_p_06.Call();
}

</script>

<body>
 
 

<gw:data id="dsohr_chhs00030_s_01" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" 
		function="hr_chhs00030_s_01" 
		procedure="hr_chhs00030_u_02"
		parameter="0,1,2,3,4,5,6,7,8"> 
            <input> 
                <input bind="lstLocation" />
                <input bind="dtMonth" /> 
            </input> 
            <output bind="grdAdj" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsohr_chhs00030_s_03" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" 
			parameter="" 
			function="hr_chhs00030_s_03" 
			procedure=""> 
            <input> 
                <input bind="lstLocation" />
                <input bind="dtMonth" /> 
            </input> 
            <output bind="grdBooking" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsohr_chhs00030_p_04" onreceive="OnDataReceive(this)"> 
	<xml> 
	   <dso id="4" type="process" 
		procedure="hr_chhs00030_p_04" >
			<input>
				<input bind="lstLocation" />
				<input bind="dtMonth" />  
				<input bind="txtNote" />  
				
			</input> 
			<output>
				<output bind="txtResult" />
			</output>
		</dso> 
	</xml> 
</gw:data>

<gw:data id="dsohr_chhs00030_p_05" onreceive="OnDataReceive(this)"> 
	<xml> 
	   <dso id="4" type="process" 
		procedure="hr_chhs00030_p_05" >
			<input>
				<input bind="lstLocation" />
				<input bind="dtMonth" />  
				<input bind="txtNote" />  
				
			</input> 
			<output>
				
				<output bind="txtRoomServiceAmt" />
				<output bind="txtAdditionAmt" />
				<output bind="txtDeductionAmt" />
				<output bind="lblTotalIncome" />
			</output>
		</dso> 
	</xml> 
</gw:data>

<gw:data id="dsohr_chhs00030_p_06" onreceive="OnDataReceive(this)"> 
	<xml> 
	   <dso id="4" type="process" 
		procedure="hr_chhs00030_p_06" >
			<input>
				<input bind="lstLocation" />
				<input bind="dtMonth" />  
			</input> 
			<output>				
				<output bind="txtRoomServiceAmt" />
				<output bind="txtAdditionAmt" />
				<output bind="txtDeductionAmt" />
				<output bind="lblTotalIncome" />
				<output bind="txtNote" />
				<output bind="txtResult" />
			</output>
		</dso> 
	</xml> 
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="1" style="background: #BDE9FF">
    <tr height="10%">
        <td style="background: white" colspan="2">
            <table width="100%" border="0">
                <tr>
                    <td width="5%">Địa điểm</td>
                    <td width="15%">
						<gw:list  id="lstLocation"  styles='width:100%' onchange=" " >
							<data>
								<%= ESysLib.SetListDataSQL("select a.location_id,a.location_name from thr_hs_location a  where a.del_if = 0  order by 2 ")%>
							</data>
						</gw:list></td>
                    <td width="5%">Month</td>
                    <td width="6%"><gw:datebox id="dtMonth" maxlen = "10" type="month" styles='width:100%'lang="<%=Session("Lang")%>" onchange="OnChangeMonth()"/> </td>
                    <td width="6%"> </td>
                    <td width="25%">
                         <gw:label id="lblAnnoucement" text="999,999,999" styles="width:100%;height:99%;text-align:center;vertical-align:middle;font-size:18.0pt;color:red;font-weight:600;" />
                    </td>
                     
                    <td width="17%"> </td>
                    <td width="10%"></td>
                    <td width="3%"><gw:imgBtn img="search"   alt="Search"   onclick ="OnSearch()"/></td>
                    <td width="3%"><gw:icon id="idBtnClose"     img="in" text="Đóng sổ"    onclick="OnClose()" /></td>
                    <td width="3%"> </td>
                    <td width="3%"><gw:icon id="idBtnProcess"     img="in" text="Tính doanh thu"    onclick="OnProcess()" /></td>
                    <td width="3%"> </td>
                </tr>
            </table>
        </td>
    </tr>
	<tr height="15%">
        <td width="45%" style="background: white" >             
           <a><gw:label id="lblNote" styles="width:100%;font-size:16px" text="Ghi chú" /></a>
           <gw:textarea id="txtNote" rows="4" styles="width:100%" />
        </td>
        <td width="55%" style="background: white">
             <table height = "100%" width = "100%">
				<tr height="7%">	
					<td width="15%">Tổng phòng + dv</td>
					<td width="20%"><gw:textbox id="txtRoomServiceAmt" text="" style="" /></td>
					<td width="15%">Tổng thu khác</td>
					<td width="20%"><gw:textbox id="txtAdditionAmt" text="" style="" /></td>
					<td width="10%">Tổng chi</td>
					<td width="20%"><gw:textbox id="txtDeductionAmt" text="" style="" /></td> 
				</tr>
				<tr height="8%">
					<td></td>
					<td colspan=2 align=right><gw:label id="lblTotal" text="Tổng doanh thu : " styles="width:100%;height:99%;text-align:center;vertical-align:middle;font-size:18.0pt;color:blue;font-weight:600;" /></td>
					 
					<td colspan=3 align=center><gw:label id="lblTotalIncome" text="999,999,999" styles="width:100%;height:99%;text-align:center;vertical-align:middle;font-size:18.0pt;color:red;font-weight:600;" /></td>
					 
					
				</tr>
			</table>
        </td>
    </tr>
    <tr height="5%">
        <td width="100%" style="background: white" colspan="2">
            <table width="100%" border="0">
                <tr width="100%" >
                    <td width="15%" style="background: white" >Các khoản thu chi:</td>
					<td width="24%" style="background: white" > </td>
					<td width="2%" style="background: white" >
						<gw:imgbtn id="btnAddNew" img="new" alt="Add" onclick="OnAddNew()" />
					</td>
					<td width="2%" style="background: white" >
						<gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
					</td>
					<td width="2%" style="background: white" >
						<gw:imgbtn id="btnSave" img="save" alt="Delete" onclick="OnSave()" />
					</td>
					
                    <td width="55%" align="right"><b style="color: Blue; cursor: hand" ><gw:label id="lbRecord">record(s)</gw:label></b></td>            
                </tr>
            </table>
        </td>
    </tr>    
    
	<tr height="70%">
        <td width="45%" style="background: white" >
            <gw:grid id='grdAdj'
            header='_PK|_Mon|STT|Ngày thu/chi|Chọn kiểu|Số tiền|Nội dung (bắt buộc nhập)|Số tham chiếu|Location'
            format='0|0|0|4|0|-0|0|0|0'
            aligns='0|0|0|0|0|0|0|0|0'
            defaults='|||||||||'
            editcol='1|1|1|1|1|1|1|1|1'
            widths='1000|1200|1000|1200|1500|1500|3000|1500|1500'
            sorting='T'
            styles='width:100%; height:100%'
            oncellclick=''
            />
            
        </td>
        <td width="55%" style="background: white">
            <gw:grid id='grdBooking'
            header='Mã đặt phòng|Tên Khách|Từ ngày|Đến ngày|Tình trạng|Tiền cọc|Phí dịch vụ|Tiền phòng|Còn lại|Tổng thu|Ghi chú|Số lượng phòng|thr_hs_book_m_pk'
            format='0|0|4|4|0|-0|-0|-0|-0|-0|0|0'
            aligns='0|0|0|0|0|0|0|0|0|0|0|0'
            defaults='||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0'
            widths='1500|2000|1200|1200|1200|1200|1200|1200|1200|1200|3000|1500|1200'
            sorting='T'
            styles='width:100%; height:100%'
            />            
        </td>
    </tr> 
	
	
</table>
<gw:textbox id="txtResult" text="" style="display:none" />
</body>