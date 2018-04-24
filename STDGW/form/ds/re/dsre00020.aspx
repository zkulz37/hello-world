<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>S/O Revision Approve (Prod Manager)</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
  
var G1_CHK              = 0,           
    G1_PK               = 1,
    G1_SLIP_NO          = 2,
    G1_REV_DATE         = 3,
    G1_STATUS           = 4,
    G1_TSA_SALEORDER_PK = 5,
    G1_REF_NO           = 6,
    G1_DESCRIPTION      = 7,
    G1_RESPONSE         = 8,
    G1_CHARGER_PK       = 9,   
    G1_FULL_NAME        = 10;
    
var G2_PK               = 0,
    G2_SLIP_NO          = 1,
    G2_REV_DATE         = 2,
    G2_STATUS           = 3,
    G2_TSA_SALEORDER_PK = 4,
    G2_REF_NO           = 5,
    G2_DESCRIPTION      = 6,
    G2_CHARGER_PK       = 7, 
    G2_FULL_NAME        = 8;    
//==================================================================
         
function BodyInit()
{       
    System.Translate(document);
    //---------------------------------- 
    txtReturnChargerPK.text = "<%=Session("EMPLOYEE_PK")%>";
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtApproveFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtApproveFrom.value=ldate ; 
    
    ldate=dtConfirmFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtConfirmFrom.value=ldate ;      
    //---------------------------------- 
     FormatGrid();
    //-----------------------------------
}
//==================================================================
  
function FormatGrid()
{
    var ctrl = grdApprove.GetGridControl();       
    
    ctrl.Cell( 7, 0, G1_STATUS, 0, G1_STATUS) = 0x3300cc;
    ctrl = grdCancel.GetGridControl();
    ctrl.Cell( 7, 0, G2_STATUS, 0, G2_STATUS) = 0x3300cc;
    //--------------------- 
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdApprove':
            data_dsre00020.Call('SELECT');
        break;
        
        case 'grdCancel':
            data_dsre00020_1.Call('SELECT')
        break;
    }
}

//==================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
         case 'POConfirm':
            if ( grdApprove.row > 0 )
            {
                var path = System.RootURL + '/form/ds/re/dsre00021.aspx?trans_pk=' + grdApprove.GetGridData( grdApprove.row, G1_PK);
                var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes', this);
                if ( object != null )                    
                {                
			OnSearch('grdApprove');
		}        
            }    
         break ;
         
         case 'POApprove':
            if ( grdCancel.row > 0 )
            {
                    var path = System.RootURL + '/form/ds/re/dsre00022.aspx?trans_pk=' + grdCancel.GetGridData( grdCancel.row, G2_PK);
                    var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes', this);
                if ( object != null )                    
                {                
			OnSearch('grdApprove');
		}
	    }      	        
         break;                         
     }       
}
//==================================================================
function OnPrint()
{    
    txtDateFrom.text=dtFrom2.value;
    txtDateTo.text=dtTo2.value;
    
    var url =System.RootURL + "/reports/ds/re/rpt_dsre00020.aspx?dtFrom="+txtDateFrom.text+"&dtTo="+txtDateTo.text ;
	System.OpenTargetPage(url); 
}
//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsre00020':
            lbConfirmRecord.text = grdApprove.rows-1 + " record(s)";
            if ( grdApprove.rows > 1 )
            {
                grdApprove.SetCellBold( 1, G1_REF_NO, grdApprove.rows - 1, G1_REF_NO, true);
                grdApprove.GetGridControl().Cell( 7, 0, G1_RESPONSE, grdApprove.rows - 1, G1_RESPONSE) = 0x3300cc;
            }
            OnSearch('grdCancel');
        break;    
        
        case 'data_dsre00020_1':                    
            lbApproveRecord.text = grdCancel.rows-1 + " record(s)";
            if ( grdCancel.rows > 1 )
            {
                grdCancel.SetCellBold( 1, G2_REF_NO, grdCancel.rows - 1, G2_REF_NO, true);
            }          
        break;  
                 
        case 'pro_dsre00020' :
            alert(txtReturnValue.text);
            data_dsre00020.Call('SELECT')   
        break;
        
        case'pro_dsre00020_1':
            alert(txtReturnValue.text);
            data_dsre00020.Call('SELECT');
        break;
        
         case'pro_dsre00030_1':
            alert(txtReturnValue.text);
            data_dsre00020_3.Call('SELECT');
        break;
        
        case'pro_dsre00020_4':
            alert(txtReturnValue.text);
            OnSearch('grdCancel') ;
        break;
        
        case'pro_dsre00020_5':
            alert(txtReturnValue.text);
            OnSearch('grdCancel') ;
        break;
    }
}
 
//==================================================================

function OnProcess(pos)
{
    switch (pos)
    {        
        case'Approve':
            var income_pk = "";
            var t_link = "";
            
            for( var i=1; i<grdApprove.rows; i++)
            {
                var a = grdApprove.GetGridData(i,0);
                var b = grdApprove.GetGridData(i,1);
                
                if (a == "-1" )
                {
                   income_pk = income_pk + t_link + b ;
                   t_link = ",";
                }
            }
            
            txtInComePK.text = income_pk;
            
            if(txtInComePK.text=="")
            {
                alert('You must select one slip to approve.');
            }
            else
            {
                 if ( confirm ('Do you want to Approve ?') )
                 {
                        pro_dsre00020.Call();
                 }       
            }
        break; 
        
        case 'Cancel':
            if ( grdCancel.row > 0 )
            {
                if ( confirm ('Do you want to Cancel ?'))
                {
                    txtInComePK.text = grdCancel.GetGridData( grdCancel.row, G2_PK);
                    
                    pro_dsre00020_1.Call();
                }    
            }
            else
            {
                alert('Pls select one slip to cancel.');
            }     
        break;  
        case 'Return':
             var income_pk = "";
            var t_link = "";
            
            for( var i=1; i<grdApprove.rows; i++)
            {
                var a = grdApprove.GetGridData(i,0);
                var b = grdApprove.GetGridData(i,1);
                
                if (a == "-1" )
                {
                   income_pk = income_pk + t_link + b ;
                   t_link = ",";
                }
            }
            
            txtInComePK.text = income_pk;
            
            if(txtInComePK.text=="")
            {
                alert('You must select one slip to Return.');
            }
            else
            {
                 if ( confirm ('Do you want to Return ?') )
                 {
                        var path = System.RootURL + "/form/ds/re/dsre00023.aspx";
	                    System.OpenModal( path ,400 , 200 ,  'resizable:yes;status:yes',this);   
	                    pro_dsre00020_3.Call();
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
function OnReport()
{
      var url =System.RootURL + '/reports/ds/re/rpt_dsre00020.aspx?p_master_pk='+ grdApprove.GetGridData(grdApprove.row, G1_PK);
      System.OpenTargetPage(url);      
}    
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsre00020" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_dsre00020"  >
                <input bind="grdApprove" >
                    <input bind="dtConfirmFrom" />
                    <input bind="dtConfirmTo" />
			        <input bind="txtConfirmNo" />
                </input>
                <output bind="grdApprove" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsre00020_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsre00020_1"  >
                <input bind="grdCancel" >
                    <input bind="dtApproveFrom" />
                    <input bind="dtApproveTo" />                
			        <input bind="txtApproveNo" />
			        <input bind="chkClose" />
                </input>
                <output bind="grdCancel" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="pro_dsre00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsre00020" > 
                <input>
                    <input bind="txtInComePK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsre00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsre00020_1" > 
                <input>
                    <input bind="txtInComePK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------return------------------------------->
    <gw:data id="pro_dsre00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsre00020_3" > 
                <input>
                    <input bind="txtInComePK" />
                    <input bind="txtReturnChargerPK" />
                    <input bind="txtResponse" />
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
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtConfirmFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtConfirmTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Search No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtConfirmNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 37%; text-align: center">
                            <gw:label id="lbConfirmRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnReturn" img="2" text="Return" onclick="OnProcess('Return')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail" img="2" text="View Detail" onclick="OnPopUp('POConfirm')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="10">
                            <gw:grid id='grdApprove' header='Chk|_pk|Slip No|Date|Status|_tsa_saleorder_pk|Ref No|Description|Response|_charger_pk|Full Name|Sale Approved|Prod Approved'
                                format='3|0|0|4|0|0|0|0|0|0|0|0|0' aligns='0|0|0|1|1|0|0|0|0|0|0|1|1' check='||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0' widths='800|0|1500|1200|1800|0|1500|2500|1500|0|1500|1500|1500'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%" id="tab_bottom">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%">
                            <img id="imgArrow" status="expand" id="imgUp" src="../../../system/images/up.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtApproveFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtApproveTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Search No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtApproveNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            Close
                            <gw:checkbox id="chkClose" defaultvalue="Y|N" value="N" onchange="OnSearch('grdApprove')" />
                        </td>                        
                        <td style="width: 21%; white-space: nowrap" align="center">
                            <gw:label id="lbApproveRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdCancel')" />
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
                        <td colspan="12">
                            <gw:grid id='grdCancel' header='_pk|Slip No|Date|Status|_tsa_saleorder_pk|Ref No|Description|_charger_pk|Full Name|Sale Approved|Prod Approved'
                                format='0|0|4|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|0|0|0|1|1' check='||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0' widths='0|1500|1200|1800|0|1500|2500|0|1500|1500|1500'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtInComePK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtResponse" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnChargerPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
