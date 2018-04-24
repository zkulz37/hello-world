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
    txtMixingRatio.SetEnable(false);
    txtRatioKG.SetEnable(false);  
    DtModifyDate.SetEnable(false);  
    DtCreateDate.SetEnable(false);  
    txtModifyBy.SetEnable(false);  
    txtCreateBy.SetEnable(false); 
	BindingDataList();
	dso_AddiTiveMaster.StatusInsert();
	//OnSearch();		
	lstTrOP.value =''
}
var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
 
//===============================================================
function OnPrint()
{
    if(txtMasterPK.text!="")
    {
        var path = System.RootURL + '/form/sh/pb/shpb00130.aspx?Add_type='+lstTypeM.value+'&Add_no='+txtTypeNoM.text+'&Add_name='+txtTypeNameM.text+'&Add_pk='+txtMasterPK.text;
        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    }
    else
    {
        alert("Select Blending No to print");
    }
}
//===============================================================

function BindingDataList()
{ 
    var datalstType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code3('LGMF0030') FROM DUAL" )%>";  
     var datalstTrOP = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0040') FROM DUAL" )%>||";
     <%=ESysLib.SetGridColumnComboFormat("grdSearch",3,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0040' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
    lstType.SetDataText(datalstType);
    lstTypeM.SetDataText(datalstType);
    lstTrOP.SetDataText(datalstTrOP);
    lstTrOPM.SetDataText(datalstTrOP);
    var fg = grdAddiTiveD.GetGridControl();
    fg.ColFormat(10)= "#,###.###";
    fg.ColFormat(8)= "#,###.###";
}

//===============================================================

function OnSearch()
{
   
        data_shpb00090.Call('SELECT');
     
}
//===============================================================

function OnNewD()
{        
//    grdAddiTiveD.AddRow();                            
//    grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 1, txtMasterPK.text); //master_pk	
             var path = System.RootURL + '/form/sh/pb/shpb00081.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                            grdAddiTiveD.AddRow();                            
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 1, txtMasterPK.text); //master_pk	    	                                               
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 2, arrTemp[0]); //tco_item_pk	
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 3, arrTemp[1]);//mat code    
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 4,   arrTemp[2]);//mat name    
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 5,   arrTemp[4]);//test no	
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 6,   arrTemp[6]);//Unit   
                            grdAddiTiveD.SetGridText( grdAddiTiveD.rows-1, 7,   arrTemp[5]);//Spec1  
                    }		            
             }      
}
//===============================================================

function OnDelete()
{
   if(confirm('Do you want to delete ?'))
            {
                dso_AddiTiveMaster.StatusDelete();
                dso_AddiTiveMaster.Call();
                Delete='T';
            }
}
function OnDeleteD()
{
   if(confirm('Do you want to delete ?'))
            {
               grdAddiTiveD.DeleteRow();
                data_AddiTiveD.Call();
            }
}
//===============================================================
function OnNew()
{
    dso_AddiTiveMaster.StatusInsert();
    grdAddiTiveD.ClearData();
}
function OnSave()
{  
    if(chkConfirm_YN.value =="T") 
    { 
       /* var dValueSum=0;      
             for(i=1; i<grdAddiTiveD.rows; i++ )
            dValueSum = Number(dValueSum) + Math.round(Number(grdAddiTiveD.GetGridData(i,8));*/
        if(txtMixingRatio.text != 100)
        {
            alert("Please enter the item total Mixing Ratio must equal 100%");
        }
        else
        {
            dso_AddiTiveMaster.Call();
            Insert='T';  
        } 
     }
    else
    {
        dso_AddiTiveMaster.Call();
        Insert='T';  
    } 
}
function TotalMixing_Ratio()
{
     var SumMixingRatio=0,SumRatioKG=0;      
             for(i=1; i<grdAddiTiveD.rows; i++ )
             {
               // SumMixingRatio = Number(SumMixingRatio) + Math.round(Number(grdAddiTiveD.GetGridData(i,8)));
                SumMixingRatio = Number(SumMixingRatio) + Number(grdAddiTiveD.GetGridData(i,8));
                SumRatioKG = Number(SumRatioKG) + Number(grdAddiTiveD.GetGridData(i,10));
             }
             txtMixingRatio.SetDataText(System.Round(SumMixingRatio,3));
             txtRatioKG.SetDataText(SumRatioKG);   
}
function OnEditGrid()
{
    if(grdAddiTiveD.col== 8|| grdAddiTiveD.col == 10)
    {
        TotalMixing_Ratio();
    }
}
//===============================================================

function OnClickGridMaster()
{
    if (grdSearch.row > 0)
    {        
        txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
        dso_AddiTiveMaster.Call('SELECT');
    }
}
//===============================================================

function OnDataReceive(obj)
{
    if(obj.id == 'dso_AddiTiveMaster')
    {
        if(Insert=="T" || Delete=="T")
        {
            if(Insert=="T")
            {
                SetMasterPKToGrid(txtMasterPK.text);
                data_AddiTiveD.Call();
            }
            else
            {
                data_shpb00090.Call('SELECT');
                Delete="F";
            }
        }
        else
        {
            data_AddiTiveD.Call('SELECT');
            Insert="F";
        }   
    }
    if(obj.id == 'data_AddiTiveD')
    {
        TotalMixing_Ratio(); 
        
        if(Insert=="T")
        {
           data_shpb00090.Call('SELECT');
           Insert="F";
        }
    }
} 
function SetMasterPKToGrid(p_masterPK){
    for(var i=0;i<grdAddiTiveD.rows;i++){
        if(grdAddiTiveD.GetGridData(i,1) == ""){
            grdAddiTiveD.SetGridText(i,1,p_masterPK);
        }
    }
}
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
        right.style.width="80%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
   <gw:data id="data_shpb00090" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shpb00090">
                <input bind="grdSearch" >
                    <input bind="lstType" />
                    <input bind="lstTrOP" />
                    <input bind="txtTypeNo" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_AddiTiveMaster" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6" function="PROD.sp_sel_shpb00090_1" procedure="PROD.sp_upd_shpb00090_1">
            <inout> 
                <inout bind="txtMasterPK"/>
                <inout bind="lstTypeM"/>
                <inout bind="lstTrOPM"/>
                <inout bind="txtTypeNoM"/>   
                <inout bind="txtTypeNameM"/>
                <inout bind="txtDescription"/>
                <inout bind="chkConfirm_YN"/> 
                <inout bind="DtModifyDate"/>  
                <inout bind="txtModifyBy"/>
                <inout bind="DtCreateDate"/>
                <inout bind="txtCreateBy"/>   
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_AddiTiveD" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="PROD.sp_sel_shpb00090_2" procedure="PROD.sp_upd_shpb00090_2">
                <input bind="grdAddiTiveD" >
                    <input bind="txtMasterPK" />
                </input>
                <output bind="grdAddiTiveD" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 25%" align="left" id="left">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Type</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstType" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Tr/OP</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstTrOP" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Type No</td>
                        <td style="width: 89%">
                            <gw:textbox id="txtTypeNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Type No|Type Name|Tr/OP" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|2000|2000|1500" styles="width:100%;height:100%" autosize='T'
                                oncellclick="OnClickGridMaster()" param="0,1,2,3,4" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" align="right" id="right">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                    
                        <td style="width: 6%">
                            </td>
                        <td style="width: 19%; white-space: nowrap">
                           
                        </td>
                        <td style="width: 19%; white-space: nowrap" align="right">
                            </td>
                        <td style="width: 10%; white-space: nowrap">
                            
                        </td>
                        <td style="width: 14%">
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 3%" align="right">
                            <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Excel" onclick="OnPrint()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 6%">
                            Type</td>
                        <td style="width: 19%; white-space: nowrap">
                            <gw:list id="lstTypeM" styles="width: 100%" />
                        </td>
                        <td style="width: 6%">
                            Tr/OP</td>
                        <td style="width: 19%; white-space: nowrap">
                            <gw:list id="lstTrOPM" styles="width: 100%" />
                        </td>
                        <td style="width: 6%; white-space: nowrap" align="right">
                            Create Date</td>
                        <td style="width: 19%; white-space: nowrap" colspan="2">
                            <gw:datebox id="DtCreateDate" maxlen="10" nullaccept  styles='width:100%' lang="<%=Session("Lang")%>"/>
                        </td>
                        <td style="width: 6%; white-space: nowrap" align="right">
                            Create By</td>
                        <td style="width: 30%; white-space: nowrap" colspan="3">
                            <gw:textbox id="txtCreateBy" styles="width: 100%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 6%">
                            Type No</td>
                        <td style="width: 19%; white-space: nowrap">
                            <gw:textbox id="txtTypeNoM" styles="width: 100%" />
                        </td>
                        <td style="width: 6%">
                            Type.Name</td>
                        <td style="width: 19%; white-space: nowrap">
                            <gw:textbox id="txtTypeNameM" styles="width: 100%" />
                        </td>
                        <td style="width: 6%; white-space: nowrap" align="right">
                            Modify Date</td>
                        <td style="width: 19%; white-space: nowrap" colspan="2">
                            <gw:datebox id="DtModifyDate" maxlen="10" nullaccept  styles='width:100%' lang="<%=Session("Lang")%>"/>
                        </td>
                        <td style="width: 6%; white-space: nowrap" align="right">
                            Modify By</td>
                        <td style="width: 30%; white-space: nowrap" colspan="3">
                            <gw:textbox id="txtModifyBy" styles="width: 100%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td>Description</td>
                        <td colspan="6"><gw:textbox id="txtDescription" styles="width: 100%" /></td>
                        <td >Comfirm<gw:checkbox id="chkConfirm_YN" value="F" /></td>
                        <td colspan="2" align="right"><gw:imgbtn img="new" alt="New" onclick="OnNewD()" /></td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDeleteD()" />
                        </td>
                    </tr>
                    <tr style="height: 90%">
                        <td colspan="11">
                            <gw:grid id="grdAddiTiveD" header="_PK|_AddiTiveMaster_pk|_tco_itempk|Mat Code|Mat Name|Test No|Spec|Unit|Mixing Ratio(%)|_Remark|Ratio(%)KG"
                                format="0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|3|0|3" defaults="||||||||||" editcol="0|0|1|0|0|0|0|0|1|1|1"
                                widths="0|0|2000|1500|1500|1500|1500|1500|1500|1500" styles="width:100%;height:100%" autosize='T' onafteredit="OnEditGrid()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan="3" align="right">Total Mixing Ratio(%)</td>
                        <td colspan="2"><gw:textbox id="txtMixingRatio" text="0" type="number" format="###,###.###" styles="width: 100%" /></td>
                        <td colspan="2" align="right">Ratio(%)KG</td>
                        <td colspan="3"><gw:textbox id="txtRatioKG" text="0" type="number" format="###,###.###" styles="width: 100%" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
