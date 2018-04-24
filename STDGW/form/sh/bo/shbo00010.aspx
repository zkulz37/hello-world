<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<head id="Head1" >
    <title>Additive Solution Preparation Instruction and Record</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var flag ='';
    
var G1_pk               = 0,
    G1_tsh_main_m_pk    = 1,  
    G1_work_date        = 2,
    G1_seqno            = 3,
    G1_tank_seqno       = 4,
    G1_tank_no          = 5,
    G1_trim_batchno1    = 6,
    G1_trim_qty1        = 7,
    G1_gel_batchno      = 8,
    G1_gelatin_qty      = 9,
    G1_colpack_batchno  = 10,
    G1_colpack_qty      = 11,
    G1_color_check      = 12,
    G1_cap_gu           = 13
    G1_col_codecap      = 14,
    G1_col_codebody     = 15,
    G1_add_type_no      = 16,
    G1_lotno            = 17;
 //---------------------------------------------------------

 function BodyInit()
 {
    grdCap.AddRow();
    grdBody.AddRow();
    SetHeader(1);
    SetHeader(2);
    FormatGrid();
    
    txtLotNO.SetEnable(false);
    txtProdCode.SetEnable(false);
    txtProdName.SetEnable(false);
    txtColorCap.SetEnable(false);
    txtColorBody.SetEnable(false);
    txtCustomerCode.SetEnable(false);
    txtCustomerName.SetEnable(false);
    txtEstimatedQty.SetEnable(false);
    txtBlendingNo.SetEnable(false);
    txtSizeCode.SetEnable(false);
    txtSizeName.SetEnable(false);
    txtAdditive.SetEnable(false);
 }
 //=============================================================================
function SetHeader(idx)
{    
    switch(idx)
    {
        case 1:
            var fg = grdCap.GetGridControl();             
            grdCap.SetCellBold( 1, 1, 1, G1_color_check, true);
        break;
        case 2:
            var fg = grdBody.GetGridControl();             
            grdBody.SetCellBold( 1, 1, 1, G1_color_check, true);
        break;
    }
    fg.FixedRows = 2
    fg.MergeCells = 5  
    fg.MergeCol( G1_work_date) = true;	    
    fg.Cell(0, 0, G1_work_date, 1, G1_work_date) = "Date";
    
    fg.MergeCol( G1_seqno) = true;	 
    fg.Cell(0, 0, G1_seqno, 1, G1_seqno) = "Seq \n No";
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, G1_tank_seqno,0, G1_tank_no) = "M/Tank";
        fg.Cell(0, 1, G1_tank_seqno, 1) = "Seq";
        fg.Cell(0, 1, G1_tank_no, 1) = "No";
   
  
   fg.Cell(0, 0, G1_trim_batchno1, 0, G1_trim_qty1) = "Trimming";
        fg.Cell(0, 1, G1_trim_batchno1, 1) = "Batch No";
        fg.Cell(0, 1, G1_trim_qty1, 1) = "Amount(kg)";
        
   fg.Cell(0, 0, G1_gel_batchno, 0, G1_gelatin_qty) = "Gelatin";
        fg.Cell(0, 1, G1_gel_batchno, 1) = "Batch No";
        fg.Cell(0, 1, G1_gelatin_qty, 1) = "Amount(kg)";
       
	fg.Cell(0, 1, G1_colpack_batchno, 0, G1_colpack_qty) = "Colorant Pack";
        fg.Cell(0, 1, G1_colpack_batchno, 1) = "Batch No";
        fg.Cell(0, 1, G1_colpack_qty, 1) = "Amount(kg)";
        
    fg.MergeCol( G1_color_check) = true;	    
    fg.Cell(0, 0, G1_color_check, 1, G1_color_check) = "Check";    
}
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'LotNo':
            var fpath = System.RootURL + "/form/sh/ab/shab00110.aspx?DippingVN=N&machineNo=" + lstMachineNo.value;
            var object = System.OpenModal( fpath , 750 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtLotNO.text = object[0];
                flag="onload";
                data_shbo00010.Call('SELECT');
            }
        break;
        case 'Blending':
            var fpath = System.RootURL + "/form/sh/ab/shab00100.aspx?type=Blend";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtCap_GUPK.text     = object[0];
                txtCap_GUNo.text     = object[1];
                txtCap_GUDesc.text   = object[2];
                txtBlendingNo.text = object[3];
                shbo00020_2.Call('SELECT');
            }
        break;
        case 'Emp':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtEmpPk.text   = obj[0];
                    txtEmpID.text   = obj[4];
                    txtEmpName.text = obj[5];
               }	
        break;  
    }
}
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdCap.GetGridControl();
      trl.ColFormat(G1_trim_qty1 )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_gelatin_qty )   = "###,###,###,###,##0";
      trl.ColFormat(G1_colpack_qty )   = "###,###,###,###,##0.##0";
      
      trl = grdBody.GetGridControl();
      trl.ColFormat(G1_trim_qty1 )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_gelatin_qty )   = "###,###,###,###,##0";
      trl.ColFormat(G1_colpack_qty )   = "###,###,###,###,##0.##0";
      
      
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
    if(txttsh_main_m_pk.text =='')
    {
        alert('Please select LOT No first!!!');
        return;
    }
      switch (pos)         
      {		  
        case 'Cap':
            var seq=0;
            
            if(grdCap.rows==2)
                seq = 1;
            else
                seq = Number(grdCap.GetGridData(grdCap.rows-1, G1_seqno)) +1 ;
                
            if(seq>1)
            {
                if(grdCap.GetRowStatus(grdCap.rows-1)!=0 && grdCap.GetGridData(grdCap.rows-1,G1_pk)=="" )
                {
                    alert('Please save Cap first!!!');
                    return;
                }
            }    
            grdCap.AddRow();
            
           // grdCap.SetGridText(grdCap.rows-1, G1_work_date, dtToday.GetData());
            grdCap.SetGridText(grdCap.rows-1, G1_seqno, seq);
            grdCap.SetGridText(grdCap.rows-1, G1_tank_seqno, seq);
            grdCap.SetGridText(grdCap.rows-1, G1_tsh_main_m_pk, txttsh_main_m_pk.text);
            grdCap.SetGridText(grdCap.rows-1, G1_cap_gu,      'C');
            grdCap.SetGridText(grdCap.rows-1, G1_col_codecap, txtColorCap.text);
            grdCap.SetGridText(grdCap.rows-1, G1_col_codebody,txtColorBody.text);
            grdCap.SetGridText(grdCap.rows-1, G1_add_type_no, txtAdditive.text);
            grdCap.SetGridText(grdCap.rows-1, G1_lotno,       txtLotNO.text);
        break;              
        case 'Body' :
            var seq;
            
            if(grdBody.rows==2)
                seq = 1;
            else
                seq = Number(grdBody.GetGridData(grdBody.rows-1, G1_seqno)) +1 ;
            
            if(seq>1)
            {
                if(grdBody.GetRowStatus(grdBody.rows-1)!=0 && grdBody.GetGridData(grdBody.rows-1,G1_pk)=="" )
                {
                    alert('Please save Body first!!!');
                    return;
                }
            }       
            grdBody.AddRow();
            grdBody.SetGridText(grdBody.rows-1, G1_seqno, seq);
            grdBody.SetGridText(grdBody.rows-1, G1_tank_seqno, seq);
            grdBody.SetGridText(grdBody.rows-1, G1_tsh_main_m_pk, txttsh_main_m_pk.text);
            grdBody.SetGridText(grdBody.rows-1, G1_cap_gu, 'B');
            grdBody.SetGridText(grdBody.rows-1, G1_col_codecap, txtColorCap.text);
            grdBody.SetGridText(grdBody.rows-1, G1_col_codebody,txtColorBody.text);
            grdBody.SetGridText(grdBody.rows-1, G1_add_type_no, txtAdditive.text);
            grdBody.SetGridText(grdBody.rows-1, G1_lotno,       txtLotNO.text);
        break;
      }  
 }
 //---------------------------------------------------------
 function OnDelete(obj)
 {
    switch(obj)
    {
        case 'Cap':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdCap.DeleteRow();
              // data_shbo00010_1.Call();
            }
        break;
        case 'Body':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdBody.DeleteRow();
               //data_shbo00010_2.Call();
            }
        break;
    }
 }
 //---------------------------------------------------------
 function OnUnDelete(obj)
 {
      if ( confirm( "Do you want to Undelete?" ) ) 
        {
           obj.UnDeleteRow();
          // data_shbo00010_1.Call();
        }
    
 }
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'Cap':
            data_shbo00010_1.Call('SELECT');
        break;
        case'Body':
            data_shbo00010_2.Call('SELECT');
        break;
    }
 }
 //---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Cap' :
            if(OnValidateData('Cap'))
                data_shbo00010_1.Call();
        break;
        case 'Body':
            if(OnValidateData('Body'))
                data_shbo00010_2.Call();
        break;
      }  
 }
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shbo00010':
            data_shbo00010_1.Call('SELECT');
        break;
        case 'data_shbo00010_1':
            SetHeader(1);
            if(flag=="onload")
            {
                data_shbo00010_2.Call('SELECT');
            }
            if (grdCap.rows>2)
            {
                grdCap.SetCellFontColor( 2, G1_color_check, grdCap.rows-1, G1_color_check, 0x3333FF );
                grdCap.SetCellBold( 2, G1_color_check, grdCap.rows-1, G1_color_check, true );
            }   
        break;
        case 'data_shbo00010_2':
            SetHeader(2);
            flag='';
            if(grdBody.rows>2)
            {
                grdBody.SetCellBold( 2, G1_color_check, grdBody.rows-1, G1_color_check, true);
                grdBody.SetCellFontColor( 2, G1_color_check, grdBody.rows-1, G1_color_check, 0x3333FF );
            }    
        break;
        
    }
}
//----------------------------------------------------------
function OnGriddblClick(obj)
{
    col = event.col;
    row = event.row;
    
    switch(obj)
    {
        case 'Cap':
            switch(col)
            {
                case G1_color_check:
                    if(col==G1_color_check)
                    {
                        var tank_m_pk = grdCap.GetGridData(grdCap.row, G1_pk);
                        var seqno = grdCap.GetGridData(grdCap.row, G1_seqno);
                        var tankno = grdCap.GetGridData(grdCap.row, G1_tank_no);
                        //if(grdCap.GetGridData(grdCap.row, G1_pk) !='')
                        var status = grdCap.GetRowStatus(grdCap.row);
                        if((seqno !='')&& (tankno!=''))
                        {
                            var path = System.RootURL + '/form/sh/bo/shbo00011.aspx?Captype=C&tank_m_pk=' + tank_m_pk + "&seqno=" + seqno + "&tankno=" + tankno + "&gelqty=" +grdCap.GetGridData(grdCap.row, G1_gelatin_qty);
                            var obj = System.OpenModal( path ,600 , 330,  'resizable:yes;status:yes', this);
                            if ( obj != null )
                            {
                                if((obj=='Y') && (grdCap.GetGridData(grdCap.row, G1_color_check) != obj))
                                    grdCap.SetGridText(grdCap.row, G1_color_check, obj);
                                    grdCap.SetRowStatus(grdCap.row,status);
                            }	
                       }
                       else
                       {
                            alert('Please input Seq No or Tank No first!!!');
                       }
                    }
                break;
                case G1_trim_batchno1:
                    var fpath = System.RootURL + "/form/sh/ab/shab00130.aspx?color=" + txtColorCap.text;
                    var object = System.OpenModal( fpath , 450 , 350 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                       grdCap.SetGridText(grdCap.row, G1_trim_batchno1, obj);
                    }
                break;
                case G1_colpack_batchno:
                    var fpath = System.RootURL + "/form/sh/ab/shab00140.aspx?color=" + txtColorCap.text;
                    var object = System.OpenModal( fpath , 450 , 350 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                       grdCap.SetGridText(grdCap.row, G1_colpack_batchno, obj);
                    }
                break;
            }
        break;
        case 'Body':
            switch(col)
            {
                case G1_color_check:
                    if(col==G1_color_check)
                    {
                        var tank_m_pk = grdBody.GetGridData(grdBody.row, G1_pk);
                        var seqno = grdBody.GetGridData(grdBody.row, G1_seqno);
                        var tankno = grdBody.GetGridData(grdBody.row, G1_tank_no);
                        var status = grdBody.GetRowStatus(grdBody.row);
                        //if(grdCap.GetGridData(grdCap.row, G1_pk) !='')
                        if((seqno !='')&& (tankno!=''))
                        {
                            var path = System.RootURL + '/form/sh/bo/shbo00011.aspx?Captype=B&tank_m_pk=' + tank_m_pk + "&seqno=" + seqno + "&tankno=" + tankno + "&gelqty=" +grdBody.GetGridData(grdBody.row, G1_gelatin_qty);
                            var obj = System.OpenModal( path ,600 , 330,  'resizable:yes;status:yes', this);
                            if ( obj != null )
                            {
                                grdBody.SetGridText(grdBody.row, G1_color_check, obj);
                                grdBody.SetRowStatus(grdBody.row,status);
                            }	
                       }
                       else
                       {
                            alert('Please input Seq No or Tank No first!!!');
                       }
                    }
                break;
                case G1_trim_batchno1:
                    var fpath = System.RootURL + "/form/sh/ab/shab00130.aspx?color=" + txtColorBody.text;
                    var object = System.OpenModal( fpath , 450 , 350 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                       grdBody.SetGridText(grdBody.row, G1_trim_batchno1, obj);
                    }
                break;
                case G1_colpack_batchno:
                    var fpath = System.RootURL + "/form/sh/ab/shab00140.aspx?color=" + txtColorBody.text;
                    var object = System.OpenModal( fpath , 450 , 350 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                       grdBody.SetGridText(grdBody.row, G1_colpack_batchno, obj);
                    }
                break;
            }
        break;
    }
}
//----------------------------------------------------------
function OnAfterValueChange(obj)
{   
    switch(obj)
    {
        case 'Cap':
            if(event.col == G1_tank_no)
            {
                if(grdCap.GetGridData(event.row, G1_tank_no)=='000')
                    grdCap.SetGridText(event.row, G1_gel_batchno, 'TANK LOSS');
                else    
                    grdCap.SetGridText(event.row, G1_gel_batchno, '');
            }
        break;
        case 'Body':
            if(event.col == G1_tank_no)
            {
                if(grdBody.GetGridData(event.row, G1_tank_no)=='000')
                    grdBody.SetGridText(event.row, G1_gel_batchno, 'TANK LOSS');
                else
                    grdBody.SetGridText(event.row, G1_gel_batchno, '');
            }
        break;
    }
}
//----------------------------------------------------------
function OnValidateData(obj)
{
    switch(obj)
    {
        case 'Cap':
            for(i=2; i<grdCap.rows; i++)
            {
                if(grdCap.GetRowStatus(i)!=64 )
                {
                    if(grdCap.GetGridData(i, G1_tank_no)=='')
                    {
                        alert('Please input Tank No.!!!');
                        return false;
                    }
                }
            }
        break;
        case 'Body':
            for(i=2; i<grdBody.rows; i++)
            {
                if(grdBody.GetRowStatus(i)!=64 )
                {
                    if(grdBody.GetGridData(i, G1_tank_no)=='')
                    {
                        alert('Please input Tank No.!!!');
                        return false;
                    }
                }
            }
        break;
    }
    return true;
}
//----------------------------------------------------------
function OnClosing()
{
    var v_change =0;
    for(var j=2; j<grdCap.rows; j++)
       {
        if(grdCap.GetRowStatus(j)!=0 )
        {
            v_change=1;
            break;
        }
        
       }
       
    if (v_change==1)
    {
        if ( confirm( "You have changed Cap data. Do you want to save?" ) ) 
            {
                return false;
            }else
            {
                for(i=2; i<grdCap.rows; i++)
                    {
                        if(grdCap.GetGridData(i,G1_pk)=="")
                          {
                            grdCap.DeleteRowAt(i);
                          }else
                          {
                            grdCap.SetRowStatus(i,0)
                          }
                    }
                 data_shbo00010_1.Call();
            }
    }
//-----------------------------------------------------------//
    v_change= 0;
    for(var j=2; j<grdBody.rows; j++)
       {
        if(grdBody.GetRowStatus(j)!=0 )
        {
            v_change=1;
            break;
        }
        
       }
       
    if (v_change==1)
    {
        if ( confirm( "You have changed Body data. Do you want to save?" ) ) 
            {
                return false;
            }else
            {
                for(i=2; i<grdBody.rows; i++)
                    {
                        if(grdBody.GetGridData(i,G1_pk)=="")
                          {
                            grdBody.DeleteRowAt(i);
                          }else
                          {
                            grdBody.SetRowStatus(i,0)
                          }
                    }
                 data_shbo00010_2.Call();
            }
    }
    
    return true;
}
//----------------------------------------------------------
function canClose()
{
	return 	 OnClosing();  
}


</script>
<body >
    <gw:data id="data_shbo00010" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00010" > 
                <inout> 
                     <inout  bind="txtLotNO" />
                     <inout  bind="lstMachineNo" />
                     <inout  bind="txtProdCode" />
                     <inout  bind="txtProdName" />
                     <inout  bind="txtColorCap" />
                     <inout  bind="txtColorBody" />
                     <inout  bind="txtCustomerCode" />
                     <inout  bind="txtCustomerName" />
                     <inout  bind="txtEstimatedQty" />
                     <inout  bind="txtBlendingNo" />
                     <inout  bind="txtSizeCode" />
                     <inout  bind="txtSizeName" />
                     <inout  bind="txtAdditive" />
                     <inout  bind="txttsh_main_m_pk" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00010_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="prod.sp_sel_shbo00010_1" procedure="prod.sp_upd_shbo00010_1">
                <input bind="grdCap" >
                    <input bind="txttsh_main_m_pk" />
                    <input bind="txtCapC" />
                    <input  bind="txtColorCap" />
                    <input  bind="txtColorBody" />
                    <input  bind="txtAdditive" />
                    <input  bind="txtLotNO" />
                </input>
                <output bind="grdCap" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00010_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="prod.sp_sel_shbo00010_1" procedure="prod.sp_upd_shbo00010_1">
                <input bind="grdBody" >
                    <input bind="txttsh_main_m_pk" />
                    <input bind="txtCapB" />
                    <input  bind="txtColorCap" />
                    <input  bind="txtColorBody" />
                    <input  bind="txtAdditive" />
                    <input  bind="txtLotNO" />
                </input>
                <output bind="grdBody" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 100%" id="right" >
                <table style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                    <tr style="height: 1%">
                        <td style="width: 100%" >
                            <fieldset style="padding: 5">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 10%;white-space:nowrap" align="right">
                                        Machine No.
                                    </td>
                                    <td style="width: 18%" align="right" >
                                        <gw:list id="lstMachineNo" styles='width:100%'  >
                                            <data>
											    <%=ESysLib.SetListDataSQL("select distinct hoki, hoki || ' - '|| COMM.f_get_logistic_codename('LGMF0010', hoki) machine from prod.tsh_main_m where del_if =0 and inst_gu = '6' and box_gu = '1' order by hoki ")%>||
										    </data>
										</gw:list>
                                    </td>
                                    <td style="width: 10%;white-space:nowrap" align="right"> 
                                        Product
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <gw:textbox id="txtProdCode" styles='width:100%' />
                                    </td>
                                    <td  align="right" style="width: 18%">
                                        <gw:textbox id="txtProdName" styles='width:100%' />
                                    </td>
                                    <td  align="right" style="width: 14%">
                                        Color Code
                                    </td>
                                    <td  align="right" style="width: 10%">
                                        <gw:textbox id="txtColorCap" styles='width:100%' />
                                    </td>
                                    <td  align="right" style="width: 10%">
                                        <gw:textbox id="txtColorBody" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space:nowrap" align="right">
                                        <a title="Click here to select Lot No" onclick="OnPopUp('LotNo')" href="#tips" style="text-decoration: none;
                                                color:#0000ff"><b>LOT No.</b></a>
                                    </td>
                                    <td  align="right" >
                                        <gw:textbox id="txtLotNO" styles='width:100%' />
                                    </td>
                                    <td style="white-space:nowrap" align="right"> 
                                        Customer
                                    </td>
                                    <td align="right">
                                        <gw:textbox id="txtCustomerCode" styles='width:100%' />
                                    </td>
                                    <td  align="right" >
                                        <gw:textbox id="txtCustomerName" styles='width:100%' />
                                    </td>
                                    <td  align="right" style="white-space:nowrap">
                                        Estimated Q'ty
                                    </td>
                                    <td  align="right" colspan=2>
                                        <gw:textbox id="txtEstimatedQty" styles='width:100%' type="number" format="#,###,###,###,###R" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space:nowrap" align="right">
                                        Blending No.
                                    </td>
                                    <td  align="right" >
                                        <gw:textbox id="txtBlendingNo" styles='width:100%' />
                                    </td>
                                    <td style="white-space:nowrap" align="right"> 
                                        Size
                                    </td>
                                    <td align="right" >
                                        <gw:textbox id="txtSizeCode" styles='width:100%'/>
                                    </td>
                                     <td align="right" >
                                        <gw:textbox id="txtSizeName" styles='width:100%'/>
                                    </td>
                                    <td  align="right" style="white-space:nowrap">
                                        Additive Type
                                    </td>
                                    <td  align="right" colspan=2>
                                        <gw:textbox id="txtAdditive" styles='width:100%'/>
                                    </td>
                                </tr>
                            </table>
                            </fieldset >
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right" colspan=5>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%; color:Red">
                                        <b>CAP</b>
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('Cap')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('Cap')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Cap')" />
                                    </td>
                                     <td style="width: 1%" align="right">
                                        <gw:imgbtn img="Udelete" alt="UnDelete" id="btnUDeleteCap" onclick="OnUnDelete(grdCap)" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Cap')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 48%">
                        <td colspan="5">
                            <gw:grid id='grdCap' 
                                header='_pk|_tsh_main_m_pk|Work_Date|Seqno|Tank_Seqno|Tank_No|Trim_Batchno1|Trim_Qty1|Gel_Batchno|Gelatin_Qty|Colpack_Batchno|Colpack_Qty|Color_Check|_cap_gu|_col_codecap|_col_codebody|_add_type_no|_lotno'
                                format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|1|1|0|0|3|0|3|0|3|1|0|0|0|0|0'
                                defaults='|||||||||||||||||' editcol='0|0|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0'
                                chek='|||-n|-n|||-n||-n||-n||||||'  sorting='F'
                                widths='0|0|1200|500|500|600|1250|1250|1300|1250|1300|1250|600|0|0|0|0|0'
                                 styles='width:100%; height:100%' onafteredit="OnAfterValueChange('Cap')" oncelldblclick="OnGriddblClick('Cap')"/>
                        </td>
                    </tr>
                     <tr style="height: 1%">
                        <td  align="right" >
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%; color:Red"><b>BODY</b></td>
                                    <td style="width: 96%">
                                        <hr style="color:Blue" size="2" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="search" alt="Search" id="btnSearchBody" onclick="OnSearch('Body')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAddNewBody" onclick="OnAddNew('Body')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDeleteBody" onclick="OnDelete('Body')" />
                                    </td>
                                     <td style="width: 1%" align="right">
                                        <gw:imgbtn img="Udelete" alt="UnDelete" id="btnUDeleteBody" onclick="OnUnDelete(grdBody)" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnSaveBody" onclick="OnSave('Body')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 49%">
                        <td colspan="5">
                            <gw:grid id='grdBody' 
                                header='_pk|_tsh_main_m_pk|Work_Date|Seqno|Tank_Seqno|Tank_No|Trim_Batchno1|Trim_Qty1|Gel_Batchno|Gelatin_Qty|Colpack_Batchno|Colpack_Qty|Color_Check|_cap_gu|_col_codecap|_col_codebody|_add_type_no|_lotno'
                                format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|1|1|0|0|3|0|3|0|3|1|0|0|0|0|0'
                                defaults='|||||||||||||||||' editcol='0|0|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0'
                                chek='|||-n|-n|||-n||-n||-n||||||'  sorting='F' 
                                widths='0|0|1200|500|500|600|1250|1250|1300|1250|1300|1250|600|0|0|0|0|0'
                                styles='width:100%; height:100%' onafteredit="OnAfterValueChange('Body')" oncelldblclick="OnGriddblClick('Body')"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txttsh_main_m_pk" styles="width: 100%;display:none" />
<gw:textbox id="txtCapB" text='B'  styles="width: 100%;display:none" />
<gw:textbox id="txtCapC" text='C' styles="width: 100%;display:none" />
<gw:datebox id="dtToday"  style="display:none" />
</html>
