<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manufacturing Instruction and Record (3. Printing)</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    left.style.display="none";
    OnClick('OnToggle');
    BingdingData();
    PartyTypeChange();
}
function BingdingData()
{
        var data,dataMenuFood;
        data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PARTY' and CODE not in (10,50,70,80)" )%>||Select All"; 
	    lstPartyType.SetDataText(data);
	    lstPartyTypesearch.SetDataText(data);
	    <%=ESysLib.SetGridColumnComboFormat( "grdSearch" , 3 , "SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PARTY'") %>; 
	    lstPartyTypesearch.value='';
	    data ="DATA|06:00|06:00|07:00|07:00|08:00|08:00|09:00|09:00|10:00|10:00|11:00|11:00|12:00|12:00|13:00|13:00|14:00|14:00|15:00|15:00|16:00|16:00|17:00|17:00|18:00|18:00|19:00|19:00|20:00|20:00"; 
        lstBeginTime.SetDataText(data);  
        data ="DATA|Save|Tentative|Comfirm|Comfirm|Close|Canceled"; 
        lstStatus.SetDataText(data);  
		var data2 ="DATA|Save|Tentative|Comfirm|Comfirm|Close|Canceled||Select All";
		lstStatusS.SetDataText(data2);
		lstStatusS.value="";
		var dataVenue ="DATA|01|Gallery bar|02|Terrace|03|PDR #19|04|PDR #20|05|PDR #21|06|Besta|07|Festa|08|Vista|09|Grand ballroom|10|Pool side||";
		lstVenue.SetDataText(dataVenue);
		lstVenue.value="";
        data ="DATA|USD|USD|VND|VND|EUR|EUR|KRW|KRW"; 
        lstCurrency.SetDataText(data);  
       // dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-7));
        txtCreator.SetReadOnly(true);
        txtSlipNo.SetReadOnly(true);
		txtTotAmt.SetEnable(false);  
		txtCustomerID.SetReadOnly(true);
        txtCustomerName.SetReadOnly(true);
		txtAmtServices.SetEnable(false);  
		txtVat.SetEnable(false);  
		txtSumTable.SetEnable(false);
		txtHotelfSlipNo.SetReadOnly(true);
		txtGolfSlipNo.SetReadOnly(true);
		 
		txtTotalDue.SetEnable(false);
		txtCreateDate.SetReadOnly(true);
		txtModifyBy.SetReadOnly(true);
		txtModifyDate.SetReadOnly(true);	
		txtConferenceSlipNo.SetReadOnly(true);	
		data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PARTY' and CODE in (10,50,70,80)" )%>"; 
	    lstMenuType.SetDataText(data);
        OnNew('Master'); 
		OnSearch('Search');
}
var f_save = 'select';
function OnSearch(pos) 
{
    switch (pos)
    {	
		case 'Search' :
            dso_htrt00060.Call("SELECT");
        break;
		case 'Master' :
            f_save='select';
			txtMasterPK.text=grdSearch.GetGridData(grdSearch.row,0);
            dso_htrt00060_mst.Call("SELECT");
        break;
    }
}
function OnClick(obj)
{
	switch(obj)
	{
		case 'OnToggle':
			var left  = document.all("left");    
			var right = document.all("right");   
			var imgArrow = document.all("imgArrow");

			if(imgArrow.status == "expand")
			{
				left.style.display="none";       
				imgArrow.status = "collapse";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/next_orange.gif";
			}
			else
			{
				left.style.display="";
				imgArrow.status = "expand";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/prev_orange.gif";
			}
		break;
	}	
}
function OnNew(obj) 
{
    switch (obj)         
      {		        
            case 'Master' :
	                dso_htrt00060_mst.StatusInsert(); 
					txtPer_Table.text='1';
            break;
      }
}
function ValidateData()
{
    if(lstPartyType.value =='PARTY-B')
    {
        if(txtContact.text=='')
        {
            alert("You must input contact.");
            return false;
        }
        return true;
     }
     else
     {
        if(txtMobile.text=='')
        {
            alert("You must input number mobile.");    
            return false;  
        }
        if(txtTelephone.text=='')
        {
            alert("You must input number telephone.");    
            return false;  
        }
        if(txtContact.text=='')
        {
            alert("You must input contact.");
            return false;
        }
        return true;
     }
}
function OnSave(obj)
{
    switch (obj)         
      {		        
            case 'Master' :
                f_save='update';
                if(ValidateData())
                {
                    dso_htrt00060_mst.Call();      
                }
			break;	
      }
}
function OnDelete()
{
   if(confirm("Are you sure to delete ?"))
    {
        f_save='update';
        dso_htrt00060_mst.StatusDelete();
        dso_htrt00060_mst.Call();
    } 
}
function PartyTypeChange()
{
    if(lstPartyType.GetData() =='PARTY-B')
    {
        txtReserve.SetEnable(false);
        txtPer_Table.SetEnable(false); 
        txtSumTable.SetEnable(false); 
        txtDebt.SetEnable(false); 
        txtTotAmt.SetEnable(false); 
        txtPrice_Pers.SetEnable(true);
        txtAmtServices.SetEnable(true); 
       
    }
    else
    {
        txtReserve.SetEnable(true);
        txtPer_Table.SetEnable(true); 
        txtSumTable.SetEnable(false); 
        txtDebt.SetEnable(false); 
        
    }
}
function OnDataReceive(obj)
{
	if(obj.id=="dso_htrt00060_mst")
	{
		if(f_save=='update')
		{
			dso_htrt00060.Call("SELECT");
		}
	}
}
function OnPopUp()
{		
	var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
	var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
	if ( object != null )
	{
		tco_buspartner_pk.text  = object[0];  
		txtCustomerID.text			= object[1];
		txtCustomerName.text			= object[2];
	}
}
function OnHotel_GolfConfNo(obj)
{
	if(obj=='hotel')
	{
		var path = System.RootURL + "/form/ja/bk/jabk00030_hotel_confirm_no_popup.aspx?";
				var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					txtHotelfSlipNo.text	= object[7];   
				}
	}
	if(obj=='golf')
	{
		var path = System.RootURL + "/form/ja/bk/jabk00030_golf_confirm_no_popup.aspx?";
				var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					txtGolfSlipNo.text	= object[5];
				}
	}
	if(obj=='Conference')
	{
		var path = System.RootURL + "/form/ja/bk/jabk00030_conference_confirm_no_popup.aspx?";
				var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					txtConferenceSlipNo.text	= object[3];
				}
	}
}
function OnPrint()
{
	 url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/rt/htrt00170_conference_banquet2.rpt&procedure=CRM.sp_rpt_main_not_use|CRM.sp_rpt_htrt00170_hotel|CRM.sp_rpt_htrt00170_confer_banq|CRM.sp_rpt_htrt00170_golf&parameter="+txtMasterPK.text+"|"+txtMasterPK.text+"|"+txtMasterPK.text+"|"+txtMasterPK.text;   
	 System.OpenTargetPage(url);  
}


</script>
<body>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060_search"> 
                <input bind="grdSearch" > 
                     <input bind="dtFrom" /> 
                     <input bind="dtTo1" />
                     <input bind="txtSearchSlipNo" />  
                     <input bind="lstPartyTypesearch" />
					 <input bind="lstStatusS" />
                </input> 
                <output bind="grdSearch" />   
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060_mst" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40" function="CRM.sp_sel_htrt00060_banquet" procedure="CRM.sp_upd_htrt00060_banquet"> 
			<inout>
				<inout bind="txtMasterPK" />
				<inout bind="txtSlipNo"/>
				<inout bind="dtBookDate"/>
				<inout bind="txtBookTime"/>
				<inout bind="dtOpenDate"/>
				<inout bind="lstBeginTime"/>
				<inout bind="lstPartyType"/>
				<inout bind="txtCustomerID"/>           
				<inout bind="txtCustomerName"/>
				<inout bind="txtMobile"/>
				<inout bind="txtEmail"/>
				<inout bind="txtAddress"/>
				<inout bind="txtDescription"/>
				<inout bind="txtTotGuest"/>
				<inout bind="lstMenuType"/>
				<inout bind="txtPer_Table"/>
				<inout bind="txtPrice_Pers"/>
				<inout bind="txtTotAmt"/>
				<inout bind="txtCreator"/>
				<inout bind="txtDeposit"/>
				<inout bind="txtTelephone"/>
				<inout bind="txtReserve"/>	
				<inout bind="txtSumTable"/>
				<inout bind="txtDebt"/>
				<inout bind="lstStatus"/>    
				<inout bind="txtFax"/>	
				<inout bind="txtContact"/>	
				<inout bind="lstCurrency"/>
				<inout bind="txtAmtServices"/>  
				<inout bind="txtVat"/>
				<inout bind="tco_buspartner_pk"/>
				<inout bind="txtTotalDue"/>
				<inout bind="txtCreateDate"/>
				<inout bind="txtModifyBy"/>
				<inout bind="txtModifyDate"/>  
				<inout bind="txtHotelfSlipNo"/>
				<inout bind="txtGolfSlipNo"/>
				<inout bind="txtConferenceSlipNo"/> 
				<inout bind="txtchild_12_year"/>
				<inout bind="txtchild_6_year"/>
				<inout bind="lstVenue"/>
			</inout>
		</dso> 
	</xml> 
</gw:data>
    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr>
            <td style="width: 25%; background: white" align="left" id="left">
                <table style="height: 100%; width: 100%" border="0">
                    <tr>
                        <td style="width: 30%" align="center">
                            <b>Open Date</b>
                        </td>
                        <td  style="width: 70%" colspan="2">
                            <gw:datebox id="dtFrom" onchange="OnSearch('Search')" lang="1" styles="width:49%" />
                            ~<gw:datebox id="dtTo1" onchange="OnSearch('Search')" lang="1" styles="width:49%" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('Search')" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%">
                            Slip No</td>
                        <td style="width: 67%" colspan="3">
                            <gw:textbox id="txtSearchSlipNo" styles="width: 100%" onenterkey="OnSearch('Search')" />
                        </td>
                        
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%">
                            Party Type</td>
                        <td style="width: 67%" colspan="3">
                            <gw:list id="lstPartyTypesearch" onchange="OnSearch('Search')" styles="width:100%;" />
                        </td>
                        
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 30%">
                            Status</td>
                        <td style="width: 67%" colspan="3">
                            <gw:list id="lstStatusS" onchange="OnSearch('Search')" styles="width:100%;" />
                        </td>
                        
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="4">
                            <gw:grid id="grdSearch" header="_PK|Open Date|Slip No|Party Type|Book Date" format="0|4|0|0|4" aligns="0|0|0|0|0"
							defaults="||||" editcol="0|0|0|0|0" widths="0|2000|2000|1500|1000" styles="width:100%;height:100%" autosize='T'
							oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:75%; background: white" align="right" id="right">
              <table valign='top' style="height: 100%; width: 100%" border="0">
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right"></td>
					<td style="width: 20%">
						
					</td>
					<td style="width: 15%" align="right"></td>
					<td style="width: 15%">
					</td>
					<td style="width: 10%" align="right"></td>
					<td style="width: 20%">
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
								</td>								
								<td style="width: 3%" align="right">
								</td>
								<td style="width: 3%" align="right">
								</td>
								<td style="width: 3%" align="right">
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Slip No</td>
					<td style="width: 20%">
						<gw:textbox id="txtSlipNo" styles="width: 100%" csstype="mandatory"/>
					</td>
					<td style="width: 10%" align="right"><b style="color: Red">*</b>Pax(Adult)</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTotGuest" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/> 
					</td>
					<td style="width: 20%" align="right">
						
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
									<gw:imgbtn img="excel" alt="Print" text="Print" id="btnReport" onclick="OnPrint()"/>
								</td>								
								<td style="width: 3%" align="right">
									<gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew('Master')" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Master')" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Book Date</td>
					<td style="width: 20%">
						<gw:datebox id="dtBookDate" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right">Child(12 Years)</td>
					<td style="width: 20%" colspan="2"> 
						<gw:textbox id="txtchild_12_year" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Pers/Table 
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtPer_Table" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Book Time</td>
					<td style="width: 20%">
						<gw:textbox id="txtBookTime" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right"><b style="color: Red">*</b>Price/pax </td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtPrice_Pers" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Sum Table
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">  
								    <gw:textbox id="txtSumTable" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Event Date</td>
					<td style="width: 20%">
						<gw:datebox id="dtOpenDate" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right">Amount</td> 
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTotAmt" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						<b style="color: Red">*</b>Mobile
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtMobile" styles="width: 100%"/> 
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Event Time</td>
					<td style="width: 20%">
						<gw:list id="lstBeginTime" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Service</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtAmtServices"  type="number" format="###,###,###,###" styles="text-align:right;width:100%;" />
					</td>
					<td style="width: 10%" align="right"><b style="color: Red">*</b>Telephone</td>   
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtTelephone" styles="width: 100%"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Party Type</td>
					<td style="width: 20%">
						<gw:list id="lstPartyType" onchange="PartyTypeChange()" styles="width:100%;" />
						
					</td>
					<td style="width: 10%" align="right">Vat</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtVat" styles="width: 100%" type="number" format="###,###,###,###" readonly="T" /> 
					</td>
					<td style="width: 20%" align="right">
						Status           
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
									 <gw:list id="lstStatus" styles="width:100%;" /><!--txtReserve--BACKUP_TABLE-->
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Menu Type</td>
					<td style="width: 20%">
						<gw:list id="lstMenuType" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Total Due </td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTotalDue" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						<b style="color: Red">*</b>Contact
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtContact" styles="width: 100%"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Currency</td>
					<td style="width: 20%">
						<gw:list id="lstCurrency" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Deposit </td>  
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtDeposit" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 10%" align="right">Creator</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtCreator" styles="width: 100%" csstype="mandatory" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<!-------------------------->
				<tr style="height: 2%" valign="top"> 
					<td style="width: 10%" align="right">Venue</td> 
					<td style="width: 20%">
						<gw:list id="lstVenue" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Remaining</td>  
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtDebt" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 10%" align="right">Create Date</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtCreateDate" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<!-------------------------->
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Customer</b></td>
					<td style="width: 20%" colspan="4"> 
						<gw:textbox id="txtCustomerID" styles="width: 41%"/><gw:textbox id="txtCustomerName" styles="width: 58%"/>
					</td>
					<td style="width: 20%" align="right">   
						Modify By
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtModifyBy" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Email</td> 
					<td style="width: 20%" colspan="4">
						<gw:textbox id="txtEmail" styles="width: 100%"/>
					</td>
					<td style="width: 20%" align="right">
						Modify Date
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtModifyDate" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				
				
				<tr style="height: 2%" valign="top"> 
					<td style="width: 10%" align="right"> <a href="#" onclick="OnHotel_GolfConfNo('hotel')">Hotel.Slip#</a></td>
					<td style="width: 20%">
						<gw:textbox id="txtHotelfSlipNo" csstype="mandatory" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right"> <a href="#" onclick="OnHotel_GolfConfNo('golf')">Golf.Slip#</a></td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtGolfSlipNo" styles="width: 100%" csstype="mandatory" />
					</td>
					<td style="width: 20%" align="right">
						<a href="#" onclick="OnHotel_GolfConfNo('Conference')">Conference.Slip#</a>
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">  
								    <gw:textbox id="txtConferenceSlipNo" styles="width: 100%" csstype="mandatory" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Reserve</td> 
					<td style="width: 20%">
						<gw:textbox id="txtReserve" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 10%" align="right">Fax</td>  
					<td style="width: 20%" colspan="2"> 
						<gw:textbox id="txtFax" styles="width: 100%"/>
					</td>
					<td style="width: 20%" align="right">
						Child(<6 Years)
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtchild_6_year" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				
				<tr style="height: 2%" valign="top">
				    <td>Address</td>
				    <td colspan="7"><gw:textbox id="txtAddress" styles="width: 100%"/></td>
				</tr>
				<tr style="height: 2%" valign="top">
				    <td>Special Request</td>
				    <td colspan="7"><gw:textbox id="txtDescription" styles="width:100%" /></td>
				</tr>
				<tr style="height: 76%"></tr>
			</table> 
            </td>
        </tr>
    </table>	
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnClick('OnToggle')" />
</body>
<gw:textbox id="txtMasterPK" styles="display: none" />
<gw:textbox id="tco_buspartner_pk" styles="display: none" />
<!--------------------------------------------------------------------------------------->
</html>
