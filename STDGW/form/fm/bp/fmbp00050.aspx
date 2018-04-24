<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Sea Stock Entry</title>
  </head>
  
 <%ESysLib.SetUser("comm")%>
 
 <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
   //Delivery type 
   <%=ESysLib.SetGridColumnComboFormat("grdBLContainer", 3, "SELECT CODE, CODE_NM FROM comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b WHERE a.TCO_ABCODEGRP_PK = b.PK and b.ID = 'CODC0130' and a.DEL_IF = 0 and b.DEL_IF = 0 order by CODE_NM")%>; 
    grdBLContainer.GetGridControl().SheetBorder = 0xF3D781;
   buttonDetailChange(0); //Disable all detail button 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 ="<%= ESysLib.SetListDataSQL(" select pk,partner_id from tco_company where del_if = 0") %>";
        cboCompany.SetDataText(data1);
        cboDateType.SetDataText("DATA|0|B/L Date|1|ETA Date");
        
 }
 
function buttonDetailChange(cmd)
{
    if (cmd==0)
   {
        ibtnNewDetail.SetEnable(false);
        ibtnDeleteDetail.SetEnable(false);
       // ibtnUnDeleteDetail.SetEnable(false);
        ibtnSaveDetail.SetEnable(false);
   }
   else
   {
        ibtnNewDetail.SetEnable(true);
        ibtnDeleteDetail.SetEnable(true);
      //  ibtnUnDeleteDetail.SetEnable(true);
        ibtnSaveDetail.SetEnable(true);
   } 
} 

function ShowBL()
{
     if(event.row >0)
   {
        txtPurOrdPK.text =""+grdBLContainer.GetGridData(event.row,0);
        grdPODetail.ClearData();
        idData_Dsql_PO_Detail.Call('SELECT');
   } 
}



function onVendorClick()
{
        var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
        oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');

        if ( oValue != null)
        {
                txtVendor.text = oValue[1];
        }
}

function onItemClick()
{
    alert("Item");
}

function OnNewMasterClick()
{
    grdBLContainer.AddRow();
}

function ShowDetailInfo()
{
    if(event.row >0)
   {
        txtTPR_BLCONTAINER_PK.text =""+grdBLContainer.GetGridData(event.row,0);
        grdBLContainerDetail.ClearData();
       
        buttonDetailChange(0);
        if (txtTPR_BLCONTAINER_PK.text !="")
        {
            buttonDetailChange(1);//enable all detail button
            idBLContainerDetail.Call('SELECT');
         }
   } 
}

function ShowBL()
{
    //alert("cot"+event.col);
       if  (event.col <11 && event.col >6 )
      { 
        var l_row = event.row;
   	    var fpath = System.RootURL + "/form/fm/bp/fmbp00050_1.aspx";
   	    var aValue  = System.OpenModal(  fpath , 900 , 500 , 'resizable:yes;status:yes');
		if ( aValue != null )  
		{
		        grdBLContainer.SetGridText(l_row, 1,aValue[0] );//_TPR_CPBL_PK
		       grdBLContainer.SetGridText(l_row,2,aValue[1]);//_TCO_Company_PK 
		       grdBLContainer.SetGridText(l_row, 7,aValue[6] );//BL Date
		       grdBLContainer.SetGridText(l_row, 8,aValue[5] );//BL No
		       grdBLContainer.SetGridText(l_row, 9,aValue[4] );//C/I No
		       grdBLContainer.SetGridText(l_row, 10,aValue[3] );//Vendor
		} 
	}
}

function OnSearchMasterClick()
{
    grdBLContainer.ClearData();
    idBLContainerMaster.Call('SELECT');
}

function OnSaveMasterClick()
{
    if (confirm("Do you want to save the data ?"))
   {
        idBLContainerMaster.Call('');
   } 
}

function OnDeleteMasterClick()
{
   if (confirm("Do you want to delete ?"))
   {
          grdBLContainer.DeleteRow();
          idBLContainer.Call('');
   }
}

function OnUDeleteMasterClick()
{
    alert("undelete");
}

function OnNewDetailClick()
{
     var fpath = System.RootURL + "/form/fm/bp/fmbp00050_2.aspx";
   	 var oValue  = System.OpenModal(  fpath , 900 , 500 , 'resizable:yes;status:yes');
     var crRow = 0;
    if ( oValue != null)
    {
            for(i=0;i<oValue.length;i++ )
		    {
		    
		            var arrTemp = oValue[i];
		            grdBLContainerDetail.AddRow();
		            crRow = grdBLContainerDetail.rows -1;
		            grdBLContainerDetail.SetGridText(crRow,1,txtTPR_BLCONTAINER_PK.text);//master pk
		            grdBLContainerDetail.SetGridText(crRow,2,arrTemp[1]);//purchaseorderdd pk
			        grdBLContainerDetail.SetGridText(crRow,3,arrTemp[5]);//item pk
			        grdBLContainerDetail.SetGridText(crRow,4,arrTemp[3]);//po date
			        grdBLContainerDetail.SetGridText(crRow,5,arrTemp[4]);//po id
			        
			        grdBLContainerDetail.SetGridText(crRow,6,arrTemp[2]);//vendor
			        grdBLContainerDetail.SetGridText(crRow,7,arrTemp[6]);//item code
			        grdBLContainerDetail.SetGridText(crRow,8,arrTemp[7]);//item name
			        
			        grdBLContainerDetail.SetGridText(crRow,10,arrTemp[8]);//unit
			        grdBLContainerDetail.SetGridText(crRow,11,arrTemp[12]);//item price
			        grdBLContainerDetail.SetGridText(crRow,13,arrTemp[11]);//po qty
			       // alert("aaa"+arrTemp[11]);
			        grdBLContainerDetail.SetGridText(crRow,14,arrTemp[10]);//bl last balance
			       
		    }	 
            //txtVendor.text = oValue[1];
    }
}

function OnDeleteDetailClick()
{
    if (confirm("Do you want to delete this record ?"))
   {
        grdBLContainerDetail.DeleteRow();
        idBLContainerDetail.Call('');
   } 

}

function OnSaveDetailClick()
{
    if (confirm("Do you want to save ?"))
   {
        idBLContainerDetail.Call('');
   } 
}

function CalAmount()
{
    	var i=grdBLContainerDetail.row;
	    var price = grdBLContainerDetail.GetGridData(i,11);

	    if(price=="")
	    { 
	       price=0;
	    }
	    var qty=grdBLContainerDetail.GetGridData(i,9);
	    if(qty=="")
	    { 
	       qty=0;
	    }
        var amt = price*qty; 
	    grdBLContainerDetail.SetGridText(i,12,""+amt);
    	
	    if(event.col == 9)
	    {
	       var lastBLBalance = Number(grdBLContainerDetail.GetGridData(i,14));
	       var itemQTY = Number(grdBLContainerDetail.GetGridData(i,9));
	       var bl_bal =  lastBLBalance - itemQTY;
	       grdBLContainerDetail.SetGridText(i, 15,""+bl_bal);
	    }
}

 </script>

<body>

 <gw:data id="idBLContainerMaster"  onreceive="" > 
        <xml>                                   
             <dso id="1" type="grid" user="comm"  parameter="0,1,2,3,4,5,6,11"  function="comm.sp_sel_blcontainer"  procedure="comm.sp_upd_blcontainer"> 
              <input  bind="grdBLContainer">
                    <input bind="cboCompany" /> 
                    <input bind="txtVendor" />
                    <input bind="cboDateType" />
                    <input bind="dtbFrom" /> 
                    <input bind="dtbTo" /> 
                    <input bind="txtCINo" /> 
                    <input bind="txtItem" /> 
                </input> 
                <output bind="grdBLContainer" /> 
            </dso> 
        </xml> 
</gw:data> 
<!-- function="comm.sp_sel_blcontainer"  procedure="comm.sp_upd_blcontainer" -->
 <gw:data id="idBLContainerDetail"  onreceive="" > 
        <xml>                                   
             <dso id="1" type="grid" user="comm"  parameter="0,1,2,3,9,14,15,16,17"  function ="comm.sp_sel_blcontainerd" procedure="comm.sp_upd_blcontainerd"> 
              <input  bind="grdBLContainerDetail">
                    <input bind="txtTPR_BLCONTAINER_PK" /> 
                </input> 
                <output bind="grdBLContainerDetail" /> 
            </dso> 
        </xml> 
</gw:data> 
  <table border="1" cellpadding="0" cellspacing="0" width="100%">
        <tr valign="top">
                <td>
                       <table border="0" cellpadding="0" cellspacing="0" style=" margin-top:2;">
                            <tr>
                                    <td width="15%" ><b>&nbsp;&nbsp;Company&nbsp;</b></td>
                                    <td width="10%"><gw:list id="cboCompany"   styles="width:98%;margin-left:3;" ></gw:list></td>
                                    <td  width="10%" >&nbsp;&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onVendorClick()">Vendor </b></td>
                                    <td  width="20%"><gw:textbox id="txtVendor" styles='width:100%'  onenterkey="OnSearchMasterClick()" /></td>
                                    <td width="10%"></td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="15%" align="right">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="80%"></td>
                                                <td width="5%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="OnSearchMasterClick()" /></td>
                                                <td width="5%"><gw:imgBtn id="ibtnNew" img="new" alt="New" text="New"  onclick="OnNewMasterClick()" /></td>
                                                <td width="5%"><gw:imgBtn id="ibtnDelete" img="delete" alt="Delete" text="Delete"  onclick="OnDeleteMasterClick()" /></td>
                                              <!--  <td width="3%"><gw:imgBtn id="ibtnUnDelete" img="udelete" alt="UnDelete" text="UnDelete"  onclick="OnUDeleteMasterClick()" /></td> -->
                                                <td width="5%"><gw:imgBtn id="ibtnSave" img="save" alt="Save" text="Save"  onclick="OnSaveMasterClick()" /></td> 
                                            </tr>
                                        </table>
                                </td>
                            </tr>
                            <tr>
                                <td  ><gw:list id="cboDateType"   styles="width:80%;margin-left:10;" ></gw:list></td>
                                <td align="left">
                                        <table border="0" cellpadding="1" cellspacing="2">
                                            <tr>
                                                <td width="45%"  align="left"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01"  /></td>
                                                <td width="10%"><b>&nbsp;~&nbsp;</b></td>
                                                <td width="45%"><gw:datebox id="dtbTo" lang="<%=Application("Lang")%>" mode="01"    /></td>
                                            </tr>
                                        </table>
                                </td>
                                <td ><b>&nbsp;&nbsp;&nbsp;&nbsp;C/I No</b>&nbsp;</td>
                                <td><gw:textbox id="txtCINo" styles="width:100%"  onenterkey="OnSearchMasterClick()" /></td>
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onItemClick()">Item</b>&nbsp;</td>
                                <td><gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearchMasterClick()" /></td>
                                <td>&nbsp;</td>
                           </tr>
                        </table> 
                </td>
        </tr>
        <tr >
                <td valign="top">
						 <gw:grid
                                id="grdBLContainer"
                               header="_PK|_TPR_CPBL_PK|_TCO_Company_PK|Delivery Type|Container No|Seal No|Cont. Type|BL Date|BL No|C/I No|Vendor|Description"
                                format="0|0|0|0|4|0|0|0|0|1|0|1|1|1|1|1|1|0"
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0"
                                defaults="||||||||||"
                                editcol="1|1|1|1|1|1|1|0|0|0|0|1"
                                widths="0|0|0|1500|2000|1500|2000|2000|1500|1500|0|0"
                                styles="width:100%; height:150"
                                sorting="T"
                                param="0,1,2,3,4,5,6,7,8,9,10,11"
                                oncellclick="ShowDetailInfo(this)"
                                oncelldblclick="ShowBL(this)" />
                </td>
        </tr>
        <tr>
            <td valign="top" align="right">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr >
                            <td ><gw:imgBtn id="ibtnNewDetail" img="new" alt="New Detail " text="New Detail"  onclick="OnNewDetailClick()" /></td>
                           <td>&nbsp;</td> 
                            <td ><gw:imgBtn id="ibtnDeleteDetail" img="delete" alt="Delete Detail" text="Delete Detail"  onclick="OnDeleteDetailClick()" /></td>
                           <!--  <td>&nbsp;</td>  
                           <td ><gw:imgBtn id="ibtnUnDeleteDetail" img="udelete" alt="UnDelete Detail" text="UnDelete Detail"  onclick="OnUDeleteDetailClick()" /></td> -->
                           <td>&nbsp;</td>  
                            <td ><gw:imgBtn id="ibtnSaveDetail" img="save" alt="Save Detail" text="Save Detail"  onclick="OnSaveDetailClick()" /></td>
                           <td>&nbsp;</td>
                        </tr>
                    </table>
            </td>
        </tr>
        <tr valign="top">
            <td>
                   <gw:grid
                        id="grdBLContainerDetail"
                        header="_a.pk|_tpr_blcontainer_pk|_tpr_purordd_pk|_a.tco_item_pk|PO Date|PO ID
                        |Vendor|Part No|Part Name|Qty|Unit|Price|BL Amount| PO QTY|Last BL Balance|BL Balance|_IQC QTY|Remark"
                        format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|3|3|1|3|3|3|3|3|3"
                        defaults="||||||||||||||||"
                        editcol="1|1|1|1|0|0|0|1|1|1|1|1|1|0|0|0|0"
                        widths="0|0|0|0|1200|1700|1500|1500|1700|1200|700|1200|1100|1100|1500|0|1500"
                        styles="width:100%; height:270;"
                        sorting="T"
                        onafteredit="CalAmount()"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" />
            </td>
        </tr>
  </table>
  <gw:textbox id="txtTPR_BLCONTAINER_PK" styles='width:100%;display:none;'  />
</body>
</html>
