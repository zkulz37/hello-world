<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Export Declaration Entry</title>
</head>
<%  ESysLib.SetUser("imex")%>

<script>

var user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var user_name  = "<%=Session("USER_NAME")%>" ;

var flag;
   	
var G_DETAIL_PK = 0,
    G_MST_PK    = 1,
    G_SEQ       = 2,
    G_REF_PO_NO = 3,
    G_ST_ITEM_PK= 4,
    G_ITEM_PK   = 5,
    G_ITEM_CODE = 6,
    G_ITEM_NAME = 7,
    G_SPEC01_PK = 8,
    G_SPEC01_ID = 9,
    G_SPEC02_PK = 10,
    G_SPEC02_ID = 11,
    G_SPEC03_PK = 12,
    G_SPEC03_ID = 13,
    G_SPEC04_PK = 14,
    G_SPEC04_ID = 15,
    G_SPEC05_PK = 16,
    G_SPEC05_ID = 17,
    G_HS_CODE   = 18,    
    G_QTY_01    = 19,
    G_UOM_01    = 20,
    G_QTY_02    = 21,
    G_UOM_02    = 22,
    G_UPRICE    = 23,
    G_AMOUNT    = 24,
    G_SO_D_PK   = 25,
    G_REMARK    = 26;	   
    
//================================================================================	    
function BodyInit()
 {       
    System.Translate(document);  // Translate to language session
    //--------------------------------------
    txtStaffID.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtCustomsArea.SetEnable(false);
    txtCustomsDept.SetEnable(false);
    txtDeclSeq.SetEnable(false);
    
    txtExporterID.SetEnable(false);
    txtExporterName.SetEnable(false);
    txtImporterID.SetEnable(false);
    txtImporterName.SetEnable(false);
    txtConsignorID.SetEnable(false);
    txtConsignorName.SetEnable(false);
    txtForwarderID.SetEnable(false);
    txtForwarderName.SetEnable(false);
    
    txtDeclType.SetEnable(false);
    txtImpCountry.SetEnable(false);
    txtExportGate.SetEnable(false);
    //--------------------------------------
    OnChangeTab();
    OnToggleGrid();
    //--------------------------------------
    BindingDataList(); 
    //--------------------------------------       
       txtMasterPK.text = "<%=Request.querystring("po_pk")%>";
       OnSearch('Master');
        
 }
//================================================================================	
    
 function BindingDataList()
 {   
      var data = "" ;

      data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
      lstCompany.SetDataText(data);
            
      data ="data|1|Qty 1|2|Qty 2"
      lstPriceBy.SetDataText(data);  
      lstPriceBy.value = 1;
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL")%>";  
      lstTransCCY.SetDataText(data); 
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('IEEX0030') FROM DUAL")%>";  
      lstDeclType.SetDataText(data);  
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0250') FROM DUAL")%>"; 
      lstDeliMethod.SetDataText(data); 
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0130') FROM DUAL")%>"; 
      lstPriceType.SetDataText(data);
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0120') FROM DUAL")%>"; 
      lstPaymentTerm.SetDataText(data);  
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0230') FROM DUAL")%>"; 
      lstExPort.SetDataText(data);  
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0220') FROM DUAL")%>"; 
      lstImpCountry.SetDataText(data);       
      
      var ctr = grdDetail.GetGridControl(); 
      ctr.ColFormat(G_QTY_01) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_QTY_02) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_UPRICE) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_AMOUNT) = "#,###,###,###,###,###.##";                                              
 }
 
//================================================================================
	
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G_SPEC01_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_ID) = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G_SPEC01_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_ID) = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
} 

//===================================================================================
 

//===================================================================================
function OnSearch(pos)
{
    switch(pos)
    {       
        case 'Master':
            data_epex00081.Call("SELECT");
        break;
        
        case 'Detail':
            data_epex00081_1.Call("SELECT");
        break;
    }
}    
//===================================================================================
function OnPopUp(pos)
{      
}
//=========================================================================        
function OnSave(pos)
{
    switch (pos)
    {
        case 'Detail':        
            data_epex00081_1.Call();
        break;
    }
}
//================================================================================	    
 function OnAddNew(pos)
 {    
 }   
//================================================================================	    
function OnDataReceive(obj)
{ 
        switch (obj.id)
        {
            case "data_epex00081" :
                if ( flag == 'save')
                {
                    for(var i=0; i < grdDetail.rows;i++)
                    {
                        if ( grdDetail.GetGridData( i, G_MST_PK) == '' )
                        {
                            grdDetail.SetGridText( i, G_MST_PK, txtMasterPK.text);
                        }    
                    }                
                    
                    OnSave('Detail');                
                }
                else
                {
                    //---------------------------- 
                    OnSearch('Detail');   
                }            
            break;
            
            case "data_epex00081_1":
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBold( 1, G_ITEM_CODE, grdDetail.rows - 1, G_ITEM_CODE, true);
                    grdDetail.SetCellBold( 1, G_REF_PO_NO, grdDetail.rows - 1, G_REF_PO_NO, true);
                    grdDetail.SetCellBold( 1, G_QTY_01, grdDetail.rows - 1, G_QTY_01, true); 
                    grdDetail.SetCellBold( 1, G_QTY_02, grdDetail.rows - 1, G_QTY_02, true);
                    
                    grdDetail.SetCellBold( 1, G_UPRICE, grdDetail.rows - 1, G_UPRICE, true);
                    grdDetail.SetCellBold( 1, G_AMOUNT, grdDetail.rows - 1, G_AMOUNT, true);
                }  
            break;
            
            case "data_epex00081_2" :
                alert(txtReturnValue.text);
                window.returnValue = 1; 
                this.close();         
            break;
                                                                          
        }  
} 
//===================================================================================   
 function OnChangeTab()
 { 
    var strRad = radTab.GetData();
             
	switch (strRad)
	{
		case '1':
		    document.all("Tab_Decl_Info").style.display  = "";
		    document.all("Tab_Decl_Items").style.display = "none";
		    
		    document.all("Decl_Info").style.color   = "red"; 
		    document.all("Decl_Item").style.color   = "";
        break;
        
        case '2':
		    document.all("Tab_Decl_Info").style.display  = "none";
		    document.all("Tab_Decl_Items").style.display = "";
		    
		    document.all("Decl_Info").style.color   = ""; 
		    document.all("Decl_Item").style.color   = "red";     
        break;	
        
        case '3':
		    document.all("Tab_Decl_Info").style.display   = "none";
		    document.all("Tab_Decl_Items").style.display  = "none";
		    
		    document.all("Decl_Info").style.color   = ""; 
		    document.all("Decl_Item").style.color   = "";         
        break;        
    } 
 }
 
//=================================================================================== 
function OnProcess(pos)
{
    switch (pos)
    {           
        case 'Approve':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }                    
            if ( confirm('Do you want to approve this Invoice ?') )
            {
                data_epex00081_2.Call();                
            }        
        break;     
    }    
}    

//===================================================================================    
</script>

<body>
    <!------------------------------------------------------------------------------------------>
    <gw:data id="data_epex00081" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59" function="imex.sp_sel_epex00081"> 
            <inout> 
                <inout  bind="txtMasterPK" />                 
                <inout  bind="lstCompany" /> 
                <inout  bind="txtStaffPK" />
                <inout  bind="txtStaffID" />
                <inout  bind="txtStaffName" />
                <inout  bind="lbStatus" />
                
                <inout  bind="txtCustomsPK" />
                <inout  bind="txtCustomsArea" />
                <inout  bind="txtCustomsDept" />
                <inout  bind="txtDeclSeq" />
                <inout  bind="txtDeclNo" />
                <inout  bind="dtDeclDate" />
                <inout  bind="txtAnnexDoc" /> 
                <inout  bind="txtCustomsAgent" />
                <inout  bind="dtExportDate" />
                
                <inout  bind="txtExporterPK" />
                <inout  bind="txtExporterID" />
                <inout  bind="txtExporterName" />
                <inout  bind="txtExpDesc" />
                <inout  bind="txtImporterPK" />
                <inout  bind="txtImporterID" />
                <inout  bind="txtImporterName" />
                <inout  bind="txtImpDesc" />
                <inout  bind="txtConsignorPK" />
                <inout  bind="txtConsignorID" />   
                <inout  bind="txtConsignorName" />
                <inout  bind="txtConsDesc" />
                <inout  bind="txtForwarderPK" />
                <inout  bind="txtForwarderID" />
                <inout  bind="txtForwarderName" />  
                <inout  bind="txtForwarderDesc" /> 
                 
                <inout  bind="txtDeclType" />     
                <inout  bind="lstDeclType" />      
                <inout  bind="chkTaxYN" />
                <inout  bind="txtLicenseNo" />     
                <inout  bind="dtLicenseDate" />    
                <inout  bind="dtLicenseExpDate" />  
                <inout  bind="txtArrayCIPK" />
                <inout  bind="txtInvoceNo" />   
                <inout  bind="dtInvoiceDate" /> 
                
                <inout  bind="txtContractNo" />   
                <inout  bind="dtContractDate" />       
                <inout  bind="dtContractExpDate" />   
                <inout  bind="txtImpCountry" />   
                <inout  bind="lstImpCountry" /> 
                <inout  bind="txtExportGate" />
                <inout  bind="lstExPort" />
                <inout  bind="lstDeliMethod" />  
                <inout  bind="lstPaymentTerm" /> 
                
                <inout  bind="txtOwner" />
                <inout  bind="txtEnclosedDoc" />
                                 
                <inout  bind="lstTransCCY" /> 
                <inout  bind="txtExRate" />
                
                <inout  bind="txtRemark" />  
                          
                <inout  bind="txtTransAmount" />
                <inout  bind="txtBookAmount" />
                <inout  bind="lstPriceBy" />  
                
                <inout  bind="txtRefPONo" />
                <inout  bind="dtPODate" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
    <!---------------------------------------------------------------------------------------->
    <gw:data id="data_epex00081_1" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function="IMEX.sp_sel_epex00081_1"> 
            <input bind="grdDetail">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_epex00081_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_pro_epex00081" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 30%; white-space: nowrap" align="center" colspan="10">
                <table style="width: 100%; height: 100%; background-color: CCFFFF">
                    <tr>
                        <td style="width: 96%" align="left">
                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                <span value="1" id="Decl_Info">Declaration Info</span> 
                                <span value="2" id="Decl_Item">Declaration Items</span>                                  
                            </gw:radio>
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                        </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Company</td>
            <td style="width: 20%">
                <gw:list id="lstCompany" styles="width:100%;"></gw:list>
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Charger
            </td>
            <td style="width: 40%; white-space: nowrap">
                <gw:textbox id="txtStaffID" styles="width:30%" />
                <gw:textbox id="txtStaffName" styles="width:70%" />
                <gw:textbox id="txtStaffPK" styles="display:none" />
            </td>
            <td style="width: 25%" align="center">
                <gw:label id="lbStatus" text="-" styles='width:100%;color:red; font-weight:700;'
                    csstype="mandatory" />
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <table style="width: 100%; height: 100%" id="Tab_Decl_Info">
                    <tr style="height: 1%">
                        <td colspan="2">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Customs
                                        </td>
                                        <td style="width: 35%; white-space: nowrap">
                                            <gw:textbox id="txtCustomsPK" styles='display:none;' />
                                            <gw:textbox id="txtCustomsArea" text="" styles='width:40%;' />
                                            <gw:textbox id="txtCustomsDept" text="" styles='width:60%;' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Decl No
                                        </td>
                                        <td style="width: 25%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtDeclSeq" text="" styles='width:40%;' csstype="mandatory" />
                                            <gw:textbox id="txtDeclNo" text="" styles='width:60%;' csstype="mandatory" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Accept No.</td>
                                        <td style="width: 15%">
                                            <gw:textbox id="txtAcceptNo" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Customs Agent</td>
                                        <td style="width: 35%">
                                            <gw:textbox id="txtCustomsAgent" text="" styles='width:100%;' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Register</td>
                                        <td style="width: 15%">
                                            <gw:datebox id="dtDeclDate" lang="1" nullaccept="T" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Export</td>
                                        <td style="width: 15%">
                                            <gw:datebox id="dtExportDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Annex Doc</td>
                                        <td style="width: 15%">
                                            <gw:textbox id="txtAnnexDoc" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 40%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Exporter
                                        </td>
                                        <td style="width: 35%; white-space: nowrap">
                                            <gw:textbox id="txtExporterPK" styles='display:none;' />
                                            <gw:textbox id="txtExporterID" text="" styles='width:30%;' csstype="mandatory" />
                                            <gw:textbox id="txtExporterName" text="" styles='width:70%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <gw:textarea id="txtExpDesc" styles="width:100%;" rows="3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Importer
                                        </td>
                                        <td style="width: 35%">
                                            <gw:textbox id="txtImporterPK" styles='display:none;' />
                                            <gw:textbox id="txtImporterID" text="" styles='width:30%;' csstype="mandatory" />
                                            <gw:textbox id="txtImporterName" text="" styles='width:70%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <gw:textarea id="txtImpDesc" styles="width:100%;" rows="3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Consignor
                                        </td>
                                        <td style="width: 35%">
                                            <gw:textbox id="txtConsignorPK" styles='display:none;' />
                                            <gw:textbox id="txtConsignorID" text="" styles='width:30%;' />
                                            <gw:textbox id="txtConsignorName" text="" styles='width:70%;' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <gw:textarea id="txtConsDesc" styles="width:100%;" rows="3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Forwarder
                                        </td>
                                        <td style="width: 35%; white-space: nowrap">
                                            <gw:textbox id="txtForwarderPK" styles='display:none;' />
                                            <gw:textbox id="txtForwarderID" text="" styles='width:30%;' />
                                            <gw:textbox id="txtForwarderName" text="" styles='width:70%;' />
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="2">
                                            <gw:textarea id="txtForwarderDesc" styles="width:100%;" rows="3" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td style="width: 60%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Decl type
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            <gw:textbox id="txtDeclType" text="" styles='width:100%' />
                                        </td>
                                        <td style="width: 20%; white-space: nowrap" colspan="2">
                                            <gw:list id="lstDeclType" styles="width:100%" onchange="OnListChange('DeclType')"
                                                csstype="mandatory"></gw:list>
                                        </td>
                                        <td style="width: 25%" align="center">
                                            <gw:checkbox id="chkTaxYN" onchange="" defaultvalue="Y|N" value="Y" />
                                            Tax Y/N</td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 5%; white-space: nowrap">
                                            License</td>
                                        <td colspan="4" style="width: 55%">
                                            <gw:textbox id="txtLicenseNo" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 5%">
                                            License Date</td>
                                        <td style="width: 25%" colspan="2">
                                            <gw:datebox id="dtLicenseDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                        <td style="width: 5%">
                                            Expire</td>
                                        <td style="width: 25%">
                                            <gw:datebox id="dtLicenseExpDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%">
                                            Invoice
                                        </td>
                                        <td style="width: 25%" colspan="2">
                                            <gw:textbox id="txtArrayCIPK" text="" styles='display:none' />
                                            <gw:textbox id="txtInvoceNo" text="" styles='width:100%;' />
                                        </td>
                                        <td style="width: 5%">
                                            Date</td>
                                        <td style="width: 25%">
                                            <gw:datebox id="dtInvoiceDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 5%">
                                            Contract</td>
                                        <td colspan="2" style="width: 25%">
                                            <gw:textbox id="txtContractNo" text="" styles='width:100%;' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            P/O No
                                        </td>
                                        <td style="width: 25%">
                                            <gw:textbox id="txtRefPONo" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 5%; white-space: nowrap">
                                            Contract Date</td>
                                        <td style="width: 25%; white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtContractDate" lang="1" onchange="" nullaccept="T" />
                                            ~
                                            <gw:datebox id="dtContractExpDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                        <td style="width: 5%">
                                            P/O Date
                                        </td>
                                        <td style="width: 25%">
                                            <gw:datebox id="dtPODate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%">
                                            Im-Country
                                        </td>
                                        <td style="width: 10%">
                                            <gw:textbox id="txtImpCountry" styles='width:100%;' />
                                        </td>
                                        <td colspan="3" style="width: 45%">
                                            <gw:list id="lstImpCountry" styles="width:100%;" onchange="OnListChange('ImpCountry')"></gw:list>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap; width: 5%">
                                            Ex-Port
                                        </td>
                                        <td style="width: 10%">
                                            <gw:textbox id="txtExportGate" styles='width:100%;' />
                                        </td>
                                        <td colspan="3" style="width: 45%">
                                            <gw:list id="lstExPort" styles="width:100%;" onchange="OnListChange('ExPort')"></gw:list>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap; background-color: CCFFFF">
                                            Deli Method
                                        </td>
                                        <td colspan="4" style="width: 55%; background-color: CCFFFF">
                                            <gw:list id="lstDeliMethod" styles="width:100%;" onchange=""></gw:list>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; background-color: CCFFFF">
                                            Price Type
                                        </td>
                                        <td colspan="2" style="width: 25%; background-color: CCFFFF">
                                            <gw:list id="lstPriceType" styles="width:100%;" onchange=""></gw:list>
                                        </td>
                                        <td style="width: 5%; white-space: nowrap; background-color: CCFFFF">
                                            Pay Term
                                        </td>
                                        <td style="width: 25%; background-color: CCFFFF">
                                            <gw:list id="lstPaymentTerm" styles="width:100%;" onchange=""></gw:list>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td style="width: 5%">
                                            Owner</td>
                                        <td colspan="4" style="width: 55%">
                                            <gw:textbox id="txtOwner" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%">
                                            Enclosed Doc</td>
                                        <td colspan="4" style="width: 55%">
                                            <gw:textbox id="txtEnclosedDoc" styles='width:100%;' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%; height: 100%" id="Tab_Decl_Items">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            Tr. CCY
                        </td>
                        <td style="width: 10%">
                            <gw:list id="lstTransCCY" styles="width:100%;" onchange="getExRate();"></gw:list>
                        </td>
                        <td style="width: 10%">
                            <gw:label id="lbBookCCY" text="" styles='width:100%;' />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Ex. Rate</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtExRate" styles='width:100%;' text="1" type="number" format="#,###,###,###,###.##R" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Remark</td>
                        <td colspan="5">
                            <gw:textbox id="txtRemark" text="" styles='width:100%;' onenterkey="" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            Tr. Amount
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtTransAmount" styles='width:100%;' csstype="mandatory" type="number"
                                format="#,###,###,###,###.##R" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Book Amount</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtBookAmount" styles='width:100%;' csstype="mandatory" type="number"
                                format="#,###,###,###,###.##R" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Price By</td>
                        <td style="width: 20%">
                            <gw:list id="lstPriceBy" styles="width:100%;" onchange=""></gw:list>
                        </td>
                        <td style="width: 22%" align="center">
                            <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                style="cursor: hand" onclick="OnToggleGrid()" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_PK|_MST_PK|Seq|P/O No|_ST_ITEM_PK|_ITEM_PK|Item Code|Item Name|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|HS Code|Qty 01|UOM|Qty 02|UOM|U/Price|Tr Amount|_SO_D_PK|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|0|0|0|1|0|1|0|1|0|1|0|1|0|3|1|3|1|3|3|0|0'
                                check='||||||||||||||||||||||||||' editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0|1|1|1|1'
                                widths='0|0|800|1500|0|0|2000|2500|0|1500|0|1500|0|1500|0|1500|0|1500|1000|1200|1000|1200|1000|1200|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------------------------------>
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" text="" styles='display:none' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------------------>
</html>
