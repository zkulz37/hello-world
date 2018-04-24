<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>LOADING DATA FROM EXCEL</title>
</head>

<script>
var totalCols           = 15 ,
    iClInput_Qty        = 11,
    iClInput_FAmt       = 12,
    iClInput_Amt        = 13,
    clStd_ym            = 18,
    clIMP_FILE_NAME     = 17;
    
  var  user_pk = "<%=Session("EMPLOYEE_PK")%>" ;
  var  user_name = "<%=Session("USER_NAME")%>" ;
  var  itco_company_pk = "<%=Session("tco_company_pk")%>" ;
function BodyInit()
{
    txttco_company_pk.text = itco_company_pk ;
    datFileName.Call();
}
//-----------------------------------------------------------------
function ReadFiles()
{
    idGrid.ClearData();    
    var fl = document.getElementById("idtext").value;  
    
    if ( CheckFilesExist(fl) )
    {
        var excel = new ActiveXObject("Excel.Application");
        var excel_file = excel.Workbooks.Open(fl);
        var excel_sheet = excel.Worksheets("Sheet1");
        
        var file_name = excel_file.Name ;
        txtCurrFileName.text = file_name ;
        lstOrderFile.value = '';
        var maxRow;
        maxRow = excel.Worksheets("Sheet1").UsedRange.Rows.Count;
        idGrid.ClearData();
       if ( maxRow > 0 )
       {
             var lrow, lcol, data;
             
             for(lrow = 2; lrow <= maxRow ; lrow++) 
             {
                    idGrid.AddRow();
                    
                    for(lcol = 1; lcol <= totalCols ; lcol++ )
                    {
                        data = excel_sheet.Cells( lrow, lcol).Value ;                        
                        idGrid.SetGridText( idGrid.rows-1, lcol, data);
                    }
                    
                    idGrid.SetGridText( idGrid.rows-1, clIMP_FILE_NAME, file_name);
                    idGrid.SetGridText( idGrid.rows-1, clStd_ym, dbMonthly.value);
             }
       }
       excel.Workbooks.Close  ;
    }     
}
//-----------------------------------------------------------------
function onEnterKey()
{
    if(event.keyCode==13)
    {
        ReadFiles();        
    }
}
//-----------------------------------------------------------------
function CheckFilesExist(filepath)
{

        if (Trim(filepath)=='') 
        {
            alert("Please, select an excel source file!!")
            return false;
        }
	    //test file exist
	    var fso = new ActiveXObject("Scripting.FileSystemObject");		

        if (!fso.FileExists(filepath))    
        {
            alert(filepath+" doesn't exist.");        
            return false;
        }	
        if(filepath.substring(filepath.length - 3 , filepath.length)!="xls")
        {
            //alert(filepath.substring(filepath.length - 3 , filepath.length));
            alert("This file is not excel file. Pls choose excel file!");
            return false ;
        }
        return true;    
}  
//-----------------------------------------------------------------
function OnSave()
{
    fmgf00051.Call();
}
//-----------------------------------------------------------------
function OnSearch()
{
    fmgf00051.Call('SELECT');
}
//-----------------------------------------------------------------
function onDateChange()
{
    datFileName.Call();
}
//-----------------------------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'datFileName':
            lstOrderFile.SetDataText(txtFileName.text);            
            //OnSearch(); 
           break;
        case 'fmgf00051':
            OnFormartData('idGrid');
            datFileName.Call();
            //lstOrderFile.value = txtCurrFileName.text ;
            break;
        case 'fmgf00051_1':
            alert(txtReturnMessage.text);
            break;
    }
}
//------------------------------------------------------------
function OnDelete()
{
    idGrid.DeleteRow();
}
//------------------------------------------------------------
function onInsertOpenningBalance()
{
    var i ;
    
    for( i = 1; i < idGrid.rows; i++)
    {
        if(Trim(idGrid.GetGridData(i, 19)) == 'Yes')
        {
            alert('This file has already processed!');
            return ;
        }
    }
    fmgf00051_1.Call();    
}
//------------------------------------------------------------
function OnFormartData(iObj)
{
    var ctrl;
    switch(iObj)
    {
        case 'idGrid':
            ctrl = idGrid.GetGridControl();
            ctrl.ColFormat(iClInput_Qty) = "###,###,###,###,###.###";
            ctrl.ColFormat(iClInput_FAmt) = "###,###,###,###,###.###";
            ctrl.ColFormat(iClInput_Amt) = "###,###,###,###,###.###";        
        break;
    }    
}
//------------------------------------------------------------
</script>
<body>
    <!-------------------------------------->
    <gw:data id="fmgf00051" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="acnt" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24" function="acnt.sp_sel_fmgf00051" procedure="acnt.sp_upd_fmgf00051"> 
                <input> 
                    <input bind="lstOrderFile" /> 
                    <input bind="dtImportFrom" />  
                    <input bind="dtImportTo" />
                    <input bind="dbMonthly" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------->
    <gw:data id="datFileName" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00051" > 
                <input>
                    <input bind="dtImportFrom" /> 
                    <input bind="dtImportTo" />
                </input> 
                <output>
                    <output bind="txtFileName" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------>
    <gw:data id="fmgf00051_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00051_1" > 
                <input>
                    <input bind="lstOrderFile" />
                    <input bind="txttco_company_pk" />                                      
                </input> 
                <output>
                    <output bind="txtReturnMessage" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------->    
<table width="100%" style="width:100%; height:100%; ">
    <tr style="width:100%; height:6%; ">
        <td align="right" style="width: 15%">
            <b>Import Date</b>
        </td>
        <td align="right" style="width: 10%">
            <gw:datebox id="dtImportFrom" lang="<%=Session("Lang")%>" onchange="onDateChange()"
                onenterkey="onDateChange()" />
        </td>
        <td align="left" style="width: 15%">
            ~
            <gw:datebox id="dtImportTo" lang="<%=Session("Lang")%>" onchange="onDateChange()"
                onenterkey="onDateChange()" />
        </td>
        <td align="right" style="width: 10%">
            <b>Files</b>
        </td>
        <td style="width: 35%">
            <gw:list id="lstOrderFile" styles="width:100%"  onchange="" />
        </td>
        <td align="center" style="width: 5%">
            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
        </td>
        <td style="width: 10%">
            <gw:icon id="idBtnImportSO" img="in" text="Insert Balance" styles='width:100%' onclick="onInsertOpenningBalance()" />
        </td>
    </tr>
    <tr style="width:100%; height:6%; ">
        <td align="right" style="width: 15%">
            <b>Monthly</b>
        </td>
        <td align="left" style="width: 25%" colspan="2" >
            <gw:datebox id="dbMonthly" type="month" lang="1" />
        </td>        
        <td align="right" style="width: 10%">
            <b>File Path</b>
        </td>
        <td style="width: 35%">
            <input type="file" id="idtext" style="width:100%; " size="30" onchange="ReadFiles()" onkeypress="onEnterKey()">
        </td>
        <td align="center" style="width: 5%">
            <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
        </td>
        <td align="left" style="width: 10%">
            <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" />
        </td>
    </tr>    
    <tr style="width:100%; height:88%; ">
        <td colspan="7" style="width:100%; height:100%">
            <gw:grid id='idGrid' header='_PK|No|Cust ID|Cust Name|Account Code|Account Name|Item Code|Item Name|UOM|Warehouse|PL Name|Input Qty|Input FAmt|Currency|Input Amt|Remark|_imp_dt|_imp_file_name|_STD_YM|Process|_tco_item_pk|_tac_abacctcode_pk|_tin_warehouse_pk|_tac_abpl_pk|_TCO_BUSPARTNER_PK'
                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|1|0|0|0|0|3|3|3|1|1|0|0|0|1|0|0|0|0|0'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1200|1200|2000|1500|3500|1500|3500|800|1500|1500|1500|1500|1500|1000|1500|0|0|0|800|0|0|0|0|0'
                sorting='T' styles='width:100%; height:100%' param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24"
                acceptNullDate="true" />        
        </td>
    </tr>
</table>
    <!-------------------------------------->
    <gw:textbox id="txtFileName" styles="display:none" />
    <gw:textbox id="txtCurrFileName" styles="display:none" />
    <gw:textbox id="txtReturnMessage" styles="display:none" />
    <gw:textbox id="txttco_company_pk" styles="display:none" />
    <!-------------------------------------->
</body>
</html>
    
   
   
   
