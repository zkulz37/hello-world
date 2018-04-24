<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Colorant Pack Composition</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
    
   var l_EvenRow , l_EvenRow2   
        
    var G1_pk               = 0,  
        G1_Color_Code       = 1,  
        G1_Color_Name       = 2,
        G1_Gelatin_1Pack    = 3,
        G1_Pack_Weight      = 4;

    var G2_pk               = 0,  
        G2_tsh_colpack_m_pk = 1,  
        G2_col_code         = 2,
        G2_matno            = 3, 
        G2_item_name        = 4,
        G2_spec             = 5,
        G2_use_ratio        = 6,
        G2_test_no          = 7,
        G2_gram_gel         = 8,
        G2_gram_gel1        = 9,
        G2_kg_ratio         = 10,
        G2_kg_qty           = 11,
        G2_tco_item_pk      = 12;

 //==================================================================
 function BodyInit()
 {
    txtColorName.SetReadOnly(true);
    txtColorCode.SetReadOnly(true);
    OnSearch('Master');
 }
 
 //==================================================================
 function OnSearch(pos)
 {
    switch(pos)
    {
        case'Master':
            data_shpb00120_1.Call("SELECT");
        break;        
        case'Detail': 
            data_shpb00120_2.Call('SELECT');
        break;
    }
 }
  //==================================================================
function FormatGrid()
 {
      var trl ;
     
      trl = grdColor.GetGridControl();      	
      trl.ColFormat(G1_Pack_Weight )     = "###,###,###,###,##0.#0";
      
      trl = grdColor.GetGridControl();      	
      trl.ColFormat(G2_use_ratio )     = "###,###,###,###,##0.#0";
      trl.ColFormat(G2_gram_gel1 )     = "###,###,###,###,##0.#0";
      trl.ColFormat(G2_kg_ratio )      = "###,###,###,###,##0.#0";
 }
 //==================================================================
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :
                if(OnValidate('Master'))
                    data_shpb00120_1.Call();
            break;
            case 'Detail':
                if(OnValidate('Detail'))
                    data_shpb00120_2.Call();
            break;
      }  
 }
 //==================================================================
function OnAddNew(obj)
{
    switch(obj)
    {
        case 'Master':
            grdColor.AddRow();
            lblRecord.text = grdColor.rows -1 +' record(s)'
        break;
        case 'Detail':
            if(txtTsh_colpack_m.text =='')
            {
                alert('Please Save master first!!!');
                return;
            }
            
            grdMatColor.RemoveRowAt(grdMatColor.rows-1);
            grdMatColor.AddRow();
            grdMatColor.SetGridText(grdMatColor.rows-1,G2_tsh_colpack_m_pk, txtTsh_colpack_m.text);
            grdMatColor.SetGridText(grdMatColor.rows-1,G2_col_code, txtColorCode.text);
           // grdMatColor.Subtotal( 0, 2, -1, '6!8!10','###,###,###.0000R');
        break;
    }
}
 //==================================================================

 function OnDelete(obj)
 {	
    switch(obj)
    {
        case 'Master':
	        if ( confirm( "Do you want to delete?" ) ) 
	        {
	            if(grdColor.GetGridData(grdColor.row,0) =="")
	            {
	                grdColor.RemoveRow()
	                lblRecord.text = grdColor.rows -1 +' record(s)'
	            }else
	            {
		            grdColor.DeleteRow();
		        }
	        }
	    break;
	    case 'Detail':
	        if ( confirm( "Do you want to delete?" ) ) 
	        {
	           if(grdMatColor.GetGridData(grdMatColor.row,0) =="")
	           {
	             grdMatColor.RemoveRow()
	           }else
	           {
		         grdMatColor.DeleteRow();
		       }
	        }
	    break;
	}
 }
 function OnUnDelete(obj)
 {
    switch (obj)
    {
     case 'Master':
        grdColor.UnDeleteRow();
     break;
     case 'Detail':
        grdMatColor.UnDeleteRow();
     break;
    }
 }
 //==================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shpb00120_2':
             grdMatColor.Subtotal( 0, 2, -1, '6!8!10','###,###,###.###0R');
        break;
        case 'data_shpb00120_1':
             lblRecord.text = grdColor.rows -1 +' record(s)'
        break;
        case 'data_shpb00120_3':
            if (txtMatPK.text !="")
            {
            grdMatColor.SetGridText(l_EvenRow,G2_tco_item_pk, txtMatPK.text);                
            grdMatColor.SetGridText(l_EvenRow,G2_matno, txtMatID.text); 
            grdMatColor.SetGridText(l_EvenRow,G2_item_name, txtMatName.text); 
            grdMatColor.SetGridText(l_EvenRow,G2_spec, txtMatSpec.text); 
            l_EvenRow = l_EvenRow2
            }else
            {
                OnPopUp('MAT')
            }
        break;
    }
}
 //==================================================================
 function OnPopUp(pos)
 {
    switch(pos)
       {
            case 'Color':
                if(grdColor.col == G1_Color_Code || grdColor.col == G1_Color_Name)
                {
                    var fpath = System.RootURL + "/form/sh/im/shim00011.aspx?";
                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                         grdColor.SetGridText(grdColor.row, G1_Color_Code, object[1]);
                         grdColor.SetGridText(grdColor.row, G1_Color_Name, object[2]);
                    }
                }
            break; 
            case 'MAT':
                
                    var fpath = System.RootURL + "/form/sh/pb/shpb00121.aspx?";
                    var object = System.OpenModal( fpath , 750 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {   
                        grdMatColor.SetGridText(l_EvenRow,G2_tco_item_pk, object[0]);                
                        grdMatColor.SetGridText(l_EvenRow,G2_matno, object[1]); 
                        grdMatColor.SetGridText(l_EvenRow,G2_item_name, object[2]); 
                        grdMatColor.SetGridText(l_EvenRow,G2_spec, object[3]); 
                    }
               
            break;
        case 'TEST':
            if(grdMatColor.col == G2_test_no )
                {
                    var fpath = System.RootURL + "/form/sh/ab/shab00050.aspx?matno=" + grdMatColor.GetGridData(grdMatColor.row,G2_matno) + "&matname=" + grdMatColor.GetGridData(grdMatColor.row,G2_item_name);
                    var object = System.OpenModal( fpath , 750 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {                  
                        grdMatColor.SetGridText(grdMatColor.row,G2_test_no, object[2]); 
                    }
                }else
             if(grdMatColor.col == G2_item_name )
                {
                    var fpath = System.RootURL + "/form/sh/pb/shpb00121.aspx?";
                    var object = System.OpenModal( fpath , 750 , 550 , 'resizable:yes;status:yes'); 
                    if (object != null)
                    {   
                        grdMatColor.SetGridText(grdMatColor.row,G2_tco_item_pk, object[0]);                
                        grdMatColor.SetGridText(grdMatColor.row,G2_matno, object[1]); 
                        grdMatColor.SetGridText(grdMatColor.row,G2_item_name, object[2]); 
                        grdMatColor.SetGridText(grdMatColor.row,G2_spec, object[3]); 
                    }
                }
        break; 
      }
 }
  //==================================================================
 function OnGridCelClick()
 {
    if(grdColor.row>0)
    {
        txtTsh_colpack_m.text  = grdColor.GetGridData(grdColor.row, G1_pk );
        txtColorCode.text = grdColor.GetGridData(grdColor.row, G1_Color_Code );
        txtColorName.text = grdColor.GetGridData(grdColor.row, G1_Color_Name );
        data_shpb00120_2.Call('SELECT');
    }
 }
  //==================================================================
  function OnValidate(obj)
  {
    switch(obj)
    {
        case 'Master':
            for(i=1; i<grdColor.rows; i++)
            {
                if(grdColor.GetGridData(i, G1_Color_Code ) =='')
                {
                    alert('Please select color!!!');
                    return false;
                }
                if(grdColor.GetGridData(i, G1_Gelatin_1Pack ) =='')
                {
                    alert('Please select Gelatin/1Pack!!!');
                    return false;
                }
                if(grdColor.GetGridData(i, G1_Pack_Weight ) =='')
                {
                    alert('Please select Pack Weight!!!');
                    return false;
                }
            }
        break;
        case 'Detail': 
            for(i =1; i< grdMatColor.rows-1; i++)
            {
                if(grdMatColor.GetRowStatus(i) !=64 )
                {
                    if(grdMatColor.GetGridData(i, G2_matno ) =='')
                    {
                        alert('Please select Material!!!');
                        return false;
                    }
                    if(grdMatColor.GetGridData(i, G2_kg_ratio ) =='')
                    {
                        alert('Please input Ratio!!!');
                        return false;
                    }
                    if(grdMatColor.GetGridData(i, G2_gram_gel ) =='')
                    {
                        alert('Please input Req. Qty!!!');
                        return false;
                    }
                }
            }
        break;
    }
    return true;
  }
  //==================================================================
  function OnGridChange()
  {
     grdMatColor.Subtotal( 0, 2, -1, '6!8!10','###,###,###.###0R');
    if(event.col==G2_matno)
    {
     l_EvenRow = l_EvenRow2
     txtMatID.text = grdMatColor.GetGridData(l_EvenRow,G2_matno)
     data_shpb00120_3.Call()
    }
  }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00120_1" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" parameter="0,1,2,3,4" function="prod.sp_sel_shpb00120_1" procedure="prod.sp_upd_shpb00120_1"> 
                <input>  
                    <input bind="txtColor" />
                </input> 
                <output bind="grdColor" /> 
            </dso> 
        </xml> 
    </gw:data>
     <!------------------------------------------------------------------>
    <gw:data id="data_shpb00120_2" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="prod.sp_sel_shpb00120_2" procedure="prod.sp_upd_shpb00120_2" > 
                <input>  
                    <input bind="txtTsh_colpack_m" />
                </input> 
                <output bind="grdMatColor" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <!------------------------------------------------------------------>
    <gw:data id="data_shpb00120_3" onreceive="OnReceiveData(this)"> 
        <xml>                                                               
            <dso id="1" type="process" procedure="PROD.sp_pro_shpb00120_2"> 
                <input > 
                    <input bind="txtMatID" />                   
                </input> 
                <output>
                    <output bind="txtMatPK" />
                    <output bind="txtMatID" />
                    <output bind="txtMatName" />
                    <output bind="txtMatSpec" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    
    
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height:1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height:1%">
                        <td style="width: 20%" align=right>
                            Color
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtColor" styles="width: 100%;" />
                        </td>
                        <td style="width: 30%" align=right>
                            <gw:label id="lblRecord" styles="color:blue" > </gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="New" text="New" onclick="OnSearch('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUDelete" img="Udelete" alt="Undelete" text="Delete" onclick="OnUnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUpdate" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height:59%">
            <td style="width: 100%">
               <gw:grid id='grdColor'
                    header='_pk|Color Code|Color Name|Gelatin/1Pack|Pack Weight'
                    format='0|0|0|0|0' aligns='0|0|0|1|1' defaults='||||'
                    editcol='0|0|0|1|1' widths='0|2000|2500|2000|1000'
                    sorting='T' oncelldblclick="OnPopUp('Color')"  onselchange="OnGridCelClick()"
                    styles='width:100%; height:100%'
                    /> 
            </td>
        </tr>
        <tr style="height:1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height:1%">
                        <td style="width: 10%;color:Red" align=right>
                            Color
                        </td>
                        <td style="width: 16%"> 
                            <gw:textbox id="txtColorCode" styles="width: 100%;color:Red" />
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtColorName" styles="width: 100%;color:Red" />
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnMatSearch" img="search" alt="New" text="New" onclick="OnSearch('Detail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnMatNew" img="new" alt="New" text="New" onclick="OnAddNew('Detail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnMatDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                        </td>
                         <td style="width: 1%">
                            <gw:imgbtn id="btnUMatDelete" img="Udelete" alt="Undelete" text="Delete" onclick="OnUnDelete('Detail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnMatUpdate" img="save" alt="Save" text="Save" onclick="OnSave('Detail')" />
                        </td>
                        
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height:40%">
            <td style="width: 100%">
                <gw:grid id='grdMatColor'
                    header='_pk|_tsh_Colpack_M_Pk|_Col_Code|Mat Code|Mat Name|Spec|Color Comp(%)/KG|Test No|Req Qty(g)/Kg|Req Qty(g)/Kg(C/M)|Ratio (%)/Kg|_Kg_Qty|_tco_item_pk'
                    format='0|0|0|0|0|0|-4|0|-3|-5|-3|0|0' aligns='0|0|0|0|0|0|3|0|3|3|3|3|0'
                    defaults='||||||||||||' editcol='0|0|0|1|0|0|1|0|1|1|1|1|0'
                    widths='0|0|0|2000|2500|1500|2000|1500|1800|2000|1500|1000|0'
                    sorting='T'  onafteredit="OnGridChange()" onbeforeedit="l_EvenRow2=this.row"
                    oncelldblclick="OnPopUp('TEST')"
                    styles='width:100%; height:100%'
                    /> 
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------->
<gw:textbox id="txtTsh_colpack_m" styles="width: 100%;display:none" />
<gw:textbox id="txtMatPK" styles="width: 100%;display:none" />
<gw:textbox id="txtMatID" styles="width: 100%;display:none" />
<gw:textbox id="txtMatName" styles="width: 100%;display:none" />
<gw:textbox id="txtMatSpec" styles="width: 100%;display:none" />
<gw:textbox id="txtEvenRow" styles="width: 100%;display:none" />
<gw:textbox id="txtEvenRow2" styles="width: 100%;display:none" />

</html>
