<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>G.Roll Registration</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;    
    var insert_status =0;   
        
    var G1_PK               = 0,
        G1_color_code       = 1,
        G1_color_local_name = 2;

    var G2_Item_Code                       =0,
        G2_Item_Name                       =1,
        G2_Reqd_Qty_Kg                     =2,
        G2_Reqd_Qty                        =3;

 //==================================================================
 function BodyInit()
 {
      BindingDataList();                  
      OnSearch('grdRollList');
      //txtDeptCode.SetEnable(false);
      txtDeptName.SetEnable(false);
      
      txtProdCode.SetEnable(false);
      txtProdName.SetEnable(false);
      
      txtBusCode.SetEnable(false);
      txtBusName.SetEnable(false);
      
      txtCColID.SetEnable(false);
      txtCColNM.SetEnable(false);
      
      txtBColID.SetEnable(false);
      txtBColNM.SetEnable(false);
      
      txtCInkColID.SetEnable(false);
      txtCInkColNM.SetEnable(false);
      
      txtBInkColID.SetEnable(false);
      txtBInkColNM.SetEnable(false);
      
      txtConfByID.SetEnable(false);      
      txtConfByName.SetEnable(false);
      
      txtDiscardByID.SetEnable(false);
      txtDiscardByName.SetEnable(false);
      
      txRollNo.SetEnable(false);
      lstNation.SetEnable(false);
      txtCArt.SetEnable(false);
      txtBArt.SetEnable(false);
      
      txtCapPrintType.SetEnable(false);
      txtBodyPrintType.SetEnable(false);
      
      OnNew()
 }
 
 //==================================================================
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'grdRollList':
            data_shpb00110.Call("SELECT");
        break;
        
        case'Master': 
            txtMasterPK.text = grdRollList.GetGridData(grdRollList.row,G1_PK);           
            data_shpb00110_1.Call("SELECT");
        break;
        
    }
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
//==================================================================
 
function BindingDataList()
 {    
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code||' - '||a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0060' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " )%>";      
        lstTypeSearch.SetDataText(data+'|ALL|Select ALL');
        lstTypeSearch.value='ALL';
        
        lstRollType.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code||' - '||a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0061' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " )%>";      
        lstOffsetNo.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  ")%>";
        lstSizeS.SetDataText(data+"|ALL|Select ALL"); 
        lstSizeS.value='ALL';      
        lstSize.SetDataText(data);
       
        data="<%=ESysLib.SetListDataSQL("select COUNTRY_no, COUNTRY_NM from imex.tie_country a where  a.del_if = 0")%>";
        lstNation.SetDataText(data);
        lstNation.value='';
             
 }
 //==================================================================
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :
                if(txtProdPK.text !="")
                {
                    insert_status =1; 
                    data_shpb00110_1.Call();
                }else
                {
                    alert("Please, Select Prod Code !")
                }
            break;
      }  

 }
 //-----------------------------------------------------------------
function OnNew()
{
    data_shpb00110_1.StatusInsert();
    txRollNo.text="**New Item Code**";    
}
 //==================================================================

 function OnDelete()
 {	
			if ( confirm( "Do you want to delete this Roll?" ) ) 
			{
				data_shpb00110_1.StatusDelete();
				insert_status = 1 
				data_shpb00110_1.Call();
			}
 }
 
 //==================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shpb00110_1':
            if(insert_status==1)
            {
              insert_status =0;
              data_shpb00110.Call("SELECT");
            }
        break;
        
    }
}
 //==================================================================
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
        txtSolQty.text="";
    }
}
//===================================================================
function OnPrint()
{
    if(txtMasterPK.text!="")
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pb/rpt_shpb00110.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpb00110&parameter=" + txtMasterPK.text ;
	    System.OpenTargetPage(url);
    }
}
 //==================================================================
 function OnPopUp(pos)
 {
    switch(pos)
       {
            case 'CONFIRMBY':
                        var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {                  
                            txtConfByID.text = object[3];
                            txtConfByName.text = object[5];//charger Name
		                    txtConfByPK.text = object[0];
                        }
            break;
            case 'DISCARDBY':
                        var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {                  
                            txtDiscardByID.text = object[3];
                            txtDiscardByName.text = object[5];//charger Name
		                    txtDiscardByPK.text = object[0];		                    
		                   
                        }
            break;
            case 'PROD':
                        var fpath = System.RootURL + "/form/sh/pb/shpb00111.aspx?prod_yn=Y";
	                    var object = System.OpenModal( fpath , 800 , 600 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {                  
                            txtProdCode.text = object[1];
                            txtProdPK.text = object[0];//charger Name
		                    txtProdName.text = object[2];
		                    
		                    txtBusPK.text = object[20];
                            txtBusCode.text = object[21];
                            txtBusName.text = object[22];
                            lstNation.value = object[23];
                            
                            txtCColPK.text  = object[6];
                            txtCColID.text  = object[7];
                            txtCColNM.text  = object[8];
                                            
                            txtBColPK.text  = object[9];
                            txtBColID.text  = object[10];
                            txtBColNM.text  = object[11];
                            
                            txtCArt.text    = object[14];
                            txtBArt.text    = object[18];
                            
                            txtCInkColID.text   = object[12];                         
                            txtCInkColNM.text   = object[13];
                            txtBInkColID.text   = object[16];
                            txtBInkColNM.text   = object[17];      
                        }
            break;
            
            case'Dept':
                var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                if (object != null)
                {                  
                   txtDeptName.text = object[2];
		           txtDeptCode.text = object[1];
                }
            break;
      }
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00110" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00110" > 
                <input> 
                    <input bind="lstTypeSearch" />
                    <input bind="lstSizeS" />
                    <input bind="txRollSearch" /> 
                </input> 
                <output bind="grdRollList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00110_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="2" type="control" user="prod" function="prod.sp_sel_shpb00110_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" procedure="prod.sp_upd_shpb00110_1" > 
                <inout > 
                    <inout bind="txtMasterPK" />
                    <inout bind="txRollNo" />
                    <inout bind="lstSize" />
                    <inout bind="lstOffsetNo" />
                    <inout bind="lstRollType" />
                    <inout bind="txtMaker" />
                    <inout bind="txtProdPK" />
                    <inout bind="txtProdCode" />
                    <inout bind="txtProdName" />                    
                    <inout bind="txtRollStore" />
                    
                    <inout bind="txtSampleStore" />
                    <inout bind="txtRemark" />                    
                    <inout bind="txtConfByPK" />
                    <inout bind="txtConfByID" />
                    <inout bind="txtConfByName" />
                    <inout bind="dtConfirmDate" />
                    <inout bind="radConfQC" />                    
                    <inout bind="txtDiscardByPK" />
                    <inout bind="txtDiscardByID" />
                    <inout bind="txtDiscardByName" />
                    
                    <inout bind="dtDiscardDate" />
                    <inout bind="txtDiscardReason" />                    
                    <inout bind="radRollStatus" />
                    <inout bind="lstCompany" />
                    <inout bind="txtDeptCode" />
                    <inout bind="dtEnter" />     
                                   
                    <inout bind="txtBusPK" />
                    <inout bind="txtBusCode" />
                    <inout bind="txtBusName" />
                    <inout bind="lstNation" />
                    
                    <inout bind="txtCColPK" />
                    <inout bind="txtCColID" />
                    <inout bind="txtCColNM" />                    
                    <inout bind="txtBColPK" />
                    <inout bind="txtBColID" />
                    <inout bind="txtBColNM" />                    
                    <inout bind="txtCapPrintType" />
                    <inout bind="txtCArt" />                   
                    <inout bind="txtBodyPrintType" />
                     <inout bind="txtBArt" />
                    <inout bind="txtCInkColID" />
                    
                    <inout bind="txtCInkColNM" />
                    <inout bind="txtBInkColID" />
                    <inout bind="txtBInkColNM" />
                    <inout bind="txtDeptName" />                
                    
                </inout>       
            </dso> 
        </xml> 
    </gw:data>   
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 25%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Roll Type
                        </td>
                        <td style="width: 94%" align="right">
                            <gw:list id="lstTypeSearch" styles='width:100%' />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('grdRollList')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Size
                        </td>
                        <td style="width: 94%" align="right">
                            <gw:list id="lstSizeS" styles='width:100%' onchange="OnSearch('grdRollList')" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Roll No
                        </td>
                        <td style="width: 94%" align="right">
                            <gw:textbox id="txRollSearch" styles='width:100%'  onenterkey="OnSearch('grdRollList')" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdRollList' header='_PK|Roll No|Maker' format='0|0|0' aligns='0|0|0'
                                defaults='||' editcol='0|0|0' widths='1000|1500|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" id="right">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 30%">
                        <td colspan="2" >
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                  <td style="width: 5%" align="right">
                                        <b>Company</b>
                                    </td>
                                    <td style="width: 45%"  align="right" >
                                        <gw:list id="lstCompany" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%" align="right"  colspan="2">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 97%">
                                                
                                                </td>
                                                <td style="width:1%">
                                                    <gw:imgbtn id="btnPrint" img="excel" alt="Print" onclick="OnPrint()" />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew()" />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" onclick="OnDelete()" />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave('Master')" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        Size
                                    </td>
                                    <td style="width: 45%"  align="right" >
                                        <gw:list id="lstSize" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dept')"> Department</b>
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                         <gw:textbox id="txtDeptCode" styles='width:30%' />
                                         <gw:textbox id="txtDeptName" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        D/Roll No
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txRollNo" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Roll Type
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:list id="lstRollType" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        R/Roll No
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:list id="lstOffsetNo" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        Maker
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtMaker" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td colspan="4">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PROD')"> Prod Code</b>
                                    </td>
                                    <td style="width: 45%"  align="right" >
                                        <gw:textbox id="txtProdPK" styles='width:25%;display:none' />
                                        <gw:textbox id="txtProdCode" styles='width:30%' />
                                         <gw:textbox id="txtProdName" styles='width:70%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Customer
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtBusPK" styles='width:25%;display:none' />
                                         <gw:textbox id="txtBusCode" styles='width:30%' />
                                         <gw:textbox id="txtBusName" styles='width:70%' />
                                    </td>
                                </tr>
                                 <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        CAP Color
                                    </td>
                                    <td style="width: 45%"  align="right" >
                                        <gw:textbox id="txtCColPK" styles='width:25%;display:none' />
                                        <gw:textbox id="txtCColID" styles='width:30%' />
                                         <gw:textbox id="txtCColNM" styles='width:70%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Country
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                         <gw:list id="lstNation" styles='width:100%'  />                                      
                                    </td>
                                </tr>
                                 <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        BODY Color
                                    </td>
                                    <td style="width: 45%"  align="right" >
                                        <gw:textbox id="txtBColPK" styles='width:25%;display:none' />
                                        <gw:textbox id="txtBColID" styles='width:30%' />
                                         <gw:textbox id="txtBColNM" styles='width:70%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        CAP Artwork
                                    </td>
                                    <td style="width: 45%;white-space:nowrap"  >
                                        <gw:textbox id="txtCapPrintType" styles='width:30%' />      
                                         <gw:textbox id="txtCArt" styles='width:70%' />                                         
                                    </td>
                                </tr>
                                 <tr style="height: 1%">
                                    <td style="width: 5%" align="right">
                                        Enter DT
                                    </td>
                                    <td style="width: 45%"  align="left" >
                                        <gw:datebox id="dtEnter" lang="1" nullaccept styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        BODY Artwork
                                    </td>
                                    <td style="width: 45%;white-space:nowrap" align="right" >
                                        <gw:textbox id="txtBodyPrintType" styles='width:30%' />
                                        <gw:textbox id="txtBArt" styles='width:70%' />                                         
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        SLOC(G/Roll)
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtRollStore" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        CAP Ink Color
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtCInkColID" styles='width:30%' />
                                         <gw:textbox id="txtCInkColNM" styles='width:70%' />
                                    </td>
                                </tr>
                                 <tr style="height: 1%">                                   
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        SLOC(Ref.Sample)
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtSampleStore" styles='width:100%' />
                                    </td>
                                     <td style="width: 5%; white-space: nowrap" align="right">
                                        BODY Ink Color
                                    </td>
                                    <td style="width: 45%" align="right" colspan="1">
                                        <gw:textbox id="txtBInkColID" styles='width:30%' />
                                        <gw:textbox id="txtBInkColNM" styles='width:70%' />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Remark
                                    </td>
                                    <td colspan="3">
                                        <gw:textarea rows="3" id="txtRemark" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>                       
                    </tr>                                        
                    <tr style="height: 35%">
                        <td colspan="2">
                                <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 5%" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('CONFIRMBY')">Confirm By</b>
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="right">
                                            <gw:textbox id="txtConfByPK" styles='width:100%; display:none' />
                                            <gw:textbox id="txtConfByID" styles='width:30%' />
                                            <gw:textbox id="txtConfByName" styles='width:70%' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DISCARDBY')">Discard By</b>
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="right">
                                            <gw:textbox id="txtDiscardByPK" styles='width:100%; display:none' />
                                            <gw:textbox id="txtDiscardByID" styles='width:30%' />
                                            <gw:textbox id="txtDiscardByName" styles='width:70%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap" align="right">
                                            Confirm Date
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="left">
                                            <gw:datebox id="dtConfirmDate" lang="1" nullaccept styles="width:100%" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap" align="right">
                                            Discard Date
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="left">
                                            <gw:datebox id="dtDiscardDate" nullaccept lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap" align="right">
                                            QC. Conf
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="left">
                                            <gw:radio id="radConfQC" value="N" styles="width:100%"> 
                                    <span value="Y" id="Span1">Yes</span> 
                                    <span value="N" id="Span2">No</span>
                                </gw:radio>
                                        </td>
                                        <td style="width: 5%; white-space: nowrap" align="right">
                                            Discard Reason
                                        </td>
                                        <td style="width: 45%; white-space: nowrap" align="left">
                                            <gw:textbox id="txtDiscardReason" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 45%; white-space: nowrap; background-color: CCFFFF" align="center"
                                            colspan="4">
                                            Current Status :
                                            <gw:radio id="radRollStatus" value="1" styles="width:100%"> 
                                                <span value="1" id="Span3">Good</span> 
                                                <span value="2" id="Span4">Defect</span>
                                                <span value="3" id="Span5">Discard</span>
                                            </gw:radio>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                   
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------->
 <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
<!------------------------------------------->
</html>
