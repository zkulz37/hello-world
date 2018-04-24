<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script>
var emp_id = "<%=Session("LOGIN_ID")%>";
function BodyInit()
{
    BindingDataList();
}
//---------------------------------------------------------------------------------------------
function BindingDataList()
{
    System.Translate(document);
        

    var ls_company   = "<%=ESysLib.SetListDataSQL("SELECT 0 C1,'<All>' C2  FROM DUAL UNION ALL SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    //var ls_type     = "<=ESysLib.SetListDataSQL("SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACBG0020' AND A.USE_IF = 1 AND CODE IN ('21', '22', '23') ORDER BY ORD")%>";
    
    var ls_lang     = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('COAB0070') FROM DUAL")%>";
    
   // var ls_Loai     = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0014') FROM DUAL")%>";
   var ls_Loai = "<%=ESysLib.SetListDataSQL("SELECT B.CODE, B.CODE_NM  FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK and b.code='96'  AND A.ID = 'GFQC0014' AND a.del_if = 0 AND b.del_if = 0 ")%>";
    var ls_quy     = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0015') FROM DUAL")%>";
    var ls_date     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL")%>";
    var ls_month    = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-1), 'YYYYMM') FROM DUAL")%>";
    
    var ls_date_fr  = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
    var ls_date_to  = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD') FROM DUAL")%>";
    
    lstThang.SetDataText(ls_quy);
    
    ls_trsdate      = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL")%>";
    
    txt_date.text   = ls_trsdate;
  
    txtScale.SetDataText('1');
    lstCompany.SetDataText(ls_company);
    lstCompany.value = "<%=session("company_pk") %>";
   // txtFinancialType.SetDataText("90");
    lstLang.SetDataText(ls_lang);
    lstLang.SetDataText('VIE');
    var data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
    arr  = data.split("|");
    lstLoai.SetDataText(ls_Loai);
    lstLoai.value = '96'; 
    txtScale.GetControl().focus();
    OnChangeDateType();
    txtuser.text = "<%=Session("LOGIN_ID")%>";
    
     var data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
    arr  = data.split("|");
	lblBookccy.text = arr[1];
	GridFormat();
//	alert(arr[1]);

}

//-------------------------------------------------
function GridFormat()
{
    var fg = grid_bs.GetGridControl();
  //  fg.ColFormat(1) = "###,###"; 
    fg.ColFormat(2) = "###,###"; 
	fg.ColFormat(3) = "###,###"; 
	fg.ColFormat(4) = "###,###"; 
}
//---------------------------------------------------------------------------------------------
function OnChangeDateType()
{
    CalculateFTDate();
    var quater = lstThang.GetData();
    var yyyy = dtfrdate.text.substr(6,4);
    var mmyyyy = dtfrdate.text.substr(3,7);
    var acc_mmyyyy = dtfrdate.GetData();
    acc_mmyyyy = System.AddDate(acc_mmyyyy,-365);
    acc_mmyyyy = acc_mmyyyy.substr(4,2) +"/"+ acc_mmyyyy.substr(0,4);
    //alert(acc_mmyyyy)
   
        if(lstLoai.GetData() == '96')
        {
            txtDateType.text = "M";
            lblDateType.text = "Tháng";
            dtMonth.style.display = "";
            dtYear.style.display = "none";
            lstThang.style.display = "none";
        }
        else if(lstLoai.GetData() == '95')
        {
            txtDateType.text = "Q";
            lblDateType.text = "Quý";
            dtMonth.style.display = "none";
            dtYear.style.display = "";
            lstThang.style.display = "";
        }
       
}
//---------------------------------------------------------------------------------------------
function CalculateFTDate(){
    //1:Month, 2:Quater, 3:Year
    var yyyymm,yyyy, mm, quater;
    //month
    if(lstLoai.GetData() == '96'){
        yyyymm = dtMonth.GetData();
        yyyy = yyyymm.substr(0,4);
        mm = yyyymm.substr(4,2);
        dtfrdate.SetDataText(yyyy+mm+"01");
        dttodate.SetDataText(yyyy+mm+LastDayOfMonth(yyyymm));
    }
    //quater
    else if(lstLoai.GetData() == '95'){
        yyyy = dtYear.GetData();
        quater = lstThang.GetData();
        if(quater == 1){
            dtfrdate.SetDataText(yyyy + "0101");    
            dttodate.SetDataText(yyyy + "0331");    
        }
        else if(quater == 2){
            dtfrdate.SetDataText(yyyy + "0401");    
            dttodate.SetDataText(yyyy + "0630");    
        }
        else if(quater == 3){
            dtfrdate.SetDataText(yyyy + "0701");    
            dttodate.SetDataText(yyyy + "0930");    
        }
        else if(quater == 4){
            dtfrdate.SetDataText(yyyy + "1001");    
            dttodate.SetDataText(yyyy + "1231");    
        }
    }
    //year
  
    //onSearch();
}
//---------------------------------------------------------------------------------------------
function LastDayOfMonth(p_yyyymm){
    mm = p_yyyymm.substr(4,2);
    yyyy = p_yyyymm.substr(0,4);
    mm = parseInt(mm,10);
    switch(mm)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
          return 31;
          break;
        case 4:
        case 6:
        case 9: 
        case 11:
        return 30;
          break;
        default: 
        if((yyyy%4 == 0)&&(yyyy%100 > 0)){
            return 29;
        }
        else
        {
            return 28;
        }
    }
    return -1;//invalid month
}
//---------------------------------------------------------------------------------------------
function OnChangeMonth(){
   
    OnChangeDateType();
}
//---------------------------------------------------------------------------------------------
function OnChangeQuater(){
    
    OnChangeDateType();
}
//---------------------------------------------------------------------------------------------
function OnChangeYear(){
    
    OnChangeDateType();
}
//---------------------------------------------------------------------------------------------
function onSearch()
{
    dso_sel_grid.Call("SELECT");
}
//---------------------------------------------------------------------------------------------
function trim(str)
{    if(!str || typeof str != 'string') 
       return null;    
       return str.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
}
//---------------------------------------------------------------------------------------------
function onReport(lang)
{
    var r,f_nm;
    switch(lang)
    {
        case "VIE":
         
            var  url='/reports/gf/os/gfos00170.aspx?Report_Type=' + txt_report_type.text + '&status=' + rbstatus.value + '&Company_pk=' + lstCompany.GetData() + '&From=' + dtfrdate.GetData() + '&To=' + dttodate.GetData() + '&Date_type=' + txtDateType.text + '&Scale='+ txtScale.GetData() + '&Thang=' + dtMonth.GetData() + '&user=' + txtuser.text;  
             System.OpenTargetPage( System.RootURL+url , "newform" );
            
         
//          else
//          {
//               var  url='/reports/gf/os/gfos00140_thang.aspx?kind='+lstLoai.GetData()+'&status='+rbstatus.value+'&company='+lstCompany.GetData()+'&from='+dtfrdate.GetData() + '&to='+ dttodate.GetData()+ '&date_type='+txtDateType.GetData()+"&scale="+txtScale.GetData()+ '&month=' + dtMonth.GetData() + '&user=' + txtuser.text + '&quy=' + lstThang.value + '&donvi=' + lblBookccy.text + '&nam=' + dtYear.GetData();  
//             System.OpenTargetPage( System.RootURL+url , "newform" );
//          }
           break;
     }    
             
       
}
//---------------------------------------------------------------------------------------------
function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}
//---------------------------------------------------------------------------------------------
function onSetMonth(p_bool)
{
    if (p_bool)
    {
        dtfrdate.style.display = '';
        dttodate.style.display = '';
        //dtfrmonth.style.display = 'none';
        //dttomonth.style.display = 'none';
    }
    else
    {
        dtfrdate.style.display = 'none';
        dttodate.style.display = 'none';
        //dtfrmonth.style.display = '';
        //dttomonth.style.display = '';
    }
}
//--------------------------------------------------------------------
function ChangeColor()
{
    var ctrl = grid_bs.GetGridControl();
   
    for (i = 1; i < ctrl.Rows; i++)
	{
	    if(grid_bs.GetGridData(i,5)== "B")
        {
	        ctrl.Cell(14, i, 0, i, 4) = false;
	        grid_bs.SetCellBold(i, 0, i, 4, true);
        }
       else if (grid_bs.GetGridData(i,5)== "I")
       {
	        grid_bs.SetCellBold(i, 0, i, 4, false);
	        ctrl.Cell(14, i, 0, i, 4) = true; // Chu nghieng
	    }
	    else
	    {
	        ctrl.Cell(14, i, 0, i, 4) = false;
	        grid_bs.SetCellBold(i, 0, i, 4, false);
	    }
	    grid_bs.SetCellBgColor(i, 0, i, 4, Number(grid_bs.GetGridData(i, 5)));
	}
}
//---------------------------------------------------------------------------------------------------
function ChangeColor()
{
    var ctrl = grid_bs.GetGridControl();
   
    for (i = 1; i < ctrl.Rows; i++)
	{
	    if(grid_bs.GetGridData(i,2)== "B")
        {
	        ctrl.Cell(14, i, 0, i, 4) = false;
	        grid_bs.SetCellBold(i, 0, i, 4, true);
        }
       else if (grid_bs.GetGridData(i,2)== "I")
       {
	        grid_bs.SetCellBold(i, 0, i, 4, false);
	        ctrl.Cell(14, i, 0, i, 4) = true; // Chu nghieng
	    }
	    else
	    {
	        ctrl.Cell(14, i, 0, i, 4) = false;
	        grid_bs.SetCellBold(i, 0, i, 4, false);
	    }
	    grid_bs.SetCellBgColor(i, 0, i, 4, Number(grid_bs.GetGridData(i, 2)));
	}
}
</script>

<body style="margin: 0; padding: 0;">
    <!---------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_sel_grid" onreceive="ChangeColor()">
        <xml>
            <dso type="grid" function="acnt.sp_sel_gfos00170_1">
                <input bind="grid_bs">
                    <input bind="txt_report_type"/>
                    <input bind="rbstatus"/>
                    <input bind="lstCompany"/>
                    <input bind="dtfrdate" />
                    <input bind="dttodate"/>
                    <input bind="txtDateType"/>
                    <input bind="txtScale"/>
                    <input bind="dtMonth"/>
                    
                     <input bind="txtuser"/>
                </input>
                <output bind="grid_bs"/>
            </dso>
        </xml>
    </gw:data>
 
  
    <!------------------------------------------------------------------------------->
    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border="0">
       
                    <tr style="width:100%;height:5%">
                       
		                            <td><fieldset>
		                                <table border="0" style="width:100%" cellpadding="0" cellspacing="0" id="table2">
			                            <tr>
				                            <td width="12%" align="right">Công ty&nbsp;</td>
				                            <td width="25%" ><gw:list id="lstCompany" onchange="OnChangeList()" styles='width:100%' /></td>
				                            <td width="10%" align="right">Loại&nbsp;</td>
				                            <td width="23%"> <gw:list id="lstLoai" styles="width:100%;" onchange="OnChangeDateType()" ></gw:list>
                                     </td>
                                     <td width="6%" align="center"><gw:label id="lblDateType" text="Tháng:" styles="font-weight:600;" /></td>
                                     <td width="24%"  colspan="3">
                                          <table width="100%" cellpadding="0" cellspacing="0">
                                                  <tr>
                                                        <td width="80%"><gw:list id="lstThang" styles="width:100%;" onchange="OnChangeQuater()" ></gw:list></td>
                                                        <td  width="10%"><gw:datebox id="dtYear" type="year" lang="1" styles="display:none" onchange="OnChangeYear()"/></td>
                                                        <td width="10%"><gw:datebox id="dtMonth" type="month" lang="1" onchange="OnChangeMonth()"/></td>
                                                  </tr>
                                          </table>
                                     
                                     </td>
                                     
                                     
                                     <td ><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="onSearch()" /></td>
                                     <td ><gw:imgbtn id="ibtnReport" img="excel" alt="Print" onclick="onReport('VIE')" /></td>
				                           
			                            </tr>
			                            <tr>
				                            <td align="right">Ngôn Ngữ&nbsp;</td>
				                            <td ><gw:list id="lstLang" onchange="OnChangeLang()" styles='width:100%' /></td>
				                            <td  align="right">Trạng Thái&nbsp;</td>
				                            <td > <gw:radio id="rbstatus" value="2" onchange="onSearch()"> 
		                                        <span value="2">Xác Nhận</span>
		                                        <span value="0">Duyệt</span>
		                                        </gw:radio>
                                     </td>
                                    <td><gw:datebox id="dtfrdate" type="date" lang="1" /></td>
                                    <td>~</td>
                                    <td><gw:datebox id="dttodate" type="date" lang="1" /></td>
                                                 
                                    <td  align="right">Đơn Vị&nbsp;</td>
                                    <td  >
                                          <table cellpadding="0" cellspacing="0" width="100%">
                                                  <tr>
                                                        <td width="100%"><gw:textbox id="txtScale" styles='width:100%' type="number" format="###,###,###R" onenterkey="onSearch()" /></td>
                                                        
                                                  </tr>
                                          </table>
                                    </td>
                                    <td  ><gw:label id="lblBookccy" styles="width:100%; color:red; font-weight:700;" /></td>
                                    
                                     
			                            </tr>
		                            </table>
		                            </fieldset> </td>
	                            </tr>
                           
                   
    <tr style="width:100%;height:95%">
                            
                            <td width="100%">
                            <!-- header  ="0.Chỉ tiêu|1.Số dư đầu kỳ|2.Phát sinh tăng trong kỳ|3.Phát sinh giảm trong kỳ|4.Số dư cuối kỳ|5._font_stype|6._prn_color|7._GRP_ACCD"-->
                                <gw:grid   
								        id="grid_bs"
						                header  ="Chỉ tiêu|Giá trị (VNĐ)|_a|_b|_c"
						                format  ="0|0|0|0|0"  
						                aligns   ="0|3|0|0|0"  
						                defaults="||||"  
						                editcol ="0|0|0|0|0"  
						                widths  ="8000|2000|0|0|0"  
						                styles  ="width:100%; height:100%"
						                sorting="T" 
						                /> 
                            </td>
                        </tr>
                        
  
                       
 </table>
               
                <gw:textbox id="txt_date" style="display: none" />
                <gw:textbox id="txt_row" style="display: none" />
                <gw:textbox id="txt_tmp" style="display: none" />
                <gw:textbox id="txtDateType" style="display: none" />
                <gw:textbox id="txtuser"  style="display: none" />
                <gw:textbox id="txt_report_type"  text="97" style="display: none" /> 
</body>
</html>
