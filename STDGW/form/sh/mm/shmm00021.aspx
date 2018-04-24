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
    G1_Appr_qty     = 4,
    G1_po_qty       = 5,
    G1_unit_price   = 6,
    G1_amount       = 7,
    G1_spec         = 8,
    G1_req_uom      = 9,
    G1_caqty        = 10,
    G1_cansayu      = 11,
    G1_entreqdate   = 12,
    G1_po_date      = 13,
    G1_tco_partner_pk  = 14,
    G1_partner_id   = 15,
    G1_partner_name = 16,
    G1_req_date     = 17,
    G1_tco_item_pk  = 18,
    G1_mr_no        = 19,
    G1_rout_pk      = 20,
    G1_Account      = 21,
    G1_req_dept_pk  = 22,
    G1_req_dept_id  = 23,
    G1_req_dept_nm  = 24,
    G1_pur_dept_pk  = 25,
    G1_pur_dept_id  = 26,
    G1_pur_dept_nm  = 27;
       
 //---------------------------------------------------------

 function BodyInit()
 {
 
    var callerWindowObj = dialogArguments;          
    txtDeptCode.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtPurDeptCode.SetEnable(false);
    txtPurDeptName.SetEnable(false);
    txtMatlID.SetEnable(false);
    txtMatlName.SetEnable(false);
    txtPartnerName.SetEnable(false);
    dtPODTFr.SetDataText(System.AddDate(dtPODTTo.GetData(),-7));
    txtPartnerPk.text = callerWindowObj.txtSupplierPK.text ;
    txtPartnerName.text = callerWindowObj.txtSupplierName.text;
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
               }	
        break;  
        case 'Partner':
           var path = System.RootURL + '/form/fp/ab/fpab00120.aspx';
           var obj = System.OpenModal( path ,900 , 550,  'resizable:yes;status:yes');
           if(obj !=null)
           {
                txtPartnerPk.text = obj[0];
                //txtPartnerCode.text = obj[1];
                txtPartnerName.text = obj[2];
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
    data_shmm00021_1.Call('SELECT');
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
	    var v_part = idGrid2.GetGridData(1,G1_tco_partner_pk) ;
	    var v_flag = 0;
	    for(var j =2 ; j<idGrid2.rows ; j++ )
	    {
	        if(idGrid2.GetGridData(j, G1_tco_partner_pk) != v_part)
              {
                 v_flag = 1;
                 break;
              }
	    }
	    if(v_flag ==1)
	    {
	        if(confirm('Difference Partner,Are you sure to select all these items!'))
	        {
	            window.returnValue =  arr_data;
		        window.close();
	        }
	    }else
	    {
		window.returnValue =  arr_data;
		window.close();
		}
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
           <dso id="4" type="grid" user="prod"  function="prod.sp_sel_shmm00021_1" > 
                <input bind="idGrid">
                    <input bind="txtPurDeptPk" />  
                    <input bind="dtPODTFr" />  
                    <input bind="dtPODTTo" />  
                    <input bind="lstStatus" />  
                    <input bind="txtPartnerPk" />  
                    <input bind="txtDeptPk" />  
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
                                        Req. Period
                                    </td>
                                    <td colspan=2 >
                                         <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td>
                                                    <gw:datebox id="dtPODTFr" lang=1 styles='width:100%' />
                                                    ~
                                                    <gw:datebox id="dtPODTTo" lang=1 styles='width:100%' />
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
                                        Status
                                    </td>
                                    <td style="width: 10%" colspan=3>
                                        <gw:list id="lstStatus" value="7" styles='width:50%' onchange="OnSearch();"  >
                                            <data>
											    <%=ESysLib.SetListDataSQL("select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord ")%>||
										    </data>
										</gw:list>
                                    </td>
                                    <td style="width: 10%" align="right" style="white-space:nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Partner')">Partner Code</b>
                                    </td>
                                    <td  align="right" style="width: 40%" colspan=2>
                                        <gw:textbox id="txtPartnerPk" styles='width:100%;display:none' />
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 99%">
                                                    <gw:textbox id="txtPartnerName" styles='width:100%'  />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="reset" alt="Reset" id="btnReset1" onclick="txtPartnerPk.text='';txtPartnerName.text='';" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space:nowrap" align="right"> 
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqDept')">Req. Dept.</b>
                                    </td>
                                    <td align="right" >
                                        <gw:textbox id="txtDeptPk" styles='width:100%;display:none' />
                                        <gw:textbox id="txtDeptCode" styles='width:100%' />
                                    </td>
                                    <td  align="right" colspan=2>
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 99%">
                                                    <gw:textbox id="txtDeptName" styles='width:100%' />
                                                </td>
                                                <td style="width: 1%">
                                                    <gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="txtDeptPk.text='';txtDeptCode.text='';txtDeptName.text='';" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td  align="right" style="white-space:nowrap; color:Red">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Matl')">Matl Code</b>
                                    </td>
                                    <td  align="right" style="width: 10%">
                                        <gw:textbox id="txtMatlPk" styles='width:100%;display:none'/>
                                        <gw:textbox id="txtMatlID" styles='width:100%'/>
                                    </td>
                                    <td  align="right" >
                                        <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
                                            <tr>
                                                <td style="width: 99%">
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
                                header='_Pk|Item Code|Item Name|Req. Qty|Appr. Qty|P/O Qty|U/Price|Amount|Spec|Unit|Cancel Qty|Cancel Reason|Deli. DT|PO Date|_Tco_Partner_Pk|Partner ID|Partner Name|Req Date|_tco_item_pk|_mr_no|_rout_pk|Account|_Req_Dept_pk|_Req_DeptID|_Req_DeptNm|_Pur_Dept_pk|_Pur_Dept_ID|_Pur_Dept_Nm'
                                format='0|0|0|-2|-2|-2|-2|-2|0|0|-2|0|4|4|0|0|0|4|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|3|3|3|3|3|0|1|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||0n|||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|1200|2000|1000|1000|1000|1000|1000|1300|600|1000|1300|1000|1000|0|1200|1500|1000|0|0|0|1000|1000|1000|1000|1000|1000|1000'
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
                                header='_Pk|Item Code|Item Name|Req. Qty|Appr. Qty|P/O Qty|U/Price|Amount|Spec|Unit|Cancel Qty|Cancel Reason|Deli. DT|PO Date|_Tco_Partner_Pk|Partner ID|Partner Name|Req Date|_tco_item_pk|_mr_no|_rout_pk|Account|_Req_Dept_pk|_Req_DeptID|_Req_DeptNm|_Pur_Dept_pk|_Pur_Dept_ID|_Pur_Dept_Nm'
                                format='0|0|0|-2|-2|-2|-2|-2|0|0|-2|0|4|4|0|0|0|4|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|3|3|3|3|3|0|1|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||0n|||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|1200|2000|1000|1000|1000|1000|1000|1300|600|1000|1300|1000|1000|0|1200|1500|1000|0|0|0|1000|1000|1000|1000|1000|1000|1000'
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
