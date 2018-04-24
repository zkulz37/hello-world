<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Line W/I Entry</title>
</head>
<%  
	ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>
<script>
//-----------------------------------------------------
var flag;

var G_PK        = 0,
    G_Status    = 1,
    G_SLip_No   = 2,
    G_Date      = 3,
    G_PARTNER   = 4;		 

//===============================================================================================
/*PROD*/
var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1,
    G1_SEQ 				= 2,
    G1_ITEM_PK      	= 3,
    G1_ITEM_CODE    	= 4,
    G1_ITEM_NAME    	= 5,
	G1_UOM				= 6,
	G1_LOTNO             = 7,
    G1_INS_QTY          = 8,    
    G1_INS_REMARK       = 9;
   /*WIP*/      
    var G3_DETAIL_PK        = 0,
    G3_DETAIL_PK        = 1,
    G3_MASTER_PK        = 2,
    G3_ITEM_PK      	= 3,
    G3_ITEM_CODE    	= 4,
    G3_ITEM_NAME    	= 5,
	G3_UOM				= 6,G3_WIP_QTY
	G3_WIP_QTY          = 7,    
    G3_INS_REMARK       = 8;
   /*cons*/     
    var G2_pk   = 0,
    G2_WI_M_PK  = 1,
    G2_LINE_SIDE = 2,
    G2_SEQ      = 3,
    G2_ITEM_PK  = 4,
    G2_ITEM_CD  = 5,
    G2_ITEM_NM  = 6,
    G2_UOM      = 7,
    G2_LOT_NO   = 8,
    G2_BALE     = 9, 
    G2_ATT01    = 10,
    G2_KG       = 11, 
    G2_RATIO    = 12,
    G2_WH_PK    = 13,   
    G2_REMARK   = 14;   
    
var arr_FormatNumber = new Array();    
 //===============================================================================================

function OnToggleLR()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
function OnToggleUD()
{ 
    var up  = document.all("id_midle");    
    var down = document.all("id_bottom");
    var imgArrow  = document.all("img2");  
    
    if ( imgArrow.status == "collapse" )
    {
        up.style.display     = "";
        up.style.height      = '79%'
        down.style.display    = "none";                              
                
        imgArrow.status = "expand";  
        imgArrow.src = "../../../system/images/up.gif";                              
    }
    else 
    {
        up.style.display     = "";
        down.style.display    = "";
        up.style.height      = '45%'
        down.style.height      = '39%'
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/down.gif";
    }
}
 //===============================================================================================
function BodyInit()
 {
 	
    System.Translate(document);  // Translate to language session    
 
    txtStaffName.SetEnable(false);
    OnToggleLR();
	OnToggleUD();	
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    
    BindingDataList();    
    //----------------------------
	 
	grdConsL.GetGridControl().FrozenCols = 7;
	
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0 and line_id ='MIXED'  ORDER BY line_id" )%>";    
     lstLine.SetDataText(data);
 
	 
	 data = "<%=ESysLib.SetListDataSQL(" select null,null shift from dual union all SELECT PK, shift || ' : ' || start_time || ' -> ' || end_time FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y' order by shift nulls first ")%>";
	 lstShift.SetDataText(data);
	 lstShift.value ="";
	 	 
	 var ctr = grdProd.GetGridControl(); 
     ctr.ColFormat(G1_INS_QTY) = "#,###,###,###,###,###.##";	 
	    
     arr_FormatNumber[G1_INS_QTY] = 2;                  
 }

 
//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbpr00050.Call("SELECT");
        break;
    
        case 'grdMaster':                   
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                
                flag = 'view' ;
                data_kbpr00050_1.Call("SELECT");                                      
        break;
		
        case 'ConsL':
            data_kbpr00050_3_LINE.Call("SELECT");
        break;
         
        case 'grdProd':            
            data_kbpr00050_2.Call("SELECT");
        break;
		
        case 'WIP':            
            data_kbpr00050_4.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        
        case "data_kbpr00050_1": 
            
                //---------------------------- 
                OnSearch('ConsL');   
                   
        break;

        case "data_kbpr00050_2":
           
            if ( grdProd.rows > 1 )
            {
	            grdProd.SetCellBold( 1, G1_ITEM_CODE, grdProd.rows - 1, G1_ITEM_CODE, true);
                grdProd.SetCellBold( 1, G1_INS_QTY,   grdProd.rows - 1, G1_INS_QTY,   true);

                grdProd.SetCellBgColor( 1, G1_ITEM_CODE , grdProd.rows - 1, G1_ITEM_NAME , 0xCCFFFF );        
            }   
            lblProd.text = "Total: " + CalTotal(grdProd,G1_INS_QTY);
            OnSearch("WIP");      
        break;

        case 'pro_kbpr00050':
            alert(txtReturnValue.text);
            OnSearch("WIP");
        break;   
        
        case 'pro_kbpr00050_1':
            alert(txtReturnValue.text);
        break; 		
        
        case 'data_kbpr00050_3_LINE':             
			
			SumConsumption(); 
			
			OnSearch('grdProd');
			
        break;
        
        case 'data_kbpr00050_4':
			if ( grdWIP.rows > 1 )
            {
	            grdWIP.SetCellBold( 1, G3_WIP_QTY,   grdWIP.rows - 1, G3_WIP_QTY,   true);      
            }   
            lblTotalWIP.text = "Total: " + CalTotal(grdWIP,G3_WIP_QTY);
        break;
		
		case 'pro_kbpr00050_prod':
             alert(txtReturnValue.text);
             OnSearch('grdProd');
        break;
		 	            
   }            
}
 
//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        
		 case 'PROD' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to general product for this WI?'))
                {
                    pro_kbpr00050_prod.Call();
                } 
            }                          
        break;     
           
    }
}
 
//=================================================================================
 
 function CalTotal(p_grid,p_col)
 {
	   var vQty = 0 ;
	
       for (var i = 1; i<p_grid.rows; i++)
       {	
			vQty      =  vQty      + Number(p_grid.GetGridData(i, p_col));                   
       }       	 
	 return vQty;
 }
 //------------------------------------------
 function SumConsumption()
 {
    var total_material = CalTotal(grdConsL,G2_KG)  ;
    var total_bales = CalTotal(grdConsL,G2_BALE)   ;  
	
    
      txtMATQTY.text = total_material ;
      txtBales.text = total_bales ;
     
 }
 //------------------------------------------
</script>

<body>
     
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbpr00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_kbpr00050" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtSearchNo" />					 						 	
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbpr00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00050_1"  procedure="<%=l_user%>lg_upd_kbpr00050_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />
					 <inout  bind="lblStatus" />				
					 <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstLine" />
                     <inout  bind="lstShift" />
                     <inout  bind="txtRemark" /> 
				     <inout  bind="txtMixTime" /> 
                     <inout  bind="lblMaterialRate" />  
                     <inout  bind="txtMATQTY" />                       
					 <inout  bind="txtBales" />   
					                                                                            
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00050_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00050_2"   procedure="<%=l_user%>lg_upd_kbpr00050_2"> 
                <input bind="grdProd">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdProd" /> 
            </dso> 
        </xml> 
    </gw:data>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00050_3_LINE" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_kbpr00050_3"   procedure="<%=l_user%>lg_upd_kbpr00050_3"> 
                <input bind="grdConsL">                    
                    <input bind="txtMasterPK" />                 
                </input> 
                <output bind="grdConsL" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00050_4" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user%>lg_sel_kbpr00050_4"   procedure="<%=l_user%>lg_upd_kbpr00050_4"> 
                <input bind="grdWIP">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdWIP" /> 
            </dso> 
        </xml> 
    </gw:data>
      <!--------------------------process- wip------------------------------------->
    <gw:data id="pro_kbpr00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00050" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------Out REQ-------------------------------->
    <gw:data id="pro_kbpr00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00050_1_kb" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
   
     <!-------------------------------LOAD Product------------------------------------->
    <gw:data id="pro_kbpr00050_prod" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00050_product" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 5%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Ins. No
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip|Ins. Date|Line" format="0|0|0|4|0"
                                aligns="0|1|0|1|1" defaults="||||" editcol="0|0|0|0|0" widths="0|1000|1200|1200|1500"
                                styles="width:100%; height:100%" sorting="T" param="0,1,2,3" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 5%">
                            Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>                       
                        <td style="width: 50%" align="center" colspan=3>
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                       
                        <td style="width: 1%" align="right">
                             
                        </td>
                        <td style="width: 1%">
                             
                        </td>
                        <td style="width: 1%">
                             
                        </td>
                        <td style="width: 1%">
                             
                        </td>
                        <td style="width: 1%" align="right">
                             
                        </td>
                    </tr>
                     <tr style="height: 5%">
                        <td align="right" style="width: 10%">
                             Shift 
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:list id="lstShift" styles="width: 100%"  />
                        </td>
                        <td style="width: 10%" align="right">
                              Line  
                        </td>
                        <td colspan="8">
                             <gw:list id="lstLine" styles="width: 100%" onchange="OnSearch('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                           
                                Charger 
                        </td>
                        <td style="width: 35%" colspan="3">
                           <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td colspan="8" >
                             <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                   
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            Sum Mat.
                        </td>
                        <td   style="width: 20%">
                           <gw:textbox id="txtMATQTY" styles="width:100%;" type="number" format="###,###.###" />
                        </td>
                        <td align="right" style="width: 5%">
                            Bales
                        </td>
                        <td  style="width:10%">
                             <gw:textbox id="txtBales" styles="width:100%;"  type="number" format="###,###.###"  />
                        </td>
                        <td style="width: 10%">Time</td>
                        <td  style="width:30%" >
                             <gw:textbox id="txtMixTime" styles="width:100%;"  type="number" format="###,###"  onenterkey="SumConsumption()" />
                        </td>
                        <td colspan="6">
                            <gw:label id="lblMaterialRate" styles='width:100%;color:cc0000;font:9pt;align:left' text='' />
                        </td>
                    </tr>   
                     <tr style="height: 45%" id="id_midle">
                           <td colspan="14">
                                        <gw:grid id='grdConsL' header='_PK|_WI_WORKINS_M_PK|_Line/SIDE|Seq|_Item_pk|Mat. Code|_Mat Name|_UOM|Lot No|_Bale|_Kg/BL|Qty Kg|_Ratio|_warehouse_pk|Warehouse'
                                            format= '0|0|0|0|0|0|0|0|0|0|1|1|1|1|0' aligns='0|0|0|1|0|0|0|1|3|1|0|0|0|0|0' check='||||||||||||||'
                                            editcol='0|0|0|1|1|0|0|0|1|1|1|1|1|0|1' widths='0|0|1200|800|0|1500|2000|800|1000|1200|1200|01200|1200|0|1200'
                                            sorting='T' styles='width:100%; height:100%' 
                                            autosize ='Y'
                                            onafteredit="CheckInput('LINE')" acceptnulldate='T' />
                                        
                                    </td>              
                    </tr> 
                    <tr style="height: 1%; ">
                        <td >
                             <img status="collapse" id="img2" src="../../../system/images/down.gif"
                                            style="cursor: hand" onclick="OnToggleUD()" />
                        </td>
                        <td  align="left" style=" color:Gray">Product & WIP</td>
                         <td align="left" style="width: 1%" >
                            <gw:icon id="idBtnProd" img="2" text=" Load Prod WI" styles='width:100%' onclick="OnProcess('PROD')" />
                        </td>
                        <td style="width: 90%" colspan="7"> </td>
                    </tr>                              
                    <tr style="height: 34%" id="id_bottom">
                        <td colspan="5">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">
                                    
                                    <td align="center" >
                                        <gw:label id="lblProd" styles='width:100%;color:cc0000;font:9pt;align:left' text='' />
                                    </td>
                                      
                                </tr>
                                <tr  style="height: 90%">
                                     <td colspan="14">
                                        <gw:grid id='grdProd' header='_PK|_WI_WORKINS_M_PK|Seq|_Item_pk|Item Code|_Item Name|_UOM|LOT NO|Ins Qty|Remark'
                                            format= '0|0|0|0|0|0|0|0|1|0' aligns='0|0|0|1|0|0|0|0|0|1|' check='|||||||||'
                                            editcol='0|0|1|0|1|0|0|1|1|1' widths='0|0|800|0|1000|1500|800|1500|1500|2000'
                                            sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput('PROD')" acceptnulldate='T' 
                                            />
                                        
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                        <td  colspan="7">
                            <table style="width: 100%; height: 100%">
                                <tr  style="height: 10%">                                   
                                     <td align="center" >
                                        <gw:label id="lblTotalWIP" styles='width:100%;color:cc0000;font:9pt;align:left' text='Total:' />
                                    </td>                                   
                                   
                                </tr>
                                <tr  style="height: 90%">
                                    <td>
                                        <gw:grid id='grdWIP' header='_PK|_WI_WORKINS_M_PK|_WI_WORKINS_D_PK|_Item_pk|Item Code|Lot No|_UOM|Ins Qty|Remark'
                                        format= '0|0|0|0|0|0|0|1|0' aligns='0|0|0|0|0|0|0|0|0' check='||||||||'
                                        editcol='0|0|1|0|1|0|0|1|1' widths='0|0|800|0|1500|2000|800|1500|1500'
                                        sorting='T' styles='width:100%; height:100%'  acceptnulldate='T' 
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
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />

<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />

<!---------------------------------------------------------------------------------->
</html>
