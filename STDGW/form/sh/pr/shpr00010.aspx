<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vina Genuwin</title>
</head>
<%  ESysLib.SetUser("prod")%>
<script>
var flag='search' ;
function BodyInit()
{
    BindingDataList();
    OnSearch(1);
    //OnNew(1);
}
//-------------------------------------------------------------------------------------------------------
function BindingDataList()
{
//    txtUser_Pk.SetDataText("<%=session("USER_PK")%>");
//	txtCharger.SetDataText("<%=session("USER_ID")%>");
    ls_warehouse = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_name FROM inv.tin_warehouse WHERE del_if = 0")%>|All|--- Select All ---";
    ls_machine = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM sale.LG_CODE a, sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0010' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM" )  %> " ; 
    GridDetail.SetComboFormat(2,ls_machine);
    //lstWarehouse.SetDataText(ls_warehouse);
    ls_warehouseD = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_name FROM inv.tin_warehouse WHERE del_if = 0")%>";
    //lstWarehouseD.SetDataText(ls_warehouseD);
    //lstWarehouse.value = "All";
    dso_upd_Control.StatusInsert();
}
//-------------------------------------------------------------------------------------------------------------
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="70%";
    imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//------------------------------------------------------------------------------------------------------------------------
function OnNew(obj)
{
    switch(obj)
    {
        case 1:
        flag='new';
            dso_upd_Control.StatusInsert();
            //txtUser_Pk.text =  "<%=Session("USER_PK") %>";
            GridDetail.ClearData();
        break;
        case 2:
            GridDetail.AddRow();
            if(txt_PK.text != "")
            {
                GridDetail.SetGridText( GridDetail.rows - 1, 1, GridDetail.rows-1); 
                GridDetail.SetGridText( GridDetail.rows - 1, 7, txt_PK.text);
            }  
        break;
    }
}
//---------------------------------------------------------------------------------------------------
function OnSave()
{
    dso_upd_Control.Call();
    flag='update'; 
}
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{
    switch(obj)
    {
        case 1:
            dat_Search.Call("SELECT");
        break;
        case 2:
            txt_PK.SetDataText(GridSearch.GetGridData(GridSearch.row,0));
            flag = 'search';            
            dso_upd_Control.Call('SELECT');
        break;
    }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dso_upd_Control":
            
            if(flag != 'search')
            {
                for(i = 1; i < GridDetail.rows; i++)
                {   
                            if(GridDetail.GetGridData(i, 0)=='')
                            {         
                                GridDetail.SetGridText(i, 7, txt_PK.text);               
                                GridDetail.SetRowStatus(i, 0x20);
                            }
                }
                dat_Detail.Call();
              }
              else
              {
                dat_Detail.Call('SELECT');
                flag = 'search';
              }   
        break;
        case "dat_Detail":
            if(flag != 'search')
            {
                dat_Search.Call('SELECT');
            }
        break;
    }
}
function OnPopUp(obj)
{
    switch(obj)
    {
        case 1:
            var fpath = System.RootURL + "/form/sh/pr/shpr00010_popup.aspx?";
            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                txtColor_cd.text = object[1];//cust code
                txtColor_nm.text = object[2];//cust name 	 	
            }
        break;
        case 2:
                var fpath = System.RootURL + "/form/sh/pr/shpr00010_popup_1.aspx?";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {
		               txtCharger.text = object[2];//cust name 
                       txtCharger_pk.text = object[3];
                    }
        break;
    }
}
//-----------------------------------------------------------------------------------------------
function OnDelete(index)
{
    switch(index)
    {
        case 0:
            if(txt_PK.GetData()!='')
            {
                if(confirm('Do you want to delete selected ?'))
                {
                     flag='delete';
                     dso_upd_Control.StatusDelete();
                     dso_upd_Control.Call();
                }
            }    
        break;
        case 1:
            if(confirm('Do you want to delete selected ?'))
            {
                GridDetail.DeleteRow();
                OnSave();
            }
        break;
    }         
}
</script>

<body>
<gw:data id="dat_Search" > 
    <xml> 
          <dso id="1" type="grid"  function="prod.sp_sel_shpr00010_m"> 
            <input bind="GridSearch">                    
                <input bind="dtfrdate" />
                <input bind="dttodate" />
                <input bind="txtColor" />
            </input> 
            <output bind="GridSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!---------------------------------------------------------------------------------->
 <gw:data id="dso_upd_Control" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6" function="prod.sp_sel_shpr00010" procedure="prod.sp_udp_shpr00010"> 
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="dtdate" />
                 <inout bind="txtCharger_pk" />
                <inout bind="txtColor_cd" />
                <inout bind="txtColor_nm" />
                <inout bind="txtDescription" />
                <inout bind="txtCharger" />
           </inout>
            </dso> 
        </xml> 
    </gw:data> 
<!--------------------------------------------------------------------------------->
 <gw:data id="dat_Detail" onreceive="OnDataReceive(this)"> 
    <xml> 
          <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7" function="prod.sp_sel_shpr00010_detail" procedure="prod.sp_upd_shpr00010_detail"   > 
            <input bind="GridDetail">                    
                <input bind="txt_PK" /> 
            </input> 
            <output bind="GridDetail" /> 
        </dso> 
    </xml> 
</gw:data>
    <table border="1" style="width: 100%; height: 100%">
        <tr>
            <td id="left" width="20%" valign="top">
                <table border="0" style="width: 100%; height: 100%" cellpadding="0" cellspacing="0"
                    id="table5">
                    <tr style="height: 5%">
                        <td width="100%">
                            <fieldset style="width: 100%; height: 100%; padding: 2">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" id="table1">
                                    <tr>
                                        <td width="35%" align="right">
                                            Date</td>
                                        <td width="65%" >
                                            <table style="width: 100%">
                                                <tr width="100%">
                                                    <td>
                                                        <gw:datebox id="dtfrdate" type="date" lang="1" />
                                                    </td>
                                                    <td align="center">
                                                        ~</td>
                                                    <td >
                                                        <gw:datebox id="dttodate" type="date"  lang="1" />
                                                    </td>
                                                    <td><gw:imgbtn id="ibtnDelete17" img="search" alt="Search" onclick="OnSearch(1)" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="35%">
                                            Color </td>
                                        <td width="65%"  >
                                            <gw:textbox id="txtColor" styles='width:100%' onenterkey="OnSearch(1)" />
                                        </td>
                                    </tr>
                                   <!-- <tr>
                                        <td width="35%" align="right">
                                            Warehouse </td>
                                        <td width="65%">
                                            <gw:list id="lstWarehouse"   styles="width:100%;" />
                                        </td>
                                        
                                   </tr>-->
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td width="100%">
                            <gw:grid id="GridSearch" header="_pk|Date|Color Code|Color Name" format="0|4|0|0"
                                aligns="0|0|0|0" defaults="|||" editcol="1|1|1|1" widths="0|1100|1500|2000" styles="width:100%; height:100%"
                                sorting="F" oncellclick="OnSearch(2)" />
                        </td>
                    </tr>
                </table>
            </td>
            <td align="center" id="right" style="width: 80%" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                    <tr style="width: 100%; height: 5%">
                        <td>
                            <fieldset style="width: 100%; height: 100%; padding: 2">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="right" style="width: 15%">
                                            Date</td>
                                        <td style="width: 25%">
                                            <gw:datebox id="dtdate" type="date" lang="1" />
                                        </td>
                                         <td align="right" style="width: 10%">
                                         <a title="Click here to select Charger" onclick="OnPopUp(2)" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Charger</b></a></td>
                                        
                                        <td width="45%">
                                            <gw:textbox id="txtCharger" styles='width:100%' /></td>
                                        <td >
                                                
                                        </td>
                                        <td >
                                                <gw:imgbtn id="btnreset4" img="reset" alt="Reset" onclick="txtColor_cd.text='';txtColor_nm.text='';" />
                                         </td>
                                        <td width="5%"></td>
                                        
                                        <td>
                                            <gw:imgbtn id="ibtnReset" img="new" alt="new" onclick="OnNew(1)" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnDelete" img="delete" alt="delete" onclick="OnDelete(0)" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdate" img="save" alt="save" onclick="OnSave()" />
                                        </td>
                                    </tr>
                                    <tr>
                                         <!--<td align="right" width="15%">
                                            Warehouse</td>
                                        <td width="25%">
                                            <gw:list id="lstWarehouseD" styles="width:100%;" />
                                        </td>-->
                                       
                                        <td width="15%" align="right">
                                            <a title="Click here to select Color" onclick="OnPopUp(1)" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Color</b></a></td>
                                        <td width="40%">
                                            <gw:textbox id="txtColor_cd"  styles="width:100%%;" />
                                        </td>
                                        <td width="5%" colspan="4"><gw:textbox id="txtColor_nm"  styles="width:100%;" /></td>
                                    </tr>
                                    <tr>
                                    <td align="right" width="15%">
                                            Description</td>
                                        <td width="85%" colspan="5">
                                            <gw:textbox id="txtDescription" styles='width:100%' />
                                        </td>
                                        <td width="5%" colspan="1"></td>
                                        <td>
                                            <gw:imgbtn id="ibtnReset1" img="new" alt="new" onclick="OnNew(2)" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnDelete1" img="delete" alt="delete" onclick="OnDelete(1)" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 95%">
                        <td style="width: 100%">
                            <!--header="0._pk|1.No|2.Machine|3.Batch No|4.Receipt Qty|5.Unit|6.Remark|7._pkM"-->
                            <gw:grid id="GridDetail" header="_pk|No|Machine|Batch No|Receipt Qty(KG)|_Unit|Remark|_pkM"
                                format="0|0|0|0|0|0|0|0" aligns="0|0|0|0|3|0|0|0" defaults="|||||||" 
                                editcol="0|0|1|1|1|1|1|1"
                                widths="0|600|1500|1500|1200|1500|3000|0" styles="width:100%; height:100%"
                                sorting="F" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
   
      
        <gw:textbox id="txt_PK" styles="width:98%;display:none" />
   
    <gw:textbox id="txtCharger_pk" styles="width:98%;display:none" />
</body>
</html>
