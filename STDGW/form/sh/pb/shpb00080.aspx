<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Test No Registration</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    
var G2_PK           = 0,
    G2_tco_item_pk  = 1,
    G2_Test_No      = 2,
    G2_Enter_Date   = 3,
    G2_Valid        = 4,
    G2_Change_Date  = 5;
//===============================================================

function BodyInit()
{
    //------------------
    txtTypeNoM.SetEnable(false);
    txtBlendingRatio.SetEnable(false);
	BindingDataList();
	OnSearch();		
}
var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
//===============================================================

function BindingDataList()
{ 
    var dataBlendingType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0030') FROM DUAL" )%>"; 
    var data ="#01;01 - Gelatin(Type B)|#02;02 - Gelatin(Type A)"; 
        grdMixTypeD.SetComboFormat(2,data);
    lstBlendingType.SetDataText(dataBlendingType);
    lstBlendingTypeM.SetDataText(dataBlendingType);
    dso_MixTypeMaster.StatusInsert();
     var fg = grdMixTypeD.GetGridControl();
    fg.ColFormat(4)= "#,###.###";   
}

//===============================================================

function OnSearch()
{
   
        data_shpb00080.Call('SELECT');
     
}
//===============================================================

function OnNewD()
{            
    grdMixTypeD.AddRow();                                                
}
//===============================================================

function OnDelete()
{
   if(confirm('Do you want to delete ?'))
            {
                dso_MixTypeMaster.StatusDelete();
                dso_MixTypeMaster.Call();
                Delete='T';
            }
}
function OnDeleteD()
{
   if(confirm('Do you want to delete ?'))
            {
               grdMixTypeD.DeleteRow();
                data_MixTypeD.Call();
            }
}
//=================================================================
function OnPrint()
{
    if(txtMasterPK.text!="")
    {
        var path = System.RootURL + '/form/sh/pb/shpb00140.aspx?blend_type='+lstBlendingTypeM.value+'&blend_no='+txtBlendingNoM.text;
        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    }
    else
    {
        alert("Select Blending No to print");
    }
}
//===============================================================
function OnNew()
{
    dso_MixTypeMaster.StatusInsert();
    grdMixTypeD.ClearData();
}
function OnSave()
{ 
    if(txtBlendingNoM.text !="")
    {
        if(chkConfirm_YN.value =="T") 
        { 
            var dValueSum=0;      
                 for(i=1; i<grdMixTypeD.rows; i++ )
                dValueSum = System.Round(Number(dValueSum) + Number(grdMixTypeD.GetGridData(i,4)),3);
            if(dValueSum != 100)
            {
                alert("Please enter the item total Mixing Ratio must equal 100%");
            }
            else
            {
                dso_MixTypeMaster.Call();
                Insert='T'; 
            } 
         }
        else
        {
            dso_MixTypeMaster.Call();
            Insert='T'; 
        } 
    }
    else
    {
        alert("Please input Blending No.");
    }
}
//===============================================================

function OnClickGridMaster()
{
    if (grdMixTypeSearch.row > 0)
    {        
        txtMasterPK.SetDataText(grdMixTypeSearch.GetGridData(grdMixTypeSearch.row,0));
        dso_MixTypeMaster.Call('SELECT');
    }
}
//===============================================================
function OnEditGrid()
{
    if(grdMixTypeD.col== 4)
    {
        TotalBlending_Ratio();
    }
}
function TotalBlending_Ratio()
{
     var SumBlendingRatio=0;      
             for(i=1; i<grdMixTypeD.rows; i++ )
             {
                SumBlendingRatio = Number(SumBlendingRatio) + Number(grdMixTypeD.GetGridData(i,4));
             }
             txtBlendingRatio.SetDataText(System.Round(SumBlendingRatio,3));
}
function OnDataReceive(obj)
{
    if(obj.id == 'dso_MixTypeMaster')
    {
        if(Insert=="T" || Delete=="T")
        {
            if(Insert=="T")
            {
                SetMasterPKToGrid(txtMasterPK.text);
                data_MixTypeD.Call();
            }
            else
            {
                data_shpb00080.Call('SELECT');
                Delete="F";
            } 
        }
        else
        {
            data_MixTypeD.Call('SELECT');
            Insert="F";
        }   
    }
    if(obj.id == 'data_MixTypeD')
    {
        TotalBlending_Ratio();
        if(Insert=="T")
        {
            data_shpb00080.Call('SELECT');
            Insert="F";
        }
    }
   
} 
function SetMasterPKToGrid(p_masterPK){
    for(var i=0;i<grdMixTypeD.rows;i++){
        if(grdMixTypeD.GetGridData(i,1) == ""){
            grdMixTypeD.SetGridText(i,1,p_masterPK);
        }
    }
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpb00080" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shpb00080">
                <input bind="grdMixTypeSearch" >
                    <input bind="lstBlendingType" />
                    <input bind="txtBlendingNo" />
                </input>
                <output bind="grdMixTypeSearch" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_MixTypeMaster" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="PROD.sp_sel_shpb00080_1" procedure="PROD.sp_upd_shpb00080_1">
            <inout> 
                <inout bind="txtMasterPK"/>
                <inout bind="lstBlendingTypeM"/>
                <inout bind="txtBlendingNoM"/>
                <inout bind="txtTypeNoM"/>
                <inout bind="txtTypeNameM"/>
                <inout bind="chkConfirm_YN"/>            
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_MixTypeD" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5" function="PROD.sp_sel_shpb00080_2" procedure="PROD.sp_upd_shpb00080_2">
                <input bind="grdMixTypeD" >
                    <input bind="txtMasterPK" />
                </input>
                <output bind="grdMixTypeD" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 30%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Blending Type</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstBlendingType" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Blending Type No</td>
                        <td style="width: 89%">
                            <gw:textbox id="txtBlendingNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdMixTypeSearch" header="_PK|Blending No|Blending Type No|Blending Type Name" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|2000|2000|1500" styles="width:100%;height:100%" autosize='T'
                                oncellclick="OnClickGridMaster()" param="0,1,2,3,4" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                        <td style="width: 15%">
                            Blend.Type</td>
                        <td style="width: 36%; white-space: nowrap">
                            <gw:list id="lstBlendingTypeM" styles="width: 100%" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Blending No</td>
                        <td style="width: 35%; white-space: nowrap">
                            <gw:textbox id="txtBlendingNoM" styles="width: 100%" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Excel" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 10%">
                             Type No</td>
                        <td style="width: 40%; white-space: nowrap">
                            <gw:textbox id="txtTypeNoM" styles="width: 100%" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Type Name</td>
                        <td style="width: 35%; white-space: nowrap">
                            <gw:textbox id="txtTypeNameM" styles="width: 100%" />
                        </td>
                        <td style="width: 2%" colspan="2">Confirm
                        </td>
                        <td style="width: 1%">
                            <gw:checkbox id="chkConfirm_YN" value="F" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" onclick="OnNewD()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDeleteD()" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="9">
                            <gw:grid id="grdMixTypeD" header="_PK|_MixType_pk|Blending Type|Test No|Blending Ratio(%)|Remark"
                                format="0|0|0|0|0|0" aligns="0|0|0|0|3|0" defaults="|||||" editcol="1|1|1|1|1|1"
                                widths="0|0|2000|1500|1500|1500" styles="width:100%;height:100%" autosize='T' onafteredit="OnEditGrid()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan="2" align="right">Total Blending Ratio(%)</td>
                        <td><gw:textbox id="txtBlendingRatio" text="0" type="number" format="###,###.###" styles="width: 100%" /></td>
                        <td colspan="5"></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
