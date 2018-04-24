<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Input Order detail</title>
</head>

<%  ESysLib.SetUser("comm")%>

<script language="javascript" type="text/javascript">
 
    var order_pk, is_unit_change=0, rowchange;
    var contract_pk;
    var G1_tim_contr_dtl_pk = 0,   
        G1_rownum           = 1,    
        G1_item_code        = 2,    
        G1_item_name        = 3,    
        G1_hs_code          = 4,    
        G1_unit_cd          = 5,
        G1_unit_packing     = 6,
        G1_apportion_yn     = 7,
        G1_qty              = 8,
        G1_qty_packing      = 9,
        G1_u_price          = 10,
        G1_ex_price         = 11,
        G1_retouch_amt      = 12,
        G1_tr_amt           = 13,
        G1_tco_item_pk      = 14,
        G1_tim_contr_mst_pk = 15,
        G1_tim_order_pk     = 16,
        G1_tpr_purordd_pk   = 17,
        G1_cnv_ratio        = 18,
        G1_pack_rate        = 19;
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        
        order_pk= "<%=request.QueryString("order_pk") %>";
        txtOrderPK.text=order_pk;
        contract_pk ="<%=request.QueryString("contract_pk") %>"  ;
        txtOrderNo.text= "<%=request.QueryString("OrderNo") %>"  ; 
        txtStatus.text= "<%=request.QueryString("Status") %>"  ; 
        SetGridFormat(); 
        dat_epac00010_2.Call('SELECT');
        BindingDataList();
    }
    //-----------------------------------------------------------------------------------
     function BindingDataList()
     {        
        var data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
        grdOrderDetail.SetComboFormat(G1_unit_cd,data);
        grdOrderDetail.SetComboFormat(G1_unit_packing,data);
     }
    //---------------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdOrderDetail.GetGridControl(); 
       
        ctr.ColFormat(G1_tr_amt) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_qty) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_u_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_ex_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_retouch_amt) = "#,###,###,###,###,###.##";
    } 
    //-------------------------------------------------------------------------------
    function openPopup()
    {
         var fpath = '';
       
         fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=||Y|Y|Y|Y";
         
        oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 

        if (oValue != null)
        {  
            for ( var i=0; i<oValue.length;i++)
            {                 
                var aValue = oValue[i];  
                grdOrderDetail.AddRow();
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_rownum          ,grdOrderDetail.rows-1);
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_item_code       ,aValue[1]); //Item code
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_item_name       ,aValue[2]); //_item name
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_hs_code         ,aValue[19]); //hs code
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_unit_cd         ,aValue[5]); //unit
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_unit_packing    ,aValue[5]);
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_qty             ,aValue[7]); 
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_qty_packing     ,aValue[7]); 
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tco_item_pk     ,aValue[0]); //tco_item_pk
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_cnv_ratio       ,aValue[23]); //_cnv_ratio
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_pack_rate       ,aValue[22]);
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tim_contr_mst_pk,contract_pk);
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tim_order_pk    ,order_pk); //order_pk
            }
        }
    }    
    //--------------------------------------------------------------------------------
    function onSearch()
    {
        dat_epac00010_2.Call("SELECT");
    }
    //-------------------------------------------------------------------------------
    function onSave()
    {
        dat_epac00010_2.Call('');        
    }
    //----------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case 'dat_epac00010_2':            
                grdOrderDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1,1,'')
            break;  
            case 'dat_epac00010_12':            
                grdOrderDetail.SetGridText(rowchange, G1_cnv_ratio, txtCnvRatio.text);
                onAfterEditting(G1_u_price);
                if(is_unit_change==1) 
                    onAfterEditting(G1_unit_packing);
            break;
            case 'dat_epac00010_13':            
                grdOrderDetail.SetGridText(rowchange, G1_pack_rate, txtTran_rate.text);
                if(!isNaN(grdOrderDetail.GetGridData(rowchange,G1_pack_rate)))
                {
                    grdOrderDetail.SetGridText(rowchange,G1_qty_packing,Number(grdOrderDetail.GetGridData(rowchange,G1_qty))*Number(grdOrderDetail.GetGridData(rowchange,G1_pack_rate)));                   
                }
                else
                {
                    grdOrderDetail.SetGridText(rowchange,G1_qty_packing,Number(grdOrderDetail.GetGridData(rowchange,G1_qty)));                   
                }                
                is_unit_change =0;
            break;          
        }    
    }
    //--------------------------------------------------------------------------------------
     function onAfterEditting(colidx)
     {
        if(colidx==G1_unit_cd)
        {
            is_unit_change=1; 
            rowchange=grdOrderDetail.row;
            txtUnit.text= grdOrderDetail.GetGridData(grdOrderDetail.row,G1_unit_cd);
            dat_epac00010_12.Call();
        }
        
        if(colidx==G1_unit_packing)
        {
            if(is_unit_change ==0) 
                rowchange=grdOrderDetail.row;
            txtItemPK.text = grdOrderDetail.GetGridData(grdOrderDetail.row,G1_tco_item_pk);
            txtUnit.text= grdOrderDetail.GetGridData(grdOrderDetail.row,G1_unit_cd);
            txtUnitTran.text= grdOrderDetail.GetGridData(grdOrderDetail.row,G1_unit_packing);
            dat_epac00010_13.Call();
        }
        
        if(colidx==G1_qty)
        {
            if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)))
                if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_pack_rate)))
                {
                    grdOrderDetail.SetGridText(grdOrderDetail.row,G1_qty_packing,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty))*Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_pack_rate)));                   
                }
                else
                {
                    grdOrderDetail.SetGridText(grdOrderDetail.row,G1_qty_packing,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)));                   
                }
        }
        
        if ((colidx==G1_qty)||(colidx==G1_u_price)) //Price, Qty.
        {              
           if ((!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty))) && (!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_u_price))) )
           {
               if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_cnv_ratio)))
               {
                   grdOrderDetail.SetGridText(grdOrderDetail.row,G1_ex_price,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_u_price))*Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty))/Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_cnv_ratio)));
                   grdOrderDetail.SetGridText(grdOrderDetail.row,G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)));
               }
               else
               {
                   grdOrderDetail.SetGridText(grdOrderDetail.row,G1_ex_price,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_u_price))*Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)));
                   grdOrderDetail.SetGridText(grdOrderDetail.row,G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)));
               }
           }
        } 
        if (colidx==G1_retouch_amt) //	Retouch Amt 
        {                
           if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)))
           {           
               grdOrderDetail.SetGridText(grdOrderDetail.row,G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdOrderDetail.SetGridText(grdOrderDetail.row,G1_retouch_amt,'')
              grdOrderDetail.SetGridText(grdOrderDetail.row,G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)));
           }           
        } 
        grdOrderDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
        grdOrderDetail.SetGridText(grdOrderDetail.rows-1,1,'')
        grdOrderDetail.SetRowStatus(grdOrderDetail.rows-1,'_');
     }
     //---------------------------------------------------------------------------------------
    function OnEditItem()
    {
       
        fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=|||||Y";
        aValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 

        if (aValue != null)
        {          
            grdOrderDetail.SetGridText(grdOrderDetail.row, G1_item_code   ,aValue[1]); //Item code
            grdOrderDetail.SetGridText(grdOrderDetail.row, G1_item_name   ,aValue[2]); //_item name
            grdOrderDetail.SetGridText(grdOrderDetail.row, G1_unit_cd     ,aValue[5]); //Item name
            grdOrderDetail.SetGridText(grdOrderDetail.row, G1_tco_item_pk ,aValue[0]); //tco_item_pk
            grdOrderDetail.SetGridText(grdOrderDetail.row, G1_hs_code     ,aValue[19]); //hs code
        }
    } 
    //-------------------------------------------------------------------------------
    function onDelete()
    {
        if (confirm ("Do you want to delete this item?"))
            grdOrderDetail.DeleteRow();
    }
</script>

<body>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00010_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="imex.sp_sel_epac10011_1"   procedure="imex.sp_upd_epac00011_1"> 
            <input bind="grdOrderDetail">                    
                <input bind="txtOrderPK" /> 
            </input> 
            <output bind="grdOrderDetail" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------get current curency------------------------------------>
<gw:data id="dat_epac00010_12" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_get_cnv_ratio" > 
            <input>
                <input bind="txtUnit" />
            </input> 
            <output>
                <output bind="txtCnvRatio" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get unit tran----------------------------------------------->
<gw:data id="dat_epac00010_13" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_dat_epac00030_13" > 
            <input>   
                <input bind="txtItemPK" />
                <input bind="txtUnit" />
                <input bind="txtUnitTran" />
            </input> 
            <output>
                <output bind="txtTran_rate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td width="10%" >Order No.</td> 
                <td width="20%"><gw:textbox id="txtOrderNo"  text=""  styles='width:100%;' csstype="mandatory" /> </td>
                <td width="10%" align="right"> Status</td>
                <td width="15%"><gw:textbox id="txtStatus"  text=""  styles='width:100%;' csstype="mandatory" /> </td>
                <td width="30%"> </td>
                <td width="2%"><gw:imgbtn id="btnNew" img="new" alt="Select Item" text="Select Item" onclick="openPopup()" /></td>
                <td width="2%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>
                <td width="2%"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete()" /></td>
                <td width="2%"><gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" text="Refresh" onclick="onSearch()" /></td>
            </tr>
            <tr>
                <td colspan="9">
                </td>
            </tr>
            <tr>
                <td colspan="9">
                    <gw:grid id='grdOrderDetail'
                        header='_PK|No|Item Code|Item Name|HS Code|Unit|Unit Packing|Apportion|Qty.|Qty. Packing|Price|Ext. Price|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_tpr_purordd_pk|_cnv_ratio|_pack_rate'
                        format='0|0|0|0|0|2|2|3|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|1|0|0|1|1|1|1|3|3|3|3|3|3|3|0|0|0|0|0'
                        defaults='|||||||||||||||||||'
                        editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|0|0|0|0|0'
                        widths='0|555|1500|2700|1140|1000|1000|1000|1110|1035|1040|1290|1395|1500|0|0|0|0|0'
                        sorting='T'
                        onafteredit="onAfterEditting(this.col)"
                        styles='width:100%; height:460'
                        oncelldblclick="OnEditItem()"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"
                    />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body> 
<gw:textbox id="txtOrderPK" styles="display:none" />
<gw:textbox id="txtCnvRatio"  text=""  styles='display:none'  />
<gw:textbox id="txtUnit"  text=""  styles='display:none'  />
<gw:textbox id="txtUnitTran"  text=""  styles='display:none'  />  
<gw:textbox id="txtTran_rate"  text=""  styles='display:none'  />
<gw:textbox id="txtItemPK"  text=""  styles='display:none'  />
</html>
