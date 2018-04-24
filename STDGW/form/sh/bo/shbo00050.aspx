<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Additive Solution Preparation Instruction and Record</title>
</head>

<script>
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("EMP_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;      
    
    var G1_pk               =0,
        G1_date             =1,
        G1_batch_no         =2,
        G1_batch_desc       =3; 
        
        
   var G2_tsh_colp_d_pk             =0,
       G2_TCO_ITEM_PK               =1,
       G2_Malt_Code                 =2,
       G2_Malt_Name                 =3,
       G2_Unit                      =4,
       G2_Mixing_Ratio              =5,
       G2_Inst_Qty                  =6,
       G2_Mix                       =7,
       G2_Max                       =8,
       G2_Batch_No                  =9,
       G2_tsh_colp_m_pk             =10,
       G2_tsh_colpack_d_pk          =11;
 //---------------------------------------------------------
 function BodyInit()
 {
      dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
      OnAddNew('Master');
      FormatGrid();
      txtBatchNo.SetEnable(false);
      txtWeightPack.SetEnable(false);
      txtGelatinQty.SetEnable(false);
      txtBatchQty.SetEnable(false);
      txtGelatinPack.SetEnable(false);
      shbo00050.Call("SELECT");
//      txtBatchQty.SetEnable(false);
//      txtBatchNo.SetEnable(false);
//      txtEmpID.SetEnable(false);
//      txtEmpName.SetEnable(false);
//      dtIssDate.SetEnable(false);
     // grdDetail.SetWrapText(true);
     
 }
  //---------------------------------------------------------
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
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    {
        case '1':
            if(txtTshColpackMPk.text=="")
            {
                var fpath = System.RootURL + "/form/sh/bo/shbo00051.aspx";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {                  
                    txtTshColpackMPk.text = object[0];
                    txtColorCode.text = object[1];
                    txtColorName.text = object[2];
                    txtGelatinPack.text = object[3];
                    txtWeightPack.text = object[4];
                    shbo00050_2.Call("SELECT");
                }
            }
            else
            {
                
            }
        break;
        case'2':
            var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtThrEmployeePk.text = object[0];
                txtCharger.text=object[5];
            }
        break;
        
        case'3':
            if(txtMasterPK.text=="")
            {
                alert("Please choose Batch No to print !!!");
            }
            else
            {
                var fpath = System.RootURL + "/form/sh/bo/shbo00190.aspx?batchno="+txtBatchNo.text+"&batchdesc="+txtBatchDesc.text+"";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            } 
        break;
    }
}
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'grdBatch':
            shbo00050.Call("SELECT");
        break;
        case'Master':
            txtMasterPK.text=grdBatch.GetGridData(grdBatch.row,G1_pk);
            shbo00050_1.Call("SELECT");
        break;
    }
 }
 var addnew="";
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Master':
            shbo00050_1.StatusInsert();
            txtThrEmployeePk.text = user_pk;
            txtCharger.text =user_name;
            grdDetail.ClearData();
        break;              
      }  
 }
//---------------------------------------------------------
var flag="";
//---------------------------------------------------------

 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Master' :
            shbo00050_1.Call();
            flag="update";
        break;
      }  
 }

//---------------------------------------------------------

 function OnDelete(pos)
 {
    switch(pos)
    {
        case'1':
        if ( confirm( "Do you want to delete?" ) ) 
        {
            //flag ='update';
	        shbo00050_1.StatusDelete();
	        shbo00050_1.Call();
        }
        break;	
    }
 }
 //---------------------------------------------------------
 function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'shbo00050_1':
            if(flag=="update")
            {
                
                for(i=1;i<grdDetail.rows-1;i++)
                {
                    if(grdDetail.GetGridData(i,G2_tsh_colp_d_pk)=="")
                    {
                        grdDetail.SetRowStatus(i,'48');
                        grdDetail.SetGridText(i,G2_tsh_colp_m_pk,txtMasterPK.text);
                    }
                }
                shbo00050_2.Call(); 
            }
            else
            {
                shbo00050_2.Call("SELECT");
            }   
        break;
        case'shbo00050_2':
            if(flag=='update')
            {
                grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
                grdDetail.SetGridText(grdDetail.rows-1,6,txtBatchQty.text);
                addnew="";
                shbo00050.Call("SELECT");
                flag="";
            }
            else
            {
                grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
                grdDetail.SetGridText(grdDetail.rows-1,6,txtBatchQty.text);
            }
        break;
    }
}
 //---------------------------------------------------------

 function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
	  trl = grdDetail.GetGridControl();
      trl.ColFormat(G2_Mixing_Ratio )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Inst_Qty )      = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Mix )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Max )     = "###,###,###,###,##0.##0";
      
 }
//---------------------------------------------------------
 function OnProcess()
 {
    txtBatchQty.text=txtNoColorRant.text*txtWeightPack.text;
    txtGelatinQty.text=txtNoColorRant.text*txtGelatinPack.text;
    for(i=1;i<grdDetail.rows-1;i++)
    {
        
        var matno=grdDetail.GetGridData(i,G2_Malt_Code);
        var ratio=grdDetail.GetGridData(i,G2_Mixing_Ratio);
        if(matno=="000012")
        {
            var inst_qty=Math.ceil(((Number(txtBatchQty.text) * Number(ratio) / 100) / 0.980) * 1000) / 1000;
        }
        else
        {
            var inst_qty=Math.ceil((Number(txtBatchQty.text) * Number(ratio) / 100)    * 1000) / 1000;
        }
        
        var Min=System.Round((Number(inst_qty)-(Number(inst_qty)*0.01)),3);
        
        var Max=(Number(inst_qty)+(Number(inst_qty)*0.01)).toFixed(3);
        
        
        grdDetail.SetGridText(i,G2_Inst_Qty,inst_qty);
        grdDetail.SetGridText(i,G2_Mix,Min);
        grdDetail.SetGridText(i,G2_Max,Max);
    }
    grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
    if(grdDetail.rows-1>0)
    {
        grdDetail.SetGridText(grdDetail.rows-1,6,txtBatchQty.text);
    }
    
 }
//---------------------------------------------------------
function CheckSave()
{
    
}
//---------------------------------------------------------
function OnChangeData()
{
    var inst_qty =0, min_value=0, max_value =0, gel_ratio=0;
    var i =event.row;
    if(i >0 && i <grdDetail.rows-1)
    {
        inst_qty   = grdDetail.GetGridData(i, G2_Inst_Qty);

        min_value  = System.Round((Number(inst_qty) - (Number(inst_qty) *  0.010)),3);
        max_value  = ((Number(inst_qty) + (Number(inst_qty) *  0.010))).toFixed(3) ;
      
        grdDetail.SetGridText(i, G2_Mix, min_value); 
        grdDetail.SetGridText(i, G2_Max, max_value);
    }
    grdDetail.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
    grdDetail.SetGridText(grdDetail.rows-1,6,txtBatchQty.text); 
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00050"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shbo00050" > 
                <input> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" />
                    <input bind="txtColor" />
                </input> 
                <output bind="grdBatch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00050_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shbo00050_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" procedure="prod.sp_upd_shbo00050_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="dtInstDate" />
                    <inout bind="txtBatchNo" />
                    <inout bind="txtBatchDesc" />
                    <inout bind="txtGelatinPack" />
                    <inout bind="txtTshColpackMPk" />
                    <inout bind="txtColorCode" />
                    <inout bind="txtColorName" />
                    <inout bind="txtNoColorRant" />
                    <inout bind="txtWeightPack" />
                    <inout bind="dtIssuedDate" />
                    <inout bind="txtGelatinQty" />
                    <inout bind="txtBatchQty" />
                    <inout bind="txtThrEmployeePk" />
                    <inout bind="txtCharger" />
                </inout> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00050_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="prod.sp_sel_shbo00050_2" parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="prod.sp_upd_shbo00050_2" > 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" /> 
                    <input bind="txtTshColpackMPk" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>Batch No.</b>
                        </td>
                        <td style="width: 69%" align="right">
                            <gw:textbox id="txtColor" styles='width:100%' onenterkey="OnSearch('grdBatch')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdBatch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <b>Date</b>
                        </td>
                        <td colspan="2">
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('grdBatch')" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch('grdBatch')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdBatch' header='_pk|Date|Batch No|Batch Desc' format='0|4|0|0' aligns='0|0|0|0'
                                defaults='|||' editcol='0|0|0|0' widths='0|1200|1500|2000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right" colspan="7">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="btnCal" img="3" text="Calculate"  onclick="OnProcess()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('1')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <%--<gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />--%>
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPopUp('3')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Instructed Date
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:datebox id="dtInstDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Batch No.
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtBatchNo" styles='width:100%' />
                        </td>
                        <td align="right" colspan="2">
                            <gw:textbox id="txtBatchDesc" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 12%; white-space: nowrap" align="right">
                            Gelatin Q'ty(Kg)/Pack
                        </td>
                        <td style="width: 14%" align="right">
                            <gw:textbox id="txtGelatinPack" styles='width:100%' type="number" format="#,###,###,###,###.###" />
                        </td>
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Color Code.</b>
                        </td>
                        <td align="right">
                            <gw:textbox id="txtColorCode" styles='width:100%' />
                        </td>
                        <td align="right" colspan="2">
                            <gw:textbox id="txtColorName" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 15%; white-space: nowrap" align="right">
                            No.Of Colorant Packs(ea)
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:textbox id="txtNoColorRant" styles='width:100%' type="number" format="#,###,###,###,###.###" onenterkey="OnProcess()"/>
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Weight(Kg)/Pack
                        </td>
                        <td align="right">
                            <gw:textbox id="txtWeightPack" styles='width:100%' type="number" format="#,###,###,###,###.###" />
                        </td>
                        <td align="right">
                            Issued Date
                        </td>
                        <td align="left">
                            <gw:datebox id="dtIssuedDate" lang="1" styles="width:100%" nullaccept="true" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Gelatin Q'ty(Kg)
                        </td>
                        <td align="right">
                            <gw:textbox id="txtGelatinQty" styles='width:100%' type="number" format="#,###,###,###,###.###"/>
                        </td>
                        <td align="right">
                            BATCH Q'ty
                        </td>
                        <td align="right">
                            <gw:textbox id="txtBatchQty" styles='width:100%' type="number" format="#,###,###,###,###.##R"/>
                        </td>
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Issued By</b>
                        </td>
                        <td align="right">
                            <gw:textbox id="txtCharger" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <%--<gw:grid id='grdDetail' header='_PK|_tsh_colp_m_pk|_TCO_ITEM_PK|Matl Code|Matl Name|Unit|Mixing Ratio(%)|Instructed Qty|Mix.|Max.|Batch No'
                                format='0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0' defaults='||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1' widths='0|0|0|1500|2200|1000|1500|1500|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()" />--%>
                            <gw:grid id='grdDetail' header='_tsh_colp_d_pk|_TCO_ITEM_PK|Malt Code|Malt Name|Unit|Mixing Ratio(%)|Inst Qty|Min|Max|Batch No|_tsh_colp_m_pk|_tsh_colpack_d_pk'
                                format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|3|3|3|3|3|3|3' defaults='|||||||||||' editcol='0|0|0|0|0|0|1|0|0|1|0|0'
                                widths='0|0|1000|3000|1000|1500|1500|1500|1500|1000|1000|1000' sorting='T' styles='width:100%; height:100%'onafteredit="OnChangeData()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtTshColpackMPk" styles="width: 100%;display:none" />
<gw:textbox id="txtThrEmployeePk" styles="width: 100%;display:none" />
</html>
