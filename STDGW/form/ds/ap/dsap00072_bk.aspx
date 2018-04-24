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
   var G2_pk        =0,
   G2_req_m_pk      =1,
   G2_table_pk      =2,
   G2_order         =3,
   G2_item_name     =4,
   G2_unit_price    =5,
   G2_item_amt      =6,
   G2_vat_rate      =7,
   G2_vat_amt       =8,
   G2_total_amt     =9;  
//======================================================================    
var callerWindowObj = dialogArguments;

var arr_FormatNumber = new Array();	
var str_payno =""
function BodyInit()
{
    System.Translate(document); 
     txtPayReqPK.text = "<%=Request.querystring("payreq_pk")%>" ;             
     
    //--------------
    txtPayNo.SetEnable(false);
    
    txtCustID.SetEnable(false);
     
    txtChargerID.SetEnable(false);
    txtChargerName.SetEnable(false);
    
    txtReqEmpID.SetEnable(false);
    txtReqEmpName.SetEnable(false);
    OnBindingData();    
    
    OnSearch('Master');
}
//======================================================================    
function OnSearch(pos)
{
    switch(pos)
    {
        case 'Master':  
            data_dsap00072.Call("SELECT");    
        break;
        
        case 'grdDetail':
            data_dsap00071_1.Call("SELECT");
        break;     
    }
}
//======================================================================    
function OnBindingData()
{   var data =""
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL" )%>"; 
    lstCurr.SetDataText(data)
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0110') FROM DUAL")%>||";  //payment form
    lstPayMethod.SetDataText(data);    
    
}
//======================================================================
function OnFormat()
{
   
    var ctrl = grdDetail.GetGridControl();

    ctrl.ColFormat(G2_vat_amt) = "###,###,###,###.##";
    ctrl.ColFormat(G2_total_amt)= "###,###,###,###.##";	
    ctrl.ColFormat(G2_item_amt)= "###,###,###,###.##";
}

//====================================================================== 

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsap00072':
            if(flag!='delete')
            {
                if(flag=='save')
                {
                    flag="";
                    data_dsap00072_1.Call();
                }
                else
                {
                    data_dsap00072_1.Call("SELECT");
                }
            }
            else
            {
                window.returnValue = 1;
                this.close();
            }
        break;
        
        case 'data_dsap00071_1':
            
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBold( 1, G2_item_amt,  grdDetail.rows - 1, G2_item_amt,  true);                  
                    grdDetail.SetCellBold( 1, G2_vat_amt,  grdDetail.rows - 1, G2_vat_amt,  true);
                    grdDetail.SetCellBold( 1, G2_total_amt, grdDetail.rows - 1, G2_total_amt, true);
                    grdDetail.SetCellBgColor( 1, G2_total_amt, grdDetail.rows - 1, G2_total_amt, 0xCCFFFF );
                }
            //---------------------------------------------          
               SumTotalReq()
        break;        
    }
} 
//====================================================================== 
function SumTotalReq()
{
    var v_total =0
    for(var i =1 ; i< grdDetail.rows ; i++)
    {
        if(grdDetail.GetRowStatus(i) != '64' )
        {
            v_total =  v_total + Number(grdDetail.GetGridData(i,G2_total_amt));            
        }
    }                    
    txtTotalAmt.text = v_total;
}
//====================================================================== 
var returnvalue = null;
var flag ="";
function OnSave(obj)
{
    switch(obj)
    {
        case'Master':
            returnvalue = 1;
            flag = 'save';
            data_dsap00072.StatusUpdate();
            data_dsap00072.Call();
        break;
    }  
}
//====================================================================== 
function OnDelete()
{
    if(txtPayReqPK.text !="")
    {
        if ( confirm("Do you want to delete payment request for " + txtPayNo.text + " ? ") )
        {     
            flag="delete";
            data_dsap00072.StatusDelete();
            data_dsap00072.Call();
        }
   }    
}
//====================================================================== 
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
    
    if ( col == G2_item_amt|| col == G2_vat_amt || col == G2_total_amt )
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
        if(col == G2_item_amt|| col == G2_vat_amt )
        {
            grdDetail.SetGridText(row,G2_total_amt,Number(grdDetail.GetGridData(row,G2_item_amt))+Number(grdDetail.GetGridData(row,G2_vat_amt)));
        }
        
        var dItemAmt,dVatAmt,dTotalAmt;
        var vItemAmt = 0,vVatAmt = 0,vTotalAmt = 0;
        for (var i = 1; i<grdDetail.rows  ; i++)
        {
             dItemAmt =  grdDetail.GetGridData(i,G2_item_amt)
             dVatAmt =  grdDetail.GetGridData(i,G2_vat_amt)
             dTotalAmt =  grdDetail.GetGridData(i,G2_total_amt)
             
             if (Number(dItemAmt))
                {   
                    if (dItemAmt >0)
                    {
                        vItemAmt = vItemAmt + Number(dItemAmt)
                    }                   
                }
             if (Number(dVatAmt))
                {   
                    if (dVatAmt >0)
                    {
                        vVatAmt = vVatAmt + Number(dVatAmt)
                    }
                }
             if (Number(dTotalAmt))
                {   
                    if (dTotalAmt >0)
                    {
                        vTotalAmt = vTotalAmt + Number(dTotalAmt)
                    }
                }
        }       
        txtItemAmt.text = dItemAmt;
        txtVatAmt.text = vVatAmt;
        txtTotalAmt.text = vTotalAmt;
        //---------------------------------------------
        //grdDetail.Subtotal( 0, 2, -1, '5!7!8','###,###,###');
    } 

 }
 //=======================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerID.text = obj[1];
                txtChargerPK.text   = obj[0];
            }
        break;   
        case 'ReqEmp':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtReqEmpName.text = obj[2];
                txtReqEmpID.text = obj[1];
                txtReqEmpPK.text   = obj[0];
            }
        break;            
    }
} 
 //=======================================================================
function OnCancel()
{
    window.returnValue = returnvalue ; 
    this.close();   
}
 //=======================================================================
 
function OnDeleteDetail()
{
    if ( confirm("Do you want to delete this row ") )
    {           
        grdDetail.DeleteRow();
    }    
}
//=======================================================================
 
function OnUnDelDetail()
{
    if ( confirm("Do you want to Undelete this row ") )
    {          
        grdDetail.UnDeleteRow();
    }    
}
//=======================================================================
 
function OnAddNewDetail()
{
      grdDetail.AddRow();
}
 //------------------------------------------------------------------

  
</script>

<body>
     
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00072" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="<%=l_user%>lg_sel_dsap00072" procedure="<%=l_user%>_upd_dsap00071"> 
                <inout>
                    <inout bind="txtPayReqPK" />
                    <inout bind="txtPayNo" />  
                    <inout bind="dtReqDT" />
                    <inout bind="txtCustPK" />
                    <inout bind="txtCustID" />
                    <inout bind="txtCustName" />
                    <inout bind="txtPONo" />                                        
                    <inout bind="lstPayMethod" />  
                    <inout bind="lstCurr" />          
                    <inout bind="txtExRate" />  
                                       
                    <inout bind="txtChargerPK" /> 
                    <inout bind="txtChargerID" /> 
                    <inout bind="txtChargerName" /> 
                    <inout bind="txtReqEmpPK" /> 
                    <inout bind="txtReqEmpID" /> 
                    <inout bind="txtReqEmpName" />                     
                    <inout bind="txtArrayPOPK" />                                        
                    <inout bind="txtDescription" />
                    <inout bind="txtItemAmt" />                                        
                    <inout bind="txtVatAmt" /> 
                    
                    <inout bind="txtTotalAmt" />  
                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00072_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_SEL_dsap00072_1" procedure="<%=l_user%>lg_upd_dsap00072_1" >
                <input bind="grdDetail" >			      
			        <input bind="txtPayReqPK" />
			    </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
          <tr  style="height: 5%">
                <td colspan=8>
                <table style="width: 100%; height: 100%">
                        <tr>
                   <td style="width: 70%; white-space: nowrap">                            
                    </td>                       
                    <td style="width: 7%">
                    </td>                
                    <td style="width: 1%">
                        <gw:imgbtn id="btnSave" img="save" text="Save" onclick="OnSave('Master')" />
                    </td>
                    <td style="width: 1%">
                     <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete()" />
                   </td>
                    <td style="width: 1%">
                        <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" />
                    </td>
                   </tr>
                 </table>
                 </td>
            </tr>
        <tr style="height: 5%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Req No</td>
            <td style="width: 20%">
                <gw:textbox id="txtPayNo" maxlen="100" styles='width:100%' />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Request DT</td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtReqDT" lang="<%=Application("Lang")%>" mode="01" />                
            </td>
           <td style="width: 5%; white-space: nowrap" align="right">
               Partner </td>
            <td style="width: 45%; white-space: nowrap" align="right" colspan=4>
                <gw:textbox id="txtCustPK" styles="display:none" />
                <gw:textbox id="txtCustID" styles="width:30%" csstype="mandatory" />
                <gw:textbox id="txtCustName" styles="width:70%" csstype="mandatory" />
            </td>
        </tr>
        <tr style="height: 5%">  
            <td style="width: 5%; white-space: nowrap" align="right">
                P/O No</td>
            <td style="width: 20%">
                <gw:textbox id="txtPONo" maxlen="100" styles='width:100%' />
            </td>         
            <td style="width: 5%; white-space: nowrap" align="right">
               Payment Method  </td>
            <td style="width: 20%">
                 <gw:list id="lstPayMethod" styles='width:100%'  />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                Currency
            </td>
            <td style="width: 20%">
               <gw:list id="lstCurr" styles='width:100%'  />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                Ex Rate</td>
            <td style="width: 20%" >
                <gw:textbox id="txtExRate" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>            
        </tr>
          <tr style="height: 5%"> 
              <td style="width: 5%; white-space: nowrap" align="right">
                Total Amount</td>
            <td style="width: 20%" >
                <gw:textbox id="txtTotalAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>          
            <td style="width: 5%; white-space: nowrap" align="right">
               <a title="Supplier" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                                                        Charger</a> </td>
            <td style="width: 20%">
                <gw:textbox id="txtChargerPK" styles='width:100%; display:none' />
                <gw:textbox id="txtChargerID"    styles='width:30%' />
                <gw:textbox id="txtChargerName" maxlen="100" styles='width:70%' />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                <a title="Supplier" onclick="OnPopUp('ReqEmp')" href="#tips" style="color: #0000ff">
                                                        Requester</a>
            </td>
            <td style="width: 45%;white-space:nowrap" colspan='4'>
                <gw:textbox id="txtReqEmpPK" styles='width:100%; display:none' />
                <gw:textbox id="txtReqEmpID"  styles='width:30%' />
                <gw:textbox id="txtReqEmpName" maxlen="100" styles='width:70%' />
            </td>
                        
        </tr>
        <tr style="height:5%">
            <td style="width: 5%; white-space: nowrap; display:none" align="right">
                Item Amount</td>
            <td style="width: 20%; display:none" >
                <gw:textbox id="txtItemAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>    
            <td style="width: 5%; white-space: nowrap; display:none" align="right">
                Vat Amount</td>
            <td style="width: 20%; display:none" >
                <gw:textbox id="txtVatAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>                   
              <td style="width: 5%; white-space: nowrap" align="right">
                Description</td>
            <td style="width: 45%" colspan=7>
                <gw:textbox id="txtDescription" maxlen="100" styles='width:100%' />
            </td>   
        </tr>
        <tr style="height: 5%">
            <td colspan="8">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 70%; white-space: nowrap">                            
                        </td>                       
                        <td style="width: 7%">
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNewDetail()" />
                        </td>
                        
                        <td style="width: 2%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDeleteDetail()" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" onclick="OnUnDelDetail()" />
                        </td>                        
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 75%">
            <td colspan="8">
                    <gw:grid id='grdDetail'
                    header='_REQ_D_PK|_REQ_M_PK|_OUTGO_M_PK|Order|Item Description|_U/P|_Amount|_Vat Rate|_Vat Amt|Total Amt|Remark'
                    format='0|0|0|0|0|-2|-2|-2|-2|-2|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0'
                    check='||||||||||'
                    editcol='0|0|0|0|0|1|1|1|1|1|1'
                    widths='0|0|0|800|1500|1500|1500|1500|1500|1500|1500'
                    sorting='T'
                    styles='width:100%; height:100%' onafteredit="CheckInput()" 
                    />            
             </td>
        </tr>
    </table>
    <!--------------------------------------------------------------->
    <gw:textbox id="txtPayReqPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtArrayPOPK" maxlen="100" styles='width:100%;display:none' />
    
</body>
</html>
