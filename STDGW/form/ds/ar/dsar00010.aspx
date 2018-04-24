<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Collection Request Entry</title>
</head>

<script>

    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>";
    var  user_name = "<%=Session("USER_NAME")%>"  ;
//-----------------------------------------------------
var flag = '' ;

//-----------------------------------------------------
var G1_GD_PK    = 0,
    G1_Slip_No  = 1,
    G1_Date     = 2,
    G1_CUST    = 3;
    
var G2_DETAIL_PK    = 0,
    G2_MASTER_PK    = 1,
	G2_TCO_ITEM_PK  = 2,
    G2_Seq          = 3,
    G2_REF_NO       = 4,   
    G2_ITEM_CODE 	= 5,
    G2_ITEM_NAME 	= 6,
    G2_UOM  		= 7,
    G2_QTY 		    = 8,
    G2_UPRICE 		= 9,   
    G2_AMOUNT       = 10,     
    G2_REMARK       = 11;

	var arr_FormatNumber = new Array();    
//==========================================================================
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display      = "none";       
        imgArrow.status         = "collapse";
        right.style.width       = "100%";
        imgArrow.src            = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display      = "";
        imgArrow.status         = "expand";
        right.style.width       = "75%";
        imgArrow.src            = "../../../system/images/prev_orange.gif";
    }
 }
 
//==========================================================================

function BodyInit()
{
    System.Translate(document); 
    txtChargerNm.SetEnable(false);
    txtCustCode.SetEnable(false);
    txtCustName.SetEnable(false);
    
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-30));
    //----------------------        
    FormatGrid();
    //---------------------- 
    OnAddNew('Master');
    //----------------------     
}

//==========================================================================
 function FormatGrid()
 {
        var data="";  
           
     	data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     	lstCurrency.SetDataText(data);  
                     
        var ctrl ;
        ctrl = grdDetail.GetGridControl();	
        
        ctrl.ColFormat(G2_QTY)    = "###,###,###,###,###.##";
        ctrl.ColFormat(G2_UPRICE) = "###,###,###,###,###.#####";
        ctrl.ColFormat(G2_AMOUNT) = "###,###,###,###,###.##";
		
    	arr_FormatNumber[G2_QTY]    = 2;
    	arr_FormatNumber[G2_UPRICE] = 5;     
    	arr_FormatNumber[G2_AMOUNT] = 2;   		
  }
//==========================================================================

function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch' :        
            data_dsar00010.Call("SELECT")            
        break;

        case 'grdDetail' :        
            data_dsar00010_2.Call("SELECT")            
        break;
                
        case 'Master' :
			flag = '';
			
            if ( grdSearch.row > 0 )
            {
                txtMasterPK.text = grdSearch.GetGridData( event.row, G1_GD_PK);                
            }
            else
            {
                txtMasterPK.text = '' ;
            }
            
            data_dsar00010_1.Call("SELECT");
        break;
    }
}
//==========================================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
		case "pro_dsar00010":
			alert(txtReturnValue.text);
		break;
		
        case "data_dsar00010" :
	        if ( grdSearch.rows > 1 )
	        {
	            grdSearch.SetCellBold( 1, G1_CUST,  grdSearch.rows - 1, G1_CUST,  true);
	        }    
        break;
        
        case "data_dsar00010_1" :
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G2_MASTER_PK, txtMasterPK.text);
                    }    
                }
                
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }               
        break;
               
        case "data_dsar00010_2":
			flag = '';
			
	        if ( grdDetail.rows > 1 )
	        {
	            grdDetail.SetCellBold( 1, G2_REF_NO,    grdDetail.rows - 1, G2_REF_NO,    true);
				grdDetail.SetCellBold( 1, G2_ITEM_CODE, grdDetail.rows - 1, G2_ITEM_CODE, true);
				
                grdDetail.SetCellBold( 1, G2_QTY,    grdDetail.rows - 1, G2_QTY,    true);
                grdDetail.SetCellBold( 1, G2_UPRICE, grdDetail.rows - 1, G2_UPRICE, true);
                grdDetail.SetCellBold( 1, G2_AMOUNT, grdDetail.rows - 1, G2_AMOUNT, true);
                
                grdDetail.SetCellBgColor( 1, G2_ITEM_CODE , grdDetail.rows - 1, G2_ITEM_CODE , 0xCCFFFF );
                
				var t_total_qty = 0 ;
				var t_amount = 0 ;
				 
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {                                        
                    t_total_qty = t_total_qty + Number(grdDetail.GetGridData( i, G2_QTY ));
					t_amount    = t_amount + Number(grdDetail.GetGridData( i, G2_AMOUNT ));
                }      
				 
                lblTotalQty.text = Round(Number(t_total_qty),2);
				lblAmount.text   = Round(Number(t_amount),2);
				
                TotalItem(); 
                //--------------------------------
	        }
        break;
    }
}

//==========================================================================

function OnPopUp(pos)
 {
      switch (pos)         
      {	  
            case 'Cust'  :
                 var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AR';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {       
	                txtCustPK.text   = object[0];
                    txtCustCode.text = object[1];
                    txtCustName.text = object[2];            
	             }
	        break;
    	                 
            case 'Charger' :
                 var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
	                txtChargerPK.text   = object[0];
                    txtChargerNm.text = object[2];
                 }
            break;                  
       }
 }
//==========================================================================
 
function OnAddNew(obj)
{
      switch (obj)         
      {	  
            case 'Master'  :    
                if ( data_dsar00010_1.GetStatus() != 20 )
                {
                    data_dsar00010_1.StatusInsert();
                    
                    txtSlipNo.text = "**New Slip No**";
                    
                    txtChargerNm.text = "<%=Session("USER_NAME")%>";    
                    txtChargerPK.text = "<%=Session("EMPLOYEE_PK")%>";       
                            
                    grdDetail.ClearData();
                }
                else
                {
                    alert('Already Add New. Pls Input data !!!');
                }
                
            break;
            
            case 'FreeItem':
             	var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             	var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             	if ( object != null )
             	{                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Seq, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TCO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE,   arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME,   arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UOM,         arrTemp[5]);//item_uom                          
                    }	
             	}        
        	break;    
			
			case 'NewRow':
				grdDetail.AddRow();                            
                            
                grdDetail.SetGridText( grdDetail.rows-1, G2_Seq, grdDetail.rows-1);			
			break;                           
     }         
}

//==========================================================================

function OnSave(pos)
{
    switch(pos)
    {
        case 'Master': 
            flag = 'save';  
            data_dsar00010_1.Call();                
        break;
       
        case 'Detail':
            data_dsar00010_2.Call();
        break;
    } 
}

//==========================================================================
 function OnDelete(index)
 {
    switch(index)
    {
        case'Master':
            if ( confirm( "Do you want to delete this Slip ?" ) ) 
		    {
		        flag = 'delete';
		        data_dsar00010_1.StatusDelete();
                data_dsar00010_1.Call();
	        }        
        break;
        
        case 'Detail':
            if ( grdDetail.row > 0 )
            {
                if ( grdDetail.GetGridData( grdDetail.row, G2_DETAIL_PK ) == "" ) 
		        {						            				
		            grdDetail.RemoveRow();					
		        }        			
		        else 
	            {  
		            grdDetail.DeleteRow();
	            }
	        }    
        break;
    }         
 }

//==========================================================================
function OnUnDelete() 
{
    grdDetail.UnDeleteRow();
}

//==========================================================================

 function CheckInput(obj)
 { 
    var  row, col;
   
    switch (obj.id)
    {
        case 'grdDetail':
            row = event.row ;
            col = event.col ;    
            
            if ( col == G2_QTY || col == G2_UPRICE || col == G2_AMOUNT )
            {
                var dQuantiy;
                
                dQuantiy =  grdDetail.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdDetail.SetGridText(row,col,System.Round( dQuantiy, arr_FormatNumber[col] ));
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
                if ( col == G2_QTY || col == G2_UPRICE )
                {
                    
                    var dUP  =  Number(grdDetail.GetGridData( row, G2_UPRICE ));
                    var dQty =  Number(grdDetail.GetGridData( row, G2_QTY    ));
                    var dAmount = Number(dUP * dQty);
                    
                    grdDetail.SetGridText( row, G2_AMOUNT, System.Round( dAmount, arr_FormatNumber[G2_AMOUNT] ) );
                }
            }         
        break;
    }        
 }
//==========================================================================
 function OnReportClick()
 {
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/ds/ar/rpt_dsar00010_DW01.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_epfm00050_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
	}   
 }
 
 
//==========================================================================

function TotalItem()
 {
    var iNumRecord    =  grdDetail.rows-1 ;
    lblTotalItem.text = iNumRecord  + "" ;     
 }
 
//==========================================================================
 
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Submit' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to submit this Slip?'))
                {
                    pro_dsar00010.Call();
                } 
            }                          
        break;
	}
}	 
//==========================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsar00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsar00010" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="data_dsar00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsar00010" > 
                <input bind="grdSearch" >                      
                     <input bind="dtFromDate" /> 
                     <input bind="dtToDate" /> 
					 <input bind="txtSearchNo" /> 
					 <input bind="txtChargerPK" />	
					 <input bind="chkUser" />				 
                 </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="data_dsar00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control" function="<%=l_user%>lg_sel_dsar00010_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="<%=l_user%>lg_upd_dsar00010_1" > 
                <inout > 
                     <inout bind="txtMasterPK" /> 
                     <inout bind="txtSlipNo" /> 
                     <inout bind="dtReqDate" />
                     <inout bind="lblStatus" /> 
                     <inout bind="txtChargerPK"/>
                     <inout bind="txtChargerNm"/>                                         
                     <inout bind="txtCustPK"/>
                     <inout bind="txtCustCode"/>
                     <inout bind="txtCustName"/>
 					 <inout bind="lstCurrency"/>					 
					 <inout bind="txtExRate"/>
                     <inout bind="txtDescription"/>			 
                </inout> 
             </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="data_dsar00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsar00010_2" parameter ="0,1,2,3,4,5,6,7,8,9,10,11" procedure="<%=l_user%>lg_upd_dsar00010_2"> 
                <input bind="grdDetail" > 
                     <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%" valign="top">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Date
                        </td>
                        <td style="width: 90%; white-space: nowrap">
                            <gw:datebox id="dtFromDate" lang="1" />
                            ~
                            <gw:datebox id="dtToDate" lang="1" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 25%; white-space: nowrap">
                            Search No
                        </td>
                        <td>
                            <gw:textbox id="txtSearchNo"  styles="width:100%" />
                        </td>
						<td>
							<gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
						</td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Slip No|Req Date|Cust" format="0|0|4|0" aligns="0|0|1|0"
                                defaults="||||" editcol="0|0|0|0" widths="0|1500|1200|1000" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b>Slip No</b>
                        </td>
                        <td style="width: 30%" colspan=2 >
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            <b>Req Date</b>
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtReqDate" lang="1" />
                        </td>
                        <td style="width: 20%">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt' text='status' />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 1%">
							<gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnNew" img="new" alt="New Take Out Goods" text="Add" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnUpdate" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnReport" img="excel" alt="Print" text="Print" onclick="OnReportClick()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right"> 
							<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger</b>                            
                        </td>
                        <td align="left" style="width: 30%" colspan=2 > 
							<gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtChargerNm" styles='width:100%' />						                            
                        </td>
                        <td style="width: 10%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Cust')">Cust</b>
                        </td>
                        <td style="width: 20%; white-space: nowrap" colspan="8">
                            <gw:textbox id="txtCustPK" styles='display:none' />
                            <gw:textbox id="txtCustCode" styles='width:30%' />
                            <gw:textbox id="txtCustName" styles='width:70%' />
                        </td>
                    </tr>                    
                    <tr style="height: 1%">					
						<td style="width: 10%; white-space: nowrap" align="right">
						 	 Ex-Rate                            
                        </td>
                        <td style="width: 10%">
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td style="width: 20%"  >
                        	<gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />                            
                        </td>											                         
                        <td align="right" style="width: 10%">
                            <b>Remark</b>
                        </td>
                        <td align="left" style="width: 40%" colspan="8">
                            <gw:textbox id="txtDescription" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="13">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap" align="left">                                         
                                    </td>
                                    <td style="width: 30%">
                                    </td>
                                    <td style="width: 20%;white-space:nowrap" align="left">
                                        Items :&nbsp; <gw:label id="lblTotalItem" styles='width:100%;color:cc0000;font:9pt' text='' />
                                    </td>
                                    <td style="width: 20%">
                                        Qty :&nbsp;
                                        <gw:label id="lblTotalQty" styles='width:100%;color:cc0000;font:9pt' text='' type="number"
                                            format="###,###.##" />
                                    </td>
                                    <td style="width: 20%;white-space:nowrap">
                                        Amount :&nbsp;
                                        <gw:label id="lblAmount" styles='width:100%;color:cc0000;font:9pt' text='' type="number"
                                            format="###,###.##" />
                                    </td>
                                    <td style="width: 5%" align="left">
                                        
                                    </td>
                                    <td style="width: 1%" align="left">
                                    </td>
                                    <td style="width: 1%" align="right">
										<gw:icon id="ibtnNew2" img="2" text="New Row" onclick="OnAddNew('NewRow')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="ibtnNew2" img="2" text="New Item" onclick="OnAddNew('FreeItem')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnDelete_1" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnUnDelete_1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="12">
                            <gw:grid id='grdDetail' 
								header='_PK|_MASTER_PK|_TCO_ITEM_PK|Seq|Ref No|Item Code|Item Name|UOM|Qty|U/Price|Amount|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|0|1|0|0|0|1|3|3|3|0'
                                defaults='|||||||||||' 
								editcol='0|0|0|1|1|1|1|1|1|1|1|1'
                                widths='0|0|0|800|1200|1500|3500|800|1500|1500|1500|1000'
                                sorting='T' acceptnulldate="T" styles="width:100%;height:100%" onafteredit="CheckInput(this)"
                                 />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!-------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
	<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!-------------------------------------------------------------->
</body>
</html>
