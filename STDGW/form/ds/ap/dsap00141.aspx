<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get From Payment Request</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var     G1_REQ_PK       = 0 ,
        G1_CHK          = 1 , 
        G1_REQ_DATE     = 2 ,
        G1_REF_NO       = 3 ,
        G1_REQ_AMT      = 4 , 
        G1_PAY_AMT      = 5 , 
		G1_BAL_AMT   	= 6 ,
        G1_SEL_AMT      = 7 , 
        G1_TR_CCY       = 8 ,
        G1_EX_RATE      = 9 ,  
        G1_REQ_EMP      = 10, 
        G1_PAYMENT_DESC = 11,
        G1_METHOD_ID    = 12,
        G1_METHOD_NAME 	= 13;
		
var callerWindowObj = dialogArguments;

var arr_FormatNumber = new Array();
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document); 
	txtSupplierNM.SetEnable(false);
	
	var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromDate.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromDate.value=ldate ;  
	//-------------------------
    txtSupplierPK.text = callerWindowObj.txtSupplierPK.text ;
    txtSupplierNM.text = callerWindowObj.txtSupplierName.text ;        
    
	OnFormatGrid();
	        
    OnSearch();	
	//---------------------------------------	
}

//=============================================================================================

function OnFormatGrid()
{
    var ctrl;
    
    ctrl = grdDetail.GetGridControl();	
    ctrl.ColFormat(G1_REQ_AMT) = "###,###,###,###,###.##"; 
    ctrl.ColFormat(G1_PAY_AMT) = "###,###,###,###,###.##";   
	ctrl.ColFormat(G1_BAL_AMT) = "###,###,###,###,###.##"; 
	ctrl.ColFormat(G1_SEL_AMT) = "###,###,###,###,###.##"; 
	ctrl.ColFormat(G1_EX_RATE) = "###,###,###,###,###.##"; 
	
    arr_FormatNumber[G1_SEL_AMT] = 2;       
}

//=============================================================================================

function OnSearch()
{ 	
    data_dsap00041.Call("SELECT"); 
}

//=============================================================================================

function OnSelect()
{
   	var arr_data = new Array();
      
   	for( var i=1; i<grdDetail.rows; i++ )
    {
        if ( grdDetail.GetGridData( i, G1_CHK) == -1)
        {
            var arrTemp=new Array();
             
            for(var j=0; j<grdDetail.cols; j++)
            {
               	arrTemp[arrTemp.length] = grdDetail.GetGridData(i,j);
            }
             
            arr_data[arr_data.length]= arrTemp;
        }
      	//------------------------------------------- 
	  	if ( arr_data !=null )
	  	{
			window.returnValue =  arr_data;
			window.close();
	  	}
	  	else
	  	{
	    	alert("You have not selected data yet.");
	 	}
	}	  	  
}

//=============================================================================================

function CheckInput()
{
    var col = event.col;
    var row = event.row;
	
    if ( col == G1_CHK )
    {
        if ( grdDetail.GetGridData( row, G1_CHK) == -1 )
        {
			grdDetail.SetGridText( row, G1_SEL_AMT, grdDetail.GetGridData( row, G1_BAL_AMT ));
		}
		else
		{
			grdDetail.SetGridText( row, G1_SEL_AMT, 0 );
		}
    }
	else if ( col == G1_SEL_AMT )
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
	}
	//-------------
	TotalAmount();	
}

//=============================================================================================

function TotalAmount()
{
	var req_amt = 0 ;
	var pay_amt = 0 ;
	var bal_amt = 0 ;
	
	for( i=1; i<grdDetail.rows; i++)
	{	
		if ( grdDetail.GetGridData( i, G1_CHK) == -1 )
		{ 
 			req_amt = Number(req_amt) + Number(grdDetail.GetGridData(i,G1_BAL_AMT)) + "";
			pay_amt = Number(pay_amt) + Number(grdDetail.GetGridData(i,G1_SEL_AMT)) + "";		 
		}	
	}
	
	bal_amt = Number(req_amt) - Number(pay_amt) + "";
	
	txtReqAmt.text = req_amt ;
	txtPayAmt.text = pay_amt ;
	txtBalAmt.text = bal_amt ;
}

//=============================================================================================

function OnReceiveData(obj)
{
 	switch(obj.id)
    {
    
        case 'data_dsap00041':
			if ( grdDetail.rows > 1 )
			{
            	grdDetail.SetCellBold( 1, G1_REF_NO,  grdDetail.rows - 1, G1_REF_NO,  true);
				grdDetail.SetCellBold( 1, G1_PAY_AMT, grdDetail.rows - 1, G1_PAY_AMT, true);
				grdDetail.SetCellBold( 1, G1_BAL_AMT, grdDetail.rows - 1, G1_BAL_AMT, true);
				
	        	grdDetail.SetCellFontColor( 1, G1_SEL_AMT, grdDetail.rows - 1, G1_SEL_AMT, 0x3300CC);
			}
			
			txtReqAmt.text = 0;
    		txtPayAmt.text = 0;
    		txtBalAmt.text = 0;
        break; 
	}	  
}
//================================================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_dsap00041" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_dsap00141" > 
                  <input bind="grdDetail" >
				  	<input bind="txtSupplierPK" /> 
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
					<input bind="txtSlipNo" />
                  </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Supplier
            </td>
            <td colspan="4">
                <gw:textbox id="txtSupplierPK" styles="display: none" />
                <gw:textbox id="txtSupplierNM" styles="width:100%" csstype="mandatory" />
            </td>			 
            <td style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="ibtnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="select" alt="Select" id="ibtnSelect" onclick="OnSelect()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="cancel" alt="Cancel" id="ibtnCancel" onclick="OnCancel" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Req Date
            </td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFromDate" lang="1" />
                ~
                <gw:datebox id="dtToDate" lang="1" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Search No
            </td>
            <td style="width: 30%; white-space: nowrap">
                <gw:textbox id="txtSlipNo" styles="width:100%" />
            </td>
            <td style="width: 37%">
            </td>
			<td style="width: 1%">                
            </td>
            <td style="width: 1%">               
            </td>
            <td style="width: 1%">               
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='_PK|Chk|Req Date|No|Req Amt|Pay Amt|Bal Amt|Sel Amt|Tr CCY|Ex Rate|Req Emp|Collect Desc|_InType_CD|In Type'
                    format='0|3|4|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|1|0|3|3|3|3|1|3|0|0|0|0' check='||||||||||||'
                    editcol='0|1|0|0|0|0|0|1|0|0|0|0|0|0' widths='0|800|1200|1500|1200|1200|1200|1200|1000|1200|1500|1500|0|1000'
                    sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()"/>
                />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="8">
                <table style="width: 100%; height: 100%; background-color: #CCFFFF">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Req Amount
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtReqAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" readonly="true"/>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Pay Amount
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPayAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" onenterkey="Calculator()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Bal Amount
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtBalAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R" readonly="true"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
