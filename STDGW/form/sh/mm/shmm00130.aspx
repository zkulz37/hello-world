<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>General Report</title>
</head>
<%  ESysLib.SetUser("inv")%>

<script>

var G3_Lot_No = 4 ;
//----------------------------------------------------------------------------------------

function BodyInit()
{
    txtPurDeptCode.SetEnable(false);
    txtPurDeptName.SetEnable(false);
    txtReqDeptCode.SetEnable(false);
    txtReqDeptName.SetEnable(false);   
}
//-------------------------------------------------------------------------------------
function ClearText(obj)
{
    switch(obj.id)
    {
        case "btnPurDept":
            txtPurDeptCode.text = '';
            txtPurDeptName.text = '';
            txtPurDeptPK.text = '';
       break;
       
       case "btnReqDept":
            txtReqDeptCode.text = '';
            txtReqDeptName.text = '';
            txtReqDeptPk.text = '';
       break; 
    }   
}
//----------------------------------------------------------------------------------------

function BindingDataList()
{

}
//-------------------------------------------------------------------------------------------
function ChangeWarehouse()
{

}
//---------------------------------------------------------------------------------------------------

function SetGridFormat()
{
   
}

//---------------------------------------------------------------------------------------------------

function OnSearch(obj)
{
	    data_shmm00130.Call('SELECT');
}

//---------------------------------------------------------------------------------------------------

function OnPrint(obj)
{
    
}

//---------------------------------------------------------------------------------------------------

function OnGetItem(obj)
{
}
//------------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
    case 'ReqDept':
        var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx?dept_condition=50102000";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                  
           txtReqDeptName.text = object[2]; 
           txtReqDeptPk.text  = object[0]; 
           txtReqDeptCode.text  = object[1]; 
        }
    break;
    case 'PurDept':
        var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                  
           txtPurDeptName.text = object[2]; 
           txtPurDeptPK.text  = object[0]; 
           txtPurDeptCode.text  = object[1]; 
        }
    break;
    }
    
}
//---------------------------------------------------------------------------------------------------

function OnDataReceive(obj)
{
switch(obj.id){
 case 'data_shmm00130':
 data_shmm00130_1.Call('SELECT');
 break;
 }
}

//---------------------------------------------------------------------------------------------------

</script>

<body>
    <!---------------------------------------------------------------->
    <!-----------------------grdForDrap---------------------------------------->
    <gw:data id="data_shmm00130" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" parameter="0,1" function="PROD.sp_sel_shmm00130" > 
                    <input>  
                    <input bind="txtPONo" /> 
                        <input bind="dtFrom" />    
                       <input bind="dtTo" /> 
                       <input bind="txtReqDeptPk" /> 
                       <input bind="txtPurDeptPK" />                                                
                    </input> 
                    <output bind="grdItem" /> 
                </dso> 
            </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="data_shmm00130_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="PROD.sp_sel_shmm00130" > 
                <input bind="grdItem2" >
                        <input bind="txtPONo" /> 
                        <input bind="dtFrom" />    
                       <input bind="dtTo" /> 
                       <input bind="txtReqDeptPk" /> 
                       <input bind="txtPurDeptPK" /> 
                </input>
                <output bind="grdItem2" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <!---------------------------------------------------------------->
    <!---------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 10%" align="right">
                            P/O No.</td>
                        <td style="width: 35%">
                            <gw:textbox id="txtPONo" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
                            Period</td>
                        <td style="width: 35%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 5%">
                            <a onclick="OnPopUp('PurDept')" href="#tips" style="color: #0000ff">Purch. Dept.</a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtPurDeptCode" styles="width:30%" />
                            <gw:textbox id="txtPurDeptName" styles="width:70%" />
                            <gw:textbox id="txtPurDeptPK" styles="display:none" />
                            <button onclick="ClearText(this)">X</button>
                            
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqDept')">Req. Dept.</b></td>
                        <td style="width: 25%; white-space: nowrap">
                            <gw:textbox id="txtReqDeptPk" styles='display:none' />
                            <gw:textbox id="txtReqDeptCode" styles='width:30%' />
                            <gw:textbox id="txtReqDeptName" styles='width:70%' />
                            &nbsp;
                            <input type="button" id="btnReqDept" title="Clear text" value="  X " style="background-color: White;
                                text-align: center; color: Red" onclick="ClearText(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="top" style="height: 98%">
            <td>
                <gw:tab id="tab">
                <table style="height: 100%; width: 100%" border="0" name="By Item">
                    <tr>
                        <td>
                            <gw:grid id='grdItem' header='Po Date|Po No|Item Code|Item Name|Po Qty|Receipt Qty|Unit Price|Po Uom|Seq'
                                format='4|0|0|0|1|1|1|0|0' aligns='0|1|1|0|0|0|0|1|0' check='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
                <table style="height: 100%; width: 100%" border="0" name="By Group">
                    <tr>
                        <td>
                            <gw:grid id='grdItem2' header='Po Date|Po No|Item Code|Item Name|Po Qty|Receipt Qty|Unit Price|Po Uom|Seq'
                                format='4|0|0|0|1|1|1|0|0' aligns='0|1|1|0|0|0|0|1|0' check='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' group="T" />
                        </td>
                    </tr>
                </table>
                </gw:tab>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
<gw:textbox id="txtItemPK_Ledger" styles="display: none" />
<gw:textbox id="txtItemPK_Monthly" styles="display: none" />
<gw:textbox id="txtBegin" styles="display: none" />
<gw:textbox id="txtRecords" styles="display: none" />
<gw:textbox id="txtPage" styles="display: none" />
<!------------------------------------------------------->
</html>
