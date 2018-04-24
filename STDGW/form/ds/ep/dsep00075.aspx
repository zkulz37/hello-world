<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Create Packages</title>
</head>

<script>

var G1_AS_SL                    = 0,
    G1_PackingType              = 1,
    G1_Packages_Type            = 2,
    G1_Label_Type               = 3,
    G1_Pack_Seq                 = 4,
    G1_TSA_SALEORDER_PK         = 5,
    G1_PO_No                    = 6,
    G1_Item_BC                  = 7,
    G1_PA_PACKING_WI_PK         = 8,
    G1_Package_PK               = 9;
    
var G2_SPEC01_PK        = 0,
    G2_Spec_01          = 1,
    G2_SPEC02_PK        = 2,
    G2_Spec_02          = 3,
    G2_SPEC03_PK        = 4,
    G2_Spec_03          = 5,
    G2_SPEC04_PK        = 6,
    G2_Spec_04          = 7,
    G2_SPEC05_PK        = 8,
    G2_Spec_05          = 9,
    G2_Pack_Qty         = 10,
    G2_Packages_PK      = 11,
    G2_Packages_Item_PK = 12;
    
//===========================================================

 function BodyInit()
 {
    System.Translate(document);
    //----------------------
    txtWIMasterPK.text = "<%=Request.querystring("WI_PK")%>";
	//----------------
	FormatGrid();
	//----------------
	OnSearch('lstPackagesType');
	//----------------
 } 
//===========================================================
 function FormatGrid()
 { 
      //-------------------------------------------------
      
      var data = "DATA|AS|ASSORT|SL|SOLID";
      lstPackType.SetDataText(data);  
      lstPackType.value = 'SL';  
      //-------------------------------------------------
      var packing_type = "<%=Request.querystring("packing_type")%>"; 
               
      data = "<%=ESysLib.SetListDataSQL(" SELECT   pk, type_code || ' - ' || type_name FROM tlg_pa_packing_type a WHERE del_if = 0 ORDER BY type_code ") %>";     
      lstPackingType.SetDataText(data); 
      
      if ( Number(packing_type) > 0 )
      {
        lstPackingType.value = packing_type ;                    
      } 
      //-------------------------------------------------
       
                       
 }
//===========================================================
 function OnDataReceive(obj)
 { 
    switch (obj.id)
    {          
        case 'pro_dsep00075' :
            //-------------------------
            ibtnGeneratePackages.SetEnable(true); 
        break;
        
        case 'pro_dsep00075_2' :
            //-------------------------
            alert(txtReturnValue.text);
            
            window.close();
        break;                 
    }
 }
//===========================================================
 function OnSearch(pos)
 { 
    switch (pos)
    {        
        case 'lstPackagesType':
            ibtnGeneratePackages.SetEnable(false);
            //----------------------
            pro_dsep00075.Call();
        break;                                     
    }
 }
//==============================================================================
function OnProcess(pos)
{
    switch (pos)
    {        
        case 'MakePackages' :
                   
            if ( txtWIMasterPK.text == '' )
            {
                alert('WI PK is NULL.');
                return;
            }
            
            if ( lstPackingType.value != '' && lstPackagesType.value != '' )
            {
                pro_dsep00075_2.Call();
            }
            else
            {
                alert('Pls select Packing Type, Packages Type.');
            }    
        break;
    }
}

//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="pro_dsep00075" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="<%=l_user%>lg_pro_dsep00075" > 
                <input>
                    <input bind="lstPackingType" /> 
                </input> 
                <output>
                    <output bind="lstPackagesType" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_dsep00075_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00075_2" > 
                <input>
                    <input bind="txtWIMasterPK" />
                    <input bind="lstPackingType" />
                    <input bind="lstPackagesType" />
                    <input bind="lstPackType" />  
                    <input bind="txtPackagesNum" /> 
                    <input bind="chkAutoMapping" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%;" border="1">
        <tr style="height: 65%">
            <td style="background-color: CCFFFF; border: 1px solid #034D72">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Packing
                        </td>
                        <td style="width: 90%" colspan="3">
                            <gw:list id="lstPackingType" styles='width:100%' onchange="OnSearch('lstPackagesType')"
                                csstype="mandatory" />
                        </td>
                    </tr>                    
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Package
                        </td>
                        <td style="width: 50%">                 
							<gw:list id="lstPackagesType" styles='width:100%' csstype="mandatory" />								
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Pack Type
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstPackType" styles='width:100%;color:blue' onchange="OnSearch('AssortType')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 35%">
            <td style="background-color: CCFFFF">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 20%; white-space: nowrap; color: DarkRed" align="right">
                            Packages Num</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPackagesNum" styles='width:100%' type="number" format="###,###,###" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 30%" align="right">
                            <gw:icon id="ibtnGeneratePackages" img="2" text="Make Packages" alt="Make Packages"
                                onclick="OnProcess('MakePackages')" styles='width:100%' />
                        </td>
                        <td style="width: 25%" align="center">
                            <gw:checkbox id="chkAutoMapping" defaultvalue="Y|N" value="N"/> Auto Mapping
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtWIMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtPackagesPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
