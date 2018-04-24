<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("imex")%>
<head id="Head1" runat="server">
    <title>Ex - Declaration Approve</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_Chk          = 0,           
    G1_PO_PK        = 1,
    G1_Status       = 2,
    G1_PO_Date      = 3,
    G1_PO_No        = 4,
    G1_PO_Amt       = 5,
    G1_VAT_Amt      = 6,
    G1_Total_Amt    = 7,
    G1_CCY          = 8,
    G1_SUPPLIER_PK  = 9,
    G1_Supplier_ID  = 10,
    G1_Supplier_Name= 11,
    G1_Sale_PO_No   = 12,
    G1_Remark       = 13;
    
var G2_PO_PK        = 0,
    G2_Status       = 1,
    G2_PO_Date      = 2,
    G2_PO_No        = 3,
    G2_PO_Amt       = 4,
    G2_VAT_Amt      = 5,
    G2_Total_Amt    = 6,
    G2_CCY          = 7,
    G2_SUPPLIER_PK  = 8,
    G2_Supplier_ID  = 9,
    G2_Supplier_Name= 10,
    G2_Sale_PO_No   = 11,
    G2_Remark       = 12;
//==================================================================
         
function BodyInit()
{          
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom1.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom1.value=ldate ;
    dtFrom2.value=ldate ;
    //-----------------
    FormatGrid();
    //-----------------------------------
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
    //------------------------------------
    OnSearch('grdConfirm');    
}
//==================================================================
  
function FormatGrid()
{
    var ctrl = grdConfirm.GetGridControl();   
     
    ctrl.ColFormat(G1_PO_Amt)    = "###,###,###.##" ;
    ctrl.ColFormat(G1_VAT_Amt)   = "###,###,###.##" ;
    ctrl.ColFormat(G1_Total_Amt) = "###,###,###.##" ;
    
    ctrl.Cell( 7, 0, G1_Status, 0, G1_Status) = 0x3300cc;
    //---------------------
    var ctrl = grdApprove.GetGridControl();   
     
    ctrl.ColFormat(G2_PO_Amt)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_VAT_Amt)   = "###,###,###.##" ;
    ctrl.ColFormat(G2_Total_Amt) = "###,###,###.##" ;   
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdConfirm':
            data_epex00080.Call('SELECT');
        break;
        
        case 'grdApprove':
            data_epex00080_1.Call('SELECT')
        break;
    }
}

//==================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
         case 'POConfirm':
            if ( grdConfirm.row > 0 )
            {
                var path = System.RootURL + '/form/ep/ex/epex00081.aspx?po_pk=' + grdConfirm.GetGridData( grdConfirm.row, G1_PO_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
                if ( object != null )                    
                {
                    OnSearch('grdConfirm');
                }
            }  
	        else
	        {
	            alert('Pls select P/O.');
	        }                   
         break ;
         
         case 'POApprove':
            if ( grdApprove.row > 0 )
            {
                var path = System.RootURL + '/form/ep/ex/epex00082.aspx?po_pk=' + grdApprove.GetGridData( grdApprove.row, G2_PO_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
                
                if ( object != null )                    
                {
                    OnSearch('grdConfirm');
                }
	        }
	        else
	        {
	            alert('Pls select P/O.');
	        }         	        
         break;      
         
        case 'Importer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtImporterPK.text   = object[0];
	            txtImporterID.text   = object[1];
                txtImporterName.text = object[2];

                txtImpDesc.SetDataText(object[37]);          
	         }
        break;                            
     }       
}

//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_epex00080':
            lbRecord.text = grdConfirm.rows-1 + " record(s)";
            
            if ( grdConfirm.rows > 1 )
            {
                grdConfirm.SetCellBold( 1, G1_PO_No, grdConfirm.rows - 1, G1_PO_No, true);

                grdConfirm.SetCellBgColor( 1, 11, grdConfirm.rows - 1, 11, 0xCCFFFF );      // total amount                                 
            }             
            OnSearch('grdApprove');         
        break;    
        
        case 'data_epex00080_1':       
            lbRecord1.text = grdApprove.rows-1 + " record(s)";  
            
            if ( grdApprove.rows > 1 )
            {
                grdApprove.SetCellBold( 1, G2_PO_No, grdApprove.rows - 1, G2_PO_No, true);

                grdApprove.SetCellBgColor( 1, 11, grdApprove.rows - 1, 11, 0xCCFFFF );  // total amount                                       
            }                     
        break;  
        //----close
        case 'pro_epex00080' :
            OnSearch('grdApprove');
        break;  
        //----unclose
        case 'pro_epex00080_1' :
            OnSearch('grdApprove');
        break; 
        //--------        
        case 'imex_epex00080' :
            OnSearch('grdConfirm');
        break;   
                
        case 'pro_epex00080_3' :
            alert(txtReturnValue.text);
            OnSearch('grdConfirm');   
        break;
        
        case'pro_epex00080_4':
            alert(txtReturnValue.text);
            OnSearch('grdConfirm');
        break;
    }
}
 
//==================================================================

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
}

//==================================================================
var flag="";
function OnProcess(pos)
{
    switch (pos)
    {
        case 'Close' :
            if ( grdApprove.row > 0 )
            {
                if ( confirm ('Do you want to close P/O  : ' + grdApprove.GetGridData( grdApprove.row, 5) ))
                {
                    txtPOPK.text = grdApprove.GetGridData( grdApprove.row, G2_PO_PK);
                    
                    pro_epex00080.Call();
                }    
            }
            else
            {
                alert('Pls select one Order Plan.');
            }            
        break;
        
        case 'UnClose' :
            if ( grdApprove.row > 0 )
            {
                if ( confirm ('Do you want to unclose P/O  : ' + grdApprove.GetGridData( grdApprove.row, 5) ))
                {            
                    txtPOPK.text = grdApprove.GetGridData( grdApprove.row, G2_PO_PK);                    
                    pro_epex00080_1.Call();
                }    
            }
            else
            {
                alert('Pls select one Order Plan.');
            }            
        break;
        
        case'Approve':
            var po_pk = "";
            
            for(var i=1; i<grdConfirm.rows; i++)
            {
                var a = grdConfirm.GetGridData( i, 0);
                var b = grdConfirm.GetGridData( i, 1);
                
                if ( a == "-1" )
                {
                   po_pk= po_pk + b +",";
                }
            }
            
            txtArrayPOPK.text = po_pk.substring( 0, po_pk.length-1);
            
            if ( txtArrayPOPK.text == "" )
            {
                    alert('You must select one P/O.');
            }
            else
            {
                if ( confirm ('Do you want to approve this P/O ?'))
                {
                    imex_epex00080.Call();
                }
            }
        break; 
        
        case 'Cancel':
            if ( grdApprove.row > 0 )
            {
                if ( confirm ('Do you want to Cancel P/O : ' + grdApprove.GetGridData( grdApprove.row, 5) ))
                {
                    txtPOPK.text = grdApprove.GetGridData( grdApprove.row, G2_PO_PK);
                    
                    pro_epex00080_4.Call();
                }    
            }
            else
            {
                alert('Pls select one P/O.');
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
    <gw:data id="data_epex00080" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="imex.sp_sel_epex00080"  >
                <input bind="grdConfirm" >
                    <input bind="dtFrom1" />
                    <input bind="dtTo1" />                
			        <input bind="txtSearchNo1" />
                </input>
                <output bind="grdConfirm" />
            </dso>
        </xml>
    </gw:data>
    <!-----------------------------<input bind="chkClose" />---------------------------------------->
    <gw:data id="data_epex00080_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="imex.sp_sel_epex00080_1"  >
                <input bind="grdOrdPlan" >
                    <input bind="dtFrom2" />
                    <input bind="dtTo2" />                  
			        <input bind="txtSearchNo2" />	
			        <input bind="chkClose" />		        
                </input>
                <output bind="grdApprove" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epex00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_pro_epex00080_2" > 
                <input>
                    <input bind="txtPOPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epex00080_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_pro_epex00080_3" > 
                <input>
                    <input bind="txtPOPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------make plan------------------------------->
    <gw:data id="imex_epex00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_pro_epex00080" > 
                <input>
                    <input bind="txtArrayPOPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epex00080_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.SP_PRO_EPEX00080_1" > 
                <input>
                    <input bind="txtPOPK" /> 
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
                            P/O Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom1" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo1" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Search No</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo1" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdConfirm')" />
                        </td>
                        <td style="width: 27%; text-align: center">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdConfirm')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail" img="2" text="View Detail" onclick="OnPopUp('POConfirm')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="10">
                            <gw:grid id='grdConfirm' header='Chk|_PK|Status|Import ID|Import Name|Decl Date|Seq|Decl No|Contract No|Invoice No|CCY|Tr Amount|Book CCY|Ex Rate|Book Amount'
                                format='3|0|0|0|0|4|0|0|0|0|0|1|0|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||' editcol='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%" id="tab_bottom">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 1%">
                            <img id="imgArrow" status="expand" id="imgUp" src="../../../system/images/up.gif"
                                style="cursor: hand" onclick="OnToggle()" /></td>
                        <td align="right" style="width: 9%; white-space: nowrap">
                            P/O Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom2" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo2" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Search No</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo2" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdConfirm')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            Close
                            <gw:checkbox id="chkClose" defaultvalue="Y|N" value="N" onchange="OnChangeClose(),OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            <gw:icon id="btnClose" img="2" text="Close" onclick="OnProcess('Close')" />
                            <gw:icon id="btnUnClose" img="2" text="UnClose" onclick="OnProcess('UnClose')" />
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 16%; white-space: nowrap" align="center">
                            <gw:label id="lbRecord1" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail1" img="2" text="View Detail" onclick="OnPopUp('POApprove')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="14">
                            <gw:grid id='grdApprove' header='_PK|Status|Import ID|Import Name|Decl Date|Seq|Decl No|Contract No|Invoice No|CCY|Tr Amount|Book CCY|Ex Rate|Book Amount'
                                format='0|0|0|0|4|0|0|0|0|0|1|0|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtPOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtArrayPOPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
