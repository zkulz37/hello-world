<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head>
    <title>Standard Consumption</title>
</head>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">
var     
        //-------grdSearch--------- 
        G_PK_01                 = 0,
        G_CODE_01               = 1,
        G_NAME_01               = 2,        
        //-------grdMaster---------    
        G_PK_02                 = 0,
        G_TCO_STITEM_PK_02      = 1,
        G_REG_DATE_02           = 2,
        G_STATUS_02             = 3,
        G_RECEIVE_DATE_02       = 4,
        G_RECEIVE_NO_02         = 5,
        G_CHARGER_PK_02         = 6,
        G_FULL_NAME_02          = 7,
        G_COMPANY_02            = 8,        
        G_DESCRIPTION_02        = 9, 
        //-------grdDetail---------
        G_PK_03                 = 0,
        G_TIE_CONS_REG_M_PK_03  = 1,
        G_SEQ_03                = 2,
        G_TCO_STITEM_PK_03      = 3,
        G_ITEM_CODE_03          = 4,
        G_ITEM_NAME_03          = 5,
        G_UOM_03                = 6,
        G_NEED_QTY_03           = 7,
        G_LOSS_RATE_03          = 8,
        G_CONS_QTY_03           = 9,
        G_ORIGINAL_03           = 10,
        G_DESCRIPTION_03        = 11;
    //----------------------------------------    
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name ="<%=Session("USER_NAME")%>" ;
 //---------------------------------------------------------
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
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 } 
//-----------------------------------------------------

function BodyInit()
{
    BindingDataList();    
    OnSearch('grdSearch');
}
//-----------------------------------------------------
 function BindingDataList()
{    
    var data = "<%=ESysLib.SetListDataSQL("SELECT   a.pk, a.grp_cd || ' - ' || a.grp_name FROM tlg_ie_item_group a, tlg_ie_item b WHERE a.del_if = 0 AND b.del_if = 0 AND a.group_type = 1 AND a.pk = b.tlg_ie_item_group_pk ORDER BY grp_cd")%>||Select ALL";   
    lstGroup.SetDataText(data);
    lstGroup.value = '' ;       

    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";    
    grdMaster.SetComboFormat(G_COMPANY_02,data);   
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IEBS0060' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm" ) %> ";       
    grdDetail.SetComboFormat(G_ORIGINAL_03,data);   
    
}
//-----------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
                data_epcs00010.Call('SELECT');
        break;
        //-------------------
        case 'grdMaster':
                grdDetail.ClearData();
                txtTcoStItemPK.text = grdSearch.GetGridData( grdSearch.row, G_PK_01);
                data_epcs00010_1.Call('SELECT');
        break;
        //-------------------
        case 'grdDetail':
                txtTieConsRegPK.text = grdMaster.GetGridData( grdMaster.row, G_PK_02);
                data_epcs00010_2.Call('SELECT');
        break;
    }
}

//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_epcs00010':
            grdMaster.ClearData();
            grdDetail.ClearData();
            lblRecord.text = grdMaster.rows-1 + ' row(s)';
            lblRecord2.text = grdDetail.rows-1 + ' row(s)'; 
        break;
        //-------------------
        case 'data_epcs00010_1':
            lblRecord.text = grdMaster.rows-1 + ' row(s)';
            lblRecord2.text = grdDetail.rows-1 + ' row(s)'; 
            for(var i = 1; i < grdMaster.rows; i++)
            {
                grdMaster.SetCellFontColor(1, G_STATUS_02, i, G_STATUS_02, 0x0000FF )                 
            }        
        break;   
        //--------------
        case 'data_epcs00010_2':
            lblRecord2.text = grdDetail.rows-1 + ' row(s)';    
        break; 
        //------------
        case 'pro_epcs00010':
            data_epcs00010_1.Call('SELECT');
            alert(txtReturnValue.text);
        break;
        //--------------
        case 'pro_epcs00010_1':
            data_epcs00010_1.Call('SELECT');
            alert(txtReturnValue.text);
        break;
        //--------------
        case 'pro_epcs00010_2':
            data_epcs00010_1.Call('SELECT');
            alert(txtReturnValue.text);
        break;                        
    }
}
//------------------------------------------------
function OnAddNew(obj)
{ 
    switch(obj)
    {
        case 'Master':
             if(grdSearch.row < 0)
             {
                alert('Pls select one ')
             }
             else
             {
                grdMaster.AddRow();         
                grdMaster.SetGridText( grdMaster.rows-1, G_TCO_STITEM_PK_02, grdSearch.GetGridData( grdSearch.row, G_PK_01));
                grdMaster.SetGridText( grdMaster.rows-1, G_STATUS_02, "::::");
                grdMaster.SetGridText( grdMaster.rows-1, G_CHARGER_PK_02, user_pk);
                grdMaster.SetGridText( grdMaster.rows-1, G_FULL_NAME_02, user_name);
             }
        break;

        case 'STITEM' :
             if(grdMaster.row < 0)
             {
                alert('Pls select one ')
             }
             else
             {
                 var path = System.RootURL + '/form/ep/cs/epcs00011.aspx';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];

                                grdDetail.AddRow();                
                                            
                                grdDetail.SetGridText( grdDetail.rows-1, G_SEQ_03, grdDetail.rows-1);                           
                                grdDetail.SetGridText( grdDetail.rows-1, G_TIE_CONS_REG_M_PK_03, grdMaster.GetGridData( grdMaster.row, G_PK_02));                   
                                grdDetail.SetGridText( grdDetail.rows-1, G_TCO_STITEM_PK_03, arrTemp[2]);//item_pk	    
                                grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE_03,    arrTemp[3]);//item_code	    
                                grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME_03,    arrTemp[4]);//item_name	    
                                grdDetail.SetGridText( grdDetail.rows-1, G_UOM_03, arrTemp[5]);//item_uom  
                        }	
                 }   
             }
        break;        
    }
}
//-----------------------------------------------------

function OnSave(pos)
{
    switch(pos)
    { 
        case 'Master':
            data_epcs00010_1.Call();                 
        break;
        //-------------------
        case 'Detail':
            data_epcs00010_2.Call();
        break;
    }          
}
//------------------------------------------------------------
function OnDelete(obj)
 {
      switch (obj)         
      {	  
            case 'Master':
                    if ( grdMaster.GetGridData( grdMaster.row, G_PK_02 ) == '' )
                    {
                        grdMaster.RemoveRow();
                    }
                    else
                    {   
                        grdMaster.DeleteRow();
                    }                        
            break; 
            //-------------------
           case 'Detail':
                    if(confirm('Do you want to delete this Item?'))
                    {
                        if ( grdDetail.GetGridData( grdDetail.row, G_PK_03 ) == '' )
                        {
                            for(var i = 0; i < grdDetail.rows; i++)
                            {
                                grdDetail.RemoveRow(i);
                            }
                        }
                        else
                        {   
                            for(var j = 0; j < grdDetail.rows; j++)
                            {
                                grdDetail.DeleteRow(j);
                            }
                        }    
                    } 
           break;
	  }
 }
//---------------------------------------------------------
 function OnUnDelete(obj)  
{
	switch(obj)
	{
	    case 'Master':
	        grdMaster.UnDeleteRow();
	    break;
	    //------------------	
	    case 'Detail':
	        grdDetail.UnDeleteRow();
	    break;
	}
}
//------------------------------------------------------------------
function OnProcess(obj)
{
    switch(obj)
    {
        case 'Confirm':
            if(grdMaster.row > 0)
            {
                txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G_PK_02 );
                pro_epcs00010.Call();
            }
            else
            {
                alert('Pls select one')
            }
        break;
        //--------------------
        case 'Approve':
            if(grdMaster.row > 0)
            {
                txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G_PK_02 );
                pro_epcs00010_1.Call();
            }
            else
            {
                alert('Pls select one')
            }        
        break;
        //---------------------
        case 'Cancel':
            if(grdMaster.row > 0)
            {
                txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G_PK_02 );
                pro_epcs00010_2.Call();
            }
            else
            {
                alert('Pls select one')
            }        
        break;
    }
}
//-------------------------
function OnCheckInput()
{
    var col=event.col;
    var row=event.row;
    if(col==G_NEED_QTY_03 ||col==G_LOSS_RATE_03)
    {
        grdDetail.SetGridText(grdDetail.row,G_CONS_QTY_03,Number(grdDetail.GetGridData(grdDetail.row,G_NEED_QTY_03))+Number(grdDetail.GetGridData(grdDetail.row,G_LOSS_RATE_03))*Number(grdDetail.GetGridData(grdDetail.row,G_NEED_QTY_03))/100);
    }
}
//-------------------------
function OnReport()
{
    if ( grdMaster.row > 0 )
    {
        txtTieConsRegPK.text = grdMaster.GetGridData( grdMaster.row, G_PK_02 );
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ep/cs/rpt_epcs00010.rpt&procedure=IMEX.sp_rpt_epcs00010_1|IMEX.sp_rpt_epcs00010_2&parameter="+ txtTieConsRegPK.text +"|"+ txtTieConsRegPK.text;   
        System.OpenTargetPage(url);        
    }
    else
    {
        alert("Pls select one Registration first.");
    }       
}
</script>

<body>
	<!------------------------------------------------------------------>
    <gw:data id="data_epcs00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2" function="<%=l_user%>lg_sel_epcs00010" > 
                <input>
                    <input bind="lstGroup" /> 
                    <input bind="txtItem" />                  
                    <input bind="chkActive" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epcs00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_epcs00010_1" procedure="<%=l_user%>lg_upd_epcs00010_1" >
                <input>                    
                    <input bind="txtTcoStItemPK" /> 
                </input> 
                <inout bind="grdMaster" />                 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epcs00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="<%=l_user%>lg_sel_epcs00010_2" procedure="<%=l_user%>lg_upd_epcs00010_2">  
			    <inout>                    
                    <inout bind="txtTieConsRegPK" /> 
                </inout> 
                <inout bind="grdDetail" />                 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_epcs00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epcs00010" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_epcs00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epcs00010_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_epcs00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epcs00010_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table class="table" style="height: 100%; width: 100%" cellpadding="0" cellspacing="0"
        border="1">
        <tr style="height: 100%">
            <td id="left" style="width: 30%" valign="top">
                <table style="height: 100%; width: 100%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td>
                            <table style="height: 100%; width: 100%" border="0">
                                <tr style="height: 1%">
                                    <td align="right" style="width: 25%">
                                        <b>Group</b>
                                    </td>
                                    <td style="width: 60%" align="left">
                                        <gw:list id="lstGroup" styles="width:100%" onchange="OnSearch('grdSearch')" />
                                    </td>
                                    <td style="width: 15%" align='right'>
                                        <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 25%">
                                        <b>Item</b>
                                    </td>
                                    <td style="width: 60%" align="left">
                                        <gw:textbox id="txtItem" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 20%" align="right">
                                        Consumpsion
                                    </td>
                                    <td align="left">
                                        <gw:checkbox id="chkActive" defaultvalue="Y|N" value="N" onchange="OnSearch('grdSearch')" />
                                    </td>
                                </tr>
                                <tr style="height: 97%">
                                    <td colspan="3">
                                        <gw:grid id="grdSearch" header="_PK|Code|Name" format="0|0|0" aligns="0|0|0" defaults="||"
                                            editcol="0|0|0" widths="0|1500|1200" styles="width:100%; height:100%" sorting="T"
                                            param="0,1,2" oncellclick="OnSearch('grdMaster')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%" valign="top">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table>
                                            <tr align="right">
                                                <td>
                                                    <gw:icon id="btnConfirm" img="2" text="Confirm" onclick="OnProcess('Confirm')" />
                                                </td>
                                                <td>
                                                    <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                                                </td>
                                                <td>
                                                    <gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                                                </td>
                                                <td style="width: 100%" align="center">
                                                    <gw:label id="lblRecord" styles="color: blue"></gw:label>
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="btnNew" img="new" alt="Add" text="Add" onclick="OnAddNew('Master')" />
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="btnUnDelete" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete('Master')" />
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="btnExcel" img="excel" alt="Report" onclick="OnReport()" />
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 30%">
                        <td>
                            <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <gw:grid id='grdMaster' header='_PK|_TCO_STITEM_PK|Reg Date|Status|Receive Date|Receive No|_CHARGER_PK|Full Name|Company|Description'
                                            format='0|0|4|0|4|0|0|0|0|0' aligns='0|0|1|1|1|1|0|0|0|0' check='|||||||||' editcol='1|1|1|0|1|1|1|0|1|1|'
                                            widths='1000|1000|1200|1000|1300|1200|1000|2500|2000|1000' sorting='T' styles='width:100%; height:100%'
                                            oncellclick="OnSearch('grdDetail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table>
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 90%" align="center">
                                        <gw:label id="lblRecord2" styles="color: blue"></gw:label>
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnNew2" img="new" alt="Add" text="Add" onclick="OnAddNew('STITEM')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnDelete2" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnUnDelete2" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete('Detail')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnSave2" img="save" alt="Save" text="Save" onclick="OnSave('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 68%">
                        <td>
                            <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <gw:grid id='grdDetail' header='_PK|_TIE_CONS_REG_M_PK|Seq|_TCO_STITEM_PK|Item Code|Item Name|UOM|Need Qty|Loss Rate|Cons Qty|Original|Description'
                                            format='0|0|0|0|0|0|0|1|1|1|0|0' aligns='0|0|1|0|0|0|1|0|0|0|0|0' check='|||||||||||'
                                            editcol='0|0|0|0|0|0|0|1|1|1|1|1' widths='1000|1000|500|1000|1100|2500|1000|1000|1000|1000|2000|1000'
                                            sorting='T' styles='width:100%; height:100%' onafteredit="OnCheckInput()"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------->
    <!------------------------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtTcoStItemPK" styles='width:100%;display:none' />
    <gw:textbox id="txtTieConsRegPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------------------------------->
</body>
</html>
