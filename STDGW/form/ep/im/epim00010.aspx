<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Import Declaration List</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">

var flag;

var G0_PK                      =   0,
    G0_RECEP_NO                =   1,
    G0_RECEP_YMD               =   2,
    G0_DECL_NO                 =   3,
    G0_REG_YMD                 =   4,
    G0_DECL_FORM               =   5,
    G0_BOL                     =   6,
    G0_CONTRACT_NO             =   7,
    G0_DECL_STATUS             =   8,
    G0_RAMIFICATION_CONTENT    =   9,
    G0_DECL_PROFILE_NO         =   10,
    G0_COM_INV_NO              =   11,
    G0_COM_INV_YMD             =   12,
    G0_LICENSE_NO              =   13,
    G0_LICENSE_YMD             =   14,
    G0_KDT_REFERENCES          =   15;
    
var arr_FormatNumber = new Array();    
//================================================================================	    
function BodyInit()
 {       
    System.Translate(document);  // Translate to language session
    //--------------------------------------
    txtHCom_Pk.text = "<%=Session("COMPANY_PK")%>";
    //--------------------------------------
    BindingDataList(); 
    data_epim00010_Get_Cus.Call('SELECT');
    //--------------------------------------       
        
 }
//================================================================================	
function BindingDataList()
{   
      //------------------------Bind du lieu cho cac control ben trai man hinh-------------------
      var data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IECU0101') FROM DUAL")%>||"; 
      lstSDeclForm.SetDataText(data); 
      lstSDeclForm.value = '';
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IECU07') FROM DUAL")%>||"; 
      lstSStatus.SetDataText(data); 
      lstSStatus.value = '';
      
      data = "<%=ESysLib.SetListDataSQL("select cus_code, cus_name from tlg_ie_customs where del_if =0  and show_yn = 'Y'")%>"; 
      lstSCustoms.SetDataText(data);
      
      var ctr = grdDeclList.GetGridControl();
          ctr.ColFormat(G0_PK)             = "#,###,###,###,###,###";
 }
 
//===================================================================================
function OnSearch(pos)
{
    switch(pos)
    {
        case 'DECL_LIST':
            data_epim00010_decllist.Call("SELECT");
        break;
    }
}    
//===================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'SCustomsOffice':
             var path = System.RootURL + "/form/ep/bs/epbs00040.aspx?pop_type=Y";
	         var object = System.OpenModal( path ,850 ,600 ,'resizable:yes;status:yes;scroll:no;');
	         
	         if ( object != null )
	         {	        	                   
	             lstSCustoms.value = object[1];
	         }                
        break;  
        case 'DECL':
            var row  = event.row;
	        var col  = event.col; 
	        if(col == G0_DECL_NO && row != 0)
	        {
                var path = System.RootURL + "/form/ep/im/epim00050.aspx?pop_type=Y&decl_id=" + grdDeclList.GetGridData(row,G0_PK);;
	            var object = System.OpenModal( path ,950 ,600 ,'resizable:yes;status:yes;scroll:no;');	         
	            if ( object != null )
	            {	        	                   
	                lstSCustoms.value = object[1];
	            } 
	       }      
        break;
                                                                                                                                           
    }	       
}
//================================================================================	    
function OnFormatGrid()
{
    var ctrl = grdDeclList.GetGridControl(); 
    ctrl.Cell( 7, 0, G0_DECL_STATUS, grdDeclList.rows - 1, G0_DECL_STATUS) = 0xFF0000;
    ctrl.Cell( 7, 0, G0_DECL_NO, grdDeclList.rows - 1, G0_DECL_NO) = 0x0000FF;

}
//================================================================================	    
function OnDataReceive(obj)
{ 
        switch (obj.id)
        {
             case 'data_epim00010_Get_Cus':
                lstSCustoms.value = txtHCus_Code.text;
                data_epim00010_decllist.Call('SELECT');
             break;
             case 'data_epim00010_decllist':
                lblRecord.text = grdDeclList.rows - 1 + " row(s)";
                OnFormatGrid();
             break;
        }  
}
 
//================================================================================	    

function OnDelete(index)
{
    switch (index)
    {
        case 'Master':// delete master
            if ( txtMasterPK.text != '' )
            {
                if(confirm('Do you want to delete this Declaration ?'))
                {
                    flag='delete';
                    data_epim00050.StatusDelete();
                    data_epim00050.Call();
                }   
            }
        break;

        case 'Detail':
            if ( grdDetail.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                {
                    if ( grdDetail.GetGridData( grdDetail.row, G_DETAIL_PK ) == '' )
                    {
                        grdDetail.RemoveRow();
                    }
                    else
                    {   
                        grdDetail.DeleteRow();
                    }    
                }
            }            
        break;
    }
}
  
//================================================================================	    
function ValidateData(index)
{
    switch(index)
    {
        case 'Master' :
            if ( txtImporterPK.text == '' )
            {
                alert("You must input Importer!");
                return false;
            }
            if(dtDeclDate.value == "")
            {
                alert("Please input Register Date!");
                return false;                
            }            
            return true;
        break;
    }
}
 
//-------------------------------------------------------------------------------------------
function OnPrint(index)
{
    switch(Number(index))
    {
        case 1:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_declaration.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + lstCompany.value;
            System.OpenTargetPage( url, "_blank" );        
        break;
        case 2:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_packinglist.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + lstCompany.value;
            System.OpenTargetPage( url, "_blank" );  
        break;
    }
    
}
//===================================================================================
function SetTHCFee()
{
    var pLoadingFee = Number(txtLoadingFee.text);
    var pAVG = pLoadingFee/Number(txtTransAmount.text);
    var pFee = 0, pTotalFee = 0  ;
    
    for( var i=1; i < grdDetail.rows; i++ )
    {
        if ( i == grdDetail.rows-1 )
        {
            pFee = Number(pLoadingFee) - Number(pTotalFee);
            grdDetail.SetGridText( i, G_THC_AMOUNT, pFee ) ;
        } 
        else
        {
            pFee = pAVG * Number( Number(grdDetail.GetGridData( i, G_TR_AMOUNT)) );
            pFee = parseFloat(pFee+"").toFixed(2);
            
            pTotalFee = Number(pTotalFee) + Number(pFee);
            
            grdDetail.SetGridText( i, G_THC_AMOUNT, pFee ) ;
        }   
    }               
}
//=================================================================================== 
function SetFreightFee()
{    
    var pFreightFee = Number(txtFreightFee.text);
    var pAVG = pFreightFee/Number(txtTransAmount.text);
    var pFee = 0, pTotalFee = 0  ;
    
    for( var i=1; i < grdDetail.rows; i++ )
    {
        if ( i == grdDetail.rows-1 )
        {
            pFee = Number(pFreightFee) - Number(pTotalFee);
            grdDetail.SetGridText( i, G_FREIGHT_AMOUNT, pFee ) ;            
        } 
        else
        {
            pFee = pAVG * Number( Number(grdDetail.GetGridData( i, G_TR_AMOUNT)) );
            pFee = parseFloat(pFee+"").toFixed(2);
            
            pTotalFee = Number(pTotalFee) + Number(pFee);
            grdDetail.SetGridText( i, G_FREIGHT_AMOUNT, pFee ) ;
        }   
    }               
}
//===================================================================================      
</script>

<body>
    <!-------------------------------Lay thong tin cua hai quan, thong tin cong ty------------------------------------------------>
    <gw:data id="data_epim00010_Get_Cus" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_epim00010_info"> 
                <inout> 
                    <inout  bind="txtHCom_Pk" /> 
                    <inout  bind="txtHCus_Pk" />
                    <inout  bind="txtHCus_Code" />
                    <inout  bind="txtHCus_Name" />
                    
                    <inout  bind="txtHCom_Pk" />                    
                    <inout  bind="txtHCom_Id" />
                    <inout  bind="txtHCom_Name" />
                    <inout  bind="txtHCom_Code" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------Lay danh sach to khai- cua so ben trai------------------------------------------------>
    <gw:data id="data_epim00010_decllist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="0" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_epim00010_0"> 
                <input bind="grdDeclList"> 
                    <input bind="txtSRecepNo"/> 
                    <input bind="txtSDeclNo"/>
                    <input bind="txtSRegYear"/>
                    <input bind="lstSCustoms" /> 
                    <input bind="txtHCom_Code" />                   
                    <input bind="lstSDeclForm" />                    
                    <input bind="lstSStatus" />
                    <input bind="txtSBoL" />
                    <input bind="txtSLicense" />
                    <input bind="txtSInvoice" />
                    <input bind="txtSContract" />
                    <input bind="txtSProfile" />
                </input> 
                <output bind="grdDeclList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 5%; white-space: nowrap">
                Recep No
            </td>
            <td style="width: 44%">
                <gw:textbox id="txtSRecepNo" styles="width:100%;" onenterkey="OnSearch('DECL_LIST')"  />
            </td>
            <td align="right" style="width: 5%; white-space: nowrap">
                Decl No
            </td>
            <td style="width: 46%;" colspan="3">
                <gw:textbox id="txtSDeclNo" styles="width:100%;"  onenterkey="OnSearch('DECL_LIST')" />
            </td>
           
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 5%;">
                Reg Year
            </td>
            <td style="white-space: nowrap; width: 44%">
                <gw:textbox id="txtSRegYear" styles="width:100%;" onenterkey="OnSearch('DECL_LIST')" />
            </td>
            <td align="right" style="width: 5%;">
                <a onclick="OnPopUp('SCustomsOffice')" href="#tips" style="color: #0000ff">Customs</a>
            </td>
            <td style="width: 46%" colspan="3">
                <gw:list id="lstSCustoms" styles="width:100%;" onchange="OnSearch('DECL_LIST')"></gw:list>
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 5%; white-space: nowrap">
                Decl Form
            </td>
            <td style="width: 44%">
                <gw:list id="lstSDeclForm" styles="width:100%;" onchange="OnSearch('DECL_LIST')"></gw:list>
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Status
            </td>
            <td style="width: 46%;" colspan="3">
                <gw:list id="lstSStatus" styles="width:100%;" onchange="OnSearch('DECL_LIST')"></gw:list>
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 5%; white-space: nowrap">
                B/L
            </td>
            <td style="width: 44%">
                <gw:textbox id="txtSBoL" styles="width:100%;" onenterkey="OnSearch('DECL_LIST')" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                License
            </td>
            <td style="width: 46%;" colspan="3">
                <gw:textbox id="txtSLicense" styles="width:100%;"  onenterkey="OnSearch('DECL_LIST')" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 5%; white-space: nowrap">
                Invoice
            </td>
            <td style="width: 44%">
                <gw:textbox id="txtSInvoice" styles="width:100%;"  onenterkey="OnSearch('DECL_LIST')" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Contract
            </td>
            <td style="width: 46%;" colspan="3">
                <gw:textbox id="txtSContract" styles="width:100%;"  onenterkey="OnSearch('DECL_LIST')" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 5%; white-space: nowrap">
                Profile
            </td>
            <td style="width: 44%">
                <gw:textbox id="txtSProfile" styles="width:100%;"  onenterkey="OnSearch('DECL_LIST')" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
            </td>
            <td style="width: 45%;" colspan="2">
                <gw:label id="lblRecord" text="" styles="color:red" />
            </td>
            <td style="width: 1%;" >
           <gw:imgbtn id="btnSSearch" img="search" alt="Search" text="Search" onclick="OnSearch('DECL_LIST')" />
           </td>
        </tr>
        <tr style="height: 97%">
            <td style="width: 100%" colspan="6">
                <gw:grid id='grdDeclList' 
                    header='Seq|Recep No|Recep Date|Decl No|Reg Date|Decl Form|Bill of Lading|Contract No|Decl Status|Ramification Content|Decl Profile No|Com Inv No|Com Inv Date|License No|License Date|KDT References'
                    format='1|0|4|0|4|0|0|0|0|0|0|0|4|0|4|0' 
                    aligns='0|1|1|1|1|1|1|1|0|0|0|1|1|1|1|0'
                    check='|||||||||||||||' 
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    widths='800|1000|1200|1000|1200|1000|1300|2000|1500|1900|1900|1300|1200|1900|1200|3000'
                    sorting='T' styles='width:100%; height:100%' 
                    oncelldblclick="OnPopUp('DECL')"
                    />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------------------------------>
<!-------------------------------MAC DINH HAI QUAN & MA SO DOANH NGHIEP ------------------->
<gw:textbox id="txtHCom_Pk" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Code" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Name" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Id" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Pk" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Code" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Name" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------------------>
</html>
