<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Spinning Result</title>
</head>

<script type="text/javascript" language="javascript">

var G2_PK       = 0,
    G2_CHARGER_PK    = 1,
    G2_SPIN_DATE    = 2, 
    G2_TLG_PB_LINE_PK         = 3,
    G2_TLG_WORK_SHIFT_PK         = 4,
    G2_TLG_WORK_SHIFT_PK_S         = 5,
    G2_TLG_WORK_SHIFT_PK_E         = 6,
    G2_TLG_IT_ITEMGRP_PK       = 7,
    G2_TLG_IF_ITEM_PK       = 8,
    G2_CAPACITY       = 9,
    G2_COUNT       = 10,
    G2_FROM_HK       = 11,
    G2_TO_HK       = 12,
    G2_ACTUAL_HK       = 13,
    G2_RATE       = 14;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    //----------------------------
     var ctrl = grd_Spinning_Result.GetGridControl();        
    ctrl.ColFormat(G2_CAPACITY)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_COUNT)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_FROM_HK)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_TO_HK)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_ACTUAL_HK)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_RATE)    = "###,###,###.##" ;
    
    var data ;//= "<%=ESysLib.SetListDataSQL("SELECT   pk, GROUP_ID || ' - ' || group_name FROM tlg_pb_line_group WHERE del_if = 0 ORDER BY GROUP_ID ")%>";                     
    //lstLineGroup.SetDataText(data);

    data = "<%=ESysLib.SetListDataSQL(" select null,null shift from dual union all SELECT PK, shift || ' : ' || start_time || ' -> ' || end_time FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y'  and shift in (1,2,3) order by shift nulls first ")%>";
    lst_Shift.SetDataText( data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" select null,null shift from dual union all SELECT PK, shift FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y'  and shift in (1,2,3) order by shift " ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_WORK_SHIFT_PK, data); 

    data = "<%=ESysLib.SetGridColumnDataSQL(" select null,null shift from dual union all SELECT PK, start_time  FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y'  and shift in (1,2,3) order by shift nulls first " ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_WORK_SHIFT_PK_S, data); 

    data = "<%=ESysLib.SetGridColumnDataSQL(" select null,null shift from dual union all SELECT PK, end_time  FROM thr_work_shift WHERE DEL_IF = 0 AND USE_YN = 'Y'  and shift in (1,2,3) order by shift nulls first " ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_WORK_SHIFT_PK_E, data); 
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   pk, GROUP_ID || ' - ' || group_name FROM tlg_pb_line_group WHERE del_if = 0 ORDER BY GROUP_ID " ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_PB_LINE_PK, data); 
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" select pk, (grp_cd || '-' || grp_nm) as grp_name from TLG_IT_ITEMGRP where del_if = 0  and grp_cd = 'GY'" ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_IT_ITEMGRP_PK, data); 
    
    data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   a.pk, (a.item_code || ' - ' || a.item_name) AS item FROM tlg_it_item a, TLG_IT_ITEMGRP b WHERE a.del_if = 0 and b.pk = a.TLG_IT_ITEMGRP_PK and b.grp_cd = 'GY' ORDER BY a.item_code " ) %> ";       
    grd_Spinning_Result.SetComboFormat( G2_TLG_IF_ITEM_PK, data); 
	
//    data = "<%=ESysLib.SetListDataSQL("select pk, factory_name from TLG_PR_FACTORY where del_if = 0 and use_yn='Y' order by factory_NAME")%>";
//    lstFactory.SetDataText( data);
    
    OnSearch();  
}

//--------------------------------------------------------------------------------------------------
function OnPopUp()
{
     var path = System.RootURL + '/form/kb/al/kbal00021.aspx?p_month=' +dtMonth.value + '&p_item_cd='+grdRatio.GetGridData(grdRatio.row,G2_ITEM_CD);
     var object = System.OpenModal( path, 1000, 600, 'resizable:yes;status:yes', this); 
           
} 
//-------------------------------------------------------------------------------------
function OnSearch()
{
    data_kbre00020.Call("SELECT");   
           
}
//-------------------------------------------------------------------------------------
function OnSave()
{     
       data_kbre00020.Call();
}
//-------------------------------------------------------------------------------------
function OnDelete()
{     
   if ( grd_Spinning_Result.row > 0 )
   {
        if(confirm('Do you want to delete ?'))
        {
            if ( grd_Spinning_Result.GetGridData( grd_Spinning_Result.row, G2_PK) == '' )          
                grd_Spinning_Result.RemoveRow();
            else
                grd_Spinning_Result.DeleteRow();
        }  
    }      
}
//-------------------------------------------------------------------------------------
function OnCopy()
{     
	grd_Spinning_Result.AddRow();
var l_row= grd_Spinning_Result.selrow;

    for(var i = 0; i< grd_Spinning_Result.cols; i++)
	{
		grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, i,grd_Spinning_Result.GetGridData(l_row,i));
	}
	grd_Spinning_Result.SetRowStatus(grd_Spinning_Result.rows-1, 0x20);
}
//-------------------------------------------------------------------------------------
function OnAddNew()
{
	if(lst_Shift.value == '')
	{
		alert('Pls select Shift');
		return;
	}
	
	var l_Str = grd_Spinning_Result.GetGridControl().ColComboList(  G2_TLG_PB_LINE_PK) ;
	var l_StrTmp = l_Str.split('|');
	for(var i=0; i< l_StrTmp.length;i++)
	{
		var l_StrTmp1 = l_StrTmp[i].split(';');
		var l_StrTmp2 = l_StrTmp1[0].substr(1);
//		alert(l_StrTmp1[1]);
		if ( grd_Spinning_Result.rows > 1 )
    		 {  
		        var to_hk = 0;     
		        grd_Spinning_Result.AddRow();  
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_PB_LINE_PK, l_StrTmp2); //line
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK, lst_Shift.value); //shift
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK_S, lst_Shift.value); //start time
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK_E, lst_Shift.value); //end time
		        grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_CHARGER_PK, txtUser_PK.text); //charge_pk	    	                                               
		        grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_SPIN_DATE , dt_Date.value);//spin_date 
		        //to_hk = parseFloat(grd_Spinning_Result.GetGridData(grd_Spinning_Result.rows-2,G2_TO_HK));     
		        //grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_FROM_HK , to_hk);//from_hk 
	     }
	     else
	     {      
		        grd_Spinning_Result.AddRow();  
		        grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_PB_LINE_PK,l_StrTmp2); //line    	                                               
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK, lst_Shift.value); //shift
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK_S, lst_Shift.value); //start time
			grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_TLG_WORK_SHIFT_PK_E, lst_Shift.value); //end time
		        grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_CHARGER_PK, txtUser_PK.text); //charge_pk	    	                                               
		        grd_Spinning_Result.SetGridText( grd_Spinning_Result.rows-1, G2_SPIN_DATE , dt_Date.value);//spin_date 
	     }     
	}



        
}
//=========================================================================
function CheckInput()
{       
    InputProcess(  event.col, event.row  );
}
 //======================================================================
function InputProcess( col, row )
{
    var dActualHK = 0;     
    if ( col == G2_FROM_HK || col == G2_TO_HK  )
    {                 
        dActualHK = parseFloat(grd_Spinning_Result.GetGridData( row, G2_TO_HK )) -  parseFloat(grd_Spinning_Result.GetGridData( row,G2_FROM_HK)) ;                            			               
        //grd_Spinning_Result.SetGridText( row, G2_ACTUAL_HK, System.Round( dActualHK, G2_ACTUAL_HK )) ;
		grd_Spinning_Result.SetGridText( row, G2_ACTUAL_HK, dActualHK) ;
    } 	
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {   
         case "data_kbre00020":	
             lblRecord.text  = ( grd_Spinning_Result.rows -1 )+ " record(s)."
//             for(var i =1; i<grd_Spinning_Result.rows; i++)	
//             {
//                grd_Spinning_Result.GetGridControl().ColHidden(G2_ITEM_CD+i) = false;
//                grd_Spinning_Result.SetGridText(0,G2_ITEM_CD+i,grd_Spinning_Result.GetGridData(i,GT_NM));
//             } 
//             for (var j = grd_Spinning_Result.rows + 2 ; j<= 17; j++)
//             {
//                grd_Spinning_Result.GetGridControl().ColHidden(j) = true;
//             }
//             data_kbal00020.Call("SELECT");    
         break; 
        
    }
}

//====================================================================================
    
</script>

<body>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbre00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_kbre00020" procedure="<%=l_user%>lg_upd_kbre00020" > 
                <input>
                    <input bind="dt_Date" /> 
                    <input bind="lst_Shift" /> 
                    <input bind="txt_Group" /> 
                    <input bind="txt_Count" /> 
                </input> 
                <output bind="grd_Spinning_Result" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <%--<gw:data id="data_kbal00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_kbal00020"  > 
                <input>
                    <input bind="dtMonth" /> 
                    <input bind="txtSTCode" />                  
                </input> 
                <output bind="grdRatio" /> 
            </dso> 
        </xml> 
    </gw:data>--%>
    <!---------------------------------------------------------------------->
    <table border="0" style="width: 100%; height: 100%">
        <tr >           
             <td style="width: 5%">
                Date
            </td>
            <td style="width: 15%">
                <gw:datebox id="dt_Date" lang="<%=Application("Lang")%>" mode="01"/>
            </td>
             <td style="width: 5%">
                Shift
            </td>
             <td style="width: 15%" align="right">
                <gw:list id="lst_Shift" styles="width:100%;" />
            </td>
            <td style="width:5%">
                Group
            </td>
            <td style="width:15%">
                <gw:textbox id="txt_Group" styles="width:100%;"  />
            </td>
            <td style="width:5%">
                Count
            </td>
            <td style="width:15%">
                <gw:textbox id="txt_Count" styles="width:100%;"  />
            </td>
            <td style="width: 15%">
                <gw:label id="lblRecord" text="" styles="color:red"  />
            </td>
             <td style="width: 1%">
                 <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
            </td>
		<td style="width: 1%">
                <gw:imgbtn id="btnDelete" img="copy" alt="Copy" text="Copy" onclick="OnCopy()" />
            </td>
             <td style="width: 1%">
                <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
            </td>
             <td style="width: 1%">
               <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
            </td>                       
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                   <gw:imgbtn id="btnPrint1" img="excel" alt="Print" text="Print" onclick="" />
                </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="14">
                <gw:grid id='grd_Spinning_Result'
                    header='_PK|_Charger_PK|Date|Line|Shift|Start Time|End Time|Group|Item|Capacity|Count|_From HK|_To HK|_Actual HK|Input Qty|Rate'
                    format='1|1|4|1|0|1|1|1|1|1|1|1|1|1|1|1'
                    aligns='0|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0'
                    check='|||||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|0|1200|2100|1000|1000|1000|2000|2000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T'
                    styles='width:100%; height:100%' onafteredit="CheckInput()" 
                    />
            </td>
        </tr>
    </table>
</body>

<gw:textbox id="txtSTItemPK" text="" style="display: none" />
<!--------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
</html>
