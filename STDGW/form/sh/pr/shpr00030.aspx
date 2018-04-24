<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Break Down Register</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var G1_pk           = 0,  
    G1_lotno        = 1,
    G1_st_count     = 2,
    G1_ed_count     = 3,
    G1_dip_qty      = 4,
    G1_drum         = 5,
    G1_from_date    = 6,
    G1_st_time      = 7,
    G1_ed_time      = 8,
    G1_thr_employee_pk = 9,
    G1_emp_id       = 10,
    G1_full_name    = 11,
    G1_tsh_porder_m_pk = 12;   
var emp_pk, user_id, user_name;    
//===============================================================

function BodyInit()
{
    emp_pk  = "<%=Session("EMPLOYEE_PK")%>" ;
    user_id = "<%=Session("EMP_ID")%>" ;
    user_name = "<%=Session("USER_NAME")%>" ;
    //------------------
	BindingDataList();
	FormatGrid();	
}
//===============================================================

function BindingDataList()
{ 
    txtProdName.SetEnable(false);
    txtCustomerName.SetEnable(false);
    txtSize.SetEnable(false);
    txtSizeName.SetEnable(false);
    txtPrint.SetEnable(false);
    txtColorCode.SetEnable(false);
    txtColorName.SetEnable(false);
    txtEstimateQty.SetEnable(false);
    txtLotNO.SetEnable(false);
    txtMachineNO.SetEnable(false);
    txtProdCode.SetEnable(false);
    txtCustomerCode.SetEnable(false);
    txtEstimateQty.SetEnable(false);    
    
    var data = "";
    data =  "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
    lstCompany.SetDataText(data);
   // lstCompany.value= company_pk;
}

//===============================================================

function OnSearch()
{
    data_shpr00020.Call('SELECT');
}
//===============================================================
 function FormatGrid()
 {
      var trl ;
      
      trl = grdDipping.GetGridControl();
      	
      trl.ColFormat(G1_st_count )   = "###,###,###,###,###";   
      trl.ColFormat(G1_ed_count )   = "###,###,###,###,###";  
      trl.ColFormat(G1_dip_qty )   = "###,###,###,###,###";  
      trl.ColFormat(G1_drum )   = "###,###,###,###,###";  
      
      trl.ColEditMask(G1_st_time) = "99:99";
      trl.ColEditMask(G1_ed_time)   = "99:99"; 
      
 }
//===============================================================

function OnNew()
{    
    if(txtLotNO.text=='')
    {
        alert('Please select LOT No first!!!');
        return;
    }
    
    grdDipping.RemoveRowAt(grdDipping.rows-1);
    
    if(grdDipping.rows==1)
        startNo = 1;
    else
        startNo = Number(grdDipping.GetGridData(grdDipping.rows-1,G1_ed_count)) +1;
     
     grdDipping.AddRow();
     grdDipping.SetGridText(grdDipping.rows-1, G1_st_count,     startNo);
     grdDipping.SetGridText(grdDipping.rows-1, G1_lotno,        txtLotNO.text);
     grdDipping.SetGridText(grdDipping.rows-1, G1_thr_employee_pk, emp_pk);
     grdDipping.SetGridText(grdDipping.rows-1, G1_emp_id,       user_id); 
     grdDipping.SetGridText(grdDipping.rows-1, G1_full_name,    user_name);
     grdDipping.SetGridText(grdDipping.rows-1, G1_tsh_porder_m_pk,txtLotNOPK.text);
     grdDipping.Subtotal( 0, 2, -1, '4','###,###,###');
}
//===============================================================

function OnDelete()
{
    if ( confirm ( "Do you want to delete this Dipping?" ) )
    {
        //grdDipping.DeleteRow();
        if ( grdDipping.GetGridData( grdDipping.row,G1_pk ) == '' ) 
        {
            grdDipping.RemoveRow();
        }
        else
        {
            grdDipping.DeleteRow();
        }  
    }
}
//===============================================================
function OnPopUp(obj)
{
    switch(obj)
    {
        case 'LotNo':
            var fpath = System.RootURL + "/form/sh/ab/shab00040.aspx?";
            var object = System.OpenModal( fpath , 650 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                txtLotNOPK.text = object[0];
                txtLotNO.text = object[4];
                data_shab00030_1.Call('SELECT');
            }
        break;
        case 'Emp':
            if(grdDipping.row>0)
            {
                if((event.col == G1_emp_id) || (event.col ==G1_full_name))
                {
                    var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
                    var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
                    if ( obj != null )
                    {
                        grdDipping.SetGridText(event.row, G1_thr_employee_pk, obj[0]);
                        grdDipping.SetGridText(event.row, G1_emp_id, obj[3]);
                        grdDipping.SetGridText(event.row, G1_full_name, obj[5]);
                    }
               }
           }	
        break;
    }
 }           
//===============================================================

function OnUnDelete()
{
    grdDipping.UnDeleteRow();
}
//===============================================================

function OnSave()
{  
    grdDipping.SetRowStatus(grdDipping.rows-1, '');
    if(OnValidateData())
        data_shab00030_2.Call();    
}
//=====================================================================================
 function CheckInput()
 {
    var col, row
    col = event.col
    row = event.row       
    
    if(col == G1_ed_count)
    {
        var st_count, ed_count, dip;
        st_count = grdDipping.GetGridData(row,G1_st_count); 
        ed_count = grdDipping.GetGridData(row,G1_ed_count); 
        
        dip = (Number(ed_count) - Number(st_count) +1)*210
       
        if(Number(dip)<=0)
        {
            alert("End No must be greater than Start No!!!");
            grdDipping.SetGridText(event.row, G1_dip_qty, '');
            grdDipping.SetGridText(event.row, G1_ed_count, '');
        }
        else
        {
            grdDipping.SetGridText(event.row, G1_dip_qty, dip)
        }
        grdDipping.Subtotal( 0, 2, -1, '4','###,###,###');   
    }    
        
    if ( col == G1_st_time || col == G1_ed_time )
	{
		tmpIN = grdDipping.GetGridData(event.row,col)
		
		if ( tmpIN.length == 0 )
		{
			grdDipping.SetGridText(event.row, col, "")
			
		}
		if( ( tmpIN.length !=4 ) && ( tmpIN.length !=0 ) )
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdDipping.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdDipping.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdDipping.SetGridText(event.row,col,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdDipping.SetGridText(event.row,col,tmpIN)
		}    
	}
        
        
    if ( col == G1_from_date || col == G1_st_time || col == G1_ed_time )
    {                
    //------------------------------------------                
        var start_dt,start_time, end_dt, end_time, start, end ;
 
        start_dt = grdDipping.GetGridData(row,G1_from_date);
        start_time = grdDipping.GetGridData(row,G1_st_time);
        end_time = grdDipping.GetGridData(row,G1_ed_time); 
        
        if (start_dt !='' && start_time!='' && end_dt!='' && end_time !='')
        {
            start= start_dt + start_time.replace(":","");
            end = start_dt + end_time.replace(":","");
            
            if(Number(start) > Number(end))
            {
                alert("End time must be greater than Start time!!!");
                return;
            }
        }
        
    //------------------------------------------        
    } 
 }
//===============================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_shab00030_1':
            data_shab00030_2.Call('SELECT');
        break;
        case 'data_shab00030_2':
            for(i=1; i<grdDipping.rows-1; i++)
            grdDipping.SetRowEditable(i,0);
            grdDipping.Subtotal( 0, 2, -1, '4','###,###,###');   
        break;
    }    
}
//====================================================================================
function OnValidateData()
{
    for(var i =1;i<grdDipping.rows-1;i++)
    {
        if(grdDipping.GetRowStatus(i) !=64 )
        {
            if(Number(grdDipping.GetGridData(i,G1_ed_count))<=0)
            {
                alert("End  No must be greater Start No!!!");
                return false;
            }
            if(Number(grdDipping.GetGridData(i,G1_drum))<=0)
            {
                alert("Please enter Drums!!!");
                return false;
            }
        }
    }
    return true;
}
//===============================================================
</script>

<body>
    <gw:data id="data_shab00030_1" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="control" function="prod.sp_sel_shpr00030_1" > 
                <inout> 
                     <inout  bind="txtLotNOPK" />
                     <inout  bind="txtLotNO" />
                     <inout  bind="txtMachineNO" />
                     <inout  bind="txtProdCode" />
                     <inout  bind="txtProdName" />
                     <inout  bind="txtCustomerCode" />
                     <inout  bind="txtCustomerName" />
                     <inout  bind="txtSize" />
                     <inout  bind="txtSizeName" />
                     <inout  bind="txtPrint" />
                     <inout  bind="txtColorCode" />
                     <inout  bind="txtColorName" />
                     <inout  bind="txtEstimateQty" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shab00030_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="prod.sp_sel_shpr00030_2" procedure="prod.sp_udp_shpr00030_2">
                <input bind="grdDipping" >
                    <input bind="txtLotNOPK" />
                </input>
                <output bind="grdDipping" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">          
            <td style="width: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%"> 
                        <td style="width: 45%">
                            <fieldset style="padding: 5">
                                  <table style="height: 100%; width: 100%" cellpadding=0 cellspacing=6 border=0>
                                     <tr style="height: 1%" >
                                        <td style="width: 20%">
                                            Company
                                        </td>
                                        <td style="width: 80%; white-space: nowrap" >
                                            <gw:list id="lstCompany" styles='width:100%'  />
                                        </td>
                                     </tr>
                                     <tr style="height: 1%" >
                                        <td style=" white-space: nowrap">
                                            Machine No
                                        </td>
                                        <td  >
                                            <gw:textbox id="txtMachineNO" styles='width:100%'  />
                                        </td>
                                     </tr>
                                     <tr style="height: 1%" >
                                        <td style=" white-space: nowrap">
                                            <a title="Click here to select Lot No" onclick="OnPopUp('LotNo')" href="#tips" style="text-decoration: none;
                                                color:#0000ff"><b>LOT No</b></a>
                                        </td>
                                        <td  >
                                            <gw:textbox id="txtLotNO" styles='width:100%' csstype="mandatory" />
                                        </td>
                                     </tr>
                                 </table>
                            </fieldset>
                        </td>
                        <td style="width: 55%">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 15%" align="right">
                                        Product Code
                                    </td>
                                    <td style="width: 25%; white-space: nowrap" >
                                        <gw:textbox id="txtProdCode" styles='width:100%'  />
                                    </td>
                                    <td colspan=2>
                                        <gw:textbox id="txtProdName" styles='width:100%' csstype="filter"  />
                                    </td>                                    
                                </tr>
                                <tr style="height: 1%">
                                    <td style=" white-space: nowrap" align="right">
                                        Customer Code
                                    </td>
                                    <td>
                                        <gw:textbox id="txtCustomerCode" styles='width:100%'  />
                                    </td>
                                    <td colspan=2>
                                        <gw:textbox id="txtCustomerName" styles='width:100%' csstype="filter" />
                                    </td>                                    
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right">
                                        Size
                                    </td>
                                    <td style="white-space:nowrap">
                                        <gw:textbox id="txtSize" styles='width:50%' csstype="filter" />
                                        <gw:textbox id="txtSizeName" styles='width:50%' csstype="filter" />
                                    </td>
                                    <td style="width: 30%" align=right>
                                        Printing
                                    </td>  
                                    <td style="width: 30%; white-space: nowrap" >
                                        <gw:textbox id="txtPrint" styles='width:100%' csstype="filter" />
                                    </td>                                  
                                </tr>
                                <tr style="height: 1%">
                                    <td style=" white-space: nowrap" align="right">
                                        Color Code
                                    </td>
                                    <td>
                                        <gw:textbox id="txtColorCode" styles='width:100%' csstype="filter" />
                                    </td>
                                    <td >
                                        <gw:textbox id="txtColorName" styles='width:100%' csstype="filter" />
                                    </td>     
                                    <td></td>                               
                                </tr>
                                <tr style="height: 1%">
                                    <td style=" white-space: nowrap" align="right">
                                        Estimated Q'ty
                                    </td>
                                    <td colspan=2>
                                        <gw:textbox id="txtEstimateQty" styles='width:100%' type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                    <td >
                                    </td>                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                 </table>  
            </td> 
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 100%">
                        <td style="width: 95%" align=right>
                        </td>
                        <td style="width: 1%" align=right>
                            <gw:imgbtn img="search" alt="Search" onclick="data_shab00030_2.Call('SELECT');" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 97%">
            <td >
                <gw:grid id="grdDipping" 
                    header='_pk|_Lotno|Start No|End No|Dip Qty|Drums|Date|Start Time|End Time|_thr_employee_pk|Emp ID|Full Name|_tsh_porder_m_pk'
                    format='0|0|0|0|0|0|4|0|0|0|0|0|0' aligns='0|0|3|3|3|3|0|0|0|0|0|0|0'
                    defaults='||||||||||||' editcol='0|0|0|1|0|1|1|1|1|1|0|0|0'
                    widths='0|0|1200|1200|1300|950|1250|1000|1000|0|1000|2000|0'
                    acceptnulldate="T"  onafteredit="CheckInput()"   oncelldblclick ="OnPopUp('Emp')"
                    sorting='F' styles="width:100%;height:100%" editcolcolor ="T"  />
            </td>
        </tr>
    </table>
</body>
<gw:datebox id="dtnow" style="display:none" lang="1" />
<gw:textbox id="txtStartDT" styles="display:none" />
<gw:textbox id="txtStartTime" styles="display:none" />
<gw:textbox id="txtEndDT" styles="display:none" />
<gw:textbox id="txtLotNOPK" styles="display:none" />
<gw:textbox id="txtEndTime" styles="display:none" />
<gw:textbox id="txtRtnValue" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html> 
