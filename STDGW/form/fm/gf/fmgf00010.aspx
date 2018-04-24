<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Consumption Loading</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 
var //G1_RowNum           = 0 ,
    G1_Process_DT       = 0 ,
    G1_WH_Prod          = 1 ,
    G1_Item_Name        = 2 ,
    G1_Prod_Qty         = 3 ,
    G1_Item_UOM         = 4,
    G1_GRP_NM           = 5 ,
    G1_ST_Item_Code     = 6 ,
    G1_ST_Item_Name     = 7 ,
    G1_Item_UOM         = 8 ,
    G1_Norm_Qty         = 9 ,
    G1_Loss_Rate        = 10 ,
    G1_tac_stocknormd_pk= 11 ,
    G1_Need_Qty         = 12 ,
    G1_Map_Qty          = 13 ,
    G1_Item_Code        = 14 ,
    G1_Item_Name        = 15,
    G1_Qty              = 16 ,
    G1_WH_MAT           = 17 ;
// grdSearch
var G0_takein_dt 	= 0,
	G0_prod_code	= 1,
	G0_WH_PK		= 2,
	G0_Prod_WH		= 3;
//--------------------------------------------------------------
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
        right.style.width="80%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 } 		
//------------------------------------------------------------------------
	        
function BodyInit()
{  
        BindingData();
        //-----------
        MergeColumn();    
        SetButton();   
}
//---------------------------------------------------------------------
function BindingData()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 ")%>";
    lstCompany.SetDataText(ls_data);
    
    grdTO.GetGridControl().FrozenCols = 4;
	txtProdCode.SetEnable(false);
	txtProdName.SetEnable(false);
	txtMatCode.SetEnable(false);
	txtMatName.SetEnable(false);	
	var l_month = dtTakein_fr.value ;
	l_month = l_month.substring(0, 6);
	txtMonth.text = l_month;
    fmgf00010_1.Call('SELECT');
}

//---------------------------------------------------------------------
function MergeColumn()
{
	grdSearch.GetGridControl().MergeCells = 2 ; 
	grdSearch.GetGridControl().MergeCol(0) = true ; 
		
    grdTO.GetGridControl().MergeCells = 2 ; 
        
    //grdTO.GetGridControl().MergeCol(0) = true ; 
    grdTO.GetGridControl().MergeCol(0) = true ; 
    grdTO.GetGridControl().MergeCol(1) = true ; 
    grdTO.GetGridControl().MergeCol(2) = true ; 
    grdTO.GetGridControl().MergeCol(3) = true ; 
    grdTO.GetGridControl().MergeCol(4) = true ;
    grdTO.GetGridControl().MergeCol(5) = true ;
    grdTO.GetGridControl().MergeCol(6) = true ;
    grdTO.GetGridControl().MergeCol(7) = true ;
    grdTO.GetGridControl().MergeCol(8) = true ;
    grdTO.GetGridControl().MergeCol(9) = true ;
    grdTO.GetGridControl().MergeCol(10) = true ;
    grdTO.GetGridControl().MergeCol(11) = true ;
    grdTO.GetGridControl().MergeCol(12) = true ;
    grdTO.GetGridControl().MergeCol(13) = true ;
    
    ctrl = grdTO.GetGridControl();
    
    ctrl.ColFormat(G1_Prod_Qty)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_Norm_Qty)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_Loss_Rate)   = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_Need_Qty)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_Map_Qty)     = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_Qty)         = "###,###,###,###,###.##";   
}

//---------------------------------------------------------------------
function OnPopUp(iObj)
{
    var i ;
    switch(iObj)
    {      
        case 1:
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N&item_code="+ txtProdCode.text +"&item_name=" ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');      
            if(obj != null)
            {
				txtProductPK.text = obj[0] ; //product PK
                txtProdCode.text = obj[1] ; //product code
				txtProdName.text = obj[2] ; //product name
            }   
        break;        
        case 2:
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=Y&item_code="+ txtMatCode.text +"&item_name=";
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
             if(obj != null)
            {
                txtMatCode.text = obj[1] ; // material code
				txtMatName.text = obj[2] ; // material name
				txtMatPK.text = obj[0] ; // material PK
            }   
        break;
        case 3:
            var path = System.RootURL + "/form/fm/gf/fmgf00011.aspx" ;
            var obj = System.OpenModal( path ,1000 , 700 ,  'resizable:yes;status:yes');        
        break;       
    }
}
//--------------------------------------------------
function OnSearch(obj)
{
    switch (obj)
    {
        case 1:
			if(grdSearch.row > 0)
			{
	             txtWH.text =  grdSearch.GetGridData(grdSearch.row, G0_WH_PK); // warehouse PK
	             txtTakeInDate.text = grdSearch.GetGridData(grdSearch.row, G0_takein_dt); // takein date
				 txtProd_Grid.text = grdSearch.GetGridData(grdSearch.row, G0_prod_code); // product code
	             fmgf00010.Call('SELECT')
			}				 
        break;
        case 2:
			var l_month = dtTakein_fr.value ;
			l_month = l_month.substring(0, 6);
			txtMonth.text = l_month;		
            fmgf00010_1.Call('SELECT')
        break;
    }   
}
//--------------------------------------------------
function OnSelectChange(iObj)
{
    switch(iObj)
    {
        case 'Company':
            txtTco_company_pk.text = lstCompany.value;
        break;
    }
}
//------------------------------------------------
function OnExcel(obj)
{
    switch (obj)
    {
        case 1:
            var url = System.RootURL + "/reports/fm/gf/fmgf00010.aspx?company="+lstCompany.value+"&itemCode="+txtProdCode.text+"&matCode="+txtMatCode.text+"&transdate="+dtTrans.value ;
             window.open(url)
        break;
        case 2:
            var url = System.RootURL + "/reports/fm/gf/fmgf00010_1.aspx?std_ym="+dtTrans.value ;
            window.open(url)
        break;
    }
}

//---------------------------------------------------------------------

function OnDataReceive(po_oData)
 { 
     var i, ctrl, lNeed_Qty, lMap_Qty, l_tac_stocknormd_pk ;
     
     lNeed_Qty = 0 ;
     lMap_Qty = 0 ;
     
      switch (po_oData.id)         
      {		        
            case "pro_fmgf00011_1" :
                 alert(txtReturnValue.text);
                 OnSearch(2);
            break;   
            case "pro_fmgf00011_2" :
                 alert(txtReturnValue.text);
                 OnSearch(2);
            break;
            case "fmgf00010":       
                
                ctrl = grdTO.GetGridControl();
                
                if(ctrl.rows > 1)
                {
                    grdTO.AddRow();
                    l_tac_stocknormd_pk = 0;
                    
                    for (i = 1; i < grdTO.rows ; i++)
                    {
                        
                        if( (Trim(grdTO.GetGridData(i, G1_Need_Qty)) == '') || ( Trim(grdTO.GetGridData(i, G1_Need_Qty)) != '' && parseFloat(grdTO.GetGridData(i, G1_Need_Qty))==0 )  )
                        {                            
                            grdTO.SetCellBgColor( i, G1_ST_Item_Code, i, G1_WH_MAT,   0xd4d2ff );
                        }                    
                        else if( parseFloat(grdTO.GetGridData(i, G1_Need_Qty)) > parseFloat(grdTO.GetGridData(i, G1_Map_Qty)) )
                        {
                            grdTO.SetCellBgColor( i, G1_ST_Item_Code, i, G1_WH_MAT, 0xCCFFFF );
                        }
                        
                        if( (Trim(grdTO.GetGridData(i, G1_Need_Qty)) != '') && (grdTO.GetGridData(i, G1_tac_stocknormd_pk) != l_tac_stocknormd_pk ) )
                        {
                            lNeed_Qty += parseFloat(grdTO.GetGridData(i, G1_Need_Qty)) ;
                            l_tac_stocknormd_pk = grdTO.GetGridData(i, G1_tac_stocknormd_pk);
                        }                           
                        if(Trim(grdTO.GetGridData(i, G1_Qty)) != '' )
                        {
                            lMap_Qty += parseFloat(grdTO.GetGridData(i, G1_Qty)) ;                        
                        }                               
                            
                    }
                  grdTO.SetGridText(grdTO.rows - 1, G1_Need_Qty, lNeed_Qty ) ;
                  grdTO.SetGridText(grdTO.rows - 1, G1_Map_Qty, lMap_Qty ) ;
                  
                  grdTO.SetGridText(grdTO.rows - 1, G1_WH_Prod, "TOTAL");
                  
                  grdTO.SetCellBgColor(grdTO.rows-1, 0, grdTO.rows-1, grdTO.cols - 1, 0xA9EBD7);     
                  grdTO.SetCellBold(grdTO.rows - 1, 0, grdTO.rows - 1, grdTO.cols - 1, true);                                  
                     //------------------------
                    for ( i = 1 ; i < grdTO.rows ; i++ )
                    {
                         if ( grdTO.GetGridData( i, 18 ) != "" )
                        {
                            grdTO.GetGridControl().Cell( 7 , i , 0 , i, 18 ) = 0x808080;                                  
                        } 
                    } 
                    for ( i = 1 ; i < grdTO.rows ; i++ )
                    {
                         if ( grdTO.GetGridData( i, 18 ) != "" )
                        {
                            idBtnConfirm.SetEnable(false);
                            idCancelC.SetEnable(true);                            
                            idBtnProcess.SetEnable(false);
                            idBtnCancel.SetEnable(false);                            
                            break;
                        } 
                    }                     
              }
         
            break;
            
            case "pro_fmgf00011_5" :
                 alert(txtReturnValue.text);
                 OnSearch(2);
            break;
               
            case "pro_fmgf00011_6" :
                 alert(txtReturnValue.text);
                 OnSearch(2);
            break;  
             
            case "fmgf00010_1" :
                 //-----------------
                 txtWH.text         = '' ;
                 txtTakeInDate.text = '' ;
                 SetButton();
                 //-----------------
                 fmgf00010.Call("SELECT");
            break;              
      }  
 }
//------------------------------------------------

function OnProcess(pos)
{
      switch (pos)         
      {		   
            case 'Confirm' :
                if(grdSearch.row < 1)
                {
                    alert('Please choose the Input Date!!!');
                    return ;
                }
                txtProcessDT.text = grdSearch.GetGridData(grdSearch.row, G0_takein_dt );
                pro_fmgf00011_5.Call();
            break ;      
            case 'CancelCon' :
                if(grdSearch.row < 1)
                {
                    alert('Please choose the Input Date!!!');
                    return ;
                }
                txtProcessDT.text = grdSearch.GetGridData(grdSearch.row, G0_takein_dt);            
                pro_fmgf00011_6.Call();
            break ;  
            case 'AutoMap':
				//txtTakeInDate.text = grdSearch.GetGridData(grdSearch.row, 2);
				var l_from_dt, l_to_dt  ;
				l_from_dt = dtTakein_fr.text ;
				l_to_dt = dtTakein_to.text ;
				if(confirm('Are you sure to process from date ' +  l_from_dt + ' and ' + l_to_dt + ' ?'))				
				{
                	pro_fmgf00011_1.Call();
				}					
            break ; 
            case 'CancelMap' :
				var l_month = dtTakein_fr.value;
				txtMonth.text = l_month.substring(0, 6) ;
                pro_fmgf00011_2.Call();
            break ;                         
      }      
}
//---------------------------------------------------------------------
function SetButton()
{
    if(grdSearch.rows > 1)
    {
        idBtnConfirm.SetEnable(true);
        idCancelC.SetEnable(true);
        idBtnProcess.SetEnable(true);
        idBtnCancel.SetEnable(true);
        idReport1.SetEnable(true);
        idReport2.SetEnable(true);
    }        
    else
    {
        idBtnConfirm.SetEnable(false);
        idCancelC.SetEnable(false);
        idBtnProcess.SetEnable(true);
        idBtnCancel.SetEnable(false);
        idReport1.SetEnable(false);
        idReport2.SetEnable(false);    
    }
}
function OnReset()
{
	txtProductPK.text = "";
	txtMatPK.text = "";
	txtProdCode.text = "";
	txtProdName.text = "";
	txtMatCode.text = "";
	txtMatName.text = "";
}
//---------------------------------------------------------------------
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00011_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00011_1" > 
                <input>
                    <input bind="dtTakein_fr" /> 
					<input bind="dtTakein_to" /> 
					<input bind="lstCompany" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00011_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00011_6" > 
                <input>
                    <input bind="lstCompany" /> 
                    <input bind="txtProcessDT" />                     
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00011_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00011_2" > 
                <input>
                    <input bind="txtMonth" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <gw:data id="fmgf00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="ACNT.sp_sel_fmgf00010" > 
                <input bind="grdTO" >
                    <input bind="lstCompany" /> 
                    <input bind="txtWH" />
                    <input bind="txtProd_Grid" /> 
                    <input bind="txtMatPK" /> 
                    <input bind="txtTakeInDate" /> 
                </input>
                <output  bind="grdTO" />
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <gw:data id="fmgf00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="ACNT.sp_sel_fmgf00010_1" > 
                <input bind="grdSearch" >
                    <input bind="lstCompany" /> 
                    <input bind="txtMonth" /> 
                </input>
                <output  bind="grdSearch" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00011_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="ACNT.sp_pro_fmgf00011_5" > 
                <input>
                    <input bind="txtProcessDT" /> 
                    <input bind="lstCompany" />                     
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1" 	cellpadding="0" cellspacing="0">
        <tr style="height: 10%;">
            <td>
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
					<tr >
						<td style="width:10%" ></td>
						<td style="width:15%" ></td>
						<td style="width:13%" ></td>
						<td style="width:10%" ></td>
						<td style="width:2%" ></td>
						<td style="width:10%" ></td>
						<td style="width:20%" ></td>
						<td style="width:5%" ></td>
						<td style="width:5%" ></td>
						<td style="width:5%" ></td>
						<td style="width:5%" ></td>
					</tr>
                    <tr style="height:5%;">
                        <td align="right">Company&nbsp;</td>
                        <td align="left">
                            <gw:list id="lstCompany" styles="width: 100%" onchange="OnSelectChange('Company')" />
                        </td>
                        <td align="right">Takein Date&nbsp;</td>
                        <td align="left" >
                            <gw:datebox id="dtTakein_fr" lang="1" type="date" />
                        </td>
						<td>~</td>
						<td align="left"><gw:datebox id="dtTakein_to" lang="1" type="date" /></td>
                        <td align="right">
                            <gw:imgbtn id="idSearch" img="search" onclick="OnSearch(2)" />
                        </td>
                        <td align="right">
                            <gw:icon id="idBtnConfirm" img="in" text="Confirm" onclick="OnProcess('Confirm')" />
                        </td>
                        <td align="right">
                            <gw:icon id="idCancelC" img="in" text="Cancel Confirm" onclick="OnProcess('CancelCon')" />
                        </td>
                        <td align="right">
                            <gw:icon id="idBtnProcess" img="in" text="Process" styles='width:100%' onclick="OnProcess('AutoMap')" />
                        </td>
                        <td align="right">
                            <gw:icon id="idBtnCancel" img="in" text="Cancel Process" styles='width:100%' onclick="OnProcess('CancelMap')" />
                        </td>
                    </tr>
					<tr style="height:5%;">
						<td align="right"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">Product&nbsp;</b></td>
						<td align="left"><gw:textbox id="txtProdCode" styles="width:100%" csstype="mandatory" /></td>
						<td align="left"><gw:textbox id="txtProdName" styles="width:100%" csstype="mandatory" /></td>
						<td colspan="2" align="right"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(2)">Material&nbsp;</b></td>
						<td align="left"><gw:textbox id="txtMatCode" styles="width:100%" csstype="mandatory" /></td>
						<td align="left" colspan="2"><gw:textbox id="txtMatName" styles="width:100%" csstype="mandatory" /></td>
						<td align="left"><gw:imgBtn id="idBtnReset" img="reset" onclick="OnReset()" /></td>
                        <td align="right">
                            <gw:imgbtn id="idReport1" img="excel" alt="Report" onclick="OnExcel(1)" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="idReport2" img="excel" alt="Report" onclick="OnExcel(2)" />
                        </td>						
					</tr>
                </table>
            </td>
        </tr>
        <tr style="height: 90%;">
            <td>
                <table style="height: 100%; width: 100%" border="1">
                    <tr style="height: 100%">
                        <td style="width: 25%" id="left">
                            <gw:grid 
							id='grdSearch' 
                            header='Takein Date|Prod Code|_WH_PK|Prod WH' 
                            format='4|0|0|0' 
                            aligns='0|0|0|0'
                            defaults='|||' 
                            editcol='0|0|0|0' 
                            widths='1500|1500|0|1500' 
                            styles='width:100%; height:100%'
                            acceptNullDate="T" 
                            oncellclick="OnSearch(1)" />
                        </td>
                        <td style="width: 80%" id="right">
                            <gw:grid 
							id='grdTO' 
							header='Takein Date|Prod WH|Prod Name|Prod Qty|UOM|GRP NM|ST Mat Code|ST Mat Name|Mat UOM|Norm Qty|Loss Rate(%)|_tac_stocknormd_pk|Need Qty|Map Qty|Mat Code|Mat Name|Mat Qty|WH MAT|_APPROVE_TRANS_PK'
                            format='4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|3|1|0|0|0|1|3|3|0|3|3|0|0|3|0|0'
                            defaults='||||||||||||||||||' 
							editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
							widths='1200|1500|2000|1500|1000|1500|1500|2000|1000|1500|1500|0|1500|1500|1500|2000|1500|1500|0'
                            styles='width:100%; height:100%' 
							acceptNullDate="T" 
							/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtTco_company_pk" text="" styles='display:none;' />
    <gw:textbox id="txtWH" text="" styles='display:none;' />
    <gw:textbox id="txtTakeInDate" text="" styles='display:none;' />
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtProcessDT" maxlen="100" styles='width:100%;display:none' />
	<gw:textbox id="txtProductPK" styles='width:100%;display:none' />
	<gw:textbox id="txtMatPK" styles='width:100%;display:none' />
	<gw:textbox id="txtMonth" styles='width:100%;display:none' />
	<gw:textbox id="txtProd_Grid" styles='width:100%;display:none' />
    <!------------------------------------------------------------------------------->
</body>
</html>
