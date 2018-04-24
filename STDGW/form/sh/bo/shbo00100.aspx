<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manufacturing Instruction and Record (4. Packaging)</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_id	= "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    
var G2_PK           = 0,
    G2_tco_item_pk  = 1,
    G2_Test_No      = 2,
    G2_Enter_Date   = 3,
    G2_Valid        = 4,
    G2_Change_Date  = 5;

var flag_sel	= true;
var flag_del = false;
var v_obj ;
//===============================================================
function BodyInit()
{
    right2.style.display='none'
    	
	BindingDataList();
    dso_shbo00100.StatusInsert();
	lstMachineNo.SetDataText('');
    SetEnableControl();

    
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
	
	OnSearch();
}
 
//===============================================================
function SetEnableControl()
{
	txtLotNo.SetReadOnly(true);
	lstMachineNo.SetEnable(false);
	txtPackingUnit.SetReadOnly(true);
	txtPackingUnitQty.SetReadOnly(true);
	txtBoxQty.SetReadOnly(true);
	txtProductCode.SetReadOnly(true);   
	txtProductName.SetReadOnly(true);
	txtCustomerCode.SetReadOnly(true);
	txtCustomerName.SetReadOnly(true);
	txtSizeCode.SetReadOnly(true);
	txtSizeName.SetReadOnly(true);
	txtColorCodeCap.SetReadOnly(true);
	txtColorNameCap.SetReadOnly(true);
	txtColorCodeBody.SetReadOnly(true);
	txtColorNameBody.SetReadOnly(true);	
	txtIssueName.SetReadOnly(true);
	dtIssueDt.SetEnable(false);
	txtIssueCode.SetReadOnly(true);
	txtIssueName.SetReadOnly(true);
	
	
	txtLotNo2.SetReadOnly(true);
	lstMachineNo2.SetEnable(false);
	txtPackingUnit2.SetReadOnly(true);
	txtPackingUnitQty2.SetReadOnly(true);
	txtBoxQty2.SetReadOnly(true);
	txtProductCode2.SetReadOnly(true);   
	txtProductName2.SetReadOnly(true);
	txtCustomerCode2.SetReadOnly(true);
	txtCustomerName2.SetReadOnly(true);
	txtSizeCode2.SetReadOnly(true);
	txtSizeName2.SetReadOnly(true);
	txtColorCodeCap2.SetReadOnly(true);
	txtColorNameCap2.SetReadOnly(true);
	txtColorCodeBody2.SetReadOnly(true);
	txtColorNameBody2.SetReadOnly(true);	
	txtIssueName2.SetReadOnly(true);
	dtIssueDt2.SetEnable(false);
	txtIssueCode2.SetReadOnly(true);
	txtIssueName2.SetReadOnly(true);
	txtBoxSeq2.SetReadOnly(true);
}
//==============================================================
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.F_LOGISTIC_CODE('LGMF0010') FROM DUAL" )%>|ALL|Select All"; 
	lstMachineNoM.SetDataText(data);   
	lstMachineNo.SetDataText(data);
	
	lstMachineNo2.SetDataText(data);

	lstMachineNoM.value = 'ALL';
	 var trl ;     
      trl = grdSearch.GetGridControl();      	
      trl.ColFormat(4 )     = "###,###,###,###,##0";
}

function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="50%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="50%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//===============================================
 function OnChangeTab(obj)
{
    if(obj == '1')/*form 1*/
    {
        if(rdoSTATUS.value=='2')
        {
            right.style.display='none'
            right2.style.display=''
            rdoSTATUS2.value='2'     
            OnNew()
        }
    }else
    {
          if(rdoSTATUS2.value=='1')
        {
            right.style.display=''
            right2.style.display='none'
            rdoSTATUS.value=1
         }
    }
    
    
}
//===============================================================

function OnSearch()
{  
	flag_sel	= true;
	data_shbo00100_main_list.Call('SELECT');
}
//================================================================
function ResetControl(flag)
{
    if(flag == '1')
    {
    if (dso_shbo00100.GetStatus()!="20")
    {
        dso_shbo00100.StatusInsert();
        rdoSTATUS.value = '1'      
     }
     else
        {
            txtMasterPK.text = ''
        	rdoSTATUS.value = '1'
            lstMachineNo.text = ''
            txtLotNo.text = ''
            txtProdQty.text = ''
			txtPackingUnit.text = ''
			txtPackingUnitQty.text = ''
			txtBoxQty.text = ''
            txtTcoItemPK.text = ''
            txtProductCode.text = ''    
            txtProductName.text = ''
            txtTcoBuspartnerPK.text = ''
            txtCustomerCode.text = ''
            txtCustomerName.text = ''
            txtSizeCode.text = ''        
            txtSizeName.text = ''  
            txtColorCodeCap.text = ''
			txtColorNameCap.text = '' 
            txtColorCodeBody.text = ''
            txtColorNameBody.text = ''
            txtChargerPK.text = ''
			txtIssueCode.text = '' 
            txtIssueName.text = '' 
            txtBatLotPK.text = '' 
            }
        txtIssueName.text = user_name;
        txtIssueCode.text = user_id;
        txtChargerPK.text = user_pk;
           
	}
	else
	{
	if (dso_shbo00100_mb.GetStatus()!="20")
	{
	     dso_shbo00100_mb.StatusInsert();
	     rdoSTATUS2.value = '2'
    }
     else
        {
        	txtMasterPK2.text = ''
            rdoSTATUS2.value = '2'
            lstMachineNo2.value = ''
            txtLotNo2.text = ''
            txtProdQty2.text = ''
			txtPackingUnit2.text = ''
			txtPackingUnitQty2.text = ''
			txtBoxQty2.text = ''
            txtTcoItemPK2.text = '' 
            txtProductCode2.text = ''     
            txtProductName2.text = ''
            txtTcoBuspartnerPK2.text = ''
            txtCustomerCode2.text = ''
            txtCustomerName2.text = ''
            txtSizeCode2.text = ''         
            txtSizeName2.text = ''   
            txtColorCodeCap2.text = ''
			txtColorNameCap2.text = ''  
            txtColorCodeBody2.text = ''
            txtColorNameBody2.text = '' 
            txtChargerPK2.text = ''
			txtIssueCode2.text = ''  
            txtIssueName2.text = ''  
            txtBatLotPK2.text = '' 
	      }	
	txtIssueName2.text = user_name;
    txtIssueCode2.text = user_id;
    txtChargerPK2.text = user_pk;
	
	}
    
}
//===============================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case'1':
                var fpath = System.RootURL + "/form/sh/bo/shbo00100_popup.aspx?";
                v_obj = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (v_obj != null)
                {
                    txtLotNo.text			= v_obj[1];
                    pro_shbo00100_check.Call()
                    
                   
                   /* txtBatLotPK.text		= object[0];	// tsh_batlot_pk
					DtInsDate.text			= object[2];	// inst_date
					lstMachineNo.value		= object[20];	// machine_no
					txtLotNo.text			= object[1];	// lot_no
					txtTcoItemPK.text		= object[21];	// lot_no	
					txtProdQty.text			= object[5];	// qty
					txtProductCode.text		= object[7];	// producte code
					txtProductName.text		= object[8];	// producte name
					txtTcoBuspartnerPK.text = object[9];	// buspartner_pk
					txtCustomerCode.text	= object[10];	// custome code
					txtCustomerName.text	= object[11];	// custome name
					txtSizeCode.text		= object[12];	// size code
					txtSizeName.text		= object[13];	// size name
					txtColorCodeCap.text	= object[14];	// code cap
					txtColorNameCap.text	= object[15];	// code name
					txtColorCodeBody.text   = object[16];	// code body
					txtColorNameBody.text	= object[17];	// code name
					*/
                }
                    
        break;
        case'2':
            var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                 if (rdoSTATUS.value == '1')
                {
                    txtIssueName.text=object[5];
				    txtIssueCode.text=object[3];
				    txtChargerPK.text=object[0]
				}else
				{
				    txtIssueName2.text=object[5];
				    txtIssueCode2.text=object[3];
				    txtChargerPK2.text=object[0]
				}
            }
        break;
		case '3':
			var fpath = System.RootURL + "/form/sh/bo/shbo00100_packing.aspx?";
            var object = System.OpenModal( fpath , 350 , 500 , 'resizable:yes;status:yes'); 

            if (object != null)
            {
                if (rdoSTATUS.value == '1')
                {
				    txtPackingUnit.text = object[1];
				    txtPackingUnitQty.text	= object[2];
				    OnCalculate();
				}else
				 {
				    txtPackingUnit2.text = object[1];
				    txtPackingUnitQty2.text	= object[2];
				    OnCalculate();
				}
            }
		break;
		case '4':
		    if(rdoSTATUS.value=='2')
		    {
			    var fpath = System.RootURL + "/form/sh/pb/shpb00111.aspx?prod_yn=Y";
			    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 

			    if (object != null)
			    {					
				    txtTcoItemPK2.text	= object[0];
				    txtProductCode2.text	= object[1];
				    txtProductName2.text	= object[2];					

				    dso_shbo00100_item.Call('SELECT');
			    }	
			}
		break;
		case '5':
		     if(rdoSTATUS.value=='2')
		    {
			    var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?";
			    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 

			    if (object != null)
			    {
				    txtTcoBuspartnerPK2.text	= object[0];
				    txtCustomerCode2.text	= object[1];
				    txtCustomerName2.text	= object[2];
			    }
			}
		break;
    }
    
    
}
//===============================================================
function OnDelete(flag)
{
    if(flag == '1')
    {
	    if (txtMasterPK.text != '')
	    {
		    if(confirm('Do you want to delete ?'))
		    {
			    dso_shbo00100.StatusDelete();
			    flag_sel = false;
			    flag_del = true;
			    dso_shbo00100.Call();
		    }
        }
        else
        {
		        alert('Please, Select LotNo !!!');
		        return;
	    }
    }
    else
    {
         if (txtMasterPK2.text != '')
	    {
		    if(confirm('Do you want to delete ?'))
		    {
			    dso_shbo00100_mb.StatusDelete();
			    flag_sel = false;
			    flag_del = true;
			    dso_shbo00100_mb.Call();
		    }
        }
        else
        {
		        alert('Please, Select LotNo !!!');
		        return;
	    }
    }
}
//===============================================================
function OnNew()
{
     flag_sel	= false;
	flag_insert = true;
	DtInsDate.SetEnable(true);
	rdoSTATUS.SetEnable(true);
	if(rdoSTATUS.value=='1')
	{
         ResetControl('1')
         lstMachineNo.SetDataText('');
	
     }else if(rdoSTATUS.value=='2' )
    {
         ResetControl('2')
         lstMachineNo2.SetDataText('');
     }
	

}
//===============================================================
function OnSave(obj)
{
   if(obj=='1')
   {
        OnCalculate();
        if(txtLotNo.text=="")
        {
            alert("Please, Select LotNo !!!");
		    return;
        }

	    if(Number(txtProdQty.text) < 0 )
	    {
		    alert('Please, input Estimated Qty(pcs).');
		    return;
	    }
    			
	    if(txtPackingUnitQty.text == '0' )
	    {
		    alert('Please, input Packing Unit.');
		    return;
	    }

	    flag_sel = false;
	    dso_shbo00100.Call();
	}else
	{
	    OnCalculate();
        if(txtLotNo2.text=="")
        {
            alert("Please, Select LotNo !!!");
		    return;
        }

	    if(Number(txtProdQty2.text) < 0 )
	    {
		    alert('Please, input Estimated Qty(pcs).');
		    return;
	    }
    			
	    if(txtPackingUnitQty2.text == '0' )
	    {
		    alert('Please, input Packing Unit.');
		    return;
	    }

	    flag_sel = false;
	    dso_shbo00100_mb.Call();
	}
}

//===============================================================
function OnClickGridMaster()
{
    if (grdSearch.row > 0)
    {   
        flag_sel	= true;		
		if (rdoSTATUS_M.value=='1')
		{
		    right.style.display=''
            right2.style.display='none'
            rdoSTATUS.value='1'
		    txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,0);
            dso_shbo00100.Call('SELECT');
        }else
        {
            right.style.display='none'
            right2.style.display=''
            rdoSTATUS2.value='2'
            txtMasterPK2.text = grdSearch.GetGridData(grdSearch.row,0);
            dso_shbo00100_mb.Call('SELECT');
        }
    }
}
//===============================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'dso_shbo00100':
			
			 rdoSTATUS.value='1'
			 rdoSTATUS2.value='1'
			 
			if (flag_sel == false)
			{
			    flag_sel = true
				data_shbo00100_main_list.Call('SELECT'); 
			}
        break;
        
        case 'dso_shbo00100_mb':
			
			rdoSTATUS.value='2'
		    rdoSTATUS2.value='2'
				
			if (flag_sel == false)
			{
			    flag_sel = true
			    data_shbo00100_main_list.Call('SELECT'); 
				
			}
        break;
         

        case'data_shbo00100_main_list':
            if(flag_del==true)
            {
                flag_del=false
                OnNew()
            }
        break;     
        
        case 'pro_shbo00100_check'   :
            if(txtMasterPK.text!= '')
            {
                dso_shbo00100.Call('SELECT')
            }else
            {
                if(rdoSTATUS.value =='1')
                {
                    OnNew()   
                    txtBatLotPK.text		= v_obj[0];	// tsh_batlot_pk
					DtInsDate.text			= v_obj[2];	// inst_date
					lstMachineNo.value		= v_obj[20];	// machine_no
					txtLotNo.text			= v_obj[1];	// lot_no
					txtTcoItemPK.text		= v_obj[21];	// lot_no	
					txtProdQty.text			= v_obj[5];	// qty
					txtProductCode.text		= v_obj[7];	// producte code
					txtProductName.text		= v_obj[8];	// producte name
					txtTcoBuspartnerPK.text = v_obj[9];	// buspartner_pk
					txtCustomerCode.text	= v_obj[10];	// custome code
					txtCustomerName.text	= v_obj[11];	// custome name
					txtSizeCode.text		= v_obj[12];	// size code
					txtSizeName.text		= v_obj[13];	// size name
					txtColorCodeCap.text	= v_obj[14];	// code cap
					txtColorNameCap.text	= v_obj[15];	// code name
					txtColorCodeBody.text   = v_obj[16];	// code body
					txtColorNameBody.text	= v_obj[17];	// code name
					                
                }else
                {
                     OnNew()  
                    txtBatLotPK2.text		= v_obj[0];	// tsh_batlot_pk
					DtInsDate2.text			= v_obj[2];	// inst_date
					lstMachineNo2.value		= v_obj[20];	// machine_no
					txtLotNo2.text			= v_obj[1];	// lot_no
					txtTcoItemPK2.text		= v_obj[21];	// lot_no	
					txtProdQty2.text			= v_obj[5];	// qty
					txtProductCode2.text		= v_obj[7];	// producte code
					txtProductName2.text		= v_obj[8];	// producte name
					txtTcoBuspartnerPK2.text = v_obj[9];	// buspartner_pk
					txtCustomerCode2.text	= v_obj[10];	// custome code
					txtCustomerName2.text	= v_obj[11];	// custome name
					txtSizeCode2.text		= v_obj[12];	// size code
					txtSizeName2.text		= v_obj[13];	// size name
					txtColorCodeCap2.text	= v_obj[14];	// code cap
					txtColorNameCap2.text	= v_obj[15];	// code name
					txtColorCodeBody2.text   = v_obj[16];	// code body
					txtColorNameBody2.text	= v_obj[17];	// code name
                }
                
            }
        break;
    }
}
//===============================================================
function CheckNum()
{
	if (isNaN(String.fromCharCode(event.keyCode)))
        event.keyCode = "";
}
//===============================================================
function padding(s,l) 
{ 
	return( l.substr(0, (l.length-s.length) )+s ); 
}
//===============================================================
function OnCalculate()
{
    if(rdoSTATUS.value=='1')
    {
        txtBoxQty.text=Math.ceil(Number(txtProdQty.text)/Number(txtPackingUnitQty.text));
    }else
    {
        txtBoxQty2.text=Math.ceil(Number(txtProdQty2.text)/Number(txtPackingUnitQty2.text));
    }
}
//===============================================================
function OnPrint()
{
    if(rdoSTATUS.value=='1')
	{
	    if(txtMasterPK.text!="")
	    {
		    var fpath = System.RootURL + "/form/sh/bo/shbo00230.aspx?main_m_pk=" + txtMasterPK.text		
		    + "&inst_dt=" + DtInsDate.value  + "&hoki="	+ lstMachineNo.value
		    + "&issu_dt=" + dtIssueDt.text  + "&lotno="	+ txtLotNo.text 
		    + "&item=" + txtProductName.text + "&customer="	+ txtCustomerName.text+"&type="+rdoSTATUS.value;
		    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
	    }
	    else
	    {
		    alert("Please, Select Lotno !!!");
	    }
	}else
	{
	    if(txtMasterPK2.text!="")
	    {
		    var fpath = System.RootURL + "/form/sh/bo/shbo00230.aspx?main_m_pk=" + txtMasterPK2.text		
		    + "&inst_dt=" + DtInsDate2.value  + "&hoki="	+ lstMachineNo2.value
		    + "&issu_dt=" + dtIssueDt2.text  + "&lotno="	+ txtLotNo2.text 
		    + "&item=" + txtProductName2.text + "&customer="	+ txtCustomerName2.text+"&type="+rdoSTATUS.value;
		    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
	    }
	    else
	    {
		    alert("Please, Select Lotno !!!");
	    }
	}
}
</script>
<body>
   <!--------------------------------------------------------------------------------------->
   <gw:data id="data_shbo00100_main_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00100_main_list">
                <input bind="grdSearch" >
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                    <input bind="lstMachineNoM" />
                    <input bind="txtTypeNoSearch" />
					<input bind="rdoSTATUS_M" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,12,22,25" function="PROD.sp_sel_shbo00100" procedure="PROD.sp_upd_shbo00100">
            <inout> 
                <inout bind="txtMasterPK"/>
                <inout bind="DtInsDate"/>
				<inout bind="rdoSTATUS"/>
                <inout bind="lstMachineNo"/>
                <inout bind="txtLotNo"/>
                <inout bind="txtProdQty"/>
				<inout bind="txtPackingUnit"/>
				<inout bind="txtPackingUnitQty"/>
				<inout bind="txtBoxQty"/>
                <inout bind="txtTcoItemPK"/> 
                <inout bind="txtProductCode"/>     
                <inout bind="txtProductName"/>
                <inout bind="txtTcoBuspartnerPK"/>
                <inout bind="txtCustomerCode"/>
                <inout bind="txtCustomerName"/>
                <inout bind="txtSizeCode"/>         
                <inout bind="txtSizeName"/>   
                <inout bind="txtColorCodeCap"/>
				<inout bind="txtColorNameCap"/>  
                <inout bind="txtColorCodeBody"/>
                <inout bind="txtColorNameBody"/> 
                <inout bind="dtIssueDt"/>     
                <inout bind="txtChargerPK"/>
				<inout bind="txtIssueCode"/>  
                <inout bind="txtIssueName"/>  
                <inout bind="txtBatLotPK"  />   
            </inout>
            </dso> 
        </xml> 
    </gw:data>
     <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00100_mb" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,12,22,25" function="PROD.sp_sel_shbo00100_mb" procedure="PROD.sp_upd_shbo00100_mb">
            <inout> 
                <inout bind="txtMasterPK2"/>
                <inout bind="DtInsDate2"/>
				<inout bind="rdoSTATUS2"/>
                <inout bind="lstMachineNo2"/>
                <inout bind="txtLotNo2"/>
                <inout bind="txtProdQty2"/>
				<inout bind="txtPackingUnit2"/>
				<inout bind="txtPackingUnitQty2"/>
				<inout bind="txtBoxQty2"/>
                <inout bind="txtTcoItemPK2"/> 
                <inout bind="txtProductCode2"/>     
                <inout bind="txtProductName2"/>
                <inout bind="txtTcoBuspartnerPK2"/>
                <inout bind="txtCustomerCode2"/>
                <inout bind="txtCustomerName2"/>
                <inout bind="txtSizeCode2"/>         
                <inout bind="txtSizeName2"/>   
                <inout bind="txtColorCodeCap2"/>
				<inout bind="txtColorNameCap2"/>  
                <inout bind="txtColorCodeBody2"/>
                <inout bind="txtColorNameBody2"/> 
                <inout bind="dtIssueDt2"/>     
                <inout bind="txtChargerPK2"/>
				<inout bind="txtIssueCode2"/>  
                <inout bind="txtIssueName2"/>  
                <inout bind="txtBatLotPK2"/>   
                <inout bind="txtBoxSeq2"/>   
            </inout>
            </dso> 
        </xml> 
    </gw:data>
	<!--------------------------------------------------------------------------------------->
	<gw:data id="dso_shbo00100_item" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="control" function="PROD.SP_SEL_SHBO00100_ITEM" procedure="">
			<inout> 
				<inout bind="txtTcoItemPK2"/>
				<inout bind="txtSizeCode2"/>
				<inout bind="txtSizeName2"/>
				<inout bind="txtColorCodeCap2"/>
                <inout bind="txtColorNameBody2"/>  
                <inout bind="txtColorCodeBody2"/> 
				<inout bind="txtColorNameCap2"/>
			</inout>
			</dso> 
		</xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="pro_shbo00100_check" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="PROD.pro_shbo00100_check" > 
                <input>
                    <input bind="txtLotNo" />  
                    <input bind="rdoSTATUS" />                    
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 40%" align="left" id="left">
                <table style="height: 100%; width: 100%">
                    <tr>
                    <td align="right" >
                            <b>Period</b>
                        </td>
                        <td  >
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch()" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch()" />
                        </td>
                         <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Machine No</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstMachineNoM" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Lot No</td>
                        <td style="width: 89%" colspan="2">
                            <gw:textbox id="txtTypeNoSearch" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>                        
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 20%">
                            Product Type</td>
                        <td style="width: 79%">
							<gw:radio id="rdoSTATUS_M" value="1" styles='height:22' onchange='OnSearch()'>
								<span value="1">Norm</span>
								<span value="2">BOX</span>
							</gw:radio >                            
                        </td>						
                       
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
							<gw:grid id="grdSearch" header="PK|Lot No|Hoki|Inst Date|Inst Qty|Iss No" format="0|0|0|4|1|0" aligns="0|0|0|0|3|0"
							defaults="|||||" 
							editcol="0|0|0|0|0|0" 
							widths="0|2000|2000|1500|1000|1000" 
							styles="width:100%;height:100%" 
							autosize='T'
							oncellclick="OnClickGridMaster()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:60%" align="right" id="right">
              <table style="height: 100%; width: 100%">
                <tr style="height: 5%">
                    <td></td>
                    <td>
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
									<gw:imgbtn img="printer" alt="Print" text="Print" id="btnReport" onclick="OnPrint()"/>
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('1')" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('1')" />
								</td>
							</tr>
						</table>
					</td>
                </tr>
                <tr style="height: 5%">	
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate" maxlen="10" lang="1"  styles='width:100%'/></td>
                </tr>
				<tr style="height: 5%">
                    <td style="width: 40%">Product Type</td>
					<td>
						<table style="width: 100%" border="0">
							<td style="width: 40%">
								<gw:radio id="rdoSTATUS" value="1" styles='height:22' onchange="OnChangeTab('1')">
									<span value="1">Norm</span>
									<span value="2">BOX</span>
								</gw:radio >
							</td>
							<td style="width: 60%">
								<gw:textbox id="txtBoxSeq" styles="width: 10%; display:none" />
							</td>	
						</table>
					</td>
                </tr>
                <tr style="height: 5%">
                    <td>Machine No</td>
                    <td><gw:list id="lstMachineNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Lot No</b></td>
                    <td><gw:textbox id="txtLotNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Package Q'ty(pcs)</td>
                    <td><gw:textbox id="txtProdQty"  type="number" format="###,###.##"  styles="width: 100%" onkeypress="CheckNum()" onenterkey="OnCalculate()"/></td>
                </tr>
				<tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('3')">Packing Unit</b></td>					
                    <td><gw:textbox id="txtPackingUnit" styles="width: 35%" /><gw:textbox id="txtPackingUnitQty" type="number" format="###,###.##" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Box Q'ty</td>
                    <td><gw:textbox id="txtBoxQty"  type="number" format="###,###.##"  styles="width: 100%"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Product Code</td>
                    <td><gw:textbox id="txtProductCode" styles="width: 35%" /><gw:textbox id="txtProductName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
					<td>Customer Code</td>
                    <td><gw:textbox id="txtCustomerCode" styles="width: 35%" /><gw:textbox id="txtCustomerName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Size</td>
                    <td><gw:textbox id="txtSizeCode" styles="width: 35%" /><gw:textbox id="txtSizeName" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(CAP)</td>
                    <td><gw:textbox id="txtColorCodeCap" styles="width: 35%" /><gw:textbox id="txtColorNameCap" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(BODY)</td>
                    <td><gw:textbox id="txtColorCodeBody" styles="width: 35%" /><gw:textbox id="txtColorNameBody" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="dtIssueDt" styles="width: 100%" lang="1" nullaccept /></td>

                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Issue By</b></td>
                  <td><gw:textbox id="txtIssueCode" styles="width: 35%" />
                  <gw:textbox id="txtIssueName" styles="width: 65%" /></td>
                </tr>
              </table> 
            </td>
            <td style="width:60%; display:none" align="right" id="right2">
              <table style="height: 100%; width: 100%">
                <tr style="height: 5%">
                    <td></td>
                    <td>
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
									<gw:imgbtn img="printer" alt="Print" text="Print" id="btnReport2" onclick="OnPrint()"/>
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="new" alt="New" id="btnAddNew2" onclick="OnNew()" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="delete" alt="Delete" id="btnDelete2" onclick="OnDelete('2')" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="save" alt="Save" id="btnSave2" onclick="OnSave('2')" />
								</td>
							</tr>
						</table>
					</td>
                </tr>
                <tr style="height: 5%">	
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate2" maxlen="10" lang="1"  styles='width:100%'/></td>
                </tr>
				<tr style="height: 5%">
                    <td style="width: 40%">Product Type</td>
					<td>
						<table style="width: 100%" border="0">
							<td style="width: 40%">
								<gw:radio id="rdoSTATUS2" value="1" styles='height:22' onchange="OnChangeTab('2')">
									<span value="1">Norm</span>
									<span value="2">BOX</span>
								</gw:radio >
							</td>
							<td style="width: 60%">
								<gw:textbox id="txtBoxSeq2" styles="width: 10%;" />
							</td>	
						</table>
					</td>
                </tr>
                <tr style="height: 5%">
                    <td>Machine No</td>
                    <td><gw:list id="lstMachineNo2" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Lot No</b></td>
                    <td><gw:textbox id="txtLotNo2" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Package Q'ty(pcs)</td>
                    <td><gw:textbox id="txtProdQty2"  type="number" format="###,###.##"  styles="width: 100%" onkeypress="CheckNum()" onenterkey="OnCalculate()"/></td>
                </tr>
				<tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('3')">Packing Unit</b></td>					
                    <td><gw:textbox id="txtPackingUnit2" styles="width: 35%" /><gw:textbox id="txtPackingUnitQty2" type="number" format="###,###.##" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Box Q'ty</td>
                    <td><gw:textbox id="txtBoxQty2"  type="number" format="###,###.##"  styles="width: 100%"/></td>
                </tr>
                <tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('4')">Product Code</b></td>
                    <td><gw:textbox id="txtProductCode2" styles="width: 35%" /><gw:textbox id="txtProductName2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
					<td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('5')">Customer Code</b></td>
                    <td><gw:textbox id="txtCustomerCode2" styles="width: 35%" /><gw:textbox id="txtCustomerName2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Size</td>
                    <td><gw:textbox id="txtSizeCode2" styles="width: 35%" /><gw:textbox id="txtSizeName2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(CAP)</td>
                    <td><gw:textbox id="txtColorCodeCap2" styles="width: 35%" /><gw:textbox id="txtColorNameCap2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(BODY)</td>
                    <td><gw:textbox id="txtColorCodeBody2" styles="width: 35%" /><gw:textbox id="txtColorNameBody2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="dtIssueDt2" styles="width: 100%" lang="1" nullaccept /></td>

                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Issue By</b></td>
                  <td><gw:textbox id="txtIssueCode2" styles="width: 35%" />
                  <gw:textbox id="txtIssueName2" styles="width: 65%" /></td>
                </tr>
              </table> 
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtChargerPK" style="display: none" />
    <gw:textbox id="txtTcoItemPK" style="display: none" />
    <gw:textbox id="txtTcoBuspartnerPK" style="display: none" />
    <gw:textbox id="txtBatLotPK" style="display: none" />
	
	 <gw:textbox id="txtMasterPK2" style="display: none" />
    <gw:textbox id="txtChargerPK2" style="display: none" />
    <gw:textbox id="txtTcoItemPK2" style="display: none" />
    <gw:textbox id="txtTcoBuspartnerPK2" style="display: none" />
    <gw:textbox id="txtBatLotPK2" style="display: none" />
    
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
