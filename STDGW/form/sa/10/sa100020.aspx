<!-- #include file="../../../system/lib/form.inc"  -->
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="ftb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("sale")%>

<script>         
var  G1_PK          = 0, 
     G1_SEQ         = 1,
     G1_YARN_CODE   = 2, 
     G1_NPL         = 3, 
     G1_YARN        = 4, 
     G1_SPEC        = 5, 
     G1_KNIT_LOSS   = 6, 
     G1_TWIST_LOSS  = 7,
     G1_NOTE        = 8, 
     G1_PRICE       = 9;
//====================================================       
function BodyInit()
{
  
}
//====================================================    
function OnAddNew()
{  
    grdMaster.AddRow();
}   
//==================================================== 
function OnSave()
{
    /*for(var i=1;i<grdMaster.rows;i++)
    {
        if(grdMaster.GetGridData(i,G1_ST_PRICE)=="")
        {
            alert("Please Input Price ");
            return false;
        } 
    }*/
    data_sa100010.Call();
} 
//=====================================================
function OnDelete()
{
    if( grdMaster.row >= 1 )
    { 
        if ( grdMaster.GetGridData( grdMaster.row,G1_PK ) == '' ) 
        {
            grdMaster.RemoveRow();
        }
        else
        {
            grdMaster.DeleteRow();
        }  
    }
}
//======================================================
function OnUndelete()
{
    grdMaster.UnDeleteRow();
}
//====================================================    
function OnSearch()
{  
   data_sa100010.Call("SELECT"); 
   txtYarn.text='';
   txtNpl_Spec.text='';
}
//====================================================  
function OnDataReceive(pos)
{   
    switch(pos.id)
    {
        case 'data_sa100010':
            lblCount.text = grdMaster.rows-1 + ' row(s)';
            grdMaster.SetCellBold( 1, G1_KNIT_LOSS  , grdMaster.rows - 1, G1_KNIT_LOSS  ,     true);         
            grdMaster.SetCellBold( 1, G1_TWIST_LOSS , grdMaster.rows - 1, G1_TWIST_LOSS ,     true);         
            grdMaster.SetCellBold( 1, G1_PRICE      , grdMaster.rows - 1, G1_PRICE      ,     true);         
        break;
    }
}
</script>

<body>
    <!----------------------------- Search --------------------------------->
    <gw:data id="data_sa100010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="SAMIL.sp_sel_sa100020" procedure="SAMIL.sp_upd_sa100020"> 
                <input>
                    <input	bind="txtYarn"	/>	
					<input	bind="txtNpl_Spec"	/>	
                </input>     
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td width="1%">
                            Yarn
                        </td>
                        <td width="25%">
                            <gw:textbox id="txtYarn" styles='width:100%' onenterkey="OnSearch()" />
                        </td>
                        <td width="1%" align="right">
                            NPL/Spec
                        </td>
                        <td width="25%">
                            <gw:textbox id="txtNpl_Spec" styles='width:100%' onenterkey="OnSearch()" />
                        </td>
                        <td width="100%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' text='-' />
                        </td>
                        <td width="1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch()" />
                        </td>
                        <td width="1%">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew()" />
                        </td>
                        <td width="1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete()" />
                        </td>
                        <td width="1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete1" onclick="OnUnDelete()" />
                        </td>
                        <td width="1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdMaster' header='_pk|Seq|Yarn Code|NPL|Yarn|Spec|Knit Loss|Twist Loss|Note|Price'
                    format='0|0|0|0|0|0|1|1|0|1' aligns='0|1|0|0|0|0|0|0|0|0' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='0|500|1200|1200|2000|2000|1500|1500|3000|1500' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
</html>
