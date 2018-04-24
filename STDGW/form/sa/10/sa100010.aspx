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
     G1_SA_GROUP    = 2, 
     G1_SA_CODE     = 3, 
     G1_ITEM        = 4, 
     G1_CONTENT     = 5, 
     G1_NOTE        = 6,
     G1_KNIT_DATA   = 7, 
     G1_PRICE       = 8, 
     G1_LOSS        = 9,
     G1_SPAN_CHK    = 10,
     G1_SPUN_CHK    = 11,
     G1_WIDTH       = 12, 
     G1_GRAM        = 13,
     G1_YARN01      = 14, 
     G1_PER01       = 15, 
     G1_YARN02      = 16, 
     G1_PER02       = 17, 
     G1_YARN03      = 18, 
     G1_PER03       = 19,
     G1_YARN04      = 20, 
     G1_PER04       = 21, 
     G1_YARN05      = 22, 
     G1_PER05       = 23;
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
   txtGroup.text='';
   txtItem.text='';
}
//====================================================  
function OnDataReceive(pos)
{   
    switch(pos.id)
    {
        case 'data_sa100010':
            lblCount.text = grdMaster.rows-1 + ' row(s)';
            grdMaster.SetCellBold( 1, G1_PRICE      , grdMaster.rows - 1, G1_LOSS       ,     true);         
            grdMaster.SetCellBold( 1, G1_WIDTH      , grdMaster.rows - 1, G1_GRAM       ,     true);         
            grdMaster.SetCellBold( 1, G1_PER01      , grdMaster.rows - 1, G1_PER01      ,     true);         
            grdMaster.SetCellBold( 1, G1_PER02      , grdMaster.rows - 1, G1_PER02      ,     true);         
            grdMaster.SetCellBold( 1, G1_PER03      , grdMaster.rows - 1, G1_PER03      ,     true);         
            grdMaster.SetCellBold( 1, G1_PER04      , grdMaster.rows - 1, G1_PER04      ,     true);         
            grdMaster.SetCellBold( 1, G1_PER05      , grdMaster.rows - 1, G1_PER05      ,     true);         
        break;
    }
}
</script>

<body>
    <!----------------------------- Search --------------------------------->
    <gw:data id="data_sa100010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="SAMIL.sp_sel_sa100010" procedure="SAMIL.sp_upd_sa100010"> 
                <input>
                    <input	bind="txtGroup"	/>	
					<input	bind="chkSpan"	/>	
					<input	bind="chkSpun"	/>	
					<input	bind="txtItem"	/>	
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
                            Group
                        </td>
                        <td width="20%">
                            <gw:textbox id="txtGroup" styles='width:100%' onenterkey="OnSearch()" />
                        </td>
                        <td width="15%">
                            <gw:checkbox id="chkSpan" styles="color:blue" defaultvalue="Y|N" value="Y">SPAN Check
</gw:checkbox>
                        </td>
                        <td width="15%">
                            <gw:checkbox id="chkSpun" styles="color:blue" defaultvalue="Y|N" value="Y">SPUN Check
</gw:checkbox>
                        </td>
                        <td width="1%" align="right">
                            Item
                        </td>
                        <td width="20%">
                            <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch()" />
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
                <gw:grid id='grdMaster' header='_pk|Seq|Sa Group|Sa Code|Item|Content|Note|Knit Data|Price|Loss|Span Chk|Spun Chk|Width|Gram|Yarn 01|Per 01|Yarn 02|Per 02|Yarn 03|Per 03|Yarn 04|Per 04|Yarn 05|Per05'
                    format='0|0|0|0|0|0|0|0|1|1|3|3|1|1|0|1|0|1|0|1|0|1|0|1' aligns='0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|500|1000|1200|1500|2000|1200|1200|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
</html>
