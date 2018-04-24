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
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  code, code code_nm  FROM tlg_lg_code a, tlg_lg_code_group b WHERE a.tlg_lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGCM0100'  AND a.use_if = 'Y' AND a.del_if = 0  AND b.del_if = 0 ORDER BY a.def_yn DESC  " ) %> ";       
    grdDetail.SetComboFormat(G1_CCY,data);
  
 }
 //==================================================================================
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
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
            grdDetail.ClearData();
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
                    grdDetail.AddRow();
                    data = obj[i];            
                    grdDetail.SetGridText(grdDetail.rows-1,G1_SUPPLIER_PK,data[0]);
                    grdDetail.SetGridText(grdDetail.rows-1,G1_SUPPLIER_ID,data[1]);
                    grdDetail.SetGridText(grdDetail.rows-1,G1_SUPPLIER,data[2]);
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
        case 'grdSearch':
            data_dsap00060.Call("SELECT");
        break;
        case 'Master':
            if ( data_dsap00060_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G1_DETAIL_PK);
                    }
                    flag = 'view' ;
                    data_dsap00060_1.Call("SELECT");
                }                
            }
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G1_DETAIL_PK );
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
                if(grdDetail.rows>1)
                {
                   grdDetail.SetCellBold( 1, G1_BEGIN_AMT, grdDetail.rows - 1, G1_END_AMT, true);
                   grdDetail.SetCellBgColor( 1, G1_SUPPLIER_ID , grdDetail.rows - 1, G1_SUPPLIER , 0xCCFFFF ); 
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
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if (grdDetail.GetGridData( i, 2) =='')
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
    if(col==G1_SUPPLIER || col==G1_SUPPLIER_ID )
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
        if(isNaN(grdDetail.GetGridData(row,G1_BEGIN_AMT))== false )
        {
            iBegin = Number(grdDetail.GetGridData(row,G1_BEGIN_AMT))
        }
        else
        {
            iBegin = 0;
            grdDetail.SetGridText(row,G1_BEGIN_AMT,0);
        }
        
        if(isNaN(grdDetail.GetGridData(row,G1_INC_AMT))== false)
        {
            iIncrease = Number(grdDetail.GetGridData(row,G1_INC_AMT))
        }else
        {
            iIncrease = 0;
            grdDetail.SetGridText(row,G1_INC_AMT,0);
        }
        
        if(isNaN(grdDetail.GetGridData(row,G1_DEC_AMT))== false)
        {
            iDecrease = Number(grdDetail.GetGridData(row,G1_DEC_AMT))
        }else
        {
            iDecrease = 0;
            grdDetail.SetGridText(row,G1_DEC_AMT,0);
        }
        
        iEnd = iBegin+ iIncrease - iDecrease;        
        grdDetail.SetGridText(row,G1_END_AMT,iEnd);
        
    }else
    {
        if(col == G1_END_AMT)
        {
            if(isNaN(grdDetail.GetGridData(row,G1_END_AMT))== true)       
            {
                grdDetail.SetGridText(row,G1_END_AMT,0);
            }
        }
    }
}
//=================================================================================
</script>

<body>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dsap00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid"  function="<%=l_user%>lg_SEL_dsap00060" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
			    </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_dsap00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_SEL_dsap00060_1"  procedure="<%=l_user%>lg_upd_dsap00060_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />  
                     <inout  bind="dtCloseDate" /> 
                     <inout  bind="txtChargerPK" /> 
                     <inout  bind="txtCharger" /> 
                     <inout  bind="lblStatus" />
                     <inout  bind="txtRemark" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_SEL_dsap00060_2" procedure="<%=l_user%>lg_upd_dsap00060_2"> 
                <input bind="grdDetail">                      
                    <input bind="txtMasterPK" /> 
			    </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00060" > 
                <input>
                    <input bind="dtCloseDate" /> 
                    <input bind="txtChargerPK" /> 
                </input> 
                <output>
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00060_1" > 
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
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Close DT|Status|Crt by' format='0|4|0|0' aligns='0|0|0|0'
                                check='|||' editcol='0|0|0|0' widths='1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Close Date
                        </td>
                        <td style="white-space: nowrap">
                            <gw:datebox id="dtCloseDate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a title="Customer" onclick="OnPopUp('Type')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td style="white-space: nowrap; width: 40%">
                            <gw:textbox id="txtCharger" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                        <td align="center" style="white-space: nowrap; width: 20%">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td style="width: 1%" align="right">
                            
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="New" id="btnSearch1" onclick="OnSearch('Master')" />
                        </td>
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
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Remark
                        </td>
                        <td style="white-space: nowrap" colspan="4">
                            <gw:textbox id="txtRemark" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="11">
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
                                        <gw:icon id="btnload" img="2" text="Load Data" onclick="OnProcess('Load')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="btnrelease" img="2" text="Release" onclick="OnProcess('Release')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="idBtnPO2" img="new" alt="New" text="New" styles='width:100%' onclick="OnAddNew('Detail')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_DETAIL_PK|_MASTER_PK|_SUPPLIER_PK|Partner ID|Partner Name|Begin Amt|Inc Amt|Dec Amt|End Amt|CCY|Description'
                                format='0|0|0|0|0|1|1|1|1|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0' check='||||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' oncelldblclick="OnCellDoubleClick()"
                                onafteredit="OnCalBalance()" />
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
