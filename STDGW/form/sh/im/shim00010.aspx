<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Product Code Registration</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>

 var flag="view"; 

//------------------------------------------------------------------------------------------------
function BodyInit()
{
    shim00010_1.StatusInsert();
    chkStatus.value="Y";
    txtItemCode.text="**New Item Code**";
    lstNation.SetEnable(false);
	BindingDataList();
	shim00010.Call("SELECT");
	
	txtPartnerCode.enabled=false;	 	
    txtPartnerName.enabled=false;
	txtChargerName.enabled=false;
	txtBodyColor.enabled=false;                  
    txtBodyColorCode.enabled=false;
	//txtBodyColorName.enabled=false;
	//txtCapInkName.enabled=false;
	//txtCapInkCode.enabled=false;                  
   // txtBodyInkCode.enabled=false;
   //txtBodyInkName.enabled=false;
	txtCapColorCode.enabled=false;
	//txtCapColorName.enabled=false;
	txtItemCode.enabled=false;
	
	
}
//--------------------------------------------------------
function BindingDataList()
 {    
        var data="";
              
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||' - '||GRP_NM from  comm.tco_itemgrp where del_if=0 and prod_yn='Y' order by GRP_NM ")%>||Select All";
        lstGroup.SetDataText(data);
        lstGroup.value='';
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||' - '||GRP_NM from  comm.tco_itemgrp where del_if=0 and prod_yn='Y' order by GRP_NM ")%>";
        lstProdGroup.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT uom_code, uom_nm from  comm.tco_uom where del_if=0 order by uom_nm ")%>";
        lstUom.SetDataText(data);
        lstUom.value='';
        
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  ")%>";
        lstSize.SetDataText(data);
        lstSize.value='';
        
        lstSize_S.SetDataText(data+'|ALL|Select ALL');
        lstSize_S.value='ALL';
        
        data="<%=ESysLib.SetListDataSQL("select COUNTRY_no, COUNTRY_NM from imex.tie_country a where  a.del_if = 0")%>";
        lstNation.SetDataText(data);
        lstNation.value='';
        
        data="<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0080') FROM DUAL")%>";
        lstPharmaceu.SetDataText(data);
        lstPharmaceu.value='';
        
        data="<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0100') FROM DUAL")%>";
        lstPackingMethod.SetDataText(data);
        lstPackingMethod
        
        data="<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0070') FROM DUAL")%>";
        lstBodyType.SetDataText(data);
        lstBodyType.value='';
        
        data="<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0070') FROM DUAL")%>";
        lstCapType.SetDataText(data);
        lstCapType.value='';
        
        data="<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0090') FROM DUAL")%>";
        lstSaleType.SetDataText(data);
        lstSaleType.value='';
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code ||' - ' || a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0081' and a.use_if = 'Y' and a.del_if = 0 and a.code in ('001','005','007')  and b.del_if = 0  ")%>";
        lstMatDiv.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0030') FROM DUAL" )%>||";
        lstBlendingType.SetDataText(data);
        lstBlendingType.value='';
 }
//-----------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        case '1':
            
                    var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	                var object = System.OpenModal( fpath , 800 , 600 , 'resizable:yes;status:yes'); 
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
                        txtChargerName.text = object[5];//charger Name
		                txtChargerPK.text = object[0];
                    }
        break;
        case '3':
                    var fpath = System.RootURL + "/form/sh/ab/shab00060.aspx";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                        txtHSCodePK.text = object[1];
		                txtHSCode.text = object[2];
                    }
        break;
        case '4':
                var fpath = System.RootURL + "/form/sh/im/shim00011.aspx?";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	            if (object != null)
                    { 
                        txtCapColor.text = object[0];                 
                        txtCapColorCode.text = object[1];
		                txtCapColorName.text = object[2] ;
		                
                    }      
        break;
        case '5':
                var fpath = System.RootURL + "/form/sh/im/shim00011.aspx?";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	            if (object != null)
                    {    
                        txtBodyColor.text = object[0];                  
                        txtBodyColorCode.text = object[1];
		                txtBodyColorName.text = object[2] ;
		                
                    }      
        break;     
        case '6':
                var fpath = System.RootURL + "/form/sh/im/shim00011.aspx?";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	            if (object != null)
                    {                  
                       
		                txtCapInkCode.text = object[1];
		                txtCapInkName.text = object[2] ;
		                txtCapPrintCol.text = object[0]
                    }      
        break;     
        case '7':
                var fpath = System.RootURL + "/form/sh/im/shim00011.aspx?";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');
	            if (object != null)
                    {
                        txtBodyPrintCol.text = object[0]                  
                        txtBodyInkCode.text = object[1];
		                txtBodyInkName.text = object[2] ;
		                
                    }      
        break;             
        
    }
}
//------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case'grdMatItem':
            shim00010.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=grdMatItem.GetGridData(grdMatItem.row,0);
            shim00010_1.Call("SELECT");
        break;
    } 
}
//--------------------------------------------------------
function OnSave()
{
    
    if(txtItemCode.text=="")
    {
        alert("Please Input Item Code");
        return false;
    }
    if(txtItemName.text=="")
    {
        alert("Please Input Item Name");
        return false;
    }
    else
    {
        
        txtPicturePK.SetDataText(imgComponent.oid);
        shim00010_1.Call();
        flag="update"; 
        
    }
    
}
//-----------------------------------------------------------------
 function OnDelete()
 {
    if (confirm('Are you sure you want to delete?'))
        {
            shim00010_1.StatusDelete();
	        shim00010_1.Call(); 
	        shim00010_1.StatusInsert();
	        txtItem.text="";
	        txtItemCode.text="**New Item Code**";
	        chkStatus.value="Y";
	        shim00010.Call("SELECT");
        }
	
 }
//-----------------------------------------------------------------
function OnNew()
{
    shim00010_1.StatusInsert();
    txtItemCode.text="**New Item Code**";
    imgComponent.SetDataText("");
    chkStatus.value="Y";
}

//-----------------------------------------------------------------
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case'shim00010_1':
            if(flag=="update")
            {
                flag="view";
                imgComponent.SetDataText(txtPicturePK.text);
                txtItem.text=txtItemCode.text;
                chkActive_YN.value=chkStatus.value;
                shim00010.Call("SELECT"); 
            }
            else
            {
                imgComponent.SetDataText(txtPicturePK.text);
            }
        break;
    }
}
//----------------------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shim00010" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="PROD.sp_sel_shim00010" > 
                <input> 
                    <input bind="lstGroup" />
                    <input bind="lstSize_S" />
                    <input bind="txtCapC_S" />
                    <input bind="txtBody_S" />
                    <input bind="txtItem" />
                    <input bind="chkActive_YN" /> 
                </input> 
                <output bind="grdMatItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shim00010_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="PROD.sp_sel_shim00010_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49" procedure="prod.sp_upd_shim00010_1"> 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="lstCompany" />
                    <inout bind="lstProdGroup" />
                    <inout bind="txtItemCode" />
                    <inout bind="txtItemName" />
                    <inout bind="txtLocalName" />
                    <inout bind="txtForName" />
                    <inout bind="lstMatDiv" />
                    <inout bind="txtSpec" />
                    <inout bind="lstNation" />
                    <inout bind="txtOldCode" />
                    <inout bind="txtBuspartnerPK" />
                    <inout bind="txtPartnerCode" />
                    <inout bind="txtPartnerName" />
                    <inout bind="dtCreate_DT" />
                    <inout bind="lstUom" />
                    <inout bind="lstSize" />
                    <inout bind="lstPharmaceu" />
                    <inout bind="txtUnitQty" />
                    <inout bind="txtExpiryDate" />
                    <inout bind="dtInitial" />
                    <inout bind="txtInitialPrice" />
                    <inout bind="lstSaleType" />
                    <inout bind="dtLastTrans" />
                    <inout bind="txtLastPrice" />
                    <inout bind="chkStatus" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtChargerName" />
                    <inout bind="lstPackingMethod" />
                    <inout bind="txtHSCodePK" />
                    <inout bind="txtHSCode" />
                    <inout bind="txtCapColor" />
                    <inout bind="txtCapColorCode" />
                    <inout bind="txtCapColorName" />
                    <inout bind="lstCapType" />
                    <inout bind="txtCapChar" />
                    <inout bind="txtCapPrintCol" />
                    <inout bind="txtCapInkCode" />
                    <inout bind="txtCapInkName" />
                    <inout bind="txtBodyColor" />
                    <inout bind="txtBodyColorCode" />
                    <inout bind="txtBodyColorName" />
                    <inout bind="lstBodyType" />
                    <inout bind="txtBodyChar" />
                    <inout bind="txtBodyPrintCol" />
                    <inout bind="txtBodyInkCode" />
                    <inout bind="txtBodyInkName" />
                    <inout bind="rdPrint" />
                    <inout bind="txtPicturePK" />
                    <inout bind="lstBlendingType" />
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
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
                            <b>Size</b>
                        </td>
                        <td style="width: 95%" align="right" colspan="2">
                            <gw:list id="lstSize_S" styles='width:100%' onchange="OnSearch('grdMatItem')"/>
                        </td>                  
                   </tr>   
                    <tr style="height: 1%">
                     <td style="width: 5%" align="right">
                            <b>Color</b>
                        </td>
                        <td style="width: 40%" align="right" >
                             <gw:textbox id="txtCapC_S" styles='width:100%' onenterkey="OnSearch('grdMatItem')" />
                        </td>   
                         <td style="width: 40%" align="right" >
                             <gw:textbox id="txtBody_S" styles='width:100%' onenterkey="OnSearch('grdMatItem')" />
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
                        <td style="width: 40%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('grdMatItem')" alt="Search" />
                        </td>
                    </tr>
                  
                    <tr style="height: 95%">
                        <td colspan="3">
                            <gw:grid id='grdMatItem' header='_PK|Code|Name' format='0|0|0' aligns='0|0|0' defaults='||'
                                editcol='0|0|0' widths='1000|1000|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%">
                <table style="width: 100%; height: 100%" cellpadding="1;" cellspacing="1">
                    <tr style="height: 5%">
                        <td colspan="5" style="width: 98%">
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
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Company</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:list id="lstCompany" styles='width:100%' />
                        </td>
                        <td style="width: 15%" colspan="2" rowspan="7" align="right">
                            <gw:image id="imgComponent" table_name="TES_LGPICTURE" oid="0" view="/binary/ViewFile.aspx"
                                post="/binary/PostFile.aspx" styles="width:80%;height:100%" style='border: 1px solid #1379AC' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Matl Type</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:list id="lstMatDiv" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Item Code</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:textbox id="txtItemCode" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Item Name</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:textbox id="txtItemName" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Local Name</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:textbox id="txtLocalName" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Foreign Name</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:textbox id="txtForName" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Prod Type</b>
                        </td>
                        <td style="width: 70%" colspan="3" align="right" colspan="1">
                            <gw:list id="lstProdGroup" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 20%" align="right">
                            <b>Spec</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtSpec" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Nation </b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:list id="lstNation" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Old Code</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtOldCode" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 12%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Partner </b>
                        </td>
                        <td style="width: 20%" align="right" colspan="3">
                            <gw:textbox id="txtPartnerCode" styles='width:30%' csstype="mandatory" />
                            <gw:textbox id="txtPartnerName" styles='width:65%' csstype="mandatory" />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Create DT</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:datebox id="dtCreate_DT" lang="1" onchange="OnSearch()" nullaccept />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan="6">
                            <hr style="color: Silver" size="1" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>UOM</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:list id="lstUom" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Size</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:list id="lstSize" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Pharmaceutical</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:list id="lstPharmaceu" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Unit Q'ty</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtUnitQty" styles='width:100%' type='number' format="###,###,###,###.#" />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Expiry DT</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtExpiryDate" styles='width:100%' type='number' format="###,###,###,###.#" />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Initial Trans DT</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:datebox id="dtInitial" lang="1" nullaccept />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Initial Price</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtInitialPrice" styles='width:100%' type='number' format="###,###,###,###.#" />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Sale type</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:list id="lstSaleType" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Last Trans DT</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:datebox id="dtLastTrans" lang="1" nullaccept />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%" align="right">
                            <b>Last Price</b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtLastPrice" styles='width:100%' type='number' format="###,###,###,###.#" />
                        </td>
                        <td align="right">
                            Gelatin Type</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:list id="lstBlendingType" styles="width: 100%" />
                        </td>
                        
                        <td style="width: 15%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Charger </b>
                        </td>
                        <td style="width: 25%" align="right" colspan="1">
                            <gw:textbox id="txtChargerName" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <b>Packing Method </b>
                        </td>
                        <td style="width: 25%" align="right">
                            <gw:list id="lstPackingMethod" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Active</b>
                        </td>
                        <td style="width: 25%" align="left" colspan="1">
                            <gw:checkbox id="chkStatus" value="Y" defaultvalue="Y|N" />
                        </td>
                        <td style="width: 15%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('3')">HS Code</b>
                        </td>
                        <td style="width: 30%" align="right" colspan="1">
                            <gw:textbox id="txtHSCode" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan="6">
                            <hr style="color: Silver" size="1" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan="2">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align='left'>
                                        CAPSULE
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='3' align='center' style="background-color: #99ccff">
                                        COLOR
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="background-color: #99ccff; width: 20%">
                                        CAP
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtCapColorCode" styles='width:100%' csstype="mandatory" ondblclick="OnPopUp('4')" />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtCapColorName" styles='width:100%' csstype="mandatory" ondblclick="OnPopUp('4')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="background-color: #99ccff; width: 20%">
                                        BODY
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtBodyColorCode" styles='width:100%' csstype="mandatory" ondblclick="OnPopUp('5')" />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtBodyColorName" styles='width:100%' csstype="mandatory" ondblclick="OnPopUp('5')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="4">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align='left'>
                                        PRINT
                                    </td>
                                    <td colspan="4" align='right' style="height: 1%">
                                        <gw:radio id="rdPrint" value="Y" styles="width:98%; height:50%">                   
		                                            <span value="Y" id="rdYes">Printed</span>                      
		                                            <span value="N" id="rdNo">Unprinted</span>                   			                                
    			                        </gw:radio>
                                    </td>
                                </tr>
                                <tr>
                                    <td align='center' style="background-color: #99ccff">
                                    </td>
                                    <td align='center' style="background-color: #99ccff">
                                        Type
                                    </td>
                                    <td align='center' style="background-color: #99ccff">
                                        Character
                                    </td>
                                    <td align='left' colspan="2" style="background-color: #99ccff">
                                        Print Ink
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="background-color: #99ccff; width: 10%">
                                        CAP
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstCapType" styles='width:100%' />
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtCapChar" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtCapInkCode" styles='width:100%' ondblclick="OnPopUp('6')" csstype="mandatory" />
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtCapInkName" styles='width:100%' ondblclick="OnPopUp('6')" csstype="mandatory" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align='right' style="background-color: #99ccff; width: 10%">
                                        BODY
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstBodyType" styles='width:100%' />
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtBodyChar" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtBodyInkCode" styles='width:100%' ondblclick="OnPopUp('7')" csstype="mandatory" />
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtBodyInkName" styles='width:100%' ondblclick="OnPopUp('7')" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtBuspartnerPK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
<gw:textbox id="txtCapColor" styles="width: 100%;display:none" />
<gw:textbox id="txtCapPrintCol" styles="width: 100%;display:none" />
<gw:textbox id="txtBodyColor" styles="width: 100%;display:none" />
<gw:textbox id="txtBodyPrintCol" styles="width: 100%;display:none" />
<gw:textbox id="txtPicturePK" styles="width: 100%;display:none" />
<gw:textbox id="txtHSCodePK" styles="width: 100%;display:none" />
</html>
