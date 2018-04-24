<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Test No Registration</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    
var G2_pk               = 0,
    G2_LOC              = 1,
    G2_MFG_Date         = 2,
    G2_Seq_No           = 3,
    G2_Product_Code     = 4,
    G2_Product_Name     = 5,
    G2_Lot_No           = 6,
    G2_Movement_Type    = 7,
    G2_Qty_Printed      = 8,
    G2_Qty_Unprinted    = 9,
    G2_Qty_Prod_Receipt = 10,
    G2_FILE_GU          = 11,
    g2_file_name        = 12;
    
//===============================================================

function BodyInit()
{
    //------------------
	BindingDataList();	
	OnSearch('Master');	
}
//===============================================================

function BindingDataList()
{ 
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);  
        
        <%=ESysLib.SetGridColumnComboFormat("igrid",7,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0110' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;
}

//===============================================================

function OnSearch()
{
    
    data_shpp00220.Call("SELECT");
   
     
}
//===============================================================

function OnRemove()
{

}
//===============================================================

function OnNew()
{    
    
}
//===============================================================

function OnDelete()
{
    
}
//===============================================================

function OnUnDelete()
{
    
}
//===============================================================

function OnSave()
{ 
    
    for(i=1;i<igrid.rows;i++)
    {
        if(igrid.GetGridData(i,0)=="")
        {
            igrid.SetRowStatus(i,48);
        } 
    } 
    data_shpp00220.Call();
}
//===============================================================

function OnClickGroup()
{

}
//===============================================================

//===============================================================
function OnPopUp()
{
    var path = System.RootURL + '/form/sh/pp/shpp00221.aspx?prod_dt='+dtDate.value;
    var obj = System.OpenModal( path ,500 , 400 ,  'resizable:yes;status:yes');
    if (obj != null)
    {                  
        txtFileName.text = obj[0];
        dtDate.value=obj[2];  
        data_shpp00220_process.Call("SELECT");            
    }
}
//===============================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shpp00220_process':
            for(i=1;i<igrid.rows;i++)
            {
                igrid.SetGridText(i,G2_LOC,lstCompany.value);
                igrid.SetGridText(i,G2_MFG_Date,dtDate.value);
                igrid.SetGridText(i,G2_Seq_No,i);
                igrid.SetGridText(i,G2_Seq_No,'01');
                igrid.SetGridText(i,g2_file_name,txtFileName.text);
            }
        break;
        case 'data_shpp00220_Receipt':
            alert(txtresult1.text);
        break;
    }
}
//===============================================================
function ReceiptExe()
{
    data_shpp00220_Receipt.Call();
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpp00220_process" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpp00220_process" > 
                <input> 
                    <input bind="txtFileName" />
                </input> 
                <output bind="igrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <%--<gw:data id="data_shpp00220_Receipt" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" procedure="prod.sp_upd_shpp00220_receipt" > 
                <input>
                    <input bind="igrid" />  
                </input> 
                <output> 
                    <output bind="txtresult1" />
                </output>
            </dso> 
        </xml> 
    </gw:data>--%>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpp00220_Receipt" onreceive="OnReceiveData(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shpp00220_receipt" > 
                <input>
                    <input bind="dtDate" />  
                </input> 
                <output> 
                    <output bind="txtresult1" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpp00220" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="PROD.sp_sel_shpp00220" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" procedure="prod.sp_upd_shpp00220" > 
                <input> 
                    <input bind="dtDate" />
                </input> 
                <output bind="igrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 75%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Plant</td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:list id="lstCompany" styles="width: 100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtDate" lang="1" onchange="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Class
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtClass" styles="width: 100%" />
                        </td>
                        <td style="white-space: nowrap; width: 50%" colspan="2">
                            &nbsp;&nbsp;<b style="color: Red">1.DOM, 2.EXP</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <b style="color: Aqua">+ Seq No.</b>
                        </td>
                        <td colspan="4" align="right">
                            <gw:icon img="3" alt="Sum" text="Sum (Lot No.)" />
                        </td>
                    </tr>
                    <tr>
                        <td style="white-space: nowrap">
                            Performed By</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtEmployee" styles="width: 100%" />
                        </td>
                        <td colspan="7" align="right">
                            <gw:icon img="3" text="Receipt Execution" onclick="ReceiptExe()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" align="right">
                            <gw:icon img="3" text="Download" onclick="OnPopUp()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="10">
                            <gw:grid id='igrid' header='_pk|_LOC|MFG Date|Seq No|Product Code|Product Name|Lot No|Movement Type|Qty(Printed)|Qty(Unprinted)|Qty(Prod-Receipt)|_FILE_GU|_file_name'
                                format='0|0|4|0|0|0|0|0|-0|-0|-0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' acceptnulldate='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
<gw:textbox id="txtFileName" styles="width: 100%;display:none" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtresult1" styles="width: 100%;display:none" />
</html>
