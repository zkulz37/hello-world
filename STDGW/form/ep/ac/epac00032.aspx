<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Input order detail</title>
</head>

<%  ESysLib.SetUser("comm")%>

<script language="javascript" type="text/javascript">
    var flag,is_unit_change=0,  rowchange; 
    var order_pk;
    var contract_pk;
    var G1_tex_contr_dtl_pk = 0,     
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
        G1_tex_contr_mst_pk = 15,     
        G1_tex_order_pk     = 16,     
        G1_tsa_sotakeoutd_pk = 17,     
        G1_cnv_ratio        = 18,     
        G1_tran_rate        = 19;
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        BindingDataList();
        order_pk= "<%=request.QueryString("order_pk") %>";
        txtOrderPK.text=order_pk;
        contract_pk ="<%=request.QueryString("contract_pk") %>"  ;
        txtOrderNo.text= "<%=request.QueryString("OrderNo") %>"  ; 
        txtStatus.text= "<%=request.QueryString("Status") %>"  ; 
        SetGridFormat(); 
        dat_epac00030_2.Call('SELECT');
    }
    //------------------------------------------------------------------------------------------
    function BindingDataList()
    {        
        var data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
        grdOrderDetail.SetComboFormat(G1_unit_cd,data);
        grdOrderDetail.SetComboFormat(G1_unit_packing,data);
    }
    //-------------------------------------------------------------------------------
    function openPopup()
    {
         var fpath = '';
         fpath = System.RootURL + "/form/fp/ab/fpab00240.aspx?type=PROD";
        oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 

        if (oValue != null)
        {  
            for ( var i=0; i<oValue.length;i++)
            {                 
                var aValue = oValue[i];  
                grdOrderDetail.AddRow();
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_rownum         ,i+1);
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_item_code      ,aValue[1]); //Item code
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_item_name      ,aValue[2]); //_item name
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_unit_cd        ,aValue[5]); //Item name
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_qty            ,aValue[7]); //Unit
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tco_item_pk    ,aValue[0]); //tco_item_pk
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_hs_code        ,aValue[19]); //hs code
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tex_contr_mst_pk,contract_pk); // contract_pk
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tex_order_pk   ,order_pk); //order_pk
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_cnv_ratio      ,aValue[20]); //cnv_ratio
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_unit_packing   ,aValue[5]); // packing unit
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1, G1_tran_rate      ,aValue[22]); // transrate                                                
            }
        }
    }    
    //--------------------------------------------------------------------------------------
     function onAfterEditting(colidx)
     {  
        if(colidx==G1_unit_cd)
        {
            txtUnit.text= grdOrderDetail.GetGridData(grdOrderDetail.row, G1_unit_cd);
            dat_epac00030_12.Call();
        }
        
        if(colidx==G1_unit_packing)
        {
            txtUnit.text= grdOrderDetail.GetGridData(grdOrderDetail.row,G1_unit_cd);
            txtUnitTran.text= grdOrderDetail.GetGridData(grdOrderDetail.row,G1_unit_packing);
            dat_epac00030_13.Call();
        }
       
        if(colidx==8)
        {
            if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)))
                if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row, G1_tran_rate)))
                {
                    grdOrderDetail.SetGridText(grdOrderDetail.row, G1_qty_packing,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty))*Number(grdOrderDetail.GetGridData(grdOrderDetail.row, G1_tran_rate)));                   
                }
                else
                {
                    grdOrderDetail.SetGridText(grdOrderDetail.row, G1_qty_packing,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)));                   
                }
        }
           
        if ((colidx==G1_qty)||(colidx==G1_u_price)) //Price, Qty.
        {                
           if ((!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty))) && (!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_u_price))) )
           {
               grdOrderDetail.SetGridText(grdOrderDetail.row,G1_ex_price,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_u_price))*Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_qty)));
               grdOrderDetail.SetGridText(grdOrderDetail.row, G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row, G1_retouch_amt)));
           }
        } 
        if (colidx==G1_retouch_amt) //	Retouch Amt 
        {                
           if(!isNaN(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_retouch_amt)))
           {           
               grdOrderDetail.SetGridText(grdOrderDetail.row, G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row, G1_retouch_amt)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdOrderDetail.SetGridText(grdOrderDetail.row, G1_retouch_amt,'')
              grdOrderDetail.SetGridText(grdOrderDetail.row, G1_tr_amt,Number(grdOrderDetail.GetGridData(grdOrderDetail.row,G1_ex_price))+Number(grdOrderDetail.GetGridData(grdOrderDetail.row, G1_retouch_amt)));
           }           
        } 
        grdOrderDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
        grdOrderDetail.SetGridText(grdOrderDetail.rows-1,1,'')
        grdOrderDetail.SetRowStatus(grdOrderDetail.rows-1,'_');
     }
    //-------------------------------------------------------------------------------
    function onSave()
    {
        dat_epac00030_2.Call('');        
    }
    //-------------------------------------------------------------------------------
    function onDelete()
    {
        if (confirm ("Do you want to delete this item?"))
            grdOrderDetail.DeleteRow();
    }
    //--------------------------------------------------------------------------------
    function onSearch()
    {
        dat_epac00030_2.Call("SELECT");
    }
    //---------------------------------------------------------------------------------
    function SetGridFormat()
    {
        var ctr = grdOrderDetail.GetGridControl(); 
        ctr.ColFormat(G1_qty) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_u_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_ex_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_retouch_amt) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_tr_amt) = "#,###,###,###,###,###.##";
    } 
    //----------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case 'dat_epac00030_2':            
                grdOrderDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdOrderDetail.SetGridText(grdOrderDetail.rows-1,1,'')
                grdOrderDetail.SetRowStatus(grdOrderDetail.rows-1,'_');
            break;    
            case 'dat_epac00030_12':            
                grdOrderDetail.SetGridText(grdOrderDetail.row, G1_cnv_ratio, txtCnvRatio.text);
                onAfterEditting(G1_qty);
            break;
            case 'dat_epac00030_13':            
                grdOrderDetail.SetGridText(grdOrderDetail.row, G1_tran_rate, txtTran_rate.text);
                onAfterEditting(G1_qty);
            break;        
        }
    
    }
</script>

<body>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="imex.sp_sel_epac00032_1"   procedure="imex.sp_upd_epac00032_1"> 
            <input bind="grdOrderDetail">                    
                <input bind="txtOrderPK" /> 
            </input> 
            <output bind="grdOrderDetail" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------get ratio----------------------------------------------->
<gw:data id="dat_epac00030_12" onreceive="OnDataReceive(this)"> 
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
<gw:data id="dat_epac00030_13" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_dat_epac00030_13" > 
            <input>   
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
                        header='_PK|No|Item Code|Item Name|HS Code|Unit|Packing Unit|Apportion|Qty.|Packing Qty.|Price|Ext. Price|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_so_pk|_cnv_ratio|_tran_rate'
                        format='0|0|0|0|0|2|2|3|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|1|0|0|1|1|1|0|3|3|3|3|3|3|3|0|0|0|0|0'
                        defaults='||||||||||||||||||'
                        editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|0|0|0|0|0|0'
                        widths='0|555|1500|2700|1140|1000|1500|1000|1110|1200|1035|1290|1595|1500|0|0|0|0|0|0'
                        sorting='T'
                        onafteredit="onAfterEditting(this.col)"
                        styles='width:100%; height:460'
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"
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
</html>
