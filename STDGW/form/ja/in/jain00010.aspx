<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>M/R ENTRY</title>
</head>
<%  ESysLib.SetUser("PROD")%>

<script>
var user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

//-------------------
var G_PR_PK     = 0,
    G_PR_Date   = 1,
    G_PR_No     = 2,
    G_Ref_PO_No = 3;
    
var G1_1         = 0,
    G1_PR_D_PK   = 1,
    G1_PR_M_PK   = 2,    
    G1_Seq       = 3,
    G1_ITEM_PK   = 4,
    G1_Item_Code = 5,
    G1_Item_Name = 6,
    G1_ReqQty01  = 7,
    G1_UOM_01    = 8,         
    G1_PO_Qty    = 9,
    G1_3         = 10,
    G1_U_P       = 11,
    G1_Amount    = 12,
    G1_4         = 13,
    G1_5         = 14,
    G1_6         = 15,
    G1_7         = 16,
    G1_8         = 17,
    G1_Remark    = 18,
    G1_9         = 19; 

//======================================================================

function OnToggle(pos)
{
    switch (pos)
    {
        case '1':
            var left = document.all("left"); 
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
        break; 
    }    
}

//======================================================================

function BodyInit()
{
    //System.Translate(document);  // Translate to language session
    //---------------------------------- 

    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------------- 
        
    txtMRNo.SetEnable(false);
    txtRequesterID.SetEnable(false);
    txtRequesterName.SetEnable(false);
    txtPLCode.SetEnable(false);
    txtPLName.SetEnable(false);
    //-------------------------

    BindingDataList();    
    //---------------------------------- 
    OnAddNew('Master');               
}
//============================================================================== 

 function BindingDataList()
 {      
      
    var ctr = grdDetail.GetGridControl(); 
          
    ctr.ColFormat(G1_ReqQty01) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_PO_Qty)   = "#,###,###,###,###,###.##";
    
    ctr.ColFormat(G1_U_P)    = "#,###,###,###,###,###.##";    
    ctr.ColFormat(G1_Amount) = "#,###,###,###,###,###.##"; 
    
    ctr.FrozenCols = G1_ReqQty01 ;   
     
 }

 //===================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {                            
        case 'Requester':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtRequesterName.text = obj[2];
                txtRequesterID.text   = obj[1];
                txtRequesterPK.text   = obj[0];
            }
        break; 
        
        case 'PLCenter': // PL        
            fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[0]; 
                txtPLCode.text = oValue[1];
                txtPLName.text = oValue[2];
            }
        break;    
                                                                                             
    }	       
}

 //===================================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G1_UOM_01 || event_col == G1_UOM_02 )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
            break;             
      }         
}   
 
 //===================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':
            data_jain00010_1.StatusInsert();
            
            txtMRNo.text   = '***New M/R***';
            txtAmount.text = '';            
            //-------------------------------------------
            txtRequesterName.text = "<%=Session("USER_NAME")%>";
            txtRequesterID.text   = '' ;
            txtRequesterPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
        break;
        
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Seq, grdDetail.rows-1); 	
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PR_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Code, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Name, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM_01,    arrTemp[5]);//item_uom                            
                    }		            
             }        
        break;                  
    }
}  

 //===================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_jain00010.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_jain00010_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0 );
                    }
                    else
                    {
                        txtMasterPK.text = '';
                    }
                    
                    flag = 'view' ;
                    data_jain00010_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0 );
                }
                else
                {
                    txtMasterPK.text = '';
                }  
                              
                flag = 'view' ;
                data_jain00010_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_jain00010_2.Call("SELECT");
        break;
    
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_jain00010":
        break;
            
        case "data_jain00010_1": 
                   
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_PR_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_PR_M_PK, txtMasterPK.text);
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
        
        case "data_jain00010_2":

            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G1_Item_Code, grdDetail.rows - 1, G1_Item_Code, true);
                grdDetail.SetCellBold( 1, G1_ReqQty01,  grdDetail.rows - 1, G1_ReqQty01,  true);
                grdDetail.SetCellBold( 1, G1_U_P,       grdDetail.rows - 1, G1_U_P,       true);
                grdDetail.SetCellBold( 1, G1_Amount,    grdDetail.rows - 1, G1_Amount,    true);
                
            }  
        break;   
                   
        case "pro_jain00010":
            alert(txtReturnValue.text); 
            //-----------
            OnSearch('grdMaster');
        break; 
    }
}
//==============================================================================
 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if ( confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_jain00010_1.StatusDelete();
                data_jain00010_1.Call();
            }   
        break;

        case 'Detail':
            if ( grdDetail.GetGridData( grdDetail.row, G1_PR_D_PK ) == '' )
            {
                grdDetail.RemoveRow();
            }
            else
            {   
                grdDetail.DeleteRow();
            }              
        break; 
     
    }     
}
//==============================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//==============================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            flag='save';
            data_jain00010_1.Call();                
        break;
        
        case 'Detail':        
            data_jain00010_2.Call();
        break;
        
    }
}

//==============================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_ReqQty01 || col == G1_U_P || col == G1_Amount )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
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
        //------------------------
        if ( col == G1_ReqQty01 || col == G1_U_P )
        {
            var dAmount;
            
            dAmount = Number(grdDetail.GetGridData( row, G1_ReqQty01 )) * Number(grdDetail.GetGridData( row, G1_U_P )) ;
            
            grdDetail.SetGridText( row, G1_Amount, parseFloat(dAmount+"").toFixed(2) ) ;
        }
        //------------------------
        TotalAmount();
    }
}
    

//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G1_Amount));
    }

    txtAmount.text = sumAmount.toFixed(2)+"";
} 
//====================================================
 function OnReport()
 {
        if ( txtMasterPK.text != "" )
        { 
               var url =System.RootURL + '/reports/ja/in/rpt_jain00010_AMB.aspx?master_pk=' + txtMasterPK.text  ;
               System.OpenTargetPage(url);  
        }  
 }
 
//================================================================= 
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_jain00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_jain00010" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_jain00010" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="crm" function="crm.sp_sel_jain00010" >
                <input  bind="grdSearch">                    
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtSearchNo" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_jain00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="crm.sp_sel_jain00010_1" procedure="crm.sp_upd_jain00010_1">
                <input>                               
                    <inout bind="txtMasterPK" />
                    <inout bind="txtMRNo" />
                    <inout bind="dtReqDate" />
                    <inout bind="lbStatus" />                    
                    <inout bind="txtRequesterPK" />
                    <inout bind="txtRequesterID" />
                    <inout bind="txtRequesterName" />                  
                    <inout bind="txtAmount" />                                                      
                    <inout bind="txtPLPK" />
                    <inout bind="txtPLCode" />
                    <inout bind="txtPLName" />                                                                                                                                                                          
                    <inout bind="txtDescription" />                                                                                                                      
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_jain00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="crm.sp_sel_jain00010_2" procedure="crm.sp_upd_jain00010_2"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 20%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 20%" align="right">
                            Date</td>
                        <td align="left" style="white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%; white-space: nowrap" align="right">
                            M/R No
                        </td>
                        <td colspan="2">
                            <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|M/R Date|M/R No" format="0|4|0" aligns="1|1|0"
                                defaults="||" editcol="0|0|0" widths="0|1200|1200" styles="width:100%; height:100%"
                                sorting="T" oncellclick="OnSearch('grdMaster')" param="0,1,2" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 80%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 1%">
                            <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                onclick="OnToggle('1')" />
                        </td>
                        <td align="right" style="width: 9%; white-space: nowrap">
                            M/R No
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtMRNo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Req Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtReqDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td align="right" style="width: 25%">
                            <gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnReport" img="excel" alt="Print Request" onclick="OnReport()" />
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
                    <tr style="height: 1%">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF">
                                <tr style="height: 30%">
                                    <td align="right" style="width: 10%">
                                        <a title="Requester" onclick="OnPopUp('Requester')" style="color: #0000ff; cursor: hand">
                                            Requester</a>
                                    </td>
                                    <td align="right" style="width: 40%; white-space: nowrap">
                                        <gw:textbox id="txtRequesterPK" styles="display:none" />
                                        <gw:textbox id="txtRequesterID" styles="width:30%" />
                                        <gw:textbox id="txtRequesterName" styles="width:70%" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a title="PLCenter" onclick="OnPopUp('PLCenter')" style="color: #0000ff; cursor: hand">
                                            P/L</a>
                                    </td>
                                    <td style="width: 40%; white-space: nowrap">
                                        <gw:textbox id="txtPLPK" styles="display: none" />
                                        <gw:textbox id="txtPLCode" styles="width: 30%" />
                                        <gw:textbox id="txtPLName" styles="width: 70%" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%">
                                        Amount
                                    </td>
                                    <td>
                                        <gw:textbox id="txtAmount" styles="width: 100%;color:Red" type="number" format="###,###,###.###" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        Remark
                                    </td>
                                    <td style="white-space: nowrap; width: 40%">
                                        <gw:textbox id="txtDescription" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="12">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 97%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:100%' onclick="OnAddNew('FreeItem')" />
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
                    <tr style="height: 96%">
                        <td colspan="12">
                            <gw:grid id='grdDetail' header='_NULL|_PK|_PO_PR_M_PK|Seq|_TCO_ITEM_PK|Item Code|Item Name|Req Qty|UOM|P/O Qty|_NULL|U/P|Amount|_NULL|_NULL|_NULL|_NULL|_NULL|Remark|_NULL'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|1|0|0|0|3|1|3|1|3|3|0|0|0|0|0|0|0'
                                check='|||||||||||||||||||' editcol='0|0|0|1|0|0|0|1|0|1|0|1|1|0|0|0|0|1|1|0'
                                widths='800|0|0|800|0|1500|3000|1500|1000|1500|1000|1500|1500|0|1500|0|0|1000|1000|0'
                                styles='width:100%; height:100%' sorting='T' onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
