<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Collection Slip Approve</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var G1_CHK              = 0,
    G1_PK               = 1,    
    G1_SLIP_DATE        = 2,
    G1_SLIP_NO          = 3,  
    G1_STATUS           = 4,
    G1_PARTNER_NAME     = 5,
    G1_PAY_AMOUNT       = 6,
    G1_TR_CCY           = 7,
    G1_EX_RATE          = 8,
    G1_PAYMENT_METHOD   = 9,    
    G1_PAY_DESC         = 10;    
    
var G2_PK               = 0, 
    G2_SLIP_DATE        = 1,
    G2_SLIP_NO          = 2, 
    G2_STATUS           = 3,
    G2_PARTNER_NAME     = 4,
    G2_PAY_AMOUNT       = 5,
    G2_TR_CCY           = 6,
    G2_EX_RATE          = 7,
    G2_PAYMENT_METHOD   = 8, 
    G2_PAY_DESC         = 9;
    
//==================================================================
         
function BodyInit()
{      
    System.Translate(document);    
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));  
    dtFrom2.SetDataText(System.AddDate(dtTo2.GetData(),-30));
    
    FormatGrid();
  
}
//==================================================================
  
function FormatGrid()
{
    var data="";    
	
    var ctrl = grdApprove.GetGridControl();   
     
    ctrl.ColFormat(G1_PAY_AMOUNT) = "###,###,###" ;
    //---------------------
    ctrl = grdCancel.GetGridControl();  
    ctrl.ColFormat(G2_PAY_AMOUNT) = "###,###,###" ;
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdApprove':
            data_dsap00090.Call('SELECT');
        break;
        
        case 'grdCancel':
            data_dsap00090_1.Call('SELECT')
        break;
    }
}
//==================================================================
function OnGridCellClick(obj)
{
    switch(obj)
    {
        case'up':
            txtMasterPK.text=grdApprove.GetGridData(grdApprove.row,G1_PK);
        break;
        case'down':
            txtMasterPK1.text=grdCancel.GetGridData(grdCancel.row,G2_PK);
        break;
    }
}
//==================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case'up':
            if ( grdApprove.row > 0 )
            {                
                var path = System.RootURL + '/form/ds/ap/dsap00091.aspx?type=APPROVE&MasterPK=' + grdApprove.GetGridData( grdApprove.row, G1_PK ) ;
                var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
				
                OnSearch('grdApprove');
            }
            else
            {
                alert("Please select slip no to view Detail!!!")
            }
        break;
        
        case'down':
            if ( grdCancel.row > 0 )
            {
                
                var path = System.RootURL + '/form/ds/ap/dsap00091.aspx?type=CANCEL&MasterPK=' + grdCancel.GetGridData( grdCancel.row, G2_PK );
                var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
				
                OnSearch('grdApprove');
            }
            else
            {
                alert("Please select slip no to view Detail!!!")
            }
        break;
    }
}
//==================================================================
function OnPrint()
{    txtDateFrom.text=dtFrom2.value;
    txtDateTo.text=dtTo2.value;
     var url =System.RootURL + "/reports/fp/ip/rpt_dsap00090.aspx?dtFrom="+txtDateFrom.text+"&dtTo="+txtDateTo.text ;
	 System.OpenTargetPage(url); 
}
//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
            case 'data_dsap00090':                   
            lbRecord.text = grdApprove.rows-1 + " record(s)";
            
            if ( grdApprove.rows > 1 )
            {
                grdApprove.SetCellBold( 1, G1_SLIP_NO,    grdApprove.rows - 1, G1_SLIP_NO,    true);
                grdApprove.SetCellBold( 1, G1_PAY_AMOUNT, grdApprove.rows - 1, G1_PAY_AMOUNT, true);
                grdApprove.SetCellBgColor( 1, G1_SLIP_NO,    grdApprove.rows - 1, G1_SLIP_NO,    0xCCFFFF ); 
                grdApprove.SetCellBgColor( 1, G1_PAY_AMOUNT, grdApprove.rows - 1, G1_PAY_AMOUNT, 0xCCFFFF );				
            }
            OnSearch('grdCancel');            
        break;    
        
        case 'data_dsap00090_1':                   
            lbRecord1.text = grdCancel.rows-1 + " record(s)";   
            
            if ( grdCancel.rows > 1 )
            {
                grdCancel.SetCellBold( 1, G2_SLIP_NO,    grdCancel.rows - 1, G2_SLIP_NO,    true);
                grdCancel.SetCellBold( 1, G2_PAY_AMOUNT, grdCancel.rows - 1, G2_PAY_AMOUNT, true);
                grdCancel.SetCellBgColor( 1, G2_SLIP_NO,    grdCancel.rows - 1, G2_SLIP_NO,    0xCCFFFF ); 
                grdCancel.SetCellBgColor( 1, G2_PAY_AMOUNT, grdCancel.rows - 1, G2_PAY_AMOUNT, 0xCCFFFF );    
            }         
        break;  
        
        case 'pro_dsap00090' :
            alert(txtReturnValue.text);
            OnSearch('grdApprove') ;
        break;  
        
        case 'pro_dsap00090_1' :
            alert(txtReturnValue.text);
            
            OnSearch('grdCancel') ;
        break;   
        
    }
}
//==================================================================
function OnProcess(pos)
{
    var array_so_pk = '';
    var array_slip_no = '';

    switch (pos)
    {
        case 'Approve':
            for(i = 1; i < grdApprove.rows; i++)
            {
                if (grdApprove.GetGridData(i, G1_CHK) == -1)
                {
                    array_so_pk    = array_so_pk    + grdApprove.GetGridData(i, G1_PK) + ',';
                    array_slip_no = array_slip_no + grdApprove.GetGridData(i, G1_SLIP_NO) + ',';
                }
            }
            array_so_pk = array_so_pk.substring(0, array_so_pk.length-1); 
            array_slip_no = array_slip_no.substring(0, array_slip_no.length-1);
            if ( array_so_pk == '' )
            {
                alert('You must select one Slip.');
            }
            else
            {
                if ( confirm("Do you want to approve " + array_slip_no + " ? ") )
                {
                     txtArraySOPK.text = array_so_pk;
                     txtSOPO.text = array_slip_no;                     
                     pro_dsap00090.Call();
                } 
            }
        break;
        case 'Cancel':
            if (grdCancel.row > -1)
            {
                array_so_pk    = array_so_pk    + grdCancel.GetGridData(grdCancel.row, G2_PK) + ',';
                array_slip_no = array_slip_no + grdCancel.GetGridData(grdCancel.row, G2_SLIP_NO) + ',';
            }
            array_so_pk = array_so_pk.substring(0, array_so_pk.length-1);        
            array_slip_no = array_slip_no.substring(0, array_slip_no.length-1); 
            if ( array_so_pk == '' )
            {
                alert('You must select one Slip.');
            }
            else
            {
                if ( confirm("Do you want to cancel " + array_slip_no + " ? ") )
                {
                     txtArraySOPK.text = array_so_pk;
                     txtSOPO.text = array_slip_no;                     
                     pro_dsap00090_1.Call();
                } 
            }             
        break;
    }    
}

//==================================================================
 function OnToggle()
 {
    var tab_top  = document.all("tab_top");    
    var tab_bottom = document.all("tab_bottom");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        tab_top.style.display="none";       
        imgArrow.status = "collapse";
        tab_bottom.style.width="100%";
        imgArrow.src = "../../../system/images/down.gif";
    }
    else
    {
        tab_top.style.display="";
        imgArrow.status = "expand";
        tab_bottom.style.height="50%";
        imgArrow.src = "../../../system/images/up.gif";
    }
 }    

//==================================================================
         
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00090" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_dsap00090"  >
                <input bind="grdApprove" >
			        <input bind="dtFrom" />
			        <input bind="dtTo" />
			        <input bind="txtPartner" />
			        <input bind="txtSlipRefNo" />
                </input>
                <output bind="grdApprove" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00090_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00090_1"  >
                <input bind="grdCancel" >
			        <input bind="dtFrom2" />
			        <input bind="dtTo2" />
			        <input bind="txtPartner2" />
			        <input bind="txtSlipRefNo2" />
                </input>
                <output bind="grdCancel" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00090" > 
                <input>
                    <input bind="txtArraySOPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00090_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00090_1" > 
                <input>
                    <input bind="txtArraySOPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 50%" id="tab_top">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Partner
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPartner" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Slip/Ref No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipRefNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 27%; text-align: center; white-space: nowrap">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnMakeOrdPlanAuto" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnMakeOrdPlan" img="2" text="Detail" onclick="OnPopUp('up')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="10">
                            <gw:grid id='grdApprove' header='Chk|_pk|Slip Date|Slip No|Status|Partner Name|Collect Amount|CCY|Ex Rate|Out Type|Collection Desc'
                                format='3|0|4|0|0|0|0|0|0|0|0' aligns='0|0|1|0|1|0|3|1|3|0|0' check='||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0' widths='500|0|1200|1500|1200|3000|1500|1000|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%" id="tab_bottom">
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 2%" align="left">
                            <img id="imgArrow" status="expand" id="imgUp" src="../../../system/images/up.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td style="width: 1%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom2" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo2" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Partner
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPartner2" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Slip/Ref No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipRefNo2" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="center">
                            <gw:label id="lbRecord1" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdCancel')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="excel" alt="Print Report" id="btnPrint" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnCancelDetail" img="2" text="Detail" onclick="OnPopUp('down')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="14">
                            <gw:grid id='grdCancel' header='_pk|Slip Date|Slip No|Status|Partner Name|Collect Amount|CCY|Ex Rate|Out Type|Collection Desc'
                                format='0|4|0|0|0|0|0|0|0|0' aligns='0|1|0|1|0|3|1|3|0|0' check='|||||||||' editcol='0|0|0|0|0|0|0|0|0|0'
                                widths='0|1200|1500|1200|3000|1500|1000|1200|1200|1000' sorting='T' styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtDateFrom" styles='width:100%;display:none' />
    <gw:textbox id="txtDateTo" styles='width:100%;display:none' />
    <gw:textbox id="txtOrdPlanPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtStylePK" styles='width:100%;display:none' />
    <gw:textbox id="txtArraySOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtSOPO" styles='width:100%;display:none' />
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtMasterPK1" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
