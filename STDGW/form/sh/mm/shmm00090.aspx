<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>General Report</title>
</head>
<%  ESysLib.SetUser("inv")%>

<script>

var G3_Lot_No = 4 ;
//----------------------------------------------------------------------------------------

function BodyInit()
{
    //----------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate = dtFrom_Ledger1.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom_Monthly.value=ldate ;
    dtFrom_Ledger1.value=ldate;
    
    //----------------
    BindingDataList();
    SetGridFormat();
    //----------------    
}

//----------------------------------------------------------------------------------------

function BindingDataList()
{
    var data = "";
    //-----------------    
    
    data = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || '-' || grp_nm from comm.tco_itemgrp where del_if = 0 and Mat_yn='Y' and use_yn = 'Y'")%>|ALL|Select ALL"; 
   
    lstGroup_Monthly.SetDataText(data);
    lstGroup_Monthly.value = 'ALL';
    //------------------------------------
     lstGroup_Monthly2.SetDataText(data);
    lstGroup_Monthly2.value = 'ALL';
    //-----------------
    data = "<%=ESysLib.SetListDataSQL(" SELECT 'IN-' || code,'IN-' || code_nm FROM sale.lg_code a, sale.lg_code_group b WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGPO2001' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 UNION SELECT 'OUT-' || code, 'OUT-' ||code_nm FROM sale.lg_code a, sale.lg_code_group b WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIV0040' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0")%>|ALL|Select ALL"; 
    lstTransType_Ledger1.SetDataText(data);
    lstTransType_Ledger1.value = 'ALL' ;
    //-----------------
    
}

//---------------------------------------------------------------------------------------------------

function SetGridFormat()
{
    var ctr1 = grdItemLedger.GetGridControl(); 
  
    ctr1.MergeCells  = 2 ;	
    ctr1.MergeCol(0) = true ;	
    ctr1.MergeCol(1) = true ;   	
    ctr1.MergeCol(2) = true ;	
    ctr1.MergeCol(3) = true ;	
    ctr1.MergeCol(4) = true ;	
    ctr1.MergeCol(5) = true ;
    
    var ctr2 = grdMonthly1.GetGridControl(); 
      
    ctr2.MergeCells  = 2 ;	
    ctr2.MergeCol(0) = true ; 
    ctr2.MergeCol(1) = true ;   	
    ctr2.MergeCol(2) = true ;	
    ctr2.MergeCol(3) = true ;	
    ctr2.MergeCol(4) = true ;	
    
}

//---------------------------------------------------------------------------------------------------

function OnSearch(obj)
{
    switch(obj)
    {
        
        case '3':
            shmm00090_2.Call('SELECT');  
        break;
       case '4':      
            shmm00090_5.Call('SELECT');
        break;         
    }
}

//---------------------------------------------------------------------------------------------------

function OnPrint()
{
    
   var url =System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00090.rpt&export_pdf=Y&procedure=inv.sp_rpt_shmm00090&parameter=" + dtFrom_Monthly.value +","+ dtTo_Monthly.value+","+ lstGroup_Monthly.value+","+txtItem_Monthly.text
     System.OpenTargetPage(url);

}

//---------------------------------------------------------------------------------------------------

function OnGetItem(obj)
{
    switch(obj)
    {
        case '1':
            // var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=Y|||||";
            var fpath = System.RootURL + "/form/fp/ab/fpab00110_tree.aspx";
            oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                    txtItemPK_Ledger.SetDataText(oValue[0]);
                    txtItem_Ledger.SetDataText(oValue[1]);
            }
        break;
        
        case '2':
           // var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=Y|||||";
            var fpath = System.RootURL + "/form/fp/ab/fpab00110_tree.aspx";
            oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');    
            
            if ( oValue != null )
            {
                    txtItemPK_Monthly.SetDataText(oValue[0]);
                    txtItem_Monthly.SetDataText(oValue[1]);
            }
        break;
        case '3':
            // var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx?group_type=Y|||||";
            var fpath = System.RootURL + "/form/fp/ab/fpab00110_tree.aspx";
            oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                    txtItemPK_Ledger.SetDataText(oValue[0]);
                    txtItemCode_Ledger1.SetDataText(oValue[1]);
            }
        break;
    }
}
function OnPopup(obj)
{       var fpath = System.RootURL + "/form/fp/ab/fpab00240.aspx";
        oValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
          
    switch(obj)
    {
        case '1':
               if ( oValue != null )
            {
                    lstWH_Ledger1.value=oValue[0];
           }
        break;
        
        case '2':
             
            if ( oValue != null )
            {
                    lstWH_Ledger.value =oValue[0];
             }
        break;
        case '3':
              
            if ( oValue != null )
            {
                    lstWH_Monthly.value=oValue[0];
              }
        break;
    }
}
//---------------------------------------------------------------------------------------------------

function ReceiveData(obj)
{
    switch(obj.id)
    {
        //case 'shmm00090_4':
        //break;
        case 'shmm00090_5':
            if(grdItemLedger.rows > 1)
            {
                lblBeginQty.text='Begin :'+grdItemLedger.GetGridData(1,9);
                grdItemLedger.Subtotal( 0, 2,0, '7!8','###,###,###.######');
                //grdItemLedger.SetGridText( grdItemLedger.rows-1, 7,   grdItemLedger.GetGridData( grdItemLedger.rows-2, 7));
            }
        break;
        case 'shmm00090_2':
            lblRecord_Monthly.text = grdMonthly1.rows -1 + " record(s)";            
            grdMonthly1.Subtotal( 0, 2,0, '5!6!7!8');
           // grdMonthly1.SetGridText( grdMonthly1.rows-1, 7,   grdMonthly1.GetGridData( grdItemLedger.rows-2, 7));
        break; 
    }
}

//---------------------------------------------------------------------------------------------------

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00090_2" onreceive="ReceiveData(this)"> 
        <xml> 
            <dso id="1" type="grid" function="inv.sp_sel_shmm00090_1" > 
                <input> 
                    <input bind="dtFrom_Monthly" />
                    <input bind="dtTo_Monthly" />
                    <input bind="lstGroup_Monthly" />
                    <input bind="txtItem_Monthly" />
                </input> 
                <output bind="grdMonthly1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00090_5" onreceive="ReceiveData(this)"> 
        <xml> 
            <dso id="1" type="grid" function="inv.sp_sel_shmm00090_5" > 
                <input> 
                    <input bind="dtFrom_Ledger1" />
                    <input bind="dtTo_Ledger1" />
                    <input bind="txtItemCode_Ledger1" />
                    <input bind="txtItem_SlipNo" />
                    <input bind="lstTransType_Ledger1" />
                    <input bind="lstGroup_Monthly2" /> 
                </input> 
                <output bind="grdItemLedger" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="height: 100%; width: 100%">
        <tr valign="top" style="height: 100%">
            <td style="width: 100%">
                <gw:tab id="idTab" style="width: 100%; height: 100%">
                <table style="height: 100%; width: 100%" border="1" name="Item In/Out Ledger">
                    <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 50%">
                                    <td style="width: 10%" align="right">
                                        Date</td>
                                    <td style="width: 20%" align="left">
                                        <gw:datebox id="dtFrom_Ledger1" lang="<%=Application("Lang")%>" />
                                         &nbsp;&raquo;&raquo;&nbsp<gw:datebox id="dtTo_Ledger1" lang="<%=Application("Lang")%>" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Slip No</td>
                                    <td style="width: 30%" >
                                        <gw:textbox id="txtItem_SlipNo" styles="width:100%;" onenterkey="OnSearch('4')" />
                                    </td>
                                    <td style="width: 5%"></td><td></td>
                                    <td style="width: 8%" align="right">
                                        <gw:imgbtn id="btnSearch_2" img="search" alt="Search" text="Search" onclick="OnSearch('4')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnPrint_2" img="excel" alt="Print" text="Print" styles="display:none" onclick="OnPrint()" />
                                    </td>
                                </tr>
                                <tr style="height: 50%">
                                    <td style="width: 10%;" align="right">
                                        Trans.Type
                                     </td>
                                    <td style="width: 20%;">
                                        <gw:list id="lstTransType_Ledger1" styles="width:100%" />
                                    </td>
                                   <td style="width: 10%" align="right">
                                        Group</td> 
                                       <td style="width: 30%">
                                        <gw:list id="lstGroup_Monthly2" styles="width:100%;" />
                                    </td> 
                                    <td  align="right">
                                        Item</td>
                                    <td style="width: 25%" >
                                        <gw:textbox id="txtItemCode_Ledger1" styles="width:100%;" onenterkey="OnSearch('4')" />
                                    </td>
                                    <td style="width: 8%" align="right" colspan=2>
                                        <gw:label id="lblBeginQty" styles="color: blue"> BeginQty</gw:label>
                                    </td>
                                 </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <gw:grid id='grdItemLedger' header='Item Code|Item Name|Stock Date|Slip No|Lot No|Test No|Trans Type|Input Qty|Output Qty|_Last Balance|_l_begin_qty'
                                format='0|0|4|0|0|0|0|-6|-6|0|0' aligns='0|0|0|0|0|0|0|3|3|3|0' defaults='||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0'
                                widths='1200|2500|1200|1400|1000|1000|1100|1000|1500|800|0'
                                sorting='T' styles="width:100%; height:100%" autosize='T' />
                        </td>
                    </tr>
                </table>
                <table style="height: 100%; width: 100%" border="1" name="Item In/Out Monthly" id="TabInOutMonthly">
                    <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 50%">
                                    <td style="width: 10%" align="right">
                                        Date</td>
                                    <td style="width: 30%" align="left">
                                        <gw:datebox id="dtFrom_Monthly" lang="<%=Application("Lang")%>" />
                                        ~<gw:datebox id="dtTo_Monthly" lang="<%=Application("Lang")%>" /></td>
                                    <td style="width: 10%" align="right">
                                        Group</td>
                                    <td style="width: 30%">
                                        <gw:list id="lstGroup_Monthly" styles="width:100%;" />
                                    </td>
                                    <td style="width: 18%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnSearch_Monthly" img="search" alt="Search" text="Search" onclick="OnSearch('3')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnPrint_Monthly" img="printer" alt="Print" text="Print"  onclick="OnPrint()" />
                                    </td>
                                </tr>
                                <tr style="height: 50%">                                
                                    <td style="width: 10%" align="right">
                                        <b>Item</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtItem_Monthly" styles="width:100%;" onenterkey="OnSearch('3')"/>
                                    </td>
                                    <td style="width: 5%" align="right">
                                       </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td colspan="3" align=right>
                                        <gw:label id="lblRecord_Monthly" styles="color: blue">record(s)</gw:label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%" id="NotInclude_Stock_No">
                        <td>
                            <gw:grid id="grdMonthly1" header="Item Code|Item Name|UOM|Lot No|Test No|Begin|Input|Output|End|_Unit Weight|_Total Weight|_Price|_Amount"
                                format="0|0|0|0|0|-6|-6|-6|-6|0|0|0|0" aligns="0|0|1|0|0|3|3|3|3|3|3|3|3" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                widths="1200|3500|700|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300" 
                                styles="width:100%; height:100%" sorting="T"  />
                        </td>
                    </tr>
                </table>
                </gw:tab>
               </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
<gw:textbox id="txtItemPK_Ledger" styles="display: none" />
<gw:textbox id="txtItemPK_Monthly" styles="display: none" />
<gw:textbox id="txtBegin" styles="display: none" />
<gw:textbox id="txtRecords" styles="display: none" />
<gw:textbox id="txtPage" styles="display: none" />
<!------------------------------------------------------->
</html>
