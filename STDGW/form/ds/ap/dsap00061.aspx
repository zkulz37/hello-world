<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Collection Balance Closing</title>
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
    G1_MASTER_PK        = 1,
    G1_SUPPLIER_PK      = 2,
    G1_SUPPLIER_ID      = 3,
    G1_SUPPLIER         = 4,
    G1_BEGIN_AMT        = 5,
    G1_INC_AMT          = 6,
    G1_DEC_AMT          = 7,
    G1_END_AMT          = 8,
    G1_CCY              = 9,
    G1_DESCRIPTION      = 10;    
    
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
//====================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session     
    OnAddNew('Master');
    BindingData();
    SetGridFormat();
 }
 //==================================================================================
 function BindingData()
 {
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  code, code code_nm  FROM sale.lg_code a, sale.lg_code_group b WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGCM0100'  AND a.use_if = 'Y' AND a.del_if = 0  AND b.del_if = 0 ORDER BY a.def_yn DESC  " ) %> ";       
    grdPay.SetComboFormat(G1_CCY,data);
  
 }
 //==================================================================================
 function SetGridFormat()
 {
    var ctr = grdPay.GetGridControl(); 
    
    ctr.ColFormat(G1_BEGIN_AMT) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_INC_AMT) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_DEC_AMT) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_END_AMT) = "#,###,###,###,###,###.###";   
 }
 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_dsap00060_1.StatusInsert();;
            //-------------------------------------------
            txtCharger.text = "<%=Session("USER_NAME")%>";
            txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            lblStatus.text='Status';
            //------------------------------------------- 
            grdPay.ClearData();
            flag = "view";        
        break;     
        case'Detail':
        if(txtMasterPK.text != "")
        {
            var data ;
            var path = System.RootURL + '/form/fp/ab/fpab00480.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if ( obj != null )
            {
                for (var i = 0 ; i< obj.length; i++)
                {
                    grdPay.AddRow();
                    data = obj[i];            
                    grdPay.SetGridText(grdPay.rows-1,G1_SUPPLIER_PK,data[0]);
                    grdPay.SetGridText(grdPay.rows-1,G1_SUPPLIER_ID,data[1]);
                    grdPay.SetGridText(grdPay.rows-1,G1_SUPPLIER,data[2]);
                 }
            }
        }
        else
        {
            alert("Please, select closing master first!")
        }
        break;                           
    }
}  

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdReq':
            data_dsap00060.Call("SELECT");
        break;
        case 'Master':
            if ( data_dsap00060_1.GetStatus() == 20 && grdPay.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdReq.row > 0 )
                    {
                        txtMasterPK.text = grdReq.GetGridData( grdReq.row, G1_DETAIL_PK);
                    }
                    flag = 'view' ;
                    data_dsap00060_1.Call("SELECT");
                }                
            }
            else
            {
                if ( grdReq.row > 0 )
                {
                    txtMasterPK.text = grdReq.GetGridData( grdReq.row, G1_DETAIL_PK );
                }
                
                flag = 'view' ;
                data_dsap00060_1.Call("SELECT");
            }      
        break;
        case'Detail':
            data_dsap00060_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'data_dsap00060_1':
            if ( flag == 'save')
            {
                for(var i=1; i < grdPay.rows;i++)
                {
                    if ( grdPay.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdPay.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    } 
                }
                //----------------------------
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('Detail');   
            }
        break;
        case'data_dsap00060_2':
            if(flag=='process')
            {
                data_dsap00060.Call("SELECT");
                flag="";
            }
            else
            {
                if(grdPay.rows>1)
                {
                   grdPay.SetCellBold( 1, G1_BEGIN_AMT, grdPay.rows - 1, G1_END_AMT, true);
                   grdPay.SetCellBgColor( 1, G1_SUPPLIER_ID , grdPay.rows - 1, G1_SUPPLIER , 0xCCFFFF ); 
                }
            }
        break;
        case'pro_dsap00060':
            flag='process';
            data_dsap00060_1.Call("SELECT");
        break;
        case'pro_dsap00060_1':
            alert(txtReturnValue.text);
            flag='process';
            data_dsap00060_1.Call("SELECT");
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
        
        case 'Method' :
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
             if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0110';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstColMedName.value = object[1];      
	            }    	                
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
                    lstColTypeName.value = object[1];      
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
            if( Validate())
            {
                data_dsap00060_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_dsap00060_2.Call();
        break;
    }
}
//=================================================================================
function Validate()
{   
    //---------------
    for( var i = 1; i < grdPay.rows; i++)
    {
        //---------------
        if (grdPay.GetGridData( i, 2) =='')
        {
            alert("Input Supplier at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}
//================================================================================= 
//=================================================================================

function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this slip?'))
            {
                flag='delete';
                data_dsap00060_1.StatusDelete();
                data_dsap00060_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdPay.GetGridData( grdPay.row, G1_DETAIL_PK ) == '' )
                {
                    grdPay.RemoveRow();
                }
                else
                {   
                    grdPay.DeleteRow();
                }    
            }            
        break;            

    }     
}
//=================================================================================
 
function OnUnDelete()
{              
     grdPay.UnDeleteRow();
}

//=================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case'Load':
            pro_dsap00060.Call();
        break;
        case'Release':
            pro_dsap00060_1.Call();
        break;
    }
}
//=================================================================================
function OnCellDoubleClick()
{
    var col = event.col;
    var row = event.row;
    if(col==G1_SUPPLIER)
    {
        var path = System.RootURL + '/form/ds/ap/dsap00061.aspx';
        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

    }
}
//=================================================================================
function OnCalBalance()
{
    var col = event.col;
    var row = event.row;
    if(col == G1_BEGIN_AMT || col == G1_INC_AMT || col == G1_DEC_AMT )
    {
        if(isNaN(grdPay.GetGridData(row,G1_BEGIN_AMT))== false )
        {
            iBegin = Number(grdPay.GetGridData(row,G1_BEGIN_AMT))
        }
        else
        {
            iBegin = 0;
            grdPay.SetGridText(row,G1_BEGIN_AMT,0);
        }
        
        if(isNaN(grdPay.GetGridData(row,G1_INC_AMT))== false)
        {
            iIncrease = Number(grdPay.GetGridData(row,G1_INC_AMT))
        }else
        {
            iIncrease = 0;
            grdPay.SetGridText(row,G1_INC_AMT,0);
        }
        
        if(isNaN(grdPay.GetGridData(row,G1_DEC_AMT))== false)
        {
            iDecrease = Number(grdPay.GetGridData(row,G1_DEC_AMT))
        }else
        {
            iDecrease = 0;
            grdPay.SetGridText(row,G1_DEC_AMT,0);
        }
        
        iEnd = iBegin+ iIncrease - iDecrease;        
        grdPay.SetGridText(row,G1_END_AMT,iEnd);
        
    }else
    {
        if(col == G1_END_AMT)
        {
            if(isNaN(grdPay.GetGridData(row,G1_END_AMT))== true)       
            {
                grdPay.SetGridText(row,G1_END_AMT,0);
            }
        }
    }
}
//=================================================================================
</script>

<body>
    <!-----------------------grdReq---------------------------------------->
    <gw:data id="data_dsap00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00060" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
			    </input> 
                <output bind="grdReq" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_SEL_dsap00060_2" procedure="<%=l_user%>lg_upd_dsap00060_2"> 
                <input bind="grdPay">                      
                    <input bind="txtMasterPK" /> 
			    </input> 
                <output bind="grdPay" /> 
            </dso> 
        </xml> 
    </gw:data>

    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 50%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 10%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdReq')" />
                        </td>
                    </tr>
                    <tr style="height: 80%">
                        <td colspan="3">
                        <gw:grid id='grdReq'
                            header='_PK|Slip No|Slip Date|Total Amount|Chk'
                            format='0|0|4|1|3'
                            aligns='0|0|0|0|0'
                            check='||||'
                            editcol='0|0|0|0|0'
                            widths='0|1500|1200|1500|1000'
                            sorting='T'                            
                            styles='width:100%; height:100%'
                            />
                        </td>
                    </tr>
                     <tr style="height: 10%">
                       
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 50%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 10%">
                       
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                                                        
                    <tr style="height: 80%">
                        <td colspan="11">
                            <gw:grid id='grdPay'
                                header='_PK|Slip No|Slip Date|Total Amount|Chk'
                                format='0|0|4|1|3'
                                aligns='0|0|0|0|0'
                                check='||||'
                                editcol='0|0|0|0|0'
                                widths='0|1500|1200|1500|1000'
                                sorting='T'                            
                                styles='width:100%; height:100%'
                                />
                        </td>
                    </tr>
                    
                     <tr style="height: 10%">
                       
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
</html>
