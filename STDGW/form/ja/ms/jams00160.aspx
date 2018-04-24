<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Transfer Request</title>
</head>
<%  ESysLib.SetUser("inv")%>

<script>
var flag;
var G_PK=0,
	G_contact_M_PK=1,
	G_No=2,
	G_Date_From=3,
	G_Date_To=4,
	G_Amount=5,
	G_Description=6;
function BodyInit()
{
	BindingDataList();
	OnToggle();
	OnAddNew('Master');
}
function BindingDataList()
 {
	var data;   
	data = "data|10|SAVE|20|CONFIRMED|30|CANCELLED|40|CLOSED";
    lstStatus.SetDataText(data);
	data = "data|10|Ms|20|Mr|30|Mrs|40|Drs|50|Pro";
    lstTitle.SetDataText(data); 
    data = "<%=ESysLib.SetListDataSQL(" select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y' and type=10  order by a.NAME")%>";     
	lstMembershipType.SetDataText(data);
	data = "<%=ESysLib.SetListDataSQL(" select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y' and type=10  order by a.NAME")%>|ALL|Select All";     
	lstMemberTypeSearch.SetDataText(data);
	lstMemberTypeSearch.value='ALL';
 }
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="90%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
function OnSearch(pos)  
{
    switch (pos)
    {
        case 'grdSearch':
            dso_jams00160.Call("SELECT");
        break;
		case 'grdMaster':
             if ( grdSearch.row > 0 )
             {
                 txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
             }
            dso_jams00160_mst.Call("SELECT");
        break;
    }
}
function OnAddNew(pos)
{
        switch (pos)
        {
            case 'Master':              
                dso_jams00160_mst.StatusInsert();       
                grdDetail.ClearData();     
            break;  
			case 'Detail':              
                grdDetail.AddRow(); 
				grdDetail.SetGridText(grdDetail.rows-1,G_No, grdDetail.rows-1);	
            break;  
        }
}
function Validate()   
{   
	if ( txtContactNo.text =="")
	{
		alert("Please,input contract no.");
		return false;
	}
	if (txtMemberName.text =="")
	{
		alert("Please,input member name.");
		return false;
	}
	/*if (txtAmountUSD.text =="0" || txtAmountUSD.text=="")
	{
		alert("Please,input amount(USD).");
		return false;
	}*/
	return true;
}
function OnSave()
{    
	if(Validate())
	{
		flag = "save"; 
		dso_jams00160_mst.Call();
	}
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "dso_jams00160_mst": 
            if(flag == "save")
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i,G_contact_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G_contact_M_PK, txtMasterPK.text);
                    } 
					 if (grdDetail.GetGridData( i, G_Date_From) == '' )
					 {
						alert("Please,input date from at row "+i)
						return;
					 }
					 if (grdDetail.GetGridData( i, G_Date_To) == '' )
					 {
						alert("Please,input date to at row "+i)
						return;
					 }
					 if (grdDetail.GetGridData( i, G_Amount) == '' )
					 {
						alert("Please,input amount at row "+i)
						return;
					 }
                }
                //----------------------------            
                dso_jams00160_dtl.Call();
            }
			if(flag == "delete")
            {
				flag = "";
				OnSearch('grdSearch');
			}
            else
            {
               dso_jams00160_dtl.Call("SELECT");
            }
        break;
	}
}
function OnPopup(obj)
{
    if(obj=='member_name')
	{
		var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
		var obj1 = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	 
		 if ( obj1 != null )
		 {
			 txtMemberNamePK.text = obj1[0]; //partner_pk
			 txtMemberName.text   = obj1[3];  
		 }    
	}
	if(obj=='company')
	{
		var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
		var obj1 = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	 
		 if ( obj1 != null )
		 {
			 txtCompanyNamePK.text = obj1[0];   //partner_pk
			 txtCompanyName.text   = obj1[3];
		 }  
	}
    
}
 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this contract?'))
            {
                flag = "delete";
				dso_jams00160_mst.StatusDelete();
                dso_jams00160_mst.Call();
            }   
        break;
        //================
        case 'Detail':
			if(grdDetail.rows >1)
			{
				if(grdDetail.row !="-1")
				{
					if(confirm('Do you want to delete this contract detail?'))
					{
						if ( grdDetail.GetGridData( grdDetail.row, G_PK ) == '' )
						{
							grdDetail.RemoveRow();
						}
						else
						{   
							grdDetail.DeleteRow();
							dso_jams00160_dtl.Call();
						}    
					} 
				}					
			}		
        break;            

    }     
}
function TotalAmtUSD()
{
	 var total_ant_usd=0;
	 if(grdDetail.rows > 1)
	 {
		 for(var i=1; i < grdDetail.rows;i++)
			{
				total_ant_usd=total_ant_usd+Number(grdDetail.GetGridData(i, G_Amount ));
			}
			//alert(total_ant_usd);
			txtAmountUSD.text=total_ant_usd;
	 }
}
function OnReditGrdDetail()
{
	TotalAmtUSD();
}
</script>

<html>
<body>
	<!------------------------------------------------------------------->
    <gw:data id="dso_jams00160" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="crm.sp_sel_jams00160"> 
                <input bind="grdSearch" > 
                    <input bind="dtSearchFrm" /> 
					<input bind="dtSearchTo" /> 
					<input bind="lstMemberTypeSearch" /> 
					<input bind="txtNameSearch" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
	<gw:data id="dso_jams00160_mst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="crm.sp_sel_jams00160_M" procedure="crm.sp_upd_jams00160_M"> 
             <inout>
                <inout  bind="txtMasterPK" /> 
                <inout  bind="dtContactM" />
                <inout  bind="txtContactNo" />  
                <inout  bind="lstMembershipType" />  
                <inout  bind="lstTitle" />
                <inout  bind="txtMemberNamePK" />
				<inout  bind="txtMemberName" />
                <inout  bind="txtCompanyNamePK" />
				<inout  bind="txtCompanyName" />
                <inout  bind="dtFrom" /> 
                <inout  bind="dtTo" />
                <inout  bind="txtAmountUSD" />
                <inout  bind="lstStatus" />
				<inout  bind="txtBalance" />
				<inout  bind="txtRate" />  
				<inout  bind="txtPayed" />
				<inout  bind="txtPhone" />
				<inout  bind="txtAdress" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
	<!------------------------------------------------------------------->
	<gw:data id="dso_jams00160_dtl" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid"  parameter="0,1,2,3,4,5,6" function="crm.sp_sel_jams00160_dtl" procedure="crm.sp_upd_jams00160_dtl"> 
                <input bind="grdDetail" > 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data> 
	<!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 10%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 2%" align="right">
                        <td style="width: 30%">
                            <b>Date</b>
                        </td>
                        <td colspan="2" align="left">
                            <gw:datebox id="dtSearchFrm" lang="1" onchange="OnSearch('grdSearch')" />
                            ~<gw:datebox id="dtSearchTo" lang="1" onchange="OnSearch('grdSearch')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            <b>Type</b>
                        </td>
                        <td style="width: 69%" colspan="3">
                            <gw:list id="lstMemberTypeSearch" styles='width:100%' csstype="mandatory" onchange="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 30%; white-space: nowrap" align="right">
                            Name
                        </td>
                        <td style="width: 69%" colspan="3">
                            <gw:textbox id="txtNameSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <gw:grid id="grdSearch" header="_PK|Date|Member Name/Company" format="0|4|0"
                                aligns="0|0|0" defaults="||" editcol="0|0|0" widths="0|1100|1000"
                                styles="width:100%; height:100%" sorting="T" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 90%">
                <table style="width: 100%; height: 100%" border="0">
					<tr>
						<td style="width: 8%" align="right"></td>
						<td style="width: 9%"></td>
						<td style="width: 14%" align="right"></td>
						<td style="width: 21%"></td>
						<td style="width: 16%" align="right"></td>
						<td style="width: 18%"></td>
						<td style="width: 5%"></td>
						<td style="width: 3%"></td>
						<td style="width: 3%"></td>
						<td style="width: 3%"></td>
					</tr>
					<tr style="height: 2%">
						<td align="right">Date</td> 
						<td ><gw:datebox id="dtContactM" lang="<%=Application("Lang")%>" mode="01" /></td>
						<td align="right">Contract No</td> 
						<td ><gw:textbox id="txtContactNo" csstype="mandatory" styles="width: 100%" /></td>
						<td align="right">Membership Type</td> 
						<td colspan="2"><gw:list id="lstMembershipType" styles="width:100%"  onchange=""/></td>
						<td><gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNew('Master')" /></td>
						<td ><gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" /></td>
						<td ><gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave()" /></td>
					</tr>
					<tr style="height: 2%">
						<td align="right">Title</td> 
						<td ><gw:list id="lstTitle" styles="width:100%"  onchange=""/></td> 
						<td align="right"><a href="#" onclick="OnPopup('member_name')">Member Name</a></td>  
						<td ><gw:textbox id="txtMemberName" csstype="mandatory" styles="width: 100%" readonly="true" /></td>
						<td align="right"><a href="#" onclick="OnPopup('company')">Company</a></td>
						<td colspan="5"><gw:textbox id="txtCompanyName" csstype="mandatory" styles="width: 100%" readonly="true" /></td>
					</tr>
					<tr style="height: 2%"> 
						<td align="right">Duration</td>
						<td colspan="3"><gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />~<gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" /></td>
						<td align="right">Phone</td>
						<td ><gw:textbox id="txtPhone" csstype="mandatory" styles="width: 100%" readonly="true" /></td>
						<td align="right">Status</td>
						<td colspan="4"><gw:list id="lstStatus" styles="width:100%"  onchange=""/></td>
					</tr>
					<tr style="height: 2%"> 
						<td >Amount(USD)</td>
						<td ><gw:textbox id="txtAmountUSD" type="number" format="###,###,###.#" styles="text-align:right;width:100%;height:22"  styles="width: 100%" readonly="true" /></td>
						<td align="right">Payed</td>
						<td ><gw:textbox id="txtPayed" type="number" format="###,###,###.#" styles="text-align:right;width:100%;height:22"  styles="width: 100%" readonly="true" /></td>
						<td align="right">Balance</td>
						<td ><gw:textbox id="txtBalance" type="number" format="###,###,###.#" styles="text-align:right;width:100%;height:22"  styles="width: 100%" readonly="true"  /></td>
						<td align="right">Rate</td>
						<td colspan="4"><gw:textbox id="txtRate" type="number" format="###,###.##" styles="text-align:right;width:70%;height:22"  styles="width: 70%" readonly="true" /><gw:textbox id="txtPercent" text="%"  styles="text-align:center;width:30%;height:22" readonly="true" /></td>
					</tr>
					<tr style="height: 2%">
						<td >Adress</td>
						<td colspan="10"><gw:textbox id="txtAdress"  readonly="true" /></td>
					</tr>
                    <tr style="height: 2%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 64%" align="left">
										<b style="color: blue; font-weight: bold">Payment Plan:</b>	
                                    </td>
                                    <td style="width: 19%" align="center">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>                                    
                                    <td align="right" style="width: 1%">
                                        
                                    </td>
                                    <td style="width: 1%">
											<gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNew('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <td><gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" /></td>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 92%">
                        <td colspan="10">
                            <gw:grid id='grdDetail' header='_PK|_contact_M_PK|No|Date From|Date To|Amount(USD)|Description'
                                format='0|0|0|4|4|-1|0' aligns='0|0|0|0|0|0|0'
								editcol='1|1|0|1|1|1|1' widths='0|0|0|0|0|0|0' 
                                onafteredit="OnReditGrdDetail()" sorting='T' styles='width:100%; height:100%' oncelldblclick="" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---txtMemberNamePK-and--txtcompanyNamePK---are----partner_pk-------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtMemberNamePK" styles="width: 100%;display: none" />  
	<gw:textbox id="txtCompanyNamePK" styles="width: 100%;display: none" />
</body>
</html>
