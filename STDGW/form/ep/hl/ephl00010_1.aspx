<%@ Page Language="C#" AutoEventWireup="true"  %>
<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<%ESysLib.SetUser("imex");%>
<script language="javascript" type="text/javascript">
function BodyInit()
{ 
    var Company = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>"; 
    var option = "Data|Man|Manual|BOM|BOM";
    //var status = "<%=ESysLib.SetListDataSQL("select CODE, A.code_nm FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'ACBG0010' and A.use_yn = 'Y'")%>"; 
     var Unit = "<%=ESysLib.SetListDataSQL(" SELECT  uom_code, uom_nm FROM comm.tco_uom WHERE del_if = 0 ")%>"; 
    cboUnit.SetDataText(Unit);
    cboCompany.SetDataText(Company);
    cboOption.SetDataText(option);
    //cboStatus.SetDataText(status);
    cboOption.value='Man';
    
    onNew();
    txtSearchCusCode.SetEnable(false);
    txtSearchCusName.SetEnable(false);
    txtSearchProductCode.SetEnable(false);
    txtSearchProductName.SetEnable(false);
    txtCusCode.SetEnable(false);
    txtCusName.SetEnable(false);
    txtProductCode.SetEnable(false);
    txtProductName.SetEnable(false);
    Binding();
}
function Binding()
{
    var ctr = grdManParent.GetGridControl(); 
    
    //ctr.ColEditMask(7) = "\999999999.99";
    
    ctr.ColFormat(7) = "###.##";
    ctr.ColFormat(8) = "###.###";
    ctr.ColFormat(9) = "###.###";
    ctr.ColFormat(10) = "###.##";
    ctr.ColFormat(11) = "###.###";
}
  var action;
function OnSearch()
{
    dat_SearchMaster.Call("SELECT");
}
function onNew()
{
    lblStatus.text="";
    btnSave.SetEnable(true);
    btnISave.SetEnable(true);
    dat_ephl00010_1.StatusInsert();
    txtEmpPK.text = "<%=Session["USER_PK"]%>";
    grdManParent.ClearData();
}
 function onSave(index)
{
    switch(index)
    {
        case 0:
            if(ValidateData())
            {
                action ="save";
                dat_ephl00010_1.Call('');
            }            
        break;
        case 1:
            if(checkdata())
            {
             dat_ephl00010_2.Call();
            }
        break;
    }
}
function checkdata()
{
     for(var i=1;i<grdManParent.rows;i++)
          {
              if(grdManParent.GetGridData(i,7) == "")
             {
                alert("Please input Request Qty.");
                return false;
             }
             else if(grdManParent.GetGridData(i,8) == "")
             {
                alert("Please input Loss Rate.");
                return false;
             }
          }
          return true;
}
function ValidateData()
{
    if(txtCusPK.text=='')
    {
        alert("You must input Customs Office!"); 
        return false;
    }
    if(cboOption.value=='')
    {
        alert("You must input a option!");    
        return false;  
    }
    return true;
}
function openPopup(obj)
{
    switch(obj)
    {
        case 'Customs' :
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?partner_type=90"; //customs
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {             
                txtSearchCusName.SetDataText(aValue[2]); 
                txtSearchCusCode.SetDataText(aValue[1]);  
                txtSearchCusPK.SetDataText(aValue[0]);  
            }	
        break;
        case 'Product' :
           var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=Y|||||";
            oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                    txtSearchProductPK.SetDataText(oValue[0]);
                    txtSearchProductCode.SetDataText(oValue[1]);
                    txtSearchProductName.SetDataText(oValue[2]);
            }
        break;
        case 'Product1' :
           var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=Y|||||";
            oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                    txtProductPK.SetDataText(oValue[0]);
                    txtProductCode.SetDataText(oValue[1]);
                    txtProductName.SetDataText(oValue[2]);
                    cboUnit.value=oValue[5];
            }
        break;
        case 'CustomOffice' :
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?partner_type=90"; //customs
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {             
                txtCusName.SetDataText(aValue[2]); 
                txtCusCode.SetDataText(aValue[1]);  
                txtCusPK.SetDataText(aValue[0]);  
            }	
        break;
        case 2:  //SELECT PARENT    
            var fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=|||Y|Y|Y";
            oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
            var isAlready;           
            isAlready=0;
           
            if (oValue != null)
            {   
                //--0._Pk|1._Mst_pk|2_item_pk|3.No|4.Select|5.Parent Code|6.Parent Name|7.HS Code|8.Unit     
                for (var i=0; i<oValue.length;i++)
                {
                    aValue=oValue[i];
	                    
                    for(var k=1; k<grdManParent.rows;k++)
                        if (grdManParent.GetGridData(k , 3)== aValue[0]) // da co
				        {
					        isAlready=1;
					        break;	
				        }		
				        
				    if(isAlready==0) 
                    {    
                        var aValue = oValue[i];  
                        grdManParent.AddRow();
                        SetMasterPK_ManTab()
                        grdManParent.SetGridText(grdManParent.rows-1,3,aValue[0]);
                        grdManParent.SetGridText(grdManParent.rows-1,4,aValue[1]);
                        grdManParent.SetGridText(grdManParent.rows-1,5,aValue[2]);
                        grdManParent.SetGridText(grdManParent.rows-1,6,aValue[5]);
                        
                    }
                }                
            }
        break;

    }
}
function SetMasterPK_ManTab()
{
    for(var i=0; i<grdManParent.rows;i++)
        if (grdManParent.GetGridData(i,0)=='')
        {
            grdManParent.SetGridText(i,1,txtMasterPK.text);
        }
}
function Gridcellclick()
{
    txtMasterPK.text = grdSearchMaster.GetGridData(event.row,0);
    dat_ephl00010_1.Call("SELECT");
}
function CheckStatus()
{
    if(lblStatus.text=="Confirmed")
    {
        btnSave.SetEnable(false);
        btnISave.SetEnable(false);
    }
    else
    {
        btnSave.SetEnable(true);
        btnISave.SetEnable(true);
    }
    
}
function onDelete(index)
{
    switch(index)
    {
        case 0:
            if(confirm('Do you want to delete this entry?'))
            {
                dat_ephl00010_1.StatusDelete();
                action = 'delete';
                dat_ephl00010_1.Call('');
            }
        break;
        case 1:
            if(confirm('Do you want to delete this item ?'))
            {
                grdManParent.DeleteRow();
                dat_ephl00010_2.Call();
            }
        break;
    }
}
var flag="view"; 
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dat_ephl00010_1":
            if(flag == 'save')
            {
                SetMasterPK_ManTab();
                dat_ephl00010_2.Call();
            }
            else
            {
                dat_ephl00010_2.Call("SELECT");
            }
            CheckStatus();
         break;
          case "dat_ephl00010_2":
          {
            OnSearch();
           
          }
         break;
          case "dat_epil00010_2":
          {
            OnSearch();
          }
         break;
         case "dat_ephl00010_Cancel":
          {
            OnSearch();
          }
         break;
     }  
}
function GridDBClick(obj)
{
    if(obj.col==12)
    {
        var fpath = System.RootURL + "/form/gf/gf/gfgf00050_4.aspx"; 
        aValue = System.OpenModal( fpath , 600 , 400, 'resizable:yes;status:yes');
        if ( aValue != null )
        {          
             grdManParent.SetGridText(grdManParent.row,13, aValue[1]);
             grdManParent.SetGridText(grdManParent.row,12, aValue[4]);
        }	
     }
}
function resetAcc()
{
    txtSearchProductPK.text="";
    txtSearchProductCode.text="";
    txtSearchProductName.text="";
}
function onConfirmCancel()
{
    if(CheckDataToConfirm())
    {
        dat_epil00010_2.Call(); 
        lblStatus.text="Confirmed";
        btnSave.SetEnable(false);
        btnISave.SetEnable(false);
    }
}
function CheckDataToConfirm()
{
     for(var i=1;i<grdManParent.rows;i++)
          {
             if(grdManParent.GetGridData(i,4) == "")
             {
                alert("Please input Item Code.");
                return false;
             }
             else if(grdManParent.GetGridData(i,7) == "")
             {
                alert("Please input request Qty.");
                return false;
             }
             else if(grdManParent.GetGridData(i,8) == "")
             {
                alert("Please input Loss Rate.");
                return false;
             }
             else if(grdManParent.GetGridData(i,10) == "")
             {
                alert("Please input Adjust Qty.");
                return false;
             }
             /*else if(grdManParent.GetGridData(i,12) == "")
             {
                alert("Please input Origin.");
                return false;
             }
             else if(grdManParent.GetGridData(i,14) == "")
             {
                alert("Please input Remark.");
                return false;
             }*/
          }
          return true;
}
function OnChangeGrid()
{
    var LossQty=Number(grdManParent.GetGridData(grdManParent.row,7)) * Number(grdManParent.GetGridData(grdManParent.row,8))/100;
        grdManParent.SetGridText(grdManParent.row,9, LossQty);
    var Adjust=Number(grdManParent.GetGridData(grdManParent.row,7)) + Number(grdManParent.GetGridData(grdManParent.row,9));
//    var LossRate=Number(grdManParent.GetGridData(grdManParent.row,8));
//    var LossQty=Number(grdManParent.GetGridData(grdManParent.row,9));
//    var Adjust=ReQty+LossQty;
    var Total=LossQty+Adjust;
    
    grdManParent.SetGridText(grdManParent.row,10, Adjust);
    grdManParent.SetGridText(grdManParent.row,11, Total);
    
}
function OnCancel()
{
    dat_ephl00010_Cancel.Call();
    lblStatus.text="Cancel";
    btnSave.SetEnable(true);
    btnISave.SetEnable(true);
}
</script>
<body>
<!------------------------------------------------------------------>
<gw:data id="dat_SearchMaster"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" function="IMEX.sp_sel_ephl00010"> 
            <input bind="grdSearchMaster">                    
                <input bind="txtSearchCusPK" /> 
                <input bind="txtSearchProductPK" /> 
            </input> 
            <output bind="grdSearchMaster" /> 
        </dso>    
    </xml> 
</gw:data>  
<!------------------------------------------------------------------>

<!------------------------------------------------------------------------------------->
<gw:data id="dat_ephl00010_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="imex.sp_sel_ephl00010_1" procedure="imex.sp_upd_ephl00010_1" > 
            <inout>     
                 <inout  bind="txtMasterPK" />
                 <inout  bind="lblStatus" />
                 <inout  bind="txtCusPK" />
                 <inout  bind="txtCusCode" /> 
                 <inout  bind="txtCusName" /> 
                 <inout  bind="cboOption" /> 
                 <inout  bind="txtProductPK" /> 
                 <inout  bind="cboUnit" />  
                 <inout  bind="txtAcceptNo" />  
                 <inout  bind="dtAcceptDate" />   
                 <inout  bind="txtDes" />
                 <inout  bind="txtEmpPK" />
                 <inout  bind="txtConspNo" />
                 <inout  bind="txtProductCode" /> 
                 <inout  bind="txtProductName" /> 
            </inout>
        </dso> 
    </xml> 
</gw:data>  
<!-------------------------------Confirm/Cancel------------------------------------>
<!------------------------------------------------------------------>
<gw:data id="dat_ephl00010_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="imex.sp_sel_ephl00010_2"   procedure="imex.sp_upd_ephl00010_2"> 
            <input bind="grdManParent">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdManParent" /> 
        </dso>    
    </xml> 
</gw:data>  
<!------------------------------------------------------------------>
<!-------------------------------Confirm/Cancel------------------------------------>
<gw:data id="dat_epil00010_2" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_tie_consp_mst" > 
            <input>
                <input bind="txtMasterPK"/>
            </input> 
            <output>
                <output bind="txtstatus11" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Confirm/Cancel------------------------------------>
<gw:data id="dat_ephl00010_Cancel" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="IMEX.sp_pro_cancel_tie_consp_mst" > 
            <input>
                <input bind="txtMasterPK"/>
            </input> 
            <output>
                <output bind="txtstatus11" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------->
    <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
    <tr>
        <td style="width: 30%;">
            <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=1>
            <tr style="height: 2%">
                <td>
                    <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
                    <tr  style="height: 2%">
                    <td width="22%" nowrap ><a title="Click here to select Customs" onclick="openPopup('Customs')" href="#tips" style="text-decoration : none; color=#0000FF"><b>Customs</b></a> </td>
                    <td style="width: 23%;">
                        <gw:textbox id="txtSearchCusCode"  text=""  styles='width:100%;' csstype="mandatory" />
                        <gw:textbox id="txtSearchCusPK"  text=""  styles='display:none;' />
                    </td>
                    <td style="width: 45%;">
                        <gw:textbox id="txtSearchCusName"  text=""  styles='width:100%;' csstype="mandatory" />
                    </td>
                    <td style="width: 10%;"><gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                    </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 2%">
                <td>
                    <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
                    <tr  style="height: 2%">
                    <td width="22%" nowrap ><a title="Click here to select Product" onclick="openPopup('Product')" href="#tips" style="text-decoration : none; color=#0000FF"><b>Product</b></a> </td>
                    <td style="width: 23%;">
                        <gw:textbox id="txtSearchProductCode"  text=""  styles='width:100%;' csstype="mandatory" />
                        <gw:textbox id="txtSearchProductPK"  text=""  styles='display:none;' />
                    </td>
                    <td style="width: 45%;">
                        <gw:textbox id="txtSearchProductName"  text=""  styles='width:100%;' csstype="mandatory" />
                    </td>
                    <td style="width: 10%;" align="right">
                        <gw:imgBtn id="ibtnFaAccReset" img="reset"  alt="reset acc" onclick="resetAcc()" />
                    </td>
                    </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 94%">
                <td colspan="3">
                    <gw:grid id='grdSearchMaster'
                                        header='_Pk|Accept Date|Consp No|Status'
                                        format='0|4|0|0'
                                        aligns='0|0|0|1'
                                        defaults='|||'
                                        editcol='1|0|0|1'
                                        widths='0|1300|1300|1300'
                                        sorting='T'
                                        styles='width:100%; height:439'
                                        oncellclick="Gridcellclick()"
                                    />
                </td>
            </tr>
            </table>
        </td>
        
         <td style="width: 70%;">
            <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
                <tr style="height: 2%">
                <td>
                    <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
                    <tr>
                <td style="width: 15%;">Company</td>
                <td style="width: 17%;"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                <td style="width: 12%;">Consp No</td>
                <td style="width: 19%;"><gw:textbox id="txtConspNo"/></td>
                <td style="width: 5%;">Status</td>
                <td style="width: 2%;"></td>
                <td style="width: 12%;"><gw:label id="lblStatus" styles='width:100%;color:red; font-weight:700;'/></td>
                <td style="width: 1%;"></td>
                <td style="width: 3%;"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" /></td>
                <td style="width: 3%;"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                <td style="width: 2%;"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                <td style="width: 2%;"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirmCancel()" /></td>
                <td style="width: 2%;"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="OnCancel()" /></td>
                </tr>
                
                    </table>
                </td>
                </tr>
                
                
                 <tr style="height: 8%">
                 <td colspan="10">
                    <table width="100%" style="height: 100%" cellpadding=0 cellspacing=0 border=0>
                    <tr >
                <td><a title="Click here to select Customs Office" onclick="openPopup('CustomOffice')" href="#tips" style="text-decoration : none; color=#0000FF"><b>Custom Office</b></a> </td>
                 <td>
                  <gw:textbox id="txtCusCode"  text=""  styles='width:100%;' csstype="mandatory" />
                  
                 </td>
                 <td>
                  <gw:textbox id="txtCusName"  text=""  styles='width:100%;' csstype="mandatory" />
                  </td>
                  
                <td>Option</td>
                <td><gw:list id="cboOption" styles="width:100%;"></gw:list></td>
                </tr>
                    <tr>
                 <td style="width: 15%;"><a title="Click here to select Product" onclick="openPopup('Product1')" href="#tips" style="text-decoration : none; color=#0000FF"><b>Product</b></a> </td>
                 <td style="width: 19%;">
                  <gw:textbox id="txtProductCode"  text=""  styles='width:100%;' csstype="mandatory" />
                  
                 </td>
                 <td style="width: 37%;">
                  <gw:textbox id="txtProductName"  text=""  styles='width:100%;' csstype="mandatory" />
                  </td>
                <td style="width: 15%;">Unit</td>
                 <td style="width: 14%;">
                  <gw:list id="cboUnit" styles="width:100%;"/>
                 </td>
                </tr>
                 <tr>
                <td >Accept No</td>
                 <td colspan="2">
                  <gw:textbox id="txtAcceptNo"/>
                 </td>
                <td >Accept Date</td>
                <td ><gw:datebox id="dtAcceptDate" lang="1" onchange="onAcceptDateChange();"/></td>
                </tr>
                <tr>
                    <td>Description</td>
                     <td colspan="4"><gw:textbox id="txtDes"  styles="width:100%;"/></td>
                </tr>
                </table>
                </td>
                </tr>
                
                
                <tr style="height: 90%">
                <td colspan="8" valign="top">
                        <table width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="96%"></td> 
                                <td width="1%"><gw:imgbtn id="btnPopup" img="popup" alt="Click to open form search" text="Search" onclick="openPopup(2)" /></td>
                                <td width="1%"><gw:imgbtn id="btnISave" img="save" alt="Save" text="Save" onclick="onSave(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnIDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" text="Refresh" onclick="dat_ephl00010_2.Call('SELECT');" /></td>
                            </tr>  
                            <tr>
                                <td colspan="5">
                                    <gw:grid id='grdManParent'
                                        header='_Pk|_Mst_pk|No|_item_pk|Item code|Item Name|Unit|Request Qty|Loss Rate|Loss Qty|Adjust Qty|Total qty|Origin|_OrgPk|Remark'
                                        format='0|0|0|0|0|0|0|1|1|1|1|1|0|0|0'
                                        aligns='0|0|1|1|1|0|0|3|3|3|3|3|0|0|0'
                                        defaults='||||||||||||||'
                                        editcol='1|1|0|1|1|1|1|1|1|0|1|0|0|1|1'
                                        widths='0|0|1200|1200|1200|2500|1500|1500|1200|1200|1200|1200|1600|1200|1200'
                                        sorting='T' oncelldblclick="GridDBClick(this)" onafteredit="OnChangeGrid()"
                                        styles='width:100%; height:357'
                                    />
                                </td>
                            </tr>
                         </table>
                </td>
                </tr>
            </table>
        </td>
    </tr>
   </table>
   <gw:textbox id="txtCusPK"  text=""  styles='display:none;' />
   <gw:textbox id="txtMasterPK"  text=""  styles='display:none;' />
    <gw:textbox id="txtStatusNum"  text=""  styles='display:none;' />
    <gw:textbox id="txtDeptPK" text=""  styles='display:none;' />
    <gw:textbox id="txtStatus"  text="1"  styles='display:none;' />
    <gw:textbox id="txtdtlmPK"  text=""  styles='display:none;' />
    <gw:textbox id="txtdtlmRow"  text=""  styles='display:none;' /> 
    <gw:textbox id="txtEmpPK"  text=""  styles='display:none;' />
    <gw:datebox id="dtTmp" lang="1"  style='display:none;'  onchange=""/>
    <gw:textbox id="txtProductPK" styles='display:none;'/>
    <gw:textbox id="txtstatus11" styles='display:none;'/>
</body>
</html>
