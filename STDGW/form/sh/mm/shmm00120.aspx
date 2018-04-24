<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("inv")%>
<head id="Head1" runat="server">
    <title>TAKE OUT MATERIAL INQUIRY</title>
</head>

<script language="javascript" type="text/javascript">
/*Start Check if it call from fpbp00010.aspx form*/
  var pop_item_name = "<%=Request.querystring("item_nm")%>"; 
/*End*/
var G1_Req_DT               = 0 ,
    G1_Slip_No              = 1 ,
    G1_TIN_LINEMATREQ_PK    = 2 ,     
    G1_Item_Code            = 3 ,
    G1_Item_Name            = 4 ,
    G1_UOM                  = 5 ,
    G1_Req_Qty              = 6 ,
    G1_TO_Qty               = 7 ,
    G1_Slip_No_TO           = 8 ,
    G1_Line_Name            = 9 ,
    G1_Partner_pk           = 10 ,
    G1_ITEM_CODE_TO         = 11 ,
    G1_ITEM_NAME_TO         = 12 ,
    G1_ITEM_UNIT_TO         = 13 ,
    G1_Lot_No               = 14 ,
    G1_TO_Qty_TO            = 15 ,
    G1_Warehouse            = 16 ;
    
var G2_Req_Date     = 0 ,
    G2_Slip_No      = 1 ,
    G2_Line_Name    = 2 ,
    G2_Partner      = 3 ,
    G2_Warehouse    = 4 ,
    G2_Item_Code    = 5 ,
    G2_Item_Name    = 6 ,
    G2_Unit         = 7 , 
    G2_Req_Qty      = 8 ,
    G2_Takeout_Qty  = 9 ,
    G2_Balance      = 10 ;
    
//----------------------------------------------------------------
function BodyInit()
 { 
 txtDeptName.SetEnable(false);
 txtPurDeptName.SetEnable(false);
 txtDeptCode.SetEnable(false);
 txtPurDeptCode.SetEnable(false);
//    System.Translate(document);  // Translate to language session
//    
//    //--------------------
//    var ldate;
//    
//    ldate = dtFrom.value;         
//    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
//    dtFrom.value=ldate ; 
//    //--------------------
//    
    BindingDataList(); 
   // FormatGrid();      
    //--------------------    
      /*this segment will be executed if this form are called as a popup*/   
    if(pop_item_name!="")
    {
             txtItem.text   = pop_item_name
             OnSearch();
    }
 }
 
 //---------------------------------------------------------

 function FormatGrid()
 {
        grdByItem.GetGridControl().FrozenCols  = 3 ;
        //------------
        var ctrl = grdByItem.GetGridControl();
        ctrl.ColFormat(G1_Req_Qty)      = "###,###,###.##" ;
        ctrl.ColFormat(G1_TO_Qty)       = "###,###,###.##" ;
        ctrl.ColFormat(G1_TO_Qty_TO)    = "###,###,###.##" ;
        
        //-------------
          ctrl.MergeCells  = 2 ;	
          ctrl.MergeCol(0) = true ;	
          ctrl.MergeCol(1) = true ;   	
          ctrl.MergeCol(2) = true ;	
          ctrl.MergeCol(3) = true ;	
          ctrl.MergeCol(4) = true ;		
          ctrl.MergeCol(5) = true ;	
          ctrl.MergeCol(6) = true ;	
          ctrl.MergeCol(7) = true ;   		
        
 }
  
//---------------------------------------------------------------------------------------------------
 function BindingDataList()
 {  
     var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0 order by PARTNER_NAME")%>";   
     cboCompany.SetDataText(data);
//     
//<%--     data = "<%=ESysLib.SetListDataSQL("SELECT PK, LINE_NAME FROM prod.pb_LINE Where Del_if=0 order by LINE_NAME ")%>|ALL|Select All";  
//     cboLine.SetDataText(data); 
//     cboLine.value="ALL"
//     
//     data = "<%=ESysLib.SetListDataSQL("select pk, wh_name from tin_warehouse where del_if=0 order by wh_name")%>|ALL|Select All";  
//     cboWarehouse.SetDataText(data); 
//     cboWarehouse.value="ALL"    --%>           
 }
  
 //----------------------------------------------------------------------------------------------------
  function OnSearch()
 {
	    data_shmm00120.Call('SELECT'); 
 }
 //--------------------------------------------------------------------------------------------------
 function OnDataReceive(obj)
 {
    switch(obj.id)
    {
        case'data_shmm00120':
            data_shmm00120_1.Call('SELECT');
        break;
    }
 }

//---------------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    { 
        case 'ReqDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx?dept_condition=5";//Long Thanh
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPk.text  = object[0]; 
               txtDeptCode.text  = object[1]; 
            }
        break;
        case 'PurDept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx?dept_condition=50102000";//purchase section
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtPurDeptName.text = object[2]; 
               txtPurDeptPk.text  = object[0]; 
               txtPurDeptCode.text  = object[1]; 
            }
        break;       
    }
}
</script>

<body>
    <!-----------------------grdForDrap---------------------------------------->
    <gw:data id="data_shmm00120" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" parameter="0,1" function="PROD.sp_sel_shmm00120" > 
                    <input>                         
                        <input bind="dtFrom" /> 
                        <input bind="dtTo" />    
                       <input bind="txtDeptPk" /> 
                       <input bind="txtPurDeptPk" /> 
                       <input bind="txtItem" /> 
                    </input> 
                    <output bind="grdForDrap" /> 
                </dso> 
            </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="data_shmm00120_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="PROD.sp_sel_shmm00120" > 
                <input bind="grdByItem" >
                        <input bind="dtFrom" /> 
                        <input bind="dtTo" />    
                       <input bind="txtDeptPk" /> 
                       <input bind="txtPurDeptPk" /> 
                       <input bind="txtItem" /> 
                </input>
                <output bind="grdByItem" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%" border="1">
            <tr style="height: 2%">
                <td>
                    <table style="width: 100%; height: 100%" border="0">
                        <tr>
                            <td style="width: 10%" align="right">
                                Company</td>
                            <td>
                                <gw:list id="cboCompany" styles="width:100%;" />
                            </td>
                            <td style="white-space: nowrap; width: 10%" align="right">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('ReqDept')">Req. Dept.</b>
                            </td>
                            <td align="right" style="width: 10%">
                                <gw:textbox id="txtDeptPk" styles='width:100%;display:none' />
                                <gw:textbox id="txtDeptCode" styles='width:100%' />
                            </td>
                            <td align="right" style="width: 22%">
                                <gw:textbox id="txtDeptName" styles='width:100%' />
                            </td>
                            <td style="width: 5%">
                            </td>
                            <td style="width: 20%" align="right">
                                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 10%; white-space: nowrap" align="right">
                                Request Date</td>
                            <td style="width: 8%; white-space: nowrap">
                                <gw:datebox id="dtFrom" lang="1" />
                                ~
                                <gw:datebox id="dtTo" lang="1" />
                            </td>
                            <td align="right" style="white-space: nowrap">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PurDept')">Purch. Dept.</b>
                            </td>
                            <td align="right" style="width: 10%">
                                <gw:textbox id="txtPurDeptPk" styles='width:100%;display:none' />
                                <gw:textbox id="txtPurDeptCode" styles='width:100%' />
                            </td>
                            <td align="right" style="width: 23%">
                                <gw:textbox id="txtPurDeptName" styles='width:100%' />
                            </td>
                            <td align="right">
                                Item</td>
                            <td>
                                <gw:textbox id="txtItem" styles="width:100%;" onenterkey="OnSearch()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 98%">
                <td>
                    <gw:tab id="tab">
                    <table name="By Item" style="width: 100%; height: 100%">
                        <tr>
                            <td>
                                <gw:grid id='grdByItem'
                                header='_null_|Request DT|MR No|Seq|Item Code|Item Name|UOM |Vendor No|Vendor Name|Req Qty|Po Qty|Unit Price|Amount|Dept'
                                format='0|4|0|0|0|0|0|0|0|1|1|1|1|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|1500|1500|800|1500|2500|800|1500|2500|1500|1500|1500|1500|1500'
                                sorting='T'
                                autosize='T' 
                                styles='width:100%; height:100%'
                                />
                            </td>
                        </tr>
                    </table>
                    <table name="By Group" style="width: 100%; height: 100%">
                        <tr>
                            <td>
                                <gw:grid id='grdForDrap'   header='|Request DT|MR No|Seq|Item Code|Item Name|UOM |Vendor No|Vendor Name|Req Qty|Po Qty|Unit Price|Amount|Dept'
                                format='0|4|0|0|0|0|0|0|0|1|1|1|1|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|1500|1500|800|1500|2500|800|1500|2500|1500|1500|1500|1500|1500'
                                sorting='T'
                                autosize='T' 
                                styles='width:100%; height:100%'
                                group='T'
                                />
                            </td>
                        </tr>
                    </table>
                    </gw:tab>
                </td>
            </tr>
        </table>
    </form>
    <!----------------------------------------------------------------->
</body>
</html>
