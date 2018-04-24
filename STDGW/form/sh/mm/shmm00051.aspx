<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<head id="Head1" >
    <title>Purchase Request Registration</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var  dept_pk  = "<%=Session("DEPT_PK")%>" ; 
var  dept_id  = "<%=Session("DEPT_CODE")%>" ; 
var  dept_nm  = "<%=Session("DEPT_NAME")%>" ; 
var flag ='';
    
var G1_pk           = 0,  
    G1_item_code    = 1,
    G1_item_name    = 2,
    G1_req_qty      = 3,
    G1_po_qty       = 4,
    G1_unit_price   = 5,
    G1_amount       = 6,
    G1_spec         = 7,
    G1_req_uom      = 8,
    G1_caqty        = 9,
    G1_cansayu      = 10,
    G1_entreqdate   = 11,
    G1_po_date      = 12,
    G1_tco_partner_pk  = 13,
    G1_partner_id   = 14,
    G1_partner_name = 15,
    G1_req_date     = 16;
 //---------------------------------------------------------

 function BodyInit()
 {
 
    var callerWindowObj = dialogArguments;          
    
    txtPurDeptCode.SetEnable(false);
    txtPurDeptName.SetEnable(false);
    txtMatlID.SetEnable(false);
    txtMatlName.SetEnable(false);
    txtPartnerName.SetEnable(false);
    dtTIDTFr.SetDataText(System.AddDate(dtTIDTTo.GetData(),-7));
    txtPartnerPk.text = callerWindowObj.txtSupplierPK.text ;
    txtPartnerCode.text = callerWindowObj.txtSupplierID.text;
    txtPartnerName.text = callerWindowObj.txtSupplierName.text;
    OnSearch();
}
 //---------------------------------------------------------
 function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'ReqDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPk.text  = object[0]; 
               txtDeptCode.text  = object[1]; 
               OnSearch();
            }
        break;
        case 'PurDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtPurDeptName.text = object[2]; 
               txtPurDeptPk.text  = object[0]; 
               txtPurDeptCode.text  = object[1]; 
               OnSearch();
            }
        break;
        case 'Matl':
               var path = System.RootURL + '/form/sh/ab/shab00160.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtMatlPk.text= obj[0];
                    txtMatlID.text = obj[1];
                    txtMatlName.text = obj[2];
                    OnSearch();
               }	
        break;  
        case 'Partner':
           if(idGrid2.rows>1)
           {
                alert("Cannot change Partner when you already select some Item");
           }
           else
           {
               var path = System.RootURL + '/form/fp/ab/fpab00120.aspx?partner_type=AP';
               var obj = System.OpenModal( path ,900 , 550,  'resizable:yes;status:yes');
               if(obj !=null)
               {
                    txtPartnerPk.text = obj[0];
                    txtPartnerCode.text = obj[1];
                    txtPartnerName.text = obj[2];
                    OnSearch();
               }
           }
           
        break;
    }
}
//---------------------------------------------------------
function BindingDataList()
 {
     <%=ESysLib.SetGridColumnComboFormat("grdDetail",4,"select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0104' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;        
 }
 //---------------------------------------------------------
 function OnAddNew(pos)
 {
      
 }
 //---------------------------------------------------------
 function OnSearch()
 {
    if(txtPartnerPk.text=="")
    {
        alert("Please select Partner frist");
    }
    else
    {
        data_shmm00021_1.Call('SELECT');
    }   
 }
 //---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
                
    }
}
//---------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		dialogArguments.txtSupplierPK.text=txtPartnerPk.text;
		dialogArguments.txtSupplierID.text=txtPartnerCode.text;
		dialogArguments.txtSupplierName.text=txtPartnerName.text;
				
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, G1_pk);
    
    idGrid2.RemoveRowAt(idGrid2.row);
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
    
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, G1_pk) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G1_pk) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, G1_pk );
            
            if(event.row > 0 && ( !CheckDataExist(idGrid2,col_val)) )
            {
                SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		        idGrid2.AddRow();
		        for(var i=0;i<oGrid.cols;i++)
		        {
		          idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
		        }
            }
      }
      countItem()
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//-------------------------------------------------------------------------------------------------
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, G1_pk);		
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val)) )
        {
            SetRowBackGroundColor( oGrid, col_val, 0x0000FF);
            
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }		
	}
    
    countItem();    
}
</script>
<body >
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00021_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod"  function="prod.sp_sel_shmm00051" > 
                <input bind="idGrid">
                    <input bind="txtPurDeptPk" />  
                    <input bind="dtTIDTFr" />  
                    <input bind="dtTIDTTo" />  
                    <input bind="txtPartnerPk" />  
                    <input bind="txtMatlPk" />  
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 80%" id="right" >
                <table style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                    <tr style="height: 1%">
                        <td style="width: 100%" >
                            <fieldset style="padding: 5">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width:10%;white-space:nowrap" align="right"> 
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PurDept')">Purch. Dept.</b>
                                    </td>
                                    <td align="right" style="width: 10%">
                                        <gw:textbox id="txtPurDeptPk" styles='width:100%;display:none' />
                                        <gw:textbox id="txtPurDeptCode" styles='width:100%' />
                                    </td>
                                    <td style="width: 30%;white-space:nowrap" colspan=2 nowrap>
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 99%">
                                                    <gw:textbox id="txtPurDeptName" styles='width:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="txtPurDeptPk.text='';txtPurDeptCode.text='';txtPurDeptName.text='';" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td  align="right" style="width: 12%">
                                        T/I Period
                                    </td>
                                    <td colspan=2 >
                                         <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td>
                                                    <gw:datebox id="dtTIDTFr" lang=1 styles='width:100%' />
                                                    ~
                                                    <gw:datebox id="dtTIDTTo" lang=1 styles='width:100%' />
                                                </td>
                                                <td align=right>
                                                    <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space:nowrap" align="right"> 
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Partner')">Partner Code</b>
                                    </td>
                                    <td style="width: 10%" colspan=3>
                                        <gw:textbox id="txtPartnerPk" styles='width:100%;display:none' />
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 99%">
                                                   <gw:textbox id="txtPartnerCode" styles='width:100%;display:none'  />
                                                    <gw:textbox id="txtPartnerName" styles='width:100%'  />
                                                </td>
                                                <td style="width: 1%">
                                                    <%--<gw:imgbtn img="reset" alt="Reset" id="btnReset1" onclick="txtPartnerPk.text='';txtPartnerName.text='';" />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 10%" align="right" style="white-space:nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Matl')">Matl Code</b>
                                    </td>
                                    <td  align="right" style="width: 40%" colspan=2>
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 29%">
                                                    <gw:textbox id="txtMatlPk" styles='width:100%;display:none'/>
                                                    <gw:textbox id="txtMatlID" styles='width:100%'/>
                                                </td>
                                                <td style="width: 70%">
                                                    <gw:textbox id="txtMatlName" styles='width:100%'/>
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="txtMatlPk.text='';txtMatlID.text='';txtMatlName.text='';" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            </fieldset >
                        </td>
                    </tr>
                    <tr style="height: 48%">
                        <td colspan="5">
                            <gw:grid id='idGrid' 
                                header='_tin_mattakeind_pk|_tin_mattakein_pk|_tpr_purordd_pk|Slip No|_ref_no|T/I Date|_tin_warehouse_pk|WH Name|_tco_item_pk|Item Code|Item Name|Unit|T/I Qty.|U/Price|Amount|Lot No|Test No|Description|_rout_pk'
                                format='0|0|0|0|0|4|0|0|0|0|0|0|-2|-2|-2|0|0|0|0' aligns='0|0|0|0|0|1|0|0|0|0|0|0|3|3|3|0|0|0|0'
                                check='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|0|0|1000|1000|1000|0|1000|0|1500|2500|800|1000|1000|1000|1000|1000|1000|0'
                                sorting='T'  acceptNullDate styles='width:100%; height:100%' 
                                oncelldblclick="OnGridCellDoubleClick(this)"  />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="5">
                            <table>
                                <tr>
                                    <td style="width: 96%" align="center">
                                        <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                                    </td>
                                    <td style="width: 1%;white-space: nowrap">
                                        <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                                        Duplicate
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 48%">
                        <td colspan="5">
                            <gw:grid id='idGrid2' 
                                header='_tin_mattakeind_pk|_tin_mattakein_pk|_tpr_purordd_pk|Slip No|_ref_no|T/I Date|_tin_warehouse_pk|WH Name|_tco_item_pk|Item Code|Item Name|Unit|T/I Qty.|U/Price|Amount|Lot No|Test No|Description|_rout_pk'
                                format='0|0|0|0|0|4|0|0|0|0|0|0|-2|-2|-2|0|0|0|0' aligns='0|0|0|0|0|1|0|0|0|0|0|0|3|3|3|0|0|0|0'
                                check='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|0|0|1000|1000|1000|0|1000|0|1500|2500|800|1000|1000|1000|1000|1000|1000|0'
                                sorting='T'  acceptNullDate styles='width:100%; height:100%' 
                                onafteredit="OnAfterEdit()()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
</html>
