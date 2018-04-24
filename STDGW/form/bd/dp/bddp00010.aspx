<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  
<script language="javascript" type="text/javascript" for="document" event="oncellchange">
<!--
return document_oncellchange()
// -->
</script>
</head>
<% ESysLib.SetUser("prod")%>
<script>
var EmpNm="<%=Session("User_ID")%>";
var status_control;
function BodyInit()
{
    System.Translate(document); 
    txtEmpR.SetEnable(false);
  
    BindingDataList();
    
    if (lstStatus.value == 'CF')
    {
        txtStatus.SetEnable(false);
    }
}
 
function BindingDataList()
{   
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM tco_company where del_if=0")%>"; 
    lstCom.SetDataText(data);    
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('PRCP0090','','') FROM DUAL")%>"; 
    lstStatus.SetDataText(data);
    lstStatus.value="WT";
}

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../images/right-arrow.ico";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="80%";
    imgArrow.src = "../../../images/left-arrow.ico";
    }
}
 
function TabPopUp(obj)
{   
    var fpath;
    var oValue;
    
    switch(obj)
    {
        case 1: // Employee
            fpath  = System.RootURL + "/form/bd/dp/bddp00011.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtEmpPK.text = oValue[0];
                txtEmpR.text  = oValue[2];
            }
        break;
        
        case 2: // Project
            fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtProjPK.text = oValue[0]; 
                txtProject.text = oValue[2];
            }
        break;
        
        case 3: // Get Item form Cosumption
            fpath  = System.RootURL + "/form/bd/dp/bddp00013.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes'); 
        break;
        
        case 4: // Get Item
            fpath  = System.RootURL + "/form/bd/dp/bddp00014.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes'); 
            
            if (oValue != null)
            {                
                for ( var i=0; i<oValue.length;i++)
                {
                    var aTemp = oValue[i];
                    grdDTL.AddRow();
                    
                    
                    grdDTL.SetGridText(grdDTL.rows-1, 1, aTemp[0]); // PK
                    grdDTL.SetGridText(grdDTL.rows-1, 2, aTemp[1]); // Group
                    grdDTL.SetGridText(grdDTL.rows-1, 3, aTemp[2]); // Item Code
                    grdDTL.SetGridText(grdDTL.rows-1, 4, aTemp[3]); // Item Name
                    grdDTL.SetGridText(grdDTL.rows-1, 16, dtbTakeInDate.GetData() ); // Takein Date
                    grdDTL.SetGridText(grdDTL.rows-1, 17, aTemp[4]); // Unit
                    
                    grdDTL.SetGridText(grdDTL.rows-1, 19 ,txtMRPK.text);
                }
            }
        break;
    }
}
// Left
function OnSearch()
{
    idData_dsql_sel_left.Call();
}

function OnNewMST()
{
    idData_dsql_tpr_poreq.StatusInsert();
    grdDTL.ClearData();
}

function OnDeleteMST()
{
    if (confirm('Are you sure delete ?'))
    {
        idData_dsql_tpr_poreq.StatusDelete();
    }
}

function OnSaveMST()
{
    switch (idData_dsql_tpr_poreq.GetStatus())
    {
        case 20 :
            idData_dsql_tpr_poreq.StatusInsert();
            idData_dsql_tpr_poreq.Call('INSERT');   
        break;
        case 10 :
            idData_dsql_tpr_poreq.StatusUpdate();
            idData_dsql_tpr_poreq.Call('UPDATE');   
        break;
        case 40 :
            idData_dsql_tpr_poreq.StatusDelete();
            idData_dsql_tpr_poreq.Call('DELETE');   
        break;
    }
}

function OnDeleteDTL()
{
    grdDTL.DeleteRow();
}

function OnUnDeleteDTL()
{
    grdDTL.UnDeleteRow();
}

function OnPrintDTL()
{

}

function OnSaveDTL()
{
    idData_dsql_tpr_poreqd.Call("INSERT");   
}

function OnMakeVer()
{

}

function OnAfterEditGrid()
{
    /* Chua dung den
    if ( grdDTL.GetGridData(grdDTL.row, 13 ) > grdDTL.GetGridData(grdDTL.row, 12 ) )
    {
        alert("PO Reserve must small than PO Common");
        grdDTL.SetGridText(grdDTL.row, 13, ''); // PO Reserve
        return;
    }    
    
    if ( grdDTL.GetGridData(grdDTL.row, 14 ) > grdDTL.GetGridData(grdDTL.row, 11 ) )
    {
        alert("Transfer Qty must small than Common Stock");
        grdDTL.SetGridText(grdDTL.row, 14, ''); // Transfer Qty
        return;
    }
    */
}

function OnClick()
{
    txtMRPK.SetDataText(grdMST.GetGridData(grdMST.row, 0));
    idData_dsql_tpr_poreq.StatusSelect();    
    idData_dsql_tpr_poreq.Call("SELECT");
}

function OnDBClick()
{
    var obj = grdDTL.GetGridControl();
    
    if (obj.col == 6)
    {
        var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
        oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
        
        if ( oValue != null )
        {
            grdDTL.SetGridText(grdDTL.rows-1, 5, oValue[0] )
            grdDTL.SetGridText(grdDTL.rows-1, 6, oValue[2] )
        }
    }
}

function onReceiveDTL()
{   
    status_control = idData_dsql_tpr_poreq.GetStatus();
    
    idData_dsql_tpr_poreqd.Call('SELECT');
}

function onReceiveData()
{   
    if ( lstStatus.value == 'CF' )
    {
        lstStatus.SetEnable(false);
        btnNewMST.SetEnable(false);
        btnDeleteMST.SetEnable(false);
        btnSaveMST.SetEnable(false);
        btnDeleteDTL.SetEnable(false);
        btnUnDeleteDTL.SetEnable(false);
        btnSaveDTL.SetEnable(false);
    }
    else
    {   
        lstStatus.SetEnable(true);
        btnNewMST.SetEnable(true);
        btnDeleteMST.SetEnable(true);
        btnSaveMST.SetEnable(true);
        btnDeleteDTL.SetEnable(true);
        btnUnDeleteDTL.SetEnable(true);
        btnSaveDTL.SetEnable(true);
    }
    
    if ( status_control == 10 || status_control == 20 || status_control == 40)
    {
        idData_dsql_sel_left.Call('SELECT');
    }
    else
    {}
}

</script>
<body>
<gw:data id="idData_dsql_sel_left"  onreceive="" > 
    <xml> 
       <dso id="1" type="grid" user="prod" function="prod.sp_sel_tpr_poreq_left" > 
            <input  bind="grdMST">
                <input bind="txtMRNoL" />
                <input bind="dtbFromL" />
                <input bind="dtbToL" />
            </input> 
            <output bind="grdMST" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="idData_dsql_tpr_poreq" onreceive="onReceiveDTL()" > 
    <xml> 
        <dso id="2" type="control" parameter="0,1,2,3,4,6,7,9,10" function="prod.sp_sel_tpr_poreq" procedure="prod.sp_upd_tpr_poreq">
            <input>
                <inout bind="txtMRPK" />
                <inout bind="lstCom" />
                <inout bind="txtMRNoR" />
                <inout bind="dtbFromR" />
                <inout bind="txtEmpPK" />
                <inout bind="txtEmpR" />
                <inout bind="dtbTakeInDate" />
                <inout bind="txtProjPK" />
                <inout bind="txtProject" />
                <inout bind="lstStatus" />
                <inout bind="txtRemark" />
            </input>
        </dso>
    </xml>
</gw:data>


<gw:data id="idData_dsql_tpr_poreqd"  onreceive="onReceiveData()" > 
    <xml> 
       <dso id="3" type="grid" user="prod" parameter="0,1,5,7,15,16,17,18,19" function="prod.sp_sel_tpr_poreqd" procedure="prod.sp_upd_tpr_poreqd"> 
            <input bind="grdDTL">
                <input bind="txtMRPK" />               
            </input> 
            <output bind="grdDTL" /> 
        </dso> 
    </xml> 
</gw:data>

<table width="100%" border="0" style="background: #BDE9FF" id="tableID1" >
    <tr>    
        <td id="left" width="35%" valign="top" style="background: White" >
            <table width="100%" border="0">
                <tr>
                    <td width=10%><b>MR No.</b></td>
                    <td width=10%><gw:textbox id="txtMRNoL" styles="width: 100%" /></td>
                    <td width=3%></td>
                    <td width=10% align="left"><gw:imgbtn id="btnSearchL" img="search" alt="Search" text="Search" onclick="OnSearch()" /></td>
                </tr>
                <tr>
                    <td width=10%><b>MR Date</b></td>
                    <td width=10%><gw:datebox id="dtbFromL" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                    <td width=3%><b>&nbsp;~</b></td>
                    <td width=10%><gw:datebox id="dtbToL" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <gw:grid
                            id="grdMST"
                            header="_PK|MR Date|MR No"
                            format="0|4|0"
                            aligns="1|0|0"
                            defaults="||"
                            editcol="0|0|0"
                            widths="0|1500|0"
                            styles="width:100%; height:400"
                            sorting="T"
                            oncellclick="OnClick()"
                            param="0,1,2"/>
                    </td>
                </tr>
            </table>    
        </td>
        
        <td id="right" width="65%" valign="top" style="background: White" >
            <table width="100%" border="0">
                <tr>
                    <td width="100%">
                        <table width="100%" border="0">
                            <tr>
                                <td width="15%"><b>Company</b></td>
                                <td width="35%" colspan=2><gw:list id="lstCom" styles="width: 100%" /></td>                                
                                <td width="50%" colspan=3>
                                    <table width="100%" >
                                        <tr>
                                            <td width="83%"></td>
                                            <td width="5%"><gw:icon   id="idMakeVersion" 	   img="in"              onclick="OnMakeVer()" text="Make version" styles="display: none"  /></td>
                                            <td width="3%"><gw:imgBtn id="btnNewMST"           img="new"             alt="New"    onclick ="OnNewMST()"/></td>
                                            <td width="3%"><gw:imgBtn id="btnDeleteMST"        img="delete"          alt="Delete" onclick ="OnDeleteMST()"/></td>
                                            <td width="3%"><gw:imgBtn id="btnSaveMST"          img="save"            alt="Save"   onclick ="OnSaveMST()"/></td>
                                        </tr>
                                    </table>
                                </td>                                
                            </tr>
                            <tr>
                                <td width="15%"><b>MR No.</b></td>
                                <td width="20%"><gw:textbox id="txtMRNoR" styles="width: 100%" /></td>
                                <td width="15%"><b>&nbsp; &nbsp; &nbsp; &nbsp;MR Date</b></td>
                                <td width="15%"><gw:datebox id="dtbFromR" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                                <td width="15%"><b style="color: Blue; cursor: hand" onclick="TabPopUp(1)" >&nbsp; &nbsp; &nbsp; &nbsp;MR Emp</b></td>
                                <td width="20%"><gw:textbox id="txtEmpR" styles="width: 100%"/></td>
                            </tr>
                            <tr>
                                <td width="15%"><b>Take in date</b></td>
                                <td width="20%"><gw:datebox id="dtbTakeInDate" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                                <td width="15%"><b style="color: Blue; cursor: hand" onclick="TabPopUp(2)">&nbsp; &nbsp; &nbsp; &nbsp;Project
                                <td width="15%"><gw:textbox id="txtProject" styles="width: 100%" /></td>
                                <td width="15%"><b>&nbsp; &nbsp; &nbsp; &nbsp;Status</b></td>
                                <td width="20%"><gw:list id="lstStatus" styles="width: 100%" /></td>
                            </tr>
                            <tr>
                                <td width="15%"><b>Remark</b></td>
                                <td width="85%" colspan="5" ><gw:textbox id="txtRemark" styles="width: 100%" /></td>
                            </tr>
                            <tr>
                                <td width="100%" colspan="6">
                                    <table width="100%">
                                        <tr>
                                            <td width="80%"></td>
                                            <td width="3%"><gw:icon   id="idGetConsum"      img="in"         onclick="TabPopUp(3)"   text="Get Item from consumtion" styles="display:none" /></td>
                                            <td width="3%"><gw:icon   id="idGetItem"        img="in"         onclick="TabPopUp(4)"   text="Get Item"/></td>
                                            <td width="3%"><gw:imgBtn id="btnPrint"         img="printer"    alt="Print"    onclick="OnPrintDTL()"/></td>
                                            <td width="5%"><gw:imgBtn id="btnDeleteDTL"     img="delete"     alt="Delete"   onclick="OnDeleteDTL()"/></td>
                                            <td width="3%"><gw:imgBtn id="btnUnDeleteDTL"   img="udelete"    alt="UnDelete" onclick="OnUnDeleteDTL()"/></td>
                                            <td width="3%"><gw:imgBtn id="btnSaveDTL"       img="save"       alt="Save"     onclick="OnSaveDTL()"/></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>                    

                            <tr>
                                <td colspan="6">
                                        <!--     0 |   1   |  2  |    3    |    4    |      5    |    6    |   7   |   8   |   9     |     10     |      11     |     12   |    13     |      14     |  15  |     16     | 17 |  18  |   19 -->
                                    <gw:grid
                                        id="grdDTL"
                                        header="_PK|_ItemPK|Group|Item Code|Item Name|_CustomerPK|_Customer|_S/O_PK|_S/O No|_Need Qty|_Order Stock|_Common Stock|_PO Common|_PO Reserve|_Transfer Qty|MR Qty|_Take In Date|Unit|Remark|_tpr_poreq"
                                        format="0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|4|0|0|0"
                                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0"
                                        defaults="|||||||||||||||||||"
                                        editcol="0|0|0|0|0|0|0|0|0|1|0|1|1|1|1|1|1|1|1|1"
                                        widths="0|0|2500|2000|2000|0|2000|0|1500|1000|1500|1500|1500|1500|1500|0|0|0|0|0"
                                        styles="width:100%; height:300"
                                        sorting="T"
                                        onafteredit="OnAfterEditGrid()"
                                        oncelldblclick="OnDBClick()"
                                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<gw:textbox id="txtProjPK" styles="width: 100%;display: none"/>
<gw:textbox id="txtEmpPK"  styles="width: 100%;display: none"/>
<gw:textbox id="txtMRPK"  styles="width: 100%;display: none"/>
<img status="expand" id="imgArrow" src="../../../images/left-arrow.ico" style="cursor:hand;position:absolute;left:1;top:0;" onclick="OnToggle()" /> 

</body>
</html>
