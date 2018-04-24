<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Outgo Return Request</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>
var G2_PK                           = 0,
    G2_ST_OUTGO_RETURN_REQ_M_PK     = 1,
    G2_SEQ                          = 2,
    G2_REF_NO                       = 3,
    G2_REQ_ITEM_PK                  = 4,
    G2_ITEM_CODE                    = 5,
    G2_ITEM_NAME                    = 6,
    G2_REQ_QTY                      = 7,
    G2_REQ_UOM                      = 8,
    G2_LOT_NO                       = 9,
    G2_DESCRIPTION                  = 10;
   
var user_name = "<%=Session("USER_NAME")%>"   ;
var user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
var comp_pk   = "<%=Session("COMPANY_PK") %>" ;
var arr_FormatNumber = new Array();  
var flag ;
//====================================================================================
function BodyInit()
{
    System.Translate(document); 
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtSlipNo.SetEnable(false);
    txtChargerName.SetEnable(false);
    txtPartnerName.SetEnable(false);
    txtPLName.SetEnable(false);
    
    SetGridFormat();
    BindingDataList();
    lstWH.value = "";
    
    OnAddNew('Master');
 }
//====================================================================================

function BindingDataList()
{
    var ldate;    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    
    var data="";
        
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id ||' * '||wh_name  FROM tlg_in_warehouse  WHERE del_if = 0 and use_yn='Y'  ORDER BY wh_name  ASC" )%>||";    
    lstWH.SetDataText(data);       
    lstReWH.SetDataText(data); 
}
//====================================================================================
 function SetGridFormat()
 {
    var ctrl = grdDetail.GetGridControl(); 
    
    ctrl.ColFormat(G2_REQ_QTY) = "#,###,###,###,###,###.##";    
    arr_FormatNumber[G2_REQ_QTY]   = 2;
 }
//====================================================================================

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("img1"); 

    if(imgArrow.status == "expand")
    {
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/button/next.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="80%";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
//====================================================================================
 
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_bias00110.Call('SELECT');
        break;
        //------------------
        case 'Master':
            txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0 );
            data_bias00110_1.Call('SELECT');
        break;
    }
}
//====================================================================================
function OnAddNew()
{             
    data_bias00110_1.StatusInsert();    
    txtSlipNo.text   = '***New Voucher***';
    //-------------------------------------------
    txtChargerName.text = "<%=Session("USER_NAME")%>";
    txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
    //------------------------------------------- 
    grdDetail.ClearData(); 
}
//====================================================================================

function OnSave(pos)
{   
    switch(pos)
    { 
        case 'Master':
            data_bias00110_1.Call();    
            flag="save";        
        break;
        //--------------
        case 'Detail':
            data_bias00110_2.Call();            
        break;        
    }    
}
//====================================================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_bias00110_1":   
            if(flag == "save")
            { 
                for(var i=1; i < grdDetail.rows;i++)
                {
                        if ( grdDetail.GetGridData( i, G2_ST_OUTGO_RETURN_REQ_M_PK) == '' )
                        {
                            grdDetail.SetGridText( i, G2_ST_OUTGO_RETURN_REQ_M_PK, txtMasterPK.text);
                        } 
                }
                    data_bias00110_2.Call();
            }
            else
            {
               data_bias00110_2.Call('SELECT');
            }
        break;  
        //----------------------
        case "data_bias00110_2":   
            if(grdDetail.rows > 1)
            {
                grdDetail.SetCellBold( 1, G2_ITEM_CODE, grdDetail.rows - 1, G2_ITEM_CODE,  true);
                grdDetail.SetCellBold( 1, G2_REQ_QTY, grdDetail.rows - 1, G2_REQ_QTY,  true);
            }
        break;       
        //--------------------
        case 'pro_bias00110':
            alert(txtReturnValue.text);
            OnSearch('Master');
        break;   
        case 'pro_bias00110_1':
            alert(txtReturnValue.text);
        break;            
    }
}
 
//====================================================================================
function OnPopUp(obj)
{
    switch(obj)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
            }
        break;  
        //---------------------------
        case 'Partner':
            var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtPartnerName.text = obj[2];
                txtPartnerPK.text   = obj[0];
            }
        break; 
        //-----------------------
        case 'PL': 
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[6]; 
                txtPLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;
        //----------------------------
        case 'FreeItem':
            if(txtPartnerPK.text!="")
            {
                 var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=||Y|Y||';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];
                                    
                                grdDetail.AddRow();                            
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ                     , grdDetail.rows-1);
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ST_OUTGO_RETURN_REQ_M_PK, txtMasterPK.text); //master_pk	    	                                               
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_ITEM_PK             , arrTemp[0]);//item_pk	    
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE               , arrTemp[1]);//item_code	    
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME               , arrTemp[2]);//item_name	    
                                grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM                 , arrTemp[5]);//item_uom                                                  
                        }
                 } 
             }
             else
             {
                alert("Please Select Partner first !!!");
             }
        break;
        //--------------------------          
    }
}
//====================================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_REQ_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
            break;             
      }         
}
//====================================================================================
function OnDelete(obj)
{
    if(obj == "Master")
    {
        if(confirm('Do you want to delete this request?'))
        {
            data_bias00110_1.StatusDelete();
            data_bias00110_1.Call();
        }        
    }
    if(obj == "Detail")
    {
        if(confirm('Do you want to delete this Item?'))
        {
                if ( grdDetail.GetGridData( grdDetail.row, G2_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
        }        
    }
}
//====================================================================================
function OnUnDelete()
{
    grdDetail.UnDeleteRow();
}
//====================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Confirm' :
            if ( confirm('Do you want to confirm this Slip?'))
            {
                pro_bias00110.Call();
            }               
        break;
        
        case 'Return' :
            if(txtMasterPK.text!="")
            {
                if(lblStatus.text=="SUBMITED")
                {
                    if ( confirm('Do you want to return this Slip?'))
                    {
                        pro_bias00110_1.Call();
                    }
                }
                else
                {
                    alert("This slip not yet Submit!!!");
                }
            }
            else
            {
                alert("Please Select one Slip to Return!!!");
            }               
        break;
    }
}
</script>

<body>
    <!------------------------------------------------------------------->
    <gw:data id="data_bias00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_bias00110" > 
                <input>                     
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtVoucherSearch" />
                    <input bind="lstWh" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bias00110_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_bias00110_1"  procedure="<%=l_user%>lg_upd_bias00110_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstReWH" />
                     <inout  bind="dtReDate" />  
                     <inout  bind="txtRefNo" />                         
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="txtRemark" />
                     <inout  bind="txtPartnerPK" />
                     <inout  bind="txtPartnerName" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="lblStatus" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="data_bias00110_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_sel_bias00110_2" procedure="<%=l_user%>lg_upd_bias00110_2"> 
                <input> 
                    <input bind="txtMasterPK" />                
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bias00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bias00110" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="pro_bias00110_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bias00110_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                    <input bind="txtEmpPK" />  
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%" align="right">
                            Date
                        </td>
                        <td style="width: 69%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            Slip No
                        </td>
                        <td colspan="1">
                            <gw:textbox id="txtVoucherSearch" styles="width:100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="3">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnReturn" img="2" text="Auto Return" styles='width:30%' onclick="OnProcess('Return')" />
                                    </td>
                                    <td style="width: 99%">
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip No|Date|Ref No" format="0|0|0|4|0"
                                aligns="1|0|0|1|0" defaults="|||||" editcol="0|0|0|0|0" widths="0|1000|1000|1100|1000"
                                styles="width:100%; height:100%" sorting="T" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 2%">
                            Date
                        </td>
                        <td>
                            <gw:datebox id="dtReDate" lang="1" />
                        </td>
                        <td style="width: 100%" colspan="2" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='' />
                        </td>
                        <td>
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Confirm')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Ref No
                        </td>
                        <td style="width: 40%" colspan="3">
                            <gw:textbox id="txtRefNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 5%" align="right">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            W/H
                        </td>
                        <td colspan="3">
                            <gw:list id="lstReWH" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right">
                            <a title="Charger" onclick="OnPopUp('Partner')" href="#tips" style="color=#0000ff"><b>
                                Partner</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtPartnerName" styles="width:100%" />
                            <gw:textbox id="txtPartnerPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap">
                            Description
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                        <td align="right">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color=#0000ff"><b>P/L</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="left" colspan="6">
                            <img status="expand" id="img1" src="../../../system/images/button/previous.gif" style="cursor: hand"
                                onclick="OnToggle()" />
                        </td>
                        <td style="width: 1%" align="right" colspan="3">
                            <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:10%' onclick="OnPopUp('FreeItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_pk|_st_outgo_return_req_m_pk|Seq|Ref No|_req_item_pk|Item Code|Item Name|Req Qty|Req Uom|Lot No|Description'
                                format='0|0|0|0|0|0|0|1|2|0|0' aligns='0|0|1|0|0|0|0|0|1|0|0' editcol='1|1|0|1|1|0|0|1|1|1|1'
                                widths='0|0|500|1000|0|1200|2500|1000|1000|1000|1200' sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnGridCellDoubleClick(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="display:none"></gw:textbox>
    <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
    <!------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!------------------------------------------------------------------->
</body>
</html>
