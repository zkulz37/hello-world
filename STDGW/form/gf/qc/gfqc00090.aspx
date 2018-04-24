<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ADVANCE REQUEST ENTRY</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
var flag='search' ;
function BodyInit()
{
	
   FormatGridDetail();
   FormatGridTerms();
	
    
	txtWeightQty.text = "1";
	
	
	 automode();
	 BindingDataList();
	 ChangeEx();
	 dat_gfqc00090_1.Call('SELECT');
}
//----------------------------------------------------------------------------------
function BindingDataList()
 {      
     var data ;
     var arr;
     txtUser_Pk.SetDataText("<%=session("USER_PK")%>");
	 txtCharger.SetDataText("<%=session("USER_ID")%>");
     data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     lstCompany.SetDataText(data);
     lstCompany.value = "<%=Session("COMPANY_PK") %>";
	 data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
     lstCurrency.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0001') FROM DUAL")%>";
     lstArea.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACAB051') FROM DUAL")%>";
     lstBiz.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0002') FROM DUAL")%>";
     lstUnit.SetDataText(data);
     OnNew(0);
     
 }
 //--------------------------------------------------------------------------------------------
 function ChangeEx()
{
    txtExRate1.SetDataText('1');
   txtExRate.SetDataText("1");
   txtExRate.SetEnable(false);
   txt_row.text    = 1;
   
   var ls_current  = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
   lstCurrency.SetDataText(ls_current);
}  
 //---------------------------------------------------------------------------------------------
function FormatGridTerms()
{
	var ctrl = GridTerms.GetGridControl();
	ctrl.ColWidth(0) = 0;
	ctrl.ColWidth(1) = 0;
	ctrl.ColWidth(2) = 1200;
	ctrl.ColWidth(3) = 800;
	ctrl.ColWidth(4) = 1500;
	ctrl.ColWidth(5) = 0;
	ctrl.ColWidth(6) = 0;
	ctrl.ColWidth(7) = 1100;
	ctrl.ColWidth(8) = 1000;
	ctrl.ColWidth(9) = 1000;
	ctrl.ColWidth(10) = 1200;
	FormatNumberGrid_Book();
}
 //---------------------------------------------------------------------------------------------
function FormatGridDetail()
{
	var ctrl = GridDetail.GetGridControl();
	ctrl.ColWidth(0) = 500;
	ctrl.ColWidth(1) = 0;
	ctrl.ColWidth(2) = 0;//sua lai
	ctrl.ColWidth(3) = 1600;
	ctrl.ColWidth(4) = 1600;
	ctrl.ColWidth(5) = 0;
	ctrl.ColWidth(6) = 1600;
	ctrl.ColWidth(7) = 1500;
	ctrl.ColWidth(8) = 1500;
	
	
	FormatNumberGrid_Book();
}
 //---------------------------------------------------------------------------------------------

function FormatNumberGrid_Book()
{
	var ctrl1 = GridDetail.GetGridControl();
	var ctrl2 = GridTerms.GetGridControl();	
	if(lstBookCurrency.GetData() == "VND")
	{
		ctrl1.ColFormat(6) 	 = "#,###,###,###,###";	
		ctrl1.ColFormat(7) 	 = "#,###,###,###,###";
		ctrl1.ColFormat(8) 	 = "#,###,###,###,###";
		
		ctrl2.ColFormat(5)   = "#,###,###,###,###";
	}
	else
	{
		ctrl1.ColFormat(6)   = "#,###,###.##";		
		ctrl1.ColFormat(7)   = "#,###,###.##";	
		ctrl1.ColFormat(8)   = "#,###,###.##";	
		ctrl2.ColFormat(5)   = "#,###,###.##";		
			
	}
}
//---------------------------------------------------------------------------------------
function OnChangeCurrent()
{
    
    dso_get_rate.Call();
    
    
} 

 //---------------------------------------------------------------------------------------------
function Calculate(obj)
{
    switch(obj)
    {
        case 'detail':
                OnChangeAmt();
        break;
        case 'term':
                var ctrl = GridTerms.GetGridControl();
	            var amount = 0;
	            var bookamt = 0; 
	            var exrate = 0;
	            exrate = Number(txtExRate.GetData());
	            if (exrate != 0)
	            {
		            for (var i = 1; i < ctrl.rows; i++)
		            {
			            amount = Number(GridTerms.GetGridData(i, 4));		   
            			
			            if (lstBookCurrency.GetData() != 'VND')
			            {
				            bookamt = Math.round(amount * 100 / exrate) / 100;				
			            } else
			            {
				            bookamt = Math.round(amount * exrate * 100) / 100;				
			            }
			            GridTerms.SetGridText(i, 5,'' + bookamt);	
		            }
	            }
        break;
    }
	
}
 //---------------------------------------------------------------------------------------------
function OnChangeAmt()
{

	var ctrl   = GridDetail.GetGridControl();
	var amount = 0;
	var bookamt = 0;
	var AdjAmtTemp = 0;
	var famt = 0;
	var exrate = 0;
	var FTotalAdjAmount = 0;
	var QtyAdj = 0;
	var TotalVatAdj = 0;
	var TotalVatAdjTmp = 0;
	for (var i = 1; i < ctrl.rows; i++)
	{
		if (GridDetail.GetRowStatus(i) <64) //Not Mark delete
		{
		    if (lstUnit.value != "VALUES")
		    {
			    QtyAdj =  Number(GridDetail.GetGridData(i, 4));//Qty
			  
			    AdjAmtTemp = Number(GridDetail.GetGridData(i,6));
			    FTotalAdjAmount = FTotalAdjAmount + AdjAmtTemp;
			    
			    TotalVatAdjTmp = Number(GridDetail.GetGridData(i,7));
			    GridDetail.SetGridData(i,8,GridDetail.GetGridData(i,7));
			    TotalVatAdj = TotalVatAdj + TotalVatAdjTmp;
			    
			}
			else
			{
			    GridDetail.SetGridText(i, 4,1);
			    AdjAmtTemp = Number(GridDetail.GetGridData(i, 6));//Contract amt adj
			    FTotalAdjAmount = FTotalAdjAmount + AdjAmtTemp;
			    
			    TotalVatAdjTmp = Number(GridDetail.GetGridData(i,7));
			    GridDetail.SetGridData(i,8,GridDetail.GetGridData(i,7));
			    TotalVatAdj = TotalVatAdj + TotalVatAdjTmp;
			}
		}
	}
	txtAdjust_Amt.text =  "" + FTotalAdjAmount;	
	txtVAT_Adj.text = "" + TotalVatAdj;
	
	var nWeightQty = 0;
	var nUnitPrice = 0;
	var nContractAmt = 0;
	var nAdjAmt = 0;
	var nFAmt = 0;
	nWeightQty	= Number(txtWeightQty.GetData());
	nUnitPrice		= Number(txtUnitPrice.GetData());
	nAdjAmt		= Number(txtAdjust_Amt.GetData());
	nContractVAT    =   Number(txtVAT.GetData());
	nContractAmt	=	nWeightQty*(nUnitPrice + nContractVAT);
	
	nVatAdj         =   Number(txtVAT_Adj.GetData());
	
	nFAmt = nContractAmt + nAdjAmt  + nVatAdj;
	
	txtContract_Amt.SetDataText(''+nContractAmt);
	
	txtFinal_Amt.SetDataText(''+nFAmt);
	
	var ctrl   = GridTerms.GetGridControl();
	var amount = 0;
	var bookamt = 0; 
	var exrate = 0;
	for(i=1;i<GridTerms.rows;i++)
	{
            var strRate = GridTerms.GetGridData(i, 6);
	        if (strRate =="50")
	        {
	                GridTerms.SetGridText(i, 4,''); 
	        }
            else
            {
                amount = Number(GridTerms.GetGridData(i, 3));
                amount = amount * Number(txtFinal_Amt.GetData()) / 100;
                GridTerms.SetGridText(i, 4,'' + amount);
            }
	  }
}
 //---------------------------------------------------------------------------------------------
function UpperKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
 //---------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        case 1:
                var url 	= System.RootURL + "/form/gf/qc/gfqc00090_popup_customer.aspx?ap_yn=Y";
	            var aValue  = System.OpenModal( url, 850, 500, 'resizable:yes;status:yes');	 
	            if ( aValue != null )  
	            {
		            txtCust_Pk.text   = aValue[0];//cust Pk
		            txtCust_Code.text = aValue[1];//cust code
		            txtCust_Name.text = aValue[3];//cust name 	 	
	            }  
        break;
        case 2:
            
             fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
             oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            if ( oValue != null )
            {
                txtProject_Pk.text = oValue[2]; 
                txtProject_Name.text   = oValue[1];
                txtProject_Code.text   = oValue[0];
            }
        break;
    }
	
}
 //---------------------------------------------------------------------------------------------
function OnResetCust()
{
	txtCust_Pk.SetDataText('');
	txtCust_Code.SetDataText('');
	txtCust_Name.SetDataText('');
}
 
 //---------------------------------------------------------------------------------------------
function OnResetProject()
{
	txtProject_Pk.SetDataText('');
	txtProject_Code.SetDataText('');
	txtProject_Name.SetDataText('');
}
//----------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{  
    switch(obj.id)
    {  
      
            case "dat_gfqc00090_1":          
            if(flag != 'search')
            
            {
               
                for(i = 1; i < GridDetail.rows; i++)
                {
                    if(GridDetail.GetGridData(i, 2)=='')
                    {
                        GridDetail.SetGridText(i, 2, txtPK.text);
                        GridDetail.SetRowStatus(i, 0x20);
                    }    
                }
                dat_Detail.Call();
              }
              else
              {
                dat_Detail.Call('SELECT');
              }  /**/ 
        break;  
        case "dat_gfqc00090_2":    
               switch(flag)
               {
                    case 'update':
                        for(i=1;i< GridTerms.rows; i++)
                        {
                            GridTerms.SetGridText(i, 1, txtPK.text);
                           // alert(GridTerms.GetGridData(i,0));
                            if(GridTerms.GetGridData(i, 0)=='')
                            {                        
                                GridTerms.SetRowStatus(i, 0x20);
                            }
                        }
                       dat_gfqc00090_1.Call(); 
                    break;
                    case 'delete':
                        for(i=1;i< GridTerms.rows; i++)
                        {
                            if(GridTerms.GetGridData(i, 0)=='')
                            {                        
                                GridTerms.SetRowStatus(i, 0x40);
                            }
                        }
                          dat_gfqc00090_1.Call();
                    break;
                    case 'search':
                       
                            dat_gfqc00090_1.Call('SELECT');
                    break;
               } 
                
           
        break; 
       
    }  
}
 //---------------------------------------------------------------------------------------------
function OnDelete(index)
{
    switch(index)
    {
        case 0:
            if(txtPK.GetData()!='')
            {
                if(confirm('Do you want to delete subcontract?'))
                {
                     flag='delete';
                     //alert(dat_gfqc00090_2.GetRowStatus(2));
                     dat_gfqc00090_2.StatusDelete();
                     dat_gfqc00090_2.Call();
                     
                }
            }    
        break;
        case 1:
            if   (GridDetail.rows >1)
	        {
		        
				        GridDetail.DeleteRow();
				        OnChangeAmt();//CalculateDetail();
	        }
	        else
	        {
		        alert("You must select row to delete");
	        }
        break;
    }         
}
 //---------------------------------------------------------------------------------------------
function onClickUndeleteDetail()
{
        if (GridDetail.GetRowStatus(GridDetail.row) > 63)
        {
	        GridDetail.UnDeleteRowAt(GridDetail.row);
	        OnChangeAmt();
        }

}
 //---------------------------------------------------------------------------------------------
function OnEdit(obj)
{
    switch(obj)
    {
        case 'detail':
                if (event.col == 4 ||event.col == 6 || event.col == 7)
	            {
		            OnChangeAmt();
            		
                }
        break;
        case 'term':
                if ((event.col == 7) || (event.col ==8))
                {
                    if (event.row != 4)
                    {
                        GridTerms.SetGridText(event.row,event.col,'');   
                        return;
                    }
                }
             

	            var ctrl   = GridTerms.GetGridControl();
	            var amount = 0;
	            var bookamt = 0; 
	            var exrate = 0;
            	
            	
	            var strRate = GridTerms.GetGridData(event.row, 6);
	                    if (strRate =="50")
	                    {
	                            GridTerms.SetGridText(event.row, 4,''); 
	                    }
	                    else
	                    {
	                        amount = Number(GridTerms.GetGridData(event.row, 3));
	                        amount = amount * Number(txtFinal_Amt.GetData()) / 100;
	                        GridTerms.SetGridText(event.row, 4,'' + amount);
	                    }
        break;
    }
	
}

 //---------------------------------------------------------------------------------------------
function onSearchMaster()
{
	var aValue = new Array();
   	var fpath = System.RootURL + "/form/gf/qc/gfqc00090_popup_search.aspx";
   	aValue  = System.OpenModal(  fpath , 950 , 500 , 'resizable:yes;status:yes');	
   // txtOldContractNo.text = '';
   	if (aValue != null) 
   	{	
		txtPK.SetDataText(aValue[0]);
		dat_gfqc00090_2.Call("SELECT");
		
	}
}
 //---------------------------------------------------------------------------------------------
function OnNew(index)
{
    switch(index)
    {
        case 0: // New master
            //flag='new';
           
            dat_gfqc00090_2.StatusInsert();
        //    txtExRate1.SetDataText('1');
 //  txtExRate.SetDataText("1");
                        txtUser_Pk.text =  "<%=Session("USER_PK") %>";
           GridDetail.ClearData();
           for(var i = 1; i < GridTerms.rows; i++)
           {
                for(var j = 3; j < GridTerms.cols ; j++)
                {
                    if(j !=6)
                    {
                        GridTerms.SetGridText(i, j, "");
                    }    
                }                
           }
           ChangeEx();
            //idAuto.SetDataText("Y");
        break;
        case 1: // new free detail
           
            GridDetail.AddRow();
	        GridDetail.SetGridText((GridDetail.rows -1), 0,(GridDetail.rows -1) ); //Row No
	        GridDetail.SetGridText((GridDetail.rows -1), 3,(GridDetail.rows -1) ); //Row No
	        GridDetail.SetGridText((GridDetail.rows -1), 4,1 ); //Quantity
	        OnChangeAmt();
        break;
   }

}

 //---------------------------------------------------------------------------------------------
function CheckOnSave()
{
	if (txtContract_No.GetData() == '')
	{
		alert('Please input Contract No on Master !!');
		return false;
	}
	if (txtCust_Pk.GetData() == '')
	{
		alert('Please select Customer on Master !!');
		return false;
	}
	if (txtProject_Pk.GetData() == '')
	{
		alert('Please select Project on Master !!');
		return false;
	}
	
	return true;
}
 //---------------------------------------------------------------------------------------------
function onSaveMaster()
{
    flag='update';
	if (CheckOnSave())
	{
		if(txtPK.GetData()!='') flag='update';        
        dat_gfqc00090_2.Call();
	}
	
}

 //---------------------------------------------------------------------------------------------
function OnKeyDetailPress()
{

    if ( event.keyCode == 0 )
	{
	    OnEdit('detail');
	}
}
 //---------------------------------------------------------------------------------------------
function OnPrint()
{
	if(txtPK.text !="")
            {
                var url = '/reports/gf/qc/gfqc00090.aspx?p_tac_subcontract_pk=' + txtPK.GetData() + '&p_company=' + lstCompany.GetData();
                System.OpenTargetPage( System.RootURL+url , "newform" );
            }
            else
            {
                alert("Please search code master!!!");
            }
}
 //---------------------------------------------------------------------------------------------
function automode()
{
    if (idAuto.value =="Y")
    {
        txtContract_No.text ='';
        txtContract_No.SetEnable(false);
        lstBiz.SetEnable(true);
        lstArea.SetEnable(true);
        makeAutoContractNo();
    }
    else
    {
        txtContract_No.SetEnable(true);
        lstBiz.SetEnable(false);
        lstArea.SetEnable(false);

            txtContract_No.text ='';

    }
}

function makeAutoContractNo()
{
    if (idAuto.value =="Y")
    {
        var strContractNo =dtContract_Date.value;
        strContractNo = strContractNo.substr(0,4);
        strContractNo = strContractNo+'-'+ lstBiz.GetData()+'-'+lstArea.GetData()+'-9999';
        txtContract_No.text = strContractNo;
    }
    dtTr_Date.value = dtContract_Date.value;
}

function onChangePayamount()
{
    txtPAYTR_FAMT.text = txtPAY_FATM.text;
}
//---------------------------------------------------------------------------------------------
function onMapMaster()
{
    var aValue = new Array();
   	var fpath = System.RootURL + "/form/acnt/bf/wabf023000_req_mapping.asp";
   	aValue  = System.OpenModal(  fpath , 950 , 500 , 'resizable:yes;status:yes');	
   	if ((aValue != null) &&(aValue[0]!="0"))
   	{	
            txtSubcontract_Req_pk.text = aValue[0];
            txtRequestNo.text = aValue[1];
            if ((txtProject_Pk.text!="") &&(txtProject_Pk.text!=aValue[3]))
            {
                alert("Project Code is loaded from request!");
            }
            txtProject_Pk.text = aValue[3];
            txtProject_Code.text = aValue[4];
            txtProject_Name.text =aValue[5];
	}
}

</script>
<body>
 <gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtContract_Date"/>
                     <input bind="lstCompany"/>
                     <input bind="lstCurrency" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtExRate1"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!----------------------------------------------------------------------------------------> 
  <gw:data id="dat_gfqc00090_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="Control_Master" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36" function="acnt.sp_sel_gfqc00090_2" procedure="acnt.sp_upd_gfqc00090_1">
                <input>
                <inout  bind="txtPK" /> 
                <inout  bind="lstCompany" /> 
                <inout  bind="txtCust_Pk" /> 
                <inout  bind="txtProject_Pk" /> 
                <inout  bind="dtContract_Date" /> 
                
                <inout  bind="txtContract_No" /> 
                <inout  bind="dtFrom_Date" /> 
                <inout  bind="dtTo_Date" /> 
                <inout  bind="dtConfirm_Date" /> 
                <inout  bind="txtExRate" />
                
                <inout  bind="txtContract_BAmt" />
                <inout  bind="lstCurrency" />
                <inout  bind="txtAdjust_BAmt" />
                <inout  bind="txtFinal_BAmt" />
                <inout  bind="txtUser_Pk" /> 
                
                <inout  bind="txtExRate1" />
                <inout  bind="txtContract_Amt" /> 
                <inout  bind="txtAdjust_Amt" /> 
                <inout  bind="txtFinal_Amt" /> 
                <inout  bind="txtUnitPrice" /> 
                
                <inout  bind="txtWeightQty" />
                <inout  bind="lstUnit" />
                <inout  bind="idAuto" /> 
                <inout  bind="lstArea" /> 
                <inout  bind="lstBiz" />
                
                <inout  bind="txtADV_FAMT" />
                <inout  bind="txtPAY_FATM" /> 
                <inout  bind="txtPAYTR_FAMT" /> 
                <inout  bind="dtTr_Date" /> 
                <inout  bind="txtVAT" /> 
                
                <inout  bind="txtVAT_Adj" /> 
                <inout  bind="txtBVAT" /> 
                <inout  bind="txtVAT_BAdj" /> 
                <inout  bind="txtRemark" /> 
				<inout  bind="txtRemark2" /> 
				
                
				<inout  bind="txtSubcontract_Req_pk" />
				<inout  bind="txtRequestNo" /> 
				
				<inout  bind="txtCust_Code" /> 
                <inout  bind="txtCust_Name" /> 
                
                <inout  bind="txtProject_Code" /> 
                <inout  bind="txtProject_Name" /> 
                
             </input>
            </dso>
        </xml>
    </gw:data>
<!----------------------------------------------------------------------------------->	
  <gw:data id="dat_gfqc00090_1" onreceive="OnDataReceive(this)"> 
    <xml> 
          <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10" function="acnt.sp_sel_gfqc00090_1" procedure="acnt.sp_upd_gfqc00090_3"   > 
            <input bind="GridTerms">                    
                <input bind="txtPK" /> 
            </input> 
            <output bind="GridTerms" /> 
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------------->
 <gw:data id="dat_Detail" onreceive="OnDataReceive(this)"> 
    <xml> 
          <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10" function="acnt.sp_sel_gfqc00090_4" procedure="acnt.sp_upd_crsubcontract_dt"   > 
            <input bind="GridDetail">                    
                <input bind="txtPK" /> 
            </input> 
            <output bind="GridDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------------------------------->
<table width="100%"  border="0">
  <tr>
    <td><table width="100%"  border="1">
      <tr>
        <td><table width="100%"  border="0">
          <tr>
            <td width="10%"></td>
            <td width="13%"></td>
            <td width="12%"></td>
            <td width="15%"></td>
            <td width="10%"></td>
            <td width="13%"></td>
            <td width="11%"></td>
            <td width="16%"></td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold">Company&nbsp;&nbsp;</span></td>
            <td colspan="3">
				<gw:list id="lstCompany"  styles='width:100%'></gw:list >
			</td>
            <td align="right"><span style="font-weight: bold">Charger&nbsp;&nbsp;</span></td>
            <td><gw:textbox id="txtCharger" readonly='true' onchange="" styles="width:100%" /></td>
            <td colspan="2">
				<table width="100%" cellpadding="1" cellspacing="3">
				<tr>
					<td width="50%"></td>
					<td><gw:imgbtn id="ibtnSearch" 	img="search"  alt="Search" 	onclick="onSearchMaster()"/></td>
					<td><gw:imgbtn id="ibtnNew"    	img="new"     alt="New" 	onclick="OnNew(0)"/></td>
					<td><gw:imgbtn id="ibtnDelete" 	img="delete"  alt="Delete" 	onclick="OnDelete(0)"/></td>
					<td><gw:imgbtn id="ibtnSave"   	img="save"    alt="Save" 	onclick="onSaveMaster()"/></td>
					<td><gw:imgbtn id="ibtnMapping"   	img="test"    alt="Map from Request" 	onclick="onMapMaster()"/></td>
					<td><gw:imgBtn id="ibtnPrint" 	img="printer" alt="Print Subcontract Detail" 	onclick="OnPrint()" /></td>	
				</tr>
				</table>
			</td>
            
          </tr>
          <tr>
            <td align="right"><b>Auto No.</b></td>
            <td>
			    <gw:radio id="idAuto" value="Y" onchange="automode()"> 
										<span value="Y" ><b>Yes</b>&nbsp;&nbsp; </span>
										<span value="N" ><b>No</b>&nbsp;&nbsp; </span>
									</gw:radio >
			</td>
            <td align="right"><span style="font-weight: bold">Biz type&nbsp;&nbsp; </span></td>
            <td>
			    <gw:list id="lstBiz"  styles='width:100%;display:' onchange='makeAutoContractNo();'> 
					
				</gw:list >
			</td>
            <td align="right"><span style="font-weight: bold">Area&nbsp; </span></td>
            <td>
                <gw:list id="lstArea"  styles='width:100%;display:' onchange='makeAutoContractNo();'> 
					
				</gw:list >
            </td>
            <td align="right"><span style="font-weight: bold">Contract No&nbsp;&nbsp; </span></td>
            <td>
                <gw:textbox id="txtContract_No" onkeypress="UpperKey()" onchange="" csstype="mandatory"  styles="width:100%;" />
            </td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold"><a title="Click here to select Customer" onclick="OnPopUp(1)" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Customer&nbsp;&nbsp;</b></a></span></td>
			<td colspan="3">
            <table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="36%">
					<gw:textbox id="txtCust_Pk" styles="display:none" />
					<gw:textbox id="txtCust_Code" csstype="mandatory" readonly='true' onkeypress="UpperKey()"  styles="width:100%" />
				</td>
				<td width="60%"><gw:textbox id="txtCust_Name" csstype="mandatory" readonly='true' onkeypress="UpperKey()" styles="width:100%" /></td>
				<td width="2%"></td>
				<td width="2%"><gw:imgbtn id="ibtnReset_Cust" img="reset" alt="Reset" onclick="OnResetCust()" /></td>
			</tr>
			</table>
			</td>
            <td align="right"><span style="font-weight: bold">Contract Date&nbsp;&nbsp;</span></td>
            <td><gw:datebox id="dtContract_Date" lang="1" styles="width:100%" onchange="makeAutoContractNo();idData_dsql_sliprate.Call('SELECT');"></gw:datebox></td>
            <td align="right"><b>Request No &nbsp;&nbsp; </b></td>
            <td>
				<gw:textbox id="txtRequestNo"  styles="width:100%" />
			</td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold"><a title="Click here to select Project" onclick="OnPopUp(2)" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Project&nbsp;&nbsp;</b></a></span></td>
			<td colspan="3">
            <table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td width="36%">
					<gw:textbox id="txtProject_Pk" styles="display:none" />
					<gw:textbox id="txtProject_Code" csstype="mandatory" readonly='true' onkeypress="UpperKey()"  styles="width:100%" />
				</td>
				<td width="60%"><gw:textbox id="txtProject_Name" csstype="mandatory" readonly='true' onkeypress="UpperKey()"  styles="width:100%" /></td>
				<td width="2%"></td>
				<td width="2%"><gw:imgbtn id="ibtnReset_Project" img="reset" alt="Reset" onclick="OnResetProject()" /></td>
			</tr>
			</table>
			</td>
			<td align="right"><span style="font-weight: bold">From&nbsp;&nbsp;</span></td>
         	<td><gw:datebox id="dtFrom_Date" lang="1" styles="width:100%"></gw:datebox></td>
			<td align="center"><span style="font-weight: bold">to</span></td>
			<td><gw:datebox id="dtTo_Date" nullaccept lang="1" styles="width:100%"  ></gw:datebox></td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold">Ex. Rate&nbsp;&nbsp; </span></td>
            <td>
			<gw:textbox id="txtExRate" format="#,###,###,###,###,###,###.##R" type="number"  styles="width:100%" />
			
			</td>
            <td align="center"><span style="font-weight: bold">:&nbsp;&nbsp; </span></td>
            <td>
			<gw:textbox id="txtExRate1" format="#,###,###,###,###,###,###.##R" type="number"  styles="width:100%" />
			
			</td>
            <td align="right"><span style="font-weight: bold">Confirm Date&nbsp;&nbsp; </span></td>
            <td><gw:datebox id="dtConfirm_Date" lang="1" styles="width:100%"></gw:datebox></td>
            <td align="right"><span style="font-weight: bold">Contract Ccy.&nbsp;&nbsp; </span></td>
            <td>
				<gw:list id="lstCurrency" styles="width:100%" lang="1" onchange="OnChangeCurrent()">
					
				</gw:list>
			</td>
          </tr>
          <tr>
			<td align="right"><span style="font-weight: bold">Unit.&nbsp;&nbsp; </span></td>
			<td><gw:list id="lstUnit" styles="width:100%" value="TON" >
				
				</gw:list>
			
				</td>
				
			<td align="right"><span style="font-weight: bold">Weight Q.ty.&nbsp;&nbsp; </span></td>
			<td><gw:textbox id="txtWeightQty" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" /></td>
			<td align="right"><span style="font-weight: bold">Unit Price (Net)&nbsp;</span></td>
			<td><gw:textbox id="txtUnitPrice" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" /></td>
			<td align="right"><span style="font-weight: bold">VAT Amt.&nbsp;&nbsp; </span></td>
			<td>
			    <gw:textbox id="txtVAT" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" />
			    <gw:textbox id="txtBVAT" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%;display:none" />    
			</td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold">Contract Amt.&nbsp;&nbsp; </span></td>
            <td>
			<gw:textbox id="txtContract_Amt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" onlossfocus="OnChangeAmt()" onenterkey= "OnChangeAmt()" styles="width:100%" />
			<gw:textbox id="txtContract_BAmt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="" styles="width:100%;display:none" />
			</td>
            <td align="right"><span style="font-weight: bold">Adj. Amt.&nbsp;&nbsp; </span></td>
            <td>
			<gw:textbox id="txtAdjust_Amt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" />
			<gw:textbox id="txtAdjust_BAmt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="" styles="width:100%;display:none" />
			<td align="right"><span style="font-weight: bold">Adjust VAT.&nbsp;&nbsp; </span></td>
			<td>
			    <gw:textbox id="txtVAT_Adj" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" />
			    <gw:textbox id="txtVAT_BAdj" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%;display:none;" />
			</td>
			</td>
            <td align="right"><span style="font-weight: bold">Final Amt.&nbsp;&nbsp; </span></td>
            <td>
			<gw:textbox id="txtFinal_Amt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="OnChangeAmt()" styles="width:100%" />
			<gw:textbox id="txtFinal_BAmt" format="#,###,###,###,###,###,###.##R" type="number"  onkeypress="OnChangeAmt()" onchange="" styles="width:100%;display:none" />
			</td>
          </tr>
          <tr>
            <td align="right"><span style="font-weight: bold">In use date.&nbsp;&nbsp; </span></td>
            <td>
                <gw:datebox id="dtTr_Date" lang="1" styles="width:100%" ></gw:datebox></td>
            </td>
            <td align="right"><span style="font-weight: bold">Advance Amt.</span></td>
            <td>
			    <gw:textbox id="txtADV_FAMT" format="#,###,###,###,###,###,###.##R" type="number"  onchange="" styles="width:100%;" />
			</td>
			<td align="right"><span style="font-weight: bold">Payable Amt.</span></td>
            <td>
			    <gw:textbox id="txtPAY_FATM" format="#,###,###,###,###,###,###.##R" type="number"  onchange="onChangePayamount()" styles="width:100%;" />
			</td>
			<td align="right"><span style="font-weight: bold">Paid Amt.</span></td>
            <td>
			    <gw:textbox id="txtPAYTR_FAMT" format="#,###,###,###,###,###,###.##R" type="number"  onchange="" styles="width:100%;" />
			</td>
          </tr>
          <tr>
          <td align="right"><span style="font-weight: bold">Remark(Accounting Team)</span></td>
          <td colspan="3"><gw:textbox id="txtRemark" styles="width:100%;" /></td>
          <td align="right"><span style="font-weight: bold">Remark(Contract Team)</span></td>
          <td  colspan="3"><gw:textbox id="txtRemark2" styles="width:100%;" /></td>
          </tr>
        </table></td>
      </tr>
      
	  <tr>
	  	<td >
			
			<table name="Information" class="table"  width="100%" cellpadding="0" cellspacing="8">
			<tr height="0">
				<td width="40%"></td>
				<td width="60%"></td>
			</tr>
			<tr>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td width="70%" align="center"><span style="color: #6699FF; font-weight: bold">Terms Type Management </span></td>
						<td width="10%"><gw:imgbtn id="ibtnNewTerms" img="new" alt="New Terms" onclick="onClickNewTerms()" styles="display:none" /><gw:imgbtn id="ibtnDeleteTerms" img="delete" alt="Delete Terms" onclick="onClickDeleteTerms()"  styles="display:none"/></td>
						<td width="10%"><gw:imgbtn id="ibtUnDeleteTerms" img="udelete" alt="UnDelete Terms" onclick="onClickUndeleteTerms()" styles="display:none"/></td>
						<td width="10%" align="right"><gw:imgbtn id="ibtnResetDate" img="reset" alt="Reset Guarantee Date" onclick="onClickResetDate()" styles="display:none" /></td>
					</tr>
					</table>
				</td>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td width="88%" align="center"><span style="color: #FFCC99; font-weight: bold">Adjust Management</span></td>
						<td width="4%"><gw:imgbtn id="ibtnNewDetail" img="new" alt="New Detail" onclick="OnNew(1)"/></td>
						<td width="4%"><gw:imgbtn id="ibtnDeleteDetail" img="delete" alt="Delete Detail" onclick="OnDelete(1)" /></td>
						<td width="4%"><gw:imgbtn id="ibtUnDeleteDetail" img="udelete" alt="UnDelete Detail" onclick="onClickUndeleteDetail()" /></td>
					</tr>
					</table>
				</td>
				
			</tr>
			<tr>
				<td valign="top">
				    <gw:grid   
                                id="GridTerms"  
                                header="_PK|TAC_CRSUBCONTRACT_PK|Terms Type|Rate|Trans. Amt.|Books Amt.|CODE|Valid From|Valid To|Remark|Local Remark"   
                                format="0|0|0|0|0|0|0|4|4|0|0"  
                                aligns="0|0|0|3|3|3|0|0|0|0|0"
                                defaults="||||||||||"  
                                editcol="1|1|0|1|1|1|1|1|1|1|1"  
                                widths="0|0|0|0|0|0|0|0|0|0|0"  
                                styles="width:100%; height:150"   
                                sorting="T"   
                                onafteredit="OnEdit('term')"   
                                param="0,1,2,3,4,5,6,7,8,9,10" 
                                acceptNullDate="T" />              
				</td>
				    
				<td>
				<gw:grid   
    id="GridDetail"  
    header="No|_PK|TAC_CRSUBCONTRACT_PK|Installment Type|Contract Q.ty Adj|Contract Book Amount Adjust|Contract Amt Adj|VAT Amt|_VAT_BAMT|Remark|Local Remark"   
    format="0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|0|0|0|3|3|3|3|3|0|0"  
    defaults="||||||||||"  
    editcol="1|1|1|1|1|1|1|1|1|1|1"  
    widths="0|0|0|0|0|0|0|0|0|0|0"  
    styles="width:100%; height:150"   
    sorting="T"   
    onafteredit="OnEdit('detail')"  
    onkeypressedit ="OnKeyDetailPress()"
    param="0,1,2,3,4,5,6,7,8,9,10"  /> 
				</td>
			</tr>
			</table>
			
			
		</td>
	  </tr>
	  
	  
	  
	  
    </table>
    
    </td>
    
  </tr>
  
</table>

<gw:textbox id="txtPK" styles="display:none" />
<gw:textbox id="txtUser_Pk" styles="display:none" />
<gw:textbox id="txtCurrency" styles="display:none" />
<gw:textbox id="txtOldContractNo" styles="display:none" />
<gw:textbox id="txtSubcontract_Req_pk" styles="display:none" />
<gw:list id="lstBookCurrency" styles="width:100%;display:none"></gw:list>
<gw:textbox id="txt_row"        styles='display:none'/>


</body>

</html>