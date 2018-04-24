<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Test No Registration</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_id	= "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    
var G2_PK           = 0,
    G2_tco_item_pk  = 1,
    G2_Test_No      = 2,
    G2_Enter_Date   = 3,
    G2_Valid        = 4,
    G2_Change_Date  = 5;
//===============================================================
function BodyInit()
{
    dso_shbo00080.StatusInsert();
    SetEnableControl();
    BindingDataList();	
    txtIssueNo.text="**New Issue No**"; 
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
    data_shbo00080_main_list.Call('SELECT');
    
}
//===============================================================

var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
 
//===============================================================
function SetEnableControl()
{  
                txtIssueNo.SetReadOnly(true);
                txtLicenseNo.SetReadOnly(true);
                txtLotNo.SetReadOnly(true);
                lstMachineNo.SetEnable(false);       
                //txtEstQty.SetEnable(false);
                txtProductCode.SetReadOnly(true);   
                txtProductName.SetReadOnly(true);
                txtCustomerCode.SetReadOnly(true);
                txtCustomerName.SetReadOnly(true);
                txtSizeCode.SetReadOnly(true);
                txtSizeName.SetReadOnly(true);
                txtColorCodeCap.SetReadOnly(true);
                txtColorNameCap.SetReadOnly(true);
                txtColorCodeBody.SetReadOnly(true);
                txtColorNameBody.SetReadOnly(true);
                txtCapPinNo.SetReadOnly(true);
                txtBodyPinNo.SetReadOnly(true);
                dtIssueDt.SetEnable(false);
                txtIssueID.SetReadOnly(true);
                txtIssueName.SetReadOnly(true);
}
//==============================================================
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>||Select All"; 
        lstMachineNoM.SetDataText(data); 
        lstMachineNoM.value = '';  
        lstMachineNo.SetDataText(data);  
    var trl ;     
      trl = grdSearch.GetGridControl();      	
      trl.ColFormat(4 )     = "###,###,###,###,##0";
}
//===============================================================

function OnSearch()
{  
   data_shbo00080_main_list.Call('SELECT');
}
//===============================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case'1':
                var fpath = System.RootURL + "/form/sh/bo/shbo00081.aspx?";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                    txtLotNo.text = object[0];
                    pro_shbo00080_3.Call();
                }
        break;
        case'2':
            var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                txtIssueName.text=object[5];
                txtIssueID.text=object[3];
                txtChargerPK.text=object[0]
            }
        break;
    }
    
    
}
//===============================================================
function OnDelete()
{
   if(confirm('Do you want to delete ?'))
            {
                dso_shbo00080.StatusDelete();
                Delete="T";
                flag="update";
                dso_shbo00080.Call();
                
            }
}
//===============================================================
function OnNew()
{
    dso_shbo00080.StatusInsert();
    txtIssueNo.text="**New Issue No**";
    txtIssueName.text = user_name;
	txtIssueID.text = user_id;
	txtChargerPK.text = user_pk;	
}

//===============================================================
var flag="";
function OnSave()
{
    if(txtLotNo.text=="")
    {
        alert("Please Select LotNo");
    }
    else
    {
        dso_shbo00080.Call();
        flag="update";
    }
    
}
//===============================================================
function OnClickGridMaster()
{
    if (grdSearch.row > 0)
    {   
        txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
        dso_shbo00080.Call('SELECT');
    }
}
//===============================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'dso_shbo00080':
            if(flag=="update")
            {
                data_shbo00080_main_list.Call('SELECT');
                flag="";
            }  
        break;
        case'data_shbo00080_main_list':
            if(Delete=="T")
            {
                dso_shbo00080.StatusInsert();
                txtIssueNo.text="**New Issue No**";
                Delete="F";
            }
        break;
        
        case'pro_shbo00080_3':
            if(txtMasterPK.text=="")
            {
                var lono= txtLotNo.text;
                if(dso_shbo00080.GetStatus()!="20")
                {
                    dso_shbo00080.StatusInsert();
                }
                txtLotNo.text=lono;
                dso_shbo00080_1.Call("SELECT");
            }
            else
            {
                alert("This Lot created!!!");
                dso_shbo00080.Call("SELECT");
            }
        break;
        
    }
}
//===============================================================
function OnPrint(pos)
{
    switch(pos)
    {
        case'1':
            if(txtMasterPK.text!="")
            {
                var fpath = System.RootURL + "/form/sh/bo/shbo00082.aspx?main_m_pk="+txtMasterPK.text;
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            }
            else
            {
                alert("Please Select Lotno to print Label");
            }
        break;
        case'2':
            if(txtMasterPK.text!="")
            {
                var fpath = System.RootURL + "/form/sh/bo/shbo00210.aspx?main_m_pk="+txtMasterPK.text+"&hoki="+lstMachineNo.value+"&lotno="+txtLotNo.text+"&InstructDT="+DtInsDate.value;
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            }
            else
            {
                alert("Please Select Lotno to print Label");
            }
        break;
    }
    
    
}
//===============================================================
function btnPrint_onfocus() {

}

</script>
<body>
   
   <!--------------------------------------------------------------------------------------->
   <gw:data id="data_shbo00080_main_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00080_main_list">
                <input bind="grdSearch" >
                    <input bind="lstMachineNoM" />
                    <input bind="txtTypeNoSearch" />
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="PROD.sp_sel_shbo00080" procedure="PROD.sp_upd_shbo00080">
            <inout> 
                <inout bind="txtMasterPK"/>       
                <inout bind="DtInsDate"/>
                <inout bind="lstMachineNo"/>
                <inout bind="txtLotNo"/>   
                <inout bind="txtEstQty"/>
                <inout bind="txtIssueNo"/>
                <inout bind="txtLicenseNo"/>
                <inout bind="txtTcoItemPK"/> 
                <inout bind="txtProductCode"/>     
                <inout bind="txtProductName"/>
                <inout bind="txtTcoBuspartnerPK"/>
                <inout bind="txtCustomerCode"/>
                <inout bind="txtCustomerName"/>
                <inout bind="txtSizeCode"/>         
                <inout bind="txtSizeName"/>   
                <inout bind="txtColorCodeCap"/>
                <inout bind="txtColorNameCap"/>
                <inout bind="txtColorCodeBody"/> 
                <inout bind="txtColorNameBody"/>  
                <inout bind="txtCapPinNo"/>
                <inout bind="txtBodyPinNo"/>
                <inout bind="dtIssueDt"/>     
                <inout bind="txtChargerPK"/>
                <inout bind="txtIssueID"/>
                <inout bind="txtIssueName"/>  
                <inout bind="txtBatLotPK"  />         
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00080_1" > 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00080_1">
            <inout>
                <inout bind="txtLotNo"  />
                <inout bind="lstMachineNo"/>       
                <inout bind="txtEstQty"/>
                <inout bind="txtTcoItemPK"/>
                <inout bind="txtProductCode"/>   
                <inout bind="txtProductName"/>
                <inout bind="txtTcoBuspartnerPK"/>
                <inout bind="txtCustomerCode"/>
                <inout bind="txtCustomerName"/> 
                <inout bind="txtSizeCode"/>     
                <inout bind="txtSizeName"/>
                <inout bind="txtColorCodeCap"/>
                <inout bind="txtColorNameCap"/>
                <inout bind="txtColorCodeBody"/>         
                <inout bind="txtColorNameBody"/>   
                <inout bind="txtCapPinNo"/>
                <inout bind="txtBodyPinNo"/> 
                <inout bind="txtBatLotPK"  />
                <inout bind="txtLicenseNo"  />           
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_shbo00080_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00080_3" > 
                <input>
                    <input bind="txtLotNo" />                     
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 40%" align="left" id="left">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td align="right" >
                            <b>Period</b>
                        </td>
                        <td  >
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch()" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Machine No</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstMachineNoM" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Lot No</td>
                        <td style="width: 89%" colspan="2">
                            <gw:textbox id="txtTypeNoSearch" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Lot No|Hoki|Inst Date|Inst Qty|Iss No" format="0|0|0|4|1|0" aligns="0|0|0|0|0|0"
                                defaults="|||||" editcol="0|0|0|0|0|0" widths="0|2000|2000|1500|1000|1000" styles="width:100%;height:100%" autosize='T'
                                oncellclick="OnClickGridMaster()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:60%" align="right" id="right">
              <table style="height: 100%; width: 100%">
                <tr style="height: 7%">
                    <td></td>
                    <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height:10%">
                                    
                                    <td style="width: 96%" align="right">
                                        <button id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint('1')" onfocus="return btnPrint_onfocus()" >Identification Label</button>
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="printer" alt="Print" text="Print" id="btnReport" onclick="OnPrint('2')"/>
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
                                    </td>
                                </tr>
                            </table>
                            </td>
                </tr>
                <tr style="height: 5%">
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate" maxlen="10" lang="<%=Application("Lang")%>" mode="01"   styles='width:100%'/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Machine No</td>
                    <td><gw:list id="lstMachineNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Lot No</b></td>
                    <td><gw:textbox id="txtLotNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Estimated Qty(pcs)</td>
                    <td><gw:textbox id="txtEstQty" styles="width: 100%" type="number" format="###,###.###"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue No.</td>
                    <td><gw:textbox id="txtIssueNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>License No.</td>
                    <td><gw:textbox id="txtLicenseNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Product Code</td>
                    <td><gw:textbox id="txtProductCode" styles="width: 35%" /><gw:textbox id="txtProductName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Customer Code</td>
                    <td><gw:textbox id="txtCustomerCode" styles="width: 35%" /><gw:textbox id="txtCustomerName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Size</td>
                    <td><gw:textbox id="txtSizeCode" styles="width: 35%" /><gw:textbox id="txtSizeName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(CAP)</td>
                    <td><gw:textbox id="txtColorCodeCap" styles="width: 35%" /><gw:textbox id="txtColorNameCap" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(BODY)</td>
                    <td><gw:textbox id="txtColorCodeBody" styles="width: 35%" /><gw:textbox id="txtColorNameBody" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%"> 
                    <td>CAP Pin No.</td>
                    <td><gw:textbox id="txtCapPinNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>BODY Pin No.</td>
                    <td><gw:textbox id="txtBodyPinNo" styles="width:100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="dtIssueDt" styles="width: 100%" lang="1" nullaccept /></td>
                </tr>
                <tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Issue By</b></td>
                    <td>
                    <gw:textbox id="txtIssueID" styles="width: 35%" />
                    <gw:textbox id="txtIssueName" styles="width: 65%" />
                    </td>
                </tr>
              </table> 
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtChargerPK" style="display: none" />
    <gw:textbox id="txtTcoItemPK" style="display: none" />
    <gw:textbox id="txtTcoBuspartnerPK" style="display: none" />
    <gw:textbox id="txtBatLotPK" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
