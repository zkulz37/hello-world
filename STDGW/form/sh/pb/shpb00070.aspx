<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Color Composition</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
        
    var G1_PK                       = 0,
        G1_color_code               = 1,
        G1_color_local_name         = 2,
        G1_color_eng_name           = 3,
        G1_color_for_name           = 4;
        

 //---------------------------------------------------------
 function BodyInit()
 {
      OnSearch('grdDetail');
 }
 
 //---------------------------------------------------------

 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                shpb00070.Call("SELECT");
            break;     
      }  
 }
//----------------------------------------------------------
function CheckDataIsValid()
{
    for(var i=1;i<grdDetail.rows;i++)
    {
        var color_code=grdDetail.GetGridData(i,G1_color_code);
        if(color_code.length!=3)
        {
            alert("Color Code row" + i + " must be 3 character ");
            return false;
        }
        if(grdDetail.GetGridData(i,G1_color_code)==""&& grdDetail.GetRowStatus(i)!=64)
        {
            alert("Please input Color Code row "+ i);
            return false;
        }
        else if(grdDetail.GetGridData(i,G1_color_local_name)=="" && grdDetail.GetRowStatus(i)!=64)
        {
            alert("Please input Color Name row "+ i);
            return false;
        } 
    }
   return true;
}
//----------------------------------------------------------

 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :
            grdDetail.AddRow();  	 	           
        break;
      }  
 }
//---------------------------------------------------------
function OnChangeGroup()
{
    if(txtGroupPK.text!="")
    {
        grdDetail.SetGridText(grdDetail.row,G1_item_group_pk,lstGroup.value);
        grdDetail.SetGridText(grdDetail.row,G1_group_name,lstGroup.GetText());
    }   
}
//---------------------------------------------------------

 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                if(CheckDataIsValid())
                {          
                    shpb00070.Call();    
                }      
            break;
      }  

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
function GrdOnClick()
{
    txtGroupPK.text=grdDetail.GetGridData( grdDetail.row, G1_item_group_pk );
}
//------------------------------------------------------------------------------
function OnDataReceive(obj)
{
   lblRecord.text = (grdDetail.rows -1) + ' record(s)'
}
//------------------------------------------------------------
//-------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00070" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00070" parameter="0,1,2,3,4" procedure="prod.sp_upd_shpb00070" > 
                <input bind="grdDetail" > 
                    <input bind="txtName" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                <b>Color</b>
            </td>
            <td style="width: 30%" align="right" colspan="3">
                <gw:textbox id="txtName" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
            </td>
            <td style="width: 20%" align="right">
                <gw:label id="lblRecord" styles="width:100%;color:blue" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('grdDetail')" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="11">
                <gw:grid id='grdDetail' header='_PK|Color Code|Color Local Name|Color Eng Name|Color Foreign Name'
                    format='0|0|0|0|0' aligns='0|0|0|0|0' defaults='||||' editcol='1|1|1|1|1'
                    widths='1000|1500|2500|2500|2500' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
