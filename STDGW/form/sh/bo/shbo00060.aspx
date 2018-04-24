<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Additive Solution Preparation Instruction and Record</title>
</head>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var flag ='';
    
var G1_pk               = 0,
    G1_tsh_batlot_m_pk  = 1,
    G1_label_no         = 2,
    G1_melt_qty         = 3,
    G1_trim_qty         = 4,
    G1_col_date         = 5,
    G1_st_time          = 6,
    G1_cap_gu           = 7,
    G1_lotno            = 8,
    G1_label_prt        = 9,
    G1_hoki             = 10;   
 //---------------------------------------------------------

 function BodyInit()
 {
    txtLotNO.SetEnable(false);
    txtProdCode.SetEnable(false);
    txtProdName.SetEnable(false);
    txtColorCap.SetEnable(false);
    txtColorBody.SetEnable(false);
    txtCustomerCode.SetEnable(false);
    txtCustomerName.SetEnable(false);
    txtEstimatedQty.SetEnable(false);
    FormatGrid();
 }
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'LotNo':
            var fpath = System.RootURL + "/form/sh/ab/shab00120.aspx?machineNo=" + lstMachineNo.value;
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtLotNO.text = object[1];
                flag="onload";
                data_shbo00060.Call('SELECT');
            }
        break;
        case 'Print':
           var min = 0, max = 0; 
            min = grdCap.GetGridData(i, G1_col_date);
           //---------------------------Cap-------------------
           for(var i =1; i < grdCap.rows; i++)
           {                           
                 if(grdCap.GetGridData(i, G1_col_date) > min ) 
                {                
                   max =  grdCap.GetGridData(i, G1_col_date);
               }   
              else 
              {
                min =  grdCap.GetGridData(i, G1_col_date);
               }   
         }      
         //-----------------------------Body------------------
            for(var y = 1; y < grdBody.rows; y++)
            {
                if(grdBody.GetGridData(y, G1_col_date) > max)
               {
                    max =  grdBody.GetGridData(y, G1_col_date);
               } 
              else if(grdBody.GetGridData(y, G1_col_date) < min)
              {
                min =  grdBody.GetGridData(y, G1_col_date) ;
              } 
            }          
            var fpath = System.RootURL + "/form/sh/bo/shbo00061.aspx?machineNo=" + lstMachineNo.value+"&min="+min+"&max="+max;
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
        break;
       } 
}
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdCap.GetGridControl();
      trl.ColFormat(G1_melt_qty )   = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_trim_qty )   = "###,###,###,###,##0.##0";
      trl.ColEditMask(G1_st_time)   = "99:99";
      
      trl = grdBody.GetGridControl();
      trl.ColFormat(G1_melt_qty )   = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_trim_qty )   = "###,###,###,###,##0.##0";
      trl.ColEditMask(G1_st_time)   = "99:99";
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
    if(txttsh_batlot_m_pk.text =='')
    {
        alert('Please select LOT No first!!!');
        return;
    }
      switch (pos)         
      {		  
        case 'Cap':
            
            if(grdCap.rows >1)
            {
                seq = Number(grdCap.GetGridData(grdCap.rows-1,G1_label_no)) +1;
            }
            else
            {
                seq=1;
            } 
            
            grdCap.AddRow();    
            grdCap.SetGridText(grdCap.rows-1, G1_label_no, seq);   
            grdCap.SetGridText(grdCap.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdCap.SetGridText(grdCap.rows-1, G1_cap_gu,      'C');
            grdCap.SetGridText(grdCap.rows-1, G1_lotno,       txtLotNO.text);
            grdCap.SetGridText(grdCap.rows-1, G1_melt_qty,      32);
            grdCap.SetGridText(grdCap.rows-1, G1_trim_qty,      8);
        break;              
        case 'Body' :
            if(grdBody.rows >1)
            {
                seq = Number(grdBody.GetGridData(grdBody.rows-1,G1_label_no)) +1;
            }
            else
            {
                seq=1;
            } 
            
            grdBody.AddRow();    
            grdBody.SetGridText(grdBody.rows-1, G1_label_no, seq);    
            grdBody.SetGridText(grdBody.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdBody.SetGridText(grdBody.rows-1, G1_cap_gu, 'B');
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
            }
        break;
        case 'Body':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               grdBody.DeleteRow();
            }
        break;
    }
 }
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'Cap':
            data_shbo00060_1.Call('SELECT');
        break;
        case'Body':
            data_shbo00060_2.Call('SELECT');
        break;
    }
 }
 //---------------------------------------------------------
 function OnSave(pos)
 {
      switch (pos)         
      {		        
        case 'Cap' :
            data_shbo00060_1.Call();
        break;
        case 'Body':
            data_shbo00060_2.Call();
        break;
      }  
 }
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shbo00060':
            data_shbo00060_1.Call('SELECT');
        break;
        case 'data_shbo00060_1':
            if(grdCap.rows==1)
            {
                PP_Initally_Registration_Cap();
            }
            if(flag=="onload")
            {
                flag ='';
                
                data_shbo00060_2.Call('SELECT');
                    
            }
            if (grdCap.rows>1)
            {
                grdCap.SetCellFontColor( 1, G1_label_prt, grdCap.rows-1, G1_label_prt, 0x3333FF );
                grdCap.SetCellBold( 1, G1_label_prt, grdCap.rows-1, G1_label_prt, true );
            }
        break;
        case 'data_shbo00060_2':
            if(grdBody.rows==1)
            {
                PP_Initally_Registration_Body();
            }
            if(grdBody.rows>1)
            {
                grdBody.SetCellBold( 1, G1_label_prt, grdBody.rows-1, G1_label_prt, true);
                grdBody.SetCellFontColor( 1, G1_label_prt, grdBody.rows-1, G1_label_prt, 0x3333FF );
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
            if(col==G1_color_check)
            {
                var tank_m_pk = grdCap.GetGridData(grdCap.row, G1_pk);
                var seqno = grdCap.GetGridData(grdCap.row, G1_seqno);
                var tankno = grdCap.GetGridData(grdCap.row, G1_tank_no);
                var path = System.RootURL + '/form/sh/bo/shbo00011.aspx?Captype=C&tank_m_pk=' + tank_m_pk + "&seqno=" + seqno + "&tankno=" + tankno;
               var obj = System.OpenModal( path ,750 , 500,  'resizable:yes;status:yes', this);
               if ( obj != null )
               {
                   grdCap.SetGridText(grdCap.row, G1_color_check, obj);
               }	
            }
        break;
        case 'Body':
            if(col==G1_color_check)
            {
                var tank_m_pk = grdBody.GetGridData(grdBody.row, G1_pk);
                var seqno = grdBody.GetGridData(grdBody.row, G1_seqno);
                var tankno = grdBody.GetGridData(grdBody.row, G1_tank_no);
                var path = System.RootURL + '/form/sh/bo/shbo00011.aspx?Captype=B&tank_m_pk=' + tank_m_pk + "&seqno=" + seqno + "&tankno=" + tankno;
               var obj = System.OpenModal( path ,750 , 500,  'resizable:yes;status:yes', this);
               if ( obj != null )
               {
                    grdBody.SetGridText(grdBody.row, G1_color_check, obj);
               }	
            }
        break;
    }
}
//----------------------------------------------------------
function OnProcess(obj)
{
    switch(obj)
    {
        case 'Cap':
            if(grdCap.row>0)
            {
                if(grdCap.GetGridData(grdCap.row,G1_pk) == '')
                {
                    alert("Please save data first!!!");
                    return;
                }
                grdCap.SetRowStatus(grdCap.row, '48');
                data_shbo00060_3.Call();
            }
            //Scheduling();
        break;
        case 'Body':
            if(grdBody.row>0)
            {
                if(grdBody.GetGridData(grdBody.row,G1_pk) == '')
                {
                    alert("Please save data first!!!");
                    return;
                }
                grdBody.SetRowStatus(grdBody.row, '48');
                data_shbo00060_4.Call();
            }
        break;
    }
}
//----------------------------------------------------------
function  PP_Initally_Registration_Cap()
{
   var v_cnt =0, v_cap =0, v_body =0, v_d_cap =0, v_d_body =0, v_day =0;
   var v_cap_cnt = 1, v_body_cnt = 1, v_cap_sum  = 0, v_body_sum = 0, v_cap_grt = 0, v_body_grt = 0;
   var v_cap_chdate = new Date();
   var v_body_chdate =new Date();

    v_date = txtinst_date.text; 
    v_cap = txtcap_gel_qty.text; 
    v_body = txtbody_gel_qty.text;
    v_day = txtdur_date.text;
    
    if(txtLotNO.text.substring(1,1)== 'V')
    {
        v_melt_qty = 18.5;
        v_trim_qty = '';
        v_tank_qty = 18.5;
    }
    else
    {
        v_melt_qty = 32;
        v_trim_qty = 8;
        v_tank_qty = 40;
    }
    
    v_b_date = v_date;
    v_d_cap = (((Number(v_cap) / Number(v_tank_qty)).toFixed(0)) / v_day).toFixed(0);
    v_d_body = (((Number(v_body) /  Number(v_tank_qty)).toFixed(0)) / v_day).toFixed(0);
// CAP INSERT 
    for( v_mn = 1 ;v_mn<= v_day;v_mn++)
    {
        for (m = 1;m<= v_d_cap;m++)
        {
            grdCap.AddRow();
            grdCap.SetGridText(grdCap.rows-1, G1_label_no, grdCap.rows-1);   
            grdCap.SetGridText(grdCap.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdCap.SetGridText(grdCap.rows-1, G1_cap_gu,      'C');
            grdCap.SetGridText(grdCap.rows-1, G1_lotno,       txtLotNO.text);
            grdCap.SetGridText(grdCap.rows-1, G1_melt_qty,     v_melt_qty);
            grdCap.SetGridText(grdCap.rows-1, G1_trim_qty,     v_trim_qty);
                        
            v_cap_sum = Number(v_cap_sum) + Number(grdCap.GetGridData(grdCap.rows-1,G1_melt_qty))
                    + Number(grdCap.GetGridData(grdCap.rows-1,G1_trim_qty))
                    
            grdCap.SetGridText(grdCap.rows-1, G1_col_date, v_date);         
        
            grdCap.SetGridText(grdCap.rows-1, G1_label_prt, 'N');           
            grdCap.SetGridText(grdCap.rows-1, G1_hoki, lstMachineNo.value);           
       }

       v_date = System.AddDate(v_date,1);

    }
    if (Number(v_cap) > Number(v_cap_sum))
    {
       if (Number(v_cap) - Number(v_cap_sum) >  Number(v_tank_qty))
       {
            grdCap.AddRow();
            grdCap.SetGridText(grdCap.rows-1, G1_label_no, grdCap.rows-1);   
            grdCap.SetGridText(grdCap.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdCap.SetGridText(grdCap.rows-1, G1_cap_gu,      'C');
            grdCap.SetGridText(grdCap.rows-1, G1_lotno,       txtLotNO.text);
            grdCap.SetGridText(grdCap.rows-1, G1_melt_qty,   v_melt_qty);
            grdCap.SetGridText(grdCap.rows-1, G1_trim_qty,   v_trim_qty);
            grdCap.SetGridText(grdCap.rows-1, G1_col_date, v_date);  
            grdCap.SetGridText(grdCap.rows-1, G1_label_prt, 'N'); 
            grdCap.SetGridText(grdCap.rows-1, G1_hoki, lstMachineNo.value);  
       
            grdCap.AddRow();
            grdCap.SetGridText(grdCap.rows-1, G1_label_no, grdCap.rows-1);   
            grdCap.SetGridText(grdCap.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdCap.SetGridText(grdCap.rows-1, G1_cap_gu,      'C');
            grdCap.SetGridText(grdCap.rows-1, G1_lotno,       txtLotNO.text);
            grdCap.SetGridText(grdCap.rows-1, G1_melt_qty,    Math.round ((Number(v_cap).toFixed(0)) %  Number(v_tank_qty)));
            grdCap.SetGridText(grdCap.rows-1, G1_col_date, v_date);  
            grdCap.SetGridText(grdCap.rows-1, G1_label_prt, 'N'); 
            grdCap.SetGridText(grdCap.rows-1, G1_hoki, lstMachineNo.value);  
       }
    }
}
//--------------------------------------------------------------------
function  PP_Initally_Registration_Body()
{
   var v_cnt =0, v_cap =0, v_body =0, v_d_cap =0, v_d_body =0, v_day =0;
   var v_cap_cnt = 1, v_body_cnt = 1, v_cap_sum  = 0, v_body_sum = 0, v_cap_grt = 0, v_body_grt = 0;
   var v_cap_chdate = new Date();
   var v_body_chdate =new Date();

    v_date = txtinst_date.text; 
    v_cap = txtcap_gel_qty.text; 
    v_body = txtbody_gel_qty.text;
    v_day = txtdur_date.text;

    if(txtLotNO.text.substring(1,1)== 'V')
    {
        v_melt_qty = 18.5;
        v_trim_qty = '';
        v_tank_qty = 18.5;
    }
    else
    {
        v_melt_qty = 32;
        v_trim_qty = 8;
        v_tank_qty = 40;
    }

    v_b_date = v_date;
    v_d_cap = (((Number(v_cap) / Number(v_tank_qty)).toFixed(0)) / v_day).toFixed(0);
    v_d_body = (((Number(v_body) / Number(v_tank_qty)).toFixed(0)) / v_day).toFixed(0);
// 
    for( v_mn = 1; v_mn<= v_day; v_mn++)
    {
       for( m = 1;m<= v_d_body; m++)
       {
            grdBody.AddRow();
            grdBody.SetGridText(grdBody.rows-1, G1_label_no, grdBody.rows-1);   
            grdBody.SetGridText(grdBody.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdBody.SetGridText(grdBody.rows-1, G1_cap_gu,      'B');
            grdBody.SetGridText(grdBody.rows-1, G1_lotno,       txtLotNO.text);
            grdBody.SetGridText(grdBody.rows-1, G1_melt_qty,   v_melt_qty);
            grdBody.SetGridText(grdBody.rows-1, G1_trim_qty,   v_trim_qty);
            grdBody.SetGridText(grdBody.rows-1, G1_col_date, v_b_date);  
            grdBody.SetGridText(grdBody.rows-1, G1_label_prt, 'N'); 
            grdBody.SetGridText(grdBody.rows-1, G1_hoki, lstMachineNo.value);  
          
           v_body_sum = v_body_sum + Number(grdBody.GetGridData(grdBody.rows-1, G1_melt_qty))
                         + Number(grdBody.GetGridData(grdBody.rows-1, G1_trim_qty));
       }

       v_b_date = System.AddDate(v_b_date,1);
    }

    if( Number(v_body) > Number(v_body_sum))
    {
       if( Number(v_body) - Number(v_body_sum) > Number(v_tank_qty))
       {
            grdBody.AddRow();
            grdBody.SetGridText(grdBody.rows-1, G1_label_no, grdBody.rows-1);   
            grdBody.SetGridText(grdBody.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdBody.SetGridText(grdBody.rows-1, G1_cap_gu,      'B');
            grdBody.SetGridText(grdBody.rows-1, G1_lotno,       txtLotNO.text);
            grdBody.SetGridText(grdBody.rows-1, G1_melt_qty,   v_melt_qty);
            grdBody.SetGridText(grdBody.rows-1, G1_trim_qty,   v_trim_qty);
            grdBody.SetGridText(grdBody.rows-1, G1_col_date, v_b_date);  
            grdBody.SetGridText(grdBody.rows-1, G1_label_prt, 'N'); 
            grdBody.SetGridText(grdBody.rows-1, G1_hoki, lstMachineNo.value); 
       
            grdBody.AddRow();
            grdBody.SetGridText(grdBody.rows-1, G1_label_no, grdBody.rows-1);   
            grdBody.SetGridText(grdBody.rows-1, G1_tsh_batlot_m_pk, txttsh_batlot_m_pk.text);
            grdBody.SetGridText(grdBody.rows-1, G1_cap_gu,      'B');
            grdBody.SetGridText(grdBody.rows-1, G1_lotno,       txtLotNO.text);
            grdBody.SetGridText(grdBody.rows-1, G1_melt_qty,    Math.round ((Number(v_body).toFixed(0)) % Number(v_tank_qty)));
            grdBody.SetGridText(grdBody.rows-1, G1_col_date, v_b_date);  
            grdBody.SetGridText(grdBody.rows-1, G1_label_prt, 'N'); 
            grdBody.SetGridText(grdBody.rows-1, G1_hoki, lstMachineNo.value); 
       }
    }
}
//----------------------------------------------------------
function CheckInput(obj)
 {
    var col, row
    
    cIdx = event.col
    row = event.row        
      
    switch(obj)
    {  
        case 'Cap':
            if ( cIdx == G1_st_time )
	        {
		        tmpIN = grdCap.GetGridData(event.row,cIdx)
        		
		        if ( tmpIN.length == 0 )
		        {
			        grdCap.SetGridText(event.row, cIdx, "")
        			
		        }
		        if( ( tmpIN.length !=4 ) && ( tmpIN.length !=0 ) )
		        {
			        alert("Input time is not correct type.(type: hh:mm)\nKiểu giờ nhập không đúng")
			        grdCap.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		        {
			        alert("Input time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ phải >=00 và <=23")
			        grdCap.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		        {
			        alert("Input time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			        grdCap.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if(tmpIN.length>0)
		        {
		            tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		            grdCap.SetGridText(event.row,cIdx,tmpIN)
		        }    
	        }
	    break;
	    case 'Body':
	        if ( cIdx == G1_st_time )
	        {
		        tmpIN = grdBody.GetGridData(event.row,cIdx)
        		
		        if ( tmpIN.length == 0 )
		        {
			        grdBody.SetGridText(event.row, cIdx, "")
        			
		        }
		        if( ( tmpIN.length !=4 ) && ( tmpIN.length !=0 ) )
		        {
			        alert("Input time is not correct type.(type: hh:mm)\nKiểu giờ nhập không đúng")
			        grdBody.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		        {
			        alert("Input time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ phải >=00 và <=23")
			        grdBody.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		        {
			        alert("Input time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			        grdBody.SetGridText(event.row,cIdx,'')
			        return;
		        }
		        if(tmpIN.length>0)
		        {
		            tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		            grdBody.SetGridText(event.row,cIdx,tmpIN)
		        }    
	        }
	    break;
	}

 }
//----------------------------------------------------------
</script>

<body>
    <gw:data id="data_shbo00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="prod.sp_sel_shbo00060" > 
                <inout> 
                     <inout  bind="txtLotNO" />
                     <inout  bind="lstMachineNo" />
                     <inout  bind="txtProdCode" />
                     <inout  bind="txtProdName" />
                     <inout  bind="txttsh_batlot_m_pk" />
                     <inout  bind="txtCustomerCode" />
                     <inout  bind="txtCustomerName" />
                     <inout  bind="txtColorCap" />
                     <inout  bind="txtColorBody" />
                     <inout  bind="txtEstimatedQty" />                     
                     <inout  bind="txtdur_date" />
                     <inout  bind="txtinst_date" />
                     <inout  bind="txtcap_gel_qty" />
                     <inout  bind="txtbody_gel_qty" />
                     <inout  bind="txtmelt_qty" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00060_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="prod.sp_sel_shbo00060_1" procedure="prod.sp_upd_shbo00060_1">
                <input bind="grdCap" >
                    <input bind="txttsh_batlot_m_pk" />
                    <input bind="txtCapC" />
                    <input bind="lstMachineNo" />
                </input>
                <output bind="grdCap" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00060_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="prod.sp_sel_shbo00060_1" procedure="prod.sp_upd_shbo00060_1">
                <input bind="grdBody" >
                    <input bind="txttsh_batlot_m_pk" />
                    <input bind="txtCapB" />
                    <input bind="lstMachineNo" />
                </input>
                <output bind="grdBody" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shbo00060_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="1,2,5,6,7,10"  function="prod.sp_sel_shbo00060_1" procedure="prod.sp_pro_shbo00060_2" > 
                <input>
                    <input bind="txttsh_batlot_m_pk" />
                    <input bind="txtCapC" />
                    <input bind="lstMachineNo" />
                </input> 
                <output bind="grdCap" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shbo00060_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  parameter="1,2,5,6,7,10" function="prod.sp_sel_shbo00060_1" procedure="prod.sp_pro_shbo00060_2" > 
                <input>
                    <input bind="txttsh_batlot_m_pk" />
                    <input bind="txtCapB" /> 
                    <input bind="lstMachineNo" />
                </input> 
                <output bind="grdBody" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 100%" id="right">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 1%">
                                        <td rowspan="3" style="width: 5%">
                                            <gw:radio id="radType" value="G" styles="width:100%"> 
                                            <span value="G">Gelatin </span> 
                                        </gw:radio>
                                        </td>
                                        <td style="width: 11%; white-space: nowrap" align="right">
                                            Machine No.
                                        </td>
                                        <td style="width: 21%" align="right">
                                            <gw:list id="lstMachineNo" styles='width:100%'>
                                            <data>
											    <%=ESysLib.SetListDataSQL("select distinct a.hoki, a.hoki || ' - '|| COMM.f_get_logistic_codename('LGMF0010', a.hoki) machine from prod.tsh_batlot_m a, prod.tsh_main_m b where a.del_if =0 and b.del_if =0 and b.inst_gu = '6' and b.box_gu = '1' and a.dip_yn = 'N' and a.pk = b.TSH_BATLOT_M_PK order by a.hoki")%>||
										    </data>
										</gw:list>
                                        </td>
                                        <td style="width: 13%; white-space: nowrap" align="right">
                                            Product
                                        </td>
                                        <td style="width: 11%" align="right">
                                            <gw:textbox id="txtProdCode" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 16%">
                                            <gw:textbox id="txtProdName" styles='width:100%' />
                                        </td>
                                        <td align="right" style="width: 13%" rowspan="3">
                                            <gw:icon id="btnPrint" img="3" text="S/Tank Label Print" onclick="OnPopUp('Print')" />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            <a title="Click here to select Lot No" onclick="OnPopUp('LotNo')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>LOT No.</b></a>
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtLotNO" styles='width:100%' />
                                        </td>
                                        <td style="white-space: nowrap" align="right">
                                            Customer
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtCustomerCode" styles='width:100%' />
                                        </td>
                                        <td align="right">
                                            <gw:textbox id="txtCustomerName" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="white-space: nowrap" align="right">
                                            Color Code
                                        </td>
                                        <td align="right" style="white-space: nowrap">
                                            <gw:textbox id="txtColorCap" styles='width:50%' />
                                            <gw:textbox id="txtColorBody" styles='width:50%' />
                                        </td>
                                        <td style="white-space: nowrap" align="right">
                                            Estimated Q'ty
                                        </td>
                                        <td align="right" colspan="2">
                                            <gw:textbox id="txtEstimatedQty" styles='width:100%' type="number" format="#,###,###,###,###.##R" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 18%" align="right">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%">
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
                                        <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('Cap')" />
                                    </td>
                                    <td align="right" style="width: 13%">
                                        <gw:icon id="btnSchedule1" img="3" text="Scheduling" onclick="OnProcess('Cap')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 48%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%; color: Red" valign="top">
                                        CAP&nbsp;&nbsp;</td>
                                    <td style="width: 99%">
                                        <gw:grid id='grdCap' header='_pk|_tsh_batlot_m_pk|Seq. No.|Sol. Qty.|Trimming Qty.|Date|Time|_Cap_Gu|_Lotno|Checked|_hoki'
                                            format='0|0|0|0|0|4|0|0|0|0|0' aligns='0|0|1|3|3|1|1|0|0|1|0' defaults='||||||||||'
                                            editcol='0|0|0|1|1|1|1|0|0|0|0' widths='0|0|1500|1800|1800|1800|1800|0|0|1000|0'
                                            sorting='F' chek='||||-n|-n||||' acceptnulldate="T" styles='width:100%; height:100%'
                                            oncelldblclick="" onafteredit="CheckInput('Cap')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%">
                                        <hr style="color: Blue" size="2" />
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
                                        <gw:imgbtn img="save" alt="Save" id="btnSaveBody" onclick="OnSave('Body')" />
                                    </td>
                                    <td align="right" style="width: 13%">
                                        <gw:icon id="btnSchedule2" img="3" text="Scheduling" onclick="OnProcess('Body')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 49%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 1%; color: Red" valign="top">
                                        BODY</td>
                                    <td colspan="4">
                                        <gw:grid id='grdBody' header='_pk|_tsh_batlot_m_pk|Seq. No.|Sol. Qty.|Trimming Qty.|Date|Time|_Cap_Gu|_Lotno|Checked|_hoki'
                                            format='0|0|0|0|0|4|0|0|0|0|0' aligns='0|0|1|3|3|1|1|0|0|1|0' defaults='||||||||||'
                                            editcol='0|0|0|1|1|1|1|0|0|0|0' widths='0|0|1500|1800|1800|1800|1800|0|0|1000|0'
                                            sorting='F' chek='||||-n|-n||||' acceptnulldate="T" styles='width:100%; height:100%'
                                            oncelldblclick="" onafteredit="CheckInput('Body')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txttsh_batlot_m_pk" styles="width: 100%;display:none" />
<gw:textbox id="txtCapB" text='B' styles="width: 100%;display:none" />
<gw:textbox id="txtCapC" text='C' styles="width: 100%;display:none" />
<gw:textbox id="txtRtnValue" styles="width: 100%;display:none" />
<gw:textbox id="txtdur_date" styles="width: 100%;display:none" />
<gw:textbox id="txtinst_date" styles="width: 100%;display:none" />
<gw:textbox id="txtcap_gel_qty" styles="width: 100%;display:none" />
<gw:textbox id="txtbody_gel_qty" styles="width: 100%;display:none" />
<gw:textbox id="txtmelt_qty" styles="width: 100%;display:none" />
<gw:textbox id="txtColDate" lang="1" styles="width:100%;display:none" />
<gw:textbox id="txtSeq" lang="1" styles="width:100%;display:none" />
</html>
