<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Im - Declaration Approve</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";


var G_PK                =0,
    G_TCO_COMPANY_PK    =1,
    G_DECL_DATE         =2,
    G_DECL_NO           =3;

var G1_DETAIL_PK    =0,
    G1_MASTER_PK    =1,
    G1_ITEM_PK      =2,
    G1_ITEM_CODE    =3,
    G1_ITEM_NAME    =4,
    G1_QTY          =5,
    G1_UOM          =6,
    G1_PRICE        =7,
    G1_AMOUNT       =8;
    
//==================================================================
         
function BodyInit()
{          
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom1.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom1.value=ldate ;
    OnBindingList();
    //-----------------
    FormatGrid();
    //------------------------------------
    //OnSearch('grdConfirm');    
}
//==================================================================
function OnBindingList()
{
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT pk , partner_name FROM TCO_company  WHERE del_if=0" ) %> ";       
    grdDecl.SetComboFormat(G_TCO_COMPANY_PK,data);  
}
//==================================================================  
function FormatGrid()
{
    var ctrl = grdItem.GetGridControl();   
     
    ctrl.ColFormat(G1_QTY)    = "###,###,###.##R" ;
    ctrl.ColFormat(G1_PRICE)   = "###,###,###.##R" ;
    ctrl.ColFormat(G1_AMOUNT) = "###,###,###.##R" ;
    
    
}

//==================================================================
function OnSearch()
{
    data_epim00090.Call("SELECT");
}
//===================================================================
function OnSearchDetail()
{
    if(grdDecl.row>0)
    {
        txtMasterPK.text = grdDecl.GetGridData(grdDecl.row,G_PK)
        data_epim00090_1.Call("SELECT");
    }
}

//==================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
         case 'item':
            if(grdItem.row>0)
            {
                var col = event.col;
                var row = event.row;
                if(col==G1_ITEM_NAME||col==G1_ITEM_CODE)
                {
                    var path = System.RootURL + '/form/ep/im/epim00091.aspx';
                    var object = System.OpenModal( path, 600, 500, 'resizable:yes;status:yes', this); 
                    if(object != null)
                    {
                        grdItem.SetGridText(row,G1_ITEM_PK,object[0])
                        grdItem.SetGridText(row,G1_ITEM_CODE,object[1])
                        grdItem.SetGridText(row,G1_ITEM_NAME,object[2])
                        grdItem.SetGridText(row,G1_UOM,object[3])
                    }
                }
            }                   
         break ;
         
                           
     }       
}
//=================================================================
function OnCheckInput()
{
    var col = event.col;
    var row = event.row;
    if(col == G1_QTY)
    {
        var dQuantiy, dAmount;
        
        dQuantiy =  grdItem.GetGridData(row,col) ;
        if(Number(dQuantiy))
        {
            if (Number(dQuantiy) >0)
            {   
                grdItem.SetGridText( row, col, System.Round(grdItem.GetGridData(row, col),2)); 
            }
            else
            {
                grdItem.SetGridText( row, col, "");
            } 
        }
        else
        {
            grdItem.SetGridText( row, col, "");
        }
        var a = Number(grdItem.GetGridData(row,G1_QTY))* Number(grdItem.GetGridData(row,G1_PRICE));
        grdItem.SetGridText(row,G1_AMOUNT,a);
        
    }
    if(col == G1_PRICE)
    {
        var dQuantiy, dAmount;
        
        dQuantiy =  grdItem.GetGridData(row,col) ;
        if(Number(dQuantiy))
        {   
            if (Number(dQuantiy) >0)
            {   
                grdItem.SetGridText( row, col, System.Round(grdItem.GetGridData(row, col),2)); 
            }
            else
            {
                grdItem.SetGridText( row, col, "");
            }
        }
        else
        {
            grdItem.SetGridText( row, col, "");
        }
        var a = Number(grdItem.GetGridData(row,G1_QTY))* Number(grdItem.GetGridData(row,G1_PRICE));
        grdItem.SetGridText(row,G1_AMOUNT,a);
    }
}
//==================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'data_epim00090':
            if(flag=="save")
            {
                for (i=1;i<grdItem.rows;i++)
                {
                    if(grdItem.GetGridData(i,G1_MASTER_PK)=="")
                    {
                        grdItem.SetGridText(i,G1_MASTER_PK,txtMasterPK.text);
                    }
                }
                flag="";
                data_epim00090_1.Call();
            }
            else
            {
                data_epim00090_1.Call("SELECT");
            }
            
        break;
    }
}
//==================================================================
function OnAddNew(pos)
{
    switch(pos)
    {
        case'1':
            grdDecl.AddRow();
        break;
        case'2':
            if(txtMasterPK.text=="")
            {
                alert("Please save first") ;
            }
            else
            {
                var path = System.RootURL + '/form/fp/ab/fpab00650.aspx';
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                
                if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];                                
                                grdItem.AddRow();   

                                grdItem.SetGridText( grdItem.rows-1, G1_ITEM_PK, arrTemp[2]);                           
                                grdItem.SetGridText( grdItem.rows-1, G1_ITEM_CODE, arrTemp[3]);
                                grdItem.SetGridText( grdItem.rows-1, G1_ITEM_NAME, arrTemp[4]);
                                grdItem.SetGridText( grdItem.rows-1, G1_UOM, arrTemp[5]);
                        }	
                 }  
            }
        break;
    }
    
}
function OnDelete(pos)
{
    switch(pos)
    {
        case'1':
            if(grdDecl.GetGridData(grdDecl.row,G_PK)=="")
            {
                grdDecl.RemoveRow();
            }
            else
            {
                if(confirm("Are you sure to Delete ???"))
                {
                    grdDecl.DeleteRow();
                }
            }
        break;
        case'2':
            if(grdItem.GetGridData(grdItem.row,G_PK)=="")
            {
                grdItem.RemoveRow();
            }
            else
            {
                if(confirm("Are you sure to Delete ???"))
                {
                    grdItem.DeleteRow();
                }
            }
        break;
    }
}
//==================================================================
 function OnToggle()
 {
    var tab_top  = document.all("tab_top");    
    var tab_bottom = document.all("tab_bottom");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        tab_top.style.display="none";       
        imgArrow.status = "collapse";
        tab_bottom.style.width="100%";
        imgArrow.src = "../../../system/images/down.gif";
    }
    else
    {
        tab_top.style.display="";
        imgArrow.status = "expand";
        tab_bottom.style.height="50%";
        imgArrow.src = "../../../system/images/up.gif";
    }
 }    
 
//==================================================================
function OnCalTotal()
{
    for(i=1;i<grdItem.rows;i++)
    {
        var a = Number(grdItem.GetGridData(i,G1_QTY))* Number(grdItem.GetGridData(i,G1_PRICE));
        grdItem.SetGridText(i,G1_AMOUNT,a);
    }
}
//==================================================================
var flag = "";
function OnSave()
{
    flag="save";
    data_epim00090.Call();
}
//==================================================================         
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_epim00090" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="lg_sel_epim00090" parameter="0,1,2,3" procedure="lg_upd_epim00090" >
                <input bind="grdDecl" >
                    <input bind="dtFrom1" />
                    <input bind="dtTo1" />                
			        <input bind="txtSearchNo1" />
                </input>
                <output bind="grdDecl" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="data_epim00090_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="lg_sel_epim00090_1" parameter="0,1,2,3,4,5,6,7,8" procedure="lg_upd_epim00090_1" >
                <input bind="grdItem" >
                    <input bind="txtMasterPK" />
                </input>
                <output bind="grdItem" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 50%" id="tab_top">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            P/O Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom1" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo1" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Search No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearchNo1" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdConfirm')" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                        </td>
                        <td style="width: 27%; text-align: center">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="Add New" onclick="OnAddNew('1')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete('1')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="11">
                            <gw:grid id='grdDecl' header='_PK|Company|Declare Date|Declare No' format='0|0|4|0'
                                aligns='0|0|0|0' check='|||' editcol='1|1|1|1' widths='1000|3000|2000|1000' sorting='T'
                                styles='width:100%; height:100%' onclick="OnSearchDetail()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%" id="tab_bottom">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 1%">
                            <%--<img id="imgArrow" status="expand" id="imgUp" src="../../../system/images/up.gif"
                                style="cursor: hand" onclick="OnToggle()" />--%>
                        </td>
                        <td style="width: 99%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew1" img="new" alt="Add New" onclick="OnAddNew('2')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" onclick="OnDelete('2')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="4">
                            <gw:grid id='grdItem' header='_PK|_TLG_IE_IM_DECL_M_PK|_ITEM_PK|Item Code|Item Name|Qty|Uom|Price|Amount'
                                format='0|0|0|0|0|1|0|1|1' aligns='0|0|0|0|0|0|0|0|0' check='||||||||' editcol='1|1|1|1|1|1|1|1|1'
                                widths='1000|1000|1000|2000|4000|2000|2000|2000|2000' sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnPopUp('item')" onafteredit="OnCheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtPOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
    <gw:textbox id="txtArrayPOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------->
</body>
</html>
