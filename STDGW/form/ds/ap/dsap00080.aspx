<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Collection Slip Entry</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//-----------------------------------------------------

var flag;

var G_PK        = 0,     
    G_SLip_No   = 1,
    G_Date      = 2,
    G_PARTNER   = 3;

//=================================================================================

var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1;
    G1_SEQ              = 2,
    G1_REF_NO           = 3,
    G1_ITEM_DESC        = 4,
    G1_REQ_AMOUNT       = 5,
    G1_PAY_AMOUNT       = 6,
    G1_BAL_AMOUNT       = 7,
    G1_COLLECT_DESC     = 8,
    G1_PC_COL_REQ_PK    = 9;
    
    
var arr_FormatNumber = new Array();   
	   
 //===============================================================================================
function OnToggle()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //===============================================================================================
 
var rtnLGCode = '' ;

function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
     
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtCustomerName.SetEnable(false);      
   
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;   
       
    //----------------------------         
    SetGridFormat();  
    //----------------------------
    OnAddNew('Master');
 }
 //==================================================================================
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_PAY_AMOUNT) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_BAL_AMOUNT) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_REQ_AMOUNT) = "#,###,###,###,###,###.##";
    
    arr_FormatNumber[G1_PAY_AMOUNT] = 2; 
	arr_FormatNumber[G1_BAL_AMOUNT] = 2;  
		
	var data ;
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0301') FROM DUAL")%>||";  //report type
    lstOutType.SetDataText(data);
    lstOutType.value="";
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGSA6020') FROM DUAL")%>||";  //report type
    lstCollectType.SetDataText(data);
    lstCollectType.value="";
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
    lstCurrency.SetDataText(data);    	 
 }
 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_dsap00080_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            
            txtReqAmt.text = 0;
            txtPayAmt.text = 0;
            txtBalAmt.text = 0;
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;  
        
//        case 'FreeItem':
//             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=||Y|Y||';//purchase_yn=Y
//             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
//             
//             if ( object != null )
//             {                    
//                    var arrTemp;
//                    for( var i=0; i < object.length; i++)	  
//                    {	
//                            arrTemp = object[i];
//                                
//                            grdDetail.AddRow();                            
//                            
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
//                            
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
//                            
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK, arrTemp[0]);//item_pk	    
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE,   arrTemp[1]);//item_code	    
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME,   arrTemp[2]);//item_name	    
//                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM,         arrTemp[5]);//item_uom                         
//                    }	
//             }        
//        break;                            		 
				             
        case 'SO':
		
			 if ( txtCustomerPK.text == '' )
			 {
			  		alert("PLS SELECT CUSTOMER FIRST.");
					return;
			 }
			 
             var path = System.RootURL + '/form/ds/ap/dsap00081.aspx?CustomerPK='+txtCustomerPK.text+'&CustomerName='+txtCustomerName.text;
             var object = System.OpenModal( path ,1000 , 550 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------         	                         
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); 						
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1); 
						                      
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,        arrTemp[3]); 
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_AMOUNT,    arrTemp[6]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_PAY_AMOUNT,    arrTemp[7]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_BAL_AMOUNT,    Number(arrTemp[6]) - Number(arrTemp[7]) );
                        grdDetail.SetGridText( grdDetail.rows-1, G1_COLLECT_DESC,  arrTemp[11]);   
                         
                        grdDetail.SetGridText( grdDetail.rows-1, G1_PC_COL_REQ_PK, arrTemp[0]);  
						
						lstCurrency.value = arrTemp[8];
						txtExRate.text    = arrTemp[9];
						
						lstOutType.value = arrTemp[12];							 					
                    }
					//------------------  
                 	TotalAmount();  
             }                                                                 
        break;                                        
    }
}  
 //===============================================================================================
 
 function TotalAmount()
{
	var req_amt = 0 ;
	var pay_amt = 0 ;
	var bal_amt = 0 ;
	
	for( i=1; i<grdDetail.rows; i++)
	{			 
 			req_amt = Number(req_amt) + Number(grdDetail.GetGridData( i, G1_REQ_AMOUNT ));
			pay_amt = Number(pay_amt) + Number(grdDetail.GetGridData( i, G1_PAY_AMOUNT ));		 		 
	}
	
	bal_amt = Number(req_amt) - Number(pay_amt);
	
	txtReqAmt.text = req_amt ;
	txtPayAmt.text = pay_amt ;
	txtBalAmt.text = bal_amt ;
}
 
//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_dsap00080.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_dsap00080_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                    }
                    flag = 'view' ;
                    data_dsap00080_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                
                flag = 'view' ;
                data_dsap00080_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_dsap00080_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
    
        case 'data_fpab00220_2':
            if ( txtLGGroupCodeID.text == 'LGCM0110')
			 {
				 lstOutType.SetDataText(txtLGCodeList.text);
				 lstOutType.value = rtnLGCode;
			 }
			 
			 if ( txtLGGroupCodeID.text == 'LGSA6020')
			 {
				 lstCollectType.SetDataText(txtLGCodeList.text);
				 lstCollectType.value = rtnLGCode;
			 }
        break;
        case "data_dsap00080_1": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    } 
                }
                //----------------------------
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }
                            
        break;

        case "data_dsap00080_2":
           
            if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G1_REF_NO, grdDetail.rows - 1, G1_REF_NO,  true);
	            grdDetail.SetCellFontColor(1,G1_BAL_AMOUNT,grdDetail.rows - 1,G1_BAL_AMOUNT,0x3300CC);
            }         
        break;      
        
        case 'pro_dsap00080':
            alert(txtReturnValue.text);
            OnSearch('grdMaster');
        break;                
   }            
}
//=================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Submit' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to submit this Slip?'))
                {
                    pro_dsap00080.Call();
                } 
            }                          
        break;        
    }
}
//=================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text = obj[2];
                txtStaffPK.text   = obj[0];
            }
        break;            

        case 'Customer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtCustomerPK.text   = object[0];
                txtCustomerName.text = object[2];                
	         }
        break;       
       
        case 'Type' :
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA6020";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
             if ( object != null )
             {	        	                   
                if ( object[0] == 1 )
                {
                    txtLGGroupCodeID.text = 'LGSA6020';
                    rtnLGCode             = object[1];
                    
                    data_fpab00220_2.Call("SELECT");                                
                }
                else
                {
                    lstCollectType.value = object[1];      
                }    	                
             } 
        break;                    
    }	       
}
  
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_dsap00080_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_dsap00080_2.Call();
        break;
    }
}

//=================================================================================

function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_dsap00080_1.StatusDelete();
                data_dsap00080_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_DETAIL_PK ) == '' )
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
//=================================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//=================================================================================
function Validate()
{   
	if ( txtCustomerPK.text == "" )
	{
		alert("PLS SELECT CUSTOMER.");
		return false;
	}
    //---------------
//    for( var i = 1; i < grdDetail.rows; i++)
//    {
//        //---------------
//        if ( Number(grdDetail.GetGridData( i, G1_REQ_QTY)) == 0 )
//        {
//            alert("Input req qty. at " + i + ",pls!")
//            return false;
//        }
//        //---------------
//    }
    //----------------
    return true;
}

//=================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_PAY_AMOUNT )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }     
		
		//-------------------------
		var dBalAmt = 0 ;
		
		dBalAmt = Number(grdDetail.GetGridData( row, G1_REQ_AMOUNT)) - Number(grdDetail.GetGridData( row, G1_PAY_AMOUNT)) ;
		grdDetail.SetGridText( row, G1_BAL_AMOUNT, System.Round( dBalAmt, arr_FormatNumber[G1_BAL_AMOUNT] ));
		
		//-------------------------
		TotalAmount();                
    }      
} 
 
//=================================================================================
function OnPrint()
{    
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/ds/ap/rpt_dsap00080.aspx?master_pk=' + txtMasterPK.text ;         
        System.OpenTargetPage(url); 	    
	}
	else
	{
	    alert("Pls select one slip.");
	}
}
//=================================================================================
function OnAddRow()
{
    grdDetail.AddRow();
    grdDetail.SetGridText( grdDetail.rows - 1, G1_SEQ, grdDetail.rows - 1);
}
</script>

<body>
	<!------------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
               <output>
                    <output bind="txtLGCodeList" /> 
               </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dsap00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_SEL_DSAP00080" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtSearchNo" />
					<input bind="txtPartner" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_dsap00080_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="<%=l_user%>lg_sel_dsap00080_1"  procedure="<%=l_user%>lg_upd_dsap00080_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtReqDate" />
                     <inout  bind="lblStatus" />
					 <inout  bind="txtRefNo" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />                                          
                     <inout  bind="txtCustomerPK" />
                     <inout  bind="txtCustomerName" />					 				 
                     <inout  bind="txtRemark" />             
                     <inout  bind="lstOutType" />  
                     <inout  bind="lstCollectType" />          
                     <inout  bind="txtReqAmt" /> 
                     <inout  bind="txtPayAmt" /> 
                     <inout  bind="txtBalAmt" />    
                     <inout  bind="lstCurrency" /> 
                     <inout  bind="txtExRate" />                                                                       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00080_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_dsap00080_2"   procedure="<%=l_user%>lg_upd_dsap00080_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00080" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%" align="right">
                            Partner
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtPartner" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            No.
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|No|Slip Date|Partner' format='0|0|4|0'
                                aligns='0|0|0|0' check='|||' editcol='0|0|0|0' widths='0|1500|1200|1000' sorting='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtReqDate" lang="1" />
                        </td>
                        <td style="width: 20%" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Ref No
                        </td>
                        <td>
                            <gw:textbox id="txtRefNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="10">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a title="Customer" onclick="OnPopUp('Customer')" href="#tips" style="color=#0000ff">
                                <b>Customer</b></a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtCustomerPK" styles="display:none" />
                            <gw:textbox id="txtCustomerName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Ex-Rate
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td style="white-space: nowrap" colspan="7">
                            <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">                             
                                Out Type 
                        </td>
                        <td style="white-space: nowrap">
                            <gw:list id="lstOutType" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a title="Customer" onclick="OnPopUp('Type')" href="#tips" style="color=#0000ff"><b>
                                Collect Type</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="10">
                            <gw:list id="lstCollectType" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Collect Desc
                        </td>
                        <td style="white-space: nowrap" colspan="12">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="13">
                            <table style="width: 100%; height: 100%; background-color: #CCFFFF">
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Req Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtReqAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Pay Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtPayAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Bal Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtBalAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="14">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 64%" align="right">
                                    </td>
                                    <td style="width: 19%; white-space: nowrap" align="center">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                        
                                    </td>
                                    <td align="right" style="width: 1%">
                                        
                                    </td>
                                    <td style="width: 1%">
                                       <gw:icon id="idBtnReq" img="2" text="Req" styles='width:100%' onclick="OnAddNew('SO')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="idBtnPO2" img="new" alt="New" text="New" styles='width:100%' onclick="OnAddRow()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="14">
                            <gw:grid id='grdDetail' 
								header='_PK|_MASTER_PK|Seq|Ref No|_Item Desc|Req Amount|Pay Amount|Bal Amount|Collect Desc|_PC_COLLECT_REQ_M_PK'
                                format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|3|3|3|0|0' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                                widths='0|0|800|1500|2000|1500|1500|1500|1000|1000' sorting='T'
                                styles='width:100%; height:100%' acceptnulldate='T' onafteredit="CheckInput()"
                                />
                            />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:textbox id="txtLGGroupCodeID" styles="width: 100%;display: none" />
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />

<!---------------------------------------------------------------------------------->
</html>
