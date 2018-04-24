<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Billing</title>
</head>
 <%ESysLib.SetUser("comm");%>
 
 <script language="javascript" type="text/javascript">
    var flag;
    flag='select';
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        
        var ldate;
        txtMasterPK.text="<%=Request.QueryString["tie_bl_mst"] %>";
        BindingDataList();
        SetGridFormat();
        <%=ESysLib.SetGridColumnComboFormat("grdBillingDetail", 4, "select a.CODE,  a.CODE_NM from comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='PRAB0240' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
        <%=ESysLib.SetGridColumnComboFormat("grdBillingDetail", 10, "select  UOM_CODE, UOM_CODE || '-' || UOM_NM from comm.TCO_UOM where del_if=0 and DIMENSION_TYPE = 'WET' order by UOM_CODE")%>; 
        <%=ESysLib.SetGridColumnComboFormat("grdBillingDetail", 12, "select  UOM_CODE, UOM_CODE || '-' || UOM_NM from comm.TCO_UOM where del_if=0  order by UOM_CODE")%>; 
        
        if(txtMasterPK.text!='')
            dat_epgd00010_Billing_1.Call('SELECT');
        else
        {
            btnSave.SetEnable(false);
            dat_epgd00010_Billing_1.StatusInsert();     
            onValueChange(1);
             onValueChange(2);
             onValueChange(3);
             onValueChange(4);     
        }
    }
    //-----------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("select country_cd2, country_nm from imex.tie_country where del_if=0")%>";  //country
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT INITCAP(comm.F_COMMONCODE('IEAB0010','','')) FROM DUAL")%>";  //trade term
         var data2 = "<%=ESysLib.SetListDataSQL("select PORT_CD, PORT_NM from  imex.TIE_PORT  where del_if=0")%>";  //port
         
         cboImpGate.SetDataText(data2); 
         cboExpGate.SetDataText(data2); 
         cboTrans.SetDataText(data1);      
         cboExport.SetDataText(data1);  
         cboTradeTerm.SetDataText(data3);    
             
     }
     //----------------------------------------------------------------------------------
     function openPopup(index)
     {
        var fpath = '';
	    switch(index)
	    {	        	         
           case 0:// Carrier
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {           
	                txtCarrierName.SetDataText(aValue[2]); 
	                txtCarrierCode.SetDataText(aValue[1]);  
	                txtCarrierPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 1:// Consignee
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {              
	                txtConsName.SetDataText(aValue[2]); 
	                txtConsCode.SetDataText(aValue[1]);  
	                txtConsPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 2:// Notify Party
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {                
	                txtNotifyName.SetDataText(aValue[2]); 
	                txtNotifyCode.SetDataText(aValue[1]);  
	                txtNotifyPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 3:// Ship
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {                  
	                txtShipperName.SetDataText(aValue[2]); 
	                txtShipperCode.SetDataText(aValue[1]);  
	                txtShipperPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 4:        
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtLoadName.SetDataText(aValue[3]); 
	                txtLoadCode.SetDataText(aValue[2]);  
	            }	
	        break;       
	        case 5: 
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtDiscName.SetDataText(aValue[3]); 
	                txtDiscCode.SetDataText(aValue[2]);  
	            }	
	        break;
	    }
     }
     //----------------------------------------------------------------------------------
     function onClose()
     {
        var arr_data = new Array();
        arr_data[0]=txtMasterPK.text;
        arr_data[1]=txtBLNo.text; 
        arr_data[2]=dtBLDate.value;
        window.returnValue =  arr_data;
	    window.close();
     }
     //----------------------------------------------------------------------------------
     function onSave(index)
     {
        switch(index)
        {
            case 0:
                flag='save';
                dat_epgd00010_Billing_1.Call('');
            break;
            case 1:
                for(var i=1; i<grdBillingDetail.rows;i++)
                    if(grdBillingDetail.GetGridData(i,1)=='')
                        grdBillingDetail.SetGridText(i,2,txtMasterPK.text);
                dat_epgd00010_Billing_2.Call('');
            break;
        }
     }
     //----------------------------------------------------------------------------------
     function OnDataReceive(obj)
     {
        switch(obj.id)
        {
            case 'dat_epgd00010_Billing_1':
                if(txtMasterPK.text!='')
                    btnSave.SetEnable(true);
                else
                {
                    btnSave.SetEnable(false);
                }
                
                if (flag=='select')
                    dat_epgd00010_Billing_2.Call('SELECT');
                else
                    onSave(1);
            break;        
        }
     }
     //---------------------------------------------------------------------------------
     function onNew(index)
     {
        switch(index)
        {
            case 1:
                grdBillingDetail.AddRow();
                grdBillingDetail.SetGridText(grdBillingDetail.rows-1,0,grdBillingDetail.rows-1);
            break;
        }
     }
     //--------------------------------------------------------------------------------
     function onDelete(index)
     {
        switch(index)
        {
            case 1:
                if(confirm("Do you want to delete this item"))
                {
                    grdBillingDetail.DeleteRow();
                    dat_epgd00010_Billing_2.Call('');
                }                    
            break;
        }
     }
     //--------------------------------------------------------------------------------
     function onValueChange(index)
     {
        switch(index)
        {          
            case 1:
                txtTrans.text = cboTrans.value;
            break;
            case 2:
                txtExport.text = cboExport.value;
            break;
            case 3:
                txtImpGate.text = cboImpGate.value; 
            break;
            case 4:
                txtExpGate.text = cboExpGate.value;
            break;
        }
     }
     //---------------------------------------------------------------------------------------------------
     function SetGridFormat()
     {
        var ctr = grdBillingDetail.GetGridControl(); 
        ctr.ColFormat(7) = "#,###,###,###,###,###.##";
        ctr.ColFormat(8) = "#,###,###,###,###,###.##";
        ctr.ColFormat(9) = "#,###,###,###,###,###.##";
        ctr.ColFormat(10) = "#,###,###,###,###,###.##";
     }

 </script>
<body >
    <!------------------------------------------------------------------>
<gw:data id="dat_epgd00010_Billing_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,33" function="imex.sp_sel_tie_bl_mst"  procedure="IMEX.SP_UPD_TIE_BL_MST"> 
            <inout> 
                 <inout  bind="txtMasterPK" />
                 <inout  bind="txtBLNo" /> 
                 <inout  bind="txtVesselNo" />
                 <inout  bind="txtCarrierPK" /> 
                 <inout  bind="dtBLDate" />
                 <inout  bind="dtArrivalDate" />                 
                 <inout  bind="txtVesselName" />
                 <inout  bind="cboTrans" />
                 <inout  bind="cboExport" />
                 <inout  bind="txtConsPK" />
                 <inout  bind="chkHangRoi" />
                 <inout  bind="cboImpGate" />
                 <inout  bind="cboExpGate" />
                 <inout  bind="txtNotifyPK" />
                 <inout  bind="cboTradeTerm" />  
                 <inout  bind="txtLocation" />                 
                 <inout  bind="txtDiscCode" /> 
                 <inout  bind="txtLoadCode" />
                 <inout  bind="txtDiscName" />             
                 <inout  bind="txtLoadName" />
                 <inout  bind="txtShipperPK" />
                 <inout  bind="txtCarrierCode" />   
                 <inout  bind="txtCarrierName" />
                 <inout  bind="txtConsCode" />  
                 <inout  bind="txtConsName" />  
                 <inout  bind="txtNotifyCode" />
                 <inout  bind="txtNotifyName" />
                 <inout  bind="txtShipperCode" />  
                 <inout  bind="txtShipperName" />
                 <inout  bind="txtImpGate" />  
                 <inout  bind="txtExpGate" />
                 <inout  bind="txtTrans" />
                 <inout  bind="txtExport" />
                 <inout  bind="txtMark" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
    <gw:data id="dat_epgd00010_Billing_2"  onreceive="" > 
            <xml> 
                <dso id="1" type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12" function="imex.sp_sel_tie_bl_dtl"  procedure="imex.sp_upd_tie_bl_dtl" > 
                    <input bind="grdBillingDetail">                    
                        <input bind="txtMasterPK" /> 
                    </input> 
                    <output bind="grdBillingDetail" /> 
                </dso> 
            </xml> 
    </gw:data> 
<!------------------------------------------------------------------>
    <form id="form1" runat="server" >
    <div>
        <table cellpadding=0 cellspacing=0 border=0 width="100%">
            <tr>
                <td width="97%"></td>
                <td width="1%"><gw:imgBtn img="save" alt="Save" id="btnUpdate" onclick="onSave(0)" /></td>								
		        <td width="2%"><gw:icon img="in"  text="Close" alt="Update" id="btnClose" onclick="onClose()" /></td>
            </tr>
            <tr>
                <td colspan="3">
                    <fieldset style="padding: 5">
                        <legend ><font color="red"  >&nbsp;&nbsp;&nbsp;General Infomation</font></legend>
                            <table width="100%" cellpadding=0 cellspacing=0>
                                <tr>
                                    <td>
                                        <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                            <tr> 
                                                <td width="15%">BL/HAWB No.</td>
                                                <td width="30%"><gw:textbox id="txtBLNo"   styles="width:100%;" /></td>
                                                <td width="18%">&nbsp;&nbsp;&nbsp;&nbsp;BL/HAWB Date</td>
                                                <td width="13%"><gw:datebox id="dtBLDate" lang="1" width="10%" csstype="filter"/></td>
                                                <td width="12%">&nbsp;&nbsp;&nbsp;&nbsp;Arrival Date</td>
                                                <td width="13%"><gw:datebox id="dtArrivalDate" lang="1" width="10%" csstype="filter"/></td>
                                            </tr>
                                            <tr>
                                                <td>Vessel/ Flight No.</td>
                                                <td ><gw:textbox id="txtVesselNo"   styles="width:100%;" /></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;Vessel/ Flight Name</td>
                                                <td ><gw:textbox id="txtVesselName"   styles="width:100%;" /></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;Hang roi</td>
                                                <td ><gw:checkbox id="chkHangRoi" onchange="" defaultvalue="Y|N" value="N"/></td>
                                            </tr>
                                            <tr>
                                                <td><a title="Click here to select Carrier" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Carrier Code</b></a></td>
                                                <td ><gw:textbox id="txtCarrierCode"   styles="width:100%;" /><gw:textbox id="txtCarrierPK"   styles="display:none" /></td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;Carrier Name</td>
                                                <td  colspan="3"><gw:textbox id="txtCarrierName"   styles="width:100%;" /></td>
                                            </tr> 
                                        </table>
                                    </td>
                                </tr> 
                                <tr>
                                    <td>
                                        <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                            <tr>  
                                                <td width="17%">Transport Nationality</td>
                                                <td width="12%"><gw:textbox id="txtTrans"   styles="width:100%;" /></td>
                                                <td width="23%"><gw:list id="cboTrans" onchange="onValueChange(1);" styles="width:100%;"></gw:list></td>
                                                <td width="15%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Export Country</td>
                                                <td width="12%"><gw:textbox id="txtExport"   styles="width:100%;" /></td>
                                                <td width="23%"><gw:list id="cboExport"  onchange="onValueChange(2);" styles="width:100%;"></gw:list></td>
                                            </tr>                            
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                            <tr>
                                                <td width="15%">Marks</td>
                                                <td width="85%"><gw:textbox id="txtMark" styles="width:100%;" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan=3>
                                        <table width="100%" cellpadding=0 cellspacing=0>
                                            <tr> 
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><a title="Click here to select Consignee" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Consignee</b></a></legend>
                                                        <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                            <tr> 
                                                                <td>Code</td>
                                                                <td width=30%><gw:textbox id="txtConsCode"   styles="width:100%;" /><gw:textbox id="txtConsPK"   styles="width:100%;" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtConsName"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><a title="Click here to select Shipper" onclick="openPopup(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Shipper</b></a></legend>
                                                        <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                            <tr> 
                                                                <td>Code</td>  
                                                                <td width=30%><gw:textbox id="txtShipperCode"   styles="width:100%;" /><gw:textbox id="txtShipperPK"   styles="width:100%;" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtShipperName"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                        <tr>
                                                            <td>Import Gate</td>
                                                            <td></td>
                                                        </tr> 
                                                        <tr>
                                                            <td width="15%"><gw:textbox id="txtImpGate"   styles="width:100%;" /></td>
                                                            <td width="35%"><gw:list id="cboImpGate" onchange="onValueChange(3);" styles="width:100%;"></gw:list></td>    
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td> 
                                                    <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                        <tr>
                                                            <td>Export Gate</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="15%"><gw:textbox id="txtExpGate"   styles="width:100%;" /></td>
                                                            <td width=35%><gw:list id="cboExpGate" onchange="onValueChange(4);" styles="width:100%;"></gw:list></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr> 
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><a title="Click here to select Notify Party" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Notify Party</b></a></legend>
                                                        <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                            <tr> 
                                                                <td>Code</td> 
                                                                <td width=30%><gw:textbox id="txtNotifyCode"   styles="width:100%;" /><gw:textbox id="txtNotifyPK"   styles="display:none" /></td>
                                                            </tr> 
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtNotifyName"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><font color="black"  >&nbsp;&nbsp;&nbsp;</font></legend>
                                                        <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                            <tr> 
                                                                <td>Trade Terms</td>
                                                                <td width=30%><gw:list id="cboTradeTerm" styles="width:100%;"></gw:list></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtLocation"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><font color="black"  >&nbsp;&nbsp;&nbsp;<a title="Click here to select Shipper" onclick="openPopup(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Place of Discharge</b></a></font></legend>
                                                        <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                                            <tr> 
                                                                <td>Code</td>
                                                                <td width=30%><gw:textbox id="txtDiscCode"   styles="width:100%;" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtDiscName"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                                <td>
                                                    <fieldset style="padding: 5">
                                                        <legend ><font color="black"  ><a title="Click here to select Shipper" onclick="openPopup(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Place of Loading</b></a></font></legend>
                                                        <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                                            <tr> 
                                                                <td>Code</td>
                                                                <td width=30%><gw:textbox id="txtLoadCode"   styles="width:100%;" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td width=70%><gw:textbox id="txtLoadName"   styles="width:100%;" /></td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>                                                
                                            </tr>
                                        </table>
                                    </td>
                                </tr>                             
                            </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <fieldset style="padding: 5">
                        <legend ><font color="black"  >&nbsp;&nbsp;&nbsp;Place of Discharge</font></legend>
                        <table width=100% cellpadding=0 cellspacing=1 border=0 >
                            <tr> 
                                <td width="95%"></td>
                                <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="onDelete(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" text="Refresh" onclick="dat_epgd00010_Billing_2.Call('SELECT');" /></td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <gw:grid id='grdBillingDetail'
                                        header='No|_PK|_TIE_BL_MST_PK|Container|Container Type|Seal No|Status|Qty|N/Weight|G/Weight|U/Weight|Measurement|U/MET'
                                        format='0|0|0|0|2|0|3|0|0|0|0|0|0'
                                        aligns='0|0|0|0|0|0|0|3|3|3|0|3|0'
                                        defaults='||||||||||KG||CBM'
                                        editcol='0|0|0|1|1|1|1|1|1|1|1|1|1'
                                        widths='600|0|0|1900|1600|2000|850|1000|1000|1000|1000|2000|1000'
                                        sorting='T'
                                        styles='width:100%; height:260'
                                    />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
<gw:textbox id="txtMasterPK"   styles="display:none" />
</html>
