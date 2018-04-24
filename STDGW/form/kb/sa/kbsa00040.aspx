<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Stock Incoming Approve</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_SELECT       = 0,
    G1_MASTER_PK    = 1,          
    G1_STATUS       = 2;
  
    
var G2_MASTER_PK    = 1,           
    G2_STATUS       = 2;
   


//==================================================================
         
function BodyInit()
{       
    System.Translate(document); 
    //---------------------------------- 
     
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtApproveFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtApproveFrom.value=ldate ; 
    
    ldate=dtConfirmFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtConfirmFrom.value=ldate ;     
    FormatGrid();
}
//==================================================================
  
function FormatGrid()
{
    var ctrl = grdApprove.GetGridControl();       
    
    ctrl.Cell( 7, 0, G1_STATUS, 0, G1_STATUS) = 0x3300cc;
    //--------------------- 
}

//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdApprove':
            data_kbsa00040.Call('SELECT');
        break;
        
        case 'grdCancel':
            data_kbsa00040_1.Call('SELECT');
        break;
    }
}

//==================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
         case 'Approve':
            if ( grdApprove.row > 0 )
            {
                var path = System.RootURL + '/form/kb/sa/kbsa00041.aspx?type=APPROVE&master_pk=' + grdApprove.GetGridData( grdApprove.row, G1_MASTER_PK);
                var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes');
                 
                if ( object != null )                    
                {
                    OnSearch('grdApprove');
                }
            }    
         break ;
         
         case 'Cancel':
            if ( grdCancel.row > 0 )
            {
                    var path = System.RootURL + '/form/kb/sa/kbsa00041.aspx?type=CANCEL&master_pk=' + grdCancel.GetGridData( grdCancel.row, G2_MASTER_PK);
                    var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes', this);
                     
                    if ( object != null )                    
                    {
                        OnSearch('grdCancel');
                    }
	        }      	        
         break;                         
     }       
}
//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_kbsa00040':
            if ( grdApprove.rows > 1 )
            {
               lbConfirmRecord.text = grdApprove.rows-1 + " record(s)";
               
            }
            OnSearch('grdCancel');
        break;    
        
        case 'data_kbsa00040_1':                    
            if ( grdCancel.rows > 1 )
            {
                lbApproveRecord.text = grdCancel.rows-1 + " record(s)";
            }          
        break;  
                 
        case 'pro_kbsa00040_1' :
            alert(txtReturnValue.text);
            data_kbsa00040.Call('SELECT')   
        break;
        
        case'pro_kbsa00040_2':
            alert(txtReturnValue.text);
            data_kbsa00040_1.Call('SELECT');
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
                var a = grdApprove.GetGridData(i,G1_SELECT);
                var b = grdApprove.GetGridData(i,G1_MASTER_PK);
                
                if (a == "-1" )
                {
                   income_pk = income_pk + t_link + b ;
                   t_link = ",";
                }
            }
            
            txtMasterPK.text = income_pk;
            
            if(txtMasterPK.text=="")
            {
                alert('You must select one slip to approve.');
            }
            else
            {
                 if ( confirm ('Do you want to Approve ?') )
                 {
                        pro_kbsa00040_1.Call();
                 }       
            }
        break; 
        
        case 'Cancel':
            if ( grdCancel.row > 0 )
            {
                if ( confirm ('Do you want to Cancel this Slip'))
                {
                    txtMasterPK.text = grdCancel.GetGridData( grdCancel.row, G2_MASTER_PK);
                    
                    pro_kbsa00040_2.Call();
                }    
            }
            else
            {
                alert('Pls select one slip to cancel.');
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
    <gw:data id="data_kbsa00040" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_kbsa00040"  >
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
    <gw:data id="data_kbsa00040_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_kbsa00040_1"  >
                <input bind="grdCancel" >
                    <input bind="dtApproveFrom" />
                    <input bind="dtApproveTo" />      
					<input bind="txtApproveNo" />
                </input>
                <output bind="grdCancel" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------make plan------------------------------->
    <gw:data id="pro_kbsa00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbsa00040" > 
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
    <gw:data id="pro_kbsa00040_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbsa00040_1" > 
                <input>
                    <input bind="txtMasterPK" />
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
                        <td style="width: 20%">
                            <gw:textbox id="txtConfirmNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 20%; text-align: center; white-space: nowrap">
                            <gw:label id="lbConfirmRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail" img="2" text="View Detail" onclick="OnPopUp('Approve')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="11">
                            <gw:grid id='grdApprove'
                                header='Check|_PK|Status|Deli Type|Variety|Deli Date|Slip No|Ref No|Partner Name|Amount|CCY|Charger|Remark'
                                format='3|0|0|0|0|4|0|0|0|0|0|0|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||'
                                editcol='1|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1000|0|800|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
                                sorting='T'
                                autosize='T' 
                                styles='width:100%; height:100%'
                              />
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
                        <td style="width: 20%">
                            <gw:textbox id="txtApproveNo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
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
                            <gw:icon id="btnViewDetail1" img="2" text="View Detail" onclick="OnPopUp('Cancel')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="13">
                               <gw:grid id='grdCancel'
                                header='Check|_PK|Status|Deli Type|Variety|Deli Date|Slip No|Ref No|Partner Name|Amount|CCY|Charger|Remark'
                                format='3|0|0|0|0|4|0|0|0|0|0|0|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||'
                                editcol='1|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1000|0|800|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
                                sorting='T'
                                autosize='T' 
                                styles='width:100%; height:100%'
                              />   
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
</body>
</html>
