<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Color Composition Display</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_PK                       = 0,
        G1_color_code               = 1,
        G1_color_local_name         = 2;

    var G2_Item_Code                       =0,
        G2_Item_Name                       =1,
        G2_Reqd_Qty_Kg                     =2,
        G2_Reqd_Qty                        =3;

 //---------------------------------------------------------
 function BodyInit()
 {
      shpb00060.Call("SELECT");
      BindingDataList();
      txtColorCode.SetEnable(false);
      txtColorName.SetEnable(false);
      lstProductType.SetEnable(false);
      FormatGrid();
      grdDetail.SetHeaderFontSize(16);
      SetHeader();
      
 }
 //
 function SetHeader()
 {
    var fg = grdDetail.GetGridControl();
    fg.RowHeight(0)=550; 
 }
   //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
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
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'grdColor':
            shpb00060.Call("SELECT");
        break;
        case'Master': 
            txtMasterPK.text=grdColor.GetGridData(grdColor.row,G1_PK);
            shpb00060_1.Call("SELECT");
            txtSolQty.text="";
        break;
        
    }
 }
//----------------------------------------------------------
function FormatGrid()
 {
      var trl ;
      
      trl = grdDetail.GetGridControl();
      	
      trl.ColFormat(G2_Reqd_Qty_Kg )         = "###,###,###,###,###.#####";
      trl.ColFormat(G2_Reqd_Qty )            = "###,###,###,###,###.####";
      
 }
//----------------------------------------------------------
function BindingDataList()
 {    
//        var data=""; 
//        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_NM from  comm.tco_itemgrp where del_if=0 order by GRP_NM ")%>";
        lstProductType.SetDataText('|1|GELATIN');
        lstProductType.value='';
             
 }
//---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :
                shpb00060_1.Call();
            break;
      }  

 }
//---------------------------------------------------------
 function ViewComponent()
 {
    var tableView = document.all("viewImg"); 
    var str = "";
    
    tableView.innerHTML = "";
    
    if ( grdDetail.rows > 0 )
    {
        str = " <table style=' width: 100%' border='1'> "
        str =  str + " <tr style='height: 1%' > "
        str =  str + " <td width='20%' align='center' style='background-color: #99ccff' > Item Code </td>  "
        str =  str + " <td width='40%' align='center' style='background-color: #99ccff' > Item Name </td>  "
        str =  str + " <td width='10%' align='center' style='background-color: #99ccff' > Reqd.Qty/Kg </td>  "
        str =  str + " <td width='30%' align='center' style='background-color: #99ccff' > Reqd.Qty </td>  "
        str =  str + " </tr> "
        
        for(var i =1; i<grdDetail.rows; i++)
        {
              str =  str + " <tr style='height: 50' > "
              str =  str + " <td  align='center' >" + grdDetail.GetGridData( i, G2_Item_Code) +  "</td>  "
              str =  str + " <td  align='center' >" + grdComponent1.GetGridData( i, G2_Item_Name) +  " </td>  "
              str =  str + " <td  align='right' >"  + grdComponent1.GetGridData( i, G2_Reqd_Qty_Kg) +  " </td>  "
              str =  str + " <td  align='right' >"  + grdComponent1.GetGridData( i, G2_Reqd_Qty) +  " </td>  "
              str =  str + "</tr>"
        }
        str = str + " </table> ";
    } 
    
    tableView.innerHTML = str
 }
//---------------------------------------------------------

 function OnDelete()
 {
		if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == "" ) 
	    {						
				grdDetail.RemoveRow();					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdDetail.DeleteRow();
			}
		}
 }
 
 //---------------------------------------------------------
 function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }
//---------------------------------------------------------
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'shpb00060_1':
             shpb00060_2.Call("SELECT");
        break;
        case'shpb00060_2':
            for(var i=0;i<grdDetail.rows;i++)
            {
                var fg = grdDetail.GetGridControl();
                fg.RowHeight(i)=550;
                grdDetail.SetCellBold(i,0,i,3,true) ;      
            }
            var fg = grdDetail.GetGridControl();
            fg.Cell(12, 1,0, grdDetail.rows-1, 3) = 15 ; 
            
        break;
        
    }
}
//----------------------------------------------------------
function OnDisplay()
{   
    if(txtSolQty.text=="")
    {
        alert("Please Input SolQty");
    }
    else if(!Number(txtSolQty.text))
    {
        alert("Please Input Numberic");
        txtSolQty.text="";
    }
    else if(Number(txtSolQty.text)<0)
    {
        alert("Value must greater than zero");
        txtSolQty.text="";
    }
    else
    {   
        
        for(var i=1;i<grdDetail.rows;i++)
        {
            var qty=grdDetail.GetGridData(i,2);
            var reqdqty=qty*txtSolQty.text;
            grdDetail.SetGridText(i,3,reqdqty);  
        }
        
    }
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00060"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00060" > 
                <input> 
                    <input bind="txtCodeName" /> 
                </input> 
                <output bind="grdColor" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00060_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shpb00060_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="txtColorCode" />
                    <inout bind="txtColorName" />
                    <inout bind="lstProductType" /> 
                </inout>       
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00060_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="3" type="grid" user="prod" function="prod.sp_sel_shpb00060_2"> 
                <input> 
                    <input bind="txtMasterPK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <b>Color Code</b>
                        </td>
                        <td style="width: 30%" align="right">
                            <gw:textbox id="txtCodeName" styles='width:100%;font-size:large' onenterkey="OnSearch('grdColor')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdColor')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdColor' header='_PK|Color Code|Color Name' format='0|0|0' aligns='0|0|0'
                                defaults='||' editcol='0|0|0' widths='1000|1500|1000' sorting='T' styles='width:100%; height:100%'
                                onselchange="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 18%; white-space: nowrap" align="right">
                            <b style="font-size: large">Product Type</b>
                        </td>
                        <td style="width: 40%" align="right" colspan="1">
                            <gw:list id="lstProductType" styles='width:100%;font-size:large' />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            <b style="font-size: large">Sol.Q'ty</b>
                        </td>
                        <td style="white-space: nowrap; width: 20%">
                            <gw:textbox id="txtSolQty" styles='width:80%;font-size:large' onenterkey="OnDisplay()" />
                            <b style="font-size: large">Kg</b>
                        </td>
                        <td style="width: 20%" align="right">
                            <gw:imgbtn img="process" alt="Display" id="btnDisplay" onclick="OnDisplay()" styles='font-size:large' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%; white-space: nowrap" align="right">
                            <b style="font-size: large">Color Code</b>
                        </td>
                        <td style="width: 30%" align="right" colspan="4">
                            <gw:textbox id="txtColorCode" styles='width:30%;font-size:large' />
                            <gw:textbox id="txtColorName" styles='width:70%;font-size:large' />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="5" style="font-size: large">
                            <gw:grid id='grdDetail' header='Item Code|Item Name|Reqd.Qty/Kg|Reqd.Qty' format='0|0|0|0'
                                aligns='0|0|3|3' defaults='|||' editcol='0|0|0|0' widths='1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' autosize='T' />
                               
                        </td>
                        <td valign="top" id="tab_view_component" colspan="10">
                            <div id="viewImg">
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
</html>
