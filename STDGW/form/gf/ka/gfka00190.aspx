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
    //alert(System.S_Lang);
    System.Translate(document);
    BindingData();
    OnFormatGrid();
    idGrid.AddRow();
    FormatHeader('2');
}
//------------------------------------------------------------------------
function BindingData()
{
        
    var ls_data = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if = 0")%>";
    lstCompany.SetDataText(ls_data);
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT '1' ,'PL Unit' FROM dual union all SELECT '2', 'Center' FROM dual")%>";
    lstReportType.SetDataText(ls_data);
    lstReportType.value = '2';
    // PL 
    txtPLCD.SetEnable(false);
    txtPLNM.SetEnable(false);
    txtPLC_CD.SetEnable(false);
    txtPLC_NM.SetEnable(false);
}
//------------------------------------------------------------------------
function FormatHeader(iObj)
{//alert(System.S_Lang);
    var language = System.S_Lang ;
        
    var fg = idGrid.GetGridControl();                    
    fg.FixedRows = 2; 
    fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
    fg.MergeCells = 5;
    fg.MergeRow(0) = true;   
    if(iObj == '2')
    {
        if(language=="ENG")
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'No';   
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Trans Date';   
            // Tuyến 
            fg.Cell(0, 0, 2, 0, 3) = 'PL Center';
            fg.Cell(0, 1, 2, 1, 2) = 'Code';
            fg.Cell(0, 1, 3, 1, 3) = 'Name';
            // Bien so xe
            fg.MergeCol(4) = true ;            
            fg.Cell(0, 0, 4, 1, 4) = 'PL Unit';   
            // So luong ve
            fg.MergeCol(5) = true ;            
            fg.Cell(0, 0, 5, 1, 5) = 'Qty';   
            // don gia
            fg.MergeCol(6) = true ;            
            fg.Cell(0, 0, 6, 1, 6) = 'Price';   
            
            // doanh thu trả vé
            fg.MergeCol(7) = true ;            
            fg.Cell(0, 0, 7, 1, 7) = 'Return Amt';   
            // doanh thu bán vé
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Sale Amt';   
            // doanh thu hop dong
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Contract Amt';   
            // doanh thu tổng cộng
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Total Amt';
        }
        else if(language == "VIE")
        {
            //Ngày
            fg.MergeCol(0) = true ;            
            fg.Cell(0, 0, 0, 1, 0) = 'Stt';   
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Ngày';   
            // Tuyến 
            fg.Cell(0, 0, 2, 0, 3) = 'Tuyến';
            fg.Cell(0, 1, 2, 1, 2) = 'Mã';
            fg.Cell(0, 1, 3, 1, 3) = 'Tên';
            // Bien so xe
            fg.MergeCol(4) = true ;            
            fg.Cell(0, 0, 4, 1, 4) = 'Biển số xe';   
            // So luong ve
            fg.MergeCol(5) = true ;            
            fg.Cell(0, 0, 5, 1, 5) = 'Số lượng';   
            // don gia
            fg.MergeCol(6) = true ;            
            fg.Cell(0, 0, 6, 1, 6) = 'Đơn giá';   
            
            // doanh thu trả vé
            fg.MergeCol(7) = true ;            
            fg.Cell(0, 0, 7, 1, 7) = 'Doanh thu trả vé';   
            // doanh thu bán vé
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Doanh thu bán vé';   
            // doanh thu hop dong
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Doanh thu hợp đồng';   
            // doanh thu tổng cộng
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Doanh thu tổng hợp';        
        }
    }
    else if(iObj == '1')
    {
        fg.MergeRow(0) = true;   
        //Ngày
        fg.MergeCol(0) = true ;
        if(language == "ENG")            
        {
            fg.Cell(0, 0, 0, 1, 0) = 'No';   
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Trans Date';   
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'PL Unit';   
            // Tuyến 
            fg.Cell(0, 0, 3, 0, 4) = 'PL Center';
            fg.Cell(0, 1, 3, 1, 3) = 'Code';
            fg.Cell(0, 1, 4, 1, 4) = 'Name';
            // So luong ve
            fg.MergeCol(5) = true ;            
            fg.Cell(0, 0, 5, 1, 5) = 'Qty';   
            // don gia
            fg.MergeCol(6) = true ;            
            fg.Cell(0, 0, 6, 1, 6) = 'Price';   
            
            // doanh thu trả vé
            fg.MergeCol(7) = true ;            
            fg.Cell(0, 0, 7, 1, 7) = 'Return Amt';   
            // doanh thu bán vé
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Sale Amt';   
            // doanh thu hop dong
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Contract Amt';   
            // doanh thu tổng cộng
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Total Amt';               
        }
        else if(language == "VIE" )
        {
            fg.Cell(0, 0, 0, 1, 0) = 'Stt';   
            fg.MergeCol(1) = true ;            
            fg.Cell(0, 0, 1, 1, 1) = 'Ngày';   
            fg.MergeCol(2) = true ;            
            fg.Cell(0, 0, 2, 1, 2) = 'Xe';   
            // Tuyến 
            fg.Cell(0, 0, 3, 0, 4) = 'Tuyến';
            fg.Cell(0, 1, 3, 1, 3) = 'Mã';
            fg.Cell(0, 1, 4, 1, 4) = 'Tên';
            // So luong ve
            fg.MergeCol(5) = true ;            
            fg.Cell(0, 0, 5, 1, 5) = 'Số lượng';   
            // don gia
            fg.MergeCol(6) = true ;            
            fg.Cell(0, 0, 6, 1, 6) = 'Đơn giá';   
            
            // doanh thu trả vé
            fg.MergeCol(7) = true ;            
            fg.Cell(0, 0, 7, 1, 7) = 'Doanh thu trả vé';   
            // doanh thu bán vé
            fg.MergeCol(8) = true ;            
            fg.Cell(0, 0, 8, 1, 8) = 'Doanh thu bán vé';   
            // doanh thu hop dong
            fg.MergeCol(9) = true ;            
            fg.Cell(0, 0, 9, 1, 9) = 'Doanh thu hợp đồng';   
            // doanh thu tổng cộng
            fg.MergeCol(10) = true ;            
            fg.Cell(0, 0, 10, 1, 10) = 'Doanh thu tổng hợp';                       
        }
    }        
}
//------------------------------------------------------------------------
function OnSearch()
{
    gfka00190.Call('SELECT');
}
//------------------------------------------------------------------------
function OnPrint()
{
    var obj = lstReportType.value;
    switch (obj)
    {
        case "2" :
            //var url = System.RootURL + "/system/ReportEngine.aspx?file=gf/ka/rpt_SumProfit_Center.rpt&procedure=ACNT.sp_sel_income_pl_center"
            //+ "&parameter="+dtTranFrom.value + "," + dtTranTo.value + "," + lstCompany.value + ",2," + txtPLPK.text + "," + txtPLC_PK.text ;
            //window.open(url);            
            var url = System.RootURL + "/reports/gf/ka/rpt_SumProfit_Center.aspx?company_pk=" + lstCompany.value + "&tr_date_from=" + dtTranFrom.value + "&tr_date_to=" + dtTranTo.value + "&tac_abcenter_pk=" + txtPLC_PK.text + "&tac_abpl_pk=" + txtPLPK.text ;
            System.OpenTargetPage(url);                    
			
        break;
        case "1":
        /*    var url = System.RootURL + "/system/ReportEngine.aspx?file=gf/ka/rpt_SumProfit_PL.rpt&procedure=ACNT.sp_sel_income_pl_center"
            + "&parameter="+dtTranFrom.value + "," + dtTranTo.value + "," + lstCompany.value + ",1" ;
            window.open(url);          */
            var url = System.RootURL + "/reports/gf/ka/rpt_SumProfit_Center.aspx?company_pk=" + lstCompany.value + "&tr_date_from=" + dtTranFrom.value + "&tr_date_to=" + dtTranTo.value + "&tac_abcenter_pk=" + txtPLC_PK.text + "&tac_abpl_pk=" + txtPLPK.text ;
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
function OnFormatGrid()
{
    var fg = idGrid.GetGridControl();    
    fg.ColFormat(5) = "#,###,###,###,###,###,###,###R";
    fg.ColFormat(6) = "#,###,###,###,###,###,###,##R";
    fg.ColFormat(7) = "#,###,###,###,###,###,###,##R";
    fg.ColFormat(8) = "#,###,###,###,###,###,###,##R";
    fg.ColFormat(9) = "#,###,###,###,###,###,###,##R";
    fg.ColFormat(10) = "#,###,###,###,###,###,###,##R";
}
//-----------------------------------------------------          
function OnDataReceive(iObj)
{
	var i;
	var l_tot_amt = 0;
    switch(iObj.id)
    {
        case 'gfka00190':
            FormatHeader(lstReportType.value);
			for(i = 2; i < idGrid.rows; i++)
			{
				l_tot_amt += Number(idGrid.GetGridData(i, 9));
			}
            idGrid.AddRow();
			idGrid.SetCellBgColor(idGrid.rows-1, 0, idGrid.rows-1, idGrid.cols-1, 0xA9EBD7);
			idGrid.SetGridText(idGrid.rows - 1, 2, 'TOTAL');			
			idGrid.SetGridText(idGrid.rows - 1, 9, l_tot_amt);												
        break ;
    }
}
//-----------------------------------------------------          
function OnSelectPL_Center()
{
    OnSearch();
}
//-----------------------------------------------------          
</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="gfka00190" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid"  function="acnt.sp_select_income_pl_center" > 
                <input bind="idGrid" >   
                    <input bind="dtTranFrom"/>
                    <input bind="dtTranTo"/>
                    <input bind="lstCompany"/>
                    <input bind="txtPLPK"/>
                    <input bind="txtPLC_PK"/>
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>    
    <!-------------------------------------------------------------------->
<table style="width:100%; " border="1" style="height:100%" cellpadding="0" cellspacing="0" >
    <tr style="height:8%" >
        <td>
            <table width="100%" border="0"  cellspacing="0" cellpadding="0" style="height:100%" >
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
                    <td style="width: 10%"></td>
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
                    <td align = "center">~</td>
                    <td align="right" ><gw:datebox id="dtTranTo" lang="1" /></td>
                    <td align="right" styles="width: 100%"><a title="Click here to select PL Unit" onclick="OnPopUp('CENTER')" href="#tips">PL Center</a>&nbsp
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLC_CD" text="" styles="width:100%" />
                    </td>
                    <td styles="width: 100%" >
                        <gw:textbox id="txtPLC_NM" text="" styles="width:100%" />
                    </td>
                    <td align="right">Report&nbsp</td>                    
                    <td colspan="2"><gw:list id="lstReportType" styles="width:100%" onchange="OnSelectPL_Center()" /></td>                    
                </tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:92%">
        <td colspan="11">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%">
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                        header="No|Trans Date|PL Center||PL Unit|Qty|Price|Return Amt|Sale Amt|Contract Amt|Total Amt"
                        format="0|4|0|0|0|0|0|0|0|0|0" 
                        aligns="1|1|1|0|1|3|3|3|3|3|3"
                        defaults="||||||||||" 
                        editcol="0|0|0|0|0|0|0|0|0|0|0" 
                        widths="1000|1200|1500|2500|1500|1500|1500|2200|2000|2000|2500"
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