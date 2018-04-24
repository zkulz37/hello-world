<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<% ESysLib.SetUser("comm")%>
<%  ESysLib.SetUser("prod")%>

<script>
 
 function BodyInit()
 {
    txtCharger.SetEnable(false);
    txtClient.SetEnable(false);
    txtProject.SetEnable(false);
    
    BindingDataList();
 }
 
 function BindingDataList()
 {
    <%=ESysLib.SetGridColumnComboFormat( "grdDTL" , 1 , "select pk, WH_NAME from tin_warehouse where del_if = 0")%>;

    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM tco_company where del_if=0")%>"; 
    lstCompany.SetDataText(data);
    
    data = "<%=ESysLib.SetListDataSQL("select pk, line_name from tpr_line where del_if = 0 and use_yn = 'Y'")%>"; 
    lstLine.SetDataText(data);
 }
 
function OnToggle()
{
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   

    if(imgArrow.status == "expand")
    {
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../images/right-arrow.ico";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="80%";
        imgArrow.src = "../../../images/left-arrow.ico";
    }
}
 
function onSearch()
{
    idData_dsql_tin_getdata.Call();
}
 
function onNewMST()
{   
    idData_dsql_stockother.StatusInsert();
    grdDTL.ClearData();
    //grdDTL.AddRow();
}

function onSaveMST()
{   
    if ( idData_dsql_stockother.GetStatus() == 10)
    {   
        idData_dsql_stockother.Call('UPDATE');
    }
    
    if ( idData_dsql_stockother.GetStatus() == 20 )
    {
        idData_dsql_stockother.Call('INSERT');
    }
    
    if ( idData_dsql_stockother.GetStatus() == 40 )
    {
        idData_dsql_stockother.Call('DELETE');
    }    
}

function ReceiveData()
{  
    switch(idData_dsql_stockother.GetStatus())
    {
        case 0:
            idData_dsql_tin_iostockotherd.Call('SELECT');
        break;
        
        case 10:
           
            if ( grdDTL.GetRowStatus(grdDTL.rows-1) == 16)
            {
                idData_dsql_tin_iostockotherd.Call('UPDATE');
            }
            if ( grdDTL.GetRowStatus(grdDTL.rows-1) == 48)
            {
                idData_dsql_tin_iostockotherd.Call('INSERT');
            }
            if ( grdDTL.GetRowStatus(grdDTL.rows-1) == 64)
            {
                idData_dsql_tin_iostockotherd.Call('DELETE');
            }
        break;
        
        case 20:
            onSearch();
        break;
        
        case 40:
            idData_dsql_tin_iostockotherd.Call('DELETE');
        break;
    }
}
 
function onNewDTL()
{   
    if (txtPKOther.text != '')
    {
        grdDTL.AddRow();
        grdDTL.SetGridText(grdDTL.rows-1, 8, txtPKOther.text);
    }
    else
    {
        alert('Do not new data...');
        return;
    }
}
 
function openPopUp(obj)
{
    switch(obj)
    {
        case 'Client':
            var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
            oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPKClient.SetDataText(oValue[0]);
                txtClient.SetDataText(oValue[2]);
            }
        break;
        
        case 'Project':
            fpath = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPKPro.SetDataText(oValue[0]);
                txtProject.SetDataText(oValue[2]);
            }
        break;
        
        case 'Charger':
            fpath = System.RootURL + "/form/bd/dp/bddp00011.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPKCharger.SetDataText(oValue[0]);
                txtCharger.SetDataText(oValue[2]);
            }
        break;
        
        default:
    }
}



function onClick()
{
    txtPKOther.SetDataText(grdMST.GetGridData(grdMST.row, 0));
    idData_dsql_stockother.StatusSelect();
    idData_dsql_stockother.Call('SELECT');
}

function onGetItem()
{
    var obj = grdDTL.GetGridControl();
    
    if ( obj.col == 3 || obj.col == 4)
    {
        var fpath = System.RootURL + "/form/ep/ab/PopUpGetItem.aspx";
        oValue = System.OpenModal( fpath , 800 , 530, 'resizable:yes;status:yes');
        
        if ( oValue != null )
        {
            for ( var i=0; i<oValue.length; i++)
            {
                var temp = oValue[i];            
                grdDTL.SetGridText(grdDTL.row, 2, temp[0]);
                grdDTL.SetGridText(grdDTL.row, 3, temp[1]);
                grdDTL.SetGridText(grdDTL.row, 4, temp[2]);
            }
        }
    }
}

function onDeleteDTL()
{
    grdDTL.DeleteRow();
}

function onUnDeleteDTL()
{
    grdDTL.UnDeleteRow();
}

function onDeleteMST()
{
    if ( confirm("Are you sure deelte ?"))
    {
        idData_dsql_stockother.StatusDelete();
    }
}
</script>

<body>
<gw:data id="idData_dsql_tin_getdata" onreceive=""> 
    <xml> 
        <dso id="1" type="grid" function="inv.sp_sel_tin_getdata" > 
            <input> 
                <input bind="txtVouchL" />
                <input bind="dtbFromL" />
                <input bind="dtbToL" />
            </input> 
            <output bind="grdMST" /> 
        </dso> 
    </xml> 
</gw:data>

  <gw:data id="idData_dsql_stockother" onreceive="ReceiveData()"> 
    <xml> 
        <dso type="control" parameter="0,1,2,4,5,6,7,9,11,12" function="inv.sp_sel_tin_iostockother"  procedure="inv.sp_upd_tin_iostockother"> 
            <inout>
                <inout  bind="txtPKOther" />
                <inout  bind="lstCompany" />
                <inout  bind="txtPKCharger" />
                <inout  bind="txtCharger" /> 
                <inout  bind="txtVouchR" />
                <inout  bind="dtdVouchDate" />
                <inout  bind="txtType" />
                <inout  bind="txtPKClient" />
                <inout  bind="txtClient" /> 
                <inout  bind="txtPKPro" />
                <inout  bind="txtProject" /> 
                <inout  bind="lstLine" />
                <inout  bind="txtDes" />
            </inout>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_dsql_tin_iostockotherd" onreceive=""> 
    <xml> 
        <dso id="3" type="grid" parameter="0,1,2,5,6,7,8" function="inv.sp_sel_tin_iostockotherd" procedure="inv.sp_upd_tin_iostockotherd"> 
            <input> 
                <input bind="txtPKOther" />                
            </input> 
            <output bind="grdDTL" /> 
        </dso> 
    </xml> 
</gw:data>
    
    <table width="100%" border="0" style="background: #BDE9FF"  id="tableID1">
        <tr valign="top">
            <td id="left" width="35%" valign="top" style="background: White"  >
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width=20%><b>&nbsp; &nbsp;Voucher No</b></td>
                        <td width=10%><gw:textbox id="txtVouchL" styles="width: 100%" onenterkey="onSearch()" /></td>
                        <td width=3%>&nbsp;</td>
                        <td width=10% align="left"><gw:imgbtn id="btnSearchL" img="search" alt="Search" text="Search" onclick="onSearch()" /></td>
                    </tr>
                    <tr>
                        <td width=20%><b>&nbsp; &nbsp;Vourcher Date</b></td>
                        <td width=10%><gw:datebox id="dtbFromL" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                        <td width=3%><b>&nbsp;~&nbsp;</b></td>
                        <td width=10%><gw:datebox id="dtbToL" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                    </tr>
                    <tr>
                        <td colspan="4" width="100%" height="3"></td>
                    </tr>
                    <tr>
                        <td colspan="4" width="100%">
                            <gw:grid
                                id="grdMST"
                                header="_PK|Voucher Date|Voucher No"
                                format="0|4|0"
                                aligns="1|0|0"
                                defaults="||"
                                editcol="0|0|0"
                                widths="0|1500|0"
                                styles="width:100%; height:400"
                                sorting="T"
                                oncellclick="onClick()"                            
                                param="0,1,2"/>
                        </td>
                    </tr>
                </table>    
            </td>
            <td id="right" width="65%" valign="top" style="background: White">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td width="15%"><b>&nbsp; &nbsp; &nbsp;Company</b></td>
                        <td width="20%"><gw:list id="lstCompany" styles="width:100%" ></gw:list></td>
                        <td width="5%"></td>
                        <td width="15%"><b style="color:Blue; cursor:hand" onclick="openPopUp('Charger')">Charger</b></td>
                        <td width="10%"><gw:textbox id="txtCharger" styles="width:100%" ></gw:textbox></td>
                        <td width="15%"></td>                        
                        <td width="25%" align="right">
                            <table width="100%">
                                <tr>
                                    <td width="88%"></td>
                                    <td width="3%"><gw:imgbtn id="ibtnNewMST"    img="new"    alt="New"    text="New"    onclick="onNewMST()" /></td>
                                    <td width="3%"><gw:imgbtn id="ibtnDeleteMST" img="delete" alt="Delete" text="Delete" onclick="onDeleteMST()" /></td>
                                    <td width="3%"><gw:imgbtn id="ibtnSaveMST"   img="save"   alt="Save"   text="Save"   onclick="onSaveMST()" /></td>
                                </tr>
                            </table>
                        </td>                        
                    </tr>
                    <tr>
                        <td width="15%"><b>&nbsp; &nbsp; &nbsp;Voucher No</b></td>
                        <td width="20%"><gw:textbox id="txtVouchR" styles="width:100%" ></gw:textbox></td>
                        <td width="5%"></td>
                        <td width="15%"><b>Voucher Date</b></td>
                        <td width="10%"><gw:datebox id="dtdVouchDate" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                        <td width="10%"><b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Type</b></td>
                        <td width="30%"><gw:textbox id="txtType" styles="width:100%" ></gw:textbox></td>
                    </tr>
                    <tr>
                        <td colspan="7" width="100%" height="3"></td>
                    </tr>
                    <tr>
                        <td width="15%"><b style="color:Blue; cursor:hand" onclick="openPopUp('Client')">&nbsp; &nbsp; &nbsp;Client</b></td>
                        <td width="20%"><gw:textbox id="txtClient" styles="width:100%" ></gw:textbox></td>
                        <td width="5%"></td>
                        <td width="15%"><b style="color:Blue; cursor:hand" onclick="openPopUp('Project')" >Project</b></td>                        
                        <td width="10%"><gw:textbox id="txtProject" styles="width:100%" ></gw:textbox></td>
                        <td width="15%"><b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Line</b></td>                        
                        <td width="25%"><gw:list id="lstLine" styles="width:100%" ></gw:list></td>
                    </tr> 
                    <tr>
                        <td colspan="7" width="100%" height="3"></td>
                    </tr>
                    <tr>
                        <td width="15%"><b>&nbsp; &nbsp; &nbsp;Description</b></td>
                        <td colspan="6" width="85%"><gw:textbox id="txtDes" styles="width:100%"></gw:textbox></td>
                    </tr>                  
                    <tr>
                        <td colspan="7" width="100%">
                            <table width="100%">
                                <tr>
                                    <td width="88%"></td>
                                    <td width="3%"><gw:imgbtn id="ibtnNewDTL"    img="new"     alt="New"    text="New"    onclick="onNewDTL()" /></td>
                                    <td width="3%"><gw:imgbtn id="ibtnDeleteDTL" img="delete"  alt="Delete" text="Delete" onclick="onDeleteDTL()" /></td>
                                    <td width="3%"><gw:imgbtn id="ibtnUnDelete"  img="udelete" alt="Save"   text="Save"   onclick="onUnDeleteDTL()" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7" width="100%">
                            <gw:grid
                                id="grdDTL"
                                header="_PK|Ware House|_Item PK|Item Code|Item Name|Unit|In/Out Qty|Description|_tin_iostockotherd"
                                format="0|0|0|0|0|0|1|0|0"
                                aligns="1|0|0|0|0|1|0|0|0"
                                defaults="||||||||"
                                editcol="0|1|1|1|1|1|1|1|0"
                                widths="0|1500|1500|2000|2000|800|0|0|0"
                                styles="width:100%; height:320"
                                sorting="T"
                                oncelldblclick="onGetItem()"
                                param="0,1,2,3,4,5,6,7,8"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    <gw:textbox id="txtPKOther" styles="display:none" ></gw:textbox>
    <gw:textbox id="txtPKClient" styles="display:none" ></gw:textbox>
    <gw:textbox id="txtPKCharger" styles="display:none" ></gw:textbox>
    <gw:textbox id="txtPKPro" styles="display:none" ></gw:textbox>
    <img status="expand" id="imgArrow" src="../../../images/left-arrow.ico" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
</html>
