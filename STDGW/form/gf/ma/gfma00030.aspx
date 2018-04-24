<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
<script>
var flag;
var flag_s;
function BodyInit()
{
    System.Translate(document);
    var data;
    var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_date_fr     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
	var ls_date_to     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD') FROM DUAL")%>";
	
    OnChangeCompany();
    
    
    lstCompany.SetDataText(ls_data);
    dtPropos_fr.SetDataText(ls_date_fr);
    dtPropos_to.SetDataText(ls_date_to);
//     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";
//     lstStatus.SetDataText(data);
//     lstStatus.SetDataText(data + "|ALL|Select ALL");
//     lstStatus.SetDataText('ALL');
     data = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>"); 
     lstDept.SetDataText(data);
     lstDept.SetDataText(data + "|0|Select ALL");
      data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //ccy
     lstccy.SetDataText(data+"|ALL|Select ALL");
  
    
    var tempGrid = gridS.GetGridControl();
    tempGrid.FixedCols = 1;
    
    gridS.GetGridControl().WordWrap = true;
	//gridS.GetGridControl().RowHeight(0) = 350 ;
    gridS.AddRow();
    gridS_sum.AddRow();
    MergeHeaderGrid();
    MergeHeaderGrid_S();
   
}
//-------------------------------------------------------------------------------------

function OnChangeCompany()
{
	datDeptData.Call("SELECT");
}

function MergeHeaderGrid()
{
	    var fg = gridS.GetGridControl();
	    
	    if(fg.rows == 1)
	    {
		    grdMaster.AddRow();
	    }
	    //fg.Cell(17, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold	
	    
	    gridS.SetCellBold(1,1,1,17,true);	
        fg.FixedRows = 2;
        fg.MergeCells =5;
		fg.MergeRow(0) = true;
        // Acc
        fg.MergeCol(0) = true;
        fg.Cell(0,0,0,1,0)  = "Seq";
        fg.MergeCol(1) = true;
        fg.Cell(0,0,1,1,1)  = "Trans Date";
        fg.MergeCol(2) = true;
        fg.Cell(0,0,2,1,2)  = "No";
        
        fg.MergeCol(3) = true;
        fg.Cell(0,0,3,1,3)  = "PV No";
        
        fg.MergeCol(4) = true;
        fg.Cell(0,0,4,1,4)  = "PV Date";
        
        fg.MergeCol(5) = true;
        fg.Cell(0,0,5,1,5)  = "Due Date";
        
        fg.MergeCol(6) = true;
        fg.Cell(0,0,6,1,6)  = "Age";
        
        fg.MergeCol(7) = true;
        fg.Cell(0,0,7,1,7)  = "Over Due Date";
        
        fg.MergeCol(8) = true;
        fg.Cell(0,0,8,1,8)  = "Trans. ccy";
        
        fg.MergeCol(9) = true;
        fg.Cell(0,0,9,1,9)  = "Ex. Rate";
        
        fg.MergeRow(0) = true;
        fg.Cell(0,0,10,0,11) = "PV Amount";
        fg.Cell(0,1,10,1,10) = "Transaction";
        fg.Cell(0,1,11,1,11) = "Booking";
        
        fg.Cell(0,0,12,0,13) = "Clear Amount";
        fg.Cell(0,1,12,1,12) = "Transaction";
        fg.Cell(0,1,13,1,13) = "Booking";
        
        fg.Cell(0,0,14,0,15) = "Balance Amount";
        fg.Cell(0,1,14,1,14) = "Transaction";
        fg.Cell(0,1,15,1,15) = "Booking";
        
        fg.Cell(0,0,16,0,17) = "Description";
        fg.Cell(0,1,16,1,16) = "Foreign";
        fg.Cell(0,1,17,1,17) = "Local";
        
        fg.ColFormat(9)  = "#,###,###,###,###.##";
        fg.ColFormat(10) = "#,###,###,###,###.##";
        fg.ColFormat(11) = "#,###,###,###,###.##";
        fg.ColFormat(12) = "#,###,###,###,###.##";
        fg.ColFormat(13) = "#,###,###,###,###.##";
        fg.ColFormat(14) = "#,###,###,###,###.##";
        fg.ColFormat(15) = "#,###,###,###,###.##";
        fg.ColFormat(16) = "#,###,###,###,###.##";
        
        fg.ColWidth(0)=1000;  // trhpk.
        fg.ColWidth(1)=1000; // adv pk
        fg.ColWidth(2)=700; // No
        fg.ColWidth(3)=2000; // PV no
        fg.ColWidth(4)=1300; // PV date   
        fg.ColWidth(5)=1300;  // Due date
        fg.ColWidth(6)=800;  // Age
        fg.ColWidth(7)=1000; // Over due date
        fg.ColWidth(8)=1000; // Trans. ccy
        fg.ColWidth(9)=1500; // Ex. rate   
        fg.ColWidth(10)=1800;  // pv trans. amt
        fg.ColWidth(11)=1800;  // pv booking amt
        fg.ColWidth(12)=1800; // clear trans. amt
        fg.ColWidth(13)=1800; // clear booking amt
        fg.ColWidth(14)=1800; // bal trans. amt  
        fg.ColWidth(15)=1800;  // bal booking amt
        fg.ColWidth(16)=1800;  // Description foreign
        fg.ColWidth(17)=1800; // Description local  
       
        
}
function MergeHeaderGrid_S()
{       
    var fg_s = gridS_sum.GetGridControl();
        if(gridS_sum.rows <2)
           {
                gridS_sum.AddRow();
           } 
        gridS_sum.Rows =2;
        gridS_sum.SetCellBold(1,1,1,8,true);	     	
        fg_s.FixedRows = 2;
        fg_s.MergeCells =5;
		fg_s.MergeRow(0) = true;        
                  
        fg_s.MergeCol(0) = true;
        fg_s.Cell(0,0,0,1,0)  = "Grand";        
          
        fg_s.MergeCol(1) = true;
        fg_s.Cell(0,0,1,1,1)  = "Trans. Ccy";
        
        fg_s.MergeCol(2) = true;
        fg_s.Cell(0,0,2,1,2)  = "Ex. Rate";     
       
        
        fg_s.MergeRow(3) = true;
        fg_s.Cell(0,0,3,0,4) = "PV Amount";
        fg_s.Cell(0,1,3,1,3) = "Transaction";
        fg_s.Cell(0,1,4,1,4) = "Booking"; 
           
         
        fg_s.Cell(0,0,5,0,6) = "Clear Amount";        
        fg_s.Cell(0,1,5,1,5) = "Transaction";
        fg_s.Cell(0,1,6,1,6) = "Booking";        
        
        fg_s.Cell(0,0,7,0,8) = "Balance Amount";
        fg_s.Cell(0,1,7,1,7) = "Transaction";
        fg_s.Cell(0,1,8,1,8) = "Booking";
        
        
        fg_s.ColFormat(2) = "#,###,###,###,###.##";
        fg_s.ColFormat(3) = "#,###,###,###,###.##";
        fg_s.ColFormat(4) = "#,###,###,###,###.##";
        fg_s.ColFormat(5) = "#,###,###,###,###.##";
        fg_s.ColFormat(6) = "#,###,###,###,###.##";
        fg_s.ColFormat(7) = "#,###,###,###,###.##";
        fg_s.ColFormat(8) = "#,###,###,###,###.##";
        
        
        
        fg_s.ColWidth(0)=1300; // Grand
        fg_s.ColWidth(1)=1000; // Trans. ccy
        fg_s.ColWidth(2)=1000; // Ex. rate   
        fg_s.ColWidth(3)=1800;  // pv trans. amt
        fg_s.ColWidth(4)=1800;  // pv booking amt
        fg_s.ColWidth(5)=1800; // clear trans. amt
        fg_s.ColWidth(6)=1800; // clear booking amt
        fg_s.ColWidth(7)=1800; // bal trans amt  
        fg_s.ColWidth(8)=1800; // bal booking amt
}
//------------------------------------------------------------
function OnPopUp(pos)
{
    switch (pos)
    {
        case '0':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtEmpNM.text    = obj[2];
                txtEmppk.text  = obj[0];
                txtEmpID.text=obj[1];
                lstDept.SetDataText(obj[13]);
            }
            break;
        case '1':
            var v_tac_emp_adv_req_pk=gridS.GetGridData(gridS.row,0);           
            var path = System.RootURL + '/form/gf/ma/gfma00010_1.aspx?tac_empadvreq_pk='+v_tac_emp_adv_req_pk;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');          
            break;
        case '2': 
            var ctrl 	= gridS.GetGridControl();
	        var rows    = ctrl.Rows
	        rows = rows - 1;
	        var rownum  	= ctrl.Row;
	        var colnum  	= ctrl.Col;
	        if (rownum > 0)		 
	        {
	            var pk      = gridS.GetGridData(ctrl.row, 1);			        
		        var ls_arr = "";       
    			
		        var fpath   = System.RootURL + '/form/gf/hg/gfhg00020_popup.aspx?PK_ROW=' + pk + '&ROW=' + ctrl.row + '&ROWS=' + rows + '&APPRCANCEL=' + status + "&ARRAY_PK=" + ls_arr;
		        var wWidth  = 950;
		        var wHeight = 580;
		        var x = Math.round((screen.availWidth - wWidth)/2);
		        var y = Math.round((screen.availHeight - wHeight)/2);
    			
		        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
		           "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
		           "lef="+ x +",top=" + y;
		        this.name = "gfhg00020";
		        var object = System.OpenModal(fpath, wWidth, wHeight, features,window);	          
            }
        
//            var v_tac_hgtrh_pk=gridS.GetGridData(gridS.row,1);           
//            var path = System.RootURL + '/form/gf/ma/gfma00010_1.aspx?tac_empadvreq_pk='+v_tac_hgtrh_pk;
//            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');          
            break;            
    }
    
}

function OnPrint(type)
{   
    switch(type)
    {
        case 'Sum':
            var par="p_Company="+lstCompany.GetData()+"&p_Propos_fr="+dtPropos_fr.GetData()+"&p_Propos_to="+dtPropos_to.GetData()+"&p_Voucherno="+txtVoucherno.GetData()+"&p_Dept="+lstDept.value+"&p_Emppk="+txtEmppk.GetData()+"&p_ccy="+lstccy.value;
            var path = System.RootURL + '/reports/gf/ma/rpt_gfma00030.aspx?'+par;           
            window.open(path);  
            break;
         case 'Dtl':
            if (gridS.row>=2)
            {
                var par="p_tac_empadvreq_pk="+gridS.GetGridData(gridS.row, 0)+"&p_tco_company_pk="+lstCompany.GetData();
                var path = System.RootURL + '/reports/gf/ma/rpt_gfma00030_1.aspx?'+par;           
                window.open(path); 
             }
             else
                alert("Please select at least a row");
            break;
    }
}

function OnSearch()
{
    dat_gfma00030.Call("SELECT");    
}
function OnDataReceive(obj)
{
    if (obj.id=="dat_gfma00030")
        {   
            MergeHeaderGrid();          
            dat_gfma00030_1.Call("SELECT");                
                   
        }    
     if (obj.id=="dat_gfma00030_1")
        {               
            MergeHeaderGrid_S();            
                   
        }       
}

</script>
<body style="margin:0; padding:0;">
<!--gw:data id="dso_sel_grd_dtl_slip_daily_aggregate" onreceive="OnTotal()">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_DAILY_AGGREGATE">
                <input bind="grid">
                    <input bind="lstCompany"/>
                    <input bind="dtPropos_fr"/>
                    <input bind="dtPropos_to"/>
                    <input bind="rbstatus"/>
                </input>
                <output bind="grid"/>
            </dso>
        </xml>
    </gw:data-->
    
<gw:data id="dat_gfma00030"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="acnt.sp_sel_gfma00030"   > 
            <input bind="gridS">   
                <input bind="lstCompany" />                 
                <input bind="dtPropos_fr" />
                <input bind="dtPropos_to" />  
                <input bind="txtVoucherno" />                
                <input bind="lstDept" />               
                <input bind="txtEmppk" />
                <input bind="lstccy" />
            </input> 
            <output bind="gridS" /> 
        </dso> 
    </xml> 
</gw:data>  
<gw:data id="dat_gfma00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="acnt.sp_sel_gfma00030_1"   > 
            <input bind="gridS_sum">   
                <input bind="lstCompany" />                 
                <input bind="dtPropos_fr" />
                <input bind="dtPropos_to" />  
                <input bind="txtVoucherno" />                
                <input bind="lstDept" />               
                <input bind="txtEmppk" />
                <input bind="lstccy" />
            </input> 
            <output bind="gridS_sum" /> 
        </dso> 
    </xml> 
</gw:data>  
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="list" procedure="ACNT.SP_LIST_DEPT" > 
            <input>
                <input bind="lstCompany" /> 
            </input> 
            <output>
                <output bind="lstDept" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr style="height:10%">
    <td width="100%">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
            <td width="100%">
	            <table width="100%" cellpadding="0" cellspacing="0" border="0">
		        <tr>
                    <td width="10%"></td>
                    <td width="20%"></td>
                    <td width="12%"></td>
                    <td width="6%"></td>
                    <td width="1%"></td>
                    <td width="6%"></td>
                    <td width="12%"></td>
                    <td width="10%"></td>
                    <td width="9%"></td>
                    <td width="20%"></td>
                    <td width="3%"></td>
                </tr>
                <tr>
                    <td align="left">Company</td>
                    <td><gw:list id="lstCompany" onchange="OnChangeCompany()" value ="" styles='width:100%'></gw:list></td>
                    <td align="right">Voucher Date</td>
                    <td><gw:datebox id="dtPropos_fr" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtPropos_to" 	onchange="" styles='width:100%' lang="1"/></td>
                     <td align="right">Voucher no</td>
                    <td><gw:textbox id="txtVoucherno" onchange="" styles="width:100%;" /></td>
                    <td align="right">&nbsp;</td>
                    <td>&nbsp;</td>                   
                    <td align="left">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td><gw:imgBtn id="btnSearch"   img="search"    alt="Search"    onclick="OnSearch()"/></td>
                            <td><gw:imgBtn id="btnPopup"   img="popup"    alt="Popup"    onclick="OnPopUp('2')"/></td>
                            <td><gw:imgBtn id="btnPrint"    img="printer"   alt="Print Summary"     onclick="OnPrint('Sum')"/></td>
                            <td><gw:imgBtn id="btnPrint"    img="printer"   alt="Print Detail"     onclick="OnPrint('Dtl')"/></td>
                            <td width="95%"></td>
                        </tr>
                        </table>
                    </td>
                </tr>
               <tr>
                    <td  align="left"> Department</td>
                    <td align="center"><gw:list id="lstDept" text="" styles="width:100%"/></td>
                    <td colspan="" align=right><a title="Click here to select Requester" onclick="OnPopUp('0')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Employee</b></a></td>
                    <td colspan=""><gw:textbox id="txtEmpID" /><gw:textbox id="txtEmppk" styles="display:none" /></td>
                    <td colspan="4"><gw:textbox id="txtEmpNM" /></td>
                    <td  align=right>Trans. ccy</td>
                    <td colspan="2"><gw:list id="lstccy" /></td>
               </tr> 
                </table>
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr style="height:65%">
    <td width="100%">
	    <gw:grid   
		    id="gridS"
		    header  ="_tac_empadvreq_pk|_tac_hgtrh_pk|No.|PV No.|VC date|Due date|Age|Over due date|Trans. ccy|Ex. rate|pv Transaction|pv Booking|clear transaction|clear booking| balance transaction| balance booking| Description foreign|Description Local"
		    format  ="0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0" 
	        aligns  ="0|0|3|0|1|1|3|3|0|3|3|3|3|3|3|3|0|0" 
		    defaults="|||||||||||||||||"  
		    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
		    widths  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
		    styles  ="width:100%; height:100%"
		    sorting ="T"   
		    oncelldblclick="OnPopUp('1')"
		    />
    </td>
</tr>
<tr style="height:35%">
<td>
    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
        <tr>
            <td width=30%>&nbsp;</td>
            <td width=70%>
               <gw:grid   
		            id="gridS_sum"	
		            header  ="Grand|Trans. ccy|Ex. rate|pv Transaction|pv Booking|clear transaction|clear booking| balance transaction| balance booking"	            
		            format  ="0|0|0|0|0|0|0|0|0" 
	                aligns  ="0|0|3|3|3|3|3|3|3" 
		            defaults="||||||||"  
		            editcol ="0|0|0|0|0|0|0|0|0"
		            widths  ="1800|1500|1800|1800|1800|1800|1800|1800|1800"
		            styles  ="width:100%; height:100%"
		            sorting ="T"   		            
		            /> 
            </td>
        </tr>
    </table>
</td>    
</tr>
</table>
<gw:textbox id="txtTotalRow" styles="display:none;" />

</body>
</html>
