<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>W/I Packing : Pop Up Get Item from S/O</title>
</head>

<script>

var v_language  = "<%=Session("SESSION_LANG")%>";
var emp_pk      = "<%=Session("EMPLOYEE_PK") %>";
var full_name   = "<%=Session("USER_NAME") %>";

var G1_PK           = 0,
    G1_Ord_Date     = 1,
    G1_PO_No        = 2,
    G1_Style_PK     = 3, 
    G1_Style_Code   = 4,
    G1_Style_Name   = 5,
    G1_Ord_Qty      = 6,
    G1_Pack_Qty     = 7,
    G1_Bal_Qty      = 8,
    G1_Description  = 9;
       
var G2_PO_No     = 0,
    G2_Spec01    = 1,
    G2_Spec02    = 2,
    G2_Spec03    = 3,
    G2_Spec04    = 4,
    G2_Spec05    = 5,
    G2_Ord_Qty   = 6,
    G2_Pack_Qty  = 7,
    G2_Bal_Qty   = 8,
    G2_Prod_Qty  = 9,
    G2_WI_Qty    = 10,
    G2_Spec01_PK = 11,
    G2_Spec02_PK = 12,
    G2_Spec03_PK = 13,
    G2_Spec04_PK = 14,
    G2_Spec05_PK = 15,
    G2_STItemPK  = 16,
    G2_SOD_PK    = 17,  
    G2_SO_PK     = 18;
        
//=======================================================================
   
function BodyInit()
{
    System.Translate(document);
    //-------------------------------
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));
    //-------------------------------
    FormatGrid();    
    //------------------------------- 
    OnHide();
    //-------------------------------
    OnSearch('grdSO');
    //-------------------------------   
}
//=======================================================================
function FormatGrid()
{
    var ctrl = grdDetail.GetGridControl();  
      
    ctrl.MergeCells = 2;
    ctrl.MergeCol(G2_PO_No)  = true;
    ctrl.MergeCol(G2_Spec01) = true;
    ctrl.MergeCol(G2_Spec02) = true;
    ctrl.MergeCol(G2_Spec03) = true;
    ctrl.MergeCol(G2_Spec04) = true;
    ctrl.MergeCol(G2_Spec05) = true;

    ctrl.ColFormat(G2_Ord_Qty) = "###,###,###,###";
    ctrl.ColFormat(G2_Pack_Qty)= "###,###,###,###";
    ctrl.ColFormat(G2_Bal_Qty) = "###,###,###,###";
    ctrl.ColFormat(G2_Prod_Qty)= "###,###,###,###";
    ctrl.ColFormat(G2_WI_Qty)  = "###,###,###,###";    
    
    ctrl = grdSO.GetGridControl(); 
        
    ctrl.ColFormat(G1_Ord_Qty) = "###,###,###,###";
    ctrl.ColFormat(G1_Pack_Qty)= "###,###,###,###";
    ctrl.ColFormat(G1_Bal_Qty) = "###,###,###,###";
}

//=======================================================================
var p_search_specgrp = 0;

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00071':
            lbRecord.text = grdSO.rows-1 + " record(s)";
            
            if ( grdSO.rows > 1 )
            {
                grdSO.SetCellBold( 1, G1_Ord_Qty,  grdSO.rows - 1, G1_Ord_Qty,  true);
                grdSO.SetCellBold( 1, G1_Pack_Qty, grdSO.rows - 1, G1_Pack_Qty, true);
                grdSO.SetCellBold( 1, G1_Bal_Qty,  grdSO.rows - 1, G1_Bal_Qty,  true);
                grdSO.SetCellBgColor( 1, G1_Style_Code , grdSO.rows - 1, G1_Style_Name , 0xCCFFFF ); 
                
                grdSO.Subtotal( 0, 2, -1, '6!7!8','###,###,###');   
            }            
        break;
        
        case 'pro_dsep00071':
        
            p_search_specgrp = 0 ; 
                
            OnHide();           
            //-----------------------
            if ( lbSpecGrp01.text != '' )
            {
                grdDetail.GetGridControl().Cell(0, 0, G2_Spec01, 0, G2_Spec01) = lbSpecGrp01.text;
                
                chkSpecGrp01.value = 'Y';
                document.all("chkSpecGrp01").style.display      = ""    ;
                grdDetail.GetGridControl().ColHidden(G2_Spec01) = false ;
            }
            
            if ( lbSpecGrp02.text!= '' )
            {
                grdDetail.GetGridControl().Cell(0, 0, G2_Spec02, 0, G2_Spec02) = lbSpecGrp02.text;
                
                chkSpecGrp02.value = 'Y';
                document.all("chkSpecGrp02").style.display      = ""    ;
                grdDetail.GetGridControl().ColHidden(G2_Spec02) = false ;                                
            } 
            
            if ( lbSpecGrp03.text!= '' )
            {
                grdDetail.GetGridControl().Cell(0, 0, G2_Spec03, 0, G2_Spec03) = lbSpecGrp03.text;
                
                chkSpecGrp03.value = 'Y';
                document.all("chkSpecGrp03").style.display      = ""    ;
                grdDetail.GetGridControl().ColHidden(G2_Spec03) = false ;                
            }  
            
            if ( lbSpecGrp04.text!= '' )
            {
                grdDetail.GetGridControl().Cell(0, 0, G2_Spec04, 0, G2_Spec04) = lbSpecGrp04.text;
                
                chkSpecGrp04.value = 'Y';
                document.all("chkSpecGrp04").style.display      = ""    ;
                grdDetail.GetGridControl().ColHidden(G2_Spec04) = false ;                
            }
            
            if ( lbSpecGrp05.text!= '' )
            {
                grdDetail.GetGridControl().Cell(0, 0, G2_Spec05, 0, G2_Spec05) = lbSpecGrp05.text;
                
                chkSpecGrp05.value = 'Y';
                document.all("chkSpecGrp05").style.display      = ""    ;
                grdDetail.GetGridControl().ColHidden(G2_Spec05) = false ;                
            }
                
            //----------------------------------
            data_dsep00071_2.Call("SELECT"); 
            //---------------------------------- 
        break;
        
        case 'data_dsep00071_2':
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G2_Ord_Qty,  grdDetail.rows - 1, G2_Ord_Qty,  true);
                grdDetail.SetCellBold( 1, G2_Pack_Qty, grdDetail.rows - 1, G2_Pack_Qty, true);
                grdDetail.SetCellBold( 1, G2_Bal_Qty,  grdDetail.rows - 1, G2_Bal_Qty,  true);
                grdDetail.SetCellBold( 1, G2_Prod_Qty, grdDetail.rows - 1, G2_Prod_Qty, true);
                grdDetail.SetCellBold( 1, G2_WI_Qty,   grdDetail.rows - 1, G2_WI_Qty,   true);                
                
                grdDetail.SetCellBgColor( 1, G2_Bal_Qty,  grdDetail.rows - 1, G2_Bal_Qty,  0xCCFFFF );
                
                grdDetail.Subtotal( 0, 2, -1, '5!6!7!8!9','###,###,###');                
            }    
        break; 
        
        case 'pro_dsep00071_1':
            alert(txtReturnValue.text);
            
            OnSearch('grdSO');
        break;       
    }
}
//=======================================================================

function OnCellClk(obj)
{
    switch (obj.id)
    {
        case 'grdSO' :
            p_search_specgrp = 1 ;
        break;
    }    
}

//=======================================================================

function OnHide()
{
    chkSpecGrp01.value = 'N';
    chkSpecGrp02.value = 'N';
    chkSpecGrp03.value = 'N';
    chkSpecGrp04.value = 'N';
    chkSpecGrp05.value = 'N';
    
    document.all("chkSpecGrp01").style.display = "none";
    document.all("chkSpecGrp02").style.display = "none";
    document.all("chkSpecGrp03").style.display = "none";
    document.all("chkSpecGrp04").style.display = "none";
    document.all("chkSpecGrp05").style.display = "none";
    
    grdDetail.GetGridControl().ColHidden(G2_Spec01) = true ;
    grdDetail.GetGridControl().ColHidden(G2_Spec02) = true ;
    grdDetail.GetGridControl().ColHidden(G2_Spec03) = true ;
    grdDetail.GetGridControl().ColHidden(G2_Spec04) = true ;
    grdDetail.GetGridControl().ColHidden(G2_Spec05) = true ;    
}

//=======================================================================
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
    
    if ( col == G2_Plan_Qty )
    {
        var dQuantiy;
        
        dQuantiy =  grdDetail.GetGridData(row,col)
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(0));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }         
        //---------------------------------------------
        grdDetail.Subtotal( 0, 2, -1, '5!6','###,###,###');
    } 

 }
//=======================================================================

function OnSearch(obj)
{
    switch(obj)
    {
        case 'grdSO':
            data_dsep00071.Call("SELECT");
        break;
    
        case 'grdDetail':
            
            if ( p_search_specgrp == 1 )                         
            {
                var t = 0 ;
                
                var array_po       = '';
                var array_so_pk    = '';
                var array_style_pk = '';
                var t_style_pk     = '';
                var t_style_name   = '';  
                
                for(var i = 1; i < grdSO.rows && t < 15; i++)
                {
                    if ( grdSO.GetGridControl().isSelected(i) == true )
                    {  
                        t = t + 1 ;    
                                           
                        array_po       = array_po       + grdSO.GetGridData( i, G1_PO_No)    + ',';
                        array_so_pk    = array_so_pk    + grdSO.GetGridData( i, G1_PK)       + ',';
						
						if ( grdSO.GetGridData( i, G1_Style_PK) != '')
						{
                        	array_style_pk = array_style_pk + grdSO.GetGridData( i, G1_Style_PK) + ','; 
						}	
                        
                        if ( t_style_pk == '' )
                        {
                            t_style_pk   = grdSO.GetGridData( i, G1_Style_PK ) ;
                            t_style_name = grdSO.GetGridData( i, G1_Style_Code ) + ' - ' + grdSO.GetGridData( i, G1_Style_Name ) ;
                        }                
                    }
                }
                                       
                array_po       = array_po.substring(       0, array_po.length-1       );
                array_so_pk    = array_so_pk.substring(    0, array_so_pk.length-1    ); 
                array_style_pk = array_style_pk.substring( 0, array_style_pk.length-1 );
                
                if ( array_so_pk == '' )
                {
                    alert('You must select one P/O.');
                }
                else
                {
                    txtArrayStylePK.text = array_style_pk ;
                    txtArraySOPK.text    = array_so_pk ;
                    lbPONo.text          = array_po ;
                    
                    txtStylePK.text      = t_style_pk ;
                    txtStyleName.text    = t_style_name ;
                    
                    pro_dsep00071.Call();
                }                                               
            }
            else
            {
                data_dsep00071_2.Call("SELECT");
            }    
            //-----------------------------------            
        break;               
    }
}

//=========================================================

function OnSelect(pos)
{
    switch (pos)
    {
        case 'Partial' :
                            
            var arr_data = new Array();
            // the last row is sub total --> no need to select 
            for(var i = 1; i < grdDetail.rows-1; i++ )
            {
                if ( grdDetail.GetGridControl().isSelected(i) == true )
                {
                     var arrTemp = new Array();
                         
                     for( var j = 0; j < grdDetail.cols; j++ )
                     {
                          arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
                     }
                         
                     arr_data[arr_data.length]= arrTemp;
                }
            }
            
            if ( arr_data != null )
            {
                var callerWindowObj = dialogArguments;    
                  
                callerWindowObj.txtArraySOPK.text = txtArraySOPK.text ;
                callerWindowObj.txtPONo.text      = lbPONo.text       ; 
                
                callerWindowObj.txtStylePK.text   = txtStylePK.text ; 
                callerWindowObj.txtStyleName.text = txtStyleName.text ;                                 
            }
                      
            window.returnValue =  arr_data;
            window.close();
            
        break;
        
        case 'ALL' :
            var arr_data = new Array();
            // the last row is sub total --> no need to select 
            for(var i = 1; i < grdDetail.rows-1; i++ )
            {
                 var arrTemp = new Array();
                     
                 for( var j = 0; j < grdDetail.cols; j++ ) 
                 {
                      arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
                 }
                     
                 arr_data[arr_data.length]= arrTemp;
            }

            if ( arr_data != null )
            {
                var callerWindowObj = dialogArguments;    
                  
                callerWindowObj.txtArraySOPK.text = txtArraySOPK.text ;
                callerWindowObj.txtPONo.text      = lbPONo.text       ;   
                
                callerWindowObj.txtStylePK.text   = txtStylePK.text ; 
                callerWindowObj.txtStyleName.text = txtStyleName.text ;            
            }
                                  
            window.returnValue =  arr_data;
            window.close();
            
        break;        
    }        
}

//=========================================================
function OnChangeGroupBy(obj)
{
    switch (obj.id)
    {
        case 'chkGroupByPODetail':
            if ( chkGroupByPODetail.value == 'Y' )
            {
                chkGroupByPO.value = 'N' ;
            }            
        break;
        
        case 'chkGroupByPO':
            if ( chkGroupByPO.value == 'Y' )
            {
                chkGroupByPODetail.value = 'N' ;
            }         
        break;
    }
}

//=========================================================
function OnProcess(pos)
{
    switch (pos)
    {
        case 'PackBalance' :
            if ( grdSO.row > 0 )
            {
                if ( confirm('Do you want to calculate packing balance for this order ?') )
                {                     
                }    
            }
        break;
    }
}
//=========================================================

</script>

<body>
    <!-------------------------------------------------------------------->
    <gw:data id="data_dsep00071" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsep00071"  > 
                <input bind="grdSO" >
			        <input bind="dtFrom" />
			        <input bind="dtTo" />
			        <input bind="txtPOStyle" />
			        <input bind="chkBal" />
                </input>
                <output bind="grdSO" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_dsep00071" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00071" > 
                <input>
                    <input bind="txtArrayStylePK" /> 
                </input>                 
                <output>                 
                    <output bind="txtSpecGroupPK01" />
                    <output bind="lbSpecGrp01" />                    
                    <output bind="txtSpecGroupPK02" />
                    <output bind="lbSpecGrp02" />
                    <output bind="txtSpecGroupPK03" />
                    <output bind="lbSpecGrp03" />
                    <output bind="txtSpecGroupPK04" />
                    <output bind="lbSpecGrp04" />
                    <output bind="txtSpecGroupPK05" />
                    <output bind="lbSpecGrp05" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsep00071_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dsep00071_2"  > 
                  <input bind="grdDetail" > 
                    <input bind="txtArraySOPK" />
					<input bind="txtSpecGroupPK01" />
					<input bind="chkSpecGrp01" />
					<input bind="txtSpecGroupPK02" />
					<input bind="chkSpecGrp02" />
					<input bind="txtSpecGroupPK03" />
					<input bind="chkSpecGrp03" />
					<input bind="txtSpecGroupPK04" />
					<input bind="chkSpecGrp04" />
					<input bind="txtSpecGroupPK05" />
					<input bind="chkSpecGrp05" />
					<input bind="chkGroupByPO" />
					<input bind="chkGroupByPODetail" />																				
                  </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>    
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 50%">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 5%">
                            Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            PO/SO/Style</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPOStyle" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdSO')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
                            Bal Y/N
                            <gw:checkbox id="chkBal" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSO')"></gw:checkbox>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdSO')" />
                        </td>
                        <td style="width: 14%; text-align: center">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 10%; white-space: nowrap; color: Purple; background-color: CCFFFF"
                            align="center">
                            Group By P/O
                            <gw:checkbox id="chkGroupByPO" styles="color:blue" defaultvalue="Y|N" value="Y" onclick="OnChangeGroupBy(this)"></gw:checkbox>
                            (M)
                            <gw:checkbox id="chkGroupByPODetail" styles="color:blue" defaultvalue="Y|N" value="N"
                                onclick="OnChangeGroupBy(this)"></gw:checkbox>
                            (D)
                        </td>                        
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdSO' header='_PK|Ord Date|P/O No|_Style_PK|Style Code|Style Name|Ord Qty|Pack WI Qty|Bal Qty|_Description'
                                format='0|4|0|0|0|0|0|0|0|0' aligns='0|1|0|0|0|0|3|3|3|0' defaults='|||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0' widths='1000|1200|1500|0|2500|4500|1200|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' onclick="OnCellClk(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <gw:textbox id="txtSpecGroupPK01" styles="display:none" />
                            <gw:label id="lbSpecGrp01" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                        </td>
                        <td style="width: 2%" align="left">
                            <gw:checkbox id="chkSpecGrp01" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <gw:textbox id="txtSpecGroupPK02" styles="display:none" />
                            <gw:label id="lbSpecGrp02" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                        </td>
                        <td style="width: 2%" align="left">
                            <gw:checkbox id="chkSpecGrp02" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <gw:textbox id="txtSpecGroupPK03" styles="display:none" />
                            <gw:label id="lbSpecGrp03" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                        </td>
                        <td style="width: 2%" align="left">
                            <gw:checkbox id="chkSpecGrp03" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <gw:textbox id="txtSpecGroupPK04" styles="display:none" />
                            <gw:label id="lbSpecGrp04" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                        </td>
                        <td style="width: 2%" align="left">
                            <gw:checkbox id="chkSpecGrp04" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <gw:textbox id="txtSpecGroupPK05" styles="display:none" />
                            <gw:label id="lbSpecGrp05" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                        </td>
                        <td style="width: 2%" align="left">
                            <gw:checkbox id="chkSpecGrp05" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 12%; white-space: nowrap" align="center">
                            <gw:label id="lbPONo" styles='width:100%;font:8pt'></gw:label>
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnQuery" img="2" text="Query" onclick="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnSelect" img="2" text="Select" onclick="OnSelect('Partial')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="select" alt="Select ALL" id="btnSelect01" onclick="OnSelect('ALL')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdDetail' header='P/O No|Spec1|Spec2|Spec3|Spec4|Spec5|Ord Qty|Packed Qty|Bal Qty|Prod Qty|WI Qty|_Spec01_PK|_Spec02_PK|_Spec03_PK|_Spec04_PK|_Spec05_PK|_tco_stitem_pk|_array_so_pk|_so_po_pk'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|1|1|1|1|1|3|3|3|3|3|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||' editcol='0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1500|2000|2000|2000|2000|2000|1200|1200|1200|1200|1200|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------->
<gw:textbox id="txtArrayStylePK" styles='width:100%; display:none' />
<gw:textbox id="txtArraySOPK" styles='width:100%; display:none' />
<gw:textbox id="txtStylePK" styles='width:100%;display:none' />
<gw:textbox id="txtStyleName" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------->
<gw:textbox id="txtSOPK" styles='width:100%;display:none' />
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------->
</html>
