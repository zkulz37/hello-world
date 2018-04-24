
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>S/O Inquiry</title>
</head>
<%  ESysLib.SetUser("sale")%>

<script>
var G1_pk           = 0,    
    G1_tco_item_pk  = 1,
    G1_slip_no      = 2,
    G1_deli_date    = 6,
    G1_order_qty    = 7,
    G1_item_code    = 8;

 var G2_pk                 = 0,
     G2_tsa_sotakeoutd_pk  = 1,
     G2_rqst_no            = 2,
     G2_tco_item_pk        = 3,
     G2_deli_date          = 4,
     G2_deli_qty           = 6,
     G2_item_code          = 5;
//-------------------------------------------------------------------------------------------
function BodyInit()
{  
    //dtOrderF.SetDataText(System.AddDate(dtOrderT.GetData(),-30));
    //dtDeliF.SetDataText(System.AddDate(dtDeliT.GetData(),-30));
    txtDeptID.SetEnable(false)
    txtDeptNM.SetEnable(false)
    grdOrder.GetGridControl().FrozenCols = 2 ;   
    txtDeptID.text = 10400000;
    txtDeptNM.text = "TRADE";
}

//-------------------------------------------------------------------------------------------
function OnSearch()
{
    grdOrder.GridRefresh()
    shex00030.Call("SELECT")
}

//-------------------------------------------------------------------------------------------
function OnDataReceive(p_oData)
{
              
}
 //---------------------------------------------------------
 function OnPopUp(pos)
 {
      switch (pos)         
      {		        
        case 'BillTo' :
             var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
                txtPartnerID.text = object[1];
                txtPartnerName.text = object[2];
	         }
	    break;
	    case 'Dept' :
             var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptNM.text = object[2]; 
               txtDeptID.text  = object[1]; 
            }
	    break;
	  }  
 }  
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		  
        case 'Detail' :
            if(grdOrder.row<0)
            {
                alert("Please select Order to make Release Instruction!!!");
                return ;
            }
            
            grdDeli.AddRow();
            
            grdDeli.SetGridText(grdDeli.rows-1,G2_tsa_sotakeoutd_pk, txttsa_sotakeoutd_pk.text);
            grdDeli.SetGridText(grdDeli.rows-1,G2_rqst_no, grdOrder.GetGridData(grdOrder.row,G1_slip_no));
            grdDeli.SetGridText(grdDeli.rows-1,G2_tco_item_pk, grdOrder.GetGridData(grdOrder.row,G1_tco_item_pk));
            if(grdDeli.rows <3)
            {
                grdDeli.SetGridText(grdDeli.rows-1,G2_deli_date, grdOrder.GetGridData(grdOrder.row,G1_deli_date));
                grdDeli.SetGridText(grdDeli.rows-1,G2_deli_qty, grdOrder.GetGridData(grdOrder.row,G1_order_qty));
            }
            else
            {
                var inst_qty ;
                inst_qty= 0;
                for(i =1; i< grdDeli.rows; i++)
                {
                    inst_qty = Number(inst_qty) + Number(grdDeli.GetGridData(i,G2_deli_qty));
                }
                grdDeli.SetGridText(grdDeli.rows-1,G2_deli_date, grdOrder.GetGridData(grdOrder.row,G1_deli_date));
                grdDeli.SetGridText(grdDeli.rows-1,G2_deli_qty, Number(grdOrder.GetGridData(grdOrder.row,G1_order_qty)) - Number(inst_qty) );
            }
            grdDeli.SetGridText(grdDeli.rows-1,G2_item_code, grdOrder.GetGridData(grdOrder.row,G1_item_code));
            
        break;
      }  
 }
 //---------------------------------------------------------
 function OnDelete(obj)
 {
    switch(obj)
    {
        case 'Detail':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdDeli.DeleteRow();
            }
        break;
    }
 }
 //--------------------------------------------------------
 function OnUnDelete()
{              
     grdDeli.UnDeleteRow();
}
//---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
        
        case 'Detail':
            shex00030_1.Call();
        break;
      }  
 }
//-------------------------------------------------------
function OnGridCellClk()
{
    if(grdOrder.row>0)
        txttsa_sotakeoutd_pk.text = grdOrder.GetGridData(grdOrder.row, G1_pk);
    shex00030_1.Call('SELECT');    
}
</script>

<body>
    <!------------------------------------------------------------>
    <gw:data id="shex00030" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="sale.sp_sel_shex00030_export_new" > 
                  <input > 
                     <input bind="lstCompany" /> 
                     <input bind="dtOrderF" /> 
                     <input bind="dtOrderT" /> 
                     <input bind="dtDeliF" /> 
                     <input bind="dtDeliT" /> 
                     <input bind="txtPartnerID" /> 
                     <input bind="txtItemID" /> 
                     <input bind="txtDeptID" /> 
                  </input> 
                <output bind="grdOrder" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------>
    <gw:data id="shex00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="sale.sp_sel_shex00030_1_export" parameter="0,1,2,3,4,5,6,7" procedure="sale.sp_upd_shex00030_1_export"> 
                  <input > 
                     <input bind="txttsa_sotakeoutd_pk" /> 
                  </input> 
                <output bind="grdDeli" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table border="0" style="width: 100%; height: 100%">
        <tr style="height: 10%">
            <td width='100%'>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 50%">
                        <td width="10%" align="right">
                            Company
                        </td>
                        <td width="37%">
                            <gw:list id="lstCompany" styles='width:100%'>
                                <data>
								    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>||
							    </data>
							</gw:list>
                        </td>
                        <td width="10%" align="right">
                            Department
                        </td>
                        <td width="38%">
                            <gw:textbox id="txtDeptID" styles="width:29%" csstype="mandatory" onenterkey="OnSearch()" />
                            <gw:textbox id="txtDeptNM" styles="width:70%" csstype="mandatory" onenterkey="OnSearch()" />
                        </td>
                        <td width="5%" colspan="2" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 50%">
                        <td align="right" nowrap>
                            Order Date
                        </td>
                        <td>
                            <gw:datebox id="dtOrderF" styles="width:100%" lang="1" onchange="OnSearch()" nullaccept />
                            ~
                            <gw:datebox id="dtOrderT" styles="width:100%" lang="1" onchange="OnSearch()"  nullaccept/>
                        </td>
                        <td align="right" nowrap>
                            Release Date
                        </td>
                        <td>
                            <gw:datebox id="dtDeliF" styles="width:100%" lang="1" onchange="OnSearch()" nullaccept />
                            ~
                            <gw:datebox id="dtDeliT" styles="width:100%" lang="1" onchange="OnSearch()" nullaccept />
                        </td>
                        <td align="right">
                        </td>
                    </tr>
                    <tr style="height: 50%">
                        <td align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BillTo')">Bill To </b>
                        </td>
                        <td>
                            <gw:textbox id="txtPartnerID" styles="width:29%" csstype="mandatory" onenterkey="OnSearch()" />
                            <gw:textbox id="txtPartnerName" styles="width:70%" csstype="mandatory" onenterkey="OnSearch()" />
                        </td>
                        <td align="right">
                            <b>Item</b>
                        </td>
                        <td>
                            <gw:textbox id="txtItemID" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 60%">
            <td>
                <%--<gw:grid id="grdOrder" header='_tsa_saleorderd|_tco_item_pk|Ord. No.|Ord. Date|Req Del Date|Cust. ID|Cust. NM|Item Code|Item Name|Color Size|_Unit|Stock Prt|Stock Unprt|Ord Qty.|Price|Deli. Qty|Undeli. Qty.'
                    format='0|0|0|4|4|0|0|0|0|0|0|-0|-0|-0|-3|-0|-0' aligns='0|0|0|0|0|0|0|0|0|0|0|3|3|3|3|3|3'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|1300|1200|1200|850|1900|950|1500|1200|500|1100|1100|1000|700|900|1000'
                    styles="width:100%; height:100%" sorting="T" onselchange="OnGridCellClk()" acceptnulldate />--%>
                <gw:grid id='grdOrder' header='_PK|_TCO_ITEM_PK|Request Production Number|Request Date|Customer|PO No.|Release Date|Order Quantity|Item Code|Size|Printing|Cap Color Code|Body Color Code|Unit Price 2|Amount 2'
                    format='0|0|0|4|0|0|4|1|0|0|0|0|0|1|1' aligns='0|0|0|0|0|0|0|0|0|1|1|0|0|0|0'
                    check='||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%'onselchange="OnGridCellClk()" acceptnulldate />
            </td>
        </tr>
        <tr style="height: 30%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 20%">
                        </td>
                        <td style="width: 80%" align="center">
                            <gw:grid id="grdDeli" header='_pk|_tsa_sotakeoutd_pk|Request Production Number|_tco_item_pk|Release Date|Item Code|Order Quantity|Declaration Date'
                                format='0|0|0|0|4|0|1|4' aligns='0|0|0|0|0|0|3|0' check='|||||||' editcol='0|0|0|0|0|0|0|1'
                                widths='0|0|1200|0|1500|1300|1000|1000'autosize='T' styles="width:550; height:100%" sorting="T" acceptnulldate />
                        </td>
                        <td style="width: 1%" align="right" valign="top">
                            <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Detail')" />
                        </td>
                        <td style="width: 1%" align="right" valign="top">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Detail')" />
                        </td>
                        <td style="width: 1%" align="right" valign="top">
                            <gw:imgbtn img="udelete" alt="Delete" id="btnuDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%" align="right" valign="top">
                            <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Detail')" />
                        </td>
                        <td style="width: 10%">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txttsa_sotakeoutd_pk" styles='width:100%;display:none' />
</html>
