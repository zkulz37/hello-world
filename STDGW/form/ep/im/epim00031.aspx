<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pop Up Import Invoice List</title>
</head>

<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script language="javascript" type="text/javascript">
//=============================================================================
var G_CV_PK         = 0,
    G_PARTNER_ID    = 1,
    G_PARTNER_NAME  = 2, 
    G_CV_DATE       = 3,
    G_CV_NO         = 4, 
    G_CONTRACT_NO   = 5,
    G_REF_PO_NO     = 6,
    G_LC_NO         = 7,
    G_TR_CCY        = 8,
    G_TR_AMOUNT     = 9,
    G_DISCOUNT_RATE = 10,
    G_DISCOUNT_AMT  = 11;
//=============================================================================

 function BodyInit()
 {    
        System.Translate(document);  // Translate to language session
           
        var now = new Date(); 
        var lmonth, ldate;
                
        ldate = dtFromDate.value;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
        dtFromDate.value = ldate ;
        
        OnChangeClose();
        
        BindingDataList(); 
        
        OnSearch('Master');       
 }
//=============================================================================
     
 function BindingDataList()
 {   
     var data = "" ;
                      
     data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
     lstCompany.SetDataText(data);
     
     var ctr = grdDetail.GetGridControl(); 
     ctr.ColFormat(G_TR_AMOUNT)     = "#,###,###,###,###,###.##";
     ctr.ColFormat(G_DISCOUNT_RATE) = "#,###,###,###,###,###.##";
     ctr.ColFormat(G_DISCOUNT_AMT)  = "#,###,###,###,###,###.##";
        
 }
          
//=============================================================================
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'data_epim00031':
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBgColor( 1, G_CV_NO, grdDetail.rows-1, G_CV_NO, 0xCCFFFF );
                    
                    grdDetail.SetCellBold( 1, G_TR_AMOUNT,    grdDetail.rows - 1, G_TR_AMOUNT,    true);
                    grdDetail.SetCellBold( 1, G_DISCOUNT_AMT, grdDetail.rows - 1, G_DISCOUNT_AMT, true);
                    
                    grdDetail.Subtotal( 0, 2, -1, '9!11','###,###,###.##');
                }    
            break;
            
            case 'pro_epim00031' :
                alert(txtReturnValue.text);
                
                OnSearch('Master') ;
            break;  
            
            case 'pro_epim00031_1' :
                alert(txtReturnValue.text);
                
                OnSearch('Master') ;
            break; 
                    
        }        
    }   
//==============================================================================
function OnChangeClose()
{
    if ( chkClose.value == "Y" ) 
    {
        btnClose.style.display   = "none" ;
        btnUnClose.style.display = "" ;
    }
    else
    {
        btnClose.style.display   = "" ;
        btnUnClose.style.display = "none" ;
    }
    
    OnSearch('Master') ;
} 
//=============================================================================

function OnSearch(pos)
{
    switch(pos)
    {
        case 'Master':
            data_epim00031.Call("SELECT");
        break;
    }
}
//==================================================================
function OnProcess(pos)
{
    switch (pos)
    {
        case 'Close' :
            if ( grdDetail.row > 0 )
            {
                if ( confirm ('Do you want to close Invoice : ' + grdDetail.GetGridData( grdDetail.row, G_CV_NO) ))
                {
                    txtMasterPK.text = grdDetail.GetGridData( grdDetail.row, G_CV_PK);
                    
                    pro_epim00031.Call();
                }    
            }
            else
            {
                alert('Pls select one Invoice.');
            }            
        break;
        
        case 'UnClose' :
            if ( grdDetail.row > 0 )
            {
                if ( confirm ('Do you want to unclose Invoice : ' + grdDetail.GetGridData( grdDetail.row, G_CV_NO) ))
                {            
                    txtMasterPK.text = grdDetail.GetGridData( grdDetail.row, G_CV_PK);
                    
                    pro_epim00031_1.Call();
                }    
            }
            else
            {
                alert('Pls select one Invoice.');
            }            
        break;        
    }    
}
//=============================================================================
function OnSelect()
{
    if ( chkClose.value == 'N' )
    {
        var code_data = new Array();	
        var rowNo = 0 ;
        var oGrid = grdDetail;
        
        code_data = new Array();
        
        if(grdDetail.row>0)   
            code_data[0] = grdDetail.GetGridData(grdDetail.row, 0) ;	
        
        window.returnValue = code_data; 
        this.close();
     }
     else
     {
        alert(' System allow to select the Opening Invoice only. ');
     }   
}  

//=============================================================================

</script>

<body>
    <!----------------------------------------------------------------------------------------->
    <gw:data id="data_epim00031" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,3,9" function="<%=l_user%>lg_sel_epim00031" > 
                <input bind="grdDetail">                    
                    <input bind="lstCompany" /> 
                    <input bind="txtSupplier" />  
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />               
                    <input bind="txtNo" />   
                    <input bind="radStatus" /> 
                    <input bind="chkClose" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_epim00031" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00031" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00031_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00031_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%">
                Company</td>
            <td>
                <gw:list id="lstCompany" styles="width:100%;" onchange="OnSearch('Master')"></gw:list>
            </td>
            <td style="width: 5%" align="right">
                Supplier</td>
            <td style="width: 25%">
                <gw:textbox id="txtSupplier" text="" styles='width:100%;' onenterkey="OnSearch('Master')" />
            </td>
            <td style="width: 5%" align="right">
                No</td>
            <td style="width: 25%" colspan="2">
                <gw:textbox id="txtNo" text="" styles='width:100%;' onenterkey="OnSearch('Master')" />
            </td>
            <td style="width: 8%; white-space: nowrap" align="left">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Master')" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Inv Date</td>
            <td style="width: 25%; white-space: nowrap">
                <gw:datebox id="dtFromDate" lang="1" styles='width:100%;' onchange="" />
                ~
                <gw:datebox id="dtToDate" lang="1" styles='width:100%;' onchange="" />
            </td>
            <td align="center" colspan="3">
                <gw:radio id="radStatus" value="1" styles="width:100%" onchange="OnSearch('Master')"> 
                    <span value="1">Saved </span> 
                    <span value="2">Confirmed</span> 
                    <span value="3">Approved</span> 
                    <span value="4">Cancel</span> 
                </gw:radio>
            </td>
            <td style="white-space: nowrap; width: 15%" align="right">
                Close
                <gw:checkbox id="chkClose" defaultvalue="Y|N" value="N" onchange="OnChangeClose()" />
            </td>
            <td style="white-space: nowrap; width: 10%" align="left">
                <gw:icon id="btnClose" img="2" text="Close" onclick="OnProcess('Close')" />
                <gw:icon id="btnUnClose" img="2" text="UnClose" onclick="OnProcess('UnClose')" />
            </td>
            <td style="width: 8%">
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdDetail' header='_PK|Cust ID|Cust Name|Inv Date|Inv No|Contract No|P/O No|L/C No|Tr CCY|Tr Amount|Disc (%)|Disc Amt'
                    format='0|0|0|4|0|0|0|0|0|0|0|0' aligns='0|0|0|1|0|0|0|0|1|3|3|3' check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1200|2200|1200|1500|1500|1500|1200|1200|1200|1200|1200'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtMasterPK" styles='display:none;width:100%' />
    <gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
    <!------------------------------------------------------------------------------------------>
</body>
</html>
