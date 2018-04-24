<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<head id="Head1">
    <title>Purchase Request Registration</title>
</head>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var  dept_pk  = "<%=Session("DEPT_PK")%>" ; 
var  dept_id  = "<%=Session("DEPT_CODE")%>" ; 
var  dept_nm  = "<%=Session("DEPT_NAME")%>" ; 
var flag ='';


var G1_pk               = 0,
    G1_status           = 1,    
    G1_item_code        = 2,
    G1_item_name        = 3,
    G1_req_qty          = 4,
    G1_po_qty           = 5,
    G1_unit_price       = 6,
    G1_amount           = 7,
    G1_spec             = 8,
    G1_req_uom          = 9,
    G1_tco_partner_pk   = 10,
    G1_partner_id       = 11,
    G1_partner_name     = 12,
    G1_payment_term     = 13,
    G1_entreqdate       = 14,
    G1_po_date          = 15,
    G1_req_date         = 16
    G1_tco_item_pk      = 17,
    G1_mr_no            = 18,
    G1_caqty            = 19,
    G1_cansayu          = 20,
    G1_pookno           = 21;
 //---------------------------------------------------------

 function BodyInit()
 {
    txtDeptCode.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtPurDeptCode.SetEnable(false);
    txtPurDeptName.SetEnable(false);
    txtMatlID.SetEnable(false);
    txtMatlName.SetEnable(false);
    txtPartnerCode.SetEnable(false);
    txtPartnerName.SetEnable(false);
    BindingDataList()
    dtReqDTFr.SetDataText(System.AddDate(dtReqDTTo.GetData(),-7));
 }
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'ReqDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx?dept_condition=5";//Long Thanh
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPk.text  = object[0]; 
               txtDeptCode.text  = object[1]; 
            }
        break;
        case 'PurDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx?dept_condition=50102000";//purchase section
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtPurDeptName.text = object[2]; 
               txtPurDeptPk.text  = object[0]; 
               txtPurDeptCode.text  = object[1]; 
            }
        break;
        case 'Matl':
               var path = System.RootURL + '/form/sh/ab/shab00160.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtMatlPk.text= obj[0];
                    txtMatlID.text = obj[1];
                    txtMatlName.text = obj[2];
               }	
        break;  
        case 'Partner':
           var path = System.RootURL + '/form/fp/ab/fpab00120.aspx';
           var obj = System.OpenModal( path ,900 , 550,  'resizable:yes;status:yes');
           if(obj !=null)
           {
                txtPartnerPk.text = obj[0];
                txtPartnerCode.text = obj[1];
                txtPartnerName.text = obj[2];
           }
        break;
    }
}
//---------------------------------------------------------
function BindingDataList()
 {
//    <%=ESysLib.SetGridColumnComboFormat("grdDetail",1,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  order by a.def_yn desc, ord")%>;        
    <%=ESysLib.SetGridColumnComboFormat("grdDetail",13,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGCM0120' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;        
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      
 }
 //---------------------------------------------------------
 function OnSearch()
 {
    data_shmm00030_1.Call('SELECT');
 }
 //---------------------------------------------------------
 function OnSave()
 {
    for(i=1; i<grdDetail.rows; i++)
    {
        if(grdDetail.GetGridData(i, G1_pookno)=='7')
            grdDetail.SetGridText(i, G1_po_date, dtPODate.value);    
    }
    data_shmm00030_1.Call();
 }
 //--------------------------------------------------------
 function OnApprove()
 {
    var control = grdDetail.GetGridControl();
    var v_valid = 1;
    for(i=0; i<control.SelectedRows; i++)
    {
        var row = control.SelectedRow(i);
        if(grdDetail.GetGridData(row,G1_unit_price)=="" || grdDetail.GetGridData(row,G1_tco_partner_pk)=="" ||
             grdDetail.GetGridData(row,G1_entreqdate)=="" || grdDetail.GetGridData(row,G1_po_qty)=="")
             {
                v_valid = 0;
             }else
             {
                grdDetail.SetGridText(row, G1_status,'Released');
                grdDetail.SetGridText(row, G1_pookno,7);
             }
    }
    if(v_valid==0)
    {
        alert("Some items don't have enough information to approve!\n Please check Unit Price, Partner,Delivery date!")
    }
 }
//---------------------------------------------------------
function OnCancelReleased()
{
    var control = grdDetail.GetGridControl();
    for(i=0; i<control.SelectedRows; i++)
    {
            var row = control.SelectedRow(i);
            grdDetail.SetGridText(row, G1_status,'Release Canceled');
            grdDetail.SetGridText(row, G1_pookno,3);
    }
}
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
      case 'data_shmm00030_1':
          for (i=1;i<grdDetail.rows;i++)
          {
              if(grdDetail.GetGridData(i,G1_pookno)!=1)
              {
                grdDetail.SetRowEditable(i,0);
              }
          } 
      break;         
    }
}
//---------------------------------------------------------
function OnAfterEditing()
{
    col = event.col;
    switch(col)
    {
       case G1_po_qty:
           req_qty = grdDetail.GetGridData(grdDetail.row, G1_req_qty);
           po_qty = grdDetail.GetGridData(grdDetail.row, G1_po_qty);
           can_qty = Number(req_qty) - Number(po_qty);
           grdDetail.SetGridText(grdDetail.row, G1_caqty, can_qty);
       break;
    }  
}
//----------------------------------------------------------
function OnPrint()
{
    if(lstStatus.value!=5)
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00030.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shmm00030&parameter=" + dtReqDTFr.value + ',' + dtReqDTTo.value + ',' + txtPartnerPk.GetData()+ ',' + txtDeptPk.GetData()+ ',' + txtPurDeptPk.GetData() ;              
	    System.OpenTargetPage(url);
    }
    
}
//----------------------------------------------------------
function OnGriddblClick()
{
    col = event.col;
    row = event.row;
    
    if(col==G1_payment_term) 
    {
        var fpath = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGCM0120';
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                 
           grdDetail.SetGridText(row, col,    object[1]);
        }
    }
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="prod.sp_sel_shmm00030_1" procedure="prod.sp_upd_shmm00030_1"> 
                <input bind="grdDetail">
                    <input bind="txtPurDeptPk" />  
                    <input bind="dtReqDTFr" />  
                    <input bind="dtReqDTTo" />  
                    <input bind="lstStatus" />  
                    <input bind="txtPartnerPk" />  
                    <input bind="txtDeptPk" />  
                    <input bind="txtMatlPk" />  
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 80%" id="right">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr> 
                                        <td colspan="6">
                                        </td>
                                        <td style="width: 10%" align="right">
                                            <table style="width: 100%; height: 100%">
                                                <tr style="height: 1%">
                                                    <td style="width: 96%; color: Red">
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
                                                    </td>                                                    
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="printer" alt="Purchase Approval" id="btnPrint" onclick="OnPrint()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="width: 10%; white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PurDept')">Purch. Dept.</b>
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:textbox id="txtPurDeptPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtPurDeptCode" styles='width:100%' />
                                        </td>
                                        <td style="width: 30%; white-space: nowrap" colspan="2" nowrap>
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 99%">
                                                        <gw:textbox id="txtPurDeptName" styles='width:100%' />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="txtPurDeptPk.text='';txtPurDeptCode.text='';txtPurDeptName.text='';" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="right" style="width: 12%">
                                            Req. Period
                                        </td>
                                        <td style="width: 18%" colspan="2">
                                            <gw:datebox id="dtReqDTFr" lang="1" styles='width:50%' />
                                            ~
                                            <gw:datebox id="dtReqDTTo" lang="1" styles='width:50%' />
                                        </td>
                                        
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            Release Dt
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:datebox id="dtPODate" lang="1" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 10%">
                                            Status
                                        </td>
                                        <td style="width: 20%">
                                            <gw:list id="lstStatus" styles='width:85%' onchange="OnSearch();">
                                            <data>
											    <%=ESysLib.SetListDataSQL("select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord ")%>||
										    </data>
										</gw:list>
                                        </td>
                                        <td style="width: 10%" align="right" style="white-space: nowrap">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Partner')">Partner Code</b>
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:textbox id="txtPartnerPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtPartnerCode" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 30%">
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 99%">
                                                        <gw:textbox id="txtPartnerName" styles='width:100%' />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn img="reset" alt="Reset" id="btnReset1" onclick="txtPartnerPk.text='';txtPartnerCode.text='';txtPartnerName.text='';" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqDept')">Req. Dept.</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtDeptPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtDeptCode" styles='width:100%' />
                                        </td>
                                        <td align="right" colspan="2">
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 99%">
                                                        <gw:textbox id="txtDeptName" styles='width:100%' />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="txtDeptPk.text='';txtDeptCode.text='';txtDeptName.text='';" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="right" style="white-space: nowrap; color: Red">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Matl')">Matl Code</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtMatlPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtMatlID" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="width: 99%">
                                                        <gw:textbox id="txtMatlName" styles='width:100%' />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="txtMatlPk.text='';txtMatlID.text='';txtMatlName.text='';" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right" colspan="5">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%; color: Red">
                                    </td>
                                    <td style="width: 1%" align="right">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon img="3" text="Approval" id="btnApp" onclick="OnApprove()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="btnCancelRelease" img="3" text="Cancel Released" onclick="OnCancelReleased()" styles='width:100' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="5">
                            <%--<gw:grid id='grdDetail' header='_PK|Status|Item Code|Item Name|Req. Qty|P/O Qty|U/Price|Amount|Spec|Unit|_TCO_PARTNER_PK|Partner ID|Partner Name|Payment Term|Deli. DT|MR App DT|Req Date|_TCO_ITEM_PK|_MR_NO|Cancel Qty|Cancel Reason'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|4|0|0|0|0' aligns='0|0|0|3|3|3|3|0|1|3|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||||||||' editcol='0|0|0|0|1|1|0|0|0|1|0|0|0|1|1|1|1|0|0|1|1'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' acceptnulldate='T' styles='width:100%; height:100%'
                                oncelldblclick="OnGriddblClick()" onafteredit="OnAfterEditing()" />--%>
                            <gw:grid id='grdDetail' header='_PK|Status|Item Code|Item Name|Req. Qty|P/O Qty|U/Price|Amount|Spec|Unit|_TCO_PARTNER_PK|Partner ID|Partner Name|Payment Term|Deli. DT|Release Date|Req Date|_TCO_ITEM_PK|_MR_NO|Cancel Qty|Cancel Reason|_pookno'
                                format='0|2|0|0|-2|-2|-2|-2|0|0|0|0|0|2|4|4|4|0|0|-2|0|0' aligns='0|0|0|0|3|3|3|3|1|0|0|0|0|3|0|0|0|0|0|0|0|0'
                                check='|||||On||||||||||||||||' editcol='0|0|0|0|1|1|1|0|0|0|0|0|0|1|0|0|0|1|1|1|1|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' oncelldblclick="OnGriddblClick()"
                                onafteredit="OnAfterEditing()" acceptnulldate='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
</html> 