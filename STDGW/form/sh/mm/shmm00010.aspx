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
    G1_tpr_poreq_pk     = 1,
    G1_req_date         = 2,
    G1_seq_no           = 3,
    G1_status           = 4,
    G1_tco_item_pk      = 5,
    G1_item_code        = 6,
    G1_item_name        = 7,
    G1_req_qty          = 8,
    G1_unit_price       = 9,
    G1_amount           = 10,
    G1_avguseqty        = 11,
    G1_rout             = 12,
    G1_rout_nm          = 13,
    G1_tco_partner_pk   = 14,
    G1_partner_id       = 15,
    G1_partner_name     = 16,
    G1_spec             = 17,
    G1_req_uom          = 18,
    G1_reqgu            = 19,
    G1_reqnm            = 20,
    G1_entreqdate       = 21,
    G1_ledger           = 22,
    G1_legname          = 23,
    G1_reqsayu          = 24;
 //---------------------------------------------------------

 function BodyInit()
 {
    txtEmpID.SetEnable(false);
    txtEmpName.SetEnable(false);
    txtAppID.SetEnable(false);
    txtAppName.SetEnable(false);
    txtDeptCode.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtPurDeptCode.SetEnable(false);
    txtPurDeptName.SetEnable(false);
    txtPartnerPk.SetEnable(false);
    txtPartnerID.SetEnable(false);
    txtPartnerName.SetEnable(false);
    txtSeq.SetEnable(false);
    BindingDataList();
    OnAddNew('Master');
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));

    txtPurDeptPk.text="205";
    txtPurDeptCode.text="50102000";
    txtPurDeptName.text="Purchasing Section";
 }
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'GetPartner':
            var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPk.text   = object[0];
                txtPartnerName.text = object[2]; 
                txtPartnerID.text = object[1];          
	         }
        break;
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
        case 'ReqEmp':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtEmpPk.text   = obj[0];
                    txtEmpID.text   = obj[4];
                    txtEmpName.text = obj[5];
               }	
        break;  
        case 'AppEmp':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtAppPk.text   = obj[0];
                    txtAppID.text   = obj[4];
                    txtAppName.text = obj[5];
               }	
        break;  
        case 'Item':
               var path = System.RootURL + '/form/sh/ab/shab00010.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    for(var i =0 ;i< obj.length;i++)
                    {
                        var value = new Array();
                        value = obj[i];
                        grdDetail.AddRow();
                        grdDetail.SetGridText(grdDetail.rows-1, G1_seq_no,  AddDigit(String(grdDetail.rows-1),3));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_status,  1);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_tco_item_pk,value[0]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_item_code,  value[1]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_item_name,  value[2]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_spec,       value[3]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_req_uom,    value[5]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_tco_partner_pk, value[8]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_partner_id, value[9]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_partner_name, value[10]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_ledger,    value[12]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_legname,   value[13]);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_unit_price,   value[15]);
                    }
               }	
        break;  
        case 'Partner':
           var path = System.RootURL + '/form/ag/ic/agic00010.aspx';
           var obj = System.OpenModal( path ,900 , 550,  'resizable:yes;status:yes');
        break; 
         case 'Matl':
           var path = System.RootURL + '/form/sh/im/shim00020.aspx';
           var obj = System.OpenModal( path ,900 , 550,  'resizable:yes;status:yes');
        break; 
    }
}
//---------------------------------------------------------
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00010.rpt&export_pdf=Y&procedure=prod.sp_rpt_shmm00010_new|prod.sp_rpt_shmm00010_1_new&parameter=" + txtMasterPK.text +"|"+ txtMasterPK.text;                            
	System.OpenTargetPage(url);
}
//---------------------------------------------------------
function BindingDataList()
 {
     <%=ESysLib.SetGridColumnComboFormat("grdDetail",4,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;        
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Master':
            txtEmpPk.text = user_pk;
            txtEmpID.text = user_code;
            txtEmpName.text = user_name;
//            txtDeptPk.text = dept_pk;
//            txtDeptCode.text = dept_id;
//            txtDeptName.text = dept_nm;
//            txtPurDeptPk.text = dept_pk;
//            txtPurDeptCode.text = dept_id;
//            txtPurDeptName.text = dept_nm;
            grdDetail.ClearData();
            btnAddNew1.SetEnable(true)
            btnPrint.SetEnable(true)
            data_shmm00010_1.StatusInsert();
        break;              
        case 'Detail' :
            grdDetail.AddRow();
        break;
      }  
 }
 //---------------------------------------------------------
 function OnDelete(obj)
 {
    switch(obj)
    {
        case 'Master':
            if ( confirm( "Do you want to delete?" ) ) 
            {
                flag = 'delete';
               data_shmm00010_1.StatusDelete();
               data_shmm00010_1.Call();
            }
        break;
        case 'Detail':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdDetail.DeleteRow();
            }
        break;
    }
 }
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            data_shmm00010.Call('SELECT');
        break;
        case'Master':
            flag= 'select';
            if(grdList.row>0)
                txtMasterPK.text = grdList.GetGridData(grdList.row,0);
                txtMasterPK1.text = grdList.GetGridData(grdList.row,0);
            data_shmm00010_1.Call('SELECT');
        break;
    }
 }
 //---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Master' :
            flag= 'save';
            data_shmm00010_1.Call();
        break;
        case 'Detail':
            //if(OnValidateData('Detail'))
            for(i=1;i<grdDetail.rows;i++)
            {
                grdDetail.SetGridText(i,G1_tpr_poreq_pk, txtMasterPK.text);
                grdDetail.SetGridText(i,G1_req_date, dtReqDT.value);
            }
            data_shmm00010_2.Call();
        break;
      }  
 }
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shmm00010_1':
            if(flag=="save")
            {
                OnSave('Detail');
            }
            else
            if(flag=='delete')
            {
                grdDetail.ClearData();
                OnAddNew('Master')
                data_shmm00010.Call('SELECT');
            }
            else
            if(flag=='select')
            {
                data_shmm00010_2.Call('SELECT');
            }
        break;
        case 'data_shmm00010_2': 
            var v_addFlag = 0;
            var v_print = 0;
            for(i=1;i<grdDetail.rows;i++)
            {
                if(grdDetail.GetGridData(i,G1_status)!='1' && grdDetail.GetGridData(i,G1_status)!='3' )
                {
                    grdDetail.SetRowEditable(i,0);
                    v_addFlag = 1;
                    v_print = 1;
                    break
                }
                
            }
            if(v_addFlag ==1)
            {
                btnAddNew1.SetEnable(false)
            }else
            {
                 btnAddNew1.SetEnable(true)
            }
            if(v_print ==1)
            {
                btnPrint.SetEnable(false)
            }else
            {
                 btnPrint.SetEnable(true)
            }
            if(flag=="save")
            {
                data_shmm00010.Call('SELECT');
            }
        break;
        case 'data_shmm00010_3':
            grdDetail.SetGridText(grdDetail.row,G1_legname, txtRtnValue1.text);
        break;
        case 'data_shmm00010_4':
            grdDetail.SetGridText(event.row,G1_partner_name, txtRtnValue1.text);
            grdDetail.SetGridText(event.row,G1_tco_partner_pk, txtRtnValue2.text);
        break;
        
        
        case'data_shmm00010_5':
            if(grdTest.rows<2)
            {
                alert("Not found this code , Please douuble click on Grid to select");
                grdDetail.SetGridText(a,G1_rout_nm, "");
                grdDetail.SetGridText(a,G1_rout, "");
            }
            else
            {
                grdDetail.SetGridText(a,G1_rout_nm, grdTest.GetGridData(1,1));
                grdDetail.SetGridText(a,G1_rout, grdTest.GetGridData(1,0));
            } 
        break;
        case'data_shmm00010_6':
            if(grdTest1.rows<2)
            {
                alert("Not found this code , Please douuble click on Grid to select");
                grdDetail.SetGridText(b,G1_partner_name, "");
                grdDetail.SetGridText(b,G1_tco_partner_pk, "");
                grdDetail.SetGridText(b,G1_partner_id, "");
            }
            else
            {
                grdDetail.SetGridText(b,G1_partner_name, grdTest1.GetGridData(1,1));
                grdDetail.SetGridText(b,G1_tco_partner_pk, grdTest1.GetGridData(1,0));
                grdDetail.SetGridText(b,G1_partner_id, grdTest1.GetGridData(1,2));
            } 
        break;
        case'data_shmm00010_7':
            if(grdTest2.rows<2)
            {
                alert("Not found this code , Please douuble click on Grid to select");
                grdDetail.SetGridText(c,G1_legname,"");
                grdDetail.SetGridText(c,G1_ledger, "");
                
            }
            else
            {
                grdDetail.SetGridText(c,G1_legname, grdTest2.GetGridData(1,1));
                grdDetail.SetGridText(c,G1_ledger, grdTest2.GetGridData(1,2));
            } 
        break;
        case'data_shmm00010_8':
            if(grdTest3.rows<2)
            {
                alert("Not found this code , Please douuble click on Grid to select");
                grdDetail.SetGridText(d,G1_reqnm, "");
                grdDetail.SetGridText(d,G1_reqgu,"");
            }
            else
            {
                grdDetail.SetGridText(d,G1_reqnm, grdTest3.GetGridData(1,1));
                grdDetail.SetGridText(d,G1_reqgu, grdTest3.GetGridData(1,2));
            } 
        break;
    }
}
//----------------------------------------------------------
function OnGriddblClick()
{
    col = event.col;
    row = event.row;
    
    if((col==G1_rout) || (col==G1_rout_nm))
    {
        var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {                  
           grdDetail.SetGridText(row, G1_rout,       object[1]);
           grdDetail.SetGridText(row, G1_rout_nm,    object[3]);
        }
    }
    if((col==G1_reqgu) || (col==G1_reqnm))
    {
        var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0010";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {        
           grdDetail.SetGridText(row, G1_reqgu,    object[1]);
           grdDetail.SetGridText(row, G1_reqnm,    object[3]);
        }
    }
    if((col==G1_partner_id) || (col==G1_partner_name))
    {
        var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {        
           grdDetail.SetGridText(row, G1_tco_partner_pk,object[0]);
           grdDetail.SetGridText(row, G1_partner_id,    object[1]);
           grdDetail.SetGridText(row, G1_partner_name,  object[2]);
        }
    }
    if((col==G1_ledger) || (col==G1_legname))
    {
        var fpath = System.RootURL + "/form/sh/ab/shab00210.aspx?code=61";
        var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
        if (object != null)
        {        
           grdDetail.SetGridText(row, G1_ledger,    object[1]);
           grdDetail.SetGridText(row, G1_legname,   object[2]);
        }
    }
}
//----------------------------------------------------------
var a="";
var b="";
var c="";
var d="";
function OnAfterValueChange(obj)
{   
    switch(obj)
    {
        case 'Detail':
            var col=event.col;
            if((col == G1_req_qty)|| (col == G1_unit_price))
            {
                qty = grdDetail.GetGridData(event.row, G1_req_qty);
                price = grdDetail.GetGridData(event.row, G1_unit_price);
                amount = Number(qty)*Number(price);
                grdDetail.SetGridText(event.row, G1_amount, amount);
            }
            if(col==G1_rout)
            {
                txtPL_Code.text=grdDetail.GetGridData(event.row, G1_rout);
                a=grdDetail.row;
                data_shmm00010_5.Call("SELECT");
            }
            if(col==G1_partner_id)
            {
                txtPartner_ID.text=grdDetail.GetGridData(event.row, G1_partner_id);
                b=grdDetail.row;
                data_shmm00010_6.Call("SELECT");
            } 
            if(col==G1_ledger)
            {
                txtLedger_ID.text=grdDetail.GetGridData(event.row, G1_ledger);
                c=grdDetail.row;
                data_shmm00010_7.Call("SELECT");
            }
            if(col==G1_reqgu)
            {
                txtClass_ID.text=grdDetail.GetGridData(event.row, G1_reqgu);
                d=grdDetail.row;
                data_shmm00010_8.Call("SELECT");
            }          
        break;
        
    }
}
//----------------------------------------------------------
function OnKeyPress(e)
{
    if (e.keyAscii != 13)
        return;
        
    if(event.col == G1_partner_id)
    {
        txtInput.text =grdDetail.GetGridData(event.row, G1_partner_id);
        data_shmm00010_4.Call();
    }
    if(event.col == G1_ledger)
    {
        txtInput.text =grdDetail.GetGridData(event.row, G1_ledger);
        data_shmm00010_3.Call();
    }
}
//----------------------------------------------------------
function AddDigit(value, number)
{
    newstr = value;
    for(i=value.length; i< number; i++)
    {
        newstr = '0' + newstr;
    }
    return newstr;
}
//----------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00010"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shmm00010" > 
                <input> 
                    <input bind="txtMRNo" /> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" /> 
                    <input bind="txtPartner" />
                </input> 
                <output bind="grdList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="prod.sp_sel_shmm00010_1"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" procedure="prod.sp_upd_shmm00010_1"> 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstMachineNo" />
                     <inout  bind="dtReqDT" />
                     <inout  bind="txtSeq" />
                     <inout  bind="txtDeptPk" />
                     <inout  bind="txtDeptCode" />
                     <inout  bind="txtDeptName" />
                     <inout  bind="txtPurDeptPk" />
                     <inout  bind="txtPurDeptCode" />
                     <inout  bind="txtPurDeptName" />
                     <inout  bind="txtEmpPk" />
                     <inout  bind="txtEmpID" />
                     <inout  bind="txtEmpName" />
                     <inout  bind="txtAppPk" />
                     <inout  bind="txtAppID" />
                     <inout  bind="txtAppName" />
                     <inout  bind="dtSignDt" />
                     <inout  bind="txtPartnerPk" />
                     <inout  bind="txtPartnerID" />
                     <inout  bind="txtPartnerName" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24" function="prod.sp_sel_shmm00010_2" procedure="prod.sp_upd_shmm00010_2"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shmm00010_3" > 
                <input>
                    <input bind="txtInput" />
                </input> 
                <output>
                    <output bind="txtRtnValue1" />
                    <output bind="txtRtnValue2" />
                </output>
            </dso> 
        </xml>      
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shmm00010_4" > 
                <input>
                    <input bind="txtInput" />
                </input> 
                <output>
                    <output bind="txtRtnValue1" />
                    <output bind="txtRtnValue2" />
                </output>
            </dso> 
        </xml>      
    </gw:data>
    <gw:data id="data_shmm00010_5" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod"  function="prod.sp_sel_shmm00010_3" > 
                <input bind="grdTest">
                    <input bind="txtPL_Code" />               
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_6" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="5" type="grid" user="prod"  function="prod.sp_sel_shmm00010_4" > 
                <input bind="grdTest1">
                    <input bind="txtPartner_ID" />               
                </input> 
                <output bind="grdTest1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_7" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="6" type="grid" user="prod"  function="prod.sp_sel_shmm00010_5" > 
                <input bind="grdTest2">
                    <input bind="txtLedger_ID" />               
                </input> 
                <output bind="grdTest2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shmm00010_8" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="7" type="grid" user="prod"  function="prod.sp_sel_shmm00010_6" > 
                <input bind="grdTest3">
                    <input bind="txtClass_ID" />               
                </input> 
                <output bind="grdTest3" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 20" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>Seq</b>
                        </td>
                        <td style="width: 69%" align="right">
                            <gw:textbox id="txtMRNo" styles='width:100%' onenterkey="OnSearch('List')" />
                        </td>
                        <td style="width: 1%; white-space: nowrap" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>Partner</b>
                        </td>
                        <td style="width: 69%" align="right">
                            <gw:textbox id="txtPartner" styles='width:100%' onenterkey="OnSearch('List')" />
                        </td>
                        
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <b>Date</b>
                        </td>
                        <td colspan="2">
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdList' header='_pk|Date|Seq|Partner |Req Dept' format='0|4|0|0|0' aligns='0|0|0|0|0' defaults='||||'
                                editcol='0|0|0|0|0' widths='0|2000|500|1000|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 80%" id="right">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 1%">
                                        <td style="width: 10%; white-space: nowrap" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 10%" align="right" colspan="2">
                                            <gw:list id="lstMachineNo" styles='width:100%'>
                                            <data>
											    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>||
										    </data>
										</gw:list>
                                        </td>
                                        <td align="right" style="width: 12%">
                                            Req. No.
                                        </td>
                                        <td colspan="2">
                                            <gw:datebox id="dtReqDT" lang="<%=Session("Lang")%>" styles='width:100%' />
                                            &nbsp;
                                            <gw:textbox id="txtSeq" styles='width:40; color:red' />
                                        </td>
                                        <td style="width: 13%">
                                            <table style="width: 100%; height: 100%">
                                                <tr style="height: 1%">
                                                    <td style="width: 96%; color: Red">
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('Cap')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqDept')">Req. Dept.</b>
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:textbox id="txtDeptPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtDeptCode" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 22%">
                                            <gw:textbox id="txtDeptName" styles='width:100%' />
                                        </td>
                                        <td align="right" style="white-space: nowrap">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PurDept')">Purch. Dept.</b>
                                        </td>
                                        <td align="right" style="width: 10%">
                                            <gw:textbox id="txtPurDeptPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtPurDeptCode" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 23%">
                                            <gw:textbox id="txtPurDeptName" styles='width:100%' />
                                        </td>
                                        <td>
                                            <gw:icon id="btnAddMat" img="3" text="Matl Reg." onclick="OnPopUp('Matl')" styles='width:100' />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqEmp')">Request by</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtEmpPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtEmpID" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtEmpName" styles='width:100%' />
                                        </td>
                                        <td align="right" style="white-space: nowrap; color: Red">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('AppEmp')">Approved by</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtAppPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtAppID" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtAppName" styles='width:100%' />
                                        </td>
                                        <td>
                                            <gw:icon id="btnAddPartner" img="3" text="Partner Reg." onclick="OnPopUp('Partner')"
                                                styles='width:100' />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('GetPartner')">Partner</b>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtPartnerPk" styles='width:100%;display:none' />
                                            <gw:textbox id="txtPartnerID" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtPartnerName" styles='width:100%' />
                                        </td>
                                        <td align="right" style="white-space: nowrap; color: Red">
                                            Approved Date
                                        </td>
                                        <td colspan="2">
                                            <gw:datebox id="dtSignDt" nullaccept lang="<%=Session("Lang")%>" />
                                        </td>
                                        <td>
                                            <gw:icon id="btnPrint" img="3" text="Print out" onclick="OnPrint()" styles='width:100' />
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
                                        <gw:icon img="3" alt="Add Item" text="Add Item" id="btnAddNew1" onclick="OnPopUp('Item')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="5">
                            <gw:grid id='grdDetail' header='_pk|_tpr_poreq_pk|_req_date|Seq No.|Status|_tco_item_pk|Item Code|Item Name|Req Qty|U/Price|Amount|Monthly AVG Consp.|Dept Code|Dept Name|_tco_partner_pk|Partner|Partner Name|Spec|UOM|Class|Class|Delivery DT|Account|Account Text|Reason for Requisition'
                                format='0|0|0|0|2|0|0|0|-2|-2|-2|-2|0|0|0|0|0|0|0|0|0|4|0|0|0' aligns='0|0|0|1|1|0|0|0|3|3|3|3|0|0|0|0|0|0|1|0|0|0|0|0|0'
                                check='||||||||0n|-n|-n|-n|||||||||||||' editcol='0|0|0|0|0|0|0|0|1|1|0|1|1|1|0|1|0|1|0|1|0|1|1|0|1'
                                widths='0|0|0|800|0|9000|1000|2000|1000|1000|1000|1300|1000|0|1500|1000|1500|1500|700|800|1300|1200|1000|1500|2000'
                                sorting='T' acceptnulldate='T' styles='width:100%; height:100%' onafteredit="OnAfterValueChange('Detail')"
                                oncelldblclick="OnGriddblClick()" autosize='T' />
                            <!------------------------------------------->
                            <gw:grid id='grdTest' header='PL_NM|PL_CD' format='0|0|0' aligns='0|0|0' check='||'
                                editcol='1|1|1' widths='1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
                            <gw:grid id='grdTest1' header='PK|PL_NM|PL_CD' format='0|0|0' aligns='0|0|0' check='||'
                                editcol='1|1|1' widths='1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
                            <gw:grid id='grdTest2' header='PK|PL_NM|PL_CD' format='0|0|0' aligns='0|0|0' check='||'
                                editcol='1|1|1' widths='1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
                            <gw:grid id='grdTest3' header='PK|PL_NM|PL_CD' format='0|0|0' aligns='0|0|0' check='||'
                                editcol='1|1|1' widths='1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
                            <!------------------------------------------->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtMasterPK1" styles="width: 100%;display:none" />
<gw:textbox id="txtInput" styles="width: 100%;display:none" />
<gw:textbox id="txtRtnValue1" styles="width: 100%;display:none" />
<gw:textbox id="txtRtnValue2" styles="width: 100%;display:none" />
<gw:textbox id="txtPL_Code" styles="width: 100%;display:none" />
<gw:textbox id="txtPartner_ID" styles="width: 100%;display:none" />
<gw:textbox id="txtLedger_ID" styles="width: 100%;display:none" />
<gw:textbox id="txtClass_ID" styles="width: 100%;display:none" />
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</html> 