<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Transfer Request</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>
var flag;

//-------------------
var G1_PK                       = 0 ;

var G1_DETAIL_PK        = 0,
    G1_Seq              = 1,
    G1_REF_NO           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_REQ_ITEM_CODE    = 4,
    G1_REQ_ITEM_NAME    = 5,
    G1_TRANS_ITEM_PK    = 6,
    G1_TRANS_ITEM_CODE  = 7,
    G1_TRANS_ITEM_NAME  = 8,
    G1_REQ_QTY          = 9,
    G1_REQ_UOM          = 10,
    G1_TRANS_QTY        = 11,
    G1_TRANS_UOM        = 12,
    G1_UNIT_PRICE       = 13,
    G1_ITEM_AMT         = 14,
    G1_VAT_RATE         = 15,
    G1_VAT_AMT          = 16,
    G1_TOTAL_AMT        = 17,
    G1_LOT_NO           = 18,
    G1_REQUEST_D_PK     = 19,
    G1_REMARK           = 20,
    G1_MASTER_PK        = 21,
    G1_PO_PO_D_PK       = 22,
    G1_NULL_02          = 23;
    
var arr_FormatNumber = new Array();     
//--------------------------------------------------------------------- 

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document); 
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
     //---------------------------------- 
    var now = new Date(); 
    var lmonth, ldate;
    txtUser_PK.text = "<%=session("USER_PK")%>";
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------------- 
    txtStaff.SetEnable(false);
   // txtRefNo.SetEnable(false);
   txtSlipNo.SetEnable(false);
    //-------------------------
    dso_wh_list_out.Call()
    SetGridFormat();
    BindingDataList();
	
    //----------------------------------    
    OnAddNew('Master');        
}
//---------------------------------------------------------------------  
 function BindingDataList()
 {      
     var data ;     
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
    lstCurrency.SetDataText(data); 
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G2_REQ_QTY)           = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_UNIT_PRICE)        = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_VAT_AMOUNT)        = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_ITEM_AMOUNT)       = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_TOTAL_AMOUNT)      = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_VAT_RATE)          = "#,###,###,###,###,###.##";
    
    
    arr_FormatNumber[G2_REQ_QTY]        = 2;
    arr_FormatNumber[G2_UNIT_PRICE]     = 2;
    arr_FormatNumber[G2_VAT_AMOUNT]     = 2;
    arr_FormatNumber[G2_ITEM_AMOUNT]    = 2;
    arr_FormatNumber[G2_TOTAL_AMOUNT]   = 2;
    arr_FormatNumber[G2_VAT_RATE]       = 2;
    
 }
//--------------------------------------------------------------------------------------------------
function CheckSelectedWareHouse(val)
{
	if(lstInWH.value == "" || lstInWH.value == lstOutWH.value )
	{
		alert("In WH and Out WH can not the same or empty.");
		lstInWH.value = "";
		return false;
	}
	return true;
   for(var i=1; i<grdDetail.rows;i++)
   {
      if(grdDetail.GetGridData(i, 2) != val)
      { 
          return false;
      }
   }
	return true;
}
 
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger': // employee
		    var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if ( obj != null )
                {
		            txtStaffPK.text = obj[0];
		            txtStaff.text = obj[2];
	            }				
	            break; 
	    //-------------------    
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=||Y|Y||';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM,       arrTemp[5]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UNIT_PRICE,    arrTemp[7]);//Price                            
                    }	
                    TotalAmount();
             }        
        break;  
        //-------------------
        case 'IN_PL': // PL
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtIN_PLPK.text   = oValue[6]; 
                txtIN_PLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;
        //-------------------------
        case 'OUT_PL': // PL
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtOUT_PLPK.text   = oValue[6]; 
                txtOUT_PLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;                                       
    }	       
}
//---------------------------------------------------------------------------------------------------
function OnReport() 
{
	/*
    var url = System.RootURL + "/system/ReportEngine.aspx?file=bi/as/rpt_bias00120.rpt&procedure=inv.sp_sel_bias00120_3"
    + "&parameter="+txtMasterPK.text;
    window.open(url);
	*/	
	if(txtMasterPK.text != '')
    {
        var url =System.RootURL + '/reports/bi/as/rpt_bias00120.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank");         
    }
    else
    {
        alert("Pls select one warehouse bill !!!");
    }
}
//-======================================================
function OnAddNew(pos)
{
        switch (pos)
        {
            case 'Master':              
                dso_bias00120_1.StatusInsert();       
                txtSlipNo.text   = '***New Voucher***';                         
                //-------------------------------------------
                txtStaff.text     = "<%=Session("USER_NAME")%>";
                txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
                //------------------------------------------- 
                grdDetail.ClearData();     
            break;  
        }
}
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            dso_bias00120.Call("SELECT");
        break;
    
        case 'grdMaster':
             if ( grdSearch.row > 0 )
             {
                 txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G1_PK );
             }
             
            dso_bias00120_1.Call("SELECT");
        break;
        
        case 'grdDetail':            
            dso_bias00120_2.Call("SELECT");
        break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "dso_bias00120_1": 
            if(flag == "save")
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G2_MASTER_PK, txtMasterPK.text);
                    } 
                }
                //----------------------------            
                OnSave('Detail');
            }
            else
            {
                OnSearch('grdDetail');  
            }
        break;
        //===================
        case "dso_bias00120_2":
            for(var i = 1; i < grdDetail.rows; i++)
            {
                grdDetail.SetCellBold( i, G2_REQ_ITEM_CODE,   grdDetail.rows - 1, G2_REQ_ITEM_CODE,   true);
                grdDetail.SetCellBold( i, G2_REQ_QTY      ,   grdDetail.rows - 1, G2_REQ_QTY      ,   true);
                grdDetail.SetCellBold( i, G2_UNIT_PRICE   ,   grdDetail.rows - 1, G2_TOTAL_AMOUNT ,   true);
            }
        break;   
        //===================
        case 'dso_bias00120_3':
            alert(txtReturnValue.text);
            OnSearch('grdMaster'); 
        break;    
          //===================
        case 'dso_wh_list_out':
            lstWH.SetDataText(txtWHStr.text+"||");
            lstOutWH.SetDataText(txtWHStr.text);
            lstWH.value =''
            dso_wh_list_in.Call()            
        break;  
        case 'dso_wh_list_in':
            lstInWH.SetDataText(txtWHStr.text);
            lstInWH.value =''
        break;
        //==================
		case 'pro_bias00120_2':
			alert(txtReturnValue.text);
		break;
    }
}
//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                dso_bias00120_1.StatusDelete();
                dso_bias00120_1.Call();
            }   
        break;
        //================
        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                    dso_bias00120_2.Call();
                }    
            }            
        break;            

    }     
}
//-------------------------------------------------------------------------------------  
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//-------------------------------------------------------------------------------------
function Validate()
{   
    for( var i = 1; i < grdDetail.rows; i++)
    {
        if ( Number(grdDetail.GetGridData(i,G2_REQ_QTY)) == 0)
        {
            alert("Input take in Qty. at " + i + ",pls!");
            return false;
        }
    }
    return true;
}
//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( CheckSelectedWareHouse(lstInWH.value) == true && Validate() == true )
            { 
                dso_bias00120_1.Call();  
                flag = "save";             
            }            
        break;
        //=================
        case 'Detail':        
			if(CheckSelectedWareHouse(lstInWH.value) == false)
			{
				alert("Many warehouse in list. Can not save");
				return;
			}    
            dso_bias00120_2.Call();
        break;
    }
}

//---------------------------------------------------------------------------------------------------
function CheckInput()
{

    var col, row
    
    col = event.col
    row = event.row  
    
    if( col == G2_REQ_QTY || col == G2_UNIT_PRICE || G2_VAT_RATE)
    {
        var Quantity;
        Quantity = grdDetail.GetGridData(row, col);
        
        if(Number(Quantity))
        {
            if(Quantity > 0)
            {
                var Item_Amount = Number(grdDetail.GetGridData(grdDetail.row,G2_REQ_QTY))*Number(grdDetail.GetGridData(grdDetail.row,G2_UNIT_PRICE))
                var VAT_Amount  = Number(grdDetail.GetGridData(grdDetail.row,G2_VAT_RATE))*Item_Amount/100;
                var Total_Amount = Item_Amount + VAT_Amount;
                
                grdDetail.SetGridText( grdDetail.row, G2_ITEM_AMOUNT, System.Round( Item_Amount, arr_FormatNumber[G2_ITEM_AMOUNT] ) ) ;
                grdDetail.SetGridText( grdDetail.row, G2_VAT_AMOUNT, System.Round( VAT_Amount, arr_FormatNumber[G2_VAT_AMOUNT] ) ) ;
                grdDetail.SetGridText( grdDetail.row, G2_TOTAL_AMOUNT, System.Round( Total_Amount, arr_FormatNumber[G2_TOTAL_AMOUNT] ) ) ;
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");            
            }
        }
        else
        {
            grdDetail.SetGridText( row, col, ""); 
        }  
        TotalAmount();     
    }  
}
//--------------------------------------------------------------------- 
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G2_TOTAL_AMOUNT));
    }

    txtAmount.text = System.Round( sumAmount, arr_FormatNumber[G2_TOTAL_AMOUNT]);
} 
//--------------------------------------------------------------------- 
function OnSelectInWHChange()
{
	if(lstOutWH.value == lstInWH.value)
	{
		alert("In WH and Out WH is the same.");
		lstInWH.value = "";
	}
}
//---------------------------------
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_REQ_UOM)
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
                 else if ( event_col == G2_REQ_ITEM_CODE || event_col == G2_REQ_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G2_REQ_ITEM_PK  ,   object[0] );
                            grdDetail.SetGridText( event_row, G2_REQ_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G2_REQ_ITEM_NAME,   object[2] );
                       }                       
                 }
            break;             
      }         
}
//--------------------------------------------------------------------- 
function OnProcess(pos)
{
	switch(pos)
	{
		case 'SUBMIT':
			if(txtMasterPK.text == '')
		    {
		        alert("Pls select one saved slip !!!");
		    }
		    else
		    {
		        dso_bias00120_3.Call();
		    }		
		break;
		
		case 'TRANS':
			if(txtMasterPK.text == '')
			{
			    alert("Pls select one saved slip !!!");
			}
			else
			{
			    pro_bias00120_2.Call();
			}
		break;
	}
    
}
//================================================================================
 
</script>

<html>
<body>
    <!---------------------------------------------------------------->
    <gw:data id="dso_wh_list_out" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bias00120_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="dso_wh_list_in" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bias00120_4" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="dso_bias00120" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="<%=l_user%>lg_sel_bias00120"> 
                <input bind="grdSearch" > 
                    <input bind="txtRefNoSearch" /> 
					<input bind="dtFrom" /> 
					<input bind="dtTo" /> 
					<input bind="lstWH" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="dso_bias00120_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_bias00120_1" procedure="<%=l_user%>lg_upd_bias00120_1"> 
             <inout>
                <inout  bind="txtMasterPK" /> 
                <inout  bind="txtSlipNo" />
                <inout  bind="txtRefNo" /> 
                <inout  bind="txtStaffPK" />
                <inout  bind="txtStaff" />
                <inout  bind="dtDocDate" />
                <inout  bind="lstOutWH" />
                <inout  bind="lstInWH" /> 
                <inout  bind="txtOUT_PLPK" />
                <inout  bind="txtOUT_PLName" />
                <inout  bind="txtIN_PLPK" />
                <inout  bind="txtIN_PLName" />
                <inout  bind="lblStatus" />
                <inout  bind="txtAmount" /> 
                <inout  bind="lstCurrency" />  
                <inout  bind="txtRemark" />       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="dso_bias00120_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_bias00120_2" procedure="<%=l_user%>lg_upd_bias00120_2"> 
                <input bind="grdDetail" > 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="dso_bias00120_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bias00120" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bias00120_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_PRO_BIAS00120_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%" align="right">
                        <td style="width: 30%">
                            <b>Date</b>
                        </td>
                        <td colspan="2" align="left">
                            <gw:datebox id="dtFrom" lang="1" />
                            &nbsp;&nbsp;<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>W/H</b>
                        </td>
                        <td style="width: 69%" colspan="3">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            No
                        </td>
                        <td style="width: 69%" colspan="2">
                            <gw:textbox id="txtRefNoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
					<tr style="height: 1%">
						<td colspan=3 >
							<table style="width: 100%; height: 100%" border="0" >
								<tr style="height: 1%" >
									<td style="width: 1%">
										<gw:icon id="idBtnAuto" img="2" text="Auto Trans" styles='width:100%' onclick="OnProcess('TRANS')" />
									</td>
									<td style="width: 99%" >										 
									</td>
								</tr>
							</table>
						</td>
					</tr>
                    <tr style="height: 96%">
                        <td colspan="4">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip No|Date|Ref No" format="0|0|0|4|0"
                                aligns="0|1|0|1|0" defaults="|||||" editcol="0|0|0|0|0" widths="0|1000|1000|1100|1000"
                                styles="width:100%; height:100%" sorting="T" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 2%">
                        <td align="right" style="width: 5%">
                            <b>Slip No</b>
                        </td>
                        <td>
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width: 100%" />
                        </td>
                        <td align="right" style="width: 2%">
                            <b>Date</b>
                        </td>
                        <td style="width: 5%">
                            <gw:datebox id="dtDocDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td colspan="2" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' />
                        </td>                        
                        <td style="width: 1%">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('SUBMIT')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExcel" img="excel" alt="Report" onclick="OnReport()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right">
                            <b>Ref No</b>
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRefNo" csstype="mandatory" styles="width: 100%" />
                        </td>
                        <td align="right">
                            <a title="Click here to select Requester" onclick="OnPopUp('Charger')" href="#tips"
                                style="text-decoration: none; color=#0000ff">Charger</a>
                        </td>
                        <td colspan="7">
                            <gw:textbox id="txtStaff" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right">
                            <b>Out WH</b>
                        </td>
                        <td colspan="3">
                            <gw:list id="lstOutWH" styles="width:100%" csstype="mandatory" onchange="OnSelectInWHChange()">
                            </gw:list>
                        </td>
                        <td align="right">
                            <b>In WH</b>
                        </td>
                        <td colspan="7">
                            <gw:list id="lstInWH" styles="width:100%" csstype="mandatory" onchange="OnSelectInWHChange()">
                            </gw:list>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right">
                            <a title="Out P/L" onclick="OnPopUp('OUT_PL')" href="#tips" style="color=#0000ff"><b>
                                Out P/L</b></a>
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtOUT_PLPK" styles="display:none" />
                            <gw:textbox id="txtOUT_PLName" styles="width:100%" />
                        </td>
                        <td align="right">
                            <a title="In P/L" onclick="OnPopUp('IN_PL')" href="#tips" style="color=#0000ff"><b>In
                                P/L</b></a>
                        </td>
                        <td style="width: 2%" colspan="7">
                            <gw:textbox id="txtIN_PLPK" styles="display:none" />
                            <gw:textbox id="txtIN_PLName" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="white-space: nowrap">
                            <b>Total Amount</b>
                        </td>
                        <td colspan="2" style="width: 40%">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="#,###,###,###,###,###.##"
                                csstype="mandatory" />
                        </td>
                        <td>
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td align="right">
                            Remark
                        </td>
                        <td style="width: 2%" colspan="7">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="12">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 64%" align="right">
                                    </td>
                                    <td style="width: 19%" align="center">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                         <gw:icon id="idBtnGetItem" img="2" text="Free Item" styles='width:100%' onclick="OnPopUp('FreeItem')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="12">
                            <gw:grid id='grdDetail' header='_PK|_ST_TRANSFER_REQ_M_PK|_REQ_ITEM_PK|Seq|Ref No|Item Code|Item Name|Req Qty|Req Uom|Unit Price|Item Amount|Vat Rate|Vat Amount|Total Amount|Lot No|Description'
                                format='0|0|0|0|0|0|0|1|0|1|1|1|1|1|0|0' aligns='0|0|0|1|0|0|0|0|1|0|0|0|0|0|0|0'
                                check='|||||||-||||-||||' editcol='0|0|0|0|1|0|0|1|1|1|0|1|0|0|1|1' widths='10|10|10|500|1000|1200|3000|800|1000|1200|1500|1000|1200|1800|1000|1000'
                                onafteredit="CheckInput()" sorting='T' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
    <gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
</body>
</html>
