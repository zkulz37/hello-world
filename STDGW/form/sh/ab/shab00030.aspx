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
        G1_item_group_pk            = 4,
        G1_group_name               = 5;
        

 //---------------------------------------------------------
 function BodyInit()
 {
      OnSearch('grdDetail');
      BindingDataList();
 }
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                shab00030.Call("SELECT");
            break;     
      }  
 }

//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
              
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_NM from  comm.tco_itemgrp where del_if=0 order by GRP_NM ")%>";
        lstGroup.SetDataText(data);
        lstGroup.value='';
             
 }
//---------------------------------------------------------
function OnChangeGroup()
{
    OnSearch('grdDetail');  
}
//------------------------------------------------------------------------------------	
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdDetail.row > 0 )
    {
        for( j=0 ; j<grdDetail.cols ; j++ )
        {
            code_data[j] = grdDetail.GetGridData(grdDetail.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdDetail.cols ; j++ )
        {
            code_data[j] = '';
        } 	    
    }
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//------------------------------------------------------------------------------------	
function EXITOnClick()
{
	OnSelect();
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shab00030"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shab00030" parameter="0,1,2,3,4,5"> 
                <input bind="grdDetail" > 
                    <input bind="txtName" /> 
                    <input bind="lstGroup" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                <b>Group</b>
            </td>
            <td style="width: 30%" align="right">
                <gw:list id="lstGroup" styles='width:100%' onchange="OnChangeGroup()"/>
            </td>
            <td style="width: 10%" align="right">
                <b>Color</b>
            </td>
            <td style="width: 40%" align="right">
                <gw:textbox id="txtName" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
            </td>
            <td style="width: 45%" align="right">
            </td>
            <td style="width: 1%" align="right">
                
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="select" alt="Select" id="btnSelect" onclick="OnSelect()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdDetail' header='_PK|Color Code|Color Local Name|Color Eng Name|_TCO_ITEMGRP_PK|Group Name'
                    format='0|0|0|0|0|0' aligns='0|0|0|0|0|0' defaults='|||||' editcol='1|1|1|1|1|0'
                    widths='1000|2500|3000|3000|1000|1000' sorting='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
