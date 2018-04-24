<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manufacturing Instruction and Record (3. Printing)</title>
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
var flag_insert = false;

//===============================================================

function BodyInit()
{
	right2.style.display='none';
		
	BindingDataList();

    dso_shbo00090_m.StatusInsert();

	lstMachineNo.SetDataText('');
	
    SetEnableControl();
    
    txtIssueNo.text="**New Issue No**";
//	txtIssueName.text = user_name;
//	txtIssueCode.text = user_id;
//	txtChargerPK.text = user_pk;
    
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
	OnSearch();
} 
//===============================================================
function SetEnableControl()
{  
	txtIssueNo.SetReadOnly(true);
	txtLicenseNo.SetReadOnly(true);
	txtLotNo.SetReadOnly(true);
	lstMachineNo.SetEnable(false);
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
	txtInkColorCap.SetReadOnly(true);
	txtInkColorBody.SetReadOnly(true);
	txtCapPinNo.SetReadOnly(true);
	txtBodyPinNo.SetReadOnly(true);
	txtPrintYN.SetReadOnly(true);
	txtIssueName.SetReadOnly(true);
	txtInkColorCapDesc.SetReadOnly(true);
	txtInkColorBodyDesc.SetReadOnly(true);
	dtIssueDt.SetEnable(false);
	txtIssueCode.SetReadOnly(true);
	txtIssueName.SetReadOnly(true);
	
	txtIssueNo2.SetReadOnly(true);
	txtLicenseNo2.SetReadOnly(true);
	txtLotNo2.SetReadOnly(true);
	lstMachineNo2.SetEnable(false);
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
	txtInkColorCap2.SetReadOnly(true);
	txtInkColorBody2.SetReadOnly(true);
	txtCapPinNo2.SetReadOnly(true);
	txtBodyPinNo2.SetReadOnly(true);
	txtPrintYN2.SetReadOnly(true);
	txtIssueName2.SetReadOnly(true);
	txtBoxSeq2.SetReadOnly(true);
	txtInkColorCapDesc2.SetReadOnly(true);
	txtInkColorBodyDesc2.SetReadOnly(true);
	dtIssueDt2.SetEnable(false);
	txtIssueCode2.SetReadOnly(true);
	txtIssueName2.SetReadOnly(true);
}
function ResetControl(flag)
{
    if(flag == '1')
    {
    if (dso_shbo00090_m.GetStatus()!="20")
    {
        dso_shbo00090_m.StatusInsert();
         rdoSTATUS.text = '1';
     }   
     else
        {
            txtMasterPK.text = '';
            rdoSTATUS.text = '1';
            lstMachineNo.value = '';
            txtLotNo.text = '';
            txtEstQty.text = '';
            txtIssueNo.text = '';
            txtLicenseNo.text = '';
            txtTcoItemPK.text = '' ;
            txtProductCode.text = '' ;    
            txtProductName.text = '';
            txtTcoBuspartnerPK.text = '';
            txtCustomerCode.text = '';
            txtCustomerName.text = '';
            txtSizeCode.text = ''  ;       
            txtSizeName.text = '' ;  
            txtColorCodeCap.text = ''  ;
	        txtColorNameCap.text = ''  ;
            txtColorCodeBody.text = '' ;              
            txtColorNameBody.text = '';
	        txtInkColorCap.text = '';
	        txtInkColorCapDesc.text = '';
	        txtInkColorBody.text = '';
	        txtInkColorBodyDesc.text = '';
            txtCapPinNo.text = '';
            txtBodyPinNo.text = '';
	        txtPrintYN.text = '';
            dtIssueDt.SetEnable(true);   
            txtChargerPK.text = '';
	        txtIssueCode.text = '';
            txtIssueName.text = ''  ;
            txtBatLotPK.text = '';
            }
        txtIssueName.text = user_name;
        txtIssueCode.text = user_id;
        txtChargerPK.text = user_pk;
           
	}
	else
	{
	if (dso_shbo00090_mb.GetStatus()!="20")
	{
        dso_shbo00090_mb.StatusInsert();
        rdoSTATUS2.text = '2';
      }
     else
        {
        	
	        txtMasterPK2.text = '';
            rdoSTATUS2.text = '2';
            lstMachineNo2.value = '';
            txtLotNo2.text = '';
            txtEstQty2.text = '';
            txtIssueNo2.text = '';
            txtLicenseNo2.text = '';
            txtTcoItemPK2.text = '' ;
            txtProductCode2.text = '' ;    
            txtProductName2.text = '';
            txtTcoBuspartnerPK2.text = '';
            txtCustomerCode2.text = '';
            txtCustomerName2.text = '';
            txtSizeCode2.text = ''  ;       
            txtSizeName2.text = '' ;  
            txtColorCodeCap2.text = ''  ;
	        txtColorNameCap2.text = ''  ;
            txtColorCodeBody2.text = '' ;              
            txtColorNameBody2.text = '';
	        txtInkColorCap2.text = '';
	        txtInkColorCapDesc2.text = '';
	        txtInkColorBody2.text = '';
	        txtInkColorBodyDesc2.text = '';
            txtCapPinNo2.text = '';
            txtBodyPinNo2.text = '';
	        txtPrintYN2.text = '';
            dtIssueDt2.SetEnable(true);   
            txtChargerPK2.text = '';
	        txtIssueCode2.text = '';
            txtIssueName2.text = ''  ;
            txtBatLotPK2.text = '';
	        txtBoxSeq2.text = '';
	      }	
	txtIssueName2.text = user_name;
    txtIssueCode2.text = user_id;
    txtChargerPK2.text = user_pk;
	
	}
    
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
    var right = document.all("right1"); 
    var right2 = document.all("right2");   
    var imgArrow = document.all("imgArrow");
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="50%";
        right2.style.width="50%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="50%";
        right2.style.width="50%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//===============================================================

function OnSearch()
{  
	flag_sel = true;	
	data_shbo00090_main_list.Call('SELECT');
}
//===============================================================
function OnChangeTab1()
{
    
    if(rdoSTATUS.value=='2')
    {
        right1.style.display='none'
        right2.style.display=''
        rdoSTATUS2.value='2'     
        OnNew()
    }
    
    
}
function OnChangeTab2()
{
    
    if(rdoSTATUS2.value=='1')
    {
        right1.style.display=''
        right2.style.display='none'
        rdoSTATUS.value=1
     }
}
//===============================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case'1':

                var fpath = System.RootURL + "/form/sh/bo/shbo00090_popup.aspx?";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                    
					    txtLotNo.text			= object[1];	// lot_no					
					    txtLotNo2.text			= object[1];	// lot_no
					
                    pro_shbo00090_check.Call();
                }
            
        break;
        case'2':
			var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
			var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 

			if (object != null)
			{
			    if(rdoSTATUS.value=='1')
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
		    if(rdoSTATUS.value=='2')
		    {
		        
				    var fpath = System.RootURL + "/form/sh/pb/shpb00111.aspx?prod_yn=Y";
				    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 

				    if (object != null)
				    {					
					    txtTcoItemPK2.text	= object[0];
					    txtProductCode2.text	= object[1];
					    txtProductName2.text	= object[2];					

					    dso_shbo00090_item.Call('SELECT');
				    }
			    			   
		    }	
		break;
		case '4':
		    if(rdoSTATUS.value == '2')
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
  if(txtMasterPK.text != '')
	{
		if(confirm('Do you want to delete ?'))
		{
			dso_shbo00090_m.StatusDelete();
			flag_sel	= false;
			dso_shbo00090_m.Call();
		}
	}
	
  }else
  {
    if(txtMasterPK2.text != '')
	{
		if(confirm('Do you want to delete ?'))
		{
			dso_shbo00090_mb.StatusDelete();
			flag_sel	= false;
			dso_shbo00090_mb.Call();
		}
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
         txtIssueNo.text="**New Issue No**";
    }else if(rdoSTATUS.value=='2' )
    {
         ResetControl('2')
         txtIssueNo2.text="**New Issue No**";
    }
	lstMachineNo.SetDataText('');
	lstMachineNo2.SetDataText('');
   
}
//===============================================================

function OnSave()
{
    if(rdoSTATUS.value == '1')
    {
        if(txtLotNo.text == '' )
           {
                alert("Please, Select LotNo !!!");
		        return;
        	
          }
       if(Number(txtEstQty.text) < 0 )
            {	
	            alert('Please, input Estimated Qty(pcs).');
	            return;
            }
	   
        flag_sel = false;
	    dso_shbo00090_m.Call();
    }
    
	 if(rdoSTATUS.value == '2')
    {
        if(txtLotNo2.text == '' )
           {
                alert("Please, Select LotNo !!!");
		        return;
        	
          }
       if(Number(txtEstQty2.text) < 0 )
            {	
	            alert('Please, input Estimated Qty(pcs).');
	            return;
            }
	   
        flag_sel = false;
	    dso_shbo00090_mb.Call();
    }
    
}
//===============================================================

function OnClickGridMaster()
{
    if (grdSearch.row > 0)
    {   
		DtInsDate.SetEnable(false);

		
		flag_insert = false;
		flag_sel	= true;
		
		if (rdoSTATUS_M.value =='1')
		{
		    right1.style.display=''
            right2.style.display='none'
            rdoSTATUS.value='1'
            txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
		    txtMasterPK2.SetDataText('');
      	    dso_shbo00090_m.Call('SELECT');
		}else
		{
		    right1.style.display='none'
            right2.style.display=''
            rdoSTATUS2.value='2'
            txtMasterPK2.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
		    txtMasterPK.SetDataText('');
            dso_shbo00090_mb.Call('SELECT');
		}
    }
}
//===============================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'dso_shbo00090_m':
            rdoSTATUS2.value='1' 
            rdoSTATUS.value='1' 
			if (flag_sel == false)
			{
				if (flag_insert == true)
				{
					flag_sel	= true;
					flag_insert = false;
					data_shbo00090_main_list.Call('SELECT'); 
				}
				
			}
        break;
        case'dso_shbo00090_mb':
            rdoSTATUS2.value='2' 
            rdoSTATUS.value='2' 
             if (flag_sel == false)
			{
				if (flag_insert == true)
				{
					flag_sel	= true;
					flag_insert = false;
					data_shbo00090_main_list.Call('SELECT'); 
				}
				
			}
        break;

        case'data_shbo00090_main_list':
            
            if(flag_sel == false)
            {					
                dso_shbo00090_m.StatusInsert();
                txtIssueNo.text="**New Issue No**";
				flag_sel = true;
            }
        break;
            
        case'pro_shbo00090_check':
            if(txtMasterPK.text=="" )
            {
                var lono= txtLotNo.text;
                if(dso_shbo00090_m.GetStatus()!="20")
                {
                    OnNew()
                }
                txtLotNo.text=lono;
                txtLotNo2.text=lono;
                if(rdoSTATUS.value == '1')
                {
                    dso_shbo00090_fill.Call("SELECT");
                }else
                {
                     dso_shbo00090_fill2.Call("SELECT");
                }
            }
            else
            {
                dso_shbo00090_m.Call("SELECT");
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
function OnPrint()
{
     if(rdoSTATUS.value=='2')
	{
	    if(txtMasterPK2.text!="")
	    {	        
		    var fpath = System.RootURL + "/form/sh/bo/shbo00220.aspx?main_m_pk=" + txtMasterPK2.text 
		    + "&inst_dt=" +DtInsDate2.value+ "&hoki="	+ lstMachineNo2.value
		    + "&issu_dt=" + dtIssueDt2.text  + "&lotno="	+ txtLotNo2.text 
		    + "&item=" + txtProductName2.text + "&customer="	+ txtCustomerName2.text + "&box_gu="+rdoSTATUS2.value;
    		
		    var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
	    }
	    else
	    {
		    alert("Please, Select Lotno !!!");
	    }
	}else
	{
	    if(txtMasterPK.text!="")
	    {
		    var fpath = System.RootURL + "/form/sh/bo/shbo00220.aspx?main_m_pk=" + txtMasterPK.text 
		    + "&inst_dt=" +DtInsDate.value+ "&hoki="	+ lstMachineNo.value
		    + "&issu_dt=" + dtIssueDt.text  + "&lotno="	+ txtLotNo.text 
		    + "&item=" + txtProductName.text + "&customer="	+ txtCustomerName.text+ "&box_gu="+rdoSTATUS.value;
    		
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
   <gw:data id="data_shbo00090_main_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00090_main_list">
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
    <gw:data id="dso_shbo00090_m" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,7,8,11,28,31" function="PROD.SP_SEL_SHBO00090_M" procedure="PROD.SP_UPD_SHBO00090">
            <inout> 
                <inout bind="txtMasterPK"/>
                <inout bind="DtInsDate"/>
				<inout bind="rdoSTATUS"/>
                <inout bind="lstMachineNo"/>
                <inout bind="txtLotNo"/>
                <inout bind="txtEstQty"/>
                <inout bind="txtIssueNo"/>
                <inout bind="txtLicenseNo"/>
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
				<inout bind="txtInkColorCap"/>
				<inout bind="txtInkColorCapDesc"/>
				<inout bind="txtInkColorBody"/>
				<inout bind="txtInkColorBodyDesc"/>
                <inout bind="txtCapPinNo"/>
                <inout bind="txtBodyPinNo"/>
				<inout bind="txtPrintYN"/>
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
    <gw:data id="dso_shbo00090_mb" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,7,8,11,28,31" function="PROD.SP_SEL_SHBO00090_Mb" procedure="PROD.SP_UPD_SHBO00090_MB">
            <inout> 
                <inout bind="txtMasterPK2"/>
                <inout bind="DtInsDate2"/>
				<inout bind="rdoSTATUS2"/>
                <inout bind="lstMachineNo2"/>
                <inout bind="txtLotNo2"/>
                <inout bind="txtEstQty2"/>
                <inout bind="txtIssueNo2"/>
                <inout bind="txtLicenseNo2"/>
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
				<inout bind="txtInkColorCap2"/>
				<inout bind="txtInkColorCapDesc2"/>
				<inout bind="txtInkColorBody2"/>
				<inout bind="txtInkColorBodyDesc2"/>
                <inout bind="txtCapPinNo2"/>
                <inout bind="txtBodyPinNo2"/>
				<inout bind="txtPrintYN2"/>
                <inout bind="dtIssueDt2"/>     
                <inout bind="txtChargerPK2"/>
				<inout bind="txtIssueCode2"/>
                <inout bind="txtIssueName2"/>  
                <inout bind="txtBatLotPK2"  />
				<inout bind="txtBoxSeq2"/>
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
	<gw:data id="dso_shbo00090_item" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="control" function="PROD.SP_SEL_SHBO00090_ITEM" procedure="">
			<inout> 
				<inout bind="txtTcoItemPK2"/>
				<inout bind="txtLicenseNo2"/>
				<inout bind="txtSizeCode2"/>
				<inout bind="txtSizeName2"/>
				<inout bind="txtColorCodeCap2"/>
                <inout bind="txtColorNameBody2"/>  
                <inout bind="txtColorCodeBody2"/> 
				<inout bind="txtColorNameCap2"/>
				<inout bind="txtInkColorCap2"/>
				<inout bind="txtInkColorCapDesc2"/>
				<inout bind="txtInkColorBody2"/>
				<inout bind="txtInkColorBodyDesc2"/>
			</inout>
			</dso> 
		</xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00090_fill" > 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00090_fill">
            <inout>
                <inout bind="txtLotNo"/>
                <inout bind="txtBatLotPK"  />       
                <inout bind="DtInsDate"/>
                <inout bind="txtEstQty"/>
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
                <inout bind="txtCapPinNo"/>
                <inout bind="txtBodyPinNo"/>
                <inout bind="lstMachineNo"/>
                <inout bind="txtInkColorCap"/>         
                <inout bind="txtInkColorCapDesc"/>   
                <inout bind="txtInkColorBody"/>
                <inout bind="txtInkColorBodyDesc"/>  
                <inout bind="txtTcoItemPK"/>   
                <inout bind="txtLicenseNo"/>      
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
     <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shbo00090_fill2" > 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00090_fill">
            <inout>
                <inout bind="txtLotNo2"/>
                <inout bind="txtBatLotPK2"  />       
                <inout bind="DtInsDate2"/>
                <inout bind="txtEstQty2"/>
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
                <inout bind="txtCapPinNo2"/>
                <inout bind="txtBodyPinNo2"/>
                <inout bind="lstMachineNo2"/>
                <inout bind="txtInkColorCap2"/>         
                <inout bind="txtInkColorCapDesc2"/>   
                <inout bind="txtInkColorBody2"/>
                <inout bind="txtInkColorBodyDesc2"/>  
                <inout bind="txtTcoItemPK2"/>   
                <inout bind="txtLicenseNo2"/>      
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="pro_shbo00090_check" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="PROD.pro_shbo00090_check" > 
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
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch()"/>
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch()"/>
                        </td>
                         <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%; white-space: nowrap">
                            Machine No</td>
                        <td style="width: 80%" align="right" colspan="2">
                            <gw:list id="lstMachineNoM" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%" align="right">
                            Lot No</td>
                        <td style="width: 80%" colspan="2">
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
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Lot No|Hoki|Inst Date|Inst Qty|Iss No|Box Gu" format="0|0|0|4|1|0|0" aligns="0|0|0|0|3|0|0"
                                defaults="||||||" editcol="0|0|0|0|0|0|0" widths="0|2000|2000|1500|1000|1000|0" styles="width:100%;height:100%" autosize='T'
                                oncellclick="OnClickGridMaster()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:60%" align="right" id="right1" >
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
									<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
								</td>
							</tr>
						</table>
					</td>
                </tr>
                <tr style="height: 5%">	
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate" maxlen="10" styles='width:100%' lang="1"/></td>
                </tr>
				<tr style="height: 5%">
                    <td style="width: 40%">Product Type</td>
                    <td style="width: 60%" NOWRAP>
						<gw:radio id="rdoSTATUS" value="1" styles='height:22' onchange="OnChangeTab1()">
							<span value="1">Norm</span>
							<span value="2">BOX</span>
						</gw:radio >&#160;
						
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
                    <td>Estimated Qty(pcs)</td>
                    <td><gw:textbox id="txtEstQty"  type="number" format="###,###.##"  styles="width: 100%" onkeypress="CheckNum()"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue No.</td>
                    <td><gw:textbox id="txtIssueNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>License No.</td>
                    <td><gw:textbox id="txtLicenseNo" styles="width: 100%" /></td>
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
                    <td>Ink Color(CAP)</td>
                    <td><gw:textbox id="txtInkColorCap" styles="width: 35%" /><gw:textbox id="txtInkColorCapDesc" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Ink Color(BODY)</td>
                    <td><gw:textbox id="txtInkColorBody" styles="width:35%" /><gw:textbox id="txtInkColorBodyDesc" styles="width:65%" /></td>
                </tr>
				<tr style="height: 5%">
                    <td>Cap Pin No.</td>
                    <td><gw:textbox id="txtCapPinNo" styles="width:80%" />&#160;&#160;&#160;&#160;&#160;Print Y/N</td>
                </tr>
				<tr style="height: 5%">
                    <td>Body Pin No.</td>
                    <td><gw:textbox id="txtBodyPinNo" styles="width:80%" /><gw:textbox id="txtPrintYN" styles="width:20%; align:center" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="dtIssueDt" styles="width: 100%" lang="1" nullaccept/></td>
                </tr>
                <tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('2')">Issue By</b></td>
                    <td><gw:textbox id="txtIssueCode" styles="width: 35%" />
                    <gw:textbox id="txtIssueName" styles="width: 65%" /></td>
                </tr>
              </table>               
            </td>
            <td style="width:60%" align="right" id="right2">
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
									<gw:imgbtn img="save" alt="Save" id="btnSave2" onclick="OnSave()" />
								</td>
							</tr>
						</table>
					</td>
                </tr>
                <tr style="height: 5%">	
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate2" maxlen="10" styles='width:100%' lang="1"/></td>
                </tr>
				<tr style="height: 5%">
                    <td style="width: 40%">Product Type</td>
                    <td style="width: 60%" NOWRAP>
						<gw:radio id="rdoSTATUS2" value="1" styles='height:22' onchange="OnChangeTab2()">
							<span value="1">Norm</span>
							<span value="2">BOX</span>
						</gw:radio >&#160;
						<gw:textbox id="txtBoxSeq2" styles="width: 15%" />
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
                    <td>Estimated Qty(pcs)</td>
                    <td><gw:textbox id="txtEstQty2"  type="number" format="###,###.##"  styles="width: 100%" onkeypress="CheckNum()"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue No.</td>
                    <td><gw:textbox id="txtIssueNo2" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>License No.</td>
                    <td><gw:textbox id="txtLicenseNo2" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('3')">Product Code</b></td>
                    <td><gw:textbox id="txtProductCode2" styles="width: 35%" /><gw:textbox id="txtProductName2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
					<td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('4')">Customer Code</b></td>
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
                    <td>Ink Color(CAP)</td>
                    <td><gw:textbox id="txtInkColorCap2" styles="width: 35%" /><gw:textbox id="txtInkColorCapDesc2" styles="width: 65%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Ink Color(BODY)</td>
                    <td><gw:textbox id="txtInkColorBody2" styles="width:35%" /><gw:textbox id="txtInkColorBodyDesc2" styles="width:65%" /></td>
                </tr>
				<tr style="height: 5%">
                    <td>Cap Pin No.</td>
                    <td><gw:textbox id="txtCapPinNo2" styles="width:80%" />&#160;&#160;&#160;&#160;&#160;Print Y/N</td>
                </tr>
				<tr style="height: 5%">
                    <td>Body Pin No.</td>
                    <td><gw:textbox id="txtBodyPinNo2" styles="width:80%" /><gw:textbox id="txtPrintYN2" styles="width:20%; align:center" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="dtIssueDt2" styles="width: 100%" lang="1" nullaccept/></td>
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
    <gw:textbox id="txtMasterPK2" style="display: none" />
    <gw:textbox id="txtChargerPK" style="display: none" />
    <gw:textbox id="txtTcoItemPK" style="display: none" />
    <gw:textbox id="txtTcoBuspartnerPK" style="display: none" />
    <gw:textbox id="txtBatLotPK" style="display: none" />
    
    <gw:textbox id="txtChargerPK2" style="display: none" />
    <gw:textbox id="txtTcoItemPK2" style="display: none" />
    <gw:textbox id="txtTcoBuspartnerPK2" style="display: none" />
    <gw:textbox id="txtBatLotPK2" style="display: none" />
	
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
