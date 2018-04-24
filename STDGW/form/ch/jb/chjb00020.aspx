<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Basic Info for Uniform</title>
</head>
<%EsysLib.SetUser("HR") %>
<script>
var cur_row;
var emp_pk    = "<%=Session("EMPLOYEE_PK")%>";
var emp_id    = "<%=Session("EMP_ID")%>";
var log_id    = "<%=Session("LOGIN_ID")%>";
var emp_name  = "<%=Session("USER_NAME")%>";
var uniformpk = "<%=Request("p_app_pk")%>";

var col_emp     = 1;
var col_status  = 2;
var col_req_qty = 4;
var col_item    = 5;
var col_size    = 6;
var col_amount  = 7;
var col_rece    = 8;
var col_laundry = 9;
var col_emp_pk  = 10;

function BodyInit()
{       
    var con = grdData.GetGridControl();
    con.FrozenCols = 4; 
    con.ColFormat(col_req_qty) = "###,###,###,###,###"; 
    con.ColFormat(col_amount)  = "###,###,###,###,###"; 
    
    var con1 = grdListEmp.GetGridControl();
    con1.ColFormat(4) = "###,###,###,###,###"; 
    con1.ColFormat(5) = "###,###,###,###,###"; 
    
    GetLastMonth();
    
    <%=ESysLib.SetGridColumnComboFormat("grdData", 2, "select code, code_nm from thr_code_detail  where del_if = 0 and thr_code_master_pk = 709 and code in ('60','10') order by code")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdData", 5, "select pk, type_id||'-'||type_name from thr_unit_cost  where del_if = 0 and category_code = '50' order by 2")%>;
    
    <%=ESysLib.SetGridColumnComboFormat("grdListEmp", 6, "select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '924' order by seq")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdListEmp", 7, "select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '925' order by seq")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdListEmp", 8, "select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '926' order by seq")%>;
    
    var data = "";

    data = "<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All"; 
    lstOrg.SetDataText(data);
    lstOrg.value = 'ALL';
    
    data = "<%=ESysLib.SetListDataSQL("select code, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = 709 and code in(10, 60) order by code")%>|ALL|Select All";
    lstStatus.SetDataText(data);
    lstStatus.value = 'ALL';
      
    txtLogID.text = log_id;
    txtUniformPK.text = uniformpk
    idData_thr_uniform_request.Call('SELECT');
}

function GetLastMonth()
{
    sysDate = new Date()
    newDate1 = sysDate.getMonth() 
    if (Number(newDate1) < 10)    
        newDate1="0"+ String(newDate1) 
    newDate2 = sysDate.getDate() 
    if (Number(newDate2) < 10 )
        newdate2="0" +String(newDate2) 
    newDate3 = sysDate.getFullYear()
    
    sysDate = newDate3 + newDate1 + newDate2
    
    dtDateF.SetDataText(sysDate);
}

function OnShowPopup(n)
{
    switch(n)
    {
        case 2:
            var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
            
            if (obj!=null)
            {
                 lstOrg.value=obj;
            }
            break;
    }    
}

function AfterEdit()
{   
    if (grdData.col == col_req_qty)
    {
        if (isNaN(grdData.GetGridData(grdData.row, col_req_qty)))
        {
            alert("Your must input number");
            grdData.SetGridText(grdData.row, col_req_qty, '');
        }
    }
}

function OnClick()
{
    if (grdData.GetGridData(grdData.row, col_status) == 10)
    {
        if (grdData.GetRowStatus(grdData.row) == 0)
            grdData.row = -1;
    }
}

function OnSave()
{
    for(var i=1; i<grdData.rows;i++)
    {
        if(grdData.GetGridData(i, col_status) == "")
        {
            alert('You must input data at column Status. Row : ' + i);
            return;
        }
        
        if(grdData.GetGridData(i, col_size) == "")
        {
            alert('You must input data at column Size. Row : ' + i);
            return;
        }
        
        if(grdData.GetGridData(i, col_item) == "")
        {
            alert('You must input data at column Item. Row : ' + i);
            return;
        }
        
        if (grdData.GetGridData(i, col_req_qty) == "")
        {
            grdData.SetGridText(i, col_req_qty, '1');
        } 
    }
    
    idData_thr_uniform_request.Call(); 
}

function OnSearch(n)
{
    switch(n)
    {
        case 1:
            idData_sp_sel_chjb00020_2.Call('SELECT');
            break;
        
        case 2:
            idData_thr_uniform_request.Call('SELECT');
            break;
    }
}

function OnDelete()
{
    grdData.DeleteRow();
}

function OnUnCancel()
{
    grdData.UnDeleteRow();
}

function ReceiveData(obj)
{
    switch(obj.id)
    {
        case 'idData_thr_uniform_request':
            lbRecord.text = grdData.rows-1 + " record(s)";  
            
        break;
    
        case 'idData_sp_sel_chjb00020_1':
            grdData.SetGridText(cur_row, col_size, txtSize.text);
        break;
        
    }
}


function PassGrid(flag)
{
    if(flag == true)
	{
		var SourceGrid      = grdListEmp.GetGridControl();
		var DestinationGrid = grdData.GetGridControl();
		
		if(SourceGrid.SelectedRows <= 0)
        {
            alert("Employee not selected")
            return;
        }
        else
        {
            for(i=SourceGrid.Rows-1; i>=0; i--)
            {
                if (SourceGrid.IsSelected(i)) 
                {
					grdData.AddRow();
                    
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_emp)     = SourceGrid.TextMatrix(i,2) + "-" + SourceGrid.TextMatrix(i,3); //Employee
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_rece)    = SourceGrid.TextMatrix(i,9);  // Receive Location		
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_laundry) = SourceGrid.TextMatrix(i,10); // Laundry Location
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_emp_pk)  = SourceGrid.TextMatrix(i,1);  // EmpPK

					grdListEmp.SetCellBgColor( i,1, i, 4, 0xFF6A73);
					DestinationGrid.TopRow = grdData.rows - 1; 
				}	
            }
        }        
	}
	else
	{
		return;
	}
}
</script>

<body>

<gw:data id="idData_sp_sel_chjb00020_2" >
    <xml>
        <dso id="2" type="grid" function="hr.sp_sel_chjb00020_2">
            <input bind="grdListEmp" >
				<input bind="lstOrg" />
				<input bind="txtSearchEmp" />
            </input>
            <output bind="grdListEmp" />
        </dso>
    </xml>
</gw:data>

<gw:data id="idData_sp_sel_chjb00020_1" onreceive="ReceiveData(this)" >
    <xml> 
        <dso type="process" procedure="hr.sp_sel_chjb00020_1"> 
        <input> 
            <input bind="txtTempPK" /> 
            <input bind="txtType" /> 
        </input> 
        <output>
            <output bind="txtSize" />
        </output>
    </dso> 
    </xml> 
</gw:data> 

<gw:data id="idData_thr_uniform_request" onreceive="ReceiveData(this)">
    <xml>
        <dso id="1" type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11" function="hr.sp_sel_thr_uniform_request" procedure="hr.sp_upd_thr_uniform_request">
            <input bind="grdData" >
                <input bind="txtUniformPK" />
				<input bind="dtDateF" />
				<input bind="dtDateT" />
                <input bind="lstStatus" />
				<input bind="txtEmpPK" />
                <input bind="txtLogID" />
            </input>
            <output bind="grdData" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr>
        <td width="35%" style="background: white">
            <table  width="100%" height="100%" border="0" >			    
			    <tr>
				    <td align = "right" width="20%"><a title="Click here to show Org" onclick="OnShowPopup(2)" href="#tips" >Org</a></td>
				    <td align = "left" width="50%"><gw:list  id="lstOrg" value = "ALL" styles='width:100%'onchange="OnSearch(1)" ></gw:list></td>
				    <td align = "left" width="10%"><gw:imgBtn id="btnSearchEmp" img="search" alt="Search item" onclick="OnSearch(1)" /></td>
			    </tr>
			    <tr>
				    <td align = "right" width="20%">Emp ID/Name</td>
				    <td align = "left" width="50%">
					    <gw:textbox id="txtSearchEmp" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearch(1)"  />
				    </td>
				    <td align = "left" width="10%"><gw:icon id="BtnPassGrid" img="in" text = "Pass" alt="Pass selected employee to Course result" onclick="PassGrid(true)" /></td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="3" >
						<gw:grid   
						id="grdListEmp"  
						header="_PK|_Emp PK|Emp ID|Emp Name|_Height|_Weight|_Jacket Size|_Trouse Size|_Shoes Size|Receive Location|Laundary Location|_Active"
						format ="0|0|0|0|2|2|0|0|0|0|0|0"
						aligns ="0|0|0|0|0|0|0|0|0|0|0|0"
						default="0|0|0|0|0|0|0|0|0|0|0|0"
						editcol="0|0|0|0|0|0|0|0|0|0|0|0"
						widths ="0|0|0|2500|2000|0|0|0|0|2000|1500|0"
						styles="width:100%; height:100%"   
						sorting="T"   
						acceptNullDate="T"
						param="0,1,2,3,4" oncelldblclick="PassGrid(true)"  />
					</td>
				</tr>
			</table>
        </td>
        <!------------------------------------------------------------------->
        <td width="65%" style="background: white">
            <table width="100%" width="100%" height="100%">
                <tr valign="top" style="background: #BDE9FF" height="5%" >        
                    <td style="background: white">
                        <table width="100%" border="0">
                            <tr width="100%">
                                <td width="14%" align="right" >Create Dated</td>
                                <td width="6%"><gw:datebox id="dtDateF" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>
                                <td width="1%">~</td>
                                <td width="6%"><gw:datebox id="dtDateT" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>
                                <td width="5%"></td>
                                <td width="7%" align="right" >Status</td>
                                <td width="15%"><gw:list  id="lstStatus" value = "ALL" styles='width:100%'onchange="OnSearch(2)" ></gw:list></td>
                                <td width="12%" align="right"><a style="color:Blue"><gw:label id="lbRecord"   styles="width:100%" text="record(s)" /></a></td>
                                <td width="2%" ><gw:imgBtn img="search" alt="Search"   onclick ="OnSearch(2)"/></td>
                                <td width="2%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete()"/></td>
                                <td width="2%" ><gw:imgBtn img="udelete"alt="UnDelete" onclick ="OnUnCancel()"/></td>
                                <td width="2%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave()"/></td>
                            </tr>
                        </table>
                    </td>           
                </tr>
                <tr valign="top" height="90%">
                    <td colspan="2" width="100%" >
                        <gw:grid   
                        id="grdData"  
                        header="_PK|Employee|Status|Order No|Req Qty|Item|Size|Amount|Receiving Location|Laundry Location|_Emp PK|Remark"
                        format="0|0|0|0|2|0|2|2|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="||60||1|||||||"
                        editcol="0|1|1|1|1|1|1|1|1|1|1|1"
                        widths="1000|3000|1200|1500|1000|2500|1000|1000|2000|2000|2000|2000"
                        styles="width:100%; height:100%"   
                        sorting="T" onafteredit="AfterEdit()" oncellclick="OnClick()"
                        />
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
</table>
<gw:grid id='grdEmp'
    header='PK|EMP|RECEIVE_LOC|LAUNDRY_LOC'
    format='0|00||0'
    aligns='0|0|0'
    defaults='|||'
    editcol='1|1|1|1'
    widths='1000|1410|1000'
    sorting='T'
    styles='width:100%;height:50;display:none'
/>

<gw:textbox id="txtLogID"     styles="width:100%;display:none" />
<gw:textbox id="txtEmpPK"     styles="width:100%;display:none" />
<gw:textbox id="txtType"      styles="width:100%;display:none" />
<gw:textbox id="txtSize"      styles="width:100%;display:none" />
<gw:textbox id="txtTempPK"    styles="width:100%;display:none" /> 
<gw:textbox id="txtUniformPK" styles="width:100%;display:none" />
</body>