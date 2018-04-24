<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Test No Registration</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_id	= "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;

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
var _save = true;

function Calulate(){
    _save = false;
    OnSave();
}
function canClose(){
    
    if( _save == true){
        return true;
    }
    
    if(confirm("Your data have not saved yet. Do you want to save?")){
        return true;
    }
    else{
        //call to delete
        dso_shbo00070.StatusDelete();
        dso_shbo00070.Call();
        Delete = 'T';
        return true;
    }
}
function BodyInit()
{
    txtIssue_PK.text= "<%=Session("EMPLOYEE_PK")%>"; 
    txtIssueByCode.text = user_id
    txtIssueByName.text = user_name
    left.style.display="none";
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
    OnToggle();
    //SetEnableControl();
    lstMachineNo.SetEnable(false);
    DtIssueDate.SetEnable(false);
    BindingDataList();
    OnSearch();
    OnNew();
    //------------------
    /*txtTypeNoM.SetEnable(false);
    txtMixingRatio.SetEnable(false);
    txtRatioKg.SetEnable(false);  
	
	dso_AddiTiveMaster.StatusInsert();*/
	//OnSearch();		
}
var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
//===============================================================
function SetEnableControl()
{
        //txtMasterPK.SetEnable(false);       
        //DtInsDate.SetEnable(false);
        lstMachineNo.SetEnable(false);
        txtLotNo.SetEnable(false); 
        //txtEstQty.SetEnable(false);
        //lstBlendingNo.SetEnable(false);
        //lstAdditiveNo.SetEnable(false);
        //txtColorantPack.SetEnable(false);     
        //txtColorantPackBody.SetEnable(false);
        //rdoSTATUS.SetEnable(false);
        txtProductCode.SetEnable(false);
        txtProductName.SetEnable(false);         
        txtCustomerCode.SetEnable(false);  
        txtCustomerName.SetEnable(false);
        txtSizeCode.SetEnable(false);
        txtSizeName.SetEnable(false);
        txtColorCode_Cap.SetEnable(false);  
        txtColorName_Cap.SetEnable(false);
        txtColorCode_Body.SetEnable(false);
        txtColorName_Body.SetEnable(false);  
        txtBlendingNo.SetEnable(false);           
        txtLicenseNo.SetEnable(false);
        txtIssueNo.SetEnable(false);
        DtIssueDate.SetEnable(false);
        txtIssueByCode.SetEnable(false);   
        txtIssueByName.SetEnable(false);
        txtProdQty.SetEnable(false);
        txtTotalGenlatin.SetEnable(false); 
        txtTrim.SetEnable(false); 
        txtQtyKg1.SetEnable(false);
        txtQtyKg2.SetEnable(false);
        txtSum1.SetEnable(false);   
        txtSum2.SetEnable(false);   
        txtGenlatinKg3.SetEnable(false);   
        txtAdditive.SetEnable(false);
        txtB1.SetEnable(false);
        txtB2.SetEnable(false);   
        txtSum3.SetEnable(false);
        txtSum4.SetEnable(false);
        txtColorrantPackC.SetEnable(false);
        txtColorrantC.SetEnable(false);            
        txtColorrantPackB.SetEnable(false);
        txtColorrantB.SetEnable(false);
        txtSum6.SetEnable(false);
        txtSum7.SetEnable(false);
        txtC.SetEnable(false);
        txtB3.SetEnable(false);  
        txtSum8.SetEnable(false);
        txtPreCap.SetEnable(false);
        txtPreBody.SetEnable(false); 
        txtInvenCap.SetEnable(false);
        txtInvenBody.SetEnable(false);  
}
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>|ALL|Select All"; 
    data1 = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>||";
        lstMachineNoM.SetDataText(data);   
        lstMachineNo.SetDataText(data1);
        lstMachineNoM.value='ALL';
        lstMachineNo.value="";
        
    /*var datalstBlendingType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0030') FROM DUAL" )%>";
        lstBlendingNo.SetDataText(datalstBlendingType); 
    var datalstAdditiveType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code3('LGMF0030') FROM DUAL" )%>";
        lstAdditiveNo.SetDataText(datalstAdditiveType); */
        
        data = "<%=ESysLib.SetListDataSQL("select type_no, type_no ||'-'||blend_no from tsh_mixtype where type_code in ('20','21') and del_if=0 order by type_no")%>||";
        lstBlendingNo.SetDataText(data); 
        data = "<%=ESysLib.SetListDataSQL("select type_no, type_no ||'-'||type_desc from tsh_mixtype where type_code in ('10') and del_if=0 order by type_no")%>||";
        lstAdditiveNo.SetDataText(data); 
        lstBlendingNo.value="";
        lstAdditiveNo.value="";
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE||' - '||a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0020' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>||Select All"
        lstSizeNo.SetDataText(data);
        lstSizeNo.value="";
}
//===============================================================

function OnSearch()
{  
   data_shbo00070_main_list.Call('SELECT');
   Insert   = 'F';
}
//---------------------------------------------------------------------------------------------
var object1
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'AddnewLotNo':

                var fpath = System.RootURL + "/form/sh/bo/shbo00071.aspx?";
                object1 = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');
                if(object1 != null)
                {
                    txtLotNo.text = object1[1];
                    pro_shbo00070_3.Call();
                } 

        break;
        case 'PopupAdditive':
            var fpath = System.RootURL + "/form/sh/bo/shbo00072_add.aspx?p_main_m_pk="+txtMasterPK.text;
            var object = System.OpenModal( fpath , 550 , 350 , 'resizable:yes;status:yes'); 
        break;
        case 'PopupColorant':
            var fpath = System.RootURL + "/form/sh/bo/shbo00073_col.aspx?p_main_m_pk="+txtMasterPK.text;
            var object = System.OpenModal( fpath , 550 , 350 , 'resizable:yes;status:yes'); 
        break;
        case 'PopupColorantPack':
             var fpath = System.RootURL + "/form/sh/bo/shbo00074_clrpack.aspx?p_main_m_pk="+txtMasterPK.text;
            var object = System.OpenModal( fpath , 700 , 350 , 'resizable:yes;status:yes'); 
        break;
        case'Issue':
            var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                txtIssueByName.text=object[5];
                txtIssueByCode.text=object[3];
                txtIssue_PK.text=object[0]
            }
        break;
    }
}
function OnDelete()
{
   if(confirm('Do you want to delete ?'))
            {
                dso_shbo00070.StatusDelete();
                dso_shbo00070.Call();
                Delete = 'T';
            }
}
//===============================================================
function OnNew()
{
    if(dso_shbo00070.GetStatus()!=20)
    {
        dso_shbo00070.StatusInsert();
        lstBlendingNo.value="";
        lstAdditiveNo.value="";
        lstMachineNo.value="";
        
        txtIssueByName.text = user_name;
	    txtIssueByCode.text = user_id;
	    txtIssue_PK.text = user_pk;	
    }
    else
    {
        alert("Already in inserted status");
    }
}
function OnSave()
{
      if(lstBlendingNo.value =="" ||lstAdditiveNo.value =="" || txtLotNo.text=="")
      {
          if(txtLotNo.text=="")
          {
            alert("Please Select Lot No.");
            return false;
          }
          else if(lstBlendingNo.value =="")
          {
            alert("Please Select Blending type No.");
            return false;
          }
          else(lstAdditiveNo.value =="")
          {
            alert("Please Select Additive Type No.");
            return false;
          }
          return true;
      }
      else
      {
          dso_shbo00070.Call();
          Insert   = 'T';
      }
}

//===============================================================

function OnClickGridMaster()
{
    if (grdSearch.row > 0)
    {   
        txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
        //alert(txtMasterPK.text); 
        dso_shbo00070.Call('SELECT');
    }
}
function OnDataReceive(obj)
{
    if(obj.id=='dso_shbo00070')
    {
        if(Insert == 'T' || Delete == 'T')
        {
            if(Insert == 'T')
            {
                data_shbo00070_main_list.Call('SELECT');
                Insert = 'F';
            }
            else
            {
                data_shbo00070_main_list.Call('SELECT');
                Delete = 'F';
                lstBlendingNo.value="";
                lstAdditiveNo.value="";
                lstMachineNo.value="";
            }
        }
    }
    if(obj.id=='pro_shbo00070_3')
    {
            
            if(txtMasterPK.text=="")
            {
                    
                    if(dso_shbo00070.GetStatus()!=20)
                    {
                        OnNew();
                    }
                    txtBatLotM_PK.text = object1[0];
                    txtLotNo.text = object1[1];
                    txtProductCode.text = object1[2];
                    txtProductName.text = object1[3];
                    txtCustomerCode.text = object1[15];
                    txtCustomerName.text = object1[16];
                    txtSizeCode.text = object1[8];
                    txtSizeName.text = object1[9];
                    txtColorCode_Cap.text = object1[10];
                    txtColorName_Cap.text = object1[11];
                    txtColorCode_Body.text = object1[12];
                    txtColorName_Body.text = object1[13];
                    txtBlendingNo.text = object1[14];
                    lstMachineNo.value=object1[4];
                    txtEstQty.text=object1[6];
            }
            else
            {
                alert("This Lot created!!!");
                dso_shbo00070.Call("SELECT");
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
        right.style.width="50%";
        right2.style.width="50%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        //right.style.width="80%";
        right.style.width="34%";
        right2.style.width="34%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function OnPrint()
 {
        if(txtLotNo.text!="")
        {
            var fpath = System.RootURL + "/form/sh/bo/shbo00200.aspx?p_lotno="+txtLotNo.text+ "&p_dtfrom="+DtInsDate.value+"&p_dtTo="+ dtTo.value; 
            var object = System.OpenModal( fpath , 650 , 535 , 'resizable:yes;status:yes'); 
            
//            if(object[0] == "1"){
//                   txtnmjjjkk
//                shbo00200_afterreport.Call();
//            }
//            if(object == "2"){
//                shbo00200_afterreport.Call();
//            }
        }
        else
        {
            alert("Please Select Lotno to print Label");
        }
 }
 function OnPopUpSize()
 {
    var fpath = System.RootURL + "/form/sh/bo/shbo00071.aspx?";
                var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {//0 _PK|1 Lot No|2 Item Code|3 Item Name|4 Hoki|5 Porder Date|6 Porder Qty|7 Target Qty|8 Sise Code|9 Sise Name|
                //10 Cap Color Code|11 Cap Color Name|12 Body Color Code|13 Body Color Name|14 Blend No|15 Partner ID|16 Partner Name"
                    //alert(object[0]); 
                    txtSizeCodeS.text = object[8];
                    txtSizeNameS.text = object[9];
                    txtSizePK.text = object[17];
                    //alert(txtSizePK.text);
                }
 }
 function Reset_Upper()
 {
    txtSizeCodeS.text = "";
    txtSizeNameS.text = "";
    txtSizePK.text = "";
 }
//===============================================================
</script>
<body>
<!--<gw:data id="shbo00200_afterreport" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="process" procedure="PROD.sp_upd_shbo00200_afterreport"> 
                <input > 
                    <input bind="txtLotNo" />
                    <input bind="DtIssue" />
                    <input bind="txtIssue_PK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
</gw:data>-->

    <!--------------------------------------------------------------------------------------->
   <gw:data id="data_shbo00070_main_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00070_main_list">
                <input bind="grdSearch" >
                    <input bind="lstMachineNoM" />
                    <input bind="txtTypeNoSearch" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" /> 
                    <input bind="lstSizeNo" />
                    <input bind="txtLicenseNoSearch" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_shbo00070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53" function="PROD.sp_sel_shbo00070" procedure="PROD.sp_upd_shbo00070">
            <inout> 
                <inout bind="txtMasterPK"/>    
                <inout bind="txtBatLotM_PK"/>   
                <inout bind="DtInsDate"/>
                <inout bind="lstMachineNo"/>
                <inout bind="txtLotNo"/>   
                <inout bind="txtEstQty"/>
                <inout bind="lstBlendingNo"/>
                <inout bind="lstAdditiveNo"/> 
                <inout bind="txtColorantPack"/>     
                <inout bind="txtColorantPackBody"/>
                <inout bind="rdoSTATUS"/>
                <inout bind="txtProductCode"/>
                <inout bind="txtProductName"/>         
                <inout bind="txtCustomerCode"/>   
                <inout bind="txtCustomerName"/>
                <inout bind="txtSizeCode"/>
                <inout bind="txtSizeName"/> 
                <inout bind="txtColorCode_Cap"/>  
                <inout bind="txtColorName_Cap"/>
                <inout bind="txtColorCode_Body"/>
                <inout bind="txtColorName_Body"/>   
                <inout bind="txtBlendingNo"/>           
                <inout bind="txtLicenseNo"/>
                <inout bind="txtIssueNo"/>
                <inout bind="DtIssueDate"/>
                <inout bind="txtIssueByCode"/>   
                <inout bind="txtIssueByName"/>
                <inout bind="txtProdQty"/>
                <inout bind="txtTotalGenlatin"/> 
                <inout bind="txtTrim"/>  
                <inout bind="txtQtyKg1"/>
                <inout bind="txtQtyKg2"/>
                <inout bind="txtSum1"/>   
                <inout bind="txtSum2"/>    
                <inout bind="txtGenlatinKg3"/>    
                <inout bind="txtAdditive"/>
                <inout bind="txtB1"/>
                <inout bind="txtB2"/>   
                <inout bind="txtSum3"/>
                <inout bind="txtSum4"/>
                <inout bind="txtColorrantPackC"/> 
                <inout bind="txtColorrantC"/>            
                <inout bind="txtColorrantPackB"/>
                <inout bind="txtColorrantB"/>
                <inout bind="txtSum6"/> 
                <inout bind="txtSum7"/>
                <inout bind="txtC"/>
                <inout bind="txtB3"/>  
                <inout bind="txtSum8"/>
                <inout bind="txtPreCap"/>
                <inout bind="txtPreBody"/>  
                <inout bind="txtInvenCap"/>
                <inout bind="txtInvenBody"/>
                <inout bind="txtIssue_PK"/> 
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
   <!-- <gw:data id="data_AddiTiveD" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="PROD.sp_sel_shpb00090_2" procedure="PROD.sp_upd_shpb00090_2">
                <input bind="grdAddiTiveD" >
                    <input bind="txtMasterPK" />
                </input>
                <output bind="grdAddiTiveD" />
            </dso>
        </xml>
    </gw:data>-->
    <!------------------------------------------------------------------>
    <gw:data id="pro_shbo00070_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00070_3" > 
                <input>
                    <input bind="txtLotNo" />                     
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 36%" align="left" id="left">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Date</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:datebox id="dtFrom"  maxlen="10"   styles='width:45%' onchange="OnSearch()"  lang="<%=Session("Lang")%>"/>~<gw:datebox id="dtTo" maxlen="10"   styles='width:45%' onchange="OnSearch()" lang="<%=Session("Lang")%>"/>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            License No</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:textbox id="txtLicenseNoSearch" styles="width: 90%" onenterkey="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Machine No</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstMachineNoM" styles="width: 90%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Size</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstSizeNo" styles="width: 90%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Lot No</td>
                        <td style="width: 89%" align="right">
                            <gw:textbox id="txtTypeNoSearch" styles="width: 89%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Lot No|_Hoki|Inst Date|_Inst Qty|Issue No" format="0|0|0|4|0|0" aligns="0|0|0|0|0|0"
                                defaults="|||||" editcol="0|0|0|0|0|0" widths="0|2000|2000|1500|1000|1000" styles="width:100%;height:100%" autosize='T'
                                oncellclick="OnClickGridMaster()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 32%" align="right" id="right">
              <!---td2--> 
              <table style="height: 100%; width: 100%">
                <tr style="height: 5%">
                    <td style="width: 40%">Instructed Date</td>
                    <td style="width: 60%"><gw:datebox id="DtInsDate" maxlen="10" styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Machine No</td>
                    <td><gw:list id="lstMachineNo" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                   <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('AddnewLotNo')"/>Lot No</td>
                    <td><gw:textbox id="txtLotNo" styles="width: 100%" csstype="mandatory" readonly="true" /></td>
                </tr>
                <tr style="height: 5%";>
                    <td>Estimated Qty(pcs)</td>
                    <td><gw:textbox id="txtEstQty" text="0" type="number" format="###,###,###,###" styles="width: 100%" csstype="mandatory" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Blending Type No</td>
                    <td><gw:list id="lstBlendingNo" styles="width: 100%" csstype="mandatory"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Additive Type No</td>
                    <td><gw:list id="lstAdditiveNo" styles="width: 100%" csstype="mandatory"/></td>
                </tr>
                <tr style="height: 5%">
                    <td>Colorant Pack Batch No(Cap)</td>
                    <td><gw:textbox id="txtColorantPack" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Colorant Pack Batch No(Body)</td>
                    <td><gw:textbox id="txtColorantPackBody" styles="width: 100%" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Trimming</td>
                    <td><gw:radio id="rdoSTATUS" value="2" styles='height:22'>
                                    <span value="Y">Yes</span>
                                    <span value="N">No</span>
                                    </gw:radio ></td>
                </tr>
                <tr style="height: 5%">
                    <td>Product Code</td>
                    <td><gw:textbox id="txtProductCode" styles="width: 35%" readonly="true" /><gw:textbox id="txtProductName" styles="width: 65%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Customer Code</td>
                    <td><gw:textbox id="txtCustomerCode" styles="width: 35%" readonly="true" /><gw:textbox id="txtCustomerName" styles="width: 65%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%"> 
                    <td>Size</td>
                    <td><gw:textbox id="txtSizeCode" styles="width: 35%" readonly="true" /><gw:textbox id="txtSizeName" styles="width: 65%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(Cap)</td>
                    <td><gw:textbox id="txtColorCode_Cap" styles="width: 35%" readonly="true" /><gw:textbox id="txtColorName_Cap" styles="width: 65%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Color Code(Body)</td>
                    <td><gw:textbox id="txtColorCode_Body" styles="width: 35%" readonly="true" /><gw:textbox id="txtColorName_Body" styles="width: 65%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Blending No</td>
                    <td><gw:textbox id="txtBlendingNo" styles="width: 100%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>License No</td>
                    <td><gw:textbox id="txtLicenseNo" styles="width: 100%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue No</td>
                    <td><gw:textbox id="txtIssueNo" styles="width: 100%" readonly="true" /></td>
                </tr>
                <tr style="height: 5%">
                    <td>Issue Date</td>
                    <td><gw:datebox id="DtIssueDate" maxlen="10"   styles='width:100%' nullaccept lang="<%=Session("Lang")%>"/></td>
                </tr>
                <tr style="height: 15%">
                    <td><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Issue')">Issue By</b></td>
                    <td>
                    <gw:textbox id="txtIssueByCode" styles="width: 35%" />
                    <gw:textbox id="txtIssueByName" styles="width: 65%" />
                    </td>
                </tr>
              </table> 
            </td>
            <td style="width: 32%" align="right" id="right2">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%" valign="top">
                            <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 90%" align="right">
                                        <gw:icon id="btnCal" img="3" text="Calculate" onclick="Calulate()" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
                                    </td>
                                    <td style="width:3%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnPrint()" styles='width:100%'/></td>
                                </tr>
                            </table>
                            </td>
                    </tr>
                    <tr style="height: 48%" valign="top">
                    <td style="width: 100%">
                    <fieldset>
                    <table style="height: 100%; width: 100%">
                    <tr style="height: 6%" valign="top">
                        <td style="width: 100%">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 6%" valign="top">
                                    <td style="width: 25%">Prod.Qty/Kg</td> 
                                    <td  style="width: 25%" align="right"><gw:textbox id="txtProdQty" styles="width: 90%" text="0" type="number" format="###,###,###" readonly="true" csstype="mandatory" /></td>
                                    <td style="width: 25%"></td>
                                    <td style="width: 25%"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 18%" valign="top">
                    <td style="width: 100%">
                    <fieldset>
                    <table style="height: 100%; width: 100%">
                     <tr style="height: 6%" valign="top">
                        <td style="width: 25%">Total Gelatin </td>
                        <td style="width: 25%"><gw:label id="lblPinType5" text="C" styles="width: 10%;" /><gw:textbox id="txtTotalGenlatin" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true" /></td>
                        <td style="width: 25%">Trim</td>
                        <td style="width: 25%"><gw:label id="lblPinType6" text="C" styles="width: 10%;" /><gw:textbox id="txtTrim" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%" valign="top">
                        <td style="width: 25%">Qty(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType7" text="B" styles="width: 10%;" /><gw:textbox id="txtQtyKg1" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%">Qty(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType8" text="B" styles="width: 10%;" /><gw:textbox id="txtQtyKg2" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%";>
                        <td style="width: 25%; color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum1" styles="width: 90%;" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25% ; color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum2" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    </table>
                    </fieldset>
                    </td>
                    </tr>
                   <tr style="height: 18%" valign="top">
                    <td style="width: 100%">
                    <fieldset>
                    <table style="height: 100%; width: 100%">
                     <tr style="height: 6%";>
                        <td style="width: 25%">Genlatin(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType3" text="C" styles="width: 10%;" /><gw:textbox id="txtGenlatinKg3" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%">Additive(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType4" text="C" styles="width: 10%;" /><gw:textbox id="txtAdditive" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%";>
                        <td style="width: 25%"></td>
                        <td style="width: 25%"><gw:label id="lblPinType" text="B" styles="width: 10%;" /><gw:textbox id="txtB1" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%"><gw:icon id="idBtnProcess_M" styles="width: 70%;" img="in" text="Details" onclick="OnPopUp('PopupAdditive')" /></td>
                        <td style="width: 25%"><gw:label id="lblPinType1" text="B" styles="width: 10%;" /><gw:textbox id="txtB2" styles="width: 90%;" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%";>
                        <td style="width: 25%; color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum3" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%;color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum4" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    </table>
                    </td>
                    </tr>
                     <tr style="height: 18%" valign="top">
                    <td style="width: 100%">
                    <fieldset>
                    <table style="height: 100%; width: 100%">
                     <tr style="height: 6%";>
                        <td style="width: 25%">Colorant Pack(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType9" text="C" styles="width: 10%;" /><gw:textbox id="txtColorrantPackC" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%">Colorants(Kg)</td>
                        <td style="width: 25%"><gw:label id="lblPinType10" text="C" styles="width: 10%;" /><gw:textbox id="txtColorrantC" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%";>
                        <td style="width: 25%"><gw:icon id="idBtnProcess_M2" styles="width: 70%;" img="in" text="Details" onclick="OnPopUp('PopupColorantPack')" /></td>
                        <td style="width: 25%"><gw:label id="lblPinType11" text="B" styles="width: 10%;" /><gw:textbox id="txtColorrantPackB" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25%" align="center"><gw:icon id="idBtnProcess_M1" styles="width: 70%;" img="in" text="Details" onclick="OnPopUp('PopupColorant')" /></td>
                        <td style="width: 25%"><gw:label id="lblPinType12" text="B" styles="width: 10%;" /><gw:textbox id="txtColorrantB" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    <tr style="height: 5%";>
                        <td style="width: 25% ;color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum6" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                        <td style="width: 25% ;color:Gray" align="right">Sum</td>
                        <td style="width: 25%" align="right"><gw:textbox id="txtSum7" styles="width: 90%" text="0" type="number" format="###,###.##0" readonly="true"/></td>
                    </tr>
                    </table>
                    </fieldset>
                    </td>
                    </tr>
                    </table>
                    </fieldset>
                    </td>
                </tr>
                    
                <tr style="height: 25%" valign="top">
                    <td colspan="4">
                    <fieldset>
                        <table style="height: 100%; width: 100%">
                            <tr style="height: 100%"; valign="top">
                                <td style="width: 50%; color:Blue" colspan="3" rowspan="3" align="right" valign="middle">Total</td>
                        <td style="width: 50%">
                            <table style="height: 100%; width: 100%">
                            <tr style="height: 100%";>
                                <td style="width: 100%">
                                <fieldset>
                                    <table style="height: 100%; width: 100%">
                                        <tr  style="height: 35%";>
                                            <td style="width: 30%">C</td>
                                            <td style="width: 70%"><gw:textbox id="txtC" styles="width: 100%" text="0" type="number" format="###,###.#####0" readonly="true" csstype="mandatory"/></td>
                                        </tr>
                                        <tr style="height: 35%";>
                                            <td style="width: 30%">B</td>
                                            <td style="width: 70%"><gw:textbox id="txtB3" styles="width: 100%" text="0" type="number" format="###,###.#####0" readonly="true" csstype="mandatory"/></td>
                                        </tr>
                                        <tr style="height: 30%"; valign="top">
                                            <td style="width: 30%;color:Gray">Sum</td>
                                            <td style="width: 70%"><gw:textbox id="txtSum8" styles="width: 100%" text="0" type="number" format="###,###.#####0" readonly="true" csstype="mandatory"/></td>
                                        </tr>
                                    </table>
                                    </fieldset>
                                </td>
                            </tr>
                            </table>
                        </td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>    
                    </tr>
                    <tr style="height: 25%" valign="top">
                    <td style="width: 100%">
                    <fieldset>
                    <table style="height: 100%; width: 100%">
                    <tr style="height: 7%";>
                        <td style="width: 15%"></td>
                        <td style="width: 35%" align="center">Cap</td>
                        <td style="width: 15%"></td>
                        <td style="width: 35%" align="center">Body</td>
                    </tr>
                     <tr style="height: 7%";>
                        <td style="width: 15%">Present.Trim.Batch No</td>
                        <td style="width: 35%"><gw:textbox id="txtPreCap" styles="width: 100%" /></td>
                        <td style="width: 15%"></td>
                        <td style="width: 35%"><gw:textbox id="txtPreBody" styles="width: 100%" /></td>
                    </tr>
                     <tr style="height: 7%"; valign="top">
                        <td style="width: 15%">Inventory.Trim.Batch No</td>
                        <td style="width: 35%"><gw:textbox id="txtInvenCap" styles="width: 100%" /></td>
                        <td style="width: 15%"></td>
                        <td style="width: 35%"><gw:textbox id="txtInvenBody" styles="width: 100%" /></td>
                    </tr>  
                    </table>
                    </fieldset>
                    </td>
                    </tr>
                   
                </table>
            <!---td3-->
            </td>
        </tr>
    </table>
    <gw:textbox id="txtSizePK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
    <gw:textbox id="txtIssue_PK" style="display: none" />
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtBatLotM_PK" style="display: none" />
    <gw:textbox id="txtPartner_PK" style="display: none" />
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
