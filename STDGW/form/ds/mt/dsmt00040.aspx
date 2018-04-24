<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>PROMO RULE APPROVE</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_CHK              = 0,           
    G1_MASTER_PK        = 1,
    G1_STATUS           = 2,
    G1_PRO_FR_DATE      = 3,
    G1_PRO_TO_DATE      = 4,	
	G1_PRO_NAME         = 5,
	G1_FULL_NAME        = 6,
    G1_DIV_NAME         = 7,
	G1_PARTNER_NAME     = 8,
    G1_PA_GROUP_NAME    = 9,
    G1_DESCRIPTION      = 10;
    G1_APPROVED_BY      = 11,
    G1_CANCEL_BY        = 12;
    
var G2_MASTER_PK        = 0,
    G2_STATUS           = 1,
    G2_PRO_FR_DATE      = 2,
    G2_PRO_TO_DATE      = 3,	
	G2_PRO_NAME         = 4,
	G2_FULL_NAME        = 5,
    G2_DIV_NAME         = 6,
	G2_PARTNER_NAME     = 7,
    G2_PA_GROUP_NAME    = 8,
    G2_DESCRIPTION      = 9,
    G2_APPROVED_BY      = 10,      
    G2_CANCEL_BY        = 11;
    
//==================================================================
         
function BodyInit()
{       
    System.Translate(document);
    txtCancelChargerPK.text="<%=Session("EMPLOYEE_PK")%>";
    //---------------------------------- 
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtApproveFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtApproveFrom.value=ldate ; 
    
    ldate=dtConfirmFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtConfirmFrom.value=ldate ;   
    //-----------------------------------------   
    FormatGrid();
     
    //------------------------------------
    OnSearch('grdConfirm');    
}
//==================================================================
  
function FormatGrid()
{
	  
     
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdConfirm':
            data_dsmt00040.Call('SELECT');
        break;
        
        case 'grdApprove':
            data_dsmt00040_1.Call('SELECT')
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
                var path = System.RootURL + '/form/fp/ma/fpma00261.aspx?type=APPROVE&po_pk=' + grdConfirm.GetGridData( grdConfirm.row, G1_MASTER_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
                if ( object != null )                    
                {
                    OnSearch('grdConfirm');
                }
            }  
	        else
	        {
	            alert('Pls select Slip No.');
	        }                   
         break ;
         
         case 'POApprove':
            if ( grdApprove.row > 0 )
            {
                var path = System.RootURL + '/form/fp/ma/fpma00261.aspx?type=CANCEL&po_pk=' + grdApprove.GetGridData( grdApprove.row, G2_MASTER_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
                
                if ( object != null )                    
                {
                    OnSearch('grdConfirm');
                }
	        }
	        else
	        {
	            alert('Pls select Slip No.');
	        }         	        
         break;                        
     }       
}

//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsmt00040':
            lbRecord.text = grdConfirm.rows-1 + " record(s)";
            if ( grdConfirm.rows > 1 )
            {
                grdConfirm.SetCellBold( 1, G1_PRO_NAME, grdConfirm.rows - 1, G1_PRO_NAME, true);                                   
            }
            OnSearch('grdApprove');         
        break;    
        
        case 'data_dsmt00040_1':       
            lbRecord1.text = grdApprove.rows-1 + " record(s)";  
            if ( grdApprove.rows > 1 )
            {
                grdApprove.SetCellBold( 1, G2_PRO_NAME, grdApprove.rows - 1, G2_PRO_NAME, true);
                //grdApprove.SetCellBgColor( 1, G2, grdApprove.rows - 1, G2_Total_Amt, 0xCCFFFF );                                      
            }                     
        break;                 
        
        case 'pro_dsmt00040_3' :
            alert(txtReturnValue.text);
            OnSearch('grdConfirm');   
        break;
        case'pro_dsmt00040_4':
            alert(txtReturnValue.text);
            OnSearch('grdConfirm');
        break;
    }
}
  
//==================================================================
var flag="";

function OnProcess(pos)
{
    switch (pos)
    {
        
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
                alert('You must select one Slip.');
            }
            else
            {
                pro_dsmt00040_3.Call();
            }
        break; 
        
        case 'Cancel':
            if ( grdApprove.row > 0 )
            {
                if ( confirm ('Do you want to Cancel : ' + grdApprove.GetGridData( grdApprove.row, G2_PRO_NAME) ))
                {
                    txtArrayPOPK.text = grdApprove.GetGridData( grdApprove.row, G2_MASTER_PK);
                    
                    pro_dsmt00040_4.Call();
                }    
            }
            else
            {
                alert('Pls select one Slip.');
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
    <gw:data id="data_dsmt00040" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_dsmt00040"  >
                <input bind="grdConfirm" >
                    <input bind="dtConfirmFrom" />
                    <input bind="dtConfirmTo" />                
			        <input bind="txtSearchNo1" />
                </input>
                <output bind="grdConfirm" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsmt00040_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsmt00040_1"  >
                <input bind="grdOrdPlan" >
                    <input bind="dtApproveFrom" />
                    <input bind="dtApproveTo" />                  
			        <input bind="txtSearchNo2" />			        
                </input>
                <output bind="grdApprove" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------Approve------------------------------>
    <gw:data id="pro_dsmt00040_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsmt00040" > 
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
    <gw:data id="pro_dsmt00040_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsmt00040_1" > 
                <input>
                    <input bind="txtArrayPOPK" /> 
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
                            Slip Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtConfirmFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtConfirmTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Search No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo1" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdConfirm')" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                        </td>
                        <td style="width: 10%; white-space: nowrap">
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
                            <gw:grid id='grdConfirm' header='Chk|_pk|Status|Pro Fr Date|Pro To Date|Pro Name|Full Name|Div Name|Partner Name|Pa Group Name|Description|Approved By|Cancel By'
                                format='3|0|0|4|4|0|0|0|0|0|0|0|0' aligns='0|0|1|1|1|0|0|0|0|0|0|0|0' check='||||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='500|0|1200|1200|1200|1300|2000|1300|1400|1300|1000|1000|1000'
                                sorting='T' autosize='true' styles='width:100%; height:100%' />
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
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td align="right" style="width: 9%; white-space: nowrap">
                            Slip Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtApproveFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtApproveTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Search No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo2" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdConfirm')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
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
                            <gw:imgbtn img="excel" alt="Print Report" styles='width:100%;display:none' id="btnPrint"
                                onclick="OnPrint()" />
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
                            <gw:grid id='grdApprove' header='_pk|Status|Pro Fr Date|Pro To Date|Pro Name|Full Name|Div Name|Partner Name|Pa Group Name|Description|Approved By|Cancel By'
                                format='0|0|4|4|0|0|0|0|0|0|0|0' aligns='0|1|1|1|0|0|0|0|0|0|0|0' check='|||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1' widths='0|1200|1200|1200|1300|2000|1300|1400|1300|1000|1000|1000'
                                sorting='T' autosize='true' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtArrayPOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtCancelChargerPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
