<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vina Genuwin</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script language="javascript">
var flagcall = false;
function BodyInit()
{
	OnInitForm();
	dso_shpr00050.StatusInsert();
	rdoCompletion.value = 'N';
	rdoProduct_Type.value = 'Y';
}
//======================================================================
function OnInitForm(){
    rdoCompletion.SetEnable(false);
    txtHoki.SetEnable(false);
	txtInst_Date.SetEnable(false);
	txtLotno.SetEnable(false);
	txtMatno.SetEnable(false);
	txtProd_Name.SetEnable(false);
	txtVendno.SetEnable(false);
	txtVend_Nm.SetEnable(false);
	txtSizea.SetEnable(false);
	txtSize_Nm.SetEnable(false);
	txtCap_Code.SetEnable(false);
	txtCap_Colnm.SetEnable(false);
	txtBody_Code.SetEnable(false);
	txtBody_Colnm.SetEnable(false);
	txtWon_Usedqty.SetEnable(false);
	txtDip_Wgt.SetEnable(false);
	txtDip_Yield.SetEnable(false);
	txtPack_Wgt.SetEnable(false);
	txtLoss_Qty.SetEnable(false);
	txtDiscard_Qty.SetEnable(false);
	txtTotal_Loss.SetEnable(false);
	txtPass_Ratio.SetEnable(false);
	txtProd_Ratio.SetEnable(false);
}
//======================================================================
function OnInitData(){
    txtMasterPk.text=grdSearch.GetGridData(grdSearch.row,0);
    dso_shpr00050.Call('SELECT')
}
//======================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    	left.style.display="none";
    	imgArrow.status = "collapse";
		left.style.width="0%";
    	right.style.width="100%";
    	imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    	left.style.display="";
    	imgArrow.status = "expand";
		left.style.width="20%";
   		right.style.width="80%";
    	imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//======================================================================
function OnClick(obj){
    switch(obj)
    {
        case "btnCall":
            if(txtLotno.GetData() == ''){alert("Please choose Lot No.!");return false;}
            if(rdoProduct_Type.GetData() == 'N'){alert("This is BOX Product,  Dip. Data call not be able to use.");return false;}
            dat_Call.Call();
        break;
        case "ibtnUpdate":
            //alert(txtMasterPk.GetData());
             if(Number(txtProd_Qty.text) > 0 && Number(txtDip_Qty.text) > 0)
            {
                if (Number(txtCount_Qty.text) == 0 && Number(txtAct_Qty.text)== 0)
                {
                    alert("Please Input Count Q'ty and Package Q'ty!");
                } else
                {           
                    dso_shpr00050.Call();
                }
            }else{
                alert("Please press Call Dip. Data button!");
            }
            
           
        break;
        case "ibtnInsert":
            flagcall = false;
            if(dso_shpr00050.GetStatus()!=20)
            {
                dso_shpr00050.StatusInsert();
            }
            rdoProduct_Type.value = 'Y';
            rdoCompletion.value = 'N';
            txtMasterPk.SetDataText('');
            txtTsh_batlot_m_pk.SetDataText('');
            txtHoki.SetDataText('');
            txtLotno.SetDataText('');
            txtInst_Date.SetDataText('');
            txtMatno.SetDataText('');
            txtProd_Name.SetDataText('');
            txtVendno.SetDataText('');
            txtVend_Nm.SetDataText('');
            txtSizea.SetDataText('');
            txtSize_Nm.SetDataText('');
            txtCap_Code.SetDataText('');
            txtCap_Colnm.SetDataText('');
            txtBody_Code.SetDataText('');
            txtBody_Colnm.SetDataText('');
            txtProd_Qty.SetDataText('0');
            txtDip_Qty.SetDataText('0');
            txtDip_Wgt.SetDataText('0');
            txtCount_Qty.SetDataText('0');
            txtPack_Wgt.SetDataText('0');
            txtDiscard_Qty.SetDataText('0');
            txtPass_Ratio.SetDataText('0');
            txtWon_Usedqty.SetDataText('0');
            txtCapsule_Wgt.SetDataText('0');
            txtDip_Yield.SetDataText('0');
            txtAct_Qty.SetDataText('0');
            txtLoss_Qty.SetDataText('0');
            txtTotal_Loss.SetDataText('0');
            txtProd_Ratio.SetDataText('0');
        break;
        case "ibtnDelete":
            if(txtMasterPk.GetData() != ''){
                if(confirm('Do you want to delete ?'))
	            {
		            dso_shpr00050.StatusDelete();
		            dso_shpr00050.Call();
		            OnClick('ibtnInsert');
	            }
	        } else alert("No data for delete!");
        break;
    }
}
//======================================================================
function OnPopUp(obj)
{
    switch(obj)
    {
        case "Lot No":
            var fpath = System.RootURL + "/form/sh/pr/shpr00050_popup_1.aspx?";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
               if(txtTsh_batlot_m_pk.text != object[0]) 
               {
                 OnClick('ibtnInsert');
               }
                
               txtTsh_batlot_m_pk.SetDataText(object[0]);
               txtLotno.SetDataText(object[1]);
               txtInst_Date.SetDataText(object[2]);
               txtProd_Qty.SetDataText(object[3]);
               txtMatno.SetDataText(object[5]);
               txtProd_Name.SetDataText(object[6]);
               txtVendno.SetDataText(object[8]);
               txtVend_Nm.SetDataText(object[9]);
               txtSizea.SetDataText(object[10]);
               txtSize_Nm.SetDataText(object[11]);
               txtCap_Code.SetDataText(object[12]);
               txtCap_Colnm.SetDataText(object[13]);
               txtBody_Code.SetDataText(object[14]);
               txtBody_Colnm.SetDataText(object[15]);
               txtHoki.SetDataText(object[17]);
               txtVGGU.SetDataText(object[18]);            
               
            }
        break;
    }
}
//======================================================================
function OnSearch(){
    dso_shpr00050_search.Call('SELECT');
}
//======================================================================
function OnInputData()
{
    if(Number(txtCount_Qty.text)<0)
    {
        txtCount_Qty.text = 0
    }
     if(Number(txtAct_Qty.text)<0)
    {
        txtAct_Qty.text = 0
    }
    txtLoss_Qty.text = Number(txtDip_Qty.text) - Number(txtCount_Qty.text)
    txtDiscard_Qty.text = Number(txtCount_Qty.text) - Number(txtAct_Qty.text)
    txtTotal_Loss.text = Number(txtLoss_Qty.text) + Number(txtDiscard_Qty.text)
    txtPack_Wgt.text = Number(txtAct_Qty.text) * Number(txtCapsule_Wgt.text)/1000000
     var temp = ""
    if(Number(txtDip_Qty.text)>0)
    {    
    
        temp =  Number(txtAct_Qty.text)/Number(txtDip_Qty.text)*100
        txtPass_Ratio.text = temp.toFixed(2)        
    }
    temp = Number(txtPack_Wgt.text)/Number(txtWon_Usedqty.text)*100 
    txtProd_Ratio.text = temp.toFixed(2)
}
//======================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dat_Call":
            flagcall = true;
            OnInputData()
            alert("Call Dip. Data finish!");
        break;
        case "dso_shpr00050":
            flagcall = false;
        break;
    }
}

</script>

<body class="bodyscrollbar">
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dat_Call" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="prod.sp_pro_shpr00050_call" > 
            <input>
                <input bind="rdoProduct_Type" />
                <input bind="txtLotno" />
                <input bind="txtTsh_batlot_m_pk" />
                <input bind="txtSizea" />
                <input bind="txtCount_Qty" />
                <input bind="txtAct_Qty" />
                <inout bind="txtMasterPk"/>
            </input>
            <output>
                <output bind="txtWon_Usedqty" />
                <output bind="txtDip_Qty" />
                <output bind="txtDip_Wgt" />
                <output bind="txtCapsule_Wgt" />
                <output bind="txtDip_Yield" />
                <output bind="txtPack_Wgt" />
                <output bind="txtLoss_Qty" />
                <output bind="txtDiscard_Qty" />
                <output bind="txtTotal_Loss" />
                <output bind="txtPass_Ratio" />
                <output bind="txtProd_Ratio" />
            </output>
        </dso> 
    </xml> 
</gw:data>
    <!--------------------------------------------------------------------------------------->

    <gw:data id="dso_shpr00050" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="PROD.sp_sel_shpr00050" procedure="PROD.sp_upd_shpr00050">
        <inout> 
            <inout bind="txtMasterPk"/>
            <inout bind="rdoProduct_Type"/>
			<inout bind="txtLotno"/>
			<inout bind="txtProd_Qty"/>
			<inout bind="txtWon_Usedqty"/>
			<inout bind="txtDip_Qty"/>
			<inout bind="txtCapsule_Wgt"/>
			<inout bind="txtDip_Wgt"/>
			<inout bind="txtDip_Yield"/>
			<inout bind="txtCount_Qty"/>
			<inout bind="txtAct_Qty"/>
			<inout bind="txtPack_Wgt"/>
			<inout bind="txtLoss_Qty"/>
			<inout bind="txtDiscard_Qty"/>			
			<inout bind="txtPass_Ratio"/>
			<inout bind="txtProd_Ratio"/>
			<inout bind="txtTsh_batlot_m_pk"/>
			<inout bind="rdoCompletion"/>
			<inout bind="txtTotal_Loss"/>
			
			<inout bind="txtInst_Date"/>
			<inout bind="txtMatno"/>
			<inout bind="txtProd_Name"/>
			<inout bind="txtVendno"/>
			<inout bind="txtVend_Nm"/>
			<inout bind="txtSizea"/>
			<inout bind="txtSize_Nm"/>
			<inout bind="txtCap_Code"/>
			<inout bind="txtCap_Colnm"/>
			<inout bind="txtBody_Code"/>
			<inout bind="txtBody_Colnm"/>
			<inout bind="txtHoki"/>
        </inout>
        </dso> 
    </xml> 
</gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="dso_shpr00050_search"> 
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpr00050_search"> 
            <input> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" />
                <input bind="txtLotNoSearch" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>
    <!--------------------------------------------------------------------------------------->
    <table border="0" style="width: 100%; height: 100%; background-color: #CCCCCC" cellpadding="3"
        cellspacing="1">
        <tr style="height: 100%">
            <td style="width: 20%" style="background: #f7f8fc; padding: 2px" id="left">
                <table border="0" style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td width="100%" style="background-color: #f7f8fc" valign="top">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="35%" align="right" style="padding-left: 20px">
                                       Inst Date</td>
                                    <td width="65%">
                                        <table style="width: 100%">
                                            <tr width="100%">
                                                <td>
                                                    <gw:datebox id="dtFromDate" type="date" lang="1" />
                                                </td>
                                                <td align="center">
                                                    ~</td>
                                                <td>
                                                    <gw:datebox id="dtToDate" type="date" lang="1" />
                                                </td>
                                                <td>
                                                    <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch();" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Lot No.</td>
                                    <td style="padding-right: 2px">
                                        <gw:textbox id="txtLotNoSearch" styles='width:100%' onenterkey="OnSearch();" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td style="padding-top: 4px">
                            <gw:grid id="grdSearch" styles="width:100%; height:100%" sorting="T" oncellclick="OnInitData()"
                                header="_pk|Date|Machine No.|Lot No." format="0|4|0|0" aligns="0|0|0|0" defaults="|||"
                                editcol="0|0|0|0" widths="0|1100|1100|1900" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 80%" style="background: #f7f8fc; padding: 5px" id="right" valign="top">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 100%">
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnInsert" img="new" alt="new" onclick="OnClick('ibtnInsert')" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="delete" onclick="OnClick('ibtnDelete')" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnUpdate" img="save" alt="save" onclick="OnClick('ibtnUpdate')" />
                        </td>
                    </tr>
                </table>
                <fieldset style="width: 100%;">
                    <table border="0" width="100%" cellpadding="2" cellspacing="0">
                        <tr>
                            <td align="right" style="width: 20%">
                            </td>
                            <td align="left" style="width: 25%">
                            </td>
                            <td align="right" style="width: 15%">
                                Instructed Date</td>
                            <td align="left" style="width: 40%">
                                <gw:textbox id="txtInst_Date" styles='text-align:center;width:100%' csstype="filter" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 20%">
                                Product Type</td>
                            <td align="left" style="border: 0px solid #999999; width: 25%">
                                <gw:radio id="rdoProduct_Type" value="Y" style="width: 100%"><span value="Y" style="width:30%;">Norm.</span><span value="N" style="width:30%">Box</span></gw:radio>
                            </td>
                            <td align="right" style="width: 15%">
                                Product Code</td>
                            <td style="width: 40%">
                                <gw:textbox id="txtMatno" styles='text-align:center;width:30%' csstype="filter" />
                                <gw:textbox id="txtProd_Name" styles='width:70%' csstype="filter" />
                            </td>
                        </tr>
                        <tr style="height: 23px">
                            <td align="right">
                                Completion</td>
                            <td align="left" style="border: 0px solid #999999">
                                <gw:radio id="rdoCompletion" value="N" style="width: 100%"><span value="Y" style="width:30%;">Yes</span><span value="N" style="width:30%">No</span></gw:radio>
                            </td>
                            <td align="right">
                                Customer No</td>
                            <td align="left">
                                <gw:textbox id="txtVendno" styles='text-align:center;width:30%' csstype="filter" />
                                <gw:textbox id="txtVend_Nm" styles='width:70%' csstype="filter" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Machine No.</td>
                            <td align="left">
                                <gw:textbox id="txtHoki" styles='text-align:center;width:50%' />
                            </td>
                            <td align="right">
                                Size</td>
                            <td align="left">
                                <gw:textbox id="txtSizea" styles='text-align:center;width:30%' csstype="filter" />
                                <gw:textbox id="txtSize_Nm" styles='width:70%' csstype="filter" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <a title="Click here to select Lot No" onclick="OnPopUp('Lot No')" href="#tips" style="text-decoration: none;
                                    color:#0000ff">Lot No.</a></td>
                            <td align="left">
                                <gw:textbox id="txtLotno" styles='width:100%;text-align:center;' />
                            </td>
                            <td align="right">
                                Color CAP.</td>
                            <td align="left">
                                <gw:textbox id="txtCap_Code" styles='text-align:center;width:30%' csstype="filter" />
                                <gw:textbox id="txtCap_Colnm" styles='width:70%' csstype="filter" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td align="left">
                                <gw:icon id="btnCall" img="2" text="Call Dip. Data" alt="Call Dip. Data" styles='width:100%'
                                    onclick="OnClick('btnCall');" />
                            </td>
                            <td align="right">
                                Color BODY.</td>
                            <td align="left">
                                <gw:textbox id="txtBody_Code" styles='text-align:center;width:30%' csstype="filter" />
                                <gw:textbox id="txtBody_Colnm" styles='width:70%' csstype="filter" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset style="width: 100%;" style="padding-top: 2px">
                    <table border="0" width="100%" cellpadding="2" cellspacing="0">
                        <tr>
                            <td align="right" style="width: 20%">
                                Estimated Q'ty(a)</td>
                            <td align="left" style="width: 30%">
                                <gw:textbox id="txtProd_Qty" styles='text-align:right;width:83%' type="number" format="###,###"
                                    onkeypress="CheckNum();" />
                            </td>
                            <td align="right" style="width: 25%">
                                :Raw Material Weights(1)</td>
                            <td align="left" style="width: 25%">
                                <gw:textbox id="txtWon_Usedqty" styles='text-align:right;width:90%' csstype="filter"
                                    type="number" format="###,###.#####0R" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Dip. Q'ty(b)</td>
                            <td align="left">
                                <gw:textbox id="txtDip_Qty" styles='text-align:right;width:83%' type="number" format="###,###"
                                    onkeypress="CheckNum();" />
                            </td>
                            <td align="right">
                                Weights per Capsule(2)</td>
                            <td align="left">
                                <gw:textbox id="txtCapsule_Wgt" styles='text-align:right;width:90%' type="number"
                                    format="###,###.##0R" />
                                mg</td>
                        </tr>
                        <tr>
                            <td align="right">
                                Dip. Weight(c)<br />
                                (b)*(2)</td>
                            <td align="left">
                                <gw:textbox id="txtDip_Wgt" styles='text-align:right;width:83%' csstype="filter"
                                    type="number" format="###,###.#####0R" />
                            </td>
                            <td align="right">
                                Dip. Yield(3)<br />
                                (c)/(1)*100</td>
                            <td align="left">
                                <gw:textbox id="txtDip_Yield" styles='text-align:right;width:90%' csstype="filter"
                                    type="number" format="###,###.#0R" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Count. Q'ty(d)</td>
                            <td align="left">
                                <gw:textbox id="txtCount_Qty" styles='text-align:right;width:83%' onenterkey="OnInputData()" type="number" format="###,###,###"
                                    />
                            </td>
                            <td align="right">
                                Package Q'ty(4)</td>
                            <td align="left">
                                <gw:textbox id="txtAct_Qty" styles='text-align:right;width:90%' onenterkey="OnInputData()" type="number" format="###,###,###"
                                    />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Package Weights(e)<br />
                                (4)*(2)</td>
                            <td align="left">
                                <gw:textbox id="txtPack_Wgt" styles='text-align:right;width:83%' csstype="filter"
                                    type="number" format="###,###.#####0R" />
                            </td>
                            <td align="right">
                                Loss Q'ty(5)<br />
                                (b)-(d)</td>
                            <td align="left">
                                <gw:textbox id="txtLoss_Qty" styles='text-align:right;width:90%' csstype="filter"
                                    type="number" format="###,###" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Scrap Q'ty(f)<br />
                                (d)-(4)</td>
                            <td align="left">
                                <gw:textbox id="txtDiscard_Qty" styles='text-align:right;width:83%' csstype="filter"
                                    type="number" format="###,###" />
                            </td>
                            <td align="right">
                                Total Loss Q'ty(6)<br />
                                (5)+(f)</td>
                            <td align="left">
                                <gw:textbox id="txtTotal_Loss" styles='text-align:right;width:90%' csstype="filter"
                                    type="number" format="###,###" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Passing Ratio(g)<br />
                                (4)/(b)</td>
                            <td align="left">
                                <gw:textbox id="txtPass_Ratio" styles='text-align:right;width:83%' csstype="filter"
                                    type="number" format="###,###.#0R" />
                            </td>
                            <td align="right">
                                Production Yeild(7)<br />
                                (e)/(1)*100</td>
                            <td align="left">
                                <gw:textbox id="txtProd_Ratio" styles='text-align:right;width:90%' csstype="filter"
                                    type="number" format="###,###.#0R" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPk" style="display: none" />
    <gw:textbox id="txtVGGU" style="display: none" />
    <gw:textbox id="txtTsh_batlot_m_pk" style="display: none" />
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 3; top: 7;" onclick="OnToggle()" />
</body>
</html>
