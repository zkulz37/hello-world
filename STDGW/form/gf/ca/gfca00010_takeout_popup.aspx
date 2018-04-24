<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
var g_company_pk = "" ;
var g_insert = false ;
function BodyInit()
{                            
    g_company_pk = "<%=Request.querystring("compk")%>" ;
    BindingDataList();
    txtCUST_PK.SetDataText("<%=Request.querystring("cust_pk")%>");
    txtCUST_ID.SetDataText("<%=Request.querystring("cust_id")%>");
    txtCUST_NM.SetDataText("<%=Request.querystring("cust_nm")%>");            
}

function BindingDataList()
{
    var ls_comp         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCOMPANY.SetDataText(ls_comp);
    lstCOMPANY.value = g_company_pk ;
    ls_comp = "<%=ESysLib.SetListDataSQL("select code, '#' || code_nm code_nm from sale.lg_code where del_if = 0 and lg_code_group_pk = 258 and use_if = 'Y'")%>||ALL" ;
    lstSize.SetDataText(ls_comp);
    lstSize.value = "";
    var l_date = txtTO.value ;
    txtFROM.value = l_date.substr(0, 6) + '01';
}
function OnSearch()
{
    dso_sel_exp_dcl.Call("SELECT");
}

function GetCustomer(ind)
{
    var fpath   = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx";
    var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null )  
    {
        if (object[0] != "")
        {
            if(ind == "1")
            {
                txtCUST_PK.text = object[0];
                txtCUST_ID.text = object[1];
                txtCUST_NM.text = object[2];
                
            }
            
         }
     }        
}
	
function OnResetCust(ind)
{
    if(ind == "1")
    {
        txtCUST_PK.text = "";
        txtCUST_ID.text = "";
        txtCUST_NM.text = "";
    }
    
}
function GetItem()
{
    var fpath   = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx";
    var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null )  
    {
        if (object[0] != "")
        {
            txtITEM_PK.text = object[0];
            txtITEM_CD.text = object[1];
            txtITEM_NM.text = object[2];
         }
     }        
}
function OnDataReceive(pObject)
{
    if(pObject.id =="dso_sel_exp_dcl")
    {
        if(grdMaster.rows > 1)
        {
            txtCUST_NM.SetDataText(grdMaster.GetGridData(1, 19));
        }
        else if(grdMaster_2.rows > 1)
        {
            txtCUST_NM.SetDataText(grdMaster_2.GetGridData(1, 19));
        }
        dso_sel_exp_dcl_2.Call('SELECT');
    }
    else if(pObject.id == "dso_sel_exp_dcl_2" )
    {
        if( g_insert == true )	
        {
	        dso_sel_exp_dcl.Call("SELECT");
	        g_insert = false ;
	    }    
	    if(grdMaster_2.rows > 1)
	    {
	        txtCUST_NM.SetDataText(grdMaster_2.GetGridData(1, 19));
	    }
    }
}

function OnRowMasterClick()
{
//    var ctrl = grdMaster.GetGridControl();
//    if(event.col == 0)
//    {
//        
//    }
    //txt_PK.text = grdMaster.GetGridData(grdMaster.row,0);
    //alert(grdMaster.row);
}

//--Detail
function OnSelectAll()
{
	if(txt_PK.text != "")
	{
		var ctrl = grdDetail.GetGridControl();
		for(i=1; i<ctrl.rows;i++)
		{
			grdDetail.SetGridData(i,0,"-1");
		}
	}
}

function OnCopy()
{	
	var i, j, k;
	for(i = 1; i < grdMaster.rows; i++)
	{
	    if(grdMaster.GetGridData(i, 0)=='-1')
	    {
	        grdMaster_2.AddRow();
	        k = grdMaster_2.rows - 1;
	        for(j = 1; j < grdMaster.cols ; j++)
	        {
	            grdMaster_2.SetGridText(k, j, grdMaster.GetGridData(i, j));
	        }   
	        grdMaster_2.SetRowStatus(k, 0x20);
	    }
	}
	//alert(grdMaster.cols);
	//alert(grdMaster_2.GetRowStatus(1));	
	g_insert = true;
	dso_sel_exp_dcl_2.Call();
}

function OnClickCancel()
{
	this.close();
}
//---------------------------------------------------------
function OnShowExp()
{
    txtITEM_PK.SetDataText("");
    txtITEM_CD.SetDataText("");
    txtITEM_NM.SetDataText("");
}
//---------------------------------------------------------
function OnSelect()
{
    var i, j;
    var data = new Array();
    for( i = 1; i < grdMaster_2.rows; i++)
    {
        if(grdMaster_2.GetGridData(i, 0) == '-1')
        {
            var arr = new Array();
            for(j = 1; j < grdMaster_2.cols ; j++)
            {
                arr[arr.length] = grdMaster_2.GetGridData(i, j);
            }
            data[data.length] = arr;
        }
    }
    window.returnValue = data;
    this.close();
}
//---------------------------------------------------------
function OnSave()
{
    dso_sel_exp_dcl_2.Call();
}
//---------------------------------------------------------
function OnDelete()
{
    var i, j;    
    for( i = 1; i < grdMaster_2.rows; i++)
    {
        if(grdMaster_2.GetGridData(i, 0) == '-1')
        {
            grdMaster_2.SetRowStatus(i, 0x40);
        }
    } 
	g_insert = true ;
	OnSave();       
}
//---------------------------------------------------------
function OnCheckAll()
{
	var i;
	if(chkAll.value == 'T')
	{
		for(i = 1; i < grdMaster_2.rows; i++)
		{			
			grdMaster_2.SetGridText(i, 0, '-1');				
		}
	}
	else if(chkAll.value == 'F')
	{
		for(i = 1; i < grdMaster_2.rows; i++)
		{
			grdMaster_2.SetGridText(i, 0, '0');				
		}
	}

}
//---------------------------------------------------------
function OnCheckAll_1()
{
	var i;
	if(chkAll_1.value == 'T')
	{
		for(i = 1; i < grdMaster.rows; i++)
		{			
			grdMaster.SetGridText(i, 0, '-1');				
		}
	}
	else if(chkAll_1.value == 'F')
	{
		for(i = 1; i < grdMaster.rows; i++)
		{
			grdMaster.SetGridText(i, 0, '0');				
		}
	}

}
//---------------------------------------------------------
function OnResetItem()
{
    
}
</script>

<body style="margin: 0; padding: 0;">
	<gw:data id="dso_sel_exp_dcl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="ACNT.SP_SELECT_TAKEOUT">
                <input bind="grdMaster">
                    <input bind="lstCOMPANY"/>
                    <input bind="txtFROM"/>
                    <input bind="txtTO"/>
                    <input bind="txtCUST_PK"/>
                    <input bind="txtCUST_ID"/>
                    <input bind="txtITEM_PK"/>
                    <input bind="txtITEM_CD"/>
                    <input bind="txtORDER"/>
		    <input bind="lstSize"/>	
                </input>
                <output bind="grdMaster"/>
            </dso> 
        </xml>
    </gw:data>
	<gw:data id="dso_sel_exp_dcl_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="2,14,20" function="ACNT.SP_SELECT_TAKEOUT_2" procedure="ACNT.SP_UPD_S_RQSTD_1" >
                <input bind="grdMaster_2">
                    <input bind="lstCOMPANY"/>
                    <input bind="txtFROM"/>
                    <input bind="txtTO"/>
                    <input bind="txtCUST_PK"/>
                    <input bind="txtCUST_ID"/>
                    <input bind="txtITEM_PK"/>
                    <input bind="txtITEM_CD"/>
                    <input bind="txtORDER"/>
	            <input bind="lstSize"/>		
                </input>
                <output bind="grdMaster_2"/>
            </dso> 
        </xml>
    </gw:data>
    
    
	   
	<!------------------------------------------------------------------------------------------------------->
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td width="10%"></td>
						<td width="20%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="35%"></td>
						<td width="5%"></td>
					</tr>
					<tr>
						<td align="right"><b>Company&nbsp;</b></td>
						<td><gw:list id="lstCOMPANY" styles='width:100%' /></td>
						<td align="right"><b>Order No&nbsp;</b></td>
						<td><gw:textbox id="txtORDER" styles='width=100%;height:22'></gw:textbox></td>
						<td align="right"><a title="Click here to show Customer" onclick="GetCustomer(1)" href="#tips"><b>Customer&nbsp;</b></a></td>
						<td>
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="95%">
										<gw:textbox id="txtCUST_PK" styles='display:none'></gw:textbox>
										<gw:textbox id="txtCUST_ID" styles='width=29%;height:22'></gw:textbox>
										<gw:textbox id="txtCUST_NM" styles='width=70%;height:22'></gw:textbox>
									</td>
									<td width="4%"><gw:imgbtn id="ibtnResetCustomer" img="reset" alt="reset" onclick="OnResetCust(1)" /></td>
								</tr>
							</table>
						</td>
						<td align="right"><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
					</tr>
					<tr>
						<td align="right"><b>Date&nbsp;</b></td>
						<td><gw:datebox id="txtFROM" styles='width:50%' lang="<%=Session("Lang")%>" />&nbsp;&nbsp;~&nbsp;&nbsp;
							<gw:datebox id="txtTO" styles='width:50%' lang="<%=Session("Lang")%>" />
						</td>
						<td colspan="1" align="right">Size&nbsp;</td>
						<td colspan="1"><gw:list id="lstSize" styles="width:100%;" onchange="OnSearch()" /></td>

						<td align="right"><a title="Click here to show Item" onclick="GetItem()" href="#tips"><b>Item&nbsp;</b></a></td>
						<td>
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="95%">
										<gw:textbox id="txtITEM_PK" styles='display:none'></gw:textbox>
										<gw:textbox id="txtITEM_CD" styles='width=29%;height:22'></gw:textbox>
										<gw:textbox id="txtITEM_NM" styles='width=70%;height:22'></gw:textbox>
									</td>
									<td width="4%"><gw:imgbtn id="ibtnResetItem" img="reset" alt="reset" onclick="OnResetItem()" /></td>
								</tr>
							</table>
						</td>
						<td><gw:checkbox id="chkAll_1" styles="width:100%" onchange="OnCheckAll_1()" /></td>
					</tr>
					
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td colspan="7">
				<gw:grid id="grdMaster" 
				    header="CHK|_MST_PK|_PK|_COMPANY_PK|ORD DATE|Deli Date|ORDER NO|_TAKEOUT_ITEM_PK|ITEM CODE|ITEM NAME|UNIT|Size|Cap Color|Body Color|QTY|Price|_DATE|_TCO_BUSPARTNER_PK|PARTNER ID|PARTNER NAME"
					format	="3|0|0|0|4|4|0|0|0|0|0|0|0|0|1|0|4|0|0|0" 
					aligns	="0|0|0|0|0|0|0|0|0|0|0|1|2|2|3|3|0|0|0|0"
					defaults="|||||||||||||||||||"
					editcol	="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths	="500|0|0|0|1500|1200|1500|0|1800|2500|500|600|1000|1000|1400|1400|1500|0|1800|2500"
					styles="width:100%; height:200" 
					sorting="F" 
					 />
			</td>
		</tr>
		<tr>
		    <td colspan="7">
	            <table width="100%" cellpadding="0" cellspacing="0" border="0">
		            <tr>
				<td width="40%" align="right">Check All&nbsp;</td>
		                <td width="10%"><gw:checkbox id="chkAll" value="F" onchange="OnCheckAll()" /></td>
			            <td width="10%" align="center"><gw:imgBtn id="btnSelect"  img="select" alt="Select"   onclick="OnSelect()"     styles='width:100%' /></td>
			            <td width="10%" align="center"><gw:imgBtn id="btnCopy"  img="copy" alt="Copy"   onclick="OnCopy()"     styles='width:100%' /></td>
			            <td width="10%" align="center"><gw:imgBtn id="btnDel"  img="delete" alt="Delete"   onclick="OnDelete()"     styles='width:100%' /></td>
			            <td width="10%" align="right"><gw:imgBtn id="btnSave"  img="save" alt="Save"   onclick="OnSave()"     styles='width:100%' /></td>
			            <td width="10%" align="center"><gw:icon id="btnCancel"  img="in" text="Cancel"   onclick="OnClickCancel()"     styles='width:100%' /></td>
			            
		            </tr>		        
	            </table>
            </td>	        	        	        
		</tr>
		<tr>
			<td colspan="7">
				<gw:grid id="grdMaster_2" 
				    header="CHK|_MST_PK|_TSA_TAKEOUTD_PK|_COMPANY_PK|ORD DATE|Deli Date|ORDER NO|_TAKEOUT_ITEM_PK|ITEM CODE|ITEM NAME|UNIT|Size|Cap Color|Body Color|QTY|Price|_DATE|_TCO_BUSPARTNER_PK|PARTNER ID|PARTNER NAME|_PK|Amount|_tin_warehouse_pk|Warehouse"
					format	="3|0|0|0|4|4|0|0|0|0|0|0|0|0|1|0|4|0|0|0|0|0|0|0" 
					aligns	="0|0|0|0|0|0|0|0|0|0|0|1|2|2|3|0|0|0|0|0|3|3|0|0"
					defaults="|||||||||||||||||||||||"
					editcol	="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths	="500|0|0|0|1500|1200|1500|0|1800|2500|500|600|1000|1000|1400|1500|0|1800|2500|0|1200|1500|0|1500"
					styles="width:100%; height:200" 
					sorting="F" 
					 />
			</td>
		</tr>		
	</table>
	
	<gw:textbox id="txt_PK" style="display: none" />
	<gw:list id="lstCust" style="display: none" />
	<!---------------------------------------------------------------------------------------------------->
</body>
</html>