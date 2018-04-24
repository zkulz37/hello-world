<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>POPUP : Item Price Setting</title>
</head>

<script>
    var G0_CHECK    = 0,
        G0_PK       = 1,
        G0_PARTNER  = 2,
        
        G1_CHECK    = 0,
        G1_PK       = 1,
        G1_ITEM     = 2,
        
        G2_CHECK    = 0,
        G2_PK       = 1,
        G2_ITEM     = 2,
        G2_PRICE    = 3,
        
        G3_CHECK    = 0,
        G3_PK       = 1,
        G3_ITEM     = 2,
        G3_PRICE    = 3,   
        
        G4_CHECK    = 0,
        G4_PK       = 1,
        G4_ITEM     = 2,
        G4_PRICE    = 3, 
        
        G5_CHECK    = 0,
        G5_PK       = 1,
        G5_ITEM     = 2,
        G5_PRICE    = 3, 
        
        G6_CHECK    = 0,
        G6_PK       = 1,
        G6_ITEM     = 2,
        G6_PRICE    = 3;
//====================================================
    function OnToggle(pos, index)
    {
        var arrTable = new Array('tblPartner','tblStyle','tblSpec01','tblSpec02','tblSpec03','tblSpec04','tblSpec05');
        var tbl = document.all(arrTable[index]);
        if(pos == 0) tbl.style.display = "none";
    }
    //======================================================
    function BodyInit() 
	{
	    System.Translate(document);
	    FormatGrid();
    }
    //=====================================================
    function FormatGrid()
    {

        
        var arr = "<%=Request.querystring("p_pk")%>".replace("",0).split('|');
        for (var i = 0; i < arr.length; i++)
        {
            OnToggle(arr[i],i);
        }
        data = "<%=ESysLib.SetListDataSQL("SELECT b.pk, b.GRP_NM FROM  comm.tco_itemgrp b WHERE b.del_if = 0") %>||SELECT ALL" ; 
        lstItemGrp.SetDataText(data);    
        lstItemGrp.value = "";  
        
        data = "<%=ESysLib.SetListDataSQLPara("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' and (pk = {2} or {2} is null) ORDER BY specgrp_nm", Request.querystring("p_pk")) %>" ;
		lstSpecGrp01.SetDataText(data); 
        
        data = "<%=ESysLib.SetListDataSQLPara("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' and (pk = {3} or {3} is null) ORDER BY specgrp_nm", Request.querystring("p_pk")) %>" ;
		lstSpecGrp02.SetDataText(data); 
		
		data = "<%=ESysLib.SetListDataSQLPara("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' and (pk = {4} or {4} is null) ORDER BY specgrp_nm", Request.querystring("p_pk")) %>" ;
		lstSpecGrp03.SetDataText(data); 
		
		data = "<%=ESysLib.SetListDataSQLPara("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' and (pk = {5} or {5} is null) ORDER BY specgrp_nm", Request.querystring("p_pk")) %>" ;
		lstSpecGrp04.SetDataText(data); 
		
		data = "<%=ESysLib.SetListDataSQLPara("SELECT   pk, specgrp_nm FROM comm.tco_specgrp WHERE del_if = 0 AND use_yn = 'Y' and (pk = {6} or {6} is null) ORDER BY specgrp_nm", Request.querystring("p_pk")) %>" ;
		lstSpecGrp05.SetDataText(data);         
    }
    
    //====================================================
    function OnSearch(pos) 
	{
        switch (pos) 
		{
            case 'grdPartner':
                data_dspc00071_7.Call('SELECT');
            break;
            
			case 'grdItem':				 
                data_dspc00071_6.Call('SELECT');
            break;  
			
			case 'grdSpec01':				 
                data_dspc00071_1.Call('SELECT');
            break;
			
			case 'grdSpec02':				 
                data_dspc00071_2.Call('SELECT');
            break;
			
			case 'grdSpec03':				 
                data_dspc00071_3.Call('SELECT');
            break;
			
			case 'grdSpec04':				 
                data_dspc00071_4.Call('SELECT');
            break;
			
			case 'grdSpec05':				 
                data_dspc00071_5.Call('SELECT');
            break;                              
        }
    }    

    //====================================================
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
			case 'data_dspc00071':
                
            break; 
			
            case 'data_dspc00071_1':
                
            break;    
        }
    }
   
   //==================================================================================
      function OnSelect()
      {
        var arrGrid = new Array('grdPartner','grdItem','grdSpec01','grdSpec02','grdSpec03','grdSpec04','grdSpec05');
         
        var col_num  = 0 ;
        var row_num  = 1 ;
        var col_value = 1;
        for ( var i = 0; i < arrGrid.length ; i++ )
        {
            var ctrl = document.all(arrGrid[i]);
            row_num = grdMain.rows;
            var mapping_times = 0 ;
	        //----------------        
            for( var j = 1; j < ctrl.rows; j++ )
	        {
                //-------------------------  	 	         
                if ( ctrl.GetGridData( j, 0 ) == -1 )
                { 
                    if ( row_num < 2 )
                    {
                        grdMain.AddRow();
                        grdMain.SetGridText( grdMain.rows-1, col_num,          ctrl.GetGridData( j, col_value)+"")    ;
                        grdMain.SetGridText( grdMain.rows-1, col_num + 1,      ctrl.GetGridData( j, col_value+1)+"") ;
                    }
                    else if ( mapping_times == 0 )
                    {
                        mapping_times = mapping_times + 1 ;
                        for( var t = 1; t < row_num; t++ )
                        {
                            grdMain.SetGridText( t, col_num,     ctrl.GetGridData( j, col_value    )+"");
                            grdMain.SetGridText( t, col_num + 1, ctrl.GetGridData( j, col_value+1 )+"");
                        }
                    }    
                    else if ( mapping_times > 0 )
                    {
                        for( var t = 1; t < row_num; t++ )
                        {
                            grdMain.AddRow();
                            //---------------
                            for( var k = 0; k < 13; k++ )
                            {
                                grdMain.SetGridText( grdMain.rows-1, k, grdMain.GetGridData( t, k )+"" );
                            }                        
                            grdMain.SetGridText( grdMain.rows-1, col_num,     ctrl.GetGridData( j, col_value    )) ;
                            grdMain.SetGridText( grdMain.rows-1, col_num + 1, ctrl.GetGridData( j, col_value+1 )+"") ;
                        }
                    }   
                }
            }
            col_num = col_num + 2 ;
	    }
	    //------   
	    var arr_data = new Array();
           
           if( grdMain.rows > 1)
           {   
              for( var i=1; i<grdMain.rows; i++)
              {
                 var arrTemp=new Array();
                 
                 for(var j=0;j<grdMain.cols; j++)
                 {
                    arrTemp[arrTemp.length]= grdMain.GetGridData(i,j);
                 }
                 
                 arr_data[arr_data.length]= arrTemp;
              }
              
	          if ( arr_data !=null )
	          {
		        window.returnValue =  arr_data;
		        window.close();
	          }
           }         	    
    }
               

</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_7" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_7"  >
                <input bind="grdPartner" >
                    <input bind="txtPartner" />
                </input> 
                <output bind="grdPartner" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_6" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_6"  >
                <input bind="grdItem" >
					<input bind="lstItemGrp" />
                    <input bind="txtItem" />
                </input> 
                <output bind="grdItem" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_1"  >
                <input bind="grdSpec01" >
					<input bind="lstSpecGrp01" />
                    <input bind="txtSpec01" />
                </input> 
                <output bind="grdSpec01" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_2" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_2"  >
                <input bind="grdSpec02" >
					<input bind="lstSpecGrp02" />
                    <input bind="txtSpec02" />
                </input> 
                <output bind="grdSpec02" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_3" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_3"  >
                <input bind="grdSpec03" >
					<input bind="lstSpecGrp03" />
                    <input bind="txtSpec03" />
                </input> 
                <output bind="grdSpec03" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_4" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_4"  >
                <input bind="grdSpec04" >
					<input bind="lstSpecGrp04" />
                    <input bind="txtSpec04" />
                </input> 
                <output bind="grdSpec04" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00071_5" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00071_5"  >
                <input bind="grdSpec05" >
					<input bind="lstSpecGrp05" />
                    <input bind="txtSpec05" />
                </input> 
                <output bind="grdSpec05" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 50%">
            <td> 
                <table id="tblPartner" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td>
                            Partner
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 99%">
                            <gw:textbox id="txtPartner" styles="width:100%" onenterkey="OnSearch('grdPartner')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdPartner')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="2">
                            <gw:grid id='grdPartner' header='V|_PK|Partner' format='3|0|0' aligns='0|0|0' editcol='0|0|0'
                                widths='500|0|2000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblStyle" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Item
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 45%">
                            <gw:list id="lstItemGrp" styles="width:100%;" onchange="OnSearch('grdItem')" />
                        </td>
                        <td style="width: 44%">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('grdItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdItem')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdItem' header='V|_PK|Item' format='3|0|0' aligns='0|0|0' editcol='0|0|0'
                                widths='500|0|2000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblSpec01" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Spec 01
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 60%">
                            <gw:list id="lstSpecGrp01" styles="width:100%;" onchange="OnSearch('grdSpec01')" />
                        </td>
                        <td style="width: 39%">
                            <gw:textbox id="txtSpec01" styles="width:100%" onenterkey="OnSearch('grdSpec01')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdSpec01')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSpec01' header='V|_PK|Item|_Price' format='3|0|0|0' aligns='0|0|0|0'
                                editcol='0|0|0|0' widths='500|0|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblSpec02" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Spec 02
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 60%">
                            <gw:list id="lstSpecGrp02" styles="width:100%;" onchange="OnSearch('grdSpec02')" />
                        </td>
                        <td style="width: 39%">
                            <gw:textbox id="txtSpec02" styles="width:100%" onenterkey="OnSearch('grdSpec02')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdSpec02')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSpec02' header='V|_PK|Item|_Price' format='3|0|0|0' aligns='0|0|0|0'
                                editcol='0|0|0|0' widths='500|0|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblSpec03" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Spec 03
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 60%">
                            <gw:list id="lstSpecGrp03" styles="width:100%;" onchange="OnSearch('grdSpec03')" />
                        </td>
                        <td style="width: 39%">
                            <gw:textbox id="txtSpec03" styles="width:100%" onenterkey="OnSearch('grdSpec03')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdSpec03')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSpec03' header='V|_PK|Item|_Price' format='3|0|0|0' aligns='0|0|0|0'
                                editcol='0|0|0|0' widths='500|0|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblSpec04" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Spec 04
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 60%">
                            <gw:list id="lstSpecGrp04" styles="width:100%;" onchange="OnSearch('grdSpec04')" />
                        </td>
                        <td style="width: 39%">
                            <gw:textbox id="txtSpec04" styles="width:100%" onenterkey="OnSearch('grdSpec04')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdSpec04')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSpec04' header='V|_PK|Item|_Price' format='3|0|0|0' aligns='0|0|0|0'
                                editcol='0|0|0|0' widths='500|0|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table id="tblSpec05" style="width: 100%; height: 100%">
                    <tr style="height: 1%; color: #CC0000" align="center">
                        <td colspan="2">
                            Spec 05
                        </td>
                        <td>
                            <gw:imgbtn img="select" alt="Select" id="btnSelect1" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 60%">
                            <gw:list id="lstSpecGrp05" styles="width:100%;" onchange="OnSearch('grdSpec05')" />
                        </td>
                        <td style="width: 39%">
                            <gw:textbox id="txtSpec05" styles="width:100%" onenterkey="OnSearch('grdSpec05')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch3" onclick="OnSearch('grdSpec05')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSpec05' header='V|_PK|Item|_Price' format='3|0|0|0' aligns='0|0|0|0'
                                editcol='0|0|0|0' widths='500|0|2000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 0%">
            <td colspan="7">
                <gw:grid id='grdMain' header='Col0_PK|Col0_Name|Col1_PK|Col1_Name|Col2_PK|Col2_Name|Col3_PK|Col3_Name|Col4_PK|Col4_Name|Col5_PK|Col5_Name|Col6_PK|Col6_Name' format='0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0' defaults='||||||' editcol='1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%; display:none' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
