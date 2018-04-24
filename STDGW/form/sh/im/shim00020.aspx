<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Material Register</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_PK                       = 0,
        G1_color_code               = 1,
        G1_color_local_name         = 2;

    var G2_Item_Code                       =0,
        G2_Item_Name                       =1,
        G2_Reqd_Qty_Kg                     =2,
        G2_Reqd_Qty                        =3;
    
 var flag="view";  
 //---------------------------------------------------------
 function BodyInit()
 {
      
      shim00020_1.StatusInsert();
      chkStatus.value="Y";
      txtAccountName.enabled=false;
      txtGLAccountNo.enabled=false;
      txtItemCode.enabled=false;
      txtItemCode.text="**New Item Code**";
      BindingDataList();
     // shim00020.Call("SELECT");
      
      
 }
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'grdMatItem':
            shim00020.Call("SELECT");
        break;
        case'Master':
                txtMasterPK.text=grdMatItem.GetGridData(grdMatItem.row,G1_PK);
                shim00020_1.Call("SELECT");

        break;
    }
}
//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
              
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||' - '||GRP_NM from  comm.tco_itemgrp where del_if=0 and Mat_yn='Y'  order by GRP_CD ")%>||Select All";
        lstGroup.SetDataText(data);
        lstGroup.value='';
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||' - '||GRP_NM from  comm.tco_itemgrp where del_if=0 and Mat_yn='Y' order by GRP_CD ")%>|0|";
        lstGroup1.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT uom_code, uom_nm from  comm.tco_uom where del_if=0 order by uom_nm ")%>";
        lstUom.SetDataText(data);
        lstUom.value='';
        
        data="|purchase|Purchase|import|Import|localimport|Local import|production|Production";
        lstPurchase.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT uom_code, uom_nm from  comm.tco_uom where del_if=0 order by uom_nm ")%>";        
        lstUnit.SetDataText(data);
        lstUnit.value='';
        
        data="|day|Day|week|Week|month|Month|year|Year";
        lstLeadUnit.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code ||' - ' || a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0081' and a.use_if = 'Y' and a.del_if = 0 and a.code in ('002','003','004','006','009')  and b.del_if = 0  ")%>";
        lstMatDiv.SetDataText(data);
             
 }
//---------------------------------------------------------
 function OnSave(pos)
 {
    if(txtItemCode.text=="")
    {
        alert("Input Item Code");
        return false;
    }
    if(txtItemName.text=="")
    {
        alert("Input item Name");
        return false;
    }
    else
    {  
        txtPicturePK.SetDataText(imgComponent.oid);
        shim00020_1.Call();
        flag="update";
    }
     
 }

//---------------------------------------------------------

 function OnDelete()
 {
     if (confirm('Are you sure you want to delete?'))
        {
            shim00020_1.StatusDelete();
	        shim00020_1.Call();
	        shim00020_1.StatusInsert();
	        txtItem.text="";
	        txtItemCode.text="**New Item Code**";
	        chkStatus.value="Y";
	        shim00020.Call("SELECT");
        }
 }
 
//---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    {
        case '1':
            
                    var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {
                                
                                            
                        txtBuspartnerPK.text = object[0];//cust pk
		                txtPartnerCode.text = object[1];//cust id	 	
                        txtPartnerName.text = object[2];//cust name
                    }
        break;
        case '2':
                var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                        txtChargerID.text = object[3];//charger id
		                txtChargerName.text = object[5];//charger name 
		                txtChargerPK.text = object[0];
                    }
        break;
        case '3':
            var fpath = System.RootURL + "/form/ag/ci/agci00050_3.aspx?";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                        txtAccountName.text = object[2];
		                txtGLAccountNo.text = object[1];
		                txtAbacctcodePK.text = object[0];
                    }
        break;
        
    }
}
//---------------------------------------------------------
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case'shim00020_1':
            if(flag=="update")
            {
                flag="view";
                imgComponent.SetDataText(txtPicturePK.text);
                txtItem.text=txtItemCode.text;
                chkActive_YN.value=chkStatus.value;
                shim00020.Call("SELECT");
                
                
            }
            else
            {
                imgComponent.SetDataText(txtPicturePK.text);
            }
        break;
    }
}
//----------------------------------------------------------
function OnNew()
{
    shim00020_1.StatusInsert();
    txtItemCode.text="**New Item Code**";
    imgComponent.SetDataText("");
    chkStatus.value="Y";
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shim00020" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="PROD.sp_sel_shim00020" > 
                <input> 
                    <input bind="lstGroup" />
                    <input bind="txtItem" />
                    <input bind="chkActive_YN" /> 
                </input> 
                <output bind="grdMatItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shim00020_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shim00020_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41" procedure="prod.sp_upd_shim00020_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="lstCompany" />
                    <inout bind="lstGroup1" />
                    <inout bind="txtItemCode" />
                    <inout bind="txtItemName" />
                    <inout bind="txtLocalName" />
                    <inout bind="txtForeName" />
                    <inout bind="lstMatDiv" /> 
                    <inout bind="txtBuspartnerPK" />
                    <inout bind="txtPartnerCode" />
                    <inout bind="txtPartnerName" />
                    <inout bind="txtSpec" />
                    <inout bind="lstUom" />
                    <inout bind="lstPurchase" />
                    <inout bind="dtCreate" />
                    <inout bind="lstUnit" />
                    <inout bind="txtShelflife" />
                    <inout bind="dtInitial" />
                    <inout bind="txtInitialPrice" />
                    <inout bind="dtLast" />
                    <inout bind="txtLastPrice" />
                    <inout bind="chkAsset" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtChargerID" />
                    <inout bind="txtChargerName" />
                    <inout bind="txtConversion" />
                    <inout bind="rdABCAnalysis" />
                    <inout bind="chkStatus" />
                    <inout bind="txtMinSize" />
                    <inout bind="chkStorge" />
                    <inout bind="txtMaxSize" />
                    <inout bind="chkInventory" />
                    <inout bind="txtSafeStock" />
                    <inout bind="txtColorIndex" />
                    <inout bind="txtAbacctcodePK" />
                    <inout bind="txtGLAccountNo" />
                    <inout bind="txtAccountName" />
                    <inout bind="txtOldMaterialCode" />
                    <inout bind="txtDescription" />
                    <inout bind="txtPicturePK" />
                    <inout bind="txtLeadTime" />
                    <inout bind="lstLeadUnit" />
                       
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            <b>Group</b>
                        </td>
                        <td style="width: 95%" align="right" colspan="2">
                            <gw:list id="lstGroup" styles='width:100%' onchange="OnSearch('grdMatItem')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            <b>Item</b>
                        </td>
                        <td style="width: 95%" align="right" colspan="2">
                            <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch('grdMatItem')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            <b>Active</b>
                        </td>
                        <td style="width: 40%">
                            <gw:checkbox id="chkActive_YN" value="Y" defaultvalue="Y|N" onchange="OnSearch('grdMatItem')" />
                        </td>
                        <td style="width: 50%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('grdMatItem')" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdMatItem' header='_PK|Code|Name' format='0|0|0' aligns='0|0|0' defaults='||'
                                editcol='0|0|0' widths='1000|1000|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 35%">
                        <td style="width: 100%">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td colspan="4" style="width: 98%">
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 99%">
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>Company</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:list id="lstCompany" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        <b>Matl Type</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:list id="lstGroup1" styles='width:100%' />
                                    </td>
                                    <td nowrap width="19%" rowspan="6" align="right">
                                        <%--<gw:image id="imgFile" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx"
                                            styles="width:130;height:130" />--%>
                                        <gw:image id="imgComponent" table_name="TES_LGPICTURE" oid="0" view="/binary/ViewFile.aspx"
                                            post="/binary/PostFile.aspx" styles="width:120;height:100%" style='border: 1px solid #1379AC' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>Item Code</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtItemCode" styles='width:100%'csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Item Name</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtItemName" styles='width:100%'csstype="mandatory" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>Local Name</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtLocalName" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        <b>Foreign Name</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtForeName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12%" align="right">
                                        <b>Matl Group</b>
                                    </td>
                                    <td style="width: 20%" align="right" colspan="3">
                                        <gw:list id="lstMatDiv" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 12%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Partner </b>
                                    </td>
                                    <td style="width: 20%" align="right" colspan="3">
                                        <gw:textbox id="txtPartnerCode" styles='width:30%' />
                                        <gw:textbox id="txtPartnerName" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>Spec</b>
                                    </td>
                                    <td style="width: 20%" align="right" colspan="3">
                                        <gw:textbox id="txtSpec" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <hr style="color: Silver" size="1" />
                        </td>
                    </tr>
                    <tr style="height: 65%">
                        <td style="width: 100%">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>UOM</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:list id="lstUom" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Purchase</b>
                                    </td>
                                    <td style="width: 25%" align="right" colspan="2">
                                        <gw:list id="lstPurchase" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Create Date</td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:datebox id="dtCreate" lang="<%=Application("Lang")%>" mode="01" nullaccept/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Alt Unit</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:list id="lstUnit" styles='width:100%;color:Red' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Shelf life</b>
                                    </td>
                                    <td style="width: 15%" align="left">
                                        <gw:textbox id="txtShelflife" styles='width:100%' type='number' format="###,###,###,###.###" />
                                    </td>
                                    <td style="width: 10%" align="left">
                                        <b>Month</b>
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Initial Trans Date</td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:datebox id="dtInitial" lang="<%=Application("Lang")%>" mode="01" nullaccept/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Initial Price</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtInitialPrice" styles='width:100%'type='number'format="###,###,###,###.###"/>
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Lead-Time</b>
                                    </td>
                                    <td style="width: 15%" align="left">
                                        <gw:textbox id="txtLeadTime" styles='width:100%' type='number'format="###,###,###,###.###" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <gw:list id="lstLeadUnit" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Last Trans Date</td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:datebox id="dtLast" lang="<%=Application("Lang")%>" mode="01" nullaccept/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%" align="right">
                                        <b>Last Price</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtLastPrice" styles='width:100%'type='number'format="###,###,###,###.###" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Asset</b>
                                    </td>
                                    <td style="width: 15%">
                                        <gw:checkbox id="chkAsset" value="Y" defaultvalue="Y|N" onclick="" />
                                    </td>
                                    <td style="width: 15%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Charger </b>
                                    </td>
                                    <td style="width: 30%; white-space: nowrap" colspan="2">
                                        <gw:textbox id="txtChargerID" styles='width:30%' />
                                        <gw:textbox id="txtChargerName" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space:nowrap" align="right">
                                        <b>Conversion Factor</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtConversion" styles='width:100%'type='number'format="###,###,###,###.####"  />
                                    </td>
                                    <td style="width: 10%;white-space:nowrap" align="right">
                                        <b>ABC Analysis</b>
                                    </td>
                                    <td style="width: 20%" align="left" colspan="2">
                                        <gw:radio id="rdABCAnalysis" value="A" styles="width:100%">                      
			                                <span value="A" id="rdA">A</span>                       
			                                <span value="B" id="rdB">B</span>
			                                <span value="C" id="rdC">C</span>                   			                                
        			                    </gw:radio>
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Active</td>
                                    <td style="width: 30%" align="left">
                                        <gw:checkbox id="chkStatus" value="Y" defaultvalue="Y|N"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Min.Order Size</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtMinSize" styles='width:100%'type='number'format="###,###,###,###.###"  />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Storage</b>
                                    </td>
                                    <td style="width: 25%" colspan="2">
                                        <gw:checkbox id="chkStorge" value="Y" defaultvalue="Y|N" onclick="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Max.Order Size</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtMaxSize" styles='width:100%'type='number'format="###,###,###,###.###"  />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Inventory</b>
                                    </td>
                                    <td style="width: 25%" colspan="2">
                                        <gw:checkbox id="chkInventory" value="Y" defaultvalue="Y|N" onclick="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Safe Stock</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtSafeStock" styles='width:100%'type='number'format="###,###,###,###.###"  />
                                    </td>
                                    <td style="width: 10%" align="right">
                                    </td>
                                    <td style="width: 20%" align="left" colspan="2">
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Color Index No</td>
                                    <td style="width: 30%" align="left">
                                        <gw:textbox id="txtColorIndex" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('3')">G/L Account No.</b>
                                    </td>
                                    <td style="width: 20%" align="right">
                                        <gw:textbox id="txtGLAccountNo" styles='width:100%' csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Account name</b>
                                    </td>
                                    <td style="width: 20%" align="left" colspan="2">
                                        <gw:textbox id="txtAccountName" styles='width:100%' csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Old Mat.Code</td>
                                    <td style="width: 30%" align="left">
                                        <gw:textbox id="txtOldMaterialCode" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Description</b>
                                    </td>
                                    <td style="width: 20%" align="right" colspan="6">
                                        <gw:textbox id="txtDescription" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtBuspartnerPK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
<gw:textbox id="txtAbacctcodePK" styles="width: 100%;display:none" />
<gw:textbox id="txtPicturePK" styles="width: 100%;display:none" />
</html>
