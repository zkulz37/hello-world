<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Monthly Income</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingData();    
    grdIncome.AddRow();
    grdExpense.AddRow();    
    FormatHeader('2');
    FormatHeader2('2');    
    txtPLCD.SetEnable(false);
    txtPLNM.SetEnable(false);
    txtPLC_CD.SetEnable(false);
    txtPLC_NM.SetEnable(false);
}
//------------------------------------------------------------------------
function BindingData()
{
        
    var ls_data = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if = 0")%>";
    lstCompany.SetDataText(ls_data);
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT '1' ,'PL Unit' FROM dual union all SELECT '2', 'Center' FROM dual")%>";
    lstReportType.SetDataText(ls_data);
    lstReportType.value = '2';
}
//------------------------------------------------------------------------
function FormatHeader(iObj)
{
    var fg  = grdIncome.GetGridControl(); 
    var language = System.S_Lang ;
    fg.FixedRows = 2; 
    fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
    fg.MergeCells = 5;
    fg.MergeRow(0) = true ;

    if(iObj == '2')
    {
        if(language == "ENG")
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'No';   
            // Tuyến 
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'PL Code';   
            // Số Seri 
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'Serial No';   
            //so hoa don
            fg.Cell(0, 0, 3, 0, 5) = 'Invoice No';
            fg.Cell(0, 1, 3, 1, 3) = 'From No';
            fg.Cell(0, 1, 4, 1, 4) = 'To No';
            fg.Cell(0, 1, 5, 1, 5) = 'Qty(a)';
            // Trả vé
            fg.Cell(0, 0, 6, 0, 7) = 'Return Qty';
            fg.Cell(0, 1, 6, 1, 6) = 'Serial No';
            fg.Cell(0, 1, 7, 1, 7) = 'Qty(b)';
            
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Total Qty = (a)-(b)';   
            // Đơn giá
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Price';   
            //Doanh thu trả vé
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Return Amt';   
            //Doanh thu bán vé
            fg.MergeCol(11) = true ;            
            fg.Cell(0, 0, 11, 1, 11) = 'Sale Amt';   
            //Doanh thu hop dong    
            fg.MergeCol(12) = true ;            
            fg.Cell(0, 0, 12, 1, 12) = 'Contract Amt';   
            // Tổng doanh thu
            fg.MergeCol(13) = true ;            
            fg.Cell(0, 0, 13, 1, 13) = 'Total Amt';  
        } 
        else if( language == "VIE")          
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'Stt';   
            // Tuyến 
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Biển số xe';   
            // Số Seri 
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'Số thứ tự';   
            //so hoa don
            fg.Cell(0, 0, 3, 0, 5) = 'Số hóa đơn';
            fg.Cell(0, 1, 3, 1, 3) = 'Từ số';
            fg.Cell(0, 1, 4, 1, 4) = 'Đến số';
            fg.Cell(0, 1, 5, 1, 5) = 'Số lượng(a)';
            // Trả vé
            fg.Cell(0, 0, 6, 0, 7) = 'Trả vé';
            fg.Cell(0, 1, 6, 1, 6) = 'Số thứ tự';
            fg.Cell(0, 1, 7, 1, 7) = 'Số lượng(b)';
            
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Số còn lại = (a)-(b)';   
            // Đơn giá
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Đơn giá';   
            //Doanh thu trả vé
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Doanh thu trả vé';   
            //Doanh thu bán vé
            fg.MergeCol(11) = true ;            
            fg.Cell(0, 0, 11, 1, 11) = 'Doanh thu bán vé';   
            //Doanh thu hop dong    
            fg.MergeCol(12) = true ;            
            fg.Cell(0, 0, 12, 1, 12) = 'Doanh thu hợp đồng';   
            // Tổng doanh thu
            fg.MergeCol(13) = true ;            
            fg.Cell(0, 0, 13, 1, 13) = 'Doanh thu tổng hợp';          
        }
    }
    else if(iObj == '1')
    {
        if(language == 'ENG')
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'Trans Date';   
            // Tuyến 
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'PL Center';   
            // Số Seri 
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'Serial No';   
            //so hoa don
            fg.Cell(0, 0, 3, 0, 5) = 'Invoice No';
            fg.Cell(0, 1, 3, 1, 3) = 'From No';
            fg.Cell(0, 1, 4, 1, 4) = 'To No';
            fg.Cell(0, 1, 5, 1, 5) = 'Qty(a)';
            // Trả vé
            fg.Cell(0, 0, 6, 0, 7) = 'Return Qty';
            fg.Cell(0, 1, 6, 1, 6) = 'Serial No';
            fg.Cell(0, 1, 7, 1, 7) = 'Qty(b)';
            
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Total Qty = (a)-(b)';   
            // Đơn giá
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Price';   
            //Doanh thu trả vé
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Return Amt';   
            //Doanh thu bán vé
            fg.MergeCol(11) = true ;            
            fg.Cell(0, 0, 11, 1, 11) = 'Sale Amt';   
            //Doanh thu hop dong    
            fg.MergeCol(12) = true ;            
            fg.Cell(0, 0, 12, 1, 12) = 'Contract Amt';   
            // Tổng doanh thu
            fg.MergeCol(13) = true ;            
            fg.Cell(0, 0, 13, 1, 13) = 'Total Amt';  
        }
        else if(language == "VIE")             
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'Ngày';   
            // Tuyến 
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Tuyến';   
            // Số Seri 
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'Số thứ tự';   
            //so hoa don
            fg.Cell(0, 0, 3, 0, 5) = 'Số hóa đơn';
            fg.Cell(0, 1, 3, 1, 3) = 'Từ số';
            fg.Cell(0, 1, 4, 1, 4) = 'Đến số';
            fg.Cell(0, 1, 5, 1, 5) = 'Số lượng(a)';
            // Trả vé
            fg.Cell(0, 0, 6, 0, 7) = 'Trả vé';
            fg.Cell(0, 1, 6, 1, 6) = 'Số thứ tự';
            fg.Cell(0, 1, 7, 1, 7) = 'Số lượng(b)';
            
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Số còn lại=(a)-(b)';   
            // Đơn giá
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Đơn giá';   
            //Doanh thu trả vé
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Doanh thu trả vé';   
            //Doanh thu bán vé
            fg.MergeCol(11) = true ;            
            fg.Cell(0, 0, 11, 1, 11) = 'Doanh thu bán vé';   
            //Doanh thu hop dong    
            fg.MergeCol(12) = true ;            
            fg.Cell(0, 0, 12, 1, 12) = 'Doanh thu hợp đồng';   
            // Tổng doanh thu
            fg.MergeCol(13) = true ;            
            fg.Cell(0, 0, 13, 1, 13) = 'Tổng doanh thu';          
        }
    }        
    fg.ColFormat(5) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(6) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(7) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(8) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(9) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(10) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(11) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(12) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(13) = "#,###,###,###,###,###,###,###R";
    
}
//------------------------------------------------------------------------
function FormatHeader2(iObj)
{
    var language = System.S_Lang ;
    var fg1 = grdExpense.GetGridControl();     
    fg1.FixedRows = 2; 
    fg1.Cell(13, 1, 0, 1, fg1.Cols - 1) = true ;    
    fg1.MergeCells = 5;
    
    if(iObj == '2')
    {
        if(language == "ENG")
        {
            // Report hao phí
            fg1.MergeRow(0) = true ;
            //chỉ tiêu hao phí
            fg1.MergeCol(0) = true ;            
            fg1.Cell(0, 0, 0, 1, 0) = 'Acc. Name';   
            // Tài khỏan
            fg1.MergeCol(1) = true ;            
            fg1.Cell(0, 0, 1, 1, 1) = 'Acc. Code';   
            //thông tin các xe
            fg1.Cell(0, 0, 2, 0, 3) = 'PL Unit';
            fg1.Cell(0, 1, 2, 1, 2) = 'Code';
            fg1.Cell(0, 1, 3, 1, 3) = 'Name';
            // Số tiền
            fg1.MergeCol(4) = true ;            
            fg1.Cell(0, 0, 4, 1, 4) = 'Amount';           
        }
        else if(language == "VIE")            
        {
            // Report hao phí
            fg1.MergeRow(0) = true ;
            //chỉ tiêu hao phí
            fg1.MergeCol(0) = true ;            
            fg1.Cell(0, 0, 0, 1, 0) = 'Các chỉ tiêu hao phí';   
            // Tài khỏan
            fg1.MergeCol(1) = true ;            
            fg1.Cell(0, 0, 1, 1, 1) = 'Tài khỏan';   
            //thông tin các xe
            fg1.Cell(0, 0, 2, 0, 3) = 'Xe';
            fg1.Cell(0, 1, 2, 1, 2) = 'Mã';
            fg1.Cell(0, 1, 3, 1, 3) = 'Tên';
            // Số tiền
            fg1.MergeCol(4) = true ;            
            fg1.Cell(0, 0, 4, 1, 4) = 'Số tiến';                   
        }
    }
    else if(iObj == '1')
    {
        if(language == "ENG")
        {
            // Repor Hao Phi        
            fg1.MergeRow(0) = true ;
            //chỉ tiêu hao phí
            fg1.MergeCol(0) = true ;            
            fg1.Cell(0, 0, 0, 1, 0) = 'Acc. Name';   
            // Tài khỏan
            fg1.MergeCol(1) = true ;            
            fg1.Cell(0, 0, 1, 1, 1) = 'Acc. Code';   
            //thông tin các xe
            fg1.Cell(0, 0, 2, 0, 3) = 'PL Unit';
            fg1.Cell(0, 1, 2, 1, 2) = 'Code';
            fg1.Cell(0, 1, 3, 1, 3) = 'Name';
            // Số tiền
            fg1.MergeCol(4) = true ;            
            fg1.Cell(0, 0, 4, 1, 4) = 'Amount';                   
        }
        else if (language == "VIE")
        {
            // Repor Hao Phi        
            fg1.MergeRow(0) = true ;
            //chỉ tiêu hao phí
            fg1.MergeCol(0) = true ;            
            fg1.Cell(0, 0, 0, 1, 0) = 'Các chỉ tiêu hao phí';   
            // Tài khỏan
            fg1.MergeCol(1) = true ;            
            fg1.Cell(0, 0, 1, 1, 1) = 'Tài khoản';   
            //thông tin các xe
            fg1.Cell(0, 0, 2, 0, 3) = 'Xe';
            fg1.Cell(0, 1, 2, 1, 2) = 'Mã';
            fg1.Cell(0, 1, 3, 1, 3) = 'Tên';
            // Số tiền
            fg1.MergeCol(4) = true ;            
            fg1.Cell(0, 0, 4, 1, 4) = 'Số tiền';                          
        }            
    }      
    fg1.ColFormat(4) = "#,###,###,###,###,###,###.###R";          
}
//------------------------------------------------------------------------
function OnSearch()
{
    
    if(Trim(txtPLC_PK.text) == "" && Trim(txtPLPK.text) == "")
    {
        alert("Please choose the Center or choose the PL Unit");
        return false;            
    }        
    if(Trim(txtPLC_PK.text) != "")
    {
        gfka00200.Call('SELECT');    
    }
    else if(Trim(txtPLPK.text) != "")
    {
        gfka00200_1.Call('SELECT');    
    }
    
}
//------------------------------------------------------------------------
function OnPrint()
{
    var obj = lstReportType.value;
    switch (obj)
    {
        case "2" :
            if(Trim(txtPLC_PK.text) == "")
            {
                alert("Please choose the PL Center");
                return false;
            }
            var url = System.RootURL + "/reports/gf/ka/gfka00200.aspx?company_pk=" + lstCompany.value + "&tr_date_from=" + dtTranFrom.value + "&tr_date_to=" + dtTranTo.value + "&tac_abcenter_pk=" + txtPLC_PK.text + "tac_abpl_pk=" + txtPLPK.text ;
            System.OpenTargetPage(url);                    
        break;
        case "1":
            if(Trim(txtPLPK.text) == "")
            {
                alert("Please choose the PL Unit");
                return false;
            }
            var url = System.RootURL + "/reports/gf/ka/gfka00200_1.aspx?company_pk=" + lstCompany.value + "&tr_date_from=" + dtTranFrom.value + "&tr_date_to=" + dtTranTo.value + "&tac_abpl_pk=" + txtPLPK.text + "&tac_abcenter_pk=" + txtPLC_PK.text ;
            System.OpenTargetPage(url);                    
        break ;
    }   
}
//-----------------------------------------------------          
function OnPopUp(iPopUp)
{
    switch(iPopUp)
    {
        case 'PL':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP_PLPK&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";            
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    txtPLPK.text = object[2];     // PL PK
                    txtPLCD.text = object[0];     // PL Code
                    txtPLNM.text = object[1];     // PL Name
                }            
            }
        break ;
        case 'CENTER':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP_CENTERPK&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";            
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    txtPLC_PK.text = object[2];     // Center PK
                    txtPLC_CD.text = object[3];     // Center Code
                    txtPLC_NM.text = object[4];     // Center Name
                }            
            }        
        break ;
    }
}
//-----------------------------------------------------          
function OnReset()
{
    txtPLPK.text = "";
    txtPLCD.text = "";
    txtPLNM.text = "";
    txtPLC_PK.text = "";
    txtPLC_CD.text = "";
    txtPLC_NM.text = "";
}
//-----------------------------------------------------          
function OnDataReceive(iObj)
{
	var i;
	var l_tot_amt = 0;
    switch(iObj.id)
    {
        case 'gfka00200':
            FormatHeader('2');
			for (i = 2; i < grdIncome.rows; i++)
			{
				l_tot_amt += Number(grdIncome.GetGridData(i, 13));				
			}
            grdIncome.AddRow();
			grdIncome.SetCellBgColor(grdIncome.rows-1, 0, grdIncome.rows-1, grdIncome.cols-1, 0xA9EBD7);
			grdIncome.SetGridText(grdIncome.rows - 1, 1, 'TOTAL');			
			grdIncome.SetGridText(grdIncome.rows - 1, 13, l_tot_amt);									
            gfka00200_2.Call('SELECT');
        break ;
        case 'gfka00200_1':
            FormatHeader('1');
            gfka00200_3.Call('SELECT');
        break ;
        case 'gfka00200_2':
			FormatHeader2('2');
			for (i = 2; i < grdExpense.rows; i++)
			{
				l_tot_amt += Number(grdExpense.GetGridData(i, 4));				
			}
            grdExpense.AddRow();
			grdExpense.SetCellBgColor(grdExpense.rows-1, 0, grdExpense.rows-1, grdExpense.cols-1,0xA9EBD7);
			grdExpense.SetGridText(grdExpense.rows - 1, 0, 'TOTAL');
			grdExpense.SetGridText(grdExpense.rows - 1, 4, l_tot_amt);
        break ;
        case 'gfka00200_3':
            FormatHeader2('1');
        break ;        
    }
}
//-----------------------------------------------------          
</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="gfka00200" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_select_income_center" > 
                <input bind="grdIncome" >   
                    <input bind="dtTranFrom"/>
                    <input bind="dtTranTo"/>
                    <input bind="txtPLC_PK" />
					<input bind="txtPLPK" />
                    <input bind="lstCompany"/>                                        
                </input>
                <output  bind="grdIncome" />
            </dso> 
        </xml> 
    </gw:data>       
    <!--------------------------------------------------------------->
    <gw:data id="gfka00200_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid"  function="ACNT.sp_select_income_PL" > 
                <input bind="grdIncome" >   
                    <input bind="dtTranFrom"/>
                    <input bind="dtTranTo"/>
                    <input bind="txtPLPK" />
					<input bind="txtPLC_PK" />
                    <input bind="lstCompany"/>                                        
                </input>
                <output  bind="grdIncome" />
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->    
    <gw:data id="gfka00200_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid"  function="ACNT.sp_sel_expense_center" > 
                <input bind="grdExpense" >   
                    <input bind="lstCompany"/> 
                    <input bind="txtPLC_PK" />
					<input bind="txtPLPK" />
                    <input bind="dtTranFrom"/>
                    <input bind="dtTranTo"/>                                                                               
                </input>
                <output  bind="grdExpense" />
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="gfka00200_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="4" type="grid"  function="ACNT.sp_sel_expense_PL" > 
                <input bind="grdExpense" >   
                    <input bind="lstCompany"/> 
                    <input bind="txtPLPK" />
					<input bind="txtPLC_PK" />
                    <input bind="dtTranFrom"/>
                    <input bind="dtTranTo"/>                                                                               
                </input>
                <output  bind="grdExpense" />
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0" >
    <tr style="height:8%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 18%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 4%"></td>
                    <td style="width:10%;"></td>
                </tr>
                <tr >
                    <td align="right" styles="width: 100%">Company&nbsp</td>
                    <td styles="width: 100%" colspan="3" >
                        <gw:list id="lstCompany" styles="width:100%" />
                    </td>
                    <td align="right" styles="width: 100%"><a title="Click here to select PL Unit" onclick="OnPopUp('PL')" href="#tips">PL Unit</a>&nbsp
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLCD" text="" styles="width:100%" />
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLNM" text="" styles="width:100%" />
                    </td>
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset()" /></td>
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
                    <td align="right"><gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" /></td>                    
                </tr>
                <tr>
                    <td style="width:10%; " align="right" >Trans Date&nbsp</td>
                    <td align="left" ><gw:datebox id="dtTranFrom" lang="1" /></td>
                    <td align="center">~</td>
                    <td align="right" ><gw:datebox id="dtTranTo" lang="1" /></td>
                    <td align="right" styles="width: 100%"><a title="Click here to select PL Unit" onclick="OnPopUp('CENTER')" href="#tips">PL Center</a>&nbsp
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLC_CD" text="" styles="width:100%" />
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLC_NM" text="" styles="width:100%" />
                    </td>
                    <td>Report&nbsp</td>                    
                    <td colspan="2"><gw:list id="lstReportType" styles="width:100%" /></td>                    
                </tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:50%">
        <td>
            <gw:grid id="grdIncome" 
            header="Ngày|Tuyến xe|Số Seri|Từ số|Đến số|Số lượng(a)|Số Seri|Số lượng|Tổng số vé = (a)-(b)|Đơn giá|Doanh thu trả vé|Doanh thu bán vé|Doanh thu hợp đồng|Tổng doanh thu"
            format="4|0|0|0|0|0|0|0|0|0|0|0|0|0" 
            aligns="1|1|0|1|1|3|0|3|3|3|3|3|3|3"
            defaults="|||||||||||||" 
            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
            widths="1200|1500|2500|1500|1500|1500|2200|2000|2000|2500|2000|2000|2000|2000"
            styles="width:100%; height:100% "                         
            acceptNullDate="T" 
            sorting="T" />                    
        </td>
    </tr>
    <tr style="height:42%">
        <td colspan="10">
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td>
                        <gw:grid id="grdExpense" 
                        header="Acc. Name|Acc. Code|PLC Code|PLC Name|Amount"
                        format="0|0|0|0|0" 
                        aligns="0|1|1|0|3"
                        defaults="||||" 
                        editcol="0|0|0|0|0" 
                        widths="4000|1500|2000|3000|2000"
                        styles="width:100%; height:100% "                         
                        acceptNullDate="T" 
                        sorting="T" />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txtPLPK" styles="display:none; " />
<gw:textbox id="txtPLC_PK" styles="display:none; " />
</body>
</html>