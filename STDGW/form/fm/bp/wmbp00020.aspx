
<%@ Page Language="C#" %> 

<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("comm");%>
 
<script language="javascript" type="text/javascript">
     function BodyInit()
     {
        onNew(0);
        var s_name;
        s_name="<%=Session["NAME"]%>";
        txtPOStaff.SetDataText(s_name);
        txtStaffPK.SetDataText("<%=Session["EMPLOYEE_PK"]%>");
        BindingDataList();  
        
     }
     
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, org_nm FROM TCO_ORGANIZATION where del_if=0")%>";   
         var data2 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0020','','') FROM DUAL")%>";  //payment term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COCI0150','','') FROM DUAL")%>";  //tradding 
         var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('PRCP0020','','') FROM DUAL")%>";  //status
        
         cboOrganization.SetDataText(data1);         
         cboCurrency.SetDataText(data2);
         cboPaymentTerms.SetDataText(data3); 
         cboTrading.SetDataText(data4);  
         cboFormOfPayment.SetDataText(data3);   
         cboIntercoms.SetDataText(data2); 
         cboStatus.SetDataText(data5);
     }
     
     function OnToggle()
     {
        var left  = document.all("left");    
        var right = document.all("right");   
        var imgArrow = document.all("imgArrow");   
        
        if(imgArrow.status == "expand"){
            left.style.display="none";
            imgArrow.status = "collapse";
            right.style.width="100%";
            imgArrow.src = "../../../images/right-arrow.ico";
        }
        else{
            left.style.display="";
            imgArrow.status = "expand";
            right.style.width="80%";
            imgArrow.src = "../../../images/left-arrow.ico";
        }
     }
  //-------------------------------------------------------------------->
    function OnResize()
    {    
         var offsetLeftTable  = document.all("tableID1").offsetLeft;    
         var offsetLeftCell   = document.all("left").offsetLeft;    
         var leftDistant = (document.all("left").clientWidth + offsetLeftTable + offsetLeftCell);	
         var n = Math.abs(window.event.clientX - leftDistant);	
         
         if(n<15){		
            document.body.style.cursor = "col-resize" ;	
         }
         else{		
            document.body.style.cursor = "auto" ;	
         }		
         
         if((window.event.button == 1)&& n < 30){	
            document.all("left").width = window.event.clientX-(offsetLeftTable + 2*offsetLeftCell);		
            var LeftWidthNew = document.all("left").clientWidth;	
            var delTa = gLeftWidth-LeftWidthNew;
            document.all("right").width = gRightWidth + delTa;	
         }
    }
  //-------------------------------------------------------------------------
  function openPopup(index)
     {
	    var fpath = '';
	    switch(index)
	    {	        
	            
           case 1:// vendor
	            var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
                aValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {      
	                txtVendor.SetDataText(aValue[2]); 
	                txtVendorPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 2:// deliver
	            var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
                aValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {       
	                txtDeliver.SetDataText(aValue[2]); 
	                txtDeliverPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 3:// charger
	            fpath = System.RootURL + '/form/fm/bp/wmbp00020_1.aspx?titlename=Charger&functionname=comm.sp_search_charger&vendor=' + txtVendorPK.text;
	            var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {        
	                txtCharger.SetDataText(aValue[2]); 
	                txtChargerPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 4:// contract
	            var vendor;
	            if (txtDeliverPK.text !='')
	                vendor =txtDeliverPK.text;
	            else 
	                vendor = txtVendorPK.text;
	                
	            fpath = System.RootURL + '/form/fm/bp/wmbp00020_2.aspx?titlename=Charger&functionname=comm.sp_search_contact&vendor=' + vendor;
	            var aValue  = System.OpenModal(  fpath , 650 , 500 , 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {         
	                txtContact.SetDataText(aValue[1]); 
	                txtContactPK.SetDataText(aValue[0]);
	            }	
	        break;
	        case 5:// contract
	            fpath = System.RootURL + '/form/fm/bp/wmbp00020_3.aspx?';
	            var aValue  = System.OpenModal(  fpath , 870 , 550 , 'resizable:yes;status:yes');
	            //var aValue  = window.open(fpath);
	            if ( aValue != null )
	            {         
	                txtContact.SetDataText(aValue[1]); 
	                txtContactPK.SetDataText(aValue[0]);
	            }	
	        break;
	    }
    }
    //--------------------------------------------------------------------------------------------
  function onSearch(index)
  {
       wmbp00020_2.Call();
  }
  
  function onPrint()
  {
  
  }
  
  function onNew(index)
  {
     switch(index)
        {
            case 0: // add new master
                 txtPOPk.SetDataText("-1");
                 wmbp00020_1.StatusInsert();                                  
            break;            
        }
  }
  
  function onSave(index)
  {
      if (index==0)  
        wmbp00020_2.Call();
  }
  
  function onDelete()
  {
  
  }
  
  function onUnDelete()
  {
  
  }
  
  function OnDataReceive(obj)
  {
      switch(obj.id)
        {
            case "wmbp00020_1":
                wmbp00020_2.Call(); 
            break;
         }
            
  }
</script>
<body>
<gw:data id="wmbp00020_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="prod.sp_get_tpr_purord"  procedure="prod.sp_upd_tpr_purord"> 
            <inout> 
                 <inout  bind="txtPOPk" />
                 <inout  bind="cboOrganization" />
                 <inout  bind="dtPODate" />
                 <inout  bind="txtPONo" />
                 <inout  bind="txtVendorPK" />
                 <inout  bind="txtDeliverPK" />                 
                 <inout  bind="cboStatus" />
                 <inout  bind="cboTrading" />
                 <inout  bind="cboFormOfPayment" />
                 <inout  bind="cboPaymentTerms" />
                 <inout  bind="txtStaffPK" />
                 <inout  bind="cboIntercoms" />
                 <inout  bind="txtInterDesc" />
                 <inout  bind="cboCurrency" />
                 <inout  bind="txtChargerPK" />
                 <inout  bind="txtContactPK" />                 
                 <inout  bind="txtAmount" />
                 <inout  bind="txtTotalAmount" />
                 <inout  bind="txtDesc" />            
                 <inout  bind="txtPOStaff" />
                 <inout  bind="txtVendor" />
                 <inout  bind="txtDeliver" />                 
                 <inout  bind="txtCharger" />
                 <inout  bind="txtContact" />
            </inout>
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------>
<gw:data id="wmbp00020_2"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="prod.sp_sel_tpr_purord" > 
                <input> 
                    <input bind="txtPONoSearch" /> 
                    <input bind="dtPOFrom" /> 
                    <input bind="dtPOTo" /> 
                </input> 
                <output bind="grdPOs" /> 
            </dso> 
        </xml> 
</gw:data> 
<!------------------------------------------------------------------>
<!-------------------------------------------------------------------->
<table width="100%" border="1" id="tableID1" cellspacing=0 cellpadding=0  >
    <tr valign=top >
        <td id="left" width="20%" onmousemove="OnResize()">
            <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="1">
                <tr >
                    <td width="10%">&nbsp;PO No.</td>
                    <td width="40%" colspan=3><gw:textbox id="txtPONoSearch" csstype="filter" styles="width:100%;" /></td>                    
                    <td width="3%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch(0)" /></td>
                </tr>
                <tr >
                    <td width="10%">&nbsp;PO Date</td>
                    <td width="10%"><gw:datebox id="dtPOFrom" lang="1" width="10%" csstype="filter"/></td>
                    <td width="2%">&nbsp;~&nbsp;</td>
                    <td width="10%" colspan=2><gw:datebox id="dtPOTo" lang="1" width="10%" csstype="filter"/></td>
                </tr>
                <tr>
                    <td colspan=5>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td width="100%">
                                   <gw:grid   
                                    id="grdPOs"  
                                    header="_PK|PO No|PO Date"   
                                    format="0|0|0"  
                                    aligns="0|0|0"  
                                    defaults="||"   
                                    editcol="1|1|1"  
	                                widths="0|0|1200"  
                                    styles="width:100%; height:383"   
                                    sorting="T"   
                                    param="0,1,2"  oncellclick="loadBSDetail1()" /> 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td id="right" width="80%" onmousemove="OnResize()">
            <table width=100% border=0  cellpadding=0  cellspacing=0  >
                <tr>
                    <td >&nbsp;&nbsp;Organization</td>
                    <td colspan="3"><gw:list id="cboOrganization" styles="width:100%;"></gw:list></td>
                    <td width=10% align=right>PO staff&nbsp;&nbsp;</td>
                    <td ><gw:textbox id="txtPOStaff" styles="width:100%;" csstype="filter"  /> <gw:textbox id="txtStaffPK" styles="display:none;" /></td>
                    <td >&nbsp;</td>
                    <td width=7% align=right ><gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="onPrint(0)" /></td>
                    <td width=2%><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" /></td>
                    <td width=2%><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                    <td width=2%><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                </tr>
                <tr>
                    <td colspan=11 >&nbsp;</td>
                </tr>
                <tr>   
                    <td width="12%">&nbsp;&nbsp;PO No.&nbsp;&nbsp;</td>
                    <td width="15%"><gw:textbox id="txtPONo"  csstype="mandatory" styles="width:100%;" /></td>
                    <td width="10%" align=right>&nbsp;&nbsp;PO Date&nbsp;&nbsp;</td>
                    <td width="8%"><gw:datebox id="dtPODate" lang="1" /></td>
                    <td width="8%" align=right>Trading&nbsp;&nbsp;</td>
                    <td width="15%"><gw:list id="cboTrading" styles="width:100%;" ></gw:list></td>                            
                    <td width="12%" align=right>Status&nbsp;&nbsp;</td>
                    <td width="20%" colspan=4><gw:list id="cboStatus" styles="width:100%;" ></gw:list></td>               
                </tr>
                <tr>
                    <td ><a title="Click here to select Vendor" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;Vendor&nbsp;&nbsp;</b></a></td>
                    <td  colspan=2><gw:textbox id="txtVendor" styles="width:100%;" /><gw:textbox id="txtVendorPK" styles="display=none" /></td>                           
                    <td  align=right><a title="Click here to select Deliver" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Deliver&nbsp;&nbsp;</b></a></td>
                    <td  colspan=2><gw:textbox id="txtDeliver" styles="width:100%;" /><gw:textbox id="txtDeliverPK" styles="display:none;" /></td>
                    <td align=right>Form of payment&nbsp;&nbsp;</td> 
                    <td  colspan=4><gw:list id="cboFormOfPayment" styles="width:100%;" ></gw:list></td>
                </tr>
                <tr>
                    <td ><a title="Click here to select Charger" onclick="openPopup(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;Charger&nbsp;&nbsp;</b></a></td>
                    <td  colspan=2><gw:textbox id="txtCharger" styles="width:100%;" /><gw:textbox id="txtChargerPK" styles="display:none" /></td>                            
                    <td align=right><a title="Click here to select Contact" onclick="openPopup(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Contact&nbsp;&nbsp;</b></a></td>
                    <td colspan=2><gw:textbox id="txtContact" styles="width:100%;" /><gw:textbox id="txtContactPK" styles="display:none" /></td>                            
                    <td align=right>&nbsp;&nbsp;Payment terms&nbsp;&nbsp;</td> 
                    <td  colspan=4><gw:list id="cboPaymentTerms" styles="width:100%;" ></gw:list></td>
                </tr>
                <tr>
                    <td  rowspan=2>&nbsp;&nbsp;Description&nbsp;&nbsp;</td>
                    <td  rowspan=2 colspan=5><gw:textarea id="txtDesc" styles="width:100%;" /></td>
                    <td align=right>&nbsp;&nbsp;Currency&nbsp;&nbsp;</td>
                    <td colspan=4><gw:list id="cboCurrency" styles="width:100%;" ></gw:list></td>             
                </tr>
                <tr>                       
                    <td align=right>Amount&nbsp;&nbsp;</td>
                    <td  colspan=4><gw:textbox id="txtAmount" styles="width:100%;" /></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;Intercoms&nbsp;&nbsp;</td>
                    <td colspan=2 ><gw:list id="cboIntercoms" styles="width:100%;" ></gw:list></td>
                    <td ></td>
                    <td ></td>
                    <td ></td>
                    <td align=right>VAT Amount&nbsp;&nbsp;</td>
                    <td  colspan=4><gw:textbox id="txtVATAmount" styles="width:100%;" /></td>
                </tr>
                <tr>
                    <td rowspan=2>&nbsp;&nbsp;Intercoms Desc.</td>
                    <td rowspan=2 colspan=5><gw:textarea id="txtInterDesc" styles="width:100%;" /></td>   
                    <td align=right>Total Amount&nbsp;&nbsp;</td>
                    <td  colspan=4><gw:textbox id="txtTotalAmount" styles="width:100%;" /></td>
                </tr>
                <tr>                    
                    <td  colspan=3 align=right><legend><font color="black"  ><a title="Click here to select Items from MR Entry " onclick="openPopup(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Get Items</b></a></font></legend></td>
                    <td ><gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                    <td ><gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="onUnDelete(0)" /></td>
                </tr>
                <tr>
                    <td colspan=11>
                        <gw:grid
                            id="grdSTitemSpec"
                            header="pk|No|specgrp_nm|specgrp_lnm|Active|spec_id|spec_name|spec_lnm|tco_cispec_pk|tco_ciSTitem_pk|tco_cispecgrp_pk|_mandatory|_idauto_yn"
                            format="0|0|0|0|3|0|0|0|0|0|0|3|0"
                            aligns="1|0|0|0|0|0|0|0|0|0|0|0|0"
                            defaults="||||||||||||"
                            editcol="0|0|0|1|1|1|1|0|0|0|0|0|0"
                            widths="0|600|1500|1500|800|1500|1500|1500|0|0|0|1000|0"
                            styles="width:100%; height:220"
                            sorting="F"
                            onafteredit="OnGridCellAfterEdit(this)"
                            oncelldblclick="OnGridCellDoubleClick(this)"
                            param="0,1,2,3,4,5,6,7,8,9,10,11,12"  />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
   
</table>   
<img status="expand" id="imgArrow" src="../../../images/left-arrow.ico" style="cursor:hand;position:absolute;left:1;top:0;" onclick="OnToggle()"  /> </body>
<gw:textbox id="txtPOPk" styles="display:none;" />
</html>
