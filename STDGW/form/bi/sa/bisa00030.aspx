<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Stock Adjust Approve</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";

var G1_Chk          = 0,           
    G1_OS_PK        = 1,
    G1_Status       = 2,
    G1_Stock_Date   = 3,
    G1_SLIP_NO      = 4,
    G1_WH_ID        = 5,
    G1_WH_NM        = 6,
    G1_ADJUST_TYPE  = 7,
    G1_CHARGER      = 8,
    G1_REMARK       = 9,
    G1_APPROVE      = 10,
    G1_CANCEL       = 11;
    
var G2_OS_PK        = 0,
    G2_Status       = 1,
    G2_Stock_Date   = 2,
    G2_SLIP_NO      = 3,
    G2_WH_ID        = 4,
    G2_WH_NM        = 5,
    G1_ADJUST_TYPE  = 6,
    G2_CHARGER      = 7,
    G2_REMARK       = 9,
    G2_APPROVE      = 10,
    G2_CANCEL       = 11;
//==================================================================
         
function BodyInit()
{
    System.Translate(document); 
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;  
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtConfirmFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtConfirmFrom.value=ldate ;
    
    ldate=dtApproveFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtApproveFrom.value=ldate ;      
    
    //------------------------------------
    dso_wh_list_approve.Call('SELECT');                 
}
//==================================================================
function OnSearch(id)
{
    switch(id)
    {
        case 'grdConfirm':
            data_bisa00030.Call('SELECT');
        break;
        
        case 'grdApprove':
            data_bisa00030_1.Call('SELECT')
        break;
    }
}

//==================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
         case 'DetailConfirm':
            if ( grdConfirm.row > 0 )
            {
                var path = System.RootURL + '/form/bi/sa/bisa00031.aspx?type=APPROVE&slip_pk=' + grdConfirm.GetGridData( grdConfirm.row, G1_OS_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
                
                if ( object != null )                    
                {
                    OnSearch('grdConfirm');
                }
            } 
	        else
	        {
	            alert('Pls select Slip to view.');
	        }                     
         break ;
         
         case 'DetailApprove':
            if ( grdApprove.row > 0 )
            {
                var path = System.RootURL + '/form/bi/sa/bisa00031.aspx?type=CANCEL&slip_pk=' + grdApprove.GetGridData( grdApprove.row, G2_OS_PK);
                var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
	            
            	if ( object != null )                    
                {
                    data_bisa00030.Call('SELECT');
                }
	        }
	        else
	        {
	            alert('Pls select Slip to view.');
	        }       	        
         break;         
     }       
}

//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_bisa00030':
                lbConfirmRecord.text = grdConfirm.rows-1 + " record(s)"; 
                data_bisa00030_1.Call('SELECT');  
        break;    
        
        case 'data_bisa00030_1':             
                lbApproveRecord.text = grdApprove.rows-1 + " record(s)";            
        break; 
        
        case 'data_bisa00030_2': 
                lbApproveRecord.text = grdApprove.rows-1 + " record(s)";             
        break; 
        
        case 'dso_wh_list_approve':
            dso_wh_list_cancel.Call('SELECT');
        break;
        
        case 'dso_wh_list_cancel':
            data_bisa00030.Call('SELECT');
        break;
                
        case 'pro_bisa00030' :
            data_bisa00030.Call('SELECT');
        break;     

        case 'pro_bisa00030_1' :
            data_bisa00030.Call('SELECT');
        break;
                                           
    }
}
 
 
//==================================================================
function OnProcess(pos)
{
    switch (pos)
    {       
        case'Approve':
            var slip_pk = "";
            
            for(var i=1;i<grdConfirm.rows;i++)
            {
                var a = grdConfirm.GetGridData( i, G1_Chk   );
                var b = grdConfirm.GetGridData( i, G1_OS_PK );
                
                if ( a == "-1" )
                {
                   slip_pk = slip_pk + b + ",";
                }
            }
            
            txtSlipPK.text = slip_pk.substring( 0, slip_pk.length-1 );
            
            if ( txtSlipPK.text == "")
            {
                alert('You must select one Slip.');
            }
            else
            {
                pro_bisa00030.Call();
            }
        break; 
        
        case 'Cancel':
            if ( grdApprove.row > 0 )
            {
                if ( confirm ('Do you want to Cancel Slip : ' + grdApprove.GetGridData( grdApprove.row, G2_SLIP_NO) ))
                {
                    txtSlipPK.text = grdApprove.GetGridData( grdApprove.row, G2_OS_PK);
                    pro_bisa00030_1.Call();
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
function OnReport()
{ 
    if(grdApprove.row > 0)
    {
        var url =System.RootURL + '/reports/bi/sa/rpt_bisa00030.aspx?p_pk='+grdApprove.GetGridData( grdApprove.row, G2_OS_PK);
        window.open(url);    
    }
    else
    {
        alert("Pls select one Slip.")
    }
}  
 //==================================================================
         
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="dso_wh_list_approve" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bisa00030_2" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="lstApproveWH" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="dso_wh_list_cancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bisa00030_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="lstCancelWH" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_bisa00030" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_bisa00030"  >
                <input bind="grdConfirm" >
			        <input bind="dtConfirmFrom" />
			        <input bind="dtConfirmTo" />
			        <input bind="lstApproveWH" />
			        <input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input>
                <output bind="grdConfirm" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_bisa00030_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_bisa00030_1"  >
                <input bind="grdApprove" >
			        <input bind="dtApproveFrom" />
			        <input bind="dtApproveTo" />
			        <input bind="lstCancelWH" />			         
			        <input bind="txtEmpPK" />
					<input bind="chkUser2" />
                </input>
                <output bind="grdApprove" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bisa00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bisa00030" > 
                <input>
                    <input bind="txtSlipPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bisa00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bisa00030_1" > 
                <input>
                    <input bind="txtSlipPK" /> 
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
                        <td style="width: 10%" align="right">
                            Date</td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                            <gw:datebox id="dtConfirmFrom" lang="1" />
                            ~<gw:datebox id="dtConfirmTo" lang="1" />
                        </td>
                        <td style="width: 10%" align="right">
                            W/H
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstApproveWH" styles="width:100%;" />
                        </td>
                        <td style="width: 1%">
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y">User</gw:checkbox>
                        </td>
                        <td style="width: 27%; text-align: center">
                            <gw:label id="lbConfirmRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdConfirm')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail" img="2" text="View Detail" onclick="OnPopUp('DetailConfirm')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdConfirm' header='Chk|_OS_PK|Status|Date|Slip No|W/H ID|W/H Name|Adjust Type|Charger|Remark|Approve|Cancel'
                                format='3|0|0|4|0|0|0|0|0|0|0|0' aligns='0|0|1|1|1|0|0|0|0|0|0' check='|||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='500|0|1200|1200|1000|1500|3000|2500|2200|1200|2200|1500' sorting='T' styles='width:100%; height:100%' />
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
                        <td style="width: 9%; white-space: nowrap" align="right">
                            Date</td>
                        <td style="width: 20%">
                            <gw:datebox id="dtApproveFrom" lang="1" />
                            ~<gw:datebox id="dtApproveTo" lang="1" />
                        </td>
                        <td style="width: 10%" align="right">
                            W/H
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstCancelWH" styles="width:100%;" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                           
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                           
                        </td>
                        <td style="width: 1%">
                            <gw:checkbox id="chkUser2" styles="color:blue" defaultvalue="Y|N" value="Y">User</gw:checkbox>
                        </td>
                        <td style="width: 16%; white-space: nowrap" align="center">
                            <gw:label id="lbApproveRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdApprove')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnReport" img="excel" styles='width:100%;display:none' alt="Report" text="Report" onclick="OnReport()" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnViewDetail1" img="2" text="View Detail" onclick="OnPopUp('DetailApprove')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="13">
                            <gw:grid id='grdApprove' header='_OS_PK|Status|Date|Slip No|W/H ID|W/H Name|Adjust Type|Charger|Remark|Approve|Cancel'
                                format='0|0|4|0|0|0|0|0|0|0|0' aligns='0|1|1|1|0|0|0|0|0|0|0' check='||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|1200|1200|1000|1500|3000|2500|2500|1200|2200|1500' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtSlipPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
</body>
</html>
