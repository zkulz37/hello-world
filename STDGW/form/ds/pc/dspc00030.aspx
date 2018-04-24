<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Processing Fee</title>
</head>

<script>
    var G1_PK           = 0,
        G1_SEQ          = 1,
        G1_PROCESS_FEE  = 2,
        G1_START_DATE   = 3,
        G1_END_DATE     = 4,
        G1_CLOSE_YN     = 5,
        G1_DESCRIPTION  = 6;
    //--------------------------------
    var G2_WP_PRICE_PK          = 0,
        G2_CO_PROCESS_PRICE_PK  = 1,
        G2_PB_WORK_PROCESS_PK   = 2,
        G2_PROCESS_NAME         = 3,        
        G2_WP_NAME              = 4,
        G2_USE_YN               = 5,
        G2_DESCRIPTION          = 6;
    //--------------------------------
    var G3_PK                   = 0,
        G3_CO_PROCESS_PRICE_PK  = 1,
        G3_SPEC_GROUP_NAME      = 2,
        G3_TCO_SPEC_PK          = 3,
        G3_SPEC_ID              = 4,
        G3_SPEC_NAME            = 5,
        G3_USE_YN               = 6,
        G3_DESCRIPTION          = 7;
    //--------------------------------
    var G4_PK                   = 0,
        G4_CO_PROCESS_PRICE_PK  = 1,
        G4_ITEM_GROUP_NAME      = 2,
        G4_STYLE_PK             = 3,
        G4_STYLE_ID             = 4,
        G4_STYLE_NAME           = 5,
        G4_USE_YN               = 6,
        G4_DESCRIPTION          = 7;   
    //--------------------------------
    var G5_PK                   = 0,
        G5_CO_PROCESS_PRICE_PK  = 1,
        G5_PARTNER_PK           = 2,
        G5_PARTNER_ID           = 3,
        G5_PARTNER_NAME         = 4,
        G5_USE_YN               = 5,
        G5_DESCRIPTION          = 6;               
    //====================================================
    function OnToggle(pos) {
        var left = document.all("t-left");
        var right = document.all("t-right");
        var imgArrow1 = document.all("imgArrow1");
        var imgArrow2 = document.all("imgArrow2");

        if (pos == '1') {
            if (imgArrow1.status == "expand" && imgArrow2.status == "expand") {
                left.style.display = "none";
                right.style.display = "";

                right.style.width = "99%";

                imgArrow1.status = "collapse";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "none";
                imgArrow2.style.display = "";
            }
            else if (imgArrow1.status == "expand" && imgArrow2.status == "collapse") {
                left.style.display = "";
                right.style.display = "";

                left.style.width = "48%";
                right.style.width = "48%";

                imgArrow1.status = "expand";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "";
            }
        }
        else {
            if (imgArrow1.status == "expand" && imgArrow2.status == "expand") {
                left.style.width = "99%";

                right.style.display = "";
                right.style.display = "none";

                imgArrow1.status = "expand";
                imgArrow2.status = "collapse";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "none";
            }
            else if (imgArrow1.status == "collapse" && imgArrow2.status == "expand") {
                left.style.display = "";
                right.style.display = "";

                left.style.width = "48%";
                right.style.width = "48%";

                imgArrow1.status = "expand";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "";
            }
        }
    }
    //======================================================
    function BodyInit() {
        System.Translate(document);
        BindingDataList();
        FormatGrid();
    }
    //=====================================================
    function FormatGrid()
    {
        var ctrl = grdProcess.GetGridControl();   
        
        ctrl.MergeCells = 3;
        ctrl.MergeCol(3) = true;
        //------------------------------
        ctrl = grdSpec.GetGridControl();   
        
        ctrl.MergeCells = 3;
        ctrl.MergeCol(2) = true;  
        //------------------------------
        ctrl = grdItem.GetGridControl();   
        
        ctrl.MergeCells = 3;
        ctrl.MergeCol(2) = true;         
    }
    //=====================================================
    function BindingDataList() {
        var data="";  
        data = "<%=ESysLib.SetListDataSQL("SELECT pk, process_id || ' - ' || process_name FROM prod.pb_process WHERE del_if = 0 AND use_yn = 'Y' ORDER BY process_id") %>||SELECT ALL" ;    
        lstProcess.SetDataText(data);
        lstProcess.value = "";
        
        data = "<%=ESysLib.SetListDataSQL("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' ORDER BY specgrp_nm") %>||SELECT ALL" ;    
        lstSpecGrp.SetDataText(data);        
        lstSpecGrp.value = "";  
        
        data = "<%=ESysLib.SetListDataSQL("SELECT b.pk, b.GRP_NM FROM  comm.tco_itemgrp b WHERE b.del_if = 0") %>||SELECT ALL" ; 
        lstItemGrp.SetDataText(data);    
        lstItemGrp.value = "";          
    }
    //====================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'grdProcessFee':
                data_dspc00030.Call('SELECT');
                break;
            case 'grdProcess':
                data_dspc00030_1.Call('SELECT');
                break;
            case 'grdSpec':
                data_dspc00030_2.Call('SELECT');
                break;   
            case 'grdItem':
                data_dspc00030_3.Call('SELECT');
                break;                    
            case 'grdPartner':
                data_dspc00030_4.Call('SELECT');
                break;                         
        }
    }
    //====================================================
    function OnAddNew(pos) {
        switch (pos) {
            case 'grdProcessFee':
                grdProcessFee.AddRow();
                grdProcessFee.SetGridText(grdProcessFee.rows - 1, G1_CLOSE_YN, 0);                   
                break;

            case 'grdProcess':
                if (grdProcessFee.row > 0 && grdProcessFee.GetGridData(grdProcessFee.row, G1_PK) != '' && lstProcess.value != '') {
                    
                    var path = System.RootURL + '/form/fp/ab/fpab00250.aspx?process_pk='+ lstProcess.value;
                    var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                    
                    if ( object != null )
                     {                    
                            var arrTemp;
                            for( var i=0; i < object.length; i++)	  
                            {	    
                                    var arrTemp = object[i];
                                    
                                    grdProcess.AddRow();
                                    grdProcess.SetGridText(grdProcess.rows - 1, G2_CO_PROCESS_PRICE_PK, grdProcessFee.GetGridData(grdProcessFee.row, G1_PK));
                                    grdProcess.SetGridText(grdProcess.rows - 1, G2_PB_WORK_PROCESS_PK, arrTemp[0]);
                                    grdProcess.SetGridText(grdProcess.rows - 1, G2_PROCESS_NAME, arrTemp[3]);
                                    grdProcess.SetGridText(grdProcess.rows - 1, G2_WP_NAME, arrTemp[4]);                         
                                    grdProcess.SetGridText(grdProcess.rows - 1, G2_USE_YN, 0);                         
                            }	
                     }
                }
                break;
                
            case 'grdSpec':
                if (grdProcessFee.row > 0 && grdProcessFee.GetGridData(grdProcessFee.row, G1_PK) != '' && lstSpecGrp.value != '') {
                              var path = System.RootURL + '/form/fp/ab/fpab00470.aspx?group_pk='+ lstSpecGrp.value;
                              var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                              if ( object != null )
                              {
                                  var arrTemp;
                                  for( var i=0; i < object.length; i++)	  
                                  {	    
                                      var arrTemp = object[i];
                                        
                                      grdSpec.AddRow();
                                      grdSpec.SetGridText(grdSpec.rows - 1, G3_CO_PROCESS_PRICE_PK, grdProcessFee.GetGridData(grdProcessFee.row, G1_PK));
                                      grdSpec.SetGridText(grdSpec.rows - 1, G3_TCO_SPEC_PK, arrTemp[2]);
                                      grdSpec.SetGridText(grdSpec.rows - 1, G3_SPEC_ID, arrTemp[3]);  
                                      grdSpec.SetGridText(grdSpec.rows - 1, G3_SPEC_NAME, arrTemp[4]);                      
                                      grdSpec.SetGridText(grdSpec.rows - 1, G3_USE_YN, 0);
                                  }	
                              }
                }
                break;    
                
            case 'grdItem':
                if (grdProcessFee.row > 0 && grdProcessFee.GetGridData(grdProcessFee.row, G1_PK) != '' && lstItemGrp.value != '') {
                              var path = System.RootURL + '/form/fp/ab/fpab00210.aspx?group_pk='+ lstItemGrp.value + '&group_type=Y|Y|Y|Y|Y|Y';
                              var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                    if ( object != null )
                    {
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	    
                            var arrTemp = object[i];
                              
                            grdItem.AddRow();
                            grdItem.SetGridText(grdItem.rows - 1, G3_CO_PROCESS_PRICE_PK, grdProcessFee.GetGridData(grdProcessFee.row, G1_PK));
                            grdItem.SetGridText(grdItem.rows - 1, G4_STYLE_PK, arrTemp[0]);
                            grdItem.SetGridText(grdItem.rows - 1, G4_STYLE_ID, arrTemp[1]); 
                            grdItem.SetGridText(grdItem.rows - 1, G4_STYLE_NAME, arrTemp[2]);  
                            grdItem.SetGridText(grdItem.rows - 1, G4_USE_YN,0)                
                        }	
                    }                    
                }
                break;     
                
            case 'grdPartner':
                if (grdProcessFee.row > 0 && grdProcessFee.GetGridData(grdProcessFee.row, G1_PK) != '') {
                    
                    
                              var path = System.RootURL + '/form/fp/ab/fpab00480.aspx';//purchase_yn=Y
                              var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                              if ( object != null )
                              {
                                  var arrTemp;
                                  for( var i=0; i < object.length; i++)	  
                                  {	    
                                      var arrTemp = object[i];
                                        
                                      grdPartner.AddRow();
                                      grdPartner.SetGridText(grdPartner.rows - 1, G5_CO_PROCESS_PRICE_PK, grdProcessFee.GetGridData(grdProcessFee.row, G1_PK));
                                      grdPartner.SetGridText(grdPartner.rows - 1, G5_PARTNER_PK, arrTemp[0]);
                                      grdPartner.SetGridText(grdPartner.rows - 1, G5_PARTNER_ID, arrTemp[1]);
                                      grdPartner.SetGridText(grdPartner.rows - 1, G5_PARTNER_NAME, arrTemp[2]);                
                                      grdPartner.SetGridText(grdPartner.rows - 1, G5_USE_YN, 0);                
                                  }	
                              }                        
                }
                break;                                          
        }

    }

    //====================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case '':
                
            break;    
        }
    }
    //=====================================================
    function OnDelete(pos) {
        switch (pos) {
            case 'grdProcessFee':
                if (grdProcessFee.row > 0) {
                    if (grdProcessFee.GetGridData(grdProcessFee.row, G1_PK) == "") {
                        grdProcessFee.RemoveRow();
                    }
                    else {
                        if (confirm("Do you want to mark this row to delete?")) {
                            grdProcessFee.DeleteRow();
                        }
                    }
                }
                break;
            //---------------
            case 'grdProcess':
                if (grdProcess.row > 0) {
                    if (grdProcess.GetGridData(grdProcess.row, G2_WP_PRICE_PK) == "") {
                        grdProcess.RemoveRow();
                    }
                    else {
                        if (confirm("Do you want to mark this row to delete?")) {
                            grdProcess.DeleteRow();
                        }
                    }
                }
                break;               
             //---------------   
             case 'grdSpec':
                if (grdSpec.row > 0) {
                    if (grdSpec.GetGridData(grdSpec.row, G3_PK) == "") {
                        grdSpec.RemoveRow();
                    }
                    else {
                        if (confirm("Do you want to mark this row to delete?")) {
                            grdSpec.DeleteRow();
                        }
                    }
                }
                break;  
              //---------------  
              case 'grdItem':
                if (grdItem.row > 0) {
                    if (grdItem.GetGridData(grdProcess.row, G4_PK) == "") {
                        grdItem.RemoveRow();
                    }
                    else {
                        if (confirm("Do you want to mark this row to delete?")) {
                            grdItem.DeleteRow();
                        }
                    }
                }
                break;  
               //--------------- 
               case 'grdPartner':
                if (grdPartner.row > 0) {
                    if (grdPartner.GetGridData(grdPartner.row, G5_PK) == "") {
                        grdPartner.RemoveRow();
                    }
                    else {
                        if (confirm("Do you want to mark this row to delete?")) {
                            grdPartner.DeleteRow();
                        }
                    }
                }
                break;   
        }
    }
    //======================================================
    function OnUnDelete(pos) {
        switch (pos) {     
            case 'grdProcessFee':
                    grdProcessFee.UnDeleteRow();
                break;
            case 'grdProcess':
                    grdProcess.UnDeleteRow();
                break;                
            case 'grdSpec':
                    grdSpec.UnDeleteRow();
                break;
            case 'grdItem':
                    grdItem.UnDeleteRow();
                break;
            case 'grdPartner':
                    grdPartner.UnDeleteRow();
                break;                                               
        }
    }
    //=====================================================
    function OnSave(pos) {
        switch (pos) {
            case 'grdProcessFee':
                data_dspc00030.Call();
                break;
            case 'grdProcess':
                data_dspc00030_1.Call();
                break;         
            case 'grdSpec':
                data_dspc00030_2.Call();
                break; 
            case 'grdItem':
                data_dspc00030_3.Call();
                break;     
            case 'grdPartner':
                data_dspc00030_4.Call();
                break;                 
        }

    }

    //------------------------------------------------------------------------------
    function OnGridCellClick()
    {
        if(grdProcessFee.row > 0)
        {
            txt_co_process_price_pk.text =  grdProcessFee.GetGridData(grdProcessFee.row, G1_PK);
            if(tab.GetCurrentPageNo() == 0) // grdProcess
            {
                data_dspc00030_1.Call('SELECT');
            }
            else if(tab.GetCurrentPageNo() == 1) // grdSpec
            {
                data_dspc00030_2.Call('SELECT');
            }
            else if(tab.GetCurrentPageNo() == 2) // grdItem
            {
                data_dspc00030_3.Call('SELECT');
            }
            else if(tab.GetCurrentPageNo() == 3) // grdPartner
            {
                data_dspc00030_4.Call('SELECT');
            }
        }        
    }
   //------------------------------------------------------------------------------
   function OnPopUp()
   {
        var path = System.RootURL + "/form/ds/pc/dspc00031.aspx";
		var object = System.OpenModal( path ,1000 , 400 ,  'resizable:yes;status:yes');		       
   }
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00030" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00030" parameter="0,1,2,3,4,5,6" procedure="<%=l_user%>lg_upd_dspc00030"  >
                <input bind="grdApprove" >
                    <input bind="txtProcess" />
                </input> 
                <output bind="grdProcessFee" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00030_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00030_1" parameter="0,1,2,3,4,5,6" procedure="<%=l_user%>lg_upd_dspc00030_1"  >
                <input bind="grdProcess" >
                    <input bind="txt_co_process_price_pk" />
                    <input bind="lstProcess" />
                    <input bind="txtWProcess" />
                </input> 
                <output bind="grdProcess" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00030_2" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00030_2" parameter="0,1,2,3,4,5,6" procedure="<%=l_user%>lg_upd_dspc00030_2"  >
                <input bind="grdSpec" >                    
                    <input bind="txt_co_process_price_pk" />
                    <input bind="lstSpecGrp" />                    
                    <input bind="txtSpec" />
                </input> 
                <output bind="grdSpec" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00030_3" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00030_3" parameter="0,1,2,3,4,5,6" procedure="<%=l_user%>lg_upd_dspc00030_3"  >
                <input bind="grdItem" >
                 <input bind="txt_co_process_price_pk" />
                 <input bind="lstItemGrp" />
                 <input bind="txtStyle" />
                </input> 
                <output bind="grdItem" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00030_4" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00030_4" parameter="0,1,2,3,4,5,6" procedure="<%=l_user%>lg_upd_dspc00030_4"  >
                <input bind="grdPartner" >
                    <input bind="txt_co_process_price_pk" />
                    <input bind="txtPartner" />
                </input> 
                <output bind="grdPartner" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="0">
        <tr>
            <td style="width: 40%; height: 100%" id="t-left">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="right" width="1%">
                                        <b>Process</b>
                                    </td>
                                    <td width="15%">
                                        <gw:textbox id="txtProcess" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdProcessFee')" />
                                    </td>
                                    <td width="3%">
                                        <gw:icon id="idBtnView" img="2" text="View" styles='width:100%' onclick="OnPopUp()" />
                                    </td>
                                    <td width="10%" align='right'>
                                        <gw:imgbtn id="btnInvSearch" img="search" onclick="OnSearch('grdProcessFee')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAdd" onclick="OnAddNew('grdProcessFee')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('grdProcessFee')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="udelete" alt="Undelete" id="btnUnDelete" onclick="OnUndelete('grdProcessFee')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnUpdate" onclick="OnSave('grdProcessFee')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <gw:grid id='grdProcessFee' header='_pk|Seq|Process Fee|Start Date|End Date|Close|Description'
                                format='0|1|1|4|4|3|0' aligns='0|0|0|1|1|0|0' check='||||||' editcol='1|1|1|1|1|1|1'
                                widths='0|600|1200|1200|1200|550|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick='OnGridCellClick()' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 2%; white-space: nowrap" align="center">
                <img status="expand" id="imgArrow1" src="../../../system/images/button/previous.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('1')" />
                <img status="expand" id="imgArrow2" src="../../../system/images/button/next.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('2')" />
            </td>
            <td style="width: 58%; height: 100%" id="t-right">
                <gw:tab id="tab">
               <table name="Process" style="height: 100%; width: 100%" border="0">
                    <tr style="height: 1%; width:100%">
                        <td style="width: 1%; white-space:nowrap">
                            Process
                        </td>
                        <td style="width: 50%">
                            <gw:list id="lstProcess" styles="width:100%;" />
                        </td>
                        <td style="width: 100%">
                            <gw:textbox id="txtWProcess" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdProcess')" />
                        </td>
                        <td>
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdProcess')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew('grdProcess')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('grdProcess')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete1" img="udelete" alt="UnDelete" onclick="OnUnDelete('grdProcess')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave('grdProcess')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width:100%">
                        <td style="width: 100%" colspan="8">
                            <gw:grid id='grdProcess'
                                header='_pk|_co_process_price_pk|_pb_work_process_pk|Process Name|W/P Name|Use|Description'
                                format='0|0|0|0|0|3|0'
                                aligns='0|0|0|0|0|0|0'
                                check='||||||'
                                editcol='0|0|0|0|0|1|1'
                                widths='0|0|0|2200|3000|500|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />                            
                        </td>
                    </tr>
               </table>
               <table name="Spec" style="height: 100%; width: 100%" border="0">
                <tr style="height: 1%; width:100%">
                        <td style="width: 1%; white-space: nowrap">
                            Spec Grp
                        </td>
                        <td style="width: 50%">
                            <gw:list id="lstSpecGrp" styles="width:100%;" onchange="LoadSpec()" />
                        </td>   
                        <td style="width: 1%">
                            Spec
                        </td>
                        <td style="width: 50%">
                            <gw:textbox id="txtSpec" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdSpec')" />
                        </td>                        
                        <td>
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('grdSpec')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnNew2" onclick="OnAddNew('grdSpec')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete2" onclick="OnDelete('grdSpec')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete2" onclick="OnUnDelete('grdSpec')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave2" onclick="OnSave('grdSpec')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width:100%">
                        <td style="width: 100%" colspan="9">
                            <gw:grid id='grdSpec'
                                header='_pk|_co_process_price_pk|Spec Grp|_tco_spec_pk|Spec ID|Spec Name|Use|Description'
                                format='0|0|0|0|0|0|3|0'
                                aligns='0|0|0|0|0|0|0|0'
                                check='|||||||'
                                editcol='0|0|0|0|0|0|1|1'
                                widths='0|0|2000|0|1500|2400|500|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />                            
                        </td>
                    </tr>
               </table>
               <table name="Item" style="height: 100%; width: 100%" border="0">
                <tr style="height: 1%; width:100%">
                        <td style="width: 1%; white-space:nowrap">
                            Item Grp
                        </td>
                        <td style="width: 55%">
                            <gw:list id="lstItemGrp" styles="width:100%;"/>
                        </td>
                        <td style="width: 1%">
                            Style
                        </td>
                        <td style="width: 100%" colspan="2">
                            <gw:textbox id="txtStyle" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdItem')" />
                        </td>
                        <td>
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdItem')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnNew3" onclick="OnAddNew('grdItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete3" onclick="OnDelete('grdItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete3" onclick="OnUnDelete('grdItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave3" onclick="OnSave('grdItem')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width:100%">
                        <td style="width: 100%" colspan="10">
                            <gw:grid id='grdItem'
                                header='_pk|_co_process_price_pk|Item Grp|_style_pk|Style ID|Style|Use|Description'
                                format='0|0|0|0|0|0|3|0'
                                aligns='0|0|0|0|0|0|0|0'
                                check='|||||||'
                                editcol='0|0|0|0|0|0|1|1'
                                widths='0|0|2000|0|1200|3000|500|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />                            
                        </td>
                    </tr>
               </table>
               <table name="Partner" style="height: 100%; width: 100%" border="0">
                <tr style="height: 1%; width:100%">
                        <td style="width: 1%">
                            Partner
                        </td>
                        <td style="width: 100%">
                            <gw:textbox id="txtPartner" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('grdPartner')" />
                        </td>
                        <td>
                            <gw:imgbtn img="search" alt="Search" id="btnSearch4" onclick="OnSearch('grdPartner')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnNew4" onclick="OnAddNew('grdPartner')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete4" onclick="OnDelete('grdPartner')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete4" onclick="OnUnDelete('grdPartner')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave4" onclick="OnSave('grdPartner')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width:100%">
                        <td style="width: 100%" colspan="8">
                            <gw:grid id='grdPartner'
                                header='_pk|_co_process_price_pk|_partner_pk|Partner ID|Partner Name|Use|Description'
                                format='0|0|0|0|0|3|0'
                                aligns='0|0|0|0|0|0|0'
                                check='||||||'
                                editcol='0|0|0|0|0|1|1'
                                widths='0|0|0|1500|3000|500|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />                            
                        </td>
                    </tr>
               </table>
            </gw:tab>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <gw:textbox id="txt_co_process_price_pk" styles="width: 100%;display: none" />
    <!------------------------------------------->
</body>
</html>
